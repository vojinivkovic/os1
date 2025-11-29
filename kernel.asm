
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00004117          	auipc	sp,0x4
    80000004:	41013103          	ld	sp,1040(sp) # 80004410 <_GLOBAL_OFFSET_TABLE_+0x10>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	4a0010ef          	jal	ra,800014bc <start>

0000000080000020 <spin>:
    80000020:	0000006f          	j	80000020 <spin>
	...

0000000080001000 <main>:
//
// Created by os on 11/29/25.
//
#include "../h/MemoryAllocator.hpp"
void main(){
    80001000:	fe010113          	addi	sp,sp,-32
    80001004:	00113c23          	sd	ra,24(sp)
    80001008:	00813823          	sd	s0,16(sp)
    8000100c:	00913423          	sd	s1,8(sp)
    80001010:	01213023          	sd	s2,0(sp)
    80001014:	02010413          	addi	s0,sp,32
    //void* allocMem1 = (void*)MemoryAllocator::allocateMemory(4);
    void* allocMem1 = MemoryAllocator::allocateMemory(4);
    80001018:	00400513          	li	a0,4
    8000101c:	00000097          	auipc	ra,0x0
    80001020:	1f8080e7          	jalr	504(ra) # 80001214 <_ZN15MemoryAllocator14allocateMemoryEm>
    80001024:	00050913          	mv	s2,a0
    void* allocMem2 = MemoryAllocator::allocateMemory(10);
    80001028:	00a00513          	li	a0,10
    8000102c:	00000097          	auipc	ra,0x0
    80001030:	1e8080e7          	jalr	488(ra) # 80001214 <_ZN15MemoryAllocator14allocateMemoryEm>
    80001034:	00050493          	mv	s1,a0
    MemoryAllocator::freeMemory(allocMem1);
    80001038:	00090513          	mv	a0,s2
    8000103c:	00000097          	auipc	ra,0x0
    80001040:	330080e7          	jalr	816(ra) # 8000136c <_ZN15MemoryAllocator10freeMemoryEPv>
    MemoryAllocator::freeMemory(allocMem2);
    80001044:	00048513          	mv	a0,s1
    80001048:	00000097          	auipc	ra,0x0
    8000104c:	324080e7          	jalr	804(ra) # 8000136c <_ZN15MemoryAllocator10freeMemoryEPv>
    MemoryAllocator::allocateMemory(4);
    80001050:	00400513          	li	a0,4
    80001054:	00000097          	auipc	ra,0x0
    80001058:	1c0080e7          	jalr	448(ra) # 80001214 <_ZN15MemoryAllocator14allocateMemoryEm>
    8000105c:	01813083          	ld	ra,24(sp)
    80001060:	01013403          	ld	s0,16(sp)
    80001064:	00813483          	ld	s1,8(sp)
    80001068:	00013903          	ld	s2,0(sp)
    8000106c:	02010113          	addi	sp,sp,32
    80001070:	00008067          	ret

0000000080001074 <_ZN15MemoryAllocator16initializeMemoryEv>:
size_t MemoryAllocator::NUM_OF_BLOCKS = 0;
size_t MemoryAllocator::numOfFreeBlocks = 0;
MemoryAllocator::FreeBlock* MemoryAllocator::firstFreeBlock = nullptr;

void MemoryAllocator::initializeMemory()
{
    80001074:	ff010113          	addi	sp,sp,-16
    80001078:	00813423          	sd	s0,8(sp)
    8000107c:	01010413          	addi	s0,sp,16

    NUM_OF_BLOCKS = ((uint8*)HEAP_END_ADDR - (uint8*)HEAP_START_ADDR) / MEM_BLOCK_SIZE;
    80001080:	00003797          	auipc	a5,0x3
    80001084:	3987b783          	ld	a5,920(a5) # 80004418 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001088:	0007b703          	ld	a4,0(a5)
    8000108c:	00003797          	auipc	a5,0x3
    80001090:	37c7b783          	ld	a5,892(a5) # 80004408 <_GLOBAL_OFFSET_TABLE_+0x8>
    80001094:	0007b683          	ld	a3,0(a5)
    80001098:	40d70733          	sub	a4,a4,a3
    8000109c:	00675713          	srli	a4,a4,0x6
    800010a0:	00003797          	auipc	a5,0x3
    800010a4:	3c078793          	addi	a5,a5,960 # 80004460 <_ZN15MemoryAllocator13NUM_OF_BLOCKSE>
    800010a8:	00e7b023          	sd	a4,0(a5)
    numOfFreeBlocks = NUM_OF_BLOCKS;
    800010ac:	00e7b423          	sd	a4,8(a5)

    firstFreeBlock = (FreeBlock*)(HEAP_START_ADDR);
    800010b0:	00d7b823          	sd	a3,16(a5)

    firstFreeBlock->flagFree = true;
    800010b4:	00100613          	li	a2,1
    800010b8:	00c68023          	sb	a2,0(a3)
    firstFreeBlock->numOfBlocks = NUM_OF_BLOCKS;
    800010bc:	0107b703          	ld	a4,16(a5)
    800010c0:	0007b683          	ld	a3,0(a5)
    800010c4:	00d73423          	sd	a3,8(a4)
    firstFreeBlock->nextBlock = nullptr;
    800010c8:	00073823          	sd	zero,16(a4)
    firstFreeBlock->previousBlock = nullptr;
    800010cc:	00073c23          	sd	zero,24(a4)
    flagSystemInitialize = 1;
    800010d0:	00c78c23          	sb	a2,24(a5)
}
    800010d4:	00813403          	ld	s0,8(sp)
    800010d8:	01010113          	addi	sp,sp,16
    800010dc:	00008067          	ret

00000000800010e0 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m>:
    occupiedBlock++;
    return occupiedBlock;
}

void MemoryAllocator::remapMemory(FreeBlock **head, FreeBlock *allocatedBlocks, size_t blocksToAllocate)
{
    800010e0:	ff010113          	addi	sp,sp,-16
    800010e4:	00813423          	sd	s0,8(sp)
    800010e8:	01010413          	addi	s0,sp,16

    if(allocatedBlocks->numOfBlocks == 0)
    800010ec:	0085b783          	ld	a5,8(a1)
    800010f0:	04079263          	bnez	a5,80001134 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x54>
    {

        if(allocatedBlocks->previousBlock)
    800010f4:	0185b783          	ld	a5,24(a1)
    800010f8:	00078663          	beqz	a5,80001104 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x24>
        {
            allocatedBlocks->previousBlock->nextBlock = allocatedBlocks->nextBlock;
    800010fc:	0105b703          	ld	a4,16(a1)
    80001100:	00e7b823          	sd	a4,16(a5)
        }

        if(allocatedBlocks->nextBlock)
    80001104:	0105b783          	ld	a5,16(a1)
    80001108:	00078663          	beqz	a5,80001114 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x34>
        {
            allocatedBlocks->nextBlock->previousBlock = allocatedBlocks->previousBlock;
    8000110c:	0185b703          	ld	a4,24(a1)
    80001110:	00e7bc23          	sd	a4,24(a5)
        }

        if(*head == allocatedBlocks)
    80001114:	00053783          	ld	a5,0(a0) # 1000 <_entry-0x7ffff000>
    80001118:	00b78863          	beq	a5,a1,80001128 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x48>
        {
            *head = newFreeBlock;
        }
    }

}
    8000111c:	00813403          	ld	s0,8(sp)
    80001120:	01010113          	addi	sp,sp,16
    80001124:	00008067          	ret
            *head = allocatedBlocks->nextBlock;
    80001128:	0105b783          	ld	a5,16(a1)
    8000112c:	00f53023          	sd	a5,0(a0)
    80001130:	fedff06f          	j	8000111c <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x3c>
        FreeBlock* newFreeBlock = (FreeBlock*)((uint8*)allocatedBlocks + blocksToAllocate * MEM_BLOCK_SIZE);
    80001134:	00661613          	slli	a2,a2,0x6
    80001138:	00c58633          	add	a2,a1,a2
        newFreeBlock->flagFree = true;
    8000113c:	00100793          	li	a5,1
    80001140:	00f60023          	sb	a5,0(a2)
        newFreeBlock->numOfBlocks = allocatedBlocks->numOfBlocks;
    80001144:	0085b783          	ld	a5,8(a1)
    80001148:	00f63423          	sd	a5,8(a2)
        if(allocatedBlocks->previousBlock)
    8000114c:	0185b783          	ld	a5,24(a1)
    80001150:	00078463          	beqz	a5,80001158 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x78>
            allocatedBlocks->previousBlock->nextBlock = newFreeBlock;
    80001154:	00c7b823          	sd	a2,16(a5)
        newFreeBlock->previousBlock = allocatedBlocks->previousBlock;
    80001158:	0185b783          	ld	a5,24(a1)
    8000115c:	00f63c23          	sd	a5,24(a2)
        newFreeBlock->nextBlock = allocatedBlocks->nextBlock;
    80001160:	0105b783          	ld	a5,16(a1)
    80001164:	00f63823          	sd	a5,16(a2)
        if(*head == allocatedBlocks)
    80001168:	00053783          	ld	a5,0(a0)
    8000116c:	fab798e3          	bne	a5,a1,8000111c <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x3c>
            *head = newFreeBlock;
    80001170:	00c53023          	sd	a2,0(a0)
}
    80001174:	fa9ff06f          	j	8000111c <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x3c>

0000000080001178 <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm>:
{
    80001178:	fe010113          	addi	sp,sp,-32
    8000117c:	00113c23          	sd	ra,24(sp)
    80001180:	00813823          	sd	s0,16(sp)
    80001184:	00913423          	sd	s1,8(sp)
    80001188:	01213023          	sd	s2,0(sp)
    8000118c:	02010413          	addi	s0,sp,32
    80001190:	00058493          	mv	s1,a1
    FreeBlock* bestBlock = *head;
    80001194:	00053903          	ld	s2,0(a0)
    for(FreeBlock* curr = (*head)->nextBlock; curr; curr = curr->nextBlock)
    80001198:	01093783          	ld	a5,16(s2)
    8000119c:	0080006f          	j	800011a4 <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm+0x2c>
    800011a0:	0107b783          	ld	a5,16(a5)
    800011a4:	00078e63          	beqz	a5,800011c0 <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm+0x48>
        if(curr->numOfBlocks > blocksToAllocate)
    800011a8:	0087b703          	ld	a4,8(a5)
    800011ac:	fee4fae3          	bgeu	s1,a4,800011a0 <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm+0x28>
            if(bestBlock->numOfBlocks > curr->numOfBlocks)
    800011b0:	00893683          	ld	a3,8(s2)
    800011b4:	fed776e3          	bgeu	a4,a3,800011a0 <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm+0x28>
                bestBlock = curr;
    800011b8:	00078913          	mv	s2,a5
    800011bc:	fe5ff06f          	j	800011a0 <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm+0x28>
    numOfFreeBlocks -= blocksToAllocate;
    800011c0:	00003717          	auipc	a4,0x3
    800011c4:	2a070713          	addi	a4,a4,672 # 80004460 <_ZN15MemoryAllocator13NUM_OF_BLOCKSE>
    800011c8:	00873783          	ld	a5,8(a4)
    800011cc:	409787b3          	sub	a5,a5,s1
    800011d0:	00f73423          	sd	a5,8(a4)
    bestBlock->numOfBlocks -= blocksToAllocate;
    800011d4:	00893783          	ld	a5,8(s2)
    800011d8:	409787b3          	sub	a5,a5,s1
    800011dc:	00f93423          	sd	a5,8(s2)
    remapMemory(head, bestBlock, blocksToAllocate);
    800011e0:	00048613          	mv	a2,s1
    800011e4:	00090593          	mv	a1,s2
    800011e8:	00000097          	auipc	ra,0x0
    800011ec:	ef8080e7          	jalr	-264(ra) # 800010e0 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m>
    occupiedBlock->flagFree = false;
    800011f0:	00090023          	sb	zero,0(s2)
    occupiedBlock->numOfBlocks = blocksToAllocate;
    800011f4:	00993423          	sd	s1,8(s2)
}
    800011f8:	01090513          	addi	a0,s2,16
    800011fc:	01813083          	ld	ra,24(sp)
    80001200:	01013403          	ld	s0,16(sp)
    80001204:	00813483          	ld	s1,8(sp)
    80001208:	00013903          	ld	s2,0(sp)
    8000120c:	02010113          	addi	sp,sp,32
    80001210:	00008067          	ret

0000000080001214 <_ZN15MemoryAllocator14allocateMemoryEm>:
{
    80001214:	fe010113          	addi	sp,sp,-32
    80001218:	00113c23          	sd	ra,24(sp)
    8000121c:	00813823          	sd	s0,16(sp)
    80001220:	00913423          	sd	s1,8(sp)
    80001224:	02010413          	addi	s0,sp,32
    80001228:	00050493          	mv	s1,a0
    if(!flagSystemInitialize)
    8000122c:	00003797          	auipc	a5,0x3
    80001230:	24c7c783          	lbu	a5,588(a5) # 80004478 <_ZN15MemoryAllocator20flagSystemInitializeE>
    80001234:	02078c63          	beqz	a5,8000126c <_ZN15MemoryAllocator14allocateMemoryEm+0x58>
    if(numOfFreeBlocks < blocksToAllocate)
    80001238:	00003797          	auipc	a5,0x3
    8000123c:	2307b783          	ld	a5,560(a5) # 80004468 <_ZN15MemoryAllocator15numOfFreeBlocksE>
    80001240:	0297ec63          	bltu	a5,s1,80001278 <_ZN15MemoryAllocator14allocateMemoryEm+0x64>
    return findBestFit(&firstFreeBlock, blocksToAllocate);
    80001244:	00048593          	mv	a1,s1
    80001248:	00003517          	auipc	a0,0x3
    8000124c:	22850513          	addi	a0,a0,552 # 80004470 <_ZN15MemoryAllocator14firstFreeBlockE>
    80001250:	00000097          	auipc	ra,0x0
    80001254:	f28080e7          	jalr	-216(ra) # 80001178 <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm>
}
    80001258:	01813083          	ld	ra,24(sp)
    8000125c:	01013403          	ld	s0,16(sp)
    80001260:	00813483          	ld	s1,8(sp)
    80001264:	02010113          	addi	sp,sp,32
    80001268:	00008067          	ret
        initializeMemory();
    8000126c:	00000097          	auipc	ra,0x0
    80001270:	e08080e7          	jalr	-504(ra) # 80001074 <_ZN15MemoryAllocator16initializeMemoryEv>
    80001274:	fc5ff06f          	j	80001238 <_ZN15MemoryAllocator14allocateMemoryEm+0x24>
        return nullptr;
    80001278:	00000513          	li	a0,0
    8000127c:	fddff06f          	j	80001258 <_ZN15MemoryAllocator14allocateMemoryEm+0x44>

0000000080001280 <_ZN15MemoryAllocator17findNextFreeBlockEPNS_9FreeBlockE>:
MemoryAllocator::FreeBlock* MemoryAllocator::findNextFreeBlock(FreeBlock* memoryToFree)
{
    80001280:	ff010113          	addi	sp,sp,-16
    80001284:	00813423          	sd	s0,8(sp)
    80001288:	01010413          	addi	s0,sp,16
    8000128c:	00050793          	mv	a5,a0
    for(uint8* i = (uint8*)memoryToFree; i + (((OccupiedBlock*)i)->numOfBlocks * MEM_BLOCK_SIZE) <= (uint8*)HEAP_END_ADDR; i+= (((OccupiedBlock*)i)->numOfBlocks * MEM_BLOCK_SIZE))
    80001290:	0087b703          	ld	a4,8(a5)
    80001294:	00671713          	slli	a4,a4,0x6
    80001298:	00078513          	mv	a0,a5
    8000129c:	00e787b3          	add	a5,a5,a4
    800012a0:	00003717          	auipc	a4,0x3
    800012a4:	17873703          	ld	a4,376(a4) # 80004418 <_GLOBAL_OFFSET_TABLE_+0x18>
    800012a8:	00073703          	ld	a4,0(a4)
    800012ac:	00f76863          	bltu	a4,a5,800012bc <_ZN15MemoryAllocator17findNextFreeBlockEPNS_9FreeBlockE+0x3c>
    {
        if(((FreeBlock*)i)->flagFree)
    800012b0:	00054703          	lbu	a4,0(a0)
    800012b4:	fc070ee3          	beqz	a4,80001290 <_ZN15MemoryAllocator17findNextFreeBlockEPNS_9FreeBlockE+0x10>
    800012b8:	0080006f          	j	800012c0 <_ZN15MemoryAllocator17findNextFreeBlockEPNS_9FreeBlockE+0x40>
        {
            return (FreeBlock*)i;
        }
    }
    return nullptr;
    800012bc:	00000513          	li	a0,0
}
    800012c0:	00813403          	ld	s0,8(sp)
    800012c4:	01010113          	addi	sp,sp,16
    800012c8:	00008067          	ret

00000000800012cc <_ZN15MemoryAllocator21findPreviousFreeBlockEPNS_9FreeBlockES1_>:

MemoryAllocator::FreeBlock* MemoryAllocator::findPreviousFreeBlock(FreeBlock* head, FreeBlock* memoryToFree)
{
    800012cc:	ff010113          	addi	sp,sp,-16
    800012d0:	00813423          	sd	s0,8(sp)
    800012d4:	01010413          	addi	s0,sp,16
    FreeBlock* temp = head;
    for(; temp && temp <= memoryToFree; temp = temp->nextBlock){}
    800012d8:	00050863          	beqz	a0,800012e8 <_ZN15MemoryAllocator21findPreviousFreeBlockEPNS_9FreeBlockES1_+0x1c>
    800012dc:	00a5e663          	bltu	a1,a0,800012e8 <_ZN15MemoryAllocator21findPreviousFreeBlockEPNS_9FreeBlockES1_+0x1c>
    800012e0:	01053503          	ld	a0,16(a0)
    800012e4:	ff5ff06f          	j	800012d8 <_ZN15MemoryAllocator21findPreviousFreeBlockEPNS_9FreeBlockES1_+0xc>
    if(!temp)
    800012e8:	00050463          	beqz	a0,800012f0 <_ZN15MemoryAllocator21findPreviousFreeBlockEPNS_9FreeBlockES1_+0x24>
    {
        return nullptr;
    }
    return temp->previousBlock;
    800012ec:	01853503          	ld	a0,24(a0)
}
    800012f0:	00813403          	ld	s0,8(sp)
    800012f4:	01010113          	addi	sp,sp,16
    800012f8:	00008067          	ret

00000000800012fc <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_>:

    return 0;
}

void MemoryAllocator::connectAdjacentBlocks(FreeBlock* previousBlock, FreeBlock* adjacentBlock)
{
    800012fc:	ff010113          	addi	sp,sp,-16
    80001300:	00813423          	sd	s0,8(sp)
    80001304:	01010413          	addi	s0,sp,16


    if(adjacentBlock == (FreeBlock*)((uint8 *)previousBlock + previousBlock->numOfBlocks * MEM_BLOCK_SIZE))
    80001308:	00853703          	ld	a4,8(a0)
    8000130c:	00671793          	slli	a5,a4,0x6
    80001310:	00f507b3          	add	a5,a0,a5
    80001314:	00b78e63          	beq	a5,a1,80001330 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_+0x34>
        adjacentBlock->previousBlock = nullptr;

    }
    else
    {
        previousBlock->nextBlock = adjacentBlock;
    80001318:	00b53823          	sd	a1,16(a0)
        if(adjacentBlock)
    8000131c:	00058463          	beqz	a1,80001324 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_+0x28>
        {
            adjacentBlock->previousBlock = previousBlock;
    80001320:	00a5bc23          	sd	a0,24(a1)
        }

    }
}
    80001324:	00813403          	ld	s0,8(sp)
    80001328:	01010113          	addi	sp,sp,16
    8000132c:	00008067          	ret
        previousBlock->numOfBlocks += adjacentBlock->numOfBlocks;
    80001330:	0085b783          	ld	a5,8(a1)
    80001334:	00f70733          	add	a4,a4,a5
    80001338:	00e53423          	sd	a4,8(a0)
        previousBlock->nextBlock = adjacentBlock->nextBlock;
    8000133c:	0105b783          	ld	a5,16(a1)
    80001340:	00f53823          	sd	a5,16(a0)
        previousBlock->previousBlock = (previousBlock == adjacentBlock->previousBlock ? nullptr : adjacentBlock->previousBlock);
    80001344:	0185b783          	ld	a5,24(a1)
    80001348:	00a78e63          	beq	a5,a0,80001364 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_+0x68>
    8000134c:	00f53c23          	sd	a5,24(a0)
        adjacentBlock->flagFree = false;
    80001350:	00058023          	sb	zero,0(a1)
        adjacentBlock->numOfBlocks = 0;
    80001354:	0005b423          	sd	zero,8(a1)
        adjacentBlock->nextBlock = nullptr;
    80001358:	0005b823          	sd	zero,16(a1)
        adjacentBlock->previousBlock = nullptr;
    8000135c:	0005bc23          	sd	zero,24(a1)
    80001360:	fc5ff06f          	j	80001324 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_+0x28>
        previousBlock->previousBlock = (previousBlock == adjacentBlock->previousBlock ? nullptr : adjacentBlock->previousBlock);
    80001364:	00000793          	li	a5,0
    80001368:	fe5ff06f          	j	8000134c <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_+0x50>

