//
// Created by os on 12/14/25.
//

#include "../h/KConsole.hpp"
#include "../h/TCB.hpp"
#include "../h/Scheduler.hpp"


extern "C" void context_switch(TCB::Context* oldContext, TCB::Context* newContext);


Buffer<char, KernelConfig::SIZE_INPUT_BUFFER>* KConsole::inputBuffer = nullptr;
Buffer<char, KernelConfig::SIZE_OUTPUT_BUFFER>* KConsole::outputBuffer = nullptr;
Queue<TCB>* KConsole::inputWaitQueue = nullptr;
Queue<TCB>* KConsole::outputWaitQueue = nullptr;
TCB* KConsole::consumerThread = nullptr;
TCB* KConsole::producerThread = nullptr;

void KConsole::initialize()
{

    inputBuffer = new Buffer<char, KernelConfig::SIZE_INPUT_BUFFER>();
    outputBuffer = new Buffer<char, KernelConfig::SIZE_OUTPUT_BUFFER>();
    inputWaitQueue = new Queue<TCB>();
    outputWaitQueue = new Queue<TCB>();
}
void KConsole::addThreadToInputWaitQueue(TCB *thread)
{
    thread->setStateOfThread(KernelConfig::BLOCKED);
    thread->setQueueOfWhichIsPart(inputWaitQueue);
    inputWaitQueue->append(thread);

}

void KConsole::addThreadToOutputWaitQueue(TCB* thread)
{
    thread->setStateOfThread(KernelConfig::BLOCKED);
    thread->setQueueOfWhichIsPart(outputWaitQueue);
    outputWaitQueue->append(thread);
}

void KConsole::removeThreadFromInputWaitQueue()
{

    TCB* oldThread = inputWaitQueue->take();
    if(oldThread)
    {
        oldThread->resetNextThreadInQueue();
        oldThread->setStateOfThread(KernelConfig::READY);
        Scheduler::put(oldThread);
    }
}
void KConsole::removeThreadFromOutputWaitQueue()
{

    TCB* oldThread = outputWaitQueue->take();
    if(oldThread)
    {
        oldThread->resetNextThreadInQueue();
        oldThread->setStateOfThread(KernelConfig::READY);
        Scheduler::put(oldThread);
    }
}
char KConsole::getCharFromInputBuffer()
{
    return *(inputBuffer->take());
}
void KConsole::addCharToOutputBuffer(char c)
{
    outputBuffer->append(&c);
}

void KConsole::consumeOutputBuffer(void*)
{
    volatile uint8 data;
    volatile uint8 statusReg;
    while(1)
    {
        volatile int numOfDevice = plic_claim();
        do {

            data = *(outputBuffer->take());
            __asm__ volatile("sb %[regData], 0(%[address])":: [regData]"r"(data), [address]"r"(CONSOLE_TX_DATA));
            __asm__ volatile("lb %[status], 0(%[address])": [status] "=r"(statusReg): [address] "r"(CONSOLE_STATUS));
            removeThreadFromOutputWaitQueue();
        } while ((statusReg & CONSOLE_TX_STATUS_BIT) && !outputBuffer->isBufferEmpty());
        plic_complete(numOfDevice);
        TCB *oldThread = TCB::getRunningThread();
        TCB::setRunningThread(Scheduler::get());
        oldThread->resetNextThreadInQueue();
        oldThread->setStateOfThread(KernelConfig::BLOCKED);
        context_switch(oldThread->getContext(), TCB::getRunningThread()->getContext());
    }
}

void KConsole::produceInputBuffer(void*)
{
    volatile uint8 statusReg;
    volatile uint8 data;
    while(1) {
        volatile int numOfDevice = plic_claim();
        do {
            __asm__ volatile("lb %[regData], 0(%[address])" : [regData]"=r"(data): [address]"r"(CONSOLE_RX_DATA));
            char c = data;
            inputBuffer->append(&c);
            __asm__ volatile("lb %[status], 0(%[address])": [status] "=r"(statusReg): [address] "r"(CONSOLE_STATUS));
            removeThreadFromInputWaitQueue();
        } while ((statusReg & CONSOLE_RX_STATUS_BIT) && !inputBuffer->isBufferFull());
        plic_complete(numOfDevice);

        TCB *oldThread = TCB::getRunningThread();
        TCB::setRunningThread(Scheduler::get());
        oldThread->resetNextThreadInQueue();
        oldThread->setStateOfThread(KernelConfig::BLOCKED);
        context_switch(oldThread->getContext(), TCB::getRunningThread()->getContext());
    }

}
void KConsole::destroy()
{
    delete inputBuffer;
    delete outputBuffer;
    delete inputWaitQueue;
    delete outputWaitQueue;
}

