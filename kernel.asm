
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00006117          	auipc	sp,0x6
    80000004:	90013103          	ld	sp,-1792(sp) # 80005900 <_GLOBAL_OFFSET_TABLE_+0x10>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	0a0020ef          	jal	ra,800020bc <start>

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
    addi sp, sp, -16
    80001030:	ff010113          	addi	sp,sp,-16
    sd t0, 8(sp)
    80001034:	00513423          	sd	t0,8(sp)
    addi t0, sp, 0
    80001038:	00010293          	mv	t0,sp

    csrr sp, sscratch
    8000103c:	14002173          	csrr	sp,sscratch
    addi sp, sp, -256
    80001040:	f0010113          	addi	sp,sp,-256

    sd x0, 0 * 8(sp)
    80001044:	00013023          	sd	zero,0(sp)
    sd x1, 1 * 8(sp)
    80001048:	00113423          	sd	ra,8(sp)
    sd t0, 2 * 8(sp)
    8000104c:	00513823          	sd	t0,16(sp)
    .irp index,  3, 4, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31
    sd x\index, \index * 8(sp)
    .endr
    80001050:	00313c23          	sd	gp,24(sp)
    80001054:	02413023          	sd	tp,32(sp)
    80001058:	02613823          	sd	t1,48(sp)
    8000105c:	02713c23          	sd	t2,56(sp)
    80001060:	04813023          	sd	s0,64(sp)
    80001064:	04913423          	sd	s1,72(sp)
    80001068:	04a13823          	sd	a0,80(sp)
    8000106c:	04b13c23          	sd	a1,88(sp)
    80001070:	06c13023          	sd	a2,96(sp)
    80001074:	06d13423          	sd	a3,104(sp)
    80001078:	06e13823          	sd	a4,112(sp)
    8000107c:	06f13c23          	sd	a5,120(sp)
    80001080:	09013023          	sd	a6,128(sp)
    80001084:	09113423          	sd	a7,136(sp)
    80001088:	09213823          	sd	s2,144(sp)
    8000108c:	09313c23          	sd	s3,152(sp)
    80001090:	0b413023          	sd	s4,160(sp)
    80001094:	0b513423          	sd	s5,168(sp)
    80001098:	0b613823          	sd	s6,176(sp)
    8000109c:	0b713c23          	sd	s7,184(sp)
    800010a0:	0d813023          	sd	s8,192(sp)
    800010a4:	0d913423          	sd	s9,200(sp)
    800010a8:	0da13823          	sd	s10,208(sp)
    800010ac:	0db13c23          	sd	s11,216(sp)
    800010b0:	0fc13023          	sd	t3,224(sp)
    800010b4:	0fd13423          	sd	t4,232(sp)
    800010b8:	0fe13823          	sd	t5,240(sp)
    800010bc:	0ff13c23          	sd	t6,248(sp)
    ld t0, 8(t0)
    800010c0:	0082b283          	ld	t0,8(t0)
    sd t0, 5 * 8(sp)
    800010c4:	02513423          	sd	t0,40(sp)

    addi s0, sp, 0
    800010c8:	00010413          	mv	s0,sp
    auipc t0, 0
    800010cc:	00000297          	auipc	t0,0x0
    addi t0, t0, 16
    800010d0:	01028293          	addi	t0,t0,16 # 800010dc <interrupt_trap+0xac>
    csrw sscratch, t0
    800010d4:	14029073          	csrw	sscratch,t0

    call _ZN6Kernel16interruptHandlerEv
    800010d8:	2f1000ef          	jal	ra,80001bc8 <_ZN6Kernel16interruptHandlerEv>

    ld x0, 0 * 8(sp)
    800010dc:	00013003          	ld	zero,0(sp)
    ld x1, 1 * 8(sp)
    800010e0:	00813083          	ld	ra,8(sp)
    ld t0, 2 * 8(sp)
    800010e4:	01013283          	ld	t0,16(sp)
    .irp index,  3, 4, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31
    sd x\index, \index * 8(sp)
    .endr
    800010e8:	00313c23          	sd	gp,24(sp)
    800010ec:	02413023          	sd	tp,32(sp)
    800010f0:	02613823          	sd	t1,48(sp)
    800010f4:	02713c23          	sd	t2,56(sp)
    800010f8:	04813023          	sd	s0,64(sp)
    800010fc:	04913423          	sd	s1,72(sp)
    80001100:	04a13823          	sd	a0,80(sp)
    80001104:	04b13c23          	sd	a1,88(sp)
    80001108:	06c13023          	sd	a2,96(sp)
    8000110c:	06d13423          	sd	a3,104(sp)
    80001110:	06e13823          	sd	a4,112(sp)
    80001114:	06f13c23          	sd	a5,120(sp)
    80001118:	09013023          	sd	a6,128(sp)
    8000111c:	09113423          	sd	a7,136(sp)
    80001120:	09213823          	sd	s2,144(sp)
    80001124:	09313c23          	sd	s3,152(sp)
    80001128:	0b413023          	sd	s4,160(sp)
    8000112c:	0b513423          	sd	s5,168(sp)
    80001130:	0b613823          	sd	s6,176(sp)
    80001134:	0b713c23          	sd	s7,184(sp)
    80001138:	0d813023          	sd	s8,192(sp)
    8000113c:	0d913423          	sd	s9,200(sp)
    80001140:	0da13823          	sd	s10,208(sp)
    80001144:	0db13c23          	sd	s11,216(sp)
    80001148:	0fc13023          	sd	t3,224(sp)
    8000114c:	0fd13423          	sd	t4,232(sp)
    80001150:	0fe13823          	sd	t5,240(sp)
    80001154:	0ff13c23          	sd	t6,248(sp)

    addi sp, sp, 256
    80001158:	10010113          	addi	sp,sp,256
    csrw sscratch, sp
    8000115c:	14011073          	csrw	sscratch,sp

    addi sp, t0, 0
    80001160:	00028113          	mv	sp,t0
    ld t0, 8(sp)
    80001164:	00813283          	ld	t0,8(sp)
    addi sp, sp, 16
    80001168:	01010113          	addi	sp,sp,16
    8000116c:	10200073          	sret

0000000080001170 <context_switch>:
.global context_switch
.type context_switch, @function
context_switch:
    sd ra, 0 * 8(a0)
    80001170:	00153023          	sd	ra,0(a0) # 1000 <_entry-0x7ffff000>
    sd sp, 1 * 8(a0)
    80001174:	00253423          	sd	sp,8(a0)

    ld ra, 0 * 8(a1)
    80001178:	0005b083          	ld	ra,0(a1)
    ld sp, 1 * 8(a1)
    8000117c:	0085b103          	ld	sp,8(a1)
    80001180:	00008067          	ret

0000000080001184 <_Z9mem_allocm>:


extern "C" uint64 system_call(Arguments* arg);

void* mem_alloc(size_t size)
{
    80001184:	fa010113          	addi	sp,sp,-96
    80001188:	04113c23          	sd	ra,88(sp)
    8000118c:	04813823          	sd	s0,80(sp)
    80001190:	04913423          	sd	s1,72(sp)
    80001194:	05213023          	sd	s2,64(sp)
    80001198:	06010413          	addi	s0,sp,96
    8000119c:	00050493          	mv	s1,a0
    uint64 size_of_blocks = (size + MemoryAllocator::getSizeOfMetaData()) / MEM_BLOCK_SIZE;
    800011a0:	00001097          	auipc	ra,0x1
    800011a4:	8e8080e7          	jalr	-1816(ra) # 80001a88 <_ZN15MemoryAllocator17getSizeOfMetaDataEv>
    800011a8:	00950933          	add	s2,a0,s1
    800011ac:	00695913          	srli	s2,s2,0x6
    size_of_blocks += (size + MemoryAllocator::getSizeOfMetaData()) % MEM_BLOCK_SIZE ? 1: 0;
    800011b0:	00001097          	auipc	ra,0x1
    800011b4:	8d8080e7          	jalr	-1832(ra) # 80001a88 <_ZN15MemoryAllocator17getSizeOfMetaDataEv>
    800011b8:	00a484b3          	add	s1,s1,a0
    800011bc:	03f4f493          	andi	s1,s1,63
    800011c0:	04048a63          	beqz	s1,80001214 <_Z9mem_allocm+0x90>
    800011c4:	00100513          	li	a0,1
    800011c8:	01250933          	add	s2,a0,s2
    Arguments arg = {KernelConfig::MEM_ALLOC, size_of_blocks, 0, 0, 0, 0, 0, 0};
    800011cc:	fa043823          	sd	zero,-80(s0)
    800011d0:	fa043c23          	sd	zero,-72(s0)
    800011d4:	fc043023          	sd	zero,-64(s0)
    800011d8:	fc043423          	sd	zero,-56(s0)
    800011dc:	fc043823          	sd	zero,-48(s0)
    800011e0:	fc043c23          	sd	zero,-40(s0)
    800011e4:	00100793          	li	a5,1
    800011e8:	faf43023          	sd	a5,-96(s0)
    800011ec:	fb243423          	sd	s2,-88(s0)
    return (void*) system_call(&arg);
    800011f0:	fa040513          	addi	a0,s0,-96
    800011f4:	00000097          	auipc	ra,0x0
    800011f8:	e0c080e7          	jalr	-500(ra) # 80001000 <system_call>
}
    800011fc:	05813083          	ld	ra,88(sp)
    80001200:	05013403          	ld	s0,80(sp)
    80001204:	04813483          	ld	s1,72(sp)
    80001208:	04013903          	ld	s2,64(sp)
    8000120c:	06010113          	addi	sp,sp,96
    80001210:	00008067          	ret
    size_of_blocks += (size + MemoryAllocator::getSizeOfMetaData()) % MEM_BLOCK_SIZE ? 1: 0;
    80001214:	00000513          	li	a0,0
    80001218:	fb1ff06f          	j	800011c8 <_Z9mem_allocm+0x44>

000000008000121c <_Z8mem_freePv>:

int mem_free(void* obj)
{   Arguments arg = {KernelConfig::MEM_FREE, (uint64)obj, 0, 0, 0, 0, 0, 0};
    8000121c:	fb010113          	addi	sp,sp,-80
    80001220:	04113423          	sd	ra,72(sp)
    80001224:	04813023          	sd	s0,64(sp)
    80001228:	05010413          	addi	s0,sp,80
    8000122c:	fc043023          	sd	zero,-64(s0)
    80001230:	fc043423          	sd	zero,-56(s0)
    80001234:	fc043823          	sd	zero,-48(s0)
    80001238:	fc043c23          	sd	zero,-40(s0)
    8000123c:	fe043023          	sd	zero,-32(s0)
    80001240:	fe043423          	sd	zero,-24(s0)
    80001244:	00200793          	li	a5,2
    80001248:	faf43823          	sd	a5,-80(s0)
    8000124c:	faa43c23          	sd	a0,-72(s0)
    return (int) system_call(&arg);
    80001250:	fb040513          	addi	a0,s0,-80
    80001254:	00000097          	auipc	ra,0x0
    80001258:	dac080e7          	jalr	-596(ra) # 80001000 <system_call>
}
    8000125c:	0005051b          	sext.w	a0,a0
    80001260:	04813083          	ld	ra,72(sp)
    80001264:	04013403          	ld	s0,64(sp)
    80001268:	05010113          	addi	sp,sp,80
    8000126c:	00008067          	ret

0000000080001270 <_Z18mem_get_free_spacev>:

size_t mem_get_free_space()
{
    80001270:	fb010113          	addi	sp,sp,-80
    80001274:	04113423          	sd	ra,72(sp)
    80001278:	04813023          	sd	s0,64(sp)
    8000127c:	05010413          	addi	s0,sp,80
    Arguments arg = {KernelConfig::MEM_FREE_SPACE, 0, 0, 0, 0, 0, 0, 0};
    80001280:	00300793          	li	a5,3
    80001284:	faf43823          	sd	a5,-80(s0)
    80001288:	fa043c23          	sd	zero,-72(s0)
    8000128c:	fc043023          	sd	zero,-64(s0)
    80001290:	fc043423          	sd	zero,-56(s0)
    80001294:	fc043823          	sd	zero,-48(s0)
    80001298:	fc043c23          	sd	zero,-40(s0)
    8000129c:	fe043023          	sd	zero,-32(s0)
    800012a0:	fe043423          	sd	zero,-24(s0)
    return (size_t) system_call(&arg);
    800012a4:	fb040513          	addi	a0,s0,-80
    800012a8:	00000097          	auipc	ra,0x0
    800012ac:	d58080e7          	jalr	-680(ra) # 80001000 <system_call>
}
    800012b0:	04813083          	ld	ra,72(sp)
    800012b4:	04013403          	ld	s0,64(sp)
    800012b8:	05010113          	addi	sp,sp,80
    800012bc:	00008067          	ret

00000000800012c0 <_Z26mem_get_largest_free_blockv>:
size_t mem_get_largest_free_block()
{
    800012c0:	fb010113          	addi	sp,sp,-80
    800012c4:	04113423          	sd	ra,72(sp)
    800012c8:	04813023          	sd	s0,64(sp)
    800012cc:	05010413          	addi	s0,sp,80
    Arguments arg = {KernelConfig::LARGEST_FREE_BLOCK, 0, 0, 0, 0, 0, 0, 0};
    800012d0:	00400793          	li	a5,4
    800012d4:	faf43823          	sd	a5,-80(s0)
    800012d8:	fa043c23          	sd	zero,-72(s0)
    800012dc:	fc043023          	sd	zero,-64(s0)
    800012e0:	fc043423          	sd	zero,-56(s0)
    800012e4:	fc043823          	sd	zero,-48(s0)
    800012e8:	fc043c23          	sd	zero,-40(s0)
    800012ec:	fe043023          	sd	zero,-32(s0)
    800012f0:	fe043423          	sd	zero,-24(s0)
    return (size_t) system_call(&arg);
    800012f4:	fb040513          	addi	a0,s0,-80
    800012f8:	00000097          	auipc	ra,0x0
    800012fc:	d08080e7          	jalr	-760(ra) # 80001000 <system_call>
}
    80001300:	04813083          	ld	ra,72(sp)
    80001304:	04013403          	ld	s0,64(sp)
    80001308:	05010113          	addi	sp,sp,80
    8000130c:	00008067          	ret

0000000080001310 <_Z13thread_createPP3TCBPFvPvES2_>:

int thread_create(thread_t* handle, void(*start_routine)(void*), void* argOfRoutine)
{
    80001310:	f9010113          	addi	sp,sp,-112
    80001314:	06113423          	sd	ra,104(sp)
    80001318:	06813023          	sd	s0,96(sp)
    8000131c:	04913c23          	sd	s1,88(sp)
    80001320:	05213823          	sd	s2,80(sp)
    80001324:	05313423          	sd	s3,72(sp)
    80001328:	07010413          	addi	s0,sp,112
    8000132c:	00050993          	mv	s3,a0
    80001330:	00058913          	mv	s2,a1
    80001334:	00060493          	mv	s1,a2
    uint8* threadStack = (uint8*)mem_alloc(DEFAULT_STACK_SIZE);
    80001338:	00001537          	lui	a0,0x1
    8000133c:	00000097          	auipc	ra,0x0
    80001340:	e48080e7          	jalr	-440(ra) # 80001184 <_Z9mem_allocm>
    if(threadStack == nullptr)
    80001344:	04050e63          	beqz	a0,800013a0 <_Z13thread_createPP3TCBPFvPvES2_+0x90>
    {
        return -1;
    }

    Arguments arg = {(uint64)KernelConfig::THREAD_CREATE, (uint64)handle, (uint64)start_routine, (uint64)argOfRoutine, (uint64)(&threadStack[DEFAULT_STACK_SIZE]), 0, 0, 0};
    80001348:	fa043c23          	sd	zero,-72(s0)
    8000134c:	fc043023          	sd	zero,-64(s0)
    80001350:	fc043423          	sd	zero,-56(s0)
    80001354:	01100793          	li	a5,17
    80001358:	f8f43823          	sd	a5,-112(s0)
    8000135c:	f9343c23          	sd	s3,-104(s0)
    80001360:	fb243023          	sd	s2,-96(s0)
    80001364:	fa943423          	sd	s1,-88(s0)
    80001368:	000017b7          	lui	a5,0x1
    8000136c:	00f50533          	add	a0,a0,a5
    80001370:	faa43823          	sd	a0,-80(s0)

    return (int) system_call(&arg);
    80001374:	f9040513          	addi	a0,s0,-112
    80001378:	00000097          	auipc	ra,0x0
    8000137c:	c88080e7          	jalr	-888(ra) # 80001000 <system_call>
    80001380:	0005051b          	sext.w	a0,a0
}
    80001384:	06813083          	ld	ra,104(sp)
    80001388:	06013403          	ld	s0,96(sp)
    8000138c:	05813483          	ld	s1,88(sp)
    80001390:	05013903          	ld	s2,80(sp)
    80001394:	04813983          	ld	s3,72(sp)
    80001398:	07010113          	addi	sp,sp,112
    8000139c:	00008067          	ret
        return -1;
    800013a0:	fff00513          	li	a0,-1
    800013a4:	fe1ff06f          	j	80001384 <_Z13thread_createPP3TCBPFvPvES2_+0x74>

00000000800013a8 <_Z15thread_dispatchv>:

void thread_dispatch()
{
    800013a8:	fb010113          	addi	sp,sp,-80
    800013ac:	04113423          	sd	ra,72(sp)
    800013b0:	04813023          	sd	s0,64(sp)
    800013b4:	05010413          	addi	s0,sp,80
    Arguments arg = {KernelConfig::THREAD_DISPATCH, 0, 0, 0, 0, 0, 0, 0};
    800013b8:	01300793          	li	a5,19
    800013bc:	faf43823          	sd	a5,-80(s0)
    800013c0:	fa043c23          	sd	zero,-72(s0)
    800013c4:	fc043023          	sd	zero,-64(s0)
    800013c8:	fc043423          	sd	zero,-56(s0)
    800013cc:	fc043823          	sd	zero,-48(s0)
    800013d0:	fc043c23          	sd	zero,-40(s0)
    800013d4:	fe043023          	sd	zero,-32(s0)
    800013d8:	fe043423          	sd	zero,-24(s0)
    system_call(&arg);
    800013dc:	fb040513          	addi	a0,s0,-80
    800013e0:	00000097          	auipc	ra,0x0
    800013e4:	c20080e7          	jalr	-992(ra) # 80001000 <system_call>
}
    800013e8:	04813083          	ld	ra,72(sp)
    800013ec:	04013403          	ld	s0,64(sp)
    800013f0:	05010113          	addi	sp,sp,80
    800013f4:	00008067          	ret

00000000800013f8 <_Z11thread_exitv>:

