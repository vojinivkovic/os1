
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00006117          	auipc	sp,0x6
    80000004:	99013103          	ld	sp,-1648(sp) # 80005990 <_GLOBAL_OFFSET_TABLE_+0x10>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	248020ef          	jal	ra,80002264 <start>

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

    csrr t0, sstatus
    80001038:	100022f3          	csrr	t0,sstatus
    andi t0, t0, 0x10
    8000103c:	0102f293          	andi	t0,t0,16
    bne t0, x0, system_stack
    80001040:	00029663          	bnez	t0,8000104c <system_stack>

    addi t0, sp, 0
    80001044:	00010293          	mv	t0,sp
    csrr sp, sscratch
    80001048:	14002173          	csrr	sp,sscratch

000000008000104c <system_stack>:

system_stack:    addi sp, sp, -256
    8000104c:	f0010113          	addi	sp,sp,-256

    sd x0, 0 * 8(sp)
    80001050:	00013023          	sd	zero,0(sp)
    sd x1, 1 * 8(sp)
    80001054:	00113423          	sd	ra,8(sp)
    sd t0, 2 * 8(sp)
    80001058:	00513823          	sd	t0,16(sp)
    .irp index,  3, 4, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31
    sd x\index, \index * 8(sp)
    .endr
    8000105c:	00313c23          	sd	gp,24(sp)
    80001060:	02413023          	sd	tp,32(sp)
    80001064:	02613823          	sd	t1,48(sp)
    80001068:	02713c23          	sd	t2,56(sp)
    8000106c:	04813023          	sd	s0,64(sp)
    80001070:	04913423          	sd	s1,72(sp)
    80001074:	04a13823          	sd	a0,80(sp)
    80001078:	04b13c23          	sd	a1,88(sp)
    8000107c:	06c13023          	sd	a2,96(sp)
    80001080:	06d13423          	sd	a3,104(sp)
    80001084:	06e13823          	sd	a4,112(sp)
    80001088:	06f13c23          	sd	a5,120(sp)
    8000108c:	09013023          	sd	a6,128(sp)
    80001090:	09113423          	sd	a7,136(sp)
    80001094:	09213823          	sd	s2,144(sp)
    80001098:	09313c23          	sd	s3,152(sp)
    8000109c:	0b413023          	sd	s4,160(sp)
    800010a0:	0b513423          	sd	s5,168(sp)
    800010a4:	0b613823          	sd	s6,176(sp)
    800010a8:	0b713c23          	sd	s7,184(sp)
    800010ac:	0d813023          	sd	s8,192(sp)
    800010b0:	0d913423          	sd	s9,200(sp)
    800010b4:	0da13823          	sd	s10,208(sp)
    800010b8:	0db13c23          	sd	s11,216(sp)
    800010bc:	0fc13023          	sd	t3,224(sp)
    800010c0:	0fd13423          	sd	t4,232(sp)
    800010c4:	0fe13823          	sd	t5,240(sp)
    800010c8:	0ff13c23          	sd	t6,248(sp)
    ld t0, 8(t0)
    800010cc:	0082b283          	ld	t0,8(t0)
    sd t0, 5 * 8(sp)
    800010d0:	02513423          	sd	t0,40(sp)

    addi s0, sp, 0
    800010d4:	00010413          	mv	s0,sp
    auipc t0, 0
    800010d8:	00000297          	auipc	t0,0x0
    addi t0, t0, 16
    800010dc:	01028293          	addi	t0,t0,16 # 800010e8 <system_stack+0x9c>
    csrw sscratch, t0
    800010e0:	14029073          	csrw	sscratch,t0

    call _ZN6Kernel16interruptHandlerEv
    800010e4:	321000ef          	jal	ra,80001c04 <_ZN6Kernel16interruptHandlerEv>

    ld x0, 0 * 8(sp)
    800010e8:	00013003          	ld	zero,0(sp)
    ld x1, 1 * 8(sp)
    800010ec:	00813083          	ld	ra,8(sp)
    ld t0, 2 * 8(sp)
    800010f0:	01013283          	ld	t0,16(sp)
    .irp index,  3, 4, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31
    sd x\index, \index * 8(sp)
    .endr
    800010f4:	00313c23          	sd	gp,24(sp)
    800010f8:	02413023          	sd	tp,32(sp)
    800010fc:	02613823          	sd	t1,48(sp)
    80001100:	02713c23          	sd	t2,56(sp)
    80001104:	04813023          	sd	s0,64(sp)
    80001108:	04913423          	sd	s1,72(sp)
    8000110c:	04a13823          	sd	a0,80(sp)
    80001110:	04b13c23          	sd	a1,88(sp)
    80001114:	06c13023          	sd	a2,96(sp)
    80001118:	06d13423          	sd	a3,104(sp)
    8000111c:	06e13823          	sd	a4,112(sp)
    80001120:	06f13c23          	sd	a5,120(sp)
    80001124:	09013023          	sd	a6,128(sp)
    80001128:	09113423          	sd	a7,136(sp)
    8000112c:	09213823          	sd	s2,144(sp)
    80001130:	09313c23          	sd	s3,152(sp)
    80001134:	0b413023          	sd	s4,160(sp)
    80001138:	0b513423          	sd	s5,168(sp)
    8000113c:	0b613823          	sd	s6,176(sp)
    80001140:	0b713c23          	sd	s7,184(sp)
    80001144:	0d813023          	sd	s8,192(sp)
    80001148:	0d913423          	sd	s9,200(sp)
    8000114c:	0da13823          	sd	s10,208(sp)
    80001150:	0db13c23          	sd	s11,216(sp)
    80001154:	0fc13023          	sd	t3,224(sp)
    80001158:	0fd13423          	sd	t4,232(sp)
    8000115c:	0fe13823          	sd	t5,240(sp)
    80001160:	0ff13c23          	sd	t6,248(sp)

    addi sp, sp, 256
    80001164:	10010113          	addi	sp,sp,256

    csrw sscratch, sp
    80001168:	14011073          	csrw	sscratch,sp

    addi sp, t0, 0
    8000116c:	00028113          	mv	sp,t0
    ld t0, 8(sp)
    80001170:	00813283          	ld	t0,8(sp)
    addi sp, sp, 16
    80001174:	01010113          	addi	sp,sp,16
    80001178:	10200073          	sret
    8000117c:	0000                	unimp
	...

0000000080001180 <context_switch>:
.global context_switch
.type context_switch, @function
context_switch:
    sd ra, 0 * 8(a0)
    80001180:	00153023          	sd	ra,0(a0) # 1000 <_entry-0x7ffff000>
    sd sp, 1 * 8(a0)
    80001184:	00253423          	sd	sp,8(a0)


    ld ra, 0 * 8(a1)
    80001188:	0005b083          	ld	ra,0(a1)
    ld sp, 1 * 8(a1)
    8000118c:	0085b103          	ld	sp,8(a1)
    ld t0, 2 * 8(a1)
    80001190:	0105b283          	ld	t0,16(a1)

    beq t0, x0, continue
    80001194:	00028663          	beqz	t0,800011a0 <continue>
    slli t0, t0, 8
    80001198:	00829293          	slli	t0,t0,0x8
    csrs sstatus, t0
    8000119c:	1002a073          	csrs	sstatus,t0

00000000800011a0 <continue>:

    800011a0:	00008067          	ret

00000000800011a4 <_Z9mem_allocm>:


extern "C" uint64 system_call(Arguments* arg);

void* mem_alloc(size_t size)
{
    800011a4:	fa010113          	addi	sp,sp,-96
    800011a8:	04113c23          	sd	ra,88(sp)
    800011ac:	04813823          	sd	s0,80(sp)
    800011b0:	04913423          	sd	s1,72(sp)
    800011b4:	05213023          	sd	s2,64(sp)
    800011b8:	06010413          	addi	s0,sp,96
    800011bc:	00050493          	mv	s1,a0
    uint64 size_of_blocks = (size + MemoryAllocator::getSizeOfMetaData()) / MEM_BLOCK_SIZE;
    800011c0:	00001097          	auipc	ra,0x1
    800011c4:	8e0080e7          	jalr	-1824(ra) # 80001aa0 <_ZN15MemoryAllocator17getSizeOfMetaDataEv>
    800011c8:	00950933          	add	s2,a0,s1
    800011cc:	00695913          	srli	s2,s2,0x6
    size_of_blocks += (size + MemoryAllocator::getSizeOfMetaData()) % MEM_BLOCK_SIZE ? 1: 0;
    800011d0:	00001097          	auipc	ra,0x1
    800011d4:	8d0080e7          	jalr	-1840(ra) # 80001aa0 <_ZN15MemoryAllocator17getSizeOfMetaDataEv>
    800011d8:	00a484b3          	add	s1,s1,a0
    800011dc:	03f4f493          	andi	s1,s1,63
    800011e0:	04048a63          	beqz	s1,80001234 <_Z9mem_allocm+0x90>
    800011e4:	00100513          	li	a0,1
    800011e8:	01250933          	add	s2,a0,s2
    Arguments arg = {KernelConfig::MEM_ALLOC, size_of_blocks, 0, 0, 0, 0, 0, 0};
    800011ec:	fa043823          	sd	zero,-80(s0)
    800011f0:	fa043c23          	sd	zero,-72(s0)
    800011f4:	fc043023          	sd	zero,-64(s0)
    800011f8:	fc043423          	sd	zero,-56(s0)
    800011fc:	fc043823          	sd	zero,-48(s0)
    80001200:	fc043c23          	sd	zero,-40(s0)
    80001204:	00100793          	li	a5,1
    80001208:	faf43023          	sd	a5,-96(s0)
    8000120c:	fb243423          	sd	s2,-88(s0)
    return (void*) system_call(&arg);
    80001210:	fa040513          	addi	a0,s0,-96
    80001214:	00000097          	auipc	ra,0x0
    80001218:	dec080e7          	jalr	-532(ra) # 80001000 <system_call>
}
    8000121c:	05813083          	ld	ra,88(sp)
    80001220:	05013403          	ld	s0,80(sp)
    80001224:	04813483          	ld	s1,72(sp)
    80001228:	04013903          	ld	s2,64(sp)
    8000122c:	06010113          	addi	sp,sp,96
    80001230:	00008067          	ret
    size_of_blocks += (size + MemoryAllocator::getSizeOfMetaData()) % MEM_BLOCK_SIZE ? 1: 0;
    80001234:	00000513          	li	a0,0
    80001238:	fb1ff06f          	j	800011e8 <_Z9mem_allocm+0x44>

000000008000123c <_Z8mem_freePv>:

int mem_free(void* obj)
{   Arguments arg = {KernelConfig::MEM_FREE, (uint64)obj, 0, 0, 0, 0, 0, 0};
    8000123c:	fb010113          	addi	sp,sp,-80
    80001240:	04113423          	sd	ra,72(sp)
    80001244:	04813023          	sd	s0,64(sp)
    80001248:	05010413          	addi	s0,sp,80
    8000124c:	fc043023          	sd	zero,-64(s0)
    80001250:	fc043423          	sd	zero,-56(s0)
    80001254:	fc043823          	sd	zero,-48(s0)
    80001258:	fc043c23          	sd	zero,-40(s0)
    8000125c:	fe043023          	sd	zero,-32(s0)
    80001260:	fe043423          	sd	zero,-24(s0)
    80001264:	00200793          	li	a5,2
    80001268:	faf43823          	sd	a5,-80(s0)
    8000126c:	faa43c23          	sd	a0,-72(s0)
    return (int) system_call(&arg);
    80001270:	fb040513          	addi	a0,s0,-80
    80001274:	00000097          	auipc	ra,0x0
    80001278:	d8c080e7          	jalr	-628(ra) # 80001000 <system_call>
}
    8000127c:	0005051b          	sext.w	a0,a0
    80001280:	04813083          	ld	ra,72(sp)
    80001284:	04013403          	ld	s0,64(sp)
    80001288:	05010113          	addi	sp,sp,80
    8000128c:	00008067          	ret

0000000080001290 <_Z18mem_get_free_spacev>:

size_t mem_get_free_space()
{
    80001290:	fb010113          	addi	sp,sp,-80
    80001294:	04113423          	sd	ra,72(sp)
    80001298:	04813023          	sd	s0,64(sp)
    8000129c:	05010413          	addi	s0,sp,80
    Arguments arg = {KernelConfig::MEM_FREE_SPACE, 0, 0, 0, 0, 0, 0, 0};
    800012a0:	00300793          	li	a5,3
    800012a4:	faf43823          	sd	a5,-80(s0)
    800012a8:	fa043c23          	sd	zero,-72(s0)
    800012ac:	fc043023          	sd	zero,-64(s0)
    800012b0:	fc043423          	sd	zero,-56(s0)
    800012b4:	fc043823          	sd	zero,-48(s0)
    800012b8:	fc043c23          	sd	zero,-40(s0)
    800012bc:	fe043023          	sd	zero,-32(s0)
    800012c0:	fe043423          	sd	zero,-24(s0)
    return (size_t) system_call(&arg);
    800012c4:	fb040513          	addi	a0,s0,-80
    800012c8:	00000097          	auipc	ra,0x0
    800012cc:	d38080e7          	jalr	-712(ra) # 80001000 <system_call>
}
    800012d0:	04813083          	ld	ra,72(sp)
    800012d4:	04013403          	ld	s0,64(sp)
    800012d8:	05010113          	addi	sp,sp,80
    800012dc:	00008067          	ret

00000000800012e0 <_Z26mem_get_largest_free_blockv>:
size_t mem_get_largest_free_block()
{
    800012e0:	fb010113          	addi	sp,sp,-80
    800012e4:	04113423          	sd	ra,72(sp)
    800012e8:	04813023          	sd	s0,64(sp)
    800012ec:	05010413          	addi	s0,sp,80
    Arguments arg = {KernelConfig::LARGEST_FREE_BLOCK, 0, 0, 0, 0, 0, 0, 0};
    800012f0:	00400793          	li	a5,4
    800012f4:	faf43823          	sd	a5,-80(s0)
    800012f8:	fa043c23          	sd	zero,-72(s0)
    800012fc:	fc043023          	sd	zero,-64(s0)
    80001300:	fc043423          	sd	zero,-56(s0)
    80001304:	fc043823          	sd	zero,-48(s0)
    80001308:	fc043c23          	sd	zero,-40(s0)
    8000130c:	fe043023          	sd	zero,-32(s0)
    80001310:	fe043423          	sd	zero,-24(s0)
    return (size_t) system_call(&arg);
    80001314:	fb040513          	addi	a0,s0,-80
    80001318:	00000097          	auipc	ra,0x0
    8000131c:	ce8080e7          	jalr	-792(ra) # 80001000 <system_call>
}
    80001320:	04813083          	ld	ra,72(sp)
    80001324:	04013403          	ld	s0,64(sp)
    80001328:	05010113          	addi	sp,sp,80
    8000132c:	00008067          	ret

0000000080001330 <_Z13thread_createPP3TCBPFvPvES2_>:

int thread_create(thread_t* handle, void(*start_routine)(void*), void* argOfRoutine)
{
    80001330:	f9010113          	addi	sp,sp,-112
    80001334:	06113423          	sd	ra,104(sp)
    80001338:	06813023          	sd	s0,96(sp)
    8000133c:	04913c23          	sd	s1,88(sp)
    80001340:	05213823          	sd	s2,80(sp)
    80001344:	05313423          	sd	s3,72(sp)
    80001348:	07010413          	addi	s0,sp,112
    8000134c:	00050993          	mv	s3,a0
    80001350:	00058913          	mv	s2,a1
    80001354:	00060493          	mv	s1,a2
    uint8* threadStack = (uint8*)mem_alloc(DEFAULT_STACK_SIZE);
    80001358:	00001537          	lui	a0,0x1
    8000135c:	00000097          	auipc	ra,0x0
    80001360:	e48080e7          	jalr	-440(ra) # 800011a4 <_Z9mem_allocm>
    if(threadStack == nullptr)
    80001364:	04050e63          	beqz	a0,800013c0 <_Z13thread_createPP3TCBPFvPvES2_+0x90>
    {
        return -1;
    }

    Arguments arg = {(uint64)KernelConfig::THREAD_CREATE, (uint64)handle, (uint64)start_routine, (uint64)argOfRoutine, (uint64)(&threadStack[DEFAULT_STACK_SIZE]), 0, 0, 0};
    80001368:	fa043c23          	sd	zero,-72(s0)
    8000136c:	fc043023          	sd	zero,-64(s0)
    80001370:	fc043423          	sd	zero,-56(s0)
    80001374:	01100793          	li	a5,17
    80001378:	f8f43823          	sd	a5,-112(s0)
    8000137c:	f9343c23          	sd	s3,-104(s0)
    80001380:	fb243023          	sd	s2,-96(s0)
    80001384:	fa943423          	sd	s1,-88(s0)
    80001388:	000017b7          	lui	a5,0x1
    8000138c:	00f50533          	add	a0,a0,a5
    80001390:	faa43823          	sd	a0,-80(s0)

    return (int) system_call(&arg);
    80001394:	f9040513          	addi	a0,s0,-112
    80001398:	00000097          	auipc	ra,0x0
    8000139c:	c68080e7          	jalr	-920(ra) # 80001000 <system_call>
    800013a0:	0005051b          	sext.w	a0,a0
}
    800013a4:	06813083          	ld	ra,104(sp)
    800013a8:	06013403          	ld	s0,96(sp)
    800013ac:	05813483          	ld	s1,88(sp)
    800013b0:	05013903          	ld	s2,80(sp)
    800013b4:	04813983          	ld	s3,72(sp)
    800013b8:	07010113          	addi	sp,sp,112
    800013bc:	00008067          	ret
        return -1;
    800013c0:	fff00513          	li	a0,-1
    800013c4:	fe1ff06f          	j	800013a4 <_Z13thread_createPP3TCBPFvPvES2_+0x74>

00000000800013c8 <_Z15thread_dispatchv>:

void thread_dispatch()
{
    800013c8:	fb010113          	addi	sp,sp,-80
    800013cc:	04113423          	sd	ra,72(sp)
    800013d0:	04813023          	sd	s0,64(sp)
    800013d4:	05010413          	addi	s0,sp,80
    Arguments arg = {KernelConfig::THREAD_DISPATCH, 0, 0, 0, 0, 0, 0, 0};
    800013d8:	01300793          	li	a5,19
    800013dc:	faf43823          	sd	a5,-80(s0)
    800013e0:	fa043c23          	sd	zero,-72(s0)
    800013e4:	fc043023          	sd	zero,-64(s0)
    800013e8:	fc043423          	sd	zero,-56(s0)
    800013ec:	fc043823          	sd	zero,-48(s0)
    800013f0:	fc043c23          	sd	zero,-40(s0)
    800013f4:	fe043023          	sd	zero,-32(s0)
    800013f8:	fe043423          	sd	zero,-24(s0)
    system_call(&arg);
    800013fc:	fb040513          	addi	a0,s0,-80
    80001400:	00000097          	auipc	ra,0x0
    80001404:	c00080e7          	jalr	-1024(ra) # 80001000 <system_call>
}
    80001408:	04813083          	ld	ra,72(sp)
    8000140c:	04013403          	ld	s0,64(sp)
    80001410:	05010113          	addi	sp,sp,80
    80001414:	00008067          	ret

0000000080001418 <_Z11thread_exitv>:

int thread_exit()
{
    80001418:	fb010113          	addi	sp,sp,-80
    8000141c:	04113423          	sd	ra,72(sp)
    80001420:	04813023          	sd	s0,64(sp)
    80001424:	05010413          	addi	s0,sp,80
    Arguments arg = {KernelConfig::THREAD_EXIT, 0, 0, 0, 0, 0, 0, 0};
    80001428:	01200793          	li	a5,18
    8000142c:	faf43823          	sd	a5,-80(s0)
    80001430:	fa043c23          	sd	zero,-72(s0)
    80001434:	fc043023          	sd	zero,-64(s0)
    80001438:	fc043423          	sd	zero,-56(s0)
    8000143c:	fc043823          	sd	zero,-48(s0)
    80001440:	fc043c23          	sd	zero,-40(s0)
    80001444:	fe043023          	sd	zero,-32(s0)
    80001448:	fe043423          	sd	zero,-24(s0)
    return (int) system_call(&arg);
    8000144c:	fb040513          	addi	a0,s0,-80
    80001450:	00000097          	auipc	ra,0x0
    80001454:	bb0080e7          	jalr	-1104(ra) # 80001000 <system_call>
    80001458:	0005051b          	sext.w	a0,a0
    8000145c:	04813083          	ld	ra,72(sp)
    80001460:	04013403          	ld	s0,64(sp)
    80001464:	05010113          	addi	sp,sp,80
    80001468:	00008067          	ret

000000008000146c <_ZN9Scheduler3putEP3TCB>:
#include "../h/TCB.hpp"
TCB* Scheduler::firstReadyThread = nullptr;
TCB* Scheduler::lastReadyThread = nullptr;

void Scheduler::put(TCB *readyThread)
{
    8000146c:	ff010113          	addi	sp,sp,-16
    80001470:	00813423          	sd	s0,8(sp)
    80001474:	01010413          	addi	s0,sp,16
    if(!firstReadyThread)
    80001478:	00004797          	auipc	a5,0x4
    8000147c:	5887b783          	ld	a5,1416(a5) # 80005a00 <_ZN9Scheduler16firstReadyThreadE>
    80001480:	02078263          	beqz	a5,800014a4 <_ZN9Scheduler3putEP3TCB+0x38>
    void* getSystemStack() const { return systemStack; }

    static void dispatch();

    static TCB* getRunningThread() { return running; }
    static void setRunningThread(TCB* newRunningThread) { running = newRunningThread; }
    80001484:	00004797          	auipc	a5,0x4
    80001488:	5247b783          	ld	a5,1316(a5) # 800059a8 <_GLOBAL_OFFSET_TABLE_+0x28>
    8000148c:	00a7b023          	sd	a0,0(a5)
    }
    else
    {
        lastReadyThread->setRunningThread(readyThread);
    }
    lastReadyThread = readyThread;
    80001490:	00004797          	auipc	a5,0x4
    80001494:	56a7bc23          	sd	a0,1400(a5) # 80005a08 <_ZN9Scheduler15lastReadyThreadE>
}
    80001498:	00813403          	ld	s0,8(sp)
    8000149c:	01010113          	addi	sp,sp,16
    800014a0:	00008067          	ret
        firstReadyThread = readyThread;
    800014a4:	00004797          	auipc	a5,0x4
    800014a8:	54a7be23          	sd	a0,1372(a5) # 80005a00 <_ZN9Scheduler16firstReadyThreadE>
    800014ac:	fe5ff06f          	j	80001490 <_ZN9Scheduler3putEP3TCB+0x24>

