//
// Created by os on 12/1/25.
//

#include "../h/Kernel.hpp"
#include "../h/Scheduler.hpp"
#include "../h/TCB.hpp"
#include "../h/KSemaphore.hpp"
#include "../h/KConsole.hpp"
//#include "../lib/console.h"

extern "C" void interrupt_trap(void);
extern "C" void context_switch(TCB::Context* oldContext, TCB::Context* newContext);
void userMain();

uint64 (*Kernel::systemCallsTable[KernelConfig::NUM_OF_SYSTEM_CALLS])(Kernel::ArgumentsOfSystemCall* arg) = {nullptr};
ObjectPool<TCB, KernelConfig::NUM_OF_THREADS_IN_POOL>* Kernel::poolOfThreads = nullptr;
ObjectPool<KSemaphore, KernelConfig::NUM_OF_SEMAPHORES_IN_POOL>* Kernel::poolOfSemaphores = nullptr;
PriorityQueue<TCB, decltype(cmp)>* Kernel::queueOfAsleepThreads = nullptr;
Queue<KSemaphore>* Kernel::queueOfOpenedSemaphores = nullptr;
TCB* Kernel::demonThread = nullptr;
KSemaphore* Kernel::semaphoreInputBuffer = nullptr;
KSemaphore* Kernel::semaphoreOutputBuffer = nullptr;
TCB* Kernel::headLiveThreads = nullptr;
TCB* Kernel::tailLiveThreads = nullptr;


void Kernel::makeConsumerThread()
{
    void* kernelSystemStack = Kernel::mallocSystemStack(KernelConfig::DEFAULT_SYSTEM_STACK_SIZE);
    ObjectPool<TCB, KernelConfig::NUM_OF_THREADS_IN_POOL>* sourcePool;
    TCB* consumerThread = poolOfThreads->mallocObject(&sourcePool);
    while(!consumerThread)
    {
        consumerThread = poolOfThreads->mallocObject(&sourcePool);
    }
    consumerThread->initializeThread(&KConsole::consumeOutputBuffer, nullptr, kernelSystemStack, kernelSystemStack, sourcePool, KernelConfig::BLOCKED, KernelConfig::KERNEL_MODE,
                                     true);
    addThreadToList(consumerThread);
    KConsole::setConsumerThread(consumerThread);
}