int thread_exit()
{
    800013f8:	fb010113          	addi	sp,sp,-80
    800013fc:	04113423          	sd	ra,72(sp)
    80001400:	04813023          	sd	s0,64(sp)
    80001404:	05010413          	addi	s0,sp,80
    Arguments arg = {KernelConfig::THREAD_EXIT, 0, 0, 0, 0, 0, 0, 0};
    80001408:	01200793          	li	a5,18
    8000140c:	faf43823          	sd	a5,-80(s0)
    80001410:	fa043c23          	sd	zero,-72(s0)
    80001414:	fc043023          	sd	zero,-64(s0)
    80001418:	fc043423          	sd	zero,-56(s0)
    8000141c:	fc043823          	sd	zero,-48(s0)
    80001420:	fc043c23          	sd	zero,-40(s0)
    80001424:	fe043023          	sd	zero,-32(s0)
    80001428:	fe043423          	sd	zero,-24(s0)
    return (int) system_call(&arg);
    8000142c:	fb040513          	addi	a0,s0,-80
    80001430:	00000097          	auipc	ra,0x0
    80001434:	bd0080e7          	jalr	-1072(ra) # 80001000 <system_call>
    80001438:	0005051b          	sext.w	a0,a0
    8000143c:	04813083          	ld	ra,72(sp)
    80001440:	04013403          	ld	s0,64(sp)
    80001444:	05010113          	addi	sp,sp,80
    80001448:	00008067          	ret

000000008000144c <_ZN9Scheduler3putEP3TCB>:
#include "../h/TCB.hpp"
TCB* Scheduler::firstReadyThread = nullptr;
TCB* Scheduler::lastReadyThread = nullptr;

void Scheduler::put(TCB *readyThread)
{
    8000144c:	ff010113          	addi	sp,sp,-16
    80001450:	00813423          	sd	s0,8(sp)
    80001454:	01010413          	addi	s0,sp,16
    if(!firstReadyThread)
    80001458:	00004797          	auipc	a5,0x4
    8000145c:	5187b783          	ld	a5,1304(a5) # 80005970 <_ZN9Scheduler16firstReadyThreadE>
    80001460:	02078263          	beqz	a5,80001484 <_ZN9Scheduler3putEP3TCB+0x38>
    {
        firstReadyThread = readyThread;
    }
    else
    {
        lastReadyThread->state = readyThread;
    80001464:	00004797          	auipc	a5,0x4
    80001468:	5147b783          	ld	a5,1300(a5) # 80005978 <_ZN9Scheduler15lastReadyThreadE>
    8000146c:	02a7b823          	sd	a0,48(a5)
    }
    lastReadyThread = readyThread;
    80001470:	00004797          	auipc	a5,0x4
    80001474:	50a7b423          	sd	a0,1288(a5) # 80005978 <_ZN9Scheduler15lastReadyThreadE>
}
    80001478:	00813403          	ld	s0,8(sp)
    8000147c:	01010113          	addi	sp,sp,16
    80001480:	00008067          	ret
        firstReadyThread = readyThread;
    80001484:	00004797          	auipc	a5,0x4
    80001488:	4ea7b623          	sd	a0,1260(a5) # 80005970 <_ZN9Scheduler16firstReadyThreadE>
    8000148c:	fe5ff06f          	j	80001470 <_ZN9Scheduler3putEP3TCB+0x24>

0000000080001490 <_ZN9Scheduler3getEv>:
TCB* Scheduler::get(void)
{
    80001490:	ff010113          	addi	sp,sp,-16
    80001494:	00813423          	sd	s0,8(sp)
    80001498:	01010413          	addi	s0,sp,16
    if(!firstReadyThread)
    8000149c:	00004517          	auipc	a0,0x4
    800014a0:	4d453503          	ld	a0,1236(a0) # 80005970 <_ZN9Scheduler16firstReadyThreadE>
    800014a4:	00050463          	beqz	a0,800014ac <_ZN9Scheduler3getEv+0x1c>
    {
        return nullptr;
    }
    TCB* newThread = firstReadyThread;
    firstReadyThread->state = firstReadyThread;
    newThread->state = nullptr;
    800014a8:	02053823          	sd	zero,48(a0)
    return newThread;
    800014ac:	00813403          	ld	s0,8(sp)
    800014b0:	01010113          	addi	sp,sp,16
    800014b4:	00008067          	ret

00000000800014b8 <main>:
// Created by os on 11/29/25.
//
#include "../h/MemoryAllocator.hpp"
#include "../h/Kernel.hpp"
#include "../h/syscall_c.hpp"
void main(){
    800014b8:	ff010113          	addi	sp,sp,-16
    800014bc:	00813423          	sd	s0,8(sp)
    800014c0:	01010413          	addi	s0,sp,16
////    __asm__ volatile ("ecall");
//    void* allocMem1 = mem_alloc(100);
//    mem_free(allocMem1);
//    void* allocMem2 = mem_alloc(10);
//    mem_free(allocMem2);
    800014c4:	00813403          	ld	s0,8(sp)
    800014c8:	01010113          	addi	sp,sp,16
    800014cc:	00008067          	ret

00000000800014d0 <_ZN3TCB13threadWrapperEv>:
    context = {Machine::readSscratch(), (uint64)(&systemStack[numOfElements]) - 256};
    Machine::writeSepc((uint64)&threadWrapper);
    Scheduler::put(this);
}
void TCB::threadWrapper()
{
    800014d0:	ff010113          	addi	sp,sp,-16
    800014d4:	00113423          	sd	ra,8(sp)
    800014d8:	00813023          	sd	s0,0(sp)
    800014dc:	01010413          	addi	s0,sp,16
    running->body(running->arguments);
    800014e0:	00004797          	auipc	a5,0x4
    800014e4:	4a07b783          	ld	a5,1184(a5) # 80005980 <_ZN3TCB7runningE>
    800014e8:	0007b703          	ld	a4,0(a5)
    800014ec:	0287b503          	ld	a0,40(a5)
    800014f0:	000700e7          	jalr	a4
    thread_exit();
    800014f4:	00000097          	auipc	ra,0x0
    800014f8:	f04080e7          	jalr	-252(ra) # 800013f8 <_Z11thread_exitv>

}
    800014fc:	00813083          	ld	ra,8(sp)
    80001500:	00013403          	ld	s0,0(sp)
    80001504:	01010113          	addi	sp,sp,16
    80001508:	00008067          	ret

000000008000150c <_ZN3TCB16initializeThreadEPFvPvES0_S0_>:
{
    8000150c:	fe010113          	addi	sp,sp,-32
    80001510:	00113c23          	sd	ra,24(sp)
    80001514:	00813823          	sd	s0,16(sp)
    80001518:	00913423          	sd	s1,8(sp)
    8000151c:	01213023          	sd	s2,0(sp)
    80001520:	02010413          	addi	s0,sp,32
    80001524:	00050493          	mv	s1,a0
    80001528:	00068913          	mv	s2,a3
    body = function;
    8000152c:	00b53023          	sd	a1,0(a0)
    timeSlice = DEFAULT_TIME_SLICE;
    80001530:	00200793          	li	a5,2
    80001534:	00f53c23          	sd	a5,24(a0)
    state = nullptr;
    80001538:	02053823          	sd	zero,48(a0)
    isFinished = false;
    8000153c:	02050c23          	sb	zero,56(a0)
    arguments = arg;
    80001540:	02c53423          	sd	a2,40(a0)
    systemStack = (uint64*)MemoryAllocator::allocateMemory(sizeOfStack);
    80001544:	00900513          	li	a0,9
    80001548:	00000097          	auipc	ra,0x0
    8000154c:	294080e7          	jalr	660(ra) # 800017dc <_ZN15MemoryAllocator14allocateMemoryEm>
    80001550:	02a4b023          	sd	a0,32(s1)
    systemStack[numOfElements - 30] = (uint64)allocatedStack;
    80001554:	11253823          	sd	s2,272(a0)
    __asm__ volatile ("csrc sip, %[reg]":: [reg] "r"(mask));
}
inline uint64 Machine::readSscratch()
{
    uint64 returnValue;
    __asm__ volatile ("csrr %[reg], sscratch": [reg] "=r"(returnValue));
    80001558:	14002773          	csrr	a4,sscratch
    context = {Machine::readSscratch(), (uint64)(&systemStack[numOfElements]) - 256};
    8000155c:	0204b783          	ld	a5,32(s1)
    80001560:	10078793          	addi	a5,a5,256
    80001564:	00e4b423          	sd	a4,8(s1)
    80001568:	00f4b823          	sd	a5,16(s1)
    Machine::writeSepc((uint64)&threadWrapper);
    8000156c:	00000797          	auipc	a5,0x0
    80001570:	f6478793          	addi	a5,a5,-156 # 800014d0 <_ZN3TCB13threadWrapperEv>
    return returnValue;
}
inline void Machine::writeSepc(uint64 address)
{
    __asm__ volatile("csrw sepc, %[reg]":: [reg] "r"(address));
    80001574:	14179073          	csrw	sepc,a5
    Scheduler::put(this);
    80001578:	00048513          	mv	a0,s1
    8000157c:	00000097          	auipc	ra,0x0
    80001580:	ed0080e7          	jalr	-304(ra) # 8000144c <_ZN9Scheduler3putEP3TCB>
}
    80001584:	01813083          	ld	ra,24(sp)
    80001588:	01013403          	ld	s0,16(sp)
    8000158c:	00813483          	ld	s1,8(sp)
    80001590:	00013903          	ld	s2,0(sp)
    80001594:	02010113          	addi	sp,sp,32
    80001598:	00008067          	ret

000000008000159c <_ZN3TCB5yieldEPS_S0_>:
void TCB::yield(TCB *oldThread, TCB *newThread)
{
    8000159c:	ff010113          	addi	sp,sp,-16
    800015a0:	00113423          	sd	ra,8(sp)
    800015a4:	00813023          	sd	s0,0(sp)
    800015a8:	01010413          	addi	s0,sp,16
    context_switch(&(oldThread->context), &(newThread->context));
    800015ac:	00858593          	addi	a1,a1,8
    800015b0:	00850513          	addi	a0,a0,8
    800015b4:	00000097          	auipc	ra,0x0
    800015b8:	bbc080e7          	jalr	-1092(ra) # 80001170 <context_switch>
}
    800015bc:	00813083          	ld	ra,8(sp)
    800015c0:	00013403          	ld	s0,0(sp)
    800015c4:	01010113          	addi	sp,sp,16
    800015c8:	00008067          	ret

00000000800015cc <_ZN3TCB8dispatchEv>:

void TCB::dispatch()
{
    800015cc:	fe010113          	addi	sp,sp,-32
    800015d0:	00113c23          	sd	ra,24(sp)
    800015d4:	00813823          	sd	s0,16(sp)
    800015d8:	00913423          	sd	s1,8(sp)
    800015dc:	02010413          	addi	s0,sp,32
    TCB* oldThread = running;
    800015e0:	00004497          	auipc	s1,0x4
    800015e4:	3a04b483          	ld	s1,928(s1) # 80005980 <_ZN3TCB7runningE>
    if(!oldThread->isFinished)
    800015e8:	0384c783          	lbu	a5,56(s1)
    800015ec:	02078c63          	beqz	a5,80001624 <_ZN3TCB8dispatchEv+0x58>
    {
        Scheduler::put(oldThread);
    }
    running = Scheduler::get();
    800015f0:	00000097          	auipc	ra,0x0
    800015f4:	ea0080e7          	jalr	-352(ra) # 80001490 <_ZN9Scheduler3getEv>
    800015f8:	00050593          	mv	a1,a0
    800015fc:	00004797          	auipc	a5,0x4
    80001600:	38a7b223          	sd	a0,900(a5) # 80005980 <_ZN3TCB7runningE>
    yield(oldThread, running);
    80001604:	00048513          	mv	a0,s1
    80001608:	00000097          	auipc	ra,0x0
    8000160c:	f94080e7          	jalr	-108(ra) # 8000159c <_ZN3TCB5yieldEPS_S0_>
    80001610:	01813083          	ld	ra,24(sp)
    80001614:	01013403          	ld	s0,16(sp)
    80001618:	00813483          	ld	s1,8(sp)
    8000161c:	02010113          	addi	sp,sp,32
    80001620:	00008067          	ret
        Scheduler::put(oldThread);
    80001624:	00048513          	mv	a0,s1
    80001628:	00000097          	auipc	ra,0x0
    8000162c:	e24080e7          	jalr	-476(ra) # 8000144c <_ZN9Scheduler3putEP3TCB>
    80001630:	fc1ff06f          	j	800015f0 <_ZN3TCB8dispatchEv+0x24>

0000000080001634 <_ZN15MemoryAllocator16initializeMemoryEv>:
size_t MemoryAllocator::NUM_OF_BLOCKS = 0;
size_t MemoryAllocator::numOfFreeBlocks = 0;
MemoryAllocator::FreeBlock* MemoryAllocator::firstFreeBlock = nullptr;

void MemoryAllocator::initializeMemory()
{
    80001634:	ff010113          	addi	sp,sp,-16
    80001638:	00813423          	sd	s0,8(sp)
    8000163c:	01010413          	addi	s0,sp,16

    NUM_OF_BLOCKS = ((uint8*)HEAP_END_ADDR - (uint8*)HEAP_START_ADDR) / MEM_BLOCK_SIZE;
    80001640:	00004797          	auipc	a5,0x4
    80001644:	2d87b783          	ld	a5,728(a5) # 80005918 <_GLOBAL_OFFSET_TABLE_+0x28>
    80001648:	0007b703          	ld	a4,0(a5)
    8000164c:	00004797          	auipc	a5,0x4
    80001650:	2ac7b783          	ld	a5,684(a5) # 800058f8 <_GLOBAL_OFFSET_TABLE_+0x8>
    80001654:	0007b683          	ld	a3,0(a5)
    80001658:	40d70733          	sub	a4,a4,a3
    8000165c:	00675713          	srli	a4,a4,0x6
    80001660:	00004797          	auipc	a5,0x4
    80001664:	33078793          	addi	a5,a5,816 # 80005990 <_ZN15MemoryAllocator13NUM_OF_BLOCKSE>
    80001668:	00e7b023          	sd	a4,0(a5)
    numOfFreeBlocks = NUM_OF_BLOCKS;
    8000166c:	00e7b423          	sd	a4,8(a5)

    firstFreeBlock = (FreeBlock*)(HEAP_START_ADDR);
    80001670:	00d7b823          	sd	a3,16(a5)

    firstFreeBlock->flagFree = true;
    80001674:	00100613          	li	a2,1
    80001678:	00c68023          	sb	a2,0(a3)
    firstFreeBlock->numOfBlocks = NUM_OF_BLOCKS;
    8000167c:	0107b703          	ld	a4,16(a5)
    80001680:	0007b683          	ld	a3,0(a5)
    80001684:	00d73423          	sd	a3,8(a4)
    firstFreeBlock->nextBlock = nullptr;
    80001688:	00073823          	sd	zero,16(a4)
    firstFreeBlock->previousBlock = nullptr;
    8000168c:	00073c23          	sd	zero,24(a4)
    flagSystemInitialize = 1;
    80001690:	00c78c23          	sb	a2,24(a5)
}
    80001694:	00813403          	ld	s0,8(sp)
    80001698:	01010113          	addi	sp,sp,16
    8000169c:	00008067          	ret

00000000800016a0 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m>:
    occupiedBlock++;
    return occupiedBlock;
}

void MemoryAllocator::remapMemory(FreeBlock **head, FreeBlock *allocatedBlocks, size_t blocksToAllocate)
{
    800016a0:	ff010113          	addi	sp,sp,-16
    800016a4:	00813423          	sd	s0,8(sp)
    800016a8:	01010413          	addi	s0,sp,16

    if(allocatedBlocks->numOfBlocks == 0)
    800016ac:	0085b783          	ld	a5,8(a1)
    800016b0:	04079263          	bnez	a5,800016f4 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x54>
    {

        if(allocatedBlocks->previousBlock)
    800016b4:	0185b783          	ld	a5,24(a1)
    800016b8:	00078663          	beqz	a5,800016c4 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x24>
        {
            allocatedBlocks->previousBlock->nextBlock = allocatedBlocks->nextBlock;
    800016bc:	0105b703          	ld	a4,16(a1)
    800016c0:	00e7b823          	sd	a4,16(a5)
        }

        if(allocatedBlocks->nextBlock)
    800016c4:	0105b783          	ld	a5,16(a1)
    800016c8:	00078663          	beqz	a5,800016d4 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x34>
        {
            allocatedBlocks->nextBlock->previousBlock = allocatedBlocks->previousBlock;
    800016cc:	0185b703          	ld	a4,24(a1)
    800016d0:	00e7bc23          	sd	a4,24(a5)
        }

        if(*head == allocatedBlocks)
    800016d4:	00053783          	ld	a5,0(a0)
    800016d8:	00b78863          	beq	a5,a1,800016e8 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x48>
        {
            *head = newFreeBlock;
        }
    }

}
    800016dc:	00813403          	ld	s0,8(sp)
    800016e0:	01010113          	addi	sp,sp,16
    800016e4:	00008067          	ret
            *head = allocatedBlocks->nextBlock;
    800016e8:	0105b783          	ld	a5,16(a1)
    800016ec:	00f53023          	sd	a5,0(a0)
    800016f0:	fedff06f          	j	800016dc <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x3c>
        FreeBlock* newFreeBlock = (FreeBlock*)((uint8*)allocatedBlocks + blocksToAllocate * MEM_BLOCK_SIZE);
    800016f4:	00661613          	slli	a2,a2,0x6
    800016f8:	00c58633          	add	a2,a1,a2
        newFreeBlock->flagFree = true;
    800016fc:	00100793          	li	a5,1
    80001700:	00f60023          	sb	a5,0(a2)
        newFreeBlock->numOfBlocks = allocatedBlocks->numOfBlocks;
    80001704:	0085b783          	ld	a5,8(a1)
    80001708:	00f63423          	sd	a5,8(a2)
        if(allocatedBlocks->previousBlock)
    8000170c:	0185b783          	ld	a5,24(a1)
    80001710:	00078463          	beqz	a5,80001718 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x78>
            allocatedBlocks->previousBlock->nextBlock = newFreeBlock;
    80001714:	00c7b823          	sd	a2,16(a5)
        newFreeBlock->previousBlock = allocatedBlocks->previousBlock;
    80001718:	0185b783          	ld	a5,24(a1)
    8000171c:	00f63c23          	sd	a5,24(a2)
        newFreeBlock->nextBlock = allocatedBlocks->nextBlock;
    80001720:	0105b783          	ld	a5,16(a1)
    80001724:	00f63823          	sd	a5,16(a2)
        if(*head == allocatedBlocks)
    80001728:	00053783          	ld	a5,0(a0)
    8000172c:	fab798e3          	bne	a5,a1,800016dc <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x3c>
            *head = newFreeBlock;
    80001730:	00c53023          	sd	a2,0(a0)
}
    80001734:	fa9ff06f          	j	800016dc <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x3c>

0000000080001738 <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm>:
{
    80001738:	fe010113          	addi	sp,sp,-32
    8000173c:	00113c23          	sd	ra,24(sp)
    80001740:	00813823          	sd	s0,16(sp)
    80001744:	00913423          	sd	s1,8(sp)
    80001748:	01213023          	sd	s2,0(sp)
    8000174c:	02010413          	addi	s0,sp,32
    80001750:	00058913          	mv	s2,a1
    for(FreeBlock* curr = (*head); curr; curr = curr->nextBlock)
    80001754:	00053783          	ld	a5,0(a0)
    FreeBlock* bestBlock = nullptr;
    80001758:	00000493          	li	s1,0
    8000175c:	00c0006f          	j	80001768 <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm+0x30>
                bestBlock = curr;
    80001760:	00078493          	mv	s1,a5
    for(FreeBlock* curr = (*head); curr; curr = curr->nextBlock)
    80001764:	0107b783          	ld	a5,16(a5)
    80001768:	02078063          	beqz	a5,80001788 <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm+0x50>
        if(curr->numOfBlocks >= blocksToAllocate)
    8000176c:	0087b703          	ld	a4,8(a5)
    80001770:	ff276ae3          	bltu	a4,s2,80001764 <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm+0x2c>
        {   if(bestBlock == nullptr)
    80001774:	fe0486e3          	beqz	s1,80001760 <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm+0x28>
            if(bestBlock->numOfBlocks > curr->numOfBlocks)
    80001778:	0084b683          	ld	a3,8(s1)
    8000177c:	fed774e3          	bgeu	a4,a3,80001764 <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm+0x2c>
                bestBlock = curr;
    80001780:	00078493          	mv	s1,a5
    80001784:	fe1ff06f          	j	80001764 <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm+0x2c>
    numOfFreeBlocks -= blocksToAllocate;
    80001788:	00004717          	auipc	a4,0x4
    8000178c:	20870713          	addi	a4,a4,520 # 80005990 <_ZN15MemoryAllocator13NUM_OF_BLOCKSE>
    80001790:	00873783          	ld	a5,8(a4)
    80001794:	412787b3          	sub	a5,a5,s2
    80001798:	00f73423          	sd	a5,8(a4)
    bestBlock->numOfBlocks -= blocksToAllocate;
    8000179c:	0084b783          	ld	a5,8(s1)
    800017a0:	412787b3          	sub	a5,a5,s2
    800017a4:	00f4b423          	sd	a5,8(s1)
    remapMemory(head, bestBlock, blocksToAllocate);
    800017a8:	00090613          	mv	a2,s2
    800017ac:	00048593          	mv	a1,s1
    800017b0:	00000097          	auipc	ra,0x0
    800017b4:	ef0080e7          	jalr	-272(ra) # 800016a0 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m>
    occupiedBlock->flagFree = false;
    800017b8:	00048023          	sb	zero,0(s1)
    occupiedBlock->numOfBlocks = blocksToAllocate;
    800017bc:	0124b423          	sd	s2,8(s1)
}
    800017c0:	01048513          	addi	a0,s1,16
    800017c4:	01813083          	ld	ra,24(sp)
    800017c8:	01013403          	ld	s0,16(sp)
    800017cc:	00813483          	ld	s1,8(sp)
    800017d0:	00013903          	ld	s2,0(sp)
    800017d4:	02010113          	addi	sp,sp,32
    800017d8:	00008067          	ret

00000000800017dc <_ZN15MemoryAllocator14allocateMemoryEm>:
{
    800017dc:	fe010113          	addi	sp,sp,-32
    800017e0:	00113c23          	sd	ra,24(sp)
    800017e4:	00813823          	sd	s0,16(sp)
    800017e8:	00913423          	sd	s1,8(sp)
    800017ec:	02010413          	addi	s0,sp,32
    800017f0:	00050493          	mv	s1,a0
    if(!flagSystemInitialize)
    800017f4:	00004797          	auipc	a5,0x4
    800017f8:	1b47c783          	lbu	a5,436(a5) # 800059a8 <_ZN15MemoryAllocator20flagSystemInitializeE>
    800017fc:	02078c63          	beqz	a5,80001834 <_ZN15MemoryAllocator14allocateMemoryEm+0x58>
    if(numOfFreeBlocks < blocksToAllocate)
    80001800:	00004797          	auipc	a5,0x4
    80001804:	1987b783          	ld	a5,408(a5) # 80005998 <_ZN15MemoryAllocator15numOfFreeBlocksE>
    80001808:	0297ec63          	bltu	a5,s1,80001840 <_ZN15MemoryAllocator14allocateMemoryEm+0x64>
    return findBestFit(&firstFreeBlock, blocksToAllocate);
    8000180c:	00048593          	mv	a1,s1
    80001810:	00004517          	auipc	a0,0x4
    80001814:	19050513          	addi	a0,a0,400 # 800059a0 <_ZN15MemoryAllocator14firstFreeBlockE>
    80001818:	00000097          	auipc	ra,0x0
    8000181c:	f20080e7          	jalr	-224(ra) # 80001738 <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm>
}
    80001820:	01813083          	ld	ra,24(sp)
    80001824:	01013403          	ld	s0,16(sp)
    80001828:	00813483          	ld	s1,8(sp)
    8000182c:	02010113          	addi	sp,sp,32
    80001830:	00008067          	ret
        initializeMemory();
    80001834:	00000097          	auipc	ra,0x0
    80001838:	e00080e7          	jalr	-512(ra) # 80001634 <_ZN15MemoryAllocator16initializeMemoryEv>
    8000183c:	fc5ff06f          	j	80001800 <_ZN15MemoryAllocator14allocateMemoryEm+0x24>
        return nullptr;
    80001840:	00000513          	li	a0,0
    80001844:	fddff06f          	j	80001820 <_ZN15MemoryAllocator14allocateMemoryEm+0x44>

0000000080001848 <_ZN15MemoryAllocator17findNextFreeBlockEPNS_9FreeBlockE>:
MemoryAllocator::FreeBlock* MemoryAllocator::findNextFreeBlock(FreeBlock* memoryToFree)
{
    80001848:	ff010113          	addi	sp,sp,-16
    8000184c:	00813423          	sd	s0,8(sp)
    80001850:	01010413          	addi	s0,sp,16
    for(uint8* i = (uint8*)memoryToFree; i + MEM_BLOCK_SIZE <= (uint8*)HEAP_END_ADDR; i+= (((OccupiedBlock*)i)->numOfBlocks * MEM_BLOCK_SIZE))
    80001854:	04050793          	addi	a5,a0,64
    80001858:	00004717          	auipc	a4,0x4
    8000185c:	0c073703          	ld	a4,192(a4) # 80005918 <_GLOBAL_OFFSET_TABLE_+0x28>
    80001860:	00073703          	ld	a4,0(a4)
    80001864:	00f76e63          	bltu	a4,a5,80001880 <_ZN15MemoryAllocator17findNextFreeBlockEPNS_9FreeBlockE+0x38>
    {
        if(((FreeBlock*)i)->flagFree)
    80001868:	00054783          	lbu	a5,0(a0)
    8000186c:	00079c63          	bnez	a5,80001884 <_ZN15MemoryAllocator17findNextFreeBlockEPNS_9FreeBlockE+0x3c>
    for(uint8* i = (uint8*)memoryToFree; i + MEM_BLOCK_SIZE <= (uint8*)HEAP_END_ADDR; i+= (((OccupiedBlock*)i)->numOfBlocks * MEM_BLOCK_SIZE))
    80001870:	00853783          	ld	a5,8(a0)
    80001874:	00679793          	slli	a5,a5,0x6
    80001878:	00f50533          	add	a0,a0,a5
    8000187c:	fd9ff06f          	j	80001854 <_ZN15MemoryAllocator17findNextFreeBlockEPNS_9FreeBlockE+0xc>
        {
            return (FreeBlock*)i;
        }
    }
    return nullptr;
    80001880:	00000513          	li	a0,0
}
    80001884:	00813403          	ld	s0,8(sp)
    80001888:	01010113          	addi	sp,sp,16
    8000188c:	00008067          	ret

0000000080001890 <_ZN15MemoryAllocator21findPreviousFreeBlockEPNS_9FreeBlockES1_>:

MemoryAllocator::FreeBlock* MemoryAllocator::findPreviousFreeBlock(FreeBlock* head, FreeBlock* memoryToFree)
{
    80001890:	ff010113          	addi	sp,sp,-16
    80001894:	00813423          	sd	s0,8(sp)
    80001898:	01010413          	addi	s0,sp,16
    FreeBlock* temp = head;
    for(; temp && temp <= memoryToFree; temp = temp->nextBlock){}
    8000189c:	00050863          	beqz	a0,800018ac <_ZN15MemoryAllocator21findPreviousFreeBlockEPNS_9FreeBlockES1_+0x1c>
    800018a0:	00a5e663          	bltu	a1,a0,800018ac <_ZN15MemoryAllocator21findPreviousFreeBlockEPNS_9FreeBlockES1_+0x1c>
    800018a4:	01053503          	ld	a0,16(a0)
    800018a8:	ff5ff06f          	j	8000189c <_ZN15MemoryAllocator21findPreviousFreeBlockEPNS_9FreeBlockES1_+0xc>
    if(!temp)
    800018ac:	00050463          	beqz	a0,800018b4 <_ZN15MemoryAllocator21findPreviousFreeBlockEPNS_9FreeBlockES1_+0x24>
    {
        return nullptr;
    }
    return temp->previousBlock;
    800018b0:	01853503          	ld	a0,24(a0)
}
    800018b4:	00813403          	ld	s0,8(sp)
    800018b8:	01010113          	addi	sp,sp,16
    800018bc:	00008067          	ret

00000000800018c0 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_>:

    return 0;
}

void MemoryAllocator::connectAdjacentBlocks(FreeBlock* previousBlock, FreeBlock* adjacentBlock)
{
    800018c0:	ff010113          	addi	sp,sp,-16
    800018c4:	00813423          	sd	s0,8(sp)
    800018c8:	01010413          	addi	s0,sp,16


    if(adjacentBlock == (FreeBlock*)((uint8 *)previousBlock + previousBlock->numOfBlocks * MEM_BLOCK_SIZE))
    800018cc:	00853703          	ld	a4,8(a0)
    800018d0:	00671793          	slli	a5,a4,0x6
    800018d4:	00f507b3          	add	a5,a0,a5
    800018d8:	00b78e63          	beq	a5,a1,800018f4 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_+0x34>
        adjacentBlock->previousBlock = nullptr;

    }
    else
    {
        previousBlock->nextBlock = adjacentBlock;
    800018dc:	00b53823          	sd	a1,16(a0)
        if(adjacentBlock)
    800018e0:	00058463          	beqz	a1,800018e8 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_+0x28>
        {
            adjacentBlock->previousBlock = previousBlock;
    800018e4:	00a5bc23          	sd	a0,24(a1)
        }

    }
}
    800018e8:	00813403          	ld	s0,8(sp)
    800018ec:	01010113          	addi	sp,sp,16
    800018f0:	00008067          	ret
        previousBlock->numOfBlocks += adjacentBlock->numOfBlocks;
    800018f4:	0085b783          	ld	a5,8(a1)
    800018f8:	00f70733          	add	a4,a4,a5
    800018fc:	00e53423          	sd	a4,8(a0)
        previousBlock->nextBlock = adjacentBlock->nextBlock;
    80001900:	0105b783          	ld	a5,16(a1)
    80001904:	00f53823          	sd	a5,16(a0)
        if(adjacentBlock->nextBlock != nullptr)
    80001908:	00078463          	beqz	a5,80001910 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_+0x50>
            adjacentBlock->nextBlock->previousBlock = previousBlock;
    8000190c:	00a7bc23          	sd	a0,24(a5)
        if(adjacentBlock->previousBlock != previousBlock && adjacentBlock->previousBlock != nullptr)
    80001910:	0185b783          	ld	a5,24(a1)
    80001914:	00a78863          	beq	a5,a0,80001924 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_+0x64>
    80001918:	00078663          	beqz	a5,80001924 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_+0x64>
            previousBlock->previousBlock = adjacentBlock->previousBlock;
    8000191c:	00f53c23          	sd	a5,24(a0)
            adjacentBlock->previousBlock->nextBlock = previousBlock;
    80001920:	00a7b823          	sd	a0,16(a5)
        adjacentBlock->flagFree = false;
    80001924:	00058023          	sb	zero,0(a1)
        adjacentBlock->numOfBlocks = 0;
    80001928:	0005b423          	sd	zero,8(a1)
        adjacentBlock->nextBlock = nullptr;
    8000192c:	0005b823          	sd	zero,16(a1)
        adjacentBlock->previousBlock = nullptr;
    80001930:	0005bc23          	sd	zero,24(a1)
    80001934:	fb5ff06f          	j	800018e8 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_+0x28>

0000000080001938 <_ZN15MemoryAllocator10freeMemoryEPv>:
    if(!addressToFree)
    80001938:	0c050e63          	beqz	a0,80001a14 <_ZN15MemoryAllocator10freeMemoryEPv+0xdc>
{
    8000193c:	fc010113          	addi	sp,sp,-64
    80001940:	02113c23          	sd	ra,56(sp)
    80001944:	02813823          	sd	s0,48(sp)
    80001948:	02913423          	sd	s1,40(sp)
    8000194c:	03213023          	sd	s2,32(sp)
    80001950:	01313c23          	sd	s3,24(sp)
    80001954:	01413823          	sd	s4,16(sp)
    80001958:	01513423          	sd	s5,8(sp)
    8000195c:	04010413          	addi	s0,sp,64
    80001960:	00050493          	mv	s1,a0
    tempAddress--;
    80001964:	ff050913          	addi	s2,a0,-16
    int numOfTakenBlocks = tempAddress->numOfBlocks;
    80001968:	ff852a83          	lw	s5,-8(a0)
    numOfFreeBlocks += numOfTakenBlocks;
    8000196c:	00004997          	auipc	s3,0x4
    80001970:	02498993          	addi	s3,s3,36 # 80005990 <_ZN15MemoryAllocator13NUM_OF_BLOCKSE>
    80001974:	0089b783          	ld	a5,8(s3)
    80001978:	015787b3          	add	a5,a5,s5
    8000197c:	00f9b423          	sd	a5,8(s3)
    FreeBlock* nextFreeBlock = findNextFreeBlock(newFreeBlock);
    80001980:	00090513          	mv	a0,s2
    80001984:	00000097          	auipc	ra,0x0
    80001988:	ec4080e7          	jalr	-316(ra) # 80001848 <_ZN15MemoryAllocator17findNextFreeBlockEPNS_9FreeBlockE>
    8000198c:	00050a13          	mv	s4,a0
    FreeBlock* previousFreeBlock = findPreviousFreeBlock(firstFreeBlock, newFreeBlock);
    80001990:	00090593          	mv	a1,s2
    80001994:	0109b503          	ld	a0,16(s3)
    80001998:	00000097          	auipc	ra,0x0
    8000199c:	ef8080e7          	jalr	-264(ra) # 80001890 <_ZN15MemoryAllocator21findPreviousFreeBlockEPNS_9FreeBlockES1_>
    800019a0:	00050993          	mv	s3,a0
    newFreeBlock->flagFree = true;
    800019a4:	00100793          	li	a5,1
    800019a8:	fef48823          	sb	a5,-16(s1)
    newFreeBlock->numOfBlocks = numOfTakenBlocks;
    800019ac:	ff54bc23          	sd	s5,-8(s1)
    newFreeBlock->nextBlock = nullptr;
    800019b0:	0004b023          	sd	zero,0(s1)
    newFreeBlock->previousBlock = nullptr;
    800019b4:	0004b423          	sd	zero,8(s1)
    connectAdjacentBlocks(newFreeBlock, nextFreeBlock);
    800019b8:	000a0593          	mv	a1,s4
    800019bc:	00090513          	mv	a0,s2
    800019c0:	00000097          	auipc	ra,0x0
    800019c4:	f00080e7          	jalr	-256(ra) # 800018c0 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_>
    if(previousFreeBlock)
    800019c8:	02098e63          	beqz	s3,80001a04 <_ZN15MemoryAllocator10freeMemoryEPv+0xcc>
        connectAdjacentBlocks(previousFreeBlock, newFreeBlock);
    800019cc:	00090593          	mv	a1,s2
    800019d0:	00098513          	mv	a0,s3
    800019d4:	00000097          	auipc	ra,0x0
    800019d8:	eec080e7          	jalr	-276(ra) # 800018c0 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_>
    return 0;
    800019dc:	00000513          	li	a0,0
}
    800019e0:	03813083          	ld	ra,56(sp)
    800019e4:	03013403          	ld	s0,48(sp)
    800019e8:	02813483          	ld	s1,40(sp)
    800019ec:	02013903          	ld	s2,32(sp)
    800019f0:	01813983          	ld	s3,24(sp)
    800019f4:	01013a03          	ld	s4,16(sp)
    800019f8:	00813a83          	ld	s5,8(sp)
    800019fc:	04010113          	addi	sp,sp,64
    80001a00:	00008067          	ret
        firstFreeBlock = newFreeBlock;
    80001a04:	00004797          	auipc	a5,0x4
    80001a08:	f927be23          	sd	s2,-100(a5) # 800059a0 <_ZN15MemoryAllocator14firstFreeBlockE>
    return 0;
    80001a0c:	00000513          	li	a0,0
    80001a10:	fd1ff06f          	j	800019e0 <_ZN15MemoryAllocator10freeMemoryEPv+0xa8>
        return -1;
    80001a14:	fff00513          	li	a0,-1
}
    80001a18:	00008067          	ret

0000000080001a1c <_ZN15MemoryAllocator19getLargestFreeBlockEv>:

size_t  MemoryAllocator::getLargestFreeBlock()
{
    80001a1c:	ff010113          	addi	sp,sp,-16
    80001a20:	00813423          	sd	s0,8(sp)
    80001a24:	01010413          	addi	s0,sp,16
    size_t largestBlock = firstFreeBlock->numOfBlocks;
    80001a28:	00004797          	auipc	a5,0x4
    80001a2c:	f787b783          	ld	a5,-136(a5) # 800059a0 <_ZN15MemoryAllocator14firstFreeBlockE>
    80001a30:	0087b503          	ld	a0,8(a5)
    for(FreeBlock* curr = firstFreeBlock->nextBlock; curr; curr = curr->nextBlock)
    80001a34:	0107b783          	ld	a5,16(a5)
    80001a38:	0080006f          	j	80001a40 <_ZN15MemoryAllocator19getLargestFreeBlockEv+0x24>
    80001a3c:	0107b783          	ld	a5,16(a5)
    80001a40:	00078a63          	beqz	a5,80001a54 <_ZN15MemoryAllocator19getLargestFreeBlockEv+0x38>
    {
        if(curr->numOfBlocks > largestBlock)
    80001a44:	0087b703          	ld	a4,8(a5)
    80001a48:	fee57ae3          	bgeu	a0,a4,80001a3c <_ZN15MemoryAllocator19getLargestFreeBlockEv+0x20>
        {
            largestBlock = curr->numOfBlocks;
    80001a4c:	00070513          	mv	a0,a4
    80001a50:	fedff06f          	j	80001a3c <_ZN15MemoryAllocator19getLargestFreeBlockEv+0x20>
        }
    }
    return largestBlock * MEM_BLOCK_SIZE;
}
    80001a54:	00651513          	slli	a0,a0,0x6
    80001a58:	00813403          	ld	s0,8(sp)
    80001a5c:	01010113          	addi	sp,sp,16
    80001a60:	00008067          	ret

0000000080001a64 <_ZN15MemoryAllocator12getFreeSpaceEv>:
size_t MemoryAllocator::getFreeSpace()
{
    80001a64:	ff010113          	addi	sp,sp,-16
    80001a68:	00813423          	sd	s0,8(sp)
    80001a6c:	01010413          	addi	s0,sp,16
    return numOfFreeBlocks * MEM_BLOCK_SIZE;
}
    80001a70:	00004517          	auipc	a0,0x4
    80001a74:	f2853503          	ld	a0,-216(a0) # 80005998 <_ZN15MemoryAllocator15numOfFreeBlocksE>
    80001a78:	00651513          	slli	a0,a0,0x6
    80001a7c:	00813403          	ld	s0,8(sp)
    80001a80:	01010113          	addi	sp,sp,16
    80001a84:	00008067          	ret

0000000080001a88 <_ZN15MemoryAllocator17getSizeOfMetaDataEv>:

