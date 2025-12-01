
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00004117          	auipc	sp,0x4
    80000004:	45013103          	ld	sp,1104(sp) # 80004450 <_GLOBAL_OFFSET_TABLE_+0x10>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	5d0010ef          	jal	ra,800015ec <start>

0000000080000020 <spin>:
    80000020:	0000006f          	j	80000020 <spin>
	...

0000000080001000 <interrupt_trap>:
.extern _ZN6Kernel16interruptHandlerEv
.align 4
.global interrupt_trap
.type interrupt_trap, @function
interrupt_trap:
    addi sp, sp, -256
    80001000:	f0010113          	addi	sp,sp,-256
    .irp index, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31
    sd x\index, \index * 8(sp)
    .endr
    80001004:	00013023          	sd	zero,0(sp)
    80001008:	00113423          	sd	ra,8(sp)
    8000100c:	00213823          	sd	sp,16(sp)
    80001010:	00313c23          	sd	gp,24(sp)
    80001014:	02413023          	sd	tp,32(sp)
    80001018:	02513423          	sd	t0,40(sp)
    8000101c:	02613823          	sd	t1,48(sp)
    80001020:	02713c23          	sd	t2,56(sp)
    80001024:	04813023          	sd	s0,64(sp)
    80001028:	04913423          	sd	s1,72(sp)
    8000102c:	04a13823          	sd	a0,80(sp)
    80001030:	04b13c23          	sd	a1,88(sp)
    80001034:	06c13023          	sd	a2,96(sp)
    80001038:	06d13423          	sd	a3,104(sp)
    8000103c:	06e13823          	sd	a4,112(sp)
    80001040:	06f13c23          	sd	a5,120(sp)
    80001044:	09013023          	sd	a6,128(sp)
    80001048:	09113423          	sd	a7,136(sp)
    8000104c:	09213823          	sd	s2,144(sp)
    80001050:	09313c23          	sd	s3,152(sp)
    80001054:	0b413023          	sd	s4,160(sp)
    80001058:	0b513423          	sd	s5,168(sp)
    8000105c:	0b613823          	sd	s6,176(sp)
    80001060:	0b713c23          	sd	s7,184(sp)
    80001064:	0d813023          	sd	s8,192(sp)
    80001068:	0d913423          	sd	s9,200(sp)
    8000106c:	0da13823          	sd	s10,208(sp)
    80001070:	0db13c23          	sd	s11,216(sp)
    80001074:	0fc13023          	sd	t3,224(sp)
    80001078:	0fd13423          	sd	t4,232(sp)
    8000107c:	0fe13823          	sd	t5,240(sp)
    80001080:	0ff13c23          	sd	t6,248(sp)

    call _ZN6Kernel16interruptHandlerEv
    80001084:	530000ef          	jal	ra,800015b4 <_ZN6Kernel16interruptHandlerEv>

    .irp index, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31
    ld x\index, \index * 8(sp)
    .endr
    80001088:	00013003          	ld	zero,0(sp)
    8000108c:	00813083          	ld	ra,8(sp)
    80001090:	01013103          	ld	sp,16(sp)
    80001094:	01813183          	ld	gp,24(sp)
    80001098:	02013203          	ld	tp,32(sp)
    8000109c:	02813283          	ld	t0,40(sp)
    800010a0:	03013303          	ld	t1,48(sp)
    800010a4:	03813383          	ld	t2,56(sp)
    800010a8:	04013403          	ld	s0,64(sp)
    800010ac:	04813483          	ld	s1,72(sp)
    800010b0:	05013503          	ld	a0,80(sp)
    800010b4:	05813583          	ld	a1,88(sp)
    800010b8:	06013603          	ld	a2,96(sp)
    800010bc:	06813683          	ld	a3,104(sp)
    800010c0:	07013703          	ld	a4,112(sp)
    800010c4:	07813783          	ld	a5,120(sp)
    800010c8:	08013803          	ld	a6,128(sp)
    800010cc:	08813883          	ld	a7,136(sp)
    800010d0:	09013903          	ld	s2,144(sp)
    800010d4:	09813983          	ld	s3,152(sp)
    800010d8:	0a013a03          	ld	s4,160(sp)
    800010dc:	0a813a83          	ld	s5,168(sp)
    800010e0:	0b013b03          	ld	s6,176(sp)
    800010e4:	0b813b83          	ld	s7,184(sp)
    800010e8:	0c013c03          	ld	s8,192(sp)
    800010ec:	0c813c83          	ld	s9,200(sp)
    800010f0:	0d013d03          	ld	s10,208(sp)
    800010f4:	0d813d83          	ld	s11,216(sp)
    800010f8:	0e013e03          	ld	t3,224(sp)
    800010fc:	0e813e83          	ld	t4,232(sp)
    80001100:	0f013f03          	ld	t5,240(sp)
    80001104:	0f813f83          	ld	t6,248(sp)
    addi sp, sp, 256
    80001108:	10010113          	addi	sp,sp,256
    8000110c:	10200073          	sret

0000000080001110 <main>:
// Created by os on 11/29/25.
//
#include "../h/MemoryAllocator.hpp"
#include "../h/Kernel.hpp"

void main(){
    80001110:	ff010113          	addi	sp,sp,-16
    80001114:	00113423          	sd	ra,8(sp)
    80001118:	00813023          	sd	s0,0(sp)
    8000111c:	01010413          	addi	s0,sp,16
//    void* allocMem1 = MemoryAllocator::allocateMemory(4);
//    void* allocMem2 = MemoryAllocator::allocateMemory(10);
//    MemoryAllocator::freeMemory(allocMem1);
//    MemoryAllocator::freeMemory(allocMem2);
//    MemoryAllocator::allocateMemory(4);
    Kernel::initializeKernel();
    80001120:	00000097          	auipc	ra,0x0
    80001124:	470080e7          	jalr	1136(ra) # 80001590 <_ZN6Kernel16initializeKernelEv>
    __asm__ volatile ("ecall");
    80001128:	00000073          	ecall
    MemoryAllocator::allocateMemory(4);
    8000112c:	00400513          	li	a0,4
    80001130:	00000097          	auipc	ra,0x0
    80001134:	1b8080e7          	jalr	440(ra) # 800012e8 <_ZN15MemoryAllocator14allocateMemoryEm>
    80001138:	00813083          	ld	ra,8(sp)
    8000113c:	00013403          	ld	s0,0(sp)
    80001140:	01010113          	addi	sp,sp,16
    80001144:	00008067          	ret

0000000080001148 <_ZN15MemoryAllocator16initializeMemoryEv>:
size_t MemoryAllocator::NUM_OF_BLOCKS = 0;
size_t MemoryAllocator::numOfFreeBlocks = 0;
MemoryAllocator::FreeBlock* MemoryAllocator::firstFreeBlock = nullptr;

void MemoryAllocator::initializeMemory()
{
    80001148:	ff010113          	addi	sp,sp,-16
    8000114c:	00813423          	sd	s0,8(sp)
    80001150:	01010413          	addi	s0,sp,16

    NUM_OF_BLOCKS = ((uint8*)HEAP_END_ADDR - (uint8*)HEAP_START_ADDR) / MEM_BLOCK_SIZE;
    80001154:	00003797          	auipc	a5,0x3
    80001158:	30c7b783          	ld	a5,780(a5) # 80004460 <_GLOBAL_OFFSET_TABLE_+0x20>
    8000115c:	0007b703          	ld	a4,0(a5)
    80001160:	00003797          	auipc	a5,0x3
    80001164:	2e87b783          	ld	a5,744(a5) # 80004448 <_GLOBAL_OFFSET_TABLE_+0x8>
    80001168:	0007b683          	ld	a3,0(a5)
    8000116c:	40d70733          	sub	a4,a4,a3
    80001170:	00675713          	srli	a4,a4,0x6
    80001174:	00003797          	auipc	a5,0x3
    80001178:	33c78793          	addi	a5,a5,828 # 800044b0 <_ZN15MemoryAllocator13NUM_OF_BLOCKSE>
    8000117c:	00e7b023          	sd	a4,0(a5)
    numOfFreeBlocks = NUM_OF_BLOCKS;
    80001180:	00e7b423          	sd	a4,8(a5)

    firstFreeBlock = (FreeBlock*)(HEAP_START_ADDR);
    80001184:	00d7b823          	sd	a3,16(a5)

    firstFreeBlock->flagFree = true;
    80001188:	00100613          	li	a2,1
    8000118c:	00c68023          	sb	a2,0(a3)
    firstFreeBlock->numOfBlocks = NUM_OF_BLOCKS;
    80001190:	0107b703          	ld	a4,16(a5)
    80001194:	0007b683          	ld	a3,0(a5)
    80001198:	00d73423          	sd	a3,8(a4)
    firstFreeBlock->nextBlock = nullptr;
    8000119c:	00073823          	sd	zero,16(a4)
    firstFreeBlock->previousBlock = nullptr;
    800011a0:	00073c23          	sd	zero,24(a4)
    flagSystemInitialize = 1;
    800011a4:	00c78c23          	sb	a2,24(a5)
}
    800011a8:	00813403          	ld	s0,8(sp)
    800011ac:	01010113          	addi	sp,sp,16
    800011b0:	00008067          	ret

00000000800011b4 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m>:
    occupiedBlock++;
    return occupiedBlock;
}

void MemoryAllocator::remapMemory(FreeBlock **head, FreeBlock *allocatedBlocks, size_t blocksToAllocate)
{
    800011b4:	ff010113          	addi	sp,sp,-16
    800011b8:	00813423          	sd	s0,8(sp)
    800011bc:	01010413          	addi	s0,sp,16

    if(allocatedBlocks->numOfBlocks == 0)
    800011c0:	0085b783          	ld	a5,8(a1)
    800011c4:	04079263          	bnez	a5,80001208 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x54>
    {

        if(allocatedBlocks->previousBlock)
    800011c8:	0185b783          	ld	a5,24(a1)
    800011cc:	00078663          	beqz	a5,800011d8 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x24>
        {
            allocatedBlocks->previousBlock->nextBlock = allocatedBlocks->nextBlock;
    800011d0:	0105b703          	ld	a4,16(a1)
    800011d4:	00e7b823          	sd	a4,16(a5)
        }

        if(allocatedBlocks->nextBlock)
    800011d8:	0105b783          	ld	a5,16(a1)
    800011dc:	00078663          	beqz	a5,800011e8 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x34>
        {
            allocatedBlocks->nextBlock->previousBlock = allocatedBlocks->previousBlock;
    800011e0:	0185b703          	ld	a4,24(a1)
    800011e4:	00e7bc23          	sd	a4,24(a5)
        }

        if(*head == allocatedBlocks)
    800011e8:	00053783          	ld	a5,0(a0) # 1000 <_entry-0x7ffff000>
    800011ec:	00b78863          	beq	a5,a1,800011fc <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x48>
        {
            *head = newFreeBlock;
        }
    }

}
    800011f0:	00813403          	ld	s0,8(sp)
    800011f4:	01010113          	addi	sp,sp,16
    800011f8:	00008067          	ret
            *head = allocatedBlocks->nextBlock;
    800011fc:	0105b783          	ld	a5,16(a1)
    80001200:	00f53023          	sd	a5,0(a0)
    80001204:	fedff06f          	j	800011f0 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x3c>
        FreeBlock* newFreeBlock = (FreeBlock*)((uint8*)allocatedBlocks + blocksToAllocate * MEM_BLOCK_SIZE);
    80001208:	00661613          	slli	a2,a2,0x6
    8000120c:	00c58633          	add	a2,a1,a2
        newFreeBlock->flagFree = true;
    80001210:	00100793          	li	a5,1
    80001214:	00f60023          	sb	a5,0(a2)
        newFreeBlock->numOfBlocks = allocatedBlocks->numOfBlocks;
    80001218:	0085b783          	ld	a5,8(a1)
    8000121c:	00f63423          	sd	a5,8(a2)
        if(allocatedBlocks->previousBlock)
    80001220:	0185b783          	ld	a5,24(a1)
    80001224:	00078463          	beqz	a5,8000122c <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x78>
            allocatedBlocks->previousBlock->nextBlock = newFreeBlock;
    80001228:	00c7b823          	sd	a2,16(a5)
        newFreeBlock->previousBlock = allocatedBlocks->previousBlock;
    8000122c:	0185b783          	ld	a5,24(a1)
    80001230:	00f63c23          	sd	a5,24(a2)
        newFreeBlock->nextBlock = allocatedBlocks->nextBlock;
    80001234:	0105b783          	ld	a5,16(a1)
    80001238:	00f63823          	sd	a5,16(a2)
        if(*head == allocatedBlocks)
    8000123c:	00053783          	ld	a5,0(a0)
    80001240:	fab798e3          	bne	a5,a1,800011f0 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x3c>
            *head = newFreeBlock;
    80001244:	00c53023          	sd	a2,0(a0)
}
    80001248:	fa9ff06f          	j	800011f0 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x3c>

000000008000124c <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm>:
{
    8000124c:	fe010113          	addi	sp,sp,-32
    80001250:	00113c23          	sd	ra,24(sp)
    80001254:	00813823          	sd	s0,16(sp)
    80001258:	00913423          	sd	s1,8(sp)
    8000125c:	01213023          	sd	s2,0(sp)
    80001260:	02010413          	addi	s0,sp,32
    80001264:	00058493          	mv	s1,a1
    FreeBlock* bestBlock = *head;
    80001268:	00053903          	ld	s2,0(a0)
    for(FreeBlock* curr = (*head)->nextBlock; curr; curr = curr->nextBlock)
    8000126c:	01093783          	ld	a5,16(s2)
    80001270:	0080006f          	j	80001278 <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm+0x2c>
    80001274:	0107b783          	ld	a5,16(a5)
    80001278:	00078e63          	beqz	a5,80001294 <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm+0x48>
        if(curr->numOfBlocks > blocksToAllocate)
    8000127c:	0087b703          	ld	a4,8(a5)
    80001280:	fee4fae3          	bgeu	s1,a4,80001274 <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm+0x28>
            if(bestBlock->numOfBlocks > curr->numOfBlocks)
    80001284:	00893683          	ld	a3,8(s2)
    80001288:	fed776e3          	bgeu	a4,a3,80001274 <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm+0x28>
                bestBlock = curr;
    8000128c:	00078913          	mv	s2,a5
    80001290:	fe5ff06f          	j	80001274 <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm+0x28>
    numOfFreeBlocks -= blocksToAllocate;
    80001294:	00003717          	auipc	a4,0x3
    80001298:	21c70713          	addi	a4,a4,540 # 800044b0 <_ZN15MemoryAllocator13NUM_OF_BLOCKSE>
    8000129c:	00873783          	ld	a5,8(a4)
    800012a0:	409787b3          	sub	a5,a5,s1
    800012a4:	00f73423          	sd	a5,8(a4)
    bestBlock->numOfBlocks -= blocksToAllocate;
    800012a8:	00893783          	ld	a5,8(s2)
    800012ac:	409787b3          	sub	a5,a5,s1
    800012b0:	00f93423          	sd	a5,8(s2)
    remapMemory(head, bestBlock, blocksToAllocate);
    800012b4:	00048613          	mv	a2,s1
    800012b8:	00090593          	mv	a1,s2
    800012bc:	00000097          	auipc	ra,0x0
    800012c0:	ef8080e7          	jalr	-264(ra) # 800011b4 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m>
    occupiedBlock->flagFree = false;
    800012c4:	00090023          	sb	zero,0(s2)
    occupiedBlock->numOfBlocks = blocksToAllocate;
    800012c8:	00993423          	sd	s1,8(s2)
}
    800012cc:	01090513          	addi	a0,s2,16
    800012d0:	01813083          	ld	ra,24(sp)
    800012d4:	01013403          	ld	s0,16(sp)
    800012d8:	00813483          	ld	s1,8(sp)
    800012dc:	00013903          	ld	s2,0(sp)
    800012e0:	02010113          	addi	sp,sp,32
    800012e4:	00008067          	ret

00000000800012e8 <_ZN15MemoryAllocator14allocateMemoryEm>:
{
    800012e8:	fe010113          	addi	sp,sp,-32
    800012ec:	00113c23          	sd	ra,24(sp)
    800012f0:	00813823          	sd	s0,16(sp)
    800012f4:	00913423          	sd	s1,8(sp)
    800012f8:	02010413          	addi	s0,sp,32
    800012fc:	00050493          	mv	s1,a0
    if(!flagSystemInitialize)
    80001300:	00003797          	auipc	a5,0x3
    80001304:	1c87c783          	lbu	a5,456(a5) # 800044c8 <_ZN15MemoryAllocator20flagSystemInitializeE>
    80001308:	02078c63          	beqz	a5,80001340 <_ZN15MemoryAllocator14allocateMemoryEm+0x58>
    if(numOfFreeBlocks < blocksToAllocate)
    8000130c:	00003797          	auipc	a5,0x3
    80001310:	1ac7b783          	ld	a5,428(a5) # 800044b8 <_ZN15MemoryAllocator15numOfFreeBlocksE>
    80001314:	0297ec63          	bltu	a5,s1,8000134c <_ZN15MemoryAllocator14allocateMemoryEm+0x64>
    return findBestFit(&firstFreeBlock, blocksToAllocate);
    80001318:	00048593          	mv	a1,s1
    8000131c:	00003517          	auipc	a0,0x3
    80001320:	1a450513          	addi	a0,a0,420 # 800044c0 <_ZN15MemoryAllocator14firstFreeBlockE>
    80001324:	00000097          	auipc	ra,0x0
    80001328:	f28080e7          	jalr	-216(ra) # 8000124c <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm>
}
    8000132c:	01813083          	ld	ra,24(sp)
    80001330:	01013403          	ld	s0,16(sp)
    80001334:	00813483          	ld	s1,8(sp)
    80001338:	02010113          	addi	sp,sp,32
    8000133c:	00008067          	ret
        initializeMemory();
    80001340:	00000097          	auipc	ra,0x0
    80001344:	e08080e7          	jalr	-504(ra) # 80001148 <_ZN15MemoryAllocator16initializeMemoryEv>
    80001348:	fc5ff06f          	j	8000130c <_ZN15MemoryAllocator14allocateMemoryEm+0x24>
        return nullptr;
    8000134c:	00000513          	li	a0,0
    80001350:	fddff06f          	j	8000132c <_ZN15MemoryAllocator14allocateMemoryEm+0x44>

0000000080001354 <_ZN15MemoryAllocator17findNextFreeBlockEPNS_9FreeBlockE>:
MemoryAllocator::FreeBlock* MemoryAllocator::findNextFreeBlock(FreeBlock* memoryToFree)
{
    80001354:	ff010113          	addi	sp,sp,-16
    80001358:	00813423          	sd	s0,8(sp)
    8000135c:	01010413          	addi	s0,sp,16
    80001360:	00050793          	mv	a5,a0
    for(uint8* i = (uint8*)memoryToFree; i + (((OccupiedBlock*)i)->numOfBlocks * MEM_BLOCK_SIZE) <= (uint8*)HEAP_END_ADDR; i+= (((OccupiedBlock*)i)->numOfBlocks * MEM_BLOCK_SIZE))
    80001364:	0087b703          	ld	a4,8(a5)
    80001368:	00671713          	slli	a4,a4,0x6
    8000136c:	00078513          	mv	a0,a5
    80001370:	00e787b3          	add	a5,a5,a4
    80001374:	00003717          	auipc	a4,0x3
    80001378:	0ec73703          	ld	a4,236(a4) # 80004460 <_GLOBAL_OFFSET_TABLE_+0x20>
    8000137c:	00073703          	ld	a4,0(a4)
    80001380:	00f76863          	bltu	a4,a5,80001390 <_ZN15MemoryAllocator17findNextFreeBlockEPNS_9FreeBlockE+0x3c>
    {
        if(((FreeBlock*)i)->flagFree)
    80001384:	00054703          	lbu	a4,0(a0)
    80001388:	fc070ee3          	beqz	a4,80001364 <_ZN15MemoryAllocator17findNextFreeBlockEPNS_9FreeBlockE+0x10>
    8000138c:	0080006f          	j	80001394 <_ZN15MemoryAllocator17findNextFreeBlockEPNS_9FreeBlockE+0x40>
        {
            return (FreeBlock*)i;
        }
    }
    return nullptr;
    80001390:	00000513          	li	a0,0
}
    80001394:	00813403          	ld	s0,8(sp)
    80001398:	01010113          	addi	sp,sp,16
    8000139c:	00008067          	ret

00000000800013a0 <_ZN15MemoryAllocator21findPreviousFreeBlockEPNS_9FreeBlockES1_>:

MemoryAllocator::FreeBlock* MemoryAllocator::findPreviousFreeBlock(FreeBlock* head, FreeBlock* memoryToFree)
{
    800013a0:	ff010113          	addi	sp,sp,-16
    800013a4:	00813423          	sd	s0,8(sp)
    800013a8:	01010413          	addi	s0,sp,16
    FreeBlock* temp = head;
    for(; temp && temp <= memoryToFree; temp = temp->nextBlock){}
    800013ac:	00050863          	beqz	a0,800013bc <_ZN15MemoryAllocator21findPreviousFreeBlockEPNS_9FreeBlockES1_+0x1c>
    800013b0:	00a5e663          	bltu	a1,a0,800013bc <_ZN15MemoryAllocator21findPreviousFreeBlockEPNS_9FreeBlockES1_+0x1c>
    800013b4:	01053503          	ld	a0,16(a0)
    800013b8:	ff5ff06f          	j	800013ac <_ZN15MemoryAllocator21findPreviousFreeBlockEPNS_9FreeBlockES1_+0xc>
    if(!temp)
    800013bc:	00050463          	beqz	a0,800013c4 <_ZN15MemoryAllocator21findPreviousFreeBlockEPNS_9FreeBlockES1_+0x24>
    {
        return nullptr;
    }
    return temp->previousBlock;
    800013c0:	01853503          	ld	a0,24(a0)
}
    800013c4:	00813403          	ld	s0,8(sp)
    800013c8:	01010113          	addi	sp,sp,16
    800013cc:	00008067          	ret

