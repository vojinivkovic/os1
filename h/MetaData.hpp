//
// Created by os on 12/26/25.
//

#ifndef PROJECT_BASE_V1_1_METADATA_H
#define PROJECT_BASE_V1_1_METADATA_H
#include "../lib/hw.h"

typedef struct FreeBlock
{
    bool flagFree;
    size_t numOfBlocks;
    FreeBlock *nextBlock;
    FreeBlock *previousBlock;
} FreeBlock;

typedef struct OccupiedBlock
{
    bool flagFree;
    size_t numOfBlocks;
} OccupiedBlock;

inline size_t getSizeOfMetaData() { return sizeof(OccupiedBlock); }

#endif //PROJECT_BASE_V1_1_METADATA_H
