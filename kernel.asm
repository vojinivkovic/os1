
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00004117          	auipc	sp,0x4
    80000004:	7a013103          	ld	sp,1952(sp) # 800047a0 <_GLOBAL_OFFSET_TABLE_+0x10>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	5f9010ef          	jal	ra,80001e14 <start>

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
    ;addi sp, sp, -256
    80001030:	f0010113          	addi	sp,sp,-256
    ;.irp index, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31
    ;sd x\index, \index * 8(sp)
    ;.endr
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
    addi sp, sp, -16
    800010b4:	ff010113          	addi	sp,sp,-16
    sd t0, 8(sp)
    800010b8:	00513423          	sd	t0,8(sp)
    addi t0, sp, 0
    800010bc:	00010293          	mv	t0,sp

    csrr sp, sscratch
    800010c0:	14002173          	csrr	sp,sscratch
    addi sp, sp, -256
    800010c4:	f0010113          	addi	sp,sp,-256

    sd x0, 0 * 8(sp)
    800010c8:	00013023          	sd	zero,0(sp)
    sd x1, 1 * 8(sp)
    800010cc:	00113423          	sd	ra,8(sp)
    sd t0, 2 * 8(sp)
    800010d0:	00513823          	sd	t0,16(sp)
    .irp index,  3, 4, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31
    sd x\index, \index * 8(sp)
    .endr
    800010d4:	00313c23          	sd	gp,24(sp)
    800010d8:	02413023          	sd	tp,32(sp)
    800010dc:	02613823          	sd	t1,48(sp)
    800010e0:	02713c23          	sd	t2,56(sp)
    800010e4:	04813023          	sd	s0,64(sp)
    800010e8:	04913423          	sd	s1,72(sp)
    800010ec:	04a13823          	sd	a0,80(sp)
    800010f0:	04b13c23          	sd	a1,88(sp)
    800010f4:	06c13023          	sd	a2,96(sp)
    800010f8:	06d13423          	sd	a3,104(sp)
    800010fc:	06e13823          	sd	a4,112(sp)
    80001100:	06f13c23          	sd	a5,120(sp)
    80001104:	09013023          	sd	a6,128(sp)
    80001108:	09113423          	sd	a7,136(sp)
    8000110c:	09213823          	sd	s2,144(sp)
    80001110:	09313c23          	sd	s3,152(sp)
    80001114:	0b413023          	sd	s4,160(sp)
    80001118:	0b513423          	sd	s5,168(sp)
    8000111c:	0b613823          	sd	s6,176(sp)
    80001120:	0b713c23          	sd	s7,184(sp)
    80001124:	0d813023          	sd	s8,192(sp)
    80001128:	0d913423          	sd	s9,200(sp)
    8000112c:	0da13823          	sd	s10,208(sp)
    80001130:	0db13c23          	sd	s11,216(sp)
    80001134:	0fc13023          	sd	t3,224(sp)
    80001138:	0fd13423          	sd	t4,232(sp)
    8000113c:	0fe13823          	sd	t5,240(sp)
    80001140:	0ff13c23          	sd	t6,248(sp)
    ld t0, 8(t0)
    80001144:	0082b283          	ld	t0,8(t0)
    sd t0, 5 * 8(sp)
    80001148:	02513423          	sd	t0,40(sp)

    addi s0, sp, 0
    8000114c:	00010413          	mv	s0,sp
    call _ZN6Kernel16interruptHandlerEv
    80001150:	0cd000ef          	jal	ra,80001a1c <_ZN6Kernel16interruptHandlerEv>


    ld x0, 0 * 8(sp)
    80001154:	00013003          	ld	zero,0(sp)
    ld x1, 1 * 8(sp)
    80001158:	00813083          	ld	ra,8(sp)
    ld t0, 2 * 8(sp)
    8000115c:	01013283          	ld	t0,16(sp)
    .irp index,  3, 4, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31
    sd x\index, \index * 8(sp)
    .endr
    80001160:	00313c23          	sd	gp,24(sp)
    80001164:	02413023          	sd	tp,32(sp)
    80001168:	02613823          	sd	t1,48(sp)
    8000116c:	02713c23          	sd	t2,56(sp)
    80001170:	04813023          	sd	s0,64(sp)
    80001174:	04913423          	sd	s1,72(sp)
    80001178:	04a13823          	sd	a0,80(sp)
    8000117c:	04b13c23          	sd	a1,88(sp)
    80001180:	06c13023          	sd	a2,96(sp)
    80001184:	06d13423          	sd	a3,104(sp)
    80001188:	06e13823          	sd	a4,112(sp)
    8000118c:	06f13c23          	sd	a5,120(sp)
    80001190:	09013023          	sd	a6,128(sp)
    80001194:	09113423          	sd	a7,136(sp)
    80001198:	09213823          	sd	s2,144(sp)
    8000119c:	09313c23          	sd	s3,152(sp)
    800011a0:	0b413023          	sd	s4,160(sp)
    800011a4:	0b513423          	sd	s5,168(sp)
    800011a8:	0b613823          	sd	s6,176(sp)
    800011ac:	0b713c23          	sd	s7,184(sp)
    800011b0:	0d813023          	sd	s8,192(sp)
    800011b4:	0d913423          	sd	s9,200(sp)
    800011b8:	0da13823          	sd	s10,208(sp)
    800011bc:	0db13c23          	sd	s11,216(sp)
    800011c0:	0fc13023          	sd	t3,224(sp)
    800011c4:	0fd13423          	sd	t4,232(sp)
    800011c8:	0fe13823          	sd	t5,240(sp)
    800011cc:	0ff13c23          	sd	t6,248(sp)

    addi sp, sp, 256
    800011d0:	10010113          	addi	sp,sp,256
    csrr t0, sscratch
    800011d4:	140022f3          	csrr	t0,sscratch
    csrw sscratch, sp
    800011d8:	14011073          	csrw	sscratch,sp

    addi sp, t0, 0
    800011dc:	00028113          	mv	sp,t0
    ld t0, 8(sp)
    800011e0:	00813283          	ld	t0,8(sp)
    addi sp, sp, 16
    800011e4:	01010113          	addi	sp,sp,16
    800011e8:	10200073          	sret
    800011ec:	0000                	unimp
	...

00000000800011f0 <context_switch>:
.global context_switch
.type context_switch, @function
context_switch:
    sd ra, 0 * 8(a0)
    800011f0:	00153023          	sd	ra,0(a0) # 1000 <_entry-0x7ffff000>
    sd sp, 1 * 8(a0)
    800011f4:	00253423          	sd	sp,8(a0)

    ld ra, 0 * 8(a1)
    800011f8:	0005b083          	ld	ra,0(a1)
    800011fc:	0085b103          	ld	sp,8(a1)

0000000080001200 <_Z9mem_allocm>:


extern "C" uint64 system_call(Arguments* arg);

void* mem_alloc(size_t size)
{
    80001200:	fa010113          	addi	sp,sp,-96
    80001204:	04113c23          	sd	ra,88(sp)
    80001208:	04813823          	sd	s0,80(sp)
    8000120c:	04913423          	sd	s1,72(sp)
    80001210:	05213023          	sd	s2,64(sp)
    80001214:	06010413          	addi	s0,sp,96
    80001218:	00050493          	mv	s1,a0
    uint64 size_of_blocks = (size + MemoryAllocator::getSizeOfMetaData()) / MEM_BLOCK_SIZE;
    8000121c:	00000097          	auipc	ra,0x0
    80001220:	6ec080e7          	jalr	1772(ra) # 80001908 <_ZN15MemoryAllocator17getSizeOfMetaDataEv>
    80001224:	00950933          	add	s2,a0,s1
    80001228:	00695913          	srli	s2,s2,0x6
    size_of_blocks += (size + MemoryAllocator::getSizeOfMetaData()) % MEM_BLOCK_SIZE ? 1: 0;
    8000122c:	00000097          	auipc	ra,0x0
    80001230:	6dc080e7          	jalr	1756(ra) # 80001908 <_ZN15MemoryAllocator17getSizeOfMetaDataEv>
    80001234:	00a484b3          	add	s1,s1,a0
    80001238:	03f4f493          	andi	s1,s1,63
    8000123c:	04048a63          	beqz	s1,80001290 <_Z9mem_allocm+0x90>
    80001240:	00100513          	li	a0,1
    80001244:	01250933          	add	s2,a0,s2
    Arguments arg = {Kernel::MEM_ALLOC, size_of_blocks, 0, 0, 0, 0, 0, 0};
    80001248:	fa043823          	sd	zero,-80(s0)
    8000124c:	fa043c23          	sd	zero,-72(s0)
    80001250:	fc043023          	sd	zero,-64(s0)
    80001254:	fc043423          	sd	zero,-56(s0)
    80001258:	fc043823          	sd	zero,-48(s0)
    8000125c:	fc043c23          	sd	zero,-40(s0)
    80001260:	00100793          	li	a5,1
    80001264:	faf43023          	sd	a5,-96(s0)
    80001268:	fb243423          	sd	s2,-88(s0)
    return (void*) system_call(&arg);
    8000126c:	fa040513          	addi	a0,s0,-96
    80001270:	00000097          	auipc	ra,0x0
    80001274:	d90080e7          	jalr	-624(ra) # 80001000 <system_call>
}
    80001278:	05813083          	ld	ra,88(sp)
    8000127c:	05013403          	ld	s0,80(sp)
    80001280:	04813483          	ld	s1,72(sp)
    80001284:	04013903          	ld	s2,64(sp)
    80001288:	06010113          	addi	sp,sp,96
    8000128c:	00008067          	ret
    size_of_blocks += (size + MemoryAllocator::getSizeOfMetaData()) % MEM_BLOCK_SIZE ? 1: 0;
    80001290:	00000513          	li	a0,0
    80001294:	fb1ff06f          	j	80001244 <_Z9mem_allocm+0x44>

0000000080001298 <_Z8mem_freePv>:

int mem_free(void* obj)
{   Arguments arg = {Kernel::MEM_FREE, (uint64)obj, 0, 0, 0, 0, 0, 0};
    80001298:	fb010113          	addi	sp,sp,-80
    8000129c:	04113423          	sd	ra,72(sp)
    800012a0:	04813023          	sd	s0,64(sp)
    800012a4:	05010413          	addi	s0,sp,80
    800012a8:	fc043023          	sd	zero,-64(s0)
    800012ac:	fc043423          	sd	zero,-56(s0)
    800012b0:	fc043823          	sd	zero,-48(s0)
    800012b4:	fc043c23          	sd	zero,-40(s0)
    800012b8:	fe043023          	sd	zero,-32(s0)
    800012bc:	fe043423          	sd	zero,-24(s0)
    800012c0:	00200793          	li	a5,2
    800012c4:	faf43823          	sd	a5,-80(s0)
    800012c8:	faa43c23          	sd	a0,-72(s0)
    return (int) system_call(&arg);
    800012cc:	fb040513          	addi	a0,s0,-80
    800012d0:	00000097          	auipc	ra,0x0
    800012d4:	d30080e7          	jalr	-720(ra) # 80001000 <system_call>
}
    800012d8:	0005051b          	sext.w	a0,a0
    800012dc:	04813083          	ld	ra,72(sp)
    800012e0:	04013403          	ld	s0,64(sp)
    800012e4:	05010113          	addi	sp,sp,80
    800012e8:	00008067          	ret

00000000800012ec <_Z18mem_get_free_spacev>:

size_t mem_get_free_space()
{
    800012ec:	fb010113          	addi	sp,sp,-80
    800012f0:	04113423          	sd	ra,72(sp)
    800012f4:	04813023          	sd	s0,64(sp)
    800012f8:	05010413          	addi	s0,sp,80
    Arguments arg = {Kernel::MEM_FREE_SPACE, 0, 0, 0, 0, 0, 0, 0};
    800012fc:	00300793          	li	a5,3
    80001300:	faf43823          	sd	a5,-80(s0)
    80001304:	fa043c23          	sd	zero,-72(s0)
    80001308:	fc043023          	sd	zero,-64(s0)
    8000130c:	fc043423          	sd	zero,-56(s0)
    80001310:	fc043823          	sd	zero,-48(s0)
    80001314:	fc043c23          	sd	zero,-40(s0)
    80001318:	fe043023          	sd	zero,-32(s0)
    8000131c:	fe043423          	sd	zero,-24(s0)
    return (size_t) system_call(&arg);
    80001320:	fb040513          	addi	a0,s0,-80
    80001324:	00000097          	auipc	ra,0x0
    80001328:	cdc080e7          	jalr	-804(ra) # 80001000 <system_call>
}
    8000132c:	04813083          	ld	ra,72(sp)
    80001330:	04013403          	ld	s0,64(sp)
    80001334:	05010113          	addi	sp,sp,80
    80001338:	00008067          	ret

000000008000133c <_Z26mem_get_largest_free_blockv>:
size_t mem_get_largest_free_block()
{
    8000133c:	fb010113          	addi	sp,sp,-80
    80001340:	04113423          	sd	ra,72(sp)
    80001344:	04813023          	sd	s0,64(sp)
    80001348:	05010413          	addi	s0,sp,80
    Arguments arg = {Kernel::LARGEST_FREE_BLOCK, 0, 0, 0, 0, 0, 0, 0};
    8000134c:	00400793          	li	a5,4
    80001350:	faf43823          	sd	a5,-80(s0)
    80001354:	fa043c23          	sd	zero,-72(s0)
    80001358:	fc043023          	sd	zero,-64(s0)
    8000135c:	fc043423          	sd	zero,-56(s0)
    80001360:	fc043823          	sd	zero,-48(s0)
    80001364:	fc043c23          	sd	zero,-40(s0)
    80001368:	fe043023          	sd	zero,-32(s0)
    8000136c:	fe043423          	sd	zero,-24(s0)
    return (size_t) system_call(&arg);
    80001370:	fb040513          	addi	a0,s0,-80
    80001374:	00000097          	auipc	ra,0x0
    80001378:	c8c080e7          	jalr	-884(ra) # 80001000 <system_call>
}
    8000137c:	04813083          	ld	ra,72(sp)
    80001380:	04013403          	ld	s0,64(sp)
    80001384:	05010113          	addi	sp,sp,80
    80001388:	00008067          	ret

000000008000138c <_ZN9Scheduler3putEP3TCB>:
#include "../h/TCB.hpp"
TCB* Scheduler::firstReadyThread = nullptr;
TCB* Scheduler::lastReadyThread = nullptr;

void Scheduler::put(TCB *readyThread)
{
    8000138c:	ff010113          	addi	sp,sp,-16
    80001390:	00813423          	sd	s0,8(sp)
    80001394:	01010413          	addi	s0,sp,16
    if(!firstReadyThread)
    80001398:	00003797          	auipc	a5,0x3
    8000139c:	4687b783          	ld	a5,1128(a5) # 80004800 <_ZN9Scheduler16firstReadyThreadE>
    800013a0:	02078263          	beqz	a5,800013c4 <_ZN9Scheduler3putEP3TCB+0x38>
    {
        firstReadyThread = readyThread;
    }
    else
    {
        lastReadyThread->state = readyThread;
    800013a4:	00003797          	auipc	a5,0x3
    800013a8:	4647b783          	ld	a5,1124(a5) # 80004808 <_ZN9Scheduler15lastReadyThreadE>
    800013ac:	04a7b023          	sd	a0,64(a5)
    }
    lastReadyThread = readyThread;
    800013b0:	00003797          	auipc	a5,0x3
    800013b4:	44a7bc23          	sd	a0,1112(a5) # 80004808 <_ZN9Scheduler15lastReadyThreadE>
}
    800013b8:	00813403          	ld	s0,8(sp)
    800013bc:	01010113          	addi	sp,sp,16
    800013c0:	00008067          	ret
        firstReadyThread = readyThread;
    800013c4:	00003797          	auipc	a5,0x3
    800013c8:	42a7be23          	sd	a0,1084(a5) # 80004800 <_ZN9Scheduler16firstReadyThreadE>
    800013cc:	fe5ff06f          	j	800013b0 <_ZN9Scheduler3putEP3TCB+0x24>

00000000800013d0 <_ZN9Scheduler3getEv>:
TCB* Scheduler::get(void)
{
    800013d0:	ff010113          	addi	sp,sp,-16
    800013d4:	00813423          	sd	s0,8(sp)
    800013d8:	01010413          	addi	s0,sp,16
    if(!firstReadyThread)
    800013dc:	00003517          	auipc	a0,0x3
    800013e0:	42453503          	ld	a0,1060(a0) # 80004800 <_ZN9Scheduler16firstReadyThreadE>
    800013e4:	00050463          	beqz	a0,800013ec <_ZN9Scheduler3getEv+0x1c>
    {
        return nullptr;
    }
    TCB* newThread = firstReadyThread;
    firstReadyThread->state = firstReadyThread;
    newThread->state = nullptr;
    800013e8:	04053023          	sd	zero,64(a0)
    return newThread;
    800013ec:	00813403          	ld	s0,8(sp)
    800013f0:	01010113          	addi	sp,sp,16
    800013f4:	00008067          	ret

00000000800013f8 <main>:
// Created by os on 11/29/25.
//
#include "../h/MemoryAllocator.hpp"
#include "../h/Kernel.hpp"
#include "../h/syscall_c.hpp"
void main(){
    800013f8:	ff010113          	addi	sp,sp,-16
    800013fc:	00813423          	sd	s0,8(sp)
    80001400:	01010413          	addi	s0,sp,16
////    __asm__ volatile ("ecall");
//    void* allocMem1 = mem_alloc(100);
//    mem_free(allocMem1);
//    void* allocMem2 = mem_alloc(10);
//    mem_free(allocMem2);
    80001404:	00813403          	ld	s0,8(sp)
    80001408:	01010113          	addi	sp,sp,16
    8000140c:	00008067          	ret

0000000080001410 <_ZN3TCB13threadWrapperEv>:

    context = {(uint64) &threadWrapper, (uint64) &stack[DEFAULT_STACK_SIZE], (uint64) &systemStack[DEFAULT_SYSTEM_STACK_SIZE]};
    Scheduler::put(this);
}
void TCB::threadWrapper()
{
    80001410:	ff010113          	addi	sp,sp,-16
    80001414:	00813423          	sd	s0,8(sp)
    80001418:	01010413          	addi	s0,sp,16

    8000141c:	00813403          	ld	s0,8(sp)
    80001420:	01010113          	addi	sp,sp,16
    80001424:	00008067          	ret

0000000080001428 <_ZN3TCB16initializeThreadEPFvPvES0_S0_>:
{
    80001428:	fe010113          	addi	sp,sp,-32
    8000142c:	00113c23          	sd	ra,24(sp)
    80001430:	00813823          	sd	s0,16(sp)
    80001434:	00913423          	sd	s1,8(sp)
    80001438:	02010413          	addi	s0,sp,32
    8000143c:	00050493          	mv	s1,a0
    body = function;
    80001440:	00b53023          	sd	a1,0(a0)
    stack = (uint64*)allocatedStack;
    80001444:	02d53423          	sd	a3,40(a0)
    timeSlice = DEFAULT_TIME_SLICE;
    80001448:	00200793          	li	a5,2
    8000144c:	02f53023          	sd	a5,32(a0)
    state = nullptr;
    80001450:	04053023          	sd	zero,64(a0)
    isFinished = false;
    80001454:	04050423          	sb	zero,72(a0)
    arguments = arg;
    80001458:	02c53c23          	sd	a2,56(a0)
    systemStack = (uint64*)MemoryAllocator::allocateMemory(sizeOfStack);
    8000145c:	08000513          	li	a0,128
    80001460:	00000097          	auipc	ra,0x0
    80001464:	1fc080e7          	jalr	508(ra) # 8000165c <_ZN15MemoryAllocator14allocateMemoryEm>
    80001468:	02a4b823          	sd	a0,48(s1)
    context = {(uint64) &threadWrapper, (uint64) &stack[DEFAULT_STACK_SIZE], (uint64) &systemStack[DEFAULT_SYSTEM_STACK_SIZE]};
    8000146c:	0284b783          	ld	a5,40(s1)
    80001470:	00008737          	lui	a4,0x8
    80001474:	00e787b3          	add	a5,a5,a4
    80001478:	00002737          	lui	a4,0x2
    8000147c:	00e50533          	add	a0,a0,a4
    80001480:	00000717          	auipc	a4,0x0
    80001484:	f9070713          	addi	a4,a4,-112 # 80001410 <_ZN3TCB13threadWrapperEv>
    80001488:	00e4b423          	sd	a4,8(s1)
    8000148c:	00f4b823          	sd	a5,16(s1)
    80001490:	00a4bc23          	sd	a0,24(s1)
    Scheduler::put(this);
    80001494:	00048513          	mv	a0,s1
    80001498:	00000097          	auipc	ra,0x0
    8000149c:	ef4080e7          	jalr	-268(ra) # 8000138c <_ZN9Scheduler3putEP3TCB>
}
    800014a0:	01813083          	ld	ra,24(sp)
    800014a4:	01013403          	ld	s0,16(sp)
    800014a8:	00813483          	ld	s1,8(sp)
    800014ac:	02010113          	addi	sp,sp,32
    800014b0:	00008067          	ret

00000000800014b4 <_ZN15MemoryAllocator16initializeMemoryEv>:
size_t MemoryAllocator::NUM_OF_BLOCKS = 0;
size_t MemoryAllocator::numOfFreeBlocks = 0;
MemoryAllocator::FreeBlock* MemoryAllocator::firstFreeBlock = nullptr;

void MemoryAllocator::initializeMemory()
{
    800014b4:	ff010113          	addi	sp,sp,-16
    800014b8:	00813423          	sd	s0,8(sp)
    800014bc:	01010413          	addi	s0,sp,16

    NUM_OF_BLOCKS = ((uint8*)HEAP_END_ADDR - (uint8*)HEAP_START_ADDR) / MEM_BLOCK_SIZE;
    800014c0:	00003797          	auipc	a5,0x3
    800014c4:	2f07b783          	ld	a5,752(a5) # 800047b0 <_GLOBAL_OFFSET_TABLE_+0x20>
    800014c8:	0007b703          	ld	a4,0(a5)
    800014cc:	00003797          	auipc	a5,0x3
    800014d0:	2cc7b783          	ld	a5,716(a5) # 80004798 <_GLOBAL_OFFSET_TABLE_+0x8>
    800014d4:	0007b683          	ld	a3,0(a5)
    800014d8:	40d70733          	sub	a4,a4,a3
    800014dc:	00675713          	srli	a4,a4,0x6
    800014e0:	00003797          	auipc	a5,0x3
    800014e4:	33878793          	addi	a5,a5,824 # 80004818 <_ZN15MemoryAllocator13NUM_OF_BLOCKSE>
    800014e8:	00e7b023          	sd	a4,0(a5)
    numOfFreeBlocks = NUM_OF_BLOCKS;
    800014ec:	00e7b423          	sd	a4,8(a5)

    firstFreeBlock = (FreeBlock*)(HEAP_START_ADDR);
    800014f0:	00d7b823          	sd	a3,16(a5)

    firstFreeBlock->flagFree = true;
    800014f4:	00100613          	li	a2,1
    800014f8:	00c68023          	sb	a2,0(a3)
    firstFreeBlock->numOfBlocks = NUM_OF_BLOCKS;
    800014fc:	0107b703          	ld	a4,16(a5)
    80001500:	0007b683          	ld	a3,0(a5)
    80001504:	00d73423          	sd	a3,8(a4)
    firstFreeBlock->nextBlock = nullptr;
    80001508:	00073823          	sd	zero,16(a4)
    firstFreeBlock->previousBlock = nullptr;
    8000150c:	00073c23          	sd	zero,24(a4)
    flagSystemInitialize = 1;
    80001510:	00c78c23          	sb	a2,24(a5)
}
    80001514:	00813403          	ld	s0,8(sp)
    80001518:	01010113          	addi	sp,sp,16
    8000151c:	00008067          	ret

0000000080001520 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m>:
    occupiedBlock++;
    return occupiedBlock;
}

void MemoryAllocator::remapMemory(FreeBlock **head, FreeBlock *allocatedBlocks, size_t blocksToAllocate)
{
    80001520:	ff010113          	addi	sp,sp,-16
    80001524:	00813423          	sd	s0,8(sp)
    80001528:	01010413          	addi	s0,sp,16

    if(allocatedBlocks->numOfBlocks == 0)
    8000152c:	0085b783          	ld	a5,8(a1)
    80001530:	04079263          	bnez	a5,80001574 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x54>
    {

        if(allocatedBlocks->previousBlock)
    80001534:	0185b783          	ld	a5,24(a1)
    80001538:	00078663          	beqz	a5,80001544 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x24>
        {
            allocatedBlocks->previousBlock->nextBlock = allocatedBlocks->nextBlock;
    8000153c:	0105b703          	ld	a4,16(a1)
    80001540:	00e7b823          	sd	a4,16(a5)
        }

        if(allocatedBlocks->nextBlock)
    80001544:	0105b783          	ld	a5,16(a1)
    80001548:	00078663          	beqz	a5,80001554 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x34>
        {
            allocatedBlocks->nextBlock->previousBlock = allocatedBlocks->previousBlock;
    8000154c:	0185b703          	ld	a4,24(a1)
    80001550:	00e7bc23          	sd	a4,24(a5)
        }

        if(*head == allocatedBlocks)
    80001554:	00053783          	ld	a5,0(a0)
    80001558:	00b78863          	beq	a5,a1,80001568 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x48>
        {
            *head = newFreeBlock;
        }
    }

}
    8000155c:	00813403          	ld	s0,8(sp)
    80001560:	01010113          	addi	sp,sp,16
    80001564:	00008067          	ret
            *head = allocatedBlocks->nextBlock;
    80001568:	0105b783          	ld	a5,16(a1)
    8000156c:	00f53023          	sd	a5,0(a0)
    80001570:	fedff06f          	j	8000155c <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x3c>
        FreeBlock* newFreeBlock = (FreeBlock*)((uint8*)allocatedBlocks + blocksToAllocate * MEM_BLOCK_SIZE);
    80001574:	00661613          	slli	a2,a2,0x6
    80001578:	00c58633          	add	a2,a1,a2
        newFreeBlock->flagFree = true;
    8000157c:	00100793          	li	a5,1
    80001580:	00f60023          	sb	a5,0(a2)
        newFreeBlock->numOfBlocks = allocatedBlocks->numOfBlocks;
    80001584:	0085b783          	ld	a5,8(a1)
    80001588:	00f63423          	sd	a5,8(a2)
        if(allocatedBlocks->previousBlock)
    8000158c:	0185b783          	ld	a5,24(a1)
    80001590:	00078463          	beqz	a5,80001598 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x78>
            allocatedBlocks->previousBlock->nextBlock = newFreeBlock;
    80001594:	00c7b823          	sd	a2,16(a5)
        newFreeBlock->previousBlock = allocatedBlocks->previousBlock;
    80001598:	0185b783          	ld	a5,24(a1)
    8000159c:	00f63c23          	sd	a5,24(a2)
        newFreeBlock->nextBlock = allocatedBlocks->nextBlock;
    800015a0:	0105b783          	ld	a5,16(a1)
    800015a4:	00f63823          	sd	a5,16(a2)
        if(*head == allocatedBlocks)
    800015a8:	00053783          	ld	a5,0(a0)
    800015ac:	fab798e3          	bne	a5,a1,8000155c <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x3c>
            *head = newFreeBlock;
    800015b0:	00c53023          	sd	a2,0(a0)
}
    800015b4:	fa9ff06f          	j	8000155c <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x3c>