000000008000136c <_ZN15MemoryAllocator10freeMemoryEPv>:
    if(!addressToFree)
    8000136c:	0c050e63          	beqz	a0,80001448 <_ZN15MemoryAllocator10freeMemoryEPv+0xdc>
{
    80001370:	fc010113          	addi	sp,sp,-64
    80001374:	02113c23          	sd	ra,56(sp)
    80001378:	02813823          	sd	s0,48(sp)
    8000137c:	02913423          	sd	s1,40(sp)
    80001380:	03213023          	sd	s2,32(sp)
    80001384:	01313c23          	sd	s3,24(sp)
    80001388:	01413823          	sd	s4,16(sp)
    8000138c:	01513423          	sd	s5,8(sp)
    80001390:	04010413          	addi	s0,sp,64
    80001394:	00050493          	mv	s1,a0
    tempAddress--;
    80001398:	ff050913          	addi	s2,a0,-16
    int numOfTakenBlocks = tempAddress->numOfBlocks;
    8000139c:	ff852a83          	lw	s5,-8(a0)
    numOfFreeBlocks += numOfTakenBlocks;
    800013a0:	00003997          	auipc	s3,0x3
    800013a4:	0c098993          	addi	s3,s3,192 # 80004460 <_ZN15MemoryAllocator13NUM_OF_BLOCKSE>
    800013a8:	0089b783          	ld	a5,8(s3)
    800013ac:	015787b3          	add	a5,a5,s5
    800013b0:	00f9b423          	sd	a5,8(s3)
    FreeBlock* nextFreeBlock = findNextFreeBlock(newFreeBlock);
    800013b4:	00090513          	mv	a0,s2
    800013b8:	00000097          	auipc	ra,0x0
    800013bc:	ec8080e7          	jalr	-312(ra) # 80001280 <_ZN15MemoryAllocator17findNextFreeBlockEPNS_9FreeBlockE>
    800013c0:	00050a13          	mv	s4,a0
    FreeBlock* previousFreeBlock = findPreviousFreeBlock(firstFreeBlock, newFreeBlock);
    800013c4:	00090593          	mv	a1,s2
    800013c8:	0109b503          	ld	a0,16(s3)
    800013cc:	00000097          	auipc	ra,0x0
    800013d0:	f00080e7          	jalr	-256(ra) # 800012cc <_ZN15MemoryAllocator21findPreviousFreeBlockEPNS_9FreeBlockES1_>
    800013d4:	00050993          	mv	s3,a0
    newFreeBlock->flagFree = true;
    800013d8:	00100793          	li	a5,1
    800013dc:	fef48823          	sb	a5,-16(s1)
    newFreeBlock->numOfBlocks = numOfTakenBlocks;
    800013e0:	ff54bc23          	sd	s5,-8(s1)
    newFreeBlock->nextBlock = nullptr;
    800013e4:	0004b023          	sd	zero,0(s1)
    newFreeBlock->previousBlock = nullptr;
    800013e8:	0004b423          	sd	zero,8(s1)
    connectAdjacentBlocks(newFreeBlock, nextFreeBlock);
    800013ec:	000a0593          	mv	a1,s4
    800013f0:	00090513          	mv	a0,s2
    800013f4:	00000097          	auipc	ra,0x0
    800013f8:	f08080e7          	jalr	-248(ra) # 800012fc <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_>
    if(previousFreeBlock)
    800013fc:	02098e63          	beqz	s3,80001438 <_ZN15MemoryAllocator10freeMemoryEPv+0xcc>
        connectAdjacentBlocks(previousFreeBlock, newFreeBlock);
    80001400:	00090593          	mv	a1,s2
    80001404:	00098513          	mv	a0,s3
    80001408:	00000097          	auipc	ra,0x0
    8000140c:	ef4080e7          	jalr	-268(ra) # 800012fc <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_>
    return 0;
    80001410:	00000513          	li	a0,0
}
    80001414:	03813083          	ld	ra,56(sp)
    80001418:	03013403          	ld	s0,48(sp)
    8000141c:	02813483          	ld	s1,40(sp)
    80001420:	02013903          	ld	s2,32(sp)
    80001424:	01813983          	ld	s3,24(sp)
    80001428:	01013a03          	ld	s4,16(sp)
    8000142c:	00813a83          	ld	s5,8(sp)
    80001430:	04010113          	addi	sp,sp,64
    80001434:	00008067          	ret
        firstFreeBlock = newFreeBlock;
    80001438:	00003797          	auipc	a5,0x3
    8000143c:	0327bc23          	sd	s2,56(a5) # 80004470 <_ZN15MemoryAllocator14firstFreeBlockE>
    return 0;
    80001440:	00000513          	li	a0,0
    80001444:	fd1ff06f          	j	80001414 <_ZN15MemoryAllocator10freeMemoryEPv+0xa8>
        return -1;
    80001448:	fff00513          	li	a0,-1
}
    8000144c:	00008067          	ret

0000000080001450 <_ZN15MemoryAllocator19getLargestFreeBlockEv>:

size_t  MemoryAllocator::getLargestFreeBlock()
{
    80001450:	ff010113          	addi	sp,sp,-16
    80001454:	00813423          	sd	s0,8(sp)
    80001458:	01010413          	addi	s0,sp,16
    size_t largestBlock = firstFreeBlock->numOfBlocks;
    8000145c:	00003797          	auipc	a5,0x3
    80001460:	0147b783          	ld	a5,20(a5) # 80004470 <_ZN15MemoryAllocator14firstFreeBlockE>
    80001464:	0087b503          	ld	a0,8(a5)
    for(FreeBlock* curr = firstFreeBlock->nextBlock; curr; curr = curr->nextBlock)
    80001468:	0107b783          	ld	a5,16(a5)
    8000146c:	0080006f          	j	80001474 <_ZN15MemoryAllocator19getLargestFreeBlockEv+0x24>
    80001470:	0107b783          	ld	a5,16(a5)
    80001474:	00078a63          	beqz	a5,80001488 <_ZN15MemoryAllocator19getLargestFreeBlockEv+0x38>
    {
        if(curr->numOfBlocks > largestBlock)
    80001478:	0087b703          	ld	a4,8(a5)
    8000147c:	fee57ae3          	bgeu	a0,a4,80001470 <_ZN15MemoryAllocator19getLargestFreeBlockEv+0x20>
        {
            largestBlock = curr->numOfBlocks;
    80001480:	00070513          	mv	a0,a4
    80001484:	fedff06f          	j	80001470 <_ZN15MemoryAllocator19getLargestFreeBlockEv+0x20>
        }
    }
    return largestBlock * MEM_BLOCK_SIZE;
}
    80001488:	00651513          	slli	a0,a0,0x6
    8000148c:	00813403          	ld	s0,8(sp)
    80001490:	01010113          	addi	sp,sp,16
    80001494:	00008067          	ret

0000000080001498 <_ZN15MemoryAllocator12getFreeSpaceEv>:
size_t MemoryAllocator::getFreeSpace()
{
    80001498:	ff010113          	addi	sp,sp,-16
    8000149c:	00813423          	sd	s0,8(sp)
    800014a0:	01010413          	addi	s0,sp,16
    return numOfFreeBlocks * MEM_BLOCK_SIZE;
}
    800014a4:	00003517          	auipc	a0,0x3
    800014a8:	fc453503          	ld	a0,-60(a0) # 80004468 <_ZN15MemoryAllocator15numOfFreeBlocksE>
    800014ac:	00651513          	slli	a0,a0,0x6
    800014b0:	00813403          	ld	s0,8(sp)
    800014b4:	01010113          	addi	sp,sp,16
    800014b8:	00008067          	ret

00000000800014bc <start>:
    800014bc:	ff010113          	addi	sp,sp,-16
    800014c0:	00813423          	sd	s0,8(sp)
    800014c4:	01010413          	addi	s0,sp,16
    800014c8:	300027f3          	csrr	a5,mstatus
    800014cc:	ffffe737          	lui	a4,0xffffe
    800014d0:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff912f>
    800014d4:	00e7f7b3          	and	a5,a5,a4
    800014d8:	00001737          	lui	a4,0x1
    800014dc:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    800014e0:	00e7e7b3          	or	a5,a5,a4
    800014e4:	30079073          	csrw	mstatus,a5
    800014e8:	00000797          	auipc	a5,0x0
    800014ec:	16078793          	addi	a5,a5,352 # 80001648 <system_main>
    800014f0:	34179073          	csrw	mepc,a5
    800014f4:	00000793          	li	a5,0
    800014f8:	18079073          	csrw	satp,a5
    800014fc:	000107b7          	lui	a5,0x10
    80001500:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80001504:	30279073          	csrw	medeleg,a5
    80001508:	30379073          	csrw	mideleg,a5
    8000150c:	104027f3          	csrr	a5,sie
    80001510:	2227e793          	ori	a5,a5,546
    80001514:	10479073          	csrw	sie,a5
    80001518:	fff00793          	li	a5,-1
    8000151c:	00a7d793          	srli	a5,a5,0xa
    80001520:	3b079073          	csrw	pmpaddr0,a5
    80001524:	00f00793          	li	a5,15
    80001528:	3a079073          	csrw	pmpcfg0,a5
    8000152c:	f14027f3          	csrr	a5,mhartid
    80001530:	0200c737          	lui	a4,0x200c
    80001534:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80001538:	0007869b          	sext.w	a3,a5
    8000153c:	00269713          	slli	a4,a3,0x2
    80001540:	000f4637          	lui	a2,0xf4
    80001544:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80001548:	00d70733          	add	a4,a4,a3
    8000154c:	0037979b          	slliw	a5,a5,0x3
    80001550:	020046b7          	lui	a3,0x2004
    80001554:	00d787b3          	add	a5,a5,a3
    80001558:	00c585b3          	add	a1,a1,a2
    8000155c:	00371693          	slli	a3,a4,0x3
    80001560:	00003717          	auipc	a4,0x3
    80001564:	f2070713          	addi	a4,a4,-224 # 80004480 <timer_scratch>
    80001568:	00b7b023          	sd	a1,0(a5)
    8000156c:	00d70733          	add	a4,a4,a3
    80001570:	00f73c23          	sd	a5,24(a4)
    80001574:	02c73023          	sd	a2,32(a4)
    80001578:	34071073          	csrw	mscratch,a4
    8000157c:	00000797          	auipc	a5,0x0
    80001580:	6e478793          	addi	a5,a5,1764 # 80001c60 <timervec>
    80001584:	30579073          	csrw	mtvec,a5
    80001588:	300027f3          	csrr	a5,mstatus
    8000158c:	0087e793          	ori	a5,a5,8
    80001590:	30079073          	csrw	mstatus,a5
    80001594:	304027f3          	csrr	a5,mie
    80001598:	0807e793          	ori	a5,a5,128
    8000159c:	30479073          	csrw	mie,a5
    800015a0:	f14027f3          	csrr	a5,mhartid
    800015a4:	0007879b          	sext.w	a5,a5
    800015a8:	00078213          	mv	tp,a5
    800015ac:	30200073          	mret
    800015b0:	00813403          	ld	s0,8(sp)
    800015b4:	01010113          	addi	sp,sp,16
    800015b8:	00008067          	ret

00000000800015bc <timerinit>:
    800015bc:	ff010113          	addi	sp,sp,-16
    800015c0:	00813423          	sd	s0,8(sp)
    800015c4:	01010413          	addi	s0,sp,16
    800015c8:	f14027f3          	csrr	a5,mhartid
    800015cc:	0200c737          	lui	a4,0x200c
    800015d0:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800015d4:	0007869b          	sext.w	a3,a5
    800015d8:	00269713          	slli	a4,a3,0x2
    800015dc:	000f4637          	lui	a2,0xf4
    800015e0:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800015e4:	00d70733          	add	a4,a4,a3
    800015e8:	0037979b          	slliw	a5,a5,0x3
    800015ec:	020046b7          	lui	a3,0x2004
    800015f0:	00d787b3          	add	a5,a5,a3
    800015f4:	00c585b3          	add	a1,a1,a2
    800015f8:	00371693          	slli	a3,a4,0x3
    800015fc:	00003717          	auipc	a4,0x3
    80001600:	e8470713          	addi	a4,a4,-380 # 80004480 <timer_scratch>
    80001604:	00b7b023          	sd	a1,0(a5)
    80001608:	00d70733          	add	a4,a4,a3
    8000160c:	00f73c23          	sd	a5,24(a4)
    80001610:	02c73023          	sd	a2,32(a4)
    80001614:	34071073          	csrw	mscratch,a4
    80001618:	00000797          	auipc	a5,0x0
    8000161c:	64878793          	addi	a5,a5,1608 # 80001c60 <timervec>
    80001620:	30579073          	csrw	mtvec,a5
    80001624:	300027f3          	csrr	a5,mstatus
    80001628:	0087e793          	ori	a5,a5,8
    8000162c:	30079073          	csrw	mstatus,a5
    80001630:	304027f3          	csrr	a5,mie
    80001634:	0807e793          	ori	a5,a5,128
    80001638:	30479073          	csrw	mie,a5
    8000163c:	00813403          	ld	s0,8(sp)
    80001640:	01010113          	addi	sp,sp,16
    80001644:	00008067          	ret

0000000080001648 <system_main>:
    80001648:	fe010113          	addi	sp,sp,-32
    8000164c:	00813823          	sd	s0,16(sp)
    80001650:	00913423          	sd	s1,8(sp)
    80001654:	00113c23          	sd	ra,24(sp)
    80001658:	02010413          	addi	s0,sp,32
    8000165c:	00000097          	auipc	ra,0x0
    80001660:	0c4080e7          	jalr	196(ra) # 80001720 <cpuid>
    80001664:	00003497          	auipc	s1,0x3
    80001668:	dcc48493          	addi	s1,s1,-564 # 80004430 <started>
    8000166c:	02050263          	beqz	a0,80001690 <system_main+0x48>
    80001670:	0004a783          	lw	a5,0(s1)
    80001674:	0007879b          	sext.w	a5,a5
    80001678:	fe078ce3          	beqz	a5,80001670 <system_main+0x28>
    8000167c:	0ff0000f          	fence
    80001680:	00003517          	auipc	a0,0x3
    80001684:	9d050513          	addi	a0,a0,-1584 # 80004050 <CONSOLE_STATUS+0x40>
    80001688:	00001097          	auipc	ra,0x1
    8000168c:	a74080e7          	jalr	-1420(ra) # 800020fc <panic>
    80001690:	00001097          	auipc	ra,0x1
    80001694:	9c8080e7          	jalr	-1592(ra) # 80002058 <consoleinit>
    80001698:	00001097          	auipc	ra,0x1
    8000169c:	154080e7          	jalr	340(ra) # 800027ec <printfinit>
    800016a0:	00003517          	auipc	a0,0x3
    800016a4:	a9050513          	addi	a0,a0,-1392 # 80004130 <CONSOLE_STATUS+0x120>
    800016a8:	00001097          	auipc	ra,0x1
    800016ac:	ab0080e7          	jalr	-1360(ra) # 80002158 <__printf>
    800016b0:	00003517          	auipc	a0,0x3
    800016b4:	97050513          	addi	a0,a0,-1680 # 80004020 <CONSOLE_STATUS+0x10>
    800016b8:	00001097          	auipc	ra,0x1
    800016bc:	aa0080e7          	jalr	-1376(ra) # 80002158 <__printf>
    800016c0:	00003517          	auipc	a0,0x3
    800016c4:	a7050513          	addi	a0,a0,-1424 # 80004130 <CONSOLE_STATUS+0x120>
    800016c8:	00001097          	auipc	ra,0x1
    800016cc:	a90080e7          	jalr	-1392(ra) # 80002158 <__printf>
    800016d0:	00001097          	auipc	ra,0x1
    800016d4:	4a8080e7          	jalr	1192(ra) # 80002b78 <kinit>
    800016d8:	00000097          	auipc	ra,0x0
    800016dc:	148080e7          	jalr	328(ra) # 80001820 <trapinit>
    800016e0:	00000097          	auipc	ra,0x0
    800016e4:	16c080e7          	jalr	364(ra) # 8000184c <trapinithart>
    800016e8:	00000097          	auipc	ra,0x0
    800016ec:	5b8080e7          	jalr	1464(ra) # 80001ca0 <plicinit>
    800016f0:	00000097          	auipc	ra,0x0
    800016f4:	5d8080e7          	jalr	1496(ra) # 80001cc8 <plicinithart>
    800016f8:	00000097          	auipc	ra,0x0
    800016fc:	078080e7          	jalr	120(ra) # 80001770 <userinit>
    80001700:	0ff0000f          	fence
    80001704:	00100793          	li	a5,1
    80001708:	00003517          	auipc	a0,0x3
    8000170c:	93050513          	addi	a0,a0,-1744 # 80004038 <CONSOLE_STATUS+0x28>
    80001710:	00f4a023          	sw	a5,0(s1)
    80001714:	00001097          	auipc	ra,0x1
    80001718:	a44080e7          	jalr	-1468(ra) # 80002158 <__printf>
    8000171c:	0000006f          	j	8000171c <system_main+0xd4>

0000000080001720 <cpuid>:
    80001720:	ff010113          	addi	sp,sp,-16
    80001724:	00813423          	sd	s0,8(sp)
    80001728:	01010413          	addi	s0,sp,16
    8000172c:	00020513          	mv	a0,tp
    80001730:	00813403          	ld	s0,8(sp)
    80001734:	0005051b          	sext.w	a0,a0
    80001738:	01010113          	addi	sp,sp,16
    8000173c:	00008067          	ret

0000000080001740 <mycpu>:
    80001740:	ff010113          	addi	sp,sp,-16
    80001744:	00813423          	sd	s0,8(sp)
    80001748:	01010413          	addi	s0,sp,16
    8000174c:	00020793          	mv	a5,tp
    80001750:	00813403          	ld	s0,8(sp)
    80001754:	0007879b          	sext.w	a5,a5
    80001758:	00779793          	slli	a5,a5,0x7
    8000175c:	00004517          	auipc	a0,0x4
    80001760:	d5450513          	addi	a0,a0,-684 # 800054b0 <cpus>
    80001764:	00f50533          	add	a0,a0,a5
    80001768:	01010113          	addi	sp,sp,16
    8000176c:	00008067          	ret

0000000080001770 <userinit>:
    80001770:	ff010113          	addi	sp,sp,-16
    80001774:	00813423          	sd	s0,8(sp)
    80001778:	01010413          	addi	s0,sp,16
    8000177c:	00813403          	ld	s0,8(sp)
    80001780:	01010113          	addi	sp,sp,16
    80001784:	00000317          	auipc	t1,0x0
    80001788:	87c30067          	jr	-1924(t1) # 80001000 <main>

000000008000178c <either_copyout>:
    8000178c:	ff010113          	addi	sp,sp,-16
    80001790:	00813023          	sd	s0,0(sp)
    80001794:	00113423          	sd	ra,8(sp)
    80001798:	01010413          	addi	s0,sp,16
    8000179c:	02051663          	bnez	a0,800017c8 <either_copyout+0x3c>
    800017a0:	00058513          	mv	a0,a1
    800017a4:	00060593          	mv	a1,a2
    800017a8:	0006861b          	sext.w	a2,a3
    800017ac:	00002097          	auipc	ra,0x2
    800017b0:	c58080e7          	jalr	-936(ra) # 80003404 <__memmove>
    800017b4:	00813083          	ld	ra,8(sp)
    800017b8:	00013403          	ld	s0,0(sp)
    800017bc:	00000513          	li	a0,0
    800017c0:	01010113          	addi	sp,sp,16
    800017c4:	00008067          	ret
    800017c8:	00003517          	auipc	a0,0x3
    800017cc:	8b050513          	addi	a0,a0,-1872 # 80004078 <CONSOLE_STATUS+0x68>
    800017d0:	00001097          	auipc	ra,0x1
    800017d4:	92c080e7          	jalr	-1748(ra) # 800020fc <panic>

