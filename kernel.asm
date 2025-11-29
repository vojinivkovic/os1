
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00004117          	auipc	sp,0x4
    80000004:	40013103          	ld	sp,1024(sp) # 80004400 <_GLOBAL_OFFSET_TABLE_+0x10>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	430010ef          	jal	ra,8000144c <start>

0000000080000020 <spin>:
    80000020:	0000006f          	j	80000020 <spin>
	...

0000000080001000 <main>:
//
// Created by os on 11/29/25.
//
#include "../h/MemoryAllocator.hpp"
void main(){
    80001000:	ff010113          	addi	sp,sp,-16
    80001004:	00113423          	sd	ra,8(sp)
    80001008:	00813023          	sd	s0,0(sp)
    8000100c:	01010413          	addi	s0,sp,16
    //void* allocMem1 = (void*)MemoryAllocator::allocateMemory(4);
    MemoryAllocator::allocateMemory(4);
    80001010:	00400513          	li	a0,4
    80001014:	00000097          	auipc	ra,0x0
    80001018:	1bc080e7          	jalr	444(ra) # 800011d0 <_ZN15MemoryAllocator14allocateMemoryEm>
    MemoryAllocator::allocateMemory(10);
    8000101c:	00a00513          	li	a0,10
    80001020:	00000097          	auipc	ra,0x0
    80001024:	1b0080e7          	jalr	432(ra) # 800011d0 <_ZN15MemoryAllocator14allocateMemoryEm>
    80001028:	00813083          	ld	ra,8(sp)
    8000102c:	00013403          	ld	s0,0(sp)
    80001030:	01010113          	addi	sp,sp,16
    80001034:	00008067          	ret

0000000080001038 <_ZN15MemoryAllocator16initializeMemoryEv>:
size_t MemoryAllocator::NUM_OF_BLOCKS = 0;
size_t MemoryAllocator::numOfFreeBlocks = 0;
MemoryAllocator::FreeBlock* MemoryAllocator::firstFreeBlock = nullptr;

void MemoryAllocator::initializeMemory()
{
    80001038:	ff010113          	addi	sp,sp,-16
    8000103c:	00813423          	sd	s0,8(sp)
    80001040:	01010413          	addi	s0,sp,16

    NUM_OF_BLOCKS = ((uint8*)HEAP_END_ADDR - (uint8*)HEAP_START_ADDR) / MEM_BLOCK_SIZE;
    80001044:	00003797          	auipc	a5,0x3
    80001048:	3c47b783          	ld	a5,964(a5) # 80004408 <_GLOBAL_OFFSET_TABLE_+0x18>
    8000104c:	0007b703          	ld	a4,0(a5)
    80001050:	00003797          	auipc	a5,0x3
    80001054:	3a87b783          	ld	a5,936(a5) # 800043f8 <_GLOBAL_OFFSET_TABLE_+0x8>
    80001058:	0007b683          	ld	a3,0(a5)
    8000105c:	40d70733          	sub	a4,a4,a3
    80001060:	00675713          	srli	a4,a4,0x6
    80001064:	00003797          	auipc	a5,0x3
    80001068:	3ec78793          	addi	a5,a5,1004 # 80004450 <_ZN15MemoryAllocator13NUM_OF_BLOCKSE>
    8000106c:	00e7b023          	sd	a4,0(a5)
    numOfFreeBlocks = NUM_OF_BLOCKS;
    80001070:	00e7b423          	sd	a4,8(a5)

    firstFreeBlock = (FreeBlock*)(HEAP_START_ADDR);
    80001074:	00d7b823          	sd	a3,16(a5)

    firstFreeBlock->flagFree = true;
    80001078:	00100613          	li	a2,1
    8000107c:	00c68023          	sb	a2,0(a3)
    firstFreeBlock->numOfBlocks = NUM_OF_BLOCKS;
    80001080:	0107b703          	ld	a4,16(a5)
    80001084:	0007b683          	ld	a3,0(a5)
    80001088:	00d73423          	sd	a3,8(a4)
    firstFreeBlock->nextBlock = nullptr;
    8000108c:	00073823          	sd	zero,16(a4)
    firstFreeBlock->previousBlock = nullptr;
    80001090:	00073c23          	sd	zero,24(a4)
    flagSystemInitialize = 1;
    80001094:	00c78c23          	sb	a2,24(a5)
}
    80001098:	00813403          	ld	s0,8(sp)
    8000109c:	01010113          	addi	sp,sp,16
    800010a0:	00008067          	ret

00000000800010a4 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m>:
    occupiedBlock++;
    return occupiedBlock;
}

void MemoryAllocator::remapMemory(FreeBlock **head, FreeBlock *allocatedBlocks, size_t blocksToAllocate)
{
    800010a4:	ff010113          	addi	sp,sp,-16
    800010a8:	00813423          	sd	s0,8(sp)
    800010ac:	01010413          	addi	s0,sp,16

    if(allocatedBlocks->numOfBlocks == 0)
    800010b0:	0085b783          	ld	a5,8(a1)
    800010b4:	04079263          	bnez	a5,800010f8 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x54>
    {

        if(allocatedBlocks->previousBlock)
    800010b8:	0185b783          	ld	a5,24(a1)
    800010bc:	00078663          	beqz	a5,800010c8 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x24>
        {
            allocatedBlocks->previousBlock->nextBlock = allocatedBlocks->nextBlock;
    800010c0:	0105b703          	ld	a4,16(a1)
    800010c4:	00e7b823          	sd	a4,16(a5)
        }

        if(allocatedBlocks->nextBlock)
    800010c8:	0105b783          	ld	a5,16(a1)
    800010cc:	00078663          	beqz	a5,800010d8 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x34>
        {
            allocatedBlocks->nextBlock->previousBlock = allocatedBlocks->previousBlock;
    800010d0:	0185b703          	ld	a4,24(a1)
    800010d4:	00e7bc23          	sd	a4,24(a5)
        }

        if(*head == allocatedBlocks)
    800010d8:	00053783          	ld	a5,0(a0) # 1000 <_entry-0x7ffff000>
    800010dc:	00b78863          	beq	a5,a1,800010ec <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x48>
        {
            *head = newFreeBlock;
        }
    }

}
    800010e0:	00813403          	ld	s0,8(sp)
    800010e4:	01010113          	addi	sp,sp,16
    800010e8:	00008067          	ret
            *head = allocatedBlocks->nextBlock;
    800010ec:	0105b783          	ld	a5,16(a1)
    800010f0:	00f53023          	sd	a5,0(a0)
    800010f4:	fedff06f          	j	800010e0 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x3c>
        FreeBlock* newFreeBlock = (FreeBlock*)((uint8*)allocatedBlocks + blocksToAllocate * MEM_BLOCK_SIZE);
    800010f8:	00661613          	slli	a2,a2,0x6
    800010fc:	00c58633          	add	a2,a1,a2
        newFreeBlock->flagFree = true;
    80001100:	00100793          	li	a5,1
    80001104:	00f60023          	sb	a5,0(a2)
        newFreeBlock->numOfBlocks = allocatedBlocks->numOfBlocks;
    80001108:	0085b783          	ld	a5,8(a1)
    8000110c:	00f63423          	sd	a5,8(a2)
        if(allocatedBlocks->previousBlock)
    80001110:	0185b783          	ld	a5,24(a1)
    80001114:	00078463          	beqz	a5,8000111c <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x78>
            allocatedBlocks->previousBlock->nextBlock = newFreeBlock;
    80001118:	00c7b823          	sd	a2,16(a5)
        newFreeBlock->nextBlock = allocatedBlocks->nextBlock;
    8000111c:	0105b783          	ld	a5,16(a1)
    80001120:	00f63823          	sd	a5,16(a2)
        if(*head == allocatedBlocks)
    80001124:	00053783          	ld	a5,0(a0)
    80001128:	fab79ce3          	bne	a5,a1,800010e0 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x3c>
            *head = newFreeBlock;
    8000112c:	00c53023          	sd	a2,0(a0)
}
    80001130:	fb1ff06f          	j	800010e0 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x3c>

0000000080001134 <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm>:
{
    80001134:	fe010113          	addi	sp,sp,-32
    80001138:	00113c23          	sd	ra,24(sp)
    8000113c:	00813823          	sd	s0,16(sp)
    80001140:	00913423          	sd	s1,8(sp)
    80001144:	01213023          	sd	s2,0(sp)
    80001148:	02010413          	addi	s0,sp,32
    8000114c:	00058493          	mv	s1,a1
    FreeBlock* bestBlock = *head;
    80001150:	00053903          	ld	s2,0(a0)
    for(FreeBlock* curr = (*head)->nextBlock; curr; curr = curr->nextBlock)
    80001154:	01093783          	ld	a5,16(s2)
    80001158:	0080006f          	j	80001160 <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm+0x2c>
    8000115c:	0107b783          	ld	a5,16(a5)
    80001160:	00078e63          	beqz	a5,8000117c <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm+0x48>
        if(curr->numOfBlocks > blocksToAllocate)
    80001164:	0087b703          	ld	a4,8(a5)
    80001168:	fee4fae3          	bgeu	s1,a4,8000115c <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm+0x28>
            if(bestBlock->numOfBlocks > curr->numOfBlocks)
    8000116c:	00893683          	ld	a3,8(s2)
    80001170:	fed776e3          	bgeu	a4,a3,8000115c <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm+0x28>
                bestBlock = curr;
    80001174:	00078913          	mv	s2,a5
    80001178:	fe5ff06f          	j	8000115c <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm+0x28>
    numOfFreeBlocks -= blocksToAllocate;
    8000117c:	00003717          	auipc	a4,0x3
    80001180:	2d470713          	addi	a4,a4,724 # 80004450 <_ZN15MemoryAllocator13NUM_OF_BLOCKSE>
    80001184:	00873783          	ld	a5,8(a4)
    80001188:	409787b3          	sub	a5,a5,s1
    8000118c:	00f73423          	sd	a5,8(a4)
    bestBlock->numOfBlocks -= blocksToAllocate;
    80001190:	00893783          	ld	a5,8(s2)
    80001194:	409787b3          	sub	a5,a5,s1
    80001198:	00f93423          	sd	a5,8(s2)
    remapMemory(head, bestBlock, blocksToAllocate);
    8000119c:	00048613          	mv	a2,s1
    800011a0:	00090593          	mv	a1,s2
    800011a4:	00000097          	auipc	ra,0x0
    800011a8:	f00080e7          	jalr	-256(ra) # 800010a4 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m>
    occupiedBlock->flagFree = false;
    800011ac:	00090023          	sb	zero,0(s2)
    occupiedBlock->numOfBlocks = blocksToAllocate;
    800011b0:	00993423          	sd	s1,8(s2)
}
    800011b4:	01090513          	addi	a0,s2,16
    800011b8:	01813083          	ld	ra,24(sp)
    800011bc:	01013403          	ld	s0,16(sp)
    800011c0:	00813483          	ld	s1,8(sp)
    800011c4:	00013903          	ld	s2,0(sp)
    800011c8:	02010113          	addi	sp,sp,32
    800011cc:	00008067          	ret

00000000800011d0 <_ZN15MemoryAllocator14allocateMemoryEm>:
{
    800011d0:	fe010113          	addi	sp,sp,-32
    800011d4:	00113c23          	sd	ra,24(sp)
    800011d8:	00813823          	sd	s0,16(sp)
    800011dc:	00913423          	sd	s1,8(sp)
    800011e0:	02010413          	addi	s0,sp,32
    800011e4:	00050493          	mv	s1,a0
    if(!flagSystemInitialize)
    800011e8:	00003797          	auipc	a5,0x3
    800011ec:	2807c783          	lbu	a5,640(a5) # 80004468 <_ZN15MemoryAllocator20flagSystemInitializeE>
    800011f0:	02078c63          	beqz	a5,80001228 <_ZN15MemoryAllocator14allocateMemoryEm+0x58>
    if(numOfFreeBlocks < blocksToAllocate)
    800011f4:	00003797          	auipc	a5,0x3
    800011f8:	2647b783          	ld	a5,612(a5) # 80004458 <_ZN15MemoryAllocator15numOfFreeBlocksE>
    800011fc:	0297ec63          	bltu	a5,s1,80001234 <_ZN15MemoryAllocator14allocateMemoryEm+0x64>
    return findBestFit(&firstFreeBlock, blocksToAllocate);
    80001200:	00048593          	mv	a1,s1
    80001204:	00003517          	auipc	a0,0x3
    80001208:	25c50513          	addi	a0,a0,604 # 80004460 <_ZN15MemoryAllocator14firstFreeBlockE>
    8000120c:	00000097          	auipc	ra,0x0
    80001210:	f28080e7          	jalr	-216(ra) # 80001134 <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm>
}
    80001214:	01813083          	ld	ra,24(sp)
    80001218:	01013403          	ld	s0,16(sp)
    8000121c:	00813483          	ld	s1,8(sp)
    80001220:	02010113          	addi	sp,sp,32
    80001224:	00008067          	ret
        initializeMemory();
    80001228:	00000097          	auipc	ra,0x0
    8000122c:	e10080e7          	jalr	-496(ra) # 80001038 <_ZN15MemoryAllocator16initializeMemoryEv>
    80001230:	fc5ff06f          	j	800011f4 <_ZN15MemoryAllocator14allocateMemoryEm+0x24>
        return nullptr;
    80001234:	00000513          	li	a0,0
    80001238:	fddff06f          	j	80001214 <_ZN15MemoryAllocator14allocateMemoryEm+0x44>

000000008000123c <_ZN15MemoryAllocator17findNextFreeBlockEPNS_9FreeBlockE>:
MemoryAllocator::FreeBlock* MemoryAllocator::findNextFreeBlock(FreeBlock* memoryToFree)
{
    8000123c:	ff010113          	addi	sp,sp,-16
    80001240:	00813423          	sd	s0,8(sp)
    80001244:	01010413          	addi	s0,sp,16
    80001248:	00050793          	mv	a5,a0
    for(uint8* i = (uint8*)memoryToFree; i + MEM_BLOCK_SIZE <= (uint8*)HEAP_END_ADDR; i+= MEM_BLOCK_SIZE)
    8000124c:	00078513          	mv	a0,a5
    80001250:	04078793          	addi	a5,a5,64
    80001254:	00003717          	auipc	a4,0x3
    80001258:	1b473703          	ld	a4,436(a4) # 80004408 <_GLOBAL_OFFSET_TABLE_+0x18>
    8000125c:	00073703          	ld	a4,0(a4)
    80001260:	00f76863          	bltu	a4,a5,80001270 <_ZN15MemoryAllocator17findNextFreeBlockEPNS_9FreeBlockE+0x34>
    {
        if(((FreeBlock*)i)->flagFree)
    80001264:	00054703          	lbu	a4,0(a0)
    80001268:	fe0702e3          	beqz	a4,8000124c <_ZN15MemoryAllocator17findNextFreeBlockEPNS_9FreeBlockE+0x10>
    8000126c:	0080006f          	j	80001274 <_ZN15MemoryAllocator17findNextFreeBlockEPNS_9FreeBlockE+0x38>
        {
            return (FreeBlock*)i;
        }
    }
    return nullptr;
    80001270:	00000513          	li	a0,0
}
    80001274:	00813403          	ld	s0,8(sp)
    80001278:	01010113          	addi	sp,sp,16
    8000127c:	00008067          	ret

0000000080001280 <_ZN15MemoryAllocator21findPreviousFreeBlockEPNS_9FreeBlockES1_>:

MemoryAllocator::FreeBlock* MemoryAllocator::findPreviousFreeBlock(FreeBlock* head, FreeBlock* memoryToFree)
{
    80001280:	ff010113          	addi	sp,sp,-16
    80001284:	00813423          	sd	s0,8(sp)
    80001288:	01010413          	addi	s0,sp,16
    FreeBlock* temp = head;
    for(; temp && temp <= memoryToFree; temp = temp->nextBlock){}
    8000128c:	00050863          	beqz	a0,8000129c <_ZN15MemoryAllocator21findPreviousFreeBlockEPNS_9FreeBlockES1_+0x1c>
    80001290:	00a5e663          	bltu	a1,a0,8000129c <_ZN15MemoryAllocator21findPreviousFreeBlockEPNS_9FreeBlockES1_+0x1c>
    80001294:	01053503          	ld	a0,16(a0)
    80001298:	ff5ff06f          	j	8000128c <_ZN15MemoryAllocator21findPreviousFreeBlockEPNS_9FreeBlockES1_+0xc>
    return temp;
}
    8000129c:	00813403          	ld	s0,8(sp)
    800012a0:	01010113          	addi	sp,sp,16
    800012a4:	00008067          	ret

00000000800012a8 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_>:

    return 0;
}

void MemoryAllocator::connectAdjacentBlocks(FreeBlock* previousBlock, FreeBlock* adjacentBlock)
{
    800012a8:	ff010113          	addi	sp,sp,-16
    800012ac:	00813423          	sd	s0,8(sp)
    800012b0:	01010413          	addi	s0,sp,16


    if(adjacentBlock == (FreeBlock*)((uint8 *)previousBlock + previousBlock->numOfBlocks * MEM_BLOCK_SIZE))
    800012b4:	00853703          	ld	a4,8(a0)
    800012b8:	00671793          	slli	a5,a4,0x6
    800012bc:	00f507b3          	add	a5,a0,a5
    800012c0:	00b78e63          	beq	a5,a1,800012dc <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_+0x34>
        previousBlock->nextBlock = adjacentBlock->nextBlock;
        previousBlock->previousBlock = adjacentBlock->previousBlock;
    }
    else
    {
        previousBlock->nextBlock = adjacentBlock;
    800012c4:	00b53823          	sd	a1,16(a0)
        if(adjacentBlock)
    800012c8:	00058463          	beqz	a1,800012d0 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_+0x28>
        {
            adjacentBlock->previousBlock = previousBlock;
    800012cc:	00a5bc23          	sd	a0,24(a1)
        }

    }
}
    800012d0:	00813403          	ld	s0,8(sp)
    800012d4:	01010113          	addi	sp,sp,16
    800012d8:	00008067          	ret
        previousBlock->numOfBlocks += adjacentBlock->numOfBlocks;
    800012dc:	0085b783          	ld	a5,8(a1)
    800012e0:	00f70733          	add	a4,a4,a5
    800012e4:	00e53423          	sd	a4,8(a0)
        previousBlock->nextBlock = adjacentBlock->nextBlock;
    800012e8:	0105b783          	ld	a5,16(a1)
    800012ec:	00f53823          	sd	a5,16(a0)
        previousBlock->previousBlock = adjacentBlock->previousBlock;
    800012f0:	0185b783          	ld	a5,24(a1)
    800012f4:	00f53c23          	sd	a5,24(a0)
    800012f8:	fd9ff06f          	j	800012d0 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_+0x28>

