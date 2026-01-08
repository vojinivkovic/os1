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
    char array[100];
    size_t head = 0, tail = 0, count = 0;
};
//template<typename T, size_t numOfElements>
//KBuffer<T, numOfElements>::KBuffer()
//{
//    for(size_t i = 0; i < numOfElements; i++)
//    {
//        array[i] = nullptr;
//    }
//}
//template<typename T, size_t numOfElements>
//void* KBuffer<T, numOfElements>::operator new(size_t size)
//{
//    //size_t correctedSize = size + MemoryAllocator::getSizeOfMetaData();
//    size_t correctedSize = size + getSizeOfMetaData();
//    size_t numOfBlocks = correctedSize / MEM_BLOCK_SIZE;
//    numOfBlocks += correctedSize % MEM_BLOCK_SIZE ? 1 : 0;
//    return MemoryAllocator::allocateMemory(numOfBlocks);
//}
//template<typename T, size_t numOfElements>
//void KBuffer<T, numOfElements>::operator delete(void* obj)
//{
//    MemoryAllocator::freeMemory(obj);
//}
//
//template<typename T, size_t numOfElements>
//int KBuffer<T, numOfElements>::append(T *element)
//{
//    if(count == numOfElements)
//    {
//        return -1;
//    }
//    count++;
//    array[tail] = element;
//    tail = (tail + 1) % numOfElements;
//
//    return 0;
//}
//template<typename T, size_t numOfElements>
//T* KBuffer<T, numOfElements>::take()
//{
//    if(count == 0)
//    {
//        return nullptr;
//    }
//
//    count--;
//    T* tempElem = array[head];
//    head = (head + 1) % numOfElements;
//    return tempElem;
//
//}
//
//template<typename T, size_t numOfElements>
//bool KBuffer<T, numOfElements>::isBufferEmpty() const
//{
//    return count == 0;
//}
//template<typename T, size_t numOfElements>
//bool KBuffer<T, numOfElements>::isBufferFull() const
//{
//    return count == numOfElements;
//}



#endif //PROJECT_BASE_V1_1_KBuffer_H