00000000800017d8 <either_copyin>:
    800017d8:	ff010113          	addi	sp,sp,-16
    800017dc:	00813023          	sd	s0,0(sp)
    800017e0:	00113423          	sd	ra,8(sp)
    800017e4:	01010413          	addi	s0,sp,16
    800017e8:	02059463          	bnez	a1,80001810 <either_copyin+0x38>
    800017ec:	00060593          	mv	a1,a2
    800017f0:	0006861b          	sext.w	a2,a3
    800017f4:	00002097          	auipc	ra,0x2
    800017f8:	c10080e7          	jalr	-1008(ra) # 80003404 <__memmove>
    800017fc:	00813083          	ld	ra,8(sp)
    80001800:	00013403          	ld	s0,0(sp)
    80001804:	00000513          	li	a0,0
    80001808:	01010113          	addi	sp,sp,16
    8000180c:	00008067          	ret
    80001810:	00003517          	auipc	a0,0x3
    80001814:	89050513          	addi	a0,a0,-1904 # 800040a0 <CONSOLE_STATUS+0x90>
    80001818:	00001097          	auipc	ra,0x1
    8000181c:	8e4080e7          	jalr	-1820(ra) # 800020fc <panic>

0000000080001820 <trapinit>:
    80001820:	ff010113          	addi	sp,sp,-16
    80001824:	00813423          	sd	s0,8(sp)
    80001828:	01010413          	addi	s0,sp,16
    8000182c:	00813403          	ld	s0,8(sp)
    80001830:	00003597          	auipc	a1,0x3
    80001834:	89858593          	addi	a1,a1,-1896 # 800040c8 <CONSOLE_STATUS+0xb8>
    80001838:	00004517          	auipc	a0,0x4
    8000183c:	cf850513          	addi	a0,a0,-776 # 80005530 <tickslock>
    80001840:	01010113          	addi	sp,sp,16
    80001844:	00001317          	auipc	t1,0x1
    80001848:	5c430067          	jr	1476(t1) # 80002e08 <initlock>

000000008000184c <trapinithart>:
    8000184c:	ff010113          	addi	sp,sp,-16
    80001850:	00813423          	sd	s0,8(sp)
    80001854:	01010413          	addi	s0,sp,16
    80001858:	00000797          	auipc	a5,0x0
    8000185c:	2f878793          	addi	a5,a5,760 # 80001b50 <kernelvec>
    80001860:	10579073          	csrw	stvec,a5
    80001864:	00813403          	ld	s0,8(sp)
    80001868:	01010113          	addi	sp,sp,16
    8000186c:	00008067          	ret

0000000080001870 <usertrap>:
    80001870:	ff010113          	addi	sp,sp,-16
    80001874:	00813423          	sd	s0,8(sp)
    80001878:	01010413          	addi	s0,sp,16
    8000187c:	00813403          	ld	s0,8(sp)
    80001880:	01010113          	addi	sp,sp,16
    80001884:	00008067          	ret

0000000080001888 <usertrapret>:
    80001888:	ff010113          	addi	sp,sp,-16
    8000188c:	00813423          	sd	s0,8(sp)
    80001890:	01010413          	addi	s0,sp,16
    80001894:	00813403          	ld	s0,8(sp)
    80001898:	01010113          	addi	sp,sp,16
    8000189c:	00008067          	ret

00000000800018a0 <kerneltrap>:
    800018a0:	fe010113          	addi	sp,sp,-32
    800018a4:	00813823          	sd	s0,16(sp)
    800018a8:	00113c23          	sd	ra,24(sp)
    800018ac:	00913423          	sd	s1,8(sp)
    800018b0:	02010413          	addi	s0,sp,32
    800018b4:	142025f3          	csrr	a1,scause
    800018b8:	100027f3          	csrr	a5,sstatus
    800018bc:	0027f793          	andi	a5,a5,2
    800018c0:	10079c63          	bnez	a5,800019d8 <kerneltrap+0x138>
    800018c4:	142027f3          	csrr	a5,scause
    800018c8:	0207ce63          	bltz	a5,80001904 <kerneltrap+0x64>
    800018cc:	00003517          	auipc	a0,0x3
    800018d0:	84450513          	addi	a0,a0,-1980 # 80004110 <CONSOLE_STATUS+0x100>
    800018d4:	00001097          	auipc	ra,0x1
    800018d8:	884080e7          	jalr	-1916(ra) # 80002158 <__printf>
    800018dc:	141025f3          	csrr	a1,sepc
    800018e0:	14302673          	csrr	a2,stval
    800018e4:	00003517          	auipc	a0,0x3
    800018e8:	83c50513          	addi	a0,a0,-1988 # 80004120 <CONSOLE_STATUS+0x110>
    800018ec:	00001097          	auipc	ra,0x1
    800018f0:	86c080e7          	jalr	-1940(ra) # 80002158 <__printf>
    800018f4:	00003517          	auipc	a0,0x3
    800018f8:	84450513          	addi	a0,a0,-1980 # 80004138 <CONSOLE_STATUS+0x128>
    800018fc:	00001097          	auipc	ra,0x1
    80001900:	800080e7          	jalr	-2048(ra) # 800020fc <panic>
    80001904:	0ff7f713          	andi	a4,a5,255
    80001908:	00900693          	li	a3,9
    8000190c:	04d70063          	beq	a4,a3,8000194c <kerneltrap+0xac>
    80001910:	fff00713          	li	a4,-1
    80001914:	03f71713          	slli	a4,a4,0x3f
    80001918:	00170713          	addi	a4,a4,1
    8000191c:	fae798e3          	bne	a5,a4,800018cc <kerneltrap+0x2c>
    80001920:	00000097          	auipc	ra,0x0
    80001924:	e00080e7          	jalr	-512(ra) # 80001720 <cpuid>
    80001928:	06050663          	beqz	a0,80001994 <kerneltrap+0xf4>
    8000192c:	144027f3          	csrr	a5,sip
    80001930:	ffd7f793          	andi	a5,a5,-3
    80001934:	14479073          	csrw	sip,a5
    80001938:	01813083          	ld	ra,24(sp)
    8000193c:	01013403          	ld	s0,16(sp)
    80001940:	00813483          	ld	s1,8(sp)
    80001944:	02010113          	addi	sp,sp,32
    80001948:	00008067          	ret
    8000194c:	00000097          	auipc	ra,0x0
    80001950:	3c8080e7          	jalr	968(ra) # 80001d14 <plic_claim>
    80001954:	00a00793          	li	a5,10
    80001958:	00050493          	mv	s1,a0
    8000195c:	06f50863          	beq	a0,a5,800019cc <kerneltrap+0x12c>
    80001960:	fc050ce3          	beqz	a0,80001938 <kerneltrap+0x98>
    80001964:	00050593          	mv	a1,a0
    80001968:	00002517          	auipc	a0,0x2
    8000196c:	78850513          	addi	a0,a0,1928 # 800040f0 <CONSOLE_STATUS+0xe0>
    80001970:	00000097          	auipc	ra,0x0
    80001974:	7e8080e7          	jalr	2024(ra) # 80002158 <__printf>
    80001978:	01013403          	ld	s0,16(sp)
    8000197c:	01813083          	ld	ra,24(sp)
    80001980:	00048513          	mv	a0,s1
    80001984:	00813483          	ld	s1,8(sp)
    80001988:	02010113          	addi	sp,sp,32
    8000198c:	00000317          	auipc	t1,0x0
    80001990:	3c030067          	jr	960(t1) # 80001d4c <plic_complete>
    80001994:	00004517          	auipc	a0,0x4
    80001998:	b9c50513          	addi	a0,a0,-1124 # 80005530 <tickslock>
    8000199c:	00001097          	auipc	ra,0x1
    800019a0:	490080e7          	jalr	1168(ra) # 80002e2c <acquire>
    800019a4:	00003717          	auipc	a4,0x3
    800019a8:	a9070713          	addi	a4,a4,-1392 # 80004434 <ticks>
    800019ac:	00072783          	lw	a5,0(a4)
    800019b0:	00004517          	auipc	a0,0x4
    800019b4:	b8050513          	addi	a0,a0,-1152 # 80005530 <tickslock>
    800019b8:	0017879b          	addiw	a5,a5,1
    800019bc:	00f72023          	sw	a5,0(a4)
    800019c0:	00001097          	auipc	ra,0x1
    800019c4:	538080e7          	jalr	1336(ra) # 80002ef8 <release>
    800019c8:	f65ff06f          	j	8000192c <kerneltrap+0x8c>
    800019cc:	00001097          	auipc	ra,0x1
    800019d0:	094080e7          	jalr	148(ra) # 80002a60 <uartintr>
    800019d4:	fa5ff06f          	j	80001978 <kerneltrap+0xd8>
    800019d8:	00002517          	auipc	a0,0x2
    800019dc:	6f850513          	addi	a0,a0,1784 # 800040d0 <CONSOLE_STATUS+0xc0>
    800019e0:	00000097          	auipc	ra,0x0
    800019e4:	71c080e7          	jalr	1820(ra) # 800020fc <panic>

00000000800019e8 <clockintr>:
    800019e8:	fe010113          	addi	sp,sp,-32
    800019ec:	00813823          	sd	s0,16(sp)
    800019f0:	00913423          	sd	s1,8(sp)
    800019f4:	00113c23          	sd	ra,24(sp)
    800019f8:	02010413          	addi	s0,sp,32
    800019fc:	00004497          	auipc	s1,0x4
    80001a00:	b3448493          	addi	s1,s1,-1228 # 80005530 <tickslock>
    80001a04:	00048513          	mv	a0,s1
    80001a08:	00001097          	auipc	ra,0x1
    80001a0c:	424080e7          	jalr	1060(ra) # 80002e2c <acquire>
    80001a10:	00003717          	auipc	a4,0x3
    80001a14:	a2470713          	addi	a4,a4,-1500 # 80004434 <ticks>
    80001a18:	00072783          	lw	a5,0(a4)
    80001a1c:	01013403          	ld	s0,16(sp)
    80001a20:	01813083          	ld	ra,24(sp)
    80001a24:	00048513          	mv	a0,s1
    80001a28:	0017879b          	addiw	a5,a5,1
    80001a2c:	00813483          	ld	s1,8(sp)
    80001a30:	00f72023          	sw	a5,0(a4)
    80001a34:	02010113          	addi	sp,sp,32
    80001a38:	00001317          	auipc	t1,0x1
    80001a3c:	4c030067          	jr	1216(t1) # 80002ef8 <release>

0000000080001a40 <devintr>:
    80001a40:	142027f3          	csrr	a5,scause
    80001a44:	00000513          	li	a0,0
    80001a48:	0007c463          	bltz	a5,80001a50 <devintr+0x10>
    80001a4c:	00008067          	ret
    80001a50:	fe010113          	addi	sp,sp,-32
    80001a54:	00813823          	sd	s0,16(sp)
    80001a58:	00113c23          	sd	ra,24(sp)
    80001a5c:	00913423          	sd	s1,8(sp)
    80001a60:	02010413          	addi	s0,sp,32
    80001a64:	0ff7f713          	andi	a4,a5,255
    80001a68:	00900693          	li	a3,9
    80001a6c:	04d70c63          	beq	a4,a3,80001ac4 <devintr+0x84>
    80001a70:	fff00713          	li	a4,-1
    80001a74:	03f71713          	slli	a4,a4,0x3f
    80001a78:	00170713          	addi	a4,a4,1
    80001a7c:	00e78c63          	beq	a5,a4,80001a94 <devintr+0x54>
    80001a80:	01813083          	ld	ra,24(sp)
    80001a84:	01013403          	ld	s0,16(sp)
    80001a88:	00813483          	ld	s1,8(sp)
    80001a8c:	02010113          	addi	sp,sp,32
    80001a90:	00008067          	ret
    80001a94:	00000097          	auipc	ra,0x0
    80001a98:	c8c080e7          	jalr	-884(ra) # 80001720 <cpuid>
    80001a9c:	06050663          	beqz	a0,80001b08 <devintr+0xc8>
    80001aa0:	144027f3          	csrr	a5,sip
    80001aa4:	ffd7f793          	andi	a5,a5,-3
    80001aa8:	14479073          	csrw	sip,a5
    80001aac:	01813083          	ld	ra,24(sp)
    80001ab0:	01013403          	ld	s0,16(sp)
    80001ab4:	00813483          	ld	s1,8(sp)
    80001ab8:	00200513          	li	a0,2
    80001abc:	02010113          	addi	sp,sp,32
    80001ac0:	00008067          	ret
    80001ac4:	00000097          	auipc	ra,0x0
    80001ac8:	250080e7          	jalr	592(ra) # 80001d14 <plic_claim>
    80001acc:	00a00793          	li	a5,10
    80001ad0:	00050493          	mv	s1,a0
    80001ad4:	06f50663          	beq	a0,a5,80001b40 <devintr+0x100>
    80001ad8:	00100513          	li	a0,1
    80001adc:	fa0482e3          	beqz	s1,80001a80 <devintr+0x40>
    80001ae0:	00048593          	mv	a1,s1
    80001ae4:	00002517          	auipc	a0,0x2
    80001ae8:	60c50513          	addi	a0,a0,1548 # 800040f0 <CONSOLE_STATUS+0xe0>
    80001aec:	00000097          	auipc	ra,0x0
    80001af0:	66c080e7          	jalr	1644(ra) # 80002158 <__printf>
    80001af4:	00048513          	mv	a0,s1
    80001af8:	00000097          	auipc	ra,0x0
    80001afc:	254080e7          	jalr	596(ra) # 80001d4c <plic_complete>
    80001b00:	00100513          	li	a0,1
    80001b04:	f7dff06f          	j	80001a80 <devintr+0x40>
    80001b08:	00004517          	auipc	a0,0x4
    80001b0c:	a2850513          	addi	a0,a0,-1496 # 80005530 <tickslock>
    80001b10:	00001097          	auipc	ra,0x1
    80001b14:	31c080e7          	jalr	796(ra) # 80002e2c <acquire>
    80001b18:	00003717          	auipc	a4,0x3
    80001b1c:	91c70713          	addi	a4,a4,-1764 # 80004434 <ticks>
    80001b20:	00072783          	lw	a5,0(a4)
    80001b24:	00004517          	auipc	a0,0x4
    80001b28:	a0c50513          	addi	a0,a0,-1524 # 80005530 <tickslock>
    80001b2c:	0017879b          	addiw	a5,a5,1
    80001b30:	00f72023          	sw	a5,0(a4)
    80001b34:	00001097          	auipc	ra,0x1
    80001b38:	3c4080e7          	jalr	964(ra) # 80002ef8 <release>
    80001b3c:	f65ff06f          	j	80001aa0 <devintr+0x60>
    80001b40:	00001097          	auipc	ra,0x1
    80001b44:	f20080e7          	jalr	-224(ra) # 80002a60 <uartintr>
    80001b48:	fadff06f          	j	80001af4 <devintr+0xb4>
    80001b4c:	0000                	unimp
	...

0000000080001b50 <kernelvec>:
    80001b50:	f0010113          	addi	sp,sp,-256
    80001b54:	00113023          	sd	ra,0(sp)
    80001b58:	00213423          	sd	sp,8(sp)
    80001b5c:	00313823          	sd	gp,16(sp)
    80001b60:	00413c23          	sd	tp,24(sp)
    80001b64:	02513023          	sd	t0,32(sp)
    80001b68:	02613423          	sd	t1,40(sp)
    80001b6c:	02713823          	sd	t2,48(sp)
    80001b70:	02813c23          	sd	s0,56(sp)
    80001b74:	04913023          	sd	s1,64(sp)
    80001b78:	04a13423          	sd	a0,72(sp)
    80001b7c:	04b13823          	sd	a1,80(sp)
    80001b80:	04c13c23          	sd	a2,88(sp)
    80001b84:	06d13023          	sd	a3,96(sp)
    80001b88:	06e13423          	sd	a4,104(sp)
    80001b8c:	06f13823          	sd	a5,112(sp)
    80001b90:	07013c23          	sd	a6,120(sp)
    80001b94:	09113023          	sd	a7,128(sp)
    80001b98:	09213423          	sd	s2,136(sp)
    80001b9c:	09313823          	sd	s3,144(sp)
    80001ba0:	09413c23          	sd	s4,152(sp)
    80001ba4:	0b513023          	sd	s5,160(sp)
    80001ba8:	0b613423          	sd	s6,168(sp)
    80001bac:	0b713823          	sd	s7,176(sp)
    80001bb0:	0b813c23          	sd	s8,184(sp)
    80001bb4:	0d913023          	sd	s9,192(sp)
    80001bb8:	0da13423          	sd	s10,200(sp)
    80001bbc:	0db13823          	sd	s11,208(sp)
    80001bc0:	0dc13c23          	sd	t3,216(sp)
    80001bc4:	0fd13023          	sd	t4,224(sp)
    80001bc8:	0fe13423          	sd	t5,232(sp)
    80001bcc:	0ff13823          	sd	t6,240(sp)
    80001bd0:	cd1ff0ef          	jal	ra,800018a0 <kerneltrap>
    80001bd4:	00013083          	ld	ra,0(sp)
    80001bd8:	00813103          	ld	sp,8(sp)
    80001bdc:	01013183          	ld	gp,16(sp)
    80001be0:	02013283          	ld	t0,32(sp)
    80001be4:	02813303          	ld	t1,40(sp)
    80001be8:	03013383          	ld	t2,48(sp)
    80001bec:	03813403          	ld	s0,56(sp)
    80001bf0:	04013483          	ld	s1,64(sp)
    80001bf4:	04813503          	ld	a0,72(sp)
    80001bf8:	05013583          	ld	a1,80(sp)
    80001bfc:	05813603          	ld	a2,88(sp)
    80001c00:	06013683          	ld	a3,96(sp)
    80001c04:	06813703          	ld	a4,104(sp)
    80001c08:	07013783          	ld	a5,112(sp)
    80001c0c:	07813803          	ld	a6,120(sp)
    80001c10:	08013883          	ld	a7,128(sp)
    80001c14:	08813903          	ld	s2,136(sp)
    80001c18:	09013983          	ld	s3,144(sp)
    80001c1c:	09813a03          	ld	s4,152(sp)
    80001c20:	0a013a83          	ld	s5,160(sp)
    80001c24:	0a813b03          	ld	s6,168(sp)
    80001c28:	0b013b83          	ld	s7,176(sp)
    80001c2c:	0b813c03          	ld	s8,184(sp)
    80001c30:	0c013c83          	ld	s9,192(sp)
    80001c34:	0c813d03          	ld	s10,200(sp)
    80001c38:	0d013d83          	ld	s11,208(sp)
    80001c3c:	0d813e03          	ld	t3,216(sp)
    80001c40:	0e013e83          	ld	t4,224(sp)
    80001c44:	0e813f03          	ld	t5,232(sp)
    80001c48:	0f013f83          	ld	t6,240(sp)
    80001c4c:	10010113          	addi	sp,sp,256
    80001c50:	10200073          	sret
    80001c54:	00000013          	nop
    80001c58:	00000013          	nop
    80001c5c:	00000013          	nop

0000000080001c60 <timervec>:
    80001c60:	34051573          	csrrw	a0,mscratch,a0
    80001c64:	00b53023          	sd	a1,0(a0)
    80001c68:	00c53423          	sd	a2,8(a0)
    80001c6c:	00d53823          	sd	a3,16(a0)
    80001c70:	01853583          	ld	a1,24(a0)
    80001c74:	02053603          	ld	a2,32(a0)
    80001c78:	0005b683          	ld	a3,0(a1)
    80001c7c:	00c686b3          	add	a3,a3,a2
    80001c80:	00d5b023          	sd	a3,0(a1)
    80001c84:	00200593          	li	a1,2
    80001c88:	14459073          	csrw	sip,a1
    80001c8c:	01053683          	ld	a3,16(a0)
    80001c90:	00853603          	ld	a2,8(a0)
    80001c94:	00053583          	ld	a1,0(a0)
    80001c98:	34051573          	csrrw	a0,mscratch,a0
    80001c9c:	30200073          	mret

0000000080001ca0 <plicinit>:
    80001ca0:	ff010113          	addi	sp,sp,-16
    80001ca4:	00813423          	sd	s0,8(sp)
    80001ca8:	01010413          	addi	s0,sp,16
    80001cac:	00813403          	ld	s0,8(sp)
    80001cb0:	0c0007b7          	lui	a5,0xc000
    80001cb4:	00100713          	li	a4,1
    80001cb8:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    80001cbc:	00e7a223          	sw	a4,4(a5)
    80001cc0:	01010113          	addi	sp,sp,16
    80001cc4:	00008067          	ret

