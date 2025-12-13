//
// Created by os on 12/8/25.
//

#include "../h/Scheduler.hpp"
#include "../h/TCB.hpp"
TCB* Scheduler::firstReadyThread = nullptr;
TCB* Scheduler::lastReadyThread = nullptr;

void Scheduler::put(TCB *readyThread)
{
    if(!firstReadyThread)
    {
        firstReadyThread = readyThread;
    }
    else
    {
        lastReadyThread->setRunningThread(readyThread);
    }
    lastReadyThread = readyThread;
}
TCB* Scheduler::get(void)
{
    if(!firstReadyThread)
    {
        return nullptr;
    }
    TCB* newThread = firstReadyThread;
    firstReadyThread = firstReadyThread->getState();

    newThread->addThreadToState(nullptr);
    return newThread;
}