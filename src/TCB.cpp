//
// Created by os on 12/5/25.
//

#include "../h/TCB.hpp"
#include "../h/Scheduler.hpp"
#include "../h/syscall_c.hpp"

extern "C" void context_switch(TCB::Context* oldContext, TCB::Context* newContext);
extern "C" char first_born;

size_t TCB::numOfTicks = 0;
TCB* TCB::running = nullptr;
void TCB::initializeThread(TCB::Body function, void*arg, void *allocatedStack, void* allocatedSystemStack, ObjectPool<TCB, KernelConfig::NUM_OF_THREADS_IN_POOL>* pool,
                           KernelConfig::StateOfThread state, KernelConfig::Mode mode)
{

    body = function;
    timeSlice = DEFAULT_TIME_SLICE;
    nextThreadInQueue = nullptr;
    finished = false;
    arguments = arg;
    waitOnSemaphore = nullptr;
    stateOfThread = state;
    timeToSleep = 0;
    sourcePool = pool;
    queueOfWaitThreads = nullptr;
    queueOfWhichIsPart = nullptr;
    userStack = (void*)((uint8*)allocatedStack - DEFAULT_STACK_SIZE);
    systemStack = (void*)((uint8*)allocatedSystemStack - KernelConfig::DEFAULT_SYSTEM_STACK_SIZE);

    *((uint64*)allocatedSystemStack - 30) = (uint64)((uint64*)allocatedStack - 2);
//    if(mode == KernelConfig::USER_MODE)
//    {
    context = {(uint64)&first_born, (uint64) ((uint64 *) allocatedSystemStack - 32)};
    Machine::writeSepc((uint64) &threadWrapper);
    uint64 status = mode | (0x1 << 5);
    Machine::writeSstatus(status);

//    }
//    else
//    {
//        context = {(uint64)&threadWrapper, (uint64) ((uint64 *) allocatedSystemStack - 32), mode};
//    }
    //Machine::bs_sstatus(Machine::SPIE);
}
void TCB::threadWrapper()
{
    running->body(running->arguments);
    thread_exit();

}
void TCB::yield(TCB *oldThread, TCB *newThread)
{
    context_switch(oldThread->getContext(), newThread->getContext());
}

void TCB::dispatch()
{
    TCB* oldThread = running;
    if(!oldThread->isFinished() && oldThread != Scheduler::getIdleThread())
    {
        oldThread->setStateOfThread(KernelConfig::READY);
        Scheduler::put(oldThread);
    }
    running = Scheduler::get();
    if(oldThread != running)
    {
        TCB::resetNumOfTicks();
        yield(oldThread, running);
    }

}
TCB::~TCB()
{
    MemoryAllocator::freeMemory(userStack);
    MemoryAllocator::freeMemory(systemStack);
    stateOfThread = KernelConfig::TERMINATED;
}
void TCB::start(TCB* readyThread)
{
    Scheduler::put(readyThread);
}
void TCB::freeWaitThreads()
{
    TCB* temp;
    while(!queueOfWaitThreads->isQueueEmpty())
    {

        temp = queueOfWaitThreads->take();
        temp->setStateOfThread(KernelConfig::READY);
        Scheduler::put(temp);
    }
}
void TCB::addThreadToWaitQueue(TCB *newThread)
{
    newThread->setStateOfThread(KernelConfig::BLOCKED);
    queueOfWaitThreads->append(newThread);
}
