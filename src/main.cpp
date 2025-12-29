//
// Created by os on 11/29/25.
//
#include "../h/MemoryAllocator.hpp"
#include "../h/Kernel.hpp"
#include "../h/syscall_c.hpp"


void main(){
    Kernel::initializeKernel();
    Kernel::startExecution();
}