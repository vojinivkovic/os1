//
// Created by os on 12/1/25.
//

#include "../h/syscall_c.hpp"
#include "../h/MemoryAllocator.hpp"
#include "../h/Config.hpp"


typedef struct Arguments
{
    uint64 a0, a1, a2, a3, a4, a5, a6, a7;
} Arguments;




extern "C" uint64 system_call(Arguments* arg);

void* mem_alloc(size_t size)
{
    uint64 size_of_blocks = (size + MemoryAllocator::getSizeOfMetaData()) / MEM_BLOCK_SIZE;
    size_of_blocks += (size + MemoryAllocator::getSizeOfMetaData()) % MEM_BLOCK_SIZE ? 1: 0;
    Arguments arg = {KernelConfig::MEM_ALLOC, size_of_blocks, 0, 0, 0, 0, 0, 0};
    return (void*) system_call(&arg);
}

int mem_free(void* obj)
{   Arguments arg = {KernelConfig::MEM_FREE, (uint64)obj, 0, 0, 0, 0, 0, 0};
    return (int) system_call(&arg);
}

size_t mem_get_free_space()
{
    Arguments arg = {KernelConfig::MEM_FREE_SPACE, 0, 0, 0, 0, 0, 0, 0};
    return (size_t) system_call(&arg);
}
size_t mem_get_largest_free_block()
{
    Arguments arg = {KernelConfig::LARGEST_FREE_BLOCK, 0, 0, 0, 0, 0, 0, 0};
    return (size_t) system_call(&arg);
}

int thread_create(thread_t* handle, void(*start_routine)(void*), void* argOfRoutine)
{
    uint8* threadStack = (uint8*)mem_alloc(DEFAULT_STACK_SIZE);
    if(threadStack == nullptr)
    {
        return -1;
    }

    Arguments arg = {(uint64)KernelConfig::THREAD_CREATE, (uint64)handle, (uint64)start_routine, (uint64)argOfRoutine, (uint64)(&threadStack[DEFAULT_STACK_SIZE]), 0, 0, 0};

    return (int) system_call(&arg);
}

void thread_dispatch()
{
    Arguments arg = {KernelConfig::THREAD_DISPATCH, 0, 0, 0, 0, 0, 0, 0};
    system_call(&arg);
}

int thread_exit()
{
    Arguments arg = {KernelConfig::THREAD_EXIT, 0, 0, 0, 0, 0, 0, 0};
    return (int) system_call(&arg);
}