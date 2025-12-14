//
// Created by os on 12/13/25.
//

#include "../h/KSemaphore.hpp"
#include "../h/TCB.hpp"
#include "../h/Scheduler.hpp"


extern "C" void context_switch(TCB::Context* oldContext, TCB::Context* newContext);

void KSemaphore::initializeSemaphore(unsigned int value)
{
    semaphoreVal = value;
    headBlockedThread = nullptr;
    lastBlockedThread = nullptr;
}

void KSemaphore::blockThread(TCB* threadToBlock)
{
    threadToBlock->setSemaphoreOnWait(this);
    if(!headBlockedThread)
    {
        headBlockedThread = threadToBlock;
    }
    else
    {
        lastBlockedThread->addThreadToState(threadToBlock);
    }
    lastBlockedThread = threadToBlock;
}

int KSemaphore::unblockThread(KernelConfig::WAKE_UP_REASON reason)
{
   if(!headBlockedThread)
   {
       return -1;
   }
   TCB* oldThread = headBlockedThread;
   headBlockedThread = headBlockedThread->getState();
   if(!headBlockedThread)
   {
       lastBlockedThread = nullptr;
   }
   oldThread->setWakeUpReason(reason);
   oldThread->resetState();
   oldThread->resetSemaphoreOnWait();
   Scheduler::put(oldThread);
   return 0;
}

int KSemaphore::wait()
{
    semaphoreVal--;
    if(semaphoreVal < 0)
    {

        TCB* oldThread = TCB::getRunningThread();
        TCB::setRunningThread(Scheduler::get());
        blockThread(oldThread);
        context_switch(&(oldThread->getContext()), &(TCB::getRunningThread()->getContext()));
        if(TCB::getRunningThread()->getWakeUpReason() == KernelConfig::WAKE_UP_SEMAPHORE_SIGNAL)
        {
            return 0;
        }
        if(TCB::getRunningThread()->getWakeUpReason() == KernelConfig::WAKE_UP_SEMAPHORE_CLOSE)
        {
            return -1;
        }

    }
    return 0;
}

int KSemaphore::signal()
{
    semaphoreVal++;
    if(semaphoreVal <= 0)
    {
        return unblockThread(KernelConfig::WAKE_UP_SEMAPHORE_SIGNAL);
    }
}

int KSemaphore::close()
{
    TCB* tempThread = headBlockedThread;
    if(!tempThread)
    {
        return 0;
    }
    for(;tempThread; tempThread = tempThread->getState())
    {
        unblockThread(KernelConfig::WAKE_UP_SEMAPHORE_CLOSE);
    }
    return -1;

}
void KSemaphore::removeThreadFromWaitQueue(TCB *thread)
{
    TCB* currThread = headBlockedThread, *prevThread = nullptr;

    while(thread != currThread && currThread)
    {
        prevThread = currThread;
        currThread = currThread->getState();
    }

    if(!prevThread)
    {
        headBlockedThread = headBlockedThread->getState();
        thread->resetSemaphoreOnWait();
        thread->resetState();
        if(!headBlockedThread)
        {
            lastBlockedThread = nullptr;
        }
    }
    else
    {
        prevThread->addThreadToState(thread->getState());
        thread->resetSemaphoreOnWait();
        thread->resetState();
        if(thread == lastBlockedThread)
        {
            lastBlockedThread = prevThread;
        }
    }
}