00000000800015b8 <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm>:
{
    800015b8:	fe010113          	addi	sp,sp,-32
    800015bc:	00113c23          	sd	ra,24(sp)
    800015c0:	00813823          	sd	s0,16(sp)
    800015c4:	00913423          	sd	s1,8(sp)
    800015c8:	01213023          	sd	s2,0(sp)
    800015cc:	02010413          	addi	s0,sp,32
    800015d0:	00058913          	mv	s2,a1
    for(FreeBlock* curr = (*head); curr; curr = curr->nextBlock)
    800015d4:	00053783          	ld	a5,0(a0)
    FreeBlock* bestBlock = nullptr;
    800015d8:	00000493          	li	s1,0
    800015dc:	00c0006f          	j	800015e8 <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm+0x30>
                bestBlock = curr;
    800015e0:	00078493          	mv	s1,a5
    for(FreeBlock* curr = (*head); curr; curr = curr->nextBlock)
    800015e4:	0107b783          	ld	a5,16(a5)
    800015e8:	02078063          	beqz	a5,80001608 <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm+0x50>
        if(curr->numOfBlocks >= blocksToAllocate)
    800015ec:	0087b703          	ld	a4,8(a5)
    800015f0:	ff276ae3          	bltu	a4,s2,800015e4 <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm+0x2c>
        {   if(bestBlock == nullptr)
    800015f4:	fe0486e3          	beqz	s1,800015e0 <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm+0x28>
            if(bestBlock->numOfBlocks > curr->numOfBlocks)
    800015f8:	0084b683          	ld	a3,8(s1)
    800015fc:	fed774e3          	bgeu	a4,a3,800015e4 <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm+0x2c>
                bestBlock = curr;
    80001600:	00078493          	mv	s1,a5
    80001604:	fe1ff06f          	j	800015e4 <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm+0x2c>
    numOfFreeBlocks -= blocksToAllocate;
    80001608:	00003717          	auipc	a4,0x3
    8000160c:	21070713          	addi	a4,a4,528 # 80004818 <_ZN15MemoryAllocator13NUM_OF_BLOCKSE>
    80001610:	00873783          	ld	a5,8(a4)
    80001614:	412787b3          	sub	a5,a5,s2
    80001618:	00f73423          	sd	a5,8(a4)
    bestBlock->numOfBlocks -= blocksToAllocate;
    8000161c:	0084b783          	ld	a5,8(s1)
    80001620:	412787b3          	sub	a5,a5,s2
    80001624:	00f4b423          	sd	a5,8(s1)
    remapMemory(head, bestBlock, blocksToAllocate);
    80001628:	00090613          	mv	a2,s2
    8000162c:	00048593          	mv	a1,s1
    80001630:	00000097          	auipc	ra,0x0
    80001634:	ef0080e7          	jalr	-272(ra) # 80001520 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m>
    occupiedBlock->flagFree = false;
    80001638:	00048023          	sb	zero,0(s1)
    occupiedBlock->numOfBlocks = blocksToAllocate;
    8000163c:	0124b423          	sd	s2,8(s1)
}
    80001640:	01048513          	addi	a0,s1,16
    80001644:	01813083          	ld	ra,24(sp)
    80001648:	01013403          	ld	s0,16(sp)
    8000164c:	00813483          	ld	s1,8(sp)
    80001650:	00013903          	ld	s2,0(sp)
    80001654:	02010113          	addi	sp,sp,32
    80001658:	00008067          	ret

000000008000165c <_ZN15MemoryAllocator14allocateMemoryEm>:
{
    8000165c:	fe010113          	addi	sp,sp,-32
    80001660:	00113c23          	sd	ra,24(sp)
    80001664:	00813823          	sd	s0,16(sp)
    80001668:	00913423          	sd	s1,8(sp)
    8000166c:	02010413          	addi	s0,sp,32
    80001670:	00050493          	mv	s1,a0
    if(!flagSystemInitialize)
    80001674:	00003797          	auipc	a5,0x3
    80001678:	1bc7c783          	lbu	a5,444(a5) # 80004830 <_ZN15MemoryAllocator20flagSystemInitializeE>
    8000167c:	02078c63          	beqz	a5,800016b4 <_ZN15MemoryAllocator14allocateMemoryEm+0x58>
    if(numOfFreeBlocks < blocksToAllocate)
    80001680:	00003797          	auipc	a5,0x3
    80001684:	1a07b783          	ld	a5,416(a5) # 80004820 <_ZN15MemoryAllocator15numOfFreeBlocksE>
    80001688:	0297ec63          	bltu	a5,s1,800016c0 <_ZN15MemoryAllocator14allocateMemoryEm+0x64>
    return findBestFit(&firstFreeBlock, blocksToAllocate);
    8000168c:	00048593          	mv	a1,s1
    80001690:	00003517          	auipc	a0,0x3
    80001694:	19850513          	addi	a0,a0,408 # 80004828 <_ZN15MemoryAllocator14firstFreeBlockE>
    80001698:	00000097          	auipc	ra,0x0
    8000169c:	f20080e7          	jalr	-224(ra) # 800015b8 <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm>
}
    800016a0:	01813083          	ld	ra,24(sp)
    800016a4:	01013403          	ld	s0,16(sp)
    800016a8:	00813483          	ld	s1,8(sp)
    800016ac:	02010113          	addi	sp,sp,32
    800016b0:	00008067          	ret
        initializeMemory();
    800016b4:	00000097          	auipc	ra,0x0
    800016b8:	e00080e7          	jalr	-512(ra) # 800014b4 <_ZN15MemoryAllocator16initializeMemoryEv>
    800016bc:	fc5ff06f          	j	80001680 <_ZN15MemoryAllocator14allocateMemoryEm+0x24>
        return nullptr;
    800016c0:	00000513          	li	a0,0
    800016c4:	fddff06f          	j	800016a0 <_ZN15MemoryAllocator14allocateMemoryEm+0x44>

00000000800016c8 <_ZN15MemoryAllocator17findNextFreeBlockEPNS_9FreeBlockE>:
MemoryAllocator::FreeBlock* MemoryAllocator::findNextFreeBlock(FreeBlock* memoryToFree)
{
    800016c8:	ff010113          	addi	sp,sp,-16
    800016cc:	00813423          	sd	s0,8(sp)
    800016d0:	01010413          	addi	s0,sp,16
    for(uint8* i = (uint8*)memoryToFree; i + MEM_BLOCK_SIZE <= (uint8*)HEAP_END_ADDR; i+= (((OccupiedBlock*)i)->numOfBlocks * MEM_BLOCK_SIZE))
    800016d4:	04050793          	addi	a5,a0,64
    800016d8:	00003717          	auipc	a4,0x3
    800016dc:	0d873703          	ld	a4,216(a4) # 800047b0 <_GLOBAL_OFFSET_TABLE_+0x20>
    800016e0:	00073703          	ld	a4,0(a4)
    800016e4:	00f76e63          	bltu	a4,a5,80001700 <_ZN15MemoryAllocator17findNextFreeBlockEPNS_9FreeBlockE+0x38>
    {
        if(((FreeBlock*)i)->flagFree)
    800016e8:	00054783          	lbu	a5,0(a0)
    800016ec:	00079c63          	bnez	a5,80001704 <_ZN15MemoryAllocator17findNextFreeBlockEPNS_9FreeBlockE+0x3c>
    for(uint8* i = (uint8*)memoryToFree; i + MEM_BLOCK_SIZE <= (uint8*)HEAP_END_ADDR; i+= (((OccupiedBlock*)i)->numOfBlocks * MEM_BLOCK_SIZE))
    800016f0:	00853783          	ld	a5,8(a0)
    800016f4:	00679793          	slli	a5,a5,0x6
    800016f8:	00f50533          	add	a0,a0,a5
    800016fc:	fd9ff06f          	j	800016d4 <_ZN15MemoryAllocator17findNextFreeBlockEPNS_9FreeBlockE+0xc>
        {
            return (FreeBlock*)i;
        }
    }
    return nullptr;
    80001700:	00000513          	li	a0,0
}
    80001704:	00813403          	ld	s0,8(sp)
    80001708:	01010113          	addi	sp,sp,16
    8000170c:	00008067          	ret

0000000080001710 <_ZN15MemoryAllocator21findPreviousFreeBlockEPNS_9FreeBlockES1_>:

MemoryAllocator::FreeBlock* MemoryAllocator::findPreviousFreeBlock(FreeBlock* head, FreeBlock* memoryToFree)
{
    80001710:	ff010113          	addi	sp,sp,-16
    80001714:	00813423          	sd	s0,8(sp)
    80001718:	01010413          	addi	s0,sp,16
    FreeBlock* temp = head;
    for(; temp && temp <= memoryToFree; temp = temp->nextBlock){}
    8000171c:	00050863          	beqz	a0,8000172c <_ZN15MemoryAllocator21findPreviousFreeBlockEPNS_9FreeBlockES1_+0x1c>
    80001720:	00a5e663          	bltu	a1,a0,8000172c <_ZN15MemoryAllocator21findPreviousFreeBlockEPNS_9FreeBlockES1_+0x1c>
    80001724:	01053503          	ld	a0,16(a0)
    80001728:	ff5ff06f          	j	8000171c <_ZN15MemoryAllocator21findPreviousFreeBlockEPNS_9FreeBlockES1_+0xc>
    if(!temp)
    8000172c:	00050463          	beqz	a0,80001734 <_ZN15MemoryAllocator21findPreviousFreeBlockEPNS_9FreeBlockES1_+0x24>
    {
        return nullptr;
    }
    return temp->previousBlock;
    80001730:	01853503          	ld	a0,24(a0)
}
    80001734:	00813403          	ld	s0,8(sp)
    80001738:	01010113          	addi	sp,sp,16
    8000173c:	00008067          	ret

0000000080001740 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_>:

    return 0;
}

void MemoryAllocator::connectAdjacentBlocks(FreeBlock* previousBlock, FreeBlock* adjacentBlock)
{
    80001740:	ff010113          	addi	sp,sp,-16
    80001744:	00813423          	sd	s0,8(sp)
    80001748:	01010413          	addi	s0,sp,16


    if(adjacentBlock == (FreeBlock*)((uint8 *)previousBlock + previousBlock->numOfBlocks * MEM_BLOCK_SIZE))
    8000174c:	00853703          	ld	a4,8(a0)
    80001750:	00671793          	slli	a5,a4,0x6
    80001754:	00f507b3          	add	a5,a0,a5
    80001758:	00b78e63          	beq	a5,a1,80001774 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_+0x34>
        adjacentBlock->previousBlock = nullptr;

    }
    else
    {
        previousBlock->nextBlock = adjacentBlock;
    8000175c:	00b53823          	sd	a1,16(a0)
        if(adjacentBlock)
    80001760:	00058463          	beqz	a1,80001768 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_+0x28>
        {
            adjacentBlock->previousBlock = previousBlock;
    80001764:	00a5bc23          	sd	a0,24(a1)
        }

    }
}
    80001768:	00813403          	ld	s0,8(sp)
    8000176c:	01010113          	addi	sp,sp,16
    80001770:	00008067          	ret
        previousBlock->numOfBlocks += adjacentBlock->numOfBlocks;
    80001774:	0085b783          	ld	a5,8(a1)
    80001778:	00f70733          	add	a4,a4,a5
    8000177c:	00e53423          	sd	a4,8(a0)
        previousBlock->nextBlock = adjacentBlock->nextBlock;
    80001780:	0105b783          	ld	a5,16(a1)
    80001784:	00f53823          	sd	a5,16(a0)
        if(adjacentBlock->nextBlock != nullptr)
    80001788:	00078463          	beqz	a5,80001790 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_+0x50>
            adjacentBlock->nextBlock->previousBlock = previousBlock;
    8000178c:	00a7bc23          	sd	a0,24(a5)
        if(adjacentBlock->previousBlock != previousBlock && adjacentBlock->previousBlock != nullptr)
    80001790:	0185b783          	ld	a5,24(a1)
    80001794:	00a78863          	beq	a5,a0,800017a4 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_+0x64>
    80001798:	00078663          	beqz	a5,800017a4 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_+0x64>
            previousBlock->previousBlock = adjacentBlock->previousBlock;
    8000179c:	00f53c23          	sd	a5,24(a0)
            adjacentBlock->previousBlock->nextBlock = previousBlock;
    800017a0:	00a7b823          	sd	a0,16(a5)
        adjacentBlock->flagFree = false;
    800017a4:	00058023          	sb	zero,0(a1)
        adjacentBlock->numOfBlocks = 0;
    800017a8:	0005b423          	sd	zero,8(a1)
        adjacentBlock->nextBlock = nullptr;
    800017ac:	0005b823          	sd	zero,16(a1)
        adjacentBlock->previousBlock = nullptr;
    800017b0:	0005bc23          	sd	zero,24(a1)
    800017b4:	fb5ff06f          	j	80001768 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_+0x28>

00000000800017b8 <_ZN15MemoryAllocator10freeMemoryEPv>:
    if(!addressToFree)
    800017b8:	0c050e63          	beqz	a0,80001894 <_ZN15MemoryAllocator10freeMemoryEPv+0xdc>
{
    800017bc:	fc010113          	addi	sp,sp,-64
    800017c0:	02113c23          	sd	ra,56(sp)
    800017c4:	02813823          	sd	s0,48(sp)
    800017c8:	02913423          	sd	s1,40(sp)
    800017cc:	03213023          	sd	s2,32(sp)
    800017d0:	01313c23          	sd	s3,24(sp)
    800017d4:	01413823          	sd	s4,16(sp)
    800017d8:	01513423          	sd	s5,8(sp)
    800017dc:	04010413          	addi	s0,sp,64
    800017e0:	00050493          	mv	s1,a0
    tempAddress--;
    800017e4:	ff050913          	addi	s2,a0,-16
    int numOfTakenBlocks = tempAddress->numOfBlocks;
    800017e8:	ff852a83          	lw	s5,-8(a0)
    numOfFreeBlocks += numOfTakenBlocks;
    800017ec:	00003997          	auipc	s3,0x3
    800017f0:	02c98993          	addi	s3,s3,44 # 80004818 <_ZN15MemoryAllocator13NUM_OF_BLOCKSE>
    800017f4:	0089b783          	ld	a5,8(s3)
    800017f8:	015787b3          	add	a5,a5,s5
    800017fc:	00f9b423          	sd	a5,8(s3)
    FreeBlock* nextFreeBlock = findNextFreeBlock(newFreeBlock);
    80001800:	00090513          	mv	a0,s2
    80001804:	00000097          	auipc	ra,0x0
    80001808:	ec4080e7          	jalr	-316(ra) # 800016c8 <_ZN15MemoryAllocator17findNextFreeBlockEPNS_9FreeBlockE>
    8000180c:	00050a13          	mv	s4,a0
    FreeBlock* previousFreeBlock = findPreviousFreeBlock(firstFreeBlock, newFreeBlock);
    80001810:	00090593          	mv	a1,s2
    80001814:	0109b503          	ld	a0,16(s3)
    80001818:	00000097          	auipc	ra,0x0
    8000181c:	ef8080e7          	jalr	-264(ra) # 80001710 <_ZN15MemoryAllocator21findPreviousFreeBlockEPNS_9FreeBlockES1_>
    80001820:	00050993          	mv	s3,a0
    newFreeBlock->flagFree = true;
    80001824:	00100793          	li	a5,1
    80001828:	fef48823          	sb	a5,-16(s1)
    newFreeBlock->numOfBlocks = numOfTakenBlocks;
    8000182c:	ff54bc23          	sd	s5,-8(s1)
    newFreeBlock->nextBlock = nullptr;
    80001830:	0004b023          	sd	zero,0(s1)
    newFreeBlock->previousBlock = nullptr;
    80001834:	0004b423          	sd	zero,8(s1)
    connectAdjacentBlocks(newFreeBlock, nextFreeBlock);
    80001838:	000a0593          	mv	a1,s4
    8000183c:	00090513          	mv	a0,s2
    80001840:	00000097          	auipc	ra,0x0
    80001844:	f00080e7          	jalr	-256(ra) # 80001740 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_>
    if(previousFreeBlock)
    80001848:	02098e63          	beqz	s3,80001884 <_ZN15MemoryAllocator10freeMemoryEPv+0xcc>
        connectAdjacentBlocks(previousFreeBlock, newFreeBlock);
    8000184c:	00090593          	mv	a1,s2
    80001850:	00098513          	mv	a0,s3
    80001854:	00000097          	auipc	ra,0x0
    80001858:	eec080e7          	jalr	-276(ra) # 80001740 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_>
    return 0;
    8000185c:	00000513          	li	a0,0
}
    80001860:	03813083          	ld	ra,56(sp)
    80001864:	03013403          	ld	s0,48(sp)
    80001868:	02813483          	ld	s1,40(sp)
    8000186c:	02013903          	ld	s2,32(sp)
    80001870:	01813983          	ld	s3,24(sp)
    80001874:	01013a03          	ld	s4,16(sp)
    80001878:	00813a83          	ld	s5,8(sp)
    8000187c:	04010113          	addi	sp,sp,64
    80001880:	00008067          	ret
        firstFreeBlock = newFreeBlock;
    80001884:	00003797          	auipc	a5,0x3
    80001888:	fb27b223          	sd	s2,-92(a5) # 80004828 <_ZN15MemoryAllocator14firstFreeBlockE>
    return 0;
    8000188c:	00000513          	li	a0,0
    80001890:	fd1ff06f          	j	80001860 <_ZN15MemoryAllocator10freeMemoryEPv+0xa8>
        return -1;
    80001894:	fff00513          	li	a0,-1
}
    80001898:	00008067          	ret

000000008000189c <_ZN15MemoryAllocator19getLargestFreeBlockEv>:

size_t  MemoryAllocator::getLargestFreeBlock()
{
    8000189c:	ff010113          	addi	sp,sp,-16
    800018a0:	00813423          	sd	s0,8(sp)
    800018a4:	01010413          	addi	s0,sp,16
    size_t largestBlock = firstFreeBlock->numOfBlocks;
    800018a8:	00003797          	auipc	a5,0x3
    800018ac:	f807b783          	ld	a5,-128(a5) # 80004828 <_ZN15MemoryAllocator14firstFreeBlockE>
    800018b0:	0087b503          	ld	a0,8(a5)
    for(FreeBlock* curr = firstFreeBlock->nextBlock; curr; curr = curr->nextBlock)
    800018b4:	0107b783          	ld	a5,16(a5)
    800018b8:	0080006f          	j	800018c0 <_ZN15MemoryAllocator19getLargestFreeBlockEv+0x24>
    800018bc:	0107b783          	ld	a5,16(a5)
    800018c0:	00078a63          	beqz	a5,800018d4 <_ZN15MemoryAllocator19getLargestFreeBlockEv+0x38>
    {
        if(curr->numOfBlocks > largestBlock)
    800018c4:	0087b703          	ld	a4,8(a5)
    800018c8:	fee57ae3          	bgeu	a0,a4,800018bc <_ZN15MemoryAllocator19getLargestFreeBlockEv+0x20>
        {
            largestBlock = curr->numOfBlocks;
    800018cc:	00070513          	mv	a0,a4
    800018d0:	fedff06f          	j	800018bc <_ZN15MemoryAllocator19getLargestFreeBlockEv+0x20>
        }
    }
    return largestBlock * MEM_BLOCK_SIZE;
}
    800018d4:	00651513          	slli	a0,a0,0x6
    800018d8:	00813403          	ld	s0,8(sp)
    800018dc:	01010113          	addi	sp,sp,16
    800018e0:	00008067          	ret

00000000800018e4 <_ZN15MemoryAllocator12getFreeSpaceEv>:
size_t MemoryAllocator::getFreeSpace()
{
    800018e4:	ff010113          	addi	sp,sp,-16
    800018e8:	00813423          	sd	s0,8(sp)
    800018ec:	01010413          	addi	s0,sp,16
    return numOfFreeBlocks * MEM_BLOCK_SIZE;
}
    800018f0:	00003517          	auipc	a0,0x3
    800018f4:	f3053503          	ld	a0,-208(a0) # 80004820 <_ZN15MemoryAllocator15numOfFreeBlocksE>
    800018f8:	00651513          	slli	a0,a0,0x6
    800018fc:	00813403          	ld	s0,8(sp)
    80001900:	01010113          	addi	sp,sp,16
    80001904:	00008067          	ret

0000000080001908 <_ZN15MemoryAllocator17getSizeOfMetaDataEv>:

size_t MemoryAllocator::getSizeOfMetaData()
{
    80001908:	ff010113          	addi	sp,sp,-16
    8000190c:	00813423          	sd	s0,8(sp)
    80001910:	01010413          	addi	s0,sp,16
    return sizeof(OccupiedBlock);
    80001914:	01000513          	li	a0,16
    80001918:	00813403          	ld	s0,8(sp)
    8000191c:	01010113          	addi	sp,sp,16
    80001920:	00008067          	ret

0000000080001924 <_ZN6Kernel9sysMallocEPNS_21ArgumentsOfSystemCallE>:
    __asm__ volatile("ld %[rd], 16*8(%[rs])":[rd]"=r"(arg->a5):[rs]"r"(basePointer));
    __asm__ volatile("ld %[rd], 17*8(%[rs])":[rd]"=r"(arg->a6):[rs]"r"(basePointer));
}

uint64 Kernel::sysMalloc(Kernel::ArgumentsOfSystemCall *arg)
{
    80001924:	ff010113          	addi	sp,sp,-16
    80001928:	00113423          	sd	ra,8(sp)
    8000192c:	00813023          	sd	s0,0(sp)
    80001930:	01010413          	addi	s0,sp,16
    uint64 returnValue;
    returnValue = (uint64)MemoryAllocator::allocateMemory(arg->a0);
    80001934:	00053503          	ld	a0,0(a0)
    80001938:	00000097          	auipc	ra,0x0
    8000193c:	d24080e7          	jalr	-732(ra) # 8000165c <_ZN15MemoryAllocator14allocateMemoryEm>
    return returnValue;
}
    80001940:	00813083          	ld	ra,8(sp)
    80001944:	00013403          	ld	s0,0(sp)
    80001948:	01010113          	addi	sp,sp,16
    8000194c:	00008067          	ret

0000000080001950 <_ZN6Kernel7sysFreeEPNS_21ArgumentsOfSystemCallE>:
uint64 Kernel::sysFree(Kernel::ArgumentsOfSystemCall *arg)
{
    80001950:	ff010113          	addi	sp,sp,-16
    80001954:	00113423          	sd	ra,8(sp)
    80001958:	00813023          	sd	s0,0(sp)
    8000195c:	01010413          	addi	s0,sp,16
    uint64 returnValue;
    returnValue = (uint64)MemoryAllocator::freeMemory((void*)arg->a0);
    80001960:	00053503          	ld	a0,0(a0)
    80001964:	00000097          	auipc	ra,0x0
    80001968:	e54080e7          	jalr	-428(ra) # 800017b8 <_ZN15MemoryAllocator10freeMemoryEPv>
    return returnValue;
}
    8000196c:	00813083          	ld	ra,8(sp)
    80001970:	00013403          	ld	s0,0(sp)
    80001974:	01010113          	addi	sp,sp,16
    80001978:	00008067          	ret

000000008000197c <_ZN6Kernel15sysGetFreeSpaceEPNS_21ArgumentsOfSystemCallE>:
uint64 Kernel::sysGetFreeSpace(Kernel::ArgumentsOfSystemCall *arg)
{
    8000197c:	ff010113          	addi	sp,sp,-16
    80001980:	00113423          	sd	ra,8(sp)
    80001984:	00813023          	sd	s0,0(sp)
    80001988:	01010413          	addi	s0,sp,16
    uint64 returnValue;
    returnValue = (uint64)MemoryAllocator::getFreeSpace();
    8000198c:	00000097          	auipc	ra,0x0
    80001990:	f58080e7          	jalr	-168(ra) # 800018e4 <_ZN15MemoryAllocator12getFreeSpaceEv>
    return returnValue;
}
    80001994:	00813083          	ld	ra,8(sp)
    80001998:	00013403          	ld	s0,0(sp)
    8000199c:	01010113          	addi	sp,sp,16
    800019a0:	00008067          	ret

00000000800019a4 <_ZN6Kernel19sysLargestFreeBlockEPNS_21ArgumentsOfSystemCallE>:
uint64 Kernel::sysLargestFreeBlock(Kernel::ArgumentsOfSystemCall *arg)
{
    800019a4:	ff010113          	addi	sp,sp,-16
    800019a8:	00113423          	sd	ra,8(sp)
    800019ac:	00813023          	sd	s0,0(sp)
    800019b0:	01010413          	addi	s0,sp,16
    uint64 returnValue;
    returnValue = (uint64)MemoryAllocator::getLargestFreeBlock();
    800019b4:	00000097          	auipc	ra,0x0
    800019b8:	ee8080e7          	jalr	-280(ra) # 8000189c <_ZN15MemoryAllocator19getLargestFreeBlockEv>
    return returnValue;
}
    800019bc:	00813083          	ld	ra,8(sp)
    800019c0:	00013403          	ld	s0,0(sp)
    800019c4:	01010113          	addi	sp,sp,16
    800019c8:	00008067          	ret

00000000800019cc <_ZN6Kernel19initializeArgumentsEPNS_21ArgumentsOfSystemCallEm>:
{
    800019cc:	ff010113          	addi	sp,sp,-16
    800019d0:	00813423          	sd	s0,8(sp)
    800019d4:	01010413          	addi	s0,sp,16
    __asm__ volatile("ld %[rd], 11*8(%[rs])":[rd]"=r"(arg->a0):[rs]"r"(basePointer));
    800019d8:	0585b783          	ld	a5,88(a1)
    800019dc:	00f53023          	sd	a5,0(a0)
    __asm__ volatile("ld %[rd], 12*8(%[rs])":[rd]"=r"(arg->a1):[rs]"r"(basePointer));
    800019e0:	0605b783          	ld	a5,96(a1)
    800019e4:	00f53423          	sd	a5,8(a0)
    __asm__ volatile("ld %[rd], 13*8(%[rs])":[rd]"=r"(arg->a2):[rs]"r"(basePointer));
    800019e8:	0685b783          	ld	a5,104(a1)
    800019ec:	00f53823          	sd	a5,16(a0)
    __asm__ volatile("ld %[rd], 14*8(%[rs])":[rd]"=r"(arg->a3):[rs]"r"(basePointer));
    800019f0:	0705b783          	ld	a5,112(a1)
    800019f4:	00f53c23          	sd	a5,24(a0)
    __asm__ volatile("ld %[rd], 15*8(%[rs])":[rd]"=r"(arg->a4):[rs]"r"(basePointer));
    800019f8:	0785b783          	ld	a5,120(a1)
    800019fc:	02f53023          	sd	a5,32(a0)
    __asm__ volatile("ld %[rd], 16*8(%[rs])":[rd]"=r"(arg->a5):[rs]"r"(basePointer));
    80001a00:	0805b783          	ld	a5,128(a1)
    80001a04:	02f53423          	sd	a5,40(a0)
    __asm__ volatile("ld %[rd], 17*8(%[rs])":[rd]"=r"(arg->a6):[rs]"r"(basePointer));
    80001a08:	0885b583          	ld	a1,136(a1)
    80001a0c:	02b53823          	sd	a1,48(a0)
}
    80001a10:	00813403          	ld	s0,8(sp)
    80001a14:	01010113          	addi	sp,sp,16
    80001a18:	00008067          	ret