0000000080001cc8 <plicinithart>:
    80001cc8:	ff010113          	addi	sp,sp,-16
    80001ccc:	00813023          	sd	s0,0(sp)
    80001cd0:	00113423          	sd	ra,8(sp)
    80001cd4:	01010413          	addi	s0,sp,16
    80001cd8:	00000097          	auipc	ra,0x0
    80001cdc:	a48080e7          	jalr	-1464(ra) # 80001720 <cpuid>
    80001ce0:	0085171b          	slliw	a4,a0,0x8
    80001ce4:	0c0027b7          	lui	a5,0xc002
    80001ce8:	00e787b3          	add	a5,a5,a4
    80001cec:	40200713          	li	a4,1026
    80001cf0:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80001cf4:	00813083          	ld	ra,8(sp)
    80001cf8:	00013403          	ld	s0,0(sp)
    80001cfc:	00d5151b          	slliw	a0,a0,0xd
    80001d00:	0c2017b7          	lui	a5,0xc201
    80001d04:	00a78533          	add	a0,a5,a0
    80001d08:	00052023          	sw	zero,0(a0)
    80001d0c:	01010113          	addi	sp,sp,16
    80001d10:	00008067          	ret

0000000080001d14 <plic_claim>:
    80001d14:	ff010113          	addi	sp,sp,-16
    80001d18:	00813023          	sd	s0,0(sp)
    80001d1c:	00113423          	sd	ra,8(sp)
    80001d20:	01010413          	addi	s0,sp,16
    80001d24:	00000097          	auipc	ra,0x0
    80001d28:	9fc080e7          	jalr	-1540(ra) # 80001720 <cpuid>
    80001d2c:	00813083          	ld	ra,8(sp)
    80001d30:	00013403          	ld	s0,0(sp)
    80001d34:	00d5151b          	slliw	a0,a0,0xd
    80001d38:	0c2017b7          	lui	a5,0xc201
    80001d3c:	00a78533          	add	a0,a5,a0
    80001d40:	00452503          	lw	a0,4(a0)
    80001d44:	01010113          	addi	sp,sp,16
    80001d48:	00008067          	ret

0000000080001d4c <plic_complete>:
    80001d4c:	fe010113          	addi	sp,sp,-32
    80001d50:	00813823          	sd	s0,16(sp)
    80001d54:	00913423          	sd	s1,8(sp)
    80001d58:	00113c23          	sd	ra,24(sp)
    80001d5c:	02010413          	addi	s0,sp,32
    80001d60:	00050493          	mv	s1,a0
    80001d64:	00000097          	auipc	ra,0x0
    80001d68:	9bc080e7          	jalr	-1604(ra) # 80001720 <cpuid>
    80001d6c:	01813083          	ld	ra,24(sp)
    80001d70:	01013403          	ld	s0,16(sp)
    80001d74:	00d5179b          	slliw	a5,a0,0xd
    80001d78:	0c201737          	lui	a4,0xc201
    80001d7c:	00f707b3          	add	a5,a4,a5
    80001d80:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80001d84:	00813483          	ld	s1,8(sp)
    80001d88:	02010113          	addi	sp,sp,32
    80001d8c:	00008067          	ret

0000000080001d90 <consolewrite>:
    80001d90:	fb010113          	addi	sp,sp,-80
    80001d94:	04813023          	sd	s0,64(sp)
    80001d98:	04113423          	sd	ra,72(sp)
    80001d9c:	02913c23          	sd	s1,56(sp)
    80001da0:	03213823          	sd	s2,48(sp)
    80001da4:	03313423          	sd	s3,40(sp)
    80001da8:	03413023          	sd	s4,32(sp)
    80001dac:	01513c23          	sd	s5,24(sp)
    80001db0:	05010413          	addi	s0,sp,80
    80001db4:	06c05c63          	blez	a2,80001e2c <consolewrite+0x9c>
    80001db8:	00060993          	mv	s3,a2
    80001dbc:	00050a13          	mv	s4,a0
    80001dc0:	00058493          	mv	s1,a1
    80001dc4:	00000913          	li	s2,0
    80001dc8:	fff00a93          	li	s5,-1
    80001dcc:	01c0006f          	j	80001de8 <consolewrite+0x58>
    80001dd0:	fbf44503          	lbu	a0,-65(s0)
    80001dd4:	0019091b          	addiw	s2,s2,1
    80001dd8:	00148493          	addi	s1,s1,1
    80001ddc:	00001097          	auipc	ra,0x1
    80001de0:	a9c080e7          	jalr	-1380(ra) # 80002878 <uartputc>
    80001de4:	03298063          	beq	s3,s2,80001e04 <consolewrite+0x74>
    80001de8:	00048613          	mv	a2,s1
    80001dec:	00100693          	li	a3,1
    80001df0:	000a0593          	mv	a1,s4
    80001df4:	fbf40513          	addi	a0,s0,-65
    80001df8:	00000097          	auipc	ra,0x0
    80001dfc:	9e0080e7          	jalr	-1568(ra) # 800017d8 <either_copyin>
    80001e00:	fd5518e3          	bne	a0,s5,80001dd0 <consolewrite+0x40>
    80001e04:	04813083          	ld	ra,72(sp)
    80001e08:	04013403          	ld	s0,64(sp)
    80001e0c:	03813483          	ld	s1,56(sp)
    80001e10:	02813983          	ld	s3,40(sp)
    80001e14:	02013a03          	ld	s4,32(sp)
    80001e18:	01813a83          	ld	s5,24(sp)
    80001e1c:	00090513          	mv	a0,s2
    80001e20:	03013903          	ld	s2,48(sp)
    80001e24:	05010113          	addi	sp,sp,80
    80001e28:	00008067          	ret
    80001e2c:	00000913          	li	s2,0
    80001e30:	fd5ff06f          	j	80001e04 <consolewrite+0x74>

0000000080001e34 <consoleread>:
    80001e34:	f9010113          	addi	sp,sp,-112
    80001e38:	06813023          	sd	s0,96(sp)
    80001e3c:	04913c23          	sd	s1,88(sp)
    80001e40:	05213823          	sd	s2,80(sp)
    80001e44:	05313423          	sd	s3,72(sp)
    80001e48:	05413023          	sd	s4,64(sp)
    80001e4c:	03513c23          	sd	s5,56(sp)
    80001e50:	03613823          	sd	s6,48(sp)
    80001e54:	03713423          	sd	s7,40(sp)
    80001e58:	03813023          	sd	s8,32(sp)
    80001e5c:	06113423          	sd	ra,104(sp)
    80001e60:	01913c23          	sd	s9,24(sp)
    80001e64:	07010413          	addi	s0,sp,112
    80001e68:	00060b93          	mv	s7,a2
    80001e6c:	00050913          	mv	s2,a0
    80001e70:	00058c13          	mv	s8,a1
    80001e74:	00060b1b          	sext.w	s6,a2
    80001e78:	00003497          	auipc	s1,0x3
    80001e7c:	6d048493          	addi	s1,s1,1744 # 80005548 <cons>
    80001e80:	00400993          	li	s3,4
    80001e84:	fff00a13          	li	s4,-1
    80001e88:	00a00a93          	li	s5,10
    80001e8c:	05705e63          	blez	s7,80001ee8 <consoleread+0xb4>
    80001e90:	09c4a703          	lw	a4,156(s1)
    80001e94:	0984a783          	lw	a5,152(s1)
    80001e98:	0007071b          	sext.w	a4,a4
    80001e9c:	08e78463          	beq	a5,a4,80001f24 <consoleread+0xf0>
    80001ea0:	07f7f713          	andi	a4,a5,127
    80001ea4:	00e48733          	add	a4,s1,a4
    80001ea8:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    80001eac:	0017869b          	addiw	a3,a5,1
    80001eb0:	08d4ac23          	sw	a3,152(s1)
    80001eb4:	00070c9b          	sext.w	s9,a4
    80001eb8:	0b370663          	beq	a4,s3,80001f64 <consoleread+0x130>
    80001ebc:	00100693          	li	a3,1
    80001ec0:	f9f40613          	addi	a2,s0,-97
    80001ec4:	000c0593          	mv	a1,s8
    80001ec8:	00090513          	mv	a0,s2
    80001ecc:	f8e40fa3          	sb	a4,-97(s0)
    80001ed0:	00000097          	auipc	ra,0x0
    80001ed4:	8bc080e7          	jalr	-1860(ra) # 8000178c <either_copyout>
    80001ed8:	01450863          	beq	a0,s4,80001ee8 <consoleread+0xb4>
    80001edc:	001c0c13          	addi	s8,s8,1
    80001ee0:	fffb8b9b          	addiw	s7,s7,-1
    80001ee4:	fb5c94e3          	bne	s9,s5,80001e8c <consoleread+0x58>
    80001ee8:	000b851b          	sext.w	a0,s7
    80001eec:	06813083          	ld	ra,104(sp)
    80001ef0:	06013403          	ld	s0,96(sp)
    80001ef4:	05813483          	ld	s1,88(sp)
    80001ef8:	05013903          	ld	s2,80(sp)
    80001efc:	04813983          	ld	s3,72(sp)
    80001f00:	04013a03          	ld	s4,64(sp)
    80001f04:	03813a83          	ld	s5,56(sp)
    80001f08:	02813b83          	ld	s7,40(sp)
    80001f0c:	02013c03          	ld	s8,32(sp)
    80001f10:	01813c83          	ld	s9,24(sp)
    80001f14:	40ab053b          	subw	a0,s6,a0
    80001f18:	03013b03          	ld	s6,48(sp)
    80001f1c:	07010113          	addi	sp,sp,112
    80001f20:	00008067          	ret
    80001f24:	00001097          	auipc	ra,0x1
    80001f28:	1d8080e7          	jalr	472(ra) # 800030fc <push_on>
    80001f2c:	0984a703          	lw	a4,152(s1)
    80001f30:	09c4a783          	lw	a5,156(s1)
    80001f34:	0007879b          	sext.w	a5,a5
    80001f38:	fef70ce3          	beq	a4,a5,80001f30 <consoleread+0xfc>
    80001f3c:	00001097          	auipc	ra,0x1
    80001f40:	234080e7          	jalr	564(ra) # 80003170 <pop_on>
    80001f44:	0984a783          	lw	a5,152(s1)
    80001f48:	07f7f713          	andi	a4,a5,127
    80001f4c:	00e48733          	add	a4,s1,a4
    80001f50:	01874703          	lbu	a4,24(a4)
    80001f54:	0017869b          	addiw	a3,a5,1
    80001f58:	08d4ac23          	sw	a3,152(s1)
    80001f5c:	00070c9b          	sext.w	s9,a4
    80001f60:	f5371ee3          	bne	a4,s3,80001ebc <consoleread+0x88>
    80001f64:	000b851b          	sext.w	a0,s7
    80001f68:	f96bf2e3          	bgeu	s7,s6,80001eec <consoleread+0xb8>
    80001f6c:	08f4ac23          	sw	a5,152(s1)
    80001f70:	f7dff06f          	j	80001eec <consoleread+0xb8>

0000000080001f74 <consputc>:
    80001f74:	10000793          	li	a5,256
    80001f78:	00f50663          	beq	a0,a5,80001f84 <consputc+0x10>
    80001f7c:	00001317          	auipc	t1,0x1
    80001f80:	9f430067          	jr	-1548(t1) # 80002970 <uartputc_sync>
    80001f84:	ff010113          	addi	sp,sp,-16
    80001f88:	00113423          	sd	ra,8(sp)
    80001f8c:	00813023          	sd	s0,0(sp)
    80001f90:	01010413          	addi	s0,sp,16
    80001f94:	00800513          	li	a0,8
    80001f98:	00001097          	auipc	ra,0x1
    80001f9c:	9d8080e7          	jalr	-1576(ra) # 80002970 <uartputc_sync>
    80001fa0:	02000513          	li	a0,32
    80001fa4:	00001097          	auipc	ra,0x1
    80001fa8:	9cc080e7          	jalr	-1588(ra) # 80002970 <uartputc_sync>
    80001fac:	00013403          	ld	s0,0(sp)
    80001fb0:	00813083          	ld	ra,8(sp)
    80001fb4:	00800513          	li	a0,8
    80001fb8:	01010113          	addi	sp,sp,16
    80001fbc:	00001317          	auipc	t1,0x1
    80001fc0:	9b430067          	jr	-1612(t1) # 80002970 <uartputc_sync>

0000000080001fc4 <consoleintr>:
    80001fc4:	fe010113          	addi	sp,sp,-32
    80001fc8:	00813823          	sd	s0,16(sp)
    80001fcc:	00913423          	sd	s1,8(sp)
    80001fd0:	01213023          	sd	s2,0(sp)
    80001fd4:	00113c23          	sd	ra,24(sp)
    80001fd8:	02010413          	addi	s0,sp,32
    80001fdc:	00003917          	auipc	s2,0x3
    80001fe0:	56c90913          	addi	s2,s2,1388 # 80005548 <cons>
    80001fe4:	00050493          	mv	s1,a0
    80001fe8:	00090513          	mv	a0,s2
    80001fec:	00001097          	auipc	ra,0x1
    80001ff0:	e40080e7          	jalr	-448(ra) # 80002e2c <acquire>
    80001ff4:	02048c63          	beqz	s1,8000202c <consoleintr+0x68>
    80001ff8:	0a092783          	lw	a5,160(s2)
    80001ffc:	09892703          	lw	a4,152(s2)
    80002000:	07f00693          	li	a3,127
    80002004:	40e7873b          	subw	a4,a5,a4
    80002008:	02e6e263          	bltu	a3,a4,8000202c <consoleintr+0x68>
    8000200c:	00d00713          	li	a4,13
    80002010:	04e48063          	beq	s1,a4,80002050 <consoleintr+0x8c>
    80002014:	07f7f713          	andi	a4,a5,127
    80002018:	00e90733          	add	a4,s2,a4
    8000201c:	0017879b          	addiw	a5,a5,1
    80002020:	0af92023          	sw	a5,160(s2)
    80002024:	00970c23          	sb	s1,24(a4)
    80002028:	08f92e23          	sw	a5,156(s2)
    8000202c:	01013403          	ld	s0,16(sp)
    80002030:	01813083          	ld	ra,24(sp)
    80002034:	00813483          	ld	s1,8(sp)
    80002038:	00013903          	ld	s2,0(sp)
    8000203c:	00003517          	auipc	a0,0x3
    80002040:	50c50513          	addi	a0,a0,1292 # 80005548 <cons>
    80002044:	02010113          	addi	sp,sp,32
    80002048:	00001317          	auipc	t1,0x1
    8000204c:	eb030067          	jr	-336(t1) # 80002ef8 <release>
    80002050:	00a00493          	li	s1,10
    80002054:	fc1ff06f          	j	80002014 <consoleintr+0x50>

0000000080002058 <consoleinit>:
    80002058:	fe010113          	addi	sp,sp,-32
    8000205c:	00113c23          	sd	ra,24(sp)
    80002060:	00813823          	sd	s0,16(sp)
    80002064:	00913423          	sd	s1,8(sp)
    80002068:	02010413          	addi	s0,sp,32
    8000206c:	00003497          	auipc	s1,0x3
    80002070:	4dc48493          	addi	s1,s1,1244 # 80005548 <cons>
    80002074:	00048513          	mv	a0,s1
    80002078:	00002597          	auipc	a1,0x2
    8000207c:	0d058593          	addi	a1,a1,208 # 80004148 <CONSOLE_STATUS+0x138>
    80002080:	00001097          	auipc	ra,0x1
    80002084:	d88080e7          	jalr	-632(ra) # 80002e08 <initlock>
    80002088:	00000097          	auipc	ra,0x0
    8000208c:	7ac080e7          	jalr	1964(ra) # 80002834 <uartinit>
    80002090:	01813083          	ld	ra,24(sp)
    80002094:	01013403          	ld	s0,16(sp)
    80002098:	00000797          	auipc	a5,0x0
    8000209c:	d9c78793          	addi	a5,a5,-612 # 80001e34 <consoleread>
    800020a0:	0af4bc23          	sd	a5,184(s1)
    800020a4:	00000797          	auipc	a5,0x0
    800020a8:	cec78793          	addi	a5,a5,-788 # 80001d90 <consolewrite>
    800020ac:	0cf4b023          	sd	a5,192(s1)
    800020b0:	00813483          	ld	s1,8(sp)
    800020b4:	02010113          	addi	sp,sp,32
    800020b8:	00008067          	ret

00000000800020bc <console_read>:
    800020bc:	ff010113          	addi	sp,sp,-16
    800020c0:	00813423          	sd	s0,8(sp)
    800020c4:	01010413          	addi	s0,sp,16
    800020c8:	00813403          	ld	s0,8(sp)
    800020cc:	00003317          	auipc	t1,0x3
    800020d0:	53433303          	ld	t1,1332(t1) # 80005600 <devsw+0x10>
    800020d4:	01010113          	addi	sp,sp,16
    800020d8:	00030067          	jr	t1

00000000800020dc <console_write>:
    800020dc:	ff010113          	addi	sp,sp,-16
    800020e0:	00813423          	sd	s0,8(sp)
    800020e4:	01010413          	addi	s0,sp,16
    800020e8:	00813403          	ld	s0,8(sp)
    800020ec:	00003317          	auipc	t1,0x3
    800020f0:	51c33303          	ld	t1,1308(t1) # 80005608 <devsw+0x18>
    800020f4:	01010113          	addi	sp,sp,16
    800020f8:	00030067          	jr	t1

00000000800020fc <panic>:
    800020fc:	fe010113          	addi	sp,sp,-32
    80002100:	00113c23          	sd	ra,24(sp)
    80002104:	00813823          	sd	s0,16(sp)
    80002108:	00913423          	sd	s1,8(sp)
    8000210c:	02010413          	addi	s0,sp,32
    80002110:	00050493          	mv	s1,a0
    80002114:	00002517          	auipc	a0,0x2
    80002118:	03c50513          	addi	a0,a0,60 # 80004150 <CONSOLE_STATUS+0x140>
    8000211c:	00003797          	auipc	a5,0x3
    80002120:	5807a623          	sw	zero,1420(a5) # 800056a8 <pr+0x18>
    80002124:	00000097          	auipc	ra,0x0
    80002128:	034080e7          	jalr	52(ra) # 80002158 <__printf>
    8000212c:	00048513          	mv	a0,s1
    80002130:	00000097          	auipc	ra,0x0
    80002134:	028080e7          	jalr	40(ra) # 80002158 <__printf>
    80002138:	00002517          	auipc	a0,0x2
    8000213c:	ff850513          	addi	a0,a0,-8 # 80004130 <CONSOLE_STATUS+0x120>
    80002140:	00000097          	auipc	ra,0x0
    80002144:	018080e7          	jalr	24(ra) # 80002158 <__printf>
    80002148:	00100793          	li	a5,1
    8000214c:	00002717          	auipc	a4,0x2
    80002150:	2ef72623          	sw	a5,748(a4) # 80004438 <panicked>
    80002154:	0000006f          	j	80002154 <panic+0x58>