00000000800012fc <_ZN15MemoryAllocator10freeMemoryEPv>:
    if(!addressToFree)
    800012fc:	0c050e63          	beqz	a0,800013d8 <_ZN15MemoryAllocator10freeMemoryEPv+0xdc>
{
    80001300:	fc010113          	addi	sp,sp,-64
    80001304:	02113c23          	sd	ra,56(sp)
    80001308:	02813823          	sd	s0,48(sp)
    8000130c:	02913423          	sd	s1,40(sp)
    80001310:	03213023          	sd	s2,32(sp)
    80001314:	01313c23          	sd	s3,24(sp)
    80001318:	01413823          	sd	s4,16(sp)
    8000131c:	01513423          	sd	s5,8(sp)
    80001320:	04010413          	addi	s0,sp,64
    80001324:	00050493          	mv	s1,a0
    tempAddress--;
    80001328:	ff050913          	addi	s2,a0,-16
    int numOfTakenBlocks = tempAddress->numOfBlocks;
    8000132c:	ff852a83          	lw	s5,-8(a0)
    numOfFreeBlocks += numOfTakenBlocks;
    80001330:	00003997          	auipc	s3,0x3
    80001334:	12098993          	addi	s3,s3,288 # 80004450 <_ZN15MemoryAllocator13NUM_OF_BLOCKSE>
    80001338:	0089b783          	ld	a5,8(s3)
    8000133c:	015787b3          	add	a5,a5,s5
    80001340:	00f9b423          	sd	a5,8(s3)
    FreeBlock* nextFreeBlock = findNextFreeBlock(newFreeBlock);
    80001344:	00090513          	mv	a0,s2
    80001348:	00000097          	auipc	ra,0x0
    8000134c:	ef4080e7          	jalr	-268(ra) # 8000123c <_ZN15MemoryAllocator17findNextFreeBlockEPNS_9FreeBlockE>
    80001350:	00050a13          	mv	s4,a0
    FreeBlock* previousFreeBlock = findPreviousFreeBlock(firstFreeBlock, newFreeBlock);
    80001354:	00090593          	mv	a1,s2
    80001358:	0109b503          	ld	a0,16(s3)
    8000135c:	00000097          	auipc	ra,0x0
    80001360:	f24080e7          	jalr	-220(ra) # 80001280 <_ZN15MemoryAllocator21findPreviousFreeBlockEPNS_9FreeBlockES1_>
    80001364:	00050993          	mv	s3,a0
    newFreeBlock->flagFree = true;
    80001368:	00100793          	li	a5,1
    8000136c:	fef48823          	sb	a5,-16(s1)
    newFreeBlock->numOfBlocks = numOfTakenBlocks;
    80001370:	ff54bc23          	sd	s5,-8(s1)
    newFreeBlock->nextBlock = nullptr;
    80001374:	0004b023          	sd	zero,0(s1)
    newFreeBlock->previousBlock = nullptr;
    80001378:	0004b423          	sd	zero,8(s1)
    connectAdjacentBlocks(newFreeBlock, nextFreeBlock);
    8000137c:	000a0593          	mv	a1,s4
    80001380:	00090513          	mv	a0,s2
    80001384:	00000097          	auipc	ra,0x0
    80001388:	f24080e7          	jalr	-220(ra) # 800012a8 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_>
    if(previousFreeBlock)
    8000138c:	02098e63          	beqz	s3,800013c8 <_ZN15MemoryAllocator10freeMemoryEPv+0xcc>
        connectAdjacentBlocks(previousFreeBlock, newFreeBlock);
    80001390:	00090593          	mv	a1,s2
    80001394:	00098513          	mv	a0,s3
    80001398:	00000097          	auipc	ra,0x0
    8000139c:	f10080e7          	jalr	-240(ra) # 800012a8 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_>
    return 0;
    800013a0:	00000513          	li	a0,0
}
    800013a4:	03813083          	ld	ra,56(sp)
    800013a8:	03013403          	ld	s0,48(sp)
    800013ac:	02813483          	ld	s1,40(sp)
    800013b0:	02013903          	ld	s2,32(sp)
    800013b4:	01813983          	ld	s3,24(sp)
    800013b8:	01013a03          	ld	s4,16(sp)
    800013bc:	00813a83          	ld	s5,8(sp)
    800013c0:	04010113          	addi	sp,sp,64
    800013c4:	00008067          	ret
        firstFreeBlock = newFreeBlock;
    800013c8:	00003797          	auipc	a5,0x3
    800013cc:	0927bc23          	sd	s2,152(a5) # 80004460 <_ZN15MemoryAllocator14firstFreeBlockE>
    return 0;
    800013d0:	00000513          	li	a0,0
    800013d4:	fd1ff06f          	j	800013a4 <_ZN15MemoryAllocator10freeMemoryEPv+0xa8>
        return -1;
    800013d8:	fff00513          	li	a0,-1
}
    800013dc:	00008067          	ret

00000000800013e0 <_ZN15MemoryAllocator19getLargestFreeBlockEv>:

size_t  MemoryAllocator::getLargestFreeBlock()
{
    800013e0:	ff010113          	addi	sp,sp,-16
    800013e4:	00813423          	sd	s0,8(sp)
    800013e8:	01010413          	addi	s0,sp,16
    size_t largestBlock = firstFreeBlock->numOfBlocks;
    800013ec:	00003797          	auipc	a5,0x3
    800013f0:	0747b783          	ld	a5,116(a5) # 80004460 <_ZN15MemoryAllocator14firstFreeBlockE>
    800013f4:	0087b503          	ld	a0,8(a5)
    for(FreeBlock* curr = firstFreeBlock->nextBlock; curr; curr = curr->nextBlock)
    800013f8:	0107b783          	ld	a5,16(a5)
    800013fc:	0080006f          	j	80001404 <_ZN15MemoryAllocator19getLargestFreeBlockEv+0x24>
    80001400:	0107b783          	ld	a5,16(a5)
    80001404:	00078a63          	beqz	a5,80001418 <_ZN15MemoryAllocator19getLargestFreeBlockEv+0x38>
    {
        if(curr->numOfBlocks > largestBlock)
    80001408:	0087b703          	ld	a4,8(a5)
    8000140c:	fee57ae3          	bgeu	a0,a4,80001400 <_ZN15MemoryAllocator19getLargestFreeBlockEv+0x20>
        {
            largestBlock = curr->numOfBlocks;
    80001410:	00070513          	mv	a0,a4
    80001414:	fedff06f          	j	80001400 <_ZN15MemoryAllocator19getLargestFreeBlockEv+0x20>
        }
    }
    return largestBlock * MEM_BLOCK_SIZE;
}
    80001418:	00651513          	slli	a0,a0,0x6
    8000141c:	00813403          	ld	s0,8(sp)
    80001420:	01010113          	addi	sp,sp,16
    80001424:	00008067          	ret

0000000080001428 <_ZN15MemoryAllocator12getFreeSpaceEv>:
size_t MemoryAllocator::getFreeSpace()
{
    80001428:	ff010113          	addi	sp,sp,-16
    8000142c:	00813423          	sd	s0,8(sp)
    80001430:	01010413          	addi	s0,sp,16
    return numOfFreeBlocks * MEM_BLOCK_SIZE;
}
    80001434:	00003517          	auipc	a0,0x3
    80001438:	02453503          	ld	a0,36(a0) # 80004458 <_ZN15MemoryAllocator15numOfFreeBlocksE>
    8000143c:	00651513          	slli	a0,a0,0x6
    80001440:	00813403          	ld	s0,8(sp)
    80001444:	01010113          	addi	sp,sp,16
    80001448:	00008067          	ret

000000008000144c <start>:
    8000144c:	ff010113          	addi	sp,sp,-16
    80001450:	00813423          	sd	s0,8(sp)
    80001454:	01010413          	addi	s0,sp,16
    80001458:	300027f3          	csrr	a5,mstatus
    8000145c:	ffffe737          	lui	a4,0xffffe
    80001460:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff913f>
    80001464:	00e7f7b3          	and	a5,a5,a4
    80001468:	00001737          	lui	a4,0x1
    8000146c:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80001470:	00e7e7b3          	or	a5,a5,a4
    80001474:	30079073          	csrw	mstatus,a5
    80001478:	00000797          	auipc	a5,0x0
    8000147c:	16078793          	addi	a5,a5,352 # 800015d8 <system_main>
    80001480:	34179073          	csrw	mepc,a5
    80001484:	00000793          	li	a5,0
    80001488:	18079073          	csrw	satp,a5
    8000148c:	000107b7          	lui	a5,0x10
    80001490:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80001494:	30279073          	csrw	medeleg,a5
    80001498:	30379073          	csrw	mideleg,a5
    8000149c:	104027f3          	csrr	a5,sie
    800014a0:	2227e793          	ori	a5,a5,546
    800014a4:	10479073          	csrw	sie,a5
    800014a8:	fff00793          	li	a5,-1
    800014ac:	00a7d793          	srli	a5,a5,0xa
    800014b0:	3b079073          	csrw	pmpaddr0,a5
    800014b4:	00f00793          	li	a5,15
    800014b8:	3a079073          	csrw	pmpcfg0,a5
    800014bc:	f14027f3          	csrr	a5,mhartid
    800014c0:	0200c737          	lui	a4,0x200c
    800014c4:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800014c8:	0007869b          	sext.w	a3,a5
    800014cc:	00269713          	slli	a4,a3,0x2
    800014d0:	000f4637          	lui	a2,0xf4
    800014d4:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800014d8:	00d70733          	add	a4,a4,a3
    800014dc:	0037979b          	slliw	a5,a5,0x3
    800014e0:	020046b7          	lui	a3,0x2004
    800014e4:	00d787b3          	add	a5,a5,a3
    800014e8:	00c585b3          	add	a1,a1,a2
    800014ec:	00371693          	slli	a3,a4,0x3
    800014f0:	00003717          	auipc	a4,0x3
    800014f4:	f8070713          	addi	a4,a4,-128 # 80004470 <timer_scratch>
    800014f8:	00b7b023          	sd	a1,0(a5)
    800014fc:	00d70733          	add	a4,a4,a3
    80001500:	00f73c23          	sd	a5,24(a4)
    80001504:	02c73023          	sd	a2,32(a4)
    80001508:	34071073          	csrw	mscratch,a4
    8000150c:	00000797          	auipc	a5,0x0
    80001510:	6e478793          	addi	a5,a5,1764 # 80001bf0 <timervec>
    80001514:	30579073          	csrw	mtvec,a5
    80001518:	300027f3          	csrr	a5,mstatus
    8000151c:	0087e793          	ori	a5,a5,8
    80001520:	30079073          	csrw	mstatus,a5
    80001524:	304027f3          	csrr	a5,mie
    80001528:	0807e793          	ori	a5,a5,128
    8000152c:	30479073          	csrw	mie,a5
    80001530:	f14027f3          	csrr	a5,mhartid
    80001534:	0007879b          	sext.w	a5,a5
    80001538:	00078213          	mv	tp,a5
    8000153c:	30200073          	mret
    80001540:	00813403          	ld	s0,8(sp)
    80001544:	01010113          	addi	sp,sp,16
    80001548:	00008067          	ret

000000008000154c <timerinit>:
    8000154c:	ff010113          	addi	sp,sp,-16
    80001550:	00813423          	sd	s0,8(sp)
    80001554:	01010413          	addi	s0,sp,16
    80001558:	f14027f3          	csrr	a5,mhartid
    8000155c:	0200c737          	lui	a4,0x200c
    80001560:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80001564:	0007869b          	sext.w	a3,a5
    80001568:	00269713          	slli	a4,a3,0x2
    8000156c:	000f4637          	lui	a2,0xf4
    80001570:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80001574:	00d70733          	add	a4,a4,a3
    80001578:	0037979b          	slliw	a5,a5,0x3
    8000157c:	020046b7          	lui	a3,0x2004
    80001580:	00d787b3          	add	a5,a5,a3
    80001584:	00c585b3          	add	a1,a1,a2
    80001588:	00371693          	slli	a3,a4,0x3
    8000158c:	00003717          	auipc	a4,0x3
    80001590:	ee470713          	addi	a4,a4,-284 # 80004470 <timer_scratch>
    80001594:	00b7b023          	sd	a1,0(a5)
    80001598:	00d70733          	add	a4,a4,a3
    8000159c:	00f73c23          	sd	a5,24(a4)
    800015a0:	02c73023          	sd	a2,32(a4)
    800015a4:	34071073          	csrw	mscratch,a4
    800015a8:	00000797          	auipc	a5,0x0
    800015ac:	64878793          	addi	a5,a5,1608 # 80001bf0 <timervec>
    800015b0:	30579073          	csrw	mtvec,a5
    800015b4:	300027f3          	csrr	a5,mstatus
    800015b8:	0087e793          	ori	a5,a5,8
    800015bc:	30079073          	csrw	mstatus,a5
    800015c0:	304027f3          	csrr	a5,mie
    800015c4:	0807e793          	ori	a5,a5,128
    800015c8:	30479073          	csrw	mie,a5
    800015cc:	00813403          	ld	s0,8(sp)
    800015d0:	01010113          	addi	sp,sp,16
    800015d4:	00008067          	ret

00000000800015d8 <system_main>:
    800015d8:	fe010113          	addi	sp,sp,-32
    800015dc:	00813823          	sd	s0,16(sp)
    800015e0:	00913423          	sd	s1,8(sp)
    800015e4:	00113c23          	sd	ra,24(sp)
    800015e8:	02010413          	addi	s0,sp,32
    800015ec:	00000097          	auipc	ra,0x0
    800015f0:	0c4080e7          	jalr	196(ra) # 800016b0 <cpuid>
    800015f4:	00003497          	auipc	s1,0x3
    800015f8:	e2c48493          	addi	s1,s1,-468 # 80004420 <started>
    800015fc:	02050263          	beqz	a0,80001620 <system_main+0x48>
    80001600:	0004a783          	lw	a5,0(s1)
    80001604:	0007879b          	sext.w	a5,a5
    80001608:	fe078ce3          	beqz	a5,80001600 <system_main+0x28>
    8000160c:	0ff0000f          	fence
    80001610:	00003517          	auipc	a0,0x3
    80001614:	a4050513          	addi	a0,a0,-1472 # 80004050 <CONSOLE_STATUS+0x40>
    80001618:	00001097          	auipc	ra,0x1
    8000161c:	a74080e7          	jalr	-1420(ra) # 8000208c <panic>
    80001620:	00001097          	auipc	ra,0x1
    80001624:	9c8080e7          	jalr	-1592(ra) # 80001fe8 <consoleinit>
    80001628:	00001097          	auipc	ra,0x1
    8000162c:	154080e7          	jalr	340(ra) # 8000277c <printfinit>
    80001630:	00003517          	auipc	a0,0x3
    80001634:	b0050513          	addi	a0,a0,-1280 # 80004130 <CONSOLE_STATUS+0x120>
    80001638:	00001097          	auipc	ra,0x1
    8000163c:	ab0080e7          	jalr	-1360(ra) # 800020e8 <__printf>
    80001640:	00003517          	auipc	a0,0x3
    80001644:	9e050513          	addi	a0,a0,-1568 # 80004020 <CONSOLE_STATUS+0x10>
    80001648:	00001097          	auipc	ra,0x1
    8000164c:	aa0080e7          	jalr	-1376(ra) # 800020e8 <__printf>
    80001650:	00003517          	auipc	a0,0x3
    80001654:	ae050513          	addi	a0,a0,-1312 # 80004130 <CONSOLE_STATUS+0x120>
    80001658:	00001097          	auipc	ra,0x1
    8000165c:	a90080e7          	jalr	-1392(ra) # 800020e8 <__printf>
    80001660:	00001097          	auipc	ra,0x1
    80001664:	4a8080e7          	jalr	1192(ra) # 80002b08 <kinit>
    80001668:	00000097          	auipc	ra,0x0
    8000166c:	148080e7          	jalr	328(ra) # 800017b0 <trapinit>
    80001670:	00000097          	auipc	ra,0x0
    80001674:	16c080e7          	jalr	364(ra) # 800017dc <trapinithart>
    80001678:	00000097          	auipc	ra,0x0
    8000167c:	5b8080e7          	jalr	1464(ra) # 80001c30 <plicinit>
    80001680:	00000097          	auipc	ra,0x0
    80001684:	5d8080e7          	jalr	1496(ra) # 80001c58 <plicinithart>
    80001688:	00000097          	auipc	ra,0x0
    8000168c:	078080e7          	jalr	120(ra) # 80001700 <userinit>
    80001690:	0ff0000f          	fence
    80001694:	00100793          	li	a5,1
    80001698:	00003517          	auipc	a0,0x3
    8000169c:	9a050513          	addi	a0,a0,-1632 # 80004038 <CONSOLE_STATUS+0x28>
    800016a0:	00f4a023          	sw	a5,0(s1)
    800016a4:	00001097          	auipc	ra,0x1
    800016a8:	a44080e7          	jalr	-1468(ra) # 800020e8 <__printf>
    800016ac:	0000006f          	j	800016ac <system_main+0xd4>

00000000800016b0 <cpuid>:
    800016b0:	ff010113          	addi	sp,sp,-16
    800016b4:	00813423          	sd	s0,8(sp)
    800016b8:	01010413          	addi	s0,sp,16
    800016bc:	00020513          	mv	a0,tp
    800016c0:	00813403          	ld	s0,8(sp)
    800016c4:	0005051b          	sext.w	a0,a0
    800016c8:	01010113          	addi	sp,sp,16
    800016cc:	00008067          	ret

00000000800016d0 <mycpu>:
    800016d0:	ff010113          	addi	sp,sp,-16
    800016d4:	00813423          	sd	s0,8(sp)
    800016d8:	01010413          	addi	s0,sp,16
    800016dc:	00020793          	mv	a5,tp
    800016e0:	00813403          	ld	s0,8(sp)
    800016e4:	0007879b          	sext.w	a5,a5
    800016e8:	00779793          	slli	a5,a5,0x7
    800016ec:	00004517          	auipc	a0,0x4
    800016f0:	db450513          	addi	a0,a0,-588 # 800054a0 <cpus>
    800016f4:	00f50533          	add	a0,a0,a5
    800016f8:	01010113          	addi	sp,sp,16
    800016fc:	00008067          	ret

0000000080001700 <userinit>:
    80001700:	ff010113          	addi	sp,sp,-16
    80001704:	00813423          	sd	s0,8(sp)
    80001708:	01010413          	addi	s0,sp,16
    8000170c:	00813403          	ld	s0,8(sp)
    80001710:	01010113          	addi	sp,sp,16
    80001714:	00000317          	auipc	t1,0x0
    80001718:	8ec30067          	jr	-1812(t1) # 80001000 <main>

000000008000171c <either_copyout>:
    8000171c:	ff010113          	addi	sp,sp,-16
    80001720:	00813023          	sd	s0,0(sp)
    80001724:	00113423          	sd	ra,8(sp)
    80001728:	01010413          	addi	s0,sp,16
    8000172c:	02051663          	bnez	a0,80001758 <either_copyout+0x3c>
    80001730:	00058513          	mv	a0,a1
    80001734:	00060593          	mv	a1,a2
    80001738:	0006861b          	sext.w	a2,a3
    8000173c:	00002097          	auipc	ra,0x2
    80001740:	c58080e7          	jalr	-936(ra) # 80003394 <__memmove>
    80001744:	00813083          	ld	ra,8(sp)
    80001748:	00013403          	ld	s0,0(sp)
    8000174c:	00000513          	li	a0,0
    80001750:	01010113          	addi	sp,sp,16
    80001754:	00008067          	ret
    80001758:	00003517          	auipc	a0,0x3
    8000175c:	92050513          	addi	a0,a0,-1760 # 80004078 <CONSOLE_STATUS+0x68>
    80001760:	00001097          	auipc	ra,0x1
    80001764:	92c080e7          	jalr	-1748(ra) # 8000208c <panic>

0000000080001768 <either_copyin>:
    80001768:	ff010113          	addi	sp,sp,-16
    8000176c:	00813023          	sd	s0,0(sp)
    80001770:	00113423          	sd	ra,8(sp)
    80001774:	01010413          	addi	s0,sp,16
    80001778:	02059463          	bnez	a1,800017a0 <either_copyin+0x38>
    8000177c:	00060593          	mv	a1,a2
    80001780:	0006861b          	sext.w	a2,a3
    80001784:	00002097          	auipc	ra,0x2
    80001788:	c10080e7          	jalr	-1008(ra) # 80003394 <__memmove>
    8000178c:	00813083          	ld	ra,8(sp)
    80001790:	00013403          	ld	s0,0(sp)
    80001794:	00000513          	li	a0,0
    80001798:	01010113          	addi	sp,sp,16
    8000179c:	00008067          	ret
    800017a0:	00003517          	auipc	a0,0x3
    800017a4:	90050513          	addi	a0,a0,-1792 # 800040a0 <CONSOLE_STATUS+0x90>
    800017a8:	00001097          	auipc	ra,0x1
    800017ac:	8e4080e7          	jalr	-1820(ra) # 8000208c <panic>

00000000800017b0 <trapinit>:
    800017b0:	ff010113          	addi	sp,sp,-16
    800017b4:	00813423          	sd	s0,8(sp)
    800017b8:	01010413          	addi	s0,sp,16
    800017bc:	00813403          	ld	s0,8(sp)
    800017c0:	00003597          	auipc	a1,0x3
    800017c4:	90858593          	addi	a1,a1,-1784 # 800040c8 <CONSOLE_STATUS+0xb8>
    800017c8:	00004517          	auipc	a0,0x4
    800017cc:	d5850513          	addi	a0,a0,-680 # 80005520 <tickslock>
    800017d0:	01010113          	addi	sp,sp,16
    800017d4:	00001317          	auipc	t1,0x1
    800017d8:	5c430067          	jr	1476(t1) # 80002d98 <initlock>