0000000080001a1c <_ZN6Kernel16interruptHandlerEv>:
    __asm__ volatile("sd %[ptrThread], 0(%[handle])"::[ptrThread]"r"(newThread), [handle]"r"(arg->a0));
    newThread->initializeThread((TCB::Body) arg->a1, (void*)arg->a2, (void*)arg->a3);
    return 0;
}
void Kernel::interruptHandler()
{
    80001a1c:	fa010113          	addi	sp,sp,-96
    80001a20:	04113c23          	sd	ra,88(sp)
    80001a24:	04813823          	sd	s0,80(sp)
    80001a28:	04913423          	sd	s1,72(sp)
    80001a2c:	05213023          	sd	s2,64(sp)
    80001a30:	06010413          	addi	s0,sp,96
    volatile uint64 basePointer;
    __asm__ volatile ("addi %[reg], s0, 0x0": [reg]"=r"(basePointer)); // Problem: da li mozemo biti 100% sigurni da ce s0 biti nepromenjen; resenje inline f-ja
    80001a34:	00040793          	mv	a5,s0
    80001a38:	fcf43c23          	sd	a5,-40(s0)
}

inline uint64 Machine::readScause(void)
{
    uint64 scause;
    __asm__ volatile ("csrr %[cause], scause": [cause] "=r"(scause));
    80001a3c:	142027f3          	csrr	a5,scause
    uint64 scause = Machine::readScause();
    if(scause == 0x0000000000000008UL || scause == 0x0000000000000009UL)
    80001a40:	ff878793          	addi	a5,a5,-8
    80001a44:	00100713          	li	a4,1
    80001a48:	00f77e63          	bgeu	a4,a5,80001a64 <_ZN6Kernel16interruptHandlerEv+0x48>
        __asm__ volatile("sd a0, 80(%[rs])"::[rs]"r"(basePointer));
        //yield;
        Machine::incrementSepc();
    }

    80001a4c:	05813083          	ld	ra,88(sp)
    80001a50:	05013403          	ld	s0,80(sp)
    80001a54:	04813483          	ld	s1,72(sp)
    80001a58:	04013903          	ld	s2,64(sp)
    80001a5c:	06010113          	addi	sp,sp,96
    80001a60:	00008067          	ret
        __asm__ volatile ("ld %[rd], 80(%[rs])": [rd]"=r"(numberOfEntry):[rs]"r"(basePointer));
    80001a64:	fd843483          	ld	s1,-40(s0)
    80001a68:	0504b483          	ld	s1,80(s1)
        initializeArguments(&arg, basePointer);
    80001a6c:	fd843583          	ld	a1,-40(s0)
    80001a70:	fa040913          	addi	s2,s0,-96
    80001a74:	00090513          	mv	a0,s2
    80001a78:	00000097          	auipc	ra,0x0
    80001a7c:	f54080e7          	jalr	-172(ra) # 800019cc <_ZN6Kernel19initializeArgumentsEPNS_21ArgumentsOfSystemCallEm>
        systemCallsTable[numberOfEntry](&arg);
    80001a80:	00349493          	slli	s1,s1,0x3
    80001a84:	00003797          	auipc	a5,0x3
    80001a88:	db478793          	addi	a5,a5,-588 # 80004838 <_ZN6Kernel16systemCallsTableE>
    80001a8c:	009784b3          	add	s1,a5,s1
    80001a90:	0004b783          	ld	a5,0(s1)
    80001a94:	00090513          	mv	a0,s2
    80001a98:	000780e7          	jalr	a5
        __asm__ volatile("sd a0, 80(%[rs])"::[rs]"r"(basePointer));
    80001a9c:	fd843783          	ld	a5,-40(s0)
    80001aa0:	04a7b823          	sd	a0,80(a5)
    return scause;
}

inline void Machine::incrementSepc(void)
{
    __asm__ volatile ("csrr t0, sepc");
    80001aa4:	141022f3          	csrr	t0,sepc
    __asm__ volatile ("addi t0, t0, 0x4");
    80001aa8:	00428293          	addi	t0,t0,4
    __asm__ volatile ("csrw sepc, t0");
    80001aac:	14129073          	csrw	sepc,t0
    80001ab0:	f9dff06f          	j	80001a4c <_ZN6Kernel16interruptHandlerEv+0x30>

0000000080001ab4 <_ZN6Kernel16initializeKernelEv>:
{
    80001ab4:	ff010113          	addi	sp,sp,-16
    80001ab8:	00113423          	sd	ra,8(sp)
    80001abc:	00813023          	sd	s0,0(sp)
    80001ac0:	01010413          	addi	s0,sp,16

};

inline void Kernel::setInterruptRoutine(void (*routine)(void))
{
    Machine::writeStvec((uint64) routine);
    80001ac4:	00003797          	auipc	a5,0x3
    80001ac8:	ce47b783          	ld	a5,-796(a5) # 800047a8 <_GLOBAL_OFFSET_TABLE_+0x18>
    __asm__ volatile ("csrw stvec, %[address]": : [address] "r"(interruptAddress));
    80001acc:	10579073          	csrw	stvec,a5
}
    80001ad0:	0100006f          	j	80001ae0 <_ZN6Kernel16initializeKernelEv+0x2c>

        for(size_t i = 0; i < numOfObjects - 1; i++)
        {
            pool[i].nextFree = &(pool[i+1]);
        }
        pool[numOfObjects - 1].nextFree = nullptr;
    80001ad4:	6c053c23          	sd	zero,1752(a0)
     poolOfThreads = new ObjectPool<TCB, KernelConfig::NUM_OF_THREADS_IN_POOL>();
    80001ad8:	00003797          	auipc	a5,0x3
    80001adc:	f6a7b823          	sd	a0,-144(a5) # 80004a48 <_ZN6Kernel13poolOfThreadsE>
    while(!poolOfThreads)
    80001ae0:	00003797          	auipc	a5,0x3
    80001ae4:	f687b783          	ld	a5,-152(a5) # 80004a48 <_ZN6Kernel13poolOfThreadsE>
    80001ae8:	06079263          	bnez	a5,80001b4c <_ZN6Kernel16initializeKernelEv+0x98>
     poolOfThreads = new ObjectPool<TCB, KernelConfig::NUM_OF_THREADS_IN_POOL>();
    80001aec:	70000513          	li	a0,1792
    80001af0:	00000097          	auipc	ra,0x0
    80001af4:	1f0080e7          	jalr	496(ra) # 80001ce0 <_ZN10ObjectPoolI3TCBLm20EEnwEm>
    ObjectPool(): headFreeObject(pool), nextObjectPool(nullptr), prevObjectPool(nullptr), id(countOfPools++)
    80001af8:	6ea53023          	sd	a0,1760(a0)
    80001afc:	6e053423          	sd	zero,1768(a0)
    80001b00:	6e053823          	sd	zero,1776(a0)
    80001b04:	00003717          	auipc	a4,0x3
    80001b08:	f5470713          	addi	a4,a4,-172 # 80004a58 <_ZN10ObjectPoolI3TCBLm20EE12countOfPoolsE>
    80001b0c:	00073783          	ld	a5,0(a4)
    80001b10:	00178693          	addi	a3,a5,1
    80001b14:	00d73023          	sd	a3,0(a4)
    80001b18:	6ef53c23          	sd	a5,1784(a0)
        for(size_t i = 0; i < numOfObjects - 1; i++)
    80001b1c:	00000793          	li	a5,0
    80001b20:	01200713          	li	a4,18
    80001b24:	faf768e3          	bltu	a4,a5,80001ad4 <_ZN6Kernel16initializeKernelEv+0x20>
            pool[i].nextFree = &(pool[i+1]);
    80001b28:	00178693          	addi	a3,a5,1
    80001b2c:	05800613          	li	a2,88
    80001b30:	02c68733          	mul	a4,a3,a2
    80001b34:	00e50733          	add	a4,a0,a4
    80001b38:	02c787b3          	mul	a5,a5,a2
    80001b3c:	00f507b3          	add	a5,a0,a5
    80001b40:	04e7b823          	sd	a4,80(a5)
        for(size_t i = 0; i < numOfObjects - 1; i++)
    80001b44:	00068793          	mv	a5,a3
    80001b48:	fd9ff06f          	j	80001b20 <_ZN6Kernel16initializeKernelEv+0x6c>
    systemCallsTable[MEM_ALLOC] = &sysMalloc;
    80001b4c:	00003797          	auipc	a5,0x3
    80001b50:	cec78793          	addi	a5,a5,-788 # 80004838 <_ZN6Kernel16systemCallsTableE>
    80001b54:	00000717          	auipc	a4,0x0
    80001b58:	dd070713          	addi	a4,a4,-560 # 80001924 <_ZN6Kernel9sysMallocEPNS_21ArgumentsOfSystemCallE>
    80001b5c:	00e7b423          	sd	a4,8(a5)
    systemCallsTable[MEM_FREE] = &sysFree;
    80001b60:	00000717          	auipc	a4,0x0
    80001b64:	df070713          	addi	a4,a4,-528 # 80001950 <_ZN6Kernel7sysFreeEPNS_21ArgumentsOfSystemCallE>
    80001b68:	00e7b823          	sd	a4,16(a5)
    systemCallsTable[MEM_FREE_SPACE] = &sysGetFreeSpace;
    80001b6c:	00000717          	auipc	a4,0x0
    80001b70:	e1070713          	addi	a4,a4,-496 # 8000197c <_ZN6Kernel15sysGetFreeSpaceEPNS_21ArgumentsOfSystemCallE>
    80001b74:	00e7bc23          	sd	a4,24(a5)
    systemCallsTable[LARGEST_FREE_BLOCK] = &sysLargestFreeBlock;
    80001b78:	00000717          	auipc	a4,0x0
    80001b7c:	e2c70713          	addi	a4,a4,-468 # 800019a4 <_ZN6Kernel19sysLargestFreeBlockEPNS_21ArgumentsOfSystemCallE>
    80001b80:	02e7b023          	sd	a4,32(a5)
    systemCallsTable[CREATE_THREAD] = &sysCreateThread;
    80001b84:	00000717          	auipc	a4,0x0
    80001b88:	0c070713          	addi	a4,a4,192 # 80001c44 <_ZN6Kernel15sysCreateThreadEPNS_21ArgumentsOfSystemCallE>
    80001b8c:	08e7b423          	sd	a4,136(a5)
}
    80001b90:	00813083          	ld	ra,8(sp)
    80001b94:	00013403          	ld	s0,0(sp)
    80001b98:	01010113          	addi	sp,sp,16
    80001b9c:	00008067          	ret

0000000080001ba0 <_Z41__static_initialization_and_destruction_0ii>:
    80001ba0:	00100793          	li	a5,1
    80001ba4:	00f50463          	beq	a0,a5,80001bac <_Z41__static_initialization_and_destruction_0ii+0xc>
    80001ba8:	00008067          	ret
    80001bac:	000107b7          	lui	a5,0x10
    80001bb0:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80001bb4:	fef59ae3          	bne	a1,a5,80001ba8 <_Z41__static_initialization_and_destruction_0ii+0x8>
    80001bb8:	ff010113          	addi	sp,sp,-16
    80001bbc:	00113423          	sd	ra,8(sp)
    80001bc0:	00813023          	sd	s0,0(sp)
    80001bc4:	01010413          	addi	s0,sp,16
ObjectPool<TCB, KernelConfig::NUM_OF_THREADS_IN_POOL>* Kernel::poolOfThreads = new ObjectPool<TCB, KernelConfig::NUM_OF_THREADS_IN_POOL>();
    80001bc8:	70000513          	li	a0,1792
    80001bcc:	00000097          	auipc	ra,0x0
    80001bd0:	114080e7          	jalr	276(ra) # 80001ce0 <_ZN10ObjectPoolI3TCBLm20EEnwEm>
    ObjectPool(): headFreeObject(pool), nextObjectPool(nullptr), prevObjectPool(nullptr), id(countOfPools++)
    80001bd4:	6ea53023          	sd	a0,1760(a0)
    80001bd8:	6e053423          	sd	zero,1768(a0)
    80001bdc:	6e053823          	sd	zero,1776(a0)
    80001be0:	00003717          	auipc	a4,0x3
    80001be4:	e7870713          	addi	a4,a4,-392 # 80004a58 <_ZN10ObjectPoolI3TCBLm20EE12countOfPoolsE>
    80001be8:	00073783          	ld	a5,0(a4)
    80001bec:	00178693          	addi	a3,a5,1
    80001bf0:	00d73023          	sd	a3,0(a4)
    80001bf4:	6ef53c23          	sd	a5,1784(a0)
        for(size_t i = 0; i < numOfObjects - 1; i++)
    80001bf8:	00000793          	li	a5,0
    80001bfc:	01200713          	li	a4,18
    80001c00:	02f76463          	bltu	a4,a5,80001c28 <_Z41__static_initialization_and_destruction_0ii+0x88>
            pool[i].nextFree = &(pool[i+1]);
    80001c04:	00178693          	addi	a3,a5,1
    80001c08:	05800613          	li	a2,88
    80001c0c:	02c68733          	mul	a4,a3,a2
    80001c10:	00e50733          	add	a4,a0,a4
    80001c14:	02c787b3          	mul	a5,a5,a2
    80001c18:	00f507b3          	add	a5,a0,a5
    80001c1c:	04e7b823          	sd	a4,80(a5)
        for(size_t i = 0; i < numOfObjects - 1; i++)
    80001c20:	00068793          	mv	a5,a3
    80001c24:	fd9ff06f          	j	80001bfc <_Z41__static_initialization_and_destruction_0ii+0x5c>
        pool[numOfObjects - 1].nextFree = nullptr;
    80001c28:	6c053c23          	sd	zero,1752(a0)
    80001c2c:	00003797          	auipc	a5,0x3
    80001c30:	e0a7be23          	sd	a0,-484(a5) # 80004a48 <_ZN6Kernel13poolOfThreadsE>
    80001c34:	00813083          	ld	ra,8(sp)
    80001c38:	00013403          	ld	s0,0(sp)
    80001c3c:	01010113          	addi	sp,sp,16
    80001c40:	00008067          	ret

0000000080001c44 <_ZN6Kernel15sysCreateThreadEPNS_21ArgumentsOfSystemCallE>:
{
    80001c44:	fe010113          	addi	sp,sp,-32
    80001c48:	00113c23          	sd	ra,24(sp)
    80001c4c:	00813823          	sd	s0,16(sp)
    80001c50:	00913423          	sd	s1,8(sp)
    80001c54:	02010413          	addi	s0,sp,32
    80001c58:	00050493          	mv	s1,a0
    TCB* newThread = poolOfThreads->mallocObject();
    80001c5c:	00003517          	auipc	a0,0x3
    80001c60:	dec53503          	ld	a0,-532(a0) # 80004a48 <_ZN6Kernel13poolOfThreadsE>
    80001c64:	00000097          	auipc	ra,0x0
    80001c68:	0e8080e7          	jalr	232(ra) # 80001d4c <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEv>
    if(!newThread)
    80001c6c:	02050c63          	beqz	a0,80001ca4 <_ZN6Kernel15sysCreateThreadEPNS_21ArgumentsOfSystemCallE+0x60>
    __asm__ volatile("sd %[ptrThread], 0(%[handle])"::[ptrThread]"r"(newThread), [handle]"r"(arg->a0));
    80001c70:	0004b783          	ld	a5,0(s1)
    80001c74:	00a7b023          	sd	a0,0(a5)
    newThread->initializeThread((TCB::Body) arg->a1, (void*)arg->a2, (void*)arg->a3);
    80001c78:	0184b683          	ld	a3,24(s1)
    80001c7c:	0104b603          	ld	a2,16(s1)
    80001c80:	0084b583          	ld	a1,8(s1)
    80001c84:	fffff097          	auipc	ra,0xfffff
    80001c88:	7a4080e7          	jalr	1956(ra) # 80001428 <_ZN3TCB16initializeThreadEPFvPvES0_S0_>
    return 0;
    80001c8c:	00000513          	li	a0,0
}
    80001c90:	01813083          	ld	ra,24(sp)
    80001c94:	01013403          	ld	s0,16(sp)
    80001c98:	00813483          	ld	s1,8(sp)
    80001c9c:	02010113          	addi	sp,sp,32
    80001ca0:	00008067          	ret
        return -1;
    80001ca4:	fff00513          	li	a0,-1
    80001ca8:	fe9ff06f          	j	80001c90 <_ZN6Kernel15sysCreateThreadEPNS_21ArgumentsOfSystemCallE+0x4c>

0000000080001cac <_GLOBAL__sub_I__ZN6Kernel16systemCallsTableE>:
    80001cac:	ff010113          	addi	sp,sp,-16
    80001cb0:	00113423          	sd	ra,8(sp)
    80001cb4:	00813023          	sd	s0,0(sp)
    80001cb8:	01010413          	addi	s0,sp,16
    80001cbc:	000105b7          	lui	a1,0x10
    80001cc0:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    80001cc4:	00100513          	li	a0,1
    80001cc8:	00000097          	auipc	ra,0x0
    80001ccc:	ed8080e7          	jalr	-296(ra) # 80001ba0 <_Z41__static_initialization_and_destruction_0ii>
    80001cd0:	00813083          	ld	ra,8(sp)
    80001cd4:	00013403          	ld	s0,0(sp)
    80001cd8:	01010113          	addi	sp,sp,16
    80001cdc:	00008067          	ret

0000000080001ce0 <_ZN10ObjectPoolI3TCBLm20EEnwEm>:
template<typename T, size_t numOfObjects>
size_t ObjectPool<T, numOfObjects>::countOfPools = 0;


template<typename T, size_t numOfObjects>
void* ObjectPool<T, numOfObjects>::operator new(size_t size)
    80001ce0:	ff010113          	addi	sp,sp,-16
    80001ce4:	00113423          	sd	ra,8(sp)
    80001ce8:	00813023          	sd	s0,0(sp)
    80001cec:	01010413          	addi	s0,sp,16
{
    size_t numOfBlocks = size / MEM_BLOCK_SIZE;
    80001cf0:	00655793          	srli	a5,a0,0x6
    numOfBlocks += size % MEM_BLOCK_SIZE ? 1 : 0;
    80001cf4:	03f57513          	andi	a0,a0,63
    80001cf8:	00050463          	beqz	a0,80001d00 <_ZN10ObjectPoolI3TCBLm20EEnwEm+0x20>
    80001cfc:	00100513          	li	a0,1
    return MemoryAllocator::allocateMemory(numOfBlocks);
    80001d00:	00f50533          	add	a0,a0,a5
    80001d04:	00000097          	auipc	ra,0x0
    80001d08:	958080e7          	jalr	-1704(ra) # 8000165c <_ZN15MemoryAllocator14allocateMemoryEm>
}
    80001d0c:	00813083          	ld	ra,8(sp)
    80001d10:	00013403          	ld	s0,0(sp)
    80001d14:	01010113          	addi	sp,sp,16
    80001d18:	00008067          	ret

0000000080001d1c <_ZN10ObjectPoolI3TCBLm20EE12findFreePoolEv>:

template<typename T, size_t numOfObjects>
ObjectPool<T, numOfObjects>* ObjectPool<T, numOfObjects>::findFreePool(void)
    80001d1c:	ff010113          	addi	sp,sp,-16
    80001d20:	00813423          	sd	s0,8(sp)
    80001d24:	01010413          	addi	s0,sp,16
    80001d28:	00050793          	mv	a5,a0
{
    ObjectPool<T, numOfObjects>* curr = this;
    for(; !curr->nextObjectPool && !curr->headFreeObject; curr = curr->nextObjectPool);
    80001d2c:	00078513          	mv	a0,a5
    80001d30:	6e87b783          	ld	a5,1768(a5)
    80001d34:	00079663          	bnez	a5,80001d40 <_ZN10ObjectPoolI3TCBLm20EE12findFreePoolEv+0x24>
    80001d38:	6e053703          	ld	a4,1760(a0)
    80001d3c:	fe0708e3          	beqz	a4,80001d2c <_ZN10ObjectPoolI3TCBLm20EE12findFreePoolEv+0x10>
    return curr;
}
    80001d40:	00813403          	ld	s0,8(sp)
    80001d44:	01010113          	addi	sp,sp,16
    80001d48:	00008067          	ret

0000000080001d4c <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEv>:

template<typename T, size_t numOfObjects>
T* ObjectPool<T, numOfObjects>::mallocObject(void)
    80001d4c:	fe010113          	addi	sp,sp,-32
    80001d50:	00113c23          	sd	ra,24(sp)
    80001d54:	00813823          	sd	s0,16(sp)
    80001d58:	00913423          	sd	s1,8(sp)
    80001d5c:	02010413          	addi	s0,sp,32
{
    ObjectPool<T,numOfObjects>* currentPool = findFreePool();
    80001d60:	00000097          	auipc	ra,0x0
    80001d64:	fbc080e7          	jalr	-68(ra) # 80001d1c <_ZN10ObjectPoolI3TCBLm20EE12findFreePoolEv>
    80001d68:	00050493          	mv	s1,a0
    if (currentPool->headFreeObject)
    80001d6c:	6e053503          	ld	a0,1760(a0)
    80001d70:	02050063          	beqz	a0,80001d90 <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEv+0x44>
    {
        PoolObject* temp = currentPool->headFreeObject;
        currentPool->headFreeObject = currentPool->headFreeObject->nextFree;
    80001d74:	05053783          	ld	a5,80(a0)
    80001d78:	6ef4b023          	sd	a5,1760(s1)

        PoolObject* temp = newPool->headFreeObject;
        newPool->headFreeObject = newPool->headFreeObject->nextFree;
        return &(temp->object);
    }
}
    80001d7c:	01813083          	ld	ra,24(sp)
    80001d80:	01013403          	ld	s0,16(sp)
    80001d84:	00813483          	ld	s1,8(sp)
    80001d88:	02010113          	addi	sp,sp,32
    80001d8c:	00008067          	ret
        ObjectPool<T, numOfObjects>* newPool = new ObjectPool();
    80001d90:	70000513          	li	a0,1792
    80001d94:	00000097          	auipc	ra,0x0
    80001d98:	f4c080e7          	jalr	-180(ra) # 80001ce0 <_ZN10ObjectPoolI3TCBLm20EEnwEm>
    ObjectPool(): headFreeObject(pool), nextObjectPool(nullptr), prevObjectPool(nullptr), id(countOfPools++)
    80001d9c:	6ea53023          	sd	a0,1760(a0)
    80001da0:	6e053423          	sd	zero,1768(a0)
    80001da4:	6e053823          	sd	zero,1776(a0)
    80001da8:	00003717          	auipc	a4,0x3
    80001dac:	cb070713          	addi	a4,a4,-848 # 80004a58 <_ZN10ObjectPoolI3TCBLm20EE12countOfPoolsE>
    80001db0:	00073783          	ld	a5,0(a4)
    80001db4:	00178693          	addi	a3,a5,1
    80001db8:	00d73023          	sd	a3,0(a4)
    80001dbc:	6ef53c23          	sd	a5,1784(a0)
        for(size_t i = 0; i < numOfObjects - 1; i++)
    80001dc0:	00000793          	li	a5,0
    80001dc4:	01200713          	li	a4,18
    80001dc8:	02f76463          	bltu	a4,a5,80001df0 <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEv+0xa4>
            pool[i].nextFree = &(pool[i+1]);
    80001dcc:	00178693          	addi	a3,a5,1
    80001dd0:	05800613          	li	a2,88
    80001dd4:	02c68733          	mul	a4,a3,a2
    80001dd8:	00e50733          	add	a4,a0,a4
    80001ddc:	02c787b3          	mul	a5,a5,a2
    80001de0:	00f507b3          	add	a5,a0,a5
    80001de4:	04e7b823          	sd	a4,80(a5)
        for(size_t i = 0; i < numOfObjects - 1; i++)
    80001de8:	00068793          	mv	a5,a3
    80001dec:	fd9ff06f          	j	80001dc4 <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEv+0x78>
        pool[numOfObjects - 1].nextFree = nullptr;
    80001df0:	6c053c23          	sd	zero,1752(a0)
        if(!newPool)
    80001df4:	f80504e3          	beqz	a0,80001d7c <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEv+0x30>
        newPool->prevObjectPool = currentPool;
    80001df8:	6e953823          	sd	s1,1776(a0)
        currentPool->nextObjectPool = newPool;
    80001dfc:	6ea4b423          	sd	a0,1768(s1)
        PoolObject* temp = newPool->headFreeObject;
    80001e00:	6e053783          	ld	a5,1760(a0)
        newPool->headFreeObject = newPool->headFreeObject->nextFree;
    80001e04:	0507b703          	ld	a4,80(a5)
    80001e08:	6ee53023          	sd	a4,1760(a0)
        return &(temp->object);
    80001e0c:	00078513          	mv	a0,a5
    80001e10:	f6dff06f          	j	80001d7c <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEv+0x30>

