//
// Created by os on 11/29/25.
//

#include "../h/MemoryAllocator.hpp"

uint8 MemoryAllocator::flagSystemInitialize = 0;
size_t MemoryAllocator::NUM_OF_BLOCKS = 0;
size_t MemoryAllocator::numOfFreeBlocks = 0;
MemoryAllocator::FreeBlock* MemoryAllocator::firstFreeBlock = nullptr;

void MemoryAllocator::initializeMemory()
{

    NUM_OF_BLOCKS = ((uint8*)HEAP_END_ADDR - (uint8*)HEAP_START_ADDR) / MEM_BLOCK_SIZE;
    numOfFreeBlocks = NUM_OF_BLOCKS;

    firstFreeBlock = (FreeBlock*)(HEAP_START_ADDR);

    firstFreeBlock->flagFree = true;
    firstFreeBlock->numOfBlocks = NUM_OF_BLOCKS;
    firstFreeBlock->nextBlock = nullptr;
    firstFreeBlock->previousBlock = nullptr;
    flagSystemInitialize = 1;
}

void* MemoryAllocator::allocateMemory(size_t blocksToAllocate)
{


    if(!flagSystemInitialize)
    {
        initializeMemory();
    }
    if(numOfFreeBlocks < blocksToAllocate)
    {
        return nullptr;
    }
    return findBestFit(&firstFreeBlock, blocksToAllocate);

}

void* MemoryAllocator::findBestFit(FreeBlock **head, size_t blocksToAllocate)
{
    FreeBlock* bestBlock = nullptr;

    for(FreeBlock* curr = (*head); curr; curr = curr->nextBlock)
    {
        if(curr->numOfBlocks > blocksToAllocate)
        {   if(bestBlock == nullptr)
            {
                bestBlock = curr;
                continue;
            }
            if(bestBlock->numOfBlocks > curr->numOfBlocks)
            {
                bestBlock = curr;
            }
        }
    }

    numOfFreeBlocks -= blocksToAllocate;
    bestBlock->numOfBlocks -= blocksToAllocate;
    remapMemory(head, bestBlock, blocksToAllocate);

    OccupiedBlock* occupiedBlock = (OccupiedBlock*)bestBlock;
    occupiedBlock->flagFree = false;
    occupiedBlock->numOfBlocks = blocksToAllocate;
    occupiedBlock++;
    return occupiedBlock;
}

void MemoryAllocator::remapMemory(FreeBlock **head, FreeBlock *allocatedBlocks, size_t blocksToAllocate)
{

    if(allocatedBlocks->numOfBlocks == 0)
    {

        if(allocatedBlocks->previousBlock)
        {
            allocatedBlocks->previousBlock->nextBlock = allocatedBlocks->nextBlock;
        }

        if(allocatedBlocks->nextBlock)
        {
            allocatedBlocks->nextBlock->previousBlock = allocatedBlocks->previousBlock;
        }

        if(*head == allocatedBlocks)
        {
            *head = allocatedBlocks->nextBlock;
        }
    }
    else
    {
        FreeBlock* newFreeBlock = (FreeBlock*)((uint8*)allocatedBlocks + blocksToAllocate * MEM_BLOCK_SIZE);
        newFreeBlock->flagFree = true;
        newFreeBlock->numOfBlocks = allocatedBlocks->numOfBlocks;

        if(allocatedBlocks->previousBlock)
        {
            allocatedBlocks->previousBlock->nextBlock = newFreeBlock;
        }

        newFreeBlock->previousBlock = allocatedBlocks->previousBlock;
        newFreeBlock->nextBlock = allocatedBlocks->nextBlock;

        if(*head == allocatedBlocks)
        {
            *head = newFreeBlock;
        }
    }

}
MemoryAllocator::FreeBlock* MemoryAllocator::findNextFreeBlock(FreeBlock* memoryToFree)
{
    for(uint8* i = (uint8*)memoryToFree; i + (((OccupiedBlock*)i)->numOfBlocks * MEM_BLOCK_SIZE) <= (uint8*)HEAP_END_ADDR; i+= (((OccupiedBlock*)i)->numOfBlocks * MEM_BLOCK_SIZE))
    {
        if(((FreeBlock*)i)->flagFree)
        {
            return (FreeBlock*)i;
        }
    }
    return nullptr;
}