00000000800017dc <trapinithart>:
    800017dc:	ff010113          	addi	sp,sp,-16
    800017e0:	00813423          	sd	s0,8(sp)
    800017e4:	01010413          	addi	s0,sp,16
    800017e8:	00000797          	auipc	a5,0x0
    800017ec:	2f878793          	addi	a5,a5,760 # 80001ae0 <kernelvec>
    800017f0:	10579073          	csrw	stvec,a5
    800017f4:	00813403          	ld	s0,8(sp)
    800017f8:	01010113          	addi	sp,sp,16
    800017fc:	00008067          	ret

0000000080001800 <usertrap>:
    80001800:	ff010113          	addi	sp,sp,-16
    80001804:	00813423          	sd	s0,8(sp)
    80001808:	01010413          	addi	s0,sp,16
    8000180c:	00813403          	ld	s0,8(sp)
    80001810:	01010113          	addi	sp,sp,16
    80001814:	00008067          	ret

0000000080001818 <usertrapret>:
    80001818:	ff010113          	addi	sp,sp,-16
    8000181c:	00813423          	sd	s0,8(sp)
    80001820:	01010413          	addi	s0,sp,16
    80001824:	00813403          	ld	s0,8(sp)
    80001828:	01010113          	addi	sp,sp,16
    8000182c:	00008067          	ret

0000000080001830 <kerneltrap>:
    80001830:	fe010113          	addi	sp,sp,-32
    80001834:	00813823          	sd	s0,16(sp)
    80001838:	00113c23          	sd	ra,24(sp)
    8000183c:	00913423          	sd	s1,8(sp)
    80001840:	02010413          	addi	s0,sp,32
    80001844:	142025f3          	csrr	a1,scause
    80001848:	100027f3          	csrr	a5,sstatus
    8000184c:	0027f793          	andi	a5,a5,2
    80001850:	10079c63          	bnez	a5,80001968 <kerneltrap+0x138>
    80001854:	142027f3          	csrr	a5,scause
    80001858:	0207ce63          	bltz	a5,80001894 <kerneltrap+0x64>
    8000185c:	00003517          	auipc	a0,0x3
    80001860:	8b450513          	addi	a0,a0,-1868 # 80004110 <CONSOLE_STATUS+0x100>
    80001864:	00001097          	auipc	ra,0x1
    80001868:	884080e7          	jalr	-1916(ra) # 800020e8 <__printf>
    8000186c:	141025f3          	csrr	a1,sepc
    80001870:	14302673          	csrr	a2,stval
    80001874:	00003517          	auipc	a0,0x3
    80001878:	8ac50513          	addi	a0,a0,-1876 # 80004120 <CONSOLE_STATUS+0x110>
    8000187c:	00001097          	auipc	ra,0x1
    80001880:	86c080e7          	jalr	-1940(ra) # 800020e8 <__printf>
    80001884:	00003517          	auipc	a0,0x3
    80001888:	8b450513          	addi	a0,a0,-1868 # 80004138 <CONSOLE_STATUS+0x128>
    8000188c:	00001097          	auipc	ra,0x1
    80001890:	800080e7          	jalr	-2048(ra) # 8000208c <panic>
    80001894:	0ff7f713          	andi	a4,a5,255
    80001898:	00900693          	li	a3,9
    8000189c:	04d70063          	beq	a4,a3,800018dc <kerneltrap+0xac>
    800018a0:	fff00713          	li	a4,-1
    800018a4:	03f71713          	slli	a4,a4,0x3f
    800018a8:	00170713          	addi	a4,a4,1
    800018ac:	fae798e3          	bne	a5,a4,8000185c <kerneltrap+0x2c>
    800018b0:	00000097          	auipc	ra,0x0
    800018b4:	e00080e7          	jalr	-512(ra) # 800016b0 <cpuid>
    800018b8:	06050663          	beqz	a0,80001924 <kerneltrap+0xf4>
    800018bc:	144027f3          	csrr	a5,sip
    800018c0:	ffd7f793          	andi	a5,a5,-3
    800018c4:	14479073          	csrw	sip,a5
    800018c8:	01813083          	ld	ra,24(sp)
    800018cc:	01013403          	ld	s0,16(sp)
    800018d0:	00813483          	ld	s1,8(sp)
    800018d4:	02010113          	addi	sp,sp,32
    800018d8:	00008067          	ret
    800018dc:	00000097          	auipc	ra,0x0
    800018e0:	3c8080e7          	jalr	968(ra) # 80001ca4 <plic_claim>
    800018e4:	00a00793          	li	a5,10
    800018e8:	00050493          	mv	s1,a0
    800018ec:	06f50863          	beq	a0,a5,8000195c <kerneltrap+0x12c>
    800018f0:	fc050ce3          	beqz	a0,800018c8 <kerneltrap+0x98>
    800018f4:	00050593          	mv	a1,a0
    800018f8:	00002517          	auipc	a0,0x2
    800018fc:	7f850513          	addi	a0,a0,2040 # 800040f0 <CONSOLE_STATUS+0xe0>
    80001900:	00000097          	auipc	ra,0x0
    80001904:	7e8080e7          	jalr	2024(ra) # 800020e8 <__printf>
    80001908:	01013403          	ld	s0,16(sp)
    8000190c:	01813083          	ld	ra,24(sp)
    80001910:	00048513          	mv	a0,s1
    80001914:	00813483          	ld	s1,8(sp)
    80001918:	02010113          	addi	sp,sp,32
    8000191c:	00000317          	auipc	t1,0x0
    80001920:	3c030067          	jr	960(t1) # 80001cdc <plic_complete>
    80001924:	00004517          	auipc	a0,0x4
    80001928:	bfc50513          	addi	a0,a0,-1028 # 80005520 <tickslock>
    8000192c:	00001097          	auipc	ra,0x1
    80001930:	490080e7          	jalr	1168(ra) # 80002dbc <acquire>
    80001934:	00003717          	auipc	a4,0x3
    80001938:	af070713          	addi	a4,a4,-1296 # 80004424 <ticks>
    8000193c:	00072783          	lw	a5,0(a4)
    80001940:	00004517          	auipc	a0,0x4
    80001944:	be050513          	addi	a0,a0,-1056 # 80005520 <tickslock>
    80001948:	0017879b          	addiw	a5,a5,1
    8000194c:	00f72023          	sw	a5,0(a4)
    80001950:	00001097          	auipc	ra,0x1
    80001954:	538080e7          	jalr	1336(ra) # 80002e88 <release>
    80001958:	f65ff06f          	j	800018bc <kerneltrap+0x8c>
    8000195c:	00001097          	auipc	ra,0x1
    80001960:	094080e7          	jalr	148(ra) # 800029f0 <uartintr>
    80001964:	fa5ff06f          	j	80001908 <kerneltrap+0xd8>
    80001968:	00002517          	auipc	a0,0x2
    8000196c:	76850513          	addi	a0,a0,1896 # 800040d0 <CONSOLE_STATUS+0xc0>
    80001970:	00000097          	auipc	ra,0x0
    80001974:	71c080e7          	jalr	1820(ra) # 8000208c <panic>

0000000080001978 <clockintr>:
    80001978:	fe010113          	addi	sp,sp,-32
    8000197c:	00813823          	sd	s0,16(sp)
    80001980:	00913423          	sd	s1,8(sp)
    80001984:	00113c23          	sd	ra,24(sp)
    80001988:	02010413          	addi	s0,sp,32
    8000198c:	00004497          	auipc	s1,0x4
    80001990:	b9448493          	addi	s1,s1,-1132 # 80005520 <tickslock>
    80001994:	00048513          	mv	a0,s1
    80001998:	00001097          	auipc	ra,0x1
    8000199c:	424080e7          	jalr	1060(ra) # 80002dbc <acquire>
    800019a0:	00003717          	auipc	a4,0x3
    800019a4:	a8470713          	addi	a4,a4,-1404 # 80004424 <ticks>
    800019a8:	00072783          	lw	a5,0(a4)
    800019ac:	01013403          	ld	s0,16(sp)
    800019b0:	01813083          	ld	ra,24(sp)
    800019b4:	00048513          	mv	a0,s1
    800019b8:	0017879b          	addiw	a5,a5,1
    800019bc:	00813483          	ld	s1,8(sp)
    800019c0:	00f72023          	sw	a5,0(a4)
    800019c4:	02010113          	addi	sp,sp,32
    800019c8:	00001317          	auipc	t1,0x1
    800019cc:	4c030067          	jr	1216(t1) # 80002e88 <release>

00000000800019d0 <devintr>:
    800019d0:	142027f3          	csrr	a5,scause
    800019d4:	00000513          	li	a0,0
    800019d8:	0007c463          	bltz	a5,800019e0 <devintr+0x10>
    800019dc:	00008067          	ret
    800019e0:	fe010113          	addi	sp,sp,-32
    800019e4:	00813823          	sd	s0,16(sp)
    800019e8:	00113c23          	sd	ra,24(sp)
    800019ec:	00913423          	sd	s1,8(sp)
    800019f0:	02010413          	addi	s0,sp,32
    800019f4:	0ff7f713          	andi	a4,a5,255
    800019f8:	00900693          	li	a3,9
    800019fc:	04d70c63          	beq	a4,a3,80001a54 <devintr+0x84>
    80001a00:	fff00713          	li	a4,-1
    80001a04:	03f71713          	slli	a4,a4,0x3f
    80001a08:	00170713          	addi	a4,a4,1
    80001a0c:	00e78c63          	beq	a5,a4,80001a24 <devintr+0x54>
    80001a10:	01813083          	ld	ra,24(sp)
    80001a14:	01013403          	ld	s0,16(sp)
    80001a18:	00813483          	ld	s1,8(sp)
    80001a1c:	02010113          	addi	sp,sp,32
    80001a20:	00008067          	ret
    80001a24:	00000097          	auipc	ra,0x0
    80001a28:	c8c080e7          	jalr	-884(ra) # 800016b0 <cpuid>
    80001a2c:	06050663          	beqz	a0,80001a98 <devintr+0xc8>
    80001a30:	144027f3          	csrr	a5,sip
    80001a34:	ffd7f793          	andi	a5,a5,-3
    80001a38:	14479073          	csrw	sip,a5
    80001a3c:	01813083          	ld	ra,24(sp)
    80001a40:	01013403          	ld	s0,16(sp)
    80001a44:	00813483          	ld	s1,8(sp)
    80001a48:	00200513          	li	a0,2
    80001a4c:	02010113          	addi	sp,sp,32
    80001a50:	00008067          	ret
    80001a54:	00000097          	auipc	ra,0x0
    80001a58:	250080e7          	jalr	592(ra) # 80001ca4 <plic_claim>
    80001a5c:	00a00793          	li	a5,10
    80001a60:	00050493          	mv	s1,a0
    80001a64:	06f50663          	beq	a0,a5,80001ad0 <devintr+0x100>
    80001a68:	00100513          	li	a0,1
    80001a6c:	fa0482e3          	beqz	s1,80001a10 <devintr+0x40>
    80001a70:	00048593          	mv	a1,s1
    80001a74:	00002517          	auipc	a0,0x2
    80001a78:	67c50513          	addi	a0,a0,1660 # 800040f0 <CONSOLE_STATUS+0xe0>
    80001a7c:	00000097          	auipc	ra,0x0
    80001a80:	66c080e7          	jalr	1644(ra) # 800020e8 <__printf>
    80001a84:	00048513          	mv	a0,s1
    80001a88:	00000097          	auipc	ra,0x0
    80001a8c:	254080e7          	jalr	596(ra) # 80001cdc <plic_complete>
    80001a90:	00100513          	li	a0,1
    80001a94:	f7dff06f          	j	80001a10 <devintr+0x40>
    80001a98:	00004517          	auipc	a0,0x4
    80001a9c:	a8850513          	addi	a0,a0,-1400 # 80005520 <tickslock>
    80001aa0:	00001097          	auipc	ra,0x1
    80001aa4:	31c080e7          	jalr	796(ra) # 80002dbc <acquire>
    80001aa8:	00003717          	auipc	a4,0x3
    80001aac:	97c70713          	addi	a4,a4,-1668 # 80004424 <ticks>
    80001ab0:	00072783          	lw	a5,0(a4)
    80001ab4:	00004517          	auipc	a0,0x4
    80001ab8:	a6c50513          	addi	a0,a0,-1428 # 80005520 <tickslock>
    80001abc:	0017879b          	addiw	a5,a5,1
    80001ac0:	00f72023          	sw	a5,0(a4)
    80001ac4:	00001097          	auipc	ra,0x1
    80001ac8:	3c4080e7          	jalr	964(ra) # 80002e88 <release>
    80001acc:	f65ff06f          	j	80001a30 <devintr+0x60>
    80001ad0:	00001097          	auipc	ra,0x1
    80001ad4:	f20080e7          	jalr	-224(ra) # 800029f0 <uartintr>
    80001ad8:	fadff06f          	j	80001a84 <devintr+0xb4>
    80001adc:	0000                	unimp
	...

0000000080001ae0 <kernelvec>:
    80001ae0:	f0010113          	addi	sp,sp,-256
    80001ae4:	00113023          	sd	ra,0(sp)
    80001ae8:	00213423          	sd	sp,8(sp)
    80001aec:	00313823          	sd	gp,16(sp)
    80001af0:	00413c23          	sd	tp,24(sp)
    80001af4:	02513023          	sd	t0,32(sp)
    80001af8:	02613423          	sd	t1,40(sp)
    80001afc:	02713823          	sd	t2,48(sp)
    80001b00:	02813c23          	sd	s0,56(sp)
    80001b04:	04913023          	sd	s1,64(sp)
    80001b08:	04a13423          	sd	a0,72(sp)
    80001b0c:	04b13823          	sd	a1,80(sp)
    80001b10:	04c13c23          	sd	a2,88(sp)
    80001b14:	06d13023          	sd	a3,96(sp)
    80001b18:	06e13423          	sd	a4,104(sp)
    80001b1c:	06f13823          	sd	a5,112(sp)
    80001b20:	07013c23          	sd	a6,120(sp)
    80001b24:	09113023          	sd	a7,128(sp)
    80001b28:	09213423          	sd	s2,136(sp)
    80001b2c:	09313823          	sd	s3,144(sp)
    80001b30:	09413c23          	sd	s4,152(sp)
    80001b34:	0b513023          	sd	s5,160(sp)
    80001b38:	0b613423          	sd	s6,168(sp)
    80001b3c:	0b713823          	sd	s7,176(sp)
    80001b40:	0b813c23          	sd	s8,184(sp)
    80001b44:	0d913023          	sd	s9,192(sp)
    80001b48:	0da13423          	sd	s10,200(sp)
    80001b4c:	0db13823          	sd	s11,208(sp)
    80001b50:	0dc13c23          	sd	t3,216(sp)
    80001b54:	0fd13023          	sd	t4,224(sp)
    80001b58:	0fe13423          	sd	t5,232(sp)
    80001b5c:	0ff13823          	sd	t6,240(sp)
    80001b60:	cd1ff0ef          	jal	ra,80001830 <kerneltrap>
    80001b64:	00013083          	ld	ra,0(sp)
    80001b68:	00813103          	ld	sp,8(sp)
    80001b6c:	01013183          	ld	gp,16(sp)
    80001b70:	02013283          	ld	t0,32(sp)
    80001b74:	02813303          	ld	t1,40(sp)
    80001b78:	03013383          	ld	t2,48(sp)
    80001b7c:	03813403          	ld	s0,56(sp)
    80001b80:	04013483          	ld	s1,64(sp)
    80001b84:	04813503          	ld	a0,72(sp)
    80001b88:	05013583          	ld	a1,80(sp)
    80001b8c:	05813603          	ld	a2,88(sp)
    80001b90:	06013683          	ld	a3,96(sp)
    80001b94:	06813703          	ld	a4,104(sp)
    80001b98:	07013783          	ld	a5,112(sp)
    80001b9c:	07813803          	ld	a6,120(sp)
    80001ba0:	08013883          	ld	a7,128(sp)
    80001ba4:	08813903          	ld	s2,136(sp)
    80001ba8:	09013983          	ld	s3,144(sp)
    80001bac:	09813a03          	ld	s4,152(sp)
    80001bb0:	0a013a83          	ld	s5,160(sp)
    80001bb4:	0a813b03          	ld	s6,168(sp)
    80001bb8:	0b013b83          	ld	s7,176(sp)
    80001bbc:	0b813c03          	ld	s8,184(sp)
    80001bc0:	0c013c83          	ld	s9,192(sp)
    80001bc4:	0c813d03          	ld	s10,200(sp)
    80001bc8:	0d013d83          	ld	s11,208(sp)
    80001bcc:	0d813e03          	ld	t3,216(sp)
    80001bd0:	0e013e83          	ld	t4,224(sp)
    80001bd4:	0e813f03          	ld	t5,232(sp)
    80001bd8:	0f013f83          	ld	t6,240(sp)
    80001bdc:	10010113          	addi	sp,sp,256
    80001be0:	10200073          	sret
    80001be4:	00000013          	nop
    80001be8:	00000013          	nop
    80001bec:	00000013          	nop

0000000080001bf0 <timervec>:
    80001bf0:	34051573          	csrrw	a0,mscratch,a0
    80001bf4:	00b53023          	sd	a1,0(a0)
    80001bf8:	00c53423          	sd	a2,8(a0)
    80001bfc:	00d53823          	sd	a3,16(a0)
    80001c00:	01853583          	ld	a1,24(a0)
    80001c04:	02053603          	ld	a2,32(a0)
    80001c08:	0005b683          	ld	a3,0(a1)
    80001c0c:	00c686b3          	add	a3,a3,a2
    80001c10:	00d5b023          	sd	a3,0(a1)
    80001c14:	00200593          	li	a1,2
    80001c18:	14459073          	csrw	sip,a1
    80001c1c:	01053683          	ld	a3,16(a0)
    80001c20:	00853603          	ld	a2,8(a0)
    80001c24:	00053583          	ld	a1,0(a0)
    80001c28:	34051573          	csrrw	a0,mscratch,a0
    80001c2c:	30200073          	mret

0000000080001c30 <plicinit>:
    80001c30:	ff010113          	addi	sp,sp,-16
    80001c34:	00813423          	sd	s0,8(sp)
    80001c38:	01010413          	addi	s0,sp,16
    80001c3c:	00813403          	ld	s0,8(sp)
    80001c40:	0c0007b7          	lui	a5,0xc000
    80001c44:	00100713          	li	a4,1
    80001c48:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    80001c4c:	00e7a223          	sw	a4,4(a5)
    80001c50:	01010113          	addi	sp,sp,16
    80001c54:	00008067          	ret

0000000080001c58 <plicinithart>:
    80001c58:	ff010113          	addi	sp,sp,-16
    80001c5c:	00813023          	sd	s0,0(sp)
    80001c60:	00113423          	sd	ra,8(sp)
    80001c64:	01010413          	addi	s0,sp,16
    80001c68:	00000097          	auipc	ra,0x0
    80001c6c:	a48080e7          	jalr	-1464(ra) # 800016b0 <cpuid>
    80001c70:	0085171b          	slliw	a4,a0,0x8
    80001c74:	0c0027b7          	lui	a5,0xc002
    80001c78:	00e787b3          	add	a5,a5,a4
    80001c7c:	40200713          	li	a4,1026
    80001c80:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80001c84:	00813083          	ld	ra,8(sp)
    80001c88:	00013403          	ld	s0,0(sp)
    80001c8c:	00d5151b          	slliw	a0,a0,0xd
    80001c90:	0c2017b7          	lui	a5,0xc201
    80001c94:	00a78533          	add	a0,a5,a0
    80001c98:	00052023          	sw	zero,0(a0)
    80001c9c:	01010113          	addi	sp,sp,16
    80001ca0:	00008067          	ret