0000000080001e14 <start>:
    80001e14:	ff010113          	addi	sp,sp,-16
    80001e18:	00813423          	sd	s0,8(sp)
    80001e1c:	01010413          	addi	s0,sp,16
    80001e20:	300027f3          	csrr	a5,mstatus
    80001e24:	ffffe737          	lui	a4,0xffffe
    80001e28:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff8b4f>
    80001e2c:	00e7f7b3          	and	a5,a5,a4
    80001e30:	00001737          	lui	a4,0x1
    80001e34:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80001e38:	00e7e7b3          	or	a5,a5,a4
    80001e3c:	30079073          	csrw	mstatus,a5
    80001e40:	00000797          	auipc	a5,0x0
    80001e44:	16078793          	addi	a5,a5,352 # 80001fa0 <system_main>
    80001e48:	34179073          	csrw	mepc,a5
    80001e4c:	00000793          	li	a5,0
    80001e50:	18079073          	csrw	satp,a5
    80001e54:	000107b7          	lui	a5,0x10
    80001e58:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80001e5c:	30279073          	csrw	medeleg,a5
    80001e60:	30379073          	csrw	mideleg,a5
    80001e64:	104027f3          	csrr	a5,sie
    80001e68:	2227e793          	ori	a5,a5,546
    80001e6c:	10479073          	csrw	sie,a5
    80001e70:	fff00793          	li	a5,-1
    80001e74:	00a7d793          	srli	a5,a5,0xa
    80001e78:	3b079073          	csrw	pmpaddr0,a5
    80001e7c:	00f00793          	li	a5,15
    80001e80:	3a079073          	csrw	pmpcfg0,a5
    80001e84:	f14027f3          	csrr	a5,mhartid
    80001e88:	0200c737          	lui	a4,0x200c
    80001e8c:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80001e90:	0007869b          	sext.w	a3,a5
    80001e94:	00269713          	slli	a4,a3,0x2
    80001e98:	000f4637          	lui	a2,0xf4
    80001e9c:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80001ea0:	00d70733          	add	a4,a4,a3
    80001ea4:	0037979b          	slliw	a5,a5,0x3
    80001ea8:	020046b7          	lui	a3,0x2004
    80001eac:	00d787b3          	add	a5,a5,a3
    80001eb0:	00c585b3          	add	a1,a1,a2
    80001eb4:	00371693          	slli	a3,a4,0x3
    80001eb8:	00003717          	auipc	a4,0x3
    80001ebc:	ba870713          	addi	a4,a4,-1112 # 80004a60 <timer_scratch>
    80001ec0:	00b7b023          	sd	a1,0(a5)
    80001ec4:	00d70733          	add	a4,a4,a3
    80001ec8:	00f73c23          	sd	a5,24(a4)
    80001ecc:	02c73023          	sd	a2,32(a4)
    80001ed0:	34071073          	csrw	mscratch,a4
    80001ed4:	00000797          	auipc	a5,0x0
    80001ed8:	6ec78793          	addi	a5,a5,1772 # 800025c0 <timervec>
    80001edc:	30579073          	csrw	mtvec,a5
    80001ee0:	300027f3          	csrr	a5,mstatus
    80001ee4:	0087e793          	ori	a5,a5,8
    80001ee8:	30079073          	csrw	mstatus,a5
    80001eec:	304027f3          	csrr	a5,mie
    80001ef0:	0807e793          	ori	a5,a5,128
    80001ef4:	30479073          	csrw	mie,a5
    80001ef8:	f14027f3          	csrr	a5,mhartid
    80001efc:	0007879b          	sext.w	a5,a5
    80001f00:	00078213          	mv	tp,a5
    80001f04:	30200073          	mret
    80001f08:	00813403          	ld	s0,8(sp)
    80001f0c:	01010113          	addi	sp,sp,16
    80001f10:	00008067          	ret

0000000080001f14 <timerinit>:
    80001f14:	ff010113          	addi	sp,sp,-16
    80001f18:	00813423          	sd	s0,8(sp)
    80001f1c:	01010413          	addi	s0,sp,16
    80001f20:	f14027f3          	csrr	a5,mhartid
    80001f24:	0200c737          	lui	a4,0x200c
    80001f28:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80001f2c:	0007869b          	sext.w	a3,a5
    80001f30:	00269713          	slli	a4,a3,0x2
    80001f34:	000f4637          	lui	a2,0xf4
    80001f38:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80001f3c:	00d70733          	add	a4,a4,a3
    80001f40:	0037979b          	slliw	a5,a5,0x3
    80001f44:	020046b7          	lui	a3,0x2004
    80001f48:	00d787b3          	add	a5,a5,a3
    80001f4c:	00c585b3          	add	a1,a1,a2
    80001f50:	00371693          	slli	a3,a4,0x3
    80001f54:	00003717          	auipc	a4,0x3
    80001f58:	b0c70713          	addi	a4,a4,-1268 # 80004a60 <timer_scratch>
    80001f5c:	00b7b023          	sd	a1,0(a5)
    80001f60:	00d70733          	add	a4,a4,a3
    80001f64:	00f73c23          	sd	a5,24(a4)
    80001f68:	02c73023          	sd	a2,32(a4)
    80001f6c:	34071073          	csrw	mscratch,a4
    80001f70:	00000797          	auipc	a5,0x0
    80001f74:	65078793          	addi	a5,a5,1616 # 800025c0 <timervec>
    80001f78:	30579073          	csrw	mtvec,a5
    80001f7c:	300027f3          	csrr	a5,mstatus
    80001f80:	0087e793          	ori	a5,a5,8
    80001f84:	30079073          	csrw	mstatus,a5
    80001f88:	304027f3          	csrr	a5,mie
    80001f8c:	0807e793          	ori	a5,a5,128
    80001f90:	30479073          	csrw	mie,a5
    80001f94:	00813403          	ld	s0,8(sp)
    80001f98:	01010113          	addi	sp,sp,16
    80001f9c:	00008067          	ret

0000000080001fa0 <system_main>:
    80001fa0:	fe010113          	addi	sp,sp,-32
    80001fa4:	00813823          	sd	s0,16(sp)
    80001fa8:	00913423          	sd	s1,8(sp)
    80001fac:	00113c23          	sd	ra,24(sp)
    80001fb0:	02010413          	addi	s0,sp,32
    80001fb4:	00000097          	auipc	ra,0x0
    80001fb8:	0c4080e7          	jalr	196(ra) # 80002078 <cpuid>
    80001fbc:	00003497          	auipc	s1,0x3
    80001fc0:	81448493          	addi	s1,s1,-2028 # 800047d0 <started>
    80001fc4:	02050263          	beqz	a0,80001fe8 <system_main+0x48>
    80001fc8:	0004a783          	lw	a5,0(s1)
    80001fcc:	0007879b          	sext.w	a5,a5
    80001fd0:	fe078ce3          	beqz	a5,80001fc8 <system_main+0x28>
    80001fd4:	0ff0000f          	fence
    80001fd8:	00002517          	auipc	a0,0x2
    80001fdc:	08050513          	addi	a0,a0,128 # 80004058 <_ZN3TCB25DEFAULT_SYSTEM_STACK_SIZEE+0x38>
    80001fe0:	00001097          	auipc	ra,0x1
    80001fe4:	a7c080e7          	jalr	-1412(ra) # 80002a5c <panic>
    80001fe8:	00001097          	auipc	ra,0x1
    80001fec:	9d0080e7          	jalr	-1584(ra) # 800029b8 <consoleinit>
    80001ff0:	00001097          	auipc	ra,0x1
    80001ff4:	15c080e7          	jalr	348(ra) # 8000314c <printfinit>
    80001ff8:	00002517          	auipc	a0,0x2
    80001ffc:	14050513          	addi	a0,a0,320 # 80004138 <_ZN3TCB25DEFAULT_SYSTEM_STACK_SIZEE+0x118>
    80002000:	00001097          	auipc	ra,0x1
    80002004:	ab8080e7          	jalr	-1352(ra) # 80002ab8 <__printf>
    80002008:	00002517          	auipc	a0,0x2
    8000200c:	02050513          	addi	a0,a0,32 # 80004028 <_ZN3TCB25DEFAULT_SYSTEM_STACK_SIZEE+0x8>
    80002010:	00001097          	auipc	ra,0x1
    80002014:	aa8080e7          	jalr	-1368(ra) # 80002ab8 <__printf>
    80002018:	00002517          	auipc	a0,0x2
    8000201c:	12050513          	addi	a0,a0,288 # 80004138 <_ZN3TCB25DEFAULT_SYSTEM_STACK_SIZEE+0x118>
    80002020:	00001097          	auipc	ra,0x1
    80002024:	a98080e7          	jalr	-1384(ra) # 80002ab8 <__printf>
    80002028:	00001097          	auipc	ra,0x1
    8000202c:	4b0080e7          	jalr	1200(ra) # 800034d8 <kinit>
    80002030:	00000097          	auipc	ra,0x0
    80002034:	148080e7          	jalr	328(ra) # 80002178 <trapinit>
    80002038:	00000097          	auipc	ra,0x0
    8000203c:	16c080e7          	jalr	364(ra) # 800021a4 <trapinithart>
    80002040:	00000097          	auipc	ra,0x0
    80002044:	5c0080e7          	jalr	1472(ra) # 80002600 <plicinit>
    80002048:	00000097          	auipc	ra,0x0
    8000204c:	5e0080e7          	jalr	1504(ra) # 80002628 <plicinithart>
    80002050:	00000097          	auipc	ra,0x0
    80002054:	078080e7          	jalr	120(ra) # 800020c8 <userinit>
    80002058:	0ff0000f          	fence
    8000205c:	00100793          	li	a5,1
    80002060:	00002517          	auipc	a0,0x2
    80002064:	fe050513          	addi	a0,a0,-32 # 80004040 <_ZN3TCB25DEFAULT_SYSTEM_STACK_SIZEE+0x20>
    80002068:	00f4a023          	sw	a5,0(s1)
    8000206c:	00001097          	auipc	ra,0x1
    80002070:	a4c080e7          	jalr	-1460(ra) # 80002ab8 <__printf>
    80002074:	0000006f          	j	80002074 <system_main+0xd4>

0000000080002078 <cpuid>:
    80002078:	ff010113          	addi	sp,sp,-16
    8000207c:	00813423          	sd	s0,8(sp)
    80002080:	01010413          	addi	s0,sp,16
    80002084:	00020513          	mv	a0,tp
    80002088:	00813403          	ld	s0,8(sp)
    8000208c:	0005051b          	sext.w	a0,a0
    80002090:	01010113          	addi	sp,sp,16
    80002094:	00008067          	ret

0000000080002098 <mycpu>:
    80002098:	ff010113          	addi	sp,sp,-16
    8000209c:	00813423          	sd	s0,8(sp)
    800020a0:	01010413          	addi	s0,sp,16
    800020a4:	00020793          	mv	a5,tp
    800020a8:	00813403          	ld	s0,8(sp)
    800020ac:	0007879b          	sext.w	a5,a5
    800020b0:	00779793          	slli	a5,a5,0x7
    800020b4:	00004517          	auipc	a0,0x4
    800020b8:	9dc50513          	addi	a0,a0,-1572 # 80005a90 <cpus>
    800020bc:	00f50533          	add	a0,a0,a5
    800020c0:	01010113          	addi	sp,sp,16
    800020c4:	00008067          	ret

00000000800020c8 <userinit>:
    800020c8:	ff010113          	addi	sp,sp,-16
    800020cc:	00813423          	sd	s0,8(sp)
    800020d0:	01010413          	addi	s0,sp,16
    800020d4:	00813403          	ld	s0,8(sp)
    800020d8:	01010113          	addi	sp,sp,16
    800020dc:	fffff317          	auipc	t1,0xfffff
    800020e0:	31c30067          	jr	796(t1) # 800013f8 <main>

00000000800020e4 <either_copyout>:
    800020e4:	ff010113          	addi	sp,sp,-16
    800020e8:	00813023          	sd	s0,0(sp)
    800020ec:	00113423          	sd	ra,8(sp)
    800020f0:	01010413          	addi	s0,sp,16
    800020f4:	02051663          	bnez	a0,80002120 <either_copyout+0x3c>
    800020f8:	00058513          	mv	a0,a1
    800020fc:	00060593          	mv	a1,a2
    80002100:	0006861b          	sext.w	a2,a3
    80002104:	00002097          	auipc	ra,0x2
    80002108:	c60080e7          	jalr	-928(ra) # 80003d64 <__memmove>
    8000210c:	00813083          	ld	ra,8(sp)
    80002110:	00013403          	ld	s0,0(sp)
    80002114:	00000513          	li	a0,0
    80002118:	01010113          	addi	sp,sp,16
    8000211c:	00008067          	ret
    80002120:	00002517          	auipc	a0,0x2
    80002124:	f6050513          	addi	a0,a0,-160 # 80004080 <_ZN3TCB25DEFAULT_SYSTEM_STACK_SIZEE+0x60>
    80002128:	00001097          	auipc	ra,0x1
    8000212c:	934080e7          	jalr	-1740(ra) # 80002a5c <panic>

0000000080002130 <either_copyin>:
    80002130:	ff010113          	addi	sp,sp,-16
    80002134:	00813023          	sd	s0,0(sp)
    80002138:	00113423          	sd	ra,8(sp)
    8000213c:	01010413          	addi	s0,sp,16
    80002140:	02059463          	bnez	a1,80002168 <either_copyin+0x38>
    80002144:	00060593          	mv	a1,a2
    80002148:	0006861b          	sext.w	a2,a3
    8000214c:	00002097          	auipc	ra,0x2
    80002150:	c18080e7          	jalr	-1000(ra) # 80003d64 <__memmove>
    80002154:	00813083          	ld	ra,8(sp)
    80002158:	00013403          	ld	s0,0(sp)
    8000215c:	00000513          	li	a0,0
    80002160:	01010113          	addi	sp,sp,16
    80002164:	00008067          	ret
    80002168:	00002517          	auipc	a0,0x2
    8000216c:	f4050513          	addi	a0,a0,-192 # 800040a8 <_ZN3TCB25DEFAULT_SYSTEM_STACK_SIZEE+0x88>
    80002170:	00001097          	auipc	ra,0x1
    80002174:	8ec080e7          	jalr	-1812(ra) # 80002a5c <panic>

0000000080002178 <trapinit>:
    80002178:	ff010113          	addi	sp,sp,-16
    8000217c:	00813423          	sd	s0,8(sp)
    80002180:	01010413          	addi	s0,sp,16
    80002184:	00813403          	ld	s0,8(sp)
    80002188:	00002597          	auipc	a1,0x2
    8000218c:	f4858593          	addi	a1,a1,-184 # 800040d0 <_ZN3TCB25DEFAULT_SYSTEM_STACK_SIZEE+0xb0>
    80002190:	00004517          	auipc	a0,0x4
    80002194:	98050513          	addi	a0,a0,-1664 # 80005b10 <tickslock>
    80002198:	01010113          	addi	sp,sp,16
    8000219c:	00001317          	auipc	t1,0x1
    800021a0:	5cc30067          	jr	1484(t1) # 80003768 <initlock>

00000000800021a4 <trapinithart>:
    800021a4:	ff010113          	addi	sp,sp,-16
    800021a8:	00813423          	sd	s0,8(sp)
    800021ac:	01010413          	addi	s0,sp,16
    800021b0:	00000797          	auipc	a5,0x0
    800021b4:	30078793          	addi	a5,a5,768 # 800024b0 <kernelvec>
    800021b8:	10579073          	csrw	stvec,a5
    800021bc:	00813403          	ld	s0,8(sp)
    800021c0:	01010113          	addi	sp,sp,16
    800021c4:	00008067          	ret

00000000800021c8 <usertrap>:
    800021c8:	ff010113          	addi	sp,sp,-16
    800021cc:	00813423          	sd	s0,8(sp)
    800021d0:	01010413          	addi	s0,sp,16
    800021d4:	00813403          	ld	s0,8(sp)
    800021d8:	01010113          	addi	sp,sp,16
    800021dc:	00008067          	ret

00000000800021e0 <usertrapret>:
    800021e0:	ff010113          	addi	sp,sp,-16
    800021e4:	00813423          	sd	s0,8(sp)
    800021e8:	01010413          	addi	s0,sp,16
    800021ec:	00813403          	ld	s0,8(sp)
    800021f0:	01010113          	addi	sp,sp,16
    800021f4:	00008067          	ret

00000000800021f8 <kerneltrap>:
    800021f8:	fe010113          	addi	sp,sp,-32
    800021fc:	00813823          	sd	s0,16(sp)
    80002200:	00113c23          	sd	ra,24(sp)
    80002204:	00913423          	sd	s1,8(sp)
    80002208:	02010413          	addi	s0,sp,32
    8000220c:	142025f3          	csrr	a1,scause
    80002210:	100027f3          	csrr	a5,sstatus
    80002214:	0027f793          	andi	a5,a5,2
    80002218:	10079c63          	bnez	a5,80002330 <kerneltrap+0x138>
    8000221c:	142027f3          	csrr	a5,scause
    80002220:	0207ce63          	bltz	a5,8000225c <kerneltrap+0x64>
    80002224:	00002517          	auipc	a0,0x2
    80002228:	ef450513          	addi	a0,a0,-268 # 80004118 <_ZN3TCB25DEFAULT_SYSTEM_STACK_SIZEE+0xf8>
    8000222c:	00001097          	auipc	ra,0x1
    80002230:	88c080e7          	jalr	-1908(ra) # 80002ab8 <__printf>
    80002234:	141025f3          	csrr	a1,sepc
    80002238:	14302673          	csrr	a2,stval
    8000223c:	00002517          	auipc	a0,0x2
    80002240:	eec50513          	addi	a0,a0,-276 # 80004128 <_ZN3TCB25DEFAULT_SYSTEM_STACK_SIZEE+0x108>
    80002244:	00001097          	auipc	ra,0x1
    80002248:	874080e7          	jalr	-1932(ra) # 80002ab8 <__printf>
    8000224c:	00002517          	auipc	a0,0x2
    80002250:	ef450513          	addi	a0,a0,-268 # 80004140 <_ZN3TCB25DEFAULT_SYSTEM_STACK_SIZEE+0x120>
    80002254:	00001097          	auipc	ra,0x1
    80002258:	808080e7          	jalr	-2040(ra) # 80002a5c <panic>
    8000225c:	0ff7f713          	andi	a4,a5,255
    80002260:	00900693          	li	a3,9
    80002264:	04d70063          	beq	a4,a3,800022a4 <kerneltrap+0xac>
    80002268:	fff00713          	li	a4,-1
    8000226c:	03f71713          	slli	a4,a4,0x3f
    80002270:	00170713          	addi	a4,a4,1
    80002274:	fae798e3          	bne	a5,a4,80002224 <kerneltrap+0x2c>
    80002278:	00000097          	auipc	ra,0x0
    8000227c:	e00080e7          	jalr	-512(ra) # 80002078 <cpuid>
    80002280:	06050663          	beqz	a0,800022ec <kerneltrap+0xf4>
    80002284:	144027f3          	csrr	a5,sip
    80002288:	ffd7f793          	andi	a5,a5,-3
    8000228c:	14479073          	csrw	sip,a5
    80002290:	01813083          	ld	ra,24(sp)
    80002294:	01013403          	ld	s0,16(sp)
    80002298:	00813483          	ld	s1,8(sp)
    8000229c:	02010113          	addi	sp,sp,32
    800022a0:	00008067          	ret
    800022a4:	00000097          	auipc	ra,0x0
    800022a8:	3d0080e7          	jalr	976(ra) # 80002674 <plic_claim>
    800022ac:	00a00793          	li	a5,10
    800022b0:	00050493          	mv	s1,a0
    800022b4:	06f50863          	beq	a0,a5,80002324 <kerneltrap+0x12c>
    800022b8:	fc050ce3          	beqz	a0,80002290 <kerneltrap+0x98>
    800022bc:	00050593          	mv	a1,a0
    800022c0:	00002517          	auipc	a0,0x2
    800022c4:	e3850513          	addi	a0,a0,-456 # 800040f8 <_ZN3TCB25DEFAULT_SYSTEM_STACK_SIZEE+0xd8>
    800022c8:	00000097          	auipc	ra,0x0
    800022cc:	7f0080e7          	jalr	2032(ra) # 80002ab8 <__printf>
    800022d0:	01013403          	ld	s0,16(sp)
    800022d4:	01813083          	ld	ra,24(sp)
    800022d8:	00048513          	mv	a0,s1
    800022dc:	00813483          	ld	s1,8(sp)
    800022e0:	02010113          	addi	sp,sp,32
    800022e4:	00000317          	auipc	t1,0x0
    800022e8:	3c830067          	jr	968(t1) # 800026ac <plic_complete>
    800022ec:	00004517          	auipc	a0,0x4
    800022f0:	82450513          	addi	a0,a0,-2012 # 80005b10 <tickslock>
    800022f4:	00001097          	auipc	ra,0x1
    800022f8:	498080e7          	jalr	1176(ra) # 8000378c <acquire>
    800022fc:	00002717          	auipc	a4,0x2
    80002300:	4d870713          	addi	a4,a4,1240 # 800047d4 <ticks>
    80002304:	00072783          	lw	a5,0(a4)
    80002308:	00004517          	auipc	a0,0x4
    8000230c:	80850513          	addi	a0,a0,-2040 # 80005b10 <tickslock>
    80002310:	0017879b          	addiw	a5,a5,1
    80002314:	00f72023          	sw	a5,0(a4)
    80002318:	00001097          	auipc	ra,0x1
    8000231c:	540080e7          	jalr	1344(ra) # 80003858 <release>
    80002320:	f65ff06f          	j	80002284 <kerneltrap+0x8c>
    80002324:	00001097          	auipc	ra,0x1
    80002328:	09c080e7          	jalr	156(ra) # 800033c0 <uartintr>
    8000232c:	fa5ff06f          	j	800022d0 <kerneltrap+0xd8>
    80002330:	00002517          	auipc	a0,0x2
    80002334:	da850513          	addi	a0,a0,-600 # 800040d8 <_ZN3TCB25DEFAULT_SYSTEM_STACK_SIZEE+0xb8>
    80002338:	00000097          	auipc	ra,0x0
    8000233c:	724080e7          	jalr	1828(ra) # 80002a5c <panic>

0000000080002340 <clockintr>:
    80002340:	fe010113          	addi	sp,sp,-32
    80002344:	00813823          	sd	s0,16(sp)
    80002348:	00913423          	sd	s1,8(sp)
    8000234c:	00113c23          	sd	ra,24(sp)
    80002350:	02010413          	addi	s0,sp,32
    80002354:	00003497          	auipc	s1,0x3
    80002358:	7bc48493          	addi	s1,s1,1980 # 80005b10 <tickslock>
    8000235c:	00048513          	mv	a0,s1
    80002360:	00001097          	auipc	ra,0x1
    80002364:	42c080e7          	jalr	1068(ra) # 8000378c <acquire>
    80002368:	00002717          	auipc	a4,0x2
    8000236c:	46c70713          	addi	a4,a4,1132 # 800047d4 <ticks>
    80002370:	00072783          	lw	a5,0(a4)
    80002374:	01013403          	ld	s0,16(sp)
    80002378:	01813083          	ld	ra,24(sp)
    8000237c:	00048513          	mv	a0,s1
    80002380:	0017879b          	addiw	a5,a5,1
    80002384:	00813483          	ld	s1,8(sp)
    80002388:	00f72023          	sw	a5,0(a4)
    8000238c:	02010113          	addi	sp,sp,32
    80002390:	00001317          	auipc	t1,0x1
    80002394:	4c830067          	jr	1224(t1) # 80003858 <release>

0000000080002398 <devintr>:
    80002398:	142027f3          	csrr	a5,scause
    8000239c:	00000513          	li	a0,0
    800023a0:	0007c463          	bltz	a5,800023a8 <devintr+0x10>
    800023a4:	00008067          	ret
    800023a8:	fe010113          	addi	sp,sp,-32
    800023ac:	00813823          	sd	s0,16(sp)
    800023b0:	00113c23          	sd	ra,24(sp)
    800023b4:	00913423          	sd	s1,8(sp)
    800023b8:	02010413          	addi	s0,sp,32
    800023bc:	0ff7f713          	andi	a4,a5,255
    800023c0:	00900693          	li	a3,9
    800023c4:	04d70c63          	beq	a4,a3,8000241c <devintr+0x84>
    800023c8:	fff00713          	li	a4,-1
    800023cc:	03f71713          	slli	a4,a4,0x3f
    800023d0:	00170713          	addi	a4,a4,1
    800023d4:	00e78c63          	beq	a5,a4,800023ec <devintr+0x54>
    800023d8:	01813083          	ld	ra,24(sp)
    800023dc:	01013403          	ld	s0,16(sp)
    800023e0:	00813483          	ld	s1,8(sp)
    800023e4:	02010113          	addi	sp,sp,32
    800023e8:	00008067          	ret
    800023ec:	00000097          	auipc	ra,0x0
    800023f0:	c8c080e7          	jalr	-884(ra) # 80002078 <cpuid>
    800023f4:	06050663          	beqz	a0,80002460 <devintr+0xc8>
    800023f8:	144027f3          	csrr	a5,sip
    800023fc:	ffd7f793          	andi	a5,a5,-3
    80002400:	14479073          	csrw	sip,a5
    80002404:	01813083          	ld	ra,24(sp)
    80002408:	01013403          	ld	s0,16(sp)
    8000240c:	00813483          	ld	s1,8(sp)
    80002410:	00200513          	li	a0,2
    80002414:	02010113          	addi	sp,sp,32
    80002418:	00008067          	ret
    8000241c:	00000097          	auipc	ra,0x0
    80002420:	258080e7          	jalr	600(ra) # 80002674 <plic_claim>
    80002424:	00a00793          	li	a5,10
    80002428:	00050493          	mv	s1,a0
    8000242c:	06f50663          	beq	a0,a5,80002498 <devintr+0x100>
    80002430:	00100513          	li	a0,1
    80002434:	fa0482e3          	beqz	s1,800023d8 <devintr+0x40>
    80002438:	00048593          	mv	a1,s1
    8000243c:	00002517          	auipc	a0,0x2
    80002440:	cbc50513          	addi	a0,a0,-836 # 800040f8 <_ZN3TCB25DEFAULT_SYSTEM_STACK_SIZEE+0xd8>
    80002444:	00000097          	auipc	ra,0x0
    80002448:	674080e7          	jalr	1652(ra) # 80002ab8 <__printf>
    8000244c:	00048513          	mv	a0,s1
    80002450:	00000097          	auipc	ra,0x0
    80002454:	25c080e7          	jalr	604(ra) # 800026ac <plic_complete>
    80002458:	00100513          	li	a0,1
    8000245c:	f7dff06f          	j	800023d8 <devintr+0x40>
    80002460:	00003517          	auipc	a0,0x3
    80002464:	6b050513          	addi	a0,a0,1712 # 80005b10 <tickslock>
    80002468:	00001097          	auipc	ra,0x1
    8000246c:	324080e7          	jalr	804(ra) # 8000378c <acquire>
    80002470:	00002717          	auipc	a4,0x2
    80002474:	36470713          	addi	a4,a4,868 # 800047d4 <ticks>
    80002478:	00072783          	lw	a5,0(a4)
    8000247c:	00003517          	auipc	a0,0x3
    80002480:	69450513          	addi	a0,a0,1684 # 80005b10 <tickslock>
    80002484:	0017879b          	addiw	a5,a5,1
    80002488:	00f72023          	sw	a5,0(a4)
    8000248c:	00001097          	auipc	ra,0x1
    80002490:	3cc080e7          	jalr	972(ra) # 80003858 <release>
    80002494:	f65ff06f          	j	800023f8 <devintr+0x60>
    80002498:	00001097          	auipc	ra,0x1
    8000249c:	f28080e7          	jalr	-216(ra) # 800033c0 <uartintr>
    800024a0:	fadff06f          	j	8000244c <devintr+0xb4>
	...