00000000800014b0 <_ZN9Scheduler3getEv>:
TCB* Scheduler::get(void)
{
    800014b0:	ff010113          	addi	sp,sp,-16
    800014b4:	00813423          	sd	s0,8(sp)
    800014b8:	01010413          	addi	s0,sp,16
    if(!firstReadyThread)
    800014bc:	00004517          	auipc	a0,0x4
    800014c0:	54453503          	ld	a0,1348(a0) # 80005a00 <_ZN9Scheduler16firstReadyThreadE>
    800014c4:	00050a63          	beqz	a0,800014d8 <_ZN9Scheduler3getEv+0x28>
    TCB* getState() const { return state; }
    800014c8:	04053783          	ld	a5,64(a0)
    {
        return nullptr;
    }
    TCB* newThread = firstReadyThread;
    firstReadyThread = firstReadyThread->getState();
    800014cc:	00004717          	auipc	a4,0x4
    800014d0:	52f73a23          	sd	a5,1332(a4) # 80005a00 <_ZN9Scheduler16firstReadyThreadE>
    void addThreadToState(TCB* newThread) { state = newThread; }
    800014d4:	04053023          	sd	zero,64(a0)

    newThread->addThreadToState(nullptr);
    return newThread;
    800014d8:	00813403          	ld	s0,8(sp)
    800014dc:	01010113          	addi	sp,sp,16
    800014e0:	00008067          	ret

00000000800014e4 <main>:
// Created by os on 11/29/25.
//
#include "../h/MemoryAllocator.hpp"
#include "../h/Kernel.hpp"
#include "../h/syscall_c.hpp"
void main(){
    800014e4:	ff010113          	addi	sp,sp,-16
    800014e8:	00813423          	sd	s0,8(sp)
    800014ec:	01010413          	addi	s0,sp,16
////    __asm__ volatile ("ecall");
//    void* allocMem1 = mem_alloc(100);
//    mem_free(allocMem1);
//    void* allocMem2 = mem_alloc(10);
//    mem_free(allocMem2);
    800014f0:	00813403          	ld	s0,8(sp)
    800014f4:	01010113          	addi	sp,sp,16
    800014f8:	00008067          	ret

00000000800014fc <_ZN3TCB13threadWrapperEv>:
    context = {Machine::readSscratch(), (uint64) ((uint64*)allocatedSystemStack - 32), mode};
    Machine::writeSepc((uint64)&threadWrapper);
    Scheduler::put(this);
}
void TCB::threadWrapper()
{
    800014fc:	ff010113          	addi	sp,sp,-16
    80001500:	00113423          	sd	ra,8(sp)
    80001504:	00813023          	sd	s0,0(sp)
    80001508:	01010413          	addi	s0,sp,16
    running->body(running->arguments);
    8000150c:	00004797          	auipc	a5,0x4
    80001510:	5047b783          	ld	a5,1284(a5) # 80005a10 <_ZN3TCB7runningE>
    80001514:	0007b703          	ld	a4,0(a5)
    80001518:	0387b503          	ld	a0,56(a5)
    8000151c:	000700e7          	jalr	a4
    thread_exit();
    80001520:	00000097          	auipc	ra,0x0
    80001524:	ef8080e7          	jalr	-264(ra) # 80001418 <_Z11thread_exitv>

}
    80001528:	00813083          	ld	ra,8(sp)
    8000152c:	00013403          	ld	s0,0(sp)
    80001530:	01010113          	addi	sp,sp,16
    80001534:	00008067          	ret

0000000080001538 <_ZN3TCB16initializeThreadEPFvPvES0_S0_S0_N12KernelConfig4ModeE>:
{
    80001538:	ff010113          	addi	sp,sp,-16
    8000153c:	00113423          	sd	ra,8(sp)
    80001540:	00813023          	sd	s0,0(sp)
    80001544:	01010413          	addi	s0,sp,16
    body = function;
    80001548:	00b53023          	sd	a1,0(a0)
    timeSlice = DEFAULT_TIME_SLICE;
    8000154c:	00200593          	li	a1,2
    80001550:	02b53823          	sd	a1,48(a0)
    state = nullptr;
    80001554:	04053023          	sd	zero,64(a0)
    finished = false;
    80001558:	04050423          	sb	zero,72(a0)
    arguments = arg;
    8000155c:	02c53c23          	sd	a2,56(a0)
    userStack = (void*)((uint8*)allocatedStack - DEFAULT_STACK_SIZE);
    80001560:	fffff637          	lui	a2,0xfffff
    80001564:	00c68633          	add	a2,a3,a2
    80001568:	02c53023          	sd	a2,32(a0)
    systemStack = (void*)((uint8*)allocatedSystemStack - KernelConfig::DEFAULT_SYSTEM_STACK_SIZE);
    8000156c:	c0070613          	addi	a2,a4,-1024
    80001570:	02c53423          	sd	a2,40(a0)
    *((uint64*)allocatedSystemStack - 30) = (uint64)((uint64*)allocatedStack - 2);
    80001574:	ff068693          	addi	a3,a3,-16
    80001578:	f0d73823          	sd	a3,-240(a4)
    __asm__ volatile ("csrc sip, %[reg]":: [reg] "r"(mask));
}
inline uint64 Machine::readSscratch()
{
    uint64 returnValue;
    __asm__ volatile ("csrr %[reg], sscratch": [reg] "=r"(returnValue));
    8000157c:	140026f3          	csrr	a3,sscratch
    context = {Machine::readSscratch(), (uint64) ((uint64*)allocatedSystemStack - 32), mode};
    80001580:	f0070713          	addi	a4,a4,-256
    80001584:	00d53423          	sd	a3,8(a0)
    80001588:	00e53823          	sd	a4,16(a0)
    8000158c:	00f52c23          	sw	a5,24(a0)
    Machine::writeSepc((uint64)&threadWrapper);
    80001590:	00000797          	auipc	a5,0x0
    80001594:	f6c78793          	addi	a5,a5,-148 # 800014fc <_ZN3TCB13threadWrapperEv>
    return returnValue;
}
inline void Machine::writeSepc(uint64 address)
{
    __asm__ volatile("csrw sepc, %[reg]":: [reg] "r"(address));
    80001598:	14179073          	csrw	sepc,a5
    Scheduler::put(this);
    8000159c:	00000097          	auipc	ra,0x0
    800015a0:	ed0080e7          	jalr	-304(ra) # 8000146c <_ZN9Scheduler3putEP3TCB>
}
    800015a4:	00813083          	ld	ra,8(sp)
    800015a8:	00013403          	ld	s0,0(sp)
    800015ac:	01010113          	addi	sp,sp,16
    800015b0:	00008067          	ret

00000000800015b4 <_ZN3TCB5yieldEPS_S0_>:
void TCB::yield(TCB *oldThread, TCB *newThread)
{
    800015b4:	ff010113          	addi	sp,sp,-16
    800015b8:	00113423          	sd	ra,8(sp)
    800015bc:	00813023          	sd	s0,0(sp)
    800015c0:	01010413          	addi	s0,sp,16
    context_switch(&(oldThread->context), &(newThread->context));
    800015c4:	00858593          	addi	a1,a1,8
    800015c8:	00850513          	addi	a0,a0,8
    800015cc:	00000097          	auipc	ra,0x0
    800015d0:	bb4080e7          	jalr	-1100(ra) # 80001180 <context_switch>
}
    800015d4:	00813083          	ld	ra,8(sp)
    800015d8:	00013403          	ld	s0,0(sp)
    800015dc:	01010113          	addi	sp,sp,16
    800015e0:	00008067          	ret

00000000800015e4 <_ZN3TCB8dispatchEv>:

void TCB::dispatch()
{
    800015e4:	fe010113          	addi	sp,sp,-32
    800015e8:	00113c23          	sd	ra,24(sp)
    800015ec:	00813823          	sd	s0,16(sp)
    800015f0:	00913423          	sd	s1,8(sp)
    800015f4:	02010413          	addi	s0,sp,32
    TCB* oldThread = running;
    800015f8:	00004497          	auipc	s1,0x4
    800015fc:	4184b483          	ld	s1,1048(s1) # 80005a10 <_ZN3TCB7runningE>
    bool isFinished() const { return finished; }
    80001600:	0484c783          	lbu	a5,72(s1)
    if(!oldThread->isFinished())
    80001604:	02078c63          	beqz	a5,8000163c <_ZN3TCB8dispatchEv+0x58>
    {
        Scheduler::put(oldThread);
    }
    running = Scheduler::get();
    80001608:	00000097          	auipc	ra,0x0
    8000160c:	ea8080e7          	jalr	-344(ra) # 800014b0 <_ZN9Scheduler3getEv>
    80001610:	00050593          	mv	a1,a0
    80001614:	00004797          	auipc	a5,0x4
    80001618:	3ea7be23          	sd	a0,1020(a5) # 80005a10 <_ZN3TCB7runningE>
    yield(oldThread, running);
    8000161c:	00048513          	mv	a0,s1
    80001620:	00000097          	auipc	ra,0x0
    80001624:	f94080e7          	jalr	-108(ra) # 800015b4 <_ZN3TCB5yieldEPS_S0_>
    80001628:	01813083          	ld	ra,24(sp)
    8000162c:	01013403          	ld	s0,16(sp)
    80001630:	00813483          	ld	s1,8(sp)
    80001634:	02010113          	addi	sp,sp,32
    80001638:	00008067          	ret
        Scheduler::put(oldThread);
    8000163c:	00048513          	mv	a0,s1
    80001640:	00000097          	auipc	ra,0x0
    80001644:	e2c080e7          	jalr	-468(ra) # 8000146c <_ZN9Scheduler3putEP3TCB>
    80001648:	fc1ff06f          	j	80001608 <_ZN3TCB8dispatchEv+0x24>

000000008000164c <_ZN15MemoryAllocator16initializeMemoryEv>:
size_t MemoryAllocator::NUM_OF_BLOCKS = 0;
size_t MemoryAllocator::numOfFreeBlocks = 0;
MemoryAllocator::FreeBlock* MemoryAllocator::firstFreeBlock = nullptr;

void MemoryAllocator::initializeMemory()
{
    8000164c:	ff010113          	addi	sp,sp,-16
    80001650:	00813423          	sd	s0,8(sp)
    80001654:	01010413          	addi	s0,sp,16

    NUM_OF_BLOCKS = ((uint8*)HEAP_END_ADDR - (uint8*)HEAP_START_ADDR) / MEM_BLOCK_SIZE;
    80001658:	00004797          	auipc	a5,0x4
    8000165c:	3587b783          	ld	a5,856(a5) # 800059b0 <_GLOBAL_OFFSET_TABLE_+0x30>
    80001660:	0007b703          	ld	a4,0(a5)
    80001664:	00004797          	auipc	a5,0x4
    80001668:	3247b783          	ld	a5,804(a5) # 80005988 <_GLOBAL_OFFSET_TABLE_+0x8>
    8000166c:	0007b683          	ld	a3,0(a5)
    80001670:	40d70733          	sub	a4,a4,a3
    80001674:	00675713          	srli	a4,a4,0x6
    80001678:	00004797          	auipc	a5,0x4
    8000167c:	3a878793          	addi	a5,a5,936 # 80005a20 <_ZN15MemoryAllocator13NUM_OF_BLOCKSE>
    80001680:	00e7b023          	sd	a4,0(a5)
    numOfFreeBlocks = NUM_OF_BLOCKS;
    80001684:	00e7b423          	sd	a4,8(a5)

    firstFreeBlock = (FreeBlock*)(HEAP_START_ADDR);
    80001688:	00d7b823          	sd	a3,16(a5)

    firstFreeBlock->flagFree = true;
    8000168c:	00100613          	li	a2,1
    80001690:	00c68023          	sb	a2,0(a3)
    firstFreeBlock->numOfBlocks = NUM_OF_BLOCKS;
    80001694:	0107b703          	ld	a4,16(a5)
    80001698:	0007b683          	ld	a3,0(a5)
    8000169c:	00d73423          	sd	a3,8(a4)
    firstFreeBlock->nextBlock = nullptr;
    800016a0:	00073823          	sd	zero,16(a4)
    firstFreeBlock->previousBlock = nullptr;
    800016a4:	00073c23          	sd	zero,24(a4)
    flagSystemInitialize = 1;
    800016a8:	00c78c23          	sb	a2,24(a5)
}
    800016ac:	00813403          	ld	s0,8(sp)
    800016b0:	01010113          	addi	sp,sp,16
    800016b4:	00008067          	ret

00000000800016b8 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m>:
    occupiedBlock++;
    return occupiedBlock;
}

void MemoryAllocator::remapMemory(FreeBlock **head, FreeBlock *allocatedBlocks, size_t blocksToAllocate)
{
    800016b8:	ff010113          	addi	sp,sp,-16
    800016bc:	00813423          	sd	s0,8(sp)
    800016c0:	01010413          	addi	s0,sp,16

    if(allocatedBlocks->numOfBlocks == 0)
    800016c4:	0085b783          	ld	a5,8(a1)
    800016c8:	04079263          	bnez	a5,8000170c <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x54>
    {

        if(allocatedBlocks->previousBlock)
    800016cc:	0185b783          	ld	a5,24(a1)
    800016d0:	00078663          	beqz	a5,800016dc <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x24>
        {
            allocatedBlocks->previousBlock->nextBlock = allocatedBlocks->nextBlock;
    800016d4:	0105b703          	ld	a4,16(a1)
    800016d8:	00e7b823          	sd	a4,16(a5)
        }

        if(allocatedBlocks->nextBlock)
    800016dc:	0105b783          	ld	a5,16(a1)
    800016e0:	00078663          	beqz	a5,800016ec <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x34>
        {
            allocatedBlocks->nextBlock->previousBlock = allocatedBlocks->previousBlock;
    800016e4:	0185b703          	ld	a4,24(a1)
    800016e8:	00e7bc23          	sd	a4,24(a5)
        }

        if(*head == allocatedBlocks)
    800016ec:	00053783          	ld	a5,0(a0)
    800016f0:	00b78863          	beq	a5,a1,80001700 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x48>
        {
            *head = newFreeBlock;
        }
    }

}
    800016f4:	00813403          	ld	s0,8(sp)
    800016f8:	01010113          	addi	sp,sp,16
    800016fc:	00008067          	ret
            *head = allocatedBlocks->nextBlock;
    80001700:	0105b783          	ld	a5,16(a1)
    80001704:	00f53023          	sd	a5,0(a0)
    80001708:	fedff06f          	j	800016f4 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x3c>
        FreeBlock* newFreeBlock = (FreeBlock*)((uint8*)allocatedBlocks + blocksToAllocate * MEM_BLOCK_SIZE);
    8000170c:	00661613          	slli	a2,a2,0x6
    80001710:	00c58633          	add	a2,a1,a2
        newFreeBlock->flagFree = true;
    80001714:	00100793          	li	a5,1
    80001718:	00f60023          	sb	a5,0(a2) # fffffffffffff000 <end+0xffffffff7fff8150>
        newFreeBlock->numOfBlocks = allocatedBlocks->numOfBlocks;
    8000171c:	0085b783          	ld	a5,8(a1)
    80001720:	00f63423          	sd	a5,8(a2)
        if(allocatedBlocks->previousBlock)
    80001724:	0185b783          	ld	a5,24(a1)
    80001728:	00078463          	beqz	a5,80001730 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x78>
            allocatedBlocks->previousBlock->nextBlock = newFreeBlock;
    8000172c:	00c7b823          	sd	a2,16(a5)
        newFreeBlock->previousBlock = allocatedBlocks->previousBlock;
    80001730:	0185b783          	ld	a5,24(a1)
    80001734:	00f63c23          	sd	a5,24(a2)
        newFreeBlock->nextBlock = allocatedBlocks->nextBlock;
    80001738:	0105b783          	ld	a5,16(a1)
    8000173c:	00f63823          	sd	a5,16(a2)
        if(*head == allocatedBlocks)
    80001740:	00053783          	ld	a5,0(a0)
    80001744:	fab798e3          	bne	a5,a1,800016f4 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x3c>
            *head = newFreeBlock;
    80001748:	00c53023          	sd	a2,0(a0)
}
    8000174c:	fa9ff06f          	j	800016f4 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x3c>

0000000080001750 <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm>:
{
    80001750:	fe010113          	addi	sp,sp,-32
    80001754:	00113c23          	sd	ra,24(sp)
    80001758:	00813823          	sd	s0,16(sp)
    8000175c:	00913423          	sd	s1,8(sp)
    80001760:	01213023          	sd	s2,0(sp)
    80001764:	02010413          	addi	s0,sp,32
    80001768:	00058913          	mv	s2,a1
    for(FreeBlock* curr = (*head); curr; curr = curr->nextBlock)
    8000176c:	00053783          	ld	a5,0(a0)
    FreeBlock* bestBlock = nullptr;
    80001770:	00000493          	li	s1,0
    80001774:	00c0006f          	j	80001780 <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm+0x30>
                bestBlock = curr;
    80001778:	00078493          	mv	s1,a5
    for(FreeBlock* curr = (*head); curr; curr = curr->nextBlock)
    8000177c:	0107b783          	ld	a5,16(a5)
    80001780:	02078063          	beqz	a5,800017a0 <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm+0x50>
        if(curr->numOfBlocks >= blocksToAllocate)
    80001784:	0087b703          	ld	a4,8(a5)
    80001788:	ff276ae3          	bltu	a4,s2,8000177c <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm+0x2c>
        {   if(bestBlock == nullptr)
    8000178c:	fe0486e3          	beqz	s1,80001778 <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm+0x28>
            if(bestBlock->numOfBlocks > curr->numOfBlocks)
    80001790:	0084b683          	ld	a3,8(s1)
    80001794:	fed774e3          	bgeu	a4,a3,8000177c <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm+0x2c>
                bestBlock = curr;
    80001798:	00078493          	mv	s1,a5
    8000179c:	fe1ff06f          	j	8000177c <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm+0x2c>
    numOfFreeBlocks -= blocksToAllocate;
    800017a0:	00004717          	auipc	a4,0x4
    800017a4:	28070713          	addi	a4,a4,640 # 80005a20 <_ZN15MemoryAllocator13NUM_OF_BLOCKSE>
    800017a8:	00873783          	ld	a5,8(a4)
    800017ac:	412787b3          	sub	a5,a5,s2
    800017b0:	00f73423          	sd	a5,8(a4)
    bestBlock->numOfBlocks -= blocksToAllocate;
    800017b4:	0084b783          	ld	a5,8(s1)
    800017b8:	412787b3          	sub	a5,a5,s2
    800017bc:	00f4b423          	sd	a5,8(s1)
    remapMemory(head, bestBlock, blocksToAllocate);
    800017c0:	00090613          	mv	a2,s2
    800017c4:	00048593          	mv	a1,s1
    800017c8:	00000097          	auipc	ra,0x0
    800017cc:	ef0080e7          	jalr	-272(ra) # 800016b8 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m>
    occupiedBlock->flagFree = false;
    800017d0:	00048023          	sb	zero,0(s1)
    occupiedBlock->numOfBlocks = blocksToAllocate;
    800017d4:	0124b423          	sd	s2,8(s1)
}
    800017d8:	01048513          	addi	a0,s1,16
    800017dc:	01813083          	ld	ra,24(sp)
    800017e0:	01013403          	ld	s0,16(sp)
    800017e4:	00813483          	ld	s1,8(sp)
    800017e8:	00013903          	ld	s2,0(sp)
    800017ec:	02010113          	addi	sp,sp,32
    800017f0:	00008067          	ret

00000000800017f4 <_ZN15MemoryAllocator14allocateMemoryEm>:
{
    800017f4:	fe010113          	addi	sp,sp,-32
    800017f8:	00113c23          	sd	ra,24(sp)
    800017fc:	00813823          	sd	s0,16(sp)
    80001800:	00913423          	sd	s1,8(sp)
    80001804:	02010413          	addi	s0,sp,32
    80001808:	00050493          	mv	s1,a0
    if(!flagSystemInitialize)
    8000180c:	00004797          	auipc	a5,0x4
    80001810:	22c7c783          	lbu	a5,556(a5) # 80005a38 <_ZN15MemoryAllocator20flagSystemInitializeE>
    80001814:	02078c63          	beqz	a5,8000184c <_ZN15MemoryAllocator14allocateMemoryEm+0x58>
    if(numOfFreeBlocks < blocksToAllocate)
    80001818:	00004797          	auipc	a5,0x4
    8000181c:	2107b783          	ld	a5,528(a5) # 80005a28 <_ZN15MemoryAllocator15numOfFreeBlocksE>
    80001820:	0297ec63          	bltu	a5,s1,80001858 <_ZN15MemoryAllocator14allocateMemoryEm+0x64>
    return findBestFit(&firstFreeBlock, blocksToAllocate);
    80001824:	00048593          	mv	a1,s1
    80001828:	00004517          	auipc	a0,0x4
    8000182c:	20850513          	addi	a0,a0,520 # 80005a30 <_ZN15MemoryAllocator14firstFreeBlockE>
    80001830:	00000097          	auipc	ra,0x0
    80001834:	f20080e7          	jalr	-224(ra) # 80001750 <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm>
}
    80001838:	01813083          	ld	ra,24(sp)
    8000183c:	01013403          	ld	s0,16(sp)
    80001840:	00813483          	ld	s1,8(sp)
    80001844:	02010113          	addi	sp,sp,32
    80001848:	00008067          	ret
        initializeMemory();
    8000184c:	00000097          	auipc	ra,0x0
    80001850:	e00080e7          	jalr	-512(ra) # 8000164c <_ZN15MemoryAllocator16initializeMemoryEv>
    80001854:	fc5ff06f          	j	80001818 <_ZN15MemoryAllocator14allocateMemoryEm+0x24>
        return nullptr;
    80001858:	00000513          	li	a0,0
    8000185c:	fddff06f          	j	80001838 <_ZN15MemoryAllocator14allocateMemoryEm+0x44>

0000000080001860 <_ZN15MemoryAllocator17findNextFreeBlockEPNS_9FreeBlockE>:
MemoryAllocator::FreeBlock* MemoryAllocator::findNextFreeBlock(FreeBlock* memoryToFree)
{
    80001860:	ff010113          	addi	sp,sp,-16
    80001864:	00813423          	sd	s0,8(sp)
    80001868:	01010413          	addi	s0,sp,16
    for(uint8* i = (uint8*)memoryToFree; i + MEM_BLOCK_SIZE <= (uint8*)HEAP_END_ADDR; i+= (((OccupiedBlock*)i)->numOfBlocks * MEM_BLOCK_SIZE))
    8000186c:	04050793          	addi	a5,a0,64
    80001870:	00004717          	auipc	a4,0x4
    80001874:	14073703          	ld	a4,320(a4) # 800059b0 <_GLOBAL_OFFSET_TABLE_+0x30>
    80001878:	00073703          	ld	a4,0(a4)
    8000187c:	00f76e63          	bltu	a4,a5,80001898 <_ZN15MemoryAllocator17findNextFreeBlockEPNS_9FreeBlockE+0x38>
    {
        if(((FreeBlock*)i)->flagFree)
    80001880:	00054783          	lbu	a5,0(a0)
    80001884:	00079c63          	bnez	a5,8000189c <_ZN15MemoryAllocator17findNextFreeBlockEPNS_9FreeBlockE+0x3c>
    for(uint8* i = (uint8*)memoryToFree; i + MEM_BLOCK_SIZE <= (uint8*)HEAP_END_ADDR; i+= (((OccupiedBlock*)i)->numOfBlocks * MEM_BLOCK_SIZE))
    80001888:	00853783          	ld	a5,8(a0)
    8000188c:	00679793          	slli	a5,a5,0x6
    80001890:	00f50533          	add	a0,a0,a5
    80001894:	fd9ff06f          	j	8000186c <_ZN15MemoryAllocator17findNextFreeBlockEPNS_9FreeBlockE+0xc>
        {
            return (FreeBlock*)i;
        }
    }
    return nullptr;
    80001898:	00000513          	li	a0,0
}
    8000189c:	00813403          	ld	s0,8(sp)
    800018a0:	01010113          	addi	sp,sp,16
    800018a4:	00008067          	ret

00000000800018a8 <_ZN15MemoryAllocator21findPreviousFreeBlockEPNS_9FreeBlockES1_>:

MemoryAllocator::FreeBlock* MemoryAllocator::findPreviousFreeBlock(FreeBlock* head, FreeBlock* memoryToFree)
{
    800018a8:	ff010113          	addi	sp,sp,-16
    800018ac:	00813423          	sd	s0,8(sp)
    800018b0:	01010413          	addi	s0,sp,16
    FreeBlock* temp = head;
    for(; temp && temp <= memoryToFree; temp = temp->nextBlock){}
    800018b4:	00050863          	beqz	a0,800018c4 <_ZN15MemoryAllocator21findPreviousFreeBlockEPNS_9FreeBlockES1_+0x1c>
    800018b8:	00a5e663          	bltu	a1,a0,800018c4 <_ZN15MemoryAllocator21findPreviousFreeBlockEPNS_9FreeBlockES1_+0x1c>
    800018bc:	01053503          	ld	a0,16(a0)
    800018c0:	ff5ff06f          	j	800018b4 <_ZN15MemoryAllocator21findPreviousFreeBlockEPNS_9FreeBlockES1_+0xc>
    if(!temp)
    800018c4:	00050463          	beqz	a0,800018cc <_ZN15MemoryAllocator21findPreviousFreeBlockEPNS_9FreeBlockES1_+0x24>
    {
        return nullptr;
    }
    return temp->previousBlock;
    800018c8:	01853503          	ld	a0,24(a0)
}
    800018cc:	00813403          	ld	s0,8(sp)
    800018d0:	01010113          	addi	sp,sp,16
    800018d4:	00008067          	ret

00000000800018d8 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_>:

    return 0;
}

void MemoryAllocator::connectAdjacentBlocks(FreeBlock* previousBlock, FreeBlock* adjacentBlock)
{
    800018d8:	ff010113          	addi	sp,sp,-16
    800018dc:	00813423          	sd	s0,8(sp)
    800018e0:	01010413          	addi	s0,sp,16


    if(adjacentBlock == (FreeBlock*)((uint8 *)previousBlock + previousBlock->numOfBlocks * MEM_BLOCK_SIZE))
    800018e4:	00853703          	ld	a4,8(a0)
    800018e8:	00671793          	slli	a5,a4,0x6
    800018ec:	00f507b3          	add	a5,a0,a5
    800018f0:	00b78e63          	beq	a5,a1,8000190c <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_+0x34>
        adjacentBlock->previousBlock = nullptr;

    }
    else
    {
        previousBlock->nextBlock = adjacentBlock;
    800018f4:	00b53823          	sd	a1,16(a0)
        if(adjacentBlock)
    800018f8:	00058463          	beqz	a1,80001900 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_+0x28>
        {
            adjacentBlock->previousBlock = previousBlock;
    800018fc:	00a5bc23          	sd	a0,24(a1)
        }

    }
}
    80001900:	00813403          	ld	s0,8(sp)
    80001904:	01010113          	addi	sp,sp,16
    80001908:	00008067          	ret
        previousBlock->numOfBlocks += adjacentBlock->numOfBlocks;
    8000190c:	0085b783          	ld	a5,8(a1)
    80001910:	00f70733          	add	a4,a4,a5
    80001914:	00e53423          	sd	a4,8(a0)
        previousBlock->nextBlock = adjacentBlock->nextBlock;
    80001918:	0105b783          	ld	a5,16(a1)
    8000191c:	00f53823          	sd	a5,16(a0)
        if(adjacentBlock->nextBlock != nullptr)
    80001920:	00078463          	beqz	a5,80001928 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_+0x50>
            adjacentBlock->nextBlock->previousBlock = previousBlock;
    80001924:	00a7bc23          	sd	a0,24(a5)
        if(adjacentBlock->previousBlock != previousBlock && adjacentBlock->previousBlock != nullptr)
    80001928:	0185b783          	ld	a5,24(a1)
    8000192c:	00a78863          	beq	a5,a0,8000193c <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_+0x64>
    80001930:	00078663          	beqz	a5,8000193c <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_+0x64>
            previousBlock->previousBlock = adjacentBlock->previousBlock;
    80001934:	00f53c23          	sd	a5,24(a0)
            adjacentBlock->previousBlock->nextBlock = previousBlock;
    80001938:	00a7b823          	sd	a0,16(a5)
        adjacentBlock->flagFree = false;
    8000193c:	00058023          	sb	zero,0(a1)
        adjacentBlock->numOfBlocks = 0;
    80001940:	0005b423          	sd	zero,8(a1)
        adjacentBlock->nextBlock = nullptr;
    80001944:	0005b823          	sd	zero,16(a1)
        adjacentBlock->previousBlock = nullptr;
    80001948:	0005bc23          	sd	zero,24(a1)
    8000194c:	fb5ff06f          	j	80001900 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_+0x28>

0000000080001950 <_ZN15MemoryAllocator10freeMemoryEPv>:
    if(!addressToFree)
    80001950:	0c050e63          	beqz	a0,80001a2c <_ZN15MemoryAllocator10freeMemoryEPv+0xdc>
{
    80001954:	fc010113          	addi	sp,sp,-64
    80001958:	02113c23          	sd	ra,56(sp)
    8000195c:	02813823          	sd	s0,48(sp)
    80001960:	02913423          	sd	s1,40(sp)
    80001964:	03213023          	sd	s2,32(sp)
    80001968:	01313c23          	sd	s3,24(sp)
    8000196c:	01413823          	sd	s4,16(sp)
    80001970:	01513423          	sd	s5,8(sp)
    80001974:	04010413          	addi	s0,sp,64
    80001978:	00050493          	mv	s1,a0
    tempAddress--;
    8000197c:	ff050913          	addi	s2,a0,-16
    int numOfTakenBlocks = tempAddress->numOfBlocks;
    80001980:	ff852a83          	lw	s5,-8(a0)
    numOfFreeBlocks += numOfTakenBlocks;
    80001984:	00004997          	auipc	s3,0x4
    80001988:	09c98993          	addi	s3,s3,156 # 80005a20 <_ZN15MemoryAllocator13NUM_OF_BLOCKSE>
    8000198c:	0089b783          	ld	a5,8(s3)
    80001990:	015787b3          	add	a5,a5,s5
    80001994:	00f9b423          	sd	a5,8(s3)
    FreeBlock* nextFreeBlock = findNextFreeBlock(newFreeBlock);
    80001998:	00090513          	mv	a0,s2
    8000199c:	00000097          	auipc	ra,0x0
    800019a0:	ec4080e7          	jalr	-316(ra) # 80001860 <_ZN15MemoryAllocator17findNextFreeBlockEPNS_9FreeBlockE>
    800019a4:	00050a13          	mv	s4,a0
    FreeBlock* previousFreeBlock = findPreviousFreeBlock(firstFreeBlock, newFreeBlock);
    800019a8:	00090593          	mv	a1,s2
    800019ac:	0109b503          	ld	a0,16(s3)
    800019b0:	00000097          	auipc	ra,0x0
    800019b4:	ef8080e7          	jalr	-264(ra) # 800018a8 <_ZN15MemoryAllocator21findPreviousFreeBlockEPNS_9FreeBlockES1_>
    800019b8:	00050993          	mv	s3,a0
    newFreeBlock->flagFree = true;
    800019bc:	00100793          	li	a5,1
    800019c0:	fef48823          	sb	a5,-16(s1)
    newFreeBlock->numOfBlocks = numOfTakenBlocks;
    800019c4:	ff54bc23          	sd	s5,-8(s1)
    newFreeBlock->nextBlock = nullptr;
    800019c8:	0004b023          	sd	zero,0(s1)
    newFreeBlock->previousBlock = nullptr;
    800019cc:	0004b423          	sd	zero,8(s1)
    connectAdjacentBlocks(newFreeBlock, nextFreeBlock);
    800019d0:	000a0593          	mv	a1,s4
    800019d4:	00090513          	mv	a0,s2
    800019d8:	00000097          	auipc	ra,0x0
    800019dc:	f00080e7          	jalr	-256(ra) # 800018d8 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_>
    if(previousFreeBlock)
    800019e0:	02098e63          	beqz	s3,80001a1c <_ZN15MemoryAllocator10freeMemoryEPv+0xcc>
        connectAdjacentBlocks(previousFreeBlock, newFreeBlock);
    800019e4:	00090593          	mv	a1,s2
    800019e8:	00098513          	mv	a0,s3
    800019ec:	00000097          	auipc	ra,0x0
    800019f0:	eec080e7          	jalr	-276(ra) # 800018d8 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_>
    return 0;
    800019f4:	00000513          	li	a0,0
}
    800019f8:	03813083          	ld	ra,56(sp)
    800019fc:	03013403          	ld	s0,48(sp)
    80001a00:	02813483          	ld	s1,40(sp)
    80001a04:	02013903          	ld	s2,32(sp)
    80001a08:	01813983          	ld	s3,24(sp)
    80001a0c:	01013a03          	ld	s4,16(sp)
    80001a10:	00813a83          	ld	s5,8(sp)
    80001a14:	04010113          	addi	sp,sp,64
    80001a18:	00008067          	ret
        firstFreeBlock = newFreeBlock;
    80001a1c:	00004797          	auipc	a5,0x4
    80001a20:	0127ba23          	sd	s2,20(a5) # 80005a30 <_ZN15MemoryAllocator14firstFreeBlockE>
    return 0;
    80001a24:	00000513          	li	a0,0
    80001a28:	fd1ff06f          	j	800019f8 <_ZN15MemoryAllocator10freeMemoryEPv+0xa8>
        return -1;
    80001a2c:	fff00513          	li	a0,-1
}
    80001a30:	00008067          	ret

0000000080001a34 <_ZN15MemoryAllocator19getLargestFreeBlockEv>:

size_t  MemoryAllocator::getLargestFreeBlock()
{
    80001a34:	ff010113          	addi	sp,sp,-16
    80001a38:	00813423          	sd	s0,8(sp)
    80001a3c:	01010413          	addi	s0,sp,16
    size_t largestBlock = firstFreeBlock->numOfBlocks;
    80001a40:	00004797          	auipc	a5,0x4
    80001a44:	ff07b783          	ld	a5,-16(a5) # 80005a30 <_ZN15MemoryAllocator14firstFreeBlockE>
    80001a48:	0087b503          	ld	a0,8(a5)
    for(FreeBlock* curr = firstFreeBlock->nextBlock; curr; curr = curr->nextBlock)
    80001a4c:	0107b783          	ld	a5,16(a5)
    80001a50:	0080006f          	j	80001a58 <_ZN15MemoryAllocator19getLargestFreeBlockEv+0x24>
    80001a54:	0107b783          	ld	a5,16(a5)
    80001a58:	00078a63          	beqz	a5,80001a6c <_ZN15MemoryAllocator19getLargestFreeBlockEv+0x38>
    {
        if(curr->numOfBlocks > largestBlock)
    80001a5c:	0087b703          	ld	a4,8(a5)
    80001a60:	fee57ae3          	bgeu	a0,a4,80001a54 <_ZN15MemoryAllocator19getLargestFreeBlockEv+0x20>
        {
            largestBlock = curr->numOfBlocks;
    80001a64:	00070513          	mv	a0,a4
    80001a68:	fedff06f          	j	80001a54 <_ZN15MemoryAllocator19getLargestFreeBlockEv+0x20>
        }
    }
    return largestBlock * MEM_BLOCK_SIZE;
}
    80001a6c:	00651513          	slli	a0,a0,0x6
    80001a70:	00813403          	ld	s0,8(sp)
    80001a74:	01010113          	addi	sp,sp,16
    80001a78:	00008067          	ret

0000000080001a7c <_ZN15MemoryAllocator12getFreeSpaceEv>:
size_t MemoryAllocator::getFreeSpace()
{
    80001a7c:	ff010113          	addi	sp,sp,-16
    80001a80:	00813423          	sd	s0,8(sp)
    80001a84:	01010413          	addi	s0,sp,16
    return numOfFreeBlocks * MEM_BLOCK_SIZE;
}
    80001a88:	00004517          	auipc	a0,0x4
    80001a8c:	fa053503          	ld	a0,-96(a0) # 80005a28 <_ZN15MemoryAllocator15numOfFreeBlocksE>
    80001a90:	00651513          	slli	a0,a0,0x6
    80001a94:	00813403          	ld	s0,8(sp)
    80001a98:	01010113          	addi	sp,sp,16
    80001a9c:	00008067          	ret

0000000080001aa0 <_ZN15MemoryAllocator17getSizeOfMetaDataEv>:

size_t MemoryAllocator::getSizeOfMetaData()
{
    80001aa0:	ff010113          	addi	sp,sp,-16
    80001aa4:	00813423          	sd	s0,8(sp)
    80001aa8:	01010413          	addi	s0,sp,16
    return sizeof(OccupiedBlock);
    80001aac:	01000513          	li	a0,16
    80001ab0:	00813403          	ld	s0,8(sp)
    80001ab4:	01010113          	addi	sp,sp,16
    80001ab8:	00008067          	ret

0000000080001abc <_ZN6Kernel12kernelWorkerEPv>:
    }

}

void Kernel::kernelWorker(void*)
{
    80001abc:	ff010113          	addi	sp,sp,-16
    80001ac0:	00813423          	sd	s0,8(sp)
    80001ac4:	01010413          	addi	s0,sp,16
    while(1)
    80001ac8:	0000006f          	j	80001ac8 <_ZN6Kernel12kernelWorkerEPv+0xc>

0000000080001acc <_ZN6Kernel9sysMallocEPNS_21ArgumentsOfSystemCallE>:

    }
}

uint64 Kernel::sysMalloc(Kernel::ArgumentsOfSystemCall *arg)
{
    80001acc:	ff010113          	addi	sp,sp,-16
    80001ad0:	00113423          	sd	ra,8(sp)
    80001ad4:	00813023          	sd	s0,0(sp)
    80001ad8:	01010413          	addi	s0,sp,16
    uint64 returnValue;
    returnValue = (uint64)MemoryAllocator::allocateMemory(arg->a0);
    80001adc:	00053503          	ld	a0,0(a0)
    80001ae0:	00000097          	auipc	ra,0x0
    80001ae4:	d14080e7          	jalr	-748(ra) # 800017f4 <_ZN15MemoryAllocator14allocateMemoryEm>
    return returnValue;
}
    80001ae8:	00813083          	ld	ra,8(sp)
    80001aec:	00013403          	ld	s0,0(sp)
    80001af0:	01010113          	addi	sp,sp,16
    80001af4:	00008067          	ret