0000000080001ca4 <plic_claim>:
    80001ca4:	ff010113          	addi	sp,sp,-16
    80001ca8:	00813023          	sd	s0,0(sp)
    80001cac:	00113423          	sd	ra,8(sp)
    80001cb0:	01010413          	addi	s0,sp,16
    80001cb4:	00000097          	auipc	ra,0x0
    80001cb8:	9fc080e7          	jalr	-1540(ra) # 800016b0 <cpuid>
    80001cbc:	00813083          	ld	ra,8(sp)
    80001cc0:	00013403          	ld	s0,0(sp)
    80001cc4:	00d5151b          	slliw	a0,a0,0xd
    80001cc8:	0c2017b7          	lui	a5,0xc201
    80001ccc:	00a78533          	add	a0,a5,a0
    80001cd0:	00452503          	lw	a0,4(a0)
    80001cd4:	01010113          	addi	sp,sp,16
    80001cd8:	00008067          	ret

0000000080001cdc <plic_complete>:
    80001cdc:	fe010113          	addi	sp,sp,-32
    80001ce0:	00813823          	sd	s0,16(sp)
    80001ce4:	00913423          	sd	s1,8(sp)
    80001ce8:	00113c23          	sd	ra,24(sp)
    80001cec:	02010413          	addi	s0,sp,32
    80001cf0:	00050493          	mv	s1,a0
    80001cf4:	00000097          	auipc	ra,0x0
    80001cf8:	9bc080e7          	jalr	-1604(ra) # 800016b0 <cpuid>
    80001cfc:	01813083          	ld	ra,24(sp)
    80001d00:	01013403          	ld	s0,16(sp)
    80001d04:	00d5179b          	slliw	a5,a0,0xd
    80001d08:	0c201737          	lui	a4,0xc201
    80001d0c:	00f707b3          	add	a5,a4,a5
    80001d10:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80001d14:	00813483          	ld	s1,8(sp)
    80001d18:	02010113          	addi	sp,sp,32
    80001d1c:	00008067          	ret

0000000080001d20 <consolewrite>:
    80001d20:	fb010113          	addi	sp,sp,-80
    80001d24:	04813023          	sd	s0,64(sp)
    80001d28:	04113423          	sd	ra,72(sp)
    80001d2c:	02913c23          	sd	s1,56(sp)
    80001d30:	03213823          	sd	s2,48(sp)
    80001d34:	03313423          	sd	s3,40(sp)
    80001d38:	03413023          	sd	s4,32(sp)
    80001d3c:	01513c23          	sd	s5,24(sp)
    80001d40:	05010413          	addi	s0,sp,80
    80001d44:	06c05c63          	blez	a2,80001dbc <consolewrite+0x9c>
    80001d48:	00060993          	mv	s3,a2
    80001d4c:	00050a13          	mv	s4,a0
    80001d50:	00058493          	mv	s1,a1
    80001d54:	00000913          	li	s2,0
    80001d58:	fff00a93          	li	s5,-1
    80001d5c:	01c0006f          	j	80001d78 <consolewrite+0x58>
    80001d60:	fbf44503          	lbu	a0,-65(s0)
    80001d64:	0019091b          	addiw	s2,s2,1
    80001d68:	00148493          	addi	s1,s1,1
    80001d6c:	00001097          	auipc	ra,0x1
    80001d70:	a9c080e7          	jalr	-1380(ra) # 80002808 <uartputc>
    80001d74:	03298063          	beq	s3,s2,80001d94 <consolewrite+0x74>
    80001d78:	00048613          	mv	a2,s1
    80001d7c:	00100693          	li	a3,1
    80001d80:	000a0593          	mv	a1,s4
    80001d84:	fbf40513          	addi	a0,s0,-65
    80001d88:	00000097          	auipc	ra,0x0
    80001d8c:	9e0080e7          	jalr	-1568(ra) # 80001768 <either_copyin>
    80001d90:	fd5518e3          	bne	a0,s5,80001d60 <consolewrite+0x40>
    80001d94:	04813083          	ld	ra,72(sp)
    80001d98:	04013403          	ld	s0,64(sp)
    80001d9c:	03813483          	ld	s1,56(sp)
    80001da0:	02813983          	ld	s3,40(sp)
    80001da4:	02013a03          	ld	s4,32(sp)
    80001da8:	01813a83          	ld	s5,24(sp)
    80001dac:	00090513          	mv	a0,s2
    80001db0:	03013903          	ld	s2,48(sp)
    80001db4:	05010113          	addi	sp,sp,80
    80001db8:	00008067          	ret
    80001dbc:	00000913          	li	s2,0
    80001dc0:	fd5ff06f          	j	80001d94 <consolewrite+0x74>

0000000080001dc4 <consoleread>:
    80001dc4:	f9010113          	addi	sp,sp,-112
    80001dc8:	06813023          	sd	s0,96(sp)
    80001dcc:	04913c23          	sd	s1,88(sp)
    80001dd0:	05213823          	sd	s2,80(sp)
    80001dd4:	05313423          	sd	s3,72(sp)
    80001dd8:	05413023          	sd	s4,64(sp)
    80001ddc:	03513c23          	sd	s5,56(sp)
    80001de0:	03613823          	sd	s6,48(sp)
    80001de4:	03713423          	sd	s7,40(sp)
    80001de8:	03813023          	sd	s8,32(sp)
    80001dec:	06113423          	sd	ra,104(sp)
    80001df0:	01913c23          	sd	s9,24(sp)
    80001df4:	07010413          	addi	s0,sp,112
    80001df8:	00060b93          	mv	s7,a2
    80001dfc:	00050913          	mv	s2,a0
    80001e00:	00058c13          	mv	s8,a1
    80001e04:	00060b1b          	sext.w	s6,a2
    80001e08:	00003497          	auipc	s1,0x3
    80001e0c:	73048493          	addi	s1,s1,1840 # 80005538 <cons>
    80001e10:	00400993          	li	s3,4
    80001e14:	fff00a13          	li	s4,-1
    80001e18:	00a00a93          	li	s5,10
    80001e1c:	05705e63          	blez	s7,80001e78 <consoleread+0xb4>
    80001e20:	09c4a703          	lw	a4,156(s1)
    80001e24:	0984a783          	lw	a5,152(s1)
    80001e28:	0007071b          	sext.w	a4,a4
    80001e2c:	08e78463          	beq	a5,a4,80001eb4 <consoleread+0xf0>
    80001e30:	07f7f713          	andi	a4,a5,127
    80001e34:	00e48733          	add	a4,s1,a4
    80001e38:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    80001e3c:	0017869b          	addiw	a3,a5,1
    80001e40:	08d4ac23          	sw	a3,152(s1)
    80001e44:	00070c9b          	sext.w	s9,a4
    80001e48:	0b370663          	beq	a4,s3,80001ef4 <consoleread+0x130>
    80001e4c:	00100693          	li	a3,1
    80001e50:	f9f40613          	addi	a2,s0,-97
    80001e54:	000c0593          	mv	a1,s8
    80001e58:	00090513          	mv	a0,s2
    80001e5c:	f8e40fa3          	sb	a4,-97(s0)
    80001e60:	00000097          	auipc	ra,0x0
    80001e64:	8bc080e7          	jalr	-1860(ra) # 8000171c <either_copyout>
    80001e68:	01450863          	beq	a0,s4,80001e78 <consoleread+0xb4>
    80001e6c:	001c0c13          	addi	s8,s8,1
    80001e70:	fffb8b9b          	addiw	s7,s7,-1
    80001e74:	fb5c94e3          	bne	s9,s5,80001e1c <consoleread+0x58>
    80001e78:	000b851b          	sext.w	a0,s7
    80001e7c:	06813083          	ld	ra,104(sp)
    80001e80:	06013403          	ld	s0,96(sp)
    80001e84:	05813483          	ld	s1,88(sp)
    80001e88:	05013903          	ld	s2,80(sp)
    80001e8c:	04813983          	ld	s3,72(sp)
    80001e90:	04013a03          	ld	s4,64(sp)
    80001e94:	03813a83          	ld	s5,56(sp)
    80001e98:	02813b83          	ld	s7,40(sp)
    80001e9c:	02013c03          	ld	s8,32(sp)
    80001ea0:	01813c83          	ld	s9,24(sp)
    80001ea4:	40ab053b          	subw	a0,s6,a0
    80001ea8:	03013b03          	ld	s6,48(sp)
    80001eac:	07010113          	addi	sp,sp,112
    80001eb0:	00008067          	ret
    80001eb4:	00001097          	auipc	ra,0x1
    80001eb8:	1d8080e7          	jalr	472(ra) # 8000308c <push_on>
    80001ebc:	0984a703          	lw	a4,152(s1)
    80001ec0:	09c4a783          	lw	a5,156(s1)
    80001ec4:	0007879b          	sext.w	a5,a5
    80001ec8:	fef70ce3          	beq	a4,a5,80001ec0 <consoleread+0xfc>
    80001ecc:	00001097          	auipc	ra,0x1
    80001ed0:	234080e7          	jalr	564(ra) # 80003100 <pop_on>
    80001ed4:	0984a783          	lw	a5,152(s1)
    80001ed8:	07f7f713          	andi	a4,a5,127
    80001edc:	00e48733          	add	a4,s1,a4
    80001ee0:	01874703          	lbu	a4,24(a4)
    80001ee4:	0017869b          	addiw	a3,a5,1
    80001ee8:	08d4ac23          	sw	a3,152(s1)
    80001eec:	00070c9b          	sext.w	s9,a4
    80001ef0:	f5371ee3          	bne	a4,s3,80001e4c <consoleread+0x88>
    80001ef4:	000b851b          	sext.w	a0,s7
    80001ef8:	f96bf2e3          	bgeu	s7,s6,80001e7c <consoleread+0xb8>
    80001efc:	08f4ac23          	sw	a5,152(s1)
    80001f00:	f7dff06f          	j	80001e7c <consoleread+0xb8>

0000000080001f04 <consputc>:
    80001f04:	10000793          	li	a5,256
    80001f08:	00f50663          	beq	a0,a5,80001f14 <consputc+0x10>
    80001f0c:	00001317          	auipc	t1,0x1
    80001f10:	9f430067          	jr	-1548(t1) # 80002900 <uartputc_sync>
    80001f14:	ff010113          	addi	sp,sp,-16
    80001f18:	00113423          	sd	ra,8(sp)
    80001f1c:	00813023          	sd	s0,0(sp)
    80001f20:	01010413          	addi	s0,sp,16
    80001f24:	00800513          	li	a0,8
    80001f28:	00001097          	auipc	ra,0x1
    80001f2c:	9d8080e7          	jalr	-1576(ra) # 80002900 <uartputc_sync>
    80001f30:	02000513          	li	a0,32
    80001f34:	00001097          	auipc	ra,0x1
    80001f38:	9cc080e7          	jalr	-1588(ra) # 80002900 <uartputc_sync>
    80001f3c:	00013403          	ld	s0,0(sp)
    80001f40:	00813083          	ld	ra,8(sp)
    80001f44:	00800513          	li	a0,8
    80001f48:	01010113          	addi	sp,sp,16
    80001f4c:	00001317          	auipc	t1,0x1
    80001f50:	9b430067          	jr	-1612(t1) # 80002900 <uartputc_sync>

0000000080001f54 <consoleintr>:
    80001f54:	fe010113          	addi	sp,sp,-32
    80001f58:	00813823          	sd	s0,16(sp)
    80001f5c:	00913423          	sd	s1,8(sp)
    80001f60:	01213023          	sd	s2,0(sp)
    80001f64:	00113c23          	sd	ra,24(sp)
    80001f68:	02010413          	addi	s0,sp,32
    80001f6c:	00003917          	auipc	s2,0x3
    80001f70:	5cc90913          	addi	s2,s2,1484 # 80005538 <cons>
    80001f74:	00050493          	mv	s1,a0
    80001f78:	00090513          	mv	a0,s2
    80001f7c:	00001097          	auipc	ra,0x1
    80001f80:	e40080e7          	jalr	-448(ra) # 80002dbc <acquire>
    80001f84:	02048c63          	beqz	s1,80001fbc <consoleintr+0x68>
    80001f88:	0a092783          	lw	a5,160(s2)
    80001f8c:	09892703          	lw	a4,152(s2)
    80001f90:	07f00693          	li	a3,127
    80001f94:	40e7873b          	subw	a4,a5,a4
    80001f98:	02e6e263          	bltu	a3,a4,80001fbc <consoleintr+0x68>
    80001f9c:	00d00713          	li	a4,13
    80001fa0:	04e48063          	beq	s1,a4,80001fe0 <consoleintr+0x8c>
    80001fa4:	07f7f713          	andi	a4,a5,127
    80001fa8:	00e90733          	add	a4,s2,a4
    80001fac:	0017879b          	addiw	a5,a5,1
    80001fb0:	0af92023          	sw	a5,160(s2)
    80001fb4:	00970c23          	sb	s1,24(a4)
    80001fb8:	08f92e23          	sw	a5,156(s2)
    80001fbc:	01013403          	ld	s0,16(sp)
    80001fc0:	01813083          	ld	ra,24(sp)
    80001fc4:	00813483          	ld	s1,8(sp)
    80001fc8:	00013903          	ld	s2,0(sp)
    80001fcc:	00003517          	auipc	a0,0x3
    80001fd0:	56c50513          	addi	a0,a0,1388 # 80005538 <cons>
    80001fd4:	02010113          	addi	sp,sp,32
    80001fd8:	00001317          	auipc	t1,0x1
    80001fdc:	eb030067          	jr	-336(t1) # 80002e88 <release>
    80001fe0:	00a00493          	li	s1,10
    80001fe4:	fc1ff06f          	j	80001fa4 <consoleintr+0x50>

0000000080001fe8 <consoleinit>:
    80001fe8:	fe010113          	addi	sp,sp,-32
    80001fec:	00113c23          	sd	ra,24(sp)
    80001ff0:	00813823          	sd	s0,16(sp)
    80001ff4:	00913423          	sd	s1,8(sp)
    80001ff8:	02010413          	addi	s0,sp,32
    80001ffc:	00003497          	auipc	s1,0x3
    80002000:	53c48493          	addi	s1,s1,1340 # 80005538 <cons>
    80002004:	00048513          	mv	a0,s1
    80002008:	00002597          	auipc	a1,0x2
    8000200c:	14058593          	addi	a1,a1,320 # 80004148 <CONSOLE_STATUS+0x138>
    80002010:	00001097          	auipc	ra,0x1
    80002014:	d88080e7          	jalr	-632(ra) # 80002d98 <initlock>
    80002018:	00000097          	auipc	ra,0x0
    8000201c:	7ac080e7          	jalr	1964(ra) # 800027c4 <uartinit>
    80002020:	01813083          	ld	ra,24(sp)
    80002024:	01013403          	ld	s0,16(sp)
    80002028:	00000797          	auipc	a5,0x0
    8000202c:	d9c78793          	addi	a5,a5,-612 # 80001dc4 <consoleread>
    80002030:	0af4bc23          	sd	a5,184(s1)
    80002034:	00000797          	auipc	a5,0x0
    80002038:	cec78793          	addi	a5,a5,-788 # 80001d20 <consolewrite>
    8000203c:	0cf4b023          	sd	a5,192(s1)
    80002040:	00813483          	ld	s1,8(sp)
    80002044:	02010113          	addi	sp,sp,32
    80002048:	00008067          	ret

000000008000204c <console_read>:
    8000204c:	ff010113          	addi	sp,sp,-16
    80002050:	00813423          	sd	s0,8(sp)
    80002054:	01010413          	addi	s0,sp,16
    80002058:	00813403          	ld	s0,8(sp)
    8000205c:	00003317          	auipc	t1,0x3
    80002060:	59433303          	ld	t1,1428(t1) # 800055f0 <devsw+0x10>
    80002064:	01010113          	addi	sp,sp,16
    80002068:	00030067          	jr	t1

000000008000206c <console_write>:
    8000206c:	ff010113          	addi	sp,sp,-16
    80002070:	00813423          	sd	s0,8(sp)
    80002074:	01010413          	addi	s0,sp,16
    80002078:	00813403          	ld	s0,8(sp)
    8000207c:	00003317          	auipc	t1,0x3
    80002080:	57c33303          	ld	t1,1404(t1) # 800055f8 <devsw+0x18>
    80002084:	01010113          	addi	sp,sp,16
    80002088:	00030067          	jr	t1

000000008000208c <panic>:
    8000208c:	fe010113          	addi	sp,sp,-32
    80002090:	00113c23          	sd	ra,24(sp)
    80002094:	00813823          	sd	s0,16(sp)
    80002098:	00913423          	sd	s1,8(sp)
    8000209c:	02010413          	addi	s0,sp,32
    800020a0:	00050493          	mv	s1,a0
    800020a4:	00002517          	auipc	a0,0x2
    800020a8:	0ac50513          	addi	a0,a0,172 # 80004150 <CONSOLE_STATUS+0x140>
    800020ac:	00003797          	auipc	a5,0x3
    800020b0:	5e07a623          	sw	zero,1516(a5) # 80005698 <pr+0x18>
    800020b4:	00000097          	auipc	ra,0x0
    800020b8:	034080e7          	jalr	52(ra) # 800020e8 <__printf>
    800020bc:	00048513          	mv	a0,s1
    800020c0:	00000097          	auipc	ra,0x0
    800020c4:	028080e7          	jalr	40(ra) # 800020e8 <__printf>
    800020c8:	00002517          	auipc	a0,0x2
    800020cc:	06850513          	addi	a0,a0,104 # 80004130 <CONSOLE_STATUS+0x120>
    800020d0:	00000097          	auipc	ra,0x0
    800020d4:	018080e7          	jalr	24(ra) # 800020e8 <__printf>
    800020d8:	00100793          	li	a5,1
    800020dc:	00002717          	auipc	a4,0x2
    800020e0:	34f72623          	sw	a5,844(a4) # 80004428 <panicked>
    800020e4:	0000006f          	j	800020e4 <panic+0x58>