0000000080002158 <__printf>:
    80002158:	f3010113          	addi	sp,sp,-208
    8000215c:	08813023          	sd	s0,128(sp)
    80002160:	07313423          	sd	s3,104(sp)
    80002164:	09010413          	addi	s0,sp,144
    80002168:	05813023          	sd	s8,64(sp)
    8000216c:	08113423          	sd	ra,136(sp)
    80002170:	06913c23          	sd	s1,120(sp)
    80002174:	07213823          	sd	s2,112(sp)
    80002178:	07413023          	sd	s4,96(sp)
    8000217c:	05513c23          	sd	s5,88(sp)
    80002180:	05613823          	sd	s6,80(sp)
    80002184:	05713423          	sd	s7,72(sp)
    80002188:	03913c23          	sd	s9,56(sp)
    8000218c:	03a13823          	sd	s10,48(sp)
    80002190:	03b13423          	sd	s11,40(sp)
    80002194:	00003317          	auipc	t1,0x3
    80002198:	4fc30313          	addi	t1,t1,1276 # 80005690 <pr>
    8000219c:	01832c03          	lw	s8,24(t1)
    800021a0:	00b43423          	sd	a1,8(s0)
    800021a4:	00c43823          	sd	a2,16(s0)
    800021a8:	00d43c23          	sd	a3,24(s0)
    800021ac:	02e43023          	sd	a4,32(s0)
    800021b0:	02f43423          	sd	a5,40(s0)
    800021b4:	03043823          	sd	a6,48(s0)
    800021b8:	03143c23          	sd	a7,56(s0)
    800021bc:	00050993          	mv	s3,a0
    800021c0:	4a0c1663          	bnez	s8,8000266c <__printf+0x514>
    800021c4:	60098c63          	beqz	s3,800027dc <__printf+0x684>
    800021c8:	0009c503          	lbu	a0,0(s3)
    800021cc:	00840793          	addi	a5,s0,8
    800021d0:	f6f43c23          	sd	a5,-136(s0)
    800021d4:	00000493          	li	s1,0
    800021d8:	22050063          	beqz	a0,800023f8 <__printf+0x2a0>
    800021dc:	00002a37          	lui	s4,0x2
    800021e0:	00018ab7          	lui	s5,0x18
    800021e4:	000f4b37          	lui	s6,0xf4
    800021e8:	00989bb7          	lui	s7,0x989
    800021ec:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    800021f0:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    800021f4:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    800021f8:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    800021fc:	00148c9b          	addiw	s9,s1,1
    80002200:	02500793          	li	a5,37
    80002204:	01998933          	add	s2,s3,s9
    80002208:	38f51263          	bne	a0,a5,8000258c <__printf+0x434>
    8000220c:	00094783          	lbu	a5,0(s2)
    80002210:	00078c9b          	sext.w	s9,a5
    80002214:	1e078263          	beqz	a5,800023f8 <__printf+0x2a0>
    80002218:	0024849b          	addiw	s1,s1,2
    8000221c:	07000713          	li	a4,112
    80002220:	00998933          	add	s2,s3,s1
    80002224:	38e78a63          	beq	a5,a4,800025b8 <__printf+0x460>
    80002228:	20f76863          	bltu	a4,a5,80002438 <__printf+0x2e0>
    8000222c:	42a78863          	beq	a5,a0,8000265c <__printf+0x504>
    80002230:	06400713          	li	a4,100
    80002234:	40e79663          	bne	a5,a4,80002640 <__printf+0x4e8>
    80002238:	f7843783          	ld	a5,-136(s0)
    8000223c:	0007a603          	lw	a2,0(a5)
    80002240:	00878793          	addi	a5,a5,8
    80002244:	f6f43c23          	sd	a5,-136(s0)
    80002248:	42064a63          	bltz	a2,8000267c <__printf+0x524>
    8000224c:	00a00713          	li	a4,10
    80002250:	02e677bb          	remuw	a5,a2,a4
    80002254:	00002d97          	auipc	s11,0x2
    80002258:	f24d8d93          	addi	s11,s11,-220 # 80004178 <digits>
    8000225c:	00900593          	li	a1,9
    80002260:	0006051b          	sext.w	a0,a2
    80002264:	00000c93          	li	s9,0
    80002268:	02079793          	slli	a5,a5,0x20
    8000226c:	0207d793          	srli	a5,a5,0x20
    80002270:	00fd87b3          	add	a5,s11,a5
    80002274:	0007c783          	lbu	a5,0(a5)
    80002278:	02e656bb          	divuw	a3,a2,a4
    8000227c:	f8f40023          	sb	a5,-128(s0)
    80002280:	14c5d863          	bge	a1,a2,800023d0 <__printf+0x278>
    80002284:	06300593          	li	a1,99
    80002288:	00100c93          	li	s9,1
    8000228c:	02e6f7bb          	remuw	a5,a3,a4
    80002290:	02079793          	slli	a5,a5,0x20
    80002294:	0207d793          	srli	a5,a5,0x20
    80002298:	00fd87b3          	add	a5,s11,a5
    8000229c:	0007c783          	lbu	a5,0(a5)
    800022a0:	02e6d73b          	divuw	a4,a3,a4
    800022a4:	f8f400a3          	sb	a5,-127(s0)
    800022a8:	12a5f463          	bgeu	a1,a0,800023d0 <__printf+0x278>
    800022ac:	00a00693          	li	a3,10
    800022b0:	00900593          	li	a1,9
    800022b4:	02d777bb          	remuw	a5,a4,a3
    800022b8:	02079793          	slli	a5,a5,0x20
    800022bc:	0207d793          	srli	a5,a5,0x20
    800022c0:	00fd87b3          	add	a5,s11,a5
    800022c4:	0007c503          	lbu	a0,0(a5)
    800022c8:	02d757bb          	divuw	a5,a4,a3
    800022cc:	f8a40123          	sb	a0,-126(s0)
    800022d0:	48e5f263          	bgeu	a1,a4,80002754 <__printf+0x5fc>
    800022d4:	06300513          	li	a0,99
    800022d8:	02d7f5bb          	remuw	a1,a5,a3
    800022dc:	02059593          	slli	a1,a1,0x20
    800022e0:	0205d593          	srli	a1,a1,0x20
    800022e4:	00bd85b3          	add	a1,s11,a1
    800022e8:	0005c583          	lbu	a1,0(a1)
    800022ec:	02d7d7bb          	divuw	a5,a5,a3
    800022f0:	f8b401a3          	sb	a1,-125(s0)
    800022f4:	48e57263          	bgeu	a0,a4,80002778 <__printf+0x620>
    800022f8:	3e700513          	li	a0,999
    800022fc:	02d7f5bb          	remuw	a1,a5,a3
    80002300:	02059593          	slli	a1,a1,0x20
    80002304:	0205d593          	srli	a1,a1,0x20
    80002308:	00bd85b3          	add	a1,s11,a1
    8000230c:	0005c583          	lbu	a1,0(a1)
    80002310:	02d7d7bb          	divuw	a5,a5,a3
    80002314:	f8b40223          	sb	a1,-124(s0)
    80002318:	46e57663          	bgeu	a0,a4,80002784 <__printf+0x62c>
    8000231c:	02d7f5bb          	remuw	a1,a5,a3
    80002320:	02059593          	slli	a1,a1,0x20
    80002324:	0205d593          	srli	a1,a1,0x20
    80002328:	00bd85b3          	add	a1,s11,a1
    8000232c:	0005c583          	lbu	a1,0(a1)
    80002330:	02d7d7bb          	divuw	a5,a5,a3
    80002334:	f8b402a3          	sb	a1,-123(s0)
    80002338:	46ea7863          	bgeu	s4,a4,800027a8 <__printf+0x650>
    8000233c:	02d7f5bb          	remuw	a1,a5,a3
    80002340:	02059593          	slli	a1,a1,0x20
    80002344:	0205d593          	srli	a1,a1,0x20
    80002348:	00bd85b3          	add	a1,s11,a1
    8000234c:	0005c583          	lbu	a1,0(a1)
    80002350:	02d7d7bb          	divuw	a5,a5,a3
    80002354:	f8b40323          	sb	a1,-122(s0)
    80002358:	3eeaf863          	bgeu	s5,a4,80002748 <__printf+0x5f0>
    8000235c:	02d7f5bb          	remuw	a1,a5,a3
    80002360:	02059593          	slli	a1,a1,0x20
    80002364:	0205d593          	srli	a1,a1,0x20
    80002368:	00bd85b3          	add	a1,s11,a1
    8000236c:	0005c583          	lbu	a1,0(a1)
    80002370:	02d7d7bb          	divuw	a5,a5,a3
    80002374:	f8b403a3          	sb	a1,-121(s0)
    80002378:	42eb7e63          	bgeu	s6,a4,800027b4 <__printf+0x65c>
    8000237c:	02d7f5bb          	remuw	a1,a5,a3
    80002380:	02059593          	slli	a1,a1,0x20
    80002384:	0205d593          	srli	a1,a1,0x20
    80002388:	00bd85b3          	add	a1,s11,a1
    8000238c:	0005c583          	lbu	a1,0(a1)
    80002390:	02d7d7bb          	divuw	a5,a5,a3
    80002394:	f8b40423          	sb	a1,-120(s0)
    80002398:	42ebfc63          	bgeu	s7,a4,800027d0 <__printf+0x678>
    8000239c:	02079793          	slli	a5,a5,0x20
    800023a0:	0207d793          	srli	a5,a5,0x20
    800023a4:	00fd8db3          	add	s11,s11,a5
    800023a8:	000dc703          	lbu	a4,0(s11)
    800023ac:	00a00793          	li	a5,10
    800023b0:	00900c93          	li	s9,9
    800023b4:	f8e404a3          	sb	a4,-119(s0)
    800023b8:	00065c63          	bgez	a2,800023d0 <__printf+0x278>
    800023bc:	f9040713          	addi	a4,s0,-112
    800023c0:	00f70733          	add	a4,a4,a5
    800023c4:	02d00693          	li	a3,45
    800023c8:	fed70823          	sb	a3,-16(a4)
    800023cc:	00078c93          	mv	s9,a5
    800023d0:	f8040793          	addi	a5,s0,-128
    800023d4:	01978cb3          	add	s9,a5,s9
    800023d8:	f7f40d13          	addi	s10,s0,-129
    800023dc:	000cc503          	lbu	a0,0(s9)
    800023e0:	fffc8c93          	addi	s9,s9,-1
    800023e4:	00000097          	auipc	ra,0x0
    800023e8:	b90080e7          	jalr	-1136(ra) # 80001f74 <consputc>
    800023ec:	ffac98e3          	bne	s9,s10,800023dc <__printf+0x284>
    800023f0:	00094503          	lbu	a0,0(s2)
    800023f4:	e00514e3          	bnez	a0,800021fc <__printf+0xa4>
    800023f8:	1a0c1663          	bnez	s8,800025a4 <__printf+0x44c>
    800023fc:	08813083          	ld	ra,136(sp)
    80002400:	08013403          	ld	s0,128(sp)
    80002404:	07813483          	ld	s1,120(sp)
    80002408:	07013903          	ld	s2,112(sp)
    8000240c:	06813983          	ld	s3,104(sp)
    80002410:	06013a03          	ld	s4,96(sp)
    80002414:	05813a83          	ld	s5,88(sp)
    80002418:	05013b03          	ld	s6,80(sp)
    8000241c:	04813b83          	ld	s7,72(sp)
    80002420:	04013c03          	ld	s8,64(sp)
    80002424:	03813c83          	ld	s9,56(sp)
    80002428:	03013d03          	ld	s10,48(sp)
    8000242c:	02813d83          	ld	s11,40(sp)
    80002430:	0d010113          	addi	sp,sp,208
    80002434:	00008067          	ret
    80002438:	07300713          	li	a4,115
    8000243c:	1ce78a63          	beq	a5,a4,80002610 <__printf+0x4b8>
    80002440:	07800713          	li	a4,120
    80002444:	1ee79e63          	bne	a5,a4,80002640 <__printf+0x4e8>
    80002448:	f7843783          	ld	a5,-136(s0)
    8000244c:	0007a703          	lw	a4,0(a5)
    80002450:	00878793          	addi	a5,a5,8
    80002454:	f6f43c23          	sd	a5,-136(s0)
    80002458:	28074263          	bltz	a4,800026dc <__printf+0x584>
    8000245c:	00002d97          	auipc	s11,0x2
    80002460:	d1cd8d93          	addi	s11,s11,-740 # 80004178 <digits>
    80002464:	00f77793          	andi	a5,a4,15
    80002468:	00fd87b3          	add	a5,s11,a5
    8000246c:	0007c683          	lbu	a3,0(a5)
    80002470:	00f00613          	li	a2,15
    80002474:	0007079b          	sext.w	a5,a4
    80002478:	f8d40023          	sb	a3,-128(s0)
    8000247c:	0047559b          	srliw	a1,a4,0x4
    80002480:	0047569b          	srliw	a3,a4,0x4
    80002484:	00000c93          	li	s9,0
    80002488:	0ee65063          	bge	a2,a4,80002568 <__printf+0x410>
    8000248c:	00f6f693          	andi	a3,a3,15
    80002490:	00dd86b3          	add	a3,s11,a3
    80002494:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80002498:	0087d79b          	srliw	a5,a5,0x8
    8000249c:	00100c93          	li	s9,1
    800024a0:	f8d400a3          	sb	a3,-127(s0)
    800024a4:	0cb67263          	bgeu	a2,a1,80002568 <__printf+0x410>
    800024a8:	00f7f693          	andi	a3,a5,15
    800024ac:	00dd86b3          	add	a3,s11,a3
    800024b0:	0006c583          	lbu	a1,0(a3)
    800024b4:	00f00613          	li	a2,15
    800024b8:	0047d69b          	srliw	a3,a5,0x4
    800024bc:	f8b40123          	sb	a1,-126(s0)
    800024c0:	0047d593          	srli	a1,a5,0x4
    800024c4:	28f67e63          	bgeu	a2,a5,80002760 <__printf+0x608>
    800024c8:	00f6f693          	andi	a3,a3,15
    800024cc:	00dd86b3          	add	a3,s11,a3
    800024d0:	0006c503          	lbu	a0,0(a3)
    800024d4:	0087d813          	srli	a6,a5,0x8
    800024d8:	0087d69b          	srliw	a3,a5,0x8
    800024dc:	f8a401a3          	sb	a0,-125(s0)
    800024e0:	28b67663          	bgeu	a2,a1,8000276c <__printf+0x614>
    800024e4:	00f6f693          	andi	a3,a3,15
    800024e8:	00dd86b3          	add	a3,s11,a3
    800024ec:	0006c583          	lbu	a1,0(a3)
    800024f0:	00c7d513          	srli	a0,a5,0xc
    800024f4:	00c7d69b          	srliw	a3,a5,0xc
    800024f8:	f8b40223          	sb	a1,-124(s0)
    800024fc:	29067a63          	bgeu	a2,a6,80002790 <__printf+0x638>
    80002500:	00f6f693          	andi	a3,a3,15
    80002504:	00dd86b3          	add	a3,s11,a3
    80002508:	0006c583          	lbu	a1,0(a3)
    8000250c:	0107d813          	srli	a6,a5,0x10
    80002510:	0107d69b          	srliw	a3,a5,0x10
    80002514:	f8b402a3          	sb	a1,-123(s0)
    80002518:	28a67263          	bgeu	a2,a0,8000279c <__printf+0x644>
    8000251c:	00f6f693          	andi	a3,a3,15
    80002520:	00dd86b3          	add	a3,s11,a3
    80002524:	0006c683          	lbu	a3,0(a3)
    80002528:	0147d79b          	srliw	a5,a5,0x14
    8000252c:	f8d40323          	sb	a3,-122(s0)
    80002530:	21067663          	bgeu	a2,a6,8000273c <__printf+0x5e4>
    80002534:	02079793          	slli	a5,a5,0x20
    80002538:	0207d793          	srli	a5,a5,0x20
    8000253c:	00fd8db3          	add	s11,s11,a5
    80002540:	000dc683          	lbu	a3,0(s11)
    80002544:	00800793          	li	a5,8
    80002548:	00700c93          	li	s9,7
    8000254c:	f8d403a3          	sb	a3,-121(s0)
    80002550:	00075c63          	bgez	a4,80002568 <__printf+0x410>
    80002554:	f9040713          	addi	a4,s0,-112
    80002558:	00f70733          	add	a4,a4,a5
    8000255c:	02d00693          	li	a3,45
    80002560:	fed70823          	sb	a3,-16(a4)
    80002564:	00078c93          	mv	s9,a5
    80002568:	f8040793          	addi	a5,s0,-128
    8000256c:	01978cb3          	add	s9,a5,s9
    80002570:	f7f40d13          	addi	s10,s0,-129
    80002574:	000cc503          	lbu	a0,0(s9)
    80002578:	fffc8c93          	addi	s9,s9,-1
    8000257c:	00000097          	auipc	ra,0x0
    80002580:	9f8080e7          	jalr	-1544(ra) # 80001f74 <consputc>
    80002584:	ff9d18e3          	bne	s10,s9,80002574 <__printf+0x41c>
    80002588:	0100006f          	j	80002598 <__printf+0x440>
    8000258c:	00000097          	auipc	ra,0x0
    80002590:	9e8080e7          	jalr	-1560(ra) # 80001f74 <consputc>
    80002594:	000c8493          	mv	s1,s9
    80002598:	00094503          	lbu	a0,0(s2)
    8000259c:	c60510e3          	bnez	a0,800021fc <__printf+0xa4>
    800025a0:	e40c0ee3          	beqz	s8,800023fc <__printf+0x2a4>
    800025a4:	00003517          	auipc	a0,0x3
    800025a8:	0ec50513          	addi	a0,a0,236 # 80005690 <pr>
    800025ac:	00001097          	auipc	ra,0x1
    800025b0:	94c080e7          	jalr	-1716(ra) # 80002ef8 <release>
    800025b4:	e49ff06f          	j	800023fc <__printf+0x2a4>
    800025b8:	f7843783          	ld	a5,-136(s0)
    800025bc:	03000513          	li	a0,48
    800025c0:	01000d13          	li	s10,16
    800025c4:	00878713          	addi	a4,a5,8
    800025c8:	0007bc83          	ld	s9,0(a5)
    800025cc:	f6e43c23          	sd	a4,-136(s0)
    800025d0:	00000097          	auipc	ra,0x0
    800025d4:	9a4080e7          	jalr	-1628(ra) # 80001f74 <consputc>
    800025d8:	07800513          	li	a0,120
    800025dc:	00000097          	auipc	ra,0x0
    800025e0:	998080e7          	jalr	-1640(ra) # 80001f74 <consputc>
    800025e4:	00002d97          	auipc	s11,0x2
    800025e8:	b94d8d93          	addi	s11,s11,-1132 # 80004178 <digits>
    800025ec:	03ccd793          	srli	a5,s9,0x3c
    800025f0:	00fd87b3          	add	a5,s11,a5
    800025f4:	0007c503          	lbu	a0,0(a5)
    800025f8:	fffd0d1b          	addiw	s10,s10,-1
    800025fc:	004c9c93          	slli	s9,s9,0x4
    80002600:	00000097          	auipc	ra,0x0
    80002604:	974080e7          	jalr	-1676(ra) # 80001f74 <consputc>
    80002608:	fe0d12e3          	bnez	s10,800025ec <__printf+0x494>
    8000260c:	f8dff06f          	j	80002598 <__printf+0x440>
    80002610:	f7843783          	ld	a5,-136(s0)
    80002614:	0007bc83          	ld	s9,0(a5)
    80002618:	00878793          	addi	a5,a5,8
    8000261c:	f6f43c23          	sd	a5,-136(s0)
    80002620:	000c9a63          	bnez	s9,80002634 <__printf+0x4dc>
    80002624:	1080006f          	j	8000272c <__printf+0x5d4>
    80002628:	001c8c93          	addi	s9,s9,1
    8000262c:	00000097          	auipc	ra,0x0
    80002630:	948080e7          	jalr	-1720(ra) # 80001f74 <consputc>
    80002634:	000cc503          	lbu	a0,0(s9)
    80002638:	fe0518e3          	bnez	a0,80002628 <__printf+0x4d0>
    8000263c:	f5dff06f          	j	80002598 <__printf+0x440>
    80002640:	02500513          	li	a0,37
    80002644:	00000097          	auipc	ra,0x0
    80002648:	930080e7          	jalr	-1744(ra) # 80001f74 <consputc>
    8000264c:	000c8513          	mv	a0,s9
    80002650:	00000097          	auipc	ra,0x0
    80002654:	924080e7          	jalr	-1756(ra) # 80001f74 <consputc>
    80002658:	f41ff06f          	j	80002598 <__printf+0x440>
    8000265c:	02500513          	li	a0,37
    80002660:	00000097          	auipc	ra,0x0
    80002664:	914080e7          	jalr	-1772(ra) # 80001f74 <consputc>
    80002668:	f31ff06f          	j	80002598 <__printf+0x440>
    8000266c:	00030513          	mv	a0,t1
    80002670:	00000097          	auipc	ra,0x0
    80002674:	7bc080e7          	jalr	1980(ra) # 80002e2c <acquire>
    80002678:	b4dff06f          	j	800021c4 <__printf+0x6c>
    8000267c:	40c0053b          	negw	a0,a2
    80002680:	00a00713          	li	a4,10
    80002684:	02e576bb          	remuw	a3,a0,a4
    80002688:	00002d97          	auipc	s11,0x2
    8000268c:	af0d8d93          	addi	s11,s11,-1296 # 80004178 <digits>
    80002690:	ff700593          	li	a1,-9
    80002694:	02069693          	slli	a3,a3,0x20
    80002698:	0206d693          	srli	a3,a3,0x20
    8000269c:	00dd86b3          	add	a3,s11,a3
    800026a0:	0006c683          	lbu	a3,0(a3)
    800026a4:	02e557bb          	divuw	a5,a0,a4
    800026a8:	f8d40023          	sb	a3,-128(s0)
    800026ac:	10b65e63          	bge	a2,a1,800027c8 <__printf+0x670>
    800026b0:	06300593          	li	a1,99
    800026b4:	02e7f6bb          	remuw	a3,a5,a4
    800026b8:	02069693          	slli	a3,a3,0x20
    800026bc:	0206d693          	srli	a3,a3,0x20
    800026c0:	00dd86b3          	add	a3,s11,a3
    800026c4:	0006c683          	lbu	a3,0(a3)
    800026c8:	02e7d73b          	divuw	a4,a5,a4
    800026cc:	00200793          	li	a5,2
    800026d0:	f8d400a3          	sb	a3,-127(s0)
    800026d4:	bca5ece3          	bltu	a1,a0,800022ac <__printf+0x154>
    800026d8:	ce5ff06f          	j	800023bc <__printf+0x264>
    800026dc:	40e007bb          	negw	a5,a4
    800026e0:	00002d97          	auipc	s11,0x2
    800026e4:	a98d8d93          	addi	s11,s11,-1384 # 80004178 <digits>
    800026e8:	00f7f693          	andi	a3,a5,15
    800026ec:	00dd86b3          	add	a3,s11,a3
    800026f0:	0006c583          	lbu	a1,0(a3)
    800026f4:	ff100613          	li	a2,-15
    800026f8:	0047d69b          	srliw	a3,a5,0x4
    800026fc:	f8b40023          	sb	a1,-128(s0)
    80002700:	0047d59b          	srliw	a1,a5,0x4
    80002704:	0ac75e63          	bge	a4,a2,800027c0 <__printf+0x668>
    80002708:	00f6f693          	andi	a3,a3,15
    8000270c:	00dd86b3          	add	a3,s11,a3
    80002710:	0006c603          	lbu	a2,0(a3)
    80002714:	00f00693          	li	a3,15
    80002718:	0087d79b          	srliw	a5,a5,0x8
    8000271c:	f8c400a3          	sb	a2,-127(s0)
    80002720:	d8b6e4e3          	bltu	a3,a1,800024a8 <__printf+0x350>
    80002724:	00200793          	li	a5,2
    80002728:	e2dff06f          	j	80002554 <__printf+0x3fc>
    8000272c:	00002c97          	auipc	s9,0x2
    80002730:	a2cc8c93          	addi	s9,s9,-1492 # 80004158 <CONSOLE_STATUS+0x148>
    80002734:	02800513          	li	a0,40
    80002738:	ef1ff06f          	j	80002628 <__printf+0x4d0>
    8000273c:	00700793          	li	a5,7
    80002740:	00600c93          	li	s9,6
    80002744:	e0dff06f          	j	80002550 <__printf+0x3f8>
    80002748:	00700793          	li	a5,7
    8000274c:	00600c93          	li	s9,6
    80002750:	c69ff06f          	j	800023b8 <__printf+0x260>
    80002754:	00300793          	li	a5,3
    80002758:	00200c93          	li	s9,2
    8000275c:	c5dff06f          	j	800023b8 <__printf+0x260>
    80002760:	00300793          	li	a5,3
    80002764:	00200c93          	li	s9,2
    80002768:	de9ff06f          	j	80002550 <__printf+0x3f8>
    8000276c:	00400793          	li	a5,4
    80002770:	00300c93          	li	s9,3
    80002774:	dddff06f          	j	80002550 <__printf+0x3f8>
    80002778:	00400793          	li	a5,4
    8000277c:	00300c93          	li	s9,3
    80002780:	c39ff06f          	j	800023b8 <__printf+0x260>
    80002784:	00500793          	li	a5,5
    80002788:	00400c93          	li	s9,4
    8000278c:	c2dff06f          	j	800023b8 <__printf+0x260>
    80002790:	00500793          	li	a5,5
    80002794:	00400c93          	li	s9,4
    80002798:	db9ff06f          	j	80002550 <__printf+0x3f8>
    8000279c:	00600793          	li	a5,6
    800027a0:	00500c93          	li	s9,5
    800027a4:	dadff06f          	j	80002550 <__printf+0x3f8>
    800027a8:	00600793          	li	a5,6
    800027ac:	00500c93          	li	s9,5
    800027b0:	c09ff06f          	j	800023b8 <__printf+0x260>
    800027b4:	00800793          	li	a5,8
    800027b8:	00700c93          	li	s9,7
    800027bc:	bfdff06f          	j	800023b8 <__printf+0x260>
    800027c0:	00100793          	li	a5,1
    800027c4:	d91ff06f          	j	80002554 <__printf+0x3fc>
    800027c8:	00100793          	li	a5,1
    800027cc:	bf1ff06f          	j	800023bc <__printf+0x264>
    800027d0:	00900793          	li	a5,9
    800027d4:	00800c93          	li	s9,8
    800027d8:	be1ff06f          	j	800023b8 <__printf+0x260>
    800027dc:	00002517          	auipc	a0,0x2
    800027e0:	98450513          	addi	a0,a0,-1660 # 80004160 <CONSOLE_STATUS+0x150>
    800027e4:	00000097          	auipc	ra,0x0
    800027e8:	918080e7          	jalr	-1768(ra) # 800020fc <panic>