0000000080001af8 <_ZN6Kernel7sysFreeEPNS_21ArgumentsOfSystemCallE>:
uint64 Kernel::sysFree(Kernel::ArgumentsOfSystemCall *arg)
{
    80001af8:	ff010113          	addi	sp,sp,-16
    80001afc:	00113423          	sd	ra,8(sp)
    80001b00:	00813023          	sd	s0,0(sp)
    80001b04:	01010413          	addi	s0,sp,16
    uint64 returnValue;
    returnValue = (uint64)MemoryAllocator::freeMemory((void*)arg->a0);
    80001b08:	00053503          	ld	a0,0(a0)
    80001b0c:	00000097          	auipc	ra,0x0
    80001b10:	e44080e7          	jalr	-444(ra) # 80001950 <_ZN15MemoryAllocator10freeMemoryEPv>
    return returnValue;
}
    80001b14:	00813083          	ld	ra,8(sp)
    80001b18:	00013403          	ld	s0,0(sp)
    80001b1c:	01010113          	addi	sp,sp,16
    80001b20:	00008067          	ret

0000000080001b24 <_ZN6Kernel15sysGetFreeSpaceEPNS_21ArgumentsOfSystemCallE>:
uint64 Kernel::sysGetFreeSpace(Kernel::ArgumentsOfSystemCall *arg)
{
    80001b24:	ff010113          	addi	sp,sp,-16
    80001b28:	00113423          	sd	ra,8(sp)
    80001b2c:	00813023          	sd	s0,0(sp)
    80001b30:	01010413          	addi	s0,sp,16
    uint64 returnValue;
    returnValue = (uint64)MemoryAllocator::getFreeSpace();
    80001b34:	00000097          	auipc	ra,0x0
    80001b38:	f48080e7          	jalr	-184(ra) # 80001a7c <_ZN15MemoryAllocator12getFreeSpaceEv>
    return returnValue;
}
    80001b3c:	00813083          	ld	ra,8(sp)
    80001b40:	00013403          	ld	s0,0(sp)
    80001b44:	01010113          	addi	sp,sp,16
    80001b48:	00008067          	ret

0000000080001b4c <_ZN6Kernel19sysLargestFreeBlockEPNS_21ArgumentsOfSystemCallE>:
uint64 Kernel::sysLargestFreeBlock(Kernel::ArgumentsOfSystemCall *arg)
{
    80001b4c:	ff010113          	addi	sp,sp,-16
    80001b50:	00113423          	sd	ra,8(sp)
    80001b54:	00813023          	sd	s0,0(sp)
    80001b58:	01010413          	addi	s0,sp,16
    uint64 returnValue;
    returnValue = (uint64)MemoryAllocator::getLargestFreeBlock();
    80001b5c:	00000097          	auipc	ra,0x0
    80001b60:	ed8080e7          	jalr	-296(ra) # 80001a34 <_ZN15MemoryAllocator19getLargestFreeBlockEv>
    return returnValue;
}
    80001b64:	00813083          	ld	ra,8(sp)
    80001b68:	00013403          	ld	s0,0(sp)
    80001b6c:	01010113          	addi	sp,sp,16
    80001b70:	00008067          	ret

0000000080001b74 <_ZN6Kernel19initializeArgumentsEPNS_21ArgumentsOfSystemCallEm>:
{
    80001b74:	ff010113          	addi	sp,sp,-16
    80001b78:	00813423          	sd	s0,8(sp)
    80001b7c:	01010413          	addi	s0,sp,16
    __asm__ volatile("ld %[rd], 11*8(%[rs])":[rd]"=r"(arg->a0):[rs]"r"(basePointer));
    80001b80:	0585b783          	ld	a5,88(a1)
    80001b84:	00f53023          	sd	a5,0(a0)
    __asm__ volatile("ld %[rd], 12*8(%[rs])":[rd]"=r"(arg->a1):[rs]"r"(basePointer));
    80001b88:	0605b783          	ld	a5,96(a1)
    80001b8c:	00f53423          	sd	a5,8(a0)
    __asm__ volatile("ld %[rd], 13*8(%[rs])":[rd]"=r"(arg->a2):[rs]"r"(basePointer));
    80001b90:	0685b783          	ld	a5,104(a1)
    80001b94:	00f53823          	sd	a5,16(a0)
    __asm__ volatile("ld %[rd], 14*8(%[rs])":[rd]"=r"(arg->a3):[rs]"r"(basePointer));
    80001b98:	0705b783          	ld	a5,112(a1)
    80001b9c:	00f53c23          	sd	a5,24(a0)
    __asm__ volatile("ld %[rd], 15*8(%[rs])":[rd]"=r"(arg->a4):[rs]"r"(basePointer));
    80001ba0:	0785b783          	ld	a5,120(a1)
    80001ba4:	02f53023          	sd	a5,32(a0)
    __asm__ volatile("ld %[rd], 16*8(%[rs])":[rd]"=r"(arg->a5):[rs]"r"(basePointer));
    80001ba8:	0805b783          	ld	a5,128(a1)
    80001bac:	02f53423          	sd	a5,40(a0)
    __asm__ volatile("ld %[rd], 17*8(%[rs])":[rd]"=r"(arg->a6):[rs]"r"(basePointer));
    80001bb0:	0885b583          	ld	a1,136(a1)
    80001bb4:	02b53823          	sd	a1,48(a0)
}
    80001bb8:	00813403          	ld	s0,8(sp)
    80001bbc:	01010113          	addi	sp,sp,16
    80001bc0:	00008067          	ret

0000000080001bc4 <_ZN6Kernel17mallocSystemStackEm>:
{
    80001bc4:	ff010113          	addi	sp,sp,-16
    80001bc8:	00113423          	sd	ra,8(sp)
    80001bcc:	00813023          	sd	s0,0(sp)
    80001bd0:	01010413          	addi	s0,sp,16
    size_t numOfBlocks = numOfBytes / MEM_BLOCK_SIZE;
    80001bd4:	00655793          	srli	a5,a0,0x6
    numOfBlocks += numOfBytes % MEM_BLOCK_SIZE ? 1 : 0;
    80001bd8:	03f57513          	andi	a0,a0,63
    80001bdc:	00050463          	beqz	a0,80001be4 <_ZN6Kernel17mallocSystemStackEm+0x20>
    80001be0:	00100513          	li	a0,1
    uint8* systemStack = (uint8*)MemoryAllocator::allocateMemory(numOfBlocks);
    80001be4:	00f50533          	add	a0,a0,a5
    80001be8:	00000097          	auipc	ra,0x0
    80001bec:	c0c080e7          	jalr	-1012(ra) # 800017f4 <_ZN15MemoryAllocator14allocateMemoryEm>
}
    80001bf0:	40050513          	addi	a0,a0,1024
    80001bf4:	00813083          	ld	ra,8(sp)
    80001bf8:	00013403          	ld	s0,0(sp)
    80001bfc:	01010113          	addi	sp,sp,16
    80001c00:	00008067          	ret

0000000080001c04 <_ZN6Kernel16interruptHandlerEv>:
{
    80001c04:	f9010113          	addi	sp,sp,-112
    80001c08:	06113423          	sd	ra,104(sp)
    80001c0c:	06813023          	sd	s0,96(sp)
    80001c10:	04913c23          	sd	s1,88(sp)
    80001c14:	05213823          	sd	s2,80(sp)
    80001c18:	05313423          	sd	s3,72(sp)
    80001c1c:	05413023          	sd	s4,64(sp)
    80001c20:	07010413          	addi	s0,sp,112
    __asm__ volatile ("addi %[reg], s0, 0x0": [reg]"=r"(basePointer)); // Problem: da li mozemo biti 100% sigurni da ce s0 biti nepromenjen; resenje inline f-ja
    80001c24:	00040793          	mv	a5,s0
    80001c28:	fcf43423          	sd	a5,-56(s0)
    __asm__ volatile ("csrr %[cause], scause": [cause] "=r"(scause));
    80001c2c:	14202773          	csrr	a4,scause
    if(scause == 0x0000000000000008UL || scause == 0x0000000000000009UL)
    80001c30:	ff870693          	addi	a3,a4,-8
    80001c34:	00100793          	li	a5,1
    80001c38:	02d7fa63          	bgeu	a5,a3,80001c6c <_ZN6Kernel16interruptHandlerEv+0x68>
    else if (scause == 0x8000000000000001UL)
    80001c3c:	fff00793          	li	a5,-1
    80001c40:	03f79793          	slli	a5,a5,0x3f
    80001c44:	00178793          	addi	a5,a5,1
    80001c48:	08f70663          	beq	a4,a5,80001cd4 <_ZN6Kernel16interruptHandlerEv+0xd0>
}
    80001c4c:	06813083          	ld	ra,104(sp)
    80001c50:	06013403          	ld	s0,96(sp)
    80001c54:	05813483          	ld	s1,88(sp)
    80001c58:	05013903          	ld	s2,80(sp)
    80001c5c:	04813983          	ld	s3,72(sp)
    80001c60:	04013a03          	ld	s4,64(sp)
    80001c64:	07010113          	addi	sp,sp,112
    80001c68:	00008067          	ret
    __asm__ volatile ("csrc sip, %[reg]":: [reg] "r"(mask));
    80001c6c:	00200793          	li	a5,2
    80001c70:	1447b073          	csrc	sip,a5
}
inline uint64 Machine::readSepc()
{
    uint64 returnAddress;
    __asm__ volatile ("csrr %[reg], sepc": [reg] "=r"(returnAddress));
    80001c74:	141029f3          	csrr	s3,sepc
        uint64 sepc = Machine::readSepc() + 4;
    80001c78:	00498993          	addi	s3,s3,4
    __asm__ volatile("csrw sstatus, %[reg]":: [reg] "r"(oldStatus));
}
inline uint64 Machine::readSstatus()
{
    uint64 returnStatus;
    __asm__ volatile ("csrr %[reg], sstatus": [reg] "=r"(returnStatus));
    80001c7c:	10002a73          	csrr	s4,sstatus
        __asm__ volatile ("ld %[rd], 80(%[rs])": [rd]"=r"(numberOfEntry):[rs]"r"(basePointer));
    80001c80:	fc843483          	ld	s1,-56(s0)
    80001c84:	0504b483          	ld	s1,80(s1)
        initializeArguments(&arg, basePointer);
    80001c88:	fc843583          	ld	a1,-56(s0)
    80001c8c:	f9040913          	addi	s2,s0,-112
    80001c90:	00090513          	mv	a0,s2
    80001c94:	00000097          	auipc	ra,0x0
    80001c98:	ee0080e7          	jalr	-288(ra) # 80001b74 <_ZN6Kernel19initializeArgumentsEPNS_21ArgumentsOfSystemCallEm>
        systemCallsTable[numberOfEntry](&arg);
    80001c9c:	00349493          	slli	s1,s1,0x3
    80001ca0:	00004797          	auipc	a5,0x4
    80001ca4:	da078793          	addi	a5,a5,-608 # 80005a40 <_ZN6Kernel16systemCallsTableE>
    80001ca8:	009784b3          	add	s1,a5,s1
    80001cac:	0004b783          	ld	a5,0(s1)
    80001cb0:	00090513          	mv	a0,s2
    80001cb4:	000780e7          	jalr	a5
        __asm__ volatile("sd a0, 80(%[rs])"::[rs]"r"(basePointer));
    80001cb8:	fc843783          	ld	a5,-56(s0)
    80001cbc:	04a7b823          	sd	a0,80(a5)
        TCB::dispatch();
    80001cc0:	00000097          	auipc	ra,0x0
    80001cc4:	924080e7          	jalr	-1756(ra) # 800015e4 <_ZN3TCB8dispatchEv>
    __asm__ volatile("csrw sepc, %[reg]":: [reg] "r"(address));
    80001cc8:	14199073          	csrw	sepc,s3
    __asm__ volatile("csrw sstatus, %[reg]":: [reg] "r"(oldStatus));
    80001ccc:	100a1073          	csrw	sstatus,s4
    80001cd0:	f7dff06f          	j	80001c4c <_ZN6Kernel16interruptHandlerEv+0x48>
    __asm__ volatile ("csrc sip, %[reg]":: [reg] "r"(mask));
    80001cd4:	00200793          	li	a5,2
    80001cd8:	1447b073          	csrc	sip,a5

    static size_t getNumOfTicks() { return numOfTicks; }
    static void resetNumOfTicks() { numOfTicks = DEFAULT_TIME_SLICE; }
    static void incrementNumOfTicks() { numOfTicks++; }
    80001cdc:	00004717          	auipc	a4,0x4
    80001ce0:	cc473703          	ld	a4,-828(a4) # 800059a0 <_GLOBAL_OFFSET_TABLE_+0x20>
    80001ce4:	00073783          	ld	a5,0(a4)
    80001ce8:	00178793          	addi	a5,a5,1
    80001cec:	00f73023          	sd	a5,0(a4)
    static TCB* getRunningThread() { return running; }
    80001cf0:	00004717          	auipc	a4,0x4
    80001cf4:	cb873703          	ld	a4,-840(a4) # 800059a8 <_GLOBAL_OFFSET_TABLE_+0x28>
    80001cf8:	00073703          	ld	a4,0(a4)
    size_t getTimeSlice() const { return timeSlice; }
    80001cfc:	03073703          	ld	a4,48(a4)
        if(TCB::getNumOfTicks() >= TCB::getRunningThread()->getTimeSlice())
    80001d00:	f4e7e6e3          	bltu	a5,a4,80001c4c <_ZN6Kernel16interruptHandlerEv+0x48>
    static void resetNumOfTicks() { numOfTicks = DEFAULT_TIME_SLICE; }
    80001d04:	00004797          	auipc	a5,0x4
    80001d08:	c9c7b783          	ld	a5,-868(a5) # 800059a0 <_GLOBAL_OFFSET_TABLE_+0x20>
    80001d0c:	00200713          	li	a4,2
    80001d10:	00e7b023          	sd	a4,0(a5)
    __asm__ volatile ("csrr %[reg], sepc": [reg] "=r"(returnAddress));
    80001d14:	141024f3          	csrr	s1,sepc
            uint64 sepc = Machine::readSepc() + 4;
    80001d18:	00448493          	addi	s1,s1,4
    __asm__ volatile ("csrr %[reg], sstatus": [reg] "=r"(returnStatus));
    80001d1c:	10002973          	csrr	s2,sstatus
            TCB::dispatch();
    80001d20:	00000097          	auipc	ra,0x0
    80001d24:	8c4080e7          	jalr	-1852(ra) # 800015e4 <_ZN3TCB8dispatchEv>
    __asm__ volatile("csrw sepc, %[reg]":: [reg] "r"(address));
    80001d28:	14149073          	csrw	sepc,s1
    __asm__ volatile("csrw sstatus, %[reg]":: [reg] "r"(oldStatus));
    80001d2c:	10091073          	csrw	sstatus,s2
}
    80001d30:	f1dff06f          	j	80001c4c <_ZN6Kernel16interruptHandlerEv+0x48>

0000000080001d34 <_ZN6Kernel17sysThreadDispatchEPNS_21ArgumentsOfSystemCallE>:
    void* kernelSystemStack = Kernel::mallocSystemStack(KernelConfig::DEFAULT_SYSTEM_STACK_SIZE);
    newThread->initializeThread((TCB::Body) arg->a1, (void*)arg->a2, (void*)arg->a3, kernelSystemStack);
    return 0;
}
uint64 Kernel::sysThreadDispatch(Kernel::ArgumentsOfSystemCall *arg)
{
    80001d34:	ff010113          	addi	sp,sp,-16
    80001d38:	00113423          	sd	ra,8(sp)
    80001d3c:	00813023          	sd	s0,0(sp)
    80001d40:	01010413          	addi	s0,sp,16
    TCB::dispatch();
    80001d44:	00000097          	auipc	ra,0x0
    80001d48:	8a0080e7          	jalr	-1888(ra) # 800015e4 <_ZN3TCB8dispatchEv>
    return 0;
}
    80001d4c:	00000513          	li	a0,0
    80001d50:	00813083          	ld	ra,8(sp)
    80001d54:	00013403          	ld	s0,0(sp)
    80001d58:	01010113          	addi	sp,sp,16
    80001d5c:	00008067          	ret

0000000080001d60 <_ZN6Kernel21initializeSystemCallsEv>:
    Kernel::poolOfThreads->freeObject(TCB::getRunningThread());
    return 0;
}

void Kernel::initializeSystemCalls(void)
{
    80001d60:	ff010113          	addi	sp,sp,-16
    80001d64:	00813423          	sd	s0,8(sp)
    80001d68:	01010413          	addi	s0,sp,16
    systemCallsTable[KernelConfig::MEM_ALLOC] = &sysMalloc;
    80001d6c:	00004797          	auipc	a5,0x4
    80001d70:	cd478793          	addi	a5,a5,-812 # 80005a40 <_ZN6Kernel16systemCallsTableE>
    80001d74:	00000717          	auipc	a4,0x0
    80001d78:	d5870713          	addi	a4,a4,-680 # 80001acc <_ZN6Kernel9sysMallocEPNS_21ArgumentsOfSystemCallE>
    80001d7c:	00e7b423          	sd	a4,8(a5)
    systemCallsTable[KernelConfig::MEM_FREE] = &sysFree;
    80001d80:	00000717          	auipc	a4,0x0
    80001d84:	d7870713          	addi	a4,a4,-648 # 80001af8 <_ZN6Kernel7sysFreeEPNS_21ArgumentsOfSystemCallE>
    80001d88:	00e7b823          	sd	a4,16(a5)
    systemCallsTable[KernelConfig::MEM_FREE_SPACE] = &sysGetFreeSpace;
    80001d8c:	00000717          	auipc	a4,0x0
    80001d90:	d9870713          	addi	a4,a4,-616 # 80001b24 <_ZN6Kernel15sysGetFreeSpaceEPNS_21ArgumentsOfSystemCallE>
    80001d94:	00e7bc23          	sd	a4,24(a5)
    systemCallsTable[KernelConfig::LARGEST_FREE_BLOCK] = &sysLargestFreeBlock;
    80001d98:	00000717          	auipc	a4,0x0
    80001d9c:	db470713          	addi	a4,a4,-588 # 80001b4c <_ZN6Kernel19sysLargestFreeBlockEPNS_21ArgumentsOfSystemCallE>
    80001da0:	02e7b023          	sd	a4,32(a5)
    systemCallsTable[KernelConfig::THREAD_CREATE] = &sysThreadCreate;
    80001da4:	00000717          	auipc	a4,0x0
    80001da8:	28c70713          	addi	a4,a4,652 # 80002030 <_ZN6Kernel15sysThreadCreateEPNS_21ArgumentsOfSystemCallE>
    80001dac:	08e7b423          	sd	a4,136(a5)
    80001db0:	00813403          	ld	s0,8(sp)
    80001db4:	01010113          	addi	sp,sp,16
    80001db8:	00008067          	ret

0000000080001dbc <_Z41__static_initialization_and_destruction_0ii>:
    80001dbc:	00100793          	li	a5,1
    80001dc0:	00f50463          	beq	a0,a5,80001dc8 <_Z41__static_initialization_and_destruction_0ii+0xc>
    80001dc4:	00008067          	ret
    80001dc8:	000107b7          	lui	a5,0x10
    80001dcc:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80001dd0:	fef59ae3          	bne	a1,a5,80001dc4 <_Z41__static_initialization_and_destruction_0ii+0x8>
    80001dd4:	ff010113          	addi	sp,sp,-16
    80001dd8:	00113423          	sd	ra,8(sp)
    80001ddc:	00813023          	sd	s0,0(sp)
    80001de0:	01010413          	addi	s0,sp,16
ObjectPool<TCB, KernelConfig::NUM_OF_THREADS_IN_POOL>* Kernel::poolOfThreads = new ObjectPool<TCB, KernelConfig::NUM_OF_THREADS_IN_POOL>();
    80001de4:	70000513          	li	a0,1792
    80001de8:	00000097          	auipc	ra,0x0
    80001dec:	308080e7          	jalr	776(ra) # 800020f0 <_ZN10ObjectPoolI3TCBLm20EEnwEm>


template <typename T, size_t numOfObjects>
class ObjectPool {
public:
    ObjectPool(): headFreeObject(pool), nextObjectPool(nullptr), prevObjectPool(nullptr), id(countOfPools++)
    80001df0:	6ea53023          	sd	a0,1760(a0)
    80001df4:	6e053423          	sd	zero,1768(a0)
    80001df8:	6e053823          	sd	zero,1776(a0)
    80001dfc:	00004717          	auipc	a4,0x4
    80001e00:	e5c70713          	addi	a4,a4,-420 # 80005c58 <_ZN10ObjectPoolI3TCBLm20EE12countOfPoolsE>
    80001e04:	00073783          	ld	a5,0(a4)
    80001e08:	00178693          	addi	a3,a5,1
    80001e0c:	00d73023          	sd	a3,0(a4)
    80001e10:	6ef53c23          	sd	a5,1784(a0)
    {

        for(size_t i = 0; i < numOfObjects - 1; i++)
    80001e14:	00000793          	li	a5,0
    80001e18:	01200713          	li	a4,18
    80001e1c:	02f76463          	bltu	a4,a5,80001e44 <_Z41__static_initialization_and_destruction_0ii+0x88>
        {
            pool[i].nextFree = &(pool[i+1]);
    80001e20:	00178693          	addi	a3,a5,1
    80001e24:	05800613          	li	a2,88
    80001e28:	02c68733          	mul	a4,a3,a2
    80001e2c:	00e50733          	add	a4,a0,a4
    80001e30:	02c787b3          	mul	a5,a5,a2
    80001e34:	00f507b3          	add	a5,a0,a5
    80001e38:	04e7b823          	sd	a4,80(a5)
        for(size_t i = 0; i < numOfObjects - 1; i++)
    80001e3c:	00068793          	mv	a5,a3
    80001e40:	fd9ff06f          	j	80001e18 <_Z41__static_initialization_and_destruction_0ii+0x5c>
        }
        pool[numOfObjects - 1].nextFree = nullptr;
    80001e44:	6c053c23          	sd	zero,1752(a0)
    80001e48:	00004797          	auipc	a5,0x4
    80001e4c:	e0a7b423          	sd	a0,-504(a5) # 80005c50 <_ZN6Kernel13poolOfThreadsE>
    80001e50:	00813083          	ld	ra,8(sp)
    80001e54:	00013403          	ld	s0,0(sp)
    80001e58:	01010113          	addi	sp,sp,16
    80001e5c:	00008067          	ret

0000000080001e60 <_ZN6Kernel13sysThreadExitEPNS_21ArgumentsOfSystemCallE>:
{
    80001e60:	ff010113          	addi	sp,sp,-16
    80001e64:	00113423          	sd	ra,8(sp)
    80001e68:	00813023          	sd	s0,0(sp)
    80001e6c:	01010413          	addi	s0,sp,16
    static TCB* getRunningThread() { return running; }
    80001e70:	00004797          	auipc	a5,0x4
    80001e74:	b387b783          	ld	a5,-1224(a5) # 800059a8 <_GLOBAL_OFFSET_TABLE_+0x28>
    80001e78:	0007b783          	ld	a5,0(a5)
    if(MemoryAllocator::freeMemory(TCB::getRunningThread()->getSystemStack()) == -1)
    80001e7c:	0287b503          	ld	a0,40(a5)
    80001e80:	00000097          	auipc	ra,0x0
    80001e84:	ad0080e7          	jalr	-1328(ra) # 80001950 <_ZN15MemoryAllocator10freeMemoryEPv>
    80001e88:	fff00793          	li	a5,-1
    80001e8c:	04f50e63          	beq	a0,a5,80001ee8 <_ZN6Kernel13sysThreadExitEPNS_21ArgumentsOfSystemCallE+0x88>
    80001e90:	00004797          	auipc	a5,0x4
    80001e94:	b187b783          	ld	a5,-1256(a5) # 800059a8 <_GLOBAL_OFFSET_TABLE_+0x28>
    80001e98:	0007b783          	ld	a5,0(a5)
    void setIsFinished() { finished = true; }
    80001e9c:	00100713          	li	a4,1
    80001ea0:	04e78423          	sb	a4,72(a5)
    if(MemoryAllocator::freeMemory(TCB::getRunningThread()->getUserStack()) == -1)
    80001ea4:	0207b503          	ld	a0,32(a5)
    80001ea8:	00000097          	auipc	ra,0x0
    80001eac:	aa8080e7          	jalr	-1368(ra) # 80001950 <_ZN15MemoryAllocator10freeMemoryEPv>
    80001eb0:	fff00793          	li	a5,-1
    80001eb4:	02f50e63          	beq	a0,a5,80001ef0 <_ZN6Kernel13sysThreadExitEPNS_21ArgumentsOfSystemCallE+0x90>
    Kernel::poolOfThreads->freeObject(TCB::getRunningThread());
    80001eb8:	00004797          	auipc	a5,0x4
    80001ebc:	af07b783          	ld	a5,-1296(a5) # 800059a8 <_GLOBAL_OFFSET_TABLE_+0x28>
    80001ec0:	0007b583          	ld	a1,0(a5)
    80001ec4:	00004517          	auipc	a0,0x4
    80001ec8:	d8c53503          	ld	a0,-628(a0) # 80005c50 <_ZN6Kernel13poolOfThreadsE>
    80001ecc:	00000097          	auipc	ra,0x0
    80001ed0:	260080e7          	jalr	608(ra) # 8000212c <_ZN10ObjectPoolI3TCBLm20EE10freeObjectEPS0_>
    return 0;
    80001ed4:	00000513          	li	a0,0
}
    80001ed8:	00813083          	ld	ra,8(sp)
    80001edc:	00013403          	ld	s0,0(sp)
    80001ee0:	01010113          	addi	sp,sp,16
    80001ee4:	00008067          	ret
        return -1;
    80001ee8:	fff00513          	li	a0,-1
    80001eec:	fedff06f          	j	80001ed8 <_ZN6Kernel13sysThreadExitEPNS_21ArgumentsOfSystemCallE+0x78>
        return -1;
    80001ef0:	fff00513          	li	a0,-1
    80001ef4:	fe5ff06f          	j	80001ed8 <_ZN6Kernel13sysThreadExitEPNS_21ArgumentsOfSystemCallE+0x78>

0000000080001ef8 <_ZN6Kernel23initializeKernelThreadsEv>:
{
    80001ef8:	fe010113          	addi	sp,sp,-32
    80001efc:	00113c23          	sd	ra,24(sp)
    80001f00:	00813823          	sd	s0,16(sp)
    80001f04:	00913423          	sd	s1,8(sp)
    80001f08:	02010413          	addi	s0,sp,32
    void* kernelSystemStack = Kernel::mallocSystemStack(KernelConfig::DEFAULT_SYSTEM_STACK_SIZE);
    80001f0c:	40000513          	li	a0,1024
    80001f10:	00000097          	auipc	ra,0x0
    80001f14:	cb4080e7          	jalr	-844(ra) # 80001bc4 <_ZN6Kernel17mallocSystemStackEm>
    80001f18:	00050493          	mv	s1,a0
    TCB* kernelThread = poolOfThreads->mallocObject();
    80001f1c:	00004517          	auipc	a0,0x4
    80001f20:	d3453503          	ld	a0,-716(a0) # 80005c50 <_ZN6Kernel13poolOfThreadsE>
    80001f24:	00000097          	auipc	ra,0x0
    80001f28:	278080e7          	jalr	632(ra) # 8000219c <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEv>
    while(kernelThread == nullptr)
    80001f2c:	00051c63          	bnez	a0,80001f44 <_ZN6Kernel23initializeKernelThreadsEv+0x4c>
        kernelThread = poolOfThreads->mallocObject();
    80001f30:	00004517          	auipc	a0,0x4
    80001f34:	d2053503          	ld	a0,-736(a0) # 80005c50 <_ZN6Kernel13poolOfThreadsE>
    80001f38:	00000097          	auipc	ra,0x0
    80001f3c:	264080e7          	jalr	612(ra) # 8000219c <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEv>
    while(kernelThread == nullptr)
    80001f40:	fedff06f          	j	80001f2c <_ZN6Kernel23initializeKernelThreadsEv+0x34>
    kernelThread->initializeThread(&kernelWorker, nullptr, kernelSystemStack, kernelSystemStack, KernelConfig::KERNEL_MODE);
    80001f44:	00100793          	li	a5,1
    80001f48:	00048713          	mv	a4,s1
    80001f4c:	00048693          	mv	a3,s1
    80001f50:	00000613          	li	a2,0
    80001f54:	00000597          	auipc	a1,0x0
    80001f58:	b6858593          	addi	a1,a1,-1176 # 80001abc <_ZN6Kernel12kernelWorkerEPv>
    80001f5c:	fffff097          	auipc	ra,0xfffff
    80001f60:	5dc080e7          	jalr	1500(ra) # 80001538 <_ZN3TCB16initializeThreadEPFvPvES0_S0_S0_N12KernelConfig4ModeE>
    initializeSystemCalls();
    80001f64:	00000097          	auipc	ra,0x0
    80001f68:	dfc080e7          	jalr	-516(ra) # 80001d60 <_ZN6Kernel21initializeSystemCallsEv>
}
    80001f6c:	01813083          	ld	ra,24(sp)
    80001f70:	01013403          	ld	s0,16(sp)
    80001f74:	00813483          	ld	s1,8(sp)
    80001f78:	02010113          	addi	sp,sp,32
    80001f7c:	00008067          	ret

0000000080001f80 <_ZN6Kernel16initializeKernelEv>:
{
    80001f80:	ff010113          	addi	sp,sp,-16
    80001f84:	00113423          	sd	ra,8(sp)
    80001f88:	00813023          	sd	s0,0(sp)
    80001f8c:	01010413          	addi	s0,sp,16

};

inline void Kernel::setInterruptRoutine(void (*routine)(void))
{
    Machine::writeStvec((uint64) routine);
    80001f90:	00004797          	auipc	a5,0x4
    80001f94:	a087b783          	ld	a5,-1528(a5) # 80005998 <_GLOBAL_OFFSET_TABLE_+0x18>
    __asm__ volatile ("csrw stvec, %[address]": : [address] "r"(interruptAddress));
    80001f98:	10579073          	csrw	stvec,a5
}
    80001f9c:	0100006f          	j	80001fac <_ZN6Kernel16initializeKernelEv+0x2c>
    80001fa0:	6c053c23          	sd	zero,1752(a0)
     poolOfThreads = new ObjectPool<TCB, KernelConfig::NUM_OF_THREADS_IN_POOL>();
    80001fa4:	00004797          	auipc	a5,0x4
    80001fa8:	caa7b623          	sd	a0,-852(a5) # 80005c50 <_ZN6Kernel13poolOfThreadsE>
    while(!poolOfThreads)
    80001fac:	00004797          	auipc	a5,0x4
    80001fb0:	ca47b783          	ld	a5,-860(a5) # 80005c50 <_ZN6Kernel13poolOfThreadsE>
    80001fb4:	06079263          	bnez	a5,80002018 <_ZN6Kernel16initializeKernelEv+0x98>
     poolOfThreads = new ObjectPool<TCB, KernelConfig::NUM_OF_THREADS_IN_POOL>();
    80001fb8:	70000513          	li	a0,1792
    80001fbc:	00000097          	auipc	ra,0x0
    80001fc0:	134080e7          	jalr	308(ra) # 800020f0 <_ZN10ObjectPoolI3TCBLm20EEnwEm>
    ObjectPool(): headFreeObject(pool), nextObjectPool(nullptr), prevObjectPool(nullptr), id(countOfPools++)
    80001fc4:	6ea53023          	sd	a0,1760(a0)
    80001fc8:	6e053423          	sd	zero,1768(a0)
    80001fcc:	6e053823          	sd	zero,1776(a0)
    80001fd0:	00004717          	auipc	a4,0x4
    80001fd4:	c8870713          	addi	a4,a4,-888 # 80005c58 <_ZN10ObjectPoolI3TCBLm20EE12countOfPoolsE>
    80001fd8:	00073783          	ld	a5,0(a4)
    80001fdc:	00178693          	addi	a3,a5,1
    80001fe0:	00d73023          	sd	a3,0(a4)
    80001fe4:	6ef53c23          	sd	a5,1784(a0)
        for(size_t i = 0; i < numOfObjects - 1; i++)
    80001fe8:	00000793          	li	a5,0
    80001fec:	01200713          	li	a4,18
    80001ff0:	faf768e3          	bltu	a4,a5,80001fa0 <_ZN6Kernel16initializeKernelEv+0x20>
            pool[i].nextFree = &(pool[i+1]);
    80001ff4:	00178693          	addi	a3,a5,1
    80001ff8:	05800613          	li	a2,88
    80001ffc:	02c68733          	mul	a4,a3,a2
    80002000:	00e50733          	add	a4,a0,a4
    80002004:	02c787b3          	mul	a5,a5,a2
    80002008:	00f507b3          	add	a5,a0,a5
    8000200c:	04e7b823          	sd	a4,80(a5)
        for(size_t i = 0; i < numOfObjects - 1; i++)
    80002010:	00068793          	mv	a5,a3
    80002014:	fd9ff06f          	j	80001fec <_ZN6Kernel16initializeKernelEv+0x6c>
    Kernel::initializeKernelThreads();
    80002018:	00000097          	auipc	ra,0x0
    8000201c:	ee0080e7          	jalr	-288(ra) # 80001ef8 <_ZN6Kernel23initializeKernelThreadsEv>
}
    80002020:	00813083          	ld	ra,8(sp)
    80002024:	00013403          	ld	s0,0(sp)
    80002028:	01010113          	addi	sp,sp,16
    8000202c:	00008067          	ret

0000000080002030 <_ZN6Kernel15sysThreadCreateEPNS_21ArgumentsOfSystemCallE>:
{
    80002030:	fe010113          	addi	sp,sp,-32
    80002034:	00113c23          	sd	ra,24(sp)
    80002038:	00813823          	sd	s0,16(sp)
    8000203c:	00913423          	sd	s1,8(sp)
    80002040:	01213023          	sd	s2,0(sp)
    80002044:	02010413          	addi	s0,sp,32
    80002048:	00050493          	mv	s1,a0
    TCB* newThread = poolOfThreads->mallocObject();
    8000204c:	00004517          	auipc	a0,0x4
    80002050:	c0453503          	ld	a0,-1020(a0) # 80005c50 <_ZN6Kernel13poolOfThreadsE>
    80002054:	00000097          	auipc	ra,0x0
    80002058:	148080e7          	jalr	328(ra) # 8000219c <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEv>
    if(!newThread)
    8000205c:	04050c63          	beqz	a0,800020b4 <_ZN6Kernel15sysThreadCreateEPNS_21ArgumentsOfSystemCallE+0x84>
    80002060:	00050913          	mv	s2,a0
    __asm__ volatile("sd %[ptrThread], 0(%[handle])"::[ptrThread]"r"(newThread), [handle]"r"(arg->a0));
    80002064:	0004b783          	ld	a5,0(s1)
    80002068:	00a7b023          	sd	a0,0(a5)
    void* kernelSystemStack = Kernel::mallocSystemStack(KernelConfig::DEFAULT_SYSTEM_STACK_SIZE);
    8000206c:	40000513          	li	a0,1024
    80002070:	00000097          	auipc	ra,0x0
    80002074:	b54080e7          	jalr	-1196(ra) # 80001bc4 <_ZN6Kernel17mallocSystemStackEm>
    80002078:	00050713          	mv	a4,a0
    newThread->initializeThread((TCB::Body) arg->a1, (void*)arg->a2, (void*)arg->a3, kernelSystemStack);
    8000207c:	00000793          	li	a5,0
    80002080:	0184b683          	ld	a3,24(s1)
    80002084:	0104b603          	ld	a2,16(s1)
    80002088:	0084b583          	ld	a1,8(s1)
    8000208c:	00090513          	mv	a0,s2
    80002090:	fffff097          	auipc	ra,0xfffff
    80002094:	4a8080e7          	jalr	1192(ra) # 80001538 <_ZN3TCB16initializeThreadEPFvPvES0_S0_S0_N12KernelConfig4ModeE>
    return 0;
    80002098:	00000513          	li	a0,0
}
    8000209c:	01813083          	ld	ra,24(sp)
    800020a0:	01013403          	ld	s0,16(sp)
    800020a4:	00813483          	ld	s1,8(sp)
    800020a8:	00013903          	ld	s2,0(sp)
    800020ac:	02010113          	addi	sp,sp,32
    800020b0:	00008067          	ret
        return -1;
    800020b4:	fff00513          	li	a0,-1
    800020b8:	fe5ff06f          	j	8000209c <_ZN6Kernel15sysThreadCreateEPNS_21ArgumentsOfSystemCallE+0x6c>

00000000800020bc <_GLOBAL__sub_I__ZN6Kernel16systemCallsTableE>:
    800020bc:	ff010113          	addi	sp,sp,-16
    800020c0:	00113423          	sd	ra,8(sp)
    800020c4:	00813023          	sd	s0,0(sp)
    800020c8:	01010413          	addi	s0,sp,16
    800020cc:	000105b7          	lui	a1,0x10
    800020d0:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    800020d4:	00100513          	li	a0,1
    800020d8:	00000097          	auipc	ra,0x0
    800020dc:	ce4080e7          	jalr	-796(ra) # 80001dbc <_Z41__static_initialization_and_destruction_0ii>
    800020e0:	00813083          	ld	ra,8(sp)
    800020e4:	00013403          	ld	s0,0(sp)
    800020e8:	01010113          	addi	sp,sp,16
    800020ec:	00008067          	ret

00000000800020f0 <_ZN10ObjectPoolI3TCBLm20EEnwEm>:
template<typename T, size_t numOfObjects>
size_t ObjectPool<T, numOfObjects>::countOfPools = 0;


template<typename T, size_t numOfObjects>
void* ObjectPool<T, numOfObjects>::operator new(size_t size)
    800020f0:	ff010113          	addi	sp,sp,-16
    800020f4:	00113423          	sd	ra,8(sp)
    800020f8:	00813023          	sd	s0,0(sp)
    800020fc:	01010413          	addi	s0,sp,16
{
    size_t numOfBlocks = size / MEM_BLOCK_SIZE;
    80002100:	00655793          	srli	a5,a0,0x6
    numOfBlocks += size % MEM_BLOCK_SIZE ? 1 : 0;
    80002104:	03f57513          	andi	a0,a0,63
    80002108:	00050463          	beqz	a0,80002110 <_ZN10ObjectPoolI3TCBLm20EEnwEm+0x20>
    8000210c:	00100513          	li	a0,1
    return MemoryAllocator::allocateMemory(numOfBlocks);
    80002110:	00f50533          	add	a0,a0,a5
    80002114:	fffff097          	auipc	ra,0xfffff
    80002118:	6e0080e7          	jalr	1760(ra) # 800017f4 <_ZN15MemoryAllocator14allocateMemoryEm>
}
    8000211c:	00813083          	ld	ra,8(sp)
    80002120:	00013403          	ld	s0,0(sp)
    80002124:	01010113          	addi	sp,sp,16
    80002128:	00008067          	ret

000000008000212c <_ZN10ObjectPoolI3TCBLm20EE10freeObjectEPS0_>:
        return &(temp->object);
    }
}

