//
// Created by os on 11/29/25.
//
#include "../h/MemoryAllocator.hpp"
#include "../h/Kernel.hpp"
#include "../h/syscall_c.hpp"
void userMain();
void mainWrapper(void*)
{
    userMain();
}

void main(){
    Kernel::initializeKernel();
    thread_t mainHandle;
    thread_create(&mainHandle, &mainWrapper, nullptr);
    thread_start(mainHandle);
}