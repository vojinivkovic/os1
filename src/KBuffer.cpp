//
// Created by os on 12/15/25.
//

#include "../h/KBuffer.hpp"
KBuffer::KBuffer()
{

}

void* KBuffer::operator new(size_t size)
{
    size_t correctedSize = size + getSizeOfMetaData();
    size_t numOfBlocks = correctedSize / MEM_BLOCK_SIZE;
    numOfBlocks += correctedSize % MEM_BLOCK_SIZE ? 1 : 0;
    return MemoryAllocator::allocateMemory(numOfBlocks);
}

void KBuffer::operator delete(void* obj)
{
    MemoryAllocator::freeMemory(obj);
}


int KBuffer::append(char element)
{
    if(count == 100)
    {
        return -1;
    }
    count++;
    array[tail] = element;
    tail = (tail + 1) % 100;

    return 0;
}

char KBuffer::take()
{
    if(count == 0)
    {
        return -1;
    }

    count--;
    char tempElem = array[head];
    head = (head + 1) % 100;
    return tempElem;

}


bool KBuffer::isBufferEmpty() const
{
    if(count == 0)
    {
        return 1;
    }
    return 0;
}

bool KBuffer::isBufferFull() const
{

    if(count == 100)
    {
        return 1;
    }
    return 0;
}