00000000800013d0 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_>:

    return 0;
}

void MemoryAllocator::connectAdjacentBlocks(FreeBlock* previousBlock, FreeBlock* adjacentBlock)
{
    800013d0:	ff010113          	addi	sp,sp,-16
    800013d4:	00813423          	sd	s0,8(sp)
    800013d8:	01010413          	addi	s0,sp,16


    if(adjacentBlock == (FreeBlock*)((uint8 *)previousBlock + previousBlock->numOfBlocks * MEM_BLOCK_SIZE))
    800013dc:	00853703          	ld	a4,8(a0)
    800013e0:	00671793          	slli	a5,a4,0x6
    800013e4:	00f507b3          	add	a5,a0,a5
    800013e8:	00b78e63          	beq	a5,a1,80001404 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_+0x34>
        adjacentBlock->previousBlock = nullptr;

    }
    else
    {
        previousBlock->nextBlock = adjacentBlock;
    800013ec:	00b53823          	sd	a1,16(a0)
        if(adjacentBlock)
    800013f0:	00058463          	beqz	a1,800013f8 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_+0x28>
        {
            adjacentBlock->previousBlock = previousBlock;
    800013f4:	00a5bc23          	sd	a0,24(a1)
        }

    }
}
    800013f8:	00813403          	ld	s0,8(sp)
    800013fc:	01010113          	addi	sp,sp,16
    80001400:	00008067          	ret
        previousBlock->numOfBlocks += adjacentBlock->numOfBlocks;
    80001404:	0085b783          	ld	a5,8(a1)
    80001408:	00f70733          	add	a4,a4,a5
    8000140c:	00e53423          	sd	a4,8(a0)
        previousBlock->nextBlock = adjacentBlock->nextBlock;
    80001410:	0105b783          	ld	a5,16(a1)
    80001414:	00f53823          	sd	a5,16(a0)
        previousBlock->previousBlock = (previousBlock == adjacentBlock->previousBlock ? nullptr : adjacentBlock->previousBlock);
    80001418:	0185b783          	ld	a5,24(a1)
    8000141c:	00a78e63          	beq	a5,a0,80001438 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_+0x68>
    80001420:	00f53c23          	sd	a5,24(a0)
        adjacentBlock->flagFree = false;
    80001424:	00058023          	sb	zero,0(a1)
        adjacentBlock->numOfBlocks = 0;
    80001428:	0005b423          	sd	zero,8(a1)
        adjacentBlock->nextBlock = nullptr;
    8000142c:	0005b823          	sd	zero,16(a1)
        adjacentBlock->previousBlock = nullptr;
    80001430:	0005bc23          	sd	zero,24(a1)
    80001434:	fc5ff06f          	j	800013f8 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_+0x28>
        previousBlock->previousBlock = (previousBlock == adjacentBlock->previousBlock ? nullptr : adjacentBlock->previousBlock);
    80001438:	00000793          	li	a5,0
    8000143c:	fe5ff06f          	j	80001420 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_+0x50>

0000000080001440 <_ZN15MemoryAllocator10freeMemoryEPv>:
    if(!addressToFree)
    80001440:	0c050e63          	beqz	a0,8000151c <_ZN15MemoryAllocator10freeMemoryEPv+0xdc>
{
    80001444:	fc010113          	addi	sp,sp,-64
    80001448:	02113c23          	sd	ra,56(sp)
    8000144c:	02813823          	sd	s0,48(sp)
    80001450:	02913423          	sd	s1,40(sp)
    80001454:	03213023          	sd	s2,32(sp)
    80001458:	01313c23          	sd	s3,24(sp)
    8000145c:	01413823          	sd	s4,16(sp)
    80001460:	01513423          	sd	s5,8(sp)
    80001464:	04010413          	addi	s0,sp,64
    80001468:	00050493          	mv	s1,a0
    tempAddress--;
    8000146c:	ff050913          	addi	s2,a0,-16
    int numOfTakenBlocks = tempAddress->numOfBlocks;
    80001470:	ff852a83          	lw	s5,-8(a0)
    numOfFreeBlocks += numOfTakenBlocks;
    80001474:	00003997          	auipc	s3,0x3
    80001478:	03c98993          	addi	s3,s3,60 # 800044b0 <_ZN15MemoryAllocator13NUM_OF_BLOCKSE>
    8000147c:	0089b783          	ld	a5,8(s3)
    80001480:	015787b3          	add	a5,a5,s5
    80001484:	00f9b423          	sd	a5,8(s3)
    FreeBlock* nextFreeBlock = findNextFreeBlock(newFreeBlock);
    80001488:	00090513          	mv	a0,s2
    8000148c:	00000097          	auipc	ra,0x0
    80001490:	ec8080e7          	jalr	-312(ra) # 80001354 <_ZN15MemoryAllocator17findNextFreeBlockEPNS_9FreeBlockE>
    80001494:	00050a13          	mv	s4,a0
    FreeBlock* previousFreeBlock = findPreviousFreeBlock(firstFreeBlock, newFreeBlock);
    80001498:	00090593          	mv	a1,s2
    8000149c:	0109b503          	ld	a0,16(s3)
    800014a0:	00000097          	auipc	ra,0x0
    800014a4:	f00080e7          	jalr	-256(ra) # 800013a0 <_ZN15MemoryAllocator21findPreviousFreeBlockEPNS_9FreeBlockES1_>
    800014a8:	00050993          	mv	s3,a0
    newFreeBlock->flagFree = true;
    800014ac:	00100793          	li	a5,1
    800014b0:	fef48823          	sb	a5,-16(s1)
    newFreeBlock->numOfBlocks = numOfTakenBlocks;
    800014b4:	ff54bc23          	sd	s5,-8(s1)
    newFreeBlock->nextBlock = nullptr;
    800014b8:	0004b023          	sd	zero,0(s1)
    newFreeBlock->previousBlock = nullptr;
    800014bc:	0004b423          	sd	zero,8(s1)
    connectAdjacentBlocks(newFreeBlock, nextFreeBlock);
    800014c0:	000a0593          	mv	a1,s4
    800014c4:	00090513          	mv	a0,s2
    800014c8:	00000097          	auipc	ra,0x0
    800014cc:	f08080e7          	jalr	-248(ra) # 800013d0 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_>
    if(previousFreeBlock)
    800014d0:	02098e63          	beqz	s3,8000150c <_ZN15MemoryAllocator10freeMemoryEPv+0xcc>
        connectAdjacentBlocks(previousFreeBlock, newFreeBlock);
    800014d4:	00090593          	mv	a1,s2
    800014d8:	00098513          	mv	a0,s3
    800014dc:	00000097          	auipc	ra,0x0
    800014e0:	ef4080e7          	jalr	-268(ra) # 800013d0 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_>
    return 0;
    800014e4:	00000513          	li	a0,0
}
    800014e8:	03813083          	ld	ra,56(sp)
    800014ec:	03013403          	ld	s0,48(sp)
    800014f0:	02813483          	ld	s1,40(sp)
    800014f4:	02013903          	ld	s2,32(sp)
    800014f8:	01813983          	ld	s3,24(sp)
    800014fc:	01013a03          	ld	s4,16(sp)
    80001500:	00813a83          	ld	s5,8(sp)
    80001504:	04010113          	addi	sp,sp,64
    80001508:	00008067          	ret
        firstFreeBlock = newFreeBlock;
    8000150c:	00003797          	auipc	a5,0x3
    80001510:	fb27ba23          	sd	s2,-76(a5) # 800044c0 <_ZN15MemoryAllocator14firstFreeBlockE>
    return 0;
    80001514:	00000513          	li	a0,0
    80001518:	fd1ff06f          	j	800014e8 <_ZN15MemoryAllocator10freeMemoryEPv+0xa8>
        return -1;
    8000151c:	fff00513          	li	a0,-1
}
    80001520:	00008067          	ret

0000000080001524 <_ZN15MemoryAllocator19getLargestFreeBlockEv>:

size_t  MemoryAllocator::getLargestFreeBlock()
{
    80001524:	ff010113          	addi	sp,sp,-16
    80001528:	00813423          	sd	s0,8(sp)
    8000152c:	01010413          	addi	s0,sp,16
    size_t largestBlock = firstFreeBlock->numOfBlocks;
    80001530:	00003797          	auipc	a5,0x3
    80001534:	f907b783          	ld	a5,-112(a5) # 800044c0 <_ZN15MemoryAllocator14firstFreeBlockE>
    80001538:	0087b503          	ld	a0,8(a5)
    for(FreeBlock* curr = firstFreeBlock->nextBlock; curr; curr = curr->nextBlock)
    8000153c:	0107b783          	ld	a5,16(a5)
    80001540:	0080006f          	j	80001548 <_ZN15MemoryAllocator19getLargestFreeBlockEv+0x24>
    80001544:	0107b783          	ld	a5,16(a5)
    80001548:	00078a63          	beqz	a5,8000155c <_ZN15MemoryAllocator19getLargestFreeBlockEv+0x38>
    {
        if(curr->numOfBlocks > largestBlock)
    8000154c:	0087b703          	ld	a4,8(a5)
    80001550:	fee57ae3          	bgeu	a0,a4,80001544 <_ZN15MemoryAllocator19getLargestFreeBlockEv+0x20>
        {
            largestBlock = curr->numOfBlocks;
    80001554:	00070513          	mv	a0,a4
    80001558:	fedff06f          	j	80001544 <_ZN15MemoryAllocator19getLargestFreeBlockEv+0x20>
        }
    }
    return largestBlock * MEM_BLOCK_SIZE;
}
    8000155c:	00651513          	slli	a0,a0,0x6
    80001560:	00813403          	ld	s0,8(sp)
    80001564:	01010113          	addi	sp,sp,16
    80001568:	00008067          	ret

000000008000156c <_ZN15MemoryAllocator12getFreeSpaceEv>:
size_t MemoryAllocator::getFreeSpace()
{
    8000156c:	ff010113          	addi	sp,sp,-16
    80001570:	00813423          	sd	s0,8(sp)
    80001574:	01010413          	addi	s0,sp,16
    return numOfFreeBlocks * MEM_BLOCK_SIZE;
}
    80001578:	00003517          	auipc	a0,0x3
    8000157c:	f4053503          	ld	a0,-192(a0) # 800044b8 <_ZN15MemoryAllocator15numOfFreeBlocksE>
    80001580:	00651513          	slli	a0,a0,0x6
    80001584:	00813403          	ld	s0,8(sp)
    80001588:	01010113          	addi	sp,sp,16
    8000158c:	00008067          	ret

0000000080001590 <_ZN6Kernel16initializeKernelEv>:

#include "../h/Kernel.hpp"
extern "C" void interrupt_trap(void);

void Kernel::initializeKernel()
{
    80001590:	ff010113          	addi	sp,sp,-16
    80001594:	00813423          	sd	s0,8(sp)
    80001598:	01010413          	addi	s0,sp,16
    static void setInterruptRoutine(void (*routine)(void));
    static void interruptHandler(void);
};

inline void Kernel::setInterruptRoutine(void (*routine)(void)) {
    Machine::writeStvec((uint64) routine);
    8000159c:	00003797          	auipc	a5,0x3
    800015a0:	ebc7b783          	ld	a5,-324(a5) # 80004458 <_GLOBAL_OFFSET_TABLE_+0x18>
    friend class Kernel;
};

inline void Machine::writeStvec(uint64 interruptAddress)
{
    __asm__ volatile ("csrw stvec, %[address]": : [address] "r"(interruptAddress));
    800015a4:	10579073          	csrw	stvec,a5
    Kernel::setInterruptRoutine(&interrupt_trap);
}
    800015a8:	00813403          	ld	s0,8(sp)
    800015ac:	01010113          	addi	sp,sp,16
    800015b0:	00008067          	ret

00000000800015b4 <_ZN6Kernel16interruptHandlerEv>:
void Kernel::interruptHandler(void)
{
    800015b4:	ff010113          	addi	sp,sp,-16
    800015b8:	00813423          	sd	s0,8(sp)
    800015bc:	01010413          	addi	s0,sp,16
}

inline uint64 Machine::readScause(void)
{
    uint64 scause;
    __asm__ volatile ("csrr %[cause], scause": [cause] "=r"(scause));
    800015c0:	142027f3          	csrr	a5,scause
    uint64 scause = Machine::readScause();
    if(scause == 0x0000000000000008UL || scause == 0x0000000000000009UL)
    800015c4:	ff878793          	addi	a5,a5,-8
    800015c8:	00100713          	li	a4,1
    800015cc:	00f77863          	bgeu	a4,a5,800015dc <_ZN6Kernel16interruptHandlerEv+0x28>
    {
        Machine::incrementSepc();
    }

    800015d0:	00813403          	ld	s0,8(sp)
    800015d4:	01010113          	addi	sp,sp,16
    800015d8:	00008067          	ret
    return scause;
}