size_t MemoryAllocator::getSizeOfMetaData()
{
    80001a88:	ff010113          	addi	sp,sp,-16
    80001a8c:	00813423          	sd	s0,8(sp)
    80001a90:	01010413          	addi	s0,sp,16
    return sizeof(OccupiedBlock);
    80001a94:	01000513          	li	a0,16
    80001a98:	00813403          	ld	s0,8(sp)
    80001a9c:	01010113          	addi	sp,sp,16
    80001aa0:	00008067          	ret

0000000080001aa4 <_ZN6Kernel9sysMallocEPNS_21ArgumentsOfSystemCallE>:
    __asm__ volatile("ld %[rd], 16*8(%[rs])":[rd]"=r"(arg->a5):[rs]"r"(basePointer));
    __asm__ volatile("ld %[rd], 17*8(%[rs])":[rd]"=r"(arg->a6):[rs]"r"(basePointer));
}

uint64 Kernel::sysMalloc(Kernel::ArgumentsOfSystemCall *arg)
{
    80001aa4:	ff010113          	addi	sp,sp,-16
    80001aa8:	00113423          	sd	ra,8(sp)
    80001aac:	00813023          	sd	s0,0(sp)
    80001ab0:	01010413          	addi	s0,sp,16
    uint64 returnValue;
    returnValue = (uint64)MemoryAllocator::allocateMemory(arg->a0);
    80001ab4:	00053503          	ld	a0,0(a0)
    80001ab8:	00000097          	auipc	ra,0x0
    80001abc:	d24080e7          	jalr	-732(ra) # 800017dc <_ZN15MemoryAllocator14allocateMemoryEm>
    return returnValue;
}
    80001ac0:	00813083          	ld	ra,8(sp)
    80001ac4:	00013403          	ld	s0,0(sp)
    80001ac8:	01010113          	addi	sp,sp,16
    80001acc:	00008067          	ret

0000000080001ad0 <_ZN6Kernel7sysFreeEPNS_21ArgumentsOfSystemCallE>:
uint64 Kernel::sysFree(Kernel::ArgumentsOfSystemCall *arg)
{
    80001ad0:	ff010113          	addi	sp,sp,-16
    80001ad4:	00113423          	sd	ra,8(sp)
    80001ad8:	00813023          	sd	s0,0(sp)
    80001adc:	01010413          	addi	s0,sp,16
    uint64 returnValue;
    returnValue = (uint64)MemoryAllocator::freeMemory((void*)arg->a0);
    80001ae0:	00053503          	ld	a0,0(a0)
    80001ae4:	00000097          	auipc	ra,0x0
    80001ae8:	e54080e7          	jalr	-428(ra) # 80001938 <_ZN15MemoryAllocator10freeMemoryEPv>
    return returnValue;
}
    80001aec:	00813083          	ld	ra,8(sp)
    80001af0:	00013403          	ld	s0,0(sp)
    80001af4:	01010113          	addi	sp,sp,16
    80001af8:	00008067          	ret

0000000080001afc <_ZN6Kernel15sysGetFreeSpaceEPNS_21ArgumentsOfSystemCallE>:
uint64 Kernel::sysGetFreeSpace(Kernel::ArgumentsOfSystemCall *arg)
{
    80001afc:	ff010113          	addi	sp,sp,-16
    80001b00:	00113423          	sd	ra,8(sp)
    80001b04:	00813023          	sd	s0,0(sp)
    80001b08:	01010413          	addi	s0,sp,16
    uint64 returnValue;
    returnValue = (uint64)MemoryAllocator::getFreeSpace();
    80001b0c:	00000097          	auipc	ra,0x0
    80001b10:	f58080e7          	jalr	-168(ra) # 80001a64 <_ZN15MemoryAllocator12getFreeSpaceEv>
    return returnValue;
}
    80001b14:	00813083          	ld	ra,8(sp)
    80001b18:	00013403          	ld	s0,0(sp)
    80001b1c:	01010113          	addi	sp,sp,16
    80001b20:	00008067          	ret

0000000080001b24 <_ZN6Kernel19sysLargestFreeBlockEPNS_21ArgumentsOfSystemCallE>:
uint64 Kernel::sysLargestFreeBlock(Kernel::ArgumentsOfSystemCall *arg)
{
    80001b24:	ff010113          	addi	sp,sp,-16
    80001b28:	00113423          	sd	ra,8(sp)
    80001b2c:	00813023          	sd	s0,0(sp)
    80001b30:	01010413          	addi	s0,sp,16
    uint64 returnValue;
    returnValue = (uint64)MemoryAllocator::getLargestFreeBlock();
    80001b34:	00000097          	auipc	ra,0x0
    80001b38:	ee8080e7          	jalr	-280(ra) # 80001a1c <_ZN15MemoryAllocator19getLargestFreeBlockEv>
    return returnValue;
}
    80001b3c:	00813083          	ld	ra,8(sp)
    80001b40:	00013403          	ld	s0,0(sp)
    80001b44:	01010113          	addi	sp,sp,16
    80001b48:	00008067          	ret

0000000080001b4c <_ZN6Kernel19initializeArgumentsEPNS_21ArgumentsOfSystemCallEm>:
{
    80001b4c:	ff010113          	addi	sp,sp,-16
    80001b50:	00813423          	sd	s0,8(sp)
    80001b54:	01010413          	addi	s0,sp,16
    __asm__ volatile("ld %[rd], 11*8(%[rs])":[rd]"=r"(arg->a0):[rs]"r"(basePointer));
    80001b58:	0585b783          	ld	a5,88(a1)
    80001b5c:	00f53023          	sd	a5,0(a0)
    __asm__ volatile("ld %[rd], 12*8(%[rs])":[rd]"=r"(arg->a1):[rs]"r"(basePointer));
    80001b60:	0605b783          	ld	a5,96(a1)
    80001b64:	00f53423          	sd	a5,8(a0)
    __asm__ volatile("ld %[rd], 13*8(%[rs])":[rd]"=r"(arg->a2):[rs]"r"(basePointer));
    80001b68:	0685b783          	ld	a5,104(a1)
    80001b6c:	00f53823          	sd	a5,16(a0)
    __asm__ volatile("ld %[rd], 14*8(%[rs])":[rd]"=r"(arg->a3):[rs]"r"(basePointer));
    80001b70:	0705b783          	ld	a5,112(a1)
    80001b74:	00f53c23          	sd	a5,24(a0)
    __asm__ volatile("ld %[rd], 15*8(%[rs])":[rd]"=r"(arg->a4):[rs]"r"(basePointer));
    80001b78:	0785b783          	ld	a5,120(a1)
    80001b7c:	02f53023          	sd	a5,32(a0)
    __asm__ volatile("ld %[rd], 16*8(%[rs])":[rd]"=r"(arg->a5):[rs]"r"(basePointer));
    80001b80:	0805b783          	ld	a5,128(a1)
    80001b84:	02f53423          	sd	a5,40(a0)
    __asm__ volatile("ld %[rd], 17*8(%[rs])":[rd]"=r"(arg->a6):[rs]"r"(basePointer));
    80001b88:	0885b583          	ld	a1,136(a1)
    80001b8c:	02b53823          	sd	a1,48(a0)
}
    80001b90:	00813403          	ld	s0,8(sp)
    80001b94:	01010113          	addi	sp,sp,16
    80001b98:	00008067          	ret

0000000080001b9c <_ZN6Kernel17sysThreadDispatchEPNS_21ArgumentsOfSystemCallE>:
    __asm__ volatile("sd %[ptrThread], 0(%[handle])"::[ptrThread]"r"(newThread), [handle]"r"(arg->a0));
    newThread->initializeThread((TCB::Body) arg->a1, (void*)arg->a2, (void*)arg->a3);
    return 0;
}
uint64 Kernel::sysThreadDispatch(Kernel::ArgumentsOfSystemCall *arg)
{
    80001b9c:	ff010113          	addi	sp,sp,-16
    80001ba0:	00113423          	sd	ra,8(sp)
    80001ba4:	00813023          	sd	s0,0(sp)
    80001ba8:	01010413          	addi	s0,sp,16
    TCB::dispatch();
    80001bac:	00000097          	auipc	ra,0x0
    80001bb0:	a20080e7          	jalr	-1504(ra) # 800015cc <_ZN3TCB8dispatchEv>
    return 0;
}
    80001bb4:	00000513          	li	a0,0
    80001bb8:	00813083          	ld	ra,8(sp)
    80001bbc:	00013403          	ld	s0,0(sp)
    80001bc0:	01010113          	addi	sp,sp,16
    80001bc4:	00008067          	ret

0000000080001bc8 <_ZN6Kernel16interruptHandlerEv>:
    TCB::running->isFinished = true;
    Kernel::poolOfThreads->freeObject(TCB::running);
    return 0;
}
void Kernel::interruptHandler()
{
    80001bc8:	f9010113          	addi	sp,sp,-112
    80001bcc:	06113423          	sd	ra,104(sp)
    80001bd0:	06813023          	sd	s0,96(sp)
    80001bd4:	04913c23          	sd	s1,88(sp)
    80001bd8:	05213823          	sd	s2,80(sp)
    80001bdc:	05313423          	sd	s3,72(sp)
    80001be0:	05413023          	sd	s4,64(sp)
    80001be4:	07010413          	addi	s0,sp,112
    volatile uint64 basePointer;
    __asm__ volatile ("addi %[reg], s0, 0x0": [reg]"=r"(basePointer)); // Problem: da li mozemo biti 100% sigurni da ce s0 biti nepromenjen; resenje inline f-ja
    80001be8:	00040793          	mv	a5,s0
    80001bec:	fcf43423          	sd	a5,-56(s0)
    __asm__ volatile ("csrr %[cause], scause": [cause] "=r"(scause));
    80001bf0:	142027f3          	csrr	a5,scause
    uint64 scause = Machine::readScause();
    if(scause == 0x0000000000000008UL || scause == 0x0000000000000009UL)
    80001bf4:	ff878793          	addi	a5,a5,-8
    80001bf8:	00100713          	li	a4,1
    80001bfc:	02f77263          	bgeu	a4,a5,80001c20 <_ZN6Kernel16interruptHandlerEv+0x58>

        Machine::writeSepc(sepc);
        Machine::writeSstatus(sstatus);
    }

    80001c00:	06813083          	ld	ra,104(sp)
    80001c04:	06013403          	ld	s0,96(sp)
    80001c08:	05813483          	ld	s1,88(sp)
    80001c0c:	05013903          	ld	s2,80(sp)
    80001c10:	04813983          	ld	s3,72(sp)
    80001c14:	04013a03          	ld	s4,64(sp)
    80001c18:	07010113          	addi	sp,sp,112
    80001c1c:	00008067          	ret
    __asm__ volatile ("csrc sip, %[reg]":: [reg] "r"(mask));
    80001c20:	00200793          	li	a5,2
    80001c24:	1447b073          	csrc	sip,a5
}
inline uint64 Machine::readSepc()
{
    uint64 returnAddress;
    __asm__ volatile ("csrr %[reg], sepc": [reg] "=r"(returnAddress));
    80001c28:	141029f3          	csrr	s3,sepc
        uint64 sepc = Machine::readSepc() + 4;
    80001c2c:	00498993          	addi	s3,s3,4
    __asm__ volatile("csrw sstatus, %[reg]":: [reg] "r"(oldStatus));
}
inline uint64 Machine::readSstatus()
{
    uint64 returnStatus;
    __asm__ volatile ("csrr %[reg], sstatus": [reg] "=r"(returnStatus));
    80001c30:	10002a73          	csrr	s4,sstatus
        __asm__ volatile ("ld %[rd], 80(%[rs])": [rd]"=r"(numberOfEntry):[rs]"r"(basePointer));
    80001c34:	fc843483          	ld	s1,-56(s0)
    80001c38:	0504b483          	ld	s1,80(s1)
        initializeArguments(&arg, basePointer);
    80001c3c:	fc843583          	ld	a1,-56(s0)
    80001c40:	f9040913          	addi	s2,s0,-112
    80001c44:	00090513          	mv	a0,s2
    80001c48:	00000097          	auipc	ra,0x0
    80001c4c:	f04080e7          	jalr	-252(ra) # 80001b4c <_ZN6Kernel19initializeArgumentsEPNS_21ArgumentsOfSystemCallEm>
        systemCallsTable[numberOfEntry](&arg);
    80001c50:	00349493          	slli	s1,s1,0x3
    80001c54:	00004797          	auipc	a5,0x4
    80001c58:	d5c78793          	addi	a5,a5,-676 # 800059b0 <_ZN6Kernel16systemCallsTableE>
    80001c5c:	009784b3          	add	s1,a5,s1
    80001c60:	0004b783          	ld	a5,0(s1)
    80001c64:	00090513          	mv	a0,s2
    80001c68:	000780e7          	jalr	a5
        __asm__ volatile("sd a0, 80(%[rs])"::[rs]"r"(basePointer));
    80001c6c:	fc843783          	ld	a5,-56(s0)
    80001c70:	04a7b823          	sd	a0,80(a5)
        TCB::dispatch();
    80001c74:	00000097          	auipc	ra,0x0
    80001c78:	958080e7          	jalr	-1704(ra) # 800015cc <_ZN3TCB8dispatchEv>
    __asm__ volatile("csrw sepc, %[reg]":: [reg] "r"(address));
    80001c7c:	14199073          	csrw	sepc,s3
    __asm__ volatile("csrw sstatus, %[reg]":: [reg] "r"(oldStatus));
    80001c80:	100a1073          	csrw	sstatus,s4
    80001c84:	f7dff06f          	j	80001c00 <_ZN6Kernel16interruptHandlerEv+0x38>

0000000080001c88 <_ZN6Kernel16initializeKernelEv>:
{
    80001c88:	ff010113          	addi	sp,sp,-16
    80001c8c:	00113423          	sd	ra,8(sp)
    80001c90:	00813023          	sd	s0,0(sp)
    80001c94:	01010413          	addi	s0,sp,16

};

inline void Kernel::setInterruptRoutine(void (*routine)(void))
{
    Machine::writeStvec((uint64) routine);
    80001c98:	00004797          	auipc	a5,0x4
    80001c9c:	c707b783          	ld	a5,-912(a5) # 80005908 <_GLOBAL_OFFSET_TABLE_+0x18>
    __asm__ volatile ("csrw stvec, %[address]": : [address] "r"(interruptAddress));
    80001ca0:	10579073          	csrw	stvec,a5
}
    80001ca4:	0100006f          	j	80001cb4 <_ZN6Kernel16initializeKernelEv+0x2c>

        for(size_t i = 0; i < numOfObjects - 1; i++)
        {
            pool[i].nextFree = &(pool[i+1]);
        }
        pool[numOfObjects - 1].nextFree = nullptr;
    80001ca8:	58053c23          	sd	zero,1432(a0)
     poolOfThreads = new ObjectPool<TCB, KernelConfig::NUM_OF_THREADS_IN_POOL>();
    80001cac:	00004797          	auipc	a5,0x4
    80001cb0:	f0a7ba23          	sd	a0,-236(a5) # 80005bc0 <_ZN6Kernel13poolOfThreadsE>
    while(!poolOfThreads)
    80001cb4:	00004797          	auipc	a5,0x4
    80001cb8:	f0c7b783          	ld	a5,-244(a5) # 80005bc0 <_ZN6Kernel13poolOfThreadsE>
    80001cbc:	06079863          	bnez	a5,80001d2c <_ZN6Kernel16initializeKernelEv+0xa4>
     poolOfThreads = new ObjectPool<TCB, KernelConfig::NUM_OF_THREADS_IN_POOL>();
    80001cc0:	5c000513          	li	a0,1472
    80001cc4:	00000097          	auipc	ra,0x0
    80001cc8:	278080e7          	jalr	632(ra) # 80001f3c <_ZN10ObjectPoolI3TCBLm20EEnwEm>
    ObjectPool(): headFreeObject(pool), nextObjectPool(nullptr), prevObjectPool(nullptr), id(countOfPools++)
    80001ccc:	5aa53023          	sd	a0,1440(a0)
    80001cd0:	5a053423          	sd	zero,1448(a0)
    80001cd4:	5a053823          	sd	zero,1456(a0)
    80001cd8:	00004717          	auipc	a4,0x4
    80001cdc:	ef070713          	addi	a4,a4,-272 # 80005bc8 <_ZN10ObjectPoolI3TCBLm20EE12countOfPoolsE>
    80001ce0:	00073783          	ld	a5,0(a4)
    80001ce4:	00178693          	addi	a3,a5,1
    80001ce8:	00d73023          	sd	a3,0(a4)
    80001cec:	5af53c23          	sd	a5,1464(a0)
        for(size_t i = 0; i < numOfObjects - 1; i++)
    80001cf0:	00000693          	li	a3,0
    80001cf4:	01200793          	li	a5,18
    80001cf8:	fad7e8e3          	bltu	a5,a3,80001ca8 <_ZN6Kernel16initializeKernelEv+0x20>
            pool[i].nextFree = &(pool[i+1]);
    80001cfc:	00168613          	addi	a2,a3,1
    80001d00:	00361713          	slli	a4,a2,0x3
    80001d04:	00c70733          	add	a4,a4,a2
    80001d08:	00371713          	slli	a4,a4,0x3
    80001d0c:	00e50733          	add	a4,a0,a4
    80001d10:	00369793          	slli	a5,a3,0x3
    80001d14:	00d787b3          	add	a5,a5,a3
    80001d18:	00379793          	slli	a5,a5,0x3
    80001d1c:	00f507b3          	add	a5,a0,a5
    80001d20:	04e7b023          	sd	a4,64(a5)
        for(size_t i = 0; i < numOfObjects - 1; i++)
    80001d24:	00060693          	mv	a3,a2
    80001d28:	fcdff06f          	j	80001cf4 <_ZN6Kernel16initializeKernelEv+0x6c>
    systemCallsTable[KernelConfig::MEM_ALLOC] = &sysMalloc;
    80001d2c:	00004797          	auipc	a5,0x4
    80001d30:	c8478793          	addi	a5,a5,-892 # 800059b0 <_ZN6Kernel16systemCallsTableE>
    80001d34:	00000717          	auipc	a4,0x0
    80001d38:	d7070713          	addi	a4,a4,-656 # 80001aa4 <_ZN6Kernel9sysMallocEPNS_21ArgumentsOfSystemCallE>
    80001d3c:	00e7b423          	sd	a4,8(a5)
    systemCallsTable[KernelConfig::MEM_FREE] = &sysFree;
    80001d40:	00000717          	auipc	a4,0x0
    80001d44:	d9070713          	addi	a4,a4,-624 # 80001ad0 <_ZN6Kernel7sysFreeEPNS_21ArgumentsOfSystemCallE>
    80001d48:	00e7b823          	sd	a4,16(a5)
    systemCallsTable[KernelConfig::MEM_FREE_SPACE] = &sysGetFreeSpace;
    80001d4c:	00000717          	auipc	a4,0x0
    80001d50:	db070713          	addi	a4,a4,-592 # 80001afc <_ZN6Kernel15sysGetFreeSpaceEPNS_21ArgumentsOfSystemCallE>
    80001d54:	00e7bc23          	sd	a4,24(a5)
    systemCallsTable[KernelConfig::LARGEST_FREE_BLOCK] = &sysLargestFreeBlock;
    80001d58:	00000717          	auipc	a4,0x0
    80001d5c:	dcc70713          	addi	a4,a4,-564 # 80001b24 <_ZN6Kernel19sysLargestFreeBlockEPNS_21ArgumentsOfSystemCallE>
    80001d60:	02e7b023          	sd	a4,32(a5)
    systemCallsTable[KernelConfig::THREAD_CREATE] = &sysThreadCreate;
    80001d64:	00000717          	auipc	a4,0x0
    80001d68:	13c70713          	addi	a4,a4,316 # 80001ea0 <_ZN6Kernel15sysThreadCreateEPNS_21ArgumentsOfSystemCallE>
    80001d6c:	08e7b423          	sd	a4,136(a5)
}
    80001d70:	00813083          	ld	ra,8(sp)
    80001d74:	00013403          	ld	s0,0(sp)
    80001d78:	01010113          	addi	sp,sp,16
    80001d7c:	00008067          	ret

0000000080001d80 <_Z41__static_initialization_and_destruction_0ii>:
    80001d80:	00100793          	li	a5,1
    80001d84:	00f50463          	beq	a0,a5,80001d8c <_Z41__static_initialization_and_destruction_0ii+0xc>
    80001d88:	00008067          	ret
    80001d8c:	000107b7          	lui	a5,0x10
    80001d90:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80001d94:	fef59ae3          	bne	a1,a5,80001d88 <_Z41__static_initialization_and_destruction_0ii+0x8>
    80001d98:	ff010113          	addi	sp,sp,-16
    80001d9c:	00113423          	sd	ra,8(sp)
    80001da0:	00813023          	sd	s0,0(sp)
    80001da4:	01010413          	addi	s0,sp,16
ObjectPool<TCB, KernelConfig::NUM_OF_THREADS_IN_POOL>* Kernel::poolOfThreads = new ObjectPool<TCB, KernelConfig::NUM_OF_THREADS_IN_POOL>();
    80001da8:	5c000513          	li	a0,1472
    80001dac:	00000097          	auipc	ra,0x0
    80001db0:	190080e7          	jalr	400(ra) # 80001f3c <_ZN10ObjectPoolI3TCBLm20EEnwEm>
    ObjectPool(): headFreeObject(pool), nextObjectPool(nullptr), prevObjectPool(nullptr), id(countOfPools++)
    80001db4:	5aa53023          	sd	a0,1440(a0)
    80001db8:	5a053423          	sd	zero,1448(a0)
    80001dbc:	5a053823          	sd	zero,1456(a0)
    80001dc0:	00004717          	auipc	a4,0x4
    80001dc4:	e0870713          	addi	a4,a4,-504 # 80005bc8 <_ZN10ObjectPoolI3TCBLm20EE12countOfPoolsE>
    80001dc8:	00073783          	ld	a5,0(a4)
    80001dcc:	00178693          	addi	a3,a5,1
    80001dd0:	00d73023          	sd	a3,0(a4)
    80001dd4:	5af53c23          	sd	a5,1464(a0)
        for(size_t i = 0; i < numOfObjects - 1; i++)
    80001dd8:	00000693          	li	a3,0
    80001ddc:	01200793          	li	a5,18
    80001de0:	02d7ea63          	bltu	a5,a3,80001e14 <_Z41__static_initialization_and_destruction_0ii+0x94>
            pool[i].nextFree = &(pool[i+1]);
    80001de4:	00168613          	addi	a2,a3,1
    80001de8:	00361713          	slli	a4,a2,0x3
    80001dec:	00c70733          	add	a4,a4,a2
    80001df0:	00371713          	slli	a4,a4,0x3
    80001df4:	00e50733          	add	a4,a0,a4
    80001df8:	00369793          	slli	a5,a3,0x3
    80001dfc:	00d787b3          	add	a5,a5,a3
    80001e00:	00379793          	slli	a5,a5,0x3
    80001e04:	00f507b3          	add	a5,a0,a5
    80001e08:	04e7b023          	sd	a4,64(a5)
        for(size_t i = 0; i < numOfObjects - 1; i++)
    80001e0c:	00060693          	mv	a3,a2
    80001e10:	fcdff06f          	j	80001ddc <_Z41__static_initialization_and_destruction_0ii+0x5c>
        pool[numOfObjects - 1].nextFree = nullptr;
    80001e14:	58053c23          	sd	zero,1432(a0)
    80001e18:	00004797          	auipc	a5,0x4
    80001e1c:	daa7b423          	sd	a0,-600(a5) # 80005bc0 <_ZN6Kernel13poolOfThreadsE>
    80001e20:	00813083          	ld	ra,8(sp)
    80001e24:	00013403          	ld	s0,0(sp)
    80001e28:	01010113          	addi	sp,sp,16
    80001e2c:	00008067          	ret

0000000080001e30 <_ZN6Kernel13sysThreadExitEPNS_21ArgumentsOfSystemCallE>:
{
    80001e30:	ff010113          	addi	sp,sp,-16
    80001e34:	00113423          	sd	ra,8(sp)
    80001e38:	00813023          	sd	s0,0(sp)
    80001e3c:	01010413          	addi	s0,sp,16
    if(MemoryAllocator::freeMemory(TCB::running->systemStack) == -1)
    80001e40:	00004797          	auipc	a5,0x4
    80001e44:	ad07b783          	ld	a5,-1328(a5) # 80005910 <_GLOBAL_OFFSET_TABLE_+0x20>
    80001e48:	0007b783          	ld	a5,0(a5)
    80001e4c:	0207b503          	ld	a0,32(a5)
    80001e50:	00000097          	auipc	ra,0x0
    80001e54:	ae8080e7          	jalr	-1304(ra) # 80001938 <_ZN15MemoryAllocator10freeMemoryEPv>
    80001e58:	fff00793          	li	a5,-1
    80001e5c:	02f50e63          	beq	a0,a5,80001e98 <_ZN6Kernel13sysThreadExitEPNS_21ArgumentsOfSystemCallE+0x68>
    TCB::running->isFinished = true;
    80001e60:	00004797          	auipc	a5,0x4
    80001e64:	ab07b783          	ld	a5,-1360(a5) # 80005910 <_GLOBAL_OFFSET_TABLE_+0x20>
    80001e68:	0007b583          	ld	a1,0(a5)
    80001e6c:	00100793          	li	a5,1
    80001e70:	02f58c23          	sb	a5,56(a1)
    Kernel::poolOfThreads->freeObject(TCB::running);
    80001e74:	00004517          	auipc	a0,0x4
    80001e78:	d4c53503          	ld	a0,-692(a0) # 80005bc0 <_ZN6Kernel13poolOfThreadsE>
    80001e7c:	00000097          	auipc	ra,0x0
    80001e80:	0fc080e7          	jalr	252(ra) # 80001f78 <_ZN10ObjectPoolI3TCBLm20EE10freeObjectEPS0_>
    return 0;
    80001e84:	00000513          	li	a0,0
}
    80001e88:	00813083          	ld	ra,8(sp)
    80001e8c:	00013403          	ld	s0,0(sp)
    80001e90:	01010113          	addi	sp,sp,16
    80001e94:	00008067          	ret
        return -1;
    80001e98:	fff00513          	li	a0,-1
    80001e9c:	fedff06f          	j	80001e88 <_ZN6Kernel13sysThreadExitEPNS_21ArgumentsOfSystemCallE+0x58>

0000000080001ea0 <_ZN6Kernel15sysThreadCreateEPNS_21ArgumentsOfSystemCallE>:
{
    80001ea0:	fe010113          	addi	sp,sp,-32
    80001ea4:	00113c23          	sd	ra,24(sp)
    80001ea8:	00813823          	sd	s0,16(sp)
    80001eac:	00913423          	sd	s1,8(sp)
    80001eb0:	02010413          	addi	s0,sp,32
    80001eb4:	00050493          	mv	s1,a0
    TCB* newThread = poolOfThreads->mallocObject();
    80001eb8:	00004517          	auipc	a0,0x4
    80001ebc:	d0853503          	ld	a0,-760(a0) # 80005bc0 <_ZN6Kernel13poolOfThreadsE>
    80001ec0:	00000097          	auipc	ra,0x0
    80001ec4:	128080e7          	jalr	296(ra) # 80001fe8 <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEv>
    if(!newThread)
    80001ec8:	02050c63          	beqz	a0,80001f00 <_ZN6Kernel15sysThreadCreateEPNS_21ArgumentsOfSystemCallE+0x60>
    __asm__ volatile("sd %[ptrThread], 0(%[handle])"::[ptrThread]"r"(newThread), [handle]"r"(arg->a0));
    80001ecc:	0004b783          	ld	a5,0(s1)
    80001ed0:	00a7b023          	sd	a0,0(a5)
    newThread->initializeThread((TCB::Body) arg->a1, (void*)arg->a2, (void*)arg->a3);
    80001ed4:	0184b683          	ld	a3,24(s1)
    80001ed8:	0104b603          	ld	a2,16(s1)
    80001edc:	0084b583          	ld	a1,8(s1)
    80001ee0:	fffff097          	auipc	ra,0xfffff
    80001ee4:	62c080e7          	jalr	1580(ra) # 8000150c <_ZN3TCB16initializeThreadEPFvPvES0_S0_>
    return 0;
    80001ee8:	00000513          	li	a0,0
}
    80001eec:	01813083          	ld	ra,24(sp)
    80001ef0:	01013403          	ld	s0,16(sp)
    80001ef4:	00813483          	ld	s1,8(sp)
    80001ef8:	02010113          	addi	sp,sp,32
    80001efc:	00008067          	ret
        return -1;
    80001f00:	fff00513          	li	a0,-1
    80001f04:	fe9ff06f          	j	80001eec <_ZN6Kernel15sysThreadCreateEPNS_21ArgumentsOfSystemCallE+0x4c>

0000000080001f08 <_GLOBAL__sub_I__ZN6Kernel16systemCallsTableE>:
    80001f08:	ff010113          	addi	sp,sp,-16
    80001f0c:	00113423          	sd	ra,8(sp)
    80001f10:	00813023          	sd	s0,0(sp)
    80001f14:	01010413          	addi	s0,sp,16
    80001f18:	000105b7          	lui	a1,0x10
    80001f1c:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    80001f20:	00100513          	li	a0,1
    80001f24:	00000097          	auipc	ra,0x0
    80001f28:	e5c080e7          	jalr	-420(ra) # 80001d80 <_Z41__static_initialization_and_destruction_0ii>
    80001f2c:	00813083          	ld	ra,8(sp)
    80001f30:	00013403          	ld	s0,0(sp)
    80001f34:	01010113          	addi	sp,sp,16
    80001f38:	00008067          	ret