void Kernel::makeProducerThread()
{
    void* kernelSystemStack = Kernel::mallocSystemStack(KernelConfig::DEFAULT_SYSTEM_STACK_SIZE);
    ObjectPool<TCB, KernelConfig::NUM_OF_THREADS_IN_POOL>* sourcePool;
    TCB* producerThread = poolOfThreads->mallocObject(&sourcePool);
    while(!producerThread)
    {
        producerThread = poolOfThreads->mallocObject(&sourcePool);
    }
    producerThread->initializeThread(&KConsole::produceInputBuffer, nullptr, kernelSystemStack, kernelSystemStack, sourcePool, KernelConfig::BLOCKED, KernelConfig::KERNEL_MODE,
                                     true);
    addThreadToList(producerThread);
    KConsole::setProducerThread(producerThread);
}
void Kernel::makeDemonThread()
{
    void* kernelSystemStack = Kernel::mallocSystemStack(KernelConfig::DEFAULT_SYSTEM_STACK_SIZE);
    ObjectPool<TCB, KernelConfig::NUM_OF_THREADS_IN_POOL>* sourcePool;
    demonThread = poolOfThreads->mallocObject(&sourcePool);
    while(!demonThread)
    {
        demonThread = poolOfThreads->mallocObject(&sourcePool);
    }
    demonThread->initializeThread(&kernelWorker, nullptr, kernelSystemStack, kernelSystemStack, sourcePool, KernelConfig::READY, KernelConfig::KERNEL_MODE,
                                  false);
    addThreadToList(demonThread);
    Scheduler::setIdleThread(demonThread);
}
void Kernel::initializeKernelThreads(void)
{
    makeConsumerThread();
    makeProducerThread();
    makeDemonThread();
}
void Kernel::initializeKernelSemaphores(void)
{
    ObjectPool<KSemaphore, KernelConfig::NUM_OF_SEMAPHORES_IN_POOL>* sourcePoolOutput, *sourcePoolInput;
    semaphoreOutputBuffer = poolOfSemaphores->mallocObject(&sourcePoolOutput);
    while(!semaphoreOutputBuffer)
    {
        semaphoreOutputBuffer = poolOfSemaphores->mallocObject(&sourcePoolOutput);
    }
    semaphoreOutputBuffer->initializeSemaphore(1, sourcePoolOutput);

    semaphoreInputBuffer = poolOfSemaphores->mallocObject(&sourcePoolInput);
    while(!semaphoreInputBuffer)
    {
        semaphoreInputBuffer =  poolOfSemaphores->mallocObject(&sourcePoolInput);
    }
    semaphoreInputBuffer->initializeSemaphore(1, sourcePoolInput);

}
void Kernel::initializeKernel()
{
    MemoryAllocator::initialize();

    TCB::initializeGlobalId();
    KSemaphore::initializeGlobalId();

    Kernel::setInterruptRoutine(&interrupt_trap);

    poolOfThreads = new ObjectPool<TCB, KernelConfig::NUM_OF_THREADS_IN_POOL>();
    poolOfSemaphores = new ObjectPool<KSemaphore, KernelConfig::NUM_OF_SEMAPHORES_IN_POOL>();
    queueOfAsleepThreads = new PriorityQueue<TCB, decltype(cmp)>(cmp);
    queueOfOpenedSemaphores = new Queue<KSemaphore>();

    KConsole::initialize();
    Scheduler::initialize();

    while(!poolOfThreads)
    {
     poolOfThreads = new ObjectPool<TCB, KernelConfig::NUM_OF_THREADS_IN_POOL>();
    }
    while(!poolOfSemaphores)
    {
        poolOfSemaphores = new ObjectPool<KSemaphore, KernelConfig::NUM_OF_SEMAPHORES_IN_POOL>();
    }

    initializeKernelSemaphores();
    initializeKernelThreads();
    initializeSystemCalls();

}
void Kernel::shutdown()
{
    freeOpenedSemaphores();
    freeOpenedThreads();
    destroy();
    __asm__ volatile("li t0, 0x5555");
    __asm__ volatile("li t1, 0x100000");
    __asm__ volatile("sw t0, 0(t1)");
}

void Kernel::freeOpenedThreads()
{
    TCB* curr = headLiveThreads, *next;
    while(curr)
    {
        next = curr->getNextLiveThread();
        removeThreadFromList(curr);
        curr->setStateOfThread(KernelConfig::EXIT);
        curr->~TCB();
        curr->resetNextThreadInQueue();
        curr->resetNextLiveThread();
        poolOfThreads->freeObject(curr);
        curr = next;
    }
}
void Kernel::freeOpenedSemaphores()
{
    for(KSemaphore* curr = queueOfOpenedSemaphores->take(); curr; curr = queueOfOpenedSemaphores->take())
    {
        curr->close();
        curr->resetNextSemaphoreInQueue();
        curr->~KSemaphore();
        poolOfSemaphores->freeObject(curr);
    }
}
void Kernel::destroy()
{
    poolOfThreads->destroy();
    poolOfSemaphores->destroy();
    delete queueOfAsleepThreads;
    delete queueOfOpenedSemaphores;
    KConsole::destroy();
    Scheduler::destroy();
}

