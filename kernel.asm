
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00004117          	auipc	sp,0x4
    80000004:	6a013103          	ld	sp,1696(sp) # 800046a0 <_GLOBAL_OFFSET_TABLE_+0x10>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	2bd010ef          	jal	ra,80001ad8 <start>

0000000080000020 <spin>:
    80000020:	0000006f          	j	80000020 <spin>
	...

0000000080001000 <system_call>:
.global system_call
.type system_call, @function
system_call:
    addi t0, a0, 0x0
    80001000:	00050293          	mv	t0,a0
    ld a0, 0x0(t0)
    80001004:	0002b503          	ld	a0,0(t0)
    ld a1, 0x8(t0)
    80001008:	0082b583          	ld	a1,8(t0)
    ld a2, 0x10(t0)
    8000100c:	0102b603          	ld	a2,16(t0)
    ld a3, 0x18(t0)
    80001010:	0182b683          	ld	a3,24(t0)
    ld a4, 0x20(t0)
    80001014:	0202b703          	ld	a4,32(t0)
    ld a5, 0x28(t0)
    80001018:	0282b783          	ld	a5,40(t0)
    ld a6, 0x30(t0)
    8000101c:	0302b803          	ld	a6,48(t0)
    ld a7, 0x38(t0)
    80001020:	0382b883          	ld	a7,56(t0)
    ecall
    80001024:	00000073          	ecall
    ret
    80001028:	00008067          	ret
    8000102c:	0000                	unimp
	...

0000000080001030 <interrupt_trap>:
.extern _ZN6Kernel16interruptHandlerEv
.align 4
.global interrupt_trap
.type interrupt_trap, @function
interrupt_trap:
    addi sp, sp, -256
    80001030:	f0010113          	addi	sp,sp,-256
    .irp index, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31
    sd x\index, \index * 8(sp)
    .endr
    80001034:	00013023          	sd	zero,0(sp)
    80001038:	00113423          	sd	ra,8(sp)
    8000103c:	00213823          	sd	sp,16(sp)
    80001040:	00313c23          	sd	gp,24(sp)
    80001044:	02413023          	sd	tp,32(sp)
    80001048:	02513423          	sd	t0,40(sp)
    8000104c:	02613823          	sd	t1,48(sp)
    80001050:	02713c23          	sd	t2,56(sp)
    80001054:	04813023          	sd	s0,64(sp)
    80001058:	04913423          	sd	s1,72(sp)
    8000105c:	04a13823          	sd	a0,80(sp)
    80001060:	04b13c23          	sd	a1,88(sp)
    80001064:	06c13023          	sd	a2,96(sp)
    80001068:	06d13423          	sd	a3,104(sp)
    8000106c:	06e13823          	sd	a4,112(sp)
    80001070:	06f13c23          	sd	a5,120(sp)
    80001074:	09013023          	sd	a6,128(sp)
    80001078:	09113423          	sd	a7,136(sp)
    8000107c:	09213823          	sd	s2,144(sp)
    80001080:	09313c23          	sd	s3,152(sp)
    80001084:	0b413023          	sd	s4,160(sp)
    80001088:	0b513423          	sd	s5,168(sp)
    8000108c:	0b613823          	sd	s6,176(sp)
    80001090:	0b713c23          	sd	s7,184(sp)
    80001094:	0d813023          	sd	s8,192(sp)
    80001098:	0d913423          	sd	s9,200(sp)
    8000109c:	0da13823          	sd	s10,208(sp)
    800010a0:	0db13c23          	sd	s11,216(sp)
    800010a4:	0fc13023          	sd	t3,224(sp)
    800010a8:	0fd13423          	sd	t4,232(sp)
    800010ac:	0fe13823          	sd	t5,240(sp)
    800010b0:	0ff13c23          	sd	t6,248(sp)

    addi s0, sp, 0
    800010b4:	00010413          	mv	s0,sp
    call _ZN6Kernel16interruptHandlerEv
    800010b8:	075000ef          	jal	ra,8000192c <_ZN6Kernel16interruptHandlerEv>

    .irp index, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31
    ld x\index, \index * 8(sp)
    .endr
    800010bc:	00013003          	ld	zero,0(sp)
    800010c0:	00813083          	ld	ra,8(sp)
    800010c4:	01013103          	ld	sp,16(sp)
    800010c8:	01813183          	ld	gp,24(sp)
    800010cc:	02013203          	ld	tp,32(sp)
    800010d0:	02813283          	ld	t0,40(sp)
    800010d4:	03013303          	ld	t1,48(sp)
    800010d8:	03813383          	ld	t2,56(sp)
    800010dc:	04013403          	ld	s0,64(sp)
    800010e0:	04813483          	ld	s1,72(sp)
    800010e4:	05013503          	ld	a0,80(sp)
    800010e8:	05813583          	ld	a1,88(sp)
    800010ec:	06013603          	ld	a2,96(sp)
    800010f0:	06813683          	ld	a3,104(sp)
    800010f4:	07013703          	ld	a4,112(sp)
    800010f8:	07813783          	ld	a5,120(sp)
    800010fc:	08013803          	ld	a6,128(sp)
    80001100:	08813883          	ld	a7,136(sp)
    80001104:	09013903          	ld	s2,144(sp)
    80001108:	09813983          	ld	s3,152(sp)
    8000110c:	0a013a03          	ld	s4,160(sp)
    80001110:	0a813a83          	ld	s5,168(sp)
    80001114:	0b013b03          	ld	s6,176(sp)
    80001118:	0b813b83          	ld	s7,184(sp)
    8000111c:	0c013c03          	ld	s8,192(sp)
    80001120:	0c813c83          	ld	s9,200(sp)
    80001124:	0d013d03          	ld	s10,208(sp)
    80001128:	0d813d83          	ld	s11,216(sp)
    8000112c:	0e013e03          	ld	t3,224(sp)
    80001130:	0e813e83          	ld	t4,232(sp)
    80001134:	0f013f03          	ld	t5,240(sp)
    80001138:	0f813f83          	ld	t6,248(sp)
    addi sp, sp, 256
    8000113c:	10010113          	addi	sp,sp,256
    80001140:	10200073          	sret
	...

0000000080001150 <_Z9mem_allocm>:


extern "C" uint64 system_call(Arguments* arg);

void* mem_alloc(size_t size)
{
    80001150:	fa010113          	addi	sp,sp,-96
    80001154:	04113c23          	sd	ra,88(sp)
    80001158:	04813823          	sd	s0,80(sp)
    8000115c:	04913423          	sd	s1,72(sp)
    80001160:	05213023          	sd	s2,64(sp)
    80001164:	06010413          	addi	s0,sp,96
    80001168:	00050493          	mv	s1,a0
    uint64 size_of_blocks = (size + MemoryAllocator::getSizeOfMetaData()) / MEM_BLOCK_SIZE;
    8000116c:	00000097          	auipc	ra,0x0
    80001170:	650080e7          	jalr	1616(ra) # 800017bc <_ZN15MemoryAllocator17getSizeOfMetaDataEv>
    80001174:	00950933          	add	s2,a0,s1
    80001178:	00695913          	srli	s2,s2,0x6
    size_of_blocks += (size + MemoryAllocator::getSizeOfMetaData()) % MEM_BLOCK_SIZE ? 1: 0;
    8000117c:	00000097          	auipc	ra,0x0
    80001180:	640080e7          	jalr	1600(ra) # 800017bc <_ZN15MemoryAllocator17getSizeOfMetaDataEv>
    80001184:	00a484b3          	add	s1,s1,a0
    80001188:	03f4f493          	andi	s1,s1,63
    8000118c:	04048a63          	beqz	s1,800011e0 <_Z9mem_allocm+0x90>
    80001190:	00100513          	li	a0,1
    80001194:	01250933          	add	s2,a0,s2
    Arguments arg = {Kernel::MEM_ALLOC, size_of_blocks, 0, 0, 0, 0, 0, 0};
    80001198:	fa043823          	sd	zero,-80(s0)
    8000119c:	fa043c23          	sd	zero,-72(s0)
    800011a0:	fc043023          	sd	zero,-64(s0)
    800011a4:	fc043423          	sd	zero,-56(s0)
    800011a8:	fc043823          	sd	zero,-48(s0)
    800011ac:	fc043c23          	sd	zero,-40(s0)
    800011b0:	00100793          	li	a5,1
    800011b4:	faf43023          	sd	a5,-96(s0)
    800011b8:	fb243423          	sd	s2,-88(s0)
    return (void*) system_call(&arg);
    800011bc:	fa040513          	addi	a0,s0,-96
    800011c0:	00000097          	auipc	ra,0x0
    800011c4:	e40080e7          	jalr	-448(ra) # 80001000 <system_call>
}
    800011c8:	05813083          	ld	ra,88(sp)
    800011cc:	05013403          	ld	s0,80(sp)
    800011d0:	04813483          	ld	s1,72(sp)
    800011d4:	04013903          	ld	s2,64(sp)
    800011d8:	06010113          	addi	sp,sp,96
    800011dc:	00008067          	ret
    size_of_blocks += (size + MemoryAllocator::getSizeOfMetaData()) % MEM_BLOCK_SIZE ? 1: 0;
    800011e0:	00000513          	li	a0,0
    800011e4:	fb1ff06f          	j	80001194 <_Z9mem_allocm+0x44>

00000000800011e8 <_Z8mem_freePv>:

int mem_free(void* obj)
{   Arguments arg = {Kernel::MEM_FREE, (uint64)obj, 0, 0, 0, 0, 0, 0};
    800011e8:	fb010113          	addi	sp,sp,-80
    800011ec:	04113423          	sd	ra,72(sp)
    800011f0:	04813023          	sd	s0,64(sp)
    800011f4:	05010413          	addi	s0,sp,80
    800011f8:	fc043023          	sd	zero,-64(s0)
    800011fc:	fc043423          	sd	zero,-56(s0)
    80001200:	fc043823          	sd	zero,-48(s0)
    80001204:	fc043c23          	sd	zero,-40(s0)
    80001208:	fe043023          	sd	zero,-32(s0)
    8000120c:	fe043423          	sd	zero,-24(s0)
    80001210:	00200793          	li	a5,2
    80001214:	faf43823          	sd	a5,-80(s0)
    80001218:	faa43c23          	sd	a0,-72(s0)
    return (int) system_call(&arg);
    8000121c:	fb040513          	addi	a0,s0,-80
    80001220:	00000097          	auipc	ra,0x0
    80001224:	de0080e7          	jalr	-544(ra) # 80001000 <system_call>
}
    80001228:	0005051b          	sext.w	a0,a0
    8000122c:	04813083          	ld	ra,72(sp)
    80001230:	04013403          	ld	s0,64(sp)
    80001234:	05010113          	addi	sp,sp,80
    80001238:	00008067          	ret

000000008000123c <_Z18mem_get_free_spacev>:

size_t mem_get_free_space()
{
    8000123c:	fb010113          	addi	sp,sp,-80
    80001240:	04113423          	sd	ra,72(sp)
    80001244:	04813023          	sd	s0,64(sp)
    80001248:	05010413          	addi	s0,sp,80
    Arguments arg = {Kernel::MEM_FREE_SPACE, 0, 0, 0, 0, 0, 0, 0};
    8000124c:	00300793          	li	a5,3
    80001250:	faf43823          	sd	a5,-80(s0)
    80001254:	fa043c23          	sd	zero,-72(s0)
    80001258:	fc043023          	sd	zero,-64(s0)
    8000125c:	fc043423          	sd	zero,-56(s0)
    80001260:	fc043823          	sd	zero,-48(s0)
    80001264:	fc043c23          	sd	zero,-40(s0)
    80001268:	fe043023          	sd	zero,-32(s0)
    8000126c:	fe043423          	sd	zero,-24(s0)
    return (size_t) system_call(&arg);
    80001270:	fb040513          	addi	a0,s0,-80
    80001274:	00000097          	auipc	ra,0x0
    80001278:	d8c080e7          	jalr	-628(ra) # 80001000 <system_call>
}
    8000127c:	04813083          	ld	ra,72(sp)
    80001280:	04013403          	ld	s0,64(sp)
    80001284:	05010113          	addi	sp,sp,80
    80001288:	00008067          	ret

000000008000128c <_Z26mem_get_largest_free_blockv>:
size_t mem_get_largest_free_block()
{
    8000128c:	fb010113          	addi	sp,sp,-80
    80001290:	04113423          	sd	ra,72(sp)
    80001294:	04813023          	sd	s0,64(sp)
    80001298:	05010413          	addi	s0,sp,80
    Arguments arg = {Kernel::LARGEST_FREE_BLOCK, 0, 0, 0, 0, 0, 0, 0};
    8000129c:	00400793          	li	a5,4
    800012a0:	faf43823          	sd	a5,-80(s0)
    800012a4:	fa043c23          	sd	zero,-72(s0)
    800012a8:	fc043023          	sd	zero,-64(s0)
    800012ac:	fc043423          	sd	zero,-56(s0)
    800012b0:	fc043823          	sd	zero,-48(s0)
    800012b4:	fc043c23          	sd	zero,-40(s0)
    800012b8:	fe043023          	sd	zero,-32(s0)
    800012bc:	fe043423          	sd	zero,-24(s0)
    return (size_t) system_call(&arg);
    800012c0:	fb040513          	addi	a0,s0,-80
    800012c4:	00000097          	auipc	ra,0x0
    800012c8:	d3c080e7          	jalr	-708(ra) # 80001000 <system_call>
}
    800012cc:	04813083          	ld	ra,72(sp)
    800012d0:	04013403          	ld	s0,64(sp)
    800012d4:	05010113          	addi	sp,sp,80
    800012d8:	00008067          	ret

00000000800012dc <main>:
// Created by os on 11/29/25.
//
#include "../h/MemoryAllocator.hpp"
#include "../h/Kernel.hpp"
#include "../h/syscall_c.hpp"
void main(){
    800012dc:	ff010113          	addi	sp,sp,-16
    800012e0:	00813423          	sd	s0,8(sp)
    800012e4:	01010413          	addi	s0,sp,16
////    __asm__ volatile ("ecall");
//    void* allocMem1 = mem_alloc(100);
//    mem_free(allocMem1);
//    void* allocMem2 = mem_alloc(10);
//    mem_free(allocMem2);
    800012e8:	00813403          	ld	s0,8(sp)
    800012ec:	01010113          	addi	sp,sp,16
    800012f0:	00008067          	ret

00000000800012f4 <_ZN3TCB16initializeThreadEPFvPvES0_P10ObjectPoolIS_Lm20EE>:

#include "../h/TCB.hpp"
const size_t TCB::DEFAULT_SYSTEM_STACK_SIZE = 1024;

void TCB::initializeThread(TCB::Body function, void *allocatedStack, ObjectPool<TCB, KernelConfig::NUM_OF_THREADS_IN_POOL> *pool)
{
    800012f4:	fe010113          	addi	sp,sp,-32
    800012f8:	00113c23          	sd	ra,24(sp)
    800012fc:	00813823          	sd	s0,16(sp)
    80001300:	00913423          	sd	s1,8(sp)
    80001304:	02010413          	addi	s0,sp,32
    80001308:	00050493          	mv	s1,a0
    body = function;
    8000130c:	00b53023          	sd	a1,0(a0) # 1000 <_entry-0x7ffff000>
    stack = (uint64*)allocatedStack;
    80001310:	02c53823          	sd	a2,48(a0)
    timeSlice = DEFAULT_TIME_SLICE;
    80001314:	00200793          	li	a5,2
    80001318:	02f53423          	sd	a5,40(a0)
    state = nullptr;
    8000131c:	04053023          	sd	zero,64(a0)
    isFinished = false;
    80001320:	04050423          	sb	zero,72(a0)
    size_t sizeOfStack = sizeof(uint64) * DEFAULT_SYSTEM_STACK_SIZE / MEM_BLOCK_SIZE;
    sizeOfStack += sizeOfStack % MEM_BLOCK_SIZE ? 1 : 0;
    systemStack = (uint64*)MemoryAllocator::allocateMemory(sizeOfStack);
    80001324:	08000513          	li	a0,128
    80001328:	00000097          	auipc	ra,0x0
    8000132c:	1e8080e7          	jalr	488(ra) # 80001510 <_ZN15MemoryAllocator14allocateMemoryEm>
    80001330:	02a4bc23          	sd	a0,56(s1)
    context = {(uint64) &body, (uint64) &stack[DEFAULT_STACK_SIZE], (uint64) &systemStack[DEFAULT_SYSTEM_STACK_SIZE]};
    80001334:	0304b783          	ld	a5,48(s1)
    80001338:	00008737          	lui	a4,0x8
    8000133c:	00e787b3          	add	a5,a5,a4
    80001340:	00002737          	lui	a4,0x2
    80001344:	00e50533          	add	a0,a0,a4
    80001348:	0094b423          	sd	s1,8(s1)
    8000134c:	00f4b823          	sd	a5,16(s1)
    80001350:	00a4bc23          	sd	a0,24(s1)
    80001354:	01813083          	ld	ra,24(sp)
    80001358:	01013403          	ld	s0,16(sp)
    8000135c:	00813483          	ld	s1,8(sp)
    80001360:	02010113          	addi	sp,sp,32
    80001364:	00008067          	ret

0000000080001368 <_ZN15MemoryAllocator16initializeMemoryEv>:
size_t MemoryAllocator::NUM_OF_BLOCKS = 0;
size_t MemoryAllocator::numOfFreeBlocks = 0;
MemoryAllocator::FreeBlock* MemoryAllocator::firstFreeBlock = nullptr;

void MemoryAllocator::initializeMemory()
{
    80001368:	ff010113          	addi	sp,sp,-16
    8000136c:	00813423          	sd	s0,8(sp)
    80001370:	01010413          	addi	s0,sp,16

    NUM_OF_BLOCKS = ((uint8*)HEAP_END_ADDR - (uint8*)HEAP_START_ADDR) / MEM_BLOCK_SIZE;
    80001374:	00003797          	auipc	a5,0x3
    80001378:	33c7b783          	ld	a5,828(a5) # 800046b0 <_GLOBAL_OFFSET_TABLE_+0x20>
    8000137c:	0007b703          	ld	a4,0(a5)
    80001380:	00003797          	auipc	a5,0x3
    80001384:	3187b783          	ld	a5,792(a5) # 80004698 <_GLOBAL_OFFSET_TABLE_+0x8>
    80001388:	0007b683          	ld	a3,0(a5)
    8000138c:	40d70733          	sub	a4,a4,a3
    80001390:	00675713          	srli	a4,a4,0x6
    80001394:	00003797          	auipc	a5,0x3
    80001398:	36c78793          	addi	a5,a5,876 # 80004700 <_ZN15MemoryAllocator13NUM_OF_BLOCKSE>
    8000139c:	00e7b023          	sd	a4,0(a5)
    numOfFreeBlocks = NUM_OF_BLOCKS;
    800013a0:	00e7b423          	sd	a4,8(a5)

    firstFreeBlock = (FreeBlock*)(HEAP_START_ADDR);
    800013a4:	00d7b823          	sd	a3,16(a5)

    firstFreeBlock->flagFree = true;
    800013a8:	00100613          	li	a2,1
    800013ac:	00c68023          	sb	a2,0(a3)
    firstFreeBlock->numOfBlocks = NUM_OF_BLOCKS;
    800013b0:	0107b703          	ld	a4,16(a5)
    800013b4:	0007b683          	ld	a3,0(a5)
    800013b8:	00d73423          	sd	a3,8(a4) # 2008 <_entry-0x7fffdff8>
    firstFreeBlock->nextBlock = nullptr;
    800013bc:	00073823          	sd	zero,16(a4)
    firstFreeBlock->previousBlock = nullptr;
    800013c0:	00073c23          	sd	zero,24(a4)
    flagSystemInitialize = 1;
    800013c4:	00c78c23          	sb	a2,24(a5)
}
    800013c8:	00813403          	ld	s0,8(sp)
    800013cc:	01010113          	addi	sp,sp,16
    800013d0:	00008067          	ret

00000000800013d4 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m>:
    occupiedBlock++;
    return occupiedBlock;
}

void MemoryAllocator::remapMemory(FreeBlock **head, FreeBlock *allocatedBlocks, size_t blocksToAllocate)
{
    800013d4:	ff010113          	addi	sp,sp,-16
    800013d8:	00813423          	sd	s0,8(sp)
    800013dc:	01010413          	addi	s0,sp,16

    if(allocatedBlocks->numOfBlocks == 0)
    800013e0:	0085b783          	ld	a5,8(a1)
    800013e4:	04079263          	bnez	a5,80001428 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x54>
    {

        if(allocatedBlocks->previousBlock)
    800013e8:	0185b783          	ld	a5,24(a1)
    800013ec:	00078663          	beqz	a5,800013f8 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x24>
        {
            allocatedBlocks->previousBlock->nextBlock = allocatedBlocks->nextBlock;
    800013f0:	0105b703          	ld	a4,16(a1)
    800013f4:	00e7b823          	sd	a4,16(a5)
        }

        if(allocatedBlocks->nextBlock)
    800013f8:	0105b783          	ld	a5,16(a1)
    800013fc:	00078663          	beqz	a5,80001408 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x34>
        {
            allocatedBlocks->nextBlock->previousBlock = allocatedBlocks->previousBlock;
    80001400:	0185b703          	ld	a4,24(a1)
    80001404:	00e7bc23          	sd	a4,24(a5)
        }

        if(*head == allocatedBlocks)
    80001408:	00053783          	ld	a5,0(a0)
    8000140c:	00b78863          	beq	a5,a1,8000141c <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x48>
        {
            *head = newFreeBlock;
        }
    }

}
    80001410:	00813403          	ld	s0,8(sp)
    80001414:	01010113          	addi	sp,sp,16
    80001418:	00008067          	ret
            *head = allocatedBlocks->nextBlock;
    8000141c:	0105b783          	ld	a5,16(a1)
    80001420:	00f53023          	sd	a5,0(a0)
    80001424:	fedff06f          	j	80001410 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x3c>
        FreeBlock* newFreeBlock = (FreeBlock*)((uint8*)allocatedBlocks + blocksToAllocate * MEM_BLOCK_SIZE);
    80001428:	00661613          	slli	a2,a2,0x6
    8000142c:	00c58633          	add	a2,a1,a2
        newFreeBlock->flagFree = true;
    80001430:	00100793          	li	a5,1
    80001434:	00f60023          	sb	a5,0(a2)
        newFreeBlock->numOfBlocks = allocatedBlocks->numOfBlocks;
    80001438:	0085b783          	ld	a5,8(a1)
    8000143c:	00f63423          	sd	a5,8(a2)
        if(allocatedBlocks->previousBlock)
    80001440:	0185b783          	ld	a5,24(a1)
    80001444:	00078463          	beqz	a5,8000144c <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x78>
            allocatedBlocks->previousBlock->nextBlock = newFreeBlock;
    80001448:	00c7b823          	sd	a2,16(a5)
        newFreeBlock->previousBlock = allocatedBlocks->previousBlock;
    8000144c:	0185b783          	ld	a5,24(a1)
    80001450:	00f63c23          	sd	a5,24(a2)
        newFreeBlock->nextBlock = allocatedBlocks->nextBlock;
    80001454:	0105b783          	ld	a5,16(a1)
    80001458:	00f63823          	sd	a5,16(a2)
        if(*head == allocatedBlocks)
    8000145c:	00053783          	ld	a5,0(a0)
    80001460:	fab798e3          	bne	a5,a1,80001410 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x3c>
            *head = newFreeBlock;
    80001464:	00c53023          	sd	a2,0(a0)
}
    80001468:	fa9ff06f          	j	80001410 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x3c>