00000000800024b0 <kernelvec>:
    800024b0:	f0010113          	addi	sp,sp,-256
    800024b4:	00113023          	sd	ra,0(sp)
    800024b8:	00213423          	sd	sp,8(sp)
    800024bc:	00313823          	sd	gp,16(sp)
    800024c0:	00413c23          	sd	tp,24(sp)
    800024c4:	02513023          	sd	t0,32(sp)
    800024c8:	02613423          	sd	t1,40(sp)
    800024cc:	02713823          	sd	t2,48(sp)
    800024d0:	02813c23          	sd	s0,56(sp)
    800024d4:	04913023          	sd	s1,64(sp)
    800024d8:	04a13423          	sd	a0,72(sp)
    800024dc:	04b13823          	sd	a1,80(sp)
    800024e0:	04c13c23          	sd	a2,88(sp)
    800024e4:	06d13023          	sd	a3,96(sp)
    800024e8:	06e13423          	sd	a4,104(sp)
    800024ec:	06f13823          	sd	a5,112(sp)
    800024f0:	07013c23          	sd	a6,120(sp)
    800024f4:	09113023          	sd	a7,128(sp)
    800024f8:	09213423          	sd	s2,136(sp)
    800024fc:	09313823          	sd	s3,144(sp)
    80002500:	09413c23          	sd	s4,152(sp)
    80002504:	0b513023          	sd	s5,160(sp)
    80002508:	0b613423          	sd	s6,168(sp)
    8000250c:	0b713823          	sd	s7,176(sp)
    80002510:	0b813c23          	sd	s8,184(sp)
    80002514:	0d913023          	sd	s9,192(sp)
    80002518:	0da13423          	sd	s10,200(sp)
    8000251c:	0db13823          	sd	s11,208(sp)
    80002520:	0dc13c23          	sd	t3,216(sp)
    80002524:	0fd13023          	sd	t4,224(sp)
    80002528:	0fe13423          	sd	t5,232(sp)
    8000252c:	0ff13823          	sd	t6,240(sp)
    80002530:	cc9ff0ef          	jal	ra,800021f8 <kerneltrap>
    80002534:	00013083          	ld	ra,0(sp)
    80002538:	00813103          	ld	sp,8(sp)
    8000253c:	01013183          	ld	gp,16(sp)
    80002540:	02013283          	ld	t0,32(sp)
    80002544:	02813303          	ld	t1,40(sp)
    80002548:	03013383          	ld	t2,48(sp)
    8000254c:	03813403          	ld	s0,56(sp)
    80002550:	04013483          	ld	s1,64(sp)
    80002554:	04813503          	ld	a0,72(sp)
    80002558:	05013583          	ld	a1,80(sp)
    8000255c:	05813603          	ld	a2,88(sp)
    80002560:	06013683          	ld	a3,96(sp)
    80002564:	06813703          	ld	a4,104(sp)
    80002568:	07013783          	ld	a5,112(sp)
    8000256c:	07813803          	ld	a6,120(sp)
    80002570:	08013883          	ld	a7,128(sp)
    80002574:	08813903          	ld	s2,136(sp)
    80002578:	09013983          	ld	s3,144(sp)
    8000257c:	09813a03          	ld	s4,152(sp)
    80002580:	0a013a83          	ld	s5,160(sp)
    80002584:	0a813b03          	ld	s6,168(sp)
    80002588:	0b013b83          	ld	s7,176(sp)
    8000258c:	0b813c03          	ld	s8,184(sp)
    80002590:	0c013c83          	ld	s9,192(sp)
    80002594:	0c813d03          	ld	s10,200(sp)
    80002598:	0d013d83          	ld	s11,208(sp)
    8000259c:	0d813e03          	ld	t3,216(sp)
    800025a0:	0e013e83          	ld	t4,224(sp)
    800025a4:	0e813f03          	ld	t5,232(sp)
    800025a8:	0f013f83          	ld	t6,240(sp)
    800025ac:	10010113          	addi	sp,sp,256
    800025b0:	10200073          	sret
    800025b4:	00000013          	nop
    800025b8:	00000013          	nop
    800025bc:	00000013          	nop

00000000800025c0 <timervec>:
    800025c0:	34051573          	csrrw	a0,mscratch,a0
    800025c4:	00b53023          	sd	a1,0(a0)
    800025c8:	00c53423          	sd	a2,8(a0)
    800025cc:	00d53823          	sd	a3,16(a0)
    800025d0:	01853583          	ld	a1,24(a0)
    800025d4:	02053603          	ld	a2,32(a0)
    800025d8:	0005b683          	ld	a3,0(a1)
    800025dc:	00c686b3          	add	a3,a3,a2
    800025e0:	00d5b023          	sd	a3,0(a1)
    800025e4:	00200593          	li	a1,2
    800025e8:	14459073          	csrw	sip,a1
    800025ec:	01053683          	ld	a3,16(a0)
    800025f0:	00853603          	ld	a2,8(a0)
    800025f4:	00053583          	ld	a1,0(a0)
    800025f8:	34051573          	csrrw	a0,mscratch,a0
    800025fc:	30200073          	mret

0000000080002600 <plicinit>:
    80002600:	ff010113          	addi	sp,sp,-16
    80002604:	00813423          	sd	s0,8(sp)
    80002608:	01010413          	addi	s0,sp,16
    8000260c:	00813403          	ld	s0,8(sp)
    80002610:	0c0007b7          	lui	a5,0xc000
    80002614:	00100713          	li	a4,1
    80002618:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    8000261c:	00e7a223          	sw	a4,4(a5)
    80002620:	01010113          	addi	sp,sp,16
    80002624:	00008067          	ret

0000000080002628 <plicinithart>:
    80002628:	ff010113          	addi	sp,sp,-16
    8000262c:	00813023          	sd	s0,0(sp)
    80002630:	00113423          	sd	ra,8(sp)
    80002634:	01010413          	addi	s0,sp,16
    80002638:	00000097          	auipc	ra,0x0
    8000263c:	a40080e7          	jalr	-1472(ra) # 80002078 <cpuid>
    80002640:	0085171b          	slliw	a4,a0,0x8
    80002644:	0c0027b7          	lui	a5,0xc002
    80002648:	00e787b3          	add	a5,a5,a4
    8000264c:	40200713          	li	a4,1026
    80002650:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80002654:	00813083          	ld	ra,8(sp)
    80002658:	00013403          	ld	s0,0(sp)
    8000265c:	00d5151b          	slliw	a0,a0,0xd
    80002660:	0c2017b7          	lui	a5,0xc201
    80002664:	00a78533          	add	a0,a5,a0
    80002668:	00052023          	sw	zero,0(a0)
    8000266c:	01010113          	addi	sp,sp,16
    80002670:	00008067          	ret

0000000080002674 <plic_claim>:
    80002674:	ff010113          	addi	sp,sp,-16
    80002678:	00813023          	sd	s0,0(sp)
    8000267c:	00113423          	sd	ra,8(sp)
    80002680:	01010413          	addi	s0,sp,16
    80002684:	00000097          	auipc	ra,0x0
    80002688:	9f4080e7          	jalr	-1548(ra) # 80002078 <cpuid>
    8000268c:	00813083          	ld	ra,8(sp)
    80002690:	00013403          	ld	s0,0(sp)
    80002694:	00d5151b          	slliw	a0,a0,0xd
    80002698:	0c2017b7          	lui	a5,0xc201
    8000269c:	00a78533          	add	a0,a5,a0
    800026a0:	00452503          	lw	a0,4(a0)
    800026a4:	01010113          	addi	sp,sp,16
    800026a8:	00008067          	ret

00000000800026ac <plic_complete>:
    800026ac:	fe010113          	addi	sp,sp,-32
    800026b0:	00813823          	sd	s0,16(sp)
    800026b4:	00913423          	sd	s1,8(sp)
    800026b8:	00113c23          	sd	ra,24(sp)
    800026bc:	02010413          	addi	s0,sp,32
    800026c0:	00050493          	mv	s1,a0
    800026c4:	00000097          	auipc	ra,0x0
    800026c8:	9b4080e7          	jalr	-1612(ra) # 80002078 <cpuid>
    800026cc:	01813083          	ld	ra,24(sp)
    800026d0:	01013403          	ld	s0,16(sp)
    800026d4:	00d5179b          	slliw	a5,a0,0xd
    800026d8:	0c201737          	lui	a4,0xc201
    800026dc:	00f707b3          	add	a5,a4,a5
    800026e0:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    800026e4:	00813483          	ld	s1,8(sp)
    800026e8:	02010113          	addi	sp,sp,32
    800026ec:	00008067          	ret

00000000800026f0 <consolewrite>:
    800026f0:	fb010113          	addi	sp,sp,-80
    800026f4:	04813023          	sd	s0,64(sp)
    800026f8:	04113423          	sd	ra,72(sp)
    800026fc:	02913c23          	sd	s1,56(sp)
    80002700:	03213823          	sd	s2,48(sp)
    80002704:	03313423          	sd	s3,40(sp)
    80002708:	03413023          	sd	s4,32(sp)
    8000270c:	01513c23          	sd	s5,24(sp)
    80002710:	05010413          	addi	s0,sp,80
    80002714:	06c05c63          	blez	a2,8000278c <consolewrite+0x9c>
    80002718:	00060993          	mv	s3,a2
    8000271c:	00050a13          	mv	s4,a0
    80002720:	00058493          	mv	s1,a1
    80002724:	00000913          	li	s2,0
    80002728:	fff00a93          	li	s5,-1
    8000272c:	01c0006f          	j	80002748 <consolewrite+0x58>
    80002730:	fbf44503          	lbu	a0,-65(s0)
    80002734:	0019091b          	addiw	s2,s2,1
    80002738:	00148493          	addi	s1,s1,1
    8000273c:	00001097          	auipc	ra,0x1
    80002740:	a9c080e7          	jalr	-1380(ra) # 800031d8 <uartputc>
    80002744:	03298063          	beq	s3,s2,80002764 <consolewrite+0x74>
    80002748:	00048613          	mv	a2,s1
    8000274c:	00100693          	li	a3,1
    80002750:	000a0593          	mv	a1,s4
    80002754:	fbf40513          	addi	a0,s0,-65
    80002758:	00000097          	auipc	ra,0x0
    8000275c:	9d8080e7          	jalr	-1576(ra) # 80002130 <either_copyin>
    80002760:	fd5518e3          	bne	a0,s5,80002730 <consolewrite+0x40>
    80002764:	04813083          	ld	ra,72(sp)
    80002768:	04013403          	ld	s0,64(sp)
    8000276c:	03813483          	ld	s1,56(sp)
    80002770:	02813983          	ld	s3,40(sp)
    80002774:	02013a03          	ld	s4,32(sp)
    80002778:	01813a83          	ld	s5,24(sp)
    8000277c:	00090513          	mv	a0,s2
    80002780:	03013903          	ld	s2,48(sp)
    80002784:	05010113          	addi	sp,sp,80
    80002788:	00008067          	ret
    8000278c:	00000913          	li	s2,0
    80002790:	fd5ff06f          	j	80002764 <consolewrite+0x74>

0000000080002794 <consoleread>:
    80002794:	f9010113          	addi	sp,sp,-112
    80002798:	06813023          	sd	s0,96(sp)
    8000279c:	04913c23          	sd	s1,88(sp)
    800027a0:	05213823          	sd	s2,80(sp)
    800027a4:	05313423          	sd	s3,72(sp)
    800027a8:	05413023          	sd	s4,64(sp)
    800027ac:	03513c23          	sd	s5,56(sp)
    800027b0:	03613823          	sd	s6,48(sp)
    800027b4:	03713423          	sd	s7,40(sp)
    800027b8:	03813023          	sd	s8,32(sp)
    800027bc:	06113423          	sd	ra,104(sp)
    800027c0:	01913c23          	sd	s9,24(sp)
    800027c4:	07010413          	addi	s0,sp,112
    800027c8:	00060b93          	mv	s7,a2
    800027cc:	00050913          	mv	s2,a0
    800027d0:	00058c13          	mv	s8,a1
    800027d4:	00060b1b          	sext.w	s6,a2
    800027d8:	00003497          	auipc	s1,0x3
    800027dc:	35048493          	addi	s1,s1,848 # 80005b28 <cons>
    800027e0:	00400993          	li	s3,4
    800027e4:	fff00a13          	li	s4,-1
    800027e8:	00a00a93          	li	s5,10
    800027ec:	05705e63          	blez	s7,80002848 <consoleread+0xb4>
    800027f0:	09c4a703          	lw	a4,156(s1)
    800027f4:	0984a783          	lw	a5,152(s1)
    800027f8:	0007071b          	sext.w	a4,a4
    800027fc:	08e78463          	beq	a5,a4,80002884 <consoleread+0xf0>
    80002800:	07f7f713          	andi	a4,a5,127
    80002804:	00e48733          	add	a4,s1,a4
    80002808:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    8000280c:	0017869b          	addiw	a3,a5,1
    80002810:	08d4ac23          	sw	a3,152(s1)
    80002814:	00070c9b          	sext.w	s9,a4
    80002818:	0b370663          	beq	a4,s3,800028c4 <consoleread+0x130>
    8000281c:	00100693          	li	a3,1
    80002820:	f9f40613          	addi	a2,s0,-97
    80002824:	000c0593          	mv	a1,s8
    80002828:	00090513          	mv	a0,s2
    8000282c:	f8e40fa3          	sb	a4,-97(s0)
    80002830:	00000097          	auipc	ra,0x0
    80002834:	8b4080e7          	jalr	-1868(ra) # 800020e4 <either_copyout>
    80002838:	01450863          	beq	a0,s4,80002848 <consoleread+0xb4>
    8000283c:	001c0c13          	addi	s8,s8,1
    80002840:	fffb8b9b          	addiw	s7,s7,-1
    80002844:	fb5c94e3          	bne	s9,s5,800027ec <consoleread+0x58>
    80002848:	000b851b          	sext.w	a0,s7
    8000284c:	06813083          	ld	ra,104(sp)
    80002850:	06013403          	ld	s0,96(sp)
    80002854:	05813483          	ld	s1,88(sp)
    80002858:	05013903          	ld	s2,80(sp)
    8000285c:	04813983          	ld	s3,72(sp)
    80002860:	04013a03          	ld	s4,64(sp)
    80002864:	03813a83          	ld	s5,56(sp)
    80002868:	02813b83          	ld	s7,40(sp)
    8000286c:	02013c03          	ld	s8,32(sp)
    80002870:	01813c83          	ld	s9,24(sp)
    80002874:	40ab053b          	subw	a0,s6,a0
    80002878:	03013b03          	ld	s6,48(sp)
    8000287c:	07010113          	addi	sp,sp,112
    80002880:	00008067          	ret
    80002884:	00001097          	auipc	ra,0x1
    80002888:	1d8080e7          	jalr	472(ra) # 80003a5c <push_on>
    8000288c:	0984a703          	lw	a4,152(s1)
    80002890:	09c4a783          	lw	a5,156(s1)
    80002894:	0007879b          	sext.w	a5,a5
    80002898:	fef70ce3          	beq	a4,a5,80002890 <consoleread+0xfc>
    8000289c:	00001097          	auipc	ra,0x1
    800028a0:	234080e7          	jalr	564(ra) # 80003ad0 <pop_on>
    800028a4:	0984a783          	lw	a5,152(s1)
    800028a8:	07f7f713          	andi	a4,a5,127
    800028ac:	00e48733          	add	a4,s1,a4
    800028b0:	01874703          	lbu	a4,24(a4)
    800028b4:	0017869b          	addiw	a3,a5,1
    800028b8:	08d4ac23          	sw	a3,152(s1)
    800028bc:	00070c9b          	sext.w	s9,a4
    800028c0:	f5371ee3          	bne	a4,s3,8000281c <consoleread+0x88>
    800028c4:	000b851b          	sext.w	a0,s7
    800028c8:	f96bf2e3          	bgeu	s7,s6,8000284c <consoleread+0xb8>
    800028cc:	08f4ac23          	sw	a5,152(s1)
    800028d0:	f7dff06f          	j	8000284c <consoleread+0xb8>

00000000800028d4 <consputc>:
    800028d4:	10000793          	li	a5,256
    800028d8:	00f50663          	beq	a0,a5,800028e4 <consputc+0x10>
    800028dc:	00001317          	auipc	t1,0x1
    800028e0:	9f430067          	jr	-1548(t1) # 800032d0 <uartputc_sync>
    800028e4:	ff010113          	addi	sp,sp,-16
    800028e8:	00113423          	sd	ra,8(sp)
    800028ec:	00813023          	sd	s0,0(sp)
    800028f0:	01010413          	addi	s0,sp,16
    800028f4:	00800513          	li	a0,8
    800028f8:	00001097          	auipc	ra,0x1
    800028fc:	9d8080e7          	jalr	-1576(ra) # 800032d0 <uartputc_sync>
    80002900:	02000513          	li	a0,32
    80002904:	00001097          	auipc	ra,0x1
    80002908:	9cc080e7          	jalr	-1588(ra) # 800032d0 <uartputc_sync>
    8000290c:	00013403          	ld	s0,0(sp)
    80002910:	00813083          	ld	ra,8(sp)
    80002914:	00800513          	li	a0,8
    80002918:	01010113          	addi	sp,sp,16
    8000291c:	00001317          	auipc	t1,0x1
    80002920:	9b430067          	jr	-1612(t1) # 800032d0 <uartputc_sync>

0000000080002924 <consoleintr>:
    80002924:	fe010113          	addi	sp,sp,-32
    80002928:	00813823          	sd	s0,16(sp)
    8000292c:	00913423          	sd	s1,8(sp)
    80002930:	01213023          	sd	s2,0(sp)
    80002934:	00113c23          	sd	ra,24(sp)
    80002938:	02010413          	addi	s0,sp,32
    8000293c:	00003917          	auipc	s2,0x3
    80002940:	1ec90913          	addi	s2,s2,492 # 80005b28 <cons>
    80002944:	00050493          	mv	s1,a0
    80002948:	00090513          	mv	a0,s2
    8000294c:	00001097          	auipc	ra,0x1
    80002950:	e40080e7          	jalr	-448(ra) # 8000378c <acquire>
    80002954:	02048c63          	beqz	s1,8000298c <consoleintr+0x68>
    80002958:	0a092783          	lw	a5,160(s2)
    8000295c:	09892703          	lw	a4,152(s2)
    80002960:	07f00693          	li	a3,127
    80002964:	40e7873b          	subw	a4,a5,a4
    80002968:	02e6e263          	bltu	a3,a4,8000298c <consoleintr+0x68>
    8000296c:	00d00713          	li	a4,13
    80002970:	04e48063          	beq	s1,a4,800029b0 <consoleintr+0x8c>
    80002974:	07f7f713          	andi	a4,a5,127
    80002978:	00e90733          	add	a4,s2,a4
    8000297c:	0017879b          	addiw	a5,a5,1
    80002980:	0af92023          	sw	a5,160(s2)
    80002984:	00970c23          	sb	s1,24(a4)
    80002988:	08f92e23          	sw	a5,156(s2)
    8000298c:	01013403          	ld	s0,16(sp)
    80002990:	01813083          	ld	ra,24(sp)
    80002994:	00813483          	ld	s1,8(sp)
    80002998:	00013903          	ld	s2,0(sp)
    8000299c:	00003517          	auipc	a0,0x3
    800029a0:	18c50513          	addi	a0,a0,396 # 80005b28 <cons>
    800029a4:	02010113          	addi	sp,sp,32
    800029a8:	00001317          	auipc	t1,0x1
    800029ac:	eb030067          	jr	-336(t1) # 80003858 <release>
    800029b0:	00a00493          	li	s1,10
    800029b4:	fc1ff06f          	j	80002974 <consoleintr+0x50>

00000000800029b8 <consoleinit>:
    800029b8:	fe010113          	addi	sp,sp,-32
    800029bc:	00113c23          	sd	ra,24(sp)
    800029c0:	00813823          	sd	s0,16(sp)
    800029c4:	00913423          	sd	s1,8(sp)
    800029c8:	02010413          	addi	s0,sp,32
    800029cc:	00003497          	auipc	s1,0x3
    800029d0:	15c48493          	addi	s1,s1,348 # 80005b28 <cons>
    800029d4:	00048513          	mv	a0,s1
    800029d8:	00001597          	auipc	a1,0x1
    800029dc:	77858593          	addi	a1,a1,1912 # 80004150 <_ZN3TCB25DEFAULT_SYSTEM_STACK_SIZEE+0x130>
    800029e0:	00001097          	auipc	ra,0x1
    800029e4:	d88080e7          	jalr	-632(ra) # 80003768 <initlock>
    800029e8:	00000097          	auipc	ra,0x0
    800029ec:	7ac080e7          	jalr	1964(ra) # 80003194 <uartinit>
    800029f0:	01813083          	ld	ra,24(sp)
    800029f4:	01013403          	ld	s0,16(sp)
    800029f8:	00000797          	auipc	a5,0x0
    800029fc:	d9c78793          	addi	a5,a5,-612 # 80002794 <consoleread>
    80002a00:	0af4bc23          	sd	a5,184(s1)
    80002a04:	00000797          	auipc	a5,0x0
    80002a08:	cec78793          	addi	a5,a5,-788 # 800026f0 <consolewrite>
    80002a0c:	0cf4b023          	sd	a5,192(s1)
    80002a10:	00813483          	ld	s1,8(sp)
    80002a14:	02010113          	addi	sp,sp,32
    80002a18:	00008067          	ret

0000000080002a1c <console_read>:
    80002a1c:	ff010113          	addi	sp,sp,-16
    80002a20:	00813423          	sd	s0,8(sp)
    80002a24:	01010413          	addi	s0,sp,16
    80002a28:	00813403          	ld	s0,8(sp)
    80002a2c:	00003317          	auipc	t1,0x3
    80002a30:	1b433303          	ld	t1,436(t1) # 80005be0 <devsw+0x10>
    80002a34:	01010113          	addi	sp,sp,16
    80002a38:	00030067          	jr	t1

0000000080002a3c <console_write>:
    80002a3c:	ff010113          	addi	sp,sp,-16
    80002a40:	00813423          	sd	s0,8(sp)
    80002a44:	01010413          	addi	s0,sp,16
    80002a48:	00813403          	ld	s0,8(sp)
    80002a4c:	00003317          	auipc	t1,0x3
    80002a50:	19c33303          	ld	t1,412(t1) # 80005be8 <devsw+0x18>
    80002a54:	01010113          	addi	sp,sp,16
    80002a58:	00030067          	jr	t1

0000000080002a5c <panic>:
    80002a5c:	fe010113          	addi	sp,sp,-32
    80002a60:	00113c23          	sd	ra,24(sp)
    80002a64:	00813823          	sd	s0,16(sp)
    80002a68:	00913423          	sd	s1,8(sp)
    80002a6c:	02010413          	addi	s0,sp,32
    80002a70:	00050493          	mv	s1,a0
    80002a74:	00001517          	auipc	a0,0x1
    80002a78:	6e450513          	addi	a0,a0,1764 # 80004158 <_ZN3TCB25DEFAULT_SYSTEM_STACK_SIZEE+0x138>
    80002a7c:	00003797          	auipc	a5,0x3
    80002a80:	2007a623          	sw	zero,524(a5) # 80005c88 <pr+0x18>
    80002a84:	00000097          	auipc	ra,0x0
    80002a88:	034080e7          	jalr	52(ra) # 80002ab8 <__printf>
    80002a8c:	00048513          	mv	a0,s1
    80002a90:	00000097          	auipc	ra,0x0
    80002a94:	028080e7          	jalr	40(ra) # 80002ab8 <__printf>
    80002a98:	00001517          	auipc	a0,0x1
    80002a9c:	6a050513          	addi	a0,a0,1696 # 80004138 <_ZN3TCB25DEFAULT_SYSTEM_STACK_SIZEE+0x118>
    80002aa0:	00000097          	auipc	ra,0x0
    80002aa4:	018080e7          	jalr	24(ra) # 80002ab8 <__printf>
    80002aa8:	00100793          	li	a5,1
    80002aac:	00002717          	auipc	a4,0x2
    80002ab0:	d2f72623          	sw	a5,-724(a4) # 800047d8 <panicked>
    80002ab4:	0000006f          	j	80002ab4 <panic+0x58>

