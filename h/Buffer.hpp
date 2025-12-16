//
// Created by os on 12/15/25.
//

#ifndef PROJECT_BASE_V1_1_BUFFER_H
#define PROJECT_BASE_V1_1_BUFFER_H
#include "../lib/hw.h"
#include "../h/MemoryAllocator.hpp"

template<typename T, size_t numOfElements>
class Buffer {
public:
    Buffer();
    bool isBufferEmpty() const;
    bool isBufferFull() const;
    int append(T* element);
    T* take();

    static void* operator new(size_t size);
private:
    T* array[numOfElements];
    size_t head = 0, tail = 0, count = 0;
};
template<typename T, size_t numOfElements>
Buffer<T, numOfElements>::Buffer()
{
    for(size_t i = 0; i < numOfElements; i++)
    {
        array[i] = nullptr;
    }
}
template<typename T, size_t numOfElements>
void* Buffer<T, numOfElements>::operator new(size_t size)
{
    size_t numOfBlocks = size / MEM_BLOCK_SIZE;
    numOfBlocks += size % MEM_BLOCK_SIZE ? 1 : 0;
    return MemoryAllocator::allocateMemory(numOfBlocks);
}

template<typename T, size_t numOfElements>
int Buffer<T, numOfElements>::append(T *element)
{
    if(count == numOfElements)
    {
        return -1;
    }
    count++;
    array[tail] = element;
    tail = (tail + 1) % numOfElements;

    return 0;
}
template<typename T, size_t numOfElements>
T* Buffer<T, numOfElements>::take()
{
    if(count == 0)
    {
        return nullptr;
    }

    count--;
    T* tempElem = array[head];
    head = (head + 1) % numOfElements;
    return tempElem;

}

template<typename T, size_t numOfElements>
bool Buffer<T, numOfElements>::isBufferEmpty() const
{
    return count == 0;
}
template<typename T, size_t numOfElements>
bool Buffer<T, numOfElements>::isBufferFull() const
{
    return count == numOfElements;
}

#endif //PROJECT_BASE_V1_1_BUFFER_H
