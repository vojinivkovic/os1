//
// Created by os on 12/1/25.
//

#include "../h/Kernel.hpp"
extern "C" void interrupt_trap(void);
uint64 (*Kernel::systemCallsTable[NUM_OF_SYSTEM_CALLS])(Kernel::ArgumentsOfSystemCall* arg) = {nullptr};

void Kernel::initializeKernel()
{
    Kernel::setInterruptRoutine(&interrupt_trap);
    systemCallsTable[1] = &kmalloc;
    systemCallsTable[2] = &kfree;
}
void Kernel::initializeArguments(Kernel::ArgumentsOfSystemCall* arg)
{
    __asm__ volatile("sd a1, 0x0(a0)");
    __asm__ volatile("sd a2, 0x8(a0)");
    __asm__ volatile("sd a3, 0x10(a0)");
    __asm__ volatile("sd a4, 0x18(a0)");
    __asm__ volatile("sd a5, 0x20(a0)");
    __asm__ volatile("sd a6, 0x28(a0)");
    __asm__ volatile("sd a7, 0x30(a0)");
}

uint64 Kernel::kmalloc(Kernel::ArgumentsOfSystemCall *arg)
{
    uint64 returnValue;
    returnValue = (uint64)MemoryAllocator::allocateMemory(arg->a0);
    return returnValue;
}
uint64 Kernel::kfree(Kernel::ArgumentsOfSystemCall *arg)
{
    uint64 returnValue;
    returnValue = (uint64)MemoryAllocator::freeMemory((void*)arg->a0);
    return returnValue;
}

void Kernel::interruptHandler(size_t numberOfEntry)
{
    uint64 scause = Machine::readScause();
    if(scause == 0x0000000000000008UL || scause == 0x0000000000000009UL)
    {
        ArgumentsOfSystemCall arg;
        initializeArguments(&arg);
        systemCallsTable[numberOfEntry](&arg);
        Machine::incrementSepc();
    }

}