00000000800020e8 <__printf>:
    800020e8:	f3010113          	addi	sp,sp,-208
    800020ec:	08813023          	sd	s0,128(sp)
    800020f0:	07313423          	sd	s3,104(sp)
    800020f4:	09010413          	addi	s0,sp,144
    800020f8:	05813023          	sd	s8,64(sp)
    800020fc:	08113423          	sd	ra,136(sp)
    80002100:	06913c23          	sd	s1,120(sp)
    80002104:	07213823          	sd	s2,112(sp)
    80002108:	07413023          	sd	s4,96(sp)
    8000210c:	05513c23          	sd	s5,88(sp)
    80002110:	05613823          	sd	s6,80(sp)
    80002114:	05713423          	sd	s7,72(sp)
    80002118:	03913c23          	sd	s9,56(sp)
    8000211c:	03a13823          	sd	s10,48(sp)
    80002120:	03b13423          	sd	s11,40(sp)
    80002124:	00003317          	auipc	t1,0x3
    80002128:	55c30313          	addi	t1,t1,1372 # 80005680 <pr>
    8000212c:	01832c03          	lw	s8,24(t1)
    80002130:	00b43423          	sd	a1,8(s0)
    80002134:	00c43823          	sd	a2,16(s0)
    80002138:	00d43c23          	sd	a3,24(s0)
    8000213c:	02e43023          	sd	a4,32(s0)
    80002140:	02f43423          	sd	a5,40(s0)
    80002144:	03043823          	sd	a6,48(s0)
    80002148:	03143c23          	sd	a7,56(s0)
    8000214c:	00050993          	mv	s3,a0
    80002150:	4a0c1663          	bnez	s8,800025fc <__printf+0x514>
    80002154:	60098c63          	beqz	s3,8000276c <__printf+0x684>
    80002158:	0009c503          	lbu	a0,0(s3)
    8000215c:	00840793          	addi	a5,s0,8
    80002160:	f6f43c23          	sd	a5,-136(s0)
    80002164:	00000493          	li	s1,0
    80002168:	22050063          	beqz	a0,80002388 <__printf+0x2a0>
    8000216c:	00002a37          	lui	s4,0x2
    80002170:	00018ab7          	lui	s5,0x18
    80002174:	000f4b37          	lui	s6,0xf4
    80002178:	00989bb7          	lui	s7,0x989
    8000217c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80002180:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80002184:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80002188:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    8000218c:	00148c9b          	addiw	s9,s1,1
    80002190:	02500793          	li	a5,37
    80002194:	01998933          	add	s2,s3,s9
    80002198:	38f51263          	bne	a0,a5,8000251c <__printf+0x434>
    8000219c:	00094783          	lbu	a5,0(s2)
    800021a0:	00078c9b          	sext.w	s9,a5
    800021a4:	1e078263          	beqz	a5,80002388 <__printf+0x2a0>
    800021a8:	0024849b          	addiw	s1,s1,2
    800021ac:	07000713          	li	a4,112
    800021b0:	00998933          	add	s2,s3,s1
    800021b4:	38e78a63          	beq	a5,a4,80002548 <__printf+0x460>
    800021b8:	20f76863          	bltu	a4,a5,800023c8 <__printf+0x2e0>
    800021bc:	42a78863          	beq	a5,a0,800025ec <__printf+0x504>
    800021c0:	06400713          	li	a4,100
    800021c4:	40e79663          	bne	a5,a4,800025d0 <__printf+0x4e8>
    800021c8:	f7843783          	ld	a5,-136(s0)
    800021cc:	0007a603          	lw	a2,0(a5)
    800021d0:	00878793          	addi	a5,a5,8
    800021d4:	f6f43c23          	sd	a5,-136(s0)
    800021d8:	42064a63          	bltz	a2,8000260c <__printf+0x524>
    800021dc:	00a00713          	li	a4,10
    800021e0:	02e677bb          	remuw	a5,a2,a4
    800021e4:	00002d97          	auipc	s11,0x2
    800021e8:	f94d8d93          	addi	s11,s11,-108 # 80004178 <digits>
    800021ec:	00900593          	li	a1,9
    800021f0:	0006051b          	sext.w	a0,a2
    800021f4:	00000c93          	li	s9,0
    800021f8:	02079793          	slli	a5,a5,0x20
    800021fc:	0207d793          	srli	a5,a5,0x20
    80002200:	00fd87b3          	add	a5,s11,a5
    80002204:	0007c783          	lbu	a5,0(a5)
    80002208:	02e656bb          	divuw	a3,a2,a4
    8000220c:	f8f40023          	sb	a5,-128(s0)
    80002210:	14c5d863          	bge	a1,a2,80002360 <__printf+0x278>
    80002214:	06300593          	li	a1,99
    80002218:	00100c93          	li	s9,1
    8000221c:	02e6f7bb          	remuw	a5,a3,a4
    80002220:	02079793          	slli	a5,a5,0x20
    80002224:	0207d793          	srli	a5,a5,0x20
    80002228:	00fd87b3          	add	a5,s11,a5
    8000222c:	0007c783          	lbu	a5,0(a5)
    80002230:	02e6d73b          	divuw	a4,a3,a4
    80002234:	f8f400a3          	sb	a5,-127(s0)
    80002238:	12a5f463          	bgeu	a1,a0,80002360 <__printf+0x278>
    8000223c:	00a00693          	li	a3,10
    80002240:	00900593          	li	a1,9
    80002244:	02d777bb          	remuw	a5,a4,a3
    80002248:	02079793          	slli	a5,a5,0x20
    8000224c:	0207d793          	srli	a5,a5,0x20
    80002250:	00fd87b3          	add	a5,s11,a5
    80002254:	0007c503          	lbu	a0,0(a5)
    80002258:	02d757bb          	divuw	a5,a4,a3
    8000225c:	f8a40123          	sb	a0,-126(s0)
    80002260:	48e5f263          	bgeu	a1,a4,800026e4 <__printf+0x5fc>
    80002264:	06300513          	li	a0,99
    80002268:	02d7f5bb          	remuw	a1,a5,a3
    8000226c:	02059593          	slli	a1,a1,0x20
    80002270:	0205d593          	srli	a1,a1,0x20
    80002274:	00bd85b3          	add	a1,s11,a1
    80002278:	0005c583          	lbu	a1,0(a1)
    8000227c:	02d7d7bb          	divuw	a5,a5,a3
    80002280:	f8b401a3          	sb	a1,-125(s0)
    80002284:	48e57263          	bgeu	a0,a4,80002708 <__printf+0x620>
    80002288:	3e700513          	li	a0,999
    8000228c:	02d7f5bb          	remuw	a1,a5,a3
    80002290:	02059593          	slli	a1,a1,0x20
    80002294:	0205d593          	srli	a1,a1,0x20
    80002298:	00bd85b3          	add	a1,s11,a1
    8000229c:	0005c583          	lbu	a1,0(a1)
    800022a0:	02d7d7bb          	divuw	a5,a5,a3
    800022a4:	f8b40223          	sb	a1,-124(s0)
    800022a8:	46e57663          	bgeu	a0,a4,80002714 <__printf+0x62c>
    800022ac:	02d7f5bb          	remuw	a1,a5,a3
    800022b0:	02059593          	slli	a1,a1,0x20
    800022b4:	0205d593          	srli	a1,a1,0x20
    800022b8:	00bd85b3          	add	a1,s11,a1
    800022bc:	0005c583          	lbu	a1,0(a1)
    800022c0:	02d7d7bb          	divuw	a5,a5,a3
    800022c4:	f8b402a3          	sb	a1,-123(s0)
    800022c8:	46ea7863          	bgeu	s4,a4,80002738 <__printf+0x650>
    800022cc:	02d7f5bb          	remuw	a1,a5,a3
    800022d0:	02059593          	slli	a1,a1,0x20
    800022d4:	0205d593          	srli	a1,a1,0x20
    800022d8:	00bd85b3          	add	a1,s11,a1
    800022dc:	0005c583          	lbu	a1,0(a1)
    800022e0:	02d7d7bb          	divuw	a5,a5,a3
    800022e4:	f8b40323          	sb	a1,-122(s0)
    800022e8:	3eeaf863          	bgeu	s5,a4,800026d8 <__printf+0x5f0>
    800022ec:	02d7f5bb          	remuw	a1,a5,a3
    800022f0:	02059593          	slli	a1,a1,0x20
    800022f4:	0205d593          	srli	a1,a1,0x20
    800022f8:	00bd85b3          	add	a1,s11,a1
    800022fc:	0005c583          	lbu	a1,0(a1)
    80002300:	02d7d7bb          	divuw	a5,a5,a3
    80002304:	f8b403a3          	sb	a1,-121(s0)
    80002308:	42eb7e63          	bgeu	s6,a4,80002744 <__printf+0x65c>
    8000230c:	02d7f5bb          	remuw	a1,a5,a3
    80002310:	02059593          	slli	a1,a1,0x20
    80002314:	0205d593          	srli	a1,a1,0x20
    80002318:	00bd85b3          	add	a1,s11,a1
    8000231c:	0005c583          	lbu	a1,0(a1)
    80002320:	02d7d7bb          	divuw	a5,a5,a3
    80002324:	f8b40423          	sb	a1,-120(s0)
    80002328:	42ebfc63          	bgeu	s7,a4,80002760 <__printf+0x678>
    8000232c:	02079793          	slli	a5,a5,0x20
    80002330:	0207d793          	srli	a5,a5,0x20
    80002334:	00fd8db3          	add	s11,s11,a5
    80002338:	000dc703          	lbu	a4,0(s11)
    8000233c:	00a00793          	li	a5,10
    80002340:	00900c93          	li	s9,9
    80002344:	f8e404a3          	sb	a4,-119(s0)
    80002348:	00065c63          	bgez	a2,80002360 <__printf+0x278>
    8000234c:	f9040713          	addi	a4,s0,-112
    80002350:	00f70733          	add	a4,a4,a5
    80002354:	02d00693          	li	a3,45
    80002358:	fed70823          	sb	a3,-16(a4)
    8000235c:	00078c93          	mv	s9,a5
    80002360:	f8040793          	addi	a5,s0,-128
    80002364:	01978cb3          	add	s9,a5,s9
    80002368:	f7f40d13          	addi	s10,s0,-129
    8000236c:	000cc503          	lbu	a0,0(s9)
    80002370:	fffc8c93          	addi	s9,s9,-1
    80002374:	00000097          	auipc	ra,0x0
    80002378:	b90080e7          	jalr	-1136(ra) # 80001f04 <consputc>
    8000237c:	ffac98e3          	bne	s9,s10,8000236c <__printf+0x284>
    80002380:	00094503          	lbu	a0,0(s2)
    80002384:	e00514e3          	bnez	a0,8000218c <__printf+0xa4>
    80002388:	1a0c1663          	bnez	s8,80002534 <__printf+0x44c>
    8000238c:	08813083          	ld	ra,136(sp)
    80002390:	08013403          	ld	s0,128(sp)
    80002394:	07813483          	ld	s1,120(sp)
    80002398:	07013903          	ld	s2,112(sp)
    8000239c:	06813983          	ld	s3,104(sp)
    800023a0:	06013a03          	ld	s4,96(sp)
    800023a4:	05813a83          	ld	s5,88(sp)
    800023a8:	05013b03          	ld	s6,80(sp)
    800023ac:	04813b83          	ld	s7,72(sp)
    800023b0:	04013c03          	ld	s8,64(sp)
    800023b4:	03813c83          	ld	s9,56(sp)
    800023b8:	03013d03          	ld	s10,48(sp)
    800023bc:	02813d83          	ld	s11,40(sp)
    800023c0:	0d010113          	addi	sp,sp,208
    800023c4:	00008067          	ret
    800023c8:	07300713          	li	a4,115
    800023cc:	1ce78a63          	beq	a5,a4,800025a0 <__printf+0x4b8>
    800023d0:	07800713          	li	a4,120
    800023d4:	1ee79e63          	bne	a5,a4,800025d0 <__printf+0x4e8>
    800023d8:	f7843783          	ld	a5,-136(s0)
    800023dc:	0007a703          	lw	a4,0(a5)
    800023e0:	00878793          	addi	a5,a5,8
    800023e4:	f6f43c23          	sd	a5,-136(s0)
    800023e8:	28074263          	bltz	a4,8000266c <__printf+0x584>
    800023ec:	00002d97          	auipc	s11,0x2
    800023f0:	d8cd8d93          	addi	s11,s11,-628 # 80004178 <digits>
    800023f4:	00f77793          	andi	a5,a4,15
    800023f8:	00fd87b3          	add	a5,s11,a5
    800023fc:	0007c683          	lbu	a3,0(a5)
    80002400:	00f00613          	li	a2,15
    80002404:	0007079b          	sext.w	a5,a4
    80002408:	f8d40023          	sb	a3,-128(s0)
    8000240c:	0047559b          	srliw	a1,a4,0x4
    80002410:	0047569b          	srliw	a3,a4,0x4
    80002414:	00000c93          	li	s9,0
    80002418:	0ee65063          	bge	a2,a4,800024f8 <__printf+0x410>
    8000241c:	00f6f693          	andi	a3,a3,15
    80002420:	00dd86b3          	add	a3,s11,a3
    80002424:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80002428:	0087d79b          	srliw	a5,a5,0x8
    8000242c:	00100c93          	li	s9,1
    80002430:	f8d400a3          	sb	a3,-127(s0)
    80002434:	0cb67263          	bgeu	a2,a1,800024f8 <__printf+0x410>
    80002438:	00f7f693          	andi	a3,a5,15
    8000243c:	00dd86b3          	add	a3,s11,a3
    80002440:	0006c583          	lbu	a1,0(a3)
    80002444:	00f00613          	li	a2,15
    80002448:	0047d69b          	srliw	a3,a5,0x4
    8000244c:	f8b40123          	sb	a1,-126(s0)
    80002450:	0047d593          	srli	a1,a5,0x4
    80002454:	28f67e63          	bgeu	a2,a5,800026f0 <__printf+0x608>
    80002458:	00f6f693          	andi	a3,a3,15
    8000245c:	00dd86b3          	add	a3,s11,a3
    80002460:	0006c503          	lbu	a0,0(a3)
    80002464:	0087d813          	srli	a6,a5,0x8
    80002468:	0087d69b          	srliw	a3,a5,0x8
    8000246c:	f8a401a3          	sb	a0,-125(s0)
    80002470:	28b67663          	bgeu	a2,a1,800026fc <__printf+0x614>
    80002474:	00f6f693          	andi	a3,a3,15
    80002478:	00dd86b3          	add	a3,s11,a3
    8000247c:	0006c583          	lbu	a1,0(a3)
    80002480:	00c7d513          	srli	a0,a5,0xc
    80002484:	00c7d69b          	srliw	a3,a5,0xc
    80002488:	f8b40223          	sb	a1,-124(s0)
    8000248c:	29067a63          	bgeu	a2,a6,80002720 <__printf+0x638>
    80002490:	00f6f693          	andi	a3,a3,15
    80002494:	00dd86b3          	add	a3,s11,a3
    80002498:	0006c583          	lbu	a1,0(a3)
    8000249c:	0107d813          	srli	a6,a5,0x10
    800024a0:	0107d69b          	srliw	a3,a5,0x10
    800024a4:	f8b402a3          	sb	a1,-123(s0)
    800024a8:	28a67263          	bgeu	a2,a0,8000272c <__printf+0x644>
    800024ac:	00f6f693          	andi	a3,a3,15
    800024b0:	00dd86b3          	add	a3,s11,a3
    800024b4:	0006c683          	lbu	a3,0(a3)
    800024b8:	0147d79b          	srliw	a5,a5,0x14
    800024bc:	f8d40323          	sb	a3,-122(s0)
    800024c0:	21067663          	bgeu	a2,a6,800026cc <__printf+0x5e4>
    800024c4:	02079793          	slli	a5,a5,0x20
    800024c8:	0207d793          	srli	a5,a5,0x20
    800024cc:	00fd8db3          	add	s11,s11,a5
    800024d0:	000dc683          	lbu	a3,0(s11)
    800024d4:	00800793          	li	a5,8
    800024d8:	00700c93          	li	s9,7
    800024dc:	f8d403a3          	sb	a3,-121(s0)
    800024e0:	00075c63          	bgez	a4,800024f8 <__printf+0x410>
    800024e4:	f9040713          	addi	a4,s0,-112
    800024e8:	00f70733          	add	a4,a4,a5
    800024ec:	02d00693          	li	a3,45
    800024f0:	fed70823          	sb	a3,-16(a4)
    800024f4:	00078c93          	mv	s9,a5
    800024f8:	f8040793          	addi	a5,s0,-128
    800024fc:	01978cb3          	add	s9,a5,s9
    80002500:	f7f40d13          	addi	s10,s0,-129
    80002504:	000cc503          	lbu	a0,0(s9)
    80002508:	fffc8c93          	addi	s9,s9,-1
    8000250c:	00000097          	auipc	ra,0x0
    80002510:	9f8080e7          	jalr	-1544(ra) # 80001f04 <consputc>
    80002514:	ff9d18e3          	bne	s10,s9,80002504 <__printf+0x41c>
    80002518:	0100006f          	j	80002528 <__printf+0x440>
    8000251c:	00000097          	auipc	ra,0x0
    80002520:	9e8080e7          	jalr	-1560(ra) # 80001f04 <consputc>
    80002524:	000c8493          	mv	s1,s9
    80002528:	00094503          	lbu	a0,0(s2)
    8000252c:	c60510e3          	bnez	a0,8000218c <__printf+0xa4>
    80002530:	e40c0ee3          	beqz	s8,8000238c <__printf+0x2a4>
    80002534:	00003517          	auipc	a0,0x3
    80002538:	14c50513          	addi	a0,a0,332 # 80005680 <pr>
    8000253c:	00001097          	auipc	ra,0x1
    80002540:	94c080e7          	jalr	-1716(ra) # 80002e88 <release>
    80002544:	e49ff06f          	j	8000238c <__printf+0x2a4>
    80002548:	f7843783          	ld	a5,-136(s0)
    8000254c:	03000513          	li	a0,48
    80002550:	01000d13          	li	s10,16
    80002554:	00878713          	addi	a4,a5,8
    80002558:	0007bc83          	ld	s9,0(a5)
    8000255c:	f6e43c23          	sd	a4,-136(s0)
    80002560:	00000097          	auipc	ra,0x0
    80002564:	9a4080e7          	jalr	-1628(ra) # 80001f04 <consputc>
    80002568:	07800513          	li	a0,120
    8000256c:	00000097          	auipc	ra,0x0
    80002570:	998080e7          	jalr	-1640(ra) # 80001f04 <consputc>
    80002574:	00002d97          	auipc	s11,0x2
    80002578:	c04d8d93          	addi	s11,s11,-1020 # 80004178 <digits>
    8000257c:	03ccd793          	srli	a5,s9,0x3c
    80002580:	00fd87b3          	add	a5,s11,a5
    80002584:	0007c503          	lbu	a0,0(a5)
    80002588:	fffd0d1b          	addiw	s10,s10,-1
    8000258c:	004c9c93          	slli	s9,s9,0x4
    80002590:	00000097          	auipc	ra,0x0
    80002594:	974080e7          	jalr	-1676(ra) # 80001f04 <consputc>
    80002598:	fe0d12e3          	bnez	s10,8000257c <__printf+0x494>
    8000259c:	f8dff06f          	j	80002528 <__printf+0x440>
    800025a0:	f7843783          	ld	a5,-136(s0)
    800025a4:	0007bc83          	ld	s9,0(a5)
    800025a8:	00878793          	addi	a5,a5,8
    800025ac:	f6f43c23          	sd	a5,-136(s0)
    800025b0:	000c9a63          	bnez	s9,800025c4 <__printf+0x4dc>
    800025b4:	1080006f          	j	800026bc <__printf+0x5d4>
    800025b8:	001c8c93          	addi	s9,s9,1
    800025bc:	00000097          	auipc	ra,0x0
    800025c0:	948080e7          	jalr	-1720(ra) # 80001f04 <consputc>
    800025c4:	000cc503          	lbu	a0,0(s9)
    800025c8:	fe0518e3          	bnez	a0,800025b8 <__printf+0x4d0>
    800025cc:	f5dff06f          	j	80002528 <__printf+0x440>
    800025d0:	02500513          	li	a0,37
    800025d4:	00000097          	auipc	ra,0x0
    800025d8:	930080e7          	jalr	-1744(ra) # 80001f04 <consputc>
    800025dc:	000c8513          	mv	a0,s9
    800025e0:	00000097          	auipc	ra,0x0
    800025e4:	924080e7          	jalr	-1756(ra) # 80001f04 <consputc>
    800025e8:	f41ff06f          	j	80002528 <__printf+0x440>
    800025ec:	02500513          	li	a0,37
    800025f0:	00000097          	auipc	ra,0x0
    800025f4:	914080e7          	jalr	-1772(ra) # 80001f04 <consputc>
    800025f8:	f31ff06f          	j	80002528 <__printf+0x440>
    800025fc:	00030513          	mv	a0,t1
    80002600:	00000097          	auipc	ra,0x0
    80002604:	7bc080e7          	jalr	1980(ra) # 80002dbc <acquire>
    80002608:	b4dff06f          	j	80002154 <__printf+0x6c>
    8000260c:	40c0053b          	negw	a0,a2
    80002610:	00a00713          	li	a4,10
    80002614:	02e576bb          	remuw	a3,a0,a4
    80002618:	00002d97          	auipc	s11,0x2
    8000261c:	b60d8d93          	addi	s11,s11,-1184 # 80004178 <digits>
    80002620:	ff700593          	li	a1,-9
    80002624:	02069693          	slli	a3,a3,0x20
    80002628:	0206d693          	srli	a3,a3,0x20
    8000262c:	00dd86b3          	add	a3,s11,a3
    80002630:	0006c683          	lbu	a3,0(a3)
    80002634:	02e557bb          	divuw	a5,a0,a4
    80002638:	f8d40023          	sb	a3,-128(s0)
    8000263c:	10b65e63          	bge	a2,a1,80002758 <__printf+0x670>
    80002640:	06300593          	li	a1,99
    80002644:	02e7f6bb          	remuw	a3,a5,a4
    80002648:	02069693          	slli	a3,a3,0x20
    8000264c:	0206d693          	srli	a3,a3,0x20
    80002650:	00dd86b3          	add	a3,s11,a3
    80002654:	0006c683          	lbu	a3,0(a3)
    80002658:	02e7d73b          	divuw	a4,a5,a4
    8000265c:	00200793          	li	a5,2
    80002660:	f8d400a3          	sb	a3,-127(s0)
    80002664:	bca5ece3          	bltu	a1,a0,8000223c <__printf+0x154>
    80002668:	ce5ff06f          	j	8000234c <__printf+0x264>
    8000266c:	40e007bb          	negw	a5,a4
    80002670:	00002d97          	auipc	s11,0x2
    80002674:	b08d8d93          	addi	s11,s11,-1272 # 80004178 <digits>
    80002678:	00f7f693          	andi	a3,a5,15
    8000267c:	00dd86b3          	add	a3,s11,a3
    80002680:	0006c583          	lbu	a1,0(a3)
    80002684:	ff100613          	li	a2,-15
    80002688:	0047d69b          	srliw	a3,a5,0x4
    8000268c:	f8b40023          	sb	a1,-128(s0)
    80002690:	0047d59b          	srliw	a1,a5,0x4
    80002694:	0ac75e63          	bge	a4,a2,80002750 <__printf+0x668>
    80002698:	00f6f693          	andi	a3,a3,15
    8000269c:	00dd86b3          	add	a3,s11,a3
    800026a0:	0006c603          	lbu	a2,0(a3)
    800026a4:	00f00693          	li	a3,15
    800026a8:	0087d79b          	srliw	a5,a5,0x8
    800026ac:	f8c400a3          	sb	a2,-127(s0)
    800026b0:	d8b6e4e3          	bltu	a3,a1,80002438 <__printf+0x350>
    800026b4:	00200793          	li	a5,2
    800026b8:	e2dff06f          	j	800024e4 <__printf+0x3fc>
    800026bc:	00002c97          	auipc	s9,0x2
    800026c0:	a9cc8c93          	addi	s9,s9,-1380 # 80004158 <CONSOLE_STATUS+0x148>
    800026c4:	02800513          	li	a0,40
    800026c8:	ef1ff06f          	j	800025b8 <__printf+0x4d0>
    800026cc:	00700793          	li	a5,7
    800026d0:	00600c93          	li	s9,6
    800026d4:	e0dff06f          	j	800024e0 <__printf+0x3f8>
    800026d8:	00700793          	li	a5,7
    800026dc:	00600c93          	li	s9,6
    800026e0:	c69ff06f          	j	80002348 <__printf+0x260>
    800026e4:	00300793          	li	a5,3
    800026e8:	00200c93          	li	s9,2
    800026ec:	c5dff06f          	j	80002348 <__printf+0x260>
    800026f0:	00300793          	li	a5,3
    800026f4:	00200c93          	li	s9,2
    800026f8:	de9ff06f          	j	800024e0 <__printf+0x3f8>
    800026fc:	00400793          	li	a5,4
    80002700:	00300c93          	li	s9,3
    80002704:	dddff06f          	j	800024e0 <__printf+0x3f8>
    80002708:	00400793          	li	a5,4
    8000270c:	00300c93          	li	s9,3
    80002710:	c39ff06f          	j	80002348 <__printf+0x260>
    80002714:	00500793          	li	a5,5
    80002718:	00400c93          	li	s9,4
    8000271c:	c2dff06f          	j	80002348 <__printf+0x260>
    80002720:	00500793          	li	a5,5
    80002724:	00400c93          	li	s9,4
    80002728:	db9ff06f          	j	800024e0 <__printf+0x3f8>
    8000272c:	00600793          	li	a5,6
    80002730:	00500c93          	li	s9,5
    80002734:	dadff06f          	j	800024e0 <__printf+0x3f8>
    80002738:	00600793          	li	a5,6
    8000273c:	00500c93          	li	s9,5
    80002740:	c09ff06f          	j	80002348 <__printf+0x260>
    80002744:	00800793          	li	a5,8
    80002748:	00700c93          	li	s9,7
    8000274c:	bfdff06f          	j	80002348 <__printf+0x260>
    80002750:	00100793          	li	a5,1
    80002754:	d91ff06f          	j	800024e4 <__printf+0x3fc>
    80002758:	00100793          	li	a5,1
    8000275c:	bf1ff06f          	j	8000234c <__printf+0x264>
    80002760:	00900793          	li	a5,9
    80002764:	00800c93          	li	s9,8
    80002768:	be1ff06f          	j	80002348 <__printf+0x260>
    8000276c:	00002517          	auipc	a0,0x2
    80002770:	9f450513          	addi	a0,a0,-1548 # 80004160 <CONSOLE_STATUS+0x150>
    80002774:	00000097          	auipc	ra,0x0
    80002778:	918080e7          	jalr	-1768(ra) # 8000208c <panic>