void Kernel::initializeArguments(Kernel::ArgumentsOfSystemCall* arg, uint64 basePointer)
{
    __asm__ volatile("ld %[rd], 11*8(%[rs])":[rd]"=r"(arg->a0):[rs]"r"(basePointer));
    __asm__ volatile("ld %[rd], 12*8(%[rs])":[rd]"=r"(arg->a1):[rs]"r"(basePointer));
    __asm__ volatile("ld %[rd], 13*8(%[rs])":[rd]"=r"(arg->a2):[rs]"r"(basePointer));
    __asm__ volatile("ld %[rd], 14*8(%[rs])":[rd]"=r"(arg->a3):[rs]"r"(basePointer));
    __asm__ volatile("ld %[rd], 15*8(%[rs])":[rd]"=r"(arg->a4):[rs]"r"(basePointer));
    __asm__ volatile("ld %[rd], 16*8(%[rs])":[rd]"=r"(arg->a5):[rs]"r"(basePointer));
    __asm__ volatile("ld %[rd], 17*8(%[rs])":[rd]"=r"(arg->a6):[rs]"r"(basePointer));
}


void* Kernel::mallocSystemStack(size_t numOfBytes)
{
    size_t correctedSize = numOfBytes + getSizeOfMetaData();
    size_t numOfBlocks = correctedSize / MEM_BLOCK_SIZE;
    numOfBlocks += correctedSize % MEM_BLOCK_SIZE ? 1 : 0;
    uint8* systemStack = (uint8*)MemoryAllocator::allocateMemory(numOfBlocks);
    return (void*)(&systemStack[KernelConfig::DEFAULT_SYSTEM_STACK_SIZE]);
}

void Kernel::wakeUpThreads()
{
    if(!queueOfAsleepThreads->top())
    {
        return;
    }
    queueOfAsleepThreads->top()->decrementTimeToSleep();

    while(queueOfAsleepThreads->top())
    {
        if(!queueOfAsleepThreads->top()->getTimeToSleep())
        {
            TCB* curr = queueOfAsleepThreads->take();
            curr->resetNextThreadInQueue();
            curr->setStateOfThread(KernelConfig::READY);
            Scheduler::put(curr);
        }
        else
        {
            return;
        }

    }
}
void Kernel::addThreadToList(TCB *thread)
{
    if(!headLiveThreads)
    {
        headLiveThreads = thread;
    }
    else
    {
        tailLiveThreads->addNewLiveThread(thread);
    }
    tailLiveThreads = thread;
}

void Kernel::removeThreadFromList(TCB *thread)
{
    TCB* prev = nullptr, *curr = headLiveThreads;
    while(curr != thread && curr)
    {
        prev = curr;
        curr = curr->getNextLiveThread();
    }
    if(!prev)
    {
        headLiveThreads = headLiveThreads->getNextLiveThread();
        if (!headLiveThreads)
        {
            tailLiveThreads = nullptr;
        }
    }
    else
    {
        prev->addNewLiveThread(thread->getNextLiveThread());
        if(tailLiveThreads == thread)
        {
            tailLiveThreads = prev;
        }
    }

}

