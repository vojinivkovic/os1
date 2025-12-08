//
// Created by os on 12/1/25.
//

#ifndef PROJECT_BASE_V1_1_MACHINE_H
#define PROJECT_BASE_V1_1_MACHINE_H
#include "../lib/hw.h"

class Kernel; //forward declaration
class TCB;

class Machine
{
public:
    Machine() = delete;
    Machine(const Machine& riscv) = delete;
    Machine& operator=(const Machine& riscv) = delete;
private:
    static void writeStvec(uint64 interruptAddress);
    static uint64 readScause(void);
    static void incrementSepc(void);
    static void writeSscratch(uint64 systemSP);
    friend class Kernel;
    friend class TCB;

};

inline void Machine::writeStvec(uint64 interruptAddress)
{
    __asm__ volatile ("csrw stvec, %[address]": : [address] "r"(interruptAddress));
}

inline uint64 Machine::readScause(void)
{
    uint64 scause;
    __asm__ volatile ("csrr %[cause], scause": [cause] "=r"(scause));
    return scause;
}

inline void Machine::incrementSepc(void)
{
    __asm__ volatile ("csrr t0, sepc");
    __asm__ volatile ("addi t0, t0, 0x4");
    __asm__ volatile ("csrw sepc, t0");
}

inline void Machine::writeSscratch(uint64 systemSP)
{
    __asm__ volatile ("csrw sscratch, %[sp]":: [sp] "r"(systemSP));
}

#endif //PROJECT_BASE_V1_1_MACHINE_H