000000008000277c <printfinit>:
    8000277c:	fe010113          	addi	sp,sp,-32
    80002780:	00813823          	sd	s0,16(sp)
    80002784:	00913423          	sd	s1,8(sp)
    80002788:	00113c23          	sd	ra,24(sp)
    8000278c:	02010413          	addi	s0,sp,32
    80002790:	00003497          	auipc	s1,0x3
    80002794:	ef048493          	addi	s1,s1,-272 # 80005680 <pr>
    80002798:	00048513          	mv	a0,s1
    8000279c:	00002597          	auipc	a1,0x2
    800027a0:	9d458593          	addi	a1,a1,-1580 # 80004170 <CONSOLE_STATUS+0x160>
    800027a4:	00000097          	auipc	ra,0x0
    800027a8:	5f4080e7          	jalr	1524(ra) # 80002d98 <initlock>
    800027ac:	01813083          	ld	ra,24(sp)
    800027b0:	01013403          	ld	s0,16(sp)
    800027b4:	0004ac23          	sw	zero,24(s1)
    800027b8:	00813483          	ld	s1,8(sp)
    800027bc:	02010113          	addi	sp,sp,32
    800027c0:	00008067          	ret

00000000800027c4 <uartinit>:
    800027c4:	ff010113          	addi	sp,sp,-16
    800027c8:	00813423          	sd	s0,8(sp)
    800027cc:	01010413          	addi	s0,sp,16
    800027d0:	100007b7          	lui	a5,0x10000
    800027d4:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    800027d8:	f8000713          	li	a4,-128
    800027dc:	00e781a3          	sb	a4,3(a5)
    800027e0:	00300713          	li	a4,3
    800027e4:	00e78023          	sb	a4,0(a5)
    800027e8:	000780a3          	sb	zero,1(a5)
    800027ec:	00e781a3          	sb	a4,3(a5)
    800027f0:	00700693          	li	a3,7
    800027f4:	00d78123          	sb	a3,2(a5)
    800027f8:	00e780a3          	sb	a4,1(a5)
    800027fc:	00813403          	ld	s0,8(sp)
    80002800:	01010113          	addi	sp,sp,16
    80002804:	00008067          	ret

0000000080002808 <uartputc>:
    80002808:	00002797          	auipc	a5,0x2
    8000280c:	c207a783          	lw	a5,-992(a5) # 80004428 <panicked>
    80002810:	00078463          	beqz	a5,80002818 <uartputc+0x10>
    80002814:	0000006f          	j	80002814 <uartputc+0xc>
    80002818:	fd010113          	addi	sp,sp,-48
    8000281c:	02813023          	sd	s0,32(sp)
    80002820:	00913c23          	sd	s1,24(sp)
    80002824:	01213823          	sd	s2,16(sp)
    80002828:	01313423          	sd	s3,8(sp)
    8000282c:	02113423          	sd	ra,40(sp)
    80002830:	03010413          	addi	s0,sp,48
    80002834:	00002917          	auipc	s2,0x2
    80002838:	bfc90913          	addi	s2,s2,-1028 # 80004430 <uart_tx_r>
    8000283c:	00093783          	ld	a5,0(s2)
    80002840:	00002497          	auipc	s1,0x2
    80002844:	bf848493          	addi	s1,s1,-1032 # 80004438 <uart_tx_w>
    80002848:	0004b703          	ld	a4,0(s1)
    8000284c:	02078693          	addi	a3,a5,32
    80002850:	00050993          	mv	s3,a0
    80002854:	02e69c63          	bne	a3,a4,8000288c <uartputc+0x84>
    80002858:	00001097          	auipc	ra,0x1
    8000285c:	834080e7          	jalr	-1996(ra) # 8000308c <push_on>
    80002860:	00093783          	ld	a5,0(s2)
    80002864:	0004b703          	ld	a4,0(s1)
    80002868:	02078793          	addi	a5,a5,32
    8000286c:	00e79463          	bne	a5,a4,80002874 <uartputc+0x6c>
    80002870:	0000006f          	j	80002870 <uartputc+0x68>
    80002874:	00001097          	auipc	ra,0x1
    80002878:	88c080e7          	jalr	-1908(ra) # 80003100 <pop_on>
    8000287c:	00093783          	ld	a5,0(s2)
    80002880:	0004b703          	ld	a4,0(s1)
    80002884:	02078693          	addi	a3,a5,32
    80002888:	fce688e3          	beq	a3,a4,80002858 <uartputc+0x50>
    8000288c:	01f77693          	andi	a3,a4,31
    80002890:	00003597          	auipc	a1,0x3
    80002894:	e1058593          	addi	a1,a1,-496 # 800056a0 <uart_tx_buf>
    80002898:	00d586b3          	add	a3,a1,a3
    8000289c:	00170713          	addi	a4,a4,1
    800028a0:	01368023          	sb	s3,0(a3)
    800028a4:	00e4b023          	sd	a4,0(s1)
    800028a8:	10000637          	lui	a2,0x10000
    800028ac:	02f71063          	bne	a4,a5,800028cc <uartputc+0xc4>
    800028b0:	0340006f          	j	800028e4 <uartputc+0xdc>
    800028b4:	00074703          	lbu	a4,0(a4)
    800028b8:	00f93023          	sd	a5,0(s2)
    800028bc:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    800028c0:	00093783          	ld	a5,0(s2)
    800028c4:	0004b703          	ld	a4,0(s1)
    800028c8:	00f70e63          	beq	a4,a5,800028e4 <uartputc+0xdc>
    800028cc:	00564683          	lbu	a3,5(a2)
    800028d0:	01f7f713          	andi	a4,a5,31
    800028d4:	00e58733          	add	a4,a1,a4
    800028d8:	0206f693          	andi	a3,a3,32
    800028dc:	00178793          	addi	a5,a5,1
    800028e0:	fc069ae3          	bnez	a3,800028b4 <uartputc+0xac>
    800028e4:	02813083          	ld	ra,40(sp)
    800028e8:	02013403          	ld	s0,32(sp)
    800028ec:	01813483          	ld	s1,24(sp)
    800028f0:	01013903          	ld	s2,16(sp)
    800028f4:	00813983          	ld	s3,8(sp)
    800028f8:	03010113          	addi	sp,sp,48
    800028fc:	00008067          	ret

0000000080002900 <uartputc_sync>:
    80002900:	ff010113          	addi	sp,sp,-16
    80002904:	00813423          	sd	s0,8(sp)
    80002908:	01010413          	addi	s0,sp,16
    8000290c:	00002717          	auipc	a4,0x2
    80002910:	b1c72703          	lw	a4,-1252(a4) # 80004428 <panicked>
    80002914:	02071663          	bnez	a4,80002940 <uartputc_sync+0x40>
    80002918:	00050793          	mv	a5,a0
    8000291c:	100006b7          	lui	a3,0x10000
    80002920:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80002924:	02077713          	andi	a4,a4,32
    80002928:	fe070ce3          	beqz	a4,80002920 <uartputc_sync+0x20>
    8000292c:	0ff7f793          	andi	a5,a5,255
    80002930:	00f68023          	sb	a5,0(a3)
    80002934:	00813403          	ld	s0,8(sp)
    80002938:	01010113          	addi	sp,sp,16
    8000293c:	00008067          	ret
    80002940:	0000006f          	j	80002940 <uartputc_sync+0x40>

0000000080002944 <uartstart>:
    80002944:	ff010113          	addi	sp,sp,-16
    80002948:	00813423          	sd	s0,8(sp)
    8000294c:	01010413          	addi	s0,sp,16
    80002950:	00002617          	auipc	a2,0x2
    80002954:	ae060613          	addi	a2,a2,-1312 # 80004430 <uart_tx_r>
    80002958:	00002517          	auipc	a0,0x2
    8000295c:	ae050513          	addi	a0,a0,-1312 # 80004438 <uart_tx_w>
    80002960:	00063783          	ld	a5,0(a2)
    80002964:	00053703          	ld	a4,0(a0)
    80002968:	04f70263          	beq	a4,a5,800029ac <uartstart+0x68>
    8000296c:	100005b7          	lui	a1,0x10000
    80002970:	00003817          	auipc	a6,0x3
    80002974:	d3080813          	addi	a6,a6,-720 # 800056a0 <uart_tx_buf>
    80002978:	01c0006f          	j	80002994 <uartstart+0x50>
    8000297c:	0006c703          	lbu	a4,0(a3)
    80002980:	00f63023          	sd	a5,0(a2)
    80002984:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80002988:	00063783          	ld	a5,0(a2)
    8000298c:	00053703          	ld	a4,0(a0)
    80002990:	00f70e63          	beq	a4,a5,800029ac <uartstart+0x68>
    80002994:	01f7f713          	andi	a4,a5,31
    80002998:	00e806b3          	add	a3,a6,a4
    8000299c:	0055c703          	lbu	a4,5(a1)
    800029a0:	00178793          	addi	a5,a5,1
    800029a4:	02077713          	andi	a4,a4,32
    800029a8:	fc071ae3          	bnez	a4,8000297c <uartstart+0x38>
    800029ac:	00813403          	ld	s0,8(sp)
    800029b0:	01010113          	addi	sp,sp,16
    800029b4:	00008067          	ret

00000000800029b8 <uartgetc>:
    800029b8:	ff010113          	addi	sp,sp,-16
    800029bc:	00813423          	sd	s0,8(sp)
    800029c0:	01010413          	addi	s0,sp,16
    800029c4:	10000737          	lui	a4,0x10000
    800029c8:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    800029cc:	0017f793          	andi	a5,a5,1
    800029d0:	00078c63          	beqz	a5,800029e8 <uartgetc+0x30>
    800029d4:	00074503          	lbu	a0,0(a4)
    800029d8:	0ff57513          	andi	a0,a0,255
    800029dc:	00813403          	ld	s0,8(sp)
    800029e0:	01010113          	addi	sp,sp,16
    800029e4:	00008067          	ret
    800029e8:	fff00513          	li	a0,-1
    800029ec:	ff1ff06f          	j	800029dc <uartgetc+0x24>

00000000800029f0 <uartintr>:
    800029f0:	100007b7          	lui	a5,0x10000
    800029f4:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    800029f8:	0017f793          	andi	a5,a5,1
    800029fc:	0a078463          	beqz	a5,80002aa4 <uartintr+0xb4>
    80002a00:	fe010113          	addi	sp,sp,-32
    80002a04:	00813823          	sd	s0,16(sp)
    80002a08:	00913423          	sd	s1,8(sp)
    80002a0c:	00113c23          	sd	ra,24(sp)
    80002a10:	02010413          	addi	s0,sp,32
    80002a14:	100004b7          	lui	s1,0x10000
    80002a18:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    80002a1c:	0ff57513          	andi	a0,a0,255
    80002a20:	fffff097          	auipc	ra,0xfffff
    80002a24:	534080e7          	jalr	1332(ra) # 80001f54 <consoleintr>
    80002a28:	0054c783          	lbu	a5,5(s1)
    80002a2c:	0017f793          	andi	a5,a5,1
    80002a30:	fe0794e3          	bnez	a5,80002a18 <uartintr+0x28>
    80002a34:	00002617          	auipc	a2,0x2
    80002a38:	9fc60613          	addi	a2,a2,-1540 # 80004430 <uart_tx_r>
    80002a3c:	00002517          	auipc	a0,0x2
    80002a40:	9fc50513          	addi	a0,a0,-1540 # 80004438 <uart_tx_w>
    80002a44:	00063783          	ld	a5,0(a2)
    80002a48:	00053703          	ld	a4,0(a0)
    80002a4c:	04f70263          	beq	a4,a5,80002a90 <uartintr+0xa0>
    80002a50:	100005b7          	lui	a1,0x10000
    80002a54:	00003817          	auipc	a6,0x3
    80002a58:	c4c80813          	addi	a6,a6,-948 # 800056a0 <uart_tx_buf>
    80002a5c:	01c0006f          	j	80002a78 <uartintr+0x88>
    80002a60:	0006c703          	lbu	a4,0(a3)
    80002a64:	00f63023          	sd	a5,0(a2)
    80002a68:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80002a6c:	00063783          	ld	a5,0(a2)
    80002a70:	00053703          	ld	a4,0(a0)
    80002a74:	00f70e63          	beq	a4,a5,80002a90 <uartintr+0xa0>
    80002a78:	01f7f713          	andi	a4,a5,31
    80002a7c:	00e806b3          	add	a3,a6,a4
    80002a80:	0055c703          	lbu	a4,5(a1)
    80002a84:	00178793          	addi	a5,a5,1
    80002a88:	02077713          	andi	a4,a4,32
    80002a8c:	fc071ae3          	bnez	a4,80002a60 <uartintr+0x70>
    80002a90:	01813083          	ld	ra,24(sp)
    80002a94:	01013403          	ld	s0,16(sp)
    80002a98:	00813483          	ld	s1,8(sp)
    80002a9c:	02010113          	addi	sp,sp,32
    80002aa0:	00008067          	ret
    80002aa4:	00002617          	auipc	a2,0x2
    80002aa8:	98c60613          	addi	a2,a2,-1652 # 80004430 <uart_tx_r>
    80002aac:	00002517          	auipc	a0,0x2
    80002ab0:	98c50513          	addi	a0,a0,-1652 # 80004438 <uart_tx_w>
    80002ab4:	00063783          	ld	a5,0(a2)
    80002ab8:	00053703          	ld	a4,0(a0)
    80002abc:	04f70263          	beq	a4,a5,80002b00 <uartintr+0x110>
    80002ac0:	100005b7          	lui	a1,0x10000
    80002ac4:	00003817          	auipc	a6,0x3
    80002ac8:	bdc80813          	addi	a6,a6,-1060 # 800056a0 <uart_tx_buf>
    80002acc:	01c0006f          	j	80002ae8 <uartintr+0xf8>
    80002ad0:	0006c703          	lbu	a4,0(a3)
    80002ad4:	00f63023          	sd	a5,0(a2)
    80002ad8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80002adc:	00063783          	ld	a5,0(a2)
    80002ae0:	00053703          	ld	a4,0(a0)
    80002ae4:	02f70063          	beq	a4,a5,80002b04 <uartintr+0x114>
    80002ae8:	01f7f713          	andi	a4,a5,31
    80002aec:	00e806b3          	add	a3,a6,a4
    80002af0:	0055c703          	lbu	a4,5(a1)
    80002af4:	00178793          	addi	a5,a5,1
    80002af8:	02077713          	andi	a4,a4,32
    80002afc:	fc071ae3          	bnez	a4,80002ad0 <uartintr+0xe0>
    80002b00:	00008067          	ret
    80002b04:	00008067          	ret