TCB* Kernel::findThread(uint64 threadId)
{
    TCB* curr = headLiveThreads;
    while(curr)
    {
        if(curr->getId() == threadId)
        {
            return curr;
        }
        curr = curr->getNextLiveThread();
    }
    return nullptr;
}
void Kernel::interruptHandler()
{
   uint64 basePointer;
    __asm__ volatile ("addi %0, s0, 0": "=r"(basePointer)::);
    uint64 scause = Machine::readScause();
    switch (scause)
    {
        case KernelConfig::SYSTEM_CALL:
        {

            Machine::bc_sip(Machine::SSIP);

            volatile uint64 sepc = Machine::readSepc() + 4;
            volatile uint64 sstatus = Machine::readSstatus();

            uint64 numberOfEntry;
            __asm__ volatile ("ld %[rd], 80(%[rs])": [rd]"=r"(numberOfEntry):[rs]"r"(basePointer));

            ArgumentsOfSystemCall arg;
            initializeArguments(&arg, basePointer);
            systemCallsTable[numberOfEntry](&arg);

            __asm__ volatile("sd a0, 80(%[rs])"::[rs]"r"(basePointer));

            TCB::dispatch();

            Machine::writeSepc(sepc);
            Machine::writeSstatus(sstatus);
            break;
        }
        case KernelConfig::TIMER_INTERRUPT:
        {

            Machine::bc_sip(Machine::SSIP);
            TCB::incrementNumOfTicks();
            if (TCB::getNumOfTicks() >= TCB::getRunningThread()->getTimeSlice()) {
                TCB::resetNumOfTicks();

                volatile uint64 sepc = Machine::readSepc();
                volatile uint64 sstatus = Machine::readSstatus();

                TCB::dispatch();

                Machine::writeSepc(sepc);
                Machine::writeSstatus(sstatus);

            }
            wakeUpThreads();
            break;
        }
        case KernelConfig::CONSOLE_INTERRUPT:
        {
            volatile uint64 sepc = Machine::readSepc();
            volatile uint64 sstatus = Machine::readSstatus();

            uint8 statusReg;
            __asm__ volatile("lbu %[status], 0(%[address])": [status] "=r"(statusReg): [address] "r"(CONSOLE_STATUS):"memory");
            TCB* consumer = KConsole::getConsumerThread();
            TCB* producer = KConsole::getProducerThread();
            if (statusReg & CONSOLE_TX_STATUS_BIT)
            {
                KConsole::setOutputBufferReady();
                if(!consumer->getQueueOfWhichIsPart() && !KConsole::isOutputBufferEmpty() && consumer->getStateOfThread() != KernelConfig::READY)
                {
                    consumer->setStateOfThread(KernelConfig::READY);
                    Scheduler::put(consumer);
                }

            }

            if(statusReg & CONSOLE_RX_STATUS_BIT)
            {
                KConsole::setInputBufferReady();
                if(!producer->getQueueOfWhichIsPart() && !KConsole::isInputBufferFull() && producer->getStateOfThread() != KernelConfig::READY)
                {
                    producer->setStateOfThread(KernelConfig::READY);
                    Scheduler::put(producer);
                }
            }


            uint64 irq = plic_claim();
            plic_complete(irq);
            TCB::dispatch();

            Machine::writeSepc(sepc);
            Machine::writeSstatus(sstatus);
            break;
        }
    }

}
void Kernel::userWorker(void *)
{
    userMain();
}
void Kernel::kernelWorker(void*)
{
    void* systemStack = Kernel::mallocSystemStack(KernelConfig::DEFAULT_SYSTEM_STACK_SIZE);

    size_t correctedSize = DEFAULT_STACK_SIZE + getSizeOfMetaData();
    size_t numOfBlocks = correctedSize / MEM_BLOCK_SIZE;
    numOfBlocks += correctedSize % MEM_BLOCK_SIZE ? 1 : 0;
    uint8* userStack = (uint8*)MemoryAllocator::allocateMemory(numOfBlocks);

    ObjectPool<TCB, KernelConfig::NUM_OF_THREADS_IN_POOL>* sourcePool;
    TCB* userThread = poolOfThreads->mallocObject(&sourcePool);

    while(!userThread)
    {
        userThread = poolOfThreads->mallocObject(&sourcePool);
    }
    userThread->initializeThread(&userWorker, nullptr, &(userStack[DEFAULT_STACK_SIZE]), systemStack, sourcePool, KernelConfig::BLOCKED, KernelConfig::USER_MODE);
    addThreadToList(userThread);
    TCB::start(userThread);
    TCB::dispatch();
    Machine::bs_sstatus(Machine::SPIE);
    Machine::bs_sstatus(Machine::SIE);
    while(1)
    {

    }
}
void Kernel::startExecution()
{
    TCB::setRunningThread(demonThread);
    Machine::writeRa(demonThread->getContext()->ra);
    Machine::writeSp(demonThread->getContext()->sp);
    Machine::writeSepc(demonThread->getContext()->sepc);
    Machine::writeSstatus(demonThread->getContext()->sstatus);
    __asm__ volatile ("ret");

}
uint64 Kernel::sysMalloc(Kernel::ArgumentsOfSystemCall *arg)
{
    return (uint64)MemoryAllocator::allocateMemory(arg->a0);
}
uint64 Kernel::sysFree(Kernel::ArgumentsOfSystemCall *arg)
{
    return (uint64)MemoryAllocator::freeMemory((void*)arg->a0);
}
uint64 Kernel::sysGetFreeSpace(Kernel::ArgumentsOfSystemCall *arg)
{
    return (uint64)MemoryAllocator::getFreeSpace();
}
uint64 Kernel::sysLargestFreeBlock(Kernel::ArgumentsOfSystemCall *arg)
{
    return (uint64)MemoryAllocator::getLargestFreeBlock();
}
uint64 Kernel::sysThreadCreate(Kernel::ArgumentsOfSystemCall *arg)
{
    ObjectPool<TCB, KernelConfig::NUM_OF_THREADS_IN_POOL>* sourcePool;
    TCB* newThread = poolOfThreads->mallocObject(&sourcePool);
    if(!newThread)
    {
        return -1;
    }
    void* kernelSystemStack = Kernel::mallocSystemStack(KernelConfig::DEFAULT_SYSTEM_STACK_SIZE);
    if(!kernelSystemStack)
    {
        return -1;
    }
    newThread->initializeThread((TCB::Body) arg->a1, (void*)arg->a2, (void*)arg->a3, kernelSystemStack, sourcePool);
    addThreadToList(newThread);
    __asm__ volatile("sd %[threadHandle], 0(%[handle])"::[threadHandle]"r"(newThread->getId()), [handle]"r"(arg->a0));
    return 0;
}
uint64 Kernel::sysThreadDispatch(Kernel::ArgumentsOfSystemCall *arg)
{
    TCB::dispatch();
    return 0;
}
uint64 Kernel::sysThreadFinish(ArgumentsOfSystemCall *arg)
{
    TCB* oldThread = TCB::getRunningThread();
    if(oldThread->getStateOfThread() == KernelConfig::FINISHED)
    {
        return 0;
    }
    oldThread->setIsFinished();
    oldThread->setStateOfThread(KernelConfig::FINISHED);
    oldThread->freeWaitThreads();
    if(oldThread->getId() == KernelConfig::USER_WORKER_ID)
    {
        shutdown();
    }
    return 0;
}
uint64 Kernel::sysThreadExit(Kernel::ArgumentsOfSystemCall *arg)
{

    TCB* oldThread = TCB::getRunningThread();
    oldThread->setStateOfThread(KernelConfig::EXIT);
    oldThread->~TCB();
    oldThread->resetNextThreadInQueue();

    removeThreadFromList(oldThread);
    oldThread->resetNextLiveThread();
    poolOfThreads->freeObject(oldThread);
    return 0;

}
uint64 Kernel::sysThreadStart(ArgumentsOfSystemCall *arg)
{
    TCB* tempThread = findThread((uint64)(arg->a0));
    if(!tempThread)
    {
        return -1;
    }
    if(tempThread->getStateOfThread() == KernelConfig::ASLEEP || tempThread->getQueueOfWhichIsPart())
    {
        return -1;
    }
    tempThread->setStateOfThread(KernelConfig::READY);
    Scheduler::put(tempThread);
    return 0;
}