0000000080001f3c <_ZN10ObjectPoolI3TCBLm20EEnwEm>:
template<typename T, size_t numOfObjects>
size_t ObjectPool<T, numOfObjects>::countOfPools = 0;


template<typename T, size_t numOfObjects>
void* ObjectPool<T, numOfObjects>::operator new(size_t size)
    80001f3c:	ff010113          	addi	sp,sp,-16
    80001f40:	00113423          	sd	ra,8(sp)
    80001f44:	00813023          	sd	s0,0(sp)
    80001f48:	01010413          	addi	s0,sp,16
{
    size_t numOfBlocks = size / MEM_BLOCK_SIZE;
    80001f4c:	00655793          	srli	a5,a0,0x6
    numOfBlocks += size % MEM_BLOCK_SIZE ? 1 : 0;
    80001f50:	03f57513          	andi	a0,a0,63
    80001f54:	00050463          	beqz	a0,80001f5c <_ZN10ObjectPoolI3TCBLm20EEnwEm+0x20>
    80001f58:	00100513          	li	a0,1
    return MemoryAllocator::allocateMemory(numOfBlocks);
    80001f5c:	00f50533          	add	a0,a0,a5
    80001f60:	00000097          	auipc	ra,0x0
    80001f64:	87c080e7          	jalr	-1924(ra) # 800017dc <_ZN15MemoryAllocator14allocateMemoryEm>
}
    80001f68:	00813083          	ld	ra,8(sp)
    80001f6c:	00013403          	ld	s0,0(sp)
    80001f70:	01010113          	addi	sp,sp,16
    80001f74:	00008067          	ret

0000000080001f78 <_ZN10ObjectPoolI3TCBLm20EE10freeObjectEPS0_>:
        return &(temp->object);
    }
}

template<typename T, size_t numOfObjects>
int ObjectPool<T, numOfObjects>::freeObject(T *obj) {
    80001f78:	ff010113          	addi	sp,sp,-16
    80001f7c:	00813423          	sd	s0,8(sp)
    80001f80:	01010413          	addi	s0,sp,16

    ObjectPool<T, numOfObjects>* curr = this;
    for(; curr->nextObjectPool; curr = curr->nextObjectPool)
    80001f84:	00050793          	mv	a5,a0
    80001f88:	5a853503          	ld	a0,1448(a0)
    80001f8c:	00050863          	beqz	a0,80001f9c <_ZN10ObjectPoolI3TCBLm20EE10freeObjectEPS0_+0x24>
    {
        if(((uint64)curr->pool <= (uint64)obj) && ((uint64)obj <= (uint64)&(curr->pool[numOfObjects])))
    80001f90:	fef5eae3          	bltu	a1,a5,80001f84 <_ZN10ObjectPoolI3TCBLm20EE10freeObjectEPS0_+0xc>
    80001f94:	5a078693          	addi	a3,a5,1440
    80001f98:	feb6e6e3          	bltu	a3,a1,80001f84 <_ZN10ObjectPoolI3TCBLm20EE10freeObjectEPS0_+0xc>
        {
            break;
        }
    }
    PoolObject* tempObj = (PoolObject*)obj;
    tempObj->nextFree = curr->headFreeObject;
    80001f9c:	5a07b703          	ld	a4,1440(a5)
    80001fa0:	04e5b023          	sd	a4,64(a1)
    curr->headFreeObject = tempObj;
    80001fa4:	5ab7b023          	sd	a1,1440(a5)

    return 0;
}
    80001fa8:	00000513          	li	a0,0
    80001fac:	00813403          	ld	s0,8(sp)
    80001fb0:	01010113          	addi	sp,sp,16
    80001fb4:	00008067          	ret

0000000080001fb8 <_ZN10ObjectPoolI3TCBLm20EE12findFreePoolEv>:
ObjectPool<T, numOfObjects>* ObjectPool<T, numOfObjects>::findFreePool(void)
    80001fb8:	ff010113          	addi	sp,sp,-16
    80001fbc:	00813423          	sd	s0,8(sp)
    80001fc0:	01010413          	addi	s0,sp,16
    80001fc4:	00050793          	mv	a5,a0
    for(; !curr->nextObjectPool && !curr->headFreeObject; curr = curr->nextObjectPool);
    80001fc8:	00078513          	mv	a0,a5
    80001fcc:	5a87b783          	ld	a5,1448(a5)
    80001fd0:	00079663          	bnez	a5,80001fdc <_ZN10ObjectPoolI3TCBLm20EE12findFreePoolEv+0x24>
    80001fd4:	5a053703          	ld	a4,1440(a0)
    80001fd8:	fe0708e3          	beqz	a4,80001fc8 <_ZN10ObjectPoolI3TCBLm20EE12findFreePoolEv+0x10>
}
    80001fdc:	00813403          	ld	s0,8(sp)
    80001fe0:	01010113          	addi	sp,sp,16
    80001fe4:	00008067          	ret

0000000080001fe8 <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEv>:
T* ObjectPool<T, numOfObjects>::mallocObject(void)
    80001fe8:	fe010113          	addi	sp,sp,-32
    80001fec:	00113c23          	sd	ra,24(sp)
    80001ff0:	00813823          	sd	s0,16(sp)
    80001ff4:	00913423          	sd	s1,8(sp)
    80001ff8:	02010413          	addi	s0,sp,32
    ObjectPool<T,numOfObjects>* currentPool = findFreePool();
    80001ffc:	00000097          	auipc	ra,0x0
    80002000:	fbc080e7          	jalr	-68(ra) # 80001fb8 <_ZN10ObjectPoolI3TCBLm20EE12findFreePoolEv>
    80002004:	00050493          	mv	s1,a0
    if (currentPool->headFreeObject)
    80002008:	5a053503          	ld	a0,1440(a0)
    8000200c:	02050063          	beqz	a0,8000202c <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEv+0x44>
        currentPool->headFreeObject = currentPool->headFreeObject->nextFree;
    80002010:	04053783          	ld	a5,64(a0)
    80002014:	5af4b023          	sd	a5,1440(s1)
}
    80002018:	01813083          	ld	ra,24(sp)
    8000201c:	01013403          	ld	s0,16(sp)
    80002020:	00813483          	ld	s1,8(sp)
    80002024:	02010113          	addi	sp,sp,32
    80002028:	00008067          	ret
        ObjectPool<T, numOfObjects>* newPool = new ObjectPool();
    8000202c:	5c000513          	li	a0,1472
    80002030:	00000097          	auipc	ra,0x0
    80002034:	f0c080e7          	jalr	-244(ra) # 80001f3c <_ZN10ObjectPoolI3TCBLm20EEnwEm>
    ObjectPool(): headFreeObject(pool), nextObjectPool(nullptr), prevObjectPool(nullptr), id(countOfPools++)
    80002038:	5aa53023          	sd	a0,1440(a0)
    8000203c:	5a053423          	sd	zero,1448(a0)
    80002040:	5a053823          	sd	zero,1456(a0)
    80002044:	00004717          	auipc	a4,0x4
    80002048:	b8470713          	addi	a4,a4,-1148 # 80005bc8 <_ZN10ObjectPoolI3TCBLm20EE12countOfPoolsE>
    8000204c:	00073783          	ld	a5,0(a4)
    80002050:	00178693          	addi	a3,a5,1
    80002054:	00d73023          	sd	a3,0(a4)
    80002058:	5af53c23          	sd	a5,1464(a0)
        for(size_t i = 0; i < numOfObjects - 1; i++)
    8000205c:	00000693          	li	a3,0
    80002060:	01200793          	li	a5,18
    80002064:	02d7ea63          	bltu	a5,a3,80002098 <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEv+0xb0>
            pool[i].nextFree = &(pool[i+1]);
    80002068:	00168613          	addi	a2,a3,1
    8000206c:	00361713          	slli	a4,a2,0x3
    80002070:	00c70733          	add	a4,a4,a2
    80002074:	00371713          	slli	a4,a4,0x3
    80002078:	00e50733          	add	a4,a0,a4
    8000207c:	00369793          	slli	a5,a3,0x3
    80002080:	00d787b3          	add	a5,a5,a3
    80002084:	00379793          	slli	a5,a5,0x3
    80002088:	00f507b3          	add	a5,a0,a5
    8000208c:	04e7b023          	sd	a4,64(a5)
        for(size_t i = 0; i < numOfObjects - 1; i++)
    80002090:	00060693          	mv	a3,a2
    80002094:	fcdff06f          	j	80002060 <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEv+0x78>
        pool[numOfObjects - 1].nextFree = nullptr;
    80002098:	58053c23          	sd	zero,1432(a0)
        if(!newPool)
    8000209c:	f6050ee3          	beqz	a0,80002018 <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEv+0x30>
        newPool->prevObjectPool = currentPool;
    800020a0:	5a953823          	sd	s1,1456(a0)
        currentPool->nextObjectPool = newPool;
    800020a4:	5aa4b423          	sd	a0,1448(s1)
        PoolObject* temp = newPool->headFreeObject;
    800020a8:	5a053783          	ld	a5,1440(a0)
        newPool->headFreeObject = newPool->headFreeObject->nextFree;
    800020ac:	0407b703          	ld	a4,64(a5)
    800020b0:	5ae53023          	sd	a4,1440(a0)
        return &(temp->object);
    800020b4:	00078513          	mv	a0,a5
    800020b8:	f61ff06f          	j	80002018 <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEv+0x30>

00000000800020bc <start>:
    800020bc:	ff010113          	addi	sp,sp,-16
    800020c0:	00813423          	sd	s0,8(sp)
    800020c4:	01010413          	addi	s0,sp,16
    800020c8:	300027f3          	csrr	a5,mstatus
    800020cc:	ffffe737          	lui	a4,0xffffe
    800020d0:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff79df>
    800020d4:	00e7f7b3          	and	a5,a5,a4
    800020d8:	00001737          	lui	a4,0x1
    800020dc:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    800020e0:	00e7e7b3          	or	a5,a5,a4
    800020e4:	30079073          	csrw	mstatus,a5
    800020e8:	00000797          	auipc	a5,0x0
    800020ec:	16078793          	addi	a5,a5,352 # 80002248 <system_main>
    800020f0:	34179073          	csrw	mepc,a5
    800020f4:	00000793          	li	a5,0
    800020f8:	18079073          	csrw	satp,a5
    800020fc:	000107b7          	lui	a5,0x10
    80002100:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80002104:	30279073          	csrw	medeleg,a5
    80002108:	30379073          	csrw	mideleg,a5
    8000210c:	104027f3          	csrr	a5,sie
    80002110:	2227e793          	ori	a5,a5,546
    80002114:	10479073          	csrw	sie,a5
    80002118:	fff00793          	li	a5,-1
    8000211c:	00a7d793          	srli	a5,a5,0xa
    80002120:	3b079073          	csrw	pmpaddr0,a5
    80002124:	00f00793          	li	a5,15
    80002128:	3a079073          	csrw	pmpcfg0,a5
    8000212c:	f14027f3          	csrr	a5,mhartid
    80002130:	0200c737          	lui	a4,0x200c
    80002134:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80002138:	0007869b          	sext.w	a3,a5
    8000213c:	00269713          	slli	a4,a3,0x2
    80002140:	000f4637          	lui	a2,0xf4
    80002144:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80002148:	00d70733          	add	a4,a4,a3
    8000214c:	0037979b          	slliw	a5,a5,0x3
    80002150:	020046b7          	lui	a3,0x2004
    80002154:	00d787b3          	add	a5,a5,a3
    80002158:	00c585b3          	add	a1,a1,a2
    8000215c:	00371693          	slli	a3,a4,0x3
    80002160:	00004717          	auipc	a4,0x4
    80002164:	a7070713          	addi	a4,a4,-1424 # 80005bd0 <timer_scratch>
    80002168:	00b7b023          	sd	a1,0(a5)
    8000216c:	00d70733          	add	a4,a4,a3
    80002170:	00f73c23          	sd	a5,24(a4)
    80002174:	02c73023          	sd	a2,32(a4)
    80002178:	34071073          	csrw	mscratch,a4
    8000217c:	00000797          	auipc	a5,0x0
    80002180:	6e478793          	addi	a5,a5,1764 # 80002860 <timervec>
    80002184:	30579073          	csrw	mtvec,a5
    80002188:	300027f3          	csrr	a5,mstatus
    8000218c:	0087e793          	ori	a5,a5,8
    80002190:	30079073          	csrw	mstatus,a5
    80002194:	304027f3          	csrr	a5,mie
    80002198:	0807e793          	ori	a5,a5,128
    8000219c:	30479073          	csrw	mie,a5
    800021a0:	f14027f3          	csrr	a5,mhartid
    800021a4:	0007879b          	sext.w	a5,a5
    800021a8:	00078213          	mv	tp,a5
    800021ac:	30200073          	mret
    800021b0:	00813403          	ld	s0,8(sp)
    800021b4:	01010113          	addi	sp,sp,16
    800021b8:	00008067          	ret

00000000800021bc <timerinit>:
    800021bc:	ff010113          	addi	sp,sp,-16
    800021c0:	00813423          	sd	s0,8(sp)
    800021c4:	01010413          	addi	s0,sp,16
    800021c8:	f14027f3          	csrr	a5,mhartid
    800021cc:	0200c737          	lui	a4,0x200c
    800021d0:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800021d4:	0007869b          	sext.w	a3,a5
    800021d8:	00269713          	slli	a4,a3,0x2
    800021dc:	000f4637          	lui	a2,0xf4
    800021e0:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800021e4:	00d70733          	add	a4,a4,a3
    800021e8:	0037979b          	slliw	a5,a5,0x3
    800021ec:	020046b7          	lui	a3,0x2004
    800021f0:	00d787b3          	add	a5,a5,a3
    800021f4:	00c585b3          	add	a1,a1,a2
    800021f8:	00371693          	slli	a3,a4,0x3
    800021fc:	00004717          	auipc	a4,0x4
    80002200:	9d470713          	addi	a4,a4,-1580 # 80005bd0 <timer_scratch>
    80002204:	00b7b023          	sd	a1,0(a5)
    80002208:	00d70733          	add	a4,a4,a3
    8000220c:	00f73c23          	sd	a5,24(a4)
    80002210:	02c73023          	sd	a2,32(a4)
    80002214:	34071073          	csrw	mscratch,a4
    80002218:	00000797          	auipc	a5,0x0
    8000221c:	64878793          	addi	a5,a5,1608 # 80002860 <timervec>
    80002220:	30579073          	csrw	mtvec,a5
    80002224:	300027f3          	csrr	a5,mstatus
    80002228:	0087e793          	ori	a5,a5,8
    8000222c:	30079073          	csrw	mstatus,a5
    80002230:	304027f3          	csrr	a5,mie
    80002234:	0807e793          	ori	a5,a5,128
    80002238:	30479073          	csrw	mie,a5
    8000223c:	00813403          	ld	s0,8(sp)
    80002240:	01010113          	addi	sp,sp,16
    80002244:	00008067          	ret

0000000080002248 <system_main>:
    80002248:	fe010113          	addi	sp,sp,-32
    8000224c:	00813823          	sd	s0,16(sp)
    80002250:	00913423          	sd	s1,8(sp)
    80002254:	00113c23          	sd	ra,24(sp)
    80002258:	02010413          	addi	s0,sp,32
    8000225c:	00000097          	auipc	ra,0x0
    80002260:	0c4080e7          	jalr	196(ra) # 80002320 <cpuid>
    80002264:	00003497          	auipc	s1,0x3
    80002268:	6dc48493          	addi	s1,s1,1756 # 80005940 <started>
    8000226c:	02050263          	beqz	a0,80002290 <system_main+0x48>
    80002270:	0004a783          	lw	a5,0(s1)
    80002274:	0007879b          	sext.w	a5,a5
    80002278:	fe078ce3          	beqz	a5,80002270 <system_main+0x28>
    8000227c:	0ff0000f          	fence
    80002280:	00003517          	auipc	a0,0x3
    80002284:	dd850513          	addi	a0,a0,-552 # 80005058 <_ZN3TCB25DEFAULT_SYSTEM_STACK_SIZEE+0x38>
    80002288:	00001097          	auipc	ra,0x1
    8000228c:	a74080e7          	jalr	-1420(ra) # 80002cfc <panic>
    80002290:	00001097          	auipc	ra,0x1
    80002294:	9c8080e7          	jalr	-1592(ra) # 80002c58 <consoleinit>
    80002298:	00001097          	auipc	ra,0x1
    8000229c:	154080e7          	jalr	340(ra) # 800033ec <printfinit>
    800022a0:	00003517          	auipc	a0,0x3
    800022a4:	e9850513          	addi	a0,a0,-360 # 80005138 <_ZN3TCB25DEFAULT_SYSTEM_STACK_SIZEE+0x118>
    800022a8:	00001097          	auipc	ra,0x1
    800022ac:	ab0080e7          	jalr	-1360(ra) # 80002d58 <__printf>
    800022b0:	00003517          	auipc	a0,0x3
    800022b4:	d7850513          	addi	a0,a0,-648 # 80005028 <_ZN3TCB25DEFAULT_SYSTEM_STACK_SIZEE+0x8>
    800022b8:	00001097          	auipc	ra,0x1
    800022bc:	aa0080e7          	jalr	-1376(ra) # 80002d58 <__printf>
    800022c0:	00003517          	auipc	a0,0x3
    800022c4:	e7850513          	addi	a0,a0,-392 # 80005138 <_ZN3TCB25DEFAULT_SYSTEM_STACK_SIZEE+0x118>
    800022c8:	00001097          	auipc	ra,0x1
    800022cc:	a90080e7          	jalr	-1392(ra) # 80002d58 <__printf>
    800022d0:	00001097          	auipc	ra,0x1
    800022d4:	4a8080e7          	jalr	1192(ra) # 80003778 <kinit>
    800022d8:	00000097          	auipc	ra,0x0
    800022dc:	148080e7          	jalr	328(ra) # 80002420 <trapinit>
    800022e0:	00000097          	auipc	ra,0x0
    800022e4:	16c080e7          	jalr	364(ra) # 8000244c <trapinithart>
    800022e8:	00000097          	auipc	ra,0x0
    800022ec:	5b8080e7          	jalr	1464(ra) # 800028a0 <plicinit>
    800022f0:	00000097          	auipc	ra,0x0
    800022f4:	5d8080e7          	jalr	1496(ra) # 800028c8 <plicinithart>
    800022f8:	00000097          	auipc	ra,0x0
    800022fc:	078080e7          	jalr	120(ra) # 80002370 <userinit>
    80002300:	0ff0000f          	fence
    80002304:	00100793          	li	a5,1
    80002308:	00003517          	auipc	a0,0x3
    8000230c:	d3850513          	addi	a0,a0,-712 # 80005040 <_ZN3TCB25DEFAULT_SYSTEM_STACK_SIZEE+0x20>
    80002310:	00f4a023          	sw	a5,0(s1)
    80002314:	00001097          	auipc	ra,0x1
    80002318:	a44080e7          	jalr	-1468(ra) # 80002d58 <__printf>
    8000231c:	0000006f          	j	8000231c <system_main+0xd4>

0000000080002320 <cpuid>:
    80002320:	ff010113          	addi	sp,sp,-16
    80002324:	00813423          	sd	s0,8(sp)
    80002328:	01010413          	addi	s0,sp,16
    8000232c:	00020513          	mv	a0,tp
    80002330:	00813403          	ld	s0,8(sp)
    80002334:	0005051b          	sext.w	a0,a0
    80002338:	01010113          	addi	sp,sp,16
    8000233c:	00008067          	ret

0000000080002340 <mycpu>:
    80002340:	ff010113          	addi	sp,sp,-16
    80002344:	00813423          	sd	s0,8(sp)
    80002348:	01010413          	addi	s0,sp,16
    8000234c:	00020793          	mv	a5,tp
    80002350:	00813403          	ld	s0,8(sp)
    80002354:	0007879b          	sext.w	a5,a5
    80002358:	00779793          	slli	a5,a5,0x7
    8000235c:	00005517          	auipc	a0,0x5
    80002360:	8a450513          	addi	a0,a0,-1884 # 80006c00 <cpus>
    80002364:	00f50533          	add	a0,a0,a5
    80002368:	01010113          	addi	sp,sp,16
    8000236c:	00008067          	ret

0000000080002370 <userinit>:
    80002370:	ff010113          	addi	sp,sp,-16
    80002374:	00813423          	sd	s0,8(sp)
    80002378:	01010413          	addi	s0,sp,16
    8000237c:	00813403          	ld	s0,8(sp)
    80002380:	01010113          	addi	sp,sp,16
    80002384:	fffff317          	auipc	t1,0xfffff
    80002388:	13430067          	jr	308(t1) # 800014b8 <main>

000000008000238c <either_copyout>:
    8000238c:	ff010113          	addi	sp,sp,-16
    80002390:	00813023          	sd	s0,0(sp)
    80002394:	00113423          	sd	ra,8(sp)
    80002398:	01010413          	addi	s0,sp,16
    8000239c:	02051663          	bnez	a0,800023c8 <either_copyout+0x3c>
    800023a0:	00058513          	mv	a0,a1
    800023a4:	00060593          	mv	a1,a2
    800023a8:	0006861b          	sext.w	a2,a3
    800023ac:	00002097          	auipc	ra,0x2
    800023b0:	c58080e7          	jalr	-936(ra) # 80004004 <__memmove>
    800023b4:	00813083          	ld	ra,8(sp)
    800023b8:	00013403          	ld	s0,0(sp)
    800023bc:	00000513          	li	a0,0
    800023c0:	01010113          	addi	sp,sp,16
    800023c4:	00008067          	ret
    800023c8:	00003517          	auipc	a0,0x3
    800023cc:	cb850513          	addi	a0,a0,-840 # 80005080 <_ZN3TCB25DEFAULT_SYSTEM_STACK_SIZEE+0x60>
    800023d0:	00001097          	auipc	ra,0x1
    800023d4:	92c080e7          	jalr	-1748(ra) # 80002cfc <panic>

00000000800023d8 <either_copyin>:
    800023d8:	ff010113          	addi	sp,sp,-16
    800023dc:	00813023          	sd	s0,0(sp)
    800023e0:	00113423          	sd	ra,8(sp)
    800023e4:	01010413          	addi	s0,sp,16
    800023e8:	02059463          	bnez	a1,80002410 <either_copyin+0x38>
    800023ec:	00060593          	mv	a1,a2
    800023f0:	0006861b          	sext.w	a2,a3
    800023f4:	00002097          	auipc	ra,0x2
    800023f8:	c10080e7          	jalr	-1008(ra) # 80004004 <__memmove>
    800023fc:	00813083          	ld	ra,8(sp)
    80002400:	00013403          	ld	s0,0(sp)
    80002404:	00000513          	li	a0,0
    80002408:	01010113          	addi	sp,sp,16
    8000240c:	00008067          	ret
    80002410:	00003517          	auipc	a0,0x3
    80002414:	c9850513          	addi	a0,a0,-872 # 800050a8 <_ZN3TCB25DEFAULT_SYSTEM_STACK_SIZEE+0x88>
    80002418:	00001097          	auipc	ra,0x1
    8000241c:	8e4080e7          	jalr	-1820(ra) # 80002cfc <panic>

0000000080002420 <trapinit>:
    80002420:	ff010113          	addi	sp,sp,-16
    80002424:	00813423          	sd	s0,8(sp)
    80002428:	01010413          	addi	s0,sp,16
    8000242c:	00813403          	ld	s0,8(sp)
    80002430:	00003597          	auipc	a1,0x3
    80002434:	ca058593          	addi	a1,a1,-864 # 800050d0 <_ZN3TCB25DEFAULT_SYSTEM_STACK_SIZEE+0xb0>
    80002438:	00005517          	auipc	a0,0x5
    8000243c:	84850513          	addi	a0,a0,-1976 # 80006c80 <tickslock>
    80002440:	01010113          	addi	sp,sp,16
    80002444:	00001317          	auipc	t1,0x1
    80002448:	5c430067          	jr	1476(t1) # 80003a08 <initlock>

000000008000244c <trapinithart>:
    8000244c:	ff010113          	addi	sp,sp,-16
    80002450:	00813423          	sd	s0,8(sp)
    80002454:	01010413          	addi	s0,sp,16
    80002458:	00000797          	auipc	a5,0x0
    8000245c:	2f878793          	addi	a5,a5,760 # 80002750 <kernelvec>
    80002460:	10579073          	csrw	stvec,a5
    80002464:	00813403          	ld	s0,8(sp)
    80002468:	01010113          	addi	sp,sp,16
    8000246c:	00008067          	ret

0000000080002470 <usertrap>:
    80002470:	ff010113          	addi	sp,sp,-16
    80002474:	00813423          	sd	s0,8(sp)
    80002478:	01010413          	addi	s0,sp,16
    8000247c:	00813403          	ld	s0,8(sp)
    80002480:	01010113          	addi	sp,sp,16
    80002484:	00008067          	ret

0000000080002488 <usertrapret>:
    80002488:	ff010113          	addi	sp,sp,-16
    8000248c:	00813423          	sd	s0,8(sp)
    80002490:	01010413          	addi	s0,sp,16
    80002494:	00813403          	ld	s0,8(sp)
    80002498:	01010113          	addi	sp,sp,16
    8000249c:	00008067          	ret

00000000800024a0 <kerneltrap>:
    800024a0:	fe010113          	addi	sp,sp,-32
    800024a4:	00813823          	sd	s0,16(sp)
    800024a8:	00113c23          	sd	ra,24(sp)
    800024ac:	00913423          	sd	s1,8(sp)
    800024b0:	02010413          	addi	s0,sp,32
    800024b4:	142025f3          	csrr	a1,scause
    800024b8:	100027f3          	csrr	a5,sstatus
    800024bc:	0027f793          	andi	a5,a5,2
    800024c0:	10079c63          	bnez	a5,800025d8 <kerneltrap+0x138>
    800024c4:	142027f3          	csrr	a5,scause
    800024c8:	0207ce63          	bltz	a5,80002504 <kerneltrap+0x64>
    800024cc:	00003517          	auipc	a0,0x3
    800024d0:	c4c50513          	addi	a0,a0,-948 # 80005118 <_ZN3TCB25DEFAULT_SYSTEM_STACK_SIZEE+0xf8>
    800024d4:	00001097          	auipc	ra,0x1
    800024d8:	884080e7          	jalr	-1916(ra) # 80002d58 <__printf>
    800024dc:	141025f3          	csrr	a1,sepc
    800024e0:	14302673          	csrr	a2,stval
    800024e4:	00003517          	auipc	a0,0x3
    800024e8:	c4450513          	addi	a0,a0,-956 # 80005128 <_ZN3TCB25DEFAULT_SYSTEM_STACK_SIZEE+0x108>
    800024ec:	00001097          	auipc	ra,0x1
    800024f0:	86c080e7          	jalr	-1940(ra) # 80002d58 <__printf>
    800024f4:	00003517          	auipc	a0,0x3
    800024f8:	c4c50513          	addi	a0,a0,-948 # 80005140 <_ZN3TCB25DEFAULT_SYSTEM_STACK_SIZEE+0x120>
    800024fc:	00001097          	auipc	ra,0x1
    80002500:	800080e7          	jalr	-2048(ra) # 80002cfc <panic>
    80002504:	0ff7f713          	andi	a4,a5,255
    80002508:	00900693          	li	a3,9
    8000250c:	04d70063          	beq	a4,a3,8000254c <kerneltrap+0xac>
    80002510:	fff00713          	li	a4,-1
    80002514:	03f71713          	slli	a4,a4,0x3f
    80002518:	00170713          	addi	a4,a4,1
    8000251c:	fae798e3          	bne	a5,a4,800024cc <kerneltrap+0x2c>
    80002520:	00000097          	auipc	ra,0x0
    80002524:	e00080e7          	jalr	-512(ra) # 80002320 <cpuid>
    80002528:	06050663          	beqz	a0,80002594 <kerneltrap+0xf4>
    8000252c:	144027f3          	csrr	a5,sip
    80002530:	ffd7f793          	andi	a5,a5,-3
    80002534:	14479073          	csrw	sip,a5
    80002538:	01813083          	ld	ra,24(sp)
    8000253c:	01013403          	ld	s0,16(sp)
    80002540:	00813483          	ld	s1,8(sp)
    80002544:	02010113          	addi	sp,sp,32
    80002548:	00008067          	ret
    8000254c:	00000097          	auipc	ra,0x0
    80002550:	3c8080e7          	jalr	968(ra) # 80002914 <plic_claim>
    80002554:	00a00793          	li	a5,10
    80002558:	00050493          	mv	s1,a0
    8000255c:	06f50863          	beq	a0,a5,800025cc <kerneltrap+0x12c>
    80002560:	fc050ce3          	beqz	a0,80002538 <kerneltrap+0x98>
    80002564:	00050593          	mv	a1,a0
    80002568:	00003517          	auipc	a0,0x3
    8000256c:	b9050513          	addi	a0,a0,-1136 # 800050f8 <_ZN3TCB25DEFAULT_SYSTEM_STACK_SIZEE+0xd8>
    80002570:	00000097          	auipc	ra,0x0
    80002574:	7e8080e7          	jalr	2024(ra) # 80002d58 <__printf>
    80002578:	01013403          	ld	s0,16(sp)
    8000257c:	01813083          	ld	ra,24(sp)
    80002580:	00048513          	mv	a0,s1
    80002584:	00813483          	ld	s1,8(sp)
    80002588:	02010113          	addi	sp,sp,32
    8000258c:	00000317          	auipc	t1,0x0
    80002590:	3c030067          	jr	960(t1) # 8000294c <plic_complete>
    80002594:	00004517          	auipc	a0,0x4
    80002598:	6ec50513          	addi	a0,a0,1772 # 80006c80 <tickslock>
    8000259c:	00001097          	auipc	ra,0x1
    800025a0:	490080e7          	jalr	1168(ra) # 80003a2c <acquire>
    800025a4:	00003717          	auipc	a4,0x3
    800025a8:	3a070713          	addi	a4,a4,928 # 80005944 <ticks>
    800025ac:	00072783          	lw	a5,0(a4)
    800025b0:	00004517          	auipc	a0,0x4
    800025b4:	6d050513          	addi	a0,a0,1744 # 80006c80 <tickslock>
    800025b8:	0017879b          	addiw	a5,a5,1
    800025bc:	00f72023          	sw	a5,0(a4)
    800025c0:	00001097          	auipc	ra,0x1
    800025c4:	538080e7          	jalr	1336(ra) # 80003af8 <release>
    800025c8:	f65ff06f          	j	8000252c <kerneltrap+0x8c>
    800025cc:	00001097          	auipc	ra,0x1
    800025d0:	094080e7          	jalr	148(ra) # 80003660 <uartintr>
    800025d4:	fa5ff06f          	j	80002578 <kerneltrap+0xd8>
    800025d8:	00003517          	auipc	a0,0x3
    800025dc:	b0050513          	addi	a0,a0,-1280 # 800050d8 <_ZN3TCB25DEFAULT_SYSTEM_STACK_SIZEE+0xb8>
    800025e0:	00000097          	auipc	ra,0x0
    800025e4:	71c080e7          	jalr	1820(ra) # 80002cfc <panic>

