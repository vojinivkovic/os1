//
// Created by os on 12/15/25.
//

#ifndef PROJECT_BASE_V1_1_KBuffer_H
#define PROJECT_BASE_V1_1_KBuffer_H
#include "../lib/hw.h"
#include "../h/MemoryAllocator.hpp"
#include "../h/Config.hpp"

//template<typename T, size_t numOfElements>
class KBuffer
{
public:
    KBuffer();
    bool isBufferEmpty() const;
    bool isBufferFull() const;
    int append(char element);
    char take();

    static void* operator new(size_t size);
    static void operator delete(void* obj);
private:
    char array[KernelConfig::BUFFER_SIZE];
    size_t head = 0, tail = 0, count = 0;
};




#endif //PROJECT_BASE_V1_1_KBuffer_H