0000000080002ab8 <__printf>:
    80002ab8:	f3010113          	addi	sp,sp,-208
    80002abc:	08813023          	sd	s0,128(sp)
    80002ac0:	07313423          	sd	s3,104(sp)
    80002ac4:	09010413          	addi	s0,sp,144
    80002ac8:	05813023          	sd	s8,64(sp)
    80002acc:	08113423          	sd	ra,136(sp)
    80002ad0:	06913c23          	sd	s1,120(sp)
    80002ad4:	07213823          	sd	s2,112(sp)
    80002ad8:	07413023          	sd	s4,96(sp)
    80002adc:	05513c23          	sd	s5,88(sp)
    80002ae0:	05613823          	sd	s6,80(sp)
    80002ae4:	05713423          	sd	s7,72(sp)
    80002ae8:	03913c23          	sd	s9,56(sp)
    80002aec:	03a13823          	sd	s10,48(sp)
    80002af0:	03b13423          	sd	s11,40(sp)
    80002af4:	00003317          	auipc	t1,0x3
    80002af8:	17c30313          	addi	t1,t1,380 # 80005c70 <pr>
    80002afc:	01832c03          	lw	s8,24(t1)
    80002b00:	00b43423          	sd	a1,8(s0)
    80002b04:	00c43823          	sd	a2,16(s0)
    80002b08:	00d43c23          	sd	a3,24(s0)
    80002b0c:	02e43023          	sd	a4,32(s0)
    80002b10:	02f43423          	sd	a5,40(s0)
    80002b14:	03043823          	sd	a6,48(s0)
    80002b18:	03143c23          	sd	a7,56(s0)
    80002b1c:	00050993          	mv	s3,a0
    80002b20:	4a0c1663          	bnez	s8,80002fcc <__printf+0x514>
    80002b24:	60098c63          	beqz	s3,8000313c <__printf+0x684>
    80002b28:	0009c503          	lbu	a0,0(s3)
    80002b2c:	00840793          	addi	a5,s0,8
    80002b30:	f6f43c23          	sd	a5,-136(s0)
    80002b34:	00000493          	li	s1,0
    80002b38:	22050063          	beqz	a0,80002d58 <__printf+0x2a0>
    80002b3c:	00002a37          	lui	s4,0x2
    80002b40:	00018ab7          	lui	s5,0x18
    80002b44:	000f4b37          	lui	s6,0xf4
    80002b48:	00989bb7          	lui	s7,0x989
    80002b4c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80002b50:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80002b54:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80002b58:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    80002b5c:	00148c9b          	addiw	s9,s1,1
    80002b60:	02500793          	li	a5,37
    80002b64:	01998933          	add	s2,s3,s9
    80002b68:	38f51263          	bne	a0,a5,80002eec <__printf+0x434>
    80002b6c:	00094783          	lbu	a5,0(s2)
    80002b70:	00078c9b          	sext.w	s9,a5
    80002b74:	1e078263          	beqz	a5,80002d58 <__printf+0x2a0>
    80002b78:	0024849b          	addiw	s1,s1,2
    80002b7c:	07000713          	li	a4,112
    80002b80:	00998933          	add	s2,s3,s1
    80002b84:	38e78a63          	beq	a5,a4,80002f18 <__printf+0x460>
    80002b88:	20f76863          	bltu	a4,a5,80002d98 <__printf+0x2e0>
    80002b8c:	42a78863          	beq	a5,a0,80002fbc <__printf+0x504>
    80002b90:	06400713          	li	a4,100
    80002b94:	40e79663          	bne	a5,a4,80002fa0 <__printf+0x4e8>
    80002b98:	f7843783          	ld	a5,-136(s0)
    80002b9c:	0007a603          	lw	a2,0(a5)
    80002ba0:	00878793          	addi	a5,a5,8
    80002ba4:	f6f43c23          	sd	a5,-136(s0)
    80002ba8:	42064a63          	bltz	a2,80002fdc <__printf+0x524>
    80002bac:	00a00713          	li	a4,10
    80002bb0:	02e677bb          	remuw	a5,a2,a4
    80002bb4:	00001d97          	auipc	s11,0x1
    80002bb8:	5ccd8d93          	addi	s11,s11,1484 # 80004180 <digits>
    80002bbc:	00900593          	li	a1,9
    80002bc0:	0006051b          	sext.w	a0,a2
    80002bc4:	00000c93          	li	s9,0
    80002bc8:	02079793          	slli	a5,a5,0x20
    80002bcc:	0207d793          	srli	a5,a5,0x20
    80002bd0:	00fd87b3          	add	a5,s11,a5
    80002bd4:	0007c783          	lbu	a5,0(a5)
    80002bd8:	02e656bb          	divuw	a3,a2,a4
    80002bdc:	f8f40023          	sb	a5,-128(s0)
    80002be0:	14c5d863          	bge	a1,a2,80002d30 <__printf+0x278>
    80002be4:	06300593          	li	a1,99
    80002be8:	00100c93          	li	s9,1
    80002bec:	02e6f7bb          	remuw	a5,a3,a4
    80002bf0:	02079793          	slli	a5,a5,0x20
    80002bf4:	0207d793          	srli	a5,a5,0x20
    80002bf8:	00fd87b3          	add	a5,s11,a5
    80002bfc:	0007c783          	lbu	a5,0(a5)
    80002c00:	02e6d73b          	divuw	a4,a3,a4
    80002c04:	f8f400a3          	sb	a5,-127(s0)
    80002c08:	12a5f463          	bgeu	a1,a0,80002d30 <__printf+0x278>
    80002c0c:	00a00693          	li	a3,10
    80002c10:	00900593          	li	a1,9
    80002c14:	02d777bb          	remuw	a5,a4,a3
    80002c18:	02079793          	slli	a5,a5,0x20
    80002c1c:	0207d793          	srli	a5,a5,0x20
    80002c20:	00fd87b3          	add	a5,s11,a5
    80002c24:	0007c503          	lbu	a0,0(a5)
    80002c28:	02d757bb          	divuw	a5,a4,a3
    80002c2c:	f8a40123          	sb	a0,-126(s0)
    80002c30:	48e5f263          	bgeu	a1,a4,800030b4 <__printf+0x5fc>
    80002c34:	06300513          	li	a0,99
    80002c38:	02d7f5bb          	remuw	a1,a5,a3
    80002c3c:	02059593          	slli	a1,a1,0x20
    80002c40:	0205d593          	srli	a1,a1,0x20
    80002c44:	00bd85b3          	add	a1,s11,a1
    80002c48:	0005c583          	lbu	a1,0(a1)
    80002c4c:	02d7d7bb          	divuw	a5,a5,a3
    80002c50:	f8b401a3          	sb	a1,-125(s0)
    80002c54:	48e57263          	bgeu	a0,a4,800030d8 <__printf+0x620>
    80002c58:	3e700513          	li	a0,999
    80002c5c:	02d7f5bb          	remuw	a1,a5,a3
    80002c60:	02059593          	slli	a1,a1,0x20
    80002c64:	0205d593          	srli	a1,a1,0x20
    80002c68:	00bd85b3          	add	a1,s11,a1
    80002c6c:	0005c583          	lbu	a1,0(a1)
    80002c70:	02d7d7bb          	divuw	a5,a5,a3
    80002c74:	f8b40223          	sb	a1,-124(s0)
    80002c78:	46e57663          	bgeu	a0,a4,800030e4 <__printf+0x62c>
    80002c7c:	02d7f5bb          	remuw	a1,a5,a3
    80002c80:	02059593          	slli	a1,a1,0x20
    80002c84:	0205d593          	srli	a1,a1,0x20
    80002c88:	00bd85b3          	add	a1,s11,a1
    80002c8c:	0005c583          	lbu	a1,0(a1)
    80002c90:	02d7d7bb          	divuw	a5,a5,a3
    80002c94:	f8b402a3          	sb	a1,-123(s0)
    80002c98:	46ea7863          	bgeu	s4,a4,80003108 <__printf+0x650>
    80002c9c:	02d7f5bb          	remuw	a1,a5,a3
    80002ca0:	02059593          	slli	a1,a1,0x20
    80002ca4:	0205d593          	srli	a1,a1,0x20
    80002ca8:	00bd85b3          	add	a1,s11,a1
    80002cac:	0005c583          	lbu	a1,0(a1)
    80002cb0:	02d7d7bb          	divuw	a5,a5,a3
    80002cb4:	f8b40323          	sb	a1,-122(s0)
    80002cb8:	3eeaf863          	bgeu	s5,a4,800030a8 <__printf+0x5f0>
    80002cbc:	02d7f5bb          	remuw	a1,a5,a3
    80002cc0:	02059593          	slli	a1,a1,0x20
    80002cc4:	0205d593          	srli	a1,a1,0x20
    80002cc8:	00bd85b3          	add	a1,s11,a1
    80002ccc:	0005c583          	lbu	a1,0(a1)
    80002cd0:	02d7d7bb          	divuw	a5,a5,a3
    80002cd4:	f8b403a3          	sb	a1,-121(s0)
    80002cd8:	42eb7e63          	bgeu	s6,a4,80003114 <__printf+0x65c>
    80002cdc:	02d7f5bb          	remuw	a1,a5,a3
    80002ce0:	02059593          	slli	a1,a1,0x20
    80002ce4:	0205d593          	srli	a1,a1,0x20
    80002ce8:	00bd85b3          	add	a1,s11,a1
    80002cec:	0005c583          	lbu	a1,0(a1)
    80002cf0:	02d7d7bb          	divuw	a5,a5,a3
    80002cf4:	f8b40423          	sb	a1,-120(s0)
    80002cf8:	42ebfc63          	bgeu	s7,a4,80003130 <__printf+0x678>
    80002cfc:	02079793          	slli	a5,a5,0x20
    80002d00:	0207d793          	srli	a5,a5,0x20
    80002d04:	00fd8db3          	add	s11,s11,a5
    80002d08:	000dc703          	lbu	a4,0(s11)
    80002d0c:	00a00793          	li	a5,10
    80002d10:	00900c93          	li	s9,9
    80002d14:	f8e404a3          	sb	a4,-119(s0)
    80002d18:	00065c63          	bgez	a2,80002d30 <__printf+0x278>
    80002d1c:	f9040713          	addi	a4,s0,-112
    80002d20:	00f70733          	add	a4,a4,a5
    80002d24:	02d00693          	li	a3,45
    80002d28:	fed70823          	sb	a3,-16(a4)
    80002d2c:	00078c93          	mv	s9,a5
    80002d30:	f8040793          	addi	a5,s0,-128
    80002d34:	01978cb3          	add	s9,a5,s9
    80002d38:	f7f40d13          	addi	s10,s0,-129
    80002d3c:	000cc503          	lbu	a0,0(s9)
    80002d40:	fffc8c93          	addi	s9,s9,-1
    80002d44:	00000097          	auipc	ra,0x0
    80002d48:	b90080e7          	jalr	-1136(ra) # 800028d4 <consputc>
    80002d4c:	ffac98e3          	bne	s9,s10,80002d3c <__printf+0x284>
    80002d50:	00094503          	lbu	a0,0(s2)
    80002d54:	e00514e3          	bnez	a0,80002b5c <__printf+0xa4>
    80002d58:	1a0c1663          	bnez	s8,80002f04 <__printf+0x44c>
    80002d5c:	08813083          	ld	ra,136(sp)
    80002d60:	08013403          	ld	s0,128(sp)
    80002d64:	07813483          	ld	s1,120(sp)
    80002d68:	07013903          	ld	s2,112(sp)
    80002d6c:	06813983          	ld	s3,104(sp)
    80002d70:	06013a03          	ld	s4,96(sp)
    80002d74:	05813a83          	ld	s5,88(sp)
    80002d78:	05013b03          	ld	s6,80(sp)
    80002d7c:	04813b83          	ld	s7,72(sp)
    80002d80:	04013c03          	ld	s8,64(sp)
    80002d84:	03813c83          	ld	s9,56(sp)
    80002d88:	03013d03          	ld	s10,48(sp)
    80002d8c:	02813d83          	ld	s11,40(sp)
    80002d90:	0d010113          	addi	sp,sp,208
    80002d94:	00008067          	ret
    80002d98:	07300713          	li	a4,115
    80002d9c:	1ce78a63          	beq	a5,a4,80002f70 <__printf+0x4b8>
    80002da0:	07800713          	li	a4,120
    80002da4:	1ee79e63          	bne	a5,a4,80002fa0 <__printf+0x4e8>
    80002da8:	f7843783          	ld	a5,-136(s0)
    80002dac:	0007a703          	lw	a4,0(a5)
    80002db0:	00878793          	addi	a5,a5,8
    80002db4:	f6f43c23          	sd	a5,-136(s0)
    80002db8:	28074263          	bltz	a4,8000303c <__printf+0x584>
    80002dbc:	00001d97          	auipc	s11,0x1
    80002dc0:	3c4d8d93          	addi	s11,s11,964 # 80004180 <digits>
    80002dc4:	00f77793          	andi	a5,a4,15
    80002dc8:	00fd87b3          	add	a5,s11,a5
    80002dcc:	0007c683          	lbu	a3,0(a5)
    80002dd0:	00f00613          	li	a2,15
    80002dd4:	0007079b          	sext.w	a5,a4
    80002dd8:	f8d40023          	sb	a3,-128(s0)
    80002ddc:	0047559b          	srliw	a1,a4,0x4
    80002de0:	0047569b          	srliw	a3,a4,0x4
    80002de4:	00000c93          	li	s9,0
    80002de8:	0ee65063          	bge	a2,a4,80002ec8 <__printf+0x410>
    80002dec:	00f6f693          	andi	a3,a3,15
    80002df0:	00dd86b3          	add	a3,s11,a3
    80002df4:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80002df8:	0087d79b          	srliw	a5,a5,0x8
    80002dfc:	00100c93          	li	s9,1
    80002e00:	f8d400a3          	sb	a3,-127(s0)
    80002e04:	0cb67263          	bgeu	a2,a1,80002ec8 <__printf+0x410>
    80002e08:	00f7f693          	andi	a3,a5,15
    80002e0c:	00dd86b3          	add	a3,s11,a3
    80002e10:	0006c583          	lbu	a1,0(a3)
    80002e14:	00f00613          	li	a2,15
    80002e18:	0047d69b          	srliw	a3,a5,0x4
    80002e1c:	f8b40123          	sb	a1,-126(s0)
    80002e20:	0047d593          	srli	a1,a5,0x4
    80002e24:	28f67e63          	bgeu	a2,a5,800030c0 <__printf+0x608>
    80002e28:	00f6f693          	andi	a3,a3,15
    80002e2c:	00dd86b3          	add	a3,s11,a3
    80002e30:	0006c503          	lbu	a0,0(a3)
    80002e34:	0087d813          	srli	a6,a5,0x8
    80002e38:	0087d69b          	srliw	a3,a5,0x8
    80002e3c:	f8a401a3          	sb	a0,-125(s0)
    80002e40:	28b67663          	bgeu	a2,a1,800030cc <__printf+0x614>
    80002e44:	00f6f693          	andi	a3,a3,15
    80002e48:	00dd86b3          	add	a3,s11,a3
    80002e4c:	0006c583          	lbu	a1,0(a3)
    80002e50:	00c7d513          	srli	a0,a5,0xc
    80002e54:	00c7d69b          	srliw	a3,a5,0xc
    80002e58:	f8b40223          	sb	a1,-124(s0)
    80002e5c:	29067a63          	bgeu	a2,a6,800030f0 <__printf+0x638>
    80002e60:	00f6f693          	andi	a3,a3,15
    80002e64:	00dd86b3          	add	a3,s11,a3
    80002e68:	0006c583          	lbu	a1,0(a3)
    80002e6c:	0107d813          	srli	a6,a5,0x10
    80002e70:	0107d69b          	srliw	a3,a5,0x10
    80002e74:	f8b402a3          	sb	a1,-123(s0)
    80002e78:	28a67263          	bgeu	a2,a0,800030fc <__printf+0x644>
    80002e7c:	00f6f693          	andi	a3,a3,15
    80002e80:	00dd86b3          	add	a3,s11,a3
    80002e84:	0006c683          	lbu	a3,0(a3)
    80002e88:	0147d79b          	srliw	a5,a5,0x14
    80002e8c:	f8d40323          	sb	a3,-122(s0)
    80002e90:	21067663          	bgeu	a2,a6,8000309c <__printf+0x5e4>
    80002e94:	02079793          	slli	a5,a5,0x20
    80002e98:	0207d793          	srli	a5,a5,0x20
    80002e9c:	00fd8db3          	add	s11,s11,a5
    80002ea0:	000dc683          	lbu	a3,0(s11)
    80002ea4:	00800793          	li	a5,8
    80002ea8:	00700c93          	li	s9,7
    80002eac:	f8d403a3          	sb	a3,-121(s0)
    80002eb0:	00075c63          	bgez	a4,80002ec8 <__printf+0x410>
    80002eb4:	f9040713          	addi	a4,s0,-112
    80002eb8:	00f70733          	add	a4,a4,a5
    80002ebc:	02d00693          	li	a3,45
    80002ec0:	fed70823          	sb	a3,-16(a4)
    80002ec4:	00078c93          	mv	s9,a5
    80002ec8:	f8040793          	addi	a5,s0,-128
    80002ecc:	01978cb3          	add	s9,a5,s9
    80002ed0:	f7f40d13          	addi	s10,s0,-129
    80002ed4:	000cc503          	lbu	a0,0(s9)
    80002ed8:	fffc8c93          	addi	s9,s9,-1
    80002edc:	00000097          	auipc	ra,0x0
    80002ee0:	9f8080e7          	jalr	-1544(ra) # 800028d4 <consputc>
    80002ee4:	ff9d18e3          	bne	s10,s9,80002ed4 <__printf+0x41c>
    80002ee8:	0100006f          	j	80002ef8 <__printf+0x440>
    80002eec:	00000097          	auipc	ra,0x0
    80002ef0:	9e8080e7          	jalr	-1560(ra) # 800028d4 <consputc>
    80002ef4:	000c8493          	mv	s1,s9
    80002ef8:	00094503          	lbu	a0,0(s2)
    80002efc:	c60510e3          	bnez	a0,80002b5c <__printf+0xa4>
    80002f00:	e40c0ee3          	beqz	s8,80002d5c <__printf+0x2a4>
    80002f04:	00003517          	auipc	a0,0x3
    80002f08:	d6c50513          	addi	a0,a0,-660 # 80005c70 <pr>
    80002f0c:	00001097          	auipc	ra,0x1
    80002f10:	94c080e7          	jalr	-1716(ra) # 80003858 <release>
    80002f14:	e49ff06f          	j	80002d5c <__printf+0x2a4>
    80002f18:	f7843783          	ld	a5,-136(s0)
    80002f1c:	03000513          	li	a0,48
    80002f20:	01000d13          	li	s10,16
    80002f24:	00878713          	addi	a4,a5,8
    80002f28:	0007bc83          	ld	s9,0(a5)
    80002f2c:	f6e43c23          	sd	a4,-136(s0)
    80002f30:	00000097          	auipc	ra,0x0
    80002f34:	9a4080e7          	jalr	-1628(ra) # 800028d4 <consputc>
    80002f38:	07800513          	li	a0,120
    80002f3c:	00000097          	auipc	ra,0x0
    80002f40:	998080e7          	jalr	-1640(ra) # 800028d4 <consputc>
    80002f44:	00001d97          	auipc	s11,0x1
    80002f48:	23cd8d93          	addi	s11,s11,572 # 80004180 <digits>
    80002f4c:	03ccd793          	srli	a5,s9,0x3c
    80002f50:	00fd87b3          	add	a5,s11,a5
    80002f54:	0007c503          	lbu	a0,0(a5)
    80002f58:	fffd0d1b          	addiw	s10,s10,-1
    80002f5c:	004c9c93          	slli	s9,s9,0x4
    80002f60:	00000097          	auipc	ra,0x0
    80002f64:	974080e7          	jalr	-1676(ra) # 800028d4 <consputc>
    80002f68:	fe0d12e3          	bnez	s10,80002f4c <__printf+0x494>
    80002f6c:	f8dff06f          	j	80002ef8 <__printf+0x440>
    80002f70:	f7843783          	ld	a5,-136(s0)
    80002f74:	0007bc83          	ld	s9,0(a5)
    80002f78:	00878793          	addi	a5,a5,8
    80002f7c:	f6f43c23          	sd	a5,-136(s0)
    80002f80:	000c9a63          	bnez	s9,80002f94 <__printf+0x4dc>
    80002f84:	1080006f          	j	8000308c <__printf+0x5d4>
    80002f88:	001c8c93          	addi	s9,s9,1
    80002f8c:	00000097          	auipc	ra,0x0
    80002f90:	948080e7          	jalr	-1720(ra) # 800028d4 <consputc>
    80002f94:	000cc503          	lbu	a0,0(s9)
    80002f98:	fe0518e3          	bnez	a0,80002f88 <__printf+0x4d0>
    80002f9c:	f5dff06f          	j	80002ef8 <__printf+0x440>
    80002fa0:	02500513          	li	a0,37
    80002fa4:	00000097          	auipc	ra,0x0
    80002fa8:	930080e7          	jalr	-1744(ra) # 800028d4 <consputc>
    80002fac:	000c8513          	mv	a0,s9
    80002fb0:	00000097          	auipc	ra,0x0
    80002fb4:	924080e7          	jalr	-1756(ra) # 800028d4 <consputc>
    80002fb8:	f41ff06f          	j	80002ef8 <__printf+0x440>
    80002fbc:	02500513          	li	a0,37
    80002fc0:	00000097          	auipc	ra,0x0
    80002fc4:	914080e7          	jalr	-1772(ra) # 800028d4 <consputc>
    80002fc8:	f31ff06f          	j	80002ef8 <__printf+0x440>
    80002fcc:	00030513          	mv	a0,t1
    80002fd0:	00000097          	auipc	ra,0x0
    80002fd4:	7bc080e7          	jalr	1980(ra) # 8000378c <acquire>
    80002fd8:	b4dff06f          	j	80002b24 <__printf+0x6c>
    80002fdc:	40c0053b          	negw	a0,a2
    80002fe0:	00a00713          	li	a4,10
    80002fe4:	02e576bb          	remuw	a3,a0,a4
    80002fe8:	00001d97          	auipc	s11,0x1
    80002fec:	198d8d93          	addi	s11,s11,408 # 80004180 <digits>
    80002ff0:	ff700593          	li	a1,-9
    80002ff4:	02069693          	slli	a3,a3,0x20
    80002ff8:	0206d693          	srli	a3,a3,0x20
    80002ffc:	00dd86b3          	add	a3,s11,a3
    80003000:	0006c683          	lbu	a3,0(a3)
    80003004:	02e557bb          	divuw	a5,a0,a4
    80003008:	f8d40023          	sb	a3,-128(s0)
    8000300c:	10b65e63          	bge	a2,a1,80003128 <__printf+0x670>
    80003010:	06300593          	li	a1,99
    80003014:	02e7f6bb          	remuw	a3,a5,a4
    80003018:	02069693          	slli	a3,a3,0x20
    8000301c:	0206d693          	srli	a3,a3,0x20
    80003020:	00dd86b3          	add	a3,s11,a3
    80003024:	0006c683          	lbu	a3,0(a3)
    80003028:	02e7d73b          	divuw	a4,a5,a4
    8000302c:	00200793          	li	a5,2
    80003030:	f8d400a3          	sb	a3,-127(s0)
    80003034:	bca5ece3          	bltu	a1,a0,80002c0c <__printf+0x154>
    80003038:	ce5ff06f          	j	80002d1c <__printf+0x264>
    8000303c:	40e007bb          	negw	a5,a4
    80003040:	00001d97          	auipc	s11,0x1
    80003044:	140d8d93          	addi	s11,s11,320 # 80004180 <digits>
    80003048:	00f7f693          	andi	a3,a5,15
    8000304c:	00dd86b3          	add	a3,s11,a3
    80003050:	0006c583          	lbu	a1,0(a3)
    80003054:	ff100613          	li	a2,-15
    80003058:	0047d69b          	srliw	a3,a5,0x4
    8000305c:	f8b40023          	sb	a1,-128(s0)
    80003060:	0047d59b          	srliw	a1,a5,0x4
    80003064:	0ac75e63          	bge	a4,a2,80003120 <__printf+0x668>
    80003068:	00f6f693          	andi	a3,a3,15
    8000306c:	00dd86b3          	add	a3,s11,a3
    80003070:	0006c603          	lbu	a2,0(a3)
    80003074:	00f00693          	li	a3,15
    80003078:	0087d79b          	srliw	a5,a5,0x8
    8000307c:	f8c400a3          	sb	a2,-127(s0)
    80003080:	d8b6e4e3          	bltu	a3,a1,80002e08 <__printf+0x350>
    80003084:	00200793          	li	a5,2
    80003088:	e2dff06f          	j	80002eb4 <__printf+0x3fc>
    8000308c:	00001c97          	auipc	s9,0x1
    80003090:	0d4c8c93          	addi	s9,s9,212 # 80004160 <_ZN3TCB25DEFAULT_SYSTEM_STACK_SIZEE+0x140>
    80003094:	02800513          	li	a0,40
    80003098:	ef1ff06f          	j	80002f88 <__printf+0x4d0>
    8000309c:	00700793          	li	a5,7
    800030a0:	00600c93          	li	s9,6
    800030a4:	e0dff06f          	j	80002eb0 <__printf+0x3f8>
    800030a8:	00700793          	li	a5,7
    800030ac:	00600c93          	li	s9,6
    800030b0:	c69ff06f          	j	80002d18 <__printf+0x260>
    800030b4:	00300793          	li	a5,3
    800030b8:	00200c93          	li	s9,2
    800030bc:	c5dff06f          	j	80002d18 <__printf+0x260>
    800030c0:	00300793          	li	a5,3
    800030c4:	00200c93          	li	s9,2
    800030c8:	de9ff06f          	j	80002eb0 <__printf+0x3f8>
    800030cc:	00400793          	li	a5,4
    800030d0:	00300c93          	li	s9,3
    800030d4:	dddff06f          	j	80002eb0 <__printf+0x3f8>
    800030d8:	00400793          	li	a5,4
    800030dc:	00300c93          	li	s9,3
    800030e0:	c39ff06f          	j	80002d18 <__printf+0x260>
    800030e4:	00500793          	li	a5,5
    800030e8:	00400c93          	li	s9,4
    800030ec:	c2dff06f          	j	80002d18 <__printf+0x260>
    800030f0:	00500793          	li	a5,5
    800030f4:	00400c93          	li	s9,4
    800030f8:	db9ff06f          	j	80002eb0 <__printf+0x3f8>
    800030fc:	00600793          	li	a5,6
    80003100:	00500c93          	li	s9,5
    80003104:	dadff06f          	j	80002eb0 <__printf+0x3f8>
    80003108:	00600793          	li	a5,6
    8000310c:	00500c93          	li	s9,5
    80003110:	c09ff06f          	j	80002d18 <__printf+0x260>
    80003114:	00800793          	li	a5,8
    80003118:	00700c93          	li	s9,7
    8000311c:	bfdff06f          	j	80002d18 <__printf+0x260>
    80003120:	00100793          	li	a5,1
    80003124:	d91ff06f          	j	80002eb4 <__printf+0x3fc>
    80003128:	00100793          	li	a5,1
    8000312c:	bf1ff06f          	j	80002d1c <__printf+0x264>
    80003130:	00900793          	li	a5,9
    80003134:	00800c93          	li	s9,8
    80003138:	be1ff06f          	j	80002d18 <__printf+0x260>
    8000313c:	00001517          	auipc	a0,0x1
    80003140:	02c50513          	addi	a0,a0,44 # 80004168 <_ZN3TCB25DEFAULT_SYSTEM_STACK_SIZEE+0x148>
    80003144:	00000097          	auipc	ra,0x0
    80003148:	918080e7          	jalr	-1768(ra) # 80002a5c <panic>

000000008000314c <printfinit>:
    8000314c:	fe010113          	addi	sp,sp,-32
    80003150:	00813823          	sd	s0,16(sp)
    80003154:	00913423          	sd	s1,8(sp)
    80003158:	00113c23          	sd	ra,24(sp)
    8000315c:	02010413          	addi	s0,sp,32
    80003160:	00003497          	auipc	s1,0x3
    80003164:	b1048493          	addi	s1,s1,-1264 # 80005c70 <pr>
    80003168:	00048513          	mv	a0,s1
    8000316c:	00001597          	auipc	a1,0x1
    80003170:	00c58593          	addi	a1,a1,12 # 80004178 <_ZN3TCB25DEFAULT_SYSTEM_STACK_SIZEE+0x158>
    80003174:	00000097          	auipc	ra,0x0
    80003178:	5f4080e7          	jalr	1524(ra) # 80003768 <initlock>
    8000317c:	01813083          	ld	ra,24(sp)
    80003180:	01013403          	ld	s0,16(sp)
    80003184:	0004ac23          	sw	zero,24(s1)
    80003188:	00813483          	ld	s1,8(sp)
    8000318c:	02010113          	addi	sp,sp,32
    80003190:	00008067          	ret

0000000080003194 <uartinit>:
    80003194:	ff010113          	addi	sp,sp,-16
    80003198:	00813423          	sd	s0,8(sp)
    8000319c:	01010413          	addi	s0,sp,16
    800031a0:	100007b7          	lui	a5,0x10000
    800031a4:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    800031a8:	f8000713          	li	a4,-128
    800031ac:	00e781a3          	sb	a4,3(a5)
    800031b0:	00300713          	li	a4,3
    800031b4:	00e78023          	sb	a4,0(a5)
    800031b8:	000780a3          	sb	zero,1(a5)
    800031bc:	00e781a3          	sb	a4,3(a5)
    800031c0:	00700693          	li	a3,7
    800031c4:	00d78123          	sb	a3,2(a5)
    800031c8:	00e780a3          	sb	a4,1(a5)
    800031cc:	00813403          	ld	s0,8(sp)
    800031d0:	01010113          	addi	sp,sp,16
    800031d4:	00008067          	ret

