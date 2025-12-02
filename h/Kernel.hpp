//
// Created by os on 12/1/25.
//

#ifndef PROJECT_BASE_V1_1_KERNEL_H
#define PROJECT_BASE_V1_1_KERNEL_H
#include "Machine.hpp"
#include "MemoryAllocator.hpp"

#define NUM_OF_SYSTEM_CALLS 10


class Kernel {
public:
    Kernel() = delete;
    Kernel(const Kernel& kernel) = delete;
    Kernel& operator=(const Kernel& kernel) = delete;
    static void initializeKernel(void);

private:
    typedef struct ArgumentsOfSystemCall{
        uint64 a0, a1, a2, a3, a4, a5, a6;
    } ArgumentsOfSystemCall;
    static void setInterruptRoutine(void (*routine)(void));
    static void interruptHandler(size_t numberOfEntry);
    static uint64 kmalloc(ArgumentsOfSystemCall* arg);
    static uint64 kfree(ArgumentsOfSystemCall* arg);
    static uint64 (*systemCallsTable[NUM_OF_SYSTEM_CALLS])(ArgumentsOfSystemCall* arg);
    static void initializeArguments(ArgumentsOfSystemCall& arg);
};

inline void Kernel::setInterruptRoutine(void (*routine)(void)) {
    Machine::writeStvec((uint64) routine);
}


#endif //PROJECT_BASE_V1_1_KERNEL_H