0000000080002b08 <kinit>:
    80002b08:	fc010113          	addi	sp,sp,-64
    80002b0c:	02913423          	sd	s1,40(sp)
    80002b10:	fffff7b7          	lui	a5,0xfffff
    80002b14:	00004497          	auipc	s1,0x4
    80002b18:	bab48493          	addi	s1,s1,-1109 # 800066bf <end+0xfff>
    80002b1c:	02813823          	sd	s0,48(sp)
    80002b20:	01313c23          	sd	s3,24(sp)
    80002b24:	00f4f4b3          	and	s1,s1,a5
    80002b28:	02113c23          	sd	ra,56(sp)
    80002b2c:	03213023          	sd	s2,32(sp)
    80002b30:	01413823          	sd	s4,16(sp)
    80002b34:	01513423          	sd	s5,8(sp)
    80002b38:	04010413          	addi	s0,sp,64
    80002b3c:	000017b7          	lui	a5,0x1
    80002b40:	01100993          	li	s3,17
    80002b44:	00f487b3          	add	a5,s1,a5
    80002b48:	01b99993          	slli	s3,s3,0x1b
    80002b4c:	06f9e063          	bltu	s3,a5,80002bac <kinit+0xa4>
    80002b50:	00003a97          	auipc	s5,0x3
    80002b54:	b70a8a93          	addi	s5,s5,-1168 # 800056c0 <end>
    80002b58:	0754ec63          	bltu	s1,s5,80002bd0 <kinit+0xc8>
    80002b5c:	0734fa63          	bgeu	s1,s3,80002bd0 <kinit+0xc8>
    80002b60:	00088a37          	lui	s4,0x88
    80002b64:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80002b68:	00002917          	auipc	s2,0x2
    80002b6c:	8d890913          	addi	s2,s2,-1832 # 80004440 <kmem>
    80002b70:	00ca1a13          	slli	s4,s4,0xc
    80002b74:	0140006f          	j	80002b88 <kinit+0x80>
    80002b78:	000017b7          	lui	a5,0x1
    80002b7c:	00f484b3          	add	s1,s1,a5
    80002b80:	0554e863          	bltu	s1,s5,80002bd0 <kinit+0xc8>
    80002b84:	0534f663          	bgeu	s1,s3,80002bd0 <kinit+0xc8>
    80002b88:	00001637          	lui	a2,0x1
    80002b8c:	00100593          	li	a1,1
    80002b90:	00048513          	mv	a0,s1
    80002b94:	00000097          	auipc	ra,0x0
    80002b98:	5e4080e7          	jalr	1508(ra) # 80003178 <__memset>
    80002b9c:	00093783          	ld	a5,0(s2)
    80002ba0:	00f4b023          	sd	a5,0(s1)
    80002ba4:	00993023          	sd	s1,0(s2)
    80002ba8:	fd4498e3          	bne	s1,s4,80002b78 <kinit+0x70>
    80002bac:	03813083          	ld	ra,56(sp)
    80002bb0:	03013403          	ld	s0,48(sp)
    80002bb4:	02813483          	ld	s1,40(sp)
    80002bb8:	02013903          	ld	s2,32(sp)
    80002bbc:	01813983          	ld	s3,24(sp)
    80002bc0:	01013a03          	ld	s4,16(sp)
    80002bc4:	00813a83          	ld	s5,8(sp)
    80002bc8:	04010113          	addi	sp,sp,64
    80002bcc:	00008067          	ret
    80002bd0:	00001517          	auipc	a0,0x1
    80002bd4:	5c050513          	addi	a0,a0,1472 # 80004190 <digits+0x18>
    80002bd8:	fffff097          	auipc	ra,0xfffff
    80002bdc:	4b4080e7          	jalr	1204(ra) # 8000208c <panic>

0000000080002be0 <freerange>:
    80002be0:	fc010113          	addi	sp,sp,-64
    80002be4:	000017b7          	lui	a5,0x1
    80002be8:	02913423          	sd	s1,40(sp)
    80002bec:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80002bf0:	009504b3          	add	s1,a0,s1
    80002bf4:	fffff537          	lui	a0,0xfffff
    80002bf8:	02813823          	sd	s0,48(sp)
    80002bfc:	02113c23          	sd	ra,56(sp)
    80002c00:	03213023          	sd	s2,32(sp)
    80002c04:	01313c23          	sd	s3,24(sp)
    80002c08:	01413823          	sd	s4,16(sp)
    80002c0c:	01513423          	sd	s5,8(sp)
    80002c10:	01613023          	sd	s6,0(sp)
    80002c14:	04010413          	addi	s0,sp,64
    80002c18:	00a4f4b3          	and	s1,s1,a0
    80002c1c:	00f487b3          	add	a5,s1,a5
    80002c20:	06f5e463          	bltu	a1,a5,80002c88 <freerange+0xa8>
    80002c24:	00003a97          	auipc	s5,0x3
    80002c28:	a9ca8a93          	addi	s5,s5,-1380 # 800056c0 <end>
    80002c2c:	0954e263          	bltu	s1,s5,80002cb0 <freerange+0xd0>
    80002c30:	01100993          	li	s3,17
    80002c34:	01b99993          	slli	s3,s3,0x1b
    80002c38:	0734fc63          	bgeu	s1,s3,80002cb0 <freerange+0xd0>
    80002c3c:	00058a13          	mv	s4,a1
    80002c40:	00002917          	auipc	s2,0x2
    80002c44:	80090913          	addi	s2,s2,-2048 # 80004440 <kmem>
    80002c48:	00002b37          	lui	s6,0x2
    80002c4c:	0140006f          	j	80002c60 <freerange+0x80>
    80002c50:	000017b7          	lui	a5,0x1
    80002c54:	00f484b3          	add	s1,s1,a5
    80002c58:	0554ec63          	bltu	s1,s5,80002cb0 <freerange+0xd0>
    80002c5c:	0534fa63          	bgeu	s1,s3,80002cb0 <freerange+0xd0>
    80002c60:	00001637          	lui	a2,0x1
    80002c64:	00100593          	li	a1,1
    80002c68:	00048513          	mv	a0,s1
    80002c6c:	00000097          	auipc	ra,0x0
    80002c70:	50c080e7          	jalr	1292(ra) # 80003178 <__memset>
    80002c74:	00093703          	ld	a4,0(s2)
    80002c78:	016487b3          	add	a5,s1,s6
    80002c7c:	00e4b023          	sd	a4,0(s1)
    80002c80:	00993023          	sd	s1,0(s2)
    80002c84:	fcfa76e3          	bgeu	s4,a5,80002c50 <freerange+0x70>
    80002c88:	03813083          	ld	ra,56(sp)
    80002c8c:	03013403          	ld	s0,48(sp)
    80002c90:	02813483          	ld	s1,40(sp)
    80002c94:	02013903          	ld	s2,32(sp)
    80002c98:	01813983          	ld	s3,24(sp)
    80002c9c:	01013a03          	ld	s4,16(sp)
    80002ca0:	00813a83          	ld	s5,8(sp)
    80002ca4:	00013b03          	ld	s6,0(sp)
    80002ca8:	04010113          	addi	sp,sp,64
    80002cac:	00008067          	ret
    80002cb0:	00001517          	auipc	a0,0x1
    80002cb4:	4e050513          	addi	a0,a0,1248 # 80004190 <digits+0x18>
    80002cb8:	fffff097          	auipc	ra,0xfffff
    80002cbc:	3d4080e7          	jalr	980(ra) # 8000208c <panic>

0000000080002cc0 <kfree>:
    80002cc0:	fe010113          	addi	sp,sp,-32
    80002cc4:	00813823          	sd	s0,16(sp)
    80002cc8:	00113c23          	sd	ra,24(sp)
    80002ccc:	00913423          	sd	s1,8(sp)
    80002cd0:	02010413          	addi	s0,sp,32
    80002cd4:	03451793          	slli	a5,a0,0x34
    80002cd8:	04079c63          	bnez	a5,80002d30 <kfree+0x70>
    80002cdc:	00003797          	auipc	a5,0x3
    80002ce0:	9e478793          	addi	a5,a5,-1564 # 800056c0 <end>
    80002ce4:	00050493          	mv	s1,a0
    80002ce8:	04f56463          	bltu	a0,a5,80002d30 <kfree+0x70>
    80002cec:	01100793          	li	a5,17
    80002cf0:	01b79793          	slli	a5,a5,0x1b
    80002cf4:	02f57e63          	bgeu	a0,a5,80002d30 <kfree+0x70>
    80002cf8:	00001637          	lui	a2,0x1
    80002cfc:	00100593          	li	a1,1
    80002d00:	00000097          	auipc	ra,0x0
    80002d04:	478080e7          	jalr	1144(ra) # 80003178 <__memset>
    80002d08:	00001797          	auipc	a5,0x1
    80002d0c:	73878793          	addi	a5,a5,1848 # 80004440 <kmem>
    80002d10:	0007b703          	ld	a4,0(a5)
    80002d14:	01813083          	ld	ra,24(sp)
    80002d18:	01013403          	ld	s0,16(sp)
    80002d1c:	00e4b023          	sd	a4,0(s1)
    80002d20:	0097b023          	sd	s1,0(a5)
    80002d24:	00813483          	ld	s1,8(sp)
    80002d28:	02010113          	addi	sp,sp,32
    80002d2c:	00008067          	ret
    80002d30:	00001517          	auipc	a0,0x1
    80002d34:	46050513          	addi	a0,a0,1120 # 80004190 <digits+0x18>
    80002d38:	fffff097          	auipc	ra,0xfffff
    80002d3c:	354080e7          	jalr	852(ra) # 8000208c <panic>

0000000080002d40 <kalloc>:
    80002d40:	fe010113          	addi	sp,sp,-32
    80002d44:	00813823          	sd	s0,16(sp)
    80002d48:	00913423          	sd	s1,8(sp)
    80002d4c:	00113c23          	sd	ra,24(sp)
    80002d50:	02010413          	addi	s0,sp,32
    80002d54:	00001797          	auipc	a5,0x1
    80002d58:	6ec78793          	addi	a5,a5,1772 # 80004440 <kmem>
    80002d5c:	0007b483          	ld	s1,0(a5)
    80002d60:	02048063          	beqz	s1,80002d80 <kalloc+0x40>
    80002d64:	0004b703          	ld	a4,0(s1)
    80002d68:	00001637          	lui	a2,0x1
    80002d6c:	00500593          	li	a1,5
    80002d70:	00048513          	mv	a0,s1
    80002d74:	00e7b023          	sd	a4,0(a5)
    80002d78:	00000097          	auipc	ra,0x0
    80002d7c:	400080e7          	jalr	1024(ra) # 80003178 <__memset>
    80002d80:	01813083          	ld	ra,24(sp)
    80002d84:	01013403          	ld	s0,16(sp)
    80002d88:	00048513          	mv	a0,s1
    80002d8c:	00813483          	ld	s1,8(sp)
    80002d90:	02010113          	addi	sp,sp,32
    80002d94:	00008067          	ret

0000000080002d98 <initlock>:
    80002d98:	ff010113          	addi	sp,sp,-16
    80002d9c:	00813423          	sd	s0,8(sp)
    80002da0:	01010413          	addi	s0,sp,16
    80002da4:	00813403          	ld	s0,8(sp)
    80002da8:	00b53423          	sd	a1,8(a0)
    80002dac:	00052023          	sw	zero,0(a0)
    80002db0:	00053823          	sd	zero,16(a0)
    80002db4:	01010113          	addi	sp,sp,16
    80002db8:	00008067          	ret

0000000080002dbc <acquire>:
    80002dbc:	fe010113          	addi	sp,sp,-32
    80002dc0:	00813823          	sd	s0,16(sp)
    80002dc4:	00913423          	sd	s1,8(sp)
    80002dc8:	00113c23          	sd	ra,24(sp)
    80002dcc:	01213023          	sd	s2,0(sp)
    80002dd0:	02010413          	addi	s0,sp,32
    80002dd4:	00050493          	mv	s1,a0
    80002dd8:	10002973          	csrr	s2,sstatus
    80002ddc:	100027f3          	csrr	a5,sstatus
    80002de0:	ffd7f793          	andi	a5,a5,-3
    80002de4:	10079073          	csrw	sstatus,a5
    80002de8:	fffff097          	auipc	ra,0xfffff
    80002dec:	8e8080e7          	jalr	-1816(ra) # 800016d0 <mycpu>
    80002df0:	07852783          	lw	a5,120(a0)
    80002df4:	06078e63          	beqz	a5,80002e70 <acquire+0xb4>
    80002df8:	fffff097          	auipc	ra,0xfffff
    80002dfc:	8d8080e7          	jalr	-1832(ra) # 800016d0 <mycpu>
    80002e00:	07852783          	lw	a5,120(a0)
    80002e04:	0004a703          	lw	a4,0(s1)
    80002e08:	0017879b          	addiw	a5,a5,1
    80002e0c:	06f52c23          	sw	a5,120(a0)
    80002e10:	04071063          	bnez	a4,80002e50 <acquire+0x94>
    80002e14:	00100713          	li	a4,1
    80002e18:	00070793          	mv	a5,a4
    80002e1c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80002e20:	0007879b          	sext.w	a5,a5
    80002e24:	fe079ae3          	bnez	a5,80002e18 <acquire+0x5c>
    80002e28:	0ff0000f          	fence
    80002e2c:	fffff097          	auipc	ra,0xfffff
    80002e30:	8a4080e7          	jalr	-1884(ra) # 800016d0 <mycpu>
    80002e34:	01813083          	ld	ra,24(sp)
    80002e38:	01013403          	ld	s0,16(sp)
    80002e3c:	00a4b823          	sd	a0,16(s1)
    80002e40:	00013903          	ld	s2,0(sp)
    80002e44:	00813483          	ld	s1,8(sp)
    80002e48:	02010113          	addi	sp,sp,32
    80002e4c:	00008067          	ret
    80002e50:	0104b903          	ld	s2,16(s1)
    80002e54:	fffff097          	auipc	ra,0xfffff
    80002e58:	87c080e7          	jalr	-1924(ra) # 800016d0 <mycpu>
    80002e5c:	faa91ce3          	bne	s2,a0,80002e14 <acquire+0x58>
    80002e60:	00001517          	auipc	a0,0x1
    80002e64:	33850513          	addi	a0,a0,824 # 80004198 <digits+0x20>
    80002e68:	fffff097          	auipc	ra,0xfffff
    80002e6c:	224080e7          	jalr	548(ra) # 8000208c <panic>
    80002e70:	00195913          	srli	s2,s2,0x1
    80002e74:	fffff097          	auipc	ra,0xfffff
    80002e78:	85c080e7          	jalr	-1956(ra) # 800016d0 <mycpu>
    80002e7c:	00197913          	andi	s2,s2,1
    80002e80:	07252e23          	sw	s2,124(a0)
    80002e84:	f75ff06f          	j	80002df8 <acquire+0x3c>

0000000080002e88 <release>:
    80002e88:	fe010113          	addi	sp,sp,-32
    80002e8c:	00813823          	sd	s0,16(sp)
    80002e90:	00113c23          	sd	ra,24(sp)
    80002e94:	00913423          	sd	s1,8(sp)
    80002e98:	01213023          	sd	s2,0(sp)
    80002e9c:	02010413          	addi	s0,sp,32
    80002ea0:	00052783          	lw	a5,0(a0)
    80002ea4:	00079a63          	bnez	a5,80002eb8 <release+0x30>
    80002ea8:	00001517          	auipc	a0,0x1
    80002eac:	2f850513          	addi	a0,a0,760 # 800041a0 <digits+0x28>
    80002eb0:	fffff097          	auipc	ra,0xfffff
    80002eb4:	1dc080e7          	jalr	476(ra) # 8000208c <panic>
    80002eb8:	01053903          	ld	s2,16(a0)
    80002ebc:	00050493          	mv	s1,a0
    80002ec0:	fffff097          	auipc	ra,0xfffff
    80002ec4:	810080e7          	jalr	-2032(ra) # 800016d0 <mycpu>
    80002ec8:	fea910e3          	bne	s2,a0,80002ea8 <release+0x20>
    80002ecc:	0004b823          	sd	zero,16(s1)
    80002ed0:	0ff0000f          	fence
    80002ed4:	0f50000f          	fence	iorw,ow
    80002ed8:	0804a02f          	amoswap.w	zero,zero,(s1)
    80002edc:	ffffe097          	auipc	ra,0xffffe
    80002ee0:	7f4080e7          	jalr	2036(ra) # 800016d0 <mycpu>
    80002ee4:	100027f3          	csrr	a5,sstatus
    80002ee8:	0027f793          	andi	a5,a5,2
    80002eec:	04079a63          	bnez	a5,80002f40 <release+0xb8>
    80002ef0:	07852783          	lw	a5,120(a0)
    80002ef4:	02f05e63          	blez	a5,80002f30 <release+0xa8>
    80002ef8:	fff7871b          	addiw	a4,a5,-1
    80002efc:	06e52c23          	sw	a4,120(a0)
    80002f00:	00071c63          	bnez	a4,80002f18 <release+0x90>
    80002f04:	07c52783          	lw	a5,124(a0)
    80002f08:	00078863          	beqz	a5,80002f18 <release+0x90>
    80002f0c:	100027f3          	csrr	a5,sstatus
    80002f10:	0027e793          	ori	a5,a5,2
    80002f14:	10079073          	csrw	sstatus,a5
    80002f18:	01813083          	ld	ra,24(sp)
    80002f1c:	01013403          	ld	s0,16(sp)
    80002f20:	00813483          	ld	s1,8(sp)
    80002f24:	00013903          	ld	s2,0(sp)
    80002f28:	02010113          	addi	sp,sp,32
    80002f2c:	00008067          	ret
    80002f30:	00001517          	auipc	a0,0x1
    80002f34:	29050513          	addi	a0,a0,656 # 800041c0 <digits+0x48>
    80002f38:	fffff097          	auipc	ra,0xfffff
    80002f3c:	154080e7          	jalr	340(ra) # 8000208c <panic>
    80002f40:	00001517          	auipc	a0,0x1
    80002f44:	26850513          	addi	a0,a0,616 # 800041a8 <digits+0x30>
    80002f48:	fffff097          	auipc	ra,0xfffff
    80002f4c:	144080e7          	jalr	324(ra) # 8000208c <panic>

0000000080002f50 <holding>:
    80002f50:	00052783          	lw	a5,0(a0)
    80002f54:	00079663          	bnez	a5,80002f60 <holding+0x10>
    80002f58:	00000513          	li	a0,0
    80002f5c:	00008067          	ret
    80002f60:	fe010113          	addi	sp,sp,-32
    80002f64:	00813823          	sd	s0,16(sp)
    80002f68:	00913423          	sd	s1,8(sp)
    80002f6c:	00113c23          	sd	ra,24(sp)
    80002f70:	02010413          	addi	s0,sp,32
    80002f74:	01053483          	ld	s1,16(a0)
    80002f78:	ffffe097          	auipc	ra,0xffffe
    80002f7c:	758080e7          	jalr	1880(ra) # 800016d0 <mycpu>
    80002f80:	01813083          	ld	ra,24(sp)
    80002f84:	01013403          	ld	s0,16(sp)
    80002f88:	40a48533          	sub	a0,s1,a0
    80002f8c:	00153513          	seqz	a0,a0
    80002f90:	00813483          	ld	s1,8(sp)
    80002f94:	02010113          	addi	sp,sp,32
    80002f98:	00008067          	ret

0000000080002f9c <push_off>:
    80002f9c:	fe010113          	addi	sp,sp,-32
    80002fa0:	00813823          	sd	s0,16(sp)
    80002fa4:	00113c23          	sd	ra,24(sp)
    80002fa8:	00913423          	sd	s1,8(sp)
    80002fac:	02010413          	addi	s0,sp,32
    80002fb0:	100024f3          	csrr	s1,sstatus
    80002fb4:	100027f3          	csrr	a5,sstatus
    80002fb8:	ffd7f793          	andi	a5,a5,-3
    80002fbc:	10079073          	csrw	sstatus,a5
    80002fc0:	ffffe097          	auipc	ra,0xffffe
    80002fc4:	710080e7          	jalr	1808(ra) # 800016d0 <mycpu>
    80002fc8:	07852783          	lw	a5,120(a0)
    80002fcc:	02078663          	beqz	a5,80002ff8 <push_off+0x5c>
    80002fd0:	ffffe097          	auipc	ra,0xffffe
    80002fd4:	700080e7          	jalr	1792(ra) # 800016d0 <mycpu>
    80002fd8:	07852783          	lw	a5,120(a0)
    80002fdc:	01813083          	ld	ra,24(sp)
    80002fe0:	01013403          	ld	s0,16(sp)
    80002fe4:	0017879b          	addiw	a5,a5,1
    80002fe8:	06f52c23          	sw	a5,120(a0)
    80002fec:	00813483          	ld	s1,8(sp)
    80002ff0:	02010113          	addi	sp,sp,32
    80002ff4:	00008067          	ret
    80002ff8:	0014d493          	srli	s1,s1,0x1
    80002ffc:	ffffe097          	auipc	ra,0xffffe
    80003000:	6d4080e7          	jalr	1748(ra) # 800016d0 <mycpu>
    80003004:	0014f493          	andi	s1,s1,1
    80003008:	06952e23          	sw	s1,124(a0)
    8000300c:	fc5ff06f          	j	80002fd0 <push_off+0x34>

