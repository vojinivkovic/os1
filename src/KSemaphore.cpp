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

int KSemaphore::unblockThread()
{
   if(!headBlockedThread)
   {
       return -1;
   }
   TCB* oldThread = headBlockedThread;
   headBlockedThread = headBlockedThread->getState();
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
        if(TCB::getRunningThread()->getWakeUpReason() == )

    }
    return 0;
}

int KSemaphore::signal()
{
    semaphoreVal++;
    if(semaphoreVal <= 0)
    {
        return unblockThread();
    }
}

int KSemaphore::close()
{

}