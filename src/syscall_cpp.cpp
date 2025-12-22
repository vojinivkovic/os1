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
v
Thread::Thread(void (*body)(void *), void *arg): body(body), arg(arg)
{
    if(thread_create(&myHandle, this->body, this->arg))
    {
       myHandle = nullptr;
    }
}

void Thread::wrapperRun(void* thread)
{
    Thread* tempThread = (Thread*)thread;
    tempThread->run();
}
int Thread::start()
{
    if(myHandle == nullptr)
    {
        return -1;
    }

}

Thread::Thread(): body(nullptr), arg(nullptr)
{
    if(thread_create(&myHandle, &(Thread::wrapperRun), this))
    {
        myHandle = nullptr;
    }
}

char Console::getc()
{
    ::getc();
}

void Console::putc(char c)
{
    ::putc();
}