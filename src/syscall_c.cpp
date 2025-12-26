//
// Created by os on 12/1/25.
//

#include "../h/syscall_c.hpp"
#include "../h/Config.hpp"
#include "../h/MetaData.hpp"


typedef struct Arguments
{
    uint64 a0, a1, a2, a3, a4, a5, a6, a7;
} Arguments;



extern "C" uint64 system_call(Arguments* arg);

void* mem_alloc(size_t size)
{
    //size_t correctedSize = size + MemoryAllocator::getSizeOfMetaData();
    size_t correctedSize = size + getSizeOfMetaData();
    uint64 size_of_blocks = correctedSize / MEM_BLOCK_SIZE;
    size_of_blocks += correctedSize % MEM_BLOCK_SIZE ? 1: 0;
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

    Arguments arg = {KernelConfig::THREAD_CREATE, (uint64)handle, (uint64)start_routine, (uint64)argOfRoutine, (uint64)(&threadStack[DEFAULT_STACK_SIZE]), 0, 0, 0};

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
int thread_start(thread_t handle)
{
    Arguments arg = {KernelConfig::THREAD_START,(uint64)handle, 0, 0, 0, 0, 0, 0};
    return (uint64)system_call(&arg);
}

void thread_join(thread_t handle)
{
    Arguments arg = {KernelConfig::THREAD_JOIN,(uint64)handle, 0, 0, 0, 0, 0, 0};
    system_call(&arg);
}

void thread_terminate(thread_t handle)
{
    Arguments arg = {KernelConfig::THREAD_TERMINATE,(uint64)handle, 0, 0, 0, 0, 0, 0};
    system_call(&arg);
}
int sem_open(sem_t* handle, unsigned init)
{
    Arguments arg = {KernelConfig::SEMAPHORE_OPEN, (uint64)handle, (uint64)init, 0, 0, 0, 0, 0};
    return (int) system_call(&arg);
}

int sem_close(sem_t handle)
{
    Arguments arg = {KernelConfig::SEMAPHORE_CLOSE, (uint64)handle, 0, 0, 0, 0, 0, 0};
    return (int) system_call(&arg);
}

int sem_wait(sem_t handle)
{
    Arguments arg = {KernelConfig::SEMAPHORE_WAIT, (uint64)handle, 0, 0, 0, 0, 0, 0};
    return (int) system_call(&arg);
}

int sem_signal(sem_t handle)
{
    Arguments arg = {KernelConfig::SEMAPHORE_SIGNAL, (uint64)handle, 0, 0, 0, 0, 0, 0};
    return (int) system_call(&arg);
}

int time_sleep(time_t time_to_sleep)
{
    Arguments arg = {KernelConfig::TIME_SLEEP, (uint64)time_to_sleep, 0, 0, 0, 0, 0, 0};
    return (int) system_call(&arg);
}
char getc()
{
    Arguments arg = {KernelConfig::GETC, 0, 0, 0, 0, 0, 0, 0};
    return (char) system_call(&arg);
}

void putc(char c)
{
    Arguments arg = {KernelConfig::PUTC, (uint64) c, 0, 0, 0, 0, 0, 0};
    system_call(&arg);
}