00000000800031d8 <uartputc>:
    800031d8:	00001797          	auipc	a5,0x1
    800031dc:	6007a783          	lw	a5,1536(a5) # 800047d8 <panicked>
    800031e0:	00078463          	beqz	a5,800031e8 <uartputc+0x10>
    800031e4:	0000006f          	j	800031e4 <uartputc+0xc>
    800031e8:	fd010113          	addi	sp,sp,-48
    800031ec:	02813023          	sd	s0,32(sp)
    800031f0:	00913c23          	sd	s1,24(sp)
    800031f4:	01213823          	sd	s2,16(sp)
    800031f8:	01313423          	sd	s3,8(sp)
    800031fc:	02113423          	sd	ra,40(sp)
    80003200:	03010413          	addi	s0,sp,48
    80003204:	00001917          	auipc	s2,0x1
    80003208:	5dc90913          	addi	s2,s2,1500 # 800047e0 <uart_tx_r>
    8000320c:	00093783          	ld	a5,0(s2)
    80003210:	00001497          	auipc	s1,0x1
    80003214:	5d848493          	addi	s1,s1,1496 # 800047e8 <uart_tx_w>
    80003218:	0004b703          	ld	a4,0(s1)
    8000321c:	02078693          	addi	a3,a5,32
    80003220:	00050993          	mv	s3,a0
    80003224:	02e69c63          	bne	a3,a4,8000325c <uartputc+0x84>
    80003228:	00001097          	auipc	ra,0x1
    8000322c:	834080e7          	jalr	-1996(ra) # 80003a5c <push_on>
    80003230:	00093783          	ld	a5,0(s2)
    80003234:	0004b703          	ld	a4,0(s1)
    80003238:	02078793          	addi	a5,a5,32
    8000323c:	00e79463          	bne	a5,a4,80003244 <uartputc+0x6c>
    80003240:	0000006f          	j	80003240 <uartputc+0x68>
    80003244:	00001097          	auipc	ra,0x1
    80003248:	88c080e7          	jalr	-1908(ra) # 80003ad0 <pop_on>
    8000324c:	00093783          	ld	a5,0(s2)
    80003250:	0004b703          	ld	a4,0(s1)
    80003254:	02078693          	addi	a3,a5,32
    80003258:	fce688e3          	beq	a3,a4,80003228 <uartputc+0x50>
    8000325c:	01f77693          	andi	a3,a4,31
    80003260:	00003597          	auipc	a1,0x3
    80003264:	a3058593          	addi	a1,a1,-1488 # 80005c90 <uart_tx_buf>
    80003268:	00d586b3          	add	a3,a1,a3
    8000326c:	00170713          	addi	a4,a4,1
    80003270:	01368023          	sb	s3,0(a3)
    80003274:	00e4b023          	sd	a4,0(s1)
    80003278:	10000637          	lui	a2,0x10000
    8000327c:	02f71063          	bne	a4,a5,8000329c <uartputc+0xc4>
    80003280:	0340006f          	j	800032b4 <uartputc+0xdc>
    80003284:	00074703          	lbu	a4,0(a4)
    80003288:	00f93023          	sd	a5,0(s2)
    8000328c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80003290:	00093783          	ld	a5,0(s2)
    80003294:	0004b703          	ld	a4,0(s1)
    80003298:	00f70e63          	beq	a4,a5,800032b4 <uartputc+0xdc>
    8000329c:	00564683          	lbu	a3,5(a2)
    800032a0:	01f7f713          	andi	a4,a5,31
    800032a4:	00e58733          	add	a4,a1,a4
    800032a8:	0206f693          	andi	a3,a3,32
    800032ac:	00178793          	addi	a5,a5,1
    800032b0:	fc069ae3          	bnez	a3,80003284 <uartputc+0xac>
    800032b4:	02813083          	ld	ra,40(sp)
    800032b8:	02013403          	ld	s0,32(sp)
    800032bc:	01813483          	ld	s1,24(sp)
    800032c0:	01013903          	ld	s2,16(sp)
    800032c4:	00813983          	ld	s3,8(sp)
    800032c8:	03010113          	addi	sp,sp,48
    800032cc:	00008067          	ret

00000000800032d0 <uartputc_sync>:
    800032d0:	ff010113          	addi	sp,sp,-16
    800032d4:	00813423          	sd	s0,8(sp)
    800032d8:	01010413          	addi	s0,sp,16
    800032dc:	00001717          	auipc	a4,0x1
    800032e0:	4fc72703          	lw	a4,1276(a4) # 800047d8 <panicked>
    800032e4:	02071663          	bnez	a4,80003310 <uartputc_sync+0x40>
    800032e8:	00050793          	mv	a5,a0
    800032ec:	100006b7          	lui	a3,0x10000
    800032f0:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    800032f4:	02077713          	andi	a4,a4,32
    800032f8:	fe070ce3          	beqz	a4,800032f0 <uartputc_sync+0x20>
    800032fc:	0ff7f793          	andi	a5,a5,255
    80003300:	00f68023          	sb	a5,0(a3)
    80003304:	00813403          	ld	s0,8(sp)
    80003308:	01010113          	addi	sp,sp,16
    8000330c:	00008067          	ret
    80003310:	0000006f          	j	80003310 <uartputc_sync+0x40>

0000000080003314 <uartstart>:
    80003314:	ff010113          	addi	sp,sp,-16
    80003318:	00813423          	sd	s0,8(sp)
    8000331c:	01010413          	addi	s0,sp,16
    80003320:	00001617          	auipc	a2,0x1
    80003324:	4c060613          	addi	a2,a2,1216 # 800047e0 <uart_tx_r>
    80003328:	00001517          	auipc	a0,0x1
    8000332c:	4c050513          	addi	a0,a0,1216 # 800047e8 <uart_tx_w>
    80003330:	00063783          	ld	a5,0(a2)
    80003334:	00053703          	ld	a4,0(a0)
    80003338:	04f70263          	beq	a4,a5,8000337c <uartstart+0x68>
    8000333c:	100005b7          	lui	a1,0x10000
    80003340:	00003817          	auipc	a6,0x3
    80003344:	95080813          	addi	a6,a6,-1712 # 80005c90 <uart_tx_buf>
    80003348:	01c0006f          	j	80003364 <uartstart+0x50>
    8000334c:	0006c703          	lbu	a4,0(a3)
    80003350:	00f63023          	sd	a5,0(a2)
    80003354:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80003358:	00063783          	ld	a5,0(a2)
    8000335c:	00053703          	ld	a4,0(a0)
    80003360:	00f70e63          	beq	a4,a5,8000337c <uartstart+0x68>
    80003364:	01f7f713          	andi	a4,a5,31
    80003368:	00e806b3          	add	a3,a6,a4
    8000336c:	0055c703          	lbu	a4,5(a1)
    80003370:	00178793          	addi	a5,a5,1
    80003374:	02077713          	andi	a4,a4,32
    80003378:	fc071ae3          	bnez	a4,8000334c <uartstart+0x38>
    8000337c:	00813403          	ld	s0,8(sp)
    80003380:	01010113          	addi	sp,sp,16
    80003384:	00008067          	ret

0000000080003388 <uartgetc>:
    80003388:	ff010113          	addi	sp,sp,-16
    8000338c:	00813423          	sd	s0,8(sp)
    80003390:	01010413          	addi	s0,sp,16
    80003394:	10000737          	lui	a4,0x10000
    80003398:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    8000339c:	0017f793          	andi	a5,a5,1
    800033a0:	00078c63          	beqz	a5,800033b8 <uartgetc+0x30>
    800033a4:	00074503          	lbu	a0,0(a4)
    800033a8:	0ff57513          	andi	a0,a0,255
    800033ac:	00813403          	ld	s0,8(sp)
    800033b0:	01010113          	addi	sp,sp,16
    800033b4:	00008067          	ret
    800033b8:	fff00513          	li	a0,-1
    800033bc:	ff1ff06f          	j	800033ac <uartgetc+0x24>

00000000800033c0 <uartintr>:
    800033c0:	100007b7          	lui	a5,0x10000
    800033c4:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    800033c8:	0017f793          	andi	a5,a5,1
    800033cc:	0a078463          	beqz	a5,80003474 <uartintr+0xb4>
    800033d0:	fe010113          	addi	sp,sp,-32
    800033d4:	00813823          	sd	s0,16(sp)
    800033d8:	00913423          	sd	s1,8(sp)
    800033dc:	00113c23          	sd	ra,24(sp)
    800033e0:	02010413          	addi	s0,sp,32
    800033e4:	100004b7          	lui	s1,0x10000
    800033e8:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    800033ec:	0ff57513          	andi	a0,a0,255
    800033f0:	fffff097          	auipc	ra,0xfffff
    800033f4:	534080e7          	jalr	1332(ra) # 80002924 <consoleintr>
    800033f8:	0054c783          	lbu	a5,5(s1)
    800033fc:	0017f793          	andi	a5,a5,1
    80003400:	fe0794e3          	bnez	a5,800033e8 <uartintr+0x28>
    80003404:	00001617          	auipc	a2,0x1
    80003408:	3dc60613          	addi	a2,a2,988 # 800047e0 <uart_tx_r>
    8000340c:	00001517          	auipc	a0,0x1
    80003410:	3dc50513          	addi	a0,a0,988 # 800047e8 <uart_tx_w>
    80003414:	00063783          	ld	a5,0(a2)
    80003418:	00053703          	ld	a4,0(a0)
    8000341c:	04f70263          	beq	a4,a5,80003460 <uartintr+0xa0>
    80003420:	100005b7          	lui	a1,0x10000
    80003424:	00003817          	auipc	a6,0x3
    80003428:	86c80813          	addi	a6,a6,-1940 # 80005c90 <uart_tx_buf>
    8000342c:	01c0006f          	j	80003448 <uartintr+0x88>
    80003430:	0006c703          	lbu	a4,0(a3)
    80003434:	00f63023          	sd	a5,0(a2)
    80003438:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000343c:	00063783          	ld	a5,0(a2)
    80003440:	00053703          	ld	a4,0(a0)
    80003444:	00f70e63          	beq	a4,a5,80003460 <uartintr+0xa0>
    80003448:	01f7f713          	andi	a4,a5,31
    8000344c:	00e806b3          	add	a3,a6,a4
    80003450:	0055c703          	lbu	a4,5(a1)
    80003454:	00178793          	addi	a5,a5,1
    80003458:	02077713          	andi	a4,a4,32
    8000345c:	fc071ae3          	bnez	a4,80003430 <uartintr+0x70>
    80003460:	01813083          	ld	ra,24(sp)
    80003464:	01013403          	ld	s0,16(sp)
    80003468:	00813483          	ld	s1,8(sp)
    8000346c:	02010113          	addi	sp,sp,32
    80003470:	00008067          	ret
    80003474:	00001617          	auipc	a2,0x1
    80003478:	36c60613          	addi	a2,a2,876 # 800047e0 <uart_tx_r>
    8000347c:	00001517          	auipc	a0,0x1
    80003480:	36c50513          	addi	a0,a0,876 # 800047e8 <uart_tx_w>
    80003484:	00063783          	ld	a5,0(a2)
    80003488:	00053703          	ld	a4,0(a0)
    8000348c:	04f70263          	beq	a4,a5,800034d0 <uartintr+0x110>
    80003490:	100005b7          	lui	a1,0x10000
    80003494:	00002817          	auipc	a6,0x2
    80003498:	7fc80813          	addi	a6,a6,2044 # 80005c90 <uart_tx_buf>
    8000349c:	01c0006f          	j	800034b8 <uartintr+0xf8>
    800034a0:	0006c703          	lbu	a4,0(a3)
    800034a4:	00f63023          	sd	a5,0(a2)
    800034a8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800034ac:	00063783          	ld	a5,0(a2)
    800034b0:	00053703          	ld	a4,0(a0)
    800034b4:	02f70063          	beq	a4,a5,800034d4 <uartintr+0x114>
    800034b8:	01f7f713          	andi	a4,a5,31
    800034bc:	00e806b3          	add	a3,a6,a4
    800034c0:	0055c703          	lbu	a4,5(a1)
    800034c4:	00178793          	addi	a5,a5,1
    800034c8:	02077713          	andi	a4,a4,32
    800034cc:	fc071ae3          	bnez	a4,800034a0 <uartintr+0xe0>
    800034d0:	00008067          	ret
    800034d4:	00008067          	ret

00000000800034d8 <kinit>:
    800034d8:	fc010113          	addi	sp,sp,-64
    800034dc:	02913423          	sd	s1,40(sp)
    800034e0:	fffff7b7          	lui	a5,0xfffff
    800034e4:	00003497          	auipc	s1,0x3
    800034e8:	7cb48493          	addi	s1,s1,1995 # 80006caf <end+0xfff>
    800034ec:	02813823          	sd	s0,48(sp)
    800034f0:	01313c23          	sd	s3,24(sp)
    800034f4:	00f4f4b3          	and	s1,s1,a5
    800034f8:	02113c23          	sd	ra,56(sp)
    800034fc:	03213023          	sd	s2,32(sp)
    80003500:	01413823          	sd	s4,16(sp)
    80003504:	01513423          	sd	s5,8(sp)
    80003508:	04010413          	addi	s0,sp,64
    8000350c:	000017b7          	lui	a5,0x1
    80003510:	01100993          	li	s3,17
    80003514:	00f487b3          	add	a5,s1,a5
    80003518:	01b99993          	slli	s3,s3,0x1b
    8000351c:	06f9e063          	bltu	s3,a5,8000357c <kinit+0xa4>
    80003520:	00002a97          	auipc	s5,0x2
    80003524:	790a8a93          	addi	s5,s5,1936 # 80005cb0 <end>
    80003528:	0754ec63          	bltu	s1,s5,800035a0 <kinit+0xc8>
    8000352c:	0734fa63          	bgeu	s1,s3,800035a0 <kinit+0xc8>
    80003530:	00088a37          	lui	s4,0x88
    80003534:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80003538:	00001917          	auipc	s2,0x1
    8000353c:	2b890913          	addi	s2,s2,696 # 800047f0 <kmem>
    80003540:	00ca1a13          	slli	s4,s4,0xc
    80003544:	0140006f          	j	80003558 <kinit+0x80>
    80003548:	000017b7          	lui	a5,0x1
    8000354c:	00f484b3          	add	s1,s1,a5
    80003550:	0554e863          	bltu	s1,s5,800035a0 <kinit+0xc8>
    80003554:	0534f663          	bgeu	s1,s3,800035a0 <kinit+0xc8>
    80003558:	00001637          	lui	a2,0x1
    8000355c:	00100593          	li	a1,1
    80003560:	00048513          	mv	a0,s1
    80003564:	00000097          	auipc	ra,0x0
    80003568:	5e4080e7          	jalr	1508(ra) # 80003b48 <__memset>
    8000356c:	00093783          	ld	a5,0(s2)
    80003570:	00f4b023          	sd	a5,0(s1)
    80003574:	00993023          	sd	s1,0(s2)
    80003578:	fd4498e3          	bne	s1,s4,80003548 <kinit+0x70>
    8000357c:	03813083          	ld	ra,56(sp)
    80003580:	03013403          	ld	s0,48(sp)
    80003584:	02813483          	ld	s1,40(sp)
    80003588:	02013903          	ld	s2,32(sp)
    8000358c:	01813983          	ld	s3,24(sp)
    80003590:	01013a03          	ld	s4,16(sp)
    80003594:	00813a83          	ld	s5,8(sp)
    80003598:	04010113          	addi	sp,sp,64
    8000359c:	00008067          	ret
    800035a0:	00001517          	auipc	a0,0x1
    800035a4:	bf850513          	addi	a0,a0,-1032 # 80004198 <digits+0x18>
    800035a8:	fffff097          	auipc	ra,0xfffff
    800035ac:	4b4080e7          	jalr	1204(ra) # 80002a5c <panic>

00000000800035b0 <freerange>:
    800035b0:	fc010113          	addi	sp,sp,-64
    800035b4:	000017b7          	lui	a5,0x1
    800035b8:	02913423          	sd	s1,40(sp)
    800035bc:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    800035c0:	009504b3          	add	s1,a0,s1
    800035c4:	fffff537          	lui	a0,0xfffff
    800035c8:	02813823          	sd	s0,48(sp)
    800035cc:	02113c23          	sd	ra,56(sp)
    800035d0:	03213023          	sd	s2,32(sp)
    800035d4:	01313c23          	sd	s3,24(sp)
    800035d8:	01413823          	sd	s4,16(sp)
    800035dc:	01513423          	sd	s5,8(sp)
    800035e0:	01613023          	sd	s6,0(sp)
    800035e4:	04010413          	addi	s0,sp,64
    800035e8:	00a4f4b3          	and	s1,s1,a0
    800035ec:	00f487b3          	add	a5,s1,a5
    800035f0:	06f5e463          	bltu	a1,a5,80003658 <freerange+0xa8>
    800035f4:	00002a97          	auipc	s5,0x2
    800035f8:	6bca8a93          	addi	s5,s5,1724 # 80005cb0 <end>
    800035fc:	0954e263          	bltu	s1,s5,80003680 <freerange+0xd0>
    80003600:	01100993          	li	s3,17
    80003604:	01b99993          	slli	s3,s3,0x1b
    80003608:	0734fc63          	bgeu	s1,s3,80003680 <freerange+0xd0>
    8000360c:	00058a13          	mv	s4,a1
    80003610:	00001917          	auipc	s2,0x1
    80003614:	1e090913          	addi	s2,s2,480 # 800047f0 <kmem>
    80003618:	00002b37          	lui	s6,0x2
    8000361c:	0140006f          	j	80003630 <freerange+0x80>
    80003620:	000017b7          	lui	a5,0x1
    80003624:	00f484b3          	add	s1,s1,a5
    80003628:	0554ec63          	bltu	s1,s5,80003680 <freerange+0xd0>
    8000362c:	0534fa63          	bgeu	s1,s3,80003680 <freerange+0xd0>
    80003630:	00001637          	lui	a2,0x1
    80003634:	00100593          	li	a1,1
    80003638:	00048513          	mv	a0,s1
    8000363c:	00000097          	auipc	ra,0x0
    80003640:	50c080e7          	jalr	1292(ra) # 80003b48 <__memset>
    80003644:	00093703          	ld	a4,0(s2)
    80003648:	016487b3          	add	a5,s1,s6
    8000364c:	00e4b023          	sd	a4,0(s1)
    80003650:	00993023          	sd	s1,0(s2)
    80003654:	fcfa76e3          	bgeu	s4,a5,80003620 <freerange+0x70>
    80003658:	03813083          	ld	ra,56(sp)
    8000365c:	03013403          	ld	s0,48(sp)
    80003660:	02813483          	ld	s1,40(sp)
    80003664:	02013903          	ld	s2,32(sp)
    80003668:	01813983          	ld	s3,24(sp)
    8000366c:	01013a03          	ld	s4,16(sp)
    80003670:	00813a83          	ld	s5,8(sp)
    80003674:	00013b03          	ld	s6,0(sp)
    80003678:	04010113          	addi	sp,sp,64
    8000367c:	00008067          	ret
    80003680:	00001517          	auipc	a0,0x1
    80003684:	b1850513          	addi	a0,a0,-1256 # 80004198 <digits+0x18>
    80003688:	fffff097          	auipc	ra,0xfffff
    8000368c:	3d4080e7          	jalr	980(ra) # 80002a5c <panic>

0000000080003690 <kfree>:
    80003690:	fe010113          	addi	sp,sp,-32
    80003694:	00813823          	sd	s0,16(sp)
    80003698:	00113c23          	sd	ra,24(sp)
    8000369c:	00913423          	sd	s1,8(sp)
    800036a0:	02010413          	addi	s0,sp,32
    800036a4:	03451793          	slli	a5,a0,0x34
    800036a8:	04079c63          	bnez	a5,80003700 <kfree+0x70>
    800036ac:	00002797          	auipc	a5,0x2
    800036b0:	60478793          	addi	a5,a5,1540 # 80005cb0 <end>
    800036b4:	00050493          	mv	s1,a0
    800036b8:	04f56463          	bltu	a0,a5,80003700 <kfree+0x70>
    800036bc:	01100793          	li	a5,17
    800036c0:	01b79793          	slli	a5,a5,0x1b
    800036c4:	02f57e63          	bgeu	a0,a5,80003700 <kfree+0x70>
    800036c8:	00001637          	lui	a2,0x1
    800036cc:	00100593          	li	a1,1
    800036d0:	00000097          	auipc	ra,0x0
    800036d4:	478080e7          	jalr	1144(ra) # 80003b48 <__memset>
    800036d8:	00001797          	auipc	a5,0x1
    800036dc:	11878793          	addi	a5,a5,280 # 800047f0 <kmem>
    800036e0:	0007b703          	ld	a4,0(a5)
    800036e4:	01813083          	ld	ra,24(sp)
    800036e8:	01013403          	ld	s0,16(sp)
    800036ec:	00e4b023          	sd	a4,0(s1)
    800036f0:	0097b023          	sd	s1,0(a5)
    800036f4:	00813483          	ld	s1,8(sp)
    800036f8:	02010113          	addi	sp,sp,32
    800036fc:	00008067          	ret
    80003700:	00001517          	auipc	a0,0x1
    80003704:	a9850513          	addi	a0,a0,-1384 # 80004198 <digits+0x18>
    80003708:	fffff097          	auipc	ra,0xfffff
    8000370c:	354080e7          	jalr	852(ra) # 80002a5c <panic>

0000000080003710 <kalloc>:
    80003710:	fe010113          	addi	sp,sp,-32
    80003714:	00813823          	sd	s0,16(sp)
    80003718:	00913423          	sd	s1,8(sp)
    8000371c:	00113c23          	sd	ra,24(sp)
    80003720:	02010413          	addi	s0,sp,32
    80003724:	00001797          	auipc	a5,0x1
    80003728:	0cc78793          	addi	a5,a5,204 # 800047f0 <kmem>
    8000372c:	0007b483          	ld	s1,0(a5)
    80003730:	02048063          	beqz	s1,80003750 <kalloc+0x40>
    80003734:	0004b703          	ld	a4,0(s1)
    80003738:	00001637          	lui	a2,0x1
    8000373c:	00500593          	li	a1,5
    80003740:	00048513          	mv	a0,s1
    80003744:	00e7b023          	sd	a4,0(a5)
    80003748:	00000097          	auipc	ra,0x0
    8000374c:	400080e7          	jalr	1024(ra) # 80003b48 <__memset>
    80003750:	01813083          	ld	ra,24(sp)
    80003754:	01013403          	ld	s0,16(sp)
    80003758:	00048513          	mv	a0,s1
    8000375c:	00813483          	ld	s1,8(sp)
    80003760:	02010113          	addi	sp,sp,32
    80003764:	00008067          	ret

0000000080003768 <initlock>:
    80003768:	ff010113          	addi	sp,sp,-16
    8000376c:	00813423          	sd	s0,8(sp)
    80003770:	01010413          	addi	s0,sp,16
    80003774:	00813403          	ld	s0,8(sp)
    80003778:	00b53423          	sd	a1,8(a0)
    8000377c:	00052023          	sw	zero,0(a0)
    80003780:	00053823          	sd	zero,16(a0)
    80003784:	01010113          	addi	sp,sp,16
    80003788:	00008067          	ret

000000008000378c <acquire>:
    8000378c:	fe010113          	addi	sp,sp,-32
    80003790:	00813823          	sd	s0,16(sp)
    80003794:	00913423          	sd	s1,8(sp)
    80003798:	00113c23          	sd	ra,24(sp)
    8000379c:	01213023          	sd	s2,0(sp)
    800037a0:	02010413          	addi	s0,sp,32
    800037a4:	00050493          	mv	s1,a0
    800037a8:	10002973          	csrr	s2,sstatus
    800037ac:	100027f3          	csrr	a5,sstatus
    800037b0:	ffd7f793          	andi	a5,a5,-3
    800037b4:	10079073          	csrw	sstatus,a5
    800037b8:	fffff097          	auipc	ra,0xfffff
    800037bc:	8e0080e7          	jalr	-1824(ra) # 80002098 <mycpu>
    800037c0:	07852783          	lw	a5,120(a0)
    800037c4:	06078e63          	beqz	a5,80003840 <acquire+0xb4>
    800037c8:	fffff097          	auipc	ra,0xfffff
    800037cc:	8d0080e7          	jalr	-1840(ra) # 80002098 <mycpu>
    800037d0:	07852783          	lw	a5,120(a0)
    800037d4:	0004a703          	lw	a4,0(s1)
    800037d8:	0017879b          	addiw	a5,a5,1
    800037dc:	06f52c23          	sw	a5,120(a0)
    800037e0:	04071063          	bnez	a4,80003820 <acquire+0x94>
    800037e4:	00100713          	li	a4,1
    800037e8:	00070793          	mv	a5,a4
    800037ec:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    800037f0:	0007879b          	sext.w	a5,a5
    800037f4:	fe079ae3          	bnez	a5,800037e8 <acquire+0x5c>
    800037f8:	0ff0000f          	fence
    800037fc:	fffff097          	auipc	ra,0xfffff
    80003800:	89c080e7          	jalr	-1892(ra) # 80002098 <mycpu>
    80003804:	01813083          	ld	ra,24(sp)
    80003808:	01013403          	ld	s0,16(sp)
    8000380c:	00a4b823          	sd	a0,16(s1)
    80003810:	00013903          	ld	s2,0(sp)
    80003814:	00813483          	ld	s1,8(sp)
    80003818:	02010113          	addi	sp,sp,32
    8000381c:	00008067          	ret
    80003820:	0104b903          	ld	s2,16(s1)
    80003824:	fffff097          	auipc	ra,0xfffff
    80003828:	874080e7          	jalr	-1932(ra) # 80002098 <mycpu>
    8000382c:	faa91ce3          	bne	s2,a0,800037e4 <acquire+0x58>
    80003830:	00001517          	auipc	a0,0x1
    80003834:	97050513          	addi	a0,a0,-1680 # 800041a0 <digits+0x20>
    80003838:	fffff097          	auipc	ra,0xfffff
    8000383c:	224080e7          	jalr	548(ra) # 80002a5c <panic>
    80003840:	00195913          	srli	s2,s2,0x1
    80003844:	fffff097          	auipc	ra,0xfffff
    80003848:	854080e7          	jalr	-1964(ra) # 80002098 <mycpu>
    8000384c:	00197913          	andi	s2,s2,1
    80003850:	07252e23          	sw	s2,124(a0)
    80003854:	f75ff06f          	j	800037c8 <acquire+0x3c>

