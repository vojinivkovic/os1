//
// Created by os on 12/1/25.
//

#include "../h/syscall_c.hpp"
#include "../h/MemoryAllocator.hpp"
#include "../h/Kernel.hpp"


typedef struct Arguments{
    uint64 a0, a1, a2, a3, a4, a5, a6, a7;
} Arguments;




extern "C" uint64 system_call(Arguments* arg);

void* mem_alloc(size_t size)
{
    uint64 size_of_blocks = (size + MemoryAllocator::getSizeOfMetaData()) / MEM_BLOCK_SIZE;
    size_of_blocks += (size + MemoryAllocator::getSizeOfMetaData()) % MEM_BLOCK_SIZE ? 1: 0;
    Arguments arg = {Kernel::MEM_ALLOC, size_of_blocks, 0, 0, 0, 0, 0, 0};
    return (void*) system_call(&arg);
}

int mem_free(void* obj)
{   Arguments arg = {Kernel::MEM_FREE, (uint64)obj, 0, 0, 0, 0, 0, 0};
    return (int) system_call(&arg);
}

size_t mem_get_free_space()
{
    Arguments arg = {Kernel::MEM_FREE_SPACE, 0, 0, 0, 0, 0, 0, 0};
    return (size_t) system_call(&arg);
}
size_t mem_get_largest_free_block()
{
    Arguments arg = {Kernel::LARGEST_FREE_BLOCK, 0, 0, 0, 0, 0, 0, 0};
    return (size_t) system_call(&arg);
}