uint64 Kernel::sysThreadKill(ArgumentsOfSystemCall *arg)
{
    TCB* tempThread = findThread((uint64)(arg->a0));
    if(!tempThread)
    {
        return -1;
    }

    if(tempThread->getStateOfThread() == KernelConfig::ASLEEP)
    {
        queueOfAsleepThreads->removeElement(tempThread);
    }
    else
    {
        Queue<TCB>* queue = tempThread->getQueueOfWhichIsPart();
        if(queue)
        {
            queue->removeElement(tempThread);
        }
    }

    tempThread->setIsFinished();
    tempThread->freeWaitThreads();
    tempThread->~TCB();
    tempThread->setStateOfThread(KernelConfig::EXIT);
    tempThread->resetNextThreadInQueue();
    tempThread->resetQueueOfWhichIsPart();
    removeThreadFromList(tempThread);
    tempThread->resetNextLiveThread();
    poolOfThreads->freeObject(tempThread);
    return 0;
}
uint64 Kernel::sysThreadJoin(ArgumentsOfSystemCall *arg)
{
    TCB* tempThread = findThread((uint64)(arg->a0));
    if(!tempThread)
    {
        return -1;
    }

    if(!tempThread->isFinished())
    {
        TCB* oldThread = TCB::getRunningThread();
        oldThread->resetNextThreadInQueue();
        oldThread->setStateOfThread(KernelConfig::BLOCKED);
        oldThread->setQueueOfWhichIsPart(tempThread->getWaitQueue());
        tempThread->addThreadToWaitQueue(oldThread);

        TCB* newRunning = Scheduler::get();
        TCB::setRunningThread(newRunning);
        context_switch(oldThread->getContext(), newRunning->getContext());

    }
    __asm__ volatile ("":::"memory");
    tempThread->~TCB();
    tempThread->setStateOfThread(KernelConfig::EXIT);
    tempThread->resetNextThreadInQueue();
    removeThreadFromList(tempThread);
    tempThread->resetNextLiveThread();
    poolOfThreads->freeObject(tempThread);
    return 0;
}
uint64 Kernel::sysThreadId(ArgumentsOfSystemCall *arg)
{
    TCB* tempThread = TCB::getRunningThread();
    return tempThread->getId();
}
uint64 Kernel::sysSemaphoreOpen(ArgumentsOfSystemCall *arg)
{
    ObjectPool<KSemaphore, KernelConfig::NUM_OF_SEMAPHORES_IN_POOL>* sourcePool;
    KSemaphore* newSemaphore = poolOfSemaphores->mallocObject(&sourcePool);
    if(!newSemaphore)
    {
        return -1;
    }
    newSemaphore->initializeSemaphore((unsigned)arg->a1, sourcePool);
    queueOfOpenedSemaphores->append(newSemaphore);
    __asm__ volatile("sd %[semaphoreHandle], 0(%[handle])"::[semaphoreHandle]"r"(newSemaphore->getID()), [handle]"r"(arg->a0));
    return 0;
}