00000000800025e8 <clockintr>:
    800025e8:	fe010113          	addi	sp,sp,-32
    800025ec:	00813823          	sd	s0,16(sp)
    800025f0:	00913423          	sd	s1,8(sp)
    800025f4:	00113c23          	sd	ra,24(sp)
    800025f8:	02010413          	addi	s0,sp,32
    800025fc:	00004497          	auipc	s1,0x4
    80002600:	68448493          	addi	s1,s1,1668 # 80006c80 <tickslock>
    80002604:	00048513          	mv	a0,s1
    80002608:	00001097          	auipc	ra,0x1
    8000260c:	424080e7          	jalr	1060(ra) # 80003a2c <acquire>
    80002610:	00003717          	auipc	a4,0x3
    80002614:	33470713          	addi	a4,a4,820 # 80005944 <ticks>
    80002618:	00072783          	lw	a5,0(a4)
    8000261c:	01013403          	ld	s0,16(sp)
    80002620:	01813083          	ld	ra,24(sp)
    80002624:	00048513          	mv	a0,s1
    80002628:	0017879b          	addiw	a5,a5,1
    8000262c:	00813483          	ld	s1,8(sp)
    80002630:	00f72023          	sw	a5,0(a4)
    80002634:	02010113          	addi	sp,sp,32
    80002638:	00001317          	auipc	t1,0x1
    8000263c:	4c030067          	jr	1216(t1) # 80003af8 <release>

0000000080002640 <devintr>:
    80002640:	142027f3          	csrr	a5,scause
    80002644:	00000513          	li	a0,0
    80002648:	0007c463          	bltz	a5,80002650 <devintr+0x10>
    8000264c:	00008067          	ret
    80002650:	fe010113          	addi	sp,sp,-32
    80002654:	00813823          	sd	s0,16(sp)
    80002658:	00113c23          	sd	ra,24(sp)
    8000265c:	00913423          	sd	s1,8(sp)
    80002660:	02010413          	addi	s0,sp,32
    80002664:	0ff7f713          	andi	a4,a5,255
    80002668:	00900693          	li	a3,9
    8000266c:	04d70c63          	beq	a4,a3,800026c4 <devintr+0x84>
    80002670:	fff00713          	li	a4,-1
    80002674:	03f71713          	slli	a4,a4,0x3f
    80002678:	00170713          	addi	a4,a4,1
    8000267c:	00e78c63          	beq	a5,a4,80002694 <devintr+0x54>
    80002680:	01813083          	ld	ra,24(sp)
    80002684:	01013403          	ld	s0,16(sp)
    80002688:	00813483          	ld	s1,8(sp)
    8000268c:	02010113          	addi	sp,sp,32
    80002690:	00008067          	ret
    80002694:	00000097          	auipc	ra,0x0
    80002698:	c8c080e7          	jalr	-884(ra) # 80002320 <cpuid>
    8000269c:	06050663          	beqz	a0,80002708 <devintr+0xc8>
    800026a0:	144027f3          	csrr	a5,sip
    800026a4:	ffd7f793          	andi	a5,a5,-3
    800026a8:	14479073          	csrw	sip,a5
    800026ac:	01813083          	ld	ra,24(sp)
    800026b0:	01013403          	ld	s0,16(sp)
    800026b4:	00813483          	ld	s1,8(sp)
    800026b8:	00200513          	li	a0,2
    800026bc:	02010113          	addi	sp,sp,32
    800026c0:	00008067          	ret
    800026c4:	00000097          	auipc	ra,0x0
    800026c8:	250080e7          	jalr	592(ra) # 80002914 <plic_claim>
    800026cc:	00a00793          	li	a5,10
    800026d0:	00050493          	mv	s1,a0
    800026d4:	06f50663          	beq	a0,a5,80002740 <devintr+0x100>
    800026d8:	00100513          	li	a0,1
    800026dc:	fa0482e3          	beqz	s1,80002680 <devintr+0x40>
    800026e0:	00048593          	mv	a1,s1
    800026e4:	00003517          	auipc	a0,0x3
    800026e8:	a1450513          	addi	a0,a0,-1516 # 800050f8 <_ZN3TCB25DEFAULT_SYSTEM_STACK_SIZEE+0xd8>
    800026ec:	00000097          	auipc	ra,0x0
    800026f0:	66c080e7          	jalr	1644(ra) # 80002d58 <__printf>
    800026f4:	00048513          	mv	a0,s1
    800026f8:	00000097          	auipc	ra,0x0
    800026fc:	254080e7          	jalr	596(ra) # 8000294c <plic_complete>
    80002700:	00100513          	li	a0,1
    80002704:	f7dff06f          	j	80002680 <devintr+0x40>
    80002708:	00004517          	auipc	a0,0x4
    8000270c:	57850513          	addi	a0,a0,1400 # 80006c80 <tickslock>
    80002710:	00001097          	auipc	ra,0x1
    80002714:	31c080e7          	jalr	796(ra) # 80003a2c <acquire>
    80002718:	00003717          	auipc	a4,0x3
    8000271c:	22c70713          	addi	a4,a4,556 # 80005944 <ticks>
    80002720:	00072783          	lw	a5,0(a4)
    80002724:	00004517          	auipc	a0,0x4
    80002728:	55c50513          	addi	a0,a0,1372 # 80006c80 <tickslock>
    8000272c:	0017879b          	addiw	a5,a5,1
    80002730:	00f72023          	sw	a5,0(a4)
    80002734:	00001097          	auipc	ra,0x1
    80002738:	3c4080e7          	jalr	964(ra) # 80003af8 <release>
    8000273c:	f65ff06f          	j	800026a0 <devintr+0x60>
    80002740:	00001097          	auipc	ra,0x1
    80002744:	f20080e7          	jalr	-224(ra) # 80003660 <uartintr>
    80002748:	fadff06f          	j	800026f4 <devintr+0xb4>
    8000274c:	0000                	unimp
	...

0000000080002750 <kernelvec>:
    80002750:	f0010113          	addi	sp,sp,-256
    80002754:	00113023          	sd	ra,0(sp)
    80002758:	00213423          	sd	sp,8(sp)
    8000275c:	00313823          	sd	gp,16(sp)
    80002760:	00413c23          	sd	tp,24(sp)
    80002764:	02513023          	sd	t0,32(sp)
    80002768:	02613423          	sd	t1,40(sp)
    8000276c:	02713823          	sd	t2,48(sp)
    80002770:	02813c23          	sd	s0,56(sp)
    80002774:	04913023          	sd	s1,64(sp)
    80002778:	04a13423          	sd	a0,72(sp)
    8000277c:	04b13823          	sd	a1,80(sp)
    80002780:	04c13c23          	sd	a2,88(sp)
    80002784:	06d13023          	sd	a3,96(sp)
    80002788:	06e13423          	sd	a4,104(sp)
    8000278c:	06f13823          	sd	a5,112(sp)
    80002790:	07013c23          	sd	a6,120(sp)
    80002794:	09113023          	sd	a7,128(sp)
    80002798:	09213423          	sd	s2,136(sp)
    8000279c:	09313823          	sd	s3,144(sp)
    800027a0:	09413c23          	sd	s4,152(sp)
    800027a4:	0b513023          	sd	s5,160(sp)
    800027a8:	0b613423          	sd	s6,168(sp)
    800027ac:	0b713823          	sd	s7,176(sp)
    800027b0:	0b813c23          	sd	s8,184(sp)
    800027b4:	0d913023          	sd	s9,192(sp)
    800027b8:	0da13423          	sd	s10,200(sp)
    800027bc:	0db13823          	sd	s11,208(sp)
    800027c0:	0dc13c23          	sd	t3,216(sp)
    800027c4:	0fd13023          	sd	t4,224(sp)
    800027c8:	0fe13423          	sd	t5,232(sp)
    800027cc:	0ff13823          	sd	t6,240(sp)
    800027d0:	cd1ff0ef          	jal	ra,800024a0 <kerneltrap>
    800027d4:	00013083          	ld	ra,0(sp)
    800027d8:	00813103          	ld	sp,8(sp)
    800027dc:	01013183          	ld	gp,16(sp)
    800027e0:	02013283          	ld	t0,32(sp)
    800027e4:	02813303          	ld	t1,40(sp)
    800027e8:	03013383          	ld	t2,48(sp)
    800027ec:	03813403          	ld	s0,56(sp)
    800027f0:	04013483          	ld	s1,64(sp)
    800027f4:	04813503          	ld	a0,72(sp)
    800027f8:	05013583          	ld	a1,80(sp)
    800027fc:	05813603          	ld	a2,88(sp)
    80002800:	06013683          	ld	a3,96(sp)
    80002804:	06813703          	ld	a4,104(sp)
    80002808:	07013783          	ld	a5,112(sp)
    8000280c:	07813803          	ld	a6,120(sp)
    80002810:	08013883          	ld	a7,128(sp)
    80002814:	08813903          	ld	s2,136(sp)
    80002818:	09013983          	ld	s3,144(sp)
    8000281c:	09813a03          	ld	s4,152(sp)
    80002820:	0a013a83          	ld	s5,160(sp)
    80002824:	0a813b03          	ld	s6,168(sp)
    80002828:	0b013b83          	ld	s7,176(sp)
    8000282c:	0b813c03          	ld	s8,184(sp)
    80002830:	0c013c83          	ld	s9,192(sp)
    80002834:	0c813d03          	ld	s10,200(sp)
    80002838:	0d013d83          	ld	s11,208(sp)
    8000283c:	0d813e03          	ld	t3,216(sp)
    80002840:	0e013e83          	ld	t4,224(sp)
    80002844:	0e813f03          	ld	t5,232(sp)
    80002848:	0f013f83          	ld	t6,240(sp)
    8000284c:	10010113          	addi	sp,sp,256
    80002850:	10200073          	sret
    80002854:	00000013          	nop
    80002858:	00000013          	nop
    8000285c:	00000013          	nop

0000000080002860 <timervec>:
    80002860:	34051573          	csrrw	a0,mscratch,a0
    80002864:	00b53023          	sd	a1,0(a0)
    80002868:	00c53423          	sd	a2,8(a0)
    8000286c:	00d53823          	sd	a3,16(a0)
    80002870:	01853583          	ld	a1,24(a0)
    80002874:	02053603          	ld	a2,32(a0)
    80002878:	0005b683          	ld	a3,0(a1)
    8000287c:	00c686b3          	add	a3,a3,a2
    80002880:	00d5b023          	sd	a3,0(a1)
    80002884:	00200593          	li	a1,2
    80002888:	14459073          	csrw	sip,a1
    8000288c:	01053683          	ld	a3,16(a0)
    80002890:	00853603          	ld	a2,8(a0)
    80002894:	00053583          	ld	a1,0(a0)
    80002898:	34051573          	csrrw	a0,mscratch,a0
    8000289c:	30200073          	mret

00000000800028a0 <plicinit>:
    800028a0:	ff010113          	addi	sp,sp,-16
    800028a4:	00813423          	sd	s0,8(sp)
    800028a8:	01010413          	addi	s0,sp,16
    800028ac:	00813403          	ld	s0,8(sp)
    800028b0:	0c0007b7          	lui	a5,0xc000
    800028b4:	00100713          	li	a4,1
    800028b8:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    800028bc:	00e7a223          	sw	a4,4(a5)
    800028c0:	01010113          	addi	sp,sp,16
    800028c4:	00008067          	ret

00000000800028c8 <plicinithart>:
    800028c8:	ff010113          	addi	sp,sp,-16
    800028cc:	00813023          	sd	s0,0(sp)
    800028d0:	00113423          	sd	ra,8(sp)
    800028d4:	01010413          	addi	s0,sp,16
    800028d8:	00000097          	auipc	ra,0x0
    800028dc:	a48080e7          	jalr	-1464(ra) # 80002320 <cpuid>
    800028e0:	0085171b          	slliw	a4,a0,0x8
    800028e4:	0c0027b7          	lui	a5,0xc002
    800028e8:	00e787b3          	add	a5,a5,a4
    800028ec:	40200713          	li	a4,1026
    800028f0:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    800028f4:	00813083          	ld	ra,8(sp)
    800028f8:	00013403          	ld	s0,0(sp)
    800028fc:	00d5151b          	slliw	a0,a0,0xd
    80002900:	0c2017b7          	lui	a5,0xc201
    80002904:	00a78533          	add	a0,a5,a0
    80002908:	00052023          	sw	zero,0(a0)
    8000290c:	01010113          	addi	sp,sp,16
    80002910:	00008067          	ret

0000000080002914 <plic_claim>:
    80002914:	ff010113          	addi	sp,sp,-16
    80002918:	00813023          	sd	s0,0(sp)
    8000291c:	00113423          	sd	ra,8(sp)
    80002920:	01010413          	addi	s0,sp,16
    80002924:	00000097          	auipc	ra,0x0
    80002928:	9fc080e7          	jalr	-1540(ra) # 80002320 <cpuid>
    8000292c:	00813083          	ld	ra,8(sp)
    80002930:	00013403          	ld	s0,0(sp)
    80002934:	00d5151b          	slliw	a0,a0,0xd
    80002938:	0c2017b7          	lui	a5,0xc201
    8000293c:	00a78533          	add	a0,a5,a0
    80002940:	00452503          	lw	a0,4(a0)
    80002944:	01010113          	addi	sp,sp,16
    80002948:	00008067          	ret

000000008000294c <plic_complete>:
    8000294c:	fe010113          	addi	sp,sp,-32
    80002950:	00813823          	sd	s0,16(sp)
    80002954:	00913423          	sd	s1,8(sp)
    80002958:	00113c23          	sd	ra,24(sp)
    8000295c:	02010413          	addi	s0,sp,32
    80002960:	00050493          	mv	s1,a0
    80002964:	00000097          	auipc	ra,0x0
    80002968:	9bc080e7          	jalr	-1604(ra) # 80002320 <cpuid>
    8000296c:	01813083          	ld	ra,24(sp)
    80002970:	01013403          	ld	s0,16(sp)
    80002974:	00d5179b          	slliw	a5,a0,0xd
    80002978:	0c201737          	lui	a4,0xc201
    8000297c:	00f707b3          	add	a5,a4,a5
    80002980:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80002984:	00813483          	ld	s1,8(sp)
    80002988:	02010113          	addi	sp,sp,32
    8000298c:	00008067          	ret

0000000080002990 <consolewrite>:
    80002990:	fb010113          	addi	sp,sp,-80
    80002994:	04813023          	sd	s0,64(sp)
    80002998:	04113423          	sd	ra,72(sp)
    8000299c:	02913c23          	sd	s1,56(sp)
    800029a0:	03213823          	sd	s2,48(sp)
    800029a4:	03313423          	sd	s3,40(sp)
    800029a8:	03413023          	sd	s4,32(sp)
    800029ac:	01513c23          	sd	s5,24(sp)
    800029b0:	05010413          	addi	s0,sp,80
    800029b4:	06c05c63          	blez	a2,80002a2c <consolewrite+0x9c>
    800029b8:	00060993          	mv	s3,a2
    800029bc:	00050a13          	mv	s4,a0
    800029c0:	00058493          	mv	s1,a1
    800029c4:	00000913          	li	s2,0
    800029c8:	fff00a93          	li	s5,-1
    800029cc:	01c0006f          	j	800029e8 <consolewrite+0x58>
    800029d0:	fbf44503          	lbu	a0,-65(s0)
    800029d4:	0019091b          	addiw	s2,s2,1
    800029d8:	00148493          	addi	s1,s1,1
    800029dc:	00001097          	auipc	ra,0x1
    800029e0:	a9c080e7          	jalr	-1380(ra) # 80003478 <uartputc>
    800029e4:	03298063          	beq	s3,s2,80002a04 <consolewrite+0x74>
    800029e8:	00048613          	mv	a2,s1
    800029ec:	00100693          	li	a3,1
    800029f0:	000a0593          	mv	a1,s4
    800029f4:	fbf40513          	addi	a0,s0,-65
    800029f8:	00000097          	auipc	ra,0x0
    800029fc:	9e0080e7          	jalr	-1568(ra) # 800023d8 <either_copyin>
    80002a00:	fd5518e3          	bne	a0,s5,800029d0 <consolewrite+0x40>
    80002a04:	04813083          	ld	ra,72(sp)
    80002a08:	04013403          	ld	s0,64(sp)
    80002a0c:	03813483          	ld	s1,56(sp)
    80002a10:	02813983          	ld	s3,40(sp)
    80002a14:	02013a03          	ld	s4,32(sp)
    80002a18:	01813a83          	ld	s5,24(sp)
    80002a1c:	00090513          	mv	a0,s2
    80002a20:	03013903          	ld	s2,48(sp)
    80002a24:	05010113          	addi	sp,sp,80
    80002a28:	00008067          	ret
    80002a2c:	00000913          	li	s2,0
    80002a30:	fd5ff06f          	j	80002a04 <consolewrite+0x74>

0000000080002a34 <consoleread>:
    80002a34:	f9010113          	addi	sp,sp,-112
    80002a38:	06813023          	sd	s0,96(sp)
    80002a3c:	04913c23          	sd	s1,88(sp)
    80002a40:	05213823          	sd	s2,80(sp)
    80002a44:	05313423          	sd	s3,72(sp)
    80002a48:	05413023          	sd	s4,64(sp)
    80002a4c:	03513c23          	sd	s5,56(sp)
    80002a50:	03613823          	sd	s6,48(sp)
    80002a54:	03713423          	sd	s7,40(sp)
    80002a58:	03813023          	sd	s8,32(sp)
    80002a5c:	06113423          	sd	ra,104(sp)
    80002a60:	01913c23          	sd	s9,24(sp)
    80002a64:	07010413          	addi	s0,sp,112
    80002a68:	00060b93          	mv	s7,a2
    80002a6c:	00050913          	mv	s2,a0
    80002a70:	00058c13          	mv	s8,a1
    80002a74:	00060b1b          	sext.w	s6,a2
    80002a78:	00004497          	auipc	s1,0x4
    80002a7c:	22048493          	addi	s1,s1,544 # 80006c98 <cons>
    80002a80:	00400993          	li	s3,4
    80002a84:	fff00a13          	li	s4,-1
    80002a88:	00a00a93          	li	s5,10
    80002a8c:	05705e63          	blez	s7,80002ae8 <consoleread+0xb4>
    80002a90:	09c4a703          	lw	a4,156(s1)
    80002a94:	0984a783          	lw	a5,152(s1)
    80002a98:	0007071b          	sext.w	a4,a4
    80002a9c:	08e78463          	beq	a5,a4,80002b24 <consoleread+0xf0>
    80002aa0:	07f7f713          	andi	a4,a5,127
    80002aa4:	00e48733          	add	a4,s1,a4
    80002aa8:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    80002aac:	0017869b          	addiw	a3,a5,1
    80002ab0:	08d4ac23          	sw	a3,152(s1)
    80002ab4:	00070c9b          	sext.w	s9,a4
    80002ab8:	0b370663          	beq	a4,s3,80002b64 <consoleread+0x130>
    80002abc:	00100693          	li	a3,1
    80002ac0:	f9f40613          	addi	a2,s0,-97
    80002ac4:	000c0593          	mv	a1,s8
    80002ac8:	00090513          	mv	a0,s2
    80002acc:	f8e40fa3          	sb	a4,-97(s0)
    80002ad0:	00000097          	auipc	ra,0x0
    80002ad4:	8bc080e7          	jalr	-1860(ra) # 8000238c <either_copyout>
    80002ad8:	01450863          	beq	a0,s4,80002ae8 <consoleread+0xb4>
    80002adc:	001c0c13          	addi	s8,s8,1
    80002ae0:	fffb8b9b          	addiw	s7,s7,-1
    80002ae4:	fb5c94e3          	bne	s9,s5,80002a8c <consoleread+0x58>
    80002ae8:	000b851b          	sext.w	a0,s7
    80002aec:	06813083          	ld	ra,104(sp)
    80002af0:	06013403          	ld	s0,96(sp)
    80002af4:	05813483          	ld	s1,88(sp)
    80002af8:	05013903          	ld	s2,80(sp)
    80002afc:	04813983          	ld	s3,72(sp)
    80002b00:	04013a03          	ld	s4,64(sp)
    80002b04:	03813a83          	ld	s5,56(sp)
    80002b08:	02813b83          	ld	s7,40(sp)
    80002b0c:	02013c03          	ld	s8,32(sp)
    80002b10:	01813c83          	ld	s9,24(sp)
    80002b14:	40ab053b          	subw	a0,s6,a0
    80002b18:	03013b03          	ld	s6,48(sp)
    80002b1c:	07010113          	addi	sp,sp,112
    80002b20:	00008067          	ret
    80002b24:	00001097          	auipc	ra,0x1
    80002b28:	1d8080e7          	jalr	472(ra) # 80003cfc <push_on>
    80002b2c:	0984a703          	lw	a4,152(s1)
    80002b30:	09c4a783          	lw	a5,156(s1)
    80002b34:	0007879b          	sext.w	a5,a5
    80002b38:	fef70ce3          	beq	a4,a5,80002b30 <consoleread+0xfc>
    80002b3c:	00001097          	auipc	ra,0x1
    80002b40:	234080e7          	jalr	564(ra) # 80003d70 <pop_on>
    80002b44:	0984a783          	lw	a5,152(s1)
    80002b48:	07f7f713          	andi	a4,a5,127
    80002b4c:	00e48733          	add	a4,s1,a4
    80002b50:	01874703          	lbu	a4,24(a4)
    80002b54:	0017869b          	addiw	a3,a5,1
    80002b58:	08d4ac23          	sw	a3,152(s1)
    80002b5c:	00070c9b          	sext.w	s9,a4
    80002b60:	f5371ee3          	bne	a4,s3,80002abc <consoleread+0x88>
    80002b64:	000b851b          	sext.w	a0,s7
    80002b68:	f96bf2e3          	bgeu	s7,s6,80002aec <consoleread+0xb8>
    80002b6c:	08f4ac23          	sw	a5,152(s1)
    80002b70:	f7dff06f          	j	80002aec <consoleread+0xb8>

0000000080002b74 <consputc>:
    80002b74:	10000793          	li	a5,256
    80002b78:	00f50663          	beq	a0,a5,80002b84 <consputc+0x10>
    80002b7c:	00001317          	auipc	t1,0x1
    80002b80:	9f430067          	jr	-1548(t1) # 80003570 <uartputc_sync>
    80002b84:	ff010113          	addi	sp,sp,-16
    80002b88:	00113423          	sd	ra,8(sp)
    80002b8c:	00813023          	sd	s0,0(sp)
    80002b90:	01010413          	addi	s0,sp,16
    80002b94:	00800513          	li	a0,8
    80002b98:	00001097          	auipc	ra,0x1
    80002b9c:	9d8080e7          	jalr	-1576(ra) # 80003570 <uartputc_sync>
    80002ba0:	02000513          	li	a0,32
    80002ba4:	00001097          	auipc	ra,0x1
    80002ba8:	9cc080e7          	jalr	-1588(ra) # 80003570 <uartputc_sync>
    80002bac:	00013403          	ld	s0,0(sp)
    80002bb0:	00813083          	ld	ra,8(sp)
    80002bb4:	00800513          	li	a0,8
    80002bb8:	01010113          	addi	sp,sp,16
    80002bbc:	00001317          	auipc	t1,0x1
    80002bc0:	9b430067          	jr	-1612(t1) # 80003570 <uartputc_sync>

0000000080002bc4 <consoleintr>:
    80002bc4:	fe010113          	addi	sp,sp,-32
    80002bc8:	00813823          	sd	s0,16(sp)
    80002bcc:	00913423          	sd	s1,8(sp)
    80002bd0:	01213023          	sd	s2,0(sp)
    80002bd4:	00113c23          	sd	ra,24(sp)
    80002bd8:	02010413          	addi	s0,sp,32
    80002bdc:	00004917          	auipc	s2,0x4
    80002be0:	0bc90913          	addi	s2,s2,188 # 80006c98 <cons>
    80002be4:	00050493          	mv	s1,a0
    80002be8:	00090513          	mv	a0,s2
    80002bec:	00001097          	auipc	ra,0x1
    80002bf0:	e40080e7          	jalr	-448(ra) # 80003a2c <acquire>
    80002bf4:	02048c63          	beqz	s1,80002c2c <consoleintr+0x68>
    80002bf8:	0a092783          	lw	a5,160(s2)
    80002bfc:	09892703          	lw	a4,152(s2)
    80002c00:	07f00693          	li	a3,127
    80002c04:	40e7873b          	subw	a4,a5,a4
    80002c08:	02e6e263          	bltu	a3,a4,80002c2c <consoleintr+0x68>
    80002c0c:	00d00713          	li	a4,13
    80002c10:	04e48063          	beq	s1,a4,80002c50 <consoleintr+0x8c>
    80002c14:	07f7f713          	andi	a4,a5,127
    80002c18:	00e90733          	add	a4,s2,a4
    80002c1c:	0017879b          	addiw	a5,a5,1
    80002c20:	0af92023          	sw	a5,160(s2)
    80002c24:	00970c23          	sb	s1,24(a4)
    80002c28:	08f92e23          	sw	a5,156(s2)
    80002c2c:	01013403          	ld	s0,16(sp)
    80002c30:	01813083          	ld	ra,24(sp)
    80002c34:	00813483          	ld	s1,8(sp)
    80002c38:	00013903          	ld	s2,0(sp)
    80002c3c:	00004517          	auipc	a0,0x4
    80002c40:	05c50513          	addi	a0,a0,92 # 80006c98 <cons>
    80002c44:	02010113          	addi	sp,sp,32
    80002c48:	00001317          	auipc	t1,0x1
    80002c4c:	eb030067          	jr	-336(t1) # 80003af8 <release>
    80002c50:	00a00493          	li	s1,10
    80002c54:	fc1ff06f          	j	80002c14 <consoleintr+0x50>

0000000080002c58 <consoleinit>:
    80002c58:	fe010113          	addi	sp,sp,-32
    80002c5c:	00113c23          	sd	ra,24(sp)
    80002c60:	00813823          	sd	s0,16(sp)
    80002c64:	00913423          	sd	s1,8(sp)
    80002c68:	02010413          	addi	s0,sp,32
    80002c6c:	00004497          	auipc	s1,0x4
    80002c70:	02c48493          	addi	s1,s1,44 # 80006c98 <cons>
    80002c74:	00048513          	mv	a0,s1
    80002c78:	00002597          	auipc	a1,0x2
    80002c7c:	4d858593          	addi	a1,a1,1240 # 80005150 <_ZN3TCB25DEFAULT_SYSTEM_STACK_SIZEE+0x130>
    80002c80:	00001097          	auipc	ra,0x1
    80002c84:	d88080e7          	jalr	-632(ra) # 80003a08 <initlock>
    80002c88:	00000097          	auipc	ra,0x0
    80002c8c:	7ac080e7          	jalr	1964(ra) # 80003434 <uartinit>
    80002c90:	01813083          	ld	ra,24(sp)
    80002c94:	01013403          	ld	s0,16(sp)
    80002c98:	00000797          	auipc	a5,0x0
    80002c9c:	d9c78793          	addi	a5,a5,-612 # 80002a34 <consoleread>
    80002ca0:	0af4bc23          	sd	a5,184(s1)
    80002ca4:	00000797          	auipc	a5,0x0
    80002ca8:	cec78793          	addi	a5,a5,-788 # 80002990 <consolewrite>
    80002cac:	0cf4b023          	sd	a5,192(s1)
    80002cb0:	00813483          	ld	s1,8(sp)
    80002cb4:	02010113          	addi	sp,sp,32
    80002cb8:	00008067          	ret

