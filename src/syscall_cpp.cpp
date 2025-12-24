//
// Created by os on 12/20/25.
//
#include "../h/syscall_cpp.hpp"

void* operator new(size_t size)
{
    return mem_alloc(size);
}
void operator delete(void* obj)
{
    mem_free(obj);
}

Thread::~Thread()
{
    thread_join(myHandle);
}
void Thread::dispatch()
{
    thread_dispatch();
}
int Thread::sleep(time_t time)
{
    return time_sleep(time);
}

Thread::Thread(void (*body)(void *), void *arg): body(body), arg(arg), myHandle(nullptr)
{
    if(thread_create(&myHandle, body, arg))
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
    return thread_start(myHandle);


}

Thread::Thread(): body(nullptr), arg(nullptr), myHandle(nullptr)
{
    if(thread_create(&myHandle, &(Thread::wrapperRun), this))
    {
        myHandle = nullptr;
    }
}
void PeriodicThread::wrapperPeriodicThread(void * thread)
{
    PeriodicThread* tempThread = (PeriodicThread*) thread;
    while(1)
    {
        tempThread->periodicActivation();
        time_sleep(period);
    }
}
PeriodicThread::PeriodicThread(time_t period) : Thread(&(PeriodicThread::wrapperPeriodicThread), this),
period(period)
{

}
void PeriodicThread::terminate()
{
    thread_terminate(myHandle);
}
Semaphore::Semaphore(unsigned int init)
{
    sem_open(&myHandle, init);
}
Semaphore::~Semaphore()
{
    sem_close(myHandle);
}
int Semaphore::wait()
{
    return sem_wait(myHandle);
}
int Semaphore::close()
{
    return sem_close(myHandle);
}

char Console::getc()
{
   return ::getc();
}

void Console::putc(char c)
{
    ::putc(c);
}