uint64 Kernel::sysSemaphoreClose(ArgumentsOfSystemCall *arg)
{
    uint64 returnValue;
    KSemaphore* tempSemaphore = queueOfOpenedSemaphores->findElement((uint64)arg->a0);
    if(!tempSemaphore)
    {
        return -1;
    }
    returnValue = (uint64)tempSemaphore->close();
    queueOfOpenedSemaphores->removeElement(tempSemaphore);
    tempSemaphore->resetNextSemaphoreInQueue();
    tempSemaphore->~KSemaphore();
    poolOfSemaphores->freeObject(tempSemaphore);

    return returnValue;
}

uint64 Kernel::sysSemaphoreWait(ArgumentsOfSystemCall *arg)
{
    KSemaphore* tempSemaphore = queueOfOpenedSemaphores->findElement((uint64)arg->a0);
    if(!tempSemaphore)
    {
        return -1;
    }
    return (uint64)tempSemaphore->wait();
}

uint64 Kernel::sysSemaphoreSignal(ArgumentsOfSystemCall *arg)
{
    KSemaphore* tempSemaphore = queueOfOpenedSemaphores->findElement(arg->a0);
    if(!tempSemaphore)
    {
        return -1;
    }
    return (uint64)tempSemaphore->signal();
}

uint64 Kernel::sysTimeSleep(ArgumentsOfSystemCall *arg)
{
    TCB* oldThread = TCB::getRunningThread();
    oldThread->resetNextThreadInQueue();
    size_t time = (size_t)arg->a0;
    if(time == 0)
    {
        return 0;
    }
    oldThread->setTimeToSleep((size_t)arg->a0);
    oldThread->setStateOfThread(KernelConfig::ASLEEP);
    queueOfAsleepThreads->append(oldThread);
    TCB* newRunning = Scheduler::get();
    TCB::setRunningThread(newRunning);
    context_switch(oldThread->getContext(), newRunning->getContext());
    return 0;
}
uint64 Kernel::sysGetc(ArgumentsOfSystemCall *arg) {
    char c;
    if (KConsole::isInputBufferEmpty())
    {
        TCB *oldThread = TCB::getRunningThread();
        TCB *newRunning = Scheduler::get();
        TCB::setRunningThread(newRunning);
        oldThread->resetNextThreadInQueue();
        KConsole::addThreadToInputWaitQueue(oldThread);
        context_switch(oldThread->getContext(), newRunning->getContext());
    }
    semaphoreInputBuffer->wait();
    TCB* producer = KConsole::getProducerThread();
    if(KConsole::getInputBufferReady() && KConsole::isInputBufferFull())
    {
        producer->setStateOfThread(KernelConfig::READY);
        Scheduler::put(producer);
    }
    c = KConsole::getCharFromInputBuffer();
    semaphoreInputBuffer->signal();
    return (uint64) c;

}
uint64 Kernel::sysPutc(ArgumentsOfSystemCall *arg)
{

    if(KConsole::isOutputBufferFull())
    {
        TCB* oldThread = TCB::getRunningThread();
        TCB* newRunning = Scheduler::get();
        TCB::setRunningThread(newRunning);
        oldThread->resetNextThreadInQueue();
        KConsole::addThreadToOutputWaitQueue(oldThread);
        context_switch(oldThread->getContext(), newRunning->getContext());
    }
    semaphoreOutputBuffer->wait();
    TCB* consumer = KConsole::getConsumerThread();
    if(KConsole::getOutputBufferReady() && KConsole::isOutputBufferEmpty())
    {
        consumer->setStateOfThread(KernelConfig::READY);
        Scheduler::put(consumer);
    }
    KConsole::addCharToOutputBuffer(arg->a0);
    semaphoreOutputBuffer->signal();
    return 0;

}

