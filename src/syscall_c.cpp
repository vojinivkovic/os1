//
// Created by os on 12/1/25.
//

#include "../h/syscall_c.hpp"
enum Number_Of_System_Call{
    MEM_ALLOC = 0x1,
    MEM_FREE = 0x2
};

typedef struct Arguments{
    uint64 a0, a1, a2, a3, a4, a5, a6, a7;
} Arguments;


extern "C" void system_call(Arguments* arg);
uint64 prepare_system_call(uint64 id, uint64 arg0, uint64 arg1, uint64 arg2, uint64 arg3, uint64 arg4, uint64 arg5, uint64 arg6){
    Arguments arg = {id, arg0, arg1, arg2, arg3, arg4, arg5, arg6};
    system_call(&arg);
    return arg.a0;
}

void* mem_alloc(size_t size){
    return (void*)prepare_system_call(MEM_ALLOC, size, 0, 0, 0, 0, 0, 0);
}

int mem_free(void* obj){
    return (int)prepare_system_call(MEM_FREE, obj, 0, 0, 0, 0, 0, 0);
}
