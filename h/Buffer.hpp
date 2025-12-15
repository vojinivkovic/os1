//
// Created by os on 12/15/25.
//

#ifndef PROJECT_BASE_V1_1_BUFFER_H
#define PROJECT_BASE_V1_1_BUFFER_H
#include "../lib/hw.h"


template<typename T, size_t numOfObjects>
class Buffer {
public:
    Buffer() = default;
    bool isBufferEmpty() const;
    int append(T* element);
    T* take();

    static void* operator new(size_t size);
private:
    T* array[numOfObjects];
    size_t head = 0, tail = 0, count = 0;
};

template<typename T, size_t numOfObjects>
void* Buffer<T, numOfObjects>::operator new(size_t size)
{
    size_t numOfBlocks = size / MEM_BLOCK_SIZE;
    numOfBlocks += size % MEM_BLOCK_SIZE ? 1 : 0;
    return MemoryAllocator::allocateMemory(numOfBlocks);
}

template<typename T, size_t numOfObjects>
int Buffer<T, numOfObjects>::append(T *element)
{
    if(count == numOfObjects)
    {
        return -1;
    }
    count++;
    array[tail] = element;
    tail = (tail + 1) % numOfObjects;

    return 0;
}
template<typename T, size_t numOfObjects>
T* Buffer<T, numOfObjects>::take()
{
    if(count == 0)
    {
        return nullptr;
    }

    count--;
    T* tempElem = array[head];
    head = (head + 1) % numOfObjects;
    return tempElem;

}

template<typename T, size_t numOfObjects>
bool Buffer<T, numOfObjects>::isBufferEmpty() const
{
    return count == 0;
}
#endif //PROJECT_BASE_V1_1_BUFFER_H