template<typename T, size_t numOfObjects>
int ObjectPool<T, numOfObjects>::freeObject(T *obj) {
    8000212c:	ff010113          	addi	sp,sp,-16
    80002130:	00813423          	sd	s0,8(sp)
    80002134:	01010413          	addi	s0,sp,16

    ObjectPool<T, numOfObjects>* curr = this;
    for(; curr->nextObjectPool; curr = curr->nextObjectPool)
    80002138:	00050793          	mv	a5,a0
    8000213c:	6e853503          	ld	a0,1768(a0)
    80002140:	00050863          	beqz	a0,80002150 <_ZN10ObjectPoolI3TCBLm20EE10freeObjectEPS0_+0x24>
    {
        if(((uint64)curr->pool <= (uint64)obj) && ((uint64)obj <= (uint64)&(curr->pool[numOfObjects])))
    80002144:	fef5eae3          	bltu	a1,a5,80002138 <_ZN10ObjectPoolI3TCBLm20EE10freeObjectEPS0_+0xc>
    80002148:	6e078693          	addi	a3,a5,1760
    8000214c:	feb6e6e3          	bltu	a3,a1,80002138 <_ZN10ObjectPoolI3TCBLm20EE10freeObjectEPS0_+0xc>
        {
            break;
        }
    }
    PoolObject* tempObj = (PoolObject*)obj;
    tempObj->nextFree = curr->headFreeObject;
    80002150:	6e07b703          	ld	a4,1760(a5)
    80002154:	04e5b823          	sd	a4,80(a1)
    curr->headFreeObject = tempObj;
    80002158:	6eb7b023          	sd	a1,1760(a5)

    return 0;
}
    8000215c:	00000513          	li	a0,0
    80002160:	00813403          	ld	s0,8(sp)
    80002164:	01010113          	addi	sp,sp,16
    80002168:	00008067          	ret

000000008000216c <_ZN10ObjectPoolI3TCBLm20EE12findFreePoolEv>:
ObjectPool<T, numOfObjects>* ObjectPool<T, numOfObjects>::findFreePool(void)
    8000216c:	ff010113          	addi	sp,sp,-16
    80002170:	00813423          	sd	s0,8(sp)
    80002174:	01010413          	addi	s0,sp,16
    80002178:	00050793          	mv	a5,a0
    for(; !curr->nextObjectPool && !curr->headFreeObject; curr = curr->nextObjectPool);
    8000217c:	00078513          	mv	a0,a5
    80002180:	6e87b783          	ld	a5,1768(a5)
    80002184:	00079663          	bnez	a5,80002190 <_ZN10ObjectPoolI3TCBLm20EE12findFreePoolEv+0x24>
    80002188:	6e053703          	ld	a4,1760(a0)
    8000218c:	fe0708e3          	beqz	a4,8000217c <_ZN10ObjectPoolI3TCBLm20EE12findFreePoolEv+0x10>
}
    80002190:	00813403          	ld	s0,8(sp)
    80002194:	01010113          	addi	sp,sp,16
    80002198:	00008067          	ret

000000008000219c <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEv>:
T* ObjectPool<T, numOfObjects>::mallocObject(void)
    8000219c:	fe010113          	addi	sp,sp,-32
    800021a0:	00113c23          	sd	ra,24(sp)
    800021a4:	00813823          	sd	s0,16(sp)
    800021a8:	00913423          	sd	s1,8(sp)
    800021ac:	02010413          	addi	s0,sp,32
    ObjectPool<T,numOfObjects>* currentPool = findFreePool();
    800021b0:	00000097          	auipc	ra,0x0
    800021b4:	fbc080e7          	jalr	-68(ra) # 8000216c <_ZN10ObjectPoolI3TCBLm20EE12findFreePoolEv>
    800021b8:	00050493          	mv	s1,a0
    if (currentPool->headFreeObject)
    800021bc:	6e053503          	ld	a0,1760(a0)
    800021c0:	02050063          	beqz	a0,800021e0 <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEv+0x44>
        currentPool->headFreeObject = currentPool->headFreeObject->nextFree;
    800021c4:	05053783          	ld	a5,80(a0)
    800021c8:	6ef4b023          	sd	a5,1760(s1)
}
    800021cc:	01813083          	ld	ra,24(sp)
    800021d0:	01013403          	ld	s0,16(sp)
    800021d4:	00813483          	ld	s1,8(sp)
    800021d8:	02010113          	addi	sp,sp,32
    800021dc:	00008067          	ret
        ObjectPool<T, numOfObjects>* newPool = new ObjectPool();
    800021e0:	70000513          	li	a0,1792
    800021e4:	00000097          	auipc	ra,0x0
    800021e8:	f0c080e7          	jalr	-244(ra) # 800020f0 <_ZN10ObjectPoolI3TCBLm20EEnwEm>
    ObjectPool(): headFreeObject(pool), nextObjectPool(nullptr), prevObjectPool(nullptr), id(countOfPools++)
    800021ec:	6ea53023          	sd	a0,1760(a0)
    800021f0:	6e053423          	sd	zero,1768(a0)
    800021f4:	6e053823          	sd	zero,1776(a0)
    800021f8:	00004717          	auipc	a4,0x4
    800021fc:	a6070713          	addi	a4,a4,-1440 # 80005c58 <_ZN10ObjectPoolI3TCBLm20EE12countOfPoolsE>
    80002200:	00073783          	ld	a5,0(a4)
    80002204:	00178693          	addi	a3,a5,1
    80002208:	00d73023          	sd	a3,0(a4)
    8000220c:	6ef53c23          	sd	a5,1784(a0)
        for(size_t i = 0; i < numOfObjects - 1; i++)
    80002210:	00000793          	li	a5,0
    80002214:	01200713          	li	a4,18
    80002218:	02f76463          	bltu	a4,a5,80002240 <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEv+0xa4>
            pool[i].nextFree = &(pool[i+1]);
    8000221c:	00178693          	addi	a3,a5,1
    80002220:	05800613          	li	a2,88
    80002224:	02c68733          	mul	a4,a3,a2
    80002228:	00e50733          	add	a4,a0,a4
    8000222c:	02c787b3          	mul	a5,a5,a2
    80002230:	00f507b3          	add	a5,a0,a5
    80002234:	04e7b823          	sd	a4,80(a5)
        for(size_t i = 0; i < numOfObjects - 1; i++)
    80002238:	00068793          	mv	a5,a3
    8000223c:	fd9ff06f          	j	80002214 <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEv+0x78>
        pool[numOfObjects - 1].nextFree = nullptr;
    80002240:	6c053c23          	sd	zero,1752(a0)
        if(!newPool)
    80002244:	f80504e3          	beqz	a0,800021cc <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEv+0x30>
        newPool->prevObjectPool = currentPool;
    80002248:	6e953823          	sd	s1,1776(a0)
        currentPool->nextObjectPool = newPool;
    8000224c:	6ea4b423          	sd	a0,1768(s1)
        PoolObject* temp = newPool->headFreeObject;
    80002250:	6e053783          	ld	a5,1760(a0)
        newPool->headFreeObject = newPool->headFreeObject->nextFree;
    80002254:	0507b703          	ld	a4,80(a5)
    80002258:	6ee53023          	sd	a4,1760(a0)
        return &(temp->object);
    8000225c:	00078513          	mv	a0,a5
    80002260:	f6dff06f          	j	800021cc <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEv+0x30>

0000000080002264 <start>:
    80002264:	ff010113          	addi	sp,sp,-16
    80002268:	00813423          	sd	s0,8(sp)
    8000226c:	01010413          	addi	s0,sp,16
    80002270:	300027f3          	csrr	a5,mstatus
    80002274:	ffffe737          	lui	a4,0xffffe
    80002278:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff794f>
    8000227c:	00e7f7b3          	and	a5,a5,a4
    80002280:	00001737          	lui	a4,0x1
    80002284:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80002288:	00e7e7b3          	or	a5,a5,a4
    8000228c:	30079073          	csrw	mstatus,a5
    80002290:	00000797          	auipc	a5,0x0
    80002294:	16078793          	addi	a5,a5,352 # 800023f0 <system_main>
    80002298:	34179073          	csrw	mepc,a5
    8000229c:	00000793          	li	a5,0
    800022a0:	18079073          	csrw	satp,a5
    800022a4:	000107b7          	lui	a5,0x10
    800022a8:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    800022ac:	30279073          	csrw	medeleg,a5
    800022b0:	30379073          	csrw	mideleg,a5
    800022b4:	104027f3          	csrr	a5,sie
    800022b8:	2227e793          	ori	a5,a5,546
    800022bc:	10479073          	csrw	sie,a5
    800022c0:	fff00793          	li	a5,-1
    800022c4:	00a7d793          	srli	a5,a5,0xa
    800022c8:	3b079073          	csrw	pmpaddr0,a5
    800022cc:	00f00793          	li	a5,15
    800022d0:	3a079073          	csrw	pmpcfg0,a5
    800022d4:	f14027f3          	csrr	a5,mhartid
    800022d8:	0200c737          	lui	a4,0x200c
    800022dc:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800022e0:	0007869b          	sext.w	a3,a5
    800022e4:	00269713          	slli	a4,a3,0x2
    800022e8:	000f4637          	lui	a2,0xf4
    800022ec:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800022f0:	00d70733          	add	a4,a4,a3
    800022f4:	0037979b          	slliw	a5,a5,0x3
    800022f8:	020046b7          	lui	a3,0x2004
    800022fc:	00d787b3          	add	a5,a5,a3
    80002300:	00c585b3          	add	a1,a1,a2
    80002304:	00371693          	slli	a3,a4,0x3
    80002308:	00004717          	auipc	a4,0x4
    8000230c:	95870713          	addi	a4,a4,-1704 # 80005c60 <timer_scratch>
    80002310:	00b7b023          	sd	a1,0(a5)
    80002314:	00d70733          	add	a4,a4,a3
    80002318:	00f73c23          	sd	a5,24(a4)
    8000231c:	02c73023          	sd	a2,32(a4)
    80002320:	34071073          	csrw	mscratch,a4
    80002324:	00000797          	auipc	a5,0x0
    80002328:	6ec78793          	addi	a5,a5,1772 # 80002a10 <timervec>
    8000232c:	30579073          	csrw	mtvec,a5
    80002330:	300027f3          	csrr	a5,mstatus
    80002334:	0087e793          	ori	a5,a5,8
    80002338:	30079073          	csrw	mstatus,a5
    8000233c:	304027f3          	csrr	a5,mie
    80002340:	0807e793          	ori	a5,a5,128
    80002344:	30479073          	csrw	mie,a5
    80002348:	f14027f3          	csrr	a5,mhartid
    8000234c:	0007879b          	sext.w	a5,a5
    80002350:	00078213          	mv	tp,a5
    80002354:	30200073          	mret
    80002358:	00813403          	ld	s0,8(sp)
    8000235c:	01010113          	addi	sp,sp,16
    80002360:	00008067          	ret

0000000080002364 <timerinit>:
    80002364:	ff010113          	addi	sp,sp,-16
    80002368:	00813423          	sd	s0,8(sp)
    8000236c:	01010413          	addi	s0,sp,16
    80002370:	f14027f3          	csrr	a5,mhartid
    80002374:	0200c737          	lui	a4,0x200c
    80002378:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    8000237c:	0007869b          	sext.w	a3,a5
    80002380:	00269713          	slli	a4,a3,0x2
    80002384:	000f4637          	lui	a2,0xf4
    80002388:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    8000238c:	00d70733          	add	a4,a4,a3
    80002390:	0037979b          	slliw	a5,a5,0x3
    80002394:	020046b7          	lui	a3,0x2004
    80002398:	00d787b3          	add	a5,a5,a3
    8000239c:	00c585b3          	add	a1,a1,a2
    800023a0:	00371693          	slli	a3,a4,0x3
    800023a4:	00004717          	auipc	a4,0x4
    800023a8:	8bc70713          	addi	a4,a4,-1860 # 80005c60 <timer_scratch>
    800023ac:	00b7b023          	sd	a1,0(a5)
    800023b0:	00d70733          	add	a4,a4,a3
    800023b4:	00f73c23          	sd	a5,24(a4)
    800023b8:	02c73023          	sd	a2,32(a4)
    800023bc:	34071073          	csrw	mscratch,a4
    800023c0:	00000797          	auipc	a5,0x0
    800023c4:	65078793          	addi	a5,a5,1616 # 80002a10 <timervec>
    800023c8:	30579073          	csrw	mtvec,a5
    800023cc:	300027f3          	csrr	a5,mstatus
    800023d0:	0087e793          	ori	a5,a5,8
    800023d4:	30079073          	csrw	mstatus,a5
    800023d8:	304027f3          	csrr	a5,mie
    800023dc:	0807e793          	ori	a5,a5,128
    800023e0:	30479073          	csrw	mie,a5
    800023e4:	00813403          	ld	s0,8(sp)
    800023e8:	01010113          	addi	sp,sp,16
    800023ec:	00008067          	ret

00000000800023f0 <system_main>:
    800023f0:	fe010113          	addi	sp,sp,-32
    800023f4:	00813823          	sd	s0,16(sp)
    800023f8:	00913423          	sd	s1,8(sp)
    800023fc:	00113c23          	sd	ra,24(sp)
    80002400:	02010413          	addi	s0,sp,32
    80002404:	00000097          	auipc	ra,0x0
    80002408:	0c4080e7          	jalr	196(ra) # 800024c8 <cpuid>
    8000240c:	00003497          	auipc	s1,0x3
    80002410:	5c448493          	addi	s1,s1,1476 # 800059d0 <started>
    80002414:	02050263          	beqz	a0,80002438 <system_main+0x48>
    80002418:	0004a783          	lw	a5,0(s1)
    8000241c:	0007879b          	sext.w	a5,a5
    80002420:	fe078ce3          	beqz	a5,80002418 <system_main+0x28>
    80002424:	0ff0000f          	fence
    80002428:	00003517          	auipc	a0,0x3
    8000242c:	c2850513          	addi	a0,a0,-984 # 80005050 <CONSOLE_STATUS+0x40>
    80002430:	00001097          	auipc	ra,0x1
    80002434:	a7c080e7          	jalr	-1412(ra) # 80002eac <panic>
    80002438:	00001097          	auipc	ra,0x1
    8000243c:	9d0080e7          	jalr	-1584(ra) # 80002e08 <consoleinit>
    80002440:	00001097          	auipc	ra,0x1
    80002444:	15c080e7          	jalr	348(ra) # 8000359c <printfinit>
    80002448:	00003517          	auipc	a0,0x3
    8000244c:	ce850513          	addi	a0,a0,-792 # 80005130 <CONSOLE_STATUS+0x120>
    80002450:	00001097          	auipc	ra,0x1
    80002454:	ab8080e7          	jalr	-1352(ra) # 80002f08 <__printf>
    80002458:	00003517          	auipc	a0,0x3
    8000245c:	bc850513          	addi	a0,a0,-1080 # 80005020 <CONSOLE_STATUS+0x10>
    80002460:	00001097          	auipc	ra,0x1
    80002464:	aa8080e7          	jalr	-1368(ra) # 80002f08 <__printf>
    80002468:	00003517          	auipc	a0,0x3
    8000246c:	cc850513          	addi	a0,a0,-824 # 80005130 <CONSOLE_STATUS+0x120>
    80002470:	00001097          	auipc	ra,0x1
    80002474:	a98080e7          	jalr	-1384(ra) # 80002f08 <__printf>
    80002478:	00001097          	auipc	ra,0x1
    8000247c:	4b0080e7          	jalr	1200(ra) # 80003928 <kinit>
    80002480:	00000097          	auipc	ra,0x0
    80002484:	148080e7          	jalr	328(ra) # 800025c8 <trapinit>
    80002488:	00000097          	auipc	ra,0x0
    8000248c:	16c080e7          	jalr	364(ra) # 800025f4 <trapinithart>
    80002490:	00000097          	auipc	ra,0x0
    80002494:	5c0080e7          	jalr	1472(ra) # 80002a50 <plicinit>
    80002498:	00000097          	auipc	ra,0x0
    8000249c:	5e0080e7          	jalr	1504(ra) # 80002a78 <plicinithart>
    800024a0:	00000097          	auipc	ra,0x0
    800024a4:	078080e7          	jalr	120(ra) # 80002518 <userinit>
    800024a8:	0ff0000f          	fence
    800024ac:	00100793          	li	a5,1
    800024b0:	00003517          	auipc	a0,0x3
    800024b4:	b8850513          	addi	a0,a0,-1144 # 80005038 <CONSOLE_STATUS+0x28>
    800024b8:	00f4a023          	sw	a5,0(s1)
    800024bc:	00001097          	auipc	ra,0x1
    800024c0:	a4c080e7          	jalr	-1460(ra) # 80002f08 <__printf>
    800024c4:	0000006f          	j	800024c4 <system_main+0xd4>

00000000800024c8 <cpuid>:
    800024c8:	ff010113          	addi	sp,sp,-16
    800024cc:	00813423          	sd	s0,8(sp)
    800024d0:	01010413          	addi	s0,sp,16
    800024d4:	00020513          	mv	a0,tp
    800024d8:	00813403          	ld	s0,8(sp)
    800024dc:	0005051b          	sext.w	a0,a0
    800024e0:	01010113          	addi	sp,sp,16
    800024e4:	00008067          	ret

00000000800024e8 <mycpu>:
    800024e8:	ff010113          	addi	sp,sp,-16
    800024ec:	00813423          	sd	s0,8(sp)
    800024f0:	01010413          	addi	s0,sp,16
    800024f4:	00020793          	mv	a5,tp
    800024f8:	00813403          	ld	s0,8(sp)
    800024fc:	0007879b          	sext.w	a5,a5
    80002500:	00779793          	slli	a5,a5,0x7
    80002504:	00004517          	auipc	a0,0x4
    80002508:	78c50513          	addi	a0,a0,1932 # 80006c90 <cpus>
    8000250c:	00f50533          	add	a0,a0,a5
    80002510:	01010113          	addi	sp,sp,16
    80002514:	00008067          	ret

0000000080002518 <userinit>:
    80002518:	ff010113          	addi	sp,sp,-16
    8000251c:	00813423          	sd	s0,8(sp)
    80002520:	01010413          	addi	s0,sp,16
    80002524:	00813403          	ld	s0,8(sp)
    80002528:	01010113          	addi	sp,sp,16
    8000252c:	fffff317          	auipc	t1,0xfffff
    80002530:	fb830067          	jr	-72(t1) # 800014e4 <main>

0000000080002534 <either_copyout>:
    80002534:	ff010113          	addi	sp,sp,-16
    80002538:	00813023          	sd	s0,0(sp)
    8000253c:	00113423          	sd	ra,8(sp)
    80002540:	01010413          	addi	s0,sp,16
    80002544:	02051663          	bnez	a0,80002570 <either_copyout+0x3c>
    80002548:	00058513          	mv	a0,a1
    8000254c:	00060593          	mv	a1,a2
    80002550:	0006861b          	sext.w	a2,a3
    80002554:	00002097          	auipc	ra,0x2
    80002558:	c60080e7          	jalr	-928(ra) # 800041b4 <__memmove>
    8000255c:	00813083          	ld	ra,8(sp)
    80002560:	00013403          	ld	s0,0(sp)
    80002564:	00000513          	li	a0,0
    80002568:	01010113          	addi	sp,sp,16
    8000256c:	00008067          	ret
    80002570:	00003517          	auipc	a0,0x3
    80002574:	b0850513          	addi	a0,a0,-1272 # 80005078 <CONSOLE_STATUS+0x68>
    80002578:	00001097          	auipc	ra,0x1
    8000257c:	934080e7          	jalr	-1740(ra) # 80002eac <panic>

0000000080002580 <either_copyin>:
    80002580:	ff010113          	addi	sp,sp,-16
    80002584:	00813023          	sd	s0,0(sp)
    80002588:	00113423          	sd	ra,8(sp)
    8000258c:	01010413          	addi	s0,sp,16
    80002590:	02059463          	bnez	a1,800025b8 <either_copyin+0x38>
    80002594:	00060593          	mv	a1,a2
    80002598:	0006861b          	sext.w	a2,a3
    8000259c:	00002097          	auipc	ra,0x2
    800025a0:	c18080e7          	jalr	-1000(ra) # 800041b4 <__memmove>
    800025a4:	00813083          	ld	ra,8(sp)
    800025a8:	00013403          	ld	s0,0(sp)
    800025ac:	00000513          	li	a0,0
    800025b0:	01010113          	addi	sp,sp,16
    800025b4:	00008067          	ret
    800025b8:	00003517          	auipc	a0,0x3
    800025bc:	ae850513          	addi	a0,a0,-1304 # 800050a0 <CONSOLE_STATUS+0x90>
    800025c0:	00001097          	auipc	ra,0x1
    800025c4:	8ec080e7          	jalr	-1812(ra) # 80002eac <panic>

