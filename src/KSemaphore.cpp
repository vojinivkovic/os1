//
// Created by os on 12/13/25.
//

#include "../h/KSemaphore.hpp"
#include "../h/TCB.hpp"
#include "../h/Scheduler.hpp"


extern "C" void context_switch(TCB::Context* oldContext, TCB::Context* newContext);
uint64 KSemaphore::countOfSemaphores = 0;

void KSemaphore::initializeSemaphore(unsigned value, ObjectPool<KSemaphore, KernelConfig::NUM_OF_SEMAPHORES_IN_POOL>* pool)
{
    semaphoreVal = value;
    queueBlockedThreads = new Queue<TCB>();
    sourcePool = pool;
    semId = countOfSemaphores++;
    nextSemaphoreInQueue = nullptr;
}

void KSemaphore::blockThread(TCB* threadToBlock)
{
    threadToBlock->setSemaphoreOnWait(this);
    threadToBlock->setStateOfThread(KernelConfig::BLOCKED);
    queueBlockedThreads->append(threadToBlock);
}

int KSemaphore::unblockThread(KernelConfig::WakeUpReason reason)
{

   TCB* oldThread = queueBlockedThreads->take();
    if(oldThread)
    {
        oldThread->setWakeUpReason(reason);
        oldThread->resetNextThreadInQueue();
        oldThread->resetSemaphoreOnWait();
        oldThread->setStateOfThread(KernelConfig::READY);
        Scheduler::put(oldThread);
        return 0;
    }
    return -1;

}

int KSemaphore::wait()
{

    semaphoreVal--;
    if(semaphoreVal < 0)
    {

        TCB* oldThread = TCB::getRunningThread();
        TCB::setRunningThread(Scheduler::get());
        oldThread->resetNextThreadInQueue();
        oldThread->setQueueOfWhichIsPart(queueBlockedThreads);
        blockThread(oldThread);
        context_switch(oldThread->getContext(), TCB::getRunningThread()->getContext());
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
    return 0;
}

int KSemaphore::close()
{
    TCB* tempThread = queueBlockedThreads->top();
    if(!tempThread)
    {
        return 0;
    }
    for(;tempThread; tempThread = tempThread->getNextThreadInQueue())
    {
        unblockThread(KernelConfig::WAKE_UP_SEMAPHORE_CLOSE);
    }
    return 0;

}
void KSemaphore::removeThreadFromBlockedQueue(TCB *thread)
{

    queueBlockedThreads->removeElement(thread);
    thread->resetSemaphoreOnWait();
    thread->resetNextThreadInQueue();

}
KSemaphore::~KSemaphore()
{
    delete queueBlockedThreads;
}