//
// Created by os on 12/8/25.
//

#include "../h/Scheduler.hpp"
#include "../h/TCB.hpp"
//TCB* Scheduler::headReadyThread = nullptr;
//TCB* Scheduler::tailReadyThread = nullptr;
Queue<TCB>* Scheduler::queueReadyThreads = new Queue<TCB>();
TCB* Scheduler::idleThread = nullptr;

void Scheduler::put(TCB *readyThread)
{
//    if(!headReadyThread)
//    {
//        headReadyThread = readyThread;
//    }
//    else
//    {
//        tailReadyThread->addThreadToState(readyThread);
//    }
//    tailReadyThread = readyThread;
    queueReadyThreads->append(readyThread);
}
TCB* Scheduler::get(void)
{
    if(queueReadyThreads->isQueueEmpty())
    {
        return idleThread;
    }
    TCB* newThread = queueReadyThreads->take();
    //headReadyThread = headReadyThread->getState();

    newThread->addThreadToState(nullptr);
    return newThread;
}