00000000800025c8 <trapinit>:
    800025c8:	ff010113          	addi	sp,sp,-16
    800025cc:	00813423          	sd	s0,8(sp)
    800025d0:	01010413          	addi	s0,sp,16
    800025d4:	00813403          	ld	s0,8(sp)
    800025d8:	00003597          	auipc	a1,0x3
    800025dc:	af058593          	addi	a1,a1,-1296 # 800050c8 <CONSOLE_STATUS+0xb8>
    800025e0:	00004517          	auipc	a0,0x4
    800025e4:	73050513          	addi	a0,a0,1840 # 80006d10 <tickslock>
    800025e8:	01010113          	addi	sp,sp,16
    800025ec:	00001317          	auipc	t1,0x1
    800025f0:	5cc30067          	jr	1484(t1) # 80003bb8 <initlock>

00000000800025f4 <trapinithart>:
    800025f4:	ff010113          	addi	sp,sp,-16
    800025f8:	00813423          	sd	s0,8(sp)
    800025fc:	01010413          	addi	s0,sp,16
    80002600:	00000797          	auipc	a5,0x0
    80002604:	30078793          	addi	a5,a5,768 # 80002900 <kernelvec>
    80002608:	10579073          	csrw	stvec,a5
    8000260c:	00813403          	ld	s0,8(sp)
    80002610:	01010113          	addi	sp,sp,16
    80002614:	00008067          	ret

0000000080002618 <usertrap>:
    80002618:	ff010113          	addi	sp,sp,-16
    8000261c:	00813423          	sd	s0,8(sp)
    80002620:	01010413          	addi	s0,sp,16
    80002624:	00813403          	ld	s0,8(sp)
    80002628:	01010113          	addi	sp,sp,16
    8000262c:	00008067          	ret

0000000080002630 <usertrapret>:
    80002630:	ff010113          	addi	sp,sp,-16
    80002634:	00813423          	sd	s0,8(sp)
    80002638:	01010413          	addi	s0,sp,16
    8000263c:	00813403          	ld	s0,8(sp)
    80002640:	01010113          	addi	sp,sp,16
    80002644:	00008067          	ret

0000000080002648 <kerneltrap>:
    80002648:	fe010113          	addi	sp,sp,-32
    8000264c:	00813823          	sd	s0,16(sp)
    80002650:	00113c23          	sd	ra,24(sp)
    80002654:	00913423          	sd	s1,8(sp)
    80002658:	02010413          	addi	s0,sp,32
    8000265c:	142025f3          	csrr	a1,scause
    80002660:	100027f3          	csrr	a5,sstatus
    80002664:	0027f793          	andi	a5,a5,2
    80002668:	10079c63          	bnez	a5,80002780 <kerneltrap+0x138>
    8000266c:	142027f3          	csrr	a5,scause
    80002670:	0207ce63          	bltz	a5,800026ac <kerneltrap+0x64>
    80002674:	00003517          	auipc	a0,0x3
    80002678:	a9c50513          	addi	a0,a0,-1380 # 80005110 <CONSOLE_STATUS+0x100>
    8000267c:	00001097          	auipc	ra,0x1
    80002680:	88c080e7          	jalr	-1908(ra) # 80002f08 <__printf>
    80002684:	141025f3          	csrr	a1,sepc
    80002688:	14302673          	csrr	a2,stval
    8000268c:	00003517          	auipc	a0,0x3
    80002690:	a9450513          	addi	a0,a0,-1388 # 80005120 <CONSOLE_STATUS+0x110>
    80002694:	00001097          	auipc	ra,0x1
    80002698:	874080e7          	jalr	-1932(ra) # 80002f08 <__printf>
    8000269c:	00003517          	auipc	a0,0x3
    800026a0:	a9c50513          	addi	a0,a0,-1380 # 80005138 <CONSOLE_STATUS+0x128>
    800026a4:	00001097          	auipc	ra,0x1
    800026a8:	808080e7          	jalr	-2040(ra) # 80002eac <panic>
    800026ac:	0ff7f713          	andi	a4,a5,255
    800026b0:	00900693          	li	a3,9
    800026b4:	04d70063          	beq	a4,a3,800026f4 <kerneltrap+0xac>
    800026b8:	fff00713          	li	a4,-1
    800026bc:	03f71713          	slli	a4,a4,0x3f
    800026c0:	00170713          	addi	a4,a4,1
    800026c4:	fae798e3          	bne	a5,a4,80002674 <kerneltrap+0x2c>
    800026c8:	00000097          	auipc	ra,0x0
    800026cc:	e00080e7          	jalr	-512(ra) # 800024c8 <cpuid>
    800026d0:	06050663          	beqz	a0,8000273c <kerneltrap+0xf4>
    800026d4:	144027f3          	csrr	a5,sip
    800026d8:	ffd7f793          	andi	a5,a5,-3
    800026dc:	14479073          	csrw	sip,a5
    800026e0:	01813083          	ld	ra,24(sp)
    800026e4:	01013403          	ld	s0,16(sp)
    800026e8:	00813483          	ld	s1,8(sp)
    800026ec:	02010113          	addi	sp,sp,32
    800026f0:	00008067          	ret
    800026f4:	00000097          	auipc	ra,0x0
    800026f8:	3d0080e7          	jalr	976(ra) # 80002ac4 <plic_claim>
    800026fc:	00a00793          	li	a5,10
    80002700:	00050493          	mv	s1,a0
    80002704:	06f50863          	beq	a0,a5,80002774 <kerneltrap+0x12c>
    80002708:	fc050ce3          	beqz	a0,800026e0 <kerneltrap+0x98>
    8000270c:	00050593          	mv	a1,a0
    80002710:	00003517          	auipc	a0,0x3
    80002714:	9e050513          	addi	a0,a0,-1568 # 800050f0 <CONSOLE_STATUS+0xe0>
    80002718:	00000097          	auipc	ra,0x0
    8000271c:	7f0080e7          	jalr	2032(ra) # 80002f08 <__printf>
    80002720:	01013403          	ld	s0,16(sp)
    80002724:	01813083          	ld	ra,24(sp)
    80002728:	00048513          	mv	a0,s1
    8000272c:	00813483          	ld	s1,8(sp)
    80002730:	02010113          	addi	sp,sp,32
    80002734:	00000317          	auipc	t1,0x0
    80002738:	3c830067          	jr	968(t1) # 80002afc <plic_complete>
    8000273c:	00004517          	auipc	a0,0x4
    80002740:	5d450513          	addi	a0,a0,1492 # 80006d10 <tickslock>
    80002744:	00001097          	auipc	ra,0x1
    80002748:	498080e7          	jalr	1176(ra) # 80003bdc <acquire>
    8000274c:	00003717          	auipc	a4,0x3
    80002750:	28870713          	addi	a4,a4,648 # 800059d4 <ticks>
    80002754:	00072783          	lw	a5,0(a4)
    80002758:	00004517          	auipc	a0,0x4
    8000275c:	5b850513          	addi	a0,a0,1464 # 80006d10 <tickslock>
    80002760:	0017879b          	addiw	a5,a5,1
    80002764:	00f72023          	sw	a5,0(a4)
    80002768:	00001097          	auipc	ra,0x1
    8000276c:	540080e7          	jalr	1344(ra) # 80003ca8 <release>
    80002770:	f65ff06f          	j	800026d4 <kerneltrap+0x8c>
    80002774:	00001097          	auipc	ra,0x1
    80002778:	09c080e7          	jalr	156(ra) # 80003810 <uartintr>
    8000277c:	fa5ff06f          	j	80002720 <kerneltrap+0xd8>
    80002780:	00003517          	auipc	a0,0x3
    80002784:	95050513          	addi	a0,a0,-1712 # 800050d0 <CONSOLE_STATUS+0xc0>
    80002788:	00000097          	auipc	ra,0x0
    8000278c:	724080e7          	jalr	1828(ra) # 80002eac <panic>

0000000080002790 <clockintr>:
    80002790:	fe010113          	addi	sp,sp,-32
    80002794:	00813823          	sd	s0,16(sp)
    80002798:	00913423          	sd	s1,8(sp)
    8000279c:	00113c23          	sd	ra,24(sp)
    800027a0:	02010413          	addi	s0,sp,32
    800027a4:	00004497          	auipc	s1,0x4
    800027a8:	56c48493          	addi	s1,s1,1388 # 80006d10 <tickslock>
    800027ac:	00048513          	mv	a0,s1
    800027b0:	00001097          	auipc	ra,0x1
    800027b4:	42c080e7          	jalr	1068(ra) # 80003bdc <acquire>
    800027b8:	00003717          	auipc	a4,0x3
    800027bc:	21c70713          	addi	a4,a4,540 # 800059d4 <ticks>
    800027c0:	00072783          	lw	a5,0(a4)
    800027c4:	01013403          	ld	s0,16(sp)
    800027c8:	01813083          	ld	ra,24(sp)
    800027cc:	00048513          	mv	a0,s1
    800027d0:	0017879b          	addiw	a5,a5,1
    800027d4:	00813483          	ld	s1,8(sp)
    800027d8:	00f72023          	sw	a5,0(a4)
    800027dc:	02010113          	addi	sp,sp,32
    800027e0:	00001317          	auipc	t1,0x1
    800027e4:	4c830067          	jr	1224(t1) # 80003ca8 <release>

00000000800027e8 <devintr>:
    800027e8:	142027f3          	csrr	a5,scause
    800027ec:	00000513          	li	a0,0
    800027f0:	0007c463          	bltz	a5,800027f8 <devintr+0x10>
    800027f4:	00008067          	ret
    800027f8:	fe010113          	addi	sp,sp,-32
    800027fc:	00813823          	sd	s0,16(sp)
    80002800:	00113c23          	sd	ra,24(sp)
    80002804:	00913423          	sd	s1,8(sp)
    80002808:	02010413          	addi	s0,sp,32
    8000280c:	0ff7f713          	andi	a4,a5,255
    80002810:	00900693          	li	a3,9
    80002814:	04d70c63          	beq	a4,a3,8000286c <devintr+0x84>
    80002818:	fff00713          	li	a4,-1
    8000281c:	03f71713          	slli	a4,a4,0x3f
    80002820:	00170713          	addi	a4,a4,1
    80002824:	00e78c63          	beq	a5,a4,8000283c <devintr+0x54>
    80002828:	01813083          	ld	ra,24(sp)
    8000282c:	01013403          	ld	s0,16(sp)
    80002830:	00813483          	ld	s1,8(sp)
    80002834:	02010113          	addi	sp,sp,32
    80002838:	00008067          	ret
    8000283c:	00000097          	auipc	ra,0x0
    80002840:	c8c080e7          	jalr	-884(ra) # 800024c8 <cpuid>
    80002844:	06050663          	beqz	a0,800028b0 <devintr+0xc8>
    80002848:	144027f3          	csrr	a5,sip
    8000284c:	ffd7f793          	andi	a5,a5,-3
    80002850:	14479073          	csrw	sip,a5
    80002854:	01813083          	ld	ra,24(sp)
    80002858:	01013403          	ld	s0,16(sp)
    8000285c:	00813483          	ld	s1,8(sp)
    80002860:	00200513          	li	a0,2
    80002864:	02010113          	addi	sp,sp,32
    80002868:	00008067          	ret
    8000286c:	00000097          	auipc	ra,0x0
    80002870:	258080e7          	jalr	600(ra) # 80002ac4 <plic_claim>
    80002874:	00a00793          	li	a5,10
    80002878:	00050493          	mv	s1,a0
    8000287c:	06f50663          	beq	a0,a5,800028e8 <devintr+0x100>
    80002880:	00100513          	li	a0,1
    80002884:	fa0482e3          	beqz	s1,80002828 <devintr+0x40>
    80002888:	00048593          	mv	a1,s1
    8000288c:	00003517          	auipc	a0,0x3
    80002890:	86450513          	addi	a0,a0,-1948 # 800050f0 <CONSOLE_STATUS+0xe0>
    80002894:	00000097          	auipc	ra,0x0
    80002898:	674080e7          	jalr	1652(ra) # 80002f08 <__printf>
    8000289c:	00048513          	mv	a0,s1
    800028a0:	00000097          	auipc	ra,0x0
    800028a4:	25c080e7          	jalr	604(ra) # 80002afc <plic_complete>
    800028a8:	00100513          	li	a0,1
    800028ac:	f7dff06f          	j	80002828 <devintr+0x40>
    800028b0:	00004517          	auipc	a0,0x4
    800028b4:	46050513          	addi	a0,a0,1120 # 80006d10 <tickslock>
    800028b8:	00001097          	auipc	ra,0x1
    800028bc:	324080e7          	jalr	804(ra) # 80003bdc <acquire>
    800028c0:	00003717          	auipc	a4,0x3
    800028c4:	11470713          	addi	a4,a4,276 # 800059d4 <ticks>
    800028c8:	00072783          	lw	a5,0(a4)
    800028cc:	00004517          	auipc	a0,0x4
    800028d0:	44450513          	addi	a0,a0,1092 # 80006d10 <tickslock>
    800028d4:	0017879b          	addiw	a5,a5,1
    800028d8:	00f72023          	sw	a5,0(a4)
    800028dc:	00001097          	auipc	ra,0x1
    800028e0:	3cc080e7          	jalr	972(ra) # 80003ca8 <release>
    800028e4:	f65ff06f          	j	80002848 <devintr+0x60>
    800028e8:	00001097          	auipc	ra,0x1
    800028ec:	f28080e7          	jalr	-216(ra) # 80003810 <uartintr>
    800028f0:	fadff06f          	j	8000289c <devintr+0xb4>
	...

0000000080002900 <kernelvec>:
    80002900:	f0010113          	addi	sp,sp,-256
    80002904:	00113023          	sd	ra,0(sp)
    80002908:	00213423          	sd	sp,8(sp)
    8000290c:	00313823          	sd	gp,16(sp)
    80002910:	00413c23          	sd	tp,24(sp)
    80002914:	02513023          	sd	t0,32(sp)
    80002918:	02613423          	sd	t1,40(sp)
    8000291c:	02713823          	sd	t2,48(sp)
    80002920:	02813c23          	sd	s0,56(sp)
    80002924:	04913023          	sd	s1,64(sp)
    80002928:	04a13423          	sd	a0,72(sp)
    8000292c:	04b13823          	sd	a1,80(sp)
    80002930:	04c13c23          	sd	a2,88(sp)
    80002934:	06d13023          	sd	a3,96(sp)
    80002938:	06e13423          	sd	a4,104(sp)
    8000293c:	06f13823          	sd	a5,112(sp)
    80002940:	07013c23          	sd	a6,120(sp)
    80002944:	09113023          	sd	a7,128(sp)
    80002948:	09213423          	sd	s2,136(sp)
    8000294c:	09313823          	sd	s3,144(sp)
    80002950:	09413c23          	sd	s4,152(sp)
    80002954:	0b513023          	sd	s5,160(sp)
    80002958:	0b613423          	sd	s6,168(sp)
    8000295c:	0b713823          	sd	s7,176(sp)
    80002960:	0b813c23          	sd	s8,184(sp)
    80002964:	0d913023          	sd	s9,192(sp)
    80002968:	0da13423          	sd	s10,200(sp)
    8000296c:	0db13823          	sd	s11,208(sp)
    80002970:	0dc13c23          	sd	t3,216(sp)
    80002974:	0fd13023          	sd	t4,224(sp)
    80002978:	0fe13423          	sd	t5,232(sp)
    8000297c:	0ff13823          	sd	t6,240(sp)
    80002980:	cc9ff0ef          	jal	ra,80002648 <kerneltrap>
    80002984:	00013083          	ld	ra,0(sp)
    80002988:	00813103          	ld	sp,8(sp)
    8000298c:	01013183          	ld	gp,16(sp)
    80002990:	02013283          	ld	t0,32(sp)
    80002994:	02813303          	ld	t1,40(sp)
    80002998:	03013383          	ld	t2,48(sp)
    8000299c:	03813403          	ld	s0,56(sp)
    800029a0:	04013483          	ld	s1,64(sp)
    800029a4:	04813503          	ld	a0,72(sp)
    800029a8:	05013583          	ld	a1,80(sp)
    800029ac:	05813603          	ld	a2,88(sp)
    800029b0:	06013683          	ld	a3,96(sp)
    800029b4:	06813703          	ld	a4,104(sp)
    800029b8:	07013783          	ld	a5,112(sp)
    800029bc:	07813803          	ld	a6,120(sp)
    800029c0:	08013883          	ld	a7,128(sp)
    800029c4:	08813903          	ld	s2,136(sp)
    800029c8:	09013983          	ld	s3,144(sp)
    800029cc:	09813a03          	ld	s4,152(sp)
    800029d0:	0a013a83          	ld	s5,160(sp)
    800029d4:	0a813b03          	ld	s6,168(sp)
    800029d8:	0b013b83          	ld	s7,176(sp)
    800029dc:	0b813c03          	ld	s8,184(sp)
    800029e0:	0c013c83          	ld	s9,192(sp)
    800029e4:	0c813d03          	ld	s10,200(sp)
    800029e8:	0d013d83          	ld	s11,208(sp)
    800029ec:	0d813e03          	ld	t3,216(sp)
    800029f0:	0e013e83          	ld	t4,224(sp)
    800029f4:	0e813f03          	ld	t5,232(sp)
    800029f8:	0f013f83          	ld	t6,240(sp)
    800029fc:	10010113          	addi	sp,sp,256
    80002a00:	10200073          	sret
    80002a04:	00000013          	nop
    80002a08:	00000013          	nop
    80002a0c:	00000013          	nop

0000000080002a10 <timervec>:
    80002a10:	34051573          	csrrw	a0,mscratch,a0
    80002a14:	00b53023          	sd	a1,0(a0)
    80002a18:	00c53423          	sd	a2,8(a0)
    80002a1c:	00d53823          	sd	a3,16(a0)
    80002a20:	01853583          	ld	a1,24(a0)
    80002a24:	02053603          	ld	a2,32(a0)
    80002a28:	0005b683          	ld	a3,0(a1)
    80002a2c:	00c686b3          	add	a3,a3,a2
    80002a30:	00d5b023          	sd	a3,0(a1)
    80002a34:	00200593          	li	a1,2
    80002a38:	14459073          	csrw	sip,a1
    80002a3c:	01053683          	ld	a3,16(a0)
    80002a40:	00853603          	ld	a2,8(a0)
    80002a44:	00053583          	ld	a1,0(a0)
    80002a48:	34051573          	csrrw	a0,mscratch,a0
    80002a4c:	30200073          	mret

0000000080002a50 <plicinit>:
    80002a50:	ff010113          	addi	sp,sp,-16
    80002a54:	00813423          	sd	s0,8(sp)
    80002a58:	01010413          	addi	s0,sp,16
    80002a5c:	00813403          	ld	s0,8(sp)
    80002a60:	0c0007b7          	lui	a5,0xc000
    80002a64:	00100713          	li	a4,1
    80002a68:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    80002a6c:	00e7a223          	sw	a4,4(a5)
    80002a70:	01010113          	addi	sp,sp,16
    80002a74:	00008067          	ret

0000000080002a78 <plicinithart>:
    80002a78:	ff010113          	addi	sp,sp,-16
    80002a7c:	00813023          	sd	s0,0(sp)
    80002a80:	00113423          	sd	ra,8(sp)
    80002a84:	01010413          	addi	s0,sp,16
    80002a88:	00000097          	auipc	ra,0x0
    80002a8c:	a40080e7          	jalr	-1472(ra) # 800024c8 <cpuid>
    80002a90:	0085171b          	slliw	a4,a0,0x8
    80002a94:	0c0027b7          	lui	a5,0xc002
    80002a98:	00e787b3          	add	a5,a5,a4
    80002a9c:	40200713          	li	a4,1026
    80002aa0:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80002aa4:	00813083          	ld	ra,8(sp)
    80002aa8:	00013403          	ld	s0,0(sp)
    80002aac:	00d5151b          	slliw	a0,a0,0xd
    80002ab0:	0c2017b7          	lui	a5,0xc201
    80002ab4:	00a78533          	add	a0,a5,a0
    80002ab8:	00052023          	sw	zero,0(a0)
    80002abc:	01010113          	addi	sp,sp,16
    80002ac0:	00008067          	ret

0000000080002ac4 <plic_claim>:
    80002ac4:	ff010113          	addi	sp,sp,-16
    80002ac8:	00813023          	sd	s0,0(sp)
    80002acc:	00113423          	sd	ra,8(sp)
    80002ad0:	01010413          	addi	s0,sp,16
    80002ad4:	00000097          	auipc	ra,0x0
    80002ad8:	9f4080e7          	jalr	-1548(ra) # 800024c8 <cpuid>
    80002adc:	00813083          	ld	ra,8(sp)
    80002ae0:	00013403          	ld	s0,0(sp)
    80002ae4:	00d5151b          	slliw	a0,a0,0xd
    80002ae8:	0c2017b7          	lui	a5,0xc201
    80002aec:	00a78533          	add	a0,a5,a0
    80002af0:	00452503          	lw	a0,4(a0)
    80002af4:	01010113          	addi	sp,sp,16
    80002af8:	00008067          	ret

0000000080002afc <plic_complete>:
    80002afc:	fe010113          	addi	sp,sp,-32
    80002b00:	00813823          	sd	s0,16(sp)
    80002b04:	00913423          	sd	s1,8(sp)
    80002b08:	00113c23          	sd	ra,24(sp)
    80002b0c:	02010413          	addi	s0,sp,32
    80002b10:	00050493          	mv	s1,a0
    80002b14:	00000097          	auipc	ra,0x0
    80002b18:	9b4080e7          	jalr	-1612(ra) # 800024c8 <cpuid>
    80002b1c:	01813083          	ld	ra,24(sp)
    80002b20:	01013403          	ld	s0,16(sp)
    80002b24:	00d5179b          	slliw	a5,a0,0xd
    80002b28:	0c201737          	lui	a4,0xc201
    80002b2c:	00f707b3          	add	a5,a4,a5
    80002b30:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80002b34:	00813483          	ld	s1,8(sp)
    80002b38:	02010113          	addi	sp,sp,32
    80002b3c:	00008067          	ret

0000000080002b40 <consolewrite>:
    80002b40:	fb010113          	addi	sp,sp,-80
    80002b44:	04813023          	sd	s0,64(sp)
    80002b48:	04113423          	sd	ra,72(sp)
    80002b4c:	02913c23          	sd	s1,56(sp)
    80002b50:	03213823          	sd	s2,48(sp)
    80002b54:	03313423          	sd	s3,40(sp)
    80002b58:	03413023          	sd	s4,32(sp)
    80002b5c:	01513c23          	sd	s5,24(sp)
    80002b60:	05010413          	addi	s0,sp,80
    80002b64:	06c05c63          	blez	a2,80002bdc <consolewrite+0x9c>
    80002b68:	00060993          	mv	s3,a2
    80002b6c:	00050a13          	mv	s4,a0
    80002b70:	00058493          	mv	s1,a1
    80002b74:	00000913          	li	s2,0
    80002b78:	fff00a93          	li	s5,-1
    80002b7c:	01c0006f          	j	80002b98 <consolewrite+0x58>
    80002b80:	fbf44503          	lbu	a0,-65(s0)
    80002b84:	0019091b          	addiw	s2,s2,1
    80002b88:	00148493          	addi	s1,s1,1
    80002b8c:	00001097          	auipc	ra,0x1
    80002b90:	a9c080e7          	jalr	-1380(ra) # 80003628 <uartputc>
    80002b94:	03298063          	beq	s3,s2,80002bb4 <consolewrite+0x74>
    80002b98:	00048613          	mv	a2,s1
    80002b9c:	00100693          	li	a3,1
    80002ba0:	000a0593          	mv	a1,s4
    80002ba4:	fbf40513          	addi	a0,s0,-65
    80002ba8:	00000097          	auipc	ra,0x0
    80002bac:	9d8080e7          	jalr	-1576(ra) # 80002580 <either_copyin>
    80002bb0:	fd5518e3          	bne	a0,s5,80002b80 <consolewrite+0x40>
    80002bb4:	04813083          	ld	ra,72(sp)
    80002bb8:	04013403          	ld	s0,64(sp)
    80002bbc:	03813483          	ld	s1,56(sp)
    80002bc0:	02813983          	ld	s3,40(sp)
    80002bc4:	02013a03          	ld	s4,32(sp)
    80002bc8:	01813a83          	ld	s5,24(sp)
    80002bcc:	00090513          	mv	a0,s2
    80002bd0:	03013903          	ld	s2,48(sp)
    80002bd4:	05010113          	addi	sp,sp,80
    80002bd8:	00008067          	ret
    80002bdc:	00000913          	li	s2,0
    80002be0:	fd5ff06f          	j	80002bb4 <consolewrite+0x74>

0000000080002be4 <consoleread>:
    80002be4:	f9010113          	addi	sp,sp,-112
    80002be8:	06813023          	sd	s0,96(sp)
    80002bec:	04913c23          	sd	s1,88(sp)
    80002bf0:	05213823          	sd	s2,80(sp)
    80002bf4:	05313423          	sd	s3,72(sp)
    80002bf8:	05413023          	sd	s4,64(sp)
    80002bfc:	03513c23          	sd	s5,56(sp)
    80002c00:	03613823          	sd	s6,48(sp)
    80002c04:	03713423          	sd	s7,40(sp)
    80002c08:	03813023          	sd	s8,32(sp)
    80002c0c:	06113423          	sd	ra,104(sp)
    80002c10:	01913c23          	sd	s9,24(sp)
    80002c14:	07010413          	addi	s0,sp,112
    80002c18:	00060b93          	mv	s7,a2
    80002c1c:	00050913          	mv	s2,a0
    80002c20:	00058c13          	mv	s8,a1
    80002c24:	00060b1b          	sext.w	s6,a2
    80002c28:	00004497          	auipc	s1,0x4
    80002c2c:	10048493          	addi	s1,s1,256 # 80006d28 <cons>
    80002c30:	00400993          	li	s3,4
    80002c34:	fff00a13          	li	s4,-1
    80002c38:	00a00a93          	li	s5,10
    80002c3c:	05705e63          	blez	s7,80002c98 <consoleread+0xb4>
    80002c40:	09c4a703          	lw	a4,156(s1)
    80002c44:	0984a783          	lw	a5,152(s1)
    80002c48:	0007071b          	sext.w	a4,a4
    80002c4c:	08e78463          	beq	a5,a4,80002cd4 <consoleread+0xf0>
    80002c50:	07f7f713          	andi	a4,a5,127
    80002c54:	00e48733          	add	a4,s1,a4
    80002c58:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    80002c5c:	0017869b          	addiw	a3,a5,1
    80002c60:	08d4ac23          	sw	a3,152(s1)
    80002c64:	00070c9b          	sext.w	s9,a4
    80002c68:	0b370663          	beq	a4,s3,80002d14 <consoleread+0x130>
    80002c6c:	00100693          	li	a3,1
    80002c70:	f9f40613          	addi	a2,s0,-97
    80002c74:	000c0593          	mv	a1,s8
    80002c78:	00090513          	mv	a0,s2
    80002c7c:	f8e40fa3          	sb	a4,-97(s0)
    80002c80:	00000097          	auipc	ra,0x0
    80002c84:	8b4080e7          	jalr	-1868(ra) # 80002534 <either_copyout>
    80002c88:	01450863          	beq	a0,s4,80002c98 <consoleread+0xb4>
    80002c8c:	001c0c13          	addi	s8,s8,1
    80002c90:	fffb8b9b          	addiw	s7,s7,-1
    80002c94:	fb5c94e3          	bne	s9,s5,80002c3c <consoleread+0x58>
    80002c98:	000b851b          	sext.w	a0,s7
    80002c9c:	06813083          	ld	ra,104(sp)
    80002ca0:	06013403          	ld	s0,96(sp)
    80002ca4:	05813483          	ld	s1,88(sp)
    80002ca8:	05013903          	ld	s2,80(sp)
    80002cac:	04813983          	ld	s3,72(sp)
    80002cb0:	04013a03          	ld	s4,64(sp)
    80002cb4:	03813a83          	ld	s5,56(sp)
    80002cb8:	02813b83          	ld	s7,40(sp)
    80002cbc:	02013c03          	ld	s8,32(sp)
    80002cc0:	01813c83          	ld	s9,24(sp)
    80002cc4:	40ab053b          	subw	a0,s6,a0
    80002cc8:	03013b03          	ld	s6,48(sp)
    80002ccc:	07010113          	addi	sp,sp,112
    80002cd0:	00008067          	ret
    80002cd4:	00001097          	auipc	ra,0x1
    80002cd8:	1d8080e7          	jalr	472(ra) # 80003eac <push_on>
    80002cdc:	0984a703          	lw	a4,152(s1)
    80002ce0:	09c4a783          	lw	a5,156(s1)
    80002ce4:	0007879b          	sext.w	a5,a5
    80002ce8:	fef70ce3          	beq	a4,a5,80002ce0 <consoleread+0xfc>
    80002cec:	00001097          	auipc	ra,0x1
    80002cf0:	234080e7          	jalr	564(ra) # 80003f20 <pop_on>
    80002cf4:	0984a783          	lw	a5,152(s1)
    80002cf8:	07f7f713          	andi	a4,a5,127
    80002cfc:	00e48733          	add	a4,s1,a4
    80002d00:	01874703          	lbu	a4,24(a4)
    80002d04:	0017869b          	addiw	a3,a5,1
    80002d08:	08d4ac23          	sw	a3,152(s1)
    80002d0c:	00070c9b          	sext.w	s9,a4
    80002d10:	f5371ee3          	bne	a4,s3,80002c6c <consoleread+0x88>
    80002d14:	000b851b          	sext.w	a0,s7
    80002d18:	f96bf2e3          	bgeu	s7,s6,80002c9c <consoleread+0xb8>
    80002d1c:	08f4ac23          	sw	a5,152(s1)
    80002d20:	f7dff06f          	j	80002c9c <consoleread+0xb8>

0000000080002d24 <consputc>:
    80002d24:	10000793          	li	a5,256
    80002d28:	00f50663          	beq	a0,a5,80002d34 <consputc+0x10>
    80002d2c:	00001317          	auipc	t1,0x1
    80002d30:	9f430067          	jr	-1548(t1) # 80003720 <uartputc_sync>
    80002d34:	ff010113          	addi	sp,sp,-16
    80002d38:	00113423          	sd	ra,8(sp)
    80002d3c:	00813023          	sd	s0,0(sp)
    80002d40:	01010413          	addi	s0,sp,16
    80002d44:	00800513          	li	a0,8
    80002d48:	00001097          	auipc	ra,0x1
    80002d4c:	9d8080e7          	jalr	-1576(ra) # 80003720 <uartputc_sync>
    80002d50:	02000513          	li	a0,32
    80002d54:	00001097          	auipc	ra,0x1
    80002d58:	9cc080e7          	jalr	-1588(ra) # 80003720 <uartputc_sync>
    80002d5c:	00013403          	ld	s0,0(sp)
    80002d60:	00813083          	ld	ra,8(sp)
    80002d64:	00800513          	li	a0,8
    80002d68:	01010113          	addi	sp,sp,16
    80002d6c:	00001317          	auipc	t1,0x1
    80002d70:	9b430067          	jr	-1612(t1) # 80003720 <uartputc_sync>