0000000080002cbc <console_read>:
    80002cbc:	ff010113          	addi	sp,sp,-16
    80002cc0:	00813423          	sd	s0,8(sp)
    80002cc4:	01010413          	addi	s0,sp,16
    80002cc8:	00813403          	ld	s0,8(sp)
    80002ccc:	00004317          	auipc	t1,0x4
    80002cd0:	08433303          	ld	t1,132(t1) # 80006d50 <devsw+0x10>
    80002cd4:	01010113          	addi	sp,sp,16
    80002cd8:	00030067          	jr	t1

0000000080002cdc <console_write>:
    80002cdc:	ff010113          	addi	sp,sp,-16
    80002ce0:	00813423          	sd	s0,8(sp)
    80002ce4:	01010413          	addi	s0,sp,16
    80002ce8:	00813403          	ld	s0,8(sp)
    80002cec:	00004317          	auipc	t1,0x4
    80002cf0:	06c33303          	ld	t1,108(t1) # 80006d58 <devsw+0x18>
    80002cf4:	01010113          	addi	sp,sp,16
    80002cf8:	00030067          	jr	t1

0000000080002cfc <panic>:
    80002cfc:	fe010113          	addi	sp,sp,-32
    80002d00:	00113c23          	sd	ra,24(sp)
    80002d04:	00813823          	sd	s0,16(sp)
    80002d08:	00913423          	sd	s1,8(sp)
    80002d0c:	02010413          	addi	s0,sp,32
    80002d10:	00050493          	mv	s1,a0
    80002d14:	00002517          	auipc	a0,0x2
    80002d18:	44450513          	addi	a0,a0,1092 # 80005158 <_ZN3TCB25DEFAULT_SYSTEM_STACK_SIZEE+0x138>
    80002d1c:	00004797          	auipc	a5,0x4
    80002d20:	0c07ae23          	sw	zero,220(a5) # 80006df8 <pr+0x18>
    80002d24:	00000097          	auipc	ra,0x0
    80002d28:	034080e7          	jalr	52(ra) # 80002d58 <__printf>
    80002d2c:	00048513          	mv	a0,s1
    80002d30:	00000097          	auipc	ra,0x0
    80002d34:	028080e7          	jalr	40(ra) # 80002d58 <__printf>
    80002d38:	00002517          	auipc	a0,0x2
    80002d3c:	40050513          	addi	a0,a0,1024 # 80005138 <_ZN3TCB25DEFAULT_SYSTEM_STACK_SIZEE+0x118>
    80002d40:	00000097          	auipc	ra,0x0
    80002d44:	018080e7          	jalr	24(ra) # 80002d58 <__printf>
    80002d48:	00100793          	li	a5,1
    80002d4c:	00003717          	auipc	a4,0x3
    80002d50:	bef72e23          	sw	a5,-1028(a4) # 80005948 <panicked>
    80002d54:	0000006f          	j	80002d54 <panic+0x58>

0000000080002d58 <__printf>:
    80002d58:	f3010113          	addi	sp,sp,-208
    80002d5c:	08813023          	sd	s0,128(sp)
    80002d60:	07313423          	sd	s3,104(sp)
    80002d64:	09010413          	addi	s0,sp,144
    80002d68:	05813023          	sd	s8,64(sp)
    80002d6c:	08113423          	sd	ra,136(sp)
    80002d70:	06913c23          	sd	s1,120(sp)
    80002d74:	07213823          	sd	s2,112(sp)
    80002d78:	07413023          	sd	s4,96(sp)
    80002d7c:	05513c23          	sd	s5,88(sp)
    80002d80:	05613823          	sd	s6,80(sp)
    80002d84:	05713423          	sd	s7,72(sp)
    80002d88:	03913c23          	sd	s9,56(sp)
    80002d8c:	03a13823          	sd	s10,48(sp)
    80002d90:	03b13423          	sd	s11,40(sp)
    80002d94:	00004317          	auipc	t1,0x4
    80002d98:	04c30313          	addi	t1,t1,76 # 80006de0 <pr>
    80002d9c:	01832c03          	lw	s8,24(t1)
    80002da0:	00b43423          	sd	a1,8(s0)
    80002da4:	00c43823          	sd	a2,16(s0)
    80002da8:	00d43c23          	sd	a3,24(s0)
    80002dac:	02e43023          	sd	a4,32(s0)
    80002db0:	02f43423          	sd	a5,40(s0)
    80002db4:	03043823          	sd	a6,48(s0)
    80002db8:	03143c23          	sd	a7,56(s0)
    80002dbc:	00050993          	mv	s3,a0
    80002dc0:	4a0c1663          	bnez	s8,8000326c <__printf+0x514>
    80002dc4:	60098c63          	beqz	s3,800033dc <__printf+0x684>
    80002dc8:	0009c503          	lbu	a0,0(s3)
    80002dcc:	00840793          	addi	a5,s0,8
    80002dd0:	f6f43c23          	sd	a5,-136(s0)
    80002dd4:	00000493          	li	s1,0
    80002dd8:	22050063          	beqz	a0,80002ff8 <__printf+0x2a0>
    80002ddc:	00002a37          	lui	s4,0x2
    80002de0:	00018ab7          	lui	s5,0x18
    80002de4:	000f4b37          	lui	s6,0xf4
    80002de8:	00989bb7          	lui	s7,0x989
    80002dec:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80002df0:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80002df4:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80002df8:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    80002dfc:	00148c9b          	addiw	s9,s1,1
    80002e00:	02500793          	li	a5,37
    80002e04:	01998933          	add	s2,s3,s9
    80002e08:	38f51263          	bne	a0,a5,8000318c <__printf+0x434>
    80002e0c:	00094783          	lbu	a5,0(s2)
    80002e10:	00078c9b          	sext.w	s9,a5
    80002e14:	1e078263          	beqz	a5,80002ff8 <__printf+0x2a0>
    80002e18:	0024849b          	addiw	s1,s1,2
    80002e1c:	07000713          	li	a4,112
    80002e20:	00998933          	add	s2,s3,s1
    80002e24:	38e78a63          	beq	a5,a4,800031b8 <__printf+0x460>
    80002e28:	20f76863          	bltu	a4,a5,80003038 <__printf+0x2e0>
    80002e2c:	42a78863          	beq	a5,a0,8000325c <__printf+0x504>
    80002e30:	06400713          	li	a4,100
    80002e34:	40e79663          	bne	a5,a4,80003240 <__printf+0x4e8>
    80002e38:	f7843783          	ld	a5,-136(s0)
    80002e3c:	0007a603          	lw	a2,0(a5)
    80002e40:	00878793          	addi	a5,a5,8
    80002e44:	f6f43c23          	sd	a5,-136(s0)
    80002e48:	42064a63          	bltz	a2,8000327c <__printf+0x524>
    80002e4c:	00a00713          	li	a4,10
    80002e50:	02e677bb          	remuw	a5,a2,a4
    80002e54:	00002d97          	auipc	s11,0x2
    80002e58:	32cd8d93          	addi	s11,s11,812 # 80005180 <digits>
    80002e5c:	00900593          	li	a1,9
    80002e60:	0006051b          	sext.w	a0,a2
    80002e64:	00000c93          	li	s9,0
    80002e68:	02079793          	slli	a5,a5,0x20
    80002e6c:	0207d793          	srli	a5,a5,0x20
    80002e70:	00fd87b3          	add	a5,s11,a5
    80002e74:	0007c783          	lbu	a5,0(a5)
    80002e78:	02e656bb          	divuw	a3,a2,a4
    80002e7c:	f8f40023          	sb	a5,-128(s0)
    80002e80:	14c5d863          	bge	a1,a2,80002fd0 <__printf+0x278>
    80002e84:	06300593          	li	a1,99
    80002e88:	00100c93          	li	s9,1
    80002e8c:	02e6f7bb          	remuw	a5,a3,a4
    80002e90:	02079793          	slli	a5,a5,0x20
    80002e94:	0207d793          	srli	a5,a5,0x20
    80002e98:	00fd87b3          	add	a5,s11,a5
    80002e9c:	0007c783          	lbu	a5,0(a5)
    80002ea0:	02e6d73b          	divuw	a4,a3,a4
    80002ea4:	f8f400a3          	sb	a5,-127(s0)
    80002ea8:	12a5f463          	bgeu	a1,a0,80002fd0 <__printf+0x278>
    80002eac:	00a00693          	li	a3,10
    80002eb0:	00900593          	li	a1,9
    80002eb4:	02d777bb          	remuw	a5,a4,a3
    80002eb8:	02079793          	slli	a5,a5,0x20
    80002ebc:	0207d793          	srli	a5,a5,0x20
    80002ec0:	00fd87b3          	add	a5,s11,a5
    80002ec4:	0007c503          	lbu	a0,0(a5)
    80002ec8:	02d757bb          	divuw	a5,a4,a3
    80002ecc:	f8a40123          	sb	a0,-126(s0)
    80002ed0:	48e5f263          	bgeu	a1,a4,80003354 <__printf+0x5fc>
    80002ed4:	06300513          	li	a0,99
    80002ed8:	02d7f5bb          	remuw	a1,a5,a3
    80002edc:	02059593          	slli	a1,a1,0x20
    80002ee0:	0205d593          	srli	a1,a1,0x20
    80002ee4:	00bd85b3          	add	a1,s11,a1
    80002ee8:	0005c583          	lbu	a1,0(a1)
    80002eec:	02d7d7bb          	divuw	a5,a5,a3
    80002ef0:	f8b401a3          	sb	a1,-125(s0)
    80002ef4:	48e57263          	bgeu	a0,a4,80003378 <__printf+0x620>
    80002ef8:	3e700513          	li	a0,999
    80002efc:	02d7f5bb          	remuw	a1,a5,a3
    80002f00:	02059593          	slli	a1,a1,0x20
    80002f04:	0205d593          	srli	a1,a1,0x20
    80002f08:	00bd85b3          	add	a1,s11,a1
    80002f0c:	0005c583          	lbu	a1,0(a1)
    80002f10:	02d7d7bb          	divuw	a5,a5,a3
    80002f14:	f8b40223          	sb	a1,-124(s0)
    80002f18:	46e57663          	bgeu	a0,a4,80003384 <__printf+0x62c>
    80002f1c:	02d7f5bb          	remuw	a1,a5,a3
    80002f20:	02059593          	slli	a1,a1,0x20
    80002f24:	0205d593          	srli	a1,a1,0x20
    80002f28:	00bd85b3          	add	a1,s11,a1
    80002f2c:	0005c583          	lbu	a1,0(a1)
    80002f30:	02d7d7bb          	divuw	a5,a5,a3
    80002f34:	f8b402a3          	sb	a1,-123(s0)
    80002f38:	46ea7863          	bgeu	s4,a4,800033a8 <__printf+0x650>
    80002f3c:	02d7f5bb          	remuw	a1,a5,a3
    80002f40:	02059593          	slli	a1,a1,0x20
    80002f44:	0205d593          	srli	a1,a1,0x20
    80002f48:	00bd85b3          	add	a1,s11,a1
    80002f4c:	0005c583          	lbu	a1,0(a1)
    80002f50:	02d7d7bb          	divuw	a5,a5,a3
    80002f54:	f8b40323          	sb	a1,-122(s0)
    80002f58:	3eeaf863          	bgeu	s5,a4,80003348 <__printf+0x5f0>
    80002f5c:	02d7f5bb          	remuw	a1,a5,a3
    80002f60:	02059593          	slli	a1,a1,0x20
    80002f64:	0205d593          	srli	a1,a1,0x20
    80002f68:	00bd85b3          	add	a1,s11,a1
    80002f6c:	0005c583          	lbu	a1,0(a1)
    80002f70:	02d7d7bb          	divuw	a5,a5,a3
    80002f74:	f8b403a3          	sb	a1,-121(s0)
    80002f78:	42eb7e63          	bgeu	s6,a4,800033b4 <__printf+0x65c>
    80002f7c:	02d7f5bb          	remuw	a1,a5,a3
    80002f80:	02059593          	slli	a1,a1,0x20
    80002f84:	0205d593          	srli	a1,a1,0x20
    80002f88:	00bd85b3          	add	a1,s11,a1
    80002f8c:	0005c583          	lbu	a1,0(a1)
    80002f90:	02d7d7bb          	divuw	a5,a5,a3
    80002f94:	f8b40423          	sb	a1,-120(s0)
    80002f98:	42ebfc63          	bgeu	s7,a4,800033d0 <__printf+0x678>
    80002f9c:	02079793          	slli	a5,a5,0x20
    80002fa0:	0207d793          	srli	a5,a5,0x20
    80002fa4:	00fd8db3          	add	s11,s11,a5
    80002fa8:	000dc703          	lbu	a4,0(s11)
    80002fac:	00a00793          	li	a5,10
    80002fb0:	00900c93          	li	s9,9
    80002fb4:	f8e404a3          	sb	a4,-119(s0)
    80002fb8:	00065c63          	bgez	a2,80002fd0 <__printf+0x278>
    80002fbc:	f9040713          	addi	a4,s0,-112
    80002fc0:	00f70733          	add	a4,a4,a5
    80002fc4:	02d00693          	li	a3,45
    80002fc8:	fed70823          	sb	a3,-16(a4)
    80002fcc:	00078c93          	mv	s9,a5
    80002fd0:	f8040793          	addi	a5,s0,-128
    80002fd4:	01978cb3          	add	s9,a5,s9
    80002fd8:	f7f40d13          	addi	s10,s0,-129
    80002fdc:	000cc503          	lbu	a0,0(s9)
    80002fe0:	fffc8c93          	addi	s9,s9,-1
    80002fe4:	00000097          	auipc	ra,0x0
    80002fe8:	b90080e7          	jalr	-1136(ra) # 80002b74 <consputc>
    80002fec:	ffac98e3          	bne	s9,s10,80002fdc <__printf+0x284>
    80002ff0:	00094503          	lbu	a0,0(s2)
    80002ff4:	e00514e3          	bnez	a0,80002dfc <__printf+0xa4>
    80002ff8:	1a0c1663          	bnez	s8,800031a4 <__printf+0x44c>
    80002ffc:	08813083          	ld	ra,136(sp)
    80003000:	08013403          	ld	s0,128(sp)
    80003004:	07813483          	ld	s1,120(sp)
    80003008:	07013903          	ld	s2,112(sp)
    8000300c:	06813983          	ld	s3,104(sp)
    80003010:	06013a03          	ld	s4,96(sp)
    80003014:	05813a83          	ld	s5,88(sp)
    80003018:	05013b03          	ld	s6,80(sp)
    8000301c:	04813b83          	ld	s7,72(sp)
    80003020:	04013c03          	ld	s8,64(sp)
    80003024:	03813c83          	ld	s9,56(sp)
    80003028:	03013d03          	ld	s10,48(sp)
    8000302c:	02813d83          	ld	s11,40(sp)
    80003030:	0d010113          	addi	sp,sp,208
    80003034:	00008067          	ret
    80003038:	07300713          	li	a4,115
    8000303c:	1ce78a63          	beq	a5,a4,80003210 <__printf+0x4b8>
    80003040:	07800713          	li	a4,120
    80003044:	1ee79e63          	bne	a5,a4,80003240 <__printf+0x4e8>
    80003048:	f7843783          	ld	a5,-136(s0)
    8000304c:	0007a703          	lw	a4,0(a5)
    80003050:	00878793          	addi	a5,a5,8
    80003054:	f6f43c23          	sd	a5,-136(s0)
    80003058:	28074263          	bltz	a4,800032dc <__printf+0x584>
    8000305c:	00002d97          	auipc	s11,0x2
    80003060:	124d8d93          	addi	s11,s11,292 # 80005180 <digits>
    80003064:	00f77793          	andi	a5,a4,15
    80003068:	00fd87b3          	add	a5,s11,a5
    8000306c:	0007c683          	lbu	a3,0(a5)
    80003070:	00f00613          	li	a2,15
    80003074:	0007079b          	sext.w	a5,a4
    80003078:	f8d40023          	sb	a3,-128(s0)
    8000307c:	0047559b          	srliw	a1,a4,0x4
    80003080:	0047569b          	srliw	a3,a4,0x4
    80003084:	00000c93          	li	s9,0
    80003088:	0ee65063          	bge	a2,a4,80003168 <__printf+0x410>
    8000308c:	00f6f693          	andi	a3,a3,15
    80003090:	00dd86b3          	add	a3,s11,a3
    80003094:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80003098:	0087d79b          	srliw	a5,a5,0x8
    8000309c:	00100c93          	li	s9,1
    800030a0:	f8d400a3          	sb	a3,-127(s0)
    800030a4:	0cb67263          	bgeu	a2,a1,80003168 <__printf+0x410>
    800030a8:	00f7f693          	andi	a3,a5,15
    800030ac:	00dd86b3          	add	a3,s11,a3
    800030b0:	0006c583          	lbu	a1,0(a3)
    800030b4:	00f00613          	li	a2,15
    800030b8:	0047d69b          	srliw	a3,a5,0x4
    800030bc:	f8b40123          	sb	a1,-126(s0)
    800030c0:	0047d593          	srli	a1,a5,0x4
    800030c4:	28f67e63          	bgeu	a2,a5,80003360 <__printf+0x608>
    800030c8:	00f6f693          	andi	a3,a3,15
    800030cc:	00dd86b3          	add	a3,s11,a3
    800030d0:	0006c503          	lbu	a0,0(a3)
    800030d4:	0087d813          	srli	a6,a5,0x8
    800030d8:	0087d69b          	srliw	a3,a5,0x8
    800030dc:	f8a401a3          	sb	a0,-125(s0)
    800030e0:	28b67663          	bgeu	a2,a1,8000336c <__printf+0x614>
    800030e4:	00f6f693          	andi	a3,a3,15
    800030e8:	00dd86b3          	add	a3,s11,a3
    800030ec:	0006c583          	lbu	a1,0(a3)
    800030f0:	00c7d513          	srli	a0,a5,0xc
    800030f4:	00c7d69b          	srliw	a3,a5,0xc
    800030f8:	f8b40223          	sb	a1,-124(s0)
    800030fc:	29067a63          	bgeu	a2,a6,80003390 <__printf+0x638>
    80003100:	00f6f693          	andi	a3,a3,15
    80003104:	00dd86b3          	add	a3,s11,a3
    80003108:	0006c583          	lbu	a1,0(a3)
    8000310c:	0107d813          	srli	a6,a5,0x10
    80003110:	0107d69b          	srliw	a3,a5,0x10
    80003114:	f8b402a3          	sb	a1,-123(s0)
    80003118:	28a67263          	bgeu	a2,a0,8000339c <__printf+0x644>
    8000311c:	00f6f693          	andi	a3,a3,15
    80003120:	00dd86b3          	add	a3,s11,a3
    80003124:	0006c683          	lbu	a3,0(a3)
    80003128:	0147d79b          	srliw	a5,a5,0x14
    8000312c:	f8d40323          	sb	a3,-122(s0)
    80003130:	21067663          	bgeu	a2,a6,8000333c <__printf+0x5e4>
    80003134:	02079793          	slli	a5,a5,0x20
    80003138:	0207d793          	srli	a5,a5,0x20
    8000313c:	00fd8db3          	add	s11,s11,a5
    80003140:	000dc683          	lbu	a3,0(s11)
    80003144:	00800793          	li	a5,8
    80003148:	00700c93          	li	s9,7
    8000314c:	f8d403a3          	sb	a3,-121(s0)
    80003150:	00075c63          	bgez	a4,80003168 <__printf+0x410>
    80003154:	f9040713          	addi	a4,s0,-112
    80003158:	00f70733          	add	a4,a4,a5
    8000315c:	02d00693          	li	a3,45
    80003160:	fed70823          	sb	a3,-16(a4)
    80003164:	00078c93          	mv	s9,a5
    80003168:	f8040793          	addi	a5,s0,-128
    8000316c:	01978cb3          	add	s9,a5,s9
    80003170:	f7f40d13          	addi	s10,s0,-129
    80003174:	000cc503          	lbu	a0,0(s9)
    80003178:	fffc8c93          	addi	s9,s9,-1
    8000317c:	00000097          	auipc	ra,0x0
    80003180:	9f8080e7          	jalr	-1544(ra) # 80002b74 <consputc>
    80003184:	ff9d18e3          	bne	s10,s9,80003174 <__printf+0x41c>
    80003188:	0100006f          	j	80003198 <__printf+0x440>
    8000318c:	00000097          	auipc	ra,0x0
    80003190:	9e8080e7          	jalr	-1560(ra) # 80002b74 <consputc>
    80003194:	000c8493          	mv	s1,s9
    80003198:	00094503          	lbu	a0,0(s2)
    8000319c:	c60510e3          	bnez	a0,80002dfc <__printf+0xa4>
    800031a0:	e40c0ee3          	beqz	s8,80002ffc <__printf+0x2a4>
    800031a4:	00004517          	auipc	a0,0x4
    800031a8:	c3c50513          	addi	a0,a0,-964 # 80006de0 <pr>
    800031ac:	00001097          	auipc	ra,0x1
    800031b0:	94c080e7          	jalr	-1716(ra) # 80003af8 <release>
    800031b4:	e49ff06f          	j	80002ffc <__printf+0x2a4>
    800031b8:	f7843783          	ld	a5,-136(s0)
    800031bc:	03000513          	li	a0,48
    800031c0:	01000d13          	li	s10,16
    800031c4:	00878713          	addi	a4,a5,8
    800031c8:	0007bc83          	ld	s9,0(a5)
    800031cc:	f6e43c23          	sd	a4,-136(s0)
    800031d0:	00000097          	auipc	ra,0x0
    800031d4:	9a4080e7          	jalr	-1628(ra) # 80002b74 <consputc>
    800031d8:	07800513          	li	a0,120
    800031dc:	00000097          	auipc	ra,0x0
    800031e0:	998080e7          	jalr	-1640(ra) # 80002b74 <consputc>
    800031e4:	00002d97          	auipc	s11,0x2
    800031e8:	f9cd8d93          	addi	s11,s11,-100 # 80005180 <digits>
    800031ec:	03ccd793          	srli	a5,s9,0x3c
    800031f0:	00fd87b3          	add	a5,s11,a5
    800031f4:	0007c503          	lbu	a0,0(a5)
    800031f8:	fffd0d1b          	addiw	s10,s10,-1
    800031fc:	004c9c93          	slli	s9,s9,0x4
    80003200:	00000097          	auipc	ra,0x0
    80003204:	974080e7          	jalr	-1676(ra) # 80002b74 <consputc>
    80003208:	fe0d12e3          	bnez	s10,800031ec <__printf+0x494>
    8000320c:	f8dff06f          	j	80003198 <__printf+0x440>
    80003210:	f7843783          	ld	a5,-136(s0)
    80003214:	0007bc83          	ld	s9,0(a5)
    80003218:	00878793          	addi	a5,a5,8
    8000321c:	f6f43c23          	sd	a5,-136(s0)
    80003220:	000c9a63          	bnez	s9,80003234 <__printf+0x4dc>
    80003224:	1080006f          	j	8000332c <__printf+0x5d4>
    80003228:	001c8c93          	addi	s9,s9,1
    8000322c:	00000097          	auipc	ra,0x0
    80003230:	948080e7          	jalr	-1720(ra) # 80002b74 <consputc>
    80003234:	000cc503          	lbu	a0,0(s9)
    80003238:	fe0518e3          	bnez	a0,80003228 <__printf+0x4d0>
    8000323c:	f5dff06f          	j	80003198 <__printf+0x440>
    80003240:	02500513          	li	a0,37
    80003244:	00000097          	auipc	ra,0x0
    80003248:	930080e7          	jalr	-1744(ra) # 80002b74 <consputc>
    8000324c:	000c8513          	mv	a0,s9
    80003250:	00000097          	auipc	ra,0x0
    80003254:	924080e7          	jalr	-1756(ra) # 80002b74 <consputc>
    80003258:	f41ff06f          	j	80003198 <__printf+0x440>
    8000325c:	02500513          	li	a0,37
    80003260:	00000097          	auipc	ra,0x0
    80003264:	914080e7          	jalr	-1772(ra) # 80002b74 <consputc>
    80003268:	f31ff06f          	j	80003198 <__printf+0x440>
    8000326c:	00030513          	mv	a0,t1
    80003270:	00000097          	auipc	ra,0x0
    80003274:	7bc080e7          	jalr	1980(ra) # 80003a2c <acquire>
    80003278:	b4dff06f          	j	80002dc4 <__printf+0x6c>
    8000327c:	40c0053b          	negw	a0,a2
    80003280:	00a00713          	li	a4,10
    80003284:	02e576bb          	remuw	a3,a0,a4
    80003288:	00002d97          	auipc	s11,0x2
    8000328c:	ef8d8d93          	addi	s11,s11,-264 # 80005180 <digits>
    80003290:	ff700593          	li	a1,-9
    80003294:	02069693          	slli	a3,a3,0x20
    80003298:	0206d693          	srli	a3,a3,0x20
    8000329c:	00dd86b3          	add	a3,s11,a3
    800032a0:	0006c683          	lbu	a3,0(a3)
    800032a4:	02e557bb          	divuw	a5,a0,a4
    800032a8:	f8d40023          	sb	a3,-128(s0)
    800032ac:	10b65e63          	bge	a2,a1,800033c8 <__printf+0x670>
    800032b0:	06300593          	li	a1,99
    800032b4:	02e7f6bb          	remuw	a3,a5,a4
    800032b8:	02069693          	slli	a3,a3,0x20
    800032bc:	0206d693          	srli	a3,a3,0x20
    800032c0:	00dd86b3          	add	a3,s11,a3
    800032c4:	0006c683          	lbu	a3,0(a3)
    800032c8:	02e7d73b          	divuw	a4,a5,a4
    800032cc:	00200793          	li	a5,2
    800032d0:	f8d400a3          	sb	a3,-127(s0)
    800032d4:	bca5ece3          	bltu	a1,a0,80002eac <__printf+0x154>
    800032d8:	ce5ff06f          	j	80002fbc <__printf+0x264>
    800032dc:	40e007bb          	negw	a5,a4
    800032e0:	00002d97          	auipc	s11,0x2
    800032e4:	ea0d8d93          	addi	s11,s11,-352 # 80005180 <digits>
    800032e8:	00f7f693          	andi	a3,a5,15
    800032ec:	00dd86b3          	add	a3,s11,a3
    800032f0:	0006c583          	lbu	a1,0(a3)
    800032f4:	ff100613          	li	a2,-15
    800032f8:	0047d69b          	srliw	a3,a5,0x4
    800032fc:	f8b40023          	sb	a1,-128(s0)
    80003300:	0047d59b          	srliw	a1,a5,0x4
    80003304:	0ac75e63          	bge	a4,a2,800033c0 <__printf+0x668>
    80003308:	00f6f693          	andi	a3,a3,15
    8000330c:	00dd86b3          	add	a3,s11,a3
    80003310:	0006c603          	lbu	a2,0(a3)
    80003314:	00f00693          	li	a3,15
    80003318:	0087d79b          	srliw	a5,a5,0x8
    8000331c:	f8c400a3          	sb	a2,-127(s0)
    80003320:	d8b6e4e3          	bltu	a3,a1,800030a8 <__printf+0x350>
    80003324:	00200793          	li	a5,2
    80003328:	e2dff06f          	j	80003154 <__printf+0x3fc>
    8000332c:	00002c97          	auipc	s9,0x2
    80003330:	e34c8c93          	addi	s9,s9,-460 # 80005160 <_ZN3TCB25DEFAULT_SYSTEM_STACK_SIZEE+0x140>
    80003334:	02800513          	li	a0,40
    80003338:	ef1ff06f          	j	80003228 <__printf+0x4d0>
    8000333c:	00700793          	li	a5,7
    80003340:	00600c93          	li	s9,6
    80003344:	e0dff06f          	j	80003150 <__printf+0x3f8>
    80003348:	00700793          	li	a5,7
    8000334c:	00600c93          	li	s9,6
    80003350:	c69ff06f          	j	80002fb8 <__printf+0x260>
    80003354:	00300793          	li	a5,3
    80003358:	00200c93          	li	s9,2
    8000335c:	c5dff06f          	j	80002fb8 <__printf+0x260>
    80003360:	00300793          	li	a5,3
    80003364:	00200c93          	li	s9,2
    80003368:	de9ff06f          	j	80003150 <__printf+0x3f8>
    8000336c:	00400793          	li	a5,4
    80003370:	00300c93          	li	s9,3
    80003374:	dddff06f          	j	80003150 <__printf+0x3f8>
    80003378:	00400793          	li	a5,4
    8000337c:	00300c93          	li	s9,3
    80003380:	c39ff06f          	j	80002fb8 <__printf+0x260>
    80003384:	00500793          	li	a5,5
    80003388:	00400c93          	li	s9,4
    8000338c:	c2dff06f          	j	80002fb8 <__printf+0x260>
    80003390:	00500793          	li	a5,5
    80003394:	00400c93          	li	s9,4
    80003398:	db9ff06f          	j	80003150 <__printf+0x3f8>
    8000339c:	00600793          	li	a5,6
    800033a0:	00500c93          	li	s9,5
    800033a4:	dadff06f          	j	80003150 <__printf+0x3f8>
    800033a8:	00600793          	li	a5,6
    800033ac:	00500c93          	li	s9,5
    800033b0:	c09ff06f          	j	80002fb8 <__printf+0x260>
    800033b4:	00800793          	li	a5,8
    800033b8:	00700c93          	li	s9,7
    800033bc:	bfdff06f          	j	80002fb8 <__printf+0x260>
    800033c0:	00100793          	li	a5,1
    800033c4:	d91ff06f          	j	80003154 <__printf+0x3fc>
    800033c8:	00100793          	li	a5,1
    800033cc:	bf1ff06f          	j	80002fbc <__printf+0x264>
    800033d0:	00900793          	li	a5,9
    800033d4:	00800c93          	li	s9,8
    800033d8:	be1ff06f          	j	80002fb8 <__printf+0x260>
    800033dc:	00002517          	auipc	a0,0x2
    800033e0:	d8c50513          	addi	a0,a0,-628 # 80005168 <_ZN3TCB25DEFAULT_SYSTEM_STACK_SIZEE+0x148>
    800033e4:	00000097          	auipc	ra,0x0
    800033e8:	918080e7          	jalr	-1768(ra) # 80002cfc <panic>