void Kernel::initializeSystemCalls(void)
{
    systemCallsTable[KernelConfig::MEM_ALLOC] = &sysMalloc;
    systemCallsTable[KernelConfig::MEM_FREE] = &sysFree;
    systemCallsTable[KernelConfig::MEM_FREE_SPACE] = &sysGetFreeSpace;
    systemCallsTable[KernelConfig::LARGEST_FREE_BLOCK] = &sysLargestFreeBlock;
    systemCallsTable[KernelConfig::THREAD_CREATE] = &sysThreadCreate;
    systemCallsTable[KernelConfig::THREAD_DISPATCH] = &sysThreadDispatch;
    systemCallsTable[KernelConfig::THREAD_EXIT] = &sysThreadExit;
    systemCallsTable[KernelConfig::THREAD_START] = &sysThreadStart;
    systemCallsTable[KernelConfig::THREAD_ID] = &sysThreadId;
    systemCallsTable[KernelConfig::THREAD_FINISH] = &sysThreadFinish;
    systemCallsTable[KernelConfig::THREAD_KILL] = &sysThreadKill;
    systemCallsTable[KernelConfig::THREAD_JOIN] = &sysThreadJoin;
    systemCallsTable[KernelConfig::SEMAPHORE_OPEN] = &sysSemaphoreOpen;
    systemCallsTable[KernelConfig::SEMAPHORE_CLOSE] = &sysSemaphoreClose;
    systemCallsTable[KernelConfig::SEMAPHORE_SIGNAL] = &sysSemaphoreSignal;
    systemCallsTable[KernelConfig::SEMAPHORE_WAIT] = &sysSemaphoreWait;
    systemCallsTable[KernelConfig::TIME_SLEEP] = &sysTimeSleep;
    systemCallsTable[KernelConfig::GETC] = &sysGetc;
    systemCallsTable[KernelConfig::PUTC] = &sysPutc;
}