0000000080002d74 <consoleintr>:
    80002d74:	fe010113          	addi	sp,sp,-32
    80002d78:	00813823          	sd	s0,16(sp)
    80002d7c:	00913423          	sd	s1,8(sp)
    80002d80:	01213023          	sd	s2,0(sp)
    80002d84:	00113c23          	sd	ra,24(sp)
    80002d88:	02010413          	addi	s0,sp,32
    80002d8c:	00004917          	auipc	s2,0x4
    80002d90:	f9c90913          	addi	s2,s2,-100 # 80006d28 <cons>
    80002d94:	00050493          	mv	s1,a0
    80002d98:	00090513          	mv	a0,s2
    80002d9c:	00001097          	auipc	ra,0x1
    80002da0:	e40080e7          	jalr	-448(ra) # 80003bdc <acquire>
    80002da4:	02048c63          	beqz	s1,80002ddc <consoleintr+0x68>
    80002da8:	0a092783          	lw	a5,160(s2)
    80002dac:	09892703          	lw	a4,152(s2)
    80002db0:	07f00693          	li	a3,127
    80002db4:	40e7873b          	subw	a4,a5,a4
    80002db8:	02e6e263          	bltu	a3,a4,80002ddc <consoleintr+0x68>
    80002dbc:	00d00713          	li	a4,13
    80002dc0:	04e48063          	beq	s1,a4,80002e00 <consoleintr+0x8c>
    80002dc4:	07f7f713          	andi	a4,a5,127
    80002dc8:	00e90733          	add	a4,s2,a4
    80002dcc:	0017879b          	addiw	a5,a5,1
    80002dd0:	0af92023          	sw	a5,160(s2)
    80002dd4:	00970c23          	sb	s1,24(a4)
    80002dd8:	08f92e23          	sw	a5,156(s2)
    80002ddc:	01013403          	ld	s0,16(sp)
    80002de0:	01813083          	ld	ra,24(sp)
    80002de4:	00813483          	ld	s1,8(sp)
    80002de8:	00013903          	ld	s2,0(sp)
    80002dec:	00004517          	auipc	a0,0x4
    80002df0:	f3c50513          	addi	a0,a0,-196 # 80006d28 <cons>
    80002df4:	02010113          	addi	sp,sp,32
    80002df8:	00001317          	auipc	t1,0x1
    80002dfc:	eb030067          	jr	-336(t1) # 80003ca8 <release>
    80002e00:	00a00493          	li	s1,10
    80002e04:	fc1ff06f          	j	80002dc4 <consoleintr+0x50>

0000000080002e08 <consoleinit>:
    80002e08:	fe010113          	addi	sp,sp,-32
    80002e0c:	00113c23          	sd	ra,24(sp)
    80002e10:	00813823          	sd	s0,16(sp)
    80002e14:	00913423          	sd	s1,8(sp)
    80002e18:	02010413          	addi	s0,sp,32
    80002e1c:	00004497          	auipc	s1,0x4
    80002e20:	f0c48493          	addi	s1,s1,-244 # 80006d28 <cons>
    80002e24:	00048513          	mv	a0,s1
    80002e28:	00002597          	auipc	a1,0x2
    80002e2c:	32058593          	addi	a1,a1,800 # 80005148 <CONSOLE_STATUS+0x138>
    80002e30:	00001097          	auipc	ra,0x1
    80002e34:	d88080e7          	jalr	-632(ra) # 80003bb8 <initlock>
    80002e38:	00000097          	auipc	ra,0x0
    80002e3c:	7ac080e7          	jalr	1964(ra) # 800035e4 <uartinit>
    80002e40:	01813083          	ld	ra,24(sp)
    80002e44:	01013403          	ld	s0,16(sp)
    80002e48:	00000797          	auipc	a5,0x0
    80002e4c:	d9c78793          	addi	a5,a5,-612 # 80002be4 <consoleread>
    80002e50:	0af4bc23          	sd	a5,184(s1)
    80002e54:	00000797          	auipc	a5,0x0
    80002e58:	cec78793          	addi	a5,a5,-788 # 80002b40 <consolewrite>
    80002e5c:	0cf4b023          	sd	a5,192(s1)
    80002e60:	00813483          	ld	s1,8(sp)
    80002e64:	02010113          	addi	sp,sp,32
    80002e68:	00008067          	ret

0000000080002e6c <console_read>:
    80002e6c:	ff010113          	addi	sp,sp,-16
    80002e70:	00813423          	sd	s0,8(sp)
    80002e74:	01010413          	addi	s0,sp,16
    80002e78:	00813403          	ld	s0,8(sp)
    80002e7c:	00004317          	auipc	t1,0x4
    80002e80:	f6433303          	ld	t1,-156(t1) # 80006de0 <devsw+0x10>
    80002e84:	01010113          	addi	sp,sp,16
    80002e88:	00030067          	jr	t1

0000000080002e8c <console_write>:
    80002e8c:	ff010113          	addi	sp,sp,-16
    80002e90:	00813423          	sd	s0,8(sp)
    80002e94:	01010413          	addi	s0,sp,16
    80002e98:	00813403          	ld	s0,8(sp)
    80002e9c:	00004317          	auipc	t1,0x4
    80002ea0:	f4c33303          	ld	t1,-180(t1) # 80006de8 <devsw+0x18>
    80002ea4:	01010113          	addi	sp,sp,16
    80002ea8:	00030067          	jr	t1

0000000080002eac <panic>:
    80002eac:	fe010113          	addi	sp,sp,-32
    80002eb0:	00113c23          	sd	ra,24(sp)
    80002eb4:	00813823          	sd	s0,16(sp)
    80002eb8:	00913423          	sd	s1,8(sp)
    80002ebc:	02010413          	addi	s0,sp,32
    80002ec0:	00050493          	mv	s1,a0
    80002ec4:	00002517          	auipc	a0,0x2
    80002ec8:	28c50513          	addi	a0,a0,652 # 80005150 <CONSOLE_STATUS+0x140>
    80002ecc:	00004797          	auipc	a5,0x4
    80002ed0:	fa07ae23          	sw	zero,-68(a5) # 80006e88 <pr+0x18>
    80002ed4:	00000097          	auipc	ra,0x0
    80002ed8:	034080e7          	jalr	52(ra) # 80002f08 <__printf>
    80002edc:	00048513          	mv	a0,s1
    80002ee0:	00000097          	auipc	ra,0x0
    80002ee4:	028080e7          	jalr	40(ra) # 80002f08 <__printf>
    80002ee8:	00002517          	auipc	a0,0x2
    80002eec:	24850513          	addi	a0,a0,584 # 80005130 <CONSOLE_STATUS+0x120>
    80002ef0:	00000097          	auipc	ra,0x0
    80002ef4:	018080e7          	jalr	24(ra) # 80002f08 <__printf>
    80002ef8:	00100793          	li	a5,1
    80002efc:	00003717          	auipc	a4,0x3
    80002f00:	acf72e23          	sw	a5,-1316(a4) # 800059d8 <panicked>
    80002f04:	0000006f          	j	80002f04 <panic+0x58>

0000000080002f08 <__printf>:
    80002f08:	f3010113          	addi	sp,sp,-208
    80002f0c:	08813023          	sd	s0,128(sp)
    80002f10:	07313423          	sd	s3,104(sp)
    80002f14:	09010413          	addi	s0,sp,144
    80002f18:	05813023          	sd	s8,64(sp)
    80002f1c:	08113423          	sd	ra,136(sp)
    80002f20:	06913c23          	sd	s1,120(sp)
    80002f24:	07213823          	sd	s2,112(sp)
    80002f28:	07413023          	sd	s4,96(sp)
    80002f2c:	05513c23          	sd	s5,88(sp)
    80002f30:	05613823          	sd	s6,80(sp)
    80002f34:	05713423          	sd	s7,72(sp)
    80002f38:	03913c23          	sd	s9,56(sp)
    80002f3c:	03a13823          	sd	s10,48(sp)
    80002f40:	03b13423          	sd	s11,40(sp)
    80002f44:	00004317          	auipc	t1,0x4
    80002f48:	f2c30313          	addi	t1,t1,-212 # 80006e70 <pr>
    80002f4c:	01832c03          	lw	s8,24(t1)
    80002f50:	00b43423          	sd	a1,8(s0)
    80002f54:	00c43823          	sd	a2,16(s0)
    80002f58:	00d43c23          	sd	a3,24(s0)
    80002f5c:	02e43023          	sd	a4,32(s0)
    80002f60:	02f43423          	sd	a5,40(s0)
    80002f64:	03043823          	sd	a6,48(s0)
    80002f68:	03143c23          	sd	a7,56(s0)
    80002f6c:	00050993          	mv	s3,a0
    80002f70:	4a0c1663          	bnez	s8,8000341c <__printf+0x514>
    80002f74:	60098c63          	beqz	s3,8000358c <__printf+0x684>
    80002f78:	0009c503          	lbu	a0,0(s3)
    80002f7c:	00840793          	addi	a5,s0,8
    80002f80:	f6f43c23          	sd	a5,-136(s0)
    80002f84:	00000493          	li	s1,0
    80002f88:	22050063          	beqz	a0,800031a8 <__printf+0x2a0>
    80002f8c:	00002a37          	lui	s4,0x2
    80002f90:	00018ab7          	lui	s5,0x18
    80002f94:	000f4b37          	lui	s6,0xf4
    80002f98:	00989bb7          	lui	s7,0x989
    80002f9c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80002fa0:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80002fa4:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80002fa8:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    80002fac:	00148c9b          	addiw	s9,s1,1
    80002fb0:	02500793          	li	a5,37
    80002fb4:	01998933          	add	s2,s3,s9
    80002fb8:	38f51263          	bne	a0,a5,8000333c <__printf+0x434>
    80002fbc:	00094783          	lbu	a5,0(s2)
    80002fc0:	00078c9b          	sext.w	s9,a5
    80002fc4:	1e078263          	beqz	a5,800031a8 <__printf+0x2a0>
    80002fc8:	0024849b          	addiw	s1,s1,2
    80002fcc:	07000713          	li	a4,112
    80002fd0:	00998933          	add	s2,s3,s1
    80002fd4:	38e78a63          	beq	a5,a4,80003368 <__printf+0x460>
    80002fd8:	20f76863          	bltu	a4,a5,800031e8 <__printf+0x2e0>
    80002fdc:	42a78863          	beq	a5,a0,8000340c <__printf+0x504>
    80002fe0:	06400713          	li	a4,100
    80002fe4:	40e79663          	bne	a5,a4,800033f0 <__printf+0x4e8>
    80002fe8:	f7843783          	ld	a5,-136(s0)
    80002fec:	0007a603          	lw	a2,0(a5)
    80002ff0:	00878793          	addi	a5,a5,8
    80002ff4:	f6f43c23          	sd	a5,-136(s0)
    80002ff8:	42064a63          	bltz	a2,8000342c <__printf+0x524>
    80002ffc:	00a00713          	li	a4,10
    80003000:	02e677bb          	remuw	a5,a2,a4
    80003004:	00002d97          	auipc	s11,0x2
    80003008:	174d8d93          	addi	s11,s11,372 # 80005178 <digits>
    8000300c:	00900593          	li	a1,9
    80003010:	0006051b          	sext.w	a0,a2
    80003014:	00000c93          	li	s9,0
    80003018:	02079793          	slli	a5,a5,0x20
    8000301c:	0207d793          	srli	a5,a5,0x20
    80003020:	00fd87b3          	add	a5,s11,a5
    80003024:	0007c783          	lbu	a5,0(a5)
    80003028:	02e656bb          	divuw	a3,a2,a4
    8000302c:	f8f40023          	sb	a5,-128(s0)
    80003030:	14c5d863          	bge	a1,a2,80003180 <__printf+0x278>
    80003034:	06300593          	li	a1,99
    80003038:	00100c93          	li	s9,1
    8000303c:	02e6f7bb          	remuw	a5,a3,a4
    80003040:	02079793          	slli	a5,a5,0x20
    80003044:	0207d793          	srli	a5,a5,0x20
    80003048:	00fd87b3          	add	a5,s11,a5
    8000304c:	0007c783          	lbu	a5,0(a5)
    80003050:	02e6d73b          	divuw	a4,a3,a4
    80003054:	f8f400a3          	sb	a5,-127(s0)
    80003058:	12a5f463          	bgeu	a1,a0,80003180 <__printf+0x278>
    8000305c:	00a00693          	li	a3,10
    80003060:	00900593          	li	a1,9
    80003064:	02d777bb          	remuw	a5,a4,a3
    80003068:	02079793          	slli	a5,a5,0x20
    8000306c:	0207d793          	srli	a5,a5,0x20
    80003070:	00fd87b3          	add	a5,s11,a5
    80003074:	0007c503          	lbu	a0,0(a5)
    80003078:	02d757bb          	divuw	a5,a4,a3
    8000307c:	f8a40123          	sb	a0,-126(s0)
    80003080:	48e5f263          	bgeu	a1,a4,80003504 <__printf+0x5fc>
    80003084:	06300513          	li	a0,99
    80003088:	02d7f5bb          	remuw	a1,a5,a3
    8000308c:	02059593          	slli	a1,a1,0x20
    80003090:	0205d593          	srli	a1,a1,0x20
    80003094:	00bd85b3          	add	a1,s11,a1
    80003098:	0005c583          	lbu	a1,0(a1)
    8000309c:	02d7d7bb          	divuw	a5,a5,a3
    800030a0:	f8b401a3          	sb	a1,-125(s0)
    800030a4:	48e57263          	bgeu	a0,a4,80003528 <__printf+0x620>
    800030a8:	3e700513          	li	a0,999
    800030ac:	02d7f5bb          	remuw	a1,a5,a3
    800030b0:	02059593          	slli	a1,a1,0x20
    800030b4:	0205d593          	srli	a1,a1,0x20
    800030b8:	00bd85b3          	add	a1,s11,a1
    800030bc:	0005c583          	lbu	a1,0(a1)
    800030c0:	02d7d7bb          	divuw	a5,a5,a3
    800030c4:	f8b40223          	sb	a1,-124(s0)
    800030c8:	46e57663          	bgeu	a0,a4,80003534 <__printf+0x62c>
    800030cc:	02d7f5bb          	remuw	a1,a5,a3
    800030d0:	02059593          	slli	a1,a1,0x20
    800030d4:	0205d593          	srli	a1,a1,0x20
    800030d8:	00bd85b3          	add	a1,s11,a1
    800030dc:	0005c583          	lbu	a1,0(a1)
    800030e0:	02d7d7bb          	divuw	a5,a5,a3
    800030e4:	f8b402a3          	sb	a1,-123(s0)
    800030e8:	46ea7863          	bgeu	s4,a4,80003558 <__printf+0x650>
    800030ec:	02d7f5bb          	remuw	a1,a5,a3
    800030f0:	02059593          	slli	a1,a1,0x20
    800030f4:	0205d593          	srli	a1,a1,0x20
    800030f8:	00bd85b3          	add	a1,s11,a1
    800030fc:	0005c583          	lbu	a1,0(a1)
    80003100:	02d7d7bb          	divuw	a5,a5,a3
    80003104:	f8b40323          	sb	a1,-122(s0)
    80003108:	3eeaf863          	bgeu	s5,a4,800034f8 <__printf+0x5f0>
    8000310c:	02d7f5bb          	remuw	a1,a5,a3
    80003110:	02059593          	slli	a1,a1,0x20
    80003114:	0205d593          	srli	a1,a1,0x20
    80003118:	00bd85b3          	add	a1,s11,a1
    8000311c:	0005c583          	lbu	a1,0(a1)
    80003120:	02d7d7bb          	divuw	a5,a5,a3
    80003124:	f8b403a3          	sb	a1,-121(s0)
    80003128:	42eb7e63          	bgeu	s6,a4,80003564 <__printf+0x65c>
    8000312c:	02d7f5bb          	remuw	a1,a5,a3
    80003130:	02059593          	slli	a1,a1,0x20
    80003134:	0205d593          	srli	a1,a1,0x20
    80003138:	00bd85b3          	add	a1,s11,a1
    8000313c:	0005c583          	lbu	a1,0(a1)
    80003140:	02d7d7bb          	divuw	a5,a5,a3
    80003144:	f8b40423          	sb	a1,-120(s0)
    80003148:	42ebfc63          	bgeu	s7,a4,80003580 <__printf+0x678>
    8000314c:	02079793          	slli	a5,a5,0x20
    80003150:	0207d793          	srli	a5,a5,0x20
    80003154:	00fd8db3          	add	s11,s11,a5
    80003158:	000dc703          	lbu	a4,0(s11)
    8000315c:	00a00793          	li	a5,10
    80003160:	00900c93          	li	s9,9
    80003164:	f8e404a3          	sb	a4,-119(s0)
    80003168:	00065c63          	bgez	a2,80003180 <__printf+0x278>
    8000316c:	f9040713          	addi	a4,s0,-112
    80003170:	00f70733          	add	a4,a4,a5
    80003174:	02d00693          	li	a3,45
    80003178:	fed70823          	sb	a3,-16(a4)
    8000317c:	00078c93          	mv	s9,a5
    80003180:	f8040793          	addi	a5,s0,-128
    80003184:	01978cb3          	add	s9,a5,s9
    80003188:	f7f40d13          	addi	s10,s0,-129
    8000318c:	000cc503          	lbu	a0,0(s9)
    80003190:	fffc8c93          	addi	s9,s9,-1
    80003194:	00000097          	auipc	ra,0x0
    80003198:	b90080e7          	jalr	-1136(ra) # 80002d24 <consputc>
    8000319c:	ffac98e3          	bne	s9,s10,8000318c <__printf+0x284>
    800031a0:	00094503          	lbu	a0,0(s2)
    800031a4:	e00514e3          	bnez	a0,80002fac <__printf+0xa4>
    800031a8:	1a0c1663          	bnez	s8,80003354 <__printf+0x44c>
    800031ac:	08813083          	ld	ra,136(sp)
    800031b0:	08013403          	ld	s0,128(sp)
    800031b4:	07813483          	ld	s1,120(sp)
    800031b8:	07013903          	ld	s2,112(sp)
    800031bc:	06813983          	ld	s3,104(sp)
    800031c0:	06013a03          	ld	s4,96(sp)
    800031c4:	05813a83          	ld	s5,88(sp)
    800031c8:	05013b03          	ld	s6,80(sp)
    800031cc:	04813b83          	ld	s7,72(sp)
    800031d0:	04013c03          	ld	s8,64(sp)
    800031d4:	03813c83          	ld	s9,56(sp)
    800031d8:	03013d03          	ld	s10,48(sp)
    800031dc:	02813d83          	ld	s11,40(sp)
    800031e0:	0d010113          	addi	sp,sp,208
    800031e4:	00008067          	ret
    800031e8:	07300713          	li	a4,115
    800031ec:	1ce78a63          	beq	a5,a4,800033c0 <__printf+0x4b8>
    800031f0:	07800713          	li	a4,120
    800031f4:	1ee79e63          	bne	a5,a4,800033f0 <__printf+0x4e8>
    800031f8:	f7843783          	ld	a5,-136(s0)
    800031fc:	0007a703          	lw	a4,0(a5)
    80003200:	00878793          	addi	a5,a5,8
    80003204:	f6f43c23          	sd	a5,-136(s0)
    80003208:	28074263          	bltz	a4,8000348c <__printf+0x584>
    8000320c:	00002d97          	auipc	s11,0x2
    80003210:	f6cd8d93          	addi	s11,s11,-148 # 80005178 <digits>
    80003214:	00f77793          	andi	a5,a4,15
    80003218:	00fd87b3          	add	a5,s11,a5
    8000321c:	0007c683          	lbu	a3,0(a5)
    80003220:	00f00613          	li	a2,15
    80003224:	0007079b          	sext.w	a5,a4
    80003228:	f8d40023          	sb	a3,-128(s0)
    8000322c:	0047559b          	srliw	a1,a4,0x4
    80003230:	0047569b          	srliw	a3,a4,0x4
    80003234:	00000c93          	li	s9,0
    80003238:	0ee65063          	bge	a2,a4,80003318 <__printf+0x410>
    8000323c:	00f6f693          	andi	a3,a3,15
    80003240:	00dd86b3          	add	a3,s11,a3
    80003244:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80003248:	0087d79b          	srliw	a5,a5,0x8
    8000324c:	00100c93          	li	s9,1
    80003250:	f8d400a3          	sb	a3,-127(s0)
    80003254:	0cb67263          	bgeu	a2,a1,80003318 <__printf+0x410>
    80003258:	00f7f693          	andi	a3,a5,15
    8000325c:	00dd86b3          	add	a3,s11,a3
    80003260:	0006c583          	lbu	a1,0(a3)
    80003264:	00f00613          	li	a2,15
    80003268:	0047d69b          	srliw	a3,a5,0x4
    8000326c:	f8b40123          	sb	a1,-126(s0)
    80003270:	0047d593          	srli	a1,a5,0x4
    80003274:	28f67e63          	bgeu	a2,a5,80003510 <__printf+0x608>
    80003278:	00f6f693          	andi	a3,a3,15
    8000327c:	00dd86b3          	add	a3,s11,a3
    80003280:	0006c503          	lbu	a0,0(a3)
    80003284:	0087d813          	srli	a6,a5,0x8
    80003288:	0087d69b          	srliw	a3,a5,0x8
    8000328c:	f8a401a3          	sb	a0,-125(s0)
    80003290:	28b67663          	bgeu	a2,a1,8000351c <__printf+0x614>
    80003294:	00f6f693          	andi	a3,a3,15
    80003298:	00dd86b3          	add	a3,s11,a3
    8000329c:	0006c583          	lbu	a1,0(a3)
    800032a0:	00c7d513          	srli	a0,a5,0xc
    800032a4:	00c7d69b          	srliw	a3,a5,0xc
    800032a8:	f8b40223          	sb	a1,-124(s0)
    800032ac:	29067a63          	bgeu	a2,a6,80003540 <__printf+0x638>
    800032b0:	00f6f693          	andi	a3,a3,15
    800032b4:	00dd86b3          	add	a3,s11,a3
    800032b8:	0006c583          	lbu	a1,0(a3)
    800032bc:	0107d813          	srli	a6,a5,0x10
    800032c0:	0107d69b          	srliw	a3,a5,0x10
    800032c4:	f8b402a3          	sb	a1,-123(s0)
    800032c8:	28a67263          	bgeu	a2,a0,8000354c <__printf+0x644>
    800032cc:	00f6f693          	andi	a3,a3,15
    800032d0:	00dd86b3          	add	a3,s11,a3
    800032d4:	0006c683          	lbu	a3,0(a3)
    800032d8:	0147d79b          	srliw	a5,a5,0x14
    800032dc:	f8d40323          	sb	a3,-122(s0)
    800032e0:	21067663          	bgeu	a2,a6,800034ec <__printf+0x5e4>
    800032e4:	02079793          	slli	a5,a5,0x20
    800032e8:	0207d793          	srli	a5,a5,0x20
    800032ec:	00fd8db3          	add	s11,s11,a5
    800032f0:	000dc683          	lbu	a3,0(s11)
    800032f4:	00800793          	li	a5,8
    800032f8:	00700c93          	li	s9,7
    800032fc:	f8d403a3          	sb	a3,-121(s0)
    80003300:	00075c63          	bgez	a4,80003318 <__printf+0x410>
    80003304:	f9040713          	addi	a4,s0,-112
    80003308:	00f70733          	add	a4,a4,a5
    8000330c:	02d00693          	li	a3,45
    80003310:	fed70823          	sb	a3,-16(a4)
    80003314:	00078c93          	mv	s9,a5
    80003318:	f8040793          	addi	a5,s0,-128
    8000331c:	01978cb3          	add	s9,a5,s9
    80003320:	f7f40d13          	addi	s10,s0,-129
    80003324:	000cc503          	lbu	a0,0(s9)
    80003328:	fffc8c93          	addi	s9,s9,-1
    8000332c:	00000097          	auipc	ra,0x0
    80003330:	9f8080e7          	jalr	-1544(ra) # 80002d24 <consputc>
    80003334:	ff9d18e3          	bne	s10,s9,80003324 <__printf+0x41c>
    80003338:	0100006f          	j	80003348 <__printf+0x440>
    8000333c:	00000097          	auipc	ra,0x0
    80003340:	9e8080e7          	jalr	-1560(ra) # 80002d24 <consputc>
    80003344:	000c8493          	mv	s1,s9
    80003348:	00094503          	lbu	a0,0(s2)
    8000334c:	c60510e3          	bnez	a0,80002fac <__printf+0xa4>
    80003350:	e40c0ee3          	beqz	s8,800031ac <__printf+0x2a4>
    80003354:	00004517          	auipc	a0,0x4
    80003358:	b1c50513          	addi	a0,a0,-1252 # 80006e70 <pr>
    8000335c:	00001097          	auipc	ra,0x1
    80003360:	94c080e7          	jalr	-1716(ra) # 80003ca8 <release>
    80003364:	e49ff06f          	j	800031ac <__printf+0x2a4>
    80003368:	f7843783          	ld	a5,-136(s0)
    8000336c:	03000513          	li	a0,48
    80003370:	01000d13          	li	s10,16
    80003374:	00878713          	addi	a4,a5,8
    80003378:	0007bc83          	ld	s9,0(a5)
    8000337c:	f6e43c23          	sd	a4,-136(s0)
    80003380:	00000097          	auipc	ra,0x0
    80003384:	9a4080e7          	jalr	-1628(ra) # 80002d24 <consputc>
    80003388:	07800513          	li	a0,120
    8000338c:	00000097          	auipc	ra,0x0
    80003390:	998080e7          	jalr	-1640(ra) # 80002d24 <consputc>
    80003394:	00002d97          	auipc	s11,0x2
    80003398:	de4d8d93          	addi	s11,s11,-540 # 80005178 <digits>
    8000339c:	03ccd793          	srli	a5,s9,0x3c
    800033a0:	00fd87b3          	add	a5,s11,a5
    800033a4:	0007c503          	lbu	a0,0(a5)
    800033a8:	fffd0d1b          	addiw	s10,s10,-1
    800033ac:	004c9c93          	slli	s9,s9,0x4
    800033b0:	00000097          	auipc	ra,0x0
    800033b4:	974080e7          	jalr	-1676(ra) # 80002d24 <consputc>
    800033b8:	fe0d12e3          	bnez	s10,8000339c <__printf+0x494>
    800033bc:	f8dff06f          	j	80003348 <__printf+0x440>
    800033c0:	f7843783          	ld	a5,-136(s0)
    800033c4:	0007bc83          	ld	s9,0(a5)
    800033c8:	00878793          	addi	a5,a5,8
    800033cc:	f6f43c23          	sd	a5,-136(s0)
    800033d0:	000c9a63          	bnez	s9,800033e4 <__printf+0x4dc>
    800033d4:	1080006f          	j	800034dc <__printf+0x5d4>
    800033d8:	001c8c93          	addi	s9,s9,1
    800033dc:	00000097          	auipc	ra,0x0
    800033e0:	948080e7          	jalr	-1720(ra) # 80002d24 <consputc>
    800033e4:	000cc503          	lbu	a0,0(s9)
    800033e8:	fe0518e3          	bnez	a0,800033d8 <__printf+0x4d0>
    800033ec:	f5dff06f          	j	80003348 <__printf+0x440>
    800033f0:	02500513          	li	a0,37
    800033f4:	00000097          	auipc	ra,0x0
    800033f8:	930080e7          	jalr	-1744(ra) # 80002d24 <consputc>
    800033fc:	000c8513          	mv	a0,s9
    80003400:	00000097          	auipc	ra,0x0
    80003404:	924080e7          	jalr	-1756(ra) # 80002d24 <consputc>
    80003408:	f41ff06f          	j	80003348 <__printf+0x440>
    8000340c:	02500513          	li	a0,37
    80003410:	00000097          	auipc	ra,0x0
    80003414:	914080e7          	jalr	-1772(ra) # 80002d24 <consputc>
    80003418:	f31ff06f          	j	80003348 <__printf+0x440>
    8000341c:	00030513          	mv	a0,t1
    80003420:	00000097          	auipc	ra,0x0
    80003424:	7bc080e7          	jalr	1980(ra) # 80003bdc <acquire>
    80003428:	b4dff06f          	j	80002f74 <__printf+0x6c>
    8000342c:	40c0053b          	negw	a0,a2
    80003430:	00a00713          	li	a4,10
    80003434:	02e576bb          	remuw	a3,a0,a4
    80003438:	00002d97          	auipc	s11,0x2
    8000343c:	d40d8d93          	addi	s11,s11,-704 # 80005178 <digits>
    80003440:	ff700593          	li	a1,-9
    80003444:	02069693          	slli	a3,a3,0x20
    80003448:	0206d693          	srli	a3,a3,0x20
    8000344c:	00dd86b3          	add	a3,s11,a3
    80003450:	0006c683          	lbu	a3,0(a3)
    80003454:	02e557bb          	divuw	a5,a0,a4
    80003458:	f8d40023          	sb	a3,-128(s0)
    8000345c:	10b65e63          	bge	a2,a1,80003578 <__printf+0x670>
    80003460:	06300593          	li	a1,99
    80003464:	02e7f6bb          	remuw	a3,a5,a4
    80003468:	02069693          	slli	a3,a3,0x20
    8000346c:	0206d693          	srli	a3,a3,0x20
    80003470:	00dd86b3          	add	a3,s11,a3
    80003474:	0006c683          	lbu	a3,0(a3)
    80003478:	02e7d73b          	divuw	a4,a5,a4
    8000347c:	00200793          	li	a5,2
    80003480:	f8d400a3          	sb	a3,-127(s0)
    80003484:	bca5ece3          	bltu	a1,a0,8000305c <__printf+0x154>
    80003488:	ce5ff06f          	j	8000316c <__printf+0x264>
    8000348c:	40e007bb          	negw	a5,a4
    80003490:	00002d97          	auipc	s11,0x2
    80003494:	ce8d8d93          	addi	s11,s11,-792 # 80005178 <digits>
    80003498:	00f7f693          	andi	a3,a5,15
    8000349c:	00dd86b3          	add	a3,s11,a3
    800034a0:	0006c583          	lbu	a1,0(a3)
    800034a4:	ff100613          	li	a2,-15
    800034a8:	0047d69b          	srliw	a3,a5,0x4
    800034ac:	f8b40023          	sb	a1,-128(s0)
    800034b0:	0047d59b          	srliw	a1,a5,0x4
    800034b4:	0ac75e63          	bge	a4,a2,80003570 <__printf+0x668>
    800034b8:	00f6f693          	andi	a3,a3,15
    800034bc:	00dd86b3          	add	a3,s11,a3
    800034c0:	0006c603          	lbu	a2,0(a3)
    800034c4:	00f00693          	li	a3,15
    800034c8:	0087d79b          	srliw	a5,a5,0x8
    800034cc:	f8c400a3          	sb	a2,-127(s0)
    800034d0:	d8b6e4e3          	bltu	a3,a1,80003258 <__printf+0x350>
    800034d4:	00200793          	li	a5,2
    800034d8:	e2dff06f          	j	80003304 <__printf+0x3fc>
    800034dc:	00002c97          	auipc	s9,0x2
    800034e0:	c7cc8c93          	addi	s9,s9,-900 # 80005158 <CONSOLE_STATUS+0x148>
    800034e4:	02800513          	li	a0,40
    800034e8:	ef1ff06f          	j	800033d8 <__printf+0x4d0>
    800034ec:	00700793          	li	a5,7
    800034f0:	00600c93          	li	s9,6
    800034f4:	e0dff06f          	j	80003300 <__printf+0x3f8>
    800034f8:	00700793          	li	a5,7
    800034fc:	00600c93          	li	s9,6
    80003500:	c69ff06f          	j	80003168 <__printf+0x260>
    80003504:	00300793          	li	a5,3
    80003508:	00200c93          	li	s9,2
    8000350c:	c5dff06f          	j	80003168 <__printf+0x260>
    80003510:	00300793          	li	a5,3
    80003514:	00200c93          	li	s9,2
    80003518:	de9ff06f          	j	80003300 <__printf+0x3f8>
    8000351c:	00400793          	li	a5,4
    80003520:	00300c93          	li	s9,3
    80003524:	dddff06f          	j	80003300 <__printf+0x3f8>
    80003528:	00400793          	li	a5,4
    8000352c:	00300c93          	li	s9,3
    80003530:	c39ff06f          	j	80003168 <__printf+0x260>
    80003534:	00500793          	li	a5,5
    80003538:	00400c93          	li	s9,4
    8000353c:	c2dff06f          	j	80003168 <__printf+0x260>
    80003540:	00500793          	li	a5,5
    80003544:	00400c93          	li	s9,4
    80003548:	db9ff06f          	j	80003300 <__printf+0x3f8>
    8000354c:	00600793          	li	a5,6
    80003550:	00500c93          	li	s9,5
    80003554:	dadff06f          	j	80003300 <__printf+0x3f8>
    80003558:	00600793          	li	a5,6
    8000355c:	00500c93          	li	s9,5
    80003560:	c09ff06f          	j	80003168 <__printf+0x260>
    80003564:	00800793          	li	a5,8
    80003568:	00700c93          	li	s9,7
    8000356c:	bfdff06f          	j	80003168 <__printf+0x260>
    80003570:	00100793          	li	a5,1
    80003574:	d91ff06f          	j	80003304 <__printf+0x3fc>
    80003578:	00100793          	li	a5,1
    8000357c:	bf1ff06f          	j	8000316c <__printf+0x264>
    80003580:	00900793          	li	a5,9
    80003584:	00800c93          	li	s9,8
    80003588:	be1ff06f          	j	80003168 <__printf+0x260>
    8000358c:	00002517          	auipc	a0,0x2
    80003590:	bd450513          	addi	a0,a0,-1068 # 80005160 <CONSOLE_STATUS+0x150>
    80003594:	00000097          	auipc	ra,0x0
    80003598:	918080e7          	jalr	-1768(ra) # 80002eac <panic>

