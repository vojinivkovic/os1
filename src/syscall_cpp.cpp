//
// Created by os on 12/20/25.
//
#include "../h/syscall_cpp.hpp"

void* ::operator new(size_t size)
{
    return mem_alloc(size);
}
void ::operator delete(void* obj)
{
    mem_free(obj);
}

char Console::getc()
{
    ::getc();
}

void Console::putc(char c)
{
    ::putc();
}