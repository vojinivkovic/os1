//
// Created by os on 12/1/25.
//

#ifndef PROJECT_BASE_V1_1_SYSCALL_C_H
#define PROJECT_BASE_V1_1_SYSCALL_C_H
#include "../lib/hw.h"
#include "_thread.hpp"
#include "_semaphore.hpp"


typedef _thread* thread_t;
typedef _sem* sem_t;
typedef unsigned long time_t;


void* mem_alloc(size_t size);

int mem_free(void*);

size_t mem_get_free_space();

size_t mem_get_largest_free_block();

int thread_create(thread_t* handle, void(*start_routine)(void*), void* arg);

int thread_exit();

void thread_dispatch();

int sem_open(sem_t* handle, unsigned init);

int sem_close(sem_t handle);

int sem_wait(sem_t handle);

int sem_signal(sem_t handle);

int time_sleep(time_t);

char getc();

void putc(char c);

#endif //PROJECT_BASE_V1_1_SYSCALL_C_H