000000008000146c <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm>:
{
    8000146c:	fe010113          	addi	sp,sp,-32
    80001470:	00113c23          	sd	ra,24(sp)
    80001474:	00813823          	sd	s0,16(sp)
    80001478:	00913423          	sd	s1,8(sp)
    8000147c:	01213023          	sd	s2,0(sp)
    80001480:	02010413          	addi	s0,sp,32
    80001484:	00058913          	mv	s2,a1
    for(FreeBlock* curr = (*head); curr; curr = curr->nextBlock)
    80001488:	00053783          	ld	a5,0(a0)
    FreeBlock* bestBlock = nullptr;
    8000148c:	00000493          	li	s1,0
    80001490:	00c0006f          	j	8000149c <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm+0x30>
                bestBlock = curr;
    80001494:	00078493          	mv	s1,a5
    for(FreeBlock* curr = (*head); curr; curr = curr->nextBlock)
    80001498:	0107b783          	ld	a5,16(a5)
    8000149c:	02078063          	beqz	a5,800014bc <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm+0x50>
        if(curr->numOfBlocks >= blocksToAllocate)
    800014a0:	0087b703          	ld	a4,8(a5)
    800014a4:	ff276ae3          	bltu	a4,s2,80001498 <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm+0x2c>
        {   if(bestBlock == nullptr)
    800014a8:	fe0486e3          	beqz	s1,80001494 <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm+0x28>
            if(bestBlock->numOfBlocks > curr->numOfBlocks)
    800014ac:	0084b683          	ld	a3,8(s1)
    800014b0:	fed774e3          	bgeu	a4,a3,80001498 <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm+0x2c>
                bestBlock = curr;
    800014b4:	00078493          	mv	s1,a5
    800014b8:	fe1ff06f          	j	80001498 <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm+0x2c>
    numOfFreeBlocks -= blocksToAllocate;
    800014bc:	00003717          	auipc	a4,0x3
    800014c0:	24470713          	addi	a4,a4,580 # 80004700 <_ZN15MemoryAllocator13NUM_OF_BLOCKSE>
    800014c4:	00873783          	ld	a5,8(a4)
    800014c8:	412787b3          	sub	a5,a5,s2
    800014cc:	00f73423          	sd	a5,8(a4)
    bestBlock->numOfBlocks -= blocksToAllocate;
    800014d0:	0084b783          	ld	a5,8(s1)
    800014d4:	412787b3          	sub	a5,a5,s2
    800014d8:	00f4b423          	sd	a5,8(s1)
    remapMemory(head, bestBlock, blocksToAllocate);
    800014dc:	00090613          	mv	a2,s2
    800014e0:	00048593          	mv	a1,s1
    800014e4:	00000097          	auipc	ra,0x0
    800014e8:	ef0080e7          	jalr	-272(ra) # 800013d4 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m>
    occupiedBlock->flagFree = false;
    800014ec:	00048023          	sb	zero,0(s1)
    occupiedBlock->numOfBlocks = blocksToAllocate;
    800014f0:	0124b423          	sd	s2,8(s1)
}
    800014f4:	01048513          	addi	a0,s1,16
    800014f8:	01813083          	ld	ra,24(sp)
    800014fc:	01013403          	ld	s0,16(sp)
    80001500:	00813483          	ld	s1,8(sp)
    80001504:	00013903          	ld	s2,0(sp)
    80001508:	02010113          	addi	sp,sp,32
    8000150c:	00008067          	ret

0000000080001510 <_ZN15MemoryAllocator14allocateMemoryEm>:
{
    80001510:	fe010113          	addi	sp,sp,-32
    80001514:	00113c23          	sd	ra,24(sp)
    80001518:	00813823          	sd	s0,16(sp)
    8000151c:	00913423          	sd	s1,8(sp)
    80001520:	02010413          	addi	s0,sp,32
    80001524:	00050493          	mv	s1,a0
    if(!flagSystemInitialize)
    80001528:	00003797          	auipc	a5,0x3
    8000152c:	1f07c783          	lbu	a5,496(a5) # 80004718 <_ZN15MemoryAllocator20flagSystemInitializeE>
    80001530:	02078c63          	beqz	a5,80001568 <_ZN15MemoryAllocator14allocateMemoryEm+0x58>
    if(numOfFreeBlocks < blocksToAllocate)
    80001534:	00003797          	auipc	a5,0x3
    80001538:	1d47b783          	ld	a5,468(a5) # 80004708 <_ZN15MemoryAllocator15numOfFreeBlocksE>
    8000153c:	0297ec63          	bltu	a5,s1,80001574 <_ZN15MemoryAllocator14allocateMemoryEm+0x64>
    return findBestFit(&firstFreeBlock, blocksToAllocate);
    80001540:	00048593          	mv	a1,s1
    80001544:	00003517          	auipc	a0,0x3
    80001548:	1cc50513          	addi	a0,a0,460 # 80004710 <_ZN15MemoryAllocator14firstFreeBlockE>
    8000154c:	00000097          	auipc	ra,0x0
    80001550:	f20080e7          	jalr	-224(ra) # 8000146c <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm>
}
    80001554:	01813083          	ld	ra,24(sp)
    80001558:	01013403          	ld	s0,16(sp)
    8000155c:	00813483          	ld	s1,8(sp)
    80001560:	02010113          	addi	sp,sp,32
    80001564:	00008067          	ret
        initializeMemory();
    80001568:	00000097          	auipc	ra,0x0
    8000156c:	e00080e7          	jalr	-512(ra) # 80001368 <_ZN15MemoryAllocator16initializeMemoryEv>
    80001570:	fc5ff06f          	j	80001534 <_ZN15MemoryAllocator14allocateMemoryEm+0x24>
        return nullptr;
    80001574:	00000513          	li	a0,0
    80001578:	fddff06f          	j	80001554 <_ZN15MemoryAllocator14allocateMemoryEm+0x44>

000000008000157c <_ZN15MemoryAllocator17findNextFreeBlockEPNS_9FreeBlockE>:
MemoryAllocator::FreeBlock* MemoryAllocator::findNextFreeBlock(FreeBlock* memoryToFree)
{
    8000157c:	ff010113          	addi	sp,sp,-16
    80001580:	00813423          	sd	s0,8(sp)
    80001584:	01010413          	addi	s0,sp,16
    for(uint8* i = (uint8*)memoryToFree; i + MEM_BLOCK_SIZE <= (uint8*)HEAP_END_ADDR; i+= (((OccupiedBlock*)i)->numOfBlocks * MEM_BLOCK_SIZE))
    80001588:	04050793          	addi	a5,a0,64
    8000158c:	00003717          	auipc	a4,0x3
    80001590:	12473703          	ld	a4,292(a4) # 800046b0 <_GLOBAL_OFFSET_TABLE_+0x20>
    80001594:	00073703          	ld	a4,0(a4)
    80001598:	00f76e63          	bltu	a4,a5,800015b4 <_ZN15MemoryAllocator17findNextFreeBlockEPNS_9FreeBlockE+0x38>
    {
        if(((FreeBlock*)i)->flagFree)
    8000159c:	00054783          	lbu	a5,0(a0)
    800015a0:	00079c63          	bnez	a5,800015b8 <_ZN15MemoryAllocator17findNextFreeBlockEPNS_9FreeBlockE+0x3c>
    for(uint8* i = (uint8*)memoryToFree; i + MEM_BLOCK_SIZE <= (uint8*)HEAP_END_ADDR; i+= (((OccupiedBlock*)i)->numOfBlocks * MEM_BLOCK_SIZE))
    800015a4:	00853783          	ld	a5,8(a0)
    800015a8:	00679793          	slli	a5,a5,0x6
    800015ac:	00f50533          	add	a0,a0,a5
    800015b0:	fd9ff06f          	j	80001588 <_ZN15MemoryAllocator17findNextFreeBlockEPNS_9FreeBlockE+0xc>
        {
            return (FreeBlock*)i;
        }
    }
    return nullptr;
    800015b4:	00000513          	li	a0,0
}
    800015b8:	00813403          	ld	s0,8(sp)
    800015bc:	01010113          	addi	sp,sp,16
    800015c0:	00008067          	ret

00000000800015c4 <_ZN15MemoryAllocator21findPreviousFreeBlockEPNS_9FreeBlockES1_>:

MemoryAllocator::FreeBlock* MemoryAllocator::findPreviousFreeBlock(FreeBlock* head, FreeBlock* memoryToFree)
{
    800015c4:	ff010113          	addi	sp,sp,-16
    800015c8:	00813423          	sd	s0,8(sp)
    800015cc:	01010413          	addi	s0,sp,16
    FreeBlock* temp = head;
    for(; temp && temp <= memoryToFree; temp = temp->nextBlock){}
    800015d0:	00050863          	beqz	a0,800015e0 <_ZN15MemoryAllocator21findPreviousFreeBlockEPNS_9FreeBlockES1_+0x1c>
    800015d4:	00a5e663          	bltu	a1,a0,800015e0 <_ZN15MemoryAllocator21findPreviousFreeBlockEPNS_9FreeBlockES1_+0x1c>
    800015d8:	01053503          	ld	a0,16(a0)
    800015dc:	ff5ff06f          	j	800015d0 <_ZN15MemoryAllocator21findPreviousFreeBlockEPNS_9FreeBlockES1_+0xc>
    if(!temp)
    800015e0:	00050463          	beqz	a0,800015e8 <_ZN15MemoryAllocator21findPreviousFreeBlockEPNS_9FreeBlockES1_+0x24>
    {
        return nullptr;
    }
    return temp->previousBlock;
    800015e4:	01853503          	ld	a0,24(a0)
}
    800015e8:	00813403          	ld	s0,8(sp)
    800015ec:	01010113          	addi	sp,sp,16
    800015f0:	00008067          	ret

00000000800015f4 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_>:

    return 0;
}

void MemoryAllocator::connectAdjacentBlocks(FreeBlock* previousBlock, FreeBlock* adjacentBlock)
{
    800015f4:	ff010113          	addi	sp,sp,-16
    800015f8:	00813423          	sd	s0,8(sp)
    800015fc:	01010413          	addi	s0,sp,16


    if(adjacentBlock == (FreeBlock*)((uint8 *)previousBlock + previousBlock->numOfBlocks * MEM_BLOCK_SIZE))
    80001600:	00853703          	ld	a4,8(a0)
    80001604:	00671793          	slli	a5,a4,0x6
    80001608:	00f507b3          	add	a5,a0,a5
    8000160c:	00b78e63          	beq	a5,a1,80001628 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_+0x34>
        adjacentBlock->previousBlock = nullptr;

    }
    else
    {
        previousBlock->nextBlock = adjacentBlock;
    80001610:	00b53823          	sd	a1,16(a0)
        if(adjacentBlock)
    80001614:	00058463          	beqz	a1,8000161c <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_+0x28>
        {
            adjacentBlock->previousBlock = previousBlock;
    80001618:	00a5bc23          	sd	a0,24(a1)
        }

    }
}
    8000161c:	00813403          	ld	s0,8(sp)
    80001620:	01010113          	addi	sp,sp,16
    80001624:	00008067          	ret
        previousBlock->numOfBlocks += adjacentBlock->numOfBlocks;
    80001628:	0085b783          	ld	a5,8(a1)
    8000162c:	00f70733          	add	a4,a4,a5
    80001630:	00e53423          	sd	a4,8(a0)
        previousBlock->nextBlock = adjacentBlock->nextBlock;
    80001634:	0105b783          	ld	a5,16(a1)
    80001638:	00f53823          	sd	a5,16(a0)
        if(adjacentBlock->nextBlock != nullptr)
    8000163c:	00078463          	beqz	a5,80001644 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_+0x50>
            adjacentBlock->nextBlock->previousBlock = previousBlock;
    80001640:	00a7bc23          	sd	a0,24(a5)
        if(adjacentBlock->previousBlock != previousBlock && adjacentBlock->previousBlock != nullptr)
    80001644:	0185b783          	ld	a5,24(a1)
    80001648:	00a78863          	beq	a5,a0,80001658 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_+0x64>
    8000164c:	00078663          	beqz	a5,80001658 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_+0x64>
            previousBlock->previousBlock = adjacentBlock->previousBlock;
    80001650:	00f53c23          	sd	a5,24(a0)
            adjacentBlock->previousBlock->nextBlock = previousBlock;
    80001654:	00a7b823          	sd	a0,16(a5)
        adjacentBlock->flagFree = false;
    80001658:	00058023          	sb	zero,0(a1)
        adjacentBlock->numOfBlocks = 0;
    8000165c:	0005b423          	sd	zero,8(a1)
        adjacentBlock->nextBlock = nullptr;
    80001660:	0005b823          	sd	zero,16(a1)
        adjacentBlock->previousBlock = nullptr;
    80001664:	0005bc23          	sd	zero,24(a1)
    80001668:	fb5ff06f          	j	8000161c <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_+0x28>

000000008000166c <_ZN15MemoryAllocator10freeMemoryEPv>:
    if(!addressToFree)
    8000166c:	0c050e63          	beqz	a0,80001748 <_ZN15MemoryAllocator10freeMemoryEPv+0xdc>
{
    80001670:	fc010113          	addi	sp,sp,-64
    80001674:	02113c23          	sd	ra,56(sp)
    80001678:	02813823          	sd	s0,48(sp)
    8000167c:	02913423          	sd	s1,40(sp)
    80001680:	03213023          	sd	s2,32(sp)
    80001684:	01313c23          	sd	s3,24(sp)
    80001688:	01413823          	sd	s4,16(sp)
    8000168c:	01513423          	sd	s5,8(sp)
    80001690:	04010413          	addi	s0,sp,64
    80001694:	00050493          	mv	s1,a0
    tempAddress--;
    80001698:	ff050913          	addi	s2,a0,-16
    int numOfTakenBlocks = tempAddress->numOfBlocks;
    8000169c:	ff852a83          	lw	s5,-8(a0)
    numOfFreeBlocks += numOfTakenBlocks;
    800016a0:	00003997          	auipc	s3,0x3
    800016a4:	06098993          	addi	s3,s3,96 # 80004700 <_ZN15MemoryAllocator13NUM_OF_BLOCKSE>
    800016a8:	0089b783          	ld	a5,8(s3)
    800016ac:	015787b3          	add	a5,a5,s5
    800016b0:	00f9b423          	sd	a5,8(s3)
    FreeBlock* nextFreeBlock = findNextFreeBlock(newFreeBlock);
    800016b4:	00090513          	mv	a0,s2
    800016b8:	00000097          	auipc	ra,0x0
    800016bc:	ec4080e7          	jalr	-316(ra) # 8000157c <_ZN15MemoryAllocator17findNextFreeBlockEPNS_9FreeBlockE>
    800016c0:	00050a13          	mv	s4,a0
    FreeBlock* previousFreeBlock = findPreviousFreeBlock(firstFreeBlock, newFreeBlock);
    800016c4:	00090593          	mv	a1,s2
    800016c8:	0109b503          	ld	a0,16(s3)
    800016cc:	00000097          	auipc	ra,0x0
    800016d0:	ef8080e7          	jalr	-264(ra) # 800015c4 <_ZN15MemoryAllocator21findPreviousFreeBlockEPNS_9FreeBlockES1_>
    800016d4:	00050993          	mv	s3,a0
    newFreeBlock->flagFree = true;
    800016d8:	00100793          	li	a5,1
    800016dc:	fef48823          	sb	a5,-16(s1)
    newFreeBlock->numOfBlocks = numOfTakenBlocks;
    800016e0:	ff54bc23          	sd	s5,-8(s1)
    newFreeBlock->nextBlock = nullptr;
    800016e4:	0004b023          	sd	zero,0(s1)
    newFreeBlock->previousBlock = nullptr;
    800016e8:	0004b423          	sd	zero,8(s1)
    connectAdjacentBlocks(newFreeBlock, nextFreeBlock);
    800016ec:	000a0593          	mv	a1,s4
    800016f0:	00090513          	mv	a0,s2
    800016f4:	00000097          	auipc	ra,0x0
    800016f8:	f00080e7          	jalr	-256(ra) # 800015f4 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_>
    if(previousFreeBlock)
    800016fc:	02098e63          	beqz	s3,80001738 <_ZN15MemoryAllocator10freeMemoryEPv+0xcc>
        connectAdjacentBlocks(previousFreeBlock, newFreeBlock);
    80001700:	00090593          	mv	a1,s2
    80001704:	00098513          	mv	a0,s3
    80001708:	00000097          	auipc	ra,0x0
    8000170c:	eec080e7          	jalr	-276(ra) # 800015f4 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_>
    return 0;
    80001710:	00000513          	li	a0,0
}
    80001714:	03813083          	ld	ra,56(sp)
    80001718:	03013403          	ld	s0,48(sp)
    8000171c:	02813483          	ld	s1,40(sp)
    80001720:	02013903          	ld	s2,32(sp)
    80001724:	01813983          	ld	s3,24(sp)
    80001728:	01013a03          	ld	s4,16(sp)
    8000172c:	00813a83          	ld	s5,8(sp)
    80001730:	04010113          	addi	sp,sp,64
    80001734:	00008067          	ret
        firstFreeBlock = newFreeBlock;
    80001738:	00003797          	auipc	a5,0x3
    8000173c:	fd27bc23          	sd	s2,-40(a5) # 80004710 <_ZN15MemoryAllocator14firstFreeBlockE>
    return 0;
    80001740:	00000513          	li	a0,0
    80001744:	fd1ff06f          	j	80001714 <_ZN15MemoryAllocator10freeMemoryEPv+0xa8>
        return -1;
    80001748:	fff00513          	li	a0,-1
}
    8000174c:	00008067          	ret

0000000080001750 <_ZN15MemoryAllocator19getLargestFreeBlockEv>:

size_t  MemoryAllocator::getLargestFreeBlock()
{
    80001750:	ff010113          	addi	sp,sp,-16
    80001754:	00813423          	sd	s0,8(sp)
    80001758:	01010413          	addi	s0,sp,16
    size_t largestBlock = firstFreeBlock->numOfBlocks;
    8000175c:	00003797          	auipc	a5,0x3
    80001760:	fb47b783          	ld	a5,-76(a5) # 80004710 <_ZN15MemoryAllocator14firstFreeBlockE>
    80001764:	0087b503          	ld	a0,8(a5)
    for(FreeBlock* curr = firstFreeBlock->nextBlock; curr; curr = curr->nextBlock)
    80001768:	0107b783          	ld	a5,16(a5)
    8000176c:	0080006f          	j	80001774 <_ZN15MemoryAllocator19getLargestFreeBlockEv+0x24>
    80001770:	0107b783          	ld	a5,16(a5)
    80001774:	00078a63          	beqz	a5,80001788 <_ZN15MemoryAllocator19getLargestFreeBlockEv+0x38>
    {
        if(curr->numOfBlocks > largestBlock)
    80001778:	0087b703          	ld	a4,8(a5)
    8000177c:	fee57ae3          	bgeu	a0,a4,80001770 <_ZN15MemoryAllocator19getLargestFreeBlockEv+0x20>
        {
            largestBlock = curr->numOfBlocks;
    80001780:	00070513          	mv	a0,a4
    80001784:	fedff06f          	j	80001770 <_ZN15MemoryAllocator19getLargestFreeBlockEv+0x20>
        }
    }
    return largestBlock * MEM_BLOCK_SIZE;
}
    80001788:	00651513          	slli	a0,a0,0x6
    8000178c:	00813403          	ld	s0,8(sp)
    80001790:	01010113          	addi	sp,sp,16
    80001794:	00008067          	ret

0000000080001798 <_ZN15MemoryAllocator12getFreeSpaceEv>:
size_t MemoryAllocator::getFreeSpace()
{
    80001798:	ff010113          	addi	sp,sp,-16
    8000179c:	00813423          	sd	s0,8(sp)
    800017a0:	01010413          	addi	s0,sp,16
    return numOfFreeBlocks * MEM_BLOCK_SIZE;
}
    800017a4:	00003517          	auipc	a0,0x3
    800017a8:	f6453503          	ld	a0,-156(a0) # 80004708 <_ZN15MemoryAllocator15numOfFreeBlocksE>
    800017ac:	00651513          	slli	a0,a0,0x6
    800017b0:	00813403          	ld	s0,8(sp)
    800017b4:	01010113          	addi	sp,sp,16
    800017b8:	00008067          	ret

00000000800017bc <_ZN15MemoryAllocator17getSizeOfMetaDataEv>:

size_t MemoryAllocator::getSizeOfMetaData()
{
    800017bc:	ff010113          	addi	sp,sp,-16
    800017c0:	00813423          	sd	s0,8(sp)
    800017c4:	01010413          	addi	s0,sp,16
    return sizeof(OccupiedBlock);
    800017c8:	01000513          	li	a0,16
    800017cc:	00813403          	ld	s0,8(sp)
    800017d0:	01010113          	addi	sp,sp,16
    800017d4:	00008067          	ret

00000000800017d8 <_ZN6Kernel9sysMallocEPNS_21ArgumentsOfSystemCallE>:
    __asm__ volatile("ld %[rd], 16*8(%[rs])":[rd]"=r"(arg->a5):[rs]"r"(basePointer));
    __asm__ volatile("ld %[rd], 17*8(%[rs])":[rd]"=r"(arg->a6):[rs]"r"(basePointer));
}

uint64 Kernel::sysMalloc(Kernel::ArgumentsOfSystemCall *arg)
{
    800017d8:	ff010113          	addi	sp,sp,-16
    800017dc:	00113423          	sd	ra,8(sp)
    800017e0:	00813023          	sd	s0,0(sp)
    800017e4:	01010413          	addi	s0,sp,16
    uint64 returnValue;
    returnValue = (uint64)MemoryAllocator::allocateMemory(arg->a0);
    800017e8:	00053503          	ld	a0,0(a0)
    800017ec:	00000097          	auipc	ra,0x0
    800017f0:	d24080e7          	jalr	-732(ra) # 80001510 <_ZN15MemoryAllocator14allocateMemoryEm>
    return returnValue;
}
    800017f4:	00813083          	ld	ra,8(sp)
    800017f8:	00013403          	ld	s0,0(sp)
    800017fc:	01010113          	addi	sp,sp,16
    80001800:	00008067          	ret

0000000080001804 <_ZN6Kernel7sysFreeEPNS_21ArgumentsOfSystemCallE>:
uint64 Kernel::sysFree(Kernel::ArgumentsOfSystemCall *arg)
{
    80001804:	ff010113          	addi	sp,sp,-16
    80001808:	00113423          	sd	ra,8(sp)
    8000180c:	00813023          	sd	s0,0(sp)
    80001810:	01010413          	addi	s0,sp,16
    uint64 returnValue;
    returnValue = (uint64)MemoryAllocator::freeMemory((void*)arg->a0);
    80001814:	00053503          	ld	a0,0(a0)
    80001818:	00000097          	auipc	ra,0x0
    8000181c:	e54080e7          	jalr	-428(ra) # 8000166c <_ZN15MemoryAllocator10freeMemoryEPv>
    return returnValue;
}
    80001820:	00813083          	ld	ra,8(sp)
    80001824:	00013403          	ld	s0,0(sp)
    80001828:	01010113          	addi	sp,sp,16
    8000182c:	00008067          	ret

0000000080001830 <_ZN6Kernel15sysGetFreeSpaceEPNS_21ArgumentsOfSystemCallE>:
uint64 Kernel::sysGetFreeSpace(Kernel::ArgumentsOfSystemCall *arg)
{
    80001830:	ff010113          	addi	sp,sp,-16
    80001834:	00113423          	sd	ra,8(sp)
    80001838:	00813023          	sd	s0,0(sp)
    8000183c:	01010413          	addi	s0,sp,16
    uint64 returnValue;
    returnValue = (uint64)MemoryAllocator::getFreeSpace();
    80001840:	00000097          	auipc	ra,0x0
    80001844:	f58080e7          	jalr	-168(ra) # 80001798 <_ZN15MemoryAllocator12getFreeSpaceEv>
    return returnValue;
}
    80001848:	00813083          	ld	ra,8(sp)
    8000184c:	00013403          	ld	s0,0(sp)
    80001850:	01010113          	addi	sp,sp,16
    80001854:	00008067          	ret

0000000080001858 <_ZN6Kernel19sysLargestFreeBlockEPNS_21ArgumentsOfSystemCallE>:
uint64 Kernel::sysLargestFreeBlock(Kernel::ArgumentsOfSystemCall *arg)
{
    80001858:	ff010113          	addi	sp,sp,-16
    8000185c:	00113423          	sd	ra,8(sp)
    80001860:	00813023          	sd	s0,0(sp)
    80001864:	01010413          	addi	s0,sp,16
    uint64 returnValue;
    returnValue = (uint64)MemoryAllocator::getLargestFreeBlock();
    80001868:	00000097          	auipc	ra,0x0
    8000186c:	ee8080e7          	jalr	-280(ra) # 80001750 <_ZN15MemoryAllocator19getLargestFreeBlockEv>
    return returnValue;
}
    80001870:	00813083          	ld	ra,8(sp)
    80001874:	00013403          	ld	s0,0(sp)
    80001878:	01010113          	addi	sp,sp,16
    8000187c:	00008067          	ret

0000000080001880 <_ZN6Kernel16initializeKernelEv>:
{
    80001880:	ff010113          	addi	sp,sp,-16
    80001884:	00813423          	sd	s0,8(sp)
    80001888:	01010413          	addi	s0,sp,16

};

inline void Kernel::setInterruptRoutine(void (*routine)(void))
{
    Machine::writeStvec((uint64) routine);
    8000188c:	00003797          	auipc	a5,0x3
    80001890:	e1c7b783          	ld	a5,-484(a5) # 800046a8 <_GLOBAL_OFFSET_TABLE_+0x18>

};