000000008000359c <printfinit>:
    8000359c:	fe010113          	addi	sp,sp,-32
    800035a0:	00813823          	sd	s0,16(sp)
    800035a4:	00913423          	sd	s1,8(sp)
    800035a8:	00113c23          	sd	ra,24(sp)
    800035ac:	02010413          	addi	s0,sp,32
    800035b0:	00004497          	auipc	s1,0x4
    800035b4:	8c048493          	addi	s1,s1,-1856 # 80006e70 <pr>
    800035b8:	00048513          	mv	a0,s1
    800035bc:	00002597          	auipc	a1,0x2
    800035c0:	bb458593          	addi	a1,a1,-1100 # 80005170 <CONSOLE_STATUS+0x160>
    800035c4:	00000097          	auipc	ra,0x0
    800035c8:	5f4080e7          	jalr	1524(ra) # 80003bb8 <initlock>
    800035cc:	01813083          	ld	ra,24(sp)
    800035d0:	01013403          	ld	s0,16(sp)
    800035d4:	0004ac23          	sw	zero,24(s1)
    800035d8:	00813483          	ld	s1,8(sp)
    800035dc:	02010113          	addi	sp,sp,32
    800035e0:	00008067          	ret

00000000800035e4 <uartinit>:
    800035e4:	ff010113          	addi	sp,sp,-16
    800035e8:	00813423          	sd	s0,8(sp)
    800035ec:	01010413          	addi	s0,sp,16
    800035f0:	100007b7          	lui	a5,0x10000
    800035f4:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    800035f8:	f8000713          	li	a4,-128
    800035fc:	00e781a3          	sb	a4,3(a5)
    80003600:	00300713          	li	a4,3
    80003604:	00e78023          	sb	a4,0(a5)
    80003608:	000780a3          	sb	zero,1(a5)
    8000360c:	00e781a3          	sb	a4,3(a5)
    80003610:	00700693          	li	a3,7
    80003614:	00d78123          	sb	a3,2(a5)
    80003618:	00e780a3          	sb	a4,1(a5)
    8000361c:	00813403          	ld	s0,8(sp)
    80003620:	01010113          	addi	sp,sp,16
    80003624:	00008067          	ret

0000000080003628 <uartputc>:
    80003628:	00002797          	auipc	a5,0x2
    8000362c:	3b07a783          	lw	a5,944(a5) # 800059d8 <panicked>
    80003630:	00078463          	beqz	a5,80003638 <uartputc+0x10>
    80003634:	0000006f          	j	80003634 <uartputc+0xc>
    80003638:	fd010113          	addi	sp,sp,-48
    8000363c:	02813023          	sd	s0,32(sp)
    80003640:	00913c23          	sd	s1,24(sp)
    80003644:	01213823          	sd	s2,16(sp)
    80003648:	01313423          	sd	s3,8(sp)
    8000364c:	02113423          	sd	ra,40(sp)
    80003650:	03010413          	addi	s0,sp,48
    80003654:	00002917          	auipc	s2,0x2
    80003658:	38c90913          	addi	s2,s2,908 # 800059e0 <uart_tx_r>
    8000365c:	00093783          	ld	a5,0(s2)
    80003660:	00002497          	auipc	s1,0x2
    80003664:	38848493          	addi	s1,s1,904 # 800059e8 <uart_tx_w>
    80003668:	0004b703          	ld	a4,0(s1)
    8000366c:	02078693          	addi	a3,a5,32
    80003670:	00050993          	mv	s3,a0
    80003674:	02e69c63          	bne	a3,a4,800036ac <uartputc+0x84>
    80003678:	00001097          	auipc	ra,0x1
    8000367c:	834080e7          	jalr	-1996(ra) # 80003eac <push_on>
    80003680:	00093783          	ld	a5,0(s2)
    80003684:	0004b703          	ld	a4,0(s1)
    80003688:	02078793          	addi	a5,a5,32
    8000368c:	00e79463          	bne	a5,a4,80003694 <uartputc+0x6c>
    80003690:	0000006f          	j	80003690 <uartputc+0x68>
    80003694:	00001097          	auipc	ra,0x1
    80003698:	88c080e7          	jalr	-1908(ra) # 80003f20 <pop_on>
    8000369c:	00093783          	ld	a5,0(s2)
    800036a0:	0004b703          	ld	a4,0(s1)
    800036a4:	02078693          	addi	a3,a5,32
    800036a8:	fce688e3          	beq	a3,a4,80003678 <uartputc+0x50>
    800036ac:	01f77693          	andi	a3,a4,31
    800036b0:	00003597          	auipc	a1,0x3
    800036b4:	7e058593          	addi	a1,a1,2016 # 80006e90 <uart_tx_buf>
    800036b8:	00d586b3          	add	a3,a1,a3
    800036bc:	00170713          	addi	a4,a4,1
    800036c0:	01368023          	sb	s3,0(a3)
    800036c4:	00e4b023          	sd	a4,0(s1)
    800036c8:	10000637          	lui	a2,0x10000
    800036cc:	02f71063          	bne	a4,a5,800036ec <uartputc+0xc4>
    800036d0:	0340006f          	j	80003704 <uartputc+0xdc>
    800036d4:	00074703          	lbu	a4,0(a4)
    800036d8:	00f93023          	sd	a5,0(s2)
    800036dc:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    800036e0:	00093783          	ld	a5,0(s2)
    800036e4:	0004b703          	ld	a4,0(s1)
    800036e8:	00f70e63          	beq	a4,a5,80003704 <uartputc+0xdc>
    800036ec:	00564683          	lbu	a3,5(a2)
    800036f0:	01f7f713          	andi	a4,a5,31
    800036f4:	00e58733          	add	a4,a1,a4
    800036f8:	0206f693          	andi	a3,a3,32
    800036fc:	00178793          	addi	a5,a5,1
    80003700:	fc069ae3          	bnez	a3,800036d4 <uartputc+0xac>
    80003704:	02813083          	ld	ra,40(sp)
    80003708:	02013403          	ld	s0,32(sp)
    8000370c:	01813483          	ld	s1,24(sp)
    80003710:	01013903          	ld	s2,16(sp)
    80003714:	00813983          	ld	s3,8(sp)
    80003718:	03010113          	addi	sp,sp,48
    8000371c:	00008067          	ret

0000000080003720 <uartputc_sync>:
    80003720:	ff010113          	addi	sp,sp,-16
    80003724:	00813423          	sd	s0,8(sp)
    80003728:	01010413          	addi	s0,sp,16
    8000372c:	00002717          	auipc	a4,0x2
    80003730:	2ac72703          	lw	a4,684(a4) # 800059d8 <panicked>
    80003734:	02071663          	bnez	a4,80003760 <uartputc_sync+0x40>
    80003738:	00050793          	mv	a5,a0
    8000373c:	100006b7          	lui	a3,0x10000
    80003740:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80003744:	02077713          	andi	a4,a4,32
    80003748:	fe070ce3          	beqz	a4,80003740 <uartputc_sync+0x20>
    8000374c:	0ff7f793          	andi	a5,a5,255
    80003750:	00f68023          	sb	a5,0(a3)
    80003754:	00813403          	ld	s0,8(sp)
    80003758:	01010113          	addi	sp,sp,16
    8000375c:	00008067          	ret
    80003760:	0000006f          	j	80003760 <uartputc_sync+0x40>

0000000080003764 <uartstart>:
    80003764:	ff010113          	addi	sp,sp,-16
    80003768:	00813423          	sd	s0,8(sp)
    8000376c:	01010413          	addi	s0,sp,16
    80003770:	00002617          	auipc	a2,0x2
    80003774:	27060613          	addi	a2,a2,624 # 800059e0 <uart_tx_r>
    80003778:	00002517          	auipc	a0,0x2
    8000377c:	27050513          	addi	a0,a0,624 # 800059e8 <uart_tx_w>
    80003780:	00063783          	ld	a5,0(a2)
    80003784:	00053703          	ld	a4,0(a0)
    80003788:	04f70263          	beq	a4,a5,800037cc <uartstart+0x68>
    8000378c:	100005b7          	lui	a1,0x10000
    80003790:	00003817          	auipc	a6,0x3
    80003794:	70080813          	addi	a6,a6,1792 # 80006e90 <uart_tx_buf>
    80003798:	01c0006f          	j	800037b4 <uartstart+0x50>
    8000379c:	0006c703          	lbu	a4,0(a3)
    800037a0:	00f63023          	sd	a5,0(a2)
    800037a4:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800037a8:	00063783          	ld	a5,0(a2)
    800037ac:	00053703          	ld	a4,0(a0)
    800037b0:	00f70e63          	beq	a4,a5,800037cc <uartstart+0x68>
    800037b4:	01f7f713          	andi	a4,a5,31
    800037b8:	00e806b3          	add	a3,a6,a4
    800037bc:	0055c703          	lbu	a4,5(a1)
    800037c0:	00178793          	addi	a5,a5,1
    800037c4:	02077713          	andi	a4,a4,32
    800037c8:	fc071ae3          	bnez	a4,8000379c <uartstart+0x38>
    800037cc:	00813403          	ld	s0,8(sp)
    800037d0:	01010113          	addi	sp,sp,16
    800037d4:	00008067          	ret

00000000800037d8 <uartgetc>:
    800037d8:	ff010113          	addi	sp,sp,-16
    800037dc:	00813423          	sd	s0,8(sp)
    800037e0:	01010413          	addi	s0,sp,16
    800037e4:	10000737          	lui	a4,0x10000
    800037e8:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    800037ec:	0017f793          	andi	a5,a5,1
    800037f0:	00078c63          	beqz	a5,80003808 <uartgetc+0x30>
    800037f4:	00074503          	lbu	a0,0(a4)
    800037f8:	0ff57513          	andi	a0,a0,255
    800037fc:	00813403          	ld	s0,8(sp)
    80003800:	01010113          	addi	sp,sp,16
    80003804:	00008067          	ret
    80003808:	fff00513          	li	a0,-1
    8000380c:	ff1ff06f          	j	800037fc <uartgetc+0x24>

0000000080003810 <uartintr>:
    80003810:	100007b7          	lui	a5,0x10000
    80003814:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80003818:	0017f793          	andi	a5,a5,1
    8000381c:	0a078463          	beqz	a5,800038c4 <uartintr+0xb4>
    80003820:	fe010113          	addi	sp,sp,-32
    80003824:	00813823          	sd	s0,16(sp)
    80003828:	00913423          	sd	s1,8(sp)
    8000382c:	00113c23          	sd	ra,24(sp)
    80003830:	02010413          	addi	s0,sp,32
    80003834:	100004b7          	lui	s1,0x10000
    80003838:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    8000383c:	0ff57513          	andi	a0,a0,255
    80003840:	fffff097          	auipc	ra,0xfffff
    80003844:	534080e7          	jalr	1332(ra) # 80002d74 <consoleintr>
    80003848:	0054c783          	lbu	a5,5(s1)
    8000384c:	0017f793          	andi	a5,a5,1
    80003850:	fe0794e3          	bnez	a5,80003838 <uartintr+0x28>
    80003854:	00002617          	auipc	a2,0x2
    80003858:	18c60613          	addi	a2,a2,396 # 800059e0 <uart_tx_r>
    8000385c:	00002517          	auipc	a0,0x2
    80003860:	18c50513          	addi	a0,a0,396 # 800059e8 <uart_tx_w>
    80003864:	00063783          	ld	a5,0(a2)
    80003868:	00053703          	ld	a4,0(a0)
    8000386c:	04f70263          	beq	a4,a5,800038b0 <uartintr+0xa0>
    80003870:	100005b7          	lui	a1,0x10000
    80003874:	00003817          	auipc	a6,0x3
    80003878:	61c80813          	addi	a6,a6,1564 # 80006e90 <uart_tx_buf>
    8000387c:	01c0006f          	j	80003898 <uartintr+0x88>
    80003880:	0006c703          	lbu	a4,0(a3)
    80003884:	00f63023          	sd	a5,0(a2)
    80003888:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000388c:	00063783          	ld	a5,0(a2)
    80003890:	00053703          	ld	a4,0(a0)
    80003894:	00f70e63          	beq	a4,a5,800038b0 <uartintr+0xa0>
    80003898:	01f7f713          	andi	a4,a5,31
    8000389c:	00e806b3          	add	a3,a6,a4
    800038a0:	0055c703          	lbu	a4,5(a1)
    800038a4:	00178793          	addi	a5,a5,1
    800038a8:	02077713          	andi	a4,a4,32
    800038ac:	fc071ae3          	bnez	a4,80003880 <uartintr+0x70>
    800038b0:	01813083          	ld	ra,24(sp)
    800038b4:	01013403          	ld	s0,16(sp)
    800038b8:	00813483          	ld	s1,8(sp)
    800038bc:	02010113          	addi	sp,sp,32
    800038c0:	00008067          	ret
    800038c4:	00002617          	auipc	a2,0x2
    800038c8:	11c60613          	addi	a2,a2,284 # 800059e0 <uart_tx_r>
    800038cc:	00002517          	auipc	a0,0x2
    800038d0:	11c50513          	addi	a0,a0,284 # 800059e8 <uart_tx_w>
    800038d4:	00063783          	ld	a5,0(a2)
    800038d8:	00053703          	ld	a4,0(a0)
    800038dc:	04f70263          	beq	a4,a5,80003920 <uartintr+0x110>
    800038e0:	100005b7          	lui	a1,0x10000
    800038e4:	00003817          	auipc	a6,0x3
    800038e8:	5ac80813          	addi	a6,a6,1452 # 80006e90 <uart_tx_buf>
    800038ec:	01c0006f          	j	80003908 <uartintr+0xf8>
    800038f0:	0006c703          	lbu	a4,0(a3)
    800038f4:	00f63023          	sd	a5,0(a2)
    800038f8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800038fc:	00063783          	ld	a5,0(a2)
    80003900:	00053703          	ld	a4,0(a0)
    80003904:	02f70063          	beq	a4,a5,80003924 <uartintr+0x114>
    80003908:	01f7f713          	andi	a4,a5,31
    8000390c:	00e806b3          	add	a3,a6,a4
    80003910:	0055c703          	lbu	a4,5(a1)
    80003914:	00178793          	addi	a5,a5,1
    80003918:	02077713          	andi	a4,a4,32
    8000391c:	fc071ae3          	bnez	a4,800038f0 <uartintr+0xe0>
    80003920:	00008067          	ret
    80003924:	00008067          	ret

0000000080003928 <kinit>:
    80003928:	fc010113          	addi	sp,sp,-64
    8000392c:	02913423          	sd	s1,40(sp)
    80003930:	fffff7b7          	lui	a5,0xfffff
    80003934:	00004497          	auipc	s1,0x4
    80003938:	57b48493          	addi	s1,s1,1403 # 80007eaf <end+0xfff>
    8000393c:	02813823          	sd	s0,48(sp)
    80003940:	01313c23          	sd	s3,24(sp)
    80003944:	00f4f4b3          	and	s1,s1,a5
    80003948:	02113c23          	sd	ra,56(sp)
    8000394c:	03213023          	sd	s2,32(sp)
    80003950:	01413823          	sd	s4,16(sp)
    80003954:	01513423          	sd	s5,8(sp)
    80003958:	04010413          	addi	s0,sp,64
    8000395c:	000017b7          	lui	a5,0x1
    80003960:	01100993          	li	s3,17
    80003964:	00f487b3          	add	a5,s1,a5
    80003968:	01b99993          	slli	s3,s3,0x1b
    8000396c:	06f9e063          	bltu	s3,a5,800039cc <kinit+0xa4>
    80003970:	00003a97          	auipc	s5,0x3
    80003974:	540a8a93          	addi	s5,s5,1344 # 80006eb0 <end>
    80003978:	0754ec63          	bltu	s1,s5,800039f0 <kinit+0xc8>
    8000397c:	0734fa63          	bgeu	s1,s3,800039f0 <kinit+0xc8>
    80003980:	00088a37          	lui	s4,0x88
    80003984:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80003988:	00002917          	auipc	s2,0x2
    8000398c:	06890913          	addi	s2,s2,104 # 800059f0 <kmem>
    80003990:	00ca1a13          	slli	s4,s4,0xc
    80003994:	0140006f          	j	800039a8 <kinit+0x80>
    80003998:	000017b7          	lui	a5,0x1
    8000399c:	00f484b3          	add	s1,s1,a5
    800039a0:	0554e863          	bltu	s1,s5,800039f0 <kinit+0xc8>
    800039a4:	0534f663          	bgeu	s1,s3,800039f0 <kinit+0xc8>
    800039a8:	00001637          	lui	a2,0x1
    800039ac:	00100593          	li	a1,1
    800039b0:	00048513          	mv	a0,s1
    800039b4:	00000097          	auipc	ra,0x0
    800039b8:	5e4080e7          	jalr	1508(ra) # 80003f98 <__memset>
    800039bc:	00093783          	ld	a5,0(s2)
    800039c0:	00f4b023          	sd	a5,0(s1)
    800039c4:	00993023          	sd	s1,0(s2)
    800039c8:	fd4498e3          	bne	s1,s4,80003998 <kinit+0x70>
    800039cc:	03813083          	ld	ra,56(sp)
    800039d0:	03013403          	ld	s0,48(sp)
    800039d4:	02813483          	ld	s1,40(sp)
    800039d8:	02013903          	ld	s2,32(sp)
    800039dc:	01813983          	ld	s3,24(sp)
    800039e0:	01013a03          	ld	s4,16(sp)
    800039e4:	00813a83          	ld	s5,8(sp)
    800039e8:	04010113          	addi	sp,sp,64
    800039ec:	00008067          	ret
    800039f0:	00001517          	auipc	a0,0x1
    800039f4:	7a050513          	addi	a0,a0,1952 # 80005190 <digits+0x18>
    800039f8:	fffff097          	auipc	ra,0xfffff
    800039fc:	4b4080e7          	jalr	1204(ra) # 80002eac <panic>

0000000080003a00 <freerange>:
    80003a00:	fc010113          	addi	sp,sp,-64
    80003a04:	000017b7          	lui	a5,0x1
    80003a08:	02913423          	sd	s1,40(sp)
    80003a0c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80003a10:	009504b3          	add	s1,a0,s1
    80003a14:	fffff537          	lui	a0,0xfffff
    80003a18:	02813823          	sd	s0,48(sp)
    80003a1c:	02113c23          	sd	ra,56(sp)
    80003a20:	03213023          	sd	s2,32(sp)
    80003a24:	01313c23          	sd	s3,24(sp)
    80003a28:	01413823          	sd	s4,16(sp)
    80003a2c:	01513423          	sd	s5,8(sp)
    80003a30:	01613023          	sd	s6,0(sp)
    80003a34:	04010413          	addi	s0,sp,64
    80003a38:	00a4f4b3          	and	s1,s1,a0
    80003a3c:	00f487b3          	add	a5,s1,a5
    80003a40:	06f5e463          	bltu	a1,a5,80003aa8 <freerange+0xa8>
    80003a44:	00003a97          	auipc	s5,0x3
    80003a48:	46ca8a93          	addi	s5,s5,1132 # 80006eb0 <end>
    80003a4c:	0954e263          	bltu	s1,s5,80003ad0 <freerange+0xd0>
    80003a50:	01100993          	li	s3,17
    80003a54:	01b99993          	slli	s3,s3,0x1b
    80003a58:	0734fc63          	bgeu	s1,s3,80003ad0 <freerange+0xd0>
    80003a5c:	00058a13          	mv	s4,a1
    80003a60:	00002917          	auipc	s2,0x2
    80003a64:	f9090913          	addi	s2,s2,-112 # 800059f0 <kmem>
    80003a68:	00002b37          	lui	s6,0x2
    80003a6c:	0140006f          	j	80003a80 <freerange+0x80>
    80003a70:	000017b7          	lui	a5,0x1
    80003a74:	00f484b3          	add	s1,s1,a5
    80003a78:	0554ec63          	bltu	s1,s5,80003ad0 <freerange+0xd0>
    80003a7c:	0534fa63          	bgeu	s1,s3,80003ad0 <freerange+0xd0>
    80003a80:	00001637          	lui	a2,0x1
    80003a84:	00100593          	li	a1,1
    80003a88:	00048513          	mv	a0,s1
    80003a8c:	00000097          	auipc	ra,0x0
    80003a90:	50c080e7          	jalr	1292(ra) # 80003f98 <__memset>
    80003a94:	00093703          	ld	a4,0(s2)
    80003a98:	016487b3          	add	a5,s1,s6
    80003a9c:	00e4b023          	sd	a4,0(s1)
    80003aa0:	00993023          	sd	s1,0(s2)
    80003aa4:	fcfa76e3          	bgeu	s4,a5,80003a70 <freerange+0x70>
    80003aa8:	03813083          	ld	ra,56(sp)
    80003aac:	03013403          	ld	s0,48(sp)
    80003ab0:	02813483          	ld	s1,40(sp)
    80003ab4:	02013903          	ld	s2,32(sp)
    80003ab8:	01813983          	ld	s3,24(sp)
    80003abc:	01013a03          	ld	s4,16(sp)
    80003ac0:	00813a83          	ld	s5,8(sp)
    80003ac4:	00013b03          	ld	s6,0(sp)
    80003ac8:	04010113          	addi	sp,sp,64
    80003acc:	00008067          	ret
    80003ad0:	00001517          	auipc	a0,0x1
    80003ad4:	6c050513          	addi	a0,a0,1728 # 80005190 <digits+0x18>
    80003ad8:	fffff097          	auipc	ra,0xfffff
    80003adc:	3d4080e7          	jalr	980(ra) # 80002eac <panic>

0000000080003ae0 <kfree>:
    80003ae0:	fe010113          	addi	sp,sp,-32
    80003ae4:	00813823          	sd	s0,16(sp)
    80003ae8:	00113c23          	sd	ra,24(sp)
    80003aec:	00913423          	sd	s1,8(sp)
    80003af0:	02010413          	addi	s0,sp,32
    80003af4:	03451793          	slli	a5,a0,0x34
    80003af8:	04079c63          	bnez	a5,80003b50 <kfree+0x70>
    80003afc:	00003797          	auipc	a5,0x3
    80003b00:	3b478793          	addi	a5,a5,948 # 80006eb0 <end>
    80003b04:	00050493          	mv	s1,a0
    80003b08:	04f56463          	bltu	a0,a5,80003b50 <kfree+0x70>
    80003b0c:	01100793          	li	a5,17
    80003b10:	01b79793          	slli	a5,a5,0x1b
    80003b14:	02f57e63          	bgeu	a0,a5,80003b50 <kfree+0x70>
    80003b18:	00001637          	lui	a2,0x1
    80003b1c:	00100593          	li	a1,1
    80003b20:	00000097          	auipc	ra,0x0
    80003b24:	478080e7          	jalr	1144(ra) # 80003f98 <__memset>
    80003b28:	00002797          	auipc	a5,0x2
    80003b2c:	ec878793          	addi	a5,a5,-312 # 800059f0 <kmem>
    80003b30:	0007b703          	ld	a4,0(a5)
    80003b34:	01813083          	ld	ra,24(sp)
    80003b38:	01013403          	ld	s0,16(sp)
    80003b3c:	00e4b023          	sd	a4,0(s1)
    80003b40:	0097b023          	sd	s1,0(a5)
    80003b44:	00813483          	ld	s1,8(sp)
    80003b48:	02010113          	addi	sp,sp,32
    80003b4c:	00008067          	ret
    80003b50:	00001517          	auipc	a0,0x1
    80003b54:	64050513          	addi	a0,a0,1600 # 80005190 <digits+0x18>
    80003b58:	fffff097          	auipc	ra,0xfffff
    80003b5c:	354080e7          	jalr	852(ra) # 80002eac <panic>

0000000080003b60 <kalloc>:
    80003b60:	fe010113          	addi	sp,sp,-32
    80003b64:	00813823          	sd	s0,16(sp)
    80003b68:	00913423          	sd	s1,8(sp)
    80003b6c:	00113c23          	sd	ra,24(sp)
    80003b70:	02010413          	addi	s0,sp,32
    80003b74:	00002797          	auipc	a5,0x2
    80003b78:	e7c78793          	addi	a5,a5,-388 # 800059f0 <kmem>
    80003b7c:	0007b483          	ld	s1,0(a5)
    80003b80:	02048063          	beqz	s1,80003ba0 <kalloc+0x40>
    80003b84:	0004b703          	ld	a4,0(s1)
    80003b88:	00001637          	lui	a2,0x1
    80003b8c:	00500593          	li	a1,5
    80003b90:	00048513          	mv	a0,s1
    80003b94:	00e7b023          	sd	a4,0(a5)
    80003b98:	00000097          	auipc	ra,0x0
    80003b9c:	400080e7          	jalr	1024(ra) # 80003f98 <__memset>
    80003ba0:	01813083          	ld	ra,24(sp)
    80003ba4:	01013403          	ld	s0,16(sp)
    80003ba8:	00048513          	mv	a0,s1
    80003bac:	00813483          	ld	s1,8(sp)
    80003bb0:	02010113          	addi	sp,sp,32
    80003bb4:	00008067          	ret

0000000080003bb8 <initlock>:
    80003bb8:	ff010113          	addi	sp,sp,-16
    80003bbc:	00813423          	sd	s0,8(sp)
    80003bc0:	01010413          	addi	s0,sp,16
    80003bc4:	00813403          	ld	s0,8(sp)
    80003bc8:	00b53423          	sd	a1,8(a0)
    80003bcc:	00052023          	sw	zero,0(a0)
    80003bd0:	00053823          	sd	zero,16(a0)
    80003bd4:	01010113          	addi	sp,sp,16
    80003bd8:	00008067          	ret