00000000800027ec <printfinit>:
    800027ec:	fe010113          	addi	sp,sp,-32
    800027f0:	00813823          	sd	s0,16(sp)
    800027f4:	00913423          	sd	s1,8(sp)
    800027f8:	00113c23          	sd	ra,24(sp)
    800027fc:	02010413          	addi	s0,sp,32
    80002800:	00003497          	auipc	s1,0x3
    80002804:	e9048493          	addi	s1,s1,-368 # 80005690 <pr>
    80002808:	00048513          	mv	a0,s1
    8000280c:	00002597          	auipc	a1,0x2
    80002810:	96458593          	addi	a1,a1,-1692 # 80004170 <CONSOLE_STATUS+0x160>
    80002814:	00000097          	auipc	ra,0x0
    80002818:	5f4080e7          	jalr	1524(ra) # 80002e08 <initlock>
    8000281c:	01813083          	ld	ra,24(sp)
    80002820:	01013403          	ld	s0,16(sp)
    80002824:	0004ac23          	sw	zero,24(s1)
    80002828:	00813483          	ld	s1,8(sp)
    8000282c:	02010113          	addi	sp,sp,32
    80002830:	00008067          	ret

0000000080002834 <uartinit>:
    80002834:	ff010113          	addi	sp,sp,-16
    80002838:	00813423          	sd	s0,8(sp)
    8000283c:	01010413          	addi	s0,sp,16
    80002840:	100007b7          	lui	a5,0x10000
    80002844:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80002848:	f8000713          	li	a4,-128
    8000284c:	00e781a3          	sb	a4,3(a5)
    80002850:	00300713          	li	a4,3
    80002854:	00e78023          	sb	a4,0(a5)
    80002858:	000780a3          	sb	zero,1(a5)
    8000285c:	00e781a3          	sb	a4,3(a5)
    80002860:	00700693          	li	a3,7
    80002864:	00d78123          	sb	a3,2(a5)
    80002868:	00e780a3          	sb	a4,1(a5)
    8000286c:	00813403          	ld	s0,8(sp)
    80002870:	01010113          	addi	sp,sp,16
    80002874:	00008067          	ret

0000000080002878 <uartputc>:
    80002878:	00002797          	auipc	a5,0x2
    8000287c:	bc07a783          	lw	a5,-1088(a5) # 80004438 <panicked>
    80002880:	00078463          	beqz	a5,80002888 <uartputc+0x10>
    80002884:	0000006f          	j	80002884 <uartputc+0xc>
    80002888:	fd010113          	addi	sp,sp,-48
    8000288c:	02813023          	sd	s0,32(sp)
    80002890:	00913c23          	sd	s1,24(sp)
    80002894:	01213823          	sd	s2,16(sp)
    80002898:	01313423          	sd	s3,8(sp)
    8000289c:	02113423          	sd	ra,40(sp)
    800028a0:	03010413          	addi	s0,sp,48
    800028a4:	00002917          	auipc	s2,0x2
    800028a8:	b9c90913          	addi	s2,s2,-1124 # 80004440 <uart_tx_r>
    800028ac:	00093783          	ld	a5,0(s2)
    800028b0:	00002497          	auipc	s1,0x2
    800028b4:	b9848493          	addi	s1,s1,-1128 # 80004448 <uart_tx_w>
    800028b8:	0004b703          	ld	a4,0(s1)
    800028bc:	02078693          	addi	a3,a5,32
    800028c0:	00050993          	mv	s3,a0
    800028c4:	02e69c63          	bne	a3,a4,800028fc <uartputc+0x84>
    800028c8:	00001097          	auipc	ra,0x1
    800028cc:	834080e7          	jalr	-1996(ra) # 800030fc <push_on>
    800028d0:	00093783          	ld	a5,0(s2)
    800028d4:	0004b703          	ld	a4,0(s1)
    800028d8:	02078793          	addi	a5,a5,32
    800028dc:	00e79463          	bne	a5,a4,800028e4 <uartputc+0x6c>
    800028e0:	0000006f          	j	800028e0 <uartputc+0x68>
    800028e4:	00001097          	auipc	ra,0x1
    800028e8:	88c080e7          	jalr	-1908(ra) # 80003170 <pop_on>
    800028ec:	00093783          	ld	a5,0(s2)
    800028f0:	0004b703          	ld	a4,0(s1)
    800028f4:	02078693          	addi	a3,a5,32
    800028f8:	fce688e3          	beq	a3,a4,800028c8 <uartputc+0x50>
    800028fc:	01f77693          	andi	a3,a4,31
    80002900:	00003597          	auipc	a1,0x3
    80002904:	db058593          	addi	a1,a1,-592 # 800056b0 <uart_tx_buf>
    80002908:	00d586b3          	add	a3,a1,a3
    8000290c:	00170713          	addi	a4,a4,1
    80002910:	01368023          	sb	s3,0(a3)
    80002914:	00e4b023          	sd	a4,0(s1)
    80002918:	10000637          	lui	a2,0x10000
    8000291c:	02f71063          	bne	a4,a5,8000293c <uartputc+0xc4>
    80002920:	0340006f          	j	80002954 <uartputc+0xdc>
    80002924:	00074703          	lbu	a4,0(a4)
    80002928:	00f93023          	sd	a5,0(s2)
    8000292c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80002930:	00093783          	ld	a5,0(s2)
    80002934:	0004b703          	ld	a4,0(s1)
    80002938:	00f70e63          	beq	a4,a5,80002954 <uartputc+0xdc>
    8000293c:	00564683          	lbu	a3,5(a2)
    80002940:	01f7f713          	andi	a4,a5,31
    80002944:	00e58733          	add	a4,a1,a4
    80002948:	0206f693          	andi	a3,a3,32
    8000294c:	00178793          	addi	a5,a5,1
    80002950:	fc069ae3          	bnez	a3,80002924 <uartputc+0xac>
    80002954:	02813083          	ld	ra,40(sp)
    80002958:	02013403          	ld	s0,32(sp)
    8000295c:	01813483          	ld	s1,24(sp)
    80002960:	01013903          	ld	s2,16(sp)
    80002964:	00813983          	ld	s3,8(sp)
    80002968:	03010113          	addi	sp,sp,48
    8000296c:	00008067          	ret

0000000080002970 <uartputc_sync>:
    80002970:	ff010113          	addi	sp,sp,-16
    80002974:	00813423          	sd	s0,8(sp)
    80002978:	01010413          	addi	s0,sp,16
    8000297c:	00002717          	auipc	a4,0x2
    80002980:	abc72703          	lw	a4,-1348(a4) # 80004438 <panicked>
    80002984:	02071663          	bnez	a4,800029b0 <uartputc_sync+0x40>
    80002988:	00050793          	mv	a5,a0
    8000298c:	100006b7          	lui	a3,0x10000
    80002990:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80002994:	02077713          	andi	a4,a4,32
    80002998:	fe070ce3          	beqz	a4,80002990 <uartputc_sync+0x20>
    8000299c:	0ff7f793          	andi	a5,a5,255
    800029a0:	00f68023          	sb	a5,0(a3)
    800029a4:	00813403          	ld	s0,8(sp)
    800029a8:	01010113          	addi	sp,sp,16
    800029ac:	00008067          	ret
    800029b0:	0000006f          	j	800029b0 <uartputc_sync+0x40>

00000000800029b4 <uartstart>:
    800029b4:	ff010113          	addi	sp,sp,-16
    800029b8:	00813423          	sd	s0,8(sp)
    800029bc:	01010413          	addi	s0,sp,16
    800029c0:	00002617          	auipc	a2,0x2
    800029c4:	a8060613          	addi	a2,a2,-1408 # 80004440 <uart_tx_r>
    800029c8:	00002517          	auipc	a0,0x2
    800029cc:	a8050513          	addi	a0,a0,-1408 # 80004448 <uart_tx_w>
    800029d0:	00063783          	ld	a5,0(a2)
    800029d4:	00053703          	ld	a4,0(a0)
    800029d8:	04f70263          	beq	a4,a5,80002a1c <uartstart+0x68>
    800029dc:	100005b7          	lui	a1,0x10000
    800029e0:	00003817          	auipc	a6,0x3
    800029e4:	cd080813          	addi	a6,a6,-816 # 800056b0 <uart_tx_buf>
    800029e8:	01c0006f          	j	80002a04 <uartstart+0x50>
    800029ec:	0006c703          	lbu	a4,0(a3)
    800029f0:	00f63023          	sd	a5,0(a2)
    800029f4:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800029f8:	00063783          	ld	a5,0(a2)
    800029fc:	00053703          	ld	a4,0(a0)
    80002a00:	00f70e63          	beq	a4,a5,80002a1c <uartstart+0x68>
    80002a04:	01f7f713          	andi	a4,a5,31
    80002a08:	00e806b3          	add	a3,a6,a4
    80002a0c:	0055c703          	lbu	a4,5(a1)
    80002a10:	00178793          	addi	a5,a5,1
    80002a14:	02077713          	andi	a4,a4,32
    80002a18:	fc071ae3          	bnez	a4,800029ec <uartstart+0x38>
    80002a1c:	00813403          	ld	s0,8(sp)
    80002a20:	01010113          	addi	sp,sp,16
    80002a24:	00008067          	ret

0000000080002a28 <uartgetc>:
    80002a28:	ff010113          	addi	sp,sp,-16
    80002a2c:	00813423          	sd	s0,8(sp)
    80002a30:	01010413          	addi	s0,sp,16
    80002a34:	10000737          	lui	a4,0x10000
    80002a38:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    80002a3c:	0017f793          	andi	a5,a5,1
    80002a40:	00078c63          	beqz	a5,80002a58 <uartgetc+0x30>
    80002a44:	00074503          	lbu	a0,0(a4)
    80002a48:	0ff57513          	andi	a0,a0,255
    80002a4c:	00813403          	ld	s0,8(sp)
    80002a50:	01010113          	addi	sp,sp,16
    80002a54:	00008067          	ret
    80002a58:	fff00513          	li	a0,-1
    80002a5c:	ff1ff06f          	j	80002a4c <uartgetc+0x24>

0000000080002a60 <uartintr>:
    80002a60:	100007b7          	lui	a5,0x10000
    80002a64:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80002a68:	0017f793          	andi	a5,a5,1
    80002a6c:	0a078463          	beqz	a5,80002b14 <uartintr+0xb4>
    80002a70:	fe010113          	addi	sp,sp,-32
    80002a74:	00813823          	sd	s0,16(sp)
    80002a78:	00913423          	sd	s1,8(sp)
    80002a7c:	00113c23          	sd	ra,24(sp)
    80002a80:	02010413          	addi	s0,sp,32
    80002a84:	100004b7          	lui	s1,0x10000
    80002a88:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    80002a8c:	0ff57513          	andi	a0,a0,255
    80002a90:	fffff097          	auipc	ra,0xfffff
    80002a94:	534080e7          	jalr	1332(ra) # 80001fc4 <consoleintr>
    80002a98:	0054c783          	lbu	a5,5(s1)
    80002a9c:	0017f793          	andi	a5,a5,1
    80002aa0:	fe0794e3          	bnez	a5,80002a88 <uartintr+0x28>
    80002aa4:	00002617          	auipc	a2,0x2
    80002aa8:	99c60613          	addi	a2,a2,-1636 # 80004440 <uart_tx_r>
    80002aac:	00002517          	auipc	a0,0x2
    80002ab0:	99c50513          	addi	a0,a0,-1636 # 80004448 <uart_tx_w>
    80002ab4:	00063783          	ld	a5,0(a2)
    80002ab8:	00053703          	ld	a4,0(a0)
    80002abc:	04f70263          	beq	a4,a5,80002b00 <uartintr+0xa0>
    80002ac0:	100005b7          	lui	a1,0x10000
    80002ac4:	00003817          	auipc	a6,0x3
    80002ac8:	bec80813          	addi	a6,a6,-1044 # 800056b0 <uart_tx_buf>
    80002acc:	01c0006f          	j	80002ae8 <uartintr+0x88>
    80002ad0:	0006c703          	lbu	a4,0(a3)
    80002ad4:	00f63023          	sd	a5,0(a2)
    80002ad8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80002adc:	00063783          	ld	a5,0(a2)
    80002ae0:	00053703          	ld	a4,0(a0)
    80002ae4:	00f70e63          	beq	a4,a5,80002b00 <uartintr+0xa0>
    80002ae8:	01f7f713          	andi	a4,a5,31
    80002aec:	00e806b3          	add	a3,a6,a4
    80002af0:	0055c703          	lbu	a4,5(a1)
    80002af4:	00178793          	addi	a5,a5,1
    80002af8:	02077713          	andi	a4,a4,32
    80002afc:	fc071ae3          	bnez	a4,80002ad0 <uartintr+0x70>
    80002b00:	01813083          	ld	ra,24(sp)
    80002b04:	01013403          	ld	s0,16(sp)
    80002b08:	00813483          	ld	s1,8(sp)
    80002b0c:	02010113          	addi	sp,sp,32
    80002b10:	00008067          	ret
    80002b14:	00002617          	auipc	a2,0x2
    80002b18:	92c60613          	addi	a2,a2,-1748 # 80004440 <uart_tx_r>
    80002b1c:	00002517          	auipc	a0,0x2
    80002b20:	92c50513          	addi	a0,a0,-1748 # 80004448 <uart_tx_w>
    80002b24:	00063783          	ld	a5,0(a2)
    80002b28:	00053703          	ld	a4,0(a0)
    80002b2c:	04f70263          	beq	a4,a5,80002b70 <uartintr+0x110>
    80002b30:	100005b7          	lui	a1,0x10000
    80002b34:	00003817          	auipc	a6,0x3
    80002b38:	b7c80813          	addi	a6,a6,-1156 # 800056b0 <uart_tx_buf>
    80002b3c:	01c0006f          	j	80002b58 <uartintr+0xf8>
    80002b40:	0006c703          	lbu	a4,0(a3)
    80002b44:	00f63023          	sd	a5,0(a2)
    80002b48:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80002b4c:	00063783          	ld	a5,0(a2)
    80002b50:	00053703          	ld	a4,0(a0)
    80002b54:	02f70063          	beq	a4,a5,80002b74 <uartintr+0x114>
    80002b58:	01f7f713          	andi	a4,a5,31
    80002b5c:	00e806b3          	add	a3,a6,a4
    80002b60:	0055c703          	lbu	a4,5(a1)
    80002b64:	00178793          	addi	a5,a5,1
    80002b68:	02077713          	andi	a4,a4,32
    80002b6c:	fc071ae3          	bnez	a4,80002b40 <uartintr+0xe0>
    80002b70:	00008067          	ret
    80002b74:	00008067          	ret

