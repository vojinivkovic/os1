//
// Created by os on 12/1/25.
//

#ifndef PROJECT_BASE_V1_1_KERNEL_H
#define PROJECT_BASE_V1_1_KERNEL_H
#include "Machine.hpp"

class Kernel {
public:
    Kernel() = delete;
    Kernel(const Kernel& kernel) = delete;
    Kernel& operator=(const Kernel& kernel) = delete;
    static void initializeKernel(void);

private:
    static void setInterruptRoutine(void (*routine)(void));
    static void interruptHandler(void);
};

inline void Kernel::setInterruptRoutine(void (*routine)(void)) {
    Machine::writeStvec((uint64) routine);
}


#endif //PROJECT_BASE_V1_1_KERNEL_H