0000000080003bdc <acquire>:
    80003bdc:	fe010113          	addi	sp,sp,-32
    80003be0:	00813823          	sd	s0,16(sp)
    80003be4:	00913423          	sd	s1,8(sp)
    80003be8:	00113c23          	sd	ra,24(sp)
    80003bec:	01213023          	sd	s2,0(sp)
    80003bf0:	02010413          	addi	s0,sp,32
    80003bf4:	00050493          	mv	s1,a0
    80003bf8:	10002973          	csrr	s2,sstatus
    80003bfc:	100027f3          	csrr	a5,sstatus
    80003c00:	ffd7f793          	andi	a5,a5,-3
    80003c04:	10079073          	csrw	sstatus,a5
    80003c08:	fffff097          	auipc	ra,0xfffff
    80003c0c:	8e0080e7          	jalr	-1824(ra) # 800024e8 <mycpu>
    80003c10:	07852783          	lw	a5,120(a0)
    80003c14:	06078e63          	beqz	a5,80003c90 <acquire+0xb4>
    80003c18:	fffff097          	auipc	ra,0xfffff
    80003c1c:	8d0080e7          	jalr	-1840(ra) # 800024e8 <mycpu>
    80003c20:	07852783          	lw	a5,120(a0)
    80003c24:	0004a703          	lw	a4,0(s1)
    80003c28:	0017879b          	addiw	a5,a5,1
    80003c2c:	06f52c23          	sw	a5,120(a0)
    80003c30:	04071063          	bnez	a4,80003c70 <acquire+0x94>
    80003c34:	00100713          	li	a4,1
    80003c38:	00070793          	mv	a5,a4
    80003c3c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80003c40:	0007879b          	sext.w	a5,a5
    80003c44:	fe079ae3          	bnez	a5,80003c38 <acquire+0x5c>
    80003c48:	0ff0000f          	fence
    80003c4c:	fffff097          	auipc	ra,0xfffff
    80003c50:	89c080e7          	jalr	-1892(ra) # 800024e8 <mycpu>
    80003c54:	01813083          	ld	ra,24(sp)
    80003c58:	01013403          	ld	s0,16(sp)
    80003c5c:	00a4b823          	sd	a0,16(s1)
    80003c60:	00013903          	ld	s2,0(sp)
    80003c64:	00813483          	ld	s1,8(sp)
    80003c68:	02010113          	addi	sp,sp,32
    80003c6c:	00008067          	ret
    80003c70:	0104b903          	ld	s2,16(s1)
    80003c74:	fffff097          	auipc	ra,0xfffff
    80003c78:	874080e7          	jalr	-1932(ra) # 800024e8 <mycpu>
    80003c7c:	faa91ce3          	bne	s2,a0,80003c34 <acquire+0x58>
    80003c80:	00001517          	auipc	a0,0x1
    80003c84:	51850513          	addi	a0,a0,1304 # 80005198 <digits+0x20>
    80003c88:	fffff097          	auipc	ra,0xfffff
    80003c8c:	224080e7          	jalr	548(ra) # 80002eac <panic>
    80003c90:	00195913          	srli	s2,s2,0x1
    80003c94:	fffff097          	auipc	ra,0xfffff
    80003c98:	854080e7          	jalr	-1964(ra) # 800024e8 <mycpu>
    80003c9c:	00197913          	andi	s2,s2,1
    80003ca0:	07252e23          	sw	s2,124(a0)
    80003ca4:	f75ff06f          	j	80003c18 <acquire+0x3c>

0000000080003ca8 <release>:
    80003ca8:	fe010113          	addi	sp,sp,-32
    80003cac:	00813823          	sd	s0,16(sp)
    80003cb0:	00113c23          	sd	ra,24(sp)
    80003cb4:	00913423          	sd	s1,8(sp)
    80003cb8:	01213023          	sd	s2,0(sp)
    80003cbc:	02010413          	addi	s0,sp,32
    80003cc0:	00052783          	lw	a5,0(a0)
    80003cc4:	00079a63          	bnez	a5,80003cd8 <release+0x30>
    80003cc8:	00001517          	auipc	a0,0x1
    80003ccc:	4d850513          	addi	a0,a0,1240 # 800051a0 <digits+0x28>
    80003cd0:	fffff097          	auipc	ra,0xfffff
    80003cd4:	1dc080e7          	jalr	476(ra) # 80002eac <panic>
    80003cd8:	01053903          	ld	s2,16(a0)
    80003cdc:	00050493          	mv	s1,a0
    80003ce0:	fffff097          	auipc	ra,0xfffff
    80003ce4:	808080e7          	jalr	-2040(ra) # 800024e8 <mycpu>
    80003ce8:	fea910e3          	bne	s2,a0,80003cc8 <release+0x20>
    80003cec:	0004b823          	sd	zero,16(s1)
    80003cf0:	0ff0000f          	fence
    80003cf4:	0f50000f          	fence	iorw,ow
    80003cf8:	0804a02f          	amoswap.w	zero,zero,(s1)
    80003cfc:	ffffe097          	auipc	ra,0xffffe
    80003d00:	7ec080e7          	jalr	2028(ra) # 800024e8 <mycpu>
    80003d04:	100027f3          	csrr	a5,sstatus
    80003d08:	0027f793          	andi	a5,a5,2
    80003d0c:	04079a63          	bnez	a5,80003d60 <release+0xb8>
    80003d10:	07852783          	lw	a5,120(a0)
    80003d14:	02f05e63          	blez	a5,80003d50 <release+0xa8>
    80003d18:	fff7871b          	addiw	a4,a5,-1
    80003d1c:	06e52c23          	sw	a4,120(a0)
    80003d20:	00071c63          	bnez	a4,80003d38 <release+0x90>
    80003d24:	07c52783          	lw	a5,124(a0)
    80003d28:	00078863          	beqz	a5,80003d38 <release+0x90>
    80003d2c:	100027f3          	csrr	a5,sstatus
    80003d30:	0027e793          	ori	a5,a5,2
    80003d34:	10079073          	csrw	sstatus,a5
    80003d38:	01813083          	ld	ra,24(sp)
    80003d3c:	01013403          	ld	s0,16(sp)
    80003d40:	00813483          	ld	s1,8(sp)
    80003d44:	00013903          	ld	s2,0(sp)
    80003d48:	02010113          	addi	sp,sp,32
    80003d4c:	00008067          	ret
    80003d50:	00001517          	auipc	a0,0x1
    80003d54:	47050513          	addi	a0,a0,1136 # 800051c0 <digits+0x48>
    80003d58:	fffff097          	auipc	ra,0xfffff
    80003d5c:	154080e7          	jalr	340(ra) # 80002eac <panic>
    80003d60:	00001517          	auipc	a0,0x1
    80003d64:	44850513          	addi	a0,a0,1096 # 800051a8 <digits+0x30>
    80003d68:	fffff097          	auipc	ra,0xfffff
    80003d6c:	144080e7          	jalr	324(ra) # 80002eac <panic>

0000000080003d70 <holding>:
    80003d70:	00052783          	lw	a5,0(a0)
    80003d74:	00079663          	bnez	a5,80003d80 <holding+0x10>
    80003d78:	00000513          	li	a0,0
    80003d7c:	00008067          	ret
    80003d80:	fe010113          	addi	sp,sp,-32
    80003d84:	00813823          	sd	s0,16(sp)
    80003d88:	00913423          	sd	s1,8(sp)
    80003d8c:	00113c23          	sd	ra,24(sp)
    80003d90:	02010413          	addi	s0,sp,32
    80003d94:	01053483          	ld	s1,16(a0)
    80003d98:	ffffe097          	auipc	ra,0xffffe
    80003d9c:	750080e7          	jalr	1872(ra) # 800024e8 <mycpu>
    80003da0:	01813083          	ld	ra,24(sp)
    80003da4:	01013403          	ld	s0,16(sp)
    80003da8:	40a48533          	sub	a0,s1,a0
    80003dac:	00153513          	seqz	a0,a0
    80003db0:	00813483          	ld	s1,8(sp)
    80003db4:	02010113          	addi	sp,sp,32
    80003db8:	00008067          	ret

0000000080003dbc <push_off>:
    80003dbc:	fe010113          	addi	sp,sp,-32
    80003dc0:	00813823          	sd	s0,16(sp)
    80003dc4:	00113c23          	sd	ra,24(sp)
    80003dc8:	00913423          	sd	s1,8(sp)
    80003dcc:	02010413          	addi	s0,sp,32
    80003dd0:	100024f3          	csrr	s1,sstatus
    80003dd4:	100027f3          	csrr	a5,sstatus
    80003dd8:	ffd7f793          	andi	a5,a5,-3
    80003ddc:	10079073          	csrw	sstatus,a5
    80003de0:	ffffe097          	auipc	ra,0xffffe
    80003de4:	708080e7          	jalr	1800(ra) # 800024e8 <mycpu>
    80003de8:	07852783          	lw	a5,120(a0)
    80003dec:	02078663          	beqz	a5,80003e18 <push_off+0x5c>
    80003df0:	ffffe097          	auipc	ra,0xffffe
    80003df4:	6f8080e7          	jalr	1784(ra) # 800024e8 <mycpu>
    80003df8:	07852783          	lw	a5,120(a0)
    80003dfc:	01813083          	ld	ra,24(sp)
    80003e00:	01013403          	ld	s0,16(sp)
    80003e04:	0017879b          	addiw	a5,a5,1
    80003e08:	06f52c23          	sw	a5,120(a0)
    80003e0c:	00813483          	ld	s1,8(sp)
    80003e10:	02010113          	addi	sp,sp,32
    80003e14:	00008067          	ret
    80003e18:	0014d493          	srli	s1,s1,0x1
    80003e1c:	ffffe097          	auipc	ra,0xffffe
    80003e20:	6cc080e7          	jalr	1740(ra) # 800024e8 <mycpu>
    80003e24:	0014f493          	andi	s1,s1,1
    80003e28:	06952e23          	sw	s1,124(a0)
    80003e2c:	fc5ff06f          	j	80003df0 <push_off+0x34>

0000000080003e30 <pop_off>:
    80003e30:	ff010113          	addi	sp,sp,-16
    80003e34:	00813023          	sd	s0,0(sp)
    80003e38:	00113423          	sd	ra,8(sp)
    80003e3c:	01010413          	addi	s0,sp,16
    80003e40:	ffffe097          	auipc	ra,0xffffe
    80003e44:	6a8080e7          	jalr	1704(ra) # 800024e8 <mycpu>
    80003e48:	100027f3          	csrr	a5,sstatus
    80003e4c:	0027f793          	andi	a5,a5,2
    80003e50:	04079663          	bnez	a5,80003e9c <pop_off+0x6c>
    80003e54:	07852783          	lw	a5,120(a0)
    80003e58:	02f05a63          	blez	a5,80003e8c <pop_off+0x5c>
    80003e5c:	fff7871b          	addiw	a4,a5,-1
    80003e60:	06e52c23          	sw	a4,120(a0)
    80003e64:	00071c63          	bnez	a4,80003e7c <pop_off+0x4c>
    80003e68:	07c52783          	lw	a5,124(a0)
    80003e6c:	00078863          	beqz	a5,80003e7c <pop_off+0x4c>
    80003e70:	100027f3          	csrr	a5,sstatus
    80003e74:	0027e793          	ori	a5,a5,2
    80003e78:	10079073          	csrw	sstatus,a5
    80003e7c:	00813083          	ld	ra,8(sp)
    80003e80:	00013403          	ld	s0,0(sp)
    80003e84:	01010113          	addi	sp,sp,16
    80003e88:	00008067          	ret
    80003e8c:	00001517          	auipc	a0,0x1
    80003e90:	33450513          	addi	a0,a0,820 # 800051c0 <digits+0x48>
    80003e94:	fffff097          	auipc	ra,0xfffff
    80003e98:	018080e7          	jalr	24(ra) # 80002eac <panic>
    80003e9c:	00001517          	auipc	a0,0x1
    80003ea0:	30c50513          	addi	a0,a0,780 # 800051a8 <digits+0x30>
    80003ea4:	fffff097          	auipc	ra,0xfffff
    80003ea8:	008080e7          	jalr	8(ra) # 80002eac <panic>

0000000080003eac <push_on>:
    80003eac:	fe010113          	addi	sp,sp,-32
    80003eb0:	00813823          	sd	s0,16(sp)
    80003eb4:	00113c23          	sd	ra,24(sp)
    80003eb8:	00913423          	sd	s1,8(sp)
    80003ebc:	02010413          	addi	s0,sp,32
    80003ec0:	100024f3          	csrr	s1,sstatus
    80003ec4:	100027f3          	csrr	a5,sstatus
    80003ec8:	0027e793          	ori	a5,a5,2
    80003ecc:	10079073          	csrw	sstatus,a5
    80003ed0:	ffffe097          	auipc	ra,0xffffe
    80003ed4:	618080e7          	jalr	1560(ra) # 800024e8 <mycpu>
    80003ed8:	07852783          	lw	a5,120(a0)
    80003edc:	02078663          	beqz	a5,80003f08 <push_on+0x5c>
    80003ee0:	ffffe097          	auipc	ra,0xffffe
    80003ee4:	608080e7          	jalr	1544(ra) # 800024e8 <mycpu>
    80003ee8:	07852783          	lw	a5,120(a0)
    80003eec:	01813083          	ld	ra,24(sp)
    80003ef0:	01013403          	ld	s0,16(sp)
    80003ef4:	0017879b          	addiw	a5,a5,1
    80003ef8:	06f52c23          	sw	a5,120(a0)
    80003efc:	00813483          	ld	s1,8(sp)
    80003f00:	02010113          	addi	sp,sp,32
    80003f04:	00008067          	ret
    80003f08:	0014d493          	srli	s1,s1,0x1
    80003f0c:	ffffe097          	auipc	ra,0xffffe
    80003f10:	5dc080e7          	jalr	1500(ra) # 800024e8 <mycpu>
    80003f14:	0014f493          	andi	s1,s1,1
    80003f18:	06952e23          	sw	s1,124(a0)
    80003f1c:	fc5ff06f          	j	80003ee0 <push_on+0x34>

0000000080003f20 <pop_on>:
    80003f20:	ff010113          	addi	sp,sp,-16
    80003f24:	00813023          	sd	s0,0(sp)
    80003f28:	00113423          	sd	ra,8(sp)
    80003f2c:	01010413          	addi	s0,sp,16
    80003f30:	ffffe097          	auipc	ra,0xffffe
    80003f34:	5b8080e7          	jalr	1464(ra) # 800024e8 <mycpu>
    80003f38:	100027f3          	csrr	a5,sstatus
    80003f3c:	0027f793          	andi	a5,a5,2
    80003f40:	04078463          	beqz	a5,80003f88 <pop_on+0x68>
    80003f44:	07852783          	lw	a5,120(a0)
    80003f48:	02f05863          	blez	a5,80003f78 <pop_on+0x58>
    80003f4c:	fff7879b          	addiw	a5,a5,-1
    80003f50:	06f52c23          	sw	a5,120(a0)
    80003f54:	07853783          	ld	a5,120(a0)
    80003f58:	00079863          	bnez	a5,80003f68 <pop_on+0x48>
    80003f5c:	100027f3          	csrr	a5,sstatus
    80003f60:	ffd7f793          	andi	a5,a5,-3
    80003f64:	10079073          	csrw	sstatus,a5
    80003f68:	00813083          	ld	ra,8(sp)
    80003f6c:	00013403          	ld	s0,0(sp)
    80003f70:	01010113          	addi	sp,sp,16
    80003f74:	00008067          	ret
    80003f78:	00001517          	auipc	a0,0x1
    80003f7c:	27050513          	addi	a0,a0,624 # 800051e8 <digits+0x70>
    80003f80:	fffff097          	auipc	ra,0xfffff
    80003f84:	f2c080e7          	jalr	-212(ra) # 80002eac <panic>
    80003f88:	00001517          	auipc	a0,0x1
    80003f8c:	24050513          	addi	a0,a0,576 # 800051c8 <digits+0x50>
    80003f90:	fffff097          	auipc	ra,0xfffff
    80003f94:	f1c080e7          	jalr	-228(ra) # 80002eac <panic>

0000000080003f98 <__memset>:
    80003f98:	ff010113          	addi	sp,sp,-16
    80003f9c:	00813423          	sd	s0,8(sp)
    80003fa0:	01010413          	addi	s0,sp,16
    80003fa4:	1a060e63          	beqz	a2,80004160 <__memset+0x1c8>
    80003fa8:	40a007b3          	neg	a5,a0
    80003fac:	0077f793          	andi	a5,a5,7
    80003fb0:	00778693          	addi	a3,a5,7
    80003fb4:	00b00813          	li	a6,11
    80003fb8:	0ff5f593          	andi	a1,a1,255
    80003fbc:	fff6071b          	addiw	a4,a2,-1
    80003fc0:	1b06e663          	bltu	a3,a6,8000416c <__memset+0x1d4>
    80003fc4:	1cd76463          	bltu	a4,a3,8000418c <__memset+0x1f4>
    80003fc8:	1a078e63          	beqz	a5,80004184 <__memset+0x1ec>
    80003fcc:	00b50023          	sb	a1,0(a0)
    80003fd0:	00100713          	li	a4,1
    80003fd4:	1ae78463          	beq	a5,a4,8000417c <__memset+0x1e4>
    80003fd8:	00b500a3          	sb	a1,1(a0)
    80003fdc:	00200713          	li	a4,2
    80003fe0:	1ae78a63          	beq	a5,a4,80004194 <__memset+0x1fc>
    80003fe4:	00b50123          	sb	a1,2(a0)
    80003fe8:	00300713          	li	a4,3
    80003fec:	18e78463          	beq	a5,a4,80004174 <__memset+0x1dc>
    80003ff0:	00b501a3          	sb	a1,3(a0)
    80003ff4:	00400713          	li	a4,4
    80003ff8:	1ae78263          	beq	a5,a4,8000419c <__memset+0x204>
    80003ffc:	00b50223          	sb	a1,4(a0)
    80004000:	00500713          	li	a4,5
    80004004:	1ae78063          	beq	a5,a4,800041a4 <__memset+0x20c>
    80004008:	00b502a3          	sb	a1,5(a0)
    8000400c:	00700713          	li	a4,7
    80004010:	18e79e63          	bne	a5,a4,800041ac <__memset+0x214>
    80004014:	00b50323          	sb	a1,6(a0)
    80004018:	00700e93          	li	t4,7
    8000401c:	00859713          	slli	a4,a1,0x8
    80004020:	00e5e733          	or	a4,a1,a4
    80004024:	01059e13          	slli	t3,a1,0x10
    80004028:	01c76e33          	or	t3,a4,t3
    8000402c:	01859313          	slli	t1,a1,0x18
    80004030:	006e6333          	or	t1,t3,t1
    80004034:	02059893          	slli	a7,a1,0x20
    80004038:	40f60e3b          	subw	t3,a2,a5
    8000403c:	011368b3          	or	a7,t1,a7
    80004040:	02859813          	slli	a6,a1,0x28
    80004044:	0108e833          	or	a6,a7,a6
    80004048:	03059693          	slli	a3,a1,0x30
    8000404c:	003e589b          	srliw	a7,t3,0x3
    80004050:	00d866b3          	or	a3,a6,a3
    80004054:	03859713          	slli	a4,a1,0x38
    80004058:	00389813          	slli	a6,a7,0x3
    8000405c:	00f507b3          	add	a5,a0,a5
    80004060:	00e6e733          	or	a4,a3,a4
    80004064:	000e089b          	sext.w	a7,t3
    80004068:	00f806b3          	add	a3,a6,a5
    8000406c:	00e7b023          	sd	a4,0(a5)
    80004070:	00878793          	addi	a5,a5,8
    80004074:	fed79ce3          	bne	a5,a3,8000406c <__memset+0xd4>
    80004078:	ff8e7793          	andi	a5,t3,-8
    8000407c:	0007871b          	sext.w	a4,a5
    80004080:	01d787bb          	addw	a5,a5,t4
    80004084:	0ce88e63          	beq	a7,a4,80004160 <__memset+0x1c8>
    80004088:	00f50733          	add	a4,a0,a5
    8000408c:	00b70023          	sb	a1,0(a4)
    80004090:	0017871b          	addiw	a4,a5,1
    80004094:	0cc77663          	bgeu	a4,a2,80004160 <__memset+0x1c8>
    80004098:	00e50733          	add	a4,a0,a4
    8000409c:	00b70023          	sb	a1,0(a4)
    800040a0:	0027871b          	addiw	a4,a5,2
    800040a4:	0ac77e63          	bgeu	a4,a2,80004160 <__memset+0x1c8>
    800040a8:	00e50733          	add	a4,a0,a4
    800040ac:	00b70023          	sb	a1,0(a4)
    800040b0:	0037871b          	addiw	a4,a5,3
    800040b4:	0ac77663          	bgeu	a4,a2,80004160 <__memset+0x1c8>
    800040b8:	00e50733          	add	a4,a0,a4
    800040bc:	00b70023          	sb	a1,0(a4)
    800040c0:	0047871b          	addiw	a4,a5,4
    800040c4:	08c77e63          	bgeu	a4,a2,80004160 <__memset+0x1c8>
    800040c8:	00e50733          	add	a4,a0,a4
    800040cc:	00b70023          	sb	a1,0(a4)
    800040d0:	0057871b          	addiw	a4,a5,5
    800040d4:	08c77663          	bgeu	a4,a2,80004160 <__memset+0x1c8>
    800040d8:	00e50733          	add	a4,a0,a4
    800040dc:	00b70023          	sb	a1,0(a4)
    800040e0:	0067871b          	addiw	a4,a5,6
    800040e4:	06c77e63          	bgeu	a4,a2,80004160 <__memset+0x1c8>
    800040e8:	00e50733          	add	a4,a0,a4
    800040ec:	00b70023          	sb	a1,0(a4)
    800040f0:	0077871b          	addiw	a4,a5,7
    800040f4:	06c77663          	bgeu	a4,a2,80004160 <__memset+0x1c8>
    800040f8:	00e50733          	add	a4,a0,a4
    800040fc:	00b70023          	sb	a1,0(a4)
    80004100:	0087871b          	addiw	a4,a5,8
    80004104:	04c77e63          	bgeu	a4,a2,80004160 <__memset+0x1c8>
    80004108:	00e50733          	add	a4,a0,a4
    8000410c:	00b70023          	sb	a1,0(a4)
    80004110:	0097871b          	addiw	a4,a5,9
    80004114:	04c77663          	bgeu	a4,a2,80004160 <__memset+0x1c8>
    80004118:	00e50733          	add	a4,a0,a4
    8000411c:	00b70023          	sb	a1,0(a4)
    80004120:	00a7871b          	addiw	a4,a5,10
    80004124:	02c77e63          	bgeu	a4,a2,80004160 <__memset+0x1c8>
    80004128:	00e50733          	add	a4,a0,a4
    8000412c:	00b70023          	sb	a1,0(a4)
    80004130:	00b7871b          	addiw	a4,a5,11
    80004134:	02c77663          	bgeu	a4,a2,80004160 <__memset+0x1c8>
    80004138:	00e50733          	add	a4,a0,a4
    8000413c:	00b70023          	sb	a1,0(a4)
    80004140:	00c7871b          	addiw	a4,a5,12
    80004144:	00c77e63          	bgeu	a4,a2,80004160 <__memset+0x1c8>
    80004148:	00e50733          	add	a4,a0,a4
    8000414c:	00b70023          	sb	a1,0(a4)
    80004150:	00d7879b          	addiw	a5,a5,13
    80004154:	00c7f663          	bgeu	a5,a2,80004160 <__memset+0x1c8>
    80004158:	00f507b3          	add	a5,a0,a5
    8000415c:	00b78023          	sb	a1,0(a5)
    80004160:	00813403          	ld	s0,8(sp)
    80004164:	01010113          	addi	sp,sp,16
    80004168:	00008067          	ret
    8000416c:	00b00693          	li	a3,11
    80004170:	e55ff06f          	j	80003fc4 <__memset+0x2c>
    80004174:	00300e93          	li	t4,3
    80004178:	ea5ff06f          	j	8000401c <__memset+0x84>
    8000417c:	00100e93          	li	t4,1
    80004180:	e9dff06f          	j	8000401c <__memset+0x84>
    80004184:	00000e93          	li	t4,0
    80004188:	e95ff06f          	j	8000401c <__memset+0x84>
    8000418c:	00000793          	li	a5,0
    80004190:	ef9ff06f          	j	80004088 <__memset+0xf0>
    80004194:	00200e93          	li	t4,2
    80004198:	e85ff06f          	j	8000401c <__memset+0x84>
    8000419c:	00400e93          	li	t4,4
    800041a0:	e7dff06f          	j	8000401c <__memset+0x84>
    800041a4:	00500e93          	li	t4,5
    800041a8:	e75ff06f          	j	8000401c <__memset+0x84>
    800041ac:	00600e93          	li	t4,6
    800041b0:	e6dff06f          	j	8000401c <__memset+0x84>

00000000800041b4 <__memmove>:
    800041b4:	ff010113          	addi	sp,sp,-16
    800041b8:	00813423          	sd	s0,8(sp)
    800041bc:	01010413          	addi	s0,sp,16
    800041c0:	0e060863          	beqz	a2,800042b0 <__memmove+0xfc>
    800041c4:	fff6069b          	addiw	a3,a2,-1
    800041c8:	0006881b          	sext.w	a6,a3
    800041cc:	0ea5e863          	bltu	a1,a0,800042bc <__memmove+0x108>
    800041d0:	00758713          	addi	a4,a1,7
    800041d4:	00a5e7b3          	or	a5,a1,a0
    800041d8:	40a70733          	sub	a4,a4,a0
    800041dc:	0077f793          	andi	a5,a5,7
    800041e0:	00f73713          	sltiu	a4,a4,15
    800041e4:	00174713          	xori	a4,a4,1
    800041e8:	0017b793          	seqz	a5,a5
    800041ec:	00e7f7b3          	and	a5,a5,a4
    800041f0:	10078863          	beqz	a5,80004300 <__memmove+0x14c>
    800041f4:	00900793          	li	a5,9
    800041f8:	1107f463          	bgeu	a5,a6,80004300 <__memmove+0x14c>
    800041fc:	0036581b          	srliw	a6,a2,0x3
    80004200:	fff8081b          	addiw	a6,a6,-1
    80004204:	02081813          	slli	a6,a6,0x20
    80004208:	01d85893          	srli	a7,a6,0x1d
    8000420c:	00858813          	addi	a6,a1,8
    80004210:	00058793          	mv	a5,a1
    80004214:	00050713          	mv	a4,a0
    80004218:	01088833          	add	a6,a7,a6
    8000421c:	0007b883          	ld	a7,0(a5)
    80004220:	00878793          	addi	a5,a5,8
    80004224:	00870713          	addi	a4,a4,8
    80004228:	ff173c23          	sd	a7,-8(a4)
    8000422c:	ff0798e3          	bne	a5,a6,8000421c <__memmove+0x68>
    80004230:	ff867713          	andi	a4,a2,-8
    80004234:	02071793          	slli	a5,a4,0x20
    80004238:	0207d793          	srli	a5,a5,0x20
    8000423c:	00f585b3          	add	a1,a1,a5
    80004240:	40e686bb          	subw	a3,a3,a4
    80004244:	00f507b3          	add	a5,a0,a5
    80004248:	06e60463          	beq	a2,a4,800042b0 <__memmove+0xfc>
    8000424c:	0005c703          	lbu	a4,0(a1)
    80004250:	00e78023          	sb	a4,0(a5)
    80004254:	04068e63          	beqz	a3,800042b0 <__memmove+0xfc>
    80004258:	0015c603          	lbu	a2,1(a1)
    8000425c:	00100713          	li	a4,1
    80004260:	00c780a3          	sb	a2,1(a5)
    80004264:	04e68663          	beq	a3,a4,800042b0 <__memmove+0xfc>
    80004268:	0025c603          	lbu	a2,2(a1)
    8000426c:	00200713          	li	a4,2
    80004270:	00c78123          	sb	a2,2(a5)
    80004274:	02e68e63          	beq	a3,a4,800042b0 <__memmove+0xfc>
    80004278:	0035c603          	lbu	a2,3(a1)
    8000427c:	00300713          	li	a4,3
    80004280:	00c781a3          	sb	a2,3(a5)
    80004284:	02e68663          	beq	a3,a4,800042b0 <__memmove+0xfc>
    80004288:	0045c603          	lbu	a2,4(a1)
    8000428c:	00400713          	li	a4,4
    80004290:	00c78223          	sb	a2,4(a5)
    80004294:	00e68e63          	beq	a3,a4,800042b0 <__memmove+0xfc>
    80004298:	0055c603          	lbu	a2,5(a1)
    8000429c:	00500713          	li	a4,5
    800042a0:	00c782a3          	sb	a2,5(a5)
    800042a4:	00e68663          	beq	a3,a4,800042b0 <__memmove+0xfc>
    800042a8:	0065c703          	lbu	a4,6(a1)
    800042ac:	00e78323          	sb	a4,6(a5)
    800042b0:	00813403          	ld	s0,8(sp)
    800042b4:	01010113          	addi	sp,sp,16
    800042b8:	00008067          	ret
    800042bc:	02061713          	slli	a4,a2,0x20
    800042c0:	02075713          	srli	a4,a4,0x20
    800042c4:	00e587b3          	add	a5,a1,a4
    800042c8:	f0f574e3          	bgeu	a0,a5,800041d0 <__memmove+0x1c>
    800042cc:	02069613          	slli	a2,a3,0x20
    800042d0:	02065613          	srli	a2,a2,0x20
    800042d4:	fff64613          	not	a2,a2
    800042d8:	00e50733          	add	a4,a0,a4
    800042dc:	00c78633          	add	a2,a5,a2
    800042e0:	fff7c683          	lbu	a3,-1(a5)
    800042e4:	fff78793          	addi	a5,a5,-1
    800042e8:	fff70713          	addi	a4,a4,-1
    800042ec:	00d70023          	sb	a3,0(a4)
    800042f0:	fec798e3          	bne	a5,a2,800042e0 <__memmove+0x12c>
    800042f4:	00813403          	ld	s0,8(sp)
    800042f8:	01010113          	addi	sp,sp,16
    800042fc:	00008067          	ret
    80004300:	02069713          	slli	a4,a3,0x20
    80004304:	02075713          	srli	a4,a4,0x20
    80004308:	00170713          	addi	a4,a4,1
    8000430c:	00e50733          	add	a4,a0,a4
    80004310:	00050793          	mv	a5,a0
    80004314:	0005c683          	lbu	a3,0(a1)
    80004318:	00178793          	addi	a5,a5,1
    8000431c:	00158593          	addi	a1,a1,1
    80004320:	fed78fa3          	sb	a3,-1(a5)
    80004324:	fee798e3          	bne	a5,a4,80004314 <__memmove+0x160>
    80004328:	f89ff06f          	j	800042b0 <__memmove+0xfc>
	...