0000000080003010 <pop_off>:
    80003010:	ff010113          	addi	sp,sp,-16
    80003014:	00813023          	sd	s0,0(sp)
    80003018:	00113423          	sd	ra,8(sp)
    8000301c:	01010413          	addi	s0,sp,16
    80003020:	ffffe097          	auipc	ra,0xffffe
    80003024:	6b0080e7          	jalr	1712(ra) # 800016d0 <mycpu>
    80003028:	100027f3          	csrr	a5,sstatus
    8000302c:	0027f793          	andi	a5,a5,2
    80003030:	04079663          	bnez	a5,8000307c <pop_off+0x6c>
    80003034:	07852783          	lw	a5,120(a0)
    80003038:	02f05a63          	blez	a5,8000306c <pop_off+0x5c>
    8000303c:	fff7871b          	addiw	a4,a5,-1
    80003040:	06e52c23          	sw	a4,120(a0)
    80003044:	00071c63          	bnez	a4,8000305c <pop_off+0x4c>
    80003048:	07c52783          	lw	a5,124(a0)
    8000304c:	00078863          	beqz	a5,8000305c <pop_off+0x4c>
    80003050:	100027f3          	csrr	a5,sstatus
    80003054:	0027e793          	ori	a5,a5,2
    80003058:	10079073          	csrw	sstatus,a5
    8000305c:	00813083          	ld	ra,8(sp)
    80003060:	00013403          	ld	s0,0(sp)
    80003064:	01010113          	addi	sp,sp,16
    80003068:	00008067          	ret
    8000306c:	00001517          	auipc	a0,0x1
    80003070:	15450513          	addi	a0,a0,340 # 800041c0 <digits+0x48>
    80003074:	fffff097          	auipc	ra,0xfffff
    80003078:	018080e7          	jalr	24(ra) # 8000208c <panic>
    8000307c:	00001517          	auipc	a0,0x1
    80003080:	12c50513          	addi	a0,a0,300 # 800041a8 <digits+0x30>
    80003084:	fffff097          	auipc	ra,0xfffff
    80003088:	008080e7          	jalr	8(ra) # 8000208c <panic>

000000008000308c <push_on>:
    8000308c:	fe010113          	addi	sp,sp,-32
    80003090:	00813823          	sd	s0,16(sp)
    80003094:	00113c23          	sd	ra,24(sp)
    80003098:	00913423          	sd	s1,8(sp)
    8000309c:	02010413          	addi	s0,sp,32
    800030a0:	100024f3          	csrr	s1,sstatus
    800030a4:	100027f3          	csrr	a5,sstatus
    800030a8:	0027e793          	ori	a5,a5,2
    800030ac:	10079073          	csrw	sstatus,a5
    800030b0:	ffffe097          	auipc	ra,0xffffe
    800030b4:	620080e7          	jalr	1568(ra) # 800016d0 <mycpu>
    800030b8:	07852783          	lw	a5,120(a0)
    800030bc:	02078663          	beqz	a5,800030e8 <push_on+0x5c>
    800030c0:	ffffe097          	auipc	ra,0xffffe
    800030c4:	610080e7          	jalr	1552(ra) # 800016d0 <mycpu>
    800030c8:	07852783          	lw	a5,120(a0)
    800030cc:	01813083          	ld	ra,24(sp)
    800030d0:	01013403          	ld	s0,16(sp)
    800030d4:	0017879b          	addiw	a5,a5,1
    800030d8:	06f52c23          	sw	a5,120(a0)
    800030dc:	00813483          	ld	s1,8(sp)
    800030e0:	02010113          	addi	sp,sp,32
    800030e4:	00008067          	ret
    800030e8:	0014d493          	srli	s1,s1,0x1
    800030ec:	ffffe097          	auipc	ra,0xffffe
    800030f0:	5e4080e7          	jalr	1508(ra) # 800016d0 <mycpu>
    800030f4:	0014f493          	andi	s1,s1,1
    800030f8:	06952e23          	sw	s1,124(a0)
    800030fc:	fc5ff06f          	j	800030c0 <push_on+0x34>

0000000080003100 <pop_on>:
    80003100:	ff010113          	addi	sp,sp,-16
    80003104:	00813023          	sd	s0,0(sp)
    80003108:	00113423          	sd	ra,8(sp)
    8000310c:	01010413          	addi	s0,sp,16
    80003110:	ffffe097          	auipc	ra,0xffffe
    80003114:	5c0080e7          	jalr	1472(ra) # 800016d0 <mycpu>
    80003118:	100027f3          	csrr	a5,sstatus
    8000311c:	0027f793          	andi	a5,a5,2
    80003120:	04078463          	beqz	a5,80003168 <pop_on+0x68>
    80003124:	07852783          	lw	a5,120(a0)
    80003128:	02f05863          	blez	a5,80003158 <pop_on+0x58>
    8000312c:	fff7879b          	addiw	a5,a5,-1
    80003130:	06f52c23          	sw	a5,120(a0)
    80003134:	07853783          	ld	a5,120(a0)
    80003138:	00079863          	bnez	a5,80003148 <pop_on+0x48>
    8000313c:	100027f3          	csrr	a5,sstatus
    80003140:	ffd7f793          	andi	a5,a5,-3
    80003144:	10079073          	csrw	sstatus,a5
    80003148:	00813083          	ld	ra,8(sp)
    8000314c:	00013403          	ld	s0,0(sp)
    80003150:	01010113          	addi	sp,sp,16
    80003154:	00008067          	ret
    80003158:	00001517          	auipc	a0,0x1
    8000315c:	09050513          	addi	a0,a0,144 # 800041e8 <digits+0x70>
    80003160:	fffff097          	auipc	ra,0xfffff
    80003164:	f2c080e7          	jalr	-212(ra) # 8000208c <panic>
    80003168:	00001517          	auipc	a0,0x1
    8000316c:	06050513          	addi	a0,a0,96 # 800041c8 <digits+0x50>
    80003170:	fffff097          	auipc	ra,0xfffff
    80003174:	f1c080e7          	jalr	-228(ra) # 8000208c <panic>

0000000080003178 <__memset>:
    80003178:	ff010113          	addi	sp,sp,-16
    8000317c:	00813423          	sd	s0,8(sp)
    80003180:	01010413          	addi	s0,sp,16
    80003184:	1a060e63          	beqz	a2,80003340 <__memset+0x1c8>
    80003188:	40a007b3          	neg	a5,a0
    8000318c:	0077f793          	andi	a5,a5,7
    80003190:	00778693          	addi	a3,a5,7
    80003194:	00b00813          	li	a6,11
    80003198:	0ff5f593          	andi	a1,a1,255
    8000319c:	fff6071b          	addiw	a4,a2,-1
    800031a0:	1b06e663          	bltu	a3,a6,8000334c <__memset+0x1d4>
    800031a4:	1cd76463          	bltu	a4,a3,8000336c <__memset+0x1f4>
    800031a8:	1a078e63          	beqz	a5,80003364 <__memset+0x1ec>
    800031ac:	00b50023          	sb	a1,0(a0)
    800031b0:	00100713          	li	a4,1
    800031b4:	1ae78463          	beq	a5,a4,8000335c <__memset+0x1e4>
    800031b8:	00b500a3          	sb	a1,1(a0)
    800031bc:	00200713          	li	a4,2
    800031c0:	1ae78a63          	beq	a5,a4,80003374 <__memset+0x1fc>
    800031c4:	00b50123          	sb	a1,2(a0)
    800031c8:	00300713          	li	a4,3
    800031cc:	18e78463          	beq	a5,a4,80003354 <__memset+0x1dc>
    800031d0:	00b501a3          	sb	a1,3(a0)
    800031d4:	00400713          	li	a4,4
    800031d8:	1ae78263          	beq	a5,a4,8000337c <__memset+0x204>
    800031dc:	00b50223          	sb	a1,4(a0)
    800031e0:	00500713          	li	a4,5
    800031e4:	1ae78063          	beq	a5,a4,80003384 <__memset+0x20c>
    800031e8:	00b502a3          	sb	a1,5(a0)
    800031ec:	00700713          	li	a4,7
    800031f0:	18e79e63          	bne	a5,a4,8000338c <__memset+0x214>
    800031f4:	00b50323          	sb	a1,6(a0)
    800031f8:	00700e93          	li	t4,7
    800031fc:	00859713          	slli	a4,a1,0x8
    80003200:	00e5e733          	or	a4,a1,a4
    80003204:	01059e13          	slli	t3,a1,0x10
    80003208:	01c76e33          	or	t3,a4,t3
    8000320c:	01859313          	slli	t1,a1,0x18
    80003210:	006e6333          	or	t1,t3,t1
    80003214:	02059893          	slli	a7,a1,0x20
    80003218:	40f60e3b          	subw	t3,a2,a5
    8000321c:	011368b3          	or	a7,t1,a7
    80003220:	02859813          	slli	a6,a1,0x28
    80003224:	0108e833          	or	a6,a7,a6
    80003228:	03059693          	slli	a3,a1,0x30
    8000322c:	003e589b          	srliw	a7,t3,0x3
    80003230:	00d866b3          	or	a3,a6,a3
    80003234:	03859713          	slli	a4,a1,0x38
    80003238:	00389813          	slli	a6,a7,0x3
    8000323c:	00f507b3          	add	a5,a0,a5
    80003240:	00e6e733          	or	a4,a3,a4
    80003244:	000e089b          	sext.w	a7,t3
    80003248:	00f806b3          	add	a3,a6,a5
    8000324c:	00e7b023          	sd	a4,0(a5)
    80003250:	00878793          	addi	a5,a5,8
    80003254:	fed79ce3          	bne	a5,a3,8000324c <__memset+0xd4>
    80003258:	ff8e7793          	andi	a5,t3,-8
    8000325c:	0007871b          	sext.w	a4,a5
    80003260:	01d787bb          	addw	a5,a5,t4
    80003264:	0ce88e63          	beq	a7,a4,80003340 <__memset+0x1c8>
    80003268:	00f50733          	add	a4,a0,a5
    8000326c:	00b70023          	sb	a1,0(a4)
    80003270:	0017871b          	addiw	a4,a5,1
    80003274:	0cc77663          	bgeu	a4,a2,80003340 <__memset+0x1c8>
    80003278:	00e50733          	add	a4,a0,a4
    8000327c:	00b70023          	sb	a1,0(a4)
    80003280:	0027871b          	addiw	a4,a5,2
    80003284:	0ac77e63          	bgeu	a4,a2,80003340 <__memset+0x1c8>
    80003288:	00e50733          	add	a4,a0,a4
    8000328c:	00b70023          	sb	a1,0(a4)
    80003290:	0037871b          	addiw	a4,a5,3
    80003294:	0ac77663          	bgeu	a4,a2,80003340 <__memset+0x1c8>
    80003298:	00e50733          	add	a4,a0,a4
    8000329c:	00b70023          	sb	a1,0(a4)
    800032a0:	0047871b          	addiw	a4,a5,4
    800032a4:	08c77e63          	bgeu	a4,a2,80003340 <__memset+0x1c8>
    800032a8:	00e50733          	add	a4,a0,a4
    800032ac:	00b70023          	sb	a1,0(a4)
    800032b0:	0057871b          	addiw	a4,a5,5
    800032b4:	08c77663          	bgeu	a4,a2,80003340 <__memset+0x1c8>
    800032b8:	00e50733          	add	a4,a0,a4
    800032bc:	00b70023          	sb	a1,0(a4)
    800032c0:	0067871b          	addiw	a4,a5,6
    800032c4:	06c77e63          	bgeu	a4,a2,80003340 <__memset+0x1c8>
    800032c8:	00e50733          	add	a4,a0,a4
    800032cc:	00b70023          	sb	a1,0(a4)
    800032d0:	0077871b          	addiw	a4,a5,7
    800032d4:	06c77663          	bgeu	a4,a2,80003340 <__memset+0x1c8>
    800032d8:	00e50733          	add	a4,a0,a4
    800032dc:	00b70023          	sb	a1,0(a4)
    800032e0:	0087871b          	addiw	a4,a5,8
    800032e4:	04c77e63          	bgeu	a4,a2,80003340 <__memset+0x1c8>
    800032e8:	00e50733          	add	a4,a0,a4
    800032ec:	00b70023          	sb	a1,0(a4)
    800032f0:	0097871b          	addiw	a4,a5,9
    800032f4:	04c77663          	bgeu	a4,a2,80003340 <__memset+0x1c8>
    800032f8:	00e50733          	add	a4,a0,a4
    800032fc:	00b70023          	sb	a1,0(a4)
    80003300:	00a7871b          	addiw	a4,a5,10
    80003304:	02c77e63          	bgeu	a4,a2,80003340 <__memset+0x1c8>
    80003308:	00e50733          	add	a4,a0,a4
    8000330c:	00b70023          	sb	a1,0(a4)
    80003310:	00b7871b          	addiw	a4,a5,11
    80003314:	02c77663          	bgeu	a4,a2,80003340 <__memset+0x1c8>
    80003318:	00e50733          	add	a4,a0,a4
    8000331c:	00b70023          	sb	a1,0(a4)
    80003320:	00c7871b          	addiw	a4,a5,12
    80003324:	00c77e63          	bgeu	a4,a2,80003340 <__memset+0x1c8>
    80003328:	00e50733          	add	a4,a0,a4
    8000332c:	00b70023          	sb	a1,0(a4)
    80003330:	00d7879b          	addiw	a5,a5,13
    80003334:	00c7f663          	bgeu	a5,a2,80003340 <__memset+0x1c8>
    80003338:	00f507b3          	add	a5,a0,a5
    8000333c:	00b78023          	sb	a1,0(a5)
    80003340:	00813403          	ld	s0,8(sp)
    80003344:	01010113          	addi	sp,sp,16
    80003348:	00008067          	ret
    8000334c:	00b00693          	li	a3,11
    80003350:	e55ff06f          	j	800031a4 <__memset+0x2c>
    80003354:	00300e93          	li	t4,3
    80003358:	ea5ff06f          	j	800031fc <__memset+0x84>
    8000335c:	00100e93          	li	t4,1
    80003360:	e9dff06f          	j	800031fc <__memset+0x84>
    80003364:	00000e93          	li	t4,0
    80003368:	e95ff06f          	j	800031fc <__memset+0x84>
    8000336c:	00000793          	li	a5,0
    80003370:	ef9ff06f          	j	80003268 <__memset+0xf0>
    80003374:	00200e93          	li	t4,2
    80003378:	e85ff06f          	j	800031fc <__memset+0x84>
    8000337c:	00400e93          	li	t4,4
    80003380:	e7dff06f          	j	800031fc <__memset+0x84>
    80003384:	00500e93          	li	t4,5
    80003388:	e75ff06f          	j	800031fc <__memset+0x84>
    8000338c:	00600e93          	li	t4,6
    80003390:	e6dff06f          	j	800031fc <__memset+0x84>

0000000080003394 <__memmove>:
    80003394:	ff010113          	addi	sp,sp,-16
    80003398:	00813423          	sd	s0,8(sp)
    8000339c:	01010413          	addi	s0,sp,16
    800033a0:	0e060863          	beqz	a2,80003490 <__memmove+0xfc>
    800033a4:	fff6069b          	addiw	a3,a2,-1
    800033a8:	0006881b          	sext.w	a6,a3
    800033ac:	0ea5e863          	bltu	a1,a0,8000349c <__memmove+0x108>
    800033b0:	00758713          	addi	a4,a1,7
    800033b4:	00a5e7b3          	or	a5,a1,a0
    800033b8:	40a70733          	sub	a4,a4,a0
    800033bc:	0077f793          	andi	a5,a5,7
    800033c0:	00f73713          	sltiu	a4,a4,15
    800033c4:	00174713          	xori	a4,a4,1
    800033c8:	0017b793          	seqz	a5,a5
    800033cc:	00e7f7b3          	and	a5,a5,a4
    800033d0:	10078863          	beqz	a5,800034e0 <__memmove+0x14c>
    800033d4:	00900793          	li	a5,9
    800033d8:	1107f463          	bgeu	a5,a6,800034e0 <__memmove+0x14c>
    800033dc:	0036581b          	srliw	a6,a2,0x3
    800033e0:	fff8081b          	addiw	a6,a6,-1
    800033e4:	02081813          	slli	a6,a6,0x20
    800033e8:	01d85893          	srli	a7,a6,0x1d
    800033ec:	00858813          	addi	a6,a1,8
    800033f0:	00058793          	mv	a5,a1
    800033f4:	00050713          	mv	a4,a0
    800033f8:	01088833          	add	a6,a7,a6
    800033fc:	0007b883          	ld	a7,0(a5)
    80003400:	00878793          	addi	a5,a5,8
    80003404:	00870713          	addi	a4,a4,8
    80003408:	ff173c23          	sd	a7,-8(a4)
    8000340c:	ff0798e3          	bne	a5,a6,800033fc <__memmove+0x68>
    80003410:	ff867713          	andi	a4,a2,-8
    80003414:	02071793          	slli	a5,a4,0x20
    80003418:	0207d793          	srli	a5,a5,0x20
    8000341c:	00f585b3          	add	a1,a1,a5
    80003420:	40e686bb          	subw	a3,a3,a4
    80003424:	00f507b3          	add	a5,a0,a5
    80003428:	06e60463          	beq	a2,a4,80003490 <__memmove+0xfc>
    8000342c:	0005c703          	lbu	a4,0(a1)
    80003430:	00e78023          	sb	a4,0(a5)
    80003434:	04068e63          	beqz	a3,80003490 <__memmove+0xfc>
    80003438:	0015c603          	lbu	a2,1(a1)
    8000343c:	00100713          	li	a4,1
    80003440:	00c780a3          	sb	a2,1(a5)
    80003444:	04e68663          	beq	a3,a4,80003490 <__memmove+0xfc>
    80003448:	0025c603          	lbu	a2,2(a1)
    8000344c:	00200713          	li	a4,2
    80003450:	00c78123          	sb	a2,2(a5)
    80003454:	02e68e63          	beq	a3,a4,80003490 <__memmove+0xfc>
    80003458:	0035c603          	lbu	a2,3(a1)
    8000345c:	00300713          	li	a4,3
    80003460:	00c781a3          	sb	a2,3(a5)
    80003464:	02e68663          	beq	a3,a4,80003490 <__memmove+0xfc>
    80003468:	0045c603          	lbu	a2,4(a1)
    8000346c:	00400713          	li	a4,4
    80003470:	00c78223          	sb	a2,4(a5)
    80003474:	00e68e63          	beq	a3,a4,80003490 <__memmove+0xfc>
    80003478:	0055c603          	lbu	a2,5(a1)
    8000347c:	00500713          	li	a4,5
    80003480:	00c782a3          	sb	a2,5(a5)
    80003484:	00e68663          	beq	a3,a4,80003490 <__memmove+0xfc>
    80003488:	0065c703          	lbu	a4,6(a1)
    8000348c:	00e78323          	sb	a4,6(a5)
    80003490:	00813403          	ld	s0,8(sp)
    80003494:	01010113          	addi	sp,sp,16
    80003498:	00008067          	ret
    8000349c:	02061713          	slli	a4,a2,0x20
    800034a0:	02075713          	srli	a4,a4,0x20
    800034a4:	00e587b3          	add	a5,a1,a4
    800034a8:	f0f574e3          	bgeu	a0,a5,800033b0 <__memmove+0x1c>
    800034ac:	02069613          	slli	a2,a3,0x20
    800034b0:	02065613          	srli	a2,a2,0x20
    800034b4:	fff64613          	not	a2,a2
    800034b8:	00e50733          	add	a4,a0,a4
    800034bc:	00c78633          	add	a2,a5,a2
    800034c0:	fff7c683          	lbu	a3,-1(a5)
    800034c4:	fff78793          	addi	a5,a5,-1
    800034c8:	fff70713          	addi	a4,a4,-1
    800034cc:	00d70023          	sb	a3,0(a4)
    800034d0:	fec798e3          	bne	a5,a2,800034c0 <__memmove+0x12c>
    800034d4:	00813403          	ld	s0,8(sp)
    800034d8:	01010113          	addi	sp,sp,16
    800034dc:	00008067          	ret
    800034e0:	02069713          	slli	a4,a3,0x20
    800034e4:	02075713          	srli	a4,a4,0x20
    800034e8:	00170713          	addi	a4,a4,1
    800034ec:	00e50733          	add	a4,a0,a4
    800034f0:	00050793          	mv	a5,a0
    800034f4:	0005c683          	lbu	a3,0(a1)
    800034f8:	00178793          	addi	a5,a5,1
    800034fc:	00158593          	addi	a1,a1,1
    80003500:	fed78fa3          	sb	a3,-1(a5)
    80003504:	fee798e3          	bne	a5,a4,800034f4 <__memmove+0x160>
    80003508:	f89ff06f          	j	80003490 <__memmove+0xfc>
	...