inline void Machine::writeStvec(uint64 interruptAddress)
{
    __asm__ volatile ("csrw stvec, %[address]": : [address] "r"(interruptAddress));
    80001894:	10579073          	csrw	stvec,a5
    systemCallsTable[MEM_ALLOC] = &sysMalloc;
    80001898:	00003797          	auipc	a5,0x3
    8000189c:	e8878793          	addi	a5,a5,-376 # 80004720 <_ZN6Kernel16systemCallsTableE>
    800018a0:	00000717          	auipc	a4,0x0
    800018a4:	f3870713          	addi	a4,a4,-200 # 800017d8 <_ZN6Kernel9sysMallocEPNS_21ArgumentsOfSystemCallE>
    800018a8:	00e7b423          	sd	a4,8(a5)
    systemCallsTable[MEM_FREE] = &sysFree;
    800018ac:	00000717          	auipc	a4,0x0
    800018b0:	f5870713          	addi	a4,a4,-168 # 80001804 <_ZN6Kernel7sysFreeEPNS_21ArgumentsOfSystemCallE>
    800018b4:	00e7b823          	sd	a4,16(a5)
    systemCallsTable[MEM_FREE_SPACE] = &sysGetFreeSpace;
    800018b8:	00000717          	auipc	a4,0x0
    800018bc:	f7870713          	addi	a4,a4,-136 # 80001830 <_ZN6Kernel15sysGetFreeSpaceEPNS_21ArgumentsOfSystemCallE>
    800018c0:	00e7bc23          	sd	a4,24(a5)
    systemCallsTable[LARGEST_FREE_BLOCK] = &sysLargestFreeBlock;
    800018c4:	00000717          	auipc	a4,0x0
    800018c8:	f9470713          	addi	a4,a4,-108 # 80001858 <_ZN6Kernel19sysLargestFreeBlockEPNS_21ArgumentsOfSystemCallE>
    800018cc:	02e7b023          	sd	a4,32(a5)
}
    800018d0:	00813403          	ld	s0,8(sp)
    800018d4:	01010113          	addi	sp,sp,16
    800018d8:	00008067          	ret

00000000800018dc <_ZN6Kernel19initializeArgumentsEPNS_21ArgumentsOfSystemCallEm>:
{
    800018dc:	ff010113          	addi	sp,sp,-16
    800018e0:	00813423          	sd	s0,8(sp)
    800018e4:	01010413          	addi	s0,sp,16
    __asm__ volatile("ld %[rd], 11*8(%[rs])":[rd]"=r"(arg->a0):[rs]"r"(basePointer));
    800018e8:	0585b783          	ld	a5,88(a1)
    800018ec:	00f53023          	sd	a5,0(a0)
    __asm__ volatile("ld %[rd], 12*8(%[rs])":[rd]"=r"(arg->a1):[rs]"r"(basePointer));
    800018f0:	0605b783          	ld	a5,96(a1)
    800018f4:	00f53423          	sd	a5,8(a0)
    __asm__ volatile("ld %[rd], 13*8(%[rs])":[rd]"=r"(arg->a2):[rs]"r"(basePointer));
    800018f8:	0685b783          	ld	a5,104(a1)
    800018fc:	00f53823          	sd	a5,16(a0)
    __asm__ volatile("ld %[rd], 14*8(%[rs])":[rd]"=r"(arg->a3):[rs]"r"(basePointer));
    80001900:	0705b783          	ld	a5,112(a1)
    80001904:	00f53c23          	sd	a5,24(a0)
    __asm__ volatile("ld %[rd], 15*8(%[rs])":[rd]"=r"(arg->a4):[rs]"r"(basePointer));
    80001908:	0785b783          	ld	a5,120(a1)
    8000190c:	02f53023          	sd	a5,32(a0)
    __asm__ volatile("ld %[rd], 16*8(%[rs])":[rd]"=r"(arg->a5):[rs]"r"(basePointer));
    80001910:	0805b783          	ld	a5,128(a1)
    80001914:	02f53423          	sd	a5,40(a0)
    __asm__ volatile("ld %[rd], 17*8(%[rs])":[rd]"=r"(arg->a6):[rs]"r"(basePointer));
    80001918:	0885b583          	ld	a1,136(a1)
    8000191c:	02b53823          	sd	a1,48(a0)
}
    80001920:	00813403          	ld	s0,8(sp)
    80001924:	01010113          	addi	sp,sp,16
    80001928:	00008067          	ret

000000008000192c <_ZN6Kernel16interruptHandlerEv>:

void Kernel::interruptHandler()
{
    8000192c:	fa010113          	addi	sp,sp,-96
    80001930:	04113c23          	sd	ra,88(sp)
    80001934:	04813823          	sd	s0,80(sp)
    80001938:	04913423          	sd	s1,72(sp)
    8000193c:	05213023          	sd	s2,64(sp)
    80001940:	06010413          	addi	s0,sp,96
    volatile uint64 basePointer;
    __asm__ volatile ("addi %[reg], s0, 0x0": [reg]"=r"(basePointer)); // Problem: da li mozemo biti 100% sigurni da ce s0 biti nepromenjen; resenje inline f-ja
    80001944:	00040793          	mv	a5,s0
    80001948:	fcf43c23          	sd	a5,-40(s0)
}

inline uint64 Machine::readScause(void)
{
    uint64 scause;
    __asm__ volatile ("csrr %[cause], scause": [cause] "=r"(scause));
    8000194c:	142027f3          	csrr	a5,scause
    uint64 scause = Machine::readScause();
    if(scause == 0x0000000000000008UL || scause == 0x0000000000000009UL)
    80001950:	ff878793          	addi	a5,a5,-8
    80001954:	00100713          	li	a4,1
    80001958:	00f77e63          	bgeu	a4,a5,80001974 <_ZN6Kernel16interruptHandlerEv+0x48>
        systemCallsTable[numberOfEntry](&arg);
        __asm__ volatile("sd a0, 80(%[rs])"::[rs]"r"(basePointer));
        Machine::incrementSepc();
    }

    8000195c:	05813083          	ld	ra,88(sp)
    80001960:	05013403          	ld	s0,80(sp)
    80001964:	04813483          	ld	s1,72(sp)
    80001968:	04013903          	ld	s2,64(sp)
    8000196c:	06010113          	addi	sp,sp,96
    80001970:	00008067          	ret
        __asm__ volatile ("ld %[rd], 80(%[rs])": [rd]"=r"(numberOfEntry):[rs]"r"(basePointer));
    80001974:	fd843483          	ld	s1,-40(s0)
    80001978:	0504b483          	ld	s1,80(s1)
        initializeArguments(&arg, basePointer);
    8000197c:	fd843583          	ld	a1,-40(s0)
    80001980:	fa040913          	addi	s2,s0,-96
    80001984:	00090513          	mv	a0,s2
    80001988:	00000097          	auipc	ra,0x0
    8000198c:	f54080e7          	jalr	-172(ra) # 800018dc <_ZN6Kernel19initializeArgumentsEPNS_21ArgumentsOfSystemCallEm>
        systemCallsTable[numberOfEntry](&arg);
    80001990:	00349493          	slli	s1,s1,0x3
    80001994:	00003797          	auipc	a5,0x3
    80001998:	d8c78793          	addi	a5,a5,-628 # 80004720 <_ZN6Kernel16systemCallsTableE>
    8000199c:	009784b3          	add	s1,a5,s1
    800019a0:	0004b783          	ld	a5,0(s1)
    800019a4:	00090513          	mv	a0,s2
    800019a8:	000780e7          	jalr	a5
        __asm__ volatile("sd a0, 80(%[rs])"::[rs]"r"(basePointer));
    800019ac:	fd843783          	ld	a5,-40(s0)
    800019b0:	04a7b823          	sd	a0,80(a5)
    return scause;
}