0000000080002b78 <kinit>:
    80002b78:	fc010113          	addi	sp,sp,-64
    80002b7c:	02913423          	sd	s1,40(sp)
    80002b80:	fffff7b7          	lui	a5,0xfffff
    80002b84:	00004497          	auipc	s1,0x4
    80002b88:	b4b48493          	addi	s1,s1,-1205 # 800066cf <end+0xfff>
    80002b8c:	02813823          	sd	s0,48(sp)
    80002b90:	01313c23          	sd	s3,24(sp)
    80002b94:	00f4f4b3          	and	s1,s1,a5
    80002b98:	02113c23          	sd	ra,56(sp)
    80002b9c:	03213023          	sd	s2,32(sp)
    80002ba0:	01413823          	sd	s4,16(sp)
    80002ba4:	01513423          	sd	s5,8(sp)
    80002ba8:	04010413          	addi	s0,sp,64
    80002bac:	000017b7          	lui	a5,0x1
    80002bb0:	01100993          	li	s3,17
    80002bb4:	00f487b3          	add	a5,s1,a5
    80002bb8:	01b99993          	slli	s3,s3,0x1b
    80002bbc:	06f9e063          	bltu	s3,a5,80002c1c <kinit+0xa4>
    80002bc0:	00003a97          	auipc	s5,0x3
    80002bc4:	b10a8a93          	addi	s5,s5,-1264 # 800056d0 <end>
    80002bc8:	0754ec63          	bltu	s1,s5,80002c40 <kinit+0xc8>
    80002bcc:	0734fa63          	bgeu	s1,s3,80002c40 <kinit+0xc8>
    80002bd0:	00088a37          	lui	s4,0x88
    80002bd4:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80002bd8:	00002917          	auipc	s2,0x2
    80002bdc:	87890913          	addi	s2,s2,-1928 # 80004450 <kmem>
    80002be0:	00ca1a13          	slli	s4,s4,0xc
    80002be4:	0140006f          	j	80002bf8 <kinit+0x80>
    80002be8:	000017b7          	lui	a5,0x1
    80002bec:	00f484b3          	add	s1,s1,a5
    80002bf0:	0554e863          	bltu	s1,s5,80002c40 <kinit+0xc8>
    80002bf4:	0534f663          	bgeu	s1,s3,80002c40 <kinit+0xc8>
    80002bf8:	00001637          	lui	a2,0x1
    80002bfc:	00100593          	li	a1,1
    80002c00:	00048513          	mv	a0,s1
    80002c04:	00000097          	auipc	ra,0x0
    80002c08:	5e4080e7          	jalr	1508(ra) # 800031e8 <__memset>
    80002c0c:	00093783          	ld	a5,0(s2)
    80002c10:	00f4b023          	sd	a5,0(s1)
    80002c14:	00993023          	sd	s1,0(s2)
    80002c18:	fd4498e3          	bne	s1,s4,80002be8 <kinit+0x70>
    80002c1c:	03813083          	ld	ra,56(sp)
    80002c20:	03013403          	ld	s0,48(sp)
    80002c24:	02813483          	ld	s1,40(sp)
    80002c28:	02013903          	ld	s2,32(sp)
    80002c2c:	01813983          	ld	s3,24(sp)
    80002c30:	01013a03          	ld	s4,16(sp)
    80002c34:	00813a83          	ld	s5,8(sp)
    80002c38:	04010113          	addi	sp,sp,64
    80002c3c:	00008067          	ret
    80002c40:	00001517          	auipc	a0,0x1
    80002c44:	55050513          	addi	a0,a0,1360 # 80004190 <digits+0x18>
    80002c48:	fffff097          	auipc	ra,0xfffff
    80002c4c:	4b4080e7          	jalr	1204(ra) # 800020fc <panic>

0000000080002c50 <freerange>:
    80002c50:	fc010113          	addi	sp,sp,-64
    80002c54:	000017b7          	lui	a5,0x1
    80002c58:	02913423          	sd	s1,40(sp)
    80002c5c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80002c60:	009504b3          	add	s1,a0,s1
    80002c64:	fffff537          	lui	a0,0xfffff
    80002c68:	02813823          	sd	s0,48(sp)
    80002c6c:	02113c23          	sd	ra,56(sp)
    80002c70:	03213023          	sd	s2,32(sp)
    80002c74:	01313c23          	sd	s3,24(sp)
    80002c78:	01413823          	sd	s4,16(sp)
    80002c7c:	01513423          	sd	s5,8(sp)
    80002c80:	01613023          	sd	s6,0(sp)
    80002c84:	04010413          	addi	s0,sp,64
    80002c88:	00a4f4b3          	and	s1,s1,a0
    80002c8c:	00f487b3          	add	a5,s1,a5
    80002c90:	06f5e463          	bltu	a1,a5,80002cf8 <freerange+0xa8>
    80002c94:	00003a97          	auipc	s5,0x3
    80002c98:	a3ca8a93          	addi	s5,s5,-1476 # 800056d0 <end>
    80002c9c:	0954e263          	bltu	s1,s5,80002d20 <freerange+0xd0>
    80002ca0:	01100993          	li	s3,17
    80002ca4:	01b99993          	slli	s3,s3,0x1b
    80002ca8:	0734fc63          	bgeu	s1,s3,80002d20 <freerange+0xd0>
    80002cac:	00058a13          	mv	s4,a1
    80002cb0:	00001917          	auipc	s2,0x1
    80002cb4:	7a090913          	addi	s2,s2,1952 # 80004450 <kmem>
    80002cb8:	00002b37          	lui	s6,0x2
    80002cbc:	0140006f          	j	80002cd0 <freerange+0x80>
    80002cc0:	000017b7          	lui	a5,0x1
    80002cc4:	00f484b3          	add	s1,s1,a5
    80002cc8:	0554ec63          	bltu	s1,s5,80002d20 <freerange+0xd0>
    80002ccc:	0534fa63          	bgeu	s1,s3,80002d20 <freerange+0xd0>
    80002cd0:	00001637          	lui	a2,0x1
    80002cd4:	00100593          	li	a1,1
    80002cd8:	00048513          	mv	a0,s1
    80002cdc:	00000097          	auipc	ra,0x0
    80002ce0:	50c080e7          	jalr	1292(ra) # 800031e8 <__memset>
    80002ce4:	00093703          	ld	a4,0(s2)
    80002ce8:	016487b3          	add	a5,s1,s6
    80002cec:	00e4b023          	sd	a4,0(s1)
    80002cf0:	00993023          	sd	s1,0(s2)
    80002cf4:	fcfa76e3          	bgeu	s4,a5,80002cc0 <freerange+0x70>
    80002cf8:	03813083          	ld	ra,56(sp)
    80002cfc:	03013403          	ld	s0,48(sp)
    80002d00:	02813483          	ld	s1,40(sp)
    80002d04:	02013903          	ld	s2,32(sp)
    80002d08:	01813983          	ld	s3,24(sp)
    80002d0c:	01013a03          	ld	s4,16(sp)
    80002d10:	00813a83          	ld	s5,8(sp)
    80002d14:	00013b03          	ld	s6,0(sp)
    80002d18:	04010113          	addi	sp,sp,64
    80002d1c:	00008067          	ret
    80002d20:	00001517          	auipc	a0,0x1
    80002d24:	47050513          	addi	a0,a0,1136 # 80004190 <digits+0x18>
    80002d28:	fffff097          	auipc	ra,0xfffff
    80002d2c:	3d4080e7          	jalr	980(ra) # 800020fc <panic>

0000000080002d30 <kfree>:
    80002d30:	fe010113          	addi	sp,sp,-32
    80002d34:	00813823          	sd	s0,16(sp)
    80002d38:	00113c23          	sd	ra,24(sp)
    80002d3c:	00913423          	sd	s1,8(sp)
    80002d40:	02010413          	addi	s0,sp,32
    80002d44:	03451793          	slli	a5,a0,0x34
    80002d48:	04079c63          	bnez	a5,80002da0 <kfree+0x70>
    80002d4c:	00003797          	auipc	a5,0x3
    80002d50:	98478793          	addi	a5,a5,-1660 # 800056d0 <end>
    80002d54:	00050493          	mv	s1,a0
    80002d58:	04f56463          	bltu	a0,a5,80002da0 <kfree+0x70>
    80002d5c:	01100793          	li	a5,17
    80002d60:	01b79793          	slli	a5,a5,0x1b
    80002d64:	02f57e63          	bgeu	a0,a5,80002da0 <kfree+0x70>
    80002d68:	00001637          	lui	a2,0x1
    80002d6c:	00100593          	li	a1,1
    80002d70:	00000097          	auipc	ra,0x0
    80002d74:	478080e7          	jalr	1144(ra) # 800031e8 <__memset>
    80002d78:	00001797          	auipc	a5,0x1
    80002d7c:	6d878793          	addi	a5,a5,1752 # 80004450 <kmem>
    80002d80:	0007b703          	ld	a4,0(a5)
    80002d84:	01813083          	ld	ra,24(sp)
    80002d88:	01013403          	ld	s0,16(sp)
    80002d8c:	00e4b023          	sd	a4,0(s1)
    80002d90:	0097b023          	sd	s1,0(a5)
    80002d94:	00813483          	ld	s1,8(sp)
    80002d98:	02010113          	addi	sp,sp,32
    80002d9c:	00008067          	ret
    80002da0:	00001517          	auipc	a0,0x1
    80002da4:	3f050513          	addi	a0,a0,1008 # 80004190 <digits+0x18>
    80002da8:	fffff097          	auipc	ra,0xfffff
    80002dac:	354080e7          	jalr	852(ra) # 800020fc <panic>

0000000080002db0 <kalloc>:
    80002db0:	fe010113          	addi	sp,sp,-32
    80002db4:	00813823          	sd	s0,16(sp)
    80002db8:	00913423          	sd	s1,8(sp)
    80002dbc:	00113c23          	sd	ra,24(sp)
    80002dc0:	02010413          	addi	s0,sp,32
    80002dc4:	00001797          	auipc	a5,0x1
    80002dc8:	68c78793          	addi	a5,a5,1676 # 80004450 <kmem>
    80002dcc:	0007b483          	ld	s1,0(a5)
    80002dd0:	02048063          	beqz	s1,80002df0 <kalloc+0x40>
    80002dd4:	0004b703          	ld	a4,0(s1)
    80002dd8:	00001637          	lui	a2,0x1
    80002ddc:	00500593          	li	a1,5
    80002de0:	00048513          	mv	a0,s1
    80002de4:	00e7b023          	sd	a4,0(a5)
    80002de8:	00000097          	auipc	ra,0x0
    80002dec:	400080e7          	jalr	1024(ra) # 800031e8 <__memset>
    80002df0:	01813083          	ld	ra,24(sp)
    80002df4:	01013403          	ld	s0,16(sp)
    80002df8:	00048513          	mv	a0,s1
    80002dfc:	00813483          	ld	s1,8(sp)
    80002e00:	02010113          	addi	sp,sp,32
    80002e04:	00008067          	ret

0000000080002e08 <initlock>:
    80002e08:	ff010113          	addi	sp,sp,-16
    80002e0c:	00813423          	sd	s0,8(sp)
    80002e10:	01010413          	addi	s0,sp,16
    80002e14:	00813403          	ld	s0,8(sp)
    80002e18:	00b53423          	sd	a1,8(a0)
    80002e1c:	00052023          	sw	zero,0(a0)
    80002e20:	00053823          	sd	zero,16(a0)
    80002e24:	01010113          	addi	sp,sp,16
    80002e28:	00008067          	ret

0000000080002e2c <acquire>:
    80002e2c:	fe010113          	addi	sp,sp,-32
    80002e30:	00813823          	sd	s0,16(sp)
    80002e34:	00913423          	sd	s1,8(sp)
    80002e38:	00113c23          	sd	ra,24(sp)
    80002e3c:	01213023          	sd	s2,0(sp)
    80002e40:	02010413          	addi	s0,sp,32
    80002e44:	00050493          	mv	s1,a0
    80002e48:	10002973          	csrr	s2,sstatus
    80002e4c:	100027f3          	csrr	a5,sstatus
    80002e50:	ffd7f793          	andi	a5,a5,-3
    80002e54:	10079073          	csrw	sstatus,a5
    80002e58:	fffff097          	auipc	ra,0xfffff
    80002e5c:	8e8080e7          	jalr	-1816(ra) # 80001740 <mycpu>
    80002e60:	07852783          	lw	a5,120(a0)
    80002e64:	06078e63          	beqz	a5,80002ee0 <acquire+0xb4>
    80002e68:	fffff097          	auipc	ra,0xfffff
    80002e6c:	8d8080e7          	jalr	-1832(ra) # 80001740 <mycpu>
    80002e70:	07852783          	lw	a5,120(a0)
    80002e74:	0004a703          	lw	a4,0(s1)
    80002e78:	0017879b          	addiw	a5,a5,1
    80002e7c:	06f52c23          	sw	a5,120(a0)
    80002e80:	04071063          	bnez	a4,80002ec0 <acquire+0x94>
    80002e84:	00100713          	li	a4,1
    80002e88:	00070793          	mv	a5,a4
    80002e8c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80002e90:	0007879b          	sext.w	a5,a5
    80002e94:	fe079ae3          	bnez	a5,80002e88 <acquire+0x5c>
    80002e98:	0ff0000f          	fence
    80002e9c:	fffff097          	auipc	ra,0xfffff
    80002ea0:	8a4080e7          	jalr	-1884(ra) # 80001740 <mycpu>
    80002ea4:	01813083          	ld	ra,24(sp)
    80002ea8:	01013403          	ld	s0,16(sp)
    80002eac:	00a4b823          	sd	a0,16(s1)
    80002eb0:	00013903          	ld	s2,0(sp)
    80002eb4:	00813483          	ld	s1,8(sp)
    80002eb8:	02010113          	addi	sp,sp,32
    80002ebc:	00008067          	ret
    80002ec0:	0104b903          	ld	s2,16(s1)
    80002ec4:	fffff097          	auipc	ra,0xfffff
    80002ec8:	87c080e7          	jalr	-1924(ra) # 80001740 <mycpu>
    80002ecc:	faa91ce3          	bne	s2,a0,80002e84 <acquire+0x58>
    80002ed0:	00001517          	auipc	a0,0x1
    80002ed4:	2c850513          	addi	a0,a0,712 # 80004198 <digits+0x20>
    80002ed8:	fffff097          	auipc	ra,0xfffff
    80002edc:	224080e7          	jalr	548(ra) # 800020fc <panic>
    80002ee0:	00195913          	srli	s2,s2,0x1
    80002ee4:	fffff097          	auipc	ra,0xfffff
    80002ee8:	85c080e7          	jalr	-1956(ra) # 80001740 <mycpu>
    80002eec:	00197913          	andi	s2,s2,1
    80002ef0:	07252e23          	sw	s2,124(a0)
    80002ef4:	f75ff06f          	j	80002e68 <acquire+0x3c>

0000000080002ef8 <release>:
    80002ef8:	fe010113          	addi	sp,sp,-32
    80002efc:	00813823          	sd	s0,16(sp)
    80002f00:	00113c23          	sd	ra,24(sp)
    80002f04:	00913423          	sd	s1,8(sp)
    80002f08:	01213023          	sd	s2,0(sp)
    80002f0c:	02010413          	addi	s0,sp,32
    80002f10:	00052783          	lw	a5,0(a0)
    80002f14:	00079a63          	bnez	a5,80002f28 <release+0x30>
    80002f18:	00001517          	auipc	a0,0x1
    80002f1c:	28850513          	addi	a0,a0,648 # 800041a0 <digits+0x28>
    80002f20:	fffff097          	auipc	ra,0xfffff
    80002f24:	1dc080e7          	jalr	476(ra) # 800020fc <panic>
    80002f28:	01053903          	ld	s2,16(a0)
    80002f2c:	00050493          	mv	s1,a0
    80002f30:	fffff097          	auipc	ra,0xfffff
    80002f34:	810080e7          	jalr	-2032(ra) # 80001740 <mycpu>
    80002f38:	fea910e3          	bne	s2,a0,80002f18 <release+0x20>
    80002f3c:	0004b823          	sd	zero,16(s1)
    80002f40:	0ff0000f          	fence
    80002f44:	0f50000f          	fence	iorw,ow
    80002f48:	0804a02f          	amoswap.w	zero,zero,(s1)
    80002f4c:	ffffe097          	auipc	ra,0xffffe
    80002f50:	7f4080e7          	jalr	2036(ra) # 80001740 <mycpu>
    80002f54:	100027f3          	csrr	a5,sstatus
    80002f58:	0027f793          	andi	a5,a5,2
    80002f5c:	04079a63          	bnez	a5,80002fb0 <release+0xb8>
    80002f60:	07852783          	lw	a5,120(a0)
    80002f64:	02f05e63          	blez	a5,80002fa0 <release+0xa8>
    80002f68:	fff7871b          	addiw	a4,a5,-1
    80002f6c:	06e52c23          	sw	a4,120(a0)
    80002f70:	00071c63          	bnez	a4,80002f88 <release+0x90>
    80002f74:	07c52783          	lw	a5,124(a0)
    80002f78:	00078863          	beqz	a5,80002f88 <release+0x90>
    80002f7c:	100027f3          	csrr	a5,sstatus
    80002f80:	0027e793          	ori	a5,a5,2
    80002f84:	10079073          	csrw	sstatus,a5
    80002f88:	01813083          	ld	ra,24(sp)
    80002f8c:	01013403          	ld	s0,16(sp)
    80002f90:	00813483          	ld	s1,8(sp)
    80002f94:	00013903          	ld	s2,0(sp)
    80002f98:	02010113          	addi	sp,sp,32
    80002f9c:	00008067          	ret
    80002fa0:	00001517          	auipc	a0,0x1
    80002fa4:	22050513          	addi	a0,a0,544 # 800041c0 <digits+0x48>
    80002fa8:	fffff097          	auipc	ra,0xfffff
    80002fac:	154080e7          	jalr	340(ra) # 800020fc <panic>
    80002fb0:	00001517          	auipc	a0,0x1
    80002fb4:	1f850513          	addi	a0,a0,504 # 800041a8 <digits+0x30>
    80002fb8:	fffff097          	auipc	ra,0xfffff
    80002fbc:	144080e7          	jalr	324(ra) # 800020fc <panic>

0000000080002fc0 <holding>:
    80002fc0:	00052783          	lw	a5,0(a0)
    80002fc4:	00079663          	bnez	a5,80002fd0 <holding+0x10>
    80002fc8:	00000513          	li	a0,0
    80002fcc:	00008067          	ret
    80002fd0:	fe010113          	addi	sp,sp,-32
    80002fd4:	00813823          	sd	s0,16(sp)
    80002fd8:	00913423          	sd	s1,8(sp)
    80002fdc:	00113c23          	sd	ra,24(sp)
    80002fe0:	02010413          	addi	s0,sp,32
    80002fe4:	01053483          	ld	s1,16(a0)
    80002fe8:	ffffe097          	auipc	ra,0xffffe
    80002fec:	758080e7          	jalr	1880(ra) # 80001740 <mycpu>
    80002ff0:	01813083          	ld	ra,24(sp)
    80002ff4:	01013403          	ld	s0,16(sp)
    80002ff8:	40a48533          	sub	a0,s1,a0
    80002ffc:	00153513          	seqz	a0,a0
    80003000:	00813483          	ld	s1,8(sp)
    80003004:	02010113          	addi	sp,sp,32
    80003008:	00008067          	ret

000000008000300c <push_off>:
    8000300c:	fe010113          	addi	sp,sp,-32
    80003010:	00813823          	sd	s0,16(sp)
    80003014:	00113c23          	sd	ra,24(sp)
    80003018:	00913423          	sd	s1,8(sp)
    8000301c:	02010413          	addi	s0,sp,32
    80003020:	100024f3          	csrr	s1,sstatus
    80003024:	100027f3          	csrr	a5,sstatus
    80003028:	ffd7f793          	andi	a5,a5,-3
    8000302c:	10079073          	csrw	sstatus,a5
    80003030:	ffffe097          	auipc	ra,0xffffe
    80003034:	710080e7          	jalr	1808(ra) # 80001740 <mycpu>
    80003038:	07852783          	lw	a5,120(a0)
    8000303c:	02078663          	beqz	a5,80003068 <push_off+0x5c>
    80003040:	ffffe097          	auipc	ra,0xffffe
    80003044:	700080e7          	jalr	1792(ra) # 80001740 <mycpu>
    80003048:	07852783          	lw	a5,120(a0)
    8000304c:	01813083          	ld	ra,24(sp)
    80003050:	01013403          	ld	s0,16(sp)
    80003054:	0017879b          	addiw	a5,a5,1
    80003058:	06f52c23          	sw	a5,120(a0)
    8000305c:	00813483          	ld	s1,8(sp)
    80003060:	02010113          	addi	sp,sp,32
    80003064:	00008067          	ret
    80003068:	0014d493          	srli	s1,s1,0x1
    8000306c:	ffffe097          	auipc	ra,0xffffe
    80003070:	6d4080e7          	jalr	1748(ra) # 80001740 <mycpu>
    80003074:	0014f493          	andi	s1,s1,1
    80003078:	06952e23          	sw	s1,124(a0)
    8000307c:	fc5ff06f          	j	80003040 <push_off+0x34>