MemoryAllocator::FreeBlock* MemoryAllocator::findPreviousFreeBlock(FreeBlock* head, FreeBlock* memoryToFree)
{
    FreeBlock* temp = head;
    for(; temp && temp <= memoryToFree; temp = temp->nextBlock){}
    if(!temp)
    {
        return nullptr;
    }
    return temp->previousBlock;
}
int MemoryAllocator::freeMemory(void *addressToFree)
{
    if(!addressToFree)
    {
        return -1;
    }
    OccupiedBlock* tempAddress = (OccupiedBlock*)addressToFree;
    tempAddress--;
    int numOfTakenBlocks = tempAddress->numOfBlocks;
    FreeBlock* newFreeBlock = (FreeBlock*)tempAddress;

    numOfFreeBlocks += numOfTakenBlocks;
    FreeBlock* nextFreeBlock = findNextFreeBlock(newFreeBlock);
    FreeBlock* previousFreeBlock = findPreviousFreeBlock(firstFreeBlock, newFreeBlock);

    newFreeBlock->flagFree = true;
    newFreeBlock->numOfBlocks = numOfTakenBlocks;
    newFreeBlock->nextBlock = nullptr;
    newFreeBlock->previousBlock = nullptr;

    connectAdjacentBlocks(newFreeBlock, nextFreeBlock);
    if(previousFreeBlock)
    {
        connectAdjacentBlocks(previousFreeBlock, newFreeBlock);
    }
    else
    {
        firstFreeBlock = newFreeBlock;
    }


    return 0;
}

void MemoryAllocator::connectAdjacentBlocks(FreeBlock* previousBlock, FreeBlock* adjacentBlock)
{


    if(adjacentBlock == (FreeBlock*)((uint8 *)previousBlock + previousBlock->numOfBlocks * MEM_BLOCK_SIZE))
    {

        previousBlock->numOfBlocks += adjacentBlock->numOfBlocks;
        previousBlock->nextBlock = adjacentBlock->nextBlock;
        if(adjacentBlock->previousBlock != previousBlock && adjacentBlock->previousBlock != nullptr)
        {
            previousBlock->previousBlock = adjacentBlock->previousBlock;
        }
        //previousBlock->previousBlock = (previousBlock != adjacentBlock->previousBlock ? adjacentBlock->previousBlock : previousBlock->previousBlock);

        adjacentBlock->flagFree = false;
        adjacentBlock->numOfBlocks = 0;
        adjacentBlock->nextBlock = nullptr;
        adjacentBlock->previousBlock = nullptr;

    }
    else
    {
        previousBlock->nextBlock = adjacentBlock;
        if(adjacentBlock)
        {
            adjacentBlock->previousBlock = previousBlock;
        }

    }
}

size_t  MemoryAllocator::getLargestFreeBlock()
{
    size_t largestBlock = firstFreeBlock->numOfBlocks;
    for(FreeBlock* curr = firstFreeBlock->nextBlock; curr; curr = curr->nextBlock)
    {
        if(curr->numOfBlocks > largestBlock)
        {
            largestBlock = curr->numOfBlocks;
        }
    }
    return largestBlock * MEM_BLOCK_SIZE;
}
size_t MemoryAllocator::getFreeSpace()
{
    return numOfFreeBlocks * MEM_BLOCK_SIZE;
}

size_t MemoryAllocator::getSizeOfMetaData()
{
    return sizeof(OccupiedBlock);
}