inline void Machine::incrementSepc(void)
{
    __asm__ volatile ("csrr t0, sepc");
    800015dc:	141022f3          	csrr	t0,sepc
    __asm__ volatile ("addi t0, t0, 0x4");
    800015e0:	00428293          	addi	t0,t0,4
    __asm__ volatile ("csrw sepc, t0");
    800015e4:	14129073          	csrw	sepc,t0
    800015e8:	fe9ff06f          	j	800015d0 <_ZN6Kernel16interruptHandlerEv+0x1c>

00000000800015ec <start>:
    800015ec:	ff010113          	addi	sp,sp,-16
    800015f0:	00813423          	sd	s0,8(sp)
    800015f4:	01010413          	addi	s0,sp,16
    800015f8:	300027f3          	csrr	a5,mstatus
    800015fc:	ffffe737          	lui	a4,0xffffe
    80001600:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff90df>
    80001604:	00e7f7b3          	and	a5,a5,a4
    80001608:	00001737          	lui	a4,0x1
    8000160c:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80001610:	00e7e7b3          	or	a5,a5,a4
    80001614:	30079073          	csrw	mstatus,a5
    80001618:	00000797          	auipc	a5,0x0
    8000161c:	16078793          	addi	a5,a5,352 # 80001778 <system_main>
    80001620:	34179073          	csrw	mepc,a5
    80001624:	00000793          	li	a5,0
    80001628:	18079073          	csrw	satp,a5
    8000162c:	000107b7          	lui	a5,0x10
    80001630:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80001634:	30279073          	csrw	medeleg,a5
    80001638:	30379073          	csrw	mideleg,a5
    8000163c:	104027f3          	csrr	a5,sie
    80001640:	2227e793          	ori	a5,a5,546
    80001644:	10479073          	csrw	sie,a5
    80001648:	fff00793          	li	a5,-1
    8000164c:	00a7d793          	srli	a5,a5,0xa
    80001650:	3b079073          	csrw	pmpaddr0,a5
    80001654:	00f00793          	li	a5,15
    80001658:	3a079073          	csrw	pmpcfg0,a5
    8000165c:	f14027f3          	csrr	a5,mhartid
    80001660:	0200c737          	lui	a4,0x200c
    80001664:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80001668:	0007869b          	sext.w	a3,a5
    8000166c:	00269713          	slli	a4,a3,0x2
    80001670:	000f4637          	lui	a2,0xf4
    80001674:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80001678:	00d70733          	add	a4,a4,a3
    8000167c:	0037979b          	slliw	a5,a5,0x3
    80001680:	020046b7          	lui	a3,0x2004
    80001684:	00d787b3          	add	a5,a5,a3
    80001688:	00c585b3          	add	a1,a1,a2
    8000168c:	00371693          	slli	a3,a4,0x3
    80001690:	00003717          	auipc	a4,0x3
    80001694:	e4070713          	addi	a4,a4,-448 # 800044d0 <timer_scratch>
    80001698:	00b7b023          	sd	a1,0(a5)
    8000169c:	00d70733          	add	a4,a4,a3
    800016a0:	00f73c23          	sd	a5,24(a4)
    800016a4:	02c73023          	sd	a2,32(a4)
    800016a8:	34071073          	csrw	mscratch,a4
    800016ac:	00000797          	auipc	a5,0x0
    800016b0:	6e478793          	addi	a5,a5,1764 # 80001d90 <timervec>
    800016b4:	30579073          	csrw	mtvec,a5
    800016b8:	300027f3          	csrr	a5,mstatus
    800016bc:	0087e793          	ori	a5,a5,8
    800016c0:	30079073          	csrw	mstatus,a5
    800016c4:	304027f3          	csrr	a5,mie
    800016c8:	0807e793          	ori	a5,a5,128
    800016cc:	30479073          	csrw	mie,a5
    800016d0:	f14027f3          	csrr	a5,mhartid
    800016d4:	0007879b          	sext.w	a5,a5
    800016d8:	00078213          	mv	tp,a5
    800016dc:	30200073          	mret
    800016e0:	00813403          	ld	s0,8(sp)
    800016e4:	01010113          	addi	sp,sp,16
    800016e8:	00008067          	ret

00000000800016ec <timerinit>:
    800016ec:	ff010113          	addi	sp,sp,-16
    800016f0:	00813423          	sd	s0,8(sp)
    800016f4:	01010413          	addi	s0,sp,16
    800016f8:	f14027f3          	csrr	a5,mhartid
    800016fc:	0200c737          	lui	a4,0x200c
    80001700:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80001704:	0007869b          	sext.w	a3,a5
    80001708:	00269713          	slli	a4,a3,0x2
    8000170c:	000f4637          	lui	a2,0xf4
    80001710:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80001714:	00d70733          	add	a4,a4,a3
    80001718:	0037979b          	slliw	a5,a5,0x3
    8000171c:	020046b7          	lui	a3,0x2004
    80001720:	00d787b3          	add	a5,a5,a3
    80001724:	00c585b3          	add	a1,a1,a2
    80001728:	00371693          	slli	a3,a4,0x3
    8000172c:	00003717          	auipc	a4,0x3
    80001730:	da470713          	addi	a4,a4,-604 # 800044d0 <timer_scratch>
    80001734:	00b7b023          	sd	a1,0(a5)
    80001738:	00d70733          	add	a4,a4,a3
    8000173c:	00f73c23          	sd	a5,24(a4)
    80001740:	02c73023          	sd	a2,32(a4)
    80001744:	34071073          	csrw	mscratch,a4
    80001748:	00000797          	auipc	a5,0x0
    8000174c:	64878793          	addi	a5,a5,1608 # 80001d90 <timervec>
    80001750:	30579073          	csrw	mtvec,a5
    80001754:	300027f3          	csrr	a5,mstatus
    80001758:	0087e793          	ori	a5,a5,8
    8000175c:	30079073          	csrw	mstatus,a5
    80001760:	304027f3          	csrr	a5,mie
    80001764:	0807e793          	ori	a5,a5,128
    80001768:	30479073          	csrw	mie,a5
    8000176c:	00813403          	ld	s0,8(sp)
    80001770:	01010113          	addi	sp,sp,16
    80001774:	00008067          	ret

0000000080001778 <system_main>:
    80001778:	fe010113          	addi	sp,sp,-32
    8000177c:	00813823          	sd	s0,16(sp)
    80001780:	00913423          	sd	s1,8(sp)
    80001784:	00113c23          	sd	ra,24(sp)
    80001788:	02010413          	addi	s0,sp,32
    8000178c:	00000097          	auipc	ra,0x0
    80001790:	0c4080e7          	jalr	196(ra) # 80001850 <cpuid>
    80001794:	00003497          	auipc	s1,0x3
    80001798:	cec48493          	addi	s1,s1,-788 # 80004480 <started>
    8000179c:	02050263          	beqz	a0,800017c0 <system_main+0x48>
    800017a0:	0004a783          	lw	a5,0(s1)
    800017a4:	0007879b          	sext.w	a5,a5
    800017a8:	fe078ce3          	beqz	a5,800017a0 <system_main+0x28>
    800017ac:	0ff0000f          	fence
    800017b0:	00003517          	auipc	a0,0x3
    800017b4:	8a050513          	addi	a0,a0,-1888 # 80004050 <CONSOLE_STATUS+0x40>
    800017b8:	00001097          	auipc	ra,0x1
    800017bc:	a74080e7          	jalr	-1420(ra) # 8000222c <panic>
    800017c0:	00001097          	auipc	ra,0x1
    800017c4:	9c8080e7          	jalr	-1592(ra) # 80002188 <consoleinit>
    800017c8:	00001097          	auipc	ra,0x1
    800017cc:	154080e7          	jalr	340(ra) # 8000291c <printfinit>
    800017d0:	00003517          	auipc	a0,0x3
    800017d4:	96050513          	addi	a0,a0,-1696 # 80004130 <CONSOLE_STATUS+0x120>
    800017d8:	00001097          	auipc	ra,0x1
    800017dc:	ab0080e7          	jalr	-1360(ra) # 80002288 <__printf>
    800017e0:	00003517          	auipc	a0,0x3
    800017e4:	84050513          	addi	a0,a0,-1984 # 80004020 <CONSOLE_STATUS+0x10>
    800017e8:	00001097          	auipc	ra,0x1
    800017ec:	aa0080e7          	jalr	-1376(ra) # 80002288 <__printf>
    800017f0:	00003517          	auipc	a0,0x3
    800017f4:	94050513          	addi	a0,a0,-1728 # 80004130 <CONSOLE_STATUS+0x120>
    800017f8:	00001097          	auipc	ra,0x1
    800017fc:	a90080e7          	jalr	-1392(ra) # 80002288 <__printf>
    80001800:	00001097          	auipc	ra,0x1
    80001804:	4a8080e7          	jalr	1192(ra) # 80002ca8 <kinit>
    80001808:	00000097          	auipc	ra,0x0
    8000180c:	148080e7          	jalr	328(ra) # 80001950 <trapinit>
    80001810:	00000097          	auipc	ra,0x0
    80001814:	16c080e7          	jalr	364(ra) # 8000197c <trapinithart>
    80001818:	00000097          	auipc	ra,0x0
    8000181c:	5b8080e7          	jalr	1464(ra) # 80001dd0 <plicinit>
    80001820:	00000097          	auipc	ra,0x0
    80001824:	5d8080e7          	jalr	1496(ra) # 80001df8 <plicinithart>
    80001828:	00000097          	auipc	ra,0x0
    8000182c:	078080e7          	jalr	120(ra) # 800018a0 <userinit>
    80001830:	0ff0000f          	fence
    80001834:	00100793          	li	a5,1
    80001838:	00003517          	auipc	a0,0x3
    8000183c:	80050513          	addi	a0,a0,-2048 # 80004038 <CONSOLE_STATUS+0x28>
    80001840:	00f4a023          	sw	a5,0(s1)
    80001844:	00001097          	auipc	ra,0x1
    80001848:	a44080e7          	jalr	-1468(ra) # 80002288 <__printf>
    8000184c:	0000006f          	j	8000184c <system_main+0xd4>

0000000080001850 <cpuid>:
    80001850:	ff010113          	addi	sp,sp,-16
    80001854:	00813423          	sd	s0,8(sp)
    80001858:	01010413          	addi	s0,sp,16
    8000185c:	00020513          	mv	a0,tp
    80001860:	00813403          	ld	s0,8(sp)
    80001864:	0005051b          	sext.w	a0,a0
    80001868:	01010113          	addi	sp,sp,16
    8000186c:	00008067          	ret

0000000080001870 <mycpu>:
    80001870:	ff010113          	addi	sp,sp,-16
    80001874:	00813423          	sd	s0,8(sp)
    80001878:	01010413          	addi	s0,sp,16
    8000187c:	00020793          	mv	a5,tp
    80001880:	00813403          	ld	s0,8(sp)
    80001884:	0007879b          	sext.w	a5,a5
    80001888:	00779793          	slli	a5,a5,0x7
    8000188c:	00004517          	auipc	a0,0x4
    80001890:	c7450513          	addi	a0,a0,-908 # 80005500 <cpus>
    80001894:	00f50533          	add	a0,a0,a5
    80001898:	01010113          	addi	sp,sp,16
    8000189c:	00008067          	ret

00000000800018a0 <userinit>:
    800018a0:	ff010113          	addi	sp,sp,-16
    800018a4:	00813423          	sd	s0,8(sp)
    800018a8:	01010413          	addi	s0,sp,16
    800018ac:	00813403          	ld	s0,8(sp)
    800018b0:	01010113          	addi	sp,sp,16
    800018b4:	00000317          	auipc	t1,0x0
    800018b8:	85c30067          	jr	-1956(t1) # 80001110 <main>

00000000800018bc <either_copyout>:
    800018bc:	ff010113          	addi	sp,sp,-16
    800018c0:	00813023          	sd	s0,0(sp)
    800018c4:	00113423          	sd	ra,8(sp)
    800018c8:	01010413          	addi	s0,sp,16
    800018cc:	02051663          	bnez	a0,800018f8 <either_copyout+0x3c>
    800018d0:	00058513          	mv	a0,a1
    800018d4:	00060593          	mv	a1,a2
    800018d8:	0006861b          	sext.w	a2,a3
    800018dc:	00002097          	auipc	ra,0x2
    800018e0:	c58080e7          	jalr	-936(ra) # 80003534 <__memmove>
    800018e4:	00813083          	ld	ra,8(sp)
    800018e8:	00013403          	ld	s0,0(sp)
    800018ec:	00000513          	li	a0,0
    800018f0:	01010113          	addi	sp,sp,16
    800018f4:	00008067          	ret
    800018f8:	00002517          	auipc	a0,0x2
    800018fc:	78050513          	addi	a0,a0,1920 # 80004078 <CONSOLE_STATUS+0x68>
    80001900:	00001097          	auipc	ra,0x1
    80001904:	92c080e7          	jalr	-1748(ra) # 8000222c <panic>

0000000080001908 <either_copyin>:
    80001908:	ff010113          	addi	sp,sp,-16
    8000190c:	00813023          	sd	s0,0(sp)
    80001910:	00113423          	sd	ra,8(sp)
    80001914:	01010413          	addi	s0,sp,16
    80001918:	02059463          	bnez	a1,80001940 <either_copyin+0x38>
    8000191c:	00060593          	mv	a1,a2
    80001920:	0006861b          	sext.w	a2,a3
    80001924:	00002097          	auipc	ra,0x2
    80001928:	c10080e7          	jalr	-1008(ra) # 80003534 <__memmove>
    8000192c:	00813083          	ld	ra,8(sp)
    80001930:	00013403          	ld	s0,0(sp)
    80001934:	00000513          	li	a0,0
    80001938:	01010113          	addi	sp,sp,16
    8000193c:	00008067          	ret
    80001940:	00002517          	auipc	a0,0x2
    80001944:	76050513          	addi	a0,a0,1888 # 800040a0 <CONSOLE_STATUS+0x90>
    80001948:	00001097          	auipc	ra,0x1
    8000194c:	8e4080e7          	jalr	-1820(ra) # 8000222c <panic>

0000000080001950 <trapinit>:
    80001950:	ff010113          	addi	sp,sp,-16
    80001954:	00813423          	sd	s0,8(sp)
    80001958:	01010413          	addi	s0,sp,16
    8000195c:	00813403          	ld	s0,8(sp)
    80001960:	00002597          	auipc	a1,0x2
    80001964:	76858593          	addi	a1,a1,1896 # 800040c8 <CONSOLE_STATUS+0xb8>
    80001968:	00004517          	auipc	a0,0x4
    8000196c:	c1850513          	addi	a0,a0,-1000 # 80005580 <tickslock>
    80001970:	01010113          	addi	sp,sp,16
    80001974:	00001317          	auipc	t1,0x1
    80001978:	5c430067          	jr	1476(t1) # 80002f38 <initlock>

000000008000197c <trapinithart>:
    8000197c:	ff010113          	addi	sp,sp,-16
    80001980:	00813423          	sd	s0,8(sp)
    80001984:	01010413          	addi	s0,sp,16
    80001988:	00000797          	auipc	a5,0x0
    8000198c:	2f878793          	addi	a5,a5,760 # 80001c80 <kernelvec>
    80001990:	10579073          	csrw	stvec,a5
    80001994:	00813403          	ld	s0,8(sp)
    80001998:	01010113          	addi	sp,sp,16
    8000199c:	00008067          	ret

00000000800019a0 <usertrap>:
    800019a0:	ff010113          	addi	sp,sp,-16
    800019a4:	00813423          	sd	s0,8(sp)
    800019a8:	01010413          	addi	s0,sp,16
    800019ac:	00813403          	ld	s0,8(sp)
    800019b0:	01010113          	addi	sp,sp,16
    800019b4:	00008067          	ret

00000000800019b8 <usertrapret>:
    800019b8:	ff010113          	addi	sp,sp,-16
    800019bc:	00813423          	sd	s0,8(sp)
    800019c0:	01010413          	addi	s0,sp,16
    800019c4:	00813403          	ld	s0,8(sp)
    800019c8:	01010113          	addi	sp,sp,16
    800019cc:	00008067          	ret

00000000800019d0 <kerneltrap>:
    800019d0:	fe010113          	addi	sp,sp,-32
    800019d4:	00813823          	sd	s0,16(sp)
    800019d8:	00113c23          	sd	ra,24(sp)
    800019dc:	00913423          	sd	s1,8(sp)
    800019e0:	02010413          	addi	s0,sp,32
    800019e4:	142025f3          	csrr	a1,scause
    800019e8:	100027f3          	csrr	a5,sstatus
    800019ec:	0027f793          	andi	a5,a5,2
    800019f0:	10079c63          	bnez	a5,80001b08 <kerneltrap+0x138>
    800019f4:	142027f3          	csrr	a5,scause
    800019f8:	0207ce63          	bltz	a5,80001a34 <kerneltrap+0x64>
    800019fc:	00002517          	auipc	a0,0x2
    80001a00:	71450513          	addi	a0,a0,1812 # 80004110 <CONSOLE_STATUS+0x100>
    80001a04:	00001097          	auipc	ra,0x1
    80001a08:	884080e7          	jalr	-1916(ra) # 80002288 <__printf>
    80001a0c:	141025f3          	csrr	a1,sepc
    80001a10:	14302673          	csrr	a2,stval
    80001a14:	00002517          	auipc	a0,0x2
    80001a18:	70c50513          	addi	a0,a0,1804 # 80004120 <CONSOLE_STATUS+0x110>
    80001a1c:	00001097          	auipc	ra,0x1
    80001a20:	86c080e7          	jalr	-1940(ra) # 80002288 <__printf>
    80001a24:	00002517          	auipc	a0,0x2
    80001a28:	71450513          	addi	a0,a0,1812 # 80004138 <CONSOLE_STATUS+0x128>
    80001a2c:	00001097          	auipc	ra,0x1
    80001a30:	800080e7          	jalr	-2048(ra) # 8000222c <panic>
    80001a34:	0ff7f713          	andi	a4,a5,255
    80001a38:	00900693          	li	a3,9
    80001a3c:	04d70063          	beq	a4,a3,80001a7c <kerneltrap+0xac>
    80001a40:	fff00713          	li	a4,-1
    80001a44:	03f71713          	slli	a4,a4,0x3f
    80001a48:	00170713          	addi	a4,a4,1
    80001a4c:	fae798e3          	bne	a5,a4,800019fc <kerneltrap+0x2c>
    80001a50:	00000097          	auipc	ra,0x0
    80001a54:	e00080e7          	jalr	-512(ra) # 80001850 <cpuid>
    80001a58:	06050663          	beqz	a0,80001ac4 <kerneltrap+0xf4>
    80001a5c:	144027f3          	csrr	a5,sip
    80001a60:	ffd7f793          	andi	a5,a5,-3
    80001a64:	14479073          	csrw	sip,a5
    80001a68:	01813083          	ld	ra,24(sp)
    80001a6c:	01013403          	ld	s0,16(sp)
    80001a70:	00813483          	ld	s1,8(sp)
    80001a74:	02010113          	addi	sp,sp,32
    80001a78:	00008067          	ret
    80001a7c:	00000097          	auipc	ra,0x0
    80001a80:	3c8080e7          	jalr	968(ra) # 80001e44 <plic_claim>
    80001a84:	00a00793          	li	a5,10
    80001a88:	00050493          	mv	s1,a0
    80001a8c:	06f50863          	beq	a0,a5,80001afc <kerneltrap+0x12c>
    80001a90:	fc050ce3          	beqz	a0,80001a68 <kerneltrap+0x98>
    80001a94:	00050593          	mv	a1,a0
    80001a98:	00002517          	auipc	a0,0x2
    80001a9c:	65850513          	addi	a0,a0,1624 # 800040f0 <CONSOLE_STATUS+0xe0>
    80001aa0:	00000097          	auipc	ra,0x0
    80001aa4:	7e8080e7          	jalr	2024(ra) # 80002288 <__printf>
    80001aa8:	01013403          	ld	s0,16(sp)
    80001aac:	01813083          	ld	ra,24(sp)
    80001ab0:	00048513          	mv	a0,s1
    80001ab4:	00813483          	ld	s1,8(sp)
    80001ab8:	02010113          	addi	sp,sp,32
    80001abc:	00000317          	auipc	t1,0x0
    80001ac0:	3c030067          	jr	960(t1) # 80001e7c <plic_complete>
    80001ac4:	00004517          	auipc	a0,0x4
    80001ac8:	abc50513          	addi	a0,a0,-1348 # 80005580 <tickslock>
    80001acc:	00001097          	auipc	ra,0x1
    80001ad0:	490080e7          	jalr	1168(ra) # 80002f5c <acquire>
    80001ad4:	00003717          	auipc	a4,0x3
    80001ad8:	9b070713          	addi	a4,a4,-1616 # 80004484 <ticks>
    80001adc:	00072783          	lw	a5,0(a4)
    80001ae0:	00004517          	auipc	a0,0x4
    80001ae4:	aa050513          	addi	a0,a0,-1376 # 80005580 <tickslock>
    80001ae8:	0017879b          	addiw	a5,a5,1
    80001aec:	00f72023          	sw	a5,0(a4)
    80001af0:	00001097          	auipc	ra,0x1
    80001af4:	538080e7          	jalr	1336(ra) # 80003028 <release>
    80001af8:	f65ff06f          	j	80001a5c <kerneltrap+0x8c>
    80001afc:	00001097          	auipc	ra,0x1
    80001b00:	094080e7          	jalr	148(ra) # 80002b90 <uartintr>
    80001b04:	fa5ff06f          	j	80001aa8 <kerneltrap+0xd8>
    80001b08:	00002517          	auipc	a0,0x2
    80001b0c:	5c850513          	addi	a0,a0,1480 # 800040d0 <CONSOLE_STATUS+0xc0>
    80001b10:	00000097          	auipc	ra,0x0
    80001b14:	71c080e7          	jalr	1820(ra) # 8000222c <panic>

0000000080001b18 <clockintr>:
    80001b18:	fe010113          	addi	sp,sp,-32
    80001b1c:	00813823          	sd	s0,16(sp)
    80001b20:	00913423          	sd	s1,8(sp)
    80001b24:	00113c23          	sd	ra,24(sp)
    80001b28:	02010413          	addi	s0,sp,32
    80001b2c:	00004497          	auipc	s1,0x4
    80001b30:	a5448493          	addi	s1,s1,-1452 # 80005580 <tickslock>
    80001b34:	00048513          	mv	a0,s1
    80001b38:	00001097          	auipc	ra,0x1
    80001b3c:	424080e7          	jalr	1060(ra) # 80002f5c <acquire>
    80001b40:	00003717          	auipc	a4,0x3
    80001b44:	94470713          	addi	a4,a4,-1724 # 80004484 <ticks>
    80001b48:	00072783          	lw	a5,0(a4)
    80001b4c:	01013403          	ld	s0,16(sp)
    80001b50:	01813083          	ld	ra,24(sp)
    80001b54:	00048513          	mv	a0,s1
    80001b58:	0017879b          	addiw	a5,a5,1
    80001b5c:	00813483          	ld	s1,8(sp)
    80001b60:	00f72023          	sw	a5,0(a4)
    80001b64:	02010113          	addi	sp,sp,32
    80001b68:	00001317          	auipc	t1,0x1
    80001b6c:	4c030067          	jr	1216(t1) # 80003028 <release>

0000000080001b70 <devintr>:
    80001b70:	142027f3          	csrr	a5,scause
    80001b74:	00000513          	li	a0,0
    80001b78:	0007c463          	bltz	a5,80001b80 <devintr+0x10>
    80001b7c:	00008067          	ret
    80001b80:	fe010113          	addi	sp,sp,-32
    80001b84:	00813823          	sd	s0,16(sp)
    80001b88:	00113c23          	sd	ra,24(sp)
    80001b8c:	00913423          	sd	s1,8(sp)
    80001b90:	02010413          	addi	s0,sp,32
    80001b94:	0ff7f713          	andi	a4,a5,255
    80001b98:	00900693          	li	a3,9
    80001b9c:	04d70c63          	beq	a4,a3,80001bf4 <devintr+0x84>
    80001ba0:	fff00713          	li	a4,-1
    80001ba4:	03f71713          	slli	a4,a4,0x3f
    80001ba8:	00170713          	addi	a4,a4,1
    80001bac:	00e78c63          	beq	a5,a4,80001bc4 <devintr+0x54>
    80001bb0:	01813083          	ld	ra,24(sp)
    80001bb4:	01013403          	ld	s0,16(sp)
    80001bb8:	00813483          	ld	s1,8(sp)
    80001bbc:	02010113          	addi	sp,sp,32
    80001bc0:	00008067          	ret
    80001bc4:	00000097          	auipc	ra,0x0
    80001bc8:	c8c080e7          	jalr	-884(ra) # 80001850 <cpuid>
    80001bcc:	06050663          	beqz	a0,80001c38 <devintr+0xc8>
    80001bd0:	144027f3          	csrr	a5,sip
    80001bd4:	ffd7f793          	andi	a5,a5,-3
    80001bd8:	14479073          	csrw	sip,a5
    80001bdc:	01813083          	ld	ra,24(sp)
    80001be0:	01013403          	ld	s0,16(sp)
    80001be4:	00813483          	ld	s1,8(sp)
    80001be8:	00200513          	li	a0,2
    80001bec:	02010113          	addi	sp,sp,32
    80001bf0:	00008067          	ret
    80001bf4:	00000097          	auipc	ra,0x0
    80001bf8:	250080e7          	jalr	592(ra) # 80001e44 <plic_claim>
    80001bfc:	00a00793          	li	a5,10
    80001c00:	00050493          	mv	s1,a0
    80001c04:	06f50663          	beq	a0,a5,80001c70 <devintr+0x100>
    80001c08:	00100513          	li	a0,1
    80001c0c:	fa0482e3          	beqz	s1,80001bb0 <devintr+0x40>
    80001c10:	00048593          	mv	a1,s1
    80001c14:	00002517          	auipc	a0,0x2
    80001c18:	4dc50513          	addi	a0,a0,1244 # 800040f0 <CONSOLE_STATUS+0xe0>
    80001c1c:	00000097          	auipc	ra,0x0
    80001c20:	66c080e7          	jalr	1644(ra) # 80002288 <__printf>
    80001c24:	00048513          	mv	a0,s1
    80001c28:	00000097          	auipc	ra,0x0
    80001c2c:	254080e7          	jalr	596(ra) # 80001e7c <plic_complete>
    80001c30:	00100513          	li	a0,1
    80001c34:	f7dff06f          	j	80001bb0 <devintr+0x40>
    80001c38:	00004517          	auipc	a0,0x4
    80001c3c:	94850513          	addi	a0,a0,-1720 # 80005580 <tickslock>
    80001c40:	00001097          	auipc	ra,0x1
    80001c44:	31c080e7          	jalr	796(ra) # 80002f5c <acquire>
    80001c48:	00003717          	auipc	a4,0x3
    80001c4c:	83c70713          	addi	a4,a4,-1988 # 80004484 <ticks>
    80001c50:	00072783          	lw	a5,0(a4)
    80001c54:	00004517          	auipc	a0,0x4
    80001c58:	92c50513          	addi	a0,a0,-1748 # 80005580 <tickslock>
    80001c5c:	0017879b          	addiw	a5,a5,1
    80001c60:	00f72023          	sw	a5,0(a4)
    80001c64:	00001097          	auipc	ra,0x1
    80001c68:	3c4080e7          	jalr	964(ra) # 80003028 <release>
    80001c6c:	f65ff06f          	j	80001bd0 <devintr+0x60>
    80001c70:	00001097          	auipc	ra,0x1
    80001c74:	f20080e7          	jalr	-224(ra) # 80002b90 <uartintr>
    80001c78:	fadff06f          	j	80001c24 <devintr+0xb4>
    80001c7c:	0000                	unimp
	...

0000000080001c80 <kernelvec>:
    80001c80:	f0010113          	addi	sp,sp,-256
    80001c84:	00113023          	sd	ra,0(sp)
    80001c88:	00213423          	sd	sp,8(sp)
    80001c8c:	00313823          	sd	gp,16(sp)
    80001c90:	00413c23          	sd	tp,24(sp)
    80001c94:	02513023          	sd	t0,32(sp)
    80001c98:	02613423          	sd	t1,40(sp)
    80001c9c:	02713823          	sd	t2,48(sp)
    80001ca0:	02813c23          	sd	s0,56(sp)
    80001ca4:	04913023          	sd	s1,64(sp)
    80001ca8:	04a13423          	sd	a0,72(sp)
    80001cac:	04b13823          	sd	a1,80(sp)
    80001cb0:	04c13c23          	sd	a2,88(sp)
    80001cb4:	06d13023          	sd	a3,96(sp)
    80001cb8:	06e13423          	sd	a4,104(sp)
    80001cbc:	06f13823          	sd	a5,112(sp)
    80001cc0:	07013c23          	sd	a6,120(sp)
    80001cc4:	09113023          	sd	a7,128(sp)
    80001cc8:	09213423          	sd	s2,136(sp)
    80001ccc:	09313823          	sd	s3,144(sp)
    80001cd0:	09413c23          	sd	s4,152(sp)
    80001cd4:	0b513023          	sd	s5,160(sp)
    80001cd8:	0b613423          	sd	s6,168(sp)
    80001cdc:	0b713823          	sd	s7,176(sp)
    80001ce0:	0b813c23          	sd	s8,184(sp)
    80001ce4:	0d913023          	sd	s9,192(sp)
    80001ce8:	0da13423          	sd	s10,200(sp)
    80001cec:	0db13823          	sd	s11,208(sp)
    80001cf0:	0dc13c23          	sd	t3,216(sp)
    80001cf4:	0fd13023          	sd	t4,224(sp)
    80001cf8:	0fe13423          	sd	t5,232(sp)
    80001cfc:	0ff13823          	sd	t6,240(sp)
    80001d00:	cd1ff0ef          	jal	ra,800019d0 <kerneltrap>
    80001d04:	00013083          	ld	ra,0(sp)
    80001d08:	00813103          	ld	sp,8(sp)
    80001d0c:	01013183          	ld	gp,16(sp)
    80001d10:	02013283          	ld	t0,32(sp)
    80001d14:	02813303          	ld	t1,40(sp)
    80001d18:	03013383          	ld	t2,48(sp)
    80001d1c:	03813403          	ld	s0,56(sp)
    80001d20:	04013483          	ld	s1,64(sp)
    80001d24:	04813503          	ld	a0,72(sp)
    80001d28:	05013583          	ld	a1,80(sp)
    80001d2c:	05813603          	ld	a2,88(sp)
    80001d30:	06013683          	ld	a3,96(sp)
    80001d34:	06813703          	ld	a4,104(sp)
    80001d38:	07013783          	ld	a5,112(sp)
    80001d3c:	07813803          	ld	a6,120(sp)
    80001d40:	08013883          	ld	a7,128(sp)
    80001d44:	08813903          	ld	s2,136(sp)
    80001d48:	09013983          	ld	s3,144(sp)
    80001d4c:	09813a03          	ld	s4,152(sp)
    80001d50:	0a013a83          	ld	s5,160(sp)
    80001d54:	0a813b03          	ld	s6,168(sp)
    80001d58:	0b013b83          	ld	s7,176(sp)
    80001d5c:	0b813c03          	ld	s8,184(sp)
    80001d60:	0c013c83          	ld	s9,192(sp)
    80001d64:	0c813d03          	ld	s10,200(sp)
    80001d68:	0d013d83          	ld	s11,208(sp)
    80001d6c:	0d813e03          	ld	t3,216(sp)
    80001d70:	0e013e83          	ld	t4,224(sp)
    80001d74:	0e813f03          	ld	t5,232(sp)
    80001d78:	0f013f83          	ld	t6,240(sp)
    80001d7c:	10010113          	addi	sp,sp,256
    80001d80:	10200073          	sret
    80001d84:	00000013          	nop
    80001d88:	00000013          	nop
    80001d8c:	00000013          	nop

0000000080001d90 <timervec>:
    80001d90:	34051573          	csrrw	a0,mscratch,a0
    80001d94:	00b53023          	sd	a1,0(a0)
    80001d98:	00c53423          	sd	a2,8(a0)
    80001d9c:	00d53823          	sd	a3,16(a0)
    80001da0:	01853583          	ld	a1,24(a0)
    80001da4:	02053603          	ld	a2,32(a0)
    80001da8:	0005b683          	ld	a3,0(a1)
    80001dac:	00c686b3          	add	a3,a3,a2
    80001db0:	00d5b023          	sd	a3,0(a1)
    80001db4:	00200593          	li	a1,2
    80001db8:	14459073          	csrw	sip,a1
    80001dbc:	01053683          	ld	a3,16(a0)
    80001dc0:	00853603          	ld	a2,8(a0)
    80001dc4:	00053583          	ld	a1,0(a0)
    80001dc8:	34051573          	csrrw	a0,mscratch,a0
    80001dcc:	30200073          	mret

0000000080001dd0 <plicinit>:
    80001dd0:	ff010113          	addi	sp,sp,-16
    80001dd4:	00813423          	sd	s0,8(sp)
    80001dd8:	01010413          	addi	s0,sp,16
    80001ddc:	00813403          	ld	s0,8(sp)
    80001de0:	0c0007b7          	lui	a5,0xc000
    80001de4:	00100713          	li	a4,1
    80001de8:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    80001dec:	00e7a223          	sw	a4,4(a5)
    80001df0:	01010113          	addi	sp,sp,16
    80001df4:	00008067          	ret

0000000080001df8 <plicinithart>:
    80001df8:	ff010113          	addi	sp,sp,-16
    80001dfc:	00813023          	sd	s0,0(sp)
    80001e00:	00113423          	sd	ra,8(sp)
    80001e04:	01010413          	addi	s0,sp,16
    80001e08:	00000097          	auipc	ra,0x0
    80001e0c:	a48080e7          	jalr	-1464(ra) # 80001850 <cpuid>
    80001e10:	0085171b          	slliw	a4,a0,0x8
    80001e14:	0c0027b7          	lui	a5,0xc002
    80001e18:	00e787b3          	add	a5,a5,a4
    80001e1c:	40200713          	li	a4,1026
    80001e20:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80001e24:	00813083          	ld	ra,8(sp)
    80001e28:	00013403          	ld	s0,0(sp)
    80001e2c:	00d5151b          	slliw	a0,a0,0xd
    80001e30:	0c2017b7          	lui	a5,0xc201
    80001e34:	00a78533          	add	a0,a5,a0
    80001e38:	00052023          	sw	zero,0(a0)
    80001e3c:	01010113          	addi	sp,sp,16
    80001e40:	00008067          	ret

0000000080001e44 <plic_claim>:
    80001e44:	ff010113          	addi	sp,sp,-16
    80001e48:	00813023          	sd	s0,0(sp)
    80001e4c:	00113423          	sd	ra,8(sp)
    80001e50:	01010413          	addi	s0,sp,16
    80001e54:	00000097          	auipc	ra,0x0
    80001e58:	9fc080e7          	jalr	-1540(ra) # 80001850 <cpuid>
    80001e5c:	00813083          	ld	ra,8(sp)
    80001e60:	00013403          	ld	s0,0(sp)
    80001e64:	00d5151b          	slliw	a0,a0,0xd
    80001e68:	0c2017b7          	lui	a5,0xc201
    80001e6c:	00a78533          	add	a0,a5,a0
    80001e70:	00452503          	lw	a0,4(a0)
    80001e74:	01010113          	addi	sp,sp,16
    80001e78:	00008067          	ret

0000000080001e7c <plic_complete>:
    80001e7c:	fe010113          	addi	sp,sp,-32
    80001e80:	00813823          	sd	s0,16(sp)
    80001e84:	00913423          	sd	s1,8(sp)
    80001e88:	00113c23          	sd	ra,24(sp)
    80001e8c:	02010413          	addi	s0,sp,32
    80001e90:	00050493          	mv	s1,a0
    80001e94:	00000097          	auipc	ra,0x0
    80001e98:	9bc080e7          	jalr	-1604(ra) # 80001850 <cpuid>
    80001e9c:	01813083          	ld	ra,24(sp)
    80001ea0:	01013403          	ld	s0,16(sp)
    80001ea4:	00d5179b          	slliw	a5,a0,0xd
    80001ea8:	0c201737          	lui	a4,0xc201
    80001eac:	00f707b3          	add	a5,a4,a5
    80001eb0:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80001eb4:	00813483          	ld	s1,8(sp)
    80001eb8:	02010113          	addi	sp,sp,32
    80001ebc:	00008067          	ret

0000000080001ec0 <consolewrite>:
    80001ec0:	fb010113          	addi	sp,sp,-80
    80001ec4:	04813023          	sd	s0,64(sp)
    80001ec8:	04113423          	sd	ra,72(sp)
    80001ecc:	02913c23          	sd	s1,56(sp)
    80001ed0:	03213823          	sd	s2,48(sp)
    80001ed4:	03313423          	sd	s3,40(sp)
    80001ed8:	03413023          	sd	s4,32(sp)
    80001edc:	01513c23          	sd	s5,24(sp)
    80001ee0:	05010413          	addi	s0,sp,80
    80001ee4:	06c05c63          	blez	a2,80001f5c <consolewrite+0x9c>
    80001ee8:	00060993          	mv	s3,a2
    80001eec:	00050a13          	mv	s4,a0
    80001ef0:	00058493          	mv	s1,a1
    80001ef4:	00000913          	li	s2,0
    80001ef8:	fff00a93          	li	s5,-1
    80001efc:	01c0006f          	j	80001f18 <consolewrite+0x58>
    80001f00:	fbf44503          	lbu	a0,-65(s0)
    80001f04:	0019091b          	addiw	s2,s2,1
    80001f08:	00148493          	addi	s1,s1,1
    80001f0c:	00001097          	auipc	ra,0x1
    80001f10:	a9c080e7          	jalr	-1380(ra) # 800029a8 <uartputc>
    80001f14:	03298063          	beq	s3,s2,80001f34 <consolewrite+0x74>
    80001f18:	00048613          	mv	a2,s1
    80001f1c:	00100693          	li	a3,1
    80001f20:	000a0593          	mv	a1,s4
    80001f24:	fbf40513          	addi	a0,s0,-65
    80001f28:	00000097          	auipc	ra,0x0
    80001f2c:	9e0080e7          	jalr	-1568(ra) # 80001908 <either_copyin>
    80001f30:	fd5518e3          	bne	a0,s5,80001f00 <consolewrite+0x40>
    80001f34:	04813083          	ld	ra,72(sp)
    80001f38:	04013403          	ld	s0,64(sp)
    80001f3c:	03813483          	ld	s1,56(sp)
    80001f40:	02813983          	ld	s3,40(sp)
    80001f44:	02013a03          	ld	s4,32(sp)
    80001f48:	01813a83          	ld	s5,24(sp)
    80001f4c:	00090513          	mv	a0,s2
    80001f50:	03013903          	ld	s2,48(sp)
    80001f54:	05010113          	addi	sp,sp,80
    80001f58:	00008067          	ret
    80001f5c:	00000913          	li	s2,0
    80001f60:	fd5ff06f          	j	80001f34 <consolewrite+0x74>

0000000080001f64 <consoleread>:
    80001f64:	f9010113          	addi	sp,sp,-112
    80001f68:	06813023          	sd	s0,96(sp)
    80001f6c:	04913c23          	sd	s1,88(sp)
    80001f70:	05213823          	sd	s2,80(sp)
    80001f74:	05313423          	sd	s3,72(sp)
    80001f78:	05413023          	sd	s4,64(sp)
    80001f7c:	03513c23          	sd	s5,56(sp)
    80001f80:	03613823          	sd	s6,48(sp)
    80001f84:	03713423          	sd	s7,40(sp)
    80001f88:	03813023          	sd	s8,32(sp)
    80001f8c:	06113423          	sd	ra,104(sp)
    80001f90:	01913c23          	sd	s9,24(sp)
    80001f94:	07010413          	addi	s0,sp,112
    80001f98:	00060b93          	mv	s7,a2
    80001f9c:	00050913          	mv	s2,a0
    80001fa0:	00058c13          	mv	s8,a1
    80001fa4:	00060b1b          	sext.w	s6,a2
    80001fa8:	00003497          	auipc	s1,0x3
    80001fac:	5f048493          	addi	s1,s1,1520 # 80005598 <cons>
    80001fb0:	00400993          	li	s3,4
    80001fb4:	fff00a13          	li	s4,-1
    80001fb8:	00a00a93          	li	s5,10
    80001fbc:	05705e63          	blez	s7,80002018 <consoleread+0xb4>
    80001fc0:	09c4a703          	lw	a4,156(s1)
    80001fc4:	0984a783          	lw	a5,152(s1)
    80001fc8:	0007071b          	sext.w	a4,a4
    80001fcc:	08e78463          	beq	a5,a4,80002054 <consoleread+0xf0>
    80001fd0:	07f7f713          	andi	a4,a5,127
    80001fd4:	00e48733          	add	a4,s1,a4
    80001fd8:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    80001fdc:	0017869b          	addiw	a3,a5,1
    80001fe0:	08d4ac23          	sw	a3,152(s1)
    80001fe4:	00070c9b          	sext.w	s9,a4
    80001fe8:	0b370663          	beq	a4,s3,80002094 <consoleread+0x130>
    80001fec:	00100693          	li	a3,1
    80001ff0:	f9f40613          	addi	a2,s0,-97
    80001ff4:	000c0593          	mv	a1,s8
    80001ff8:	00090513          	mv	a0,s2
    80001ffc:	f8e40fa3          	sb	a4,-97(s0)
    80002000:	00000097          	auipc	ra,0x0
    80002004:	8bc080e7          	jalr	-1860(ra) # 800018bc <either_copyout>
    80002008:	01450863          	beq	a0,s4,80002018 <consoleread+0xb4>
    8000200c:	001c0c13          	addi	s8,s8,1
    80002010:	fffb8b9b          	addiw	s7,s7,-1
    80002014:	fb5c94e3          	bne	s9,s5,80001fbc <consoleread+0x58>
    80002018:	000b851b          	sext.w	a0,s7
    8000201c:	06813083          	ld	ra,104(sp)
    80002020:	06013403          	ld	s0,96(sp)
    80002024:	05813483          	ld	s1,88(sp)
    80002028:	05013903          	ld	s2,80(sp)
    8000202c:	04813983          	ld	s3,72(sp)
    80002030:	04013a03          	ld	s4,64(sp)
    80002034:	03813a83          	ld	s5,56(sp)
    80002038:	02813b83          	ld	s7,40(sp)
    8000203c:	02013c03          	ld	s8,32(sp)
    80002040:	01813c83          	ld	s9,24(sp)
    80002044:	40ab053b          	subw	a0,s6,a0
    80002048:	03013b03          	ld	s6,48(sp)
    8000204c:	07010113          	addi	sp,sp,112
    80002050:	00008067          	ret
    80002054:	00001097          	auipc	ra,0x1
    80002058:	1d8080e7          	jalr	472(ra) # 8000322c <push_on>
    8000205c:	0984a703          	lw	a4,152(s1)
    80002060:	09c4a783          	lw	a5,156(s1)
    80002064:	0007879b          	sext.w	a5,a5
    80002068:	fef70ce3          	beq	a4,a5,80002060 <consoleread+0xfc>
    8000206c:	00001097          	auipc	ra,0x1
    80002070:	234080e7          	jalr	564(ra) # 800032a0 <pop_on>
    80002074:	0984a783          	lw	a5,152(s1)
    80002078:	07f7f713          	andi	a4,a5,127
    8000207c:	00e48733          	add	a4,s1,a4
    80002080:	01874703          	lbu	a4,24(a4)
    80002084:	0017869b          	addiw	a3,a5,1
    80002088:	08d4ac23          	sw	a3,152(s1)
    8000208c:	00070c9b          	sext.w	s9,a4
    80002090:	f5371ee3          	bne	a4,s3,80001fec <consoleread+0x88>
    80002094:	000b851b          	sext.w	a0,s7
    80002098:	f96bf2e3          	bgeu	s7,s6,8000201c <consoleread+0xb8>
    8000209c:	08f4ac23          	sw	a5,152(s1)
    800020a0:	f7dff06f          	j	8000201c <consoleread+0xb8>

00000000800020a4 <consputc>:
    800020a4:	10000793          	li	a5,256
    800020a8:	00f50663          	beq	a0,a5,800020b4 <consputc+0x10>
    800020ac:	00001317          	auipc	t1,0x1
    800020b0:	9f430067          	jr	-1548(t1) # 80002aa0 <uartputc_sync>
    800020b4:	ff010113          	addi	sp,sp,-16
    800020b8:	00113423          	sd	ra,8(sp)
    800020bc:	00813023          	sd	s0,0(sp)
    800020c0:	01010413          	addi	s0,sp,16
    800020c4:	00800513          	li	a0,8
    800020c8:	00001097          	auipc	ra,0x1
    800020cc:	9d8080e7          	jalr	-1576(ra) # 80002aa0 <uartputc_sync>
    800020d0:	02000513          	li	a0,32
    800020d4:	00001097          	auipc	ra,0x1
    800020d8:	9cc080e7          	jalr	-1588(ra) # 80002aa0 <uartputc_sync>
    800020dc:	00013403          	ld	s0,0(sp)
    800020e0:	00813083          	ld	ra,8(sp)
    800020e4:	00800513          	li	a0,8
    800020e8:	01010113          	addi	sp,sp,16
    800020ec:	00001317          	auipc	t1,0x1
    800020f0:	9b430067          	jr	-1612(t1) # 80002aa0 <uartputc_sync>

00000000800020f4 <consoleintr>:
    800020f4:	fe010113          	addi	sp,sp,-32
    800020f8:	00813823          	sd	s0,16(sp)
    800020fc:	00913423          	sd	s1,8(sp)
    80002100:	01213023          	sd	s2,0(sp)
    80002104:	00113c23          	sd	ra,24(sp)
    80002108:	02010413          	addi	s0,sp,32
    8000210c:	00003917          	auipc	s2,0x3
    80002110:	48c90913          	addi	s2,s2,1164 # 80005598 <cons>
    80002114:	00050493          	mv	s1,a0
    80002118:	00090513          	mv	a0,s2
    8000211c:	00001097          	auipc	ra,0x1
    80002120:	e40080e7          	jalr	-448(ra) # 80002f5c <acquire>
    80002124:	02048c63          	beqz	s1,8000215c <consoleintr+0x68>
    80002128:	0a092783          	lw	a5,160(s2)
    8000212c:	09892703          	lw	a4,152(s2)
    80002130:	07f00693          	li	a3,127
    80002134:	40e7873b          	subw	a4,a5,a4
    80002138:	02e6e263          	bltu	a3,a4,8000215c <consoleintr+0x68>
    8000213c:	00d00713          	li	a4,13
    80002140:	04e48063          	beq	s1,a4,80002180 <consoleintr+0x8c>
    80002144:	07f7f713          	andi	a4,a5,127
    80002148:	00e90733          	add	a4,s2,a4
    8000214c:	0017879b          	addiw	a5,a5,1
    80002150:	0af92023          	sw	a5,160(s2)
    80002154:	00970c23          	sb	s1,24(a4)
    80002158:	08f92e23          	sw	a5,156(s2)
    8000215c:	01013403          	ld	s0,16(sp)
    80002160:	01813083          	ld	ra,24(sp)
    80002164:	00813483          	ld	s1,8(sp)
    80002168:	00013903          	ld	s2,0(sp)
    8000216c:	00003517          	auipc	a0,0x3
    80002170:	42c50513          	addi	a0,a0,1068 # 80005598 <cons>
    80002174:	02010113          	addi	sp,sp,32
    80002178:	00001317          	auipc	t1,0x1
    8000217c:	eb030067          	jr	-336(t1) # 80003028 <release>
    80002180:	00a00493          	li	s1,10
    80002184:	fc1ff06f          	j	80002144 <consoleintr+0x50>

0000000080002188 <consoleinit>:
    80002188:	fe010113          	addi	sp,sp,-32
    8000218c:	00113c23          	sd	ra,24(sp)
    80002190:	00813823          	sd	s0,16(sp)
    80002194:	00913423          	sd	s1,8(sp)
    80002198:	02010413          	addi	s0,sp,32
    8000219c:	00003497          	auipc	s1,0x3
    800021a0:	3fc48493          	addi	s1,s1,1020 # 80005598 <cons>
    800021a4:	00048513          	mv	a0,s1
    800021a8:	00002597          	auipc	a1,0x2
    800021ac:	fa058593          	addi	a1,a1,-96 # 80004148 <CONSOLE_STATUS+0x138>
    800021b0:	00001097          	auipc	ra,0x1
    800021b4:	d88080e7          	jalr	-632(ra) # 80002f38 <initlock>
    800021b8:	00000097          	auipc	ra,0x0
    800021bc:	7ac080e7          	jalr	1964(ra) # 80002964 <uartinit>
    800021c0:	01813083          	ld	ra,24(sp)
    800021c4:	01013403          	ld	s0,16(sp)
    800021c8:	00000797          	auipc	a5,0x0
    800021cc:	d9c78793          	addi	a5,a5,-612 # 80001f64 <consoleread>
    800021d0:	0af4bc23          	sd	a5,184(s1)
    800021d4:	00000797          	auipc	a5,0x0
    800021d8:	cec78793          	addi	a5,a5,-788 # 80001ec0 <consolewrite>
    800021dc:	0cf4b023          	sd	a5,192(s1)
    800021e0:	00813483          	ld	s1,8(sp)
    800021e4:	02010113          	addi	sp,sp,32
    800021e8:	00008067          	ret

00000000800021ec <console_read>:
    800021ec:	ff010113          	addi	sp,sp,-16
    800021f0:	00813423          	sd	s0,8(sp)
    800021f4:	01010413          	addi	s0,sp,16
    800021f8:	00813403          	ld	s0,8(sp)
    800021fc:	00003317          	auipc	t1,0x3
    80002200:	45433303          	ld	t1,1108(t1) # 80005650 <devsw+0x10>
    80002204:	01010113          	addi	sp,sp,16
    80002208:	00030067          	jr	t1

000000008000220c <console_write>:
    8000220c:	ff010113          	addi	sp,sp,-16
    80002210:	00813423          	sd	s0,8(sp)
    80002214:	01010413          	addi	s0,sp,16
    80002218:	00813403          	ld	s0,8(sp)
    8000221c:	00003317          	auipc	t1,0x3
    80002220:	43c33303          	ld	t1,1084(t1) # 80005658 <devsw+0x18>
    80002224:	01010113          	addi	sp,sp,16
    80002228:	00030067          	jr	t1

000000008000222c <panic>:
    8000222c:	fe010113          	addi	sp,sp,-32
    80002230:	00113c23          	sd	ra,24(sp)
    80002234:	00813823          	sd	s0,16(sp)
    80002238:	00913423          	sd	s1,8(sp)
    8000223c:	02010413          	addi	s0,sp,32
    80002240:	00050493          	mv	s1,a0
    80002244:	00002517          	auipc	a0,0x2
    80002248:	f0c50513          	addi	a0,a0,-244 # 80004150 <CONSOLE_STATUS+0x140>
    8000224c:	00003797          	auipc	a5,0x3
    80002250:	4a07a623          	sw	zero,1196(a5) # 800056f8 <pr+0x18>
    80002254:	00000097          	auipc	ra,0x0
    80002258:	034080e7          	jalr	52(ra) # 80002288 <__printf>
    8000225c:	00048513          	mv	a0,s1
    80002260:	00000097          	auipc	ra,0x0
    80002264:	028080e7          	jalr	40(ra) # 80002288 <__printf>
    80002268:	00002517          	auipc	a0,0x2
    8000226c:	ec850513          	addi	a0,a0,-312 # 80004130 <CONSOLE_STATUS+0x120>
    80002270:	00000097          	auipc	ra,0x0
    80002274:	018080e7          	jalr	24(ra) # 80002288 <__printf>
    80002278:	00100793          	li	a5,1
    8000227c:	00002717          	auipc	a4,0x2
    80002280:	20f72623          	sw	a5,524(a4) # 80004488 <panicked>
    80002284:	0000006f          	j	80002284 <panic+0x58>

0000000080002288 <__printf>:
    80002288:	f3010113          	addi	sp,sp,-208
    8000228c:	08813023          	sd	s0,128(sp)
    80002290:	07313423          	sd	s3,104(sp)
    80002294:	09010413          	addi	s0,sp,144
    80002298:	05813023          	sd	s8,64(sp)
    8000229c:	08113423          	sd	ra,136(sp)
    800022a0:	06913c23          	sd	s1,120(sp)
    800022a4:	07213823          	sd	s2,112(sp)
    800022a8:	07413023          	sd	s4,96(sp)
    800022ac:	05513c23          	sd	s5,88(sp)
    800022b0:	05613823          	sd	s6,80(sp)
    800022b4:	05713423          	sd	s7,72(sp)
    800022b8:	03913c23          	sd	s9,56(sp)
    800022bc:	03a13823          	sd	s10,48(sp)
    800022c0:	03b13423          	sd	s11,40(sp)
    800022c4:	00003317          	auipc	t1,0x3
    800022c8:	41c30313          	addi	t1,t1,1052 # 800056e0 <pr>
    800022cc:	01832c03          	lw	s8,24(t1)
    800022d0:	00b43423          	sd	a1,8(s0)
    800022d4:	00c43823          	sd	a2,16(s0)
    800022d8:	00d43c23          	sd	a3,24(s0)
    800022dc:	02e43023          	sd	a4,32(s0)
    800022e0:	02f43423          	sd	a5,40(s0)
    800022e4:	03043823          	sd	a6,48(s0)
    800022e8:	03143c23          	sd	a7,56(s0)
    800022ec:	00050993          	mv	s3,a0
    800022f0:	4a0c1663          	bnez	s8,8000279c <__printf+0x514>
    800022f4:	60098c63          	beqz	s3,8000290c <__printf+0x684>
    800022f8:	0009c503          	lbu	a0,0(s3)
    800022fc:	00840793          	addi	a5,s0,8
    80002300:	f6f43c23          	sd	a5,-136(s0)
    80002304:	00000493          	li	s1,0
    80002308:	22050063          	beqz	a0,80002528 <__printf+0x2a0>
    8000230c:	00002a37          	lui	s4,0x2
    80002310:	00018ab7          	lui	s5,0x18
    80002314:	000f4b37          	lui	s6,0xf4
    80002318:	00989bb7          	lui	s7,0x989
    8000231c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80002320:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80002324:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80002328:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    8000232c:	00148c9b          	addiw	s9,s1,1
    80002330:	02500793          	li	a5,37
    80002334:	01998933          	add	s2,s3,s9
    80002338:	38f51263          	bne	a0,a5,800026bc <__printf+0x434>
    8000233c:	00094783          	lbu	a5,0(s2)
    80002340:	00078c9b          	sext.w	s9,a5
    80002344:	1e078263          	beqz	a5,80002528 <__printf+0x2a0>
    80002348:	0024849b          	addiw	s1,s1,2
    8000234c:	07000713          	li	a4,112
    80002350:	00998933          	add	s2,s3,s1
    80002354:	38e78a63          	beq	a5,a4,800026e8 <__printf+0x460>
    80002358:	20f76863          	bltu	a4,a5,80002568 <__printf+0x2e0>
    8000235c:	42a78863          	beq	a5,a0,8000278c <__printf+0x504>
    80002360:	06400713          	li	a4,100
    80002364:	40e79663          	bne	a5,a4,80002770 <__printf+0x4e8>
    80002368:	f7843783          	ld	a5,-136(s0)
    8000236c:	0007a603          	lw	a2,0(a5)
    80002370:	00878793          	addi	a5,a5,8
    80002374:	f6f43c23          	sd	a5,-136(s0)
    80002378:	42064a63          	bltz	a2,800027ac <__printf+0x524>
    8000237c:	00a00713          	li	a4,10
    80002380:	02e677bb          	remuw	a5,a2,a4
    80002384:	00002d97          	auipc	s11,0x2
    80002388:	df4d8d93          	addi	s11,s11,-524 # 80004178 <digits>
    8000238c:	00900593          	li	a1,9
    80002390:	0006051b          	sext.w	a0,a2
    80002394:	00000c93          	li	s9,0
    80002398:	02079793          	slli	a5,a5,0x20
    8000239c:	0207d793          	srli	a5,a5,0x20
    800023a0:	00fd87b3          	add	a5,s11,a5
    800023a4:	0007c783          	lbu	a5,0(a5)
    800023a8:	02e656bb          	divuw	a3,a2,a4
    800023ac:	f8f40023          	sb	a5,-128(s0)
    800023b0:	14c5d863          	bge	a1,a2,80002500 <__printf+0x278>
    800023b4:	06300593          	li	a1,99
    800023b8:	00100c93          	li	s9,1
    800023bc:	02e6f7bb          	remuw	a5,a3,a4
    800023c0:	02079793          	slli	a5,a5,0x20
    800023c4:	0207d793          	srli	a5,a5,0x20
    800023c8:	00fd87b3          	add	a5,s11,a5
    800023cc:	0007c783          	lbu	a5,0(a5)
    800023d0:	02e6d73b          	divuw	a4,a3,a4
    800023d4:	f8f400a3          	sb	a5,-127(s0)
    800023d8:	12a5f463          	bgeu	a1,a0,80002500 <__printf+0x278>
    800023dc:	00a00693          	li	a3,10
    800023e0:	00900593          	li	a1,9
    800023e4:	02d777bb          	remuw	a5,a4,a3
    800023e8:	02079793          	slli	a5,a5,0x20
    800023ec:	0207d793          	srli	a5,a5,0x20
    800023f0:	00fd87b3          	add	a5,s11,a5
    800023f4:	0007c503          	lbu	a0,0(a5)
    800023f8:	02d757bb          	divuw	a5,a4,a3
    800023fc:	f8a40123          	sb	a0,-126(s0)
    80002400:	48e5f263          	bgeu	a1,a4,80002884 <__printf+0x5fc>
    80002404:	06300513          	li	a0,99
    80002408:	02d7f5bb          	remuw	a1,a5,a3
    8000240c:	02059593          	slli	a1,a1,0x20
    80002410:	0205d593          	srli	a1,a1,0x20
    80002414:	00bd85b3          	add	a1,s11,a1
    80002418:	0005c583          	lbu	a1,0(a1)
    8000241c:	02d7d7bb          	divuw	a5,a5,a3
    80002420:	f8b401a3          	sb	a1,-125(s0)
    80002424:	48e57263          	bgeu	a0,a4,800028a8 <__printf+0x620>
    80002428:	3e700513          	li	a0,999
    8000242c:	02d7f5bb          	remuw	a1,a5,a3
    80002430:	02059593          	slli	a1,a1,0x20
    80002434:	0205d593          	srli	a1,a1,0x20
    80002438:	00bd85b3          	add	a1,s11,a1
    8000243c:	0005c583          	lbu	a1,0(a1)
    80002440:	02d7d7bb          	divuw	a5,a5,a3
    80002444:	f8b40223          	sb	a1,-124(s0)
    80002448:	46e57663          	bgeu	a0,a4,800028b4 <__printf+0x62c>
    8000244c:	02d7f5bb          	remuw	a1,a5,a3
    80002450:	02059593          	slli	a1,a1,0x20
    80002454:	0205d593          	srli	a1,a1,0x20
    80002458:	00bd85b3          	add	a1,s11,a1
    8000245c:	0005c583          	lbu	a1,0(a1)
    80002460:	02d7d7bb          	divuw	a5,a5,a3
    80002464:	f8b402a3          	sb	a1,-123(s0)
    80002468:	46ea7863          	bgeu	s4,a4,800028d8 <__printf+0x650>
    8000246c:	02d7f5bb          	remuw	a1,a5,a3
    80002470:	02059593          	slli	a1,a1,0x20
    80002474:	0205d593          	srli	a1,a1,0x20
    80002478:	00bd85b3          	add	a1,s11,a1
    8000247c:	0005c583          	lbu	a1,0(a1)
    80002480:	02d7d7bb          	divuw	a5,a5,a3
    80002484:	f8b40323          	sb	a1,-122(s0)
    80002488:	3eeaf863          	bgeu	s5,a4,80002878 <__printf+0x5f0>
    8000248c:	02d7f5bb          	remuw	a1,a5,a3
    80002490:	02059593          	slli	a1,a1,0x20
    80002494:	0205d593          	srli	a1,a1,0x20
    80002498:	00bd85b3          	add	a1,s11,a1
    8000249c:	0005c583          	lbu	a1,0(a1)
    800024a0:	02d7d7bb          	divuw	a5,a5,a3
    800024a4:	f8b403a3          	sb	a1,-121(s0)
    800024a8:	42eb7e63          	bgeu	s6,a4,800028e4 <__printf+0x65c>
    800024ac:	02d7f5bb          	remuw	a1,a5,a3
    800024b0:	02059593          	slli	a1,a1,0x20
    800024b4:	0205d593          	srli	a1,a1,0x20
    800024b8:	00bd85b3          	add	a1,s11,a1
    800024bc:	0005c583          	lbu	a1,0(a1)
    800024c0:	02d7d7bb          	divuw	a5,a5,a3
    800024c4:	f8b40423          	sb	a1,-120(s0)
    800024c8:	42ebfc63          	bgeu	s7,a4,80002900 <__printf+0x678>
    800024cc:	02079793          	slli	a5,a5,0x20
    800024d0:	0207d793          	srli	a5,a5,0x20
    800024d4:	00fd8db3          	add	s11,s11,a5
    800024d8:	000dc703          	lbu	a4,0(s11)
    800024dc:	00a00793          	li	a5,10
    800024e0:	00900c93          	li	s9,9
    800024e4:	f8e404a3          	sb	a4,-119(s0)
    800024e8:	00065c63          	bgez	a2,80002500 <__printf+0x278>
    800024ec:	f9040713          	addi	a4,s0,-112
    800024f0:	00f70733          	add	a4,a4,a5
    800024f4:	02d00693          	li	a3,45
    800024f8:	fed70823          	sb	a3,-16(a4)
    800024fc:	00078c93          	mv	s9,a5
    80002500:	f8040793          	addi	a5,s0,-128
    80002504:	01978cb3          	add	s9,a5,s9
    80002508:	f7f40d13          	addi	s10,s0,-129
    8000250c:	000cc503          	lbu	a0,0(s9)
    80002510:	fffc8c93          	addi	s9,s9,-1
    80002514:	00000097          	auipc	ra,0x0
    80002518:	b90080e7          	jalr	-1136(ra) # 800020a4 <consputc>
    8000251c:	ffac98e3          	bne	s9,s10,8000250c <__printf+0x284>
    80002520:	00094503          	lbu	a0,0(s2)
    80002524:	e00514e3          	bnez	a0,8000232c <__printf+0xa4>
    80002528:	1a0c1663          	bnez	s8,800026d4 <__printf+0x44c>
    8000252c:	08813083          	ld	ra,136(sp)
    80002530:	08013403          	ld	s0,128(sp)
    80002534:	07813483          	ld	s1,120(sp)
    80002538:	07013903          	ld	s2,112(sp)
    8000253c:	06813983          	ld	s3,104(sp)
    80002540:	06013a03          	ld	s4,96(sp)
    80002544:	05813a83          	ld	s5,88(sp)
    80002548:	05013b03          	ld	s6,80(sp)
    8000254c:	04813b83          	ld	s7,72(sp)
    80002550:	04013c03          	ld	s8,64(sp)
    80002554:	03813c83          	ld	s9,56(sp)
    80002558:	03013d03          	ld	s10,48(sp)
    8000255c:	02813d83          	ld	s11,40(sp)
    80002560:	0d010113          	addi	sp,sp,208
    80002564:	00008067          	ret
    80002568:	07300713          	li	a4,115
    8000256c:	1ce78a63          	beq	a5,a4,80002740 <__printf+0x4b8>
    80002570:	07800713          	li	a4,120
    80002574:	1ee79e63          	bne	a5,a4,80002770 <__printf+0x4e8>
    80002578:	f7843783          	ld	a5,-136(s0)
    8000257c:	0007a703          	lw	a4,0(a5)
    80002580:	00878793          	addi	a5,a5,8
    80002584:	f6f43c23          	sd	a5,-136(s0)
    80002588:	28074263          	bltz	a4,8000280c <__printf+0x584>
    8000258c:	00002d97          	auipc	s11,0x2
    80002590:	becd8d93          	addi	s11,s11,-1044 # 80004178 <digits>
    80002594:	00f77793          	andi	a5,a4,15
    80002598:	00fd87b3          	add	a5,s11,a5
    8000259c:	0007c683          	lbu	a3,0(a5)
    800025a0:	00f00613          	li	a2,15
    800025a4:	0007079b          	sext.w	a5,a4
    800025a8:	f8d40023          	sb	a3,-128(s0)
    800025ac:	0047559b          	srliw	a1,a4,0x4
    800025b0:	0047569b          	srliw	a3,a4,0x4
    800025b4:	00000c93          	li	s9,0
    800025b8:	0ee65063          	bge	a2,a4,80002698 <__printf+0x410>
    800025bc:	00f6f693          	andi	a3,a3,15
    800025c0:	00dd86b3          	add	a3,s11,a3
    800025c4:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    800025c8:	0087d79b          	srliw	a5,a5,0x8
    800025cc:	00100c93          	li	s9,1
    800025d0:	f8d400a3          	sb	a3,-127(s0)
    800025d4:	0cb67263          	bgeu	a2,a1,80002698 <__printf+0x410>
    800025d8:	00f7f693          	andi	a3,a5,15
    800025dc:	00dd86b3          	add	a3,s11,a3
    800025e0:	0006c583          	lbu	a1,0(a3)
    800025e4:	00f00613          	li	a2,15
    800025e8:	0047d69b          	srliw	a3,a5,0x4
    800025ec:	f8b40123          	sb	a1,-126(s0)
    800025f0:	0047d593          	srli	a1,a5,0x4
    800025f4:	28f67e63          	bgeu	a2,a5,80002890 <__printf+0x608>
    800025f8:	00f6f693          	andi	a3,a3,15
    800025fc:	00dd86b3          	add	a3,s11,a3
    80002600:	0006c503          	lbu	a0,0(a3)
    80002604:	0087d813          	srli	a6,a5,0x8
    80002608:	0087d69b          	srliw	a3,a5,0x8
    8000260c:	f8a401a3          	sb	a0,-125(s0)
    80002610:	28b67663          	bgeu	a2,a1,8000289c <__printf+0x614>
    80002614:	00f6f693          	andi	a3,a3,15
    80002618:	00dd86b3          	add	a3,s11,a3
    8000261c:	0006c583          	lbu	a1,0(a3)
    80002620:	00c7d513          	srli	a0,a5,0xc
    80002624:	00c7d69b          	srliw	a3,a5,0xc
    80002628:	f8b40223          	sb	a1,-124(s0)
    8000262c:	29067a63          	bgeu	a2,a6,800028c0 <__printf+0x638>
    80002630:	00f6f693          	andi	a3,a3,15
    80002634:	00dd86b3          	add	a3,s11,a3
    80002638:	0006c583          	lbu	a1,0(a3)
    8000263c:	0107d813          	srli	a6,a5,0x10
    80002640:	0107d69b          	srliw	a3,a5,0x10
    80002644:	f8b402a3          	sb	a1,-123(s0)
    80002648:	28a67263          	bgeu	a2,a0,800028cc <__printf+0x644>
    8000264c:	00f6f693          	andi	a3,a3,15
    80002650:	00dd86b3          	add	a3,s11,a3
    80002654:	0006c683          	lbu	a3,0(a3)
    80002658:	0147d79b          	srliw	a5,a5,0x14
    8000265c:	f8d40323          	sb	a3,-122(s0)
    80002660:	21067663          	bgeu	a2,a6,8000286c <__printf+0x5e4>
    80002664:	02079793          	slli	a5,a5,0x20
    80002668:	0207d793          	srli	a5,a5,0x20
    8000266c:	00fd8db3          	add	s11,s11,a5
    80002670:	000dc683          	lbu	a3,0(s11)
    80002674:	00800793          	li	a5,8
    80002678:	00700c93          	li	s9,7
    8000267c:	f8d403a3          	sb	a3,-121(s0)
    80002680:	00075c63          	bgez	a4,80002698 <__printf+0x410>
    80002684:	f9040713          	addi	a4,s0,-112
    80002688:	00f70733          	add	a4,a4,a5
    8000268c:	02d00693          	li	a3,45
    80002690:	fed70823          	sb	a3,-16(a4)
    80002694:	00078c93          	mv	s9,a5
    80002698:	f8040793          	addi	a5,s0,-128
    8000269c:	01978cb3          	add	s9,a5,s9
    800026a0:	f7f40d13          	addi	s10,s0,-129
    800026a4:	000cc503          	lbu	a0,0(s9)
    800026a8:	fffc8c93          	addi	s9,s9,-1
    800026ac:	00000097          	auipc	ra,0x0
    800026b0:	9f8080e7          	jalr	-1544(ra) # 800020a4 <consputc>
    800026b4:	ff9d18e3          	bne	s10,s9,800026a4 <__printf+0x41c>
    800026b8:	0100006f          	j	800026c8 <__printf+0x440>
    800026bc:	00000097          	auipc	ra,0x0
    800026c0:	9e8080e7          	jalr	-1560(ra) # 800020a4 <consputc>
    800026c4:	000c8493          	mv	s1,s9
    800026c8:	00094503          	lbu	a0,0(s2)
    800026cc:	c60510e3          	bnez	a0,8000232c <__printf+0xa4>
    800026d0:	e40c0ee3          	beqz	s8,8000252c <__printf+0x2a4>
    800026d4:	00003517          	auipc	a0,0x3
    800026d8:	00c50513          	addi	a0,a0,12 # 800056e0 <pr>
    800026dc:	00001097          	auipc	ra,0x1
    800026e0:	94c080e7          	jalr	-1716(ra) # 80003028 <release>
    800026e4:	e49ff06f          	j	8000252c <__printf+0x2a4>
    800026e8:	f7843783          	ld	a5,-136(s0)
    800026ec:	03000513          	li	a0,48
    800026f0:	01000d13          	li	s10,16
    800026f4:	00878713          	addi	a4,a5,8
    800026f8:	0007bc83          	ld	s9,0(a5)
    800026fc:	f6e43c23          	sd	a4,-136(s0)
    80002700:	00000097          	auipc	ra,0x0
    80002704:	9a4080e7          	jalr	-1628(ra) # 800020a4 <consputc>
    80002708:	07800513          	li	a0,120
    8000270c:	00000097          	auipc	ra,0x0
    80002710:	998080e7          	jalr	-1640(ra) # 800020a4 <consputc>
    80002714:	00002d97          	auipc	s11,0x2
    80002718:	a64d8d93          	addi	s11,s11,-1436 # 80004178 <digits>
    8000271c:	03ccd793          	srli	a5,s9,0x3c
    80002720:	00fd87b3          	add	a5,s11,a5
    80002724:	0007c503          	lbu	a0,0(a5)
    80002728:	fffd0d1b          	addiw	s10,s10,-1
    8000272c:	004c9c93          	slli	s9,s9,0x4
    80002730:	00000097          	auipc	ra,0x0
    80002734:	974080e7          	jalr	-1676(ra) # 800020a4 <consputc>
    80002738:	fe0d12e3          	bnez	s10,8000271c <__printf+0x494>
    8000273c:	f8dff06f          	j	800026c8 <__printf+0x440>
    80002740:	f7843783          	ld	a5,-136(s0)
    80002744:	0007bc83          	ld	s9,0(a5)
    80002748:	00878793          	addi	a5,a5,8
    8000274c:	f6f43c23          	sd	a5,-136(s0)
    80002750:	000c9a63          	bnez	s9,80002764 <__printf+0x4dc>
    80002754:	1080006f          	j	8000285c <__printf+0x5d4>
    80002758:	001c8c93          	addi	s9,s9,1
    8000275c:	00000097          	auipc	ra,0x0
    80002760:	948080e7          	jalr	-1720(ra) # 800020a4 <consputc>
    80002764:	000cc503          	lbu	a0,0(s9)
    80002768:	fe0518e3          	bnez	a0,80002758 <__printf+0x4d0>
    8000276c:	f5dff06f          	j	800026c8 <__printf+0x440>
    80002770:	02500513          	li	a0,37
    80002774:	00000097          	auipc	ra,0x0
    80002778:	930080e7          	jalr	-1744(ra) # 800020a4 <consputc>
    8000277c:	000c8513          	mv	a0,s9
    80002780:	00000097          	auipc	ra,0x0
    80002784:	924080e7          	jalr	-1756(ra) # 800020a4 <consputc>
    80002788:	f41ff06f          	j	800026c8 <__printf+0x440>
    8000278c:	02500513          	li	a0,37
    80002790:	00000097          	auipc	ra,0x0
    80002794:	914080e7          	jalr	-1772(ra) # 800020a4 <consputc>
    80002798:	f31ff06f          	j	800026c8 <__printf+0x440>
    8000279c:	00030513          	mv	a0,t1
    800027a0:	00000097          	auipc	ra,0x0
    800027a4:	7bc080e7          	jalr	1980(ra) # 80002f5c <acquire>
    800027a8:	b4dff06f          	j	800022f4 <__printf+0x6c>
    800027ac:	40c0053b          	negw	a0,a2
    800027b0:	00a00713          	li	a4,10
    800027b4:	02e576bb          	remuw	a3,a0,a4
    800027b8:	00002d97          	auipc	s11,0x2
    800027bc:	9c0d8d93          	addi	s11,s11,-1600 # 80004178 <digits>
    800027c0:	ff700593          	li	a1,-9
    800027c4:	02069693          	slli	a3,a3,0x20
    800027c8:	0206d693          	srli	a3,a3,0x20
    800027cc:	00dd86b3          	add	a3,s11,a3
    800027d0:	0006c683          	lbu	a3,0(a3)
    800027d4:	02e557bb          	divuw	a5,a0,a4
    800027d8:	f8d40023          	sb	a3,-128(s0)
    800027dc:	10b65e63          	bge	a2,a1,800028f8 <__printf+0x670>
    800027e0:	06300593          	li	a1,99
    800027e4:	02e7f6bb          	remuw	a3,a5,a4
    800027e8:	02069693          	slli	a3,a3,0x20
    800027ec:	0206d693          	srli	a3,a3,0x20
    800027f0:	00dd86b3          	add	a3,s11,a3
    800027f4:	0006c683          	lbu	a3,0(a3)
    800027f8:	02e7d73b          	divuw	a4,a5,a4
    800027fc:	00200793          	li	a5,2
    80002800:	f8d400a3          	sb	a3,-127(s0)
    80002804:	bca5ece3          	bltu	a1,a0,800023dc <__printf+0x154>
    80002808:	ce5ff06f          	j	800024ec <__printf+0x264>
    8000280c:	40e007bb          	negw	a5,a4
    80002810:	00002d97          	auipc	s11,0x2
    80002814:	968d8d93          	addi	s11,s11,-1688 # 80004178 <digits>
    80002818:	00f7f693          	andi	a3,a5,15
    8000281c:	00dd86b3          	add	a3,s11,a3
    80002820:	0006c583          	lbu	a1,0(a3)
    80002824:	ff100613          	li	a2,-15
    80002828:	0047d69b          	srliw	a3,a5,0x4
    8000282c:	f8b40023          	sb	a1,-128(s0)
    80002830:	0047d59b          	srliw	a1,a5,0x4
    80002834:	0ac75e63          	bge	a4,a2,800028f0 <__printf+0x668>
    80002838:	00f6f693          	andi	a3,a3,15
    8000283c:	00dd86b3          	add	a3,s11,a3
    80002840:	0006c603          	lbu	a2,0(a3)
    80002844:	00f00693          	li	a3,15
    80002848:	0087d79b          	srliw	a5,a5,0x8
    8000284c:	f8c400a3          	sb	a2,-127(s0)
    80002850:	d8b6e4e3          	bltu	a3,a1,800025d8 <__printf+0x350>
    80002854:	00200793          	li	a5,2
    80002858:	e2dff06f          	j	80002684 <__printf+0x3fc>
    8000285c:	00002c97          	auipc	s9,0x2
    80002860:	8fcc8c93          	addi	s9,s9,-1796 # 80004158 <CONSOLE_STATUS+0x148>
    80002864:	02800513          	li	a0,40
    80002868:	ef1ff06f          	j	80002758 <__printf+0x4d0>
    8000286c:	00700793          	li	a5,7
    80002870:	00600c93          	li	s9,6
    80002874:	e0dff06f          	j	80002680 <__printf+0x3f8>
    80002878:	00700793          	li	a5,7
    8000287c:	00600c93          	li	s9,6
    80002880:	c69ff06f          	j	800024e8 <__printf+0x260>
    80002884:	00300793          	li	a5,3
    80002888:	00200c93          	li	s9,2
    8000288c:	c5dff06f          	j	800024e8 <__printf+0x260>
    80002890:	00300793          	li	a5,3
    80002894:	00200c93          	li	s9,2
    80002898:	de9ff06f          	j	80002680 <__printf+0x3f8>
    8000289c:	00400793          	li	a5,4
    800028a0:	00300c93          	li	s9,3
    800028a4:	dddff06f          	j	80002680 <__printf+0x3f8>
    800028a8:	00400793          	li	a5,4
    800028ac:	00300c93          	li	s9,3
    800028b0:	c39ff06f          	j	800024e8 <__printf+0x260>
    800028b4:	00500793          	li	a5,5
    800028b8:	00400c93          	li	s9,4
    800028bc:	c2dff06f          	j	800024e8 <__printf+0x260>
    800028c0:	00500793          	li	a5,5
    800028c4:	00400c93          	li	s9,4
    800028c8:	db9ff06f          	j	80002680 <__printf+0x3f8>
    800028cc:	00600793          	li	a5,6
    800028d0:	00500c93          	li	s9,5
    800028d4:	dadff06f          	j	80002680 <__printf+0x3f8>
    800028d8:	00600793          	li	a5,6
    800028dc:	00500c93          	li	s9,5
    800028e0:	c09ff06f          	j	800024e8 <__printf+0x260>
    800028e4:	00800793          	li	a5,8
    800028e8:	00700c93          	li	s9,7
    800028ec:	bfdff06f          	j	800024e8 <__printf+0x260>
    800028f0:	00100793          	li	a5,1
    800028f4:	d91ff06f          	j	80002684 <__printf+0x3fc>
    800028f8:	00100793          	li	a5,1
    800028fc:	bf1ff06f          	j	800024ec <__printf+0x264>
    80002900:	00900793          	li	a5,9
    80002904:	00800c93          	li	s9,8
    80002908:	be1ff06f          	j	800024e8 <__printf+0x260>
    8000290c:	00002517          	auipc	a0,0x2
    80002910:	85450513          	addi	a0,a0,-1964 # 80004160 <CONSOLE_STATUS+0x150>
    80002914:	00000097          	auipc	ra,0x0
    80002918:	918080e7          	jalr	-1768(ra) # 8000222c <panic>

000000008000291c <printfinit>:
    8000291c:	fe010113          	addi	sp,sp,-32
    80002920:	00813823          	sd	s0,16(sp)
    80002924:	00913423          	sd	s1,8(sp)
    80002928:	00113c23          	sd	ra,24(sp)
    8000292c:	02010413          	addi	s0,sp,32
    80002930:	00003497          	auipc	s1,0x3
    80002934:	db048493          	addi	s1,s1,-592 # 800056e0 <pr>
    80002938:	00048513          	mv	a0,s1
    8000293c:	00002597          	auipc	a1,0x2
    80002940:	83458593          	addi	a1,a1,-1996 # 80004170 <CONSOLE_STATUS+0x160>
    80002944:	00000097          	auipc	ra,0x0
    80002948:	5f4080e7          	jalr	1524(ra) # 80002f38 <initlock>
    8000294c:	01813083          	ld	ra,24(sp)
    80002950:	01013403          	ld	s0,16(sp)
    80002954:	0004ac23          	sw	zero,24(s1)
    80002958:	00813483          	ld	s1,8(sp)
    8000295c:	02010113          	addi	sp,sp,32
    80002960:	00008067          	ret

0000000080002964 <uartinit>:
    80002964:	ff010113          	addi	sp,sp,-16
    80002968:	00813423          	sd	s0,8(sp)
    8000296c:	01010413          	addi	s0,sp,16
    80002970:	100007b7          	lui	a5,0x10000
    80002974:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80002978:	f8000713          	li	a4,-128
    8000297c:	00e781a3          	sb	a4,3(a5)
    80002980:	00300713          	li	a4,3
    80002984:	00e78023          	sb	a4,0(a5)
    80002988:	000780a3          	sb	zero,1(a5)
    8000298c:	00e781a3          	sb	a4,3(a5)
    80002990:	00700693          	li	a3,7
    80002994:	00d78123          	sb	a3,2(a5)
    80002998:	00e780a3          	sb	a4,1(a5)
    8000299c:	00813403          	ld	s0,8(sp)
    800029a0:	01010113          	addi	sp,sp,16
    800029a4:	00008067          	ret

00000000800029a8 <uartputc>:
    800029a8:	00002797          	auipc	a5,0x2
    800029ac:	ae07a783          	lw	a5,-1312(a5) # 80004488 <panicked>
    800029b0:	00078463          	beqz	a5,800029b8 <uartputc+0x10>
    800029b4:	0000006f          	j	800029b4 <uartputc+0xc>
    800029b8:	fd010113          	addi	sp,sp,-48
    800029bc:	02813023          	sd	s0,32(sp)
    800029c0:	00913c23          	sd	s1,24(sp)
    800029c4:	01213823          	sd	s2,16(sp)
    800029c8:	01313423          	sd	s3,8(sp)
    800029cc:	02113423          	sd	ra,40(sp)
    800029d0:	03010413          	addi	s0,sp,48
    800029d4:	00002917          	auipc	s2,0x2
    800029d8:	abc90913          	addi	s2,s2,-1348 # 80004490 <uart_tx_r>
    800029dc:	00093783          	ld	a5,0(s2)
    800029e0:	00002497          	auipc	s1,0x2
    800029e4:	ab848493          	addi	s1,s1,-1352 # 80004498 <uart_tx_w>
    800029e8:	0004b703          	ld	a4,0(s1)
    800029ec:	02078693          	addi	a3,a5,32
    800029f0:	00050993          	mv	s3,a0
    800029f4:	02e69c63          	bne	a3,a4,80002a2c <uartputc+0x84>
    800029f8:	00001097          	auipc	ra,0x1
    800029fc:	834080e7          	jalr	-1996(ra) # 8000322c <push_on>
    80002a00:	00093783          	ld	a5,0(s2)
    80002a04:	0004b703          	ld	a4,0(s1)
    80002a08:	02078793          	addi	a5,a5,32
    80002a0c:	00e79463          	bne	a5,a4,80002a14 <uartputc+0x6c>
    80002a10:	0000006f          	j	80002a10 <uartputc+0x68>
    80002a14:	00001097          	auipc	ra,0x1
    80002a18:	88c080e7          	jalr	-1908(ra) # 800032a0 <pop_on>
    80002a1c:	00093783          	ld	a5,0(s2)
    80002a20:	0004b703          	ld	a4,0(s1)
    80002a24:	02078693          	addi	a3,a5,32
    80002a28:	fce688e3          	beq	a3,a4,800029f8 <uartputc+0x50>
    80002a2c:	01f77693          	andi	a3,a4,31
    80002a30:	00003597          	auipc	a1,0x3
    80002a34:	cd058593          	addi	a1,a1,-816 # 80005700 <uart_tx_buf>
    80002a38:	00d586b3          	add	a3,a1,a3
    80002a3c:	00170713          	addi	a4,a4,1
    80002a40:	01368023          	sb	s3,0(a3)
    80002a44:	00e4b023          	sd	a4,0(s1)
    80002a48:	10000637          	lui	a2,0x10000
    80002a4c:	02f71063          	bne	a4,a5,80002a6c <uartputc+0xc4>
    80002a50:	0340006f          	j	80002a84 <uartputc+0xdc>
    80002a54:	00074703          	lbu	a4,0(a4)
    80002a58:	00f93023          	sd	a5,0(s2)
    80002a5c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80002a60:	00093783          	ld	a5,0(s2)
    80002a64:	0004b703          	ld	a4,0(s1)
    80002a68:	00f70e63          	beq	a4,a5,80002a84 <uartputc+0xdc>
    80002a6c:	00564683          	lbu	a3,5(a2)
    80002a70:	01f7f713          	andi	a4,a5,31
    80002a74:	00e58733          	add	a4,a1,a4
    80002a78:	0206f693          	andi	a3,a3,32
    80002a7c:	00178793          	addi	a5,a5,1
    80002a80:	fc069ae3          	bnez	a3,80002a54 <uartputc+0xac>
    80002a84:	02813083          	ld	ra,40(sp)
    80002a88:	02013403          	ld	s0,32(sp)
    80002a8c:	01813483          	ld	s1,24(sp)
    80002a90:	01013903          	ld	s2,16(sp)
    80002a94:	00813983          	ld	s3,8(sp)
    80002a98:	03010113          	addi	sp,sp,48
    80002a9c:	00008067          	ret

0000000080002aa0 <uartputc_sync>:
    80002aa0:	ff010113          	addi	sp,sp,-16
    80002aa4:	00813423          	sd	s0,8(sp)
    80002aa8:	01010413          	addi	s0,sp,16
    80002aac:	00002717          	auipc	a4,0x2
    80002ab0:	9dc72703          	lw	a4,-1572(a4) # 80004488 <panicked>
    80002ab4:	02071663          	bnez	a4,80002ae0 <uartputc_sync+0x40>
    80002ab8:	00050793          	mv	a5,a0
    80002abc:	100006b7          	lui	a3,0x10000
    80002ac0:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80002ac4:	02077713          	andi	a4,a4,32
    80002ac8:	fe070ce3          	beqz	a4,80002ac0 <uartputc_sync+0x20>
    80002acc:	0ff7f793          	andi	a5,a5,255
    80002ad0:	00f68023          	sb	a5,0(a3)
    80002ad4:	00813403          	ld	s0,8(sp)
    80002ad8:	01010113          	addi	sp,sp,16
    80002adc:	00008067          	ret
    80002ae0:	0000006f          	j	80002ae0 <uartputc_sync+0x40>

0000000080002ae4 <uartstart>:
    80002ae4:	ff010113          	addi	sp,sp,-16
    80002ae8:	00813423          	sd	s0,8(sp)
    80002aec:	01010413          	addi	s0,sp,16
    80002af0:	00002617          	auipc	a2,0x2
    80002af4:	9a060613          	addi	a2,a2,-1632 # 80004490 <uart_tx_r>
    80002af8:	00002517          	auipc	a0,0x2
    80002afc:	9a050513          	addi	a0,a0,-1632 # 80004498 <uart_tx_w>
    80002b00:	00063783          	ld	a5,0(a2)
    80002b04:	00053703          	ld	a4,0(a0)
    80002b08:	04f70263          	beq	a4,a5,80002b4c <uartstart+0x68>
    80002b0c:	100005b7          	lui	a1,0x10000
    80002b10:	00003817          	auipc	a6,0x3
    80002b14:	bf080813          	addi	a6,a6,-1040 # 80005700 <uart_tx_buf>
    80002b18:	01c0006f          	j	80002b34 <uartstart+0x50>
    80002b1c:	0006c703          	lbu	a4,0(a3)
    80002b20:	00f63023          	sd	a5,0(a2)
    80002b24:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80002b28:	00063783          	ld	a5,0(a2)
    80002b2c:	00053703          	ld	a4,0(a0)
    80002b30:	00f70e63          	beq	a4,a5,80002b4c <uartstart+0x68>
    80002b34:	01f7f713          	andi	a4,a5,31
    80002b38:	00e806b3          	add	a3,a6,a4
    80002b3c:	0055c703          	lbu	a4,5(a1)
    80002b40:	00178793          	addi	a5,a5,1
    80002b44:	02077713          	andi	a4,a4,32
    80002b48:	fc071ae3          	bnez	a4,80002b1c <uartstart+0x38>
    80002b4c:	00813403          	ld	s0,8(sp)
    80002b50:	01010113          	addi	sp,sp,16
    80002b54:	00008067          	ret

0000000080002b58 <uartgetc>:
    80002b58:	ff010113          	addi	sp,sp,-16
    80002b5c:	00813423          	sd	s0,8(sp)
    80002b60:	01010413          	addi	s0,sp,16
    80002b64:	10000737          	lui	a4,0x10000
    80002b68:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    80002b6c:	0017f793          	andi	a5,a5,1
    80002b70:	00078c63          	beqz	a5,80002b88 <uartgetc+0x30>
    80002b74:	00074503          	lbu	a0,0(a4)
    80002b78:	0ff57513          	andi	a0,a0,255
    80002b7c:	00813403          	ld	s0,8(sp)
    80002b80:	01010113          	addi	sp,sp,16
    80002b84:	00008067          	ret
    80002b88:	fff00513          	li	a0,-1
    80002b8c:	ff1ff06f          	j	80002b7c <uartgetc+0x24>

0000000080002b90 <uartintr>:
    80002b90:	100007b7          	lui	a5,0x10000
    80002b94:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80002b98:	0017f793          	andi	a5,a5,1
    80002b9c:	0a078463          	beqz	a5,80002c44 <uartintr+0xb4>
    80002ba0:	fe010113          	addi	sp,sp,-32
    80002ba4:	00813823          	sd	s0,16(sp)
    80002ba8:	00913423          	sd	s1,8(sp)
    80002bac:	00113c23          	sd	ra,24(sp)
    80002bb0:	02010413          	addi	s0,sp,32
    80002bb4:	100004b7          	lui	s1,0x10000
    80002bb8:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    80002bbc:	0ff57513          	andi	a0,a0,255
    80002bc0:	fffff097          	auipc	ra,0xfffff
    80002bc4:	534080e7          	jalr	1332(ra) # 800020f4 <consoleintr>
    80002bc8:	0054c783          	lbu	a5,5(s1)
    80002bcc:	0017f793          	andi	a5,a5,1
    80002bd0:	fe0794e3          	bnez	a5,80002bb8 <uartintr+0x28>
    80002bd4:	00002617          	auipc	a2,0x2
    80002bd8:	8bc60613          	addi	a2,a2,-1860 # 80004490 <uart_tx_r>
    80002bdc:	00002517          	auipc	a0,0x2
    80002be0:	8bc50513          	addi	a0,a0,-1860 # 80004498 <uart_tx_w>
    80002be4:	00063783          	ld	a5,0(a2)
    80002be8:	00053703          	ld	a4,0(a0)
    80002bec:	04f70263          	beq	a4,a5,80002c30 <uartintr+0xa0>
    80002bf0:	100005b7          	lui	a1,0x10000
    80002bf4:	00003817          	auipc	a6,0x3
    80002bf8:	b0c80813          	addi	a6,a6,-1268 # 80005700 <uart_tx_buf>
    80002bfc:	01c0006f          	j	80002c18 <uartintr+0x88>
    80002c00:	0006c703          	lbu	a4,0(a3)
    80002c04:	00f63023          	sd	a5,0(a2)
    80002c08:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80002c0c:	00063783          	ld	a5,0(a2)
    80002c10:	00053703          	ld	a4,0(a0)
    80002c14:	00f70e63          	beq	a4,a5,80002c30 <uartintr+0xa0>
    80002c18:	01f7f713          	andi	a4,a5,31
    80002c1c:	00e806b3          	add	a3,a6,a4
    80002c20:	0055c703          	lbu	a4,5(a1)
    80002c24:	00178793          	addi	a5,a5,1
    80002c28:	02077713          	andi	a4,a4,32
    80002c2c:	fc071ae3          	bnez	a4,80002c00 <uartintr+0x70>
    80002c30:	01813083          	ld	ra,24(sp)
    80002c34:	01013403          	ld	s0,16(sp)
    80002c38:	00813483          	ld	s1,8(sp)
    80002c3c:	02010113          	addi	sp,sp,32
    80002c40:	00008067          	ret
    80002c44:	00002617          	auipc	a2,0x2
    80002c48:	84c60613          	addi	a2,a2,-1972 # 80004490 <uart_tx_r>
    80002c4c:	00002517          	auipc	a0,0x2
    80002c50:	84c50513          	addi	a0,a0,-1972 # 80004498 <uart_tx_w>
    80002c54:	00063783          	ld	a5,0(a2)
    80002c58:	00053703          	ld	a4,0(a0)
    80002c5c:	04f70263          	beq	a4,a5,80002ca0 <uartintr+0x110>
    80002c60:	100005b7          	lui	a1,0x10000
    80002c64:	00003817          	auipc	a6,0x3
    80002c68:	a9c80813          	addi	a6,a6,-1380 # 80005700 <uart_tx_buf>
    80002c6c:	01c0006f          	j	80002c88 <uartintr+0xf8>
    80002c70:	0006c703          	lbu	a4,0(a3)
    80002c74:	00f63023          	sd	a5,0(a2)
    80002c78:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80002c7c:	00063783          	ld	a5,0(a2)
    80002c80:	00053703          	ld	a4,0(a0)
    80002c84:	02f70063          	beq	a4,a5,80002ca4 <uartintr+0x114>
    80002c88:	01f7f713          	andi	a4,a5,31
    80002c8c:	00e806b3          	add	a3,a6,a4
    80002c90:	0055c703          	lbu	a4,5(a1)
    80002c94:	00178793          	addi	a5,a5,1
    80002c98:	02077713          	andi	a4,a4,32
    80002c9c:	fc071ae3          	bnez	a4,80002c70 <uartintr+0xe0>
    80002ca0:	00008067          	ret
    80002ca4:	00008067          	ret

0000000080002ca8 <kinit>:
    80002ca8:	fc010113          	addi	sp,sp,-64
    80002cac:	02913423          	sd	s1,40(sp)
    80002cb0:	fffff7b7          	lui	a5,0xfffff
    80002cb4:	00004497          	auipc	s1,0x4
    80002cb8:	a6b48493          	addi	s1,s1,-1429 # 8000671f <end+0xfff>
    80002cbc:	02813823          	sd	s0,48(sp)
    80002cc0:	01313c23          	sd	s3,24(sp)
    80002cc4:	00f4f4b3          	and	s1,s1,a5
    80002cc8:	02113c23          	sd	ra,56(sp)
    80002ccc:	03213023          	sd	s2,32(sp)
    80002cd0:	01413823          	sd	s4,16(sp)
    80002cd4:	01513423          	sd	s5,8(sp)
    80002cd8:	04010413          	addi	s0,sp,64
    80002cdc:	000017b7          	lui	a5,0x1
    80002ce0:	01100993          	li	s3,17
    80002ce4:	00f487b3          	add	a5,s1,a5
    80002ce8:	01b99993          	slli	s3,s3,0x1b
    80002cec:	06f9e063          	bltu	s3,a5,80002d4c <kinit+0xa4>
    80002cf0:	00003a97          	auipc	s5,0x3
    80002cf4:	a30a8a93          	addi	s5,s5,-1488 # 80005720 <end>
    80002cf8:	0754ec63          	bltu	s1,s5,80002d70 <kinit+0xc8>
    80002cfc:	0734fa63          	bgeu	s1,s3,80002d70 <kinit+0xc8>
    80002d00:	00088a37          	lui	s4,0x88
    80002d04:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80002d08:	00001917          	auipc	s2,0x1
    80002d0c:	79890913          	addi	s2,s2,1944 # 800044a0 <kmem>
    80002d10:	00ca1a13          	slli	s4,s4,0xc
    80002d14:	0140006f          	j	80002d28 <kinit+0x80>
    80002d18:	000017b7          	lui	a5,0x1
    80002d1c:	00f484b3          	add	s1,s1,a5
    80002d20:	0554e863          	bltu	s1,s5,80002d70 <kinit+0xc8>
    80002d24:	0534f663          	bgeu	s1,s3,80002d70 <kinit+0xc8>
    80002d28:	00001637          	lui	a2,0x1
    80002d2c:	00100593          	li	a1,1
    80002d30:	00048513          	mv	a0,s1
    80002d34:	00000097          	auipc	ra,0x0
    80002d38:	5e4080e7          	jalr	1508(ra) # 80003318 <__memset>
    80002d3c:	00093783          	ld	a5,0(s2)
    80002d40:	00f4b023          	sd	a5,0(s1)
    80002d44:	00993023          	sd	s1,0(s2)
    80002d48:	fd4498e3          	bne	s1,s4,80002d18 <kinit+0x70>
    80002d4c:	03813083          	ld	ra,56(sp)
    80002d50:	03013403          	ld	s0,48(sp)
    80002d54:	02813483          	ld	s1,40(sp)
    80002d58:	02013903          	ld	s2,32(sp)
    80002d5c:	01813983          	ld	s3,24(sp)
    80002d60:	01013a03          	ld	s4,16(sp)
    80002d64:	00813a83          	ld	s5,8(sp)
    80002d68:	04010113          	addi	sp,sp,64
    80002d6c:	00008067          	ret
    80002d70:	00001517          	auipc	a0,0x1
    80002d74:	42050513          	addi	a0,a0,1056 # 80004190 <digits+0x18>
    80002d78:	fffff097          	auipc	ra,0xfffff
    80002d7c:	4b4080e7          	jalr	1204(ra) # 8000222c <panic>

0000000080002d80 <freerange>:
    80002d80:	fc010113          	addi	sp,sp,-64
    80002d84:	000017b7          	lui	a5,0x1
    80002d88:	02913423          	sd	s1,40(sp)
    80002d8c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80002d90:	009504b3          	add	s1,a0,s1
    80002d94:	fffff537          	lui	a0,0xfffff
    80002d98:	02813823          	sd	s0,48(sp)
    80002d9c:	02113c23          	sd	ra,56(sp)
    80002da0:	03213023          	sd	s2,32(sp)
    80002da4:	01313c23          	sd	s3,24(sp)
    80002da8:	01413823          	sd	s4,16(sp)
    80002dac:	01513423          	sd	s5,8(sp)
    80002db0:	01613023          	sd	s6,0(sp)
    80002db4:	04010413          	addi	s0,sp,64
    80002db8:	00a4f4b3          	and	s1,s1,a0
    80002dbc:	00f487b3          	add	a5,s1,a5
    80002dc0:	06f5e463          	bltu	a1,a5,80002e28 <freerange+0xa8>
    80002dc4:	00003a97          	auipc	s5,0x3
    80002dc8:	95ca8a93          	addi	s5,s5,-1700 # 80005720 <end>
    80002dcc:	0954e263          	bltu	s1,s5,80002e50 <freerange+0xd0>
    80002dd0:	01100993          	li	s3,17
    80002dd4:	01b99993          	slli	s3,s3,0x1b
    80002dd8:	0734fc63          	bgeu	s1,s3,80002e50 <freerange+0xd0>
    80002ddc:	00058a13          	mv	s4,a1
    80002de0:	00001917          	auipc	s2,0x1
    80002de4:	6c090913          	addi	s2,s2,1728 # 800044a0 <kmem>
    80002de8:	00002b37          	lui	s6,0x2
    80002dec:	0140006f          	j	80002e00 <freerange+0x80>
    80002df0:	000017b7          	lui	a5,0x1
    80002df4:	00f484b3          	add	s1,s1,a5
    80002df8:	0554ec63          	bltu	s1,s5,80002e50 <freerange+0xd0>
    80002dfc:	0534fa63          	bgeu	s1,s3,80002e50 <freerange+0xd0>
    80002e00:	00001637          	lui	a2,0x1
    80002e04:	00100593          	li	a1,1
    80002e08:	00048513          	mv	a0,s1
    80002e0c:	00000097          	auipc	ra,0x0
    80002e10:	50c080e7          	jalr	1292(ra) # 80003318 <__memset>
    80002e14:	00093703          	ld	a4,0(s2)
    80002e18:	016487b3          	add	a5,s1,s6
    80002e1c:	00e4b023          	sd	a4,0(s1)
    80002e20:	00993023          	sd	s1,0(s2)
    80002e24:	fcfa76e3          	bgeu	s4,a5,80002df0 <freerange+0x70>
    80002e28:	03813083          	ld	ra,56(sp)
    80002e2c:	03013403          	ld	s0,48(sp)
    80002e30:	02813483          	ld	s1,40(sp)
    80002e34:	02013903          	ld	s2,32(sp)
    80002e38:	01813983          	ld	s3,24(sp)
    80002e3c:	01013a03          	ld	s4,16(sp)
    80002e40:	00813a83          	ld	s5,8(sp)
    80002e44:	00013b03          	ld	s6,0(sp)
    80002e48:	04010113          	addi	sp,sp,64
    80002e4c:	00008067          	ret
    80002e50:	00001517          	auipc	a0,0x1
    80002e54:	34050513          	addi	a0,a0,832 # 80004190 <digits+0x18>
    80002e58:	fffff097          	auipc	ra,0xfffff
    80002e5c:	3d4080e7          	jalr	980(ra) # 8000222c <panic>

0000000080002e60 <kfree>:
    80002e60:	fe010113          	addi	sp,sp,-32
    80002e64:	00813823          	sd	s0,16(sp)
    80002e68:	00113c23          	sd	ra,24(sp)
    80002e6c:	00913423          	sd	s1,8(sp)
    80002e70:	02010413          	addi	s0,sp,32
    80002e74:	03451793          	slli	a5,a0,0x34
    80002e78:	04079c63          	bnez	a5,80002ed0 <kfree+0x70>
    80002e7c:	00003797          	auipc	a5,0x3
    80002e80:	8a478793          	addi	a5,a5,-1884 # 80005720 <end>
    80002e84:	00050493          	mv	s1,a0
    80002e88:	04f56463          	bltu	a0,a5,80002ed0 <kfree+0x70>
    80002e8c:	01100793          	li	a5,17
    80002e90:	01b79793          	slli	a5,a5,0x1b
    80002e94:	02f57e63          	bgeu	a0,a5,80002ed0 <kfree+0x70>
    80002e98:	00001637          	lui	a2,0x1
    80002e9c:	00100593          	li	a1,1
    80002ea0:	00000097          	auipc	ra,0x0
    80002ea4:	478080e7          	jalr	1144(ra) # 80003318 <__memset>
    80002ea8:	00001797          	auipc	a5,0x1
    80002eac:	5f878793          	addi	a5,a5,1528 # 800044a0 <kmem>
    80002eb0:	0007b703          	ld	a4,0(a5)
    80002eb4:	01813083          	ld	ra,24(sp)
    80002eb8:	01013403          	ld	s0,16(sp)
    80002ebc:	00e4b023          	sd	a4,0(s1)
    80002ec0:	0097b023          	sd	s1,0(a5)
    80002ec4:	00813483          	ld	s1,8(sp)
    80002ec8:	02010113          	addi	sp,sp,32
    80002ecc:	00008067          	ret
    80002ed0:	00001517          	auipc	a0,0x1
    80002ed4:	2c050513          	addi	a0,a0,704 # 80004190 <digits+0x18>
    80002ed8:	fffff097          	auipc	ra,0xfffff
    80002edc:	354080e7          	jalr	852(ra) # 8000222c <panic>

0000000080002ee0 <kalloc>:
    80002ee0:	fe010113          	addi	sp,sp,-32
    80002ee4:	00813823          	sd	s0,16(sp)
    80002ee8:	00913423          	sd	s1,8(sp)
    80002eec:	00113c23          	sd	ra,24(sp)
    80002ef0:	02010413          	addi	s0,sp,32
    80002ef4:	00001797          	auipc	a5,0x1
    80002ef8:	5ac78793          	addi	a5,a5,1452 # 800044a0 <kmem>
    80002efc:	0007b483          	ld	s1,0(a5)
    80002f00:	02048063          	beqz	s1,80002f20 <kalloc+0x40>
    80002f04:	0004b703          	ld	a4,0(s1)
    80002f08:	00001637          	lui	a2,0x1
    80002f0c:	00500593          	li	a1,5
    80002f10:	00048513          	mv	a0,s1
    80002f14:	00e7b023          	sd	a4,0(a5)
    80002f18:	00000097          	auipc	ra,0x0
    80002f1c:	400080e7          	jalr	1024(ra) # 80003318 <__memset>
    80002f20:	01813083          	ld	ra,24(sp)
    80002f24:	01013403          	ld	s0,16(sp)
    80002f28:	00048513          	mv	a0,s1
    80002f2c:	00813483          	ld	s1,8(sp)
    80002f30:	02010113          	addi	sp,sp,32
    80002f34:	00008067          	ret

0000000080002f38 <initlock>:
    80002f38:	ff010113          	addi	sp,sp,-16
    80002f3c:	00813423          	sd	s0,8(sp)
    80002f40:	01010413          	addi	s0,sp,16
    80002f44:	00813403          	ld	s0,8(sp)
    80002f48:	00b53423          	sd	a1,8(a0)
    80002f4c:	00052023          	sw	zero,0(a0)
    80002f50:	00053823          	sd	zero,16(a0)
    80002f54:	01010113          	addi	sp,sp,16
    80002f58:	00008067          	ret

0000000080002f5c <acquire>:
    80002f5c:	fe010113          	addi	sp,sp,-32
    80002f60:	00813823          	sd	s0,16(sp)
    80002f64:	00913423          	sd	s1,8(sp)
    80002f68:	00113c23          	sd	ra,24(sp)
    80002f6c:	01213023          	sd	s2,0(sp)
    80002f70:	02010413          	addi	s0,sp,32
    80002f74:	00050493          	mv	s1,a0
    80002f78:	10002973          	csrr	s2,sstatus
    80002f7c:	100027f3          	csrr	a5,sstatus
    80002f80:	ffd7f793          	andi	a5,a5,-3
    80002f84:	10079073          	csrw	sstatus,a5
    80002f88:	fffff097          	auipc	ra,0xfffff
    80002f8c:	8e8080e7          	jalr	-1816(ra) # 80001870 <mycpu>
    80002f90:	07852783          	lw	a5,120(a0)
    80002f94:	06078e63          	beqz	a5,80003010 <acquire+0xb4>
    80002f98:	fffff097          	auipc	ra,0xfffff
    80002f9c:	8d8080e7          	jalr	-1832(ra) # 80001870 <mycpu>
    80002fa0:	07852783          	lw	a5,120(a0)
    80002fa4:	0004a703          	lw	a4,0(s1)
    80002fa8:	0017879b          	addiw	a5,a5,1
    80002fac:	06f52c23          	sw	a5,120(a0)
    80002fb0:	04071063          	bnez	a4,80002ff0 <acquire+0x94>
    80002fb4:	00100713          	li	a4,1
    80002fb8:	00070793          	mv	a5,a4
    80002fbc:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80002fc0:	0007879b          	sext.w	a5,a5
    80002fc4:	fe079ae3          	bnez	a5,80002fb8 <acquire+0x5c>
    80002fc8:	0ff0000f          	fence
    80002fcc:	fffff097          	auipc	ra,0xfffff
    80002fd0:	8a4080e7          	jalr	-1884(ra) # 80001870 <mycpu>
    80002fd4:	01813083          	ld	ra,24(sp)
    80002fd8:	01013403          	ld	s0,16(sp)
    80002fdc:	00a4b823          	sd	a0,16(s1)
    80002fe0:	00013903          	ld	s2,0(sp)
    80002fe4:	00813483          	ld	s1,8(sp)
    80002fe8:	02010113          	addi	sp,sp,32
    80002fec:	00008067          	ret
    80002ff0:	0104b903          	ld	s2,16(s1)
    80002ff4:	fffff097          	auipc	ra,0xfffff
    80002ff8:	87c080e7          	jalr	-1924(ra) # 80001870 <mycpu>
    80002ffc:	faa91ce3          	bne	s2,a0,80002fb4 <acquire+0x58>
    80003000:	00001517          	auipc	a0,0x1
    80003004:	19850513          	addi	a0,a0,408 # 80004198 <digits+0x20>
    80003008:	fffff097          	auipc	ra,0xfffff
    8000300c:	224080e7          	jalr	548(ra) # 8000222c <panic>
    80003010:	00195913          	srli	s2,s2,0x1
    80003014:	fffff097          	auipc	ra,0xfffff
    80003018:	85c080e7          	jalr	-1956(ra) # 80001870 <mycpu>
    8000301c:	00197913          	andi	s2,s2,1
    80003020:	07252e23          	sw	s2,124(a0)
    80003024:	f75ff06f          	j	80002f98 <acquire+0x3c>

0000000080003028 <release>:
    80003028:	fe010113          	addi	sp,sp,-32
    8000302c:	00813823          	sd	s0,16(sp)
    80003030:	00113c23          	sd	ra,24(sp)
    80003034:	00913423          	sd	s1,8(sp)
    80003038:	01213023          	sd	s2,0(sp)
    8000303c:	02010413          	addi	s0,sp,32
    80003040:	00052783          	lw	a5,0(a0)
    80003044:	00079a63          	bnez	a5,80003058 <release+0x30>
    80003048:	00001517          	auipc	a0,0x1
    8000304c:	15850513          	addi	a0,a0,344 # 800041a0 <digits+0x28>
    80003050:	fffff097          	auipc	ra,0xfffff
    80003054:	1dc080e7          	jalr	476(ra) # 8000222c <panic>
    80003058:	01053903          	ld	s2,16(a0)
    8000305c:	00050493          	mv	s1,a0
    80003060:	fffff097          	auipc	ra,0xfffff
    80003064:	810080e7          	jalr	-2032(ra) # 80001870 <mycpu>
    80003068:	fea910e3          	bne	s2,a0,80003048 <release+0x20>
    8000306c:	0004b823          	sd	zero,16(s1)
    80003070:	0ff0000f          	fence
    80003074:	0f50000f          	fence	iorw,ow
    80003078:	0804a02f          	amoswap.w	zero,zero,(s1)
    8000307c:	ffffe097          	auipc	ra,0xffffe
    80003080:	7f4080e7          	jalr	2036(ra) # 80001870 <mycpu>
    80003084:	100027f3          	csrr	a5,sstatus
    80003088:	0027f793          	andi	a5,a5,2
    8000308c:	04079a63          	bnez	a5,800030e0 <release+0xb8>
    80003090:	07852783          	lw	a5,120(a0)
    80003094:	02f05e63          	blez	a5,800030d0 <release+0xa8>
    80003098:	fff7871b          	addiw	a4,a5,-1
    8000309c:	06e52c23          	sw	a4,120(a0)
    800030a0:	00071c63          	bnez	a4,800030b8 <release+0x90>
    800030a4:	07c52783          	lw	a5,124(a0)
    800030a8:	00078863          	beqz	a5,800030b8 <release+0x90>
    800030ac:	100027f3          	csrr	a5,sstatus
    800030b0:	0027e793          	ori	a5,a5,2
    800030b4:	10079073          	csrw	sstatus,a5
    800030b8:	01813083          	ld	ra,24(sp)
    800030bc:	01013403          	ld	s0,16(sp)
    800030c0:	00813483          	ld	s1,8(sp)
    800030c4:	00013903          	ld	s2,0(sp)
    800030c8:	02010113          	addi	sp,sp,32
    800030cc:	00008067          	ret
    800030d0:	00001517          	auipc	a0,0x1
    800030d4:	0f050513          	addi	a0,a0,240 # 800041c0 <digits+0x48>
    800030d8:	fffff097          	auipc	ra,0xfffff
    800030dc:	154080e7          	jalr	340(ra) # 8000222c <panic>
    800030e0:	00001517          	auipc	a0,0x1
    800030e4:	0c850513          	addi	a0,a0,200 # 800041a8 <digits+0x30>
    800030e8:	fffff097          	auipc	ra,0xfffff
    800030ec:	144080e7          	jalr	324(ra) # 8000222c <panic>

00000000800030f0 <holding>:
    800030f0:	00052783          	lw	a5,0(a0)
    800030f4:	00079663          	bnez	a5,80003100 <holding+0x10>
    800030f8:	00000513          	li	a0,0
    800030fc:	00008067          	ret
    80003100:	fe010113          	addi	sp,sp,-32
    80003104:	00813823          	sd	s0,16(sp)
    80003108:	00913423          	sd	s1,8(sp)
    8000310c:	00113c23          	sd	ra,24(sp)
    80003110:	02010413          	addi	s0,sp,32
    80003114:	01053483          	ld	s1,16(a0)
    80003118:	ffffe097          	auipc	ra,0xffffe
    8000311c:	758080e7          	jalr	1880(ra) # 80001870 <mycpu>
    80003120:	01813083          	ld	ra,24(sp)
    80003124:	01013403          	ld	s0,16(sp)
    80003128:	40a48533          	sub	a0,s1,a0
    8000312c:	00153513          	seqz	a0,a0
    80003130:	00813483          	ld	s1,8(sp)
    80003134:	02010113          	addi	sp,sp,32
    80003138:	00008067          	ret

000000008000313c <push_off>:
    8000313c:	fe010113          	addi	sp,sp,-32
    80003140:	00813823          	sd	s0,16(sp)
    80003144:	00113c23          	sd	ra,24(sp)
    80003148:	00913423          	sd	s1,8(sp)
    8000314c:	02010413          	addi	s0,sp,32
    80003150:	100024f3          	csrr	s1,sstatus
    80003154:	100027f3          	csrr	a5,sstatus
    80003158:	ffd7f793          	andi	a5,a5,-3
    8000315c:	10079073          	csrw	sstatus,a5
    80003160:	ffffe097          	auipc	ra,0xffffe
    80003164:	710080e7          	jalr	1808(ra) # 80001870 <mycpu>
    80003168:	07852783          	lw	a5,120(a0)
    8000316c:	02078663          	beqz	a5,80003198 <push_off+0x5c>
    80003170:	ffffe097          	auipc	ra,0xffffe
    80003174:	700080e7          	jalr	1792(ra) # 80001870 <mycpu>
    80003178:	07852783          	lw	a5,120(a0)
    8000317c:	01813083          	ld	ra,24(sp)
    80003180:	01013403          	ld	s0,16(sp)
    80003184:	0017879b          	addiw	a5,a5,1
    80003188:	06f52c23          	sw	a5,120(a0)
    8000318c:	00813483          	ld	s1,8(sp)
    80003190:	02010113          	addi	sp,sp,32
    80003194:	00008067          	ret
    80003198:	0014d493          	srli	s1,s1,0x1
    8000319c:	ffffe097          	auipc	ra,0xffffe
    800031a0:	6d4080e7          	jalr	1748(ra) # 80001870 <mycpu>
    800031a4:	0014f493          	andi	s1,s1,1
    800031a8:	06952e23          	sw	s1,124(a0)
    800031ac:	fc5ff06f          	j	80003170 <push_off+0x34>

00000000800031b0 <pop_off>:
    800031b0:	ff010113          	addi	sp,sp,-16
    800031b4:	00813023          	sd	s0,0(sp)
    800031b8:	00113423          	sd	ra,8(sp)
    800031bc:	01010413          	addi	s0,sp,16
    800031c0:	ffffe097          	auipc	ra,0xffffe
    800031c4:	6b0080e7          	jalr	1712(ra) # 80001870 <mycpu>
    800031c8:	100027f3          	csrr	a5,sstatus
    800031cc:	0027f793          	andi	a5,a5,2
    800031d0:	04079663          	bnez	a5,8000321c <pop_off+0x6c>
    800031d4:	07852783          	lw	a5,120(a0)
    800031d8:	02f05a63          	blez	a5,8000320c <pop_off+0x5c>
    800031dc:	fff7871b          	addiw	a4,a5,-1
    800031e0:	06e52c23          	sw	a4,120(a0)
    800031e4:	00071c63          	bnez	a4,800031fc <pop_off+0x4c>
    800031e8:	07c52783          	lw	a5,124(a0)
    800031ec:	00078863          	beqz	a5,800031fc <pop_off+0x4c>
    800031f0:	100027f3          	csrr	a5,sstatus
    800031f4:	0027e793          	ori	a5,a5,2
    800031f8:	10079073          	csrw	sstatus,a5
    800031fc:	00813083          	ld	ra,8(sp)
    80003200:	00013403          	ld	s0,0(sp)
    80003204:	01010113          	addi	sp,sp,16
    80003208:	00008067          	ret
    8000320c:	00001517          	auipc	a0,0x1
    80003210:	fb450513          	addi	a0,a0,-76 # 800041c0 <digits+0x48>
    80003214:	fffff097          	auipc	ra,0xfffff
    80003218:	018080e7          	jalr	24(ra) # 8000222c <panic>
    8000321c:	00001517          	auipc	a0,0x1
    80003220:	f8c50513          	addi	a0,a0,-116 # 800041a8 <digits+0x30>
    80003224:	fffff097          	auipc	ra,0xfffff
    80003228:	008080e7          	jalr	8(ra) # 8000222c <panic>

000000008000322c <push_on>:
    8000322c:	fe010113          	addi	sp,sp,-32
    80003230:	00813823          	sd	s0,16(sp)
    80003234:	00113c23          	sd	ra,24(sp)
    80003238:	00913423          	sd	s1,8(sp)
    8000323c:	02010413          	addi	s0,sp,32
    80003240:	100024f3          	csrr	s1,sstatus
    80003244:	100027f3          	csrr	a5,sstatus
    80003248:	0027e793          	ori	a5,a5,2
    8000324c:	10079073          	csrw	sstatus,a5
    80003250:	ffffe097          	auipc	ra,0xffffe
    80003254:	620080e7          	jalr	1568(ra) # 80001870 <mycpu>
    80003258:	07852783          	lw	a5,120(a0)
    8000325c:	02078663          	beqz	a5,80003288 <push_on+0x5c>
    80003260:	ffffe097          	auipc	ra,0xffffe
    80003264:	610080e7          	jalr	1552(ra) # 80001870 <mycpu>
    80003268:	07852783          	lw	a5,120(a0)
    8000326c:	01813083          	ld	ra,24(sp)
    80003270:	01013403          	ld	s0,16(sp)
    80003274:	0017879b          	addiw	a5,a5,1
    80003278:	06f52c23          	sw	a5,120(a0)
    8000327c:	00813483          	ld	s1,8(sp)
    80003280:	02010113          	addi	sp,sp,32
    80003284:	00008067          	ret
    80003288:	0014d493          	srli	s1,s1,0x1
    8000328c:	ffffe097          	auipc	ra,0xffffe
    80003290:	5e4080e7          	jalr	1508(ra) # 80001870 <mycpu>
    80003294:	0014f493          	andi	s1,s1,1
    80003298:	06952e23          	sw	s1,124(a0)
    8000329c:	fc5ff06f          	j	80003260 <push_on+0x34>

00000000800032a0 <pop_on>:
    800032a0:	ff010113          	addi	sp,sp,-16
    800032a4:	00813023          	sd	s0,0(sp)
    800032a8:	00113423          	sd	ra,8(sp)
    800032ac:	01010413          	addi	s0,sp,16
    800032b0:	ffffe097          	auipc	ra,0xffffe
    800032b4:	5c0080e7          	jalr	1472(ra) # 80001870 <mycpu>
    800032b8:	100027f3          	csrr	a5,sstatus
    800032bc:	0027f793          	andi	a5,a5,2
    800032c0:	04078463          	beqz	a5,80003308 <pop_on+0x68>
    800032c4:	07852783          	lw	a5,120(a0)
    800032c8:	02f05863          	blez	a5,800032f8 <pop_on+0x58>
    800032cc:	fff7879b          	addiw	a5,a5,-1
    800032d0:	06f52c23          	sw	a5,120(a0)
    800032d4:	07853783          	ld	a5,120(a0)
    800032d8:	00079863          	bnez	a5,800032e8 <pop_on+0x48>
    800032dc:	100027f3          	csrr	a5,sstatus
    800032e0:	ffd7f793          	andi	a5,a5,-3
    800032e4:	10079073          	csrw	sstatus,a5
    800032e8:	00813083          	ld	ra,8(sp)
    800032ec:	00013403          	ld	s0,0(sp)
    800032f0:	01010113          	addi	sp,sp,16
    800032f4:	00008067          	ret
    800032f8:	00001517          	auipc	a0,0x1
    800032fc:	ef050513          	addi	a0,a0,-272 # 800041e8 <digits+0x70>
    80003300:	fffff097          	auipc	ra,0xfffff
    80003304:	f2c080e7          	jalr	-212(ra) # 8000222c <panic>
    80003308:	00001517          	auipc	a0,0x1
    8000330c:	ec050513          	addi	a0,a0,-320 # 800041c8 <digits+0x50>
    80003310:	fffff097          	auipc	ra,0xfffff
    80003314:	f1c080e7          	jalr	-228(ra) # 8000222c <panic>

0000000080003318 <__memset>:
    80003318:	ff010113          	addi	sp,sp,-16
    8000331c:	00813423          	sd	s0,8(sp)
    80003320:	01010413          	addi	s0,sp,16
    80003324:	1a060e63          	beqz	a2,800034e0 <__memset+0x1c8>
    80003328:	40a007b3          	neg	a5,a0
    8000332c:	0077f793          	andi	a5,a5,7
    80003330:	00778693          	addi	a3,a5,7
    80003334:	00b00813          	li	a6,11
    80003338:	0ff5f593          	andi	a1,a1,255
    8000333c:	fff6071b          	addiw	a4,a2,-1
    80003340:	1b06e663          	bltu	a3,a6,800034ec <__memset+0x1d4>
    80003344:	1cd76463          	bltu	a4,a3,8000350c <__memset+0x1f4>
    80003348:	1a078e63          	beqz	a5,80003504 <__memset+0x1ec>
    8000334c:	00b50023          	sb	a1,0(a0)
    80003350:	00100713          	li	a4,1
    80003354:	1ae78463          	beq	a5,a4,800034fc <__memset+0x1e4>
    80003358:	00b500a3          	sb	a1,1(a0)
    8000335c:	00200713          	li	a4,2
    80003360:	1ae78a63          	beq	a5,a4,80003514 <__memset+0x1fc>
    80003364:	00b50123          	sb	a1,2(a0)
    80003368:	00300713          	li	a4,3
    8000336c:	18e78463          	beq	a5,a4,800034f4 <__memset+0x1dc>
    80003370:	00b501a3          	sb	a1,3(a0)
    80003374:	00400713          	li	a4,4
    80003378:	1ae78263          	beq	a5,a4,8000351c <__memset+0x204>
    8000337c:	00b50223          	sb	a1,4(a0)
    80003380:	00500713          	li	a4,5
    80003384:	1ae78063          	beq	a5,a4,80003524 <__memset+0x20c>
    80003388:	00b502a3          	sb	a1,5(a0)
    8000338c:	00700713          	li	a4,7
    80003390:	18e79e63          	bne	a5,a4,8000352c <__memset+0x214>
    80003394:	00b50323          	sb	a1,6(a0)
    80003398:	00700e93          	li	t4,7
    8000339c:	00859713          	slli	a4,a1,0x8
    800033a0:	00e5e733          	or	a4,a1,a4
    800033a4:	01059e13          	slli	t3,a1,0x10
    800033a8:	01c76e33          	or	t3,a4,t3
    800033ac:	01859313          	slli	t1,a1,0x18
    800033b0:	006e6333          	or	t1,t3,t1
    800033b4:	02059893          	slli	a7,a1,0x20
    800033b8:	40f60e3b          	subw	t3,a2,a5
    800033bc:	011368b3          	or	a7,t1,a7
    800033c0:	02859813          	slli	a6,a1,0x28
    800033c4:	0108e833          	or	a6,a7,a6
    800033c8:	03059693          	slli	a3,a1,0x30
    800033cc:	003e589b          	srliw	a7,t3,0x3
    800033d0:	00d866b3          	or	a3,a6,a3
    800033d4:	03859713          	slli	a4,a1,0x38
    800033d8:	00389813          	slli	a6,a7,0x3
    800033dc:	00f507b3          	add	a5,a0,a5
    800033e0:	00e6e733          	or	a4,a3,a4
    800033e4:	000e089b          	sext.w	a7,t3
    800033e8:	00f806b3          	add	a3,a6,a5
    800033ec:	00e7b023          	sd	a4,0(a5)
    800033f0:	00878793          	addi	a5,a5,8
    800033f4:	fed79ce3          	bne	a5,a3,800033ec <__memset+0xd4>
    800033f8:	ff8e7793          	andi	a5,t3,-8
    800033fc:	0007871b          	sext.w	a4,a5
    80003400:	01d787bb          	addw	a5,a5,t4
    80003404:	0ce88e63          	beq	a7,a4,800034e0 <__memset+0x1c8>
    80003408:	00f50733          	add	a4,a0,a5
    8000340c:	00b70023          	sb	a1,0(a4)
    80003410:	0017871b          	addiw	a4,a5,1
    80003414:	0cc77663          	bgeu	a4,a2,800034e0 <__memset+0x1c8>
    80003418:	00e50733          	add	a4,a0,a4
    8000341c:	00b70023          	sb	a1,0(a4)
    80003420:	0027871b          	addiw	a4,a5,2
    80003424:	0ac77e63          	bgeu	a4,a2,800034e0 <__memset+0x1c8>
    80003428:	00e50733          	add	a4,a0,a4
    8000342c:	00b70023          	sb	a1,0(a4)
    80003430:	0037871b          	addiw	a4,a5,3
    80003434:	0ac77663          	bgeu	a4,a2,800034e0 <__memset+0x1c8>
    80003438:	00e50733          	add	a4,a0,a4
    8000343c:	00b70023          	sb	a1,0(a4)
    80003440:	0047871b          	addiw	a4,a5,4
    80003444:	08c77e63          	bgeu	a4,a2,800034e0 <__memset+0x1c8>
    80003448:	00e50733          	add	a4,a0,a4
    8000344c:	00b70023          	sb	a1,0(a4)
    80003450:	0057871b          	addiw	a4,a5,5
    80003454:	08c77663          	bgeu	a4,a2,800034e0 <__memset+0x1c8>
    80003458:	00e50733          	add	a4,a0,a4
    8000345c:	00b70023          	sb	a1,0(a4)
    80003460:	0067871b          	addiw	a4,a5,6
    80003464:	06c77e63          	bgeu	a4,a2,800034e0 <__memset+0x1c8>
    80003468:	00e50733          	add	a4,a0,a4
    8000346c:	00b70023          	sb	a1,0(a4)
    80003470:	0077871b          	addiw	a4,a5,7
    80003474:	06c77663          	bgeu	a4,a2,800034e0 <__memset+0x1c8>
    80003478:	00e50733          	add	a4,a0,a4
    8000347c:	00b70023          	sb	a1,0(a4)
    80003480:	0087871b          	addiw	a4,a5,8
    80003484:	04c77e63          	bgeu	a4,a2,800034e0 <__memset+0x1c8>
    80003488:	00e50733          	add	a4,a0,a4
    8000348c:	00b70023          	sb	a1,0(a4)
    80003490:	0097871b          	addiw	a4,a5,9
    80003494:	04c77663          	bgeu	a4,a2,800034e0 <__memset+0x1c8>
    80003498:	00e50733          	add	a4,a0,a4
    8000349c:	00b70023          	sb	a1,0(a4)
    800034a0:	00a7871b          	addiw	a4,a5,10
    800034a4:	02c77e63          	bgeu	a4,a2,800034e0 <__memset+0x1c8>
    800034a8:	00e50733          	add	a4,a0,a4
    800034ac:	00b70023          	sb	a1,0(a4)
    800034b0:	00b7871b          	addiw	a4,a5,11
    800034b4:	02c77663          	bgeu	a4,a2,800034e0 <__memset+0x1c8>
    800034b8:	00e50733          	add	a4,a0,a4
    800034bc:	00b70023          	sb	a1,0(a4)
    800034c0:	00c7871b          	addiw	a4,a5,12
    800034c4:	00c77e63          	bgeu	a4,a2,800034e0 <__memset+0x1c8>
    800034c8:	00e50733          	add	a4,a0,a4
    800034cc:	00b70023          	sb	a1,0(a4)
    800034d0:	00d7879b          	addiw	a5,a5,13
    800034d4:	00c7f663          	bgeu	a5,a2,800034e0 <__memset+0x1c8>
    800034d8:	00f507b3          	add	a5,a0,a5
    800034dc:	00b78023          	sb	a1,0(a5)
    800034e0:	00813403          	ld	s0,8(sp)
    800034e4:	01010113          	addi	sp,sp,16
    800034e8:	00008067          	ret
    800034ec:	00b00693          	li	a3,11
    800034f0:	e55ff06f          	j	80003344 <__memset+0x2c>
    800034f4:	00300e93          	li	t4,3
    800034f8:	ea5ff06f          	j	8000339c <__memset+0x84>
    800034fc:	00100e93          	li	t4,1
    80003500:	e9dff06f          	j	8000339c <__memset+0x84>
    80003504:	00000e93          	li	t4,0
    80003508:	e95ff06f          	j	8000339c <__memset+0x84>
    8000350c:	00000793          	li	a5,0
    80003510:	ef9ff06f          	j	80003408 <__memset+0xf0>
    80003514:	00200e93          	li	t4,2
    80003518:	e85ff06f          	j	8000339c <__memset+0x84>
    8000351c:	00400e93          	li	t4,4
    80003520:	e7dff06f          	j	8000339c <__memset+0x84>
    80003524:	00500e93          	li	t4,5
    80003528:	e75ff06f          	j	8000339c <__memset+0x84>
    8000352c:	00600e93          	li	t4,6
    80003530:	e6dff06f          	j	8000339c <__memset+0x84>

0000000080003534 <__memmove>:
    80003534:	ff010113          	addi	sp,sp,-16
    80003538:	00813423          	sd	s0,8(sp)
    8000353c:	01010413          	addi	s0,sp,16
    80003540:	0e060863          	beqz	a2,80003630 <__memmove+0xfc>
    80003544:	fff6069b          	addiw	a3,a2,-1
    80003548:	0006881b          	sext.w	a6,a3
    8000354c:	0ea5e863          	bltu	a1,a0,8000363c <__memmove+0x108>
    80003550:	00758713          	addi	a4,a1,7
    80003554:	00a5e7b3          	or	a5,a1,a0
    80003558:	40a70733          	sub	a4,a4,a0
    8000355c:	0077f793          	andi	a5,a5,7
    80003560:	00f73713          	sltiu	a4,a4,15
    80003564:	00174713          	xori	a4,a4,1
    80003568:	0017b793          	seqz	a5,a5
    8000356c:	00e7f7b3          	and	a5,a5,a4
    80003570:	10078863          	beqz	a5,80003680 <__memmove+0x14c>
    80003574:	00900793          	li	a5,9
    80003578:	1107f463          	bgeu	a5,a6,80003680 <__memmove+0x14c>
    8000357c:	0036581b          	srliw	a6,a2,0x3
    80003580:	fff8081b          	addiw	a6,a6,-1
    80003584:	02081813          	slli	a6,a6,0x20
    80003588:	01d85893          	srli	a7,a6,0x1d
    8000358c:	00858813          	addi	a6,a1,8
    80003590:	00058793          	mv	a5,a1
    80003594:	00050713          	mv	a4,a0
    80003598:	01088833          	add	a6,a7,a6
    8000359c:	0007b883          	ld	a7,0(a5)
    800035a0:	00878793          	addi	a5,a5,8
    800035a4:	00870713          	addi	a4,a4,8
    800035a8:	ff173c23          	sd	a7,-8(a4)
    800035ac:	ff0798e3          	bne	a5,a6,8000359c <__memmove+0x68>
    800035b0:	ff867713          	andi	a4,a2,-8
    800035b4:	02071793          	slli	a5,a4,0x20
    800035b8:	0207d793          	srli	a5,a5,0x20
    800035bc:	00f585b3          	add	a1,a1,a5
    800035c0:	40e686bb          	subw	a3,a3,a4
    800035c4:	00f507b3          	add	a5,a0,a5
    800035c8:	06e60463          	beq	a2,a4,80003630 <__memmove+0xfc>
    800035cc:	0005c703          	lbu	a4,0(a1)
    800035d0:	00e78023          	sb	a4,0(a5)
    800035d4:	04068e63          	beqz	a3,80003630 <__memmove+0xfc>
    800035d8:	0015c603          	lbu	a2,1(a1)
    800035dc:	00100713          	li	a4,1
    800035e0:	00c780a3          	sb	a2,1(a5)
    800035e4:	04e68663          	beq	a3,a4,80003630 <__memmove+0xfc>
    800035e8:	0025c603          	lbu	a2,2(a1)
    800035ec:	00200713          	li	a4,2
    800035f0:	00c78123          	sb	a2,2(a5)
    800035f4:	02e68e63          	beq	a3,a4,80003630 <__memmove+0xfc>
    800035f8:	0035c603          	lbu	a2,3(a1)
    800035fc:	00300713          	li	a4,3
    80003600:	00c781a3          	sb	a2,3(a5)
    80003604:	02e68663          	beq	a3,a4,80003630 <__memmove+0xfc>
    80003608:	0045c603          	lbu	a2,4(a1)
    8000360c:	00400713          	li	a4,4
    80003610:	00c78223          	sb	a2,4(a5)
    80003614:	00e68e63          	beq	a3,a4,80003630 <__memmove+0xfc>
    80003618:	0055c603          	lbu	a2,5(a1)
    8000361c:	00500713          	li	a4,5
    80003620:	00c782a3          	sb	a2,5(a5)
    80003624:	00e68663          	beq	a3,a4,80003630 <__memmove+0xfc>
    80003628:	0065c703          	lbu	a4,6(a1)
    8000362c:	00e78323          	sb	a4,6(a5)
    80003630:	00813403          	ld	s0,8(sp)
    80003634:	01010113          	addi	sp,sp,16
    80003638:	00008067          	ret
    8000363c:	02061713          	slli	a4,a2,0x20
    80003640:	02075713          	srli	a4,a4,0x20
    80003644:	00e587b3          	add	a5,a1,a4
    80003648:	f0f574e3          	bgeu	a0,a5,80003550 <__memmove+0x1c>
    8000364c:	02069613          	slli	a2,a3,0x20
    80003650:	02065613          	srli	a2,a2,0x20
    80003654:	fff64613          	not	a2,a2
    80003658:	00e50733          	add	a4,a0,a4
    8000365c:	00c78633          	add	a2,a5,a2
    80003660:	fff7c683          	lbu	a3,-1(a5)
    80003664:	fff78793          	addi	a5,a5,-1
    80003668:	fff70713          	addi	a4,a4,-1
    8000366c:	00d70023          	sb	a3,0(a4)
    80003670:	fec798e3          	bne	a5,a2,80003660 <__memmove+0x12c>
    80003674:	00813403          	ld	s0,8(sp)
    80003678:	01010113          	addi	sp,sp,16
    8000367c:	00008067          	ret
    80003680:	02069713          	slli	a4,a3,0x20
    80003684:	02075713          	srli	a4,a4,0x20
    80003688:	00170713          	addi	a4,a4,1
    8000368c:	00e50733          	add	a4,a0,a4
    80003690:	00050793          	mv	a5,a0
    80003694:	0005c683          	lbu	a3,0(a1)
    80003698:	00178793          	addi	a5,a5,1
    8000369c:	00158593          	addi	a1,a1,1
    800036a0:	fed78fa3          	sb	a3,-1(a5)
    800036a4:	fee798e3          	bne	a5,a4,80003694 <__memmove+0x160>
    800036a8:	f89ff06f          	j	80003630 <__memmove+0xfc>
	...