0000000080003858 <release>:
    80003858:	fe010113          	addi	sp,sp,-32
    8000385c:	00813823          	sd	s0,16(sp)
    80003860:	00113c23          	sd	ra,24(sp)
    80003864:	00913423          	sd	s1,8(sp)
    80003868:	01213023          	sd	s2,0(sp)
    8000386c:	02010413          	addi	s0,sp,32
    80003870:	00052783          	lw	a5,0(a0)
    80003874:	00079a63          	bnez	a5,80003888 <release+0x30>
    80003878:	00001517          	auipc	a0,0x1
    8000387c:	93050513          	addi	a0,a0,-1744 # 800041a8 <digits+0x28>
    80003880:	fffff097          	auipc	ra,0xfffff
    80003884:	1dc080e7          	jalr	476(ra) # 80002a5c <panic>
    80003888:	01053903          	ld	s2,16(a0)
    8000388c:	00050493          	mv	s1,a0
    80003890:	fffff097          	auipc	ra,0xfffff
    80003894:	808080e7          	jalr	-2040(ra) # 80002098 <mycpu>
    80003898:	fea910e3          	bne	s2,a0,80003878 <release+0x20>
    8000389c:	0004b823          	sd	zero,16(s1)
    800038a0:	0ff0000f          	fence
    800038a4:	0f50000f          	fence	iorw,ow
    800038a8:	0804a02f          	amoswap.w	zero,zero,(s1)
    800038ac:	ffffe097          	auipc	ra,0xffffe
    800038b0:	7ec080e7          	jalr	2028(ra) # 80002098 <mycpu>
    800038b4:	100027f3          	csrr	a5,sstatus
    800038b8:	0027f793          	andi	a5,a5,2
    800038bc:	04079a63          	bnez	a5,80003910 <release+0xb8>
    800038c0:	07852783          	lw	a5,120(a0)
    800038c4:	02f05e63          	blez	a5,80003900 <release+0xa8>
    800038c8:	fff7871b          	addiw	a4,a5,-1
    800038cc:	06e52c23          	sw	a4,120(a0)
    800038d0:	00071c63          	bnez	a4,800038e8 <release+0x90>
    800038d4:	07c52783          	lw	a5,124(a0)
    800038d8:	00078863          	beqz	a5,800038e8 <release+0x90>
    800038dc:	100027f3          	csrr	a5,sstatus
    800038e0:	0027e793          	ori	a5,a5,2
    800038e4:	10079073          	csrw	sstatus,a5
    800038e8:	01813083          	ld	ra,24(sp)
    800038ec:	01013403          	ld	s0,16(sp)
    800038f0:	00813483          	ld	s1,8(sp)
    800038f4:	00013903          	ld	s2,0(sp)
    800038f8:	02010113          	addi	sp,sp,32
    800038fc:	00008067          	ret
    80003900:	00001517          	auipc	a0,0x1
    80003904:	8c850513          	addi	a0,a0,-1848 # 800041c8 <digits+0x48>
    80003908:	fffff097          	auipc	ra,0xfffff
    8000390c:	154080e7          	jalr	340(ra) # 80002a5c <panic>
    80003910:	00001517          	auipc	a0,0x1
    80003914:	8a050513          	addi	a0,a0,-1888 # 800041b0 <digits+0x30>
    80003918:	fffff097          	auipc	ra,0xfffff
    8000391c:	144080e7          	jalr	324(ra) # 80002a5c <panic>

0000000080003920 <holding>:
    80003920:	00052783          	lw	a5,0(a0)
    80003924:	00079663          	bnez	a5,80003930 <holding+0x10>
    80003928:	00000513          	li	a0,0
    8000392c:	00008067          	ret
    80003930:	fe010113          	addi	sp,sp,-32
    80003934:	00813823          	sd	s0,16(sp)
    80003938:	00913423          	sd	s1,8(sp)
    8000393c:	00113c23          	sd	ra,24(sp)
    80003940:	02010413          	addi	s0,sp,32
    80003944:	01053483          	ld	s1,16(a0)
    80003948:	ffffe097          	auipc	ra,0xffffe
    8000394c:	750080e7          	jalr	1872(ra) # 80002098 <mycpu>
    80003950:	01813083          	ld	ra,24(sp)
    80003954:	01013403          	ld	s0,16(sp)
    80003958:	40a48533          	sub	a0,s1,a0
    8000395c:	00153513          	seqz	a0,a0
    80003960:	00813483          	ld	s1,8(sp)
    80003964:	02010113          	addi	sp,sp,32
    80003968:	00008067          	ret

000000008000396c <push_off>:
    8000396c:	fe010113          	addi	sp,sp,-32
    80003970:	00813823          	sd	s0,16(sp)
    80003974:	00113c23          	sd	ra,24(sp)
    80003978:	00913423          	sd	s1,8(sp)
    8000397c:	02010413          	addi	s0,sp,32
    80003980:	100024f3          	csrr	s1,sstatus
    80003984:	100027f3          	csrr	a5,sstatus
    80003988:	ffd7f793          	andi	a5,a5,-3
    8000398c:	10079073          	csrw	sstatus,a5
    80003990:	ffffe097          	auipc	ra,0xffffe
    80003994:	708080e7          	jalr	1800(ra) # 80002098 <mycpu>
    80003998:	07852783          	lw	a5,120(a0)
    8000399c:	02078663          	beqz	a5,800039c8 <push_off+0x5c>
    800039a0:	ffffe097          	auipc	ra,0xffffe
    800039a4:	6f8080e7          	jalr	1784(ra) # 80002098 <mycpu>
    800039a8:	07852783          	lw	a5,120(a0)
    800039ac:	01813083          	ld	ra,24(sp)
    800039b0:	01013403          	ld	s0,16(sp)
    800039b4:	0017879b          	addiw	a5,a5,1
    800039b8:	06f52c23          	sw	a5,120(a0)
    800039bc:	00813483          	ld	s1,8(sp)
    800039c0:	02010113          	addi	sp,sp,32
    800039c4:	00008067          	ret
    800039c8:	0014d493          	srli	s1,s1,0x1
    800039cc:	ffffe097          	auipc	ra,0xffffe
    800039d0:	6cc080e7          	jalr	1740(ra) # 80002098 <mycpu>
    800039d4:	0014f493          	andi	s1,s1,1
    800039d8:	06952e23          	sw	s1,124(a0)
    800039dc:	fc5ff06f          	j	800039a0 <push_off+0x34>

00000000800039e0 <pop_off>:
    800039e0:	ff010113          	addi	sp,sp,-16
    800039e4:	00813023          	sd	s0,0(sp)
    800039e8:	00113423          	sd	ra,8(sp)
    800039ec:	01010413          	addi	s0,sp,16
    800039f0:	ffffe097          	auipc	ra,0xffffe
    800039f4:	6a8080e7          	jalr	1704(ra) # 80002098 <mycpu>
    800039f8:	100027f3          	csrr	a5,sstatus
    800039fc:	0027f793          	andi	a5,a5,2
    80003a00:	04079663          	bnez	a5,80003a4c <pop_off+0x6c>
    80003a04:	07852783          	lw	a5,120(a0)
    80003a08:	02f05a63          	blez	a5,80003a3c <pop_off+0x5c>
    80003a0c:	fff7871b          	addiw	a4,a5,-1
    80003a10:	06e52c23          	sw	a4,120(a0)
    80003a14:	00071c63          	bnez	a4,80003a2c <pop_off+0x4c>
    80003a18:	07c52783          	lw	a5,124(a0)
    80003a1c:	00078863          	beqz	a5,80003a2c <pop_off+0x4c>
    80003a20:	100027f3          	csrr	a5,sstatus
    80003a24:	0027e793          	ori	a5,a5,2
    80003a28:	10079073          	csrw	sstatus,a5
    80003a2c:	00813083          	ld	ra,8(sp)
    80003a30:	00013403          	ld	s0,0(sp)
    80003a34:	01010113          	addi	sp,sp,16
    80003a38:	00008067          	ret
    80003a3c:	00000517          	auipc	a0,0x0
    80003a40:	78c50513          	addi	a0,a0,1932 # 800041c8 <digits+0x48>
    80003a44:	fffff097          	auipc	ra,0xfffff
    80003a48:	018080e7          	jalr	24(ra) # 80002a5c <panic>
    80003a4c:	00000517          	auipc	a0,0x0
    80003a50:	76450513          	addi	a0,a0,1892 # 800041b0 <digits+0x30>
    80003a54:	fffff097          	auipc	ra,0xfffff
    80003a58:	008080e7          	jalr	8(ra) # 80002a5c <panic>

0000000080003a5c <push_on>:
    80003a5c:	fe010113          	addi	sp,sp,-32
    80003a60:	00813823          	sd	s0,16(sp)
    80003a64:	00113c23          	sd	ra,24(sp)
    80003a68:	00913423          	sd	s1,8(sp)
    80003a6c:	02010413          	addi	s0,sp,32
    80003a70:	100024f3          	csrr	s1,sstatus
    80003a74:	100027f3          	csrr	a5,sstatus
    80003a78:	0027e793          	ori	a5,a5,2
    80003a7c:	10079073          	csrw	sstatus,a5
    80003a80:	ffffe097          	auipc	ra,0xffffe
    80003a84:	618080e7          	jalr	1560(ra) # 80002098 <mycpu>
    80003a88:	07852783          	lw	a5,120(a0)
    80003a8c:	02078663          	beqz	a5,80003ab8 <push_on+0x5c>
    80003a90:	ffffe097          	auipc	ra,0xffffe
    80003a94:	608080e7          	jalr	1544(ra) # 80002098 <mycpu>
    80003a98:	07852783          	lw	a5,120(a0)
    80003a9c:	01813083          	ld	ra,24(sp)
    80003aa0:	01013403          	ld	s0,16(sp)
    80003aa4:	0017879b          	addiw	a5,a5,1
    80003aa8:	06f52c23          	sw	a5,120(a0)
    80003aac:	00813483          	ld	s1,8(sp)
    80003ab0:	02010113          	addi	sp,sp,32
    80003ab4:	00008067          	ret
    80003ab8:	0014d493          	srli	s1,s1,0x1
    80003abc:	ffffe097          	auipc	ra,0xffffe
    80003ac0:	5dc080e7          	jalr	1500(ra) # 80002098 <mycpu>
    80003ac4:	0014f493          	andi	s1,s1,1
    80003ac8:	06952e23          	sw	s1,124(a0)
    80003acc:	fc5ff06f          	j	80003a90 <push_on+0x34>

0000000080003ad0 <pop_on>:
    80003ad0:	ff010113          	addi	sp,sp,-16
    80003ad4:	00813023          	sd	s0,0(sp)
    80003ad8:	00113423          	sd	ra,8(sp)
    80003adc:	01010413          	addi	s0,sp,16
    80003ae0:	ffffe097          	auipc	ra,0xffffe
    80003ae4:	5b8080e7          	jalr	1464(ra) # 80002098 <mycpu>
    80003ae8:	100027f3          	csrr	a5,sstatus
    80003aec:	0027f793          	andi	a5,a5,2
    80003af0:	04078463          	beqz	a5,80003b38 <pop_on+0x68>
    80003af4:	07852783          	lw	a5,120(a0)
    80003af8:	02f05863          	blez	a5,80003b28 <pop_on+0x58>
    80003afc:	fff7879b          	addiw	a5,a5,-1
    80003b00:	06f52c23          	sw	a5,120(a0)
    80003b04:	07853783          	ld	a5,120(a0)
    80003b08:	00079863          	bnez	a5,80003b18 <pop_on+0x48>
    80003b0c:	100027f3          	csrr	a5,sstatus
    80003b10:	ffd7f793          	andi	a5,a5,-3
    80003b14:	10079073          	csrw	sstatus,a5
    80003b18:	00813083          	ld	ra,8(sp)
    80003b1c:	00013403          	ld	s0,0(sp)
    80003b20:	01010113          	addi	sp,sp,16
    80003b24:	00008067          	ret
    80003b28:	00000517          	auipc	a0,0x0
    80003b2c:	6c850513          	addi	a0,a0,1736 # 800041f0 <digits+0x70>
    80003b30:	fffff097          	auipc	ra,0xfffff
    80003b34:	f2c080e7          	jalr	-212(ra) # 80002a5c <panic>
    80003b38:	00000517          	auipc	a0,0x0
    80003b3c:	69850513          	addi	a0,a0,1688 # 800041d0 <digits+0x50>
    80003b40:	fffff097          	auipc	ra,0xfffff
    80003b44:	f1c080e7          	jalr	-228(ra) # 80002a5c <panic>

0000000080003b48 <__memset>:
    80003b48:	ff010113          	addi	sp,sp,-16
    80003b4c:	00813423          	sd	s0,8(sp)
    80003b50:	01010413          	addi	s0,sp,16
    80003b54:	1a060e63          	beqz	a2,80003d10 <__memset+0x1c8>
    80003b58:	40a007b3          	neg	a5,a0
    80003b5c:	0077f793          	andi	a5,a5,7
    80003b60:	00778693          	addi	a3,a5,7
    80003b64:	00b00813          	li	a6,11
    80003b68:	0ff5f593          	andi	a1,a1,255
    80003b6c:	fff6071b          	addiw	a4,a2,-1
    80003b70:	1b06e663          	bltu	a3,a6,80003d1c <__memset+0x1d4>
    80003b74:	1cd76463          	bltu	a4,a3,80003d3c <__memset+0x1f4>
    80003b78:	1a078e63          	beqz	a5,80003d34 <__memset+0x1ec>
    80003b7c:	00b50023          	sb	a1,0(a0)
    80003b80:	00100713          	li	a4,1
    80003b84:	1ae78463          	beq	a5,a4,80003d2c <__memset+0x1e4>
    80003b88:	00b500a3          	sb	a1,1(a0)
    80003b8c:	00200713          	li	a4,2
    80003b90:	1ae78a63          	beq	a5,a4,80003d44 <__memset+0x1fc>
    80003b94:	00b50123          	sb	a1,2(a0)
    80003b98:	00300713          	li	a4,3
    80003b9c:	18e78463          	beq	a5,a4,80003d24 <__memset+0x1dc>
    80003ba0:	00b501a3          	sb	a1,3(a0)
    80003ba4:	00400713          	li	a4,4
    80003ba8:	1ae78263          	beq	a5,a4,80003d4c <__memset+0x204>
    80003bac:	00b50223          	sb	a1,4(a0)
    80003bb0:	00500713          	li	a4,5
    80003bb4:	1ae78063          	beq	a5,a4,80003d54 <__memset+0x20c>
    80003bb8:	00b502a3          	sb	a1,5(a0)
    80003bbc:	00700713          	li	a4,7
    80003bc0:	18e79e63          	bne	a5,a4,80003d5c <__memset+0x214>
    80003bc4:	00b50323          	sb	a1,6(a0)
    80003bc8:	00700e93          	li	t4,7
    80003bcc:	00859713          	slli	a4,a1,0x8
    80003bd0:	00e5e733          	or	a4,a1,a4
    80003bd4:	01059e13          	slli	t3,a1,0x10
    80003bd8:	01c76e33          	or	t3,a4,t3
    80003bdc:	01859313          	slli	t1,a1,0x18
    80003be0:	006e6333          	or	t1,t3,t1
    80003be4:	02059893          	slli	a7,a1,0x20
    80003be8:	40f60e3b          	subw	t3,a2,a5
    80003bec:	011368b3          	or	a7,t1,a7
    80003bf0:	02859813          	slli	a6,a1,0x28
    80003bf4:	0108e833          	or	a6,a7,a6
    80003bf8:	03059693          	slli	a3,a1,0x30
    80003bfc:	003e589b          	srliw	a7,t3,0x3
    80003c00:	00d866b3          	or	a3,a6,a3
    80003c04:	03859713          	slli	a4,a1,0x38
    80003c08:	00389813          	slli	a6,a7,0x3
    80003c0c:	00f507b3          	add	a5,a0,a5
    80003c10:	00e6e733          	or	a4,a3,a4
    80003c14:	000e089b          	sext.w	a7,t3
    80003c18:	00f806b3          	add	a3,a6,a5
    80003c1c:	00e7b023          	sd	a4,0(a5)
    80003c20:	00878793          	addi	a5,a5,8
    80003c24:	fed79ce3          	bne	a5,a3,80003c1c <__memset+0xd4>
    80003c28:	ff8e7793          	andi	a5,t3,-8
    80003c2c:	0007871b          	sext.w	a4,a5
    80003c30:	01d787bb          	addw	a5,a5,t4
    80003c34:	0ce88e63          	beq	a7,a4,80003d10 <__memset+0x1c8>
    80003c38:	00f50733          	add	a4,a0,a5
    80003c3c:	00b70023          	sb	a1,0(a4)
    80003c40:	0017871b          	addiw	a4,a5,1
    80003c44:	0cc77663          	bgeu	a4,a2,80003d10 <__memset+0x1c8>
    80003c48:	00e50733          	add	a4,a0,a4
    80003c4c:	00b70023          	sb	a1,0(a4)
    80003c50:	0027871b          	addiw	a4,a5,2
    80003c54:	0ac77e63          	bgeu	a4,a2,80003d10 <__memset+0x1c8>
    80003c58:	00e50733          	add	a4,a0,a4
    80003c5c:	00b70023          	sb	a1,0(a4)
    80003c60:	0037871b          	addiw	a4,a5,3
    80003c64:	0ac77663          	bgeu	a4,a2,80003d10 <__memset+0x1c8>
    80003c68:	00e50733          	add	a4,a0,a4
    80003c6c:	00b70023          	sb	a1,0(a4)
    80003c70:	0047871b          	addiw	a4,a5,4
    80003c74:	08c77e63          	bgeu	a4,a2,80003d10 <__memset+0x1c8>
    80003c78:	00e50733          	add	a4,a0,a4
    80003c7c:	00b70023          	sb	a1,0(a4)
    80003c80:	0057871b          	addiw	a4,a5,5
    80003c84:	08c77663          	bgeu	a4,a2,80003d10 <__memset+0x1c8>
    80003c88:	00e50733          	add	a4,a0,a4
    80003c8c:	00b70023          	sb	a1,0(a4)
    80003c90:	0067871b          	addiw	a4,a5,6
    80003c94:	06c77e63          	bgeu	a4,a2,80003d10 <__memset+0x1c8>
    80003c98:	00e50733          	add	a4,a0,a4
    80003c9c:	00b70023          	sb	a1,0(a4)
    80003ca0:	0077871b          	addiw	a4,a5,7
    80003ca4:	06c77663          	bgeu	a4,a2,80003d10 <__memset+0x1c8>
    80003ca8:	00e50733          	add	a4,a0,a4
    80003cac:	00b70023          	sb	a1,0(a4)
    80003cb0:	0087871b          	addiw	a4,a5,8
    80003cb4:	04c77e63          	bgeu	a4,a2,80003d10 <__memset+0x1c8>
    80003cb8:	00e50733          	add	a4,a0,a4
    80003cbc:	00b70023          	sb	a1,0(a4)
    80003cc0:	0097871b          	addiw	a4,a5,9
    80003cc4:	04c77663          	bgeu	a4,a2,80003d10 <__memset+0x1c8>
    80003cc8:	00e50733          	add	a4,a0,a4
    80003ccc:	00b70023          	sb	a1,0(a4)
    80003cd0:	00a7871b          	addiw	a4,a5,10
    80003cd4:	02c77e63          	bgeu	a4,a2,80003d10 <__memset+0x1c8>
    80003cd8:	00e50733          	add	a4,a0,a4
    80003cdc:	00b70023          	sb	a1,0(a4)
    80003ce0:	00b7871b          	addiw	a4,a5,11
    80003ce4:	02c77663          	bgeu	a4,a2,80003d10 <__memset+0x1c8>
    80003ce8:	00e50733          	add	a4,a0,a4
    80003cec:	00b70023          	sb	a1,0(a4)
    80003cf0:	00c7871b          	addiw	a4,a5,12
    80003cf4:	00c77e63          	bgeu	a4,a2,80003d10 <__memset+0x1c8>
    80003cf8:	00e50733          	add	a4,a0,a4
    80003cfc:	00b70023          	sb	a1,0(a4)
    80003d00:	00d7879b          	addiw	a5,a5,13
    80003d04:	00c7f663          	bgeu	a5,a2,80003d10 <__memset+0x1c8>
    80003d08:	00f507b3          	add	a5,a0,a5
    80003d0c:	00b78023          	sb	a1,0(a5)
    80003d10:	00813403          	ld	s0,8(sp)
    80003d14:	01010113          	addi	sp,sp,16
    80003d18:	00008067          	ret
    80003d1c:	00b00693          	li	a3,11
    80003d20:	e55ff06f          	j	80003b74 <__memset+0x2c>
    80003d24:	00300e93          	li	t4,3
    80003d28:	ea5ff06f          	j	80003bcc <__memset+0x84>
    80003d2c:	00100e93          	li	t4,1
    80003d30:	e9dff06f          	j	80003bcc <__memset+0x84>
    80003d34:	00000e93          	li	t4,0
    80003d38:	e95ff06f          	j	80003bcc <__memset+0x84>
    80003d3c:	00000793          	li	a5,0
    80003d40:	ef9ff06f          	j	80003c38 <__memset+0xf0>
    80003d44:	00200e93          	li	t4,2
    80003d48:	e85ff06f          	j	80003bcc <__memset+0x84>
    80003d4c:	00400e93          	li	t4,4
    80003d50:	e7dff06f          	j	80003bcc <__memset+0x84>
    80003d54:	00500e93          	li	t4,5
    80003d58:	e75ff06f          	j	80003bcc <__memset+0x84>
    80003d5c:	00600e93          	li	t4,6
    80003d60:	e6dff06f          	j	80003bcc <__memset+0x84>

0000000080003d64 <__memmove>:
    80003d64:	ff010113          	addi	sp,sp,-16
    80003d68:	00813423          	sd	s0,8(sp)
    80003d6c:	01010413          	addi	s0,sp,16
    80003d70:	0e060863          	beqz	a2,80003e60 <__memmove+0xfc>
    80003d74:	fff6069b          	addiw	a3,a2,-1
    80003d78:	0006881b          	sext.w	a6,a3
    80003d7c:	0ea5e863          	bltu	a1,a0,80003e6c <__memmove+0x108>
    80003d80:	00758713          	addi	a4,a1,7
    80003d84:	00a5e7b3          	or	a5,a1,a0
    80003d88:	40a70733          	sub	a4,a4,a0
    80003d8c:	0077f793          	andi	a5,a5,7
    80003d90:	00f73713          	sltiu	a4,a4,15
    80003d94:	00174713          	xori	a4,a4,1
    80003d98:	0017b793          	seqz	a5,a5
    80003d9c:	00e7f7b3          	and	a5,a5,a4
    80003da0:	10078863          	beqz	a5,80003eb0 <__memmove+0x14c>
    80003da4:	00900793          	li	a5,9
    80003da8:	1107f463          	bgeu	a5,a6,80003eb0 <__memmove+0x14c>
    80003dac:	0036581b          	srliw	a6,a2,0x3
    80003db0:	fff8081b          	addiw	a6,a6,-1
    80003db4:	02081813          	slli	a6,a6,0x20
    80003db8:	01d85893          	srli	a7,a6,0x1d
    80003dbc:	00858813          	addi	a6,a1,8
    80003dc0:	00058793          	mv	a5,a1
    80003dc4:	00050713          	mv	a4,a0
    80003dc8:	01088833          	add	a6,a7,a6
    80003dcc:	0007b883          	ld	a7,0(a5)
    80003dd0:	00878793          	addi	a5,a5,8
    80003dd4:	00870713          	addi	a4,a4,8
    80003dd8:	ff173c23          	sd	a7,-8(a4)
    80003ddc:	ff0798e3          	bne	a5,a6,80003dcc <__memmove+0x68>
    80003de0:	ff867713          	andi	a4,a2,-8
    80003de4:	02071793          	slli	a5,a4,0x20
    80003de8:	0207d793          	srli	a5,a5,0x20
    80003dec:	00f585b3          	add	a1,a1,a5
    80003df0:	40e686bb          	subw	a3,a3,a4
    80003df4:	00f507b3          	add	a5,a0,a5
    80003df8:	06e60463          	beq	a2,a4,80003e60 <__memmove+0xfc>
    80003dfc:	0005c703          	lbu	a4,0(a1)
    80003e00:	00e78023          	sb	a4,0(a5)
    80003e04:	04068e63          	beqz	a3,80003e60 <__memmove+0xfc>
    80003e08:	0015c603          	lbu	a2,1(a1)
    80003e0c:	00100713          	li	a4,1
    80003e10:	00c780a3          	sb	a2,1(a5)
    80003e14:	04e68663          	beq	a3,a4,80003e60 <__memmove+0xfc>
    80003e18:	0025c603          	lbu	a2,2(a1)
    80003e1c:	00200713          	li	a4,2
    80003e20:	00c78123          	sb	a2,2(a5)
    80003e24:	02e68e63          	beq	a3,a4,80003e60 <__memmove+0xfc>
    80003e28:	0035c603          	lbu	a2,3(a1)
    80003e2c:	00300713          	li	a4,3
    80003e30:	00c781a3          	sb	a2,3(a5)
    80003e34:	02e68663          	beq	a3,a4,80003e60 <__memmove+0xfc>
    80003e38:	0045c603          	lbu	a2,4(a1)
    80003e3c:	00400713          	li	a4,4
    80003e40:	00c78223          	sb	a2,4(a5)
    80003e44:	00e68e63          	beq	a3,a4,80003e60 <__memmove+0xfc>
    80003e48:	0055c603          	lbu	a2,5(a1)
    80003e4c:	00500713          	li	a4,5
    80003e50:	00c782a3          	sb	a2,5(a5)
    80003e54:	00e68663          	beq	a3,a4,80003e60 <__memmove+0xfc>
    80003e58:	0065c703          	lbu	a4,6(a1)
    80003e5c:	00e78323          	sb	a4,6(a5)
    80003e60:	00813403          	ld	s0,8(sp)
    80003e64:	01010113          	addi	sp,sp,16
    80003e68:	00008067          	ret
    80003e6c:	02061713          	slli	a4,a2,0x20
    80003e70:	02075713          	srli	a4,a4,0x20
    80003e74:	00e587b3          	add	a5,a1,a4
    80003e78:	f0f574e3          	bgeu	a0,a5,80003d80 <__memmove+0x1c>
    80003e7c:	02069613          	slli	a2,a3,0x20
    80003e80:	02065613          	srli	a2,a2,0x20
    80003e84:	fff64613          	not	a2,a2
    80003e88:	00e50733          	add	a4,a0,a4
    80003e8c:	00c78633          	add	a2,a5,a2
    80003e90:	fff7c683          	lbu	a3,-1(a5)
    80003e94:	fff78793          	addi	a5,a5,-1
    80003e98:	fff70713          	addi	a4,a4,-1
    80003e9c:	00d70023          	sb	a3,0(a4)
    80003ea0:	fec798e3          	bne	a5,a2,80003e90 <__memmove+0x12c>
    80003ea4:	00813403          	ld	s0,8(sp)
    80003ea8:	01010113          	addi	sp,sp,16
    80003eac:	00008067          	ret
    80003eb0:	02069713          	slli	a4,a3,0x20
    80003eb4:	02075713          	srli	a4,a4,0x20
    80003eb8:	00170713          	addi	a4,a4,1
    80003ebc:	00e50733          	add	a4,a0,a4
    80003ec0:	00050793          	mv	a5,a0
    80003ec4:	0005c683          	lbu	a3,0(a1)
    80003ec8:	00178793          	addi	a5,a5,1
    80003ecc:	00158593          	addi	a1,a1,1
    80003ed0:	fed78fa3          	sb	a3,-1(a5)
    80003ed4:	fee798e3          	bne	a5,a4,80003ec4 <__memmove+0x160>
    80003ed8:	f89ff06f          	j	80003e60 <__memmove+0xfc>
	...