00000000800033ec <printfinit>:
    800033ec:	fe010113          	addi	sp,sp,-32
    800033f0:	00813823          	sd	s0,16(sp)
    800033f4:	00913423          	sd	s1,8(sp)
    800033f8:	00113c23          	sd	ra,24(sp)
    800033fc:	02010413          	addi	s0,sp,32
    80003400:	00004497          	auipc	s1,0x4
    80003404:	9e048493          	addi	s1,s1,-1568 # 80006de0 <pr>
    80003408:	00048513          	mv	a0,s1
    8000340c:	00002597          	auipc	a1,0x2
    80003410:	d6c58593          	addi	a1,a1,-660 # 80005178 <_ZN3TCB25DEFAULT_SYSTEM_STACK_SIZEE+0x158>
    80003414:	00000097          	auipc	ra,0x0
    80003418:	5f4080e7          	jalr	1524(ra) # 80003a08 <initlock>
    8000341c:	01813083          	ld	ra,24(sp)
    80003420:	01013403          	ld	s0,16(sp)
    80003424:	0004ac23          	sw	zero,24(s1)
    80003428:	00813483          	ld	s1,8(sp)
    8000342c:	02010113          	addi	sp,sp,32
    80003430:	00008067          	ret

0000000080003434 <uartinit>:
    80003434:	ff010113          	addi	sp,sp,-16
    80003438:	00813423          	sd	s0,8(sp)
    8000343c:	01010413          	addi	s0,sp,16
    80003440:	100007b7          	lui	a5,0x10000
    80003444:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80003448:	f8000713          	li	a4,-128
    8000344c:	00e781a3          	sb	a4,3(a5)
    80003450:	00300713          	li	a4,3
    80003454:	00e78023          	sb	a4,0(a5)
    80003458:	000780a3          	sb	zero,1(a5)
    8000345c:	00e781a3          	sb	a4,3(a5)
    80003460:	00700693          	li	a3,7
    80003464:	00d78123          	sb	a3,2(a5)
    80003468:	00e780a3          	sb	a4,1(a5)
    8000346c:	00813403          	ld	s0,8(sp)
    80003470:	01010113          	addi	sp,sp,16
    80003474:	00008067          	ret

0000000080003478 <uartputc>:
    80003478:	00002797          	auipc	a5,0x2
    8000347c:	4d07a783          	lw	a5,1232(a5) # 80005948 <panicked>
    80003480:	00078463          	beqz	a5,80003488 <uartputc+0x10>
    80003484:	0000006f          	j	80003484 <uartputc+0xc>
    80003488:	fd010113          	addi	sp,sp,-48
    8000348c:	02813023          	sd	s0,32(sp)
    80003490:	00913c23          	sd	s1,24(sp)
    80003494:	01213823          	sd	s2,16(sp)
    80003498:	01313423          	sd	s3,8(sp)
    8000349c:	02113423          	sd	ra,40(sp)
    800034a0:	03010413          	addi	s0,sp,48
    800034a4:	00002917          	auipc	s2,0x2
    800034a8:	4ac90913          	addi	s2,s2,1196 # 80005950 <uart_tx_r>
    800034ac:	00093783          	ld	a5,0(s2)
    800034b0:	00002497          	auipc	s1,0x2
    800034b4:	4a848493          	addi	s1,s1,1192 # 80005958 <uart_tx_w>
    800034b8:	0004b703          	ld	a4,0(s1)
    800034bc:	02078693          	addi	a3,a5,32
    800034c0:	00050993          	mv	s3,a0
    800034c4:	02e69c63          	bne	a3,a4,800034fc <uartputc+0x84>
    800034c8:	00001097          	auipc	ra,0x1
    800034cc:	834080e7          	jalr	-1996(ra) # 80003cfc <push_on>
    800034d0:	00093783          	ld	a5,0(s2)
    800034d4:	0004b703          	ld	a4,0(s1)
    800034d8:	02078793          	addi	a5,a5,32
    800034dc:	00e79463          	bne	a5,a4,800034e4 <uartputc+0x6c>
    800034e0:	0000006f          	j	800034e0 <uartputc+0x68>
    800034e4:	00001097          	auipc	ra,0x1
    800034e8:	88c080e7          	jalr	-1908(ra) # 80003d70 <pop_on>
    800034ec:	00093783          	ld	a5,0(s2)
    800034f0:	0004b703          	ld	a4,0(s1)
    800034f4:	02078693          	addi	a3,a5,32
    800034f8:	fce688e3          	beq	a3,a4,800034c8 <uartputc+0x50>
    800034fc:	01f77693          	andi	a3,a4,31
    80003500:	00004597          	auipc	a1,0x4
    80003504:	90058593          	addi	a1,a1,-1792 # 80006e00 <uart_tx_buf>
    80003508:	00d586b3          	add	a3,a1,a3
    8000350c:	00170713          	addi	a4,a4,1
    80003510:	01368023          	sb	s3,0(a3)
    80003514:	00e4b023          	sd	a4,0(s1)
    80003518:	10000637          	lui	a2,0x10000
    8000351c:	02f71063          	bne	a4,a5,8000353c <uartputc+0xc4>
    80003520:	0340006f          	j	80003554 <uartputc+0xdc>
    80003524:	00074703          	lbu	a4,0(a4)
    80003528:	00f93023          	sd	a5,0(s2)
    8000352c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80003530:	00093783          	ld	a5,0(s2)
    80003534:	0004b703          	ld	a4,0(s1)
    80003538:	00f70e63          	beq	a4,a5,80003554 <uartputc+0xdc>
    8000353c:	00564683          	lbu	a3,5(a2)
    80003540:	01f7f713          	andi	a4,a5,31
    80003544:	00e58733          	add	a4,a1,a4
    80003548:	0206f693          	andi	a3,a3,32
    8000354c:	00178793          	addi	a5,a5,1
    80003550:	fc069ae3          	bnez	a3,80003524 <uartputc+0xac>
    80003554:	02813083          	ld	ra,40(sp)
    80003558:	02013403          	ld	s0,32(sp)
    8000355c:	01813483          	ld	s1,24(sp)
    80003560:	01013903          	ld	s2,16(sp)
    80003564:	00813983          	ld	s3,8(sp)
    80003568:	03010113          	addi	sp,sp,48
    8000356c:	00008067          	ret

0000000080003570 <uartputc_sync>:
    80003570:	ff010113          	addi	sp,sp,-16
    80003574:	00813423          	sd	s0,8(sp)
    80003578:	01010413          	addi	s0,sp,16
    8000357c:	00002717          	auipc	a4,0x2
    80003580:	3cc72703          	lw	a4,972(a4) # 80005948 <panicked>
    80003584:	02071663          	bnez	a4,800035b0 <uartputc_sync+0x40>
    80003588:	00050793          	mv	a5,a0
    8000358c:	100006b7          	lui	a3,0x10000
    80003590:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80003594:	02077713          	andi	a4,a4,32
    80003598:	fe070ce3          	beqz	a4,80003590 <uartputc_sync+0x20>
    8000359c:	0ff7f793          	andi	a5,a5,255
    800035a0:	00f68023          	sb	a5,0(a3)
    800035a4:	00813403          	ld	s0,8(sp)
    800035a8:	01010113          	addi	sp,sp,16
    800035ac:	00008067          	ret
    800035b0:	0000006f          	j	800035b0 <uartputc_sync+0x40>

00000000800035b4 <uartstart>:
    800035b4:	ff010113          	addi	sp,sp,-16
    800035b8:	00813423          	sd	s0,8(sp)
    800035bc:	01010413          	addi	s0,sp,16
    800035c0:	00002617          	auipc	a2,0x2
    800035c4:	39060613          	addi	a2,a2,912 # 80005950 <uart_tx_r>
    800035c8:	00002517          	auipc	a0,0x2
    800035cc:	39050513          	addi	a0,a0,912 # 80005958 <uart_tx_w>
    800035d0:	00063783          	ld	a5,0(a2)
    800035d4:	00053703          	ld	a4,0(a0)
    800035d8:	04f70263          	beq	a4,a5,8000361c <uartstart+0x68>
    800035dc:	100005b7          	lui	a1,0x10000
    800035e0:	00004817          	auipc	a6,0x4
    800035e4:	82080813          	addi	a6,a6,-2016 # 80006e00 <uart_tx_buf>
    800035e8:	01c0006f          	j	80003604 <uartstart+0x50>
    800035ec:	0006c703          	lbu	a4,0(a3)
    800035f0:	00f63023          	sd	a5,0(a2)
    800035f4:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800035f8:	00063783          	ld	a5,0(a2)
    800035fc:	00053703          	ld	a4,0(a0)
    80003600:	00f70e63          	beq	a4,a5,8000361c <uartstart+0x68>
    80003604:	01f7f713          	andi	a4,a5,31
    80003608:	00e806b3          	add	a3,a6,a4
    8000360c:	0055c703          	lbu	a4,5(a1)
    80003610:	00178793          	addi	a5,a5,1
    80003614:	02077713          	andi	a4,a4,32
    80003618:	fc071ae3          	bnez	a4,800035ec <uartstart+0x38>
    8000361c:	00813403          	ld	s0,8(sp)
    80003620:	01010113          	addi	sp,sp,16
    80003624:	00008067          	ret

0000000080003628 <uartgetc>:
    80003628:	ff010113          	addi	sp,sp,-16
    8000362c:	00813423          	sd	s0,8(sp)
    80003630:	01010413          	addi	s0,sp,16
    80003634:	10000737          	lui	a4,0x10000
    80003638:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    8000363c:	0017f793          	andi	a5,a5,1
    80003640:	00078c63          	beqz	a5,80003658 <uartgetc+0x30>
    80003644:	00074503          	lbu	a0,0(a4)
    80003648:	0ff57513          	andi	a0,a0,255
    8000364c:	00813403          	ld	s0,8(sp)
    80003650:	01010113          	addi	sp,sp,16
    80003654:	00008067          	ret
    80003658:	fff00513          	li	a0,-1
    8000365c:	ff1ff06f          	j	8000364c <uartgetc+0x24>

0000000080003660 <uartintr>:
    80003660:	100007b7          	lui	a5,0x10000
    80003664:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80003668:	0017f793          	andi	a5,a5,1
    8000366c:	0a078463          	beqz	a5,80003714 <uartintr+0xb4>
    80003670:	fe010113          	addi	sp,sp,-32
    80003674:	00813823          	sd	s0,16(sp)
    80003678:	00913423          	sd	s1,8(sp)
    8000367c:	00113c23          	sd	ra,24(sp)
    80003680:	02010413          	addi	s0,sp,32
    80003684:	100004b7          	lui	s1,0x10000
    80003688:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    8000368c:	0ff57513          	andi	a0,a0,255
    80003690:	fffff097          	auipc	ra,0xfffff
    80003694:	534080e7          	jalr	1332(ra) # 80002bc4 <consoleintr>
    80003698:	0054c783          	lbu	a5,5(s1)
    8000369c:	0017f793          	andi	a5,a5,1
    800036a0:	fe0794e3          	bnez	a5,80003688 <uartintr+0x28>
    800036a4:	00002617          	auipc	a2,0x2
    800036a8:	2ac60613          	addi	a2,a2,684 # 80005950 <uart_tx_r>
    800036ac:	00002517          	auipc	a0,0x2
    800036b0:	2ac50513          	addi	a0,a0,684 # 80005958 <uart_tx_w>
    800036b4:	00063783          	ld	a5,0(a2)
    800036b8:	00053703          	ld	a4,0(a0)
    800036bc:	04f70263          	beq	a4,a5,80003700 <uartintr+0xa0>
    800036c0:	100005b7          	lui	a1,0x10000
    800036c4:	00003817          	auipc	a6,0x3
    800036c8:	73c80813          	addi	a6,a6,1852 # 80006e00 <uart_tx_buf>
    800036cc:	01c0006f          	j	800036e8 <uartintr+0x88>
    800036d0:	0006c703          	lbu	a4,0(a3)
    800036d4:	00f63023          	sd	a5,0(a2)
    800036d8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800036dc:	00063783          	ld	a5,0(a2)
    800036e0:	00053703          	ld	a4,0(a0)
    800036e4:	00f70e63          	beq	a4,a5,80003700 <uartintr+0xa0>
    800036e8:	01f7f713          	andi	a4,a5,31
    800036ec:	00e806b3          	add	a3,a6,a4
    800036f0:	0055c703          	lbu	a4,5(a1)
    800036f4:	00178793          	addi	a5,a5,1
    800036f8:	02077713          	andi	a4,a4,32
    800036fc:	fc071ae3          	bnez	a4,800036d0 <uartintr+0x70>
    80003700:	01813083          	ld	ra,24(sp)
    80003704:	01013403          	ld	s0,16(sp)
    80003708:	00813483          	ld	s1,8(sp)
    8000370c:	02010113          	addi	sp,sp,32
    80003710:	00008067          	ret
    80003714:	00002617          	auipc	a2,0x2
    80003718:	23c60613          	addi	a2,a2,572 # 80005950 <uart_tx_r>
    8000371c:	00002517          	auipc	a0,0x2
    80003720:	23c50513          	addi	a0,a0,572 # 80005958 <uart_tx_w>
    80003724:	00063783          	ld	a5,0(a2)
    80003728:	00053703          	ld	a4,0(a0)
    8000372c:	04f70263          	beq	a4,a5,80003770 <uartintr+0x110>
    80003730:	100005b7          	lui	a1,0x10000
    80003734:	00003817          	auipc	a6,0x3
    80003738:	6cc80813          	addi	a6,a6,1740 # 80006e00 <uart_tx_buf>
    8000373c:	01c0006f          	j	80003758 <uartintr+0xf8>
    80003740:	0006c703          	lbu	a4,0(a3)
    80003744:	00f63023          	sd	a5,0(a2)
    80003748:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000374c:	00063783          	ld	a5,0(a2)
    80003750:	00053703          	ld	a4,0(a0)
    80003754:	02f70063          	beq	a4,a5,80003774 <uartintr+0x114>
    80003758:	01f7f713          	andi	a4,a5,31
    8000375c:	00e806b3          	add	a3,a6,a4
    80003760:	0055c703          	lbu	a4,5(a1)
    80003764:	00178793          	addi	a5,a5,1
    80003768:	02077713          	andi	a4,a4,32
    8000376c:	fc071ae3          	bnez	a4,80003740 <uartintr+0xe0>
    80003770:	00008067          	ret
    80003774:	00008067          	ret

0000000080003778 <kinit>:
    80003778:	fc010113          	addi	sp,sp,-64
    8000377c:	02913423          	sd	s1,40(sp)
    80003780:	fffff7b7          	lui	a5,0xfffff
    80003784:	00004497          	auipc	s1,0x4
    80003788:	69b48493          	addi	s1,s1,1691 # 80007e1f <end+0xfff>
    8000378c:	02813823          	sd	s0,48(sp)
    80003790:	01313c23          	sd	s3,24(sp)
    80003794:	00f4f4b3          	and	s1,s1,a5
    80003798:	02113c23          	sd	ra,56(sp)
    8000379c:	03213023          	sd	s2,32(sp)
    800037a0:	01413823          	sd	s4,16(sp)
    800037a4:	01513423          	sd	s5,8(sp)
    800037a8:	04010413          	addi	s0,sp,64
    800037ac:	000017b7          	lui	a5,0x1
    800037b0:	01100993          	li	s3,17
    800037b4:	00f487b3          	add	a5,s1,a5
    800037b8:	01b99993          	slli	s3,s3,0x1b
    800037bc:	06f9e063          	bltu	s3,a5,8000381c <kinit+0xa4>
    800037c0:	00003a97          	auipc	s5,0x3
    800037c4:	660a8a93          	addi	s5,s5,1632 # 80006e20 <end>
    800037c8:	0754ec63          	bltu	s1,s5,80003840 <kinit+0xc8>
    800037cc:	0734fa63          	bgeu	s1,s3,80003840 <kinit+0xc8>
    800037d0:	00088a37          	lui	s4,0x88
    800037d4:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    800037d8:	00002917          	auipc	s2,0x2
    800037dc:	18890913          	addi	s2,s2,392 # 80005960 <kmem>
    800037e0:	00ca1a13          	slli	s4,s4,0xc
    800037e4:	0140006f          	j	800037f8 <kinit+0x80>
    800037e8:	000017b7          	lui	a5,0x1
    800037ec:	00f484b3          	add	s1,s1,a5
    800037f0:	0554e863          	bltu	s1,s5,80003840 <kinit+0xc8>
    800037f4:	0534f663          	bgeu	s1,s3,80003840 <kinit+0xc8>
    800037f8:	00001637          	lui	a2,0x1
    800037fc:	00100593          	li	a1,1
    80003800:	00048513          	mv	a0,s1
    80003804:	00000097          	auipc	ra,0x0
    80003808:	5e4080e7          	jalr	1508(ra) # 80003de8 <__memset>
    8000380c:	00093783          	ld	a5,0(s2)
    80003810:	00f4b023          	sd	a5,0(s1)
    80003814:	00993023          	sd	s1,0(s2)
    80003818:	fd4498e3          	bne	s1,s4,800037e8 <kinit+0x70>
    8000381c:	03813083          	ld	ra,56(sp)
    80003820:	03013403          	ld	s0,48(sp)
    80003824:	02813483          	ld	s1,40(sp)
    80003828:	02013903          	ld	s2,32(sp)
    8000382c:	01813983          	ld	s3,24(sp)
    80003830:	01013a03          	ld	s4,16(sp)
    80003834:	00813a83          	ld	s5,8(sp)
    80003838:	04010113          	addi	sp,sp,64
    8000383c:	00008067          	ret
    80003840:	00002517          	auipc	a0,0x2
    80003844:	95850513          	addi	a0,a0,-1704 # 80005198 <digits+0x18>
    80003848:	fffff097          	auipc	ra,0xfffff
    8000384c:	4b4080e7          	jalr	1204(ra) # 80002cfc <panic>

0000000080003850 <freerange>:
    80003850:	fc010113          	addi	sp,sp,-64
    80003854:	000017b7          	lui	a5,0x1
    80003858:	02913423          	sd	s1,40(sp)
    8000385c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80003860:	009504b3          	add	s1,a0,s1
    80003864:	fffff537          	lui	a0,0xfffff
    80003868:	02813823          	sd	s0,48(sp)
    8000386c:	02113c23          	sd	ra,56(sp)
    80003870:	03213023          	sd	s2,32(sp)
    80003874:	01313c23          	sd	s3,24(sp)
    80003878:	01413823          	sd	s4,16(sp)
    8000387c:	01513423          	sd	s5,8(sp)
    80003880:	01613023          	sd	s6,0(sp)
    80003884:	04010413          	addi	s0,sp,64
    80003888:	00a4f4b3          	and	s1,s1,a0
    8000388c:	00f487b3          	add	a5,s1,a5
    80003890:	06f5e463          	bltu	a1,a5,800038f8 <freerange+0xa8>
    80003894:	00003a97          	auipc	s5,0x3
    80003898:	58ca8a93          	addi	s5,s5,1420 # 80006e20 <end>
    8000389c:	0954e263          	bltu	s1,s5,80003920 <freerange+0xd0>
    800038a0:	01100993          	li	s3,17
    800038a4:	01b99993          	slli	s3,s3,0x1b
    800038a8:	0734fc63          	bgeu	s1,s3,80003920 <freerange+0xd0>
    800038ac:	00058a13          	mv	s4,a1
    800038b0:	00002917          	auipc	s2,0x2
    800038b4:	0b090913          	addi	s2,s2,176 # 80005960 <kmem>
    800038b8:	00002b37          	lui	s6,0x2
    800038bc:	0140006f          	j	800038d0 <freerange+0x80>
    800038c0:	000017b7          	lui	a5,0x1
    800038c4:	00f484b3          	add	s1,s1,a5
    800038c8:	0554ec63          	bltu	s1,s5,80003920 <freerange+0xd0>
    800038cc:	0534fa63          	bgeu	s1,s3,80003920 <freerange+0xd0>
    800038d0:	00001637          	lui	a2,0x1
    800038d4:	00100593          	li	a1,1
    800038d8:	00048513          	mv	a0,s1
    800038dc:	00000097          	auipc	ra,0x0
    800038e0:	50c080e7          	jalr	1292(ra) # 80003de8 <__memset>
    800038e4:	00093703          	ld	a4,0(s2)
    800038e8:	016487b3          	add	a5,s1,s6
    800038ec:	00e4b023          	sd	a4,0(s1)
    800038f0:	00993023          	sd	s1,0(s2)
    800038f4:	fcfa76e3          	bgeu	s4,a5,800038c0 <freerange+0x70>
    800038f8:	03813083          	ld	ra,56(sp)
    800038fc:	03013403          	ld	s0,48(sp)
    80003900:	02813483          	ld	s1,40(sp)
    80003904:	02013903          	ld	s2,32(sp)
    80003908:	01813983          	ld	s3,24(sp)
    8000390c:	01013a03          	ld	s4,16(sp)
    80003910:	00813a83          	ld	s5,8(sp)
    80003914:	00013b03          	ld	s6,0(sp)
    80003918:	04010113          	addi	sp,sp,64
    8000391c:	00008067          	ret
    80003920:	00002517          	auipc	a0,0x2
    80003924:	87850513          	addi	a0,a0,-1928 # 80005198 <digits+0x18>
    80003928:	fffff097          	auipc	ra,0xfffff
    8000392c:	3d4080e7          	jalr	980(ra) # 80002cfc <panic>

0000000080003930 <kfree>:
    80003930:	fe010113          	addi	sp,sp,-32
    80003934:	00813823          	sd	s0,16(sp)
    80003938:	00113c23          	sd	ra,24(sp)
    8000393c:	00913423          	sd	s1,8(sp)
    80003940:	02010413          	addi	s0,sp,32
    80003944:	03451793          	slli	a5,a0,0x34
    80003948:	04079c63          	bnez	a5,800039a0 <kfree+0x70>
    8000394c:	00003797          	auipc	a5,0x3
    80003950:	4d478793          	addi	a5,a5,1236 # 80006e20 <end>
    80003954:	00050493          	mv	s1,a0
    80003958:	04f56463          	bltu	a0,a5,800039a0 <kfree+0x70>
    8000395c:	01100793          	li	a5,17
    80003960:	01b79793          	slli	a5,a5,0x1b
    80003964:	02f57e63          	bgeu	a0,a5,800039a0 <kfree+0x70>
    80003968:	00001637          	lui	a2,0x1
    8000396c:	00100593          	li	a1,1
    80003970:	00000097          	auipc	ra,0x0
    80003974:	478080e7          	jalr	1144(ra) # 80003de8 <__memset>
    80003978:	00002797          	auipc	a5,0x2
    8000397c:	fe878793          	addi	a5,a5,-24 # 80005960 <kmem>
    80003980:	0007b703          	ld	a4,0(a5)
    80003984:	01813083          	ld	ra,24(sp)
    80003988:	01013403          	ld	s0,16(sp)
    8000398c:	00e4b023          	sd	a4,0(s1)
    80003990:	0097b023          	sd	s1,0(a5)
    80003994:	00813483          	ld	s1,8(sp)
    80003998:	02010113          	addi	sp,sp,32
    8000399c:	00008067          	ret
    800039a0:	00001517          	auipc	a0,0x1
    800039a4:	7f850513          	addi	a0,a0,2040 # 80005198 <digits+0x18>
    800039a8:	fffff097          	auipc	ra,0xfffff
    800039ac:	354080e7          	jalr	852(ra) # 80002cfc <panic>

00000000800039b0 <kalloc>:
    800039b0:	fe010113          	addi	sp,sp,-32
    800039b4:	00813823          	sd	s0,16(sp)
    800039b8:	00913423          	sd	s1,8(sp)
    800039bc:	00113c23          	sd	ra,24(sp)
    800039c0:	02010413          	addi	s0,sp,32
    800039c4:	00002797          	auipc	a5,0x2
    800039c8:	f9c78793          	addi	a5,a5,-100 # 80005960 <kmem>
    800039cc:	0007b483          	ld	s1,0(a5)
    800039d0:	02048063          	beqz	s1,800039f0 <kalloc+0x40>
    800039d4:	0004b703          	ld	a4,0(s1)
    800039d8:	00001637          	lui	a2,0x1
    800039dc:	00500593          	li	a1,5
    800039e0:	00048513          	mv	a0,s1
    800039e4:	00e7b023          	sd	a4,0(a5)
    800039e8:	00000097          	auipc	ra,0x0
    800039ec:	400080e7          	jalr	1024(ra) # 80003de8 <__memset>
    800039f0:	01813083          	ld	ra,24(sp)
    800039f4:	01013403          	ld	s0,16(sp)
    800039f8:	00048513          	mv	a0,s1
    800039fc:	00813483          	ld	s1,8(sp)
    80003a00:	02010113          	addi	sp,sp,32
    80003a04:	00008067          	ret

0000000080003a08 <initlock>:
    80003a08:	ff010113          	addi	sp,sp,-16
    80003a0c:	00813423          	sd	s0,8(sp)
    80003a10:	01010413          	addi	s0,sp,16
    80003a14:	00813403          	ld	s0,8(sp)
    80003a18:	00b53423          	sd	a1,8(a0)
    80003a1c:	00052023          	sw	zero,0(a0)
    80003a20:	00053823          	sd	zero,16(a0)
    80003a24:	01010113          	addi	sp,sp,16
    80003a28:	00008067          	ret

0000000080003a2c <acquire>:
    80003a2c:	fe010113          	addi	sp,sp,-32
    80003a30:	00813823          	sd	s0,16(sp)
    80003a34:	00913423          	sd	s1,8(sp)
    80003a38:	00113c23          	sd	ra,24(sp)
    80003a3c:	01213023          	sd	s2,0(sp)
    80003a40:	02010413          	addi	s0,sp,32
    80003a44:	00050493          	mv	s1,a0
    80003a48:	10002973          	csrr	s2,sstatus
    80003a4c:	100027f3          	csrr	a5,sstatus
    80003a50:	ffd7f793          	andi	a5,a5,-3
    80003a54:	10079073          	csrw	sstatus,a5
    80003a58:	fffff097          	auipc	ra,0xfffff
    80003a5c:	8e8080e7          	jalr	-1816(ra) # 80002340 <mycpu>
    80003a60:	07852783          	lw	a5,120(a0)
    80003a64:	06078e63          	beqz	a5,80003ae0 <acquire+0xb4>
    80003a68:	fffff097          	auipc	ra,0xfffff
    80003a6c:	8d8080e7          	jalr	-1832(ra) # 80002340 <mycpu>
    80003a70:	07852783          	lw	a5,120(a0)
    80003a74:	0004a703          	lw	a4,0(s1)
    80003a78:	0017879b          	addiw	a5,a5,1
    80003a7c:	06f52c23          	sw	a5,120(a0)
    80003a80:	04071063          	bnez	a4,80003ac0 <acquire+0x94>
    80003a84:	00100713          	li	a4,1
    80003a88:	00070793          	mv	a5,a4
    80003a8c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80003a90:	0007879b          	sext.w	a5,a5
    80003a94:	fe079ae3          	bnez	a5,80003a88 <acquire+0x5c>
    80003a98:	0ff0000f          	fence
    80003a9c:	fffff097          	auipc	ra,0xfffff
    80003aa0:	8a4080e7          	jalr	-1884(ra) # 80002340 <mycpu>
    80003aa4:	01813083          	ld	ra,24(sp)
    80003aa8:	01013403          	ld	s0,16(sp)
    80003aac:	00a4b823          	sd	a0,16(s1)
    80003ab0:	00013903          	ld	s2,0(sp)
    80003ab4:	00813483          	ld	s1,8(sp)
    80003ab8:	02010113          	addi	sp,sp,32
    80003abc:	00008067          	ret
    80003ac0:	0104b903          	ld	s2,16(s1)
    80003ac4:	fffff097          	auipc	ra,0xfffff
    80003ac8:	87c080e7          	jalr	-1924(ra) # 80002340 <mycpu>
    80003acc:	faa91ce3          	bne	s2,a0,80003a84 <acquire+0x58>
    80003ad0:	00001517          	auipc	a0,0x1
    80003ad4:	6d050513          	addi	a0,a0,1744 # 800051a0 <digits+0x20>
    80003ad8:	fffff097          	auipc	ra,0xfffff
    80003adc:	224080e7          	jalr	548(ra) # 80002cfc <panic>
    80003ae0:	00195913          	srli	s2,s2,0x1
    80003ae4:	fffff097          	auipc	ra,0xfffff
    80003ae8:	85c080e7          	jalr	-1956(ra) # 80002340 <mycpu>
    80003aec:	00197913          	andi	s2,s2,1
    80003af0:	07252e23          	sw	s2,124(a0)
    80003af4:	f75ff06f          	j	80003a68 <acquire+0x3c>

