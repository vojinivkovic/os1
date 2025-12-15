//
// Created by os on 12/14/25.
//

#include "../h/KConsole.hpp"
#include "../h/TCB.hpp"
#include "../h/Scheduler.hpp"

Buffer<char, KernelConfig::SIZE_INPUT_BUFFER>* KConsole::inputBuffer = new Buffer<char, KernelConfig::SIZE_INPUT_BUFFER>();
Buffer<char, KernelConfig::SIZE_OUTPUT_BUFFER>* KConsole::outputBuffer = new Buffer<char, KernelConfig::SIZE_OUTPUT_BUFFER>();
TCB* KConsole::consumerThread = nullptr;
TCB* KConsole::headThreadInputWait = nullptr;
TCB* KConsole::tailThreadInputWait = nullptr;

void KConsole::addThreadToWaitQueue(TCB *thread)
{
    if(!headThreadInputWait)
    {
        headThreadInputWait = thread;
    }
    else
    {
        tailThreadInputWait->addThreadToState(thread);
    }
    tailThreadInputWait = thread;
}

void KConsole::removeThreadFromWaitQueue()
{
    if(!headThreadInputWait)
    {
        return;
    }
    TCB* oldThread = headThreadInputWait;
    headThreadInputWait = headThreadInputWait->getState();
    if(!headThreadInputWait)
    {
        tailThreadInputWait = nullptr;
    }
    oldThread->resetState();
    Scheduler::put(oldThread);
}

char KConsole::getCharFromInputBuffer()
{
    return *(inputBuffer->take());
}
void KConsole::addCharToOutputBuffer(char c)
{
    outputBuffer->append(&c);
}

void KConsole::consumeOutputBuffer(void *)
{

}

void KConsole::produceInputBuffer()
{
    uint8 statusReg;
    uint8 dataReg;
    if(inputBuffer->isBufferFull())
    {
        return;
    }
    do
    {
        __asm__ volatile("")
    }while()
}

