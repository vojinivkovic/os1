//
// Created by os on 12/14/25.
//

#include "../h/KConsole.hpp"
#include "../h/TCB.hpp"
#include "../h/Scheduler.hpp"
#include "../h/Kernel.hpp"
#include "../h/KSemaphore.hpp"
#include "../h/Machine.hpp"
extern "C" void context_switch(TCB::Context* oldContext, TCB::Context* newContext);


KBuffer* KConsole::inputBuffer = nullptr;
KBuffer* KConsole::outputBuffer = nullptr;
Queue<TCB>* KConsole::inputWaitQueue = nullptr;
Queue<TCB>* KConsole::outputWaitQueue = nullptr;
TCB* KConsole::consumerThread = nullptr;
TCB* KConsole::producerThread = nullptr;
bool KConsole::outputBufferReady = false;
bool KConsole::inputBufferReady = false;

void KConsole::initialize()
{

    inputBuffer = new KBuffer();
    outputBuffer = new KBuffer();
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
    return (inputBuffer->take());
}
void KConsole::addCharToOutputBuffer(char c)
{
    outputBuffer->append(c);
}

void KConsole::consumeOutputBuffer(void*)
{
    volatile char data;
    volatile uint8 statusReg;
    volatile uint64 sstatus = Machine::readSstatus();

    while(1)
    {
        __asm__ volatile("lbu %[status], 0(%[address])": [status] "=r"(statusReg): [address] "r"(CONSOLE_STATUS):"memory");
        while ((statusReg & CONSOLE_TX_STATUS_BIT) && !outputBuffer->isBufferEmpty())
        {
            Kernel::getSemaphoreOutput()->wait();
            data = (outputBuffer->take());
            __asm__ volatile("sb %[regData], 0(%[address])":: [regData]"r"(data), [address]"r"(CONSOLE_TX_DATA):"memory");
            __asm__ volatile("lbu %[status], 0(%[address])": [status] "=r"(statusReg): [address] "r"(CONSOLE_STATUS):"memory");
            removeThreadFromOutputWaitQueue();
            Kernel::getSemaphoreOutput()->signal();
        }
        consumerThread->setStateOfThread(KernelConfig::BLOCKED);
        consumerThread->resetQueueOfWhichIsPart();
        consumerThread->resetNextThreadInQueue();
        TCB* newRunning = Scheduler::get();
        TCB::setRunningThread(newRunning);
        context_switch(consumerThread->getContext(), newRunning->getContext());
        Machine::writeSstatus(sstatus);
    }
}

void KConsole::produceInputBuffer(void*)
{
    volatile uint8 statusReg;
    volatile char data;
    volatile uint64 sstatus = Machine::readSstatus();

    while(1) {
        __asm__ volatile("lbu %[status], 0(%[address])": [status] "=r"(statusReg): [address] "r"(CONSOLE_STATUS):"memory");
        while ((statusReg & CONSOLE_RX_STATUS_BIT) && !inputBuffer->isBufferFull())
        {
            __asm__ volatile("lbu %[status], 0(%[address])": [status] "=r"(statusReg): [address] "r"(CONSOLE_STATUS):"memory");
            Kernel::getSemaphoreInput()->wait();
            __asm__ volatile("lbu %[regData], 0(%[address])" : [regData]"=r"(data): [address]"r"(CONSOLE_RX_DATA):"memory");
            char c = data;
            inputBuffer->append(c);
            __asm__ volatile("lbu %[status], 0(%[address])": [status] "=r"(statusReg): [address] "r"(CONSOLE_STATUS):"memory");
            removeThreadFromInputWaitQueue();
            Kernel::getSemaphoreInput()->signal();
        }
        producerThread->setStateOfThread(KernelConfig::BLOCKED);
        producerThread->resetQueueOfWhichIsPart();
        producerThread->resetNextThreadInQueue();
        TCB* newRunning = Scheduler::get();
        TCB::setRunningThread(newRunning);
        context_switch(producerThread->getContext(), newRunning->getContext());
        Machine::writeSstatus(sstatus);


    }

}
void KConsole::destroy()
{
    delete inputBuffer;
    delete outputBuffer;
    delete inputWaitQueue;
    delete outputWaitQueue;
}
bool KConsole::isInputBufferEmpty()
{
    return inputBuffer->isBufferEmpty();
}
bool KConsole::isInputBufferFull()
{
    return inputBuffer->isBufferFull();
}

bool KConsole::isOutputBufferFull()
{
    return outputBuffer->isBufferFull();
}
bool KConsole::isOutputBufferEmpty()
{
    return outputBuffer->isBufferEmpty();
}
