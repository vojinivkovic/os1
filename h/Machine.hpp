//
// Created by os on 12/1/25.
//

#ifndef PROJECT_BASE_V1_1_MACHINE_H
#define PROJECT_BASE_V1_1_MACHINE_H
#include "../lib/hw.h"

class Kernel; //forward declaration
class TCB;
class KConsole;
class Machine
{
public:
    Machine() = delete;
    Machine(const Machine& riscv) = delete;
    Machine& operator=(const Machine& riscv) = delete;

    enum BitsMaskSip
    {
        SSIP = 1 << 1, // software interrupt
        SEIP = 1 << 9 // (external) hardware interrupt
    };
    enum BitsMaskSstatus
    {
        SSP = 1 << 8,
        SIE = 1 << 1,
        SPIE = 1 << 5
    };
    enum BitsMaskSie
    {
        SSIE = 1 << 1,
        SEIE = 1 << 9
    };
private:
    static void writeStvec(uint64 interruptAddress);
    static uint64 readScause(void);
    static void incrementSepc(void);
    static void writeSepc(uint64 address);
    static uint64 readSepc();
    static void writeSstatus(uint64 oldStatus);
    static uint64 readSstatus();
    static void writeSscratch(uint64 systemSP);
    static uint64 readSscratch();
    static void writeRa(uint64 newRa);
    static void writeSp(uint64 newSp);
    static void bc_sip(uint64 mask);
    static void bs_sstatus(uint64 mask);
    static void bc_sie(uint64 mask);
    static void bs_sie(uint64 mask);
    friend class Kernel;
    friend class TCB;
    friend class KConsole;

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

inline void Machine::writeSscratch(uint64 systemSP)
{
    __asm__ volatile ("csrw sscratch, %[sp]":: [sp] "r"(systemSP));
}

inline void Machine::bc_sip(uint64 mask)
{
    __asm__ volatile ("csrc sip, %[reg]":: [reg] "r"(mask));
}
inline void Machine::bs_sstatus(uint64 mask)
{
    __asm__ volatile ("csrs sstatus, %[reg]":: [reg] "r"(mask));
}
inline uint64 Machine::readSscratch()
{
    uint64 returnValue;
    __asm__ volatile ("csrr %[reg], sscratch": [reg] "=r"(returnValue));
    return returnValue;
}
inline void Machine::writeSepc(uint64 address)
{
    __asm__ volatile("csrw sepc, %[reg]":: [reg] "r"(address));
}
inline uint64 Machine::readSepc()
{
    uint64 returnAddress;
    __asm__ volatile ("csrr %[reg], sepc": [reg] "=r"(returnAddress)::"memory");
    return returnAddress;
}
inline void Machine::writeSstatus(uint64 oldStatus)
{
    __asm__ volatile("csrw sstatus, %[reg]":: [reg] "r"(oldStatus));
}
inline uint64 Machine::readSstatus()
{
    uint64 returnStatus;
    __asm__ volatile ("csrr %[reg], sstatus": [reg] "=r"(returnStatus)::"memory");
    return returnStatus;
}
inline void Machine::writeRa(uint64 newRa)
{
    __asm__ volatile ("addi ra, %[reg], 0":: [reg]"r"(newRa));
}

inline void Machine::writeSp(uint64 newSp)
{
    __asm__ volatile ("addi sp, %[reg], 0":: [reg]"r"(newSp));
}

inline void Machine::bs_sie(uint64 mask)
{
    __asm__ volatile ("csrs sie, %[reg]":: [reg] "r"(mask));
}

inline void Machine::bc_sie(uint64 mask)
{
    __asm__ volatile ("csrc sie, %[reg]":: [reg] "r"(mask));
}

inline void Machine::incrementSepc()
{
    __asm__ volatile("csrr t0, sepc");
    __asm__ volatile("addi t0, t0, 4");
    __asm__ volatile("csrw sepc, t0");
}
#endif //PROJECT_BASE_V1_1_MACHINE_H
