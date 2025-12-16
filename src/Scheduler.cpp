//
// Created by os on 12/8/25.
//

#include "../h/Scheduler.hpp"
#include "../h/TCB.hpp"
TCB* Scheduler::headReadyThread = nullptr;
TCB* Scheduler::tailReadyThread = nullptr;
TCB* Scheduler::idleThread = nullptr;
void Scheduler::put(TCB *readyThread)
{
    if(!headReadyThread)
    {
        headReadyThread = readyThread;
    }
    else
    {
        tailReadyThread->addThreadToState(readyThread);
    }
    tailReadyThread = readyThread;
}
TCB* Scheduler::get(void)
{
    if(!headReadyThread)
    {
        return idleThread;
    }
    TCB* newThread = headReadyThread;
    headReadyThread = headReadyThread->getState();

    newThread->addThreadToState(nullptr);
    return newThread;
}