0000000080003af8 <release>:
    80003af8:	fe010113          	addi	sp,sp,-32
    80003afc:	00813823          	sd	s0,16(sp)
    80003b00:	00113c23          	sd	ra,24(sp)
    80003b04:	00913423          	sd	s1,8(sp)
    80003b08:	01213023          	sd	s2,0(sp)
    80003b0c:	02010413          	addi	s0,sp,32
    80003b10:	00052783          	lw	a5,0(a0)
    80003b14:	00079a63          	bnez	a5,80003b28 <release+0x30>
    80003b18:	00001517          	auipc	a0,0x1
    80003b1c:	69050513          	addi	a0,a0,1680 # 800051a8 <digits+0x28>
    80003b20:	fffff097          	auipc	ra,0xfffff
    80003b24:	1dc080e7          	jalr	476(ra) # 80002cfc <panic>
    80003b28:	01053903          	ld	s2,16(a0)
    80003b2c:	00050493          	mv	s1,a0
    80003b30:	fffff097          	auipc	ra,0xfffff
    80003b34:	810080e7          	jalr	-2032(ra) # 80002340 <mycpu>
    80003b38:	fea910e3          	bne	s2,a0,80003b18 <release+0x20>
    80003b3c:	0004b823          	sd	zero,16(s1)
    80003b40:	0ff0000f          	fence
    80003b44:	0f50000f          	fence	iorw,ow
    80003b48:	0804a02f          	amoswap.w	zero,zero,(s1)
    80003b4c:	ffffe097          	auipc	ra,0xffffe
    80003b50:	7f4080e7          	jalr	2036(ra) # 80002340 <mycpu>
    80003b54:	100027f3          	csrr	a5,sstatus
    80003b58:	0027f793          	andi	a5,a5,2
    80003b5c:	04079a63          	bnez	a5,80003bb0 <release+0xb8>
    80003b60:	07852783          	lw	a5,120(a0)
    80003b64:	02f05e63          	blez	a5,80003ba0 <release+0xa8>
    80003b68:	fff7871b          	addiw	a4,a5,-1
    80003b6c:	06e52c23          	sw	a4,120(a0)
    80003b70:	00071c63          	bnez	a4,80003b88 <release+0x90>
    80003b74:	07c52783          	lw	a5,124(a0)
    80003b78:	00078863          	beqz	a5,80003b88 <release+0x90>
    80003b7c:	100027f3          	csrr	a5,sstatus
    80003b80:	0027e793          	ori	a5,a5,2
    80003b84:	10079073          	csrw	sstatus,a5
    80003b88:	01813083          	ld	ra,24(sp)
    80003b8c:	01013403          	ld	s0,16(sp)
    80003b90:	00813483          	ld	s1,8(sp)
    80003b94:	00013903          	ld	s2,0(sp)
    80003b98:	02010113          	addi	sp,sp,32
    80003b9c:	00008067          	ret
    80003ba0:	00001517          	auipc	a0,0x1
    80003ba4:	62850513          	addi	a0,a0,1576 # 800051c8 <digits+0x48>
    80003ba8:	fffff097          	auipc	ra,0xfffff
    80003bac:	154080e7          	jalr	340(ra) # 80002cfc <panic>
    80003bb0:	00001517          	auipc	a0,0x1
    80003bb4:	60050513          	addi	a0,a0,1536 # 800051b0 <digits+0x30>
    80003bb8:	fffff097          	auipc	ra,0xfffff
    80003bbc:	144080e7          	jalr	324(ra) # 80002cfc <panic>

0000000080003bc0 <holding>:
    80003bc0:	00052783          	lw	a5,0(a0)
    80003bc4:	00079663          	bnez	a5,80003bd0 <holding+0x10>
    80003bc8:	00000513          	li	a0,0
    80003bcc:	00008067          	ret
    80003bd0:	fe010113          	addi	sp,sp,-32
    80003bd4:	00813823          	sd	s0,16(sp)
    80003bd8:	00913423          	sd	s1,8(sp)
    80003bdc:	00113c23          	sd	ra,24(sp)
    80003be0:	02010413          	addi	s0,sp,32
    80003be4:	01053483          	ld	s1,16(a0)
    80003be8:	ffffe097          	auipc	ra,0xffffe
    80003bec:	758080e7          	jalr	1880(ra) # 80002340 <mycpu>
    80003bf0:	01813083          	ld	ra,24(sp)
    80003bf4:	01013403          	ld	s0,16(sp)
    80003bf8:	40a48533          	sub	a0,s1,a0
    80003bfc:	00153513          	seqz	a0,a0
    80003c00:	00813483          	ld	s1,8(sp)
    80003c04:	02010113          	addi	sp,sp,32
    80003c08:	00008067          	ret

0000000080003c0c <push_off>:
    80003c0c:	fe010113          	addi	sp,sp,-32
    80003c10:	00813823          	sd	s0,16(sp)
    80003c14:	00113c23          	sd	ra,24(sp)
    80003c18:	00913423          	sd	s1,8(sp)
    80003c1c:	02010413          	addi	s0,sp,32
    80003c20:	100024f3          	csrr	s1,sstatus
    80003c24:	100027f3          	csrr	a5,sstatus
    80003c28:	ffd7f793          	andi	a5,a5,-3
    80003c2c:	10079073          	csrw	sstatus,a5
    80003c30:	ffffe097          	auipc	ra,0xffffe
    80003c34:	710080e7          	jalr	1808(ra) # 80002340 <mycpu>
    80003c38:	07852783          	lw	a5,120(a0)
    80003c3c:	02078663          	beqz	a5,80003c68 <push_off+0x5c>
    80003c40:	ffffe097          	auipc	ra,0xffffe
    80003c44:	700080e7          	jalr	1792(ra) # 80002340 <mycpu>
    80003c48:	07852783          	lw	a5,120(a0)
    80003c4c:	01813083          	ld	ra,24(sp)
    80003c50:	01013403          	ld	s0,16(sp)
    80003c54:	0017879b          	addiw	a5,a5,1
    80003c58:	06f52c23          	sw	a5,120(a0)
    80003c5c:	00813483          	ld	s1,8(sp)
    80003c60:	02010113          	addi	sp,sp,32
    80003c64:	00008067          	ret
    80003c68:	0014d493          	srli	s1,s1,0x1
    80003c6c:	ffffe097          	auipc	ra,0xffffe
    80003c70:	6d4080e7          	jalr	1748(ra) # 80002340 <mycpu>
    80003c74:	0014f493          	andi	s1,s1,1
    80003c78:	06952e23          	sw	s1,124(a0)
    80003c7c:	fc5ff06f          	j	80003c40 <push_off+0x34>

0000000080003c80 <pop_off>:
    80003c80:	ff010113          	addi	sp,sp,-16
    80003c84:	00813023          	sd	s0,0(sp)
    80003c88:	00113423          	sd	ra,8(sp)
    80003c8c:	01010413          	addi	s0,sp,16
    80003c90:	ffffe097          	auipc	ra,0xffffe
    80003c94:	6b0080e7          	jalr	1712(ra) # 80002340 <mycpu>
    80003c98:	100027f3          	csrr	a5,sstatus
    80003c9c:	0027f793          	andi	a5,a5,2
    80003ca0:	04079663          	bnez	a5,80003cec <pop_off+0x6c>
    80003ca4:	07852783          	lw	a5,120(a0)
    80003ca8:	02f05a63          	blez	a5,80003cdc <pop_off+0x5c>
    80003cac:	fff7871b          	addiw	a4,a5,-1
    80003cb0:	06e52c23          	sw	a4,120(a0)
    80003cb4:	00071c63          	bnez	a4,80003ccc <pop_off+0x4c>
    80003cb8:	07c52783          	lw	a5,124(a0)
    80003cbc:	00078863          	beqz	a5,80003ccc <pop_off+0x4c>
    80003cc0:	100027f3          	csrr	a5,sstatus
    80003cc4:	0027e793          	ori	a5,a5,2
    80003cc8:	10079073          	csrw	sstatus,a5
    80003ccc:	00813083          	ld	ra,8(sp)
    80003cd0:	00013403          	ld	s0,0(sp)
    80003cd4:	01010113          	addi	sp,sp,16
    80003cd8:	00008067          	ret
    80003cdc:	00001517          	auipc	a0,0x1
    80003ce0:	4ec50513          	addi	a0,a0,1260 # 800051c8 <digits+0x48>
    80003ce4:	fffff097          	auipc	ra,0xfffff
    80003ce8:	018080e7          	jalr	24(ra) # 80002cfc <panic>
    80003cec:	00001517          	auipc	a0,0x1
    80003cf0:	4c450513          	addi	a0,a0,1220 # 800051b0 <digits+0x30>
    80003cf4:	fffff097          	auipc	ra,0xfffff
    80003cf8:	008080e7          	jalr	8(ra) # 80002cfc <panic>

0000000080003cfc <push_on>:
    80003cfc:	fe010113          	addi	sp,sp,-32
    80003d00:	00813823          	sd	s0,16(sp)
    80003d04:	00113c23          	sd	ra,24(sp)
    80003d08:	00913423          	sd	s1,8(sp)
    80003d0c:	02010413          	addi	s0,sp,32
    80003d10:	100024f3          	csrr	s1,sstatus
    80003d14:	100027f3          	csrr	a5,sstatus
    80003d18:	0027e793          	ori	a5,a5,2
    80003d1c:	10079073          	csrw	sstatus,a5
    80003d20:	ffffe097          	auipc	ra,0xffffe
    80003d24:	620080e7          	jalr	1568(ra) # 80002340 <mycpu>
    80003d28:	07852783          	lw	a5,120(a0)
    80003d2c:	02078663          	beqz	a5,80003d58 <push_on+0x5c>
    80003d30:	ffffe097          	auipc	ra,0xffffe
    80003d34:	610080e7          	jalr	1552(ra) # 80002340 <mycpu>
    80003d38:	07852783          	lw	a5,120(a0)
    80003d3c:	01813083          	ld	ra,24(sp)
    80003d40:	01013403          	ld	s0,16(sp)
    80003d44:	0017879b          	addiw	a5,a5,1
    80003d48:	06f52c23          	sw	a5,120(a0)
    80003d4c:	00813483          	ld	s1,8(sp)
    80003d50:	02010113          	addi	sp,sp,32
    80003d54:	00008067          	ret
    80003d58:	0014d493          	srli	s1,s1,0x1
    80003d5c:	ffffe097          	auipc	ra,0xffffe
    80003d60:	5e4080e7          	jalr	1508(ra) # 80002340 <mycpu>
    80003d64:	0014f493          	andi	s1,s1,1
    80003d68:	06952e23          	sw	s1,124(a0)
    80003d6c:	fc5ff06f          	j	80003d30 <push_on+0x34>

0000000080003d70 <pop_on>:
    80003d70:	ff010113          	addi	sp,sp,-16
    80003d74:	00813023          	sd	s0,0(sp)
    80003d78:	00113423          	sd	ra,8(sp)
    80003d7c:	01010413          	addi	s0,sp,16
    80003d80:	ffffe097          	auipc	ra,0xffffe
    80003d84:	5c0080e7          	jalr	1472(ra) # 80002340 <mycpu>
    80003d88:	100027f3          	csrr	a5,sstatus
    80003d8c:	0027f793          	andi	a5,a5,2
    80003d90:	04078463          	beqz	a5,80003dd8 <pop_on+0x68>
    80003d94:	07852783          	lw	a5,120(a0)
    80003d98:	02f05863          	blez	a5,80003dc8 <pop_on+0x58>
    80003d9c:	fff7879b          	addiw	a5,a5,-1
    80003da0:	06f52c23          	sw	a5,120(a0)
    80003da4:	07853783          	ld	a5,120(a0)
    80003da8:	00079863          	bnez	a5,80003db8 <pop_on+0x48>
    80003dac:	100027f3          	csrr	a5,sstatus
    80003db0:	ffd7f793          	andi	a5,a5,-3
    80003db4:	10079073          	csrw	sstatus,a5
    80003db8:	00813083          	ld	ra,8(sp)
    80003dbc:	00013403          	ld	s0,0(sp)
    80003dc0:	01010113          	addi	sp,sp,16
    80003dc4:	00008067          	ret
    80003dc8:	00001517          	auipc	a0,0x1
    80003dcc:	42850513          	addi	a0,a0,1064 # 800051f0 <digits+0x70>
    80003dd0:	fffff097          	auipc	ra,0xfffff
    80003dd4:	f2c080e7          	jalr	-212(ra) # 80002cfc <panic>
    80003dd8:	00001517          	auipc	a0,0x1
    80003ddc:	3f850513          	addi	a0,a0,1016 # 800051d0 <digits+0x50>
    80003de0:	fffff097          	auipc	ra,0xfffff
    80003de4:	f1c080e7          	jalr	-228(ra) # 80002cfc <panic>

0000000080003de8 <__memset>:
    80003de8:	ff010113          	addi	sp,sp,-16
    80003dec:	00813423          	sd	s0,8(sp)
    80003df0:	01010413          	addi	s0,sp,16
    80003df4:	1a060e63          	beqz	a2,80003fb0 <__memset+0x1c8>
    80003df8:	40a007b3          	neg	a5,a0
    80003dfc:	0077f793          	andi	a5,a5,7
    80003e00:	00778693          	addi	a3,a5,7
    80003e04:	00b00813          	li	a6,11
    80003e08:	0ff5f593          	andi	a1,a1,255
    80003e0c:	fff6071b          	addiw	a4,a2,-1
    80003e10:	1b06e663          	bltu	a3,a6,80003fbc <__memset+0x1d4>
    80003e14:	1cd76463          	bltu	a4,a3,80003fdc <__memset+0x1f4>
    80003e18:	1a078e63          	beqz	a5,80003fd4 <__memset+0x1ec>
    80003e1c:	00b50023          	sb	a1,0(a0)
    80003e20:	00100713          	li	a4,1
    80003e24:	1ae78463          	beq	a5,a4,80003fcc <__memset+0x1e4>
    80003e28:	00b500a3          	sb	a1,1(a0)
    80003e2c:	00200713          	li	a4,2
    80003e30:	1ae78a63          	beq	a5,a4,80003fe4 <__memset+0x1fc>
    80003e34:	00b50123          	sb	a1,2(a0)
    80003e38:	00300713          	li	a4,3
    80003e3c:	18e78463          	beq	a5,a4,80003fc4 <__memset+0x1dc>
    80003e40:	00b501a3          	sb	a1,3(a0)
    80003e44:	00400713          	li	a4,4
    80003e48:	1ae78263          	beq	a5,a4,80003fec <__memset+0x204>
    80003e4c:	00b50223          	sb	a1,4(a0)
    80003e50:	00500713          	li	a4,5
    80003e54:	1ae78063          	beq	a5,a4,80003ff4 <__memset+0x20c>
    80003e58:	00b502a3          	sb	a1,5(a0)
    80003e5c:	00700713          	li	a4,7
    80003e60:	18e79e63          	bne	a5,a4,80003ffc <__memset+0x214>
    80003e64:	00b50323          	sb	a1,6(a0)
    80003e68:	00700e93          	li	t4,7
    80003e6c:	00859713          	slli	a4,a1,0x8
    80003e70:	00e5e733          	or	a4,a1,a4
    80003e74:	01059e13          	slli	t3,a1,0x10
    80003e78:	01c76e33          	or	t3,a4,t3
    80003e7c:	01859313          	slli	t1,a1,0x18
    80003e80:	006e6333          	or	t1,t3,t1
    80003e84:	02059893          	slli	a7,a1,0x20
    80003e88:	40f60e3b          	subw	t3,a2,a5
    80003e8c:	011368b3          	or	a7,t1,a7
    80003e90:	02859813          	slli	a6,a1,0x28
    80003e94:	0108e833          	or	a6,a7,a6
    80003e98:	03059693          	slli	a3,a1,0x30
    80003e9c:	003e589b          	srliw	a7,t3,0x3
    80003ea0:	00d866b3          	or	a3,a6,a3
    80003ea4:	03859713          	slli	a4,a1,0x38
    80003ea8:	00389813          	slli	a6,a7,0x3
    80003eac:	00f507b3          	add	a5,a0,a5
    80003eb0:	00e6e733          	or	a4,a3,a4
    80003eb4:	000e089b          	sext.w	a7,t3
    80003eb8:	00f806b3          	add	a3,a6,a5
    80003ebc:	00e7b023          	sd	a4,0(a5)
    80003ec0:	00878793          	addi	a5,a5,8
    80003ec4:	fed79ce3          	bne	a5,a3,80003ebc <__memset+0xd4>
    80003ec8:	ff8e7793          	andi	a5,t3,-8
    80003ecc:	0007871b          	sext.w	a4,a5
    80003ed0:	01d787bb          	addw	a5,a5,t4
    80003ed4:	0ce88e63          	beq	a7,a4,80003fb0 <__memset+0x1c8>
    80003ed8:	00f50733          	add	a4,a0,a5
    80003edc:	00b70023          	sb	a1,0(a4)
    80003ee0:	0017871b          	addiw	a4,a5,1
    80003ee4:	0cc77663          	bgeu	a4,a2,80003fb0 <__memset+0x1c8>
    80003ee8:	00e50733          	add	a4,a0,a4
    80003eec:	00b70023          	sb	a1,0(a4)
    80003ef0:	0027871b          	addiw	a4,a5,2
    80003ef4:	0ac77e63          	bgeu	a4,a2,80003fb0 <__memset+0x1c8>
    80003ef8:	00e50733          	add	a4,a0,a4
    80003efc:	00b70023          	sb	a1,0(a4)
    80003f00:	0037871b          	addiw	a4,a5,3
    80003f04:	0ac77663          	bgeu	a4,a2,80003fb0 <__memset+0x1c8>
    80003f08:	00e50733          	add	a4,a0,a4
    80003f0c:	00b70023          	sb	a1,0(a4)
    80003f10:	0047871b          	addiw	a4,a5,4
    80003f14:	08c77e63          	bgeu	a4,a2,80003fb0 <__memset+0x1c8>
    80003f18:	00e50733          	add	a4,a0,a4
    80003f1c:	00b70023          	sb	a1,0(a4)
    80003f20:	0057871b          	addiw	a4,a5,5
    80003f24:	08c77663          	bgeu	a4,a2,80003fb0 <__memset+0x1c8>
    80003f28:	00e50733          	add	a4,a0,a4
    80003f2c:	00b70023          	sb	a1,0(a4)
    80003f30:	0067871b          	addiw	a4,a5,6
    80003f34:	06c77e63          	bgeu	a4,a2,80003fb0 <__memset+0x1c8>
    80003f38:	00e50733          	add	a4,a0,a4
    80003f3c:	00b70023          	sb	a1,0(a4)
    80003f40:	0077871b          	addiw	a4,a5,7
    80003f44:	06c77663          	bgeu	a4,a2,80003fb0 <__memset+0x1c8>
    80003f48:	00e50733          	add	a4,a0,a4
    80003f4c:	00b70023          	sb	a1,0(a4)
    80003f50:	0087871b          	addiw	a4,a5,8
    80003f54:	04c77e63          	bgeu	a4,a2,80003fb0 <__memset+0x1c8>
    80003f58:	00e50733          	add	a4,a0,a4
    80003f5c:	00b70023          	sb	a1,0(a4)
    80003f60:	0097871b          	addiw	a4,a5,9
    80003f64:	04c77663          	bgeu	a4,a2,80003fb0 <__memset+0x1c8>
    80003f68:	00e50733          	add	a4,a0,a4
    80003f6c:	00b70023          	sb	a1,0(a4)
    80003f70:	00a7871b          	addiw	a4,a5,10
    80003f74:	02c77e63          	bgeu	a4,a2,80003fb0 <__memset+0x1c8>
    80003f78:	00e50733          	add	a4,a0,a4
    80003f7c:	00b70023          	sb	a1,0(a4)
    80003f80:	00b7871b          	addiw	a4,a5,11
    80003f84:	02c77663          	bgeu	a4,a2,80003fb0 <__memset+0x1c8>
    80003f88:	00e50733          	add	a4,a0,a4
    80003f8c:	00b70023          	sb	a1,0(a4)
    80003f90:	00c7871b          	addiw	a4,a5,12
    80003f94:	00c77e63          	bgeu	a4,a2,80003fb0 <__memset+0x1c8>
    80003f98:	00e50733          	add	a4,a0,a4
    80003f9c:	00b70023          	sb	a1,0(a4)
    80003fa0:	00d7879b          	addiw	a5,a5,13
    80003fa4:	00c7f663          	bgeu	a5,a2,80003fb0 <__memset+0x1c8>
    80003fa8:	00f507b3          	add	a5,a0,a5
    80003fac:	00b78023          	sb	a1,0(a5)
    80003fb0:	00813403          	ld	s0,8(sp)
    80003fb4:	01010113          	addi	sp,sp,16
    80003fb8:	00008067          	ret
    80003fbc:	00b00693          	li	a3,11
    80003fc0:	e55ff06f          	j	80003e14 <__memset+0x2c>
    80003fc4:	00300e93          	li	t4,3
    80003fc8:	ea5ff06f          	j	80003e6c <__memset+0x84>
    80003fcc:	00100e93          	li	t4,1
    80003fd0:	e9dff06f          	j	80003e6c <__memset+0x84>
    80003fd4:	00000e93          	li	t4,0
    80003fd8:	e95ff06f          	j	80003e6c <__memset+0x84>
    80003fdc:	00000793          	li	a5,0
    80003fe0:	ef9ff06f          	j	80003ed8 <__memset+0xf0>
    80003fe4:	00200e93          	li	t4,2
    80003fe8:	e85ff06f          	j	80003e6c <__memset+0x84>
    80003fec:	00400e93          	li	t4,4
    80003ff0:	e7dff06f          	j	80003e6c <__memset+0x84>
    80003ff4:	00500e93          	li	t4,5
    80003ff8:	e75ff06f          	j	80003e6c <__memset+0x84>
    80003ffc:	00600e93          	li	t4,6
    80004000:	e6dff06f          	j	80003e6c <__memset+0x84>

0000000080004004 <__memmove>:
    80004004:	ff010113          	addi	sp,sp,-16
    80004008:	00813423          	sd	s0,8(sp)
    8000400c:	01010413          	addi	s0,sp,16
    80004010:	0e060863          	beqz	a2,80004100 <__memmove+0xfc>
    80004014:	fff6069b          	addiw	a3,a2,-1
    80004018:	0006881b          	sext.w	a6,a3
    8000401c:	0ea5e863          	bltu	a1,a0,8000410c <__memmove+0x108>
    80004020:	00758713          	addi	a4,a1,7
    80004024:	00a5e7b3          	or	a5,a1,a0
    80004028:	40a70733          	sub	a4,a4,a0
    8000402c:	0077f793          	andi	a5,a5,7
    80004030:	00f73713          	sltiu	a4,a4,15
    80004034:	00174713          	xori	a4,a4,1
    80004038:	0017b793          	seqz	a5,a5
    8000403c:	00e7f7b3          	and	a5,a5,a4
    80004040:	10078863          	beqz	a5,80004150 <__memmove+0x14c>
    80004044:	00900793          	li	a5,9
    80004048:	1107f463          	bgeu	a5,a6,80004150 <__memmove+0x14c>
    8000404c:	0036581b          	srliw	a6,a2,0x3
    80004050:	fff8081b          	addiw	a6,a6,-1
    80004054:	02081813          	slli	a6,a6,0x20
    80004058:	01d85893          	srli	a7,a6,0x1d
    8000405c:	00858813          	addi	a6,a1,8
    80004060:	00058793          	mv	a5,a1
    80004064:	00050713          	mv	a4,a0
    80004068:	01088833          	add	a6,a7,a6
    8000406c:	0007b883          	ld	a7,0(a5)
    80004070:	00878793          	addi	a5,a5,8
    80004074:	00870713          	addi	a4,a4,8
    80004078:	ff173c23          	sd	a7,-8(a4)
    8000407c:	ff0798e3          	bne	a5,a6,8000406c <__memmove+0x68>
    80004080:	ff867713          	andi	a4,a2,-8
    80004084:	02071793          	slli	a5,a4,0x20
    80004088:	0207d793          	srli	a5,a5,0x20
    8000408c:	00f585b3          	add	a1,a1,a5
    80004090:	40e686bb          	subw	a3,a3,a4
    80004094:	00f507b3          	add	a5,a0,a5
    80004098:	06e60463          	beq	a2,a4,80004100 <__memmove+0xfc>
    8000409c:	0005c703          	lbu	a4,0(a1)
    800040a0:	00e78023          	sb	a4,0(a5)
    800040a4:	04068e63          	beqz	a3,80004100 <__memmove+0xfc>
    800040a8:	0015c603          	lbu	a2,1(a1)
    800040ac:	00100713          	li	a4,1
    800040b0:	00c780a3          	sb	a2,1(a5)
    800040b4:	04e68663          	beq	a3,a4,80004100 <__memmove+0xfc>
    800040b8:	0025c603          	lbu	a2,2(a1)
    800040bc:	00200713          	li	a4,2
    800040c0:	00c78123          	sb	a2,2(a5)
    800040c4:	02e68e63          	beq	a3,a4,80004100 <__memmove+0xfc>
    800040c8:	0035c603          	lbu	a2,3(a1)
    800040cc:	00300713          	li	a4,3
    800040d0:	00c781a3          	sb	a2,3(a5)
    800040d4:	02e68663          	beq	a3,a4,80004100 <__memmove+0xfc>
    800040d8:	0045c603          	lbu	a2,4(a1)
    800040dc:	00400713          	li	a4,4
    800040e0:	00c78223          	sb	a2,4(a5)
    800040e4:	00e68e63          	beq	a3,a4,80004100 <__memmove+0xfc>
    800040e8:	0055c603          	lbu	a2,5(a1)
    800040ec:	00500713          	li	a4,5
    800040f0:	00c782a3          	sb	a2,5(a5)
    800040f4:	00e68663          	beq	a3,a4,80004100 <__memmove+0xfc>
    800040f8:	0065c703          	lbu	a4,6(a1)
    800040fc:	00e78323          	sb	a4,6(a5)
    80004100:	00813403          	ld	s0,8(sp)
    80004104:	01010113          	addi	sp,sp,16
    80004108:	00008067          	ret
    8000410c:	02061713          	slli	a4,a2,0x20
    80004110:	02075713          	srli	a4,a4,0x20
    80004114:	00e587b3          	add	a5,a1,a4
    80004118:	f0f574e3          	bgeu	a0,a5,80004020 <__memmove+0x1c>
    8000411c:	02069613          	slli	a2,a3,0x20
    80004120:	02065613          	srli	a2,a2,0x20
    80004124:	fff64613          	not	a2,a2
    80004128:	00e50733          	add	a4,a0,a4
    8000412c:	00c78633          	add	a2,a5,a2
    80004130:	fff7c683          	lbu	a3,-1(a5)
    80004134:	fff78793          	addi	a5,a5,-1
    80004138:	fff70713          	addi	a4,a4,-1
    8000413c:	00d70023          	sb	a3,0(a4)
    80004140:	fec798e3          	bne	a5,a2,80004130 <__memmove+0x12c>
    80004144:	00813403          	ld	s0,8(sp)
    80004148:	01010113          	addi	sp,sp,16
    8000414c:	00008067          	ret
    80004150:	02069713          	slli	a4,a3,0x20
    80004154:	02075713          	srli	a4,a4,0x20
    80004158:	00170713          	addi	a4,a4,1
    8000415c:	00e50733          	add	a4,a0,a4
    80004160:	00050793          	mv	a5,a0
    80004164:	0005c683          	lbu	a3,0(a1)
    80004168:	00178793          	addi	a5,a5,1
    8000416c:	00158593          	addi	a1,a1,1
    80004170:	fed78fa3          	sb	a3,-1(a5)
    80004174:	fee798e3          	bne	a5,a4,80004164 <__memmove+0x160>
    80004178:	f89ff06f          	j	80004100 <__memmove+0xfc>
	...