inline void Machine::incrementSepc(void)
{
    __asm__ volatile ("csrr t0, sepc");
    800019b4:	141022f3          	csrr	t0,sepc
    __asm__ volatile ("addi t0, t0, 0x4");
    800019b8:	00428293          	addi	t0,t0,4
    __asm__ volatile ("csrw sepc, t0");
    800019bc:	14129073          	csrw	sepc,t0
    800019c0:	f9dff06f          	j	8000195c <_ZN6Kernel16interruptHandlerEv+0x30>

00000000800019c4 <_Z41__static_initialization_and_destruction_0ii>:
    800019c4:	00100793          	li	a5,1
    800019c8:	00f50463          	beq	a0,a5,800019d0 <_Z41__static_initialization_and_destruction_0ii+0xc>
    800019cc:	00008067          	ret
    800019d0:	000107b7          	lui	a5,0x10
    800019d4:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    800019d8:	fef59ae3          	bne	a1,a5,800019cc <_Z41__static_initialization_and_destruction_0ii+0x8>
    800019dc:	ff010113          	addi	sp,sp,-16
    800019e0:	00113423          	sd	ra,8(sp)
    800019e4:	00813023          	sd	s0,0(sp)
    800019e8:	01010413          	addi	s0,sp,16
ObjectPool<TCB, KernelConfig::NUM_OF_THREADS_IN_POOL>* Kernel::poolOfThreads = new ObjectPool<TCB, KernelConfig::NUM_OF_THREADS_IN_POOL>();
    800019ec:	70000513          	li	a0,1792
    800019f0:	00000097          	auipc	ra,0x0
    800019f4:	0ac080e7          	jalr	172(ra) # 80001a9c <_ZN10ObjectPoolI3TCBLm20EEnwEm>


template <typename T, size_t numOfObjects>
class ObjectPool {
public:
    ObjectPool(): headFreeObject(pool), nextObjectPool(nullptr), prevObjectPool(nullptr), id(countOfPools++)
    800019f8:	6ea53023          	sd	a0,1760(a0)
    800019fc:	6e053423          	sd	zero,1768(a0)
    80001a00:	6e053823          	sd	zero,1776(a0)
    80001a04:	00003717          	auipc	a4,0x3
    80001a08:	d7c70713          	addi	a4,a4,-644 # 80004780 <_ZN10ObjectPoolI3TCBLm20EE12countOfPoolsE>
    80001a0c:	00073783          	ld	a5,0(a4)
    80001a10:	00178693          	addi	a3,a5,1
    80001a14:	00d73023          	sd	a3,0(a4)
    80001a18:	6ef53c23          	sd	a5,1784(a0)
    {

        for(size_t i = 0; i < numOfObjects - 1; i++)
    80001a1c:	00000793          	li	a5,0
    80001a20:	01200713          	li	a4,18
    80001a24:	02f76463          	bltu	a4,a5,80001a4c <_Z41__static_initialization_and_destruction_0ii+0x88>
        {
            pool[i].nextFree = &(pool[i+1]);
    80001a28:	00178693          	addi	a3,a5,1
    80001a2c:	05800613          	li	a2,88
    80001a30:	02c68733          	mul	a4,a3,a2
    80001a34:	00e50733          	add	a4,a0,a4
    80001a38:	02c787b3          	mul	a5,a5,a2
    80001a3c:	00f507b3          	add	a5,a0,a5
    80001a40:	04e7b823          	sd	a4,80(a5)
        for(size_t i = 0; i < numOfObjects - 1; i++)
    80001a44:	00068793          	mv	a5,a3
    80001a48:	fd9ff06f          	j	80001a20 <_Z41__static_initialization_and_destruction_0ii+0x5c>
        }
        pool[numOfObjects - 1].nextFree = nullptr;
    80001a4c:	6c053c23          	sd	zero,1752(a0)
    80001a50:	00003797          	auipc	a5,0x3
    80001a54:	d2a7b023          	sd	a0,-736(a5) # 80004770 <_ZN6Kernel13poolOfThreadsE>
    80001a58:	00813083          	ld	ra,8(sp)
    80001a5c:	00013403          	ld	s0,0(sp)
    80001a60:	01010113          	addi	sp,sp,16
    80001a64:	00008067          	ret

0000000080001a68 <_GLOBAL__sub_I__ZN6Kernel16systemCallsTableE>:
    80001a68:	ff010113          	addi	sp,sp,-16
    80001a6c:	00113423          	sd	ra,8(sp)
    80001a70:	00813023          	sd	s0,0(sp)
    80001a74:	01010413          	addi	s0,sp,16
    80001a78:	000105b7          	lui	a1,0x10
    80001a7c:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    80001a80:	00100513          	li	a0,1
    80001a84:	00000097          	auipc	ra,0x0
    80001a88:	f40080e7          	jalr	-192(ra) # 800019c4 <_Z41__static_initialization_and_destruction_0ii>
    80001a8c:	00813083          	ld	ra,8(sp)
    80001a90:	00013403          	ld	s0,0(sp)
    80001a94:	01010113          	addi	sp,sp,16
    80001a98:	00008067          	ret

0000000080001a9c <_ZN10ObjectPoolI3TCBLm20EEnwEm>:
template<typename T, size_t numOfObjects>
size_t ObjectPool<T, numOfObjects>::countOfPools = 0;


template<typename T, size_t numOfObjects>
void* ObjectPool<T, numOfObjects>::operator new(size_t size)
    80001a9c:	ff010113          	addi	sp,sp,-16
    80001aa0:	00113423          	sd	ra,8(sp)
    80001aa4:	00813023          	sd	s0,0(sp)
    80001aa8:	01010413          	addi	s0,sp,16
{
    size_t numOfBlocks = size / MEM_BLOCK_SIZE;
    80001aac:	00655793          	srli	a5,a0,0x6
    numOfBlocks += size % MEM_BLOCK_SIZE ? 1 : 0;
    80001ab0:	03f57513          	andi	a0,a0,63
    80001ab4:	00050463          	beqz	a0,80001abc <_ZN10ObjectPoolI3TCBLm20EEnwEm+0x20>
    80001ab8:	00100513          	li	a0,1
    return MemoryAllocator::allocateMemory(numOfBlocks);
    80001abc:	00f50533          	add	a0,a0,a5
    80001ac0:	00000097          	auipc	ra,0x0
    80001ac4:	a50080e7          	jalr	-1456(ra) # 80001510 <_ZN15MemoryAllocator14allocateMemoryEm>
}
    80001ac8:	00813083          	ld	ra,8(sp)
    80001acc:	00013403          	ld	s0,0(sp)
    80001ad0:	01010113          	addi	sp,sp,16
    80001ad4:	00008067          	ret

0000000080001ad8 <start>:
    80001ad8:	ff010113          	addi	sp,sp,-16
    80001adc:	00813423          	sd	s0,8(sp)
    80001ae0:	01010413          	addi	s0,sp,16
    80001ae4:	300027f3          	csrr	a5,mstatus
    80001ae8:	ffffe737          	lui	a4,0xffffe
    80001aec:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff8e1f>
    80001af0:	00e7f7b3          	and	a5,a5,a4
    80001af4:	00001737          	lui	a4,0x1
    80001af8:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80001afc:	00e7e7b3          	or	a5,a5,a4
    80001b00:	30079073          	csrw	mstatus,a5
    80001b04:	00000797          	auipc	a5,0x0
    80001b08:	16078793          	addi	a5,a5,352 # 80001c64 <system_main>
    80001b0c:	34179073          	csrw	mepc,a5
    80001b10:	00000793          	li	a5,0
    80001b14:	18079073          	csrw	satp,a5
    80001b18:	000107b7          	lui	a5,0x10
    80001b1c:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80001b20:	30279073          	csrw	medeleg,a5
    80001b24:	30379073          	csrw	mideleg,a5
    80001b28:	104027f3          	csrr	a5,sie
    80001b2c:	2227e793          	ori	a5,a5,546
    80001b30:	10479073          	csrw	sie,a5
    80001b34:	fff00793          	li	a5,-1
    80001b38:	00a7d793          	srli	a5,a5,0xa
    80001b3c:	3b079073          	csrw	pmpaddr0,a5
    80001b40:	00f00793          	li	a5,15
    80001b44:	3a079073          	csrw	pmpcfg0,a5
    80001b48:	f14027f3          	csrr	a5,mhartid
    80001b4c:	0200c737          	lui	a4,0x200c
    80001b50:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80001b54:	0007869b          	sext.w	a3,a5
    80001b58:	00269713          	slli	a4,a3,0x2
    80001b5c:	000f4637          	lui	a2,0xf4
    80001b60:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80001b64:	00d70733          	add	a4,a4,a3
    80001b68:	0037979b          	slliw	a5,a5,0x3
    80001b6c:	020046b7          	lui	a3,0x2004
    80001b70:	00d787b3          	add	a5,a5,a3
    80001b74:	00c585b3          	add	a1,a1,a2
    80001b78:	00371693          	slli	a3,a4,0x3
    80001b7c:	00003717          	auipc	a4,0x3
    80001b80:	c1470713          	addi	a4,a4,-1004 # 80004790 <timer_scratch>
    80001b84:	00b7b023          	sd	a1,0(a5)
    80001b88:	00d70733          	add	a4,a4,a3
    80001b8c:	00f73c23          	sd	a5,24(a4)
    80001b90:	02c73023          	sd	a2,32(a4)
    80001b94:	34071073          	csrw	mscratch,a4
    80001b98:	00000797          	auipc	a5,0x0
    80001b9c:	6e878793          	addi	a5,a5,1768 # 80002280 <timervec>
    80001ba0:	30579073          	csrw	mtvec,a5
    80001ba4:	300027f3          	csrr	a5,mstatus
    80001ba8:	0087e793          	ori	a5,a5,8
    80001bac:	30079073          	csrw	mstatus,a5
    80001bb0:	304027f3          	csrr	a5,mie
    80001bb4:	0807e793          	ori	a5,a5,128
    80001bb8:	30479073          	csrw	mie,a5
    80001bbc:	f14027f3          	csrr	a5,mhartid
    80001bc0:	0007879b          	sext.w	a5,a5
    80001bc4:	00078213          	mv	tp,a5
    80001bc8:	30200073          	mret
    80001bcc:	00813403          	ld	s0,8(sp)
    80001bd0:	01010113          	addi	sp,sp,16
    80001bd4:	00008067          	ret

0000000080001bd8 <timerinit>:
    80001bd8:	ff010113          	addi	sp,sp,-16
    80001bdc:	00813423          	sd	s0,8(sp)
    80001be0:	01010413          	addi	s0,sp,16
    80001be4:	f14027f3          	csrr	a5,mhartid
    80001be8:	0200c737          	lui	a4,0x200c
    80001bec:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80001bf0:	0007869b          	sext.w	a3,a5
    80001bf4:	00269713          	slli	a4,a3,0x2
    80001bf8:	000f4637          	lui	a2,0xf4
    80001bfc:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80001c00:	00d70733          	add	a4,a4,a3
    80001c04:	0037979b          	slliw	a5,a5,0x3
    80001c08:	020046b7          	lui	a3,0x2004
    80001c0c:	00d787b3          	add	a5,a5,a3
    80001c10:	00c585b3          	add	a1,a1,a2
    80001c14:	00371693          	slli	a3,a4,0x3
    80001c18:	00003717          	auipc	a4,0x3
    80001c1c:	b7870713          	addi	a4,a4,-1160 # 80004790 <timer_scratch>
    80001c20:	00b7b023          	sd	a1,0(a5)
    80001c24:	00d70733          	add	a4,a4,a3
    80001c28:	00f73c23          	sd	a5,24(a4)
    80001c2c:	02c73023          	sd	a2,32(a4)
    80001c30:	34071073          	csrw	mscratch,a4
    80001c34:	00000797          	auipc	a5,0x0
    80001c38:	64c78793          	addi	a5,a5,1612 # 80002280 <timervec>
    80001c3c:	30579073          	csrw	mtvec,a5
    80001c40:	300027f3          	csrr	a5,mstatus
    80001c44:	0087e793          	ori	a5,a5,8
    80001c48:	30079073          	csrw	mstatus,a5
    80001c4c:	304027f3          	csrr	a5,mie
    80001c50:	0807e793          	ori	a5,a5,128
    80001c54:	30479073          	csrw	mie,a5
    80001c58:	00813403          	ld	s0,8(sp)
    80001c5c:	01010113          	addi	sp,sp,16
    80001c60:	00008067          	ret

0000000080001c64 <system_main>:
    80001c64:	fe010113          	addi	sp,sp,-32
    80001c68:	00813823          	sd	s0,16(sp)
    80001c6c:	00913423          	sd	s1,8(sp)
    80001c70:	00113c23          	sd	ra,24(sp)
    80001c74:	02010413          	addi	s0,sp,32
    80001c78:	00000097          	auipc	ra,0x0
    80001c7c:	0c4080e7          	jalr	196(ra) # 80001d3c <cpuid>
    80001c80:	00003497          	auipc	s1,0x3
    80001c84:	a5048493          	addi	s1,s1,-1456 # 800046d0 <started>
    80001c88:	02050263          	beqz	a0,80001cac <system_main+0x48>
    80001c8c:	0004a783          	lw	a5,0(s1)
    80001c90:	0007879b          	sext.w	a5,a5
    80001c94:	fe078ce3          	beqz	a5,80001c8c <system_main+0x28>
    80001c98:	0ff0000f          	fence
    80001c9c:	00002517          	auipc	a0,0x2
    80001ca0:	3bc50513          	addi	a0,a0,956 # 80004058 <_ZN3TCB25DEFAULT_SYSTEM_STACK_SIZEE+0x38>
    80001ca4:	00001097          	auipc	ra,0x1
    80001ca8:	a78080e7          	jalr	-1416(ra) # 8000271c <panic>
    80001cac:	00001097          	auipc	ra,0x1
    80001cb0:	9cc080e7          	jalr	-1588(ra) # 80002678 <consoleinit>
    80001cb4:	00001097          	auipc	ra,0x1
    80001cb8:	158080e7          	jalr	344(ra) # 80002e0c <printfinit>
    80001cbc:	00002517          	auipc	a0,0x2
    80001cc0:	47c50513          	addi	a0,a0,1148 # 80004138 <_ZN3TCB25DEFAULT_SYSTEM_STACK_SIZEE+0x118>
    80001cc4:	00001097          	auipc	ra,0x1
    80001cc8:	ab4080e7          	jalr	-1356(ra) # 80002778 <__printf>
    80001ccc:	00002517          	auipc	a0,0x2
    80001cd0:	35c50513          	addi	a0,a0,860 # 80004028 <_ZN3TCB25DEFAULT_SYSTEM_STACK_SIZEE+0x8>
    80001cd4:	00001097          	auipc	ra,0x1
    80001cd8:	aa4080e7          	jalr	-1372(ra) # 80002778 <__printf>
    80001cdc:	00002517          	auipc	a0,0x2
    80001ce0:	45c50513          	addi	a0,a0,1116 # 80004138 <_ZN3TCB25DEFAULT_SYSTEM_STACK_SIZEE+0x118>
    80001ce4:	00001097          	auipc	ra,0x1
    80001ce8:	a94080e7          	jalr	-1388(ra) # 80002778 <__printf>
    80001cec:	00001097          	auipc	ra,0x1
    80001cf0:	4ac080e7          	jalr	1196(ra) # 80003198 <kinit>
    80001cf4:	00000097          	auipc	ra,0x0
    80001cf8:	148080e7          	jalr	328(ra) # 80001e3c <trapinit>
    80001cfc:	00000097          	auipc	ra,0x0
    80001d00:	16c080e7          	jalr	364(ra) # 80001e68 <trapinithart>
    80001d04:	00000097          	auipc	ra,0x0
    80001d08:	5bc080e7          	jalr	1468(ra) # 800022c0 <plicinit>
    80001d0c:	00000097          	auipc	ra,0x0
    80001d10:	5dc080e7          	jalr	1500(ra) # 800022e8 <plicinithart>
    80001d14:	00000097          	auipc	ra,0x0
    80001d18:	078080e7          	jalr	120(ra) # 80001d8c <userinit>
    80001d1c:	0ff0000f          	fence
    80001d20:	00100793          	li	a5,1
    80001d24:	00002517          	auipc	a0,0x2
    80001d28:	31c50513          	addi	a0,a0,796 # 80004040 <_ZN3TCB25DEFAULT_SYSTEM_STACK_SIZEE+0x20>
    80001d2c:	00f4a023          	sw	a5,0(s1)
    80001d30:	00001097          	auipc	ra,0x1
    80001d34:	a48080e7          	jalr	-1464(ra) # 80002778 <__printf>
    80001d38:	0000006f          	j	80001d38 <system_main+0xd4>

0000000080001d3c <cpuid>:
    80001d3c:	ff010113          	addi	sp,sp,-16
    80001d40:	00813423          	sd	s0,8(sp)
    80001d44:	01010413          	addi	s0,sp,16
    80001d48:	00020513          	mv	a0,tp
    80001d4c:	00813403          	ld	s0,8(sp)
    80001d50:	0005051b          	sext.w	a0,a0
    80001d54:	01010113          	addi	sp,sp,16
    80001d58:	00008067          	ret

0000000080001d5c <mycpu>:
    80001d5c:	ff010113          	addi	sp,sp,-16
    80001d60:	00813423          	sd	s0,8(sp)
    80001d64:	01010413          	addi	s0,sp,16
    80001d68:	00020793          	mv	a5,tp
    80001d6c:	00813403          	ld	s0,8(sp)
    80001d70:	0007879b          	sext.w	a5,a5
    80001d74:	00779793          	slli	a5,a5,0x7
    80001d78:	00004517          	auipc	a0,0x4
    80001d7c:	a4850513          	addi	a0,a0,-1464 # 800057c0 <cpus>
    80001d80:	00f50533          	add	a0,a0,a5
    80001d84:	01010113          	addi	sp,sp,16
    80001d88:	00008067          	ret

0000000080001d8c <userinit>:
    80001d8c:	ff010113          	addi	sp,sp,-16
    80001d90:	00813423          	sd	s0,8(sp)
    80001d94:	01010413          	addi	s0,sp,16
    80001d98:	00813403          	ld	s0,8(sp)
    80001d9c:	01010113          	addi	sp,sp,16
    80001da0:	fffff317          	auipc	t1,0xfffff
    80001da4:	53c30067          	jr	1340(t1) # 800012dc <main>

0000000080001da8 <either_copyout>:
    80001da8:	ff010113          	addi	sp,sp,-16
    80001dac:	00813023          	sd	s0,0(sp)
    80001db0:	00113423          	sd	ra,8(sp)
    80001db4:	01010413          	addi	s0,sp,16
    80001db8:	02051663          	bnez	a0,80001de4 <either_copyout+0x3c>
    80001dbc:	00058513          	mv	a0,a1
    80001dc0:	00060593          	mv	a1,a2
    80001dc4:	0006861b          	sext.w	a2,a3
    80001dc8:	00002097          	auipc	ra,0x2
    80001dcc:	c5c080e7          	jalr	-932(ra) # 80003a24 <__memmove>
    80001dd0:	00813083          	ld	ra,8(sp)
    80001dd4:	00013403          	ld	s0,0(sp)
    80001dd8:	00000513          	li	a0,0
    80001ddc:	01010113          	addi	sp,sp,16
    80001de0:	00008067          	ret
    80001de4:	00002517          	auipc	a0,0x2
    80001de8:	29c50513          	addi	a0,a0,668 # 80004080 <_ZN3TCB25DEFAULT_SYSTEM_STACK_SIZEE+0x60>
    80001dec:	00001097          	auipc	ra,0x1
    80001df0:	930080e7          	jalr	-1744(ra) # 8000271c <panic>

0000000080001df4 <either_copyin>:
    80001df4:	ff010113          	addi	sp,sp,-16
    80001df8:	00813023          	sd	s0,0(sp)
    80001dfc:	00113423          	sd	ra,8(sp)
    80001e00:	01010413          	addi	s0,sp,16
    80001e04:	02059463          	bnez	a1,80001e2c <either_copyin+0x38>
    80001e08:	00060593          	mv	a1,a2
    80001e0c:	0006861b          	sext.w	a2,a3
    80001e10:	00002097          	auipc	ra,0x2
    80001e14:	c14080e7          	jalr	-1004(ra) # 80003a24 <__memmove>
    80001e18:	00813083          	ld	ra,8(sp)
    80001e1c:	00013403          	ld	s0,0(sp)
    80001e20:	00000513          	li	a0,0
    80001e24:	01010113          	addi	sp,sp,16
    80001e28:	00008067          	ret
    80001e2c:	00002517          	auipc	a0,0x2
    80001e30:	27c50513          	addi	a0,a0,636 # 800040a8 <_ZN3TCB25DEFAULT_SYSTEM_STACK_SIZEE+0x88>
    80001e34:	00001097          	auipc	ra,0x1
    80001e38:	8e8080e7          	jalr	-1816(ra) # 8000271c <panic>

0000000080001e3c <trapinit>:
    80001e3c:	ff010113          	addi	sp,sp,-16
    80001e40:	00813423          	sd	s0,8(sp)
    80001e44:	01010413          	addi	s0,sp,16
    80001e48:	00813403          	ld	s0,8(sp)
    80001e4c:	00002597          	auipc	a1,0x2
    80001e50:	28458593          	addi	a1,a1,644 # 800040d0 <_ZN3TCB25DEFAULT_SYSTEM_STACK_SIZEE+0xb0>
    80001e54:	00004517          	auipc	a0,0x4
    80001e58:	9ec50513          	addi	a0,a0,-1556 # 80005840 <tickslock>
    80001e5c:	01010113          	addi	sp,sp,16
    80001e60:	00001317          	auipc	t1,0x1
    80001e64:	5c830067          	jr	1480(t1) # 80003428 <initlock>

0000000080001e68 <trapinithart>:
    80001e68:	ff010113          	addi	sp,sp,-16
    80001e6c:	00813423          	sd	s0,8(sp)
    80001e70:	01010413          	addi	s0,sp,16
    80001e74:	00000797          	auipc	a5,0x0
    80001e78:	2fc78793          	addi	a5,a5,764 # 80002170 <kernelvec>
    80001e7c:	10579073          	csrw	stvec,a5
    80001e80:	00813403          	ld	s0,8(sp)
    80001e84:	01010113          	addi	sp,sp,16
    80001e88:	00008067          	ret

0000000080001e8c <usertrap>:
    80001e8c:	ff010113          	addi	sp,sp,-16
    80001e90:	00813423          	sd	s0,8(sp)
    80001e94:	01010413          	addi	s0,sp,16
    80001e98:	00813403          	ld	s0,8(sp)
    80001e9c:	01010113          	addi	sp,sp,16
    80001ea0:	00008067          	ret

0000000080001ea4 <usertrapret>:
    80001ea4:	ff010113          	addi	sp,sp,-16
    80001ea8:	00813423          	sd	s0,8(sp)
    80001eac:	01010413          	addi	s0,sp,16
    80001eb0:	00813403          	ld	s0,8(sp)
    80001eb4:	01010113          	addi	sp,sp,16
    80001eb8:	00008067          	ret

0000000080001ebc <kerneltrap>:
    80001ebc:	fe010113          	addi	sp,sp,-32
    80001ec0:	00813823          	sd	s0,16(sp)
    80001ec4:	00113c23          	sd	ra,24(sp)
    80001ec8:	00913423          	sd	s1,8(sp)
    80001ecc:	02010413          	addi	s0,sp,32
    80001ed0:	142025f3          	csrr	a1,scause
    80001ed4:	100027f3          	csrr	a5,sstatus
    80001ed8:	0027f793          	andi	a5,a5,2
    80001edc:	10079c63          	bnez	a5,80001ff4 <kerneltrap+0x138>
    80001ee0:	142027f3          	csrr	a5,scause
    80001ee4:	0207ce63          	bltz	a5,80001f20 <kerneltrap+0x64>
    80001ee8:	00002517          	auipc	a0,0x2
    80001eec:	23050513          	addi	a0,a0,560 # 80004118 <_ZN3TCB25DEFAULT_SYSTEM_STACK_SIZEE+0xf8>
    80001ef0:	00001097          	auipc	ra,0x1
    80001ef4:	888080e7          	jalr	-1912(ra) # 80002778 <__printf>
    80001ef8:	141025f3          	csrr	a1,sepc
    80001efc:	14302673          	csrr	a2,stval
    80001f00:	00002517          	auipc	a0,0x2
    80001f04:	22850513          	addi	a0,a0,552 # 80004128 <_ZN3TCB25DEFAULT_SYSTEM_STACK_SIZEE+0x108>
    80001f08:	00001097          	auipc	ra,0x1
    80001f0c:	870080e7          	jalr	-1936(ra) # 80002778 <__printf>
    80001f10:	00002517          	auipc	a0,0x2
    80001f14:	23050513          	addi	a0,a0,560 # 80004140 <_ZN3TCB25DEFAULT_SYSTEM_STACK_SIZEE+0x120>
    80001f18:	00001097          	auipc	ra,0x1
    80001f1c:	804080e7          	jalr	-2044(ra) # 8000271c <panic>
    80001f20:	0ff7f713          	andi	a4,a5,255
    80001f24:	00900693          	li	a3,9
    80001f28:	04d70063          	beq	a4,a3,80001f68 <kerneltrap+0xac>
    80001f2c:	fff00713          	li	a4,-1
    80001f30:	03f71713          	slli	a4,a4,0x3f
    80001f34:	00170713          	addi	a4,a4,1
    80001f38:	fae798e3          	bne	a5,a4,80001ee8 <kerneltrap+0x2c>
    80001f3c:	00000097          	auipc	ra,0x0
    80001f40:	e00080e7          	jalr	-512(ra) # 80001d3c <cpuid>
    80001f44:	06050663          	beqz	a0,80001fb0 <kerneltrap+0xf4>
    80001f48:	144027f3          	csrr	a5,sip
    80001f4c:	ffd7f793          	andi	a5,a5,-3
    80001f50:	14479073          	csrw	sip,a5
    80001f54:	01813083          	ld	ra,24(sp)
    80001f58:	01013403          	ld	s0,16(sp)
    80001f5c:	00813483          	ld	s1,8(sp)
    80001f60:	02010113          	addi	sp,sp,32
    80001f64:	00008067          	ret
    80001f68:	00000097          	auipc	ra,0x0
    80001f6c:	3cc080e7          	jalr	972(ra) # 80002334 <plic_claim>
    80001f70:	00a00793          	li	a5,10
    80001f74:	00050493          	mv	s1,a0
    80001f78:	06f50863          	beq	a0,a5,80001fe8 <kerneltrap+0x12c>
    80001f7c:	fc050ce3          	beqz	a0,80001f54 <kerneltrap+0x98>
    80001f80:	00050593          	mv	a1,a0
    80001f84:	00002517          	auipc	a0,0x2
    80001f88:	17450513          	addi	a0,a0,372 # 800040f8 <_ZN3TCB25DEFAULT_SYSTEM_STACK_SIZEE+0xd8>
    80001f8c:	00000097          	auipc	ra,0x0
    80001f90:	7ec080e7          	jalr	2028(ra) # 80002778 <__printf>
    80001f94:	01013403          	ld	s0,16(sp)
    80001f98:	01813083          	ld	ra,24(sp)
    80001f9c:	00048513          	mv	a0,s1
    80001fa0:	00813483          	ld	s1,8(sp)
    80001fa4:	02010113          	addi	sp,sp,32
    80001fa8:	00000317          	auipc	t1,0x0
    80001fac:	3c430067          	jr	964(t1) # 8000236c <plic_complete>
    80001fb0:	00004517          	auipc	a0,0x4
    80001fb4:	89050513          	addi	a0,a0,-1904 # 80005840 <tickslock>
    80001fb8:	00001097          	auipc	ra,0x1
    80001fbc:	494080e7          	jalr	1172(ra) # 8000344c <acquire>
    80001fc0:	00002717          	auipc	a4,0x2
    80001fc4:	71470713          	addi	a4,a4,1812 # 800046d4 <ticks>
    80001fc8:	00072783          	lw	a5,0(a4)
    80001fcc:	00004517          	auipc	a0,0x4
    80001fd0:	87450513          	addi	a0,a0,-1932 # 80005840 <tickslock>
    80001fd4:	0017879b          	addiw	a5,a5,1
    80001fd8:	00f72023          	sw	a5,0(a4)
    80001fdc:	00001097          	auipc	ra,0x1
    80001fe0:	53c080e7          	jalr	1340(ra) # 80003518 <release>
    80001fe4:	f65ff06f          	j	80001f48 <kerneltrap+0x8c>
    80001fe8:	00001097          	auipc	ra,0x1
    80001fec:	098080e7          	jalr	152(ra) # 80003080 <uartintr>
    80001ff0:	fa5ff06f          	j	80001f94 <kerneltrap+0xd8>
    80001ff4:	00002517          	auipc	a0,0x2
    80001ff8:	0e450513          	addi	a0,a0,228 # 800040d8 <_ZN3TCB25DEFAULT_SYSTEM_STACK_SIZEE+0xb8>
    80001ffc:	00000097          	auipc	ra,0x0
    80002000:	720080e7          	jalr	1824(ra) # 8000271c <panic>

0000000080002004 <clockintr>:
    80002004:	fe010113          	addi	sp,sp,-32
    80002008:	00813823          	sd	s0,16(sp)
    8000200c:	00913423          	sd	s1,8(sp)
    80002010:	00113c23          	sd	ra,24(sp)
    80002014:	02010413          	addi	s0,sp,32
    80002018:	00004497          	auipc	s1,0x4
    8000201c:	82848493          	addi	s1,s1,-2008 # 80005840 <tickslock>
    80002020:	00048513          	mv	a0,s1
    80002024:	00001097          	auipc	ra,0x1
    80002028:	428080e7          	jalr	1064(ra) # 8000344c <acquire>
    8000202c:	00002717          	auipc	a4,0x2
    80002030:	6a870713          	addi	a4,a4,1704 # 800046d4 <ticks>
    80002034:	00072783          	lw	a5,0(a4)
    80002038:	01013403          	ld	s0,16(sp)
    8000203c:	01813083          	ld	ra,24(sp)
    80002040:	00048513          	mv	a0,s1
    80002044:	0017879b          	addiw	a5,a5,1
    80002048:	00813483          	ld	s1,8(sp)
    8000204c:	00f72023          	sw	a5,0(a4)
    80002050:	02010113          	addi	sp,sp,32
    80002054:	00001317          	auipc	t1,0x1
    80002058:	4c430067          	jr	1220(t1) # 80003518 <release>

000000008000205c <devintr>:
    8000205c:	142027f3          	csrr	a5,scause
    80002060:	00000513          	li	a0,0
    80002064:	0007c463          	bltz	a5,8000206c <devintr+0x10>
    80002068:	00008067          	ret
    8000206c:	fe010113          	addi	sp,sp,-32
    80002070:	00813823          	sd	s0,16(sp)
    80002074:	00113c23          	sd	ra,24(sp)
    80002078:	00913423          	sd	s1,8(sp)
    8000207c:	02010413          	addi	s0,sp,32
    80002080:	0ff7f713          	andi	a4,a5,255
    80002084:	00900693          	li	a3,9
    80002088:	04d70c63          	beq	a4,a3,800020e0 <devintr+0x84>
    8000208c:	fff00713          	li	a4,-1
    80002090:	03f71713          	slli	a4,a4,0x3f
    80002094:	00170713          	addi	a4,a4,1
    80002098:	00e78c63          	beq	a5,a4,800020b0 <devintr+0x54>
    8000209c:	01813083          	ld	ra,24(sp)
    800020a0:	01013403          	ld	s0,16(sp)
    800020a4:	00813483          	ld	s1,8(sp)
    800020a8:	02010113          	addi	sp,sp,32
    800020ac:	00008067          	ret
    800020b0:	00000097          	auipc	ra,0x0
    800020b4:	c8c080e7          	jalr	-884(ra) # 80001d3c <cpuid>
    800020b8:	06050663          	beqz	a0,80002124 <devintr+0xc8>
    800020bc:	144027f3          	csrr	a5,sip
    800020c0:	ffd7f793          	andi	a5,a5,-3
    800020c4:	14479073          	csrw	sip,a5
    800020c8:	01813083          	ld	ra,24(sp)
    800020cc:	01013403          	ld	s0,16(sp)
    800020d0:	00813483          	ld	s1,8(sp)
    800020d4:	00200513          	li	a0,2
    800020d8:	02010113          	addi	sp,sp,32
    800020dc:	00008067          	ret
    800020e0:	00000097          	auipc	ra,0x0
    800020e4:	254080e7          	jalr	596(ra) # 80002334 <plic_claim>
    800020e8:	00a00793          	li	a5,10
    800020ec:	00050493          	mv	s1,a0
    800020f0:	06f50663          	beq	a0,a5,8000215c <devintr+0x100>
    800020f4:	00100513          	li	a0,1
    800020f8:	fa0482e3          	beqz	s1,8000209c <devintr+0x40>
    800020fc:	00048593          	mv	a1,s1
    80002100:	00002517          	auipc	a0,0x2
    80002104:	ff850513          	addi	a0,a0,-8 # 800040f8 <_ZN3TCB25DEFAULT_SYSTEM_STACK_SIZEE+0xd8>
    80002108:	00000097          	auipc	ra,0x0
    8000210c:	670080e7          	jalr	1648(ra) # 80002778 <__printf>
    80002110:	00048513          	mv	a0,s1
    80002114:	00000097          	auipc	ra,0x0
    80002118:	258080e7          	jalr	600(ra) # 8000236c <plic_complete>
    8000211c:	00100513          	li	a0,1
    80002120:	f7dff06f          	j	8000209c <devintr+0x40>
    80002124:	00003517          	auipc	a0,0x3
    80002128:	71c50513          	addi	a0,a0,1820 # 80005840 <tickslock>
    8000212c:	00001097          	auipc	ra,0x1
    80002130:	320080e7          	jalr	800(ra) # 8000344c <acquire>
    80002134:	00002717          	auipc	a4,0x2
    80002138:	5a070713          	addi	a4,a4,1440 # 800046d4 <ticks>
    8000213c:	00072783          	lw	a5,0(a4)
    80002140:	00003517          	auipc	a0,0x3
    80002144:	70050513          	addi	a0,a0,1792 # 80005840 <tickslock>
    80002148:	0017879b          	addiw	a5,a5,1
    8000214c:	00f72023          	sw	a5,0(a4)
    80002150:	00001097          	auipc	ra,0x1
    80002154:	3c8080e7          	jalr	968(ra) # 80003518 <release>
    80002158:	f65ff06f          	j	800020bc <devintr+0x60>
    8000215c:	00001097          	auipc	ra,0x1
    80002160:	f24080e7          	jalr	-220(ra) # 80003080 <uartintr>
    80002164:	fadff06f          	j	80002110 <devintr+0xb4>
	...

0000000080002170 <kernelvec>:
    80002170:	f0010113          	addi	sp,sp,-256
    80002174:	00113023          	sd	ra,0(sp)
    80002178:	00213423          	sd	sp,8(sp)
    8000217c:	00313823          	sd	gp,16(sp)
    80002180:	00413c23          	sd	tp,24(sp)
    80002184:	02513023          	sd	t0,32(sp)
    80002188:	02613423          	sd	t1,40(sp)
    8000218c:	02713823          	sd	t2,48(sp)
    80002190:	02813c23          	sd	s0,56(sp)
    80002194:	04913023          	sd	s1,64(sp)
    80002198:	04a13423          	sd	a0,72(sp)
    8000219c:	04b13823          	sd	a1,80(sp)
    800021a0:	04c13c23          	sd	a2,88(sp)
    800021a4:	06d13023          	sd	a3,96(sp)
    800021a8:	06e13423          	sd	a4,104(sp)
    800021ac:	06f13823          	sd	a5,112(sp)
    800021b0:	07013c23          	sd	a6,120(sp)
    800021b4:	09113023          	sd	a7,128(sp)
    800021b8:	09213423          	sd	s2,136(sp)
    800021bc:	09313823          	sd	s3,144(sp)
    800021c0:	09413c23          	sd	s4,152(sp)
    800021c4:	0b513023          	sd	s5,160(sp)
    800021c8:	0b613423          	sd	s6,168(sp)
    800021cc:	0b713823          	sd	s7,176(sp)
    800021d0:	0b813c23          	sd	s8,184(sp)
    800021d4:	0d913023          	sd	s9,192(sp)
    800021d8:	0da13423          	sd	s10,200(sp)
    800021dc:	0db13823          	sd	s11,208(sp)
    800021e0:	0dc13c23          	sd	t3,216(sp)
    800021e4:	0fd13023          	sd	t4,224(sp)
    800021e8:	0fe13423          	sd	t5,232(sp)
    800021ec:	0ff13823          	sd	t6,240(sp)
    800021f0:	ccdff0ef          	jal	ra,80001ebc <kerneltrap>
    800021f4:	00013083          	ld	ra,0(sp)
    800021f8:	00813103          	ld	sp,8(sp)
    800021fc:	01013183          	ld	gp,16(sp)
    80002200:	02013283          	ld	t0,32(sp)
    80002204:	02813303          	ld	t1,40(sp)
    80002208:	03013383          	ld	t2,48(sp)
    8000220c:	03813403          	ld	s0,56(sp)
    80002210:	04013483          	ld	s1,64(sp)
    80002214:	04813503          	ld	a0,72(sp)
    80002218:	05013583          	ld	a1,80(sp)
    8000221c:	05813603          	ld	a2,88(sp)
    80002220:	06013683          	ld	a3,96(sp)
    80002224:	06813703          	ld	a4,104(sp)
    80002228:	07013783          	ld	a5,112(sp)
    8000222c:	07813803          	ld	a6,120(sp)
    80002230:	08013883          	ld	a7,128(sp)
    80002234:	08813903          	ld	s2,136(sp)
    80002238:	09013983          	ld	s3,144(sp)
    8000223c:	09813a03          	ld	s4,152(sp)
    80002240:	0a013a83          	ld	s5,160(sp)
    80002244:	0a813b03          	ld	s6,168(sp)
    80002248:	0b013b83          	ld	s7,176(sp)
    8000224c:	0b813c03          	ld	s8,184(sp)
    80002250:	0c013c83          	ld	s9,192(sp)
    80002254:	0c813d03          	ld	s10,200(sp)
    80002258:	0d013d83          	ld	s11,208(sp)
    8000225c:	0d813e03          	ld	t3,216(sp)
    80002260:	0e013e83          	ld	t4,224(sp)
    80002264:	0e813f03          	ld	t5,232(sp)
    80002268:	0f013f83          	ld	t6,240(sp)
    8000226c:	10010113          	addi	sp,sp,256
    80002270:	10200073          	sret
    80002274:	00000013          	nop
    80002278:	00000013          	nop
    8000227c:	00000013          	nop

0000000080002280 <timervec>:
    80002280:	34051573          	csrrw	a0,mscratch,a0
    80002284:	00b53023          	sd	a1,0(a0)
    80002288:	00c53423          	sd	a2,8(a0)
    8000228c:	00d53823          	sd	a3,16(a0)
    80002290:	01853583          	ld	a1,24(a0)
    80002294:	02053603          	ld	a2,32(a0)
    80002298:	0005b683          	ld	a3,0(a1)
    8000229c:	00c686b3          	add	a3,a3,a2
    800022a0:	00d5b023          	sd	a3,0(a1)
    800022a4:	00200593          	li	a1,2
    800022a8:	14459073          	csrw	sip,a1
    800022ac:	01053683          	ld	a3,16(a0)
    800022b0:	00853603          	ld	a2,8(a0)
    800022b4:	00053583          	ld	a1,0(a0)
    800022b8:	34051573          	csrrw	a0,mscratch,a0
    800022bc:	30200073          	mret

00000000800022c0 <plicinit>:
    800022c0:	ff010113          	addi	sp,sp,-16
    800022c4:	00813423          	sd	s0,8(sp)
    800022c8:	01010413          	addi	s0,sp,16
    800022cc:	00813403          	ld	s0,8(sp)
    800022d0:	0c0007b7          	lui	a5,0xc000
    800022d4:	00100713          	li	a4,1
    800022d8:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    800022dc:	00e7a223          	sw	a4,4(a5)
    800022e0:	01010113          	addi	sp,sp,16
    800022e4:	00008067          	ret

00000000800022e8 <plicinithart>:
    800022e8:	ff010113          	addi	sp,sp,-16
    800022ec:	00813023          	sd	s0,0(sp)
    800022f0:	00113423          	sd	ra,8(sp)
    800022f4:	01010413          	addi	s0,sp,16
    800022f8:	00000097          	auipc	ra,0x0
    800022fc:	a44080e7          	jalr	-1468(ra) # 80001d3c <cpuid>
    80002300:	0085171b          	slliw	a4,a0,0x8
    80002304:	0c0027b7          	lui	a5,0xc002
    80002308:	00e787b3          	add	a5,a5,a4
    8000230c:	40200713          	li	a4,1026
    80002310:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80002314:	00813083          	ld	ra,8(sp)
    80002318:	00013403          	ld	s0,0(sp)
    8000231c:	00d5151b          	slliw	a0,a0,0xd
    80002320:	0c2017b7          	lui	a5,0xc201
    80002324:	00a78533          	add	a0,a5,a0
    80002328:	00052023          	sw	zero,0(a0)
    8000232c:	01010113          	addi	sp,sp,16
    80002330:	00008067          	ret

0000000080002334 <plic_claim>:
    80002334:	ff010113          	addi	sp,sp,-16
    80002338:	00813023          	sd	s0,0(sp)
    8000233c:	00113423          	sd	ra,8(sp)
    80002340:	01010413          	addi	s0,sp,16
    80002344:	00000097          	auipc	ra,0x0
    80002348:	9f8080e7          	jalr	-1544(ra) # 80001d3c <cpuid>
    8000234c:	00813083          	ld	ra,8(sp)
    80002350:	00013403          	ld	s0,0(sp)
    80002354:	00d5151b          	slliw	a0,a0,0xd
    80002358:	0c2017b7          	lui	a5,0xc201
    8000235c:	00a78533          	add	a0,a5,a0
    80002360:	00452503          	lw	a0,4(a0)
    80002364:	01010113          	addi	sp,sp,16
    80002368:	00008067          	ret

000000008000236c <plic_complete>:
    8000236c:	fe010113          	addi	sp,sp,-32
    80002370:	00813823          	sd	s0,16(sp)
    80002374:	00913423          	sd	s1,8(sp)
    80002378:	00113c23          	sd	ra,24(sp)
    8000237c:	02010413          	addi	s0,sp,32
    80002380:	00050493          	mv	s1,a0
    80002384:	00000097          	auipc	ra,0x0
    80002388:	9b8080e7          	jalr	-1608(ra) # 80001d3c <cpuid>
    8000238c:	01813083          	ld	ra,24(sp)
    80002390:	01013403          	ld	s0,16(sp)
    80002394:	00d5179b          	slliw	a5,a0,0xd
    80002398:	0c201737          	lui	a4,0xc201
    8000239c:	00f707b3          	add	a5,a4,a5
    800023a0:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    800023a4:	00813483          	ld	s1,8(sp)
    800023a8:	02010113          	addi	sp,sp,32
    800023ac:	00008067          	ret

00000000800023b0 <consolewrite>:
    800023b0:	fb010113          	addi	sp,sp,-80
    800023b4:	04813023          	sd	s0,64(sp)
    800023b8:	04113423          	sd	ra,72(sp)
    800023bc:	02913c23          	sd	s1,56(sp)
    800023c0:	03213823          	sd	s2,48(sp)
    800023c4:	03313423          	sd	s3,40(sp)
    800023c8:	03413023          	sd	s4,32(sp)
    800023cc:	01513c23          	sd	s5,24(sp)
    800023d0:	05010413          	addi	s0,sp,80
    800023d4:	06c05c63          	blez	a2,8000244c <consolewrite+0x9c>
    800023d8:	00060993          	mv	s3,a2
    800023dc:	00050a13          	mv	s4,a0
    800023e0:	00058493          	mv	s1,a1
    800023e4:	00000913          	li	s2,0
    800023e8:	fff00a93          	li	s5,-1
    800023ec:	01c0006f          	j	80002408 <consolewrite+0x58>
    800023f0:	fbf44503          	lbu	a0,-65(s0)
    800023f4:	0019091b          	addiw	s2,s2,1
    800023f8:	00148493          	addi	s1,s1,1
    800023fc:	00001097          	auipc	ra,0x1
    80002400:	a9c080e7          	jalr	-1380(ra) # 80002e98 <uartputc>
    80002404:	03298063          	beq	s3,s2,80002424 <consolewrite+0x74>
    80002408:	00048613          	mv	a2,s1
    8000240c:	00100693          	li	a3,1
    80002410:	000a0593          	mv	a1,s4
    80002414:	fbf40513          	addi	a0,s0,-65
    80002418:	00000097          	auipc	ra,0x0
    8000241c:	9dc080e7          	jalr	-1572(ra) # 80001df4 <either_copyin>
    80002420:	fd5518e3          	bne	a0,s5,800023f0 <consolewrite+0x40>
    80002424:	04813083          	ld	ra,72(sp)
    80002428:	04013403          	ld	s0,64(sp)
    8000242c:	03813483          	ld	s1,56(sp)
    80002430:	02813983          	ld	s3,40(sp)
    80002434:	02013a03          	ld	s4,32(sp)
    80002438:	01813a83          	ld	s5,24(sp)
    8000243c:	00090513          	mv	a0,s2
    80002440:	03013903          	ld	s2,48(sp)
    80002444:	05010113          	addi	sp,sp,80
    80002448:	00008067          	ret
    8000244c:	00000913          	li	s2,0
    80002450:	fd5ff06f          	j	80002424 <consolewrite+0x74>

0000000080002454 <consoleread>:
    80002454:	f9010113          	addi	sp,sp,-112
    80002458:	06813023          	sd	s0,96(sp)
    8000245c:	04913c23          	sd	s1,88(sp)
    80002460:	05213823          	sd	s2,80(sp)
    80002464:	05313423          	sd	s3,72(sp)
    80002468:	05413023          	sd	s4,64(sp)
    8000246c:	03513c23          	sd	s5,56(sp)
    80002470:	03613823          	sd	s6,48(sp)
    80002474:	03713423          	sd	s7,40(sp)
    80002478:	03813023          	sd	s8,32(sp)
    8000247c:	06113423          	sd	ra,104(sp)
    80002480:	01913c23          	sd	s9,24(sp)
    80002484:	07010413          	addi	s0,sp,112
    80002488:	00060b93          	mv	s7,a2
    8000248c:	00050913          	mv	s2,a0
    80002490:	00058c13          	mv	s8,a1
    80002494:	00060b1b          	sext.w	s6,a2
    80002498:	00003497          	auipc	s1,0x3
    8000249c:	3c048493          	addi	s1,s1,960 # 80005858 <cons>
    800024a0:	00400993          	li	s3,4
    800024a4:	fff00a13          	li	s4,-1
    800024a8:	00a00a93          	li	s5,10
    800024ac:	05705e63          	blez	s7,80002508 <consoleread+0xb4>
    800024b0:	09c4a703          	lw	a4,156(s1)
    800024b4:	0984a783          	lw	a5,152(s1)
    800024b8:	0007071b          	sext.w	a4,a4
    800024bc:	08e78463          	beq	a5,a4,80002544 <consoleread+0xf0>
    800024c0:	07f7f713          	andi	a4,a5,127
    800024c4:	00e48733          	add	a4,s1,a4
    800024c8:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    800024cc:	0017869b          	addiw	a3,a5,1
    800024d0:	08d4ac23          	sw	a3,152(s1)
    800024d4:	00070c9b          	sext.w	s9,a4
    800024d8:	0b370663          	beq	a4,s3,80002584 <consoleread+0x130>
    800024dc:	00100693          	li	a3,1
    800024e0:	f9f40613          	addi	a2,s0,-97
    800024e4:	000c0593          	mv	a1,s8
    800024e8:	00090513          	mv	a0,s2
    800024ec:	f8e40fa3          	sb	a4,-97(s0)
    800024f0:	00000097          	auipc	ra,0x0
    800024f4:	8b8080e7          	jalr	-1864(ra) # 80001da8 <either_copyout>
    800024f8:	01450863          	beq	a0,s4,80002508 <consoleread+0xb4>
    800024fc:	001c0c13          	addi	s8,s8,1
    80002500:	fffb8b9b          	addiw	s7,s7,-1
    80002504:	fb5c94e3          	bne	s9,s5,800024ac <consoleread+0x58>
    80002508:	000b851b          	sext.w	a0,s7
    8000250c:	06813083          	ld	ra,104(sp)
    80002510:	06013403          	ld	s0,96(sp)
    80002514:	05813483          	ld	s1,88(sp)
    80002518:	05013903          	ld	s2,80(sp)
    8000251c:	04813983          	ld	s3,72(sp)
    80002520:	04013a03          	ld	s4,64(sp)
    80002524:	03813a83          	ld	s5,56(sp)
    80002528:	02813b83          	ld	s7,40(sp)
    8000252c:	02013c03          	ld	s8,32(sp)
    80002530:	01813c83          	ld	s9,24(sp)
    80002534:	40ab053b          	subw	a0,s6,a0
    80002538:	03013b03          	ld	s6,48(sp)
    8000253c:	07010113          	addi	sp,sp,112
    80002540:	00008067          	ret
    80002544:	00001097          	auipc	ra,0x1
    80002548:	1d8080e7          	jalr	472(ra) # 8000371c <push_on>
    8000254c:	0984a703          	lw	a4,152(s1)
    80002550:	09c4a783          	lw	a5,156(s1)
    80002554:	0007879b          	sext.w	a5,a5
    80002558:	fef70ce3          	beq	a4,a5,80002550 <consoleread+0xfc>
    8000255c:	00001097          	auipc	ra,0x1
    80002560:	234080e7          	jalr	564(ra) # 80003790 <pop_on>
    80002564:	0984a783          	lw	a5,152(s1)
    80002568:	07f7f713          	andi	a4,a5,127
    8000256c:	00e48733          	add	a4,s1,a4
    80002570:	01874703          	lbu	a4,24(a4)
    80002574:	0017869b          	addiw	a3,a5,1
    80002578:	08d4ac23          	sw	a3,152(s1)
    8000257c:	00070c9b          	sext.w	s9,a4
    80002580:	f5371ee3          	bne	a4,s3,800024dc <consoleread+0x88>
    80002584:	000b851b          	sext.w	a0,s7
    80002588:	f96bf2e3          	bgeu	s7,s6,8000250c <consoleread+0xb8>
    8000258c:	08f4ac23          	sw	a5,152(s1)
    80002590:	f7dff06f          	j	8000250c <consoleread+0xb8>

0000000080002594 <consputc>:
    80002594:	10000793          	li	a5,256
    80002598:	00f50663          	beq	a0,a5,800025a4 <consputc+0x10>
    8000259c:	00001317          	auipc	t1,0x1
    800025a0:	9f430067          	jr	-1548(t1) # 80002f90 <uartputc_sync>
    800025a4:	ff010113          	addi	sp,sp,-16
    800025a8:	00113423          	sd	ra,8(sp)
    800025ac:	00813023          	sd	s0,0(sp)
    800025b0:	01010413          	addi	s0,sp,16
    800025b4:	00800513          	li	a0,8
    800025b8:	00001097          	auipc	ra,0x1
    800025bc:	9d8080e7          	jalr	-1576(ra) # 80002f90 <uartputc_sync>
    800025c0:	02000513          	li	a0,32
    800025c4:	00001097          	auipc	ra,0x1
    800025c8:	9cc080e7          	jalr	-1588(ra) # 80002f90 <uartputc_sync>
    800025cc:	00013403          	ld	s0,0(sp)
    800025d0:	00813083          	ld	ra,8(sp)
    800025d4:	00800513          	li	a0,8
    800025d8:	01010113          	addi	sp,sp,16
    800025dc:	00001317          	auipc	t1,0x1
    800025e0:	9b430067          	jr	-1612(t1) # 80002f90 <uartputc_sync>

00000000800025e4 <consoleintr>:
    800025e4:	fe010113          	addi	sp,sp,-32
    800025e8:	00813823          	sd	s0,16(sp)
    800025ec:	00913423          	sd	s1,8(sp)
    800025f0:	01213023          	sd	s2,0(sp)
    800025f4:	00113c23          	sd	ra,24(sp)
    800025f8:	02010413          	addi	s0,sp,32
    800025fc:	00003917          	auipc	s2,0x3
    80002600:	25c90913          	addi	s2,s2,604 # 80005858 <cons>
    80002604:	00050493          	mv	s1,a0
    80002608:	00090513          	mv	a0,s2
    8000260c:	00001097          	auipc	ra,0x1
    80002610:	e40080e7          	jalr	-448(ra) # 8000344c <acquire>
    80002614:	02048c63          	beqz	s1,8000264c <consoleintr+0x68>
    80002618:	0a092783          	lw	a5,160(s2)
    8000261c:	09892703          	lw	a4,152(s2)
    80002620:	07f00693          	li	a3,127
    80002624:	40e7873b          	subw	a4,a5,a4
    80002628:	02e6e263          	bltu	a3,a4,8000264c <consoleintr+0x68>
    8000262c:	00d00713          	li	a4,13
    80002630:	04e48063          	beq	s1,a4,80002670 <consoleintr+0x8c>
    80002634:	07f7f713          	andi	a4,a5,127
    80002638:	00e90733          	add	a4,s2,a4
    8000263c:	0017879b          	addiw	a5,a5,1
    80002640:	0af92023          	sw	a5,160(s2)
    80002644:	00970c23          	sb	s1,24(a4)
    80002648:	08f92e23          	sw	a5,156(s2)
    8000264c:	01013403          	ld	s0,16(sp)
    80002650:	01813083          	ld	ra,24(sp)
    80002654:	00813483          	ld	s1,8(sp)
    80002658:	00013903          	ld	s2,0(sp)
    8000265c:	00003517          	auipc	a0,0x3
    80002660:	1fc50513          	addi	a0,a0,508 # 80005858 <cons>
    80002664:	02010113          	addi	sp,sp,32
    80002668:	00001317          	auipc	t1,0x1
    8000266c:	eb030067          	jr	-336(t1) # 80003518 <release>
    80002670:	00a00493          	li	s1,10
    80002674:	fc1ff06f          	j	80002634 <consoleintr+0x50>

0000000080002678 <consoleinit>:
    80002678:	fe010113          	addi	sp,sp,-32
    8000267c:	00113c23          	sd	ra,24(sp)
    80002680:	00813823          	sd	s0,16(sp)
    80002684:	00913423          	sd	s1,8(sp)
    80002688:	02010413          	addi	s0,sp,32
    8000268c:	00003497          	auipc	s1,0x3
    80002690:	1cc48493          	addi	s1,s1,460 # 80005858 <cons>
    80002694:	00048513          	mv	a0,s1
    80002698:	00002597          	auipc	a1,0x2
    8000269c:	ab858593          	addi	a1,a1,-1352 # 80004150 <_ZN3TCB25DEFAULT_SYSTEM_STACK_SIZEE+0x130>
    800026a0:	00001097          	auipc	ra,0x1
    800026a4:	d88080e7          	jalr	-632(ra) # 80003428 <initlock>
    800026a8:	00000097          	auipc	ra,0x0
    800026ac:	7ac080e7          	jalr	1964(ra) # 80002e54 <uartinit>
    800026b0:	01813083          	ld	ra,24(sp)
    800026b4:	01013403          	ld	s0,16(sp)
    800026b8:	00000797          	auipc	a5,0x0
    800026bc:	d9c78793          	addi	a5,a5,-612 # 80002454 <consoleread>
    800026c0:	0af4bc23          	sd	a5,184(s1)
    800026c4:	00000797          	auipc	a5,0x0
    800026c8:	cec78793          	addi	a5,a5,-788 # 800023b0 <consolewrite>
    800026cc:	0cf4b023          	sd	a5,192(s1)
    800026d0:	00813483          	ld	s1,8(sp)
    800026d4:	02010113          	addi	sp,sp,32
    800026d8:	00008067          	ret

00000000800026dc <console_read>:
    800026dc:	ff010113          	addi	sp,sp,-16
    800026e0:	00813423          	sd	s0,8(sp)
    800026e4:	01010413          	addi	s0,sp,16
    800026e8:	00813403          	ld	s0,8(sp)
    800026ec:	00003317          	auipc	t1,0x3
    800026f0:	22433303          	ld	t1,548(t1) # 80005910 <devsw+0x10>
    800026f4:	01010113          	addi	sp,sp,16
    800026f8:	00030067          	jr	t1

00000000800026fc <console_write>:
    800026fc:	ff010113          	addi	sp,sp,-16
    80002700:	00813423          	sd	s0,8(sp)
    80002704:	01010413          	addi	s0,sp,16
    80002708:	00813403          	ld	s0,8(sp)
    8000270c:	00003317          	auipc	t1,0x3
    80002710:	20c33303          	ld	t1,524(t1) # 80005918 <devsw+0x18>
    80002714:	01010113          	addi	sp,sp,16
    80002718:	00030067          	jr	t1

000000008000271c <panic>:
    8000271c:	fe010113          	addi	sp,sp,-32
    80002720:	00113c23          	sd	ra,24(sp)
    80002724:	00813823          	sd	s0,16(sp)
    80002728:	00913423          	sd	s1,8(sp)
    8000272c:	02010413          	addi	s0,sp,32
    80002730:	00050493          	mv	s1,a0
    80002734:	00002517          	auipc	a0,0x2
    80002738:	a2450513          	addi	a0,a0,-1500 # 80004158 <_ZN3TCB25DEFAULT_SYSTEM_STACK_SIZEE+0x138>
    8000273c:	00003797          	auipc	a5,0x3
    80002740:	2607ae23          	sw	zero,636(a5) # 800059b8 <pr+0x18>
    80002744:	00000097          	auipc	ra,0x0
    80002748:	034080e7          	jalr	52(ra) # 80002778 <__printf>
    8000274c:	00048513          	mv	a0,s1
    80002750:	00000097          	auipc	ra,0x0
    80002754:	028080e7          	jalr	40(ra) # 80002778 <__printf>
    80002758:	00002517          	auipc	a0,0x2
    8000275c:	9e050513          	addi	a0,a0,-1568 # 80004138 <_ZN3TCB25DEFAULT_SYSTEM_STACK_SIZEE+0x118>
    80002760:	00000097          	auipc	ra,0x0
    80002764:	018080e7          	jalr	24(ra) # 80002778 <__printf>
    80002768:	00100793          	li	a5,1
    8000276c:	00002717          	auipc	a4,0x2
    80002770:	f6f72623          	sw	a5,-148(a4) # 800046d8 <panicked>
    80002774:	0000006f          	j	80002774 <panic+0x58>

0000000080002778 <__printf>:
    80002778:	f3010113          	addi	sp,sp,-208
    8000277c:	08813023          	sd	s0,128(sp)
    80002780:	07313423          	sd	s3,104(sp)
    80002784:	09010413          	addi	s0,sp,144
    80002788:	05813023          	sd	s8,64(sp)
    8000278c:	08113423          	sd	ra,136(sp)
    80002790:	06913c23          	sd	s1,120(sp)
    80002794:	07213823          	sd	s2,112(sp)
    80002798:	07413023          	sd	s4,96(sp)
    8000279c:	05513c23          	sd	s5,88(sp)
    800027a0:	05613823          	sd	s6,80(sp)
    800027a4:	05713423          	sd	s7,72(sp)
    800027a8:	03913c23          	sd	s9,56(sp)
    800027ac:	03a13823          	sd	s10,48(sp)
    800027b0:	03b13423          	sd	s11,40(sp)
    800027b4:	00003317          	auipc	t1,0x3
    800027b8:	1ec30313          	addi	t1,t1,492 # 800059a0 <pr>
    800027bc:	01832c03          	lw	s8,24(t1)
    800027c0:	00b43423          	sd	a1,8(s0)
    800027c4:	00c43823          	sd	a2,16(s0)
    800027c8:	00d43c23          	sd	a3,24(s0)
    800027cc:	02e43023          	sd	a4,32(s0)
    800027d0:	02f43423          	sd	a5,40(s0)
    800027d4:	03043823          	sd	a6,48(s0)
    800027d8:	03143c23          	sd	a7,56(s0)
    800027dc:	00050993          	mv	s3,a0
    800027e0:	4a0c1663          	bnez	s8,80002c8c <__printf+0x514>
    800027e4:	60098c63          	beqz	s3,80002dfc <__printf+0x684>
    800027e8:	0009c503          	lbu	a0,0(s3)
    800027ec:	00840793          	addi	a5,s0,8
    800027f0:	f6f43c23          	sd	a5,-136(s0)
    800027f4:	00000493          	li	s1,0
    800027f8:	22050063          	beqz	a0,80002a18 <__printf+0x2a0>
    800027fc:	00002a37          	lui	s4,0x2
    80002800:	00018ab7          	lui	s5,0x18
    80002804:	000f4b37          	lui	s6,0xf4
    80002808:	00989bb7          	lui	s7,0x989
    8000280c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80002810:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80002814:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80002818:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    8000281c:	00148c9b          	addiw	s9,s1,1
    80002820:	02500793          	li	a5,37
    80002824:	01998933          	add	s2,s3,s9
    80002828:	38f51263          	bne	a0,a5,80002bac <__printf+0x434>
    8000282c:	00094783          	lbu	a5,0(s2)
    80002830:	00078c9b          	sext.w	s9,a5
    80002834:	1e078263          	beqz	a5,80002a18 <__printf+0x2a0>
    80002838:	0024849b          	addiw	s1,s1,2
    8000283c:	07000713          	li	a4,112
    80002840:	00998933          	add	s2,s3,s1
    80002844:	38e78a63          	beq	a5,a4,80002bd8 <__printf+0x460>
    80002848:	20f76863          	bltu	a4,a5,80002a58 <__printf+0x2e0>
    8000284c:	42a78863          	beq	a5,a0,80002c7c <__printf+0x504>
    80002850:	06400713          	li	a4,100
    80002854:	40e79663          	bne	a5,a4,80002c60 <__printf+0x4e8>
    80002858:	f7843783          	ld	a5,-136(s0)
    8000285c:	0007a603          	lw	a2,0(a5)
    80002860:	00878793          	addi	a5,a5,8
    80002864:	f6f43c23          	sd	a5,-136(s0)
    80002868:	42064a63          	bltz	a2,80002c9c <__printf+0x524>
    8000286c:	00a00713          	li	a4,10
    80002870:	02e677bb          	remuw	a5,a2,a4
    80002874:	00002d97          	auipc	s11,0x2
    80002878:	90cd8d93          	addi	s11,s11,-1780 # 80004180 <digits>
    8000287c:	00900593          	li	a1,9
    80002880:	0006051b          	sext.w	a0,a2
    80002884:	00000c93          	li	s9,0
    80002888:	02079793          	slli	a5,a5,0x20
    8000288c:	0207d793          	srli	a5,a5,0x20
    80002890:	00fd87b3          	add	a5,s11,a5
    80002894:	0007c783          	lbu	a5,0(a5)
    80002898:	02e656bb          	divuw	a3,a2,a4
    8000289c:	f8f40023          	sb	a5,-128(s0)
    800028a0:	14c5d863          	bge	a1,a2,800029f0 <__printf+0x278>
    800028a4:	06300593          	li	a1,99
    800028a8:	00100c93          	li	s9,1
    800028ac:	02e6f7bb          	remuw	a5,a3,a4
    800028b0:	02079793          	slli	a5,a5,0x20
    800028b4:	0207d793          	srli	a5,a5,0x20
    800028b8:	00fd87b3          	add	a5,s11,a5
    800028bc:	0007c783          	lbu	a5,0(a5)
    800028c0:	02e6d73b          	divuw	a4,a3,a4
    800028c4:	f8f400a3          	sb	a5,-127(s0)
    800028c8:	12a5f463          	bgeu	a1,a0,800029f0 <__printf+0x278>
    800028cc:	00a00693          	li	a3,10
    800028d0:	00900593          	li	a1,9
    800028d4:	02d777bb          	remuw	a5,a4,a3
    800028d8:	02079793          	slli	a5,a5,0x20
    800028dc:	0207d793          	srli	a5,a5,0x20
    800028e0:	00fd87b3          	add	a5,s11,a5
    800028e4:	0007c503          	lbu	a0,0(a5)
    800028e8:	02d757bb          	divuw	a5,a4,a3
    800028ec:	f8a40123          	sb	a0,-126(s0)
    800028f0:	48e5f263          	bgeu	a1,a4,80002d74 <__printf+0x5fc>
    800028f4:	06300513          	li	a0,99
    800028f8:	02d7f5bb          	remuw	a1,a5,a3
    800028fc:	02059593          	slli	a1,a1,0x20
    80002900:	0205d593          	srli	a1,a1,0x20
    80002904:	00bd85b3          	add	a1,s11,a1
    80002908:	0005c583          	lbu	a1,0(a1)
    8000290c:	02d7d7bb          	divuw	a5,a5,a3
    80002910:	f8b401a3          	sb	a1,-125(s0)
    80002914:	48e57263          	bgeu	a0,a4,80002d98 <__printf+0x620>
    80002918:	3e700513          	li	a0,999
    8000291c:	02d7f5bb          	remuw	a1,a5,a3
    80002920:	02059593          	slli	a1,a1,0x20
    80002924:	0205d593          	srli	a1,a1,0x20
    80002928:	00bd85b3          	add	a1,s11,a1
    8000292c:	0005c583          	lbu	a1,0(a1)
    80002930:	02d7d7bb          	divuw	a5,a5,a3
    80002934:	f8b40223          	sb	a1,-124(s0)
    80002938:	46e57663          	bgeu	a0,a4,80002da4 <__printf+0x62c>
    8000293c:	02d7f5bb          	remuw	a1,a5,a3
    80002940:	02059593          	slli	a1,a1,0x20
    80002944:	0205d593          	srli	a1,a1,0x20
    80002948:	00bd85b3          	add	a1,s11,a1
    8000294c:	0005c583          	lbu	a1,0(a1)
    80002950:	02d7d7bb          	divuw	a5,a5,a3
    80002954:	f8b402a3          	sb	a1,-123(s0)
    80002958:	46ea7863          	bgeu	s4,a4,80002dc8 <__printf+0x650>
    8000295c:	02d7f5bb          	remuw	a1,a5,a3
    80002960:	02059593          	slli	a1,a1,0x20
    80002964:	0205d593          	srli	a1,a1,0x20
    80002968:	00bd85b3          	add	a1,s11,a1
    8000296c:	0005c583          	lbu	a1,0(a1)
    80002970:	02d7d7bb          	divuw	a5,a5,a3
    80002974:	f8b40323          	sb	a1,-122(s0)
    80002978:	3eeaf863          	bgeu	s5,a4,80002d68 <__printf+0x5f0>
    8000297c:	02d7f5bb          	remuw	a1,a5,a3
    80002980:	02059593          	slli	a1,a1,0x20
    80002984:	0205d593          	srli	a1,a1,0x20
    80002988:	00bd85b3          	add	a1,s11,a1
    8000298c:	0005c583          	lbu	a1,0(a1)
    80002990:	02d7d7bb          	divuw	a5,a5,a3
    80002994:	f8b403a3          	sb	a1,-121(s0)
    80002998:	42eb7e63          	bgeu	s6,a4,80002dd4 <__printf+0x65c>
    8000299c:	02d7f5bb          	remuw	a1,a5,a3
    800029a0:	02059593          	slli	a1,a1,0x20
    800029a4:	0205d593          	srli	a1,a1,0x20
    800029a8:	00bd85b3          	add	a1,s11,a1
    800029ac:	0005c583          	lbu	a1,0(a1)
    800029b0:	02d7d7bb          	divuw	a5,a5,a3
    800029b4:	f8b40423          	sb	a1,-120(s0)
    800029b8:	42ebfc63          	bgeu	s7,a4,80002df0 <__printf+0x678>
    800029bc:	02079793          	slli	a5,a5,0x20
    800029c0:	0207d793          	srli	a5,a5,0x20
    800029c4:	00fd8db3          	add	s11,s11,a5
    800029c8:	000dc703          	lbu	a4,0(s11)
    800029cc:	00a00793          	li	a5,10
    800029d0:	00900c93          	li	s9,9
    800029d4:	f8e404a3          	sb	a4,-119(s0)
    800029d8:	00065c63          	bgez	a2,800029f0 <__printf+0x278>
    800029dc:	f9040713          	addi	a4,s0,-112
    800029e0:	00f70733          	add	a4,a4,a5
    800029e4:	02d00693          	li	a3,45
    800029e8:	fed70823          	sb	a3,-16(a4)
    800029ec:	00078c93          	mv	s9,a5
    800029f0:	f8040793          	addi	a5,s0,-128
    800029f4:	01978cb3          	add	s9,a5,s9
    800029f8:	f7f40d13          	addi	s10,s0,-129
    800029fc:	000cc503          	lbu	a0,0(s9)
    80002a00:	fffc8c93          	addi	s9,s9,-1
    80002a04:	00000097          	auipc	ra,0x0
    80002a08:	b90080e7          	jalr	-1136(ra) # 80002594 <consputc>
    80002a0c:	ffac98e3          	bne	s9,s10,800029fc <__printf+0x284>
    80002a10:	00094503          	lbu	a0,0(s2)
    80002a14:	e00514e3          	bnez	a0,8000281c <__printf+0xa4>
    80002a18:	1a0c1663          	bnez	s8,80002bc4 <__printf+0x44c>
    80002a1c:	08813083          	ld	ra,136(sp)
    80002a20:	08013403          	ld	s0,128(sp)
    80002a24:	07813483          	ld	s1,120(sp)
    80002a28:	07013903          	ld	s2,112(sp)
    80002a2c:	06813983          	ld	s3,104(sp)
    80002a30:	06013a03          	ld	s4,96(sp)
    80002a34:	05813a83          	ld	s5,88(sp)
    80002a38:	05013b03          	ld	s6,80(sp)
    80002a3c:	04813b83          	ld	s7,72(sp)
    80002a40:	04013c03          	ld	s8,64(sp)
    80002a44:	03813c83          	ld	s9,56(sp)
    80002a48:	03013d03          	ld	s10,48(sp)
    80002a4c:	02813d83          	ld	s11,40(sp)
    80002a50:	0d010113          	addi	sp,sp,208
    80002a54:	00008067          	ret
    80002a58:	07300713          	li	a4,115
    80002a5c:	1ce78a63          	beq	a5,a4,80002c30 <__printf+0x4b8>
    80002a60:	07800713          	li	a4,120
    80002a64:	1ee79e63          	bne	a5,a4,80002c60 <__printf+0x4e8>
    80002a68:	f7843783          	ld	a5,-136(s0)
    80002a6c:	0007a703          	lw	a4,0(a5)
    80002a70:	00878793          	addi	a5,a5,8
    80002a74:	f6f43c23          	sd	a5,-136(s0)
    80002a78:	28074263          	bltz	a4,80002cfc <__printf+0x584>
    80002a7c:	00001d97          	auipc	s11,0x1
    80002a80:	704d8d93          	addi	s11,s11,1796 # 80004180 <digits>
    80002a84:	00f77793          	andi	a5,a4,15
    80002a88:	00fd87b3          	add	a5,s11,a5
    80002a8c:	0007c683          	lbu	a3,0(a5)
    80002a90:	00f00613          	li	a2,15
    80002a94:	0007079b          	sext.w	a5,a4
    80002a98:	f8d40023          	sb	a3,-128(s0)
    80002a9c:	0047559b          	srliw	a1,a4,0x4
    80002aa0:	0047569b          	srliw	a3,a4,0x4
    80002aa4:	00000c93          	li	s9,0
    80002aa8:	0ee65063          	bge	a2,a4,80002b88 <__printf+0x410>
    80002aac:	00f6f693          	andi	a3,a3,15
    80002ab0:	00dd86b3          	add	a3,s11,a3
    80002ab4:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80002ab8:	0087d79b          	srliw	a5,a5,0x8
    80002abc:	00100c93          	li	s9,1
    80002ac0:	f8d400a3          	sb	a3,-127(s0)
    80002ac4:	0cb67263          	bgeu	a2,a1,80002b88 <__printf+0x410>
    80002ac8:	00f7f693          	andi	a3,a5,15
    80002acc:	00dd86b3          	add	a3,s11,a3
    80002ad0:	0006c583          	lbu	a1,0(a3)
    80002ad4:	00f00613          	li	a2,15
    80002ad8:	0047d69b          	srliw	a3,a5,0x4
    80002adc:	f8b40123          	sb	a1,-126(s0)
    80002ae0:	0047d593          	srli	a1,a5,0x4
    80002ae4:	28f67e63          	bgeu	a2,a5,80002d80 <__printf+0x608>
    80002ae8:	00f6f693          	andi	a3,a3,15
    80002aec:	00dd86b3          	add	a3,s11,a3
    80002af0:	0006c503          	lbu	a0,0(a3)
    80002af4:	0087d813          	srli	a6,a5,0x8
    80002af8:	0087d69b          	srliw	a3,a5,0x8
    80002afc:	f8a401a3          	sb	a0,-125(s0)
    80002b00:	28b67663          	bgeu	a2,a1,80002d8c <__printf+0x614>
    80002b04:	00f6f693          	andi	a3,a3,15
    80002b08:	00dd86b3          	add	a3,s11,a3
    80002b0c:	0006c583          	lbu	a1,0(a3)
    80002b10:	00c7d513          	srli	a0,a5,0xc
    80002b14:	00c7d69b          	srliw	a3,a5,0xc
    80002b18:	f8b40223          	sb	a1,-124(s0)
    80002b1c:	29067a63          	bgeu	a2,a6,80002db0 <__printf+0x638>
    80002b20:	00f6f693          	andi	a3,a3,15
    80002b24:	00dd86b3          	add	a3,s11,a3
    80002b28:	0006c583          	lbu	a1,0(a3)
    80002b2c:	0107d813          	srli	a6,a5,0x10
    80002b30:	0107d69b          	srliw	a3,a5,0x10
    80002b34:	f8b402a3          	sb	a1,-123(s0)
    80002b38:	28a67263          	bgeu	a2,a0,80002dbc <__printf+0x644>
    80002b3c:	00f6f693          	andi	a3,a3,15
    80002b40:	00dd86b3          	add	a3,s11,a3
    80002b44:	0006c683          	lbu	a3,0(a3)
    80002b48:	0147d79b          	srliw	a5,a5,0x14
    80002b4c:	f8d40323          	sb	a3,-122(s0)
    80002b50:	21067663          	bgeu	a2,a6,80002d5c <__printf+0x5e4>
    80002b54:	02079793          	slli	a5,a5,0x20
    80002b58:	0207d793          	srli	a5,a5,0x20
    80002b5c:	00fd8db3          	add	s11,s11,a5
    80002b60:	000dc683          	lbu	a3,0(s11)
    80002b64:	00800793          	li	a5,8
    80002b68:	00700c93          	li	s9,7
    80002b6c:	f8d403a3          	sb	a3,-121(s0)
    80002b70:	00075c63          	bgez	a4,80002b88 <__printf+0x410>
    80002b74:	f9040713          	addi	a4,s0,-112
    80002b78:	00f70733          	add	a4,a4,a5
    80002b7c:	02d00693          	li	a3,45
    80002b80:	fed70823          	sb	a3,-16(a4)
    80002b84:	00078c93          	mv	s9,a5
    80002b88:	f8040793          	addi	a5,s0,-128
    80002b8c:	01978cb3          	add	s9,a5,s9
    80002b90:	f7f40d13          	addi	s10,s0,-129
    80002b94:	000cc503          	lbu	a0,0(s9)
    80002b98:	fffc8c93          	addi	s9,s9,-1
    80002b9c:	00000097          	auipc	ra,0x0
    80002ba0:	9f8080e7          	jalr	-1544(ra) # 80002594 <consputc>
    80002ba4:	ff9d18e3          	bne	s10,s9,80002b94 <__printf+0x41c>
    80002ba8:	0100006f          	j	80002bb8 <__printf+0x440>
    80002bac:	00000097          	auipc	ra,0x0
    80002bb0:	9e8080e7          	jalr	-1560(ra) # 80002594 <consputc>
    80002bb4:	000c8493          	mv	s1,s9
    80002bb8:	00094503          	lbu	a0,0(s2)
    80002bbc:	c60510e3          	bnez	a0,8000281c <__printf+0xa4>
    80002bc0:	e40c0ee3          	beqz	s8,80002a1c <__printf+0x2a4>
    80002bc4:	00003517          	auipc	a0,0x3
    80002bc8:	ddc50513          	addi	a0,a0,-548 # 800059a0 <pr>
    80002bcc:	00001097          	auipc	ra,0x1
    80002bd0:	94c080e7          	jalr	-1716(ra) # 80003518 <release>
    80002bd4:	e49ff06f          	j	80002a1c <__printf+0x2a4>
    80002bd8:	f7843783          	ld	a5,-136(s0)
    80002bdc:	03000513          	li	a0,48
    80002be0:	01000d13          	li	s10,16
    80002be4:	00878713          	addi	a4,a5,8
    80002be8:	0007bc83          	ld	s9,0(a5)
    80002bec:	f6e43c23          	sd	a4,-136(s0)
    80002bf0:	00000097          	auipc	ra,0x0
    80002bf4:	9a4080e7          	jalr	-1628(ra) # 80002594 <consputc>
    80002bf8:	07800513          	li	a0,120
    80002bfc:	00000097          	auipc	ra,0x0
    80002c00:	998080e7          	jalr	-1640(ra) # 80002594 <consputc>
    80002c04:	00001d97          	auipc	s11,0x1
    80002c08:	57cd8d93          	addi	s11,s11,1404 # 80004180 <digits>
    80002c0c:	03ccd793          	srli	a5,s9,0x3c
    80002c10:	00fd87b3          	add	a5,s11,a5
    80002c14:	0007c503          	lbu	a0,0(a5)
    80002c18:	fffd0d1b          	addiw	s10,s10,-1
    80002c1c:	004c9c93          	slli	s9,s9,0x4
    80002c20:	00000097          	auipc	ra,0x0
    80002c24:	974080e7          	jalr	-1676(ra) # 80002594 <consputc>
    80002c28:	fe0d12e3          	bnez	s10,80002c0c <__printf+0x494>
    80002c2c:	f8dff06f          	j	80002bb8 <__printf+0x440>
    80002c30:	f7843783          	ld	a5,-136(s0)
    80002c34:	0007bc83          	ld	s9,0(a5)
    80002c38:	00878793          	addi	a5,a5,8
    80002c3c:	f6f43c23          	sd	a5,-136(s0)
    80002c40:	000c9a63          	bnez	s9,80002c54 <__printf+0x4dc>
    80002c44:	1080006f          	j	80002d4c <__printf+0x5d4>
    80002c48:	001c8c93          	addi	s9,s9,1
    80002c4c:	00000097          	auipc	ra,0x0
    80002c50:	948080e7          	jalr	-1720(ra) # 80002594 <consputc>
    80002c54:	000cc503          	lbu	a0,0(s9)
    80002c58:	fe0518e3          	bnez	a0,80002c48 <__printf+0x4d0>
    80002c5c:	f5dff06f          	j	80002bb8 <__printf+0x440>
    80002c60:	02500513          	li	a0,37
    80002c64:	00000097          	auipc	ra,0x0
    80002c68:	930080e7          	jalr	-1744(ra) # 80002594 <consputc>
    80002c6c:	000c8513          	mv	a0,s9
    80002c70:	00000097          	auipc	ra,0x0
    80002c74:	924080e7          	jalr	-1756(ra) # 80002594 <consputc>
    80002c78:	f41ff06f          	j	80002bb8 <__printf+0x440>
    80002c7c:	02500513          	li	a0,37
    80002c80:	00000097          	auipc	ra,0x0
    80002c84:	914080e7          	jalr	-1772(ra) # 80002594 <consputc>
    80002c88:	f31ff06f          	j	80002bb8 <__printf+0x440>
    80002c8c:	00030513          	mv	a0,t1
    80002c90:	00000097          	auipc	ra,0x0
    80002c94:	7bc080e7          	jalr	1980(ra) # 8000344c <acquire>
    80002c98:	b4dff06f          	j	800027e4 <__printf+0x6c>
    80002c9c:	40c0053b          	negw	a0,a2
    80002ca0:	00a00713          	li	a4,10
    80002ca4:	02e576bb          	remuw	a3,a0,a4
    80002ca8:	00001d97          	auipc	s11,0x1
    80002cac:	4d8d8d93          	addi	s11,s11,1240 # 80004180 <digits>
    80002cb0:	ff700593          	li	a1,-9
    80002cb4:	02069693          	slli	a3,a3,0x20
    80002cb8:	0206d693          	srli	a3,a3,0x20
    80002cbc:	00dd86b3          	add	a3,s11,a3
    80002cc0:	0006c683          	lbu	a3,0(a3)
    80002cc4:	02e557bb          	divuw	a5,a0,a4
    80002cc8:	f8d40023          	sb	a3,-128(s0)
    80002ccc:	10b65e63          	bge	a2,a1,80002de8 <__printf+0x670>
    80002cd0:	06300593          	li	a1,99
    80002cd4:	02e7f6bb          	remuw	a3,a5,a4
    80002cd8:	02069693          	slli	a3,a3,0x20
    80002cdc:	0206d693          	srli	a3,a3,0x20
    80002ce0:	00dd86b3          	add	a3,s11,a3
    80002ce4:	0006c683          	lbu	a3,0(a3)
    80002ce8:	02e7d73b          	divuw	a4,a5,a4
    80002cec:	00200793          	li	a5,2
    80002cf0:	f8d400a3          	sb	a3,-127(s0)
    80002cf4:	bca5ece3          	bltu	a1,a0,800028cc <__printf+0x154>
    80002cf8:	ce5ff06f          	j	800029dc <__printf+0x264>
    80002cfc:	40e007bb          	negw	a5,a4
    80002d00:	00001d97          	auipc	s11,0x1
    80002d04:	480d8d93          	addi	s11,s11,1152 # 80004180 <digits>
    80002d08:	00f7f693          	andi	a3,a5,15
    80002d0c:	00dd86b3          	add	a3,s11,a3
    80002d10:	0006c583          	lbu	a1,0(a3)
    80002d14:	ff100613          	li	a2,-15
    80002d18:	0047d69b          	srliw	a3,a5,0x4
    80002d1c:	f8b40023          	sb	a1,-128(s0)
    80002d20:	0047d59b          	srliw	a1,a5,0x4
    80002d24:	0ac75e63          	bge	a4,a2,80002de0 <__printf+0x668>
    80002d28:	00f6f693          	andi	a3,a3,15
    80002d2c:	00dd86b3          	add	a3,s11,a3
    80002d30:	0006c603          	lbu	a2,0(a3)
    80002d34:	00f00693          	li	a3,15
    80002d38:	0087d79b          	srliw	a5,a5,0x8
    80002d3c:	f8c400a3          	sb	a2,-127(s0)
    80002d40:	d8b6e4e3          	bltu	a3,a1,80002ac8 <__printf+0x350>
    80002d44:	00200793          	li	a5,2
    80002d48:	e2dff06f          	j	80002b74 <__printf+0x3fc>
    80002d4c:	00001c97          	auipc	s9,0x1
    80002d50:	414c8c93          	addi	s9,s9,1044 # 80004160 <_ZN3TCB25DEFAULT_SYSTEM_STACK_SIZEE+0x140>
    80002d54:	02800513          	li	a0,40
    80002d58:	ef1ff06f          	j	80002c48 <__printf+0x4d0>
    80002d5c:	00700793          	li	a5,7
    80002d60:	00600c93          	li	s9,6
    80002d64:	e0dff06f          	j	80002b70 <__printf+0x3f8>
    80002d68:	00700793          	li	a5,7
    80002d6c:	00600c93          	li	s9,6
    80002d70:	c69ff06f          	j	800029d8 <__printf+0x260>
    80002d74:	00300793          	li	a5,3
    80002d78:	00200c93          	li	s9,2
    80002d7c:	c5dff06f          	j	800029d8 <__printf+0x260>
    80002d80:	00300793          	li	a5,3
    80002d84:	00200c93          	li	s9,2
    80002d88:	de9ff06f          	j	80002b70 <__printf+0x3f8>
    80002d8c:	00400793          	li	a5,4
    80002d90:	00300c93          	li	s9,3
    80002d94:	dddff06f          	j	80002b70 <__printf+0x3f8>
    80002d98:	00400793          	li	a5,4
    80002d9c:	00300c93          	li	s9,3
    80002da0:	c39ff06f          	j	800029d8 <__printf+0x260>
    80002da4:	00500793          	li	a5,5
    80002da8:	00400c93          	li	s9,4
    80002dac:	c2dff06f          	j	800029d8 <__printf+0x260>
    80002db0:	00500793          	li	a5,5
    80002db4:	00400c93          	li	s9,4
    80002db8:	db9ff06f          	j	80002b70 <__printf+0x3f8>
    80002dbc:	00600793          	li	a5,6
    80002dc0:	00500c93          	li	s9,5
    80002dc4:	dadff06f          	j	80002b70 <__printf+0x3f8>
    80002dc8:	00600793          	li	a5,6
    80002dcc:	00500c93          	li	s9,5
    80002dd0:	c09ff06f          	j	800029d8 <__printf+0x260>
    80002dd4:	00800793          	li	a5,8
    80002dd8:	00700c93          	li	s9,7
    80002ddc:	bfdff06f          	j	800029d8 <__printf+0x260>
    80002de0:	00100793          	li	a5,1
    80002de4:	d91ff06f          	j	80002b74 <__printf+0x3fc>
    80002de8:	00100793          	li	a5,1
    80002dec:	bf1ff06f          	j	800029dc <__printf+0x264>
    80002df0:	00900793          	li	a5,9
    80002df4:	00800c93          	li	s9,8
    80002df8:	be1ff06f          	j	800029d8 <__printf+0x260>
    80002dfc:	00001517          	auipc	a0,0x1
    80002e00:	36c50513          	addi	a0,a0,876 # 80004168 <_ZN3TCB25DEFAULT_SYSTEM_STACK_SIZEE+0x148>
    80002e04:	00000097          	auipc	ra,0x0
    80002e08:	918080e7          	jalr	-1768(ra) # 8000271c <panic>

0000000080002e0c <printfinit>:
    80002e0c:	fe010113          	addi	sp,sp,-32
    80002e10:	00813823          	sd	s0,16(sp)
    80002e14:	00913423          	sd	s1,8(sp)
    80002e18:	00113c23          	sd	ra,24(sp)
    80002e1c:	02010413          	addi	s0,sp,32
    80002e20:	00003497          	auipc	s1,0x3
    80002e24:	b8048493          	addi	s1,s1,-1152 # 800059a0 <pr>
    80002e28:	00048513          	mv	a0,s1
    80002e2c:	00001597          	auipc	a1,0x1
    80002e30:	34c58593          	addi	a1,a1,844 # 80004178 <_ZN3TCB25DEFAULT_SYSTEM_STACK_SIZEE+0x158>
    80002e34:	00000097          	auipc	ra,0x0
    80002e38:	5f4080e7          	jalr	1524(ra) # 80003428 <initlock>
    80002e3c:	01813083          	ld	ra,24(sp)
    80002e40:	01013403          	ld	s0,16(sp)
    80002e44:	0004ac23          	sw	zero,24(s1)
    80002e48:	00813483          	ld	s1,8(sp)
    80002e4c:	02010113          	addi	sp,sp,32
    80002e50:	00008067          	ret

0000000080002e54 <uartinit>:
    80002e54:	ff010113          	addi	sp,sp,-16
    80002e58:	00813423          	sd	s0,8(sp)
    80002e5c:	01010413          	addi	s0,sp,16
    80002e60:	100007b7          	lui	a5,0x10000
    80002e64:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80002e68:	f8000713          	li	a4,-128
    80002e6c:	00e781a3          	sb	a4,3(a5)
    80002e70:	00300713          	li	a4,3
    80002e74:	00e78023          	sb	a4,0(a5)
    80002e78:	000780a3          	sb	zero,1(a5)
    80002e7c:	00e781a3          	sb	a4,3(a5)
    80002e80:	00700693          	li	a3,7
    80002e84:	00d78123          	sb	a3,2(a5)
    80002e88:	00e780a3          	sb	a4,1(a5)
    80002e8c:	00813403          	ld	s0,8(sp)
    80002e90:	01010113          	addi	sp,sp,16
    80002e94:	00008067          	ret

0000000080002e98 <uartputc>:
    80002e98:	00002797          	auipc	a5,0x2
    80002e9c:	8407a783          	lw	a5,-1984(a5) # 800046d8 <panicked>
    80002ea0:	00078463          	beqz	a5,80002ea8 <uartputc+0x10>
    80002ea4:	0000006f          	j	80002ea4 <uartputc+0xc>
    80002ea8:	fd010113          	addi	sp,sp,-48
    80002eac:	02813023          	sd	s0,32(sp)
    80002eb0:	00913c23          	sd	s1,24(sp)
    80002eb4:	01213823          	sd	s2,16(sp)
    80002eb8:	01313423          	sd	s3,8(sp)
    80002ebc:	02113423          	sd	ra,40(sp)
    80002ec0:	03010413          	addi	s0,sp,48
    80002ec4:	00002917          	auipc	s2,0x2
    80002ec8:	81c90913          	addi	s2,s2,-2020 # 800046e0 <uart_tx_r>
    80002ecc:	00093783          	ld	a5,0(s2)
    80002ed0:	00002497          	auipc	s1,0x2
    80002ed4:	81848493          	addi	s1,s1,-2024 # 800046e8 <uart_tx_w>
    80002ed8:	0004b703          	ld	a4,0(s1)
    80002edc:	02078693          	addi	a3,a5,32
    80002ee0:	00050993          	mv	s3,a0
    80002ee4:	02e69c63          	bne	a3,a4,80002f1c <uartputc+0x84>
    80002ee8:	00001097          	auipc	ra,0x1
    80002eec:	834080e7          	jalr	-1996(ra) # 8000371c <push_on>
    80002ef0:	00093783          	ld	a5,0(s2)
    80002ef4:	0004b703          	ld	a4,0(s1)
    80002ef8:	02078793          	addi	a5,a5,32
    80002efc:	00e79463          	bne	a5,a4,80002f04 <uartputc+0x6c>
    80002f00:	0000006f          	j	80002f00 <uartputc+0x68>
    80002f04:	00001097          	auipc	ra,0x1
    80002f08:	88c080e7          	jalr	-1908(ra) # 80003790 <pop_on>
    80002f0c:	00093783          	ld	a5,0(s2)
    80002f10:	0004b703          	ld	a4,0(s1)
    80002f14:	02078693          	addi	a3,a5,32
    80002f18:	fce688e3          	beq	a3,a4,80002ee8 <uartputc+0x50>
    80002f1c:	01f77693          	andi	a3,a4,31
    80002f20:	00003597          	auipc	a1,0x3
    80002f24:	aa058593          	addi	a1,a1,-1376 # 800059c0 <uart_tx_buf>
    80002f28:	00d586b3          	add	a3,a1,a3
    80002f2c:	00170713          	addi	a4,a4,1
    80002f30:	01368023          	sb	s3,0(a3)
    80002f34:	00e4b023          	sd	a4,0(s1)
    80002f38:	10000637          	lui	a2,0x10000
    80002f3c:	02f71063          	bne	a4,a5,80002f5c <uartputc+0xc4>
    80002f40:	0340006f          	j	80002f74 <uartputc+0xdc>
    80002f44:	00074703          	lbu	a4,0(a4)
    80002f48:	00f93023          	sd	a5,0(s2)
    80002f4c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80002f50:	00093783          	ld	a5,0(s2)
    80002f54:	0004b703          	ld	a4,0(s1)
    80002f58:	00f70e63          	beq	a4,a5,80002f74 <uartputc+0xdc>
    80002f5c:	00564683          	lbu	a3,5(a2)
    80002f60:	01f7f713          	andi	a4,a5,31
    80002f64:	00e58733          	add	a4,a1,a4
    80002f68:	0206f693          	andi	a3,a3,32
    80002f6c:	00178793          	addi	a5,a5,1
    80002f70:	fc069ae3          	bnez	a3,80002f44 <uartputc+0xac>
    80002f74:	02813083          	ld	ra,40(sp)
    80002f78:	02013403          	ld	s0,32(sp)
    80002f7c:	01813483          	ld	s1,24(sp)
    80002f80:	01013903          	ld	s2,16(sp)
    80002f84:	00813983          	ld	s3,8(sp)
    80002f88:	03010113          	addi	sp,sp,48
    80002f8c:	00008067          	ret

0000000080002f90 <uartputc_sync>:
    80002f90:	ff010113          	addi	sp,sp,-16
    80002f94:	00813423          	sd	s0,8(sp)
    80002f98:	01010413          	addi	s0,sp,16
    80002f9c:	00001717          	auipc	a4,0x1
    80002fa0:	73c72703          	lw	a4,1852(a4) # 800046d8 <panicked>
    80002fa4:	02071663          	bnez	a4,80002fd0 <uartputc_sync+0x40>
    80002fa8:	00050793          	mv	a5,a0
    80002fac:	100006b7          	lui	a3,0x10000
    80002fb0:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80002fb4:	02077713          	andi	a4,a4,32
    80002fb8:	fe070ce3          	beqz	a4,80002fb0 <uartputc_sync+0x20>
    80002fbc:	0ff7f793          	andi	a5,a5,255
    80002fc0:	00f68023          	sb	a5,0(a3)
    80002fc4:	00813403          	ld	s0,8(sp)
    80002fc8:	01010113          	addi	sp,sp,16
    80002fcc:	00008067          	ret
    80002fd0:	0000006f          	j	80002fd0 <uartputc_sync+0x40>

0000000080002fd4 <uartstart>:
    80002fd4:	ff010113          	addi	sp,sp,-16
    80002fd8:	00813423          	sd	s0,8(sp)
    80002fdc:	01010413          	addi	s0,sp,16
    80002fe0:	00001617          	auipc	a2,0x1
    80002fe4:	70060613          	addi	a2,a2,1792 # 800046e0 <uart_tx_r>
    80002fe8:	00001517          	auipc	a0,0x1
    80002fec:	70050513          	addi	a0,a0,1792 # 800046e8 <uart_tx_w>
    80002ff0:	00063783          	ld	a5,0(a2)
    80002ff4:	00053703          	ld	a4,0(a0)
    80002ff8:	04f70263          	beq	a4,a5,8000303c <uartstart+0x68>
    80002ffc:	100005b7          	lui	a1,0x10000
    80003000:	00003817          	auipc	a6,0x3
    80003004:	9c080813          	addi	a6,a6,-1600 # 800059c0 <uart_tx_buf>
    80003008:	01c0006f          	j	80003024 <uartstart+0x50>
    8000300c:	0006c703          	lbu	a4,0(a3)
    80003010:	00f63023          	sd	a5,0(a2)
    80003014:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80003018:	00063783          	ld	a5,0(a2)
    8000301c:	00053703          	ld	a4,0(a0)
    80003020:	00f70e63          	beq	a4,a5,8000303c <uartstart+0x68>
    80003024:	01f7f713          	andi	a4,a5,31
    80003028:	00e806b3          	add	a3,a6,a4
    8000302c:	0055c703          	lbu	a4,5(a1)
    80003030:	00178793          	addi	a5,a5,1
    80003034:	02077713          	andi	a4,a4,32
    80003038:	fc071ae3          	bnez	a4,8000300c <uartstart+0x38>
    8000303c:	00813403          	ld	s0,8(sp)
    80003040:	01010113          	addi	sp,sp,16
    80003044:	00008067          	ret

0000000080003048 <uartgetc>:
    80003048:	ff010113          	addi	sp,sp,-16
    8000304c:	00813423          	sd	s0,8(sp)
    80003050:	01010413          	addi	s0,sp,16
    80003054:	10000737          	lui	a4,0x10000
    80003058:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    8000305c:	0017f793          	andi	a5,a5,1
    80003060:	00078c63          	beqz	a5,80003078 <uartgetc+0x30>
    80003064:	00074503          	lbu	a0,0(a4)
    80003068:	0ff57513          	andi	a0,a0,255
    8000306c:	00813403          	ld	s0,8(sp)
    80003070:	01010113          	addi	sp,sp,16
    80003074:	00008067          	ret
    80003078:	fff00513          	li	a0,-1
    8000307c:	ff1ff06f          	j	8000306c <uartgetc+0x24>

0000000080003080 <uartintr>:
    80003080:	100007b7          	lui	a5,0x10000
    80003084:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80003088:	0017f793          	andi	a5,a5,1
    8000308c:	0a078463          	beqz	a5,80003134 <uartintr+0xb4>
    80003090:	fe010113          	addi	sp,sp,-32
    80003094:	00813823          	sd	s0,16(sp)
    80003098:	00913423          	sd	s1,8(sp)
    8000309c:	00113c23          	sd	ra,24(sp)
    800030a0:	02010413          	addi	s0,sp,32
    800030a4:	100004b7          	lui	s1,0x10000
    800030a8:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    800030ac:	0ff57513          	andi	a0,a0,255
    800030b0:	fffff097          	auipc	ra,0xfffff
    800030b4:	534080e7          	jalr	1332(ra) # 800025e4 <consoleintr>
    800030b8:	0054c783          	lbu	a5,5(s1)
    800030bc:	0017f793          	andi	a5,a5,1
    800030c0:	fe0794e3          	bnez	a5,800030a8 <uartintr+0x28>
    800030c4:	00001617          	auipc	a2,0x1
    800030c8:	61c60613          	addi	a2,a2,1564 # 800046e0 <uart_tx_r>
    800030cc:	00001517          	auipc	a0,0x1
    800030d0:	61c50513          	addi	a0,a0,1564 # 800046e8 <uart_tx_w>
    800030d4:	00063783          	ld	a5,0(a2)
    800030d8:	00053703          	ld	a4,0(a0)
    800030dc:	04f70263          	beq	a4,a5,80003120 <uartintr+0xa0>
    800030e0:	100005b7          	lui	a1,0x10000
    800030e4:	00003817          	auipc	a6,0x3
    800030e8:	8dc80813          	addi	a6,a6,-1828 # 800059c0 <uart_tx_buf>
    800030ec:	01c0006f          	j	80003108 <uartintr+0x88>
    800030f0:	0006c703          	lbu	a4,0(a3)
    800030f4:	00f63023          	sd	a5,0(a2)
    800030f8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800030fc:	00063783          	ld	a5,0(a2)
    80003100:	00053703          	ld	a4,0(a0)
    80003104:	00f70e63          	beq	a4,a5,80003120 <uartintr+0xa0>
    80003108:	01f7f713          	andi	a4,a5,31
    8000310c:	00e806b3          	add	a3,a6,a4
    80003110:	0055c703          	lbu	a4,5(a1)
    80003114:	00178793          	addi	a5,a5,1
    80003118:	02077713          	andi	a4,a4,32
    8000311c:	fc071ae3          	bnez	a4,800030f0 <uartintr+0x70>
    80003120:	01813083          	ld	ra,24(sp)
    80003124:	01013403          	ld	s0,16(sp)
    80003128:	00813483          	ld	s1,8(sp)
    8000312c:	02010113          	addi	sp,sp,32
    80003130:	00008067          	ret
    80003134:	00001617          	auipc	a2,0x1
    80003138:	5ac60613          	addi	a2,a2,1452 # 800046e0 <uart_tx_r>
    8000313c:	00001517          	auipc	a0,0x1
    80003140:	5ac50513          	addi	a0,a0,1452 # 800046e8 <uart_tx_w>
    80003144:	00063783          	ld	a5,0(a2)
    80003148:	00053703          	ld	a4,0(a0)
    8000314c:	04f70263          	beq	a4,a5,80003190 <uartintr+0x110>
    80003150:	100005b7          	lui	a1,0x10000
    80003154:	00003817          	auipc	a6,0x3
    80003158:	86c80813          	addi	a6,a6,-1940 # 800059c0 <uart_tx_buf>
    8000315c:	01c0006f          	j	80003178 <uartintr+0xf8>
    80003160:	0006c703          	lbu	a4,0(a3)
    80003164:	00f63023          	sd	a5,0(a2)
    80003168:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000316c:	00063783          	ld	a5,0(a2)
    80003170:	00053703          	ld	a4,0(a0)
    80003174:	02f70063          	beq	a4,a5,80003194 <uartintr+0x114>
    80003178:	01f7f713          	andi	a4,a5,31
    8000317c:	00e806b3          	add	a3,a6,a4
    80003180:	0055c703          	lbu	a4,5(a1)
    80003184:	00178793          	addi	a5,a5,1
    80003188:	02077713          	andi	a4,a4,32
    8000318c:	fc071ae3          	bnez	a4,80003160 <uartintr+0xe0>
    80003190:	00008067          	ret
    80003194:	00008067          	ret

0000000080003198 <kinit>:
    80003198:	fc010113          	addi	sp,sp,-64
    8000319c:	02913423          	sd	s1,40(sp)
    800031a0:	fffff7b7          	lui	a5,0xfffff
    800031a4:	00004497          	auipc	s1,0x4
    800031a8:	83b48493          	addi	s1,s1,-1989 # 800069df <end+0xfff>
    800031ac:	02813823          	sd	s0,48(sp)
    800031b0:	01313c23          	sd	s3,24(sp)
    800031b4:	00f4f4b3          	and	s1,s1,a5
    800031b8:	02113c23          	sd	ra,56(sp)
    800031bc:	03213023          	sd	s2,32(sp)
    800031c0:	01413823          	sd	s4,16(sp)
    800031c4:	01513423          	sd	s5,8(sp)
    800031c8:	04010413          	addi	s0,sp,64
    800031cc:	000017b7          	lui	a5,0x1
    800031d0:	01100993          	li	s3,17
    800031d4:	00f487b3          	add	a5,s1,a5
    800031d8:	01b99993          	slli	s3,s3,0x1b
    800031dc:	06f9e063          	bltu	s3,a5,8000323c <kinit+0xa4>
    800031e0:	00003a97          	auipc	s5,0x3
    800031e4:	800a8a93          	addi	s5,s5,-2048 # 800059e0 <end>
    800031e8:	0754ec63          	bltu	s1,s5,80003260 <kinit+0xc8>
    800031ec:	0734fa63          	bgeu	s1,s3,80003260 <kinit+0xc8>
    800031f0:	00088a37          	lui	s4,0x88
    800031f4:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    800031f8:	00001917          	auipc	s2,0x1
    800031fc:	4f890913          	addi	s2,s2,1272 # 800046f0 <kmem>
    80003200:	00ca1a13          	slli	s4,s4,0xc
    80003204:	0140006f          	j	80003218 <kinit+0x80>
    80003208:	000017b7          	lui	a5,0x1
    8000320c:	00f484b3          	add	s1,s1,a5
    80003210:	0554e863          	bltu	s1,s5,80003260 <kinit+0xc8>
    80003214:	0534f663          	bgeu	s1,s3,80003260 <kinit+0xc8>
    80003218:	00001637          	lui	a2,0x1
    8000321c:	00100593          	li	a1,1
    80003220:	00048513          	mv	a0,s1
    80003224:	00000097          	auipc	ra,0x0
    80003228:	5e4080e7          	jalr	1508(ra) # 80003808 <__memset>
    8000322c:	00093783          	ld	a5,0(s2)
    80003230:	00f4b023          	sd	a5,0(s1)
    80003234:	00993023          	sd	s1,0(s2)
    80003238:	fd4498e3          	bne	s1,s4,80003208 <kinit+0x70>
    8000323c:	03813083          	ld	ra,56(sp)
    80003240:	03013403          	ld	s0,48(sp)
    80003244:	02813483          	ld	s1,40(sp)
    80003248:	02013903          	ld	s2,32(sp)
    8000324c:	01813983          	ld	s3,24(sp)
    80003250:	01013a03          	ld	s4,16(sp)
    80003254:	00813a83          	ld	s5,8(sp)
    80003258:	04010113          	addi	sp,sp,64
    8000325c:	00008067          	ret
    80003260:	00001517          	auipc	a0,0x1
    80003264:	f3850513          	addi	a0,a0,-200 # 80004198 <digits+0x18>
    80003268:	fffff097          	auipc	ra,0xfffff
    8000326c:	4b4080e7          	jalr	1204(ra) # 8000271c <panic>

0000000080003270 <freerange>:
    80003270:	fc010113          	addi	sp,sp,-64
    80003274:	000017b7          	lui	a5,0x1
    80003278:	02913423          	sd	s1,40(sp)
    8000327c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80003280:	009504b3          	add	s1,a0,s1
    80003284:	fffff537          	lui	a0,0xfffff
    80003288:	02813823          	sd	s0,48(sp)
    8000328c:	02113c23          	sd	ra,56(sp)
    80003290:	03213023          	sd	s2,32(sp)
    80003294:	01313c23          	sd	s3,24(sp)
    80003298:	01413823          	sd	s4,16(sp)
    8000329c:	01513423          	sd	s5,8(sp)
    800032a0:	01613023          	sd	s6,0(sp)
    800032a4:	04010413          	addi	s0,sp,64
    800032a8:	00a4f4b3          	and	s1,s1,a0
    800032ac:	00f487b3          	add	a5,s1,a5
    800032b0:	06f5e463          	bltu	a1,a5,80003318 <freerange+0xa8>
    800032b4:	00002a97          	auipc	s5,0x2
    800032b8:	72ca8a93          	addi	s5,s5,1836 # 800059e0 <end>
    800032bc:	0954e263          	bltu	s1,s5,80003340 <freerange+0xd0>
    800032c0:	01100993          	li	s3,17
    800032c4:	01b99993          	slli	s3,s3,0x1b
    800032c8:	0734fc63          	bgeu	s1,s3,80003340 <freerange+0xd0>
    800032cc:	00058a13          	mv	s4,a1
    800032d0:	00001917          	auipc	s2,0x1
    800032d4:	42090913          	addi	s2,s2,1056 # 800046f0 <kmem>
    800032d8:	00002b37          	lui	s6,0x2
    800032dc:	0140006f          	j	800032f0 <freerange+0x80>
    800032e0:	000017b7          	lui	a5,0x1
    800032e4:	00f484b3          	add	s1,s1,a5
    800032e8:	0554ec63          	bltu	s1,s5,80003340 <freerange+0xd0>
    800032ec:	0534fa63          	bgeu	s1,s3,80003340 <freerange+0xd0>
    800032f0:	00001637          	lui	a2,0x1
    800032f4:	00100593          	li	a1,1
    800032f8:	00048513          	mv	a0,s1
    800032fc:	00000097          	auipc	ra,0x0
    80003300:	50c080e7          	jalr	1292(ra) # 80003808 <__memset>
    80003304:	00093703          	ld	a4,0(s2)
    80003308:	016487b3          	add	a5,s1,s6
    8000330c:	00e4b023          	sd	a4,0(s1)
    80003310:	00993023          	sd	s1,0(s2)
    80003314:	fcfa76e3          	bgeu	s4,a5,800032e0 <freerange+0x70>
    80003318:	03813083          	ld	ra,56(sp)
    8000331c:	03013403          	ld	s0,48(sp)
    80003320:	02813483          	ld	s1,40(sp)
    80003324:	02013903          	ld	s2,32(sp)
    80003328:	01813983          	ld	s3,24(sp)
    8000332c:	01013a03          	ld	s4,16(sp)
    80003330:	00813a83          	ld	s5,8(sp)
    80003334:	00013b03          	ld	s6,0(sp)
    80003338:	04010113          	addi	sp,sp,64
    8000333c:	00008067          	ret
    80003340:	00001517          	auipc	a0,0x1
    80003344:	e5850513          	addi	a0,a0,-424 # 80004198 <digits+0x18>
    80003348:	fffff097          	auipc	ra,0xfffff
    8000334c:	3d4080e7          	jalr	980(ra) # 8000271c <panic>

0000000080003350 <kfree>:
    80003350:	fe010113          	addi	sp,sp,-32
    80003354:	00813823          	sd	s0,16(sp)
    80003358:	00113c23          	sd	ra,24(sp)
    8000335c:	00913423          	sd	s1,8(sp)
    80003360:	02010413          	addi	s0,sp,32
    80003364:	03451793          	slli	a5,a0,0x34
    80003368:	04079c63          	bnez	a5,800033c0 <kfree+0x70>
    8000336c:	00002797          	auipc	a5,0x2
    80003370:	67478793          	addi	a5,a5,1652 # 800059e0 <end>
    80003374:	00050493          	mv	s1,a0
    80003378:	04f56463          	bltu	a0,a5,800033c0 <kfree+0x70>
    8000337c:	01100793          	li	a5,17
    80003380:	01b79793          	slli	a5,a5,0x1b
    80003384:	02f57e63          	bgeu	a0,a5,800033c0 <kfree+0x70>
    80003388:	00001637          	lui	a2,0x1
    8000338c:	00100593          	li	a1,1
    80003390:	00000097          	auipc	ra,0x0
    80003394:	478080e7          	jalr	1144(ra) # 80003808 <__memset>
    80003398:	00001797          	auipc	a5,0x1
    8000339c:	35878793          	addi	a5,a5,856 # 800046f0 <kmem>
    800033a0:	0007b703          	ld	a4,0(a5)
    800033a4:	01813083          	ld	ra,24(sp)
    800033a8:	01013403          	ld	s0,16(sp)
    800033ac:	00e4b023          	sd	a4,0(s1)
    800033b0:	0097b023          	sd	s1,0(a5)
    800033b4:	00813483          	ld	s1,8(sp)
    800033b8:	02010113          	addi	sp,sp,32
    800033bc:	00008067          	ret
    800033c0:	00001517          	auipc	a0,0x1
    800033c4:	dd850513          	addi	a0,a0,-552 # 80004198 <digits+0x18>
    800033c8:	fffff097          	auipc	ra,0xfffff
    800033cc:	354080e7          	jalr	852(ra) # 8000271c <panic>

00000000800033d0 <kalloc>:
    800033d0:	fe010113          	addi	sp,sp,-32
    800033d4:	00813823          	sd	s0,16(sp)
    800033d8:	00913423          	sd	s1,8(sp)
    800033dc:	00113c23          	sd	ra,24(sp)
    800033e0:	02010413          	addi	s0,sp,32
    800033e4:	00001797          	auipc	a5,0x1
    800033e8:	30c78793          	addi	a5,a5,780 # 800046f0 <kmem>
    800033ec:	0007b483          	ld	s1,0(a5)
    800033f0:	02048063          	beqz	s1,80003410 <kalloc+0x40>
    800033f4:	0004b703          	ld	a4,0(s1)
    800033f8:	00001637          	lui	a2,0x1
    800033fc:	00500593          	li	a1,5
    80003400:	00048513          	mv	a0,s1
    80003404:	00e7b023          	sd	a4,0(a5)
    80003408:	00000097          	auipc	ra,0x0
    8000340c:	400080e7          	jalr	1024(ra) # 80003808 <__memset>
    80003410:	01813083          	ld	ra,24(sp)
    80003414:	01013403          	ld	s0,16(sp)
    80003418:	00048513          	mv	a0,s1
    8000341c:	00813483          	ld	s1,8(sp)
    80003420:	02010113          	addi	sp,sp,32
    80003424:	00008067          	ret

0000000080003428 <initlock>:
    80003428:	ff010113          	addi	sp,sp,-16
    8000342c:	00813423          	sd	s0,8(sp)
    80003430:	01010413          	addi	s0,sp,16
    80003434:	00813403          	ld	s0,8(sp)
    80003438:	00b53423          	sd	a1,8(a0)
    8000343c:	00052023          	sw	zero,0(a0)
    80003440:	00053823          	sd	zero,16(a0)
    80003444:	01010113          	addi	sp,sp,16
    80003448:	00008067          	ret

000000008000344c <acquire>:
    8000344c:	fe010113          	addi	sp,sp,-32
    80003450:	00813823          	sd	s0,16(sp)
    80003454:	00913423          	sd	s1,8(sp)
    80003458:	00113c23          	sd	ra,24(sp)
    8000345c:	01213023          	sd	s2,0(sp)
    80003460:	02010413          	addi	s0,sp,32
    80003464:	00050493          	mv	s1,a0
    80003468:	10002973          	csrr	s2,sstatus
    8000346c:	100027f3          	csrr	a5,sstatus
    80003470:	ffd7f793          	andi	a5,a5,-3
    80003474:	10079073          	csrw	sstatus,a5
    80003478:	fffff097          	auipc	ra,0xfffff
    8000347c:	8e4080e7          	jalr	-1820(ra) # 80001d5c <mycpu>
    80003480:	07852783          	lw	a5,120(a0)
    80003484:	06078e63          	beqz	a5,80003500 <acquire+0xb4>
    80003488:	fffff097          	auipc	ra,0xfffff
    8000348c:	8d4080e7          	jalr	-1836(ra) # 80001d5c <mycpu>
    80003490:	07852783          	lw	a5,120(a0)
    80003494:	0004a703          	lw	a4,0(s1)
    80003498:	0017879b          	addiw	a5,a5,1
    8000349c:	06f52c23          	sw	a5,120(a0)
    800034a0:	04071063          	bnez	a4,800034e0 <acquire+0x94>
    800034a4:	00100713          	li	a4,1
    800034a8:	00070793          	mv	a5,a4
    800034ac:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    800034b0:	0007879b          	sext.w	a5,a5
    800034b4:	fe079ae3          	bnez	a5,800034a8 <acquire+0x5c>
    800034b8:	0ff0000f          	fence
    800034bc:	fffff097          	auipc	ra,0xfffff
    800034c0:	8a0080e7          	jalr	-1888(ra) # 80001d5c <mycpu>
    800034c4:	01813083          	ld	ra,24(sp)
    800034c8:	01013403          	ld	s0,16(sp)
    800034cc:	00a4b823          	sd	a0,16(s1)
    800034d0:	00013903          	ld	s2,0(sp)
    800034d4:	00813483          	ld	s1,8(sp)
    800034d8:	02010113          	addi	sp,sp,32
    800034dc:	00008067          	ret
    800034e0:	0104b903          	ld	s2,16(s1)
    800034e4:	fffff097          	auipc	ra,0xfffff
    800034e8:	878080e7          	jalr	-1928(ra) # 80001d5c <mycpu>
    800034ec:	faa91ce3          	bne	s2,a0,800034a4 <acquire+0x58>
    800034f0:	00001517          	auipc	a0,0x1
    800034f4:	cb050513          	addi	a0,a0,-848 # 800041a0 <digits+0x20>
    800034f8:	fffff097          	auipc	ra,0xfffff
    800034fc:	224080e7          	jalr	548(ra) # 8000271c <panic>
    80003500:	00195913          	srli	s2,s2,0x1
    80003504:	fffff097          	auipc	ra,0xfffff
    80003508:	858080e7          	jalr	-1960(ra) # 80001d5c <mycpu>
    8000350c:	00197913          	andi	s2,s2,1
    80003510:	07252e23          	sw	s2,124(a0)
    80003514:	f75ff06f          	j	80003488 <acquire+0x3c>

0000000080003518 <release>:
    80003518:	fe010113          	addi	sp,sp,-32
    8000351c:	00813823          	sd	s0,16(sp)
    80003520:	00113c23          	sd	ra,24(sp)
    80003524:	00913423          	sd	s1,8(sp)
    80003528:	01213023          	sd	s2,0(sp)
    8000352c:	02010413          	addi	s0,sp,32
    80003530:	00052783          	lw	a5,0(a0)
    80003534:	00079a63          	bnez	a5,80003548 <release+0x30>
    80003538:	00001517          	auipc	a0,0x1
    8000353c:	c7050513          	addi	a0,a0,-912 # 800041a8 <digits+0x28>
    80003540:	fffff097          	auipc	ra,0xfffff
    80003544:	1dc080e7          	jalr	476(ra) # 8000271c <panic>
    80003548:	01053903          	ld	s2,16(a0)
    8000354c:	00050493          	mv	s1,a0
    80003550:	fffff097          	auipc	ra,0xfffff
    80003554:	80c080e7          	jalr	-2036(ra) # 80001d5c <mycpu>
    80003558:	fea910e3          	bne	s2,a0,80003538 <release+0x20>
    8000355c:	0004b823          	sd	zero,16(s1)
    80003560:	0ff0000f          	fence
    80003564:	0f50000f          	fence	iorw,ow
    80003568:	0804a02f          	amoswap.w	zero,zero,(s1)
    8000356c:	ffffe097          	auipc	ra,0xffffe
    80003570:	7f0080e7          	jalr	2032(ra) # 80001d5c <mycpu>
    80003574:	100027f3          	csrr	a5,sstatus
    80003578:	0027f793          	andi	a5,a5,2
    8000357c:	04079a63          	bnez	a5,800035d0 <release+0xb8>
    80003580:	07852783          	lw	a5,120(a0)
    80003584:	02f05e63          	blez	a5,800035c0 <release+0xa8>
    80003588:	fff7871b          	addiw	a4,a5,-1
    8000358c:	06e52c23          	sw	a4,120(a0)
    80003590:	00071c63          	bnez	a4,800035a8 <release+0x90>
    80003594:	07c52783          	lw	a5,124(a0)
    80003598:	00078863          	beqz	a5,800035a8 <release+0x90>
    8000359c:	100027f3          	csrr	a5,sstatus
    800035a0:	0027e793          	ori	a5,a5,2
    800035a4:	10079073          	csrw	sstatus,a5
    800035a8:	01813083          	ld	ra,24(sp)
    800035ac:	01013403          	ld	s0,16(sp)
    800035b0:	00813483          	ld	s1,8(sp)
    800035b4:	00013903          	ld	s2,0(sp)
    800035b8:	02010113          	addi	sp,sp,32
    800035bc:	00008067          	ret
    800035c0:	00001517          	auipc	a0,0x1
    800035c4:	c0850513          	addi	a0,a0,-1016 # 800041c8 <digits+0x48>
    800035c8:	fffff097          	auipc	ra,0xfffff
    800035cc:	154080e7          	jalr	340(ra) # 8000271c <panic>
    800035d0:	00001517          	auipc	a0,0x1
    800035d4:	be050513          	addi	a0,a0,-1056 # 800041b0 <digits+0x30>
    800035d8:	fffff097          	auipc	ra,0xfffff
    800035dc:	144080e7          	jalr	324(ra) # 8000271c <panic>

00000000800035e0 <holding>:
    800035e0:	00052783          	lw	a5,0(a0)
    800035e4:	00079663          	bnez	a5,800035f0 <holding+0x10>
    800035e8:	00000513          	li	a0,0
    800035ec:	00008067          	ret
    800035f0:	fe010113          	addi	sp,sp,-32
    800035f4:	00813823          	sd	s0,16(sp)
    800035f8:	00913423          	sd	s1,8(sp)
    800035fc:	00113c23          	sd	ra,24(sp)
    80003600:	02010413          	addi	s0,sp,32
    80003604:	01053483          	ld	s1,16(a0)
    80003608:	ffffe097          	auipc	ra,0xffffe
    8000360c:	754080e7          	jalr	1876(ra) # 80001d5c <mycpu>
    80003610:	01813083          	ld	ra,24(sp)
    80003614:	01013403          	ld	s0,16(sp)
    80003618:	40a48533          	sub	a0,s1,a0
    8000361c:	00153513          	seqz	a0,a0
    80003620:	00813483          	ld	s1,8(sp)
    80003624:	02010113          	addi	sp,sp,32
    80003628:	00008067          	ret

000000008000362c <push_off>:
    8000362c:	fe010113          	addi	sp,sp,-32
    80003630:	00813823          	sd	s0,16(sp)
    80003634:	00113c23          	sd	ra,24(sp)
    80003638:	00913423          	sd	s1,8(sp)
    8000363c:	02010413          	addi	s0,sp,32
    80003640:	100024f3          	csrr	s1,sstatus
    80003644:	100027f3          	csrr	a5,sstatus
    80003648:	ffd7f793          	andi	a5,a5,-3
    8000364c:	10079073          	csrw	sstatus,a5
    80003650:	ffffe097          	auipc	ra,0xffffe
    80003654:	70c080e7          	jalr	1804(ra) # 80001d5c <mycpu>
    80003658:	07852783          	lw	a5,120(a0)
    8000365c:	02078663          	beqz	a5,80003688 <push_off+0x5c>
    80003660:	ffffe097          	auipc	ra,0xffffe
    80003664:	6fc080e7          	jalr	1788(ra) # 80001d5c <mycpu>
    80003668:	07852783          	lw	a5,120(a0)
    8000366c:	01813083          	ld	ra,24(sp)
    80003670:	01013403          	ld	s0,16(sp)
    80003674:	0017879b          	addiw	a5,a5,1
    80003678:	06f52c23          	sw	a5,120(a0)
    8000367c:	00813483          	ld	s1,8(sp)
    80003680:	02010113          	addi	sp,sp,32
    80003684:	00008067          	ret
    80003688:	0014d493          	srli	s1,s1,0x1
    8000368c:	ffffe097          	auipc	ra,0xffffe
    80003690:	6d0080e7          	jalr	1744(ra) # 80001d5c <mycpu>
    80003694:	0014f493          	andi	s1,s1,1
    80003698:	06952e23          	sw	s1,124(a0)
    8000369c:	fc5ff06f          	j	80003660 <push_off+0x34>

00000000800036a0 <pop_off>:
    800036a0:	ff010113          	addi	sp,sp,-16
    800036a4:	00813023          	sd	s0,0(sp)
    800036a8:	00113423          	sd	ra,8(sp)
    800036ac:	01010413          	addi	s0,sp,16
    800036b0:	ffffe097          	auipc	ra,0xffffe
    800036b4:	6ac080e7          	jalr	1708(ra) # 80001d5c <mycpu>
    800036b8:	100027f3          	csrr	a5,sstatus
    800036bc:	0027f793          	andi	a5,a5,2
    800036c0:	04079663          	bnez	a5,8000370c <pop_off+0x6c>
    800036c4:	07852783          	lw	a5,120(a0)
    800036c8:	02f05a63          	blez	a5,800036fc <pop_off+0x5c>
    800036cc:	fff7871b          	addiw	a4,a5,-1
    800036d0:	06e52c23          	sw	a4,120(a0)
    800036d4:	00071c63          	bnez	a4,800036ec <pop_off+0x4c>
    800036d8:	07c52783          	lw	a5,124(a0)
    800036dc:	00078863          	beqz	a5,800036ec <pop_off+0x4c>
    800036e0:	100027f3          	csrr	a5,sstatus
    800036e4:	0027e793          	ori	a5,a5,2
    800036e8:	10079073          	csrw	sstatus,a5
    800036ec:	00813083          	ld	ra,8(sp)
    800036f0:	00013403          	ld	s0,0(sp)
    800036f4:	01010113          	addi	sp,sp,16
    800036f8:	00008067          	ret
    800036fc:	00001517          	auipc	a0,0x1
    80003700:	acc50513          	addi	a0,a0,-1332 # 800041c8 <digits+0x48>
    80003704:	fffff097          	auipc	ra,0xfffff
    80003708:	018080e7          	jalr	24(ra) # 8000271c <panic>
    8000370c:	00001517          	auipc	a0,0x1
    80003710:	aa450513          	addi	a0,a0,-1372 # 800041b0 <digits+0x30>
    80003714:	fffff097          	auipc	ra,0xfffff
    80003718:	008080e7          	jalr	8(ra) # 8000271c <panic>

000000008000371c <push_on>:
    8000371c:	fe010113          	addi	sp,sp,-32
    80003720:	00813823          	sd	s0,16(sp)
    80003724:	00113c23          	sd	ra,24(sp)
    80003728:	00913423          	sd	s1,8(sp)
    8000372c:	02010413          	addi	s0,sp,32
    80003730:	100024f3          	csrr	s1,sstatus
    80003734:	100027f3          	csrr	a5,sstatus
    80003738:	0027e793          	ori	a5,a5,2
    8000373c:	10079073          	csrw	sstatus,a5
    80003740:	ffffe097          	auipc	ra,0xffffe
    80003744:	61c080e7          	jalr	1564(ra) # 80001d5c <mycpu>
    80003748:	07852783          	lw	a5,120(a0)
    8000374c:	02078663          	beqz	a5,80003778 <push_on+0x5c>
    80003750:	ffffe097          	auipc	ra,0xffffe
    80003754:	60c080e7          	jalr	1548(ra) # 80001d5c <mycpu>
    80003758:	07852783          	lw	a5,120(a0)
    8000375c:	01813083          	ld	ra,24(sp)
    80003760:	01013403          	ld	s0,16(sp)
    80003764:	0017879b          	addiw	a5,a5,1
    80003768:	06f52c23          	sw	a5,120(a0)
    8000376c:	00813483          	ld	s1,8(sp)
    80003770:	02010113          	addi	sp,sp,32
    80003774:	00008067          	ret
    80003778:	0014d493          	srli	s1,s1,0x1
    8000377c:	ffffe097          	auipc	ra,0xffffe
    80003780:	5e0080e7          	jalr	1504(ra) # 80001d5c <mycpu>
    80003784:	0014f493          	andi	s1,s1,1
    80003788:	06952e23          	sw	s1,124(a0)
    8000378c:	fc5ff06f          	j	80003750 <push_on+0x34>

0000000080003790 <pop_on>:
    80003790:	ff010113          	addi	sp,sp,-16
    80003794:	00813023          	sd	s0,0(sp)
    80003798:	00113423          	sd	ra,8(sp)
    8000379c:	01010413          	addi	s0,sp,16
    800037a0:	ffffe097          	auipc	ra,0xffffe
    800037a4:	5bc080e7          	jalr	1468(ra) # 80001d5c <mycpu>
    800037a8:	100027f3          	csrr	a5,sstatus
    800037ac:	0027f793          	andi	a5,a5,2
    800037b0:	04078463          	beqz	a5,800037f8 <pop_on+0x68>
    800037b4:	07852783          	lw	a5,120(a0)
    800037b8:	02f05863          	blez	a5,800037e8 <pop_on+0x58>
    800037bc:	fff7879b          	addiw	a5,a5,-1
    800037c0:	06f52c23          	sw	a5,120(a0)
    800037c4:	07853783          	ld	a5,120(a0)
    800037c8:	00079863          	bnez	a5,800037d8 <pop_on+0x48>
    800037cc:	100027f3          	csrr	a5,sstatus
    800037d0:	ffd7f793          	andi	a5,a5,-3
    800037d4:	10079073          	csrw	sstatus,a5
    800037d8:	00813083          	ld	ra,8(sp)
    800037dc:	00013403          	ld	s0,0(sp)
    800037e0:	01010113          	addi	sp,sp,16
    800037e4:	00008067          	ret
    800037e8:	00001517          	auipc	a0,0x1
    800037ec:	a0850513          	addi	a0,a0,-1528 # 800041f0 <digits+0x70>
    800037f0:	fffff097          	auipc	ra,0xfffff
    800037f4:	f2c080e7          	jalr	-212(ra) # 8000271c <panic>
    800037f8:	00001517          	auipc	a0,0x1
    800037fc:	9d850513          	addi	a0,a0,-1576 # 800041d0 <digits+0x50>
    80003800:	fffff097          	auipc	ra,0xfffff
    80003804:	f1c080e7          	jalr	-228(ra) # 8000271c <panic>

0000000080003808 <__memset>:
    80003808:	ff010113          	addi	sp,sp,-16
    8000380c:	00813423          	sd	s0,8(sp)
    80003810:	01010413          	addi	s0,sp,16
    80003814:	1a060e63          	beqz	a2,800039d0 <__memset+0x1c8>
    80003818:	40a007b3          	neg	a5,a0
    8000381c:	0077f793          	andi	a5,a5,7
    80003820:	00778693          	addi	a3,a5,7
    80003824:	00b00813          	li	a6,11
    80003828:	0ff5f593          	andi	a1,a1,255
    8000382c:	fff6071b          	addiw	a4,a2,-1
    80003830:	1b06e663          	bltu	a3,a6,800039dc <__memset+0x1d4>
    80003834:	1cd76463          	bltu	a4,a3,800039fc <__memset+0x1f4>
    80003838:	1a078e63          	beqz	a5,800039f4 <__memset+0x1ec>
    8000383c:	00b50023          	sb	a1,0(a0)
    80003840:	00100713          	li	a4,1
    80003844:	1ae78463          	beq	a5,a4,800039ec <__memset+0x1e4>
    80003848:	00b500a3          	sb	a1,1(a0)
    8000384c:	00200713          	li	a4,2
    80003850:	1ae78a63          	beq	a5,a4,80003a04 <__memset+0x1fc>
    80003854:	00b50123          	sb	a1,2(a0)
    80003858:	00300713          	li	a4,3
    8000385c:	18e78463          	beq	a5,a4,800039e4 <__memset+0x1dc>
    80003860:	00b501a3          	sb	a1,3(a0)
    80003864:	00400713          	li	a4,4
    80003868:	1ae78263          	beq	a5,a4,80003a0c <__memset+0x204>
    8000386c:	00b50223          	sb	a1,4(a0)
    80003870:	00500713          	li	a4,5
    80003874:	1ae78063          	beq	a5,a4,80003a14 <__memset+0x20c>
    80003878:	00b502a3          	sb	a1,5(a0)
    8000387c:	00700713          	li	a4,7
    80003880:	18e79e63          	bne	a5,a4,80003a1c <__memset+0x214>
    80003884:	00b50323          	sb	a1,6(a0)
    80003888:	00700e93          	li	t4,7
    8000388c:	00859713          	slli	a4,a1,0x8
    80003890:	00e5e733          	or	a4,a1,a4
    80003894:	01059e13          	slli	t3,a1,0x10
    80003898:	01c76e33          	or	t3,a4,t3
    8000389c:	01859313          	slli	t1,a1,0x18
    800038a0:	006e6333          	or	t1,t3,t1
    800038a4:	02059893          	slli	a7,a1,0x20
    800038a8:	40f60e3b          	subw	t3,a2,a5
    800038ac:	011368b3          	or	a7,t1,a7
    800038b0:	02859813          	slli	a6,a1,0x28
    800038b4:	0108e833          	or	a6,a7,a6
    800038b8:	03059693          	slli	a3,a1,0x30
    800038bc:	003e589b          	srliw	a7,t3,0x3
    800038c0:	00d866b3          	or	a3,a6,a3
    800038c4:	03859713          	slli	a4,a1,0x38
    800038c8:	00389813          	slli	a6,a7,0x3
    800038cc:	00f507b3          	add	a5,a0,a5
    800038d0:	00e6e733          	or	a4,a3,a4
    800038d4:	000e089b          	sext.w	a7,t3
    800038d8:	00f806b3          	add	a3,a6,a5
    800038dc:	00e7b023          	sd	a4,0(a5)
    800038e0:	00878793          	addi	a5,a5,8
    800038e4:	fed79ce3          	bne	a5,a3,800038dc <__memset+0xd4>
    800038e8:	ff8e7793          	andi	a5,t3,-8
    800038ec:	0007871b          	sext.w	a4,a5
    800038f0:	01d787bb          	addw	a5,a5,t4
    800038f4:	0ce88e63          	beq	a7,a4,800039d0 <__memset+0x1c8>
    800038f8:	00f50733          	add	a4,a0,a5
    800038fc:	00b70023          	sb	a1,0(a4)
    80003900:	0017871b          	addiw	a4,a5,1
    80003904:	0cc77663          	bgeu	a4,a2,800039d0 <__memset+0x1c8>
    80003908:	00e50733          	add	a4,a0,a4
    8000390c:	00b70023          	sb	a1,0(a4)
    80003910:	0027871b          	addiw	a4,a5,2
    80003914:	0ac77e63          	bgeu	a4,a2,800039d0 <__memset+0x1c8>
    80003918:	00e50733          	add	a4,a0,a4
    8000391c:	00b70023          	sb	a1,0(a4)
    80003920:	0037871b          	addiw	a4,a5,3
    80003924:	0ac77663          	bgeu	a4,a2,800039d0 <__memset+0x1c8>
    80003928:	00e50733          	add	a4,a0,a4
    8000392c:	00b70023          	sb	a1,0(a4)
    80003930:	0047871b          	addiw	a4,a5,4
    80003934:	08c77e63          	bgeu	a4,a2,800039d0 <__memset+0x1c8>
    80003938:	00e50733          	add	a4,a0,a4
    8000393c:	00b70023          	sb	a1,0(a4)
    80003940:	0057871b          	addiw	a4,a5,5
    80003944:	08c77663          	bgeu	a4,a2,800039d0 <__memset+0x1c8>
    80003948:	00e50733          	add	a4,a0,a4
    8000394c:	00b70023          	sb	a1,0(a4)
    80003950:	0067871b          	addiw	a4,a5,6
    80003954:	06c77e63          	bgeu	a4,a2,800039d0 <__memset+0x1c8>
    80003958:	00e50733          	add	a4,a0,a4
    8000395c:	00b70023          	sb	a1,0(a4)
    80003960:	0077871b          	addiw	a4,a5,7
    80003964:	06c77663          	bgeu	a4,a2,800039d0 <__memset+0x1c8>
    80003968:	00e50733          	add	a4,a0,a4
    8000396c:	00b70023          	sb	a1,0(a4)
    80003970:	0087871b          	addiw	a4,a5,8
    80003974:	04c77e63          	bgeu	a4,a2,800039d0 <__memset+0x1c8>
    80003978:	00e50733          	add	a4,a0,a4
    8000397c:	00b70023          	sb	a1,0(a4)
    80003980:	0097871b          	addiw	a4,a5,9
    80003984:	04c77663          	bgeu	a4,a2,800039d0 <__memset+0x1c8>
    80003988:	00e50733          	add	a4,a0,a4
    8000398c:	00b70023          	sb	a1,0(a4)
    80003990:	00a7871b          	addiw	a4,a5,10
    80003994:	02c77e63          	bgeu	a4,a2,800039d0 <__memset+0x1c8>
    80003998:	00e50733          	add	a4,a0,a4
    8000399c:	00b70023          	sb	a1,0(a4)
    800039a0:	00b7871b          	addiw	a4,a5,11
    800039a4:	02c77663          	bgeu	a4,a2,800039d0 <__memset+0x1c8>
    800039a8:	00e50733          	add	a4,a0,a4
    800039ac:	00b70023          	sb	a1,0(a4)
    800039b0:	00c7871b          	addiw	a4,a5,12
    800039b4:	00c77e63          	bgeu	a4,a2,800039d0 <__memset+0x1c8>
    800039b8:	00e50733          	add	a4,a0,a4
    800039bc:	00b70023          	sb	a1,0(a4)
    800039c0:	00d7879b          	addiw	a5,a5,13
    800039c4:	00c7f663          	bgeu	a5,a2,800039d0 <__memset+0x1c8>
    800039c8:	00f507b3          	add	a5,a0,a5
    800039cc:	00b78023          	sb	a1,0(a5)
    800039d0:	00813403          	ld	s0,8(sp)
    800039d4:	01010113          	addi	sp,sp,16
    800039d8:	00008067          	ret
    800039dc:	00b00693          	li	a3,11
    800039e0:	e55ff06f          	j	80003834 <__memset+0x2c>
    800039e4:	00300e93          	li	t4,3
    800039e8:	ea5ff06f          	j	8000388c <__memset+0x84>
    800039ec:	00100e93          	li	t4,1
    800039f0:	e9dff06f          	j	8000388c <__memset+0x84>
    800039f4:	00000e93          	li	t4,0
    800039f8:	e95ff06f          	j	8000388c <__memset+0x84>
    800039fc:	00000793          	li	a5,0
    80003a00:	ef9ff06f          	j	800038f8 <__memset+0xf0>
    80003a04:	00200e93          	li	t4,2
    80003a08:	e85ff06f          	j	8000388c <__memset+0x84>
    80003a0c:	00400e93          	li	t4,4
    80003a10:	e7dff06f          	j	8000388c <__memset+0x84>
    80003a14:	00500e93          	li	t4,5
    80003a18:	e75ff06f          	j	8000388c <__memset+0x84>
    80003a1c:	00600e93          	li	t4,6
    80003a20:	e6dff06f          	j	8000388c <__memset+0x84>

0000000080003a24 <__memmove>:
    80003a24:	ff010113          	addi	sp,sp,-16
    80003a28:	00813423          	sd	s0,8(sp)
    80003a2c:	01010413          	addi	s0,sp,16
    80003a30:	0e060863          	beqz	a2,80003b20 <__memmove+0xfc>
    80003a34:	fff6069b          	addiw	a3,a2,-1
    80003a38:	0006881b          	sext.w	a6,a3
    80003a3c:	0ea5e863          	bltu	a1,a0,80003b2c <__memmove+0x108>
    80003a40:	00758713          	addi	a4,a1,7
    80003a44:	00a5e7b3          	or	a5,a1,a0
    80003a48:	40a70733          	sub	a4,a4,a0
    80003a4c:	0077f793          	andi	a5,a5,7
    80003a50:	00f73713          	sltiu	a4,a4,15
    80003a54:	00174713          	xori	a4,a4,1
    80003a58:	0017b793          	seqz	a5,a5
    80003a5c:	00e7f7b3          	and	a5,a5,a4
    80003a60:	10078863          	beqz	a5,80003b70 <__memmove+0x14c>
    80003a64:	00900793          	li	a5,9
    80003a68:	1107f463          	bgeu	a5,a6,80003b70 <__memmove+0x14c>
    80003a6c:	0036581b          	srliw	a6,a2,0x3
    80003a70:	fff8081b          	addiw	a6,a6,-1
    80003a74:	02081813          	slli	a6,a6,0x20
    80003a78:	01d85893          	srli	a7,a6,0x1d
    80003a7c:	00858813          	addi	a6,a1,8
    80003a80:	00058793          	mv	a5,a1
    80003a84:	00050713          	mv	a4,a0
    80003a88:	01088833          	add	a6,a7,a6
    80003a8c:	0007b883          	ld	a7,0(a5)
    80003a90:	00878793          	addi	a5,a5,8
    80003a94:	00870713          	addi	a4,a4,8
    80003a98:	ff173c23          	sd	a7,-8(a4)
    80003a9c:	ff0798e3          	bne	a5,a6,80003a8c <__memmove+0x68>
    80003aa0:	ff867713          	andi	a4,a2,-8
    80003aa4:	02071793          	slli	a5,a4,0x20
    80003aa8:	0207d793          	srli	a5,a5,0x20
    80003aac:	00f585b3          	add	a1,a1,a5
    80003ab0:	40e686bb          	subw	a3,a3,a4
    80003ab4:	00f507b3          	add	a5,a0,a5
    80003ab8:	06e60463          	beq	a2,a4,80003b20 <__memmove+0xfc>
    80003abc:	0005c703          	lbu	a4,0(a1)
    80003ac0:	00e78023          	sb	a4,0(a5)
    80003ac4:	04068e63          	beqz	a3,80003b20 <__memmove+0xfc>
    80003ac8:	0015c603          	lbu	a2,1(a1)
    80003acc:	00100713          	li	a4,1
    80003ad0:	00c780a3          	sb	a2,1(a5)
    80003ad4:	04e68663          	beq	a3,a4,80003b20 <__memmove+0xfc>
    80003ad8:	0025c603          	lbu	a2,2(a1)
    80003adc:	00200713          	li	a4,2
    80003ae0:	00c78123          	sb	a2,2(a5)
    80003ae4:	02e68e63          	beq	a3,a4,80003b20 <__memmove+0xfc>
    80003ae8:	0035c603          	lbu	a2,3(a1)
    80003aec:	00300713          	li	a4,3
    80003af0:	00c781a3          	sb	a2,3(a5)
    80003af4:	02e68663          	beq	a3,a4,80003b20 <__memmove+0xfc>
    80003af8:	0045c603          	lbu	a2,4(a1)
    80003afc:	00400713          	li	a4,4
    80003b00:	00c78223          	sb	a2,4(a5)
    80003b04:	00e68e63          	beq	a3,a4,80003b20 <__memmove+0xfc>
    80003b08:	0055c603          	lbu	a2,5(a1)
    80003b0c:	00500713          	li	a4,5
    80003b10:	00c782a3          	sb	a2,5(a5)
    80003b14:	00e68663          	beq	a3,a4,80003b20 <__memmove+0xfc>
    80003b18:	0065c703          	lbu	a4,6(a1)
    80003b1c:	00e78323          	sb	a4,6(a5)
    80003b20:	00813403          	ld	s0,8(sp)
    80003b24:	01010113          	addi	sp,sp,16
    80003b28:	00008067          	ret
    80003b2c:	02061713          	slli	a4,a2,0x20
    80003b30:	02075713          	srli	a4,a4,0x20
    80003b34:	00e587b3          	add	a5,a1,a4
    80003b38:	f0f574e3          	bgeu	a0,a5,80003a40 <__memmove+0x1c>
    80003b3c:	02069613          	slli	a2,a3,0x20
    80003b40:	02065613          	srli	a2,a2,0x20
    80003b44:	fff64613          	not	a2,a2
    80003b48:	00e50733          	add	a4,a0,a4
    80003b4c:	00c78633          	add	a2,a5,a2
    80003b50:	fff7c683          	lbu	a3,-1(a5)
    80003b54:	fff78793          	addi	a5,a5,-1
    80003b58:	fff70713          	addi	a4,a4,-1
    80003b5c:	00d70023          	sb	a3,0(a4)
    80003b60:	fec798e3          	bne	a5,a2,80003b50 <__memmove+0x12c>
    80003b64:	00813403          	ld	s0,8(sp)
    80003b68:	01010113          	addi	sp,sp,16
    80003b6c:	00008067          	ret
    80003b70:	02069713          	slli	a4,a3,0x20
    80003b74:	02075713          	srli	a4,a4,0x20
    80003b78:	00170713          	addi	a4,a4,1
    80003b7c:	00e50733          	add	a4,a0,a4
    80003b80:	00050793          	mv	a5,a0
    80003b84:	0005c683          	lbu	a3,0(a1)
    80003b88:	00178793          	addi	a5,a5,1
    80003b8c:	00158593          	addi	a1,a1,1
    80003b90:	fed78fa3          	sb	a3,-1(a5)
    80003b94:	fee798e3          	bne	a5,a4,80003b84 <__memmove+0x160>
    80003b98:	f89ff06f          	j	80003b20 <__memmove+0xfc>
	...
