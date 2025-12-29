//
// Created by os on 12/8/25.
//

#include "../h/Scheduler.hpp"
#include "../h/TCB.hpp"
#include "../h/Config.hpp"
//TCB* Scheduler::headReadyThread = nullptr;
//TCB* Scheduler::tailReadyThread = nullptr;
Queue<TCB>* Scheduler::queueReadyThreads = nullptr;
TCB* Scheduler::idleThread = nullptr;
void Scheduler::initialize()
{
    queueReadyThreads = new Queue<TCB>();
}
void Scheduler::put(TCB *readyThread)
{
    readyThread->setQueueOfWhichIsPart(queueReadyThreads);
    queueReadyThreads->append(readyThread);
}
TCB* Scheduler::get(void)
{
    if(queueReadyThreads->isQueueEmpty())
    {
        return idleThread;
    }
    TCB* newThread = queueReadyThreads->take();
    newThread->resetQueueOfWhichIsPart();
    newThread->resetNextThreadInQueue();
    newThread->setStateOfThread(KernelConfig::RUNNING);
    return newThread;
}
void Scheduler::destroy()
{
    delete queueReadyThreads;
}