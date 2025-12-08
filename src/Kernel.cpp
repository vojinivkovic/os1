//
// Created by os on 12/1/25.
//

#include "../h/Kernel.hpp"
extern "C" void interrupt_trap(void);



uint64 (*Kernel::systemCallsTable[KernelConfig::NUM_OF_SYSTEM_CALLS])(Kernel::ArgumentsOfSystemCall* arg) = {nullptr};
ObjectPool<TCB, KernelConfig::NUM_OF_THREADS_IN_POOL>* Kernel::poolOfThreads = new ObjectPool<TCB, KernelConfig::NUM_OF_THREADS_IN_POOL>();
TCB* Kernel::runningThread = nullptr;

void Kernel::initializeKernel()
{
    Kernel::setInterruptRoutine(&interrupt_trap);
    while(!poolOfThreads)
    {
     poolOfThreads = new ObjectPool<TCB, KernelConfig::NUM_OF_THREADS_IN_POOL>();
    }
    systemCallsTable[MEM_ALLOC] = &sysMalloc;
    systemCallsTable[MEM_FREE] = &sysFree;
    systemCallsTable[MEM_FREE_SPACE] = &sysGetFreeSpace;
    systemCallsTable[LARGEST_FREE_BLOCK] = &sysLargestFreeBlock;
    systemCallsTable[CREATE_THREAD] = &sysCreateThread;
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

uint64 Kernel::sysMalloc(Kernel::ArgumentsOfSystemCall *arg)
{
    uint64 returnValue;
    returnValue = (uint64)MemoryAllocator::allocateMemory(arg->a0);
    return returnValue;
}
uint64 Kernel::sysFree(Kernel::ArgumentsOfSystemCall *arg)
{
    uint64 returnValue;
    returnValue = (uint64)MemoryAllocator::freeMemory((void*)arg->a0);
    return returnValue;
}
uint64 Kernel::sysGetFreeSpace(Kernel::ArgumentsOfSystemCall *arg)
{
    uint64 returnValue;
    returnValue = (uint64)MemoryAllocator::getFreeSpace();
    return returnValue;
}
uint64 Kernel::sysLargestFreeBlock(Kernel::ArgumentsOfSystemCall *arg)
{
    uint64 returnValue;
    returnValue = (uint64)MemoryAllocator::getLargestFreeBlock();
    return returnValue;
}
uint64 Kernel::sysCreateThread(Kernel::ArgumentsOfSystemCall *arg)
{
    TCB* newThread = poolOfThreads->mallocObject();
    if(!newThread)
    {
        return -1;
    }
    __asm__ volatile("sd %[ptrThread], 0(%[handle])"::[ptrThread]"r"(newThread), [handle]"r"(arg->a0));
    newThread->initializeThread(arg->a1, )
    return 0;
}
void Kernel::interruptHandler()
{
    volatile uint64 basePointer;
    __asm__ volatile ("addi %[reg], s0, 0x0": [reg]"=r"(basePointer)); // Problem: da li mozemo biti 100% sigurni da ce s0 biti nepromenjen; resenje inline f-ja
    uint64 scause = Machine::readScause();
    if(scause == 0x0000000000000008UL || scause == 0x0000000000000009UL)
    {
        uint64 numberOfEntry;
        __asm__ volatile ("ld %[rd], 80(%[rs])": [rd]"=r"(numberOfEntry):[rs]"r"(basePointer));
        ArgumentsOfSystemCall arg;
        initializeArguments(&arg, basePointer);
        systemCallsTable[numberOfEntry](&arg);
        __asm__ volatile("sd a0, 80(%[rs])"::[rs]"r"(basePointer));
        yield;
        Machine::incrementSepc();
    }

}