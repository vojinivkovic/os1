//
// Created by os on 12/20/25.
//
#include "../h/syscall_cpp.hpp"
#include "../h/printing.hpp"
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
    if(myHandle == thread_id())
    {
        printString("Thread tried to kill itself");
        return;
    }
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

Thread::Thread(void (*body)(void *), void *arg): myHandle(0), body(body), arg(arg)
{
    if(thread_create(&myHandle, this->body, this->arg))
    {
       myHandle = 0;
    }
}

void Thread::wrapperRun(void* thread)
{
    Thread* tempThread = (Thread*)thread;
    tempThread->run();
}
int Thread::start()
{
    if(myHandle == 0)
    {
        return -1;
    }
    return thread_start(myHandle);


}

Thread::Thread(): myHandle(0), body(nullptr), arg(nullptr)
{
    if(thread_create(&myHandle, &(Thread::wrapperRun), this))
    {
        myHandle = 0;
    }
}
void PeriodicThread::wrapperPeriodicThread(void * thread)
{
    PeriodicThread* tempThread = (PeriodicThread*) thread;
    while(1)
    {
        tempThread->periodicActivation();
        time_sleep(tempThread->period);
    }
}
PeriodicThread::PeriodicThread(time_t period) : Thread(&(PeriodicThread::wrapperPeriodicThread), this),
period(period)
{

}
void PeriodicThread::terminate()
{
    if(myHandle == 0)
    {
        return;
    }
    thread_kill(myHandle);
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
int Semaphore::signal()
{
    return sem_signal(myHandle);
}

char Console::getc()
{
   return ::getc();
}

void Console::putc(char c)
{
    ::putc(c);
}