0000000080003080 <pop_off>:
    80003080:	ff010113          	addi	sp,sp,-16
    80003084:	00813023          	sd	s0,0(sp)
    80003088:	00113423          	sd	ra,8(sp)
    8000308c:	01010413          	addi	s0,sp,16
    80003090:	ffffe097          	auipc	ra,0xffffe
    80003094:	6b0080e7          	jalr	1712(ra) # 80001740 <mycpu>
    80003098:	100027f3          	csrr	a5,sstatus
    8000309c:	0027f793          	andi	a5,a5,2
    800030a0:	04079663          	bnez	a5,800030ec <pop_off+0x6c>
    800030a4:	07852783          	lw	a5,120(a0)
    800030a8:	02f05a63          	blez	a5,800030dc <pop_off+0x5c>
    800030ac:	fff7871b          	addiw	a4,a5,-1
    800030b0:	06e52c23          	sw	a4,120(a0)
    800030b4:	00071c63          	bnez	a4,800030cc <pop_off+0x4c>
    800030b8:	07c52783          	lw	a5,124(a0)
    800030bc:	00078863          	beqz	a5,800030cc <pop_off+0x4c>
    800030c0:	100027f3          	csrr	a5,sstatus
    800030c4:	0027e793          	ori	a5,a5,2
    800030c8:	10079073          	csrw	sstatus,a5
    800030cc:	00813083          	ld	ra,8(sp)
    800030d0:	00013403          	ld	s0,0(sp)
    800030d4:	01010113          	addi	sp,sp,16
    800030d8:	00008067          	ret
    800030dc:	00001517          	auipc	a0,0x1
    800030e0:	0e450513          	addi	a0,a0,228 # 800041c0 <digits+0x48>
    800030e4:	fffff097          	auipc	ra,0xfffff
    800030e8:	018080e7          	jalr	24(ra) # 800020fc <panic>
    800030ec:	00001517          	auipc	a0,0x1
    800030f0:	0bc50513          	addi	a0,a0,188 # 800041a8 <digits+0x30>
    800030f4:	fffff097          	auipc	ra,0xfffff
    800030f8:	008080e7          	jalr	8(ra) # 800020fc <panic>

00000000800030fc <push_on>:
    800030fc:	fe010113          	addi	sp,sp,-32
    80003100:	00813823          	sd	s0,16(sp)
    80003104:	00113c23          	sd	ra,24(sp)
    80003108:	00913423          	sd	s1,8(sp)
    8000310c:	02010413          	addi	s0,sp,32
    80003110:	100024f3          	csrr	s1,sstatus
    80003114:	100027f3          	csrr	a5,sstatus
    80003118:	0027e793          	ori	a5,a5,2
    8000311c:	10079073          	csrw	sstatus,a5
    80003120:	ffffe097          	auipc	ra,0xffffe
    80003124:	620080e7          	jalr	1568(ra) # 80001740 <mycpu>
    80003128:	07852783          	lw	a5,120(a0)
    8000312c:	02078663          	beqz	a5,80003158 <push_on+0x5c>
    80003130:	ffffe097          	auipc	ra,0xffffe
    80003134:	610080e7          	jalr	1552(ra) # 80001740 <mycpu>
    80003138:	07852783          	lw	a5,120(a0)
    8000313c:	01813083          	ld	ra,24(sp)
    80003140:	01013403          	ld	s0,16(sp)
    80003144:	0017879b          	addiw	a5,a5,1
    80003148:	06f52c23          	sw	a5,120(a0)
    8000314c:	00813483          	ld	s1,8(sp)
    80003150:	02010113          	addi	sp,sp,32
    80003154:	00008067          	ret
    80003158:	0014d493          	srli	s1,s1,0x1
    8000315c:	ffffe097          	auipc	ra,0xffffe
    80003160:	5e4080e7          	jalr	1508(ra) # 80001740 <mycpu>
    80003164:	0014f493          	andi	s1,s1,1
    80003168:	06952e23          	sw	s1,124(a0)
    8000316c:	fc5ff06f          	j	80003130 <push_on+0x34>

0000000080003170 <pop_on>:
    80003170:	ff010113          	addi	sp,sp,-16
    80003174:	00813023          	sd	s0,0(sp)
    80003178:	00113423          	sd	ra,8(sp)
    8000317c:	01010413          	addi	s0,sp,16
    80003180:	ffffe097          	auipc	ra,0xffffe
    80003184:	5c0080e7          	jalr	1472(ra) # 80001740 <mycpu>
    80003188:	100027f3          	csrr	a5,sstatus
    8000318c:	0027f793          	andi	a5,a5,2
    80003190:	04078463          	beqz	a5,800031d8 <pop_on+0x68>
    80003194:	07852783          	lw	a5,120(a0)
    80003198:	02f05863          	blez	a5,800031c8 <pop_on+0x58>
    8000319c:	fff7879b          	addiw	a5,a5,-1
    800031a0:	06f52c23          	sw	a5,120(a0)
    800031a4:	07853783          	ld	a5,120(a0)
    800031a8:	00079863          	bnez	a5,800031b8 <pop_on+0x48>
    800031ac:	100027f3          	csrr	a5,sstatus
    800031b0:	ffd7f793          	andi	a5,a5,-3
    800031b4:	10079073          	csrw	sstatus,a5
    800031b8:	00813083          	ld	ra,8(sp)
    800031bc:	00013403          	ld	s0,0(sp)
    800031c0:	01010113          	addi	sp,sp,16
    800031c4:	00008067          	ret
    800031c8:	00001517          	auipc	a0,0x1
    800031cc:	02050513          	addi	a0,a0,32 # 800041e8 <digits+0x70>
    800031d0:	fffff097          	auipc	ra,0xfffff
    800031d4:	f2c080e7          	jalr	-212(ra) # 800020fc <panic>
    800031d8:	00001517          	auipc	a0,0x1
    800031dc:	ff050513          	addi	a0,a0,-16 # 800041c8 <digits+0x50>
    800031e0:	fffff097          	auipc	ra,0xfffff
    800031e4:	f1c080e7          	jalr	-228(ra) # 800020fc <panic>

00000000800031e8 <__memset>:
    800031e8:	ff010113          	addi	sp,sp,-16
    800031ec:	00813423          	sd	s0,8(sp)
    800031f0:	01010413          	addi	s0,sp,16
    800031f4:	1a060e63          	beqz	a2,800033b0 <__memset+0x1c8>
    800031f8:	40a007b3          	neg	a5,a0
    800031fc:	0077f793          	andi	a5,a5,7
    80003200:	00778693          	addi	a3,a5,7
    80003204:	00b00813          	li	a6,11
    80003208:	0ff5f593          	andi	a1,a1,255
    8000320c:	fff6071b          	addiw	a4,a2,-1
    80003210:	1b06e663          	bltu	a3,a6,800033bc <__memset+0x1d4>
    80003214:	1cd76463          	bltu	a4,a3,800033dc <__memset+0x1f4>
    80003218:	1a078e63          	beqz	a5,800033d4 <__memset+0x1ec>
    8000321c:	00b50023          	sb	a1,0(a0)
    80003220:	00100713          	li	a4,1
    80003224:	1ae78463          	beq	a5,a4,800033cc <__memset+0x1e4>
    80003228:	00b500a3          	sb	a1,1(a0)
    8000322c:	00200713          	li	a4,2
    80003230:	1ae78a63          	beq	a5,a4,800033e4 <__memset+0x1fc>
    80003234:	00b50123          	sb	a1,2(a0)
    80003238:	00300713          	li	a4,3
    8000323c:	18e78463          	beq	a5,a4,800033c4 <__memset+0x1dc>
    80003240:	00b501a3          	sb	a1,3(a0)
    80003244:	00400713          	li	a4,4
    80003248:	1ae78263          	beq	a5,a4,800033ec <__memset+0x204>
    8000324c:	00b50223          	sb	a1,4(a0)
    80003250:	00500713          	li	a4,5
    80003254:	1ae78063          	beq	a5,a4,800033f4 <__memset+0x20c>
    80003258:	00b502a3          	sb	a1,5(a0)
    8000325c:	00700713          	li	a4,7
    80003260:	18e79e63          	bne	a5,a4,800033fc <__memset+0x214>
    80003264:	00b50323          	sb	a1,6(a0)
    80003268:	00700e93          	li	t4,7
    8000326c:	00859713          	slli	a4,a1,0x8
    80003270:	00e5e733          	or	a4,a1,a4
    80003274:	01059e13          	slli	t3,a1,0x10
    80003278:	01c76e33          	or	t3,a4,t3
    8000327c:	01859313          	slli	t1,a1,0x18
    80003280:	006e6333          	or	t1,t3,t1
    80003284:	02059893          	slli	a7,a1,0x20
    80003288:	40f60e3b          	subw	t3,a2,a5
    8000328c:	011368b3          	or	a7,t1,a7
    80003290:	02859813          	slli	a6,a1,0x28
    80003294:	0108e833          	or	a6,a7,a6
    80003298:	03059693          	slli	a3,a1,0x30
    8000329c:	003e589b          	srliw	a7,t3,0x3
    800032a0:	00d866b3          	or	a3,a6,a3
    800032a4:	03859713          	slli	a4,a1,0x38
    800032a8:	00389813          	slli	a6,a7,0x3
    800032ac:	00f507b3          	add	a5,a0,a5
    800032b0:	00e6e733          	or	a4,a3,a4
    800032b4:	000e089b          	sext.w	a7,t3
    800032b8:	00f806b3          	add	a3,a6,a5
    800032bc:	00e7b023          	sd	a4,0(a5)
    800032c0:	00878793          	addi	a5,a5,8
    800032c4:	fed79ce3          	bne	a5,a3,800032bc <__memset+0xd4>
    800032c8:	ff8e7793          	andi	a5,t3,-8
    800032cc:	0007871b          	sext.w	a4,a5
    800032d0:	01d787bb          	addw	a5,a5,t4
    800032d4:	0ce88e63          	beq	a7,a4,800033b0 <__memset+0x1c8>
    800032d8:	00f50733          	add	a4,a0,a5
    800032dc:	00b70023          	sb	a1,0(a4)
    800032e0:	0017871b          	addiw	a4,a5,1
    800032e4:	0cc77663          	bgeu	a4,a2,800033b0 <__memset+0x1c8>
    800032e8:	00e50733          	add	a4,a0,a4
    800032ec:	00b70023          	sb	a1,0(a4)
    800032f0:	0027871b          	addiw	a4,a5,2
    800032f4:	0ac77e63          	bgeu	a4,a2,800033b0 <__memset+0x1c8>
    800032f8:	00e50733          	add	a4,a0,a4
    800032fc:	00b70023          	sb	a1,0(a4)
    80003300:	0037871b          	addiw	a4,a5,3
    80003304:	0ac77663          	bgeu	a4,a2,800033b0 <__memset+0x1c8>
    80003308:	00e50733          	add	a4,a0,a4
    8000330c:	00b70023          	sb	a1,0(a4)
    80003310:	0047871b          	addiw	a4,a5,4
    80003314:	08c77e63          	bgeu	a4,a2,800033b0 <__memset+0x1c8>
    80003318:	00e50733          	add	a4,a0,a4
    8000331c:	00b70023          	sb	a1,0(a4)
    80003320:	0057871b          	addiw	a4,a5,5
    80003324:	08c77663          	bgeu	a4,a2,800033b0 <__memset+0x1c8>
    80003328:	00e50733          	add	a4,a0,a4
    8000332c:	00b70023          	sb	a1,0(a4)
    80003330:	0067871b          	addiw	a4,a5,6
    80003334:	06c77e63          	bgeu	a4,a2,800033b0 <__memset+0x1c8>
    80003338:	00e50733          	add	a4,a0,a4
    8000333c:	00b70023          	sb	a1,0(a4)
    80003340:	0077871b          	addiw	a4,a5,7
    80003344:	06c77663          	bgeu	a4,a2,800033b0 <__memset+0x1c8>
    80003348:	00e50733          	add	a4,a0,a4
    8000334c:	00b70023          	sb	a1,0(a4)
    80003350:	0087871b          	addiw	a4,a5,8
    80003354:	04c77e63          	bgeu	a4,a2,800033b0 <__memset+0x1c8>
    80003358:	00e50733          	add	a4,a0,a4
    8000335c:	00b70023          	sb	a1,0(a4)
    80003360:	0097871b          	addiw	a4,a5,9
    80003364:	04c77663          	bgeu	a4,a2,800033b0 <__memset+0x1c8>
    80003368:	00e50733          	add	a4,a0,a4
    8000336c:	00b70023          	sb	a1,0(a4)
    80003370:	00a7871b          	addiw	a4,a5,10
    80003374:	02c77e63          	bgeu	a4,a2,800033b0 <__memset+0x1c8>
    80003378:	00e50733          	add	a4,a0,a4
    8000337c:	00b70023          	sb	a1,0(a4)
    80003380:	00b7871b          	addiw	a4,a5,11
    80003384:	02c77663          	bgeu	a4,a2,800033b0 <__memset+0x1c8>
    80003388:	00e50733          	add	a4,a0,a4
    8000338c:	00b70023          	sb	a1,0(a4)
    80003390:	00c7871b          	addiw	a4,a5,12
    80003394:	00c77e63          	bgeu	a4,a2,800033b0 <__memset+0x1c8>
    80003398:	00e50733          	add	a4,a0,a4
    8000339c:	00b70023          	sb	a1,0(a4)
    800033a0:	00d7879b          	addiw	a5,a5,13
    800033a4:	00c7f663          	bgeu	a5,a2,800033b0 <__memset+0x1c8>
    800033a8:	00f507b3          	add	a5,a0,a5
    800033ac:	00b78023          	sb	a1,0(a5)
    800033b0:	00813403          	ld	s0,8(sp)
    800033b4:	01010113          	addi	sp,sp,16
    800033b8:	00008067          	ret
    800033bc:	00b00693          	li	a3,11
    800033c0:	e55ff06f          	j	80003214 <__memset+0x2c>
    800033c4:	00300e93          	li	t4,3
    800033c8:	ea5ff06f          	j	8000326c <__memset+0x84>
    800033cc:	00100e93          	li	t4,1
    800033d0:	e9dff06f          	j	8000326c <__memset+0x84>
    800033d4:	00000e93          	li	t4,0
    800033d8:	e95ff06f          	j	8000326c <__memset+0x84>
    800033dc:	00000793          	li	a5,0
    800033e0:	ef9ff06f          	j	800032d8 <__memset+0xf0>
    800033e4:	00200e93          	li	t4,2
    800033e8:	e85ff06f          	j	8000326c <__memset+0x84>
    800033ec:	00400e93          	li	t4,4
    800033f0:	e7dff06f          	j	8000326c <__memset+0x84>
    800033f4:	00500e93          	li	t4,5
    800033f8:	e75ff06f          	j	8000326c <__memset+0x84>
    800033fc:	00600e93          	li	t4,6
    80003400:	e6dff06f          	j	8000326c <__memset+0x84>

0000000080003404 <__memmove>:
    80003404:	ff010113          	addi	sp,sp,-16
    80003408:	00813423          	sd	s0,8(sp)
    8000340c:	01010413          	addi	s0,sp,16
    80003410:	0e060863          	beqz	a2,80003500 <__memmove+0xfc>
    80003414:	fff6069b          	addiw	a3,a2,-1
    80003418:	0006881b          	sext.w	a6,a3
    8000341c:	0ea5e863          	bltu	a1,a0,8000350c <__memmove+0x108>
    80003420:	00758713          	addi	a4,a1,7
    80003424:	00a5e7b3          	or	a5,a1,a0
    80003428:	40a70733          	sub	a4,a4,a0
    8000342c:	0077f793          	andi	a5,a5,7
    80003430:	00f73713          	sltiu	a4,a4,15
    80003434:	00174713          	xori	a4,a4,1
    80003438:	0017b793          	seqz	a5,a5
    8000343c:	00e7f7b3          	and	a5,a5,a4
    80003440:	10078863          	beqz	a5,80003550 <__memmove+0x14c>
    80003444:	00900793          	li	a5,9
    80003448:	1107f463          	bgeu	a5,a6,80003550 <__memmove+0x14c>
    8000344c:	0036581b          	srliw	a6,a2,0x3
    80003450:	fff8081b          	addiw	a6,a6,-1
    80003454:	02081813          	slli	a6,a6,0x20
    80003458:	01d85893          	srli	a7,a6,0x1d
    8000345c:	00858813          	addi	a6,a1,8
    80003460:	00058793          	mv	a5,a1
    80003464:	00050713          	mv	a4,a0
    80003468:	01088833          	add	a6,a7,a6
    8000346c:	0007b883          	ld	a7,0(a5)
    80003470:	00878793          	addi	a5,a5,8
    80003474:	00870713          	addi	a4,a4,8
    80003478:	ff173c23          	sd	a7,-8(a4)
    8000347c:	ff0798e3          	bne	a5,a6,8000346c <__memmove+0x68>
    80003480:	ff867713          	andi	a4,a2,-8
    80003484:	02071793          	slli	a5,a4,0x20
    80003488:	0207d793          	srli	a5,a5,0x20
    8000348c:	00f585b3          	add	a1,a1,a5
    80003490:	40e686bb          	subw	a3,a3,a4
    80003494:	00f507b3          	add	a5,a0,a5
    80003498:	06e60463          	beq	a2,a4,80003500 <__memmove+0xfc>
    8000349c:	0005c703          	lbu	a4,0(a1)
    800034a0:	00e78023          	sb	a4,0(a5)
    800034a4:	04068e63          	beqz	a3,80003500 <__memmove+0xfc>
    800034a8:	0015c603          	lbu	a2,1(a1)
    800034ac:	00100713          	li	a4,1
    800034b0:	00c780a3          	sb	a2,1(a5)
    800034b4:	04e68663          	beq	a3,a4,80003500 <__memmove+0xfc>
    800034b8:	0025c603          	lbu	a2,2(a1)
    800034bc:	00200713          	li	a4,2
    800034c0:	00c78123          	sb	a2,2(a5)
    800034c4:	02e68e63          	beq	a3,a4,80003500 <__memmove+0xfc>
    800034c8:	0035c603          	lbu	a2,3(a1)
    800034cc:	00300713          	li	a4,3
    800034d0:	00c781a3          	sb	a2,3(a5)
    800034d4:	02e68663          	beq	a3,a4,80003500 <__memmove+0xfc>
    800034d8:	0045c603          	lbu	a2,4(a1)
    800034dc:	00400713          	li	a4,4
    800034e0:	00c78223          	sb	a2,4(a5)
    800034e4:	00e68e63          	beq	a3,a4,80003500 <__memmove+0xfc>
    800034e8:	0055c603          	lbu	a2,5(a1)
    800034ec:	00500713          	li	a4,5
    800034f0:	00c782a3          	sb	a2,5(a5)
    800034f4:	00e68663          	beq	a3,a4,80003500 <__memmove+0xfc>
    800034f8:	0065c703          	lbu	a4,6(a1)
    800034fc:	00e78323          	sb	a4,6(a5)
    80003500:	00813403          	ld	s0,8(sp)
    80003504:	01010113          	addi	sp,sp,16
    80003508:	00008067          	ret
    8000350c:	02061713          	slli	a4,a2,0x20
    80003510:	02075713          	srli	a4,a4,0x20
    80003514:	00e587b3          	add	a5,a1,a4
    80003518:	f0f574e3          	bgeu	a0,a5,80003420 <__memmove+0x1c>
    8000351c:	02069613          	slli	a2,a3,0x20
    80003520:	02065613          	srli	a2,a2,0x20
    80003524:	fff64613          	not	a2,a2
    80003528:	00e50733          	add	a4,a0,a4
    8000352c:	00c78633          	add	a2,a5,a2
    80003530:	fff7c683          	lbu	a3,-1(a5)
    80003534:	fff78793          	addi	a5,a5,-1
    80003538:	fff70713          	addi	a4,a4,-1
    8000353c:	00d70023          	sb	a3,0(a4)
    80003540:	fec798e3          	bne	a5,a2,80003530 <__memmove+0x12c>
    80003544:	00813403          	ld	s0,8(sp)
    80003548:	01010113          	addi	sp,sp,16
    8000354c:	00008067          	ret
    80003550:	02069713          	slli	a4,a3,0x20
    80003554:	02075713          	srli	a4,a4,0x20
    80003558:	00170713          	addi	a4,a4,1
    8000355c:	00e50733          	add	a4,a0,a4
    80003560:	00050793          	mv	a5,a0
    80003564:	0005c683          	lbu	a3,0(a1)
    80003568:	00178793          	addi	a5,a5,1
    8000356c:	00158593          	addi	a1,a1,1
    80003570:	fed78fa3          	sb	a3,-1(a5)
    80003574:	fee798e3          	bne	a5,a4,80003564 <__memmove+0x160>
    80003578:	f89ff06f          	j	80003500 <__memmove+0xfc>
	...
