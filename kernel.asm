
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00008117          	auipc	sp,0x8
    80000004:	7a013103          	ld	sp,1952(sp) # 800087a0 <_GLOBAL_OFFSET_TABLE_+0x30>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	755030ef          	jal	ra,80003f70 <start>

0000000080000020 <spin>:
    80000020:	0000006f          	j	80000020 <spin>
	...

0000000080001000 <copy_and_swap>:
# a1 holds expected value
# a2 holds desired value
# a0 holds return value, 0 if successful, !0 otherwise
.global copy_and_swap
copy_and_swap:
    lr.w t0, (a0)          # Load original value.
    80001000:	100522af          	lr.w	t0,(a0)
    bne t0, a1, fail       # Doesn’t match, so fail.
    80001004:	00b29a63          	bne	t0,a1,80001018 <fail>
    sc.w t0, a2, (a0)      # Try to update.
    80001008:	18c522af          	sc.w	t0,a2,(a0)
    bnez t0, copy_and_swap # Retry if store-conditional failed.
    8000100c:	fe029ae3          	bnez	t0,80001000 <copy_and_swap>
    li a0, 0               # Set return to success.
    80001010:	00000513          	li	a0,0
    jr ra                  # Return.
    80001014:	00008067          	ret

0000000080001018 <fail>:
    fail:
    li a0, 1               # Set return to failure.
    80001018:	00100513          	li	a0,1
    8000101c:	00008067          	ret

0000000080001020 <system_call>:
.global system_call
.type system_call, @function
system_call:
    addi t0, a0, 0x0
    80001020:	00050293          	mv	t0,a0
    ld a0, 0x0(t0)
    80001024:	0002b503          	ld	a0,0(t0)
    ld a1, 0x8(t0)
    80001028:	0082b583          	ld	a1,8(t0)
    ld a2, 0x10(t0)
    8000102c:	0102b603          	ld	a2,16(t0)
    ld a3, 0x18(t0)
    80001030:	0182b683          	ld	a3,24(t0)
    ld a4, 0x20(t0)
    80001034:	0202b703          	ld	a4,32(t0)
    ld a5, 0x28(t0)
    80001038:	0282b783          	ld	a5,40(t0)
    ld a6, 0x30(t0)
    8000103c:	0302b803          	ld	a6,48(t0)
    ld a7, 0x38(t0)
    80001040:	0382b883          	ld	a7,56(t0)
    ecall
    80001044:	00000073          	ecall
    ret
    80001048:	00008067          	ret
    8000104c:	0000                	unimp
	...

0000000080001050 <interrupt_trap>:
.extern _ZN6Kernel16interruptHandlerEv
.align 4
.global interrupt_trap
.type interrupt_trap, @function
interrupt_trap:
    addi sp, sp, -16
    80001050:	ff010113          	addi	sp,sp,-16
    sd t0, 8(sp)
    80001054:	00513423          	sd	t0,8(sp)

    csrr t0, sstatus
    80001058:	100022f3          	csrr	t0,sstatus
    andi t0, t0, 0x10
    8000105c:	0102f293          	andi	t0,t0,16
    bne t0, x0, system_stack
    80001060:	00029663          	bnez	t0,8000106c <system_stack>

    addi t0, sp, 0
    80001064:	00010293          	mv	t0,sp
    csrr sp, sscratch
    80001068:	14002173          	csrr	sp,sscratch

000000008000106c <system_stack>:

system_stack:    addi sp, sp, -256
    8000106c:	f0010113          	addi	sp,sp,-256

    sd x0, 0 * 8(sp)
    80001070:	00013023          	sd	zero,0(sp)
    sd x1, 1 * 8(sp)
    80001074:	00113423          	sd	ra,8(sp)
    sd t0, 2 * 8(sp)
    80001078:	00513823          	sd	t0,16(sp)
    .irp index,  3, 4, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31
    sd x\index, \index * 8(sp)
    .endr
    8000107c:	00313c23          	sd	gp,24(sp)
    80001080:	02413023          	sd	tp,32(sp)
    80001084:	02613823          	sd	t1,48(sp)
    80001088:	02713c23          	sd	t2,56(sp)
    8000108c:	04813023          	sd	s0,64(sp)
    80001090:	04913423          	sd	s1,72(sp)
    80001094:	04a13823          	sd	a0,80(sp)
    80001098:	04b13c23          	sd	a1,88(sp)
    8000109c:	06c13023          	sd	a2,96(sp)
    800010a0:	06d13423          	sd	a3,104(sp)
    800010a4:	06e13823          	sd	a4,112(sp)
    800010a8:	06f13c23          	sd	a5,120(sp)
    800010ac:	09013023          	sd	a6,128(sp)
    800010b0:	09113423          	sd	a7,136(sp)
    800010b4:	09213823          	sd	s2,144(sp)
    800010b8:	09313c23          	sd	s3,152(sp)
    800010bc:	0b413023          	sd	s4,160(sp)
    800010c0:	0b513423          	sd	s5,168(sp)
    800010c4:	0b613823          	sd	s6,176(sp)
    800010c8:	0b713c23          	sd	s7,184(sp)
    800010cc:	0d813023          	sd	s8,192(sp)
    800010d0:	0d913423          	sd	s9,200(sp)
    800010d4:	0da13823          	sd	s10,208(sp)
    800010d8:	0db13c23          	sd	s11,216(sp)
    800010dc:	0fc13023          	sd	t3,224(sp)
    800010e0:	0fd13423          	sd	t4,232(sp)
    800010e4:	0fe13823          	sd	t5,240(sp)
    800010e8:	0ff13c23          	sd	t6,248(sp)
    ld t0, 8(t0)
    800010ec:	0082b283          	ld	t0,8(t0)
    sd t0, 5 * 8(sp)
    800010f0:	02513423          	sd	t0,40(sp)

    addi s0, sp, 256
    800010f4:	10010413          	addi	s0,sp,256
    auipc t0, 0
    800010f8:	00000297          	auipc	t0,0x0
    addi t0, t0, 16
    800010fc:	01028293          	addi	t0,t0,16 # 80001108 <system_stack+0x9c>
    csrw sscratch, t0
    80001100:	14029073          	csrw	sscratch,t0

    call _ZN6Kernel16interruptHandlerEv
    80001104:	094020ef          	jal	ra,80003198 <_ZN6Kernel16interruptHandlerEv>

    ld x0, 0 * 8(sp)
    80001108:	00013003          	ld	zero,0(sp)
    ld x1, 1 * 8(sp)
    8000110c:	00813083          	ld	ra,8(sp)
    ld t0, 2 * 8(sp)
    80001110:	01013283          	ld	t0,16(sp)
    .irp index,  3, 4, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31
    sd x\index, \index * 8(sp)
    .endr
    80001114:	00313c23          	sd	gp,24(sp)
    80001118:	02413023          	sd	tp,32(sp)
    8000111c:	02613823          	sd	t1,48(sp)
    80001120:	02713c23          	sd	t2,56(sp)
    80001124:	04813023          	sd	s0,64(sp)
    80001128:	04913423          	sd	s1,72(sp)
    8000112c:	04a13823          	sd	a0,80(sp)
    80001130:	04b13c23          	sd	a1,88(sp)
    80001134:	06c13023          	sd	a2,96(sp)
    80001138:	06d13423          	sd	a3,104(sp)
    8000113c:	06e13823          	sd	a4,112(sp)
    80001140:	06f13c23          	sd	a5,120(sp)
    80001144:	09013023          	sd	a6,128(sp)
    80001148:	09113423          	sd	a7,136(sp)
    8000114c:	09213823          	sd	s2,144(sp)
    80001150:	09313c23          	sd	s3,152(sp)
    80001154:	0b413023          	sd	s4,160(sp)
    80001158:	0b513423          	sd	s5,168(sp)
    8000115c:	0b613823          	sd	s6,176(sp)
    80001160:	0b713c23          	sd	s7,184(sp)
    80001164:	0d813023          	sd	s8,192(sp)
    80001168:	0d913423          	sd	s9,200(sp)
    8000116c:	0da13823          	sd	s10,208(sp)
    80001170:	0db13c23          	sd	s11,216(sp)
    80001174:	0fc13023          	sd	t3,224(sp)
    80001178:	0fd13423          	sd	t4,232(sp)
    8000117c:	0fe13823          	sd	t5,240(sp)
    80001180:	0ff13c23          	sd	t6,248(sp)

    addi sp, sp, 256
    80001184:	10010113          	addi	sp,sp,256

    csrw sscratch, sp
    80001188:	14011073          	csrw	sscratch,sp

    addi sp, t0, 0
    8000118c:	00028113          	mv	sp,t0
    ld t0, 8(sp)
    80001190:	00813283          	ld	t0,8(sp)
    addi sp, sp, 16
    80001194:	01010113          	addi	sp,sp,16
    80001198:	10200073          	sret
    8000119c:	0000                	unimp
	...

00000000800011a0 <context_switch>:
.global context_switch
.type context_switch, @function
context_switch:
    sd ra, 0 * 8(a0)
    800011a0:	00153023          	sd	ra,0(a0) # 1000 <_entry-0x7ffff000>
    sd sp, 1 * 8(a0)
    800011a4:	00253423          	sd	sp,8(a0)


    ld ra, 0 * 8(a1)
    800011a8:	0005b083          	ld	ra,0(a1)
    ld sp, 1 * 8(a1)
    800011ac:	0085b103          	ld	sp,8(a1)
    ld t0, 2 * 8(a1)
    800011b0:	0105b283          	ld	t0,16(a1)

    beq t0, x0, continue
    800011b4:	00028663          	beqz	t0,800011c0 <continue>
    slli t0, t0, 8
    800011b8:	00829293          	slli	t0,t0,0x8
    csrs sstatus, t0
    800011bc:	1002a073          	csrs	sstatus,t0

00000000800011c0 <continue>:

    800011c0:	00008067          	ret

00000000800011c4 <_Z9mem_allocm>:


extern "C" uint64 system_call(Arguments* arg);

void* mem_alloc(size_t size)
{
    800011c4:	fa010113          	addi	sp,sp,-96
    800011c8:	04113c23          	sd	ra,88(sp)
    800011cc:	04813823          	sd	s0,80(sp)
    800011d0:	04913423          	sd	s1,72(sp)
    800011d4:	05213023          	sd	s2,64(sp)
    800011d8:	06010413          	addi	s0,sp,96
    800011dc:	00050493          	mv	s1,a0
    uint64 size_of_blocks = (size + MemoryAllocator::getSizeOfMetaData()) / MEM_BLOCK_SIZE;
    800011e0:	00001097          	auipc	ra,0x1
    800011e4:	664080e7          	jalr	1636(ra) # 80002844 <_ZN15MemoryAllocator17getSizeOfMetaDataEv>
    800011e8:	00950933          	add	s2,a0,s1
    800011ec:	00695913          	srli	s2,s2,0x6
    size_of_blocks += (size + MemoryAllocator::getSizeOfMetaData()) % MEM_BLOCK_SIZE ? 1: 0;
    800011f0:	00001097          	auipc	ra,0x1
    800011f4:	654080e7          	jalr	1620(ra) # 80002844 <_ZN15MemoryAllocator17getSizeOfMetaDataEv>
    800011f8:	00a484b3          	add	s1,s1,a0
    800011fc:	03f4f493          	andi	s1,s1,63
    80001200:	04048a63          	beqz	s1,80001254 <_Z9mem_allocm+0x90>
    80001204:	00100513          	li	a0,1
    80001208:	01250933          	add	s2,a0,s2
    Arguments arg = {KernelConfig::MEM_ALLOC, size_of_blocks, 0, 0, 0, 0, 0, 0};
    8000120c:	fa043823          	sd	zero,-80(s0)
    80001210:	fa043c23          	sd	zero,-72(s0)
    80001214:	fc043023          	sd	zero,-64(s0)
    80001218:	fc043423          	sd	zero,-56(s0)
    8000121c:	fc043823          	sd	zero,-48(s0)
    80001220:	fc043c23          	sd	zero,-40(s0)
    80001224:	00100793          	li	a5,1
    80001228:	faf43023          	sd	a5,-96(s0)
    8000122c:	fb243423          	sd	s2,-88(s0)
    return (void*) system_call(&arg);
    80001230:	fa040513          	addi	a0,s0,-96
    80001234:	00000097          	auipc	ra,0x0
    80001238:	dec080e7          	jalr	-532(ra) # 80001020 <system_call>
}
    8000123c:	05813083          	ld	ra,88(sp)
    80001240:	05013403          	ld	s0,80(sp)
    80001244:	04813483          	ld	s1,72(sp)
    80001248:	04013903          	ld	s2,64(sp)
    8000124c:	06010113          	addi	sp,sp,96
    80001250:	00008067          	ret
    size_of_blocks += (size + MemoryAllocator::getSizeOfMetaData()) % MEM_BLOCK_SIZE ? 1: 0;
    80001254:	00000513          	li	a0,0
    80001258:	fb1ff06f          	j	80001208 <_Z9mem_allocm+0x44>

000000008000125c <_Z8mem_freePv>:

int mem_free(void* obj)
{   Arguments arg = {KernelConfig::MEM_FREE, (uint64)obj, 0, 0, 0, 0, 0, 0};
    8000125c:	fb010113          	addi	sp,sp,-80
    80001260:	04113423          	sd	ra,72(sp)
    80001264:	04813023          	sd	s0,64(sp)
    80001268:	05010413          	addi	s0,sp,80
    8000126c:	fc043023          	sd	zero,-64(s0)
    80001270:	fc043423          	sd	zero,-56(s0)
    80001274:	fc043823          	sd	zero,-48(s0)
    80001278:	fc043c23          	sd	zero,-40(s0)
    8000127c:	fe043023          	sd	zero,-32(s0)
    80001280:	fe043423          	sd	zero,-24(s0)
    80001284:	00200793          	li	a5,2
    80001288:	faf43823          	sd	a5,-80(s0)
    8000128c:	faa43c23          	sd	a0,-72(s0)
    return (int) system_call(&arg);
    80001290:	fb040513          	addi	a0,s0,-80
    80001294:	00000097          	auipc	ra,0x0
    80001298:	d8c080e7          	jalr	-628(ra) # 80001020 <system_call>
}
    8000129c:	0005051b          	sext.w	a0,a0
    800012a0:	04813083          	ld	ra,72(sp)
    800012a4:	04013403          	ld	s0,64(sp)
    800012a8:	05010113          	addi	sp,sp,80
    800012ac:	00008067          	ret

00000000800012b0 <_Z18mem_get_free_spacev>:

size_t mem_get_free_space()
{
    800012b0:	fb010113          	addi	sp,sp,-80
    800012b4:	04113423          	sd	ra,72(sp)
    800012b8:	04813023          	sd	s0,64(sp)
    800012bc:	05010413          	addi	s0,sp,80
    Arguments arg = {KernelConfig::MEM_FREE_SPACE, 0, 0, 0, 0, 0, 0, 0};
    800012c0:	00300793          	li	a5,3
    800012c4:	faf43823          	sd	a5,-80(s0)
    800012c8:	fa043c23          	sd	zero,-72(s0)
    800012cc:	fc043023          	sd	zero,-64(s0)
    800012d0:	fc043423          	sd	zero,-56(s0)
    800012d4:	fc043823          	sd	zero,-48(s0)
    800012d8:	fc043c23          	sd	zero,-40(s0)
    800012dc:	fe043023          	sd	zero,-32(s0)
    800012e0:	fe043423          	sd	zero,-24(s0)
    return (size_t) system_call(&arg);
    800012e4:	fb040513          	addi	a0,s0,-80
    800012e8:	00000097          	auipc	ra,0x0
    800012ec:	d38080e7          	jalr	-712(ra) # 80001020 <system_call>
}
    800012f0:	04813083          	ld	ra,72(sp)
    800012f4:	04013403          	ld	s0,64(sp)
    800012f8:	05010113          	addi	sp,sp,80
    800012fc:	00008067          	ret

0000000080001300 <_Z26mem_get_largest_free_blockv>:
size_t mem_get_largest_free_block()
{
    80001300:	fb010113          	addi	sp,sp,-80
    80001304:	04113423          	sd	ra,72(sp)
    80001308:	04813023          	sd	s0,64(sp)
    8000130c:	05010413          	addi	s0,sp,80
    Arguments arg = {KernelConfig::LARGEST_FREE_BLOCK, 0, 0, 0, 0, 0, 0, 0};
    80001310:	00400793          	li	a5,4
    80001314:	faf43823          	sd	a5,-80(s0)
    80001318:	fa043c23          	sd	zero,-72(s0)
    8000131c:	fc043023          	sd	zero,-64(s0)
    80001320:	fc043423          	sd	zero,-56(s0)
    80001324:	fc043823          	sd	zero,-48(s0)
    80001328:	fc043c23          	sd	zero,-40(s0)
    8000132c:	fe043023          	sd	zero,-32(s0)
    80001330:	fe043423          	sd	zero,-24(s0)
    return (size_t) system_call(&arg);
    80001334:	fb040513          	addi	a0,s0,-80
    80001338:	00000097          	auipc	ra,0x0
    8000133c:	ce8080e7          	jalr	-792(ra) # 80001020 <system_call>
}
    80001340:	04813083          	ld	ra,72(sp)
    80001344:	04013403          	ld	s0,64(sp)
    80001348:	05010113          	addi	sp,sp,80
    8000134c:	00008067          	ret

0000000080001350 <_Z13thread_createPP3TCBPFvPvES2_>:

int thread_create(thread_t* handle, void(*start_routine)(void*), void* argOfRoutine)
{
    80001350:	f9010113          	addi	sp,sp,-112
    80001354:	06113423          	sd	ra,104(sp)
    80001358:	06813023          	sd	s0,96(sp)
    8000135c:	04913c23          	sd	s1,88(sp)
    80001360:	05213823          	sd	s2,80(sp)
    80001364:	05313423          	sd	s3,72(sp)
    80001368:	07010413          	addi	s0,sp,112
    8000136c:	00050993          	mv	s3,a0
    80001370:	00058913          	mv	s2,a1
    80001374:	00060493          	mv	s1,a2
    uint8* threadStack = (uint8*)mem_alloc(DEFAULT_STACK_SIZE);
    80001378:	00001537          	lui	a0,0x1
    8000137c:	00000097          	auipc	ra,0x0
    80001380:	e48080e7          	jalr	-440(ra) # 800011c4 <_Z9mem_allocm>
    if(threadStack == nullptr)
    80001384:	04050e63          	beqz	a0,800013e0 <_Z13thread_createPP3TCBPFvPvES2_+0x90>
    {
        return -1;
    }

    Arguments arg = {KernelConfig::THREAD_CREATE, (uint64)handle, (uint64)start_routine, (uint64)argOfRoutine, (uint64)(&threadStack[DEFAULT_STACK_SIZE]), 0, 0, 0};
    80001388:	fa043c23          	sd	zero,-72(s0)
    8000138c:	fc043023          	sd	zero,-64(s0)
    80001390:	fc043423          	sd	zero,-56(s0)
    80001394:	01100793          	li	a5,17
    80001398:	f8f43823          	sd	a5,-112(s0)
    8000139c:	f9343c23          	sd	s3,-104(s0)
    800013a0:	fb243023          	sd	s2,-96(s0)
    800013a4:	fa943423          	sd	s1,-88(s0)
    800013a8:	000017b7          	lui	a5,0x1
    800013ac:	00f50533          	add	a0,a0,a5
    800013b0:	faa43823          	sd	a0,-80(s0)

    return (int) system_call(&arg);
    800013b4:	f9040513          	addi	a0,s0,-112
    800013b8:	00000097          	auipc	ra,0x0
    800013bc:	c68080e7          	jalr	-920(ra) # 80001020 <system_call>
    800013c0:	0005051b          	sext.w	a0,a0
}
    800013c4:	06813083          	ld	ra,104(sp)
    800013c8:	06013403          	ld	s0,96(sp)
    800013cc:	05813483          	ld	s1,88(sp)
    800013d0:	05013903          	ld	s2,80(sp)
    800013d4:	04813983          	ld	s3,72(sp)
    800013d8:	07010113          	addi	sp,sp,112
    800013dc:	00008067          	ret
        return -1;
    800013e0:	fff00513          	li	a0,-1
    800013e4:	fe1ff06f          	j	800013c4 <_Z13thread_createPP3TCBPFvPvES2_+0x74>

00000000800013e8 <_Z15thread_dispatchv>:

void thread_dispatch()
{
    800013e8:	fb010113          	addi	sp,sp,-80
    800013ec:	04113423          	sd	ra,72(sp)
    800013f0:	04813023          	sd	s0,64(sp)
    800013f4:	05010413          	addi	s0,sp,80
    Arguments arg = {KernelConfig::THREAD_DISPATCH, 0, 0, 0, 0, 0, 0, 0};
    800013f8:	01300793          	li	a5,19
    800013fc:	faf43823          	sd	a5,-80(s0)
    80001400:	fa043c23          	sd	zero,-72(s0)
    80001404:	fc043023          	sd	zero,-64(s0)
    80001408:	fc043423          	sd	zero,-56(s0)
    8000140c:	fc043823          	sd	zero,-48(s0)
    80001410:	fc043c23          	sd	zero,-40(s0)
    80001414:	fe043023          	sd	zero,-32(s0)
    80001418:	fe043423          	sd	zero,-24(s0)
    system_call(&arg);
    8000141c:	fb040513          	addi	a0,s0,-80
    80001420:	00000097          	auipc	ra,0x0
    80001424:	c00080e7          	jalr	-1024(ra) # 80001020 <system_call>
}
    80001428:	04813083          	ld	ra,72(sp)
    8000142c:	04013403          	ld	s0,64(sp)
    80001430:	05010113          	addi	sp,sp,80
    80001434:	00008067          	ret

0000000080001438 <_Z11thread_exitv>:

int thread_exit()
{
    80001438:	fb010113          	addi	sp,sp,-80
    8000143c:	04113423          	sd	ra,72(sp)
    80001440:	04813023          	sd	s0,64(sp)
    80001444:	05010413          	addi	s0,sp,80
    Arguments arg = {KernelConfig::THREAD_EXIT, 0, 0, 0, 0, 0, 0, 0};
    80001448:	01200793          	li	a5,18
    8000144c:	faf43823          	sd	a5,-80(s0)
    80001450:	fa043c23          	sd	zero,-72(s0)
    80001454:	fc043023          	sd	zero,-64(s0)
    80001458:	fc043423          	sd	zero,-56(s0)
    8000145c:	fc043823          	sd	zero,-48(s0)
    80001460:	fc043c23          	sd	zero,-40(s0)
    80001464:	fe043023          	sd	zero,-32(s0)
    80001468:	fe043423          	sd	zero,-24(s0)
    return (int) system_call(&arg);
    8000146c:	fb040513          	addi	a0,s0,-80
    80001470:	00000097          	auipc	ra,0x0
    80001474:	bb0080e7          	jalr	-1104(ra) # 80001020 <system_call>
}
    80001478:	0005051b          	sext.w	a0,a0
    8000147c:	04813083          	ld	ra,72(sp)
    80001480:	04013403          	ld	s0,64(sp)
    80001484:	05010113          	addi	sp,sp,80
    80001488:	00008067          	ret

000000008000148c <_Z12thread_startP3TCB>:
void thread_start(thread_t handle)
{
    8000148c:	fb010113          	addi	sp,sp,-80
    80001490:	04113423          	sd	ra,72(sp)
    80001494:	04813023          	sd	s0,64(sp)
    80001498:	05010413          	addi	s0,sp,80
    Arguments arg = {KernelConfig::THREAD_START,(uint64)handle, 0, 0, 0, 0, 0, 0};
    8000149c:	fc043023          	sd	zero,-64(s0)
    800014a0:	fc043423          	sd	zero,-56(s0)
    800014a4:	fc043823          	sd	zero,-48(s0)
    800014a8:	fc043c23          	sd	zero,-40(s0)
    800014ac:	fe043023          	sd	zero,-32(s0)
    800014b0:	fe043423          	sd	zero,-24(s0)
    800014b4:	01400793          	li	a5,20
    800014b8:	faf43823          	sd	a5,-80(s0)
    800014bc:	faa43c23          	sd	a0,-72(s0)
    system_call(&arg);
    800014c0:	fb040513          	addi	a0,s0,-80
    800014c4:	00000097          	auipc	ra,0x0
    800014c8:	b5c080e7          	jalr	-1188(ra) # 80001020 <system_call>
}
    800014cc:	04813083          	ld	ra,72(sp)
    800014d0:	04013403          	ld	s0,64(sp)
    800014d4:	05010113          	addi	sp,sp,80
    800014d8:	00008067          	ret

00000000800014dc <_Z11thread_joinP3TCB>:

void thread_join(thread_t handle)
{
    800014dc:	fb010113          	addi	sp,sp,-80
    800014e0:	04113423          	sd	ra,72(sp)
    800014e4:	04813023          	sd	s0,64(sp)
    800014e8:	05010413          	addi	s0,sp,80
    Arguments arg = {KernelConfig::THREAD_JOIN,(uint64)handle, 0, 0, 0, 0, 0, 0};
    800014ec:	fc043023          	sd	zero,-64(s0)
    800014f0:	fc043423          	sd	zero,-56(s0)
    800014f4:	fc043823          	sd	zero,-48(s0)
    800014f8:	fc043c23          	sd	zero,-40(s0)
    800014fc:	fe043023          	sd	zero,-32(s0)
    80001500:	fe043423          	sd	zero,-24(s0)
    80001504:	01500793          	li	a5,21
    80001508:	faf43823          	sd	a5,-80(s0)
    8000150c:	faa43c23          	sd	a0,-72(s0)
    system_call(&arg);
    80001510:	fb040513          	addi	a0,s0,-80
    80001514:	00000097          	auipc	ra,0x0
    80001518:	b0c080e7          	jalr	-1268(ra) # 80001020 <system_call>
}
    8000151c:	04813083          	ld	ra,72(sp)
    80001520:	04013403          	ld	s0,64(sp)
    80001524:	05010113          	addi	sp,sp,80
    80001528:	00008067          	ret

000000008000152c <_Z8sem_openPP10KSemaphorej>:


int sem_open(sem_t* handle, unsigned init)
{
    8000152c:	fb010113          	addi	sp,sp,-80
    80001530:	04113423          	sd	ra,72(sp)
    80001534:	04813023          	sd	s0,64(sp)
    80001538:	05010413          	addi	s0,sp,80
    Arguments arg = {KernelConfig::SEMAPHORE_OPEN, (uint64)handle, (uint64)init, 0, 0, 0, 0, 0};
    8000153c:	fc043423          	sd	zero,-56(s0)
    80001540:	fc043823          	sd	zero,-48(s0)
    80001544:	fc043c23          	sd	zero,-40(s0)
    80001548:	fe043023          	sd	zero,-32(s0)
    8000154c:	fe043423          	sd	zero,-24(s0)
    80001550:	02100793          	li	a5,33
    80001554:	faf43823          	sd	a5,-80(s0)
    80001558:	faa43c23          	sd	a0,-72(s0)
    8000155c:	02059593          	slli	a1,a1,0x20
    80001560:	0205d593          	srli	a1,a1,0x20
    80001564:	fcb43023          	sd	a1,-64(s0)
    return (int) system_call(&arg);
    80001568:	fb040513          	addi	a0,s0,-80
    8000156c:	00000097          	auipc	ra,0x0
    80001570:	ab4080e7          	jalr	-1356(ra) # 80001020 <system_call>
}
    80001574:	0005051b          	sext.w	a0,a0
    80001578:	04813083          	ld	ra,72(sp)
    8000157c:	04013403          	ld	s0,64(sp)
    80001580:	05010113          	addi	sp,sp,80
    80001584:	00008067          	ret

0000000080001588 <_Z9sem_closeP10KSemaphore>:

int sem_close(sem_t handle)
{
    80001588:	fb010113          	addi	sp,sp,-80
    8000158c:	04113423          	sd	ra,72(sp)
    80001590:	04813023          	sd	s0,64(sp)
    80001594:	05010413          	addi	s0,sp,80
    Arguments arg = {KernelConfig::SEMAPHORE_CLOSE, (uint64)handle, 0, 0, 0, 0, 0, 0};
    80001598:	fc043023          	sd	zero,-64(s0)
    8000159c:	fc043423          	sd	zero,-56(s0)
    800015a0:	fc043823          	sd	zero,-48(s0)
    800015a4:	fc043c23          	sd	zero,-40(s0)
    800015a8:	fe043023          	sd	zero,-32(s0)
    800015ac:	fe043423          	sd	zero,-24(s0)
    800015b0:	02200793          	li	a5,34
    800015b4:	faf43823          	sd	a5,-80(s0)
    800015b8:	faa43c23          	sd	a0,-72(s0)
    return (int) system_call(&arg);
    800015bc:	fb040513          	addi	a0,s0,-80
    800015c0:	00000097          	auipc	ra,0x0
    800015c4:	a60080e7          	jalr	-1440(ra) # 80001020 <system_call>
}
    800015c8:	0005051b          	sext.w	a0,a0
    800015cc:	04813083          	ld	ra,72(sp)
    800015d0:	04013403          	ld	s0,64(sp)
    800015d4:	05010113          	addi	sp,sp,80
    800015d8:	00008067          	ret

00000000800015dc <_Z8sem_waitP10KSemaphore>:

int sem_wait(sem_t handle)
{
    800015dc:	fb010113          	addi	sp,sp,-80
    800015e0:	04113423          	sd	ra,72(sp)
    800015e4:	04813023          	sd	s0,64(sp)
    800015e8:	05010413          	addi	s0,sp,80
    Arguments arg = {KernelConfig::SEMAPHORE_WAIT, (uint64)handle, 0, 0, 0, 0, 0, 0};
    800015ec:	fc043023          	sd	zero,-64(s0)
    800015f0:	fc043423          	sd	zero,-56(s0)
    800015f4:	fc043823          	sd	zero,-48(s0)
    800015f8:	fc043c23          	sd	zero,-40(s0)
    800015fc:	fe043023          	sd	zero,-32(s0)
    80001600:	fe043423          	sd	zero,-24(s0)
    80001604:	02300793          	li	a5,35
    80001608:	faf43823          	sd	a5,-80(s0)
    8000160c:	faa43c23          	sd	a0,-72(s0)
    return (int) system_call(&arg);
    80001610:	fb040513          	addi	a0,s0,-80
    80001614:	00000097          	auipc	ra,0x0
    80001618:	a0c080e7          	jalr	-1524(ra) # 80001020 <system_call>
}
    8000161c:	0005051b          	sext.w	a0,a0
    80001620:	04813083          	ld	ra,72(sp)
    80001624:	04013403          	ld	s0,64(sp)
    80001628:	05010113          	addi	sp,sp,80
    8000162c:	00008067          	ret

0000000080001630 <_Z10sem_signalP10KSemaphore>:

int sem_signal(sem_t handle)
{
    80001630:	fb010113          	addi	sp,sp,-80
    80001634:	04113423          	sd	ra,72(sp)
    80001638:	04813023          	sd	s0,64(sp)
    8000163c:	05010413          	addi	s0,sp,80
    Arguments arg = {KernelConfig::SEMAPHORE_SIGNAL, (uint64)handle, 0, 0, 0, 0, 0, 0};
    80001640:	fc043023          	sd	zero,-64(s0)
    80001644:	fc043423          	sd	zero,-56(s0)
    80001648:	fc043823          	sd	zero,-48(s0)
    8000164c:	fc043c23          	sd	zero,-40(s0)
    80001650:	fe043023          	sd	zero,-32(s0)
    80001654:	fe043423          	sd	zero,-24(s0)
    80001658:	02400793          	li	a5,36
    8000165c:	faf43823          	sd	a5,-80(s0)
    80001660:	faa43c23          	sd	a0,-72(s0)
    return (int) system_call(&arg);
    80001664:	fb040513          	addi	a0,s0,-80
    80001668:	00000097          	auipc	ra,0x0
    8000166c:	9b8080e7          	jalr	-1608(ra) # 80001020 <system_call>
}
    80001670:	0005051b          	sext.w	a0,a0
    80001674:	04813083          	ld	ra,72(sp)
    80001678:	04013403          	ld	s0,64(sp)
    8000167c:	05010113          	addi	sp,sp,80
    80001680:	00008067          	ret

0000000080001684 <_Z10time_sleepm>:

int time_sleep(time_t time_to_sleep)
{
    80001684:	fb010113          	addi	sp,sp,-80
    80001688:	04113423          	sd	ra,72(sp)
    8000168c:	04813023          	sd	s0,64(sp)
    80001690:	05010413          	addi	s0,sp,80
    Arguments arg = {KernelConfig::TIME_SLEEP, (uint64)time_to_sleep, 0, 0, 0, 0, 0, 0};
    80001694:	fc043023          	sd	zero,-64(s0)
    80001698:	fc043423          	sd	zero,-56(s0)
    8000169c:	fc043823          	sd	zero,-48(s0)
    800016a0:	fc043c23          	sd	zero,-40(s0)
    800016a4:	fe043023          	sd	zero,-32(s0)
    800016a8:	fe043423          	sd	zero,-24(s0)
    800016ac:	03100793          	li	a5,49
    800016b0:	faf43823          	sd	a5,-80(s0)
    800016b4:	faa43c23          	sd	a0,-72(s0)
    return (int) system_call(&arg);
    800016b8:	fb040513          	addi	a0,s0,-80
    800016bc:	00000097          	auipc	ra,0x0
    800016c0:	964080e7          	jalr	-1692(ra) # 80001020 <system_call>
}
    800016c4:	0005051b          	sext.w	a0,a0
    800016c8:	04813083          	ld	ra,72(sp)
    800016cc:	04013403          	ld	s0,64(sp)
    800016d0:	05010113          	addi	sp,sp,80
    800016d4:	00008067          	ret

00000000800016d8 <_Z4getcv>:
char getc()
{
    800016d8:	fb010113          	addi	sp,sp,-80
    800016dc:	04113423          	sd	ra,72(sp)
    800016e0:	04813023          	sd	s0,64(sp)
    800016e4:	05010413          	addi	s0,sp,80
    Arguments arg = {KernelConfig::GETC, 0, 0, 0, 0, 0, 0, 0};
    800016e8:	04100793          	li	a5,65
    800016ec:	faf43823          	sd	a5,-80(s0)
    800016f0:	fa043c23          	sd	zero,-72(s0)
    800016f4:	fc043023          	sd	zero,-64(s0)
    800016f8:	fc043423          	sd	zero,-56(s0)
    800016fc:	fc043823          	sd	zero,-48(s0)
    80001700:	fc043c23          	sd	zero,-40(s0)
    80001704:	fe043023          	sd	zero,-32(s0)
    80001708:	fe043423          	sd	zero,-24(s0)
    return (char) system_call(&arg);
    8000170c:	fb040513          	addi	a0,s0,-80
    80001710:	00000097          	auipc	ra,0x0
    80001714:	910080e7          	jalr	-1776(ra) # 80001020 <system_call>
}
    80001718:	0ff57513          	andi	a0,a0,255
    8000171c:	04813083          	ld	ra,72(sp)
    80001720:	04013403          	ld	s0,64(sp)
    80001724:	05010113          	addi	sp,sp,80
    80001728:	00008067          	ret

000000008000172c <_Z4putcc>:

void putc(char c)
{
    8000172c:	fb010113          	addi	sp,sp,-80
    80001730:	04113423          	sd	ra,72(sp)
    80001734:	04813023          	sd	s0,64(sp)
    80001738:	05010413          	addi	s0,sp,80
    Arguments arg = {KernelConfig::PUTC, (uint64) c, 0, 0, 0, 0, 0, 0};
    8000173c:	fc043023          	sd	zero,-64(s0)
    80001740:	fc043423          	sd	zero,-56(s0)
    80001744:	fc043823          	sd	zero,-48(s0)
    80001748:	fc043c23          	sd	zero,-40(s0)
    8000174c:	fe043023          	sd	zero,-32(s0)
    80001750:	fe043423          	sd	zero,-24(s0)
    80001754:	04200793          	li	a5,66
    80001758:	faf43823          	sd	a5,-80(s0)
    8000175c:	faa43c23          	sd	a0,-72(s0)
    system_call(&arg);
    80001760:	fb040513          	addi	a0,s0,-80
    80001764:	00000097          	auipc	ra,0x0
    80001768:	8bc080e7          	jalr	-1860(ra) # 80001020 <system_call>
    8000176c:	04813083          	ld	ra,72(sp)
    80001770:	04013403          	ld	s0,64(sp)
    80001774:	05010113          	addi	sp,sp,80
    80001778:	00008067          	ret

000000008000177c <_Z41__static_initialization_and_destruction_0ii>:
{
    delete inputBuffer;
    delete outputBuffer;
    delete inputWaitQueue;
    delete outputWaitQueue;
}
    8000177c:	00100793          	li	a5,1
    80001780:	00f50463          	beq	a0,a5,80001788 <_Z41__static_initialization_and_destruction_0ii+0xc>
    80001784:	00008067          	ret
    80001788:	000107b7          	lui	a5,0x10
    8000178c:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80001790:	fef59ae3          	bne	a1,a5,80001784 <_Z41__static_initialization_and_destruction_0ii+0x8>
    80001794:	fe010113          	addi	sp,sp,-32
    80001798:	00113c23          	sd	ra,24(sp)
    8000179c:	00813823          	sd	s0,16(sp)
    800017a0:	00913423          	sd	s1,8(sp)
    800017a4:	01213023          	sd	s2,0(sp)
    800017a8:	02010413          	addi	s0,sp,32
Buffer<char, KernelConfig::SIZE_INPUT_BUFFER>* KConsole::inputBuffer = new Buffer<char, KernelConfig::SIZE_INPUT_BUFFER>();
    800017ac:	33800513          	li	a0,824
    800017b0:	00000097          	auipc	ra,0x0
    800017b4:	468080e7          	jalr	1128(ra) # 80001c18 <_ZN6BufferIcLm100EEnwEm>
    800017b8:	00050913          	mv	s2,a0
    800017bc:	00000097          	auipc	ra,0x0
    800017c0:	498080e7          	jalr	1176(ra) # 80001c54 <_ZN6BufferIcLm100EEC1Ev>
    800017c4:	00007497          	auipc	s1,0x7
    800017c8:	08c48493          	addi	s1,s1,140 # 80008850 <_ZN8KConsole11inputBufferE>
    800017cc:	0124b023          	sd	s2,0(s1)
Buffer<char, KernelConfig::SIZE_OUTPUT_BUFFER>* KConsole::outputBuffer = new Buffer<char, KernelConfig::SIZE_OUTPUT_BUFFER>();
    800017d0:	33800513          	li	a0,824
    800017d4:	00000097          	auipc	ra,0x0
    800017d8:	444080e7          	jalr	1092(ra) # 80001c18 <_ZN6BufferIcLm100EEnwEm>
    800017dc:	00050913          	mv	s2,a0
    800017e0:	00000097          	auipc	ra,0x0
    800017e4:	474080e7          	jalr	1140(ra) # 80001c54 <_ZN6BufferIcLm100EEC1Ev>
    800017e8:	0124b423          	sd	s2,8(s1)
Queue<TCB>* KConsole::inputWaitQueue = new Queue<TCB>();
    800017ec:	01000513          	li	a0,16
    800017f0:	00000097          	auipc	ra,0x0
    800017f4:	4d0080e7          	jalr	1232(ra) # 80001cc0 <_ZN5QueueI3TCBEnwEm>
    800017f8:	00053023          	sd	zero,0(a0) # 1000 <_entry-0x7ffff000>
    800017fc:	00053423          	sd	zero,8(a0)
    80001800:	00a4b823          	sd	a0,16(s1)
Queue<TCB>* KConsole::outputWaitQueue = new Queue<TCB>();
    80001804:	01000513          	li	a0,16
    80001808:	00000097          	auipc	ra,0x0
    8000180c:	4b8080e7          	jalr	1208(ra) # 80001cc0 <_ZN5QueueI3TCBEnwEm>
    80001810:	00053023          	sd	zero,0(a0)
    80001814:	00053423          	sd	zero,8(a0)
    80001818:	00a4bc23          	sd	a0,24(s1)
}
    8000181c:	01813083          	ld	ra,24(sp)
    80001820:	01013403          	ld	s0,16(sp)
    80001824:	00813483          	ld	s1,8(sp)
    80001828:	00013903          	ld	s2,0(sp)
    8000182c:	02010113          	addi	sp,sp,32
    80001830:	00008067          	ret

0000000080001834 <_ZN8KConsole7destroyEv>:
{
    80001834:	ff010113          	addi	sp,sp,-16
    80001838:	00113423          	sd	ra,8(sp)
    8000183c:	00813023          	sd	s0,0(sp)
    80001840:	01010413          	addi	s0,sp,16
    delete inputBuffer;
    80001844:	00007517          	auipc	a0,0x7
    80001848:	00c53503          	ld	a0,12(a0) # 80008850 <_ZN8KConsole11inputBufferE>
    8000184c:	00050663          	beqz	a0,80001858 <_ZN8KConsole7destroyEv+0x24>
    80001850:	00000097          	auipc	ra,0x0
    80001854:	448080e7          	jalr	1096(ra) # 80001c98 <_ZN6BufferIcLm100EEdlEPv>
    delete outputBuffer;
    80001858:	00007517          	auipc	a0,0x7
    8000185c:	00053503          	ld	a0,0(a0) # 80008858 <_ZN8KConsole12outputBufferE>
    80001860:	00050663          	beqz	a0,8000186c <_ZN8KConsole7destroyEv+0x38>
    80001864:	00000097          	auipc	ra,0x0
    80001868:	434080e7          	jalr	1076(ra) # 80001c98 <_ZN6BufferIcLm100EEdlEPv>
    delete inputWaitQueue;
    8000186c:	00007517          	auipc	a0,0x7
    80001870:	ff453503          	ld	a0,-12(a0) # 80008860 <_ZN8KConsole14inputWaitQueueE>
    80001874:	00050663          	beqz	a0,80001880 <_ZN8KConsole7destroyEv+0x4c>
    80001878:	00000097          	auipc	ra,0x0
    8000187c:	484080e7          	jalr	1156(ra) # 80001cfc <_ZN5QueueI3TCBEdlEPv>
    delete outputWaitQueue;
    80001880:	00007517          	auipc	a0,0x7
    80001884:	fe853503          	ld	a0,-24(a0) # 80008868 <_ZN8KConsole15outputWaitQueueE>
    80001888:	00050663          	beqz	a0,80001894 <_ZN8KConsole7destroyEv+0x60>
    8000188c:	00000097          	auipc	ra,0x0
    80001890:	470080e7          	jalr	1136(ra) # 80001cfc <_ZN5QueueI3TCBEdlEPv>
}
    80001894:	00813083          	ld	ra,8(sp)
    80001898:	00013403          	ld	s0,0(sp)
    8000189c:	01010113          	addi	sp,sp,16
    800018a0:	00008067          	ret

00000000800018a4 <_ZN8KConsole25addThreadToInputWaitQueueEP3TCB>:
{
    800018a4:	ff010113          	addi	sp,sp,-16
    800018a8:	00113423          	sd	ra,8(sp)
    800018ac:	00813023          	sd	s0,0(sp)
    800018b0:	01010413          	addi	s0,sp,16
    800018b4:	00050593          	mv	a1,a0
    inputWaitQueue->append(thread);
    800018b8:	00007517          	auipc	a0,0x7
    800018bc:	fa853503          	ld	a0,-88(a0) # 80008860 <_ZN8KConsole14inputWaitQueueE>
    800018c0:	00000097          	auipc	ra,0x0
    800018c4:	464080e7          	jalr	1124(ra) # 80001d24 <_ZN5QueueI3TCBE6appendEPS0_>
}
    800018c8:	00813083          	ld	ra,8(sp)
    800018cc:	00013403          	ld	s0,0(sp)
    800018d0:	01010113          	addi	sp,sp,16
    800018d4:	00008067          	ret

00000000800018d8 <_ZN8KConsole26addThreadToOutputWaitQueueEP3TCB>:
{
    800018d8:	ff010113          	addi	sp,sp,-16
    800018dc:	00113423          	sd	ra,8(sp)
    800018e0:	00813023          	sd	s0,0(sp)
    800018e4:	01010413          	addi	s0,sp,16
    800018e8:	00050593          	mv	a1,a0
    outputWaitQueue->append(thread);
    800018ec:	00007517          	auipc	a0,0x7
    800018f0:	f7c53503          	ld	a0,-132(a0) # 80008868 <_ZN8KConsole15outputWaitQueueE>
    800018f4:	00000097          	auipc	ra,0x0
    800018f8:	430080e7          	jalr	1072(ra) # 80001d24 <_ZN5QueueI3TCBE6appendEPS0_>
}
    800018fc:	00813083          	ld	ra,8(sp)
    80001900:	00013403          	ld	s0,0(sp)
    80001904:	01010113          	addi	sp,sp,16
    80001908:	00008067          	ret

000000008000190c <_ZN8KConsole30removeThreadFromInputWaitQueueEv>:
{
    8000190c:	ff010113          	addi	sp,sp,-16
    80001910:	00113423          	sd	ra,8(sp)
    80001914:	00813023          	sd	s0,0(sp)
    80001918:	01010413          	addi	s0,sp,16
    TCB* oldThread = outputWaitQueue->take();
    8000191c:	00007517          	auipc	a0,0x7
    80001920:	f4c53503          	ld	a0,-180(a0) # 80008868 <_ZN8KConsole15outputWaitQueueE>
    80001924:	00000097          	auipc	ra,0x0
    80001928:	434080e7          	jalr	1076(ra) # 80001d58 <_ZN5QueueI3TCBE4takeEv>
    if(oldThread)
    8000192c:	00050863          	beqz	a0,8000193c <_ZN8KConsole30removeThreadFromInputWaitQueueEv+0x30>
    void setTimeToSleep(size_t time) { timeToSleep = time; }

    void decrementTimeToSleep() { timeToSleep--; };
    void addThreadToState(TCB* newThread) { state = newThread; }
    TCB* getState() const { return state; }
    void resetState() {state = nullptr; }
    80001930:	04053423          	sd	zero,72(a0)
        Scheduler::put(oldThread);
    80001934:	00000097          	auipc	ra,0x0
    80001938:	594080e7          	jalr	1428(ra) # 80001ec8 <_ZN9Scheduler3putEP3TCB>
}
    8000193c:	00813083          	ld	ra,8(sp)
    80001940:	00013403          	ld	s0,0(sp)
    80001944:	01010113          	addi	sp,sp,16
    80001948:	00008067          	ret

000000008000194c <_ZN8KConsole31removeThreadFromOutputWaitQueueEv>:
{
    8000194c:	ff010113          	addi	sp,sp,-16
    80001950:	00113423          	sd	ra,8(sp)
    80001954:	00813023          	sd	s0,0(sp)
    80001958:	01010413          	addi	s0,sp,16
    TCB* oldThread = inputWaitQueue->take();
    8000195c:	00007517          	auipc	a0,0x7
    80001960:	f0453503          	ld	a0,-252(a0) # 80008860 <_ZN8KConsole14inputWaitQueueE>
    80001964:	00000097          	auipc	ra,0x0
    80001968:	3f4080e7          	jalr	1012(ra) # 80001d58 <_ZN5QueueI3TCBE4takeEv>
    if(oldThread)
    8000196c:	00050863          	beqz	a0,8000197c <_ZN8KConsole31removeThreadFromOutputWaitQueueEv+0x30>
    80001970:	04053423          	sd	zero,72(a0)
        Scheduler::put(oldThread);
    80001974:	00000097          	auipc	ra,0x0
    80001978:	554080e7          	jalr	1364(ra) # 80001ec8 <_ZN9Scheduler3putEP3TCB>
}
    8000197c:	00813083          	ld	ra,8(sp)
    80001980:	00013403          	ld	s0,0(sp)
    80001984:	01010113          	addi	sp,sp,16
    80001988:	00008067          	ret

000000008000198c <_ZN8KConsole22getCharFromInputBufferEv>:
{
    8000198c:	ff010113          	addi	sp,sp,-16
    80001990:	00113423          	sd	ra,8(sp)
    80001994:	00813023          	sd	s0,0(sp)
    80001998:	01010413          	addi	s0,sp,16
    return *(inputBuffer->take());
    8000199c:	00007517          	auipc	a0,0x7
    800019a0:	eb453503          	ld	a0,-332(a0) # 80008850 <_ZN8KConsole11inputBufferE>
    800019a4:	00000097          	auipc	ra,0x0
    800019a8:	3ec080e7          	jalr	1004(ra) # 80001d90 <_ZN6BufferIcLm100EE4takeEv>
}
    800019ac:	00054503          	lbu	a0,0(a0)
    800019b0:	00813083          	ld	ra,8(sp)
    800019b4:	00013403          	ld	s0,0(sp)
    800019b8:	01010113          	addi	sp,sp,16
    800019bc:	00008067          	ret

00000000800019c0 <_ZN8KConsole19consumeOutputBufferEPv>:
{
    800019c0:	fd010113          	addi	sp,sp,-48
    800019c4:	02113423          	sd	ra,40(sp)
    800019c8:	02813023          	sd	s0,32(sp)
    800019cc:	00913c23          	sd	s1,24(sp)
    800019d0:	01213823          	sd	s2,16(sp)
    800019d4:	03010413          	addi	s0,sp,48
    800019d8:	0400006f          	j	80001a18 <_ZN8KConsole19consumeOutputBufferEPv+0x58>
        plic_complete(numOfDevice);
    800019dc:	fd842503          	lw	a0,-40(s0)
    800019e0:	0005051b          	sext.w	a0,a0
    800019e4:	00003097          	auipc	ra,0x3
    800019e8:	e18080e7          	jalr	-488(ra) # 800047fc <plic_complete>
    void freeWaitThreads();

    static void dispatch();
    static void start(TCB* readyElement);

    static TCB* getRunningThread() { return running; }
    800019ec:	00007917          	auipc	s2,0x7
    800019f0:	de493903          	ld	s2,-540(s2) # 800087d0 <_GLOBAL_OFFSET_TABLE_+0x60>
    800019f4:	00093483          	ld	s1,0(s2)
        TCB::setRunningThread(Scheduler::get());
    800019f8:	00000097          	auipc	ra,0x0
    800019fc:	504080e7          	jalr	1284(ra) # 80001efc <_ZN9Scheduler3getEv>
    static void setRunningThread(TCB* newRunningThread) { running = newRunningThread; }
    80001a00:	00a93023          	sd	a0,0(s2)
    void resetState() {state = nullptr; }
    80001a04:	0404b423          	sd	zero,72(s1)
        context_switch(oldThread->getContext(), TCB::getRunningThread()->getContext());
    80001a08:	00850593          	addi	a1,a0,8
    80001a0c:	00848513          	addi	a0,s1,8
    80001a10:	fffff097          	auipc	ra,0xfffff
    80001a14:	790080e7          	jalr	1936(ra) # 800011a0 <context_switch>
        volatile int numOfDevice = plic_claim();
    80001a18:	00003097          	auipc	ra,0x3
    80001a1c:	dac080e7          	jalr	-596(ra) # 800047c4 <plic_claim>
    80001a20:	fca42c23          	sw	a0,-40(s0)
            data = *(outputBuffer->take());
    80001a24:	00007517          	auipc	a0,0x7
    80001a28:	e3453503          	ld	a0,-460(a0) # 80008858 <_ZN8KConsole12outputBufferE>
    80001a2c:	00000097          	auipc	ra,0x0
    80001a30:	364080e7          	jalr	868(ra) # 80001d90 <_ZN6BufferIcLm100EE4takeEv>
    80001a34:	00054783          	lbu	a5,0(a0)
    80001a38:	fcf40fa3          	sb	a5,-33(s0)
            __asm__ volatile("sb %[regData], 0(%[address])":: [regData]"r"(data), [address]"r"(CONSOLE_TX_DATA));
    80001a3c:	fdf44783          	lbu	a5,-33(s0)
    80001a40:	00007717          	auipc	a4,0x7
    80001a44:	d5873703          	ld	a4,-680(a4) # 80008798 <_GLOBAL_OFFSET_TABLE_+0x28>
    80001a48:	00073703          	ld	a4,0(a4)
    80001a4c:	00f70023          	sb	a5,0(a4)
            __asm__ volatile("lb %[status], 0(%[address])": [status] "=r"(statusReg): [address] "r"(CONSOLE_STATUS));
    80001a50:	00007797          	auipc	a5,0x7
    80001a54:	d307b783          	ld	a5,-720(a5) # 80008780 <_GLOBAL_OFFSET_TABLE_+0x10>
    80001a58:	0007b783          	ld	a5,0(a5)
    80001a5c:	00078783          	lb	a5,0(a5)
    80001a60:	fcf40f23          	sb	a5,-34(s0)
            removeThreadFromOutputWaitQueue();
    80001a64:	00000097          	auipc	ra,0x0
    80001a68:	ee8080e7          	jalr	-280(ra) # 8000194c <_ZN8KConsole31removeThreadFromOutputWaitQueueEv>
        } while ((statusReg & CONSOLE_TX_STATUS_BIT) && !outputBuffer->isBufferEmpty());
    80001a6c:	fde44783          	lbu	a5,-34(s0)
    80001a70:	0ff7f793          	andi	a5,a5,255
    80001a74:	0207f793          	andi	a5,a5,32
    80001a78:	f60782e3          	beqz	a5,800019dc <_ZN8KConsole19consumeOutputBufferEPv+0x1c>
    80001a7c:	00007517          	auipc	a0,0x7
    80001a80:	ddc53503          	ld	a0,-548(a0) # 80008858 <_ZN8KConsole12outputBufferE>
    80001a84:	00000097          	auipc	ra,0x0
    80001a88:	150080e7          	jalr	336(ra) # 80001bd4 <_ZNK6BufferIcLm100EE13isBufferEmptyEv>
    80001a8c:	f8050ce3          	beqz	a0,80001a24 <_ZN8KConsole19consumeOutputBufferEPv+0x64>
    80001a90:	f4dff06f          	j	800019dc <_ZN8KConsole19consumeOutputBufferEPv+0x1c>

0000000080001a94 <_ZN8KConsole21addCharToOutputBufferEc>:
{
    80001a94:	fe010113          	addi	sp,sp,-32
    80001a98:	00113c23          	sd	ra,24(sp)
    80001a9c:	00813823          	sd	s0,16(sp)
    80001aa0:	02010413          	addi	s0,sp,32
    80001aa4:	fea407a3          	sb	a0,-17(s0)
    outputBuffer->append(&c);
    80001aa8:	fef40593          	addi	a1,s0,-17
    80001aac:	00007517          	auipc	a0,0x7
    80001ab0:	dac53503          	ld	a0,-596(a0) # 80008858 <_ZN8KConsole12outputBufferE>
    80001ab4:	00000097          	auipc	ra,0x0
    80001ab8:	330080e7          	jalr	816(ra) # 80001de4 <_ZN6BufferIcLm100EE6appendEPc>
}
    80001abc:	01813083          	ld	ra,24(sp)
    80001ac0:	01013403          	ld	s0,16(sp)
    80001ac4:	02010113          	addi	sp,sp,32
    80001ac8:	00008067          	ret

0000000080001acc <_ZN8KConsole18produceInputBufferEPv>:
{
    80001acc:	fd010113          	addi	sp,sp,-48
    80001ad0:	02113423          	sd	ra,40(sp)
    80001ad4:	02813023          	sd	s0,32(sp)
    80001ad8:	00913c23          	sd	s1,24(sp)
    80001adc:	01213823          	sd	s2,16(sp)
    80001ae0:	03010413          	addi	s0,sp,48
    80001ae4:	0400006f          	j	80001b24 <_ZN8KConsole18produceInputBufferEPv+0x58>
        plic_complete(numOfDevice);
    80001ae8:	fd842503          	lw	a0,-40(s0)
    80001aec:	0005051b          	sext.w	a0,a0
    80001af0:	00003097          	auipc	ra,0x3
    80001af4:	d0c080e7          	jalr	-756(ra) # 800047fc <plic_complete>
    static TCB* getRunningThread() { return running; }
    80001af8:	00007917          	auipc	s2,0x7
    80001afc:	cd893903          	ld	s2,-808(s2) # 800087d0 <_GLOBAL_OFFSET_TABLE_+0x60>
    80001b00:	00093483          	ld	s1,0(s2)
        TCB::setRunningThread(Scheduler::get());
    80001b04:	00000097          	auipc	ra,0x0
    80001b08:	3f8080e7          	jalr	1016(ra) # 80001efc <_ZN9Scheduler3getEv>
    static void setRunningThread(TCB* newRunningThread) { running = newRunningThread; }
    80001b0c:	00a93023          	sd	a0,0(s2)
    void resetState() {state = nullptr; }
    80001b10:	0404b423          	sd	zero,72(s1)
        context_switch(oldThread->getContext(), TCB::getRunningThread()->getContext());
    80001b14:	00850593          	addi	a1,a0,8
    80001b18:	00848513          	addi	a0,s1,8
    80001b1c:	fffff097          	auipc	ra,0xfffff
    80001b20:	684080e7          	jalr	1668(ra) # 800011a0 <context_switch>
        volatile int numOfDevice = plic_claim();
    80001b24:	00003097          	auipc	ra,0x3
    80001b28:	ca0080e7          	jalr	-864(ra) # 800047c4 <plic_claim>
    80001b2c:	fca42c23          	sw	a0,-40(s0)
            __asm__ volatile("lb %[regData], 0(%[address])" : [regData]"=r"(data): [address]"r"(CONSOLE_RX_DATA));
    80001b30:	00007797          	auipc	a5,0x7
    80001b34:	c487b783          	ld	a5,-952(a5) # 80008778 <_GLOBAL_OFFSET_TABLE_+0x8>
    80001b38:	0007b783          	ld	a5,0(a5)
    80001b3c:	00078783          	lb	a5,0(a5)
    80001b40:	fcf40f23          	sb	a5,-34(s0)
            char c = data;
    80001b44:	fde44783          	lbu	a5,-34(s0)
    80001b48:	fcf40ba3          	sb	a5,-41(s0)
            inputBuffer->append(&c);
    80001b4c:	fd740593          	addi	a1,s0,-41
    80001b50:	00007517          	auipc	a0,0x7
    80001b54:	d0053503          	ld	a0,-768(a0) # 80008850 <_ZN8KConsole11inputBufferE>
    80001b58:	00000097          	auipc	ra,0x0
    80001b5c:	28c080e7          	jalr	652(ra) # 80001de4 <_ZN6BufferIcLm100EE6appendEPc>
            __asm__ volatile("lb %[status], 0(%[address])": [status] "=r"(statusReg): [address] "r"(CONSOLE_STATUS));
    80001b60:	00007797          	auipc	a5,0x7
    80001b64:	c207b783          	ld	a5,-992(a5) # 80008780 <_GLOBAL_OFFSET_TABLE_+0x10>
    80001b68:	0007b783          	ld	a5,0(a5)
    80001b6c:	00078783          	lb	a5,0(a5)
    80001b70:	fcf40fa3          	sb	a5,-33(s0)
            removeThreadFromInputWaitQueue();
    80001b74:	00000097          	auipc	ra,0x0
    80001b78:	d98080e7          	jalr	-616(ra) # 8000190c <_ZN8KConsole30removeThreadFromInputWaitQueueEv>
        } while ((statusReg & CONSOLE_RX_STATUS_BIT) && !inputBuffer->isBufferFull());
    80001b7c:	fdf44783          	lbu	a5,-33(s0)
    80001b80:	0017f793          	andi	a5,a5,1
    80001b84:	f60782e3          	beqz	a5,80001ae8 <_ZN8KConsole18produceInputBufferEPv+0x1c>
    80001b88:	00007517          	auipc	a0,0x7
    80001b8c:	cc853503          	ld	a0,-824(a0) # 80008850 <_ZN8KConsole11inputBufferE>
    80001b90:	00000097          	auipc	ra,0x0
    80001b94:	064080e7          	jalr	100(ra) # 80001bf4 <_ZNK6BufferIcLm100EE12isBufferFullEv>
    80001b98:	f8050ce3          	beqz	a0,80001b30 <_ZN8KConsole18produceInputBufferEPv+0x64>
    80001b9c:	f4dff06f          	j	80001ae8 <_ZN8KConsole18produceInputBufferEPv+0x1c>

0000000080001ba0 <_GLOBAL__sub_I__ZN8KConsole11inputBufferE>:
}
    80001ba0:	ff010113          	addi	sp,sp,-16
    80001ba4:	00113423          	sd	ra,8(sp)
    80001ba8:	00813023          	sd	s0,0(sp)
    80001bac:	01010413          	addi	s0,sp,16
    80001bb0:	000105b7          	lui	a1,0x10
    80001bb4:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    80001bb8:	00100513          	li	a0,1
    80001bbc:	00000097          	auipc	ra,0x0
    80001bc0:	bc0080e7          	jalr	-1088(ra) # 8000177c <_Z41__static_initialization_and_destruction_0ii>
    80001bc4:	00813083          	ld	ra,8(sp)
    80001bc8:	00013403          	ld	s0,0(sp)
    80001bcc:	01010113          	addi	sp,sp,16
    80001bd0:	00008067          	ret

0000000080001bd4 <_ZNK6BufferIcLm100EE13isBufferEmptyEv>:
    return tempElem;

}

template<typename T, size_t numOfElements>
bool Buffer<T, numOfElements>::isBufferEmpty() const
    80001bd4:	ff010113          	addi	sp,sp,-16
    80001bd8:	00813423          	sd	s0,8(sp)
    80001bdc:	01010413          	addi	s0,sp,16
{
    return count == 0;
    80001be0:	33053503          	ld	a0,816(a0)
}
    80001be4:	00153513          	seqz	a0,a0
    80001be8:	00813403          	ld	s0,8(sp)
    80001bec:	01010113          	addi	sp,sp,16
    80001bf0:	00008067          	ret

0000000080001bf4 <_ZNK6BufferIcLm100EE12isBufferFullEv>:
template<typename T, size_t numOfElements>
bool Buffer<T, numOfElements>::isBufferFull() const
    80001bf4:	ff010113          	addi	sp,sp,-16
    80001bf8:	00813423          	sd	s0,8(sp)
    80001bfc:	01010413          	addi	s0,sp,16
{
    return count == numOfElements;
    80001c00:	33053503          	ld	a0,816(a0)
    80001c04:	f9c50513          	addi	a0,a0,-100
}
    80001c08:	00153513          	seqz	a0,a0
    80001c0c:	00813403          	ld	s0,8(sp)
    80001c10:	01010113          	addi	sp,sp,16
    80001c14:	00008067          	ret

0000000080001c18 <_ZN6BufferIcLm100EEnwEm>:
void* Buffer<T, numOfElements>::operator new(size_t size)
    80001c18:	ff010113          	addi	sp,sp,-16
    80001c1c:	00113423          	sd	ra,8(sp)
    80001c20:	00813023          	sd	s0,0(sp)
    80001c24:	01010413          	addi	s0,sp,16
    size_t numOfBlocks = size / MEM_BLOCK_SIZE;
    80001c28:	00655793          	srli	a5,a0,0x6
    numOfBlocks += size % MEM_BLOCK_SIZE ? 1 : 0;
    80001c2c:	03f57513          	andi	a0,a0,63
    80001c30:	00050463          	beqz	a0,80001c38 <_ZN6BufferIcLm100EEnwEm+0x20>
    80001c34:	00100513          	li	a0,1
    return MemoryAllocator::allocateMemory(numOfBlocks);
    80001c38:	00f50533          	add	a0,a0,a5
    80001c3c:	00001097          	auipc	ra,0x1
    80001c40:	95c080e7          	jalr	-1700(ra) # 80002598 <_ZN15MemoryAllocator14allocateMemoryEm>
}
    80001c44:	00813083          	ld	ra,8(sp)
    80001c48:	00013403          	ld	s0,0(sp)
    80001c4c:	01010113          	addi	sp,sp,16
    80001c50:	00008067          	ret

0000000080001c54 <_ZN6BufferIcLm100EEC1Ev>:
Buffer<T, numOfElements>::Buffer()
    80001c54:	ff010113          	addi	sp,sp,-16
    80001c58:	00813423          	sd	s0,8(sp)
    80001c5c:	01010413          	addi	s0,sp,16
    80001c60:	32053023          	sd	zero,800(a0)
    80001c64:	32053423          	sd	zero,808(a0)
    80001c68:	32053823          	sd	zero,816(a0)
    for(size_t i = 0; i < numOfElements; i++)
    80001c6c:	00000793          	li	a5,0
    80001c70:	06300713          	li	a4,99
    80001c74:	00f76c63          	bltu	a4,a5,80001c8c <_ZN6BufferIcLm100EEC1Ev+0x38>
        array[i] = nullptr;
    80001c78:	00379713          	slli	a4,a5,0x3
    80001c7c:	00e50733          	add	a4,a0,a4
    80001c80:	00073023          	sd	zero,0(a4)
    for(size_t i = 0; i < numOfElements; i++)
    80001c84:	00178793          	addi	a5,a5,1
    80001c88:	fe9ff06f          	j	80001c70 <_ZN6BufferIcLm100EEC1Ev+0x1c>
}
    80001c8c:	00813403          	ld	s0,8(sp)
    80001c90:	01010113          	addi	sp,sp,16
    80001c94:	00008067          	ret

0000000080001c98 <_ZN6BufferIcLm100EEdlEPv>:
void Buffer<T, numOfElements>::operator delete(void* obj)
    80001c98:	ff010113          	addi	sp,sp,-16
    80001c9c:	00113423          	sd	ra,8(sp)
    80001ca0:	00813023          	sd	s0,0(sp)
    80001ca4:	01010413          	addi	s0,sp,16
    MemoryAllocator::freeMemory(obj);
    80001ca8:	00001097          	auipc	ra,0x1
    80001cac:	a4c080e7          	jalr	-1460(ra) # 800026f4 <_ZN15MemoryAllocator10freeMemoryEPv>
}
    80001cb0:	00813083          	ld	ra,8(sp)
    80001cb4:	00013403          	ld	s0,0(sp)
    80001cb8:	01010113          	addi	sp,sp,16
    80001cbc:	00008067          	ret

0000000080001cc0 <_ZN5QueueI3TCBEnwEm>:
            tail = prev;
        }
    }
}
template<typename T>
void* Queue<T>::operator new(size_t size)
    80001cc0:	ff010113          	addi	sp,sp,-16
    80001cc4:	00113423          	sd	ra,8(sp)
    80001cc8:	00813023          	sd	s0,0(sp)
    80001ccc:	01010413          	addi	s0,sp,16
{
    size_t numOfBlocks = size / MEM_BLOCK_SIZE;
    80001cd0:	00655793          	srli	a5,a0,0x6
    numOfBlocks += size % MEM_BLOCK_SIZE ? 1 : 0;
    80001cd4:	03f57513          	andi	a0,a0,63
    80001cd8:	00050463          	beqz	a0,80001ce0 <_ZN5QueueI3TCBEnwEm+0x20>
    80001cdc:	00100513          	li	a0,1
    return MemoryAllocator::allocateMemory(numOfBlocks);
    80001ce0:	00f50533          	add	a0,a0,a5
    80001ce4:	00001097          	auipc	ra,0x1
    80001ce8:	8b4080e7          	jalr	-1868(ra) # 80002598 <_ZN15MemoryAllocator14allocateMemoryEm>
}
    80001cec:	00813083          	ld	ra,8(sp)
    80001cf0:	00013403          	ld	s0,0(sp)
    80001cf4:	01010113          	addi	sp,sp,16
    80001cf8:	00008067          	ret

0000000080001cfc <_ZN5QueueI3TCBEdlEPv>:
template<typename T>
void Queue<T>::operator delete(void *obj)
    80001cfc:	ff010113          	addi	sp,sp,-16
    80001d00:	00113423          	sd	ra,8(sp)
    80001d04:	00813023          	sd	s0,0(sp)
    80001d08:	01010413          	addi	s0,sp,16
{
    MemoryAllocator::freeMemory(obj);
    80001d0c:	00001097          	auipc	ra,0x1
    80001d10:	9e8080e7          	jalr	-1560(ra) # 800026f4 <_ZN15MemoryAllocator10freeMemoryEPv>
}
    80001d14:	00813083          	ld	ra,8(sp)
    80001d18:	00013403          	ld	s0,0(sp)
    80001d1c:	01010113          	addi	sp,sp,16
    80001d20:	00008067          	ret

0000000080001d24 <_ZN5QueueI3TCBE6appendEPS0_>:
void Queue<T>::append(T *newElement)
    80001d24:	ff010113          	addi	sp,sp,-16
    80001d28:	00813423          	sd	s0,8(sp)
    80001d2c:	01010413          	addi	s0,sp,16
    if(!head)
    80001d30:	00053783          	ld	a5,0(a0)
    80001d34:	00078e63          	beqz	a5,80001d50 <_ZN5QueueI3TCBE6appendEPS0_+0x2c>
        tail->addThreadToState(newElement);
    80001d38:	00853783          	ld	a5,8(a0)
    void addThreadToState(TCB* newThread) { state = newThread; }
    80001d3c:	04b7b423          	sd	a1,72(a5)
    tail = newElement;
    80001d40:	00b53423          	sd	a1,8(a0)
}
    80001d44:	00813403          	ld	s0,8(sp)
    80001d48:	01010113          	addi	sp,sp,16
    80001d4c:	00008067          	ret
        head = newElement;
    80001d50:	00b53023          	sd	a1,0(a0)
    80001d54:	fedff06f          	j	80001d40 <_ZN5QueueI3TCBE6appendEPS0_+0x1c>

0000000080001d58 <_ZN5QueueI3TCBE4takeEv>:
T* Queue<T>::take()
    80001d58:	ff010113          	addi	sp,sp,-16
    80001d5c:	00813423          	sd	s0,8(sp)
    80001d60:	01010413          	addi	s0,sp,16
    80001d64:	00050793          	mv	a5,a0
    if(!head)
    80001d68:	00053503          	ld	a0,0(a0)
    80001d6c:	00050863          	beqz	a0,80001d7c <_ZN5QueueI3TCBE4takeEv+0x24>
    TCB* getState() const { return state; }
    80001d70:	04853703          	ld	a4,72(a0)
    head = head->getState();
    80001d74:	00e7b023          	sd	a4,0(a5)
    if(!head)
    80001d78:	00070863          	beqz	a4,80001d88 <_ZN5QueueI3TCBE4takeEv+0x30>
}
    80001d7c:	00813403          	ld	s0,8(sp)
    80001d80:	01010113          	addi	sp,sp,16
    80001d84:	00008067          	ret
        tail = nullptr;
    80001d88:	0007b423          	sd	zero,8(a5)
    80001d8c:	ff1ff06f          	j	80001d7c <_ZN5QueueI3TCBE4takeEv+0x24>

0000000080001d90 <_ZN6BufferIcLm100EE4takeEv>:
T* Buffer<T, numOfElements>::take()
    80001d90:	ff010113          	addi	sp,sp,-16
    80001d94:	00813423          	sd	s0,8(sp)
    80001d98:	01010413          	addi	s0,sp,16
    if(count == 0)
    80001d9c:	33053703          	ld	a4,816(a0)
    80001da0:	02070e63          	beqz	a4,80001ddc <_ZN6BufferIcLm100EE4takeEv+0x4c>
    80001da4:	00050793          	mv	a5,a0
    count--;
    80001da8:	fff70713          	addi	a4,a4,-1
    80001dac:	32e53823          	sd	a4,816(a0)
    T* tempElem = array[head];
    80001db0:	32053703          	ld	a4,800(a0)
    80001db4:	00371693          	slli	a3,a4,0x3
    80001db8:	00d506b3          	add	a3,a0,a3
    80001dbc:	0006b503          	ld	a0,0(a3)
    head = (head + 1) % numOfElements;
    80001dc0:	00170713          	addi	a4,a4,1
    80001dc4:	06400693          	li	a3,100
    80001dc8:	02d77733          	remu	a4,a4,a3
    80001dcc:	32e7b023          	sd	a4,800(a5)
}
    80001dd0:	00813403          	ld	s0,8(sp)
    80001dd4:	01010113          	addi	sp,sp,16
    80001dd8:	00008067          	ret
        return nullptr;
    80001ddc:	00000513          	li	a0,0
    80001de0:	ff1ff06f          	j	80001dd0 <_ZN6BufferIcLm100EE4takeEv+0x40>

0000000080001de4 <_ZN6BufferIcLm100EE6appendEPc>:
int Buffer<T, numOfElements>::append(T *element)
    80001de4:	ff010113          	addi	sp,sp,-16
    80001de8:	00813423          	sd	s0,8(sp)
    80001dec:	01010413          	addi	s0,sp,16
    if(count == numOfElements)
    80001df0:	33053783          	ld	a5,816(a0)
    80001df4:	06400713          	li	a4,100
    80001df8:	02e78e63          	beq	a5,a4,80001e34 <_ZN6BufferIcLm100EE6appendEPc+0x50>
    count++;
    80001dfc:	00178793          	addi	a5,a5,1
    80001e00:	32f53823          	sd	a5,816(a0)
    array[tail] = element;
    80001e04:	32853783          	ld	a5,808(a0)
    80001e08:	00379713          	slli	a4,a5,0x3
    80001e0c:	00e50733          	add	a4,a0,a4
    80001e10:	00b73023          	sd	a1,0(a4)
    tail = (tail + 1) % numOfElements;
    80001e14:	00178793          	addi	a5,a5,1
    80001e18:	06400713          	li	a4,100
    80001e1c:	02e7f7b3          	remu	a5,a5,a4
    80001e20:	32f53423          	sd	a5,808(a0)
    return 0;
    80001e24:	00000513          	li	a0,0
}
    80001e28:	00813403          	ld	s0,8(sp)
    80001e2c:	01010113          	addi	sp,sp,16
    80001e30:	00008067          	ret
        return -1;
    80001e34:	fff00513          	li	a0,-1
    80001e38:	ff1ff06f          	j	80001e28 <_ZN6BufferIcLm100EE6appendEPc+0x44>

0000000080001e3c <_Z41__static_initialization_and_destruction_0ii>:
    return newThread;
}
void Scheduler::destroy()
{
    delete queueReadyThreads;
    80001e3c:	00100793          	li	a5,1
    80001e40:	00f50463          	beq	a0,a5,80001e48 <_Z41__static_initialization_and_destruction_0ii+0xc>
    80001e44:	00008067          	ret
    80001e48:	000107b7          	lui	a5,0x10
    80001e4c:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80001e50:	fef59ae3          	bne	a1,a5,80001e44 <_Z41__static_initialization_and_destruction_0ii+0x8>
    80001e54:	ff010113          	addi	sp,sp,-16
    80001e58:	00113423          	sd	ra,8(sp)
    80001e5c:	00813023          	sd	s0,0(sp)
    80001e60:	01010413          	addi	s0,sp,16
Queue<TCB>* Scheduler::queueReadyThreads = new Queue<TCB>();
    80001e64:	01000513          	li	a0,16
    80001e68:	00000097          	auipc	ra,0x0
    80001e6c:	e58080e7          	jalr	-424(ra) # 80001cc0 <_ZN5QueueI3TCBEnwEm>
    80001e70:	00053023          	sd	zero,0(a0)
    80001e74:	00053423          	sd	zero,8(a0)
    80001e78:	00007797          	auipc	a5,0x7
    80001e7c:	a0a7b423          	sd	a0,-1528(a5) # 80008880 <_ZN9Scheduler17queueReadyThreadsE>
    80001e80:	00813083          	ld	ra,8(sp)
    80001e84:	00013403          	ld	s0,0(sp)
    80001e88:	01010113          	addi	sp,sp,16
    80001e8c:	00008067          	ret

0000000080001e90 <_ZN9Scheduler7destroyEv>:
    delete queueReadyThreads;
    80001e90:	00007517          	auipc	a0,0x7
    80001e94:	9f053503          	ld	a0,-1552(a0) # 80008880 <_ZN9Scheduler17queueReadyThreadsE>
    80001e98:	02050663          	beqz	a0,80001ec4 <_ZN9Scheduler7destroyEv+0x34>
{
    80001e9c:	ff010113          	addi	sp,sp,-16
    80001ea0:	00113423          	sd	ra,8(sp)
    80001ea4:	00813023          	sd	s0,0(sp)
    80001ea8:	01010413          	addi	s0,sp,16
    delete queueReadyThreads;
    80001eac:	00000097          	auipc	ra,0x0
    80001eb0:	e50080e7          	jalr	-432(ra) # 80001cfc <_ZN5QueueI3TCBEdlEPv>
    80001eb4:	00813083          	ld	ra,8(sp)
    80001eb8:	00013403          	ld	s0,0(sp)
    80001ebc:	01010113          	addi	sp,sp,16
    80001ec0:	00008067          	ret
    80001ec4:	00008067          	ret

0000000080001ec8 <_ZN9Scheduler3putEP3TCB>:
{
    80001ec8:	ff010113          	addi	sp,sp,-16
    80001ecc:	00113423          	sd	ra,8(sp)
    80001ed0:	00813023          	sd	s0,0(sp)
    80001ed4:	01010413          	addi	s0,sp,16
    80001ed8:	00050593          	mv	a1,a0
    queueReadyThreads->append(readyThread);
    80001edc:	00007517          	auipc	a0,0x7
    80001ee0:	9a453503          	ld	a0,-1628(a0) # 80008880 <_ZN9Scheduler17queueReadyThreadsE>
    80001ee4:	00000097          	auipc	ra,0x0
    80001ee8:	e40080e7          	jalr	-448(ra) # 80001d24 <_ZN5QueueI3TCBE6appendEPS0_>
}
    80001eec:	00813083          	ld	ra,8(sp)
    80001ef0:	00013403          	ld	s0,0(sp)
    80001ef4:	01010113          	addi	sp,sp,16
    80001ef8:	00008067          	ret

0000000080001efc <_ZN9Scheduler3getEv>:
    if(queueReadyThreads->isQueueEmpty())
    80001efc:	00007517          	auipc	a0,0x7
    80001f00:	98453503          	ld	a0,-1660(a0) # 80008880 <_ZN9Scheduler17queueReadyThreadsE>
    bool isQueueEmpty() const { return !head; }
    80001f04:	00053783          	ld	a5,0(a0)
    80001f08:	02078863          	beqz	a5,80001f38 <_ZN9Scheduler3getEv+0x3c>
{
    80001f0c:	ff010113          	addi	sp,sp,-16
    80001f10:	00113423          	sd	ra,8(sp)
    80001f14:	00813023          	sd	s0,0(sp)
    80001f18:	01010413          	addi	s0,sp,16
    TCB* newThread = queueReadyThreads->take();
    80001f1c:	00000097          	auipc	ra,0x0
    80001f20:	e3c080e7          	jalr	-452(ra) # 80001d58 <_ZN5QueueI3TCBE4takeEv>
    void addThreadToState(TCB* newThread) { state = newThread; }
    80001f24:	04053423          	sd	zero,72(a0)
}
    80001f28:	00813083          	ld	ra,8(sp)
    80001f2c:	00013403          	ld	s0,0(sp)
    80001f30:	01010113          	addi	sp,sp,16
    80001f34:	00008067          	ret
        return idleThread;
    80001f38:	00007517          	auipc	a0,0x7
    80001f3c:	95053503          	ld	a0,-1712(a0) # 80008888 <_ZN9Scheduler10idleThreadE>
}
    80001f40:	00008067          	ret

0000000080001f44 <_GLOBAL__sub_I__ZN9Scheduler17queueReadyThreadsE>:
    80001f44:	ff010113          	addi	sp,sp,-16
    80001f48:	00113423          	sd	ra,8(sp)
    80001f4c:	00813023          	sd	s0,0(sp)
    80001f50:	01010413          	addi	s0,sp,16
    80001f54:	000105b7          	lui	a1,0x10
    80001f58:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    80001f5c:	00100513          	li	a0,1
    80001f60:	00000097          	auipc	ra,0x0
    80001f64:	edc080e7          	jalr	-292(ra) # 80001e3c <_Z41__static_initialization_and_destruction_0ii>
    80001f68:	00813083          	ld	ra,8(sp)
    80001f6c:	00013403          	ld	s0,0(sp)
    80001f70:	01010113          	addi	sp,sp,16
    80001f74:	00008067          	ret

0000000080001f78 <main>:
// Created by os on 11/29/25.
//
#include "../h/MemoryAllocator.hpp"
#include "../h/Kernel.hpp"
#include "../h/syscall_c.hpp"
void main(){
    80001f78:	ff010113          	addi	sp,sp,-16
    80001f7c:	00813423          	sd	s0,8(sp)
    80001f80:	01010413          	addi	s0,sp,16
////    __asm__ volatile ("ecall");
//    void* allocMem1 = mem_alloc(100);
//    mem_free(allocMem1);
//    void* allocMem2 = mem_alloc(10);
//    mem_free(allocMem2);
    80001f84:	00813403          	ld	s0,8(sp)
    80001f88:	01010113          	addi	sp,sp,16
    80001f8c:	00008067          	ret

0000000080001f90 <_ZN6ThreadD1Ev>:
void operator delete(void* obj)
{
    mem_free(obj);
}

Thread::~Thread()
    80001f90:	ff010113          	addi	sp,sp,-16
    80001f94:	00813423          	sd	s0,8(sp)
    80001f98:	01010413          	addi	s0,sp,16
{

}
    80001f9c:	00813403          	ld	s0,8(sp)
    80001fa0:	01010113          	addi	sp,sp,16
    80001fa4:	00008067          	ret

0000000080001fa8 <_ZN6Thread10wrapperRunEPv>:
       myHandle = nullptr;
    }
}

void Thread::wrapperRun(void* thread)
{
    80001fa8:	ff010113          	addi	sp,sp,-16
    80001fac:	00113423          	sd	ra,8(sp)
    80001fb0:	00813023          	sd	s0,0(sp)
    80001fb4:	01010413          	addi	s0,sp,16
    Thread* tempThread = (Thread*)thread;
    tempThread->run();
    80001fb8:	00053783          	ld	a5,0(a0)
    80001fbc:	0107b783          	ld	a5,16(a5)
    80001fc0:	000780e7          	jalr	a5
}
    80001fc4:	00813083          	ld	ra,8(sp)
    80001fc8:	00013403          	ld	s0,0(sp)
    80001fcc:	01010113          	addi	sp,sp,16
    80001fd0:	00008067          	ret

0000000080001fd4 <_Znwm>:
{
    80001fd4:	ff010113          	addi	sp,sp,-16
    80001fd8:	00113423          	sd	ra,8(sp)
    80001fdc:	00813023          	sd	s0,0(sp)
    80001fe0:	01010413          	addi	s0,sp,16
    return mem_alloc(size);
    80001fe4:	fffff097          	auipc	ra,0xfffff
    80001fe8:	1e0080e7          	jalr	480(ra) # 800011c4 <_Z9mem_allocm>
}
    80001fec:	00813083          	ld	ra,8(sp)
    80001ff0:	00013403          	ld	s0,0(sp)
    80001ff4:	01010113          	addi	sp,sp,16
    80001ff8:	00008067          	ret

0000000080001ffc <_ZdlPv>:
{
    80001ffc:	ff010113          	addi	sp,sp,-16
    80002000:	00113423          	sd	ra,8(sp)
    80002004:	00813023          	sd	s0,0(sp)
    80002008:	01010413          	addi	s0,sp,16
    mem_free(obj);
    8000200c:	fffff097          	auipc	ra,0xfffff
    80002010:	250080e7          	jalr	592(ra) # 8000125c <_Z8mem_freePv>
}
    80002014:	00813083          	ld	ra,8(sp)
    80002018:	00013403          	ld	s0,0(sp)
    8000201c:	01010113          	addi	sp,sp,16
    80002020:	00008067          	ret

0000000080002024 <_ZN6ThreadD0Ev>:
Thread::~Thread()
    80002024:	ff010113          	addi	sp,sp,-16
    80002028:	00113423          	sd	ra,8(sp)
    8000202c:	00813023          	sd	s0,0(sp)
    80002030:	01010413          	addi	s0,sp,16
}
    80002034:	00000097          	auipc	ra,0x0
    80002038:	fc8080e7          	jalr	-56(ra) # 80001ffc <_ZdlPv>
    8000203c:	00813083          	ld	ra,8(sp)
    80002040:	00013403          	ld	s0,0(sp)
    80002044:	01010113          	addi	sp,sp,16
    80002048:	00008067          	ret

000000008000204c <_ZN6ThreadC1EPFvPvES0_>:
Thread::Thread(void (*body)(void *), void *arg): body(body), arg(arg)
    8000204c:	fe010113          	addi	sp,sp,-32
    80002050:	00113c23          	sd	ra,24(sp)
    80002054:	00813823          	sd	s0,16(sp)
    80002058:	00913423          	sd	s1,8(sp)
    8000205c:	02010413          	addi	s0,sp,32
    80002060:	00050493          	mv	s1,a0
    80002064:	00006797          	auipc	a5,0x6
    80002068:	6ec78793          	addi	a5,a5,1772 # 80008750 <_ZTV6Thread+0x10>
    8000206c:	00f53023          	sd	a5,0(a0)
    80002070:	00b53823          	sd	a1,16(a0)
    80002074:	00c53c23          	sd	a2,24(a0)
    if(thread_create(&myHandle, body, arg))
    80002078:	00850513          	addi	a0,a0,8
    8000207c:	fffff097          	auipc	ra,0xfffff
    80002080:	2d4080e7          	jalr	724(ra) # 80001350 <_Z13thread_createPP3TCBPFvPvES2_>
    80002084:	00050463          	beqz	a0,8000208c <_ZN6ThreadC1EPFvPvES0_+0x40>
       myHandle = nullptr;
    80002088:	0004b423          	sd	zero,8(s1)
}
    8000208c:	01813083          	ld	ra,24(sp)
    80002090:	01013403          	ld	s0,16(sp)
    80002094:	00813483          	ld	s1,8(sp)
    80002098:	02010113          	addi	sp,sp,32
    8000209c:	00008067          	ret

00000000800020a0 <_ZN6Thread5startEv>:
int Thread::start()
{
    if(myHandle == nullptr)
    800020a0:	00853503          	ld	a0,8(a0)
    800020a4:	02050863          	beqz	a0,800020d4 <_ZN6Thread5startEv+0x34>
{
    800020a8:	ff010113          	addi	sp,sp,-16
    800020ac:	00113423          	sd	ra,8(sp)
    800020b0:	00813023          	sd	s0,0(sp)
    800020b4:	01010413          	addi	s0,sp,16
    {
        return -1;
    }
    thread_start(myHandle);
    800020b8:	fffff097          	auipc	ra,0xfffff
    800020bc:	3d4080e7          	jalr	980(ra) # 8000148c <_Z12thread_startP3TCB>
    return 0;
    800020c0:	00000513          	li	a0,0

}
    800020c4:	00813083          	ld	ra,8(sp)
    800020c8:	00013403          	ld	s0,0(sp)
    800020cc:	01010113          	addi	sp,sp,16
    800020d0:	00008067          	ret
        return -1;
    800020d4:	fff00513          	li	a0,-1
}
    800020d8:	00008067          	ret

00000000800020dc <_ZN6ThreadC1Ev>:

Thread::Thread(): body(nullptr), arg(nullptr)
    800020dc:	fe010113          	addi	sp,sp,-32
    800020e0:	00113c23          	sd	ra,24(sp)
    800020e4:	00813823          	sd	s0,16(sp)
    800020e8:	00913423          	sd	s1,8(sp)
    800020ec:	02010413          	addi	s0,sp,32
    800020f0:	00050493          	mv	s1,a0
    800020f4:	00006797          	auipc	a5,0x6
    800020f8:	65c78793          	addi	a5,a5,1628 # 80008750 <_ZTV6Thread+0x10>
    800020fc:	00f53023          	sd	a5,0(a0)
    80002100:	00053823          	sd	zero,16(a0)
    80002104:	00053c23          	sd	zero,24(a0)
{
    if(thread_create(&myHandle, &(Thread::wrapperRun), this))
    80002108:	00050613          	mv	a2,a0
    8000210c:	00000597          	auipc	a1,0x0
    80002110:	e9c58593          	addi	a1,a1,-356 # 80001fa8 <_ZN6Thread10wrapperRunEPv>
    80002114:	00850513          	addi	a0,a0,8
    80002118:	fffff097          	auipc	ra,0xfffff
    8000211c:	238080e7          	jalr	568(ra) # 80001350 <_Z13thread_createPP3TCBPFvPvES2_>
    80002120:	00050463          	beqz	a0,80002128 <_ZN6ThreadC1Ev+0x4c>
    {
        myHandle = nullptr;
    80002124:	0004b423          	sd	zero,8(s1)
    }
}
    80002128:	01813083          	ld	ra,24(sp)
    8000212c:	01013403          	ld	s0,16(sp)
    80002130:	00813483          	ld	s1,8(sp)
    80002134:	02010113          	addi	sp,sp,32
    80002138:	00008067          	ret

000000008000213c <_ZN7Console4getcEv>:

char Console::getc()
{
    8000213c:	ff010113          	addi	sp,sp,-16
    80002140:	00113423          	sd	ra,8(sp)
    80002144:	00813023          	sd	s0,0(sp)
    80002148:	01010413          	addi	s0,sp,16
   return ::getc();
    8000214c:	fffff097          	auipc	ra,0xfffff
    80002150:	58c080e7          	jalr	1420(ra) # 800016d8 <_Z4getcv>
}
    80002154:	00813083          	ld	ra,8(sp)
    80002158:	00013403          	ld	s0,0(sp)
    8000215c:	01010113          	addi	sp,sp,16
    80002160:	00008067          	ret

0000000080002164 <_ZN7Console4putcEc>:

void Console::putc(char c)
{
    80002164:	ff010113          	addi	sp,sp,-16
    80002168:	00113423          	sd	ra,8(sp)
    8000216c:	00813023          	sd	s0,0(sp)
    80002170:	01010413          	addi	s0,sp,16
    ::putc(c);
    80002174:	fffff097          	auipc	ra,0xfffff
    80002178:	5b8080e7          	jalr	1464(ra) # 8000172c <_Z4putcc>
    8000217c:	00813083          	ld	ra,8(sp)
    80002180:	00013403          	ld	s0,0(sp)
    80002184:	01010113          	addi	sp,sp,16
    80002188:	00008067          	ret

000000008000218c <_ZN6Thread3runEv>:
    static int sleep(time_t);

protected:
    Thread();
    static void wrapperRun(void*);
    virtual void run() {}
    8000218c:	ff010113          	addi	sp,sp,-16
    80002190:	00813423          	sd	s0,8(sp)
    80002194:	01010413          	addi	s0,sp,16
    80002198:	00813403          	ld	s0,8(sp)
    8000219c:	01010113          	addi	sp,sp,16
    800021a0:	00008067          	ret

00000000800021a4 <_ZN3TCB13threadWrapperEv>:
    {
        Scheduler::put(this);
    }
}
void TCB::threadWrapper()
{
    800021a4:	ff010113          	addi	sp,sp,-16
    800021a8:	00113423          	sd	ra,8(sp)
    800021ac:	00813023          	sd	s0,0(sp)
    800021b0:	01010413          	addi	s0,sp,16
    running->body(running->arguments);
    800021b4:	00006797          	auipc	a5,0x6
    800021b8:	6dc7b783          	ld	a5,1756(a5) # 80008890 <_ZN3TCB7runningE>
    800021bc:	0007b703          	ld	a4,0(a5)
    800021c0:	0387b503          	ld	a0,56(a5)
    800021c4:	000700e7          	jalr	a4
    thread_exit();
    800021c8:	fffff097          	auipc	ra,0xfffff
    800021cc:	270080e7          	jalr	624(ra) # 80001438 <_Z11thread_exitv>

}
    800021d0:	00813083          	ld	ra,8(sp)
    800021d4:	00013403          	ld	s0,0(sp)
    800021d8:	01010113          	addi	sp,sp,16
    800021dc:	00008067          	ret

00000000800021e0 <_ZN3TCB16initializeThreadEPFvPvES0_S0_S0_P10ObjectPoolIS_Lm20EEN12KernelConfig11ThreadStateENS6_4ModeE>:
    body = function;
    800021e0:	00b53023          	sd	a1,0(a0)
    timeSlice = DEFAULT_TIME_SLICE;
    800021e4:	00200593          	li	a1,2
    800021e8:	02b53823          	sd	a1,48(a0)
    state = nullptr;
    800021ec:	04053423          	sd	zero,72(a0)
    finished = false;
    800021f0:	04050823          	sb	zero,80(a0)
    arguments = arg;
    800021f4:	02c53c23          	sd	a2,56(a0)
    waitOnSemaphore = nullptr;
    800021f8:	04053023          	sd	zero,64(a0)
    timeToSleep = 0;
    800021fc:	04053c23          	sd	zero,88(a0)
    sourcePool = pool;
    80002200:	06f53423          	sd	a5,104(a0)
    queueOfWaitThreads = nullptr;
    80002204:	06053023          	sd	zero,96(a0)
    userStack = (void*)((uint8*)allocatedStack - DEFAULT_STACK_SIZE);
    80002208:	fffff7b7          	lui	a5,0xfffff
    8000220c:	00f687b3          	add	a5,a3,a5
    80002210:	02f53023          	sd	a5,32(a0)
    systemStack = (void*)((uint8*)allocatedSystemStack - KernelConfig::DEFAULT_SYSTEM_STACK_SIZE);
    80002214:	c0070793          	addi	a5,a4,-1024
    80002218:	02f53423          	sd	a5,40(a0)
    *((uint64*)allocatedSystemStack - 30) = (uint64)((uint64*)allocatedStack - 2);
    8000221c:	ff068693          	addi	a3,a3,-16
    80002220:	f0d73823          	sd	a3,-240(a4)
    __asm__ volatile ("csrc sip, %[reg]":: [reg] "r"(mask));
}
inline uint64 Machine::readSscratch()
{
    uint64 returnValue;
    __asm__ volatile ("csrr %[reg], sscratch": [reg] "=r"(returnValue));
    80002224:	140027f3          	csrr	a5,sscratch
    context = {Machine::readSscratch(), (uint64) ((uint64*)allocatedSystemStack - 32), mode};
    80002228:	f0070713          	addi	a4,a4,-256
    8000222c:	00f53423          	sd	a5,8(a0)
    80002230:	00e53823          	sd	a4,16(a0)
    80002234:	01152c23          	sw	a7,24(a0)
    Machine::writeSepc((uint64)&threadWrapper);
    80002238:	00000797          	auipc	a5,0x0
    8000223c:	f6c78793          	addi	a5,a5,-148 # 800021a4 <_ZN3TCB13threadWrapperEv>
    return returnValue;
}
inline void Machine::writeSepc(uint64 address)
{
    __asm__ volatile("csrw sepc, %[reg]":: [reg] "r"(address));
    80002240:	14179073          	csrw	sepc,a5
    if(stateOfThread == KernelConfig::ACTIVE)
    80002244:	00080463          	beqz	a6,8000224c <_ZN3TCB16initializeThreadEPFvPvES0_S0_S0_P10ObjectPoolIS_Lm20EEN12KernelConfig11ThreadStateENS6_4ModeE+0x6c>
    80002248:	00008067          	ret
{
    8000224c:	ff010113          	addi	sp,sp,-16
    80002250:	00113423          	sd	ra,8(sp)
    80002254:	00813023          	sd	s0,0(sp)
    80002258:	01010413          	addi	s0,sp,16
        Scheduler::put(this);
    8000225c:	00000097          	auipc	ra,0x0
    80002260:	c6c080e7          	jalr	-916(ra) # 80001ec8 <_ZN9Scheduler3putEP3TCB>
}
    80002264:	00813083          	ld	ra,8(sp)
    80002268:	00013403          	ld	s0,0(sp)
    8000226c:	01010113          	addi	sp,sp,16
    80002270:	00008067          	ret

0000000080002274 <_ZN3TCB5yieldEPS_S0_>:
void TCB::yield(TCB *oldThread, TCB *newThread)
{
    80002274:	ff010113          	addi	sp,sp,-16
    80002278:	00113423          	sd	ra,8(sp)
    8000227c:	00813023          	sd	s0,0(sp)
    80002280:	01010413          	addi	s0,sp,16
    context_switch(oldThread->getContext(), newThread->getContext());
    80002284:	00858593          	addi	a1,a1,8
    80002288:	00850513          	addi	a0,a0,8
    8000228c:	fffff097          	auipc	ra,0xfffff
    80002290:	f14080e7          	jalr	-236(ra) # 800011a0 <context_switch>
}
    80002294:	00813083          	ld	ra,8(sp)
    80002298:	00013403          	ld	s0,0(sp)
    8000229c:	01010113          	addi	sp,sp,16
    800022a0:	00008067          	ret

00000000800022a4 <_ZN3TCB8dispatchEv>:

void TCB::dispatch()
{
    800022a4:	fe010113          	addi	sp,sp,-32
    800022a8:	00113c23          	sd	ra,24(sp)
    800022ac:	00813823          	sd	s0,16(sp)
    800022b0:	00913423          	sd	s1,8(sp)
    800022b4:	02010413          	addi	s0,sp,32
    TCB* oldThread = running;
    800022b8:	00006497          	auipc	s1,0x6
    800022bc:	5d84b483          	ld	s1,1496(s1) # 80008890 <_ZN3TCB7runningE>
    bool isFinished() const { return finished; }
    800022c0:	0504c783          	lbu	a5,80(s1)
    if(!oldThread->isFinished())
    800022c4:	02078c63          	beqz	a5,800022fc <_ZN3TCB8dispatchEv+0x58>
    {
        Scheduler::put(oldThread);
    }
    running = Scheduler::get();
    800022c8:	00000097          	auipc	ra,0x0
    800022cc:	c34080e7          	jalr	-972(ra) # 80001efc <_ZN9Scheduler3getEv>
    800022d0:	00050593          	mv	a1,a0
    800022d4:	00006797          	auipc	a5,0x6
    800022d8:	5aa7be23          	sd	a0,1468(a5) # 80008890 <_ZN3TCB7runningE>
    yield(oldThread, running);
    800022dc:	00048513          	mv	a0,s1
    800022e0:	00000097          	auipc	ra,0x0
    800022e4:	f94080e7          	jalr	-108(ra) # 80002274 <_ZN3TCB5yieldEPS_S0_>
}
    800022e8:	01813083          	ld	ra,24(sp)
    800022ec:	01013403          	ld	s0,16(sp)
    800022f0:	00813483          	ld	s1,8(sp)
    800022f4:	02010113          	addi	sp,sp,32
    800022f8:	00008067          	ret
        Scheduler::put(oldThread);
    800022fc:	00048513          	mv	a0,s1
    80002300:	00000097          	auipc	ra,0x0
    80002304:	bc8080e7          	jalr	-1080(ra) # 80001ec8 <_ZN9Scheduler3putEP3TCB>
    80002308:	fc1ff06f          	j	800022c8 <_ZN3TCB8dispatchEv+0x24>

000000008000230c <_ZN3TCBD1Ev>:
TCB::~TCB()
    8000230c:	fe010113          	addi	sp,sp,-32
    80002310:	00113c23          	sd	ra,24(sp)
    80002314:	00813823          	sd	s0,16(sp)
    80002318:	00913423          	sd	s1,8(sp)
    8000231c:	02010413          	addi	s0,sp,32
    80002320:	00050493          	mv	s1,a0
{
    MemoryAllocator::freeMemory(userStack);
    80002324:	02053503          	ld	a0,32(a0)
    80002328:	00000097          	auipc	ra,0x0
    8000232c:	3cc080e7          	jalr	972(ra) # 800026f4 <_ZN15MemoryAllocator10freeMemoryEPv>
    MemoryAllocator::freeMemory(systemStack);
    80002330:	0284b503          	ld	a0,40(s1)
    80002334:	00000097          	auipc	ra,0x0
    80002338:	3c0080e7          	jalr	960(ra) # 800026f4 <_ZN15MemoryAllocator10freeMemoryEPv>
}
    8000233c:	01813083          	ld	ra,24(sp)
    80002340:	01013403          	ld	s0,16(sp)
    80002344:	00813483          	ld	s1,8(sp)
    80002348:	02010113          	addi	sp,sp,32
    8000234c:	00008067          	ret

0000000080002350 <_ZN3TCB5startEPS_>:
void TCB::start(TCB* readyThread)
{
    80002350:	ff010113          	addi	sp,sp,-16
    80002354:	00113423          	sd	ra,8(sp)
    80002358:	00813023          	sd	s0,0(sp)
    8000235c:	01010413          	addi	s0,sp,16
    Scheduler::put(readyThread);
    80002360:	00000097          	auipc	ra,0x0
    80002364:	b68080e7          	jalr	-1176(ra) # 80001ec8 <_ZN9Scheduler3putEP3TCB>
}
    80002368:	00813083          	ld	ra,8(sp)
    8000236c:	00013403          	ld	s0,0(sp)
    80002370:	01010113          	addi	sp,sp,16
    80002374:	00008067          	ret

0000000080002378 <_ZN3TCB15freeWaitThreadsEv>:
void TCB::freeWaitThreads()
{
    80002378:	fe010113          	addi	sp,sp,-32
    8000237c:	00113c23          	sd	ra,24(sp)
    80002380:	00813823          	sd	s0,16(sp)
    80002384:	00913423          	sd	s1,8(sp)
    80002388:	02010413          	addi	s0,sp,32
    8000238c:	00050493          	mv	s1,a0
    TCB* temp;
    while(!queueOfWaitThreads->isQueueEmpty())
    80002390:	0604b503          	ld	a0,96(s1)
    80002394:	00053783          	ld	a5,0(a0)
    80002398:	00078c63          	beqz	a5,800023b0 <_ZN3TCB15freeWaitThreadsEv+0x38>
    {
        temp = queueOfWaitThreads->take();
    8000239c:	00000097          	auipc	ra,0x0
    800023a0:	9bc080e7          	jalr	-1604(ra) # 80001d58 <_ZN5QueueI3TCBE4takeEv>
        Scheduler::put(temp);
    800023a4:	00000097          	auipc	ra,0x0
    800023a8:	b24080e7          	jalr	-1244(ra) # 80001ec8 <_ZN9Scheduler3putEP3TCB>
    while(!queueOfWaitThreads->isQueueEmpty())
    800023ac:	fe5ff06f          	j	80002390 <_ZN3TCB15freeWaitThreadsEv+0x18>
    }
}
    800023b0:	01813083          	ld	ra,24(sp)
    800023b4:	01013403          	ld	s0,16(sp)
    800023b8:	00813483          	ld	s1,8(sp)
    800023bc:	02010113          	addi	sp,sp,32
    800023c0:	00008067          	ret

00000000800023c4 <_ZN3TCB20addThreadToWaitQueueEPS_>:
void TCB::addThreadToWaitQueue(TCB *newThread)
{
    800023c4:	ff010113          	addi	sp,sp,-16
    800023c8:	00113423          	sd	ra,8(sp)
    800023cc:	00813023          	sd	s0,0(sp)
    800023d0:	01010413          	addi	s0,sp,16
    queueOfWaitThreads->append(newThread);
    800023d4:	06053503          	ld	a0,96(a0)
    800023d8:	00000097          	auipc	ra,0x0
    800023dc:	94c080e7          	jalr	-1716(ra) # 80001d24 <_ZN5QueueI3TCBE6appendEPS0_>
}
    800023e0:	00813083          	ld	ra,8(sp)
    800023e4:	00013403          	ld	s0,0(sp)
    800023e8:	01010113          	addi	sp,sp,16
    800023ec:	00008067          	ret

00000000800023f0 <_ZN15MemoryAllocator16initializeMemoryEv>:
size_t MemoryAllocator::NUM_OF_BLOCKS = 0;
size_t MemoryAllocator::numOfFreeBlocks = 0;
MemoryAllocator::FreeBlock* MemoryAllocator::firstFreeBlock = nullptr;

void MemoryAllocator::initializeMemory()
{
    800023f0:	ff010113          	addi	sp,sp,-16
    800023f4:	00813423          	sd	s0,8(sp)
    800023f8:	01010413          	addi	s0,sp,16

    NUM_OF_BLOCKS = ((uint8*)HEAP_END_ADDR - (uint8*)HEAP_START_ADDR) / MEM_BLOCK_SIZE;
    800023fc:	00006797          	auipc	a5,0x6
    80002400:	3e47b783          	ld	a5,996(a5) # 800087e0 <_GLOBAL_OFFSET_TABLE_+0x70>
    80002404:	0007b703          	ld	a4,0(a5)
    80002408:	00006797          	auipc	a5,0x6
    8000240c:	3807b783          	ld	a5,896(a5) # 80008788 <_GLOBAL_OFFSET_TABLE_+0x18>
    80002410:	0007b683          	ld	a3,0(a5)
    80002414:	40d70733          	sub	a4,a4,a3
    80002418:	00675713          	srli	a4,a4,0x6
    8000241c:	00006797          	auipc	a5,0x6
    80002420:	48478793          	addi	a5,a5,1156 # 800088a0 <_ZN15MemoryAllocator13NUM_OF_BLOCKSE>
    80002424:	00e7b023          	sd	a4,0(a5)
    numOfFreeBlocks = NUM_OF_BLOCKS;
    80002428:	00e7b423          	sd	a4,8(a5)

    firstFreeBlock = (FreeBlock*)(HEAP_START_ADDR);
    8000242c:	00d7b823          	sd	a3,16(a5)

    firstFreeBlock->flagFree = true;
    80002430:	00100613          	li	a2,1
    80002434:	00c68023          	sb	a2,0(a3)
    firstFreeBlock->numOfBlocks = NUM_OF_BLOCKS;
    80002438:	0107b703          	ld	a4,16(a5)
    8000243c:	0007b683          	ld	a3,0(a5)
    80002440:	00d73423          	sd	a3,8(a4)
    firstFreeBlock->nextBlock = nullptr;
    80002444:	00073823          	sd	zero,16(a4)
    firstFreeBlock->previousBlock = nullptr;
    80002448:	00073c23          	sd	zero,24(a4)
    flagSystemInitialize = 1;
    8000244c:	00c78c23          	sb	a2,24(a5)
}
    80002450:	00813403          	ld	s0,8(sp)
    80002454:	01010113          	addi	sp,sp,16
    80002458:	00008067          	ret

000000008000245c <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m>:
    occupiedBlock++;
    return occupiedBlock;
}

void MemoryAllocator::remapMemory(FreeBlock **head, FreeBlock *allocatedBlocks, size_t blocksToAllocate)
{
    8000245c:	ff010113          	addi	sp,sp,-16
    80002460:	00813423          	sd	s0,8(sp)
    80002464:	01010413          	addi	s0,sp,16

    if(allocatedBlocks->numOfBlocks == 0)
    80002468:	0085b783          	ld	a5,8(a1)
    8000246c:	04079263          	bnez	a5,800024b0 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x54>
    {

        if(allocatedBlocks->previousBlock)
    80002470:	0185b783          	ld	a5,24(a1)
    80002474:	00078663          	beqz	a5,80002480 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x24>
        {
            allocatedBlocks->previousBlock->nextBlock = allocatedBlocks->nextBlock;
    80002478:	0105b703          	ld	a4,16(a1)
    8000247c:	00e7b823          	sd	a4,16(a5)
        }

        if(allocatedBlocks->nextBlock)
    80002480:	0105b783          	ld	a5,16(a1)
    80002484:	00078663          	beqz	a5,80002490 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x34>
        {
            allocatedBlocks->nextBlock->previousBlock = allocatedBlocks->previousBlock;
    80002488:	0185b703          	ld	a4,24(a1)
    8000248c:	00e7bc23          	sd	a4,24(a5)
        }

        if(*head == allocatedBlocks)
    80002490:	00053783          	ld	a5,0(a0)
    80002494:	00b78863          	beq	a5,a1,800024a4 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x48>
        {
            *head = newFreeBlock;
        }
    }

}
    80002498:	00813403          	ld	s0,8(sp)
    8000249c:	01010113          	addi	sp,sp,16
    800024a0:	00008067          	ret
            *head = allocatedBlocks->nextBlock;
    800024a4:	0105b783          	ld	a5,16(a1)
    800024a8:	00f53023          	sd	a5,0(a0)
    800024ac:	fedff06f          	j	80002498 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x3c>
        FreeBlock* newFreeBlock = (FreeBlock*)((uint8*)allocatedBlocks + blocksToAllocate * MEM_BLOCK_SIZE);
    800024b0:	00661613          	slli	a2,a2,0x6
    800024b4:	00c58633          	add	a2,a1,a2
        newFreeBlock->flagFree = true;
    800024b8:	00100793          	li	a5,1
    800024bc:	00f60023          	sb	a5,0(a2)
        newFreeBlock->numOfBlocks = allocatedBlocks->numOfBlocks;
    800024c0:	0085b783          	ld	a5,8(a1)
    800024c4:	00f63423          	sd	a5,8(a2)
        if(allocatedBlocks->previousBlock)
    800024c8:	0185b783          	ld	a5,24(a1)
    800024cc:	00078463          	beqz	a5,800024d4 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x78>
            allocatedBlocks->previousBlock->nextBlock = newFreeBlock;
    800024d0:	00c7b823          	sd	a2,16(a5)
        newFreeBlock->previousBlock = allocatedBlocks->previousBlock;
    800024d4:	0185b783          	ld	a5,24(a1)
    800024d8:	00f63c23          	sd	a5,24(a2)
        newFreeBlock->nextBlock = allocatedBlocks->nextBlock;
    800024dc:	0105b783          	ld	a5,16(a1)
    800024e0:	00f63823          	sd	a5,16(a2)
        if(*head == allocatedBlocks)
    800024e4:	00053783          	ld	a5,0(a0)
    800024e8:	fab798e3          	bne	a5,a1,80002498 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x3c>
            *head = newFreeBlock;
    800024ec:	00c53023          	sd	a2,0(a0)
}
    800024f0:	fa9ff06f          	j	80002498 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x3c>

00000000800024f4 <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm>:
{
    800024f4:	fe010113          	addi	sp,sp,-32
    800024f8:	00113c23          	sd	ra,24(sp)
    800024fc:	00813823          	sd	s0,16(sp)
    80002500:	00913423          	sd	s1,8(sp)
    80002504:	01213023          	sd	s2,0(sp)
    80002508:	02010413          	addi	s0,sp,32
    8000250c:	00058913          	mv	s2,a1
    for(FreeBlock* curr = (*head); curr; curr = curr->nextBlock)
    80002510:	00053783          	ld	a5,0(a0)
    FreeBlock* bestBlock = nullptr;
    80002514:	00000493          	li	s1,0
    80002518:	00c0006f          	j	80002524 <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm+0x30>
                bestBlock = curr;
    8000251c:	00078493          	mv	s1,a5
    for(FreeBlock* curr = (*head); curr; curr = curr->nextBlock)
    80002520:	0107b783          	ld	a5,16(a5)
    80002524:	02078063          	beqz	a5,80002544 <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm+0x50>
        if(curr->numOfBlocks >= blocksToAllocate)
    80002528:	0087b703          	ld	a4,8(a5)
    8000252c:	ff276ae3          	bltu	a4,s2,80002520 <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm+0x2c>
        {   if(bestBlock == nullptr)
    80002530:	fe0486e3          	beqz	s1,8000251c <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm+0x28>
            if(bestBlock->numOfBlocks > curr->numOfBlocks)
    80002534:	0084b683          	ld	a3,8(s1)
    80002538:	fed774e3          	bgeu	a4,a3,80002520 <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm+0x2c>
                bestBlock = curr;
    8000253c:	00078493          	mv	s1,a5
    80002540:	fe1ff06f          	j	80002520 <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm+0x2c>
    numOfFreeBlocks -= blocksToAllocate;
    80002544:	00006717          	auipc	a4,0x6
    80002548:	35c70713          	addi	a4,a4,860 # 800088a0 <_ZN15MemoryAllocator13NUM_OF_BLOCKSE>
    8000254c:	00873783          	ld	a5,8(a4)
    80002550:	412787b3          	sub	a5,a5,s2
    80002554:	00f73423          	sd	a5,8(a4)
    bestBlock->numOfBlocks -= blocksToAllocate;
    80002558:	0084b783          	ld	a5,8(s1)
    8000255c:	412787b3          	sub	a5,a5,s2
    80002560:	00f4b423          	sd	a5,8(s1)
    remapMemory(head, bestBlock, blocksToAllocate);
    80002564:	00090613          	mv	a2,s2
    80002568:	00048593          	mv	a1,s1
    8000256c:	00000097          	auipc	ra,0x0
    80002570:	ef0080e7          	jalr	-272(ra) # 8000245c <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m>
    occupiedBlock->flagFree = false;
    80002574:	00048023          	sb	zero,0(s1)
    occupiedBlock->numOfBlocks = blocksToAllocate;
    80002578:	0124b423          	sd	s2,8(s1)
}
    8000257c:	01048513          	addi	a0,s1,16
    80002580:	01813083          	ld	ra,24(sp)
    80002584:	01013403          	ld	s0,16(sp)
    80002588:	00813483          	ld	s1,8(sp)
    8000258c:	00013903          	ld	s2,0(sp)
    80002590:	02010113          	addi	sp,sp,32
    80002594:	00008067          	ret

0000000080002598 <_ZN15MemoryAllocator14allocateMemoryEm>:
{
    80002598:	fe010113          	addi	sp,sp,-32
    8000259c:	00113c23          	sd	ra,24(sp)
    800025a0:	00813823          	sd	s0,16(sp)
    800025a4:	00913423          	sd	s1,8(sp)
    800025a8:	02010413          	addi	s0,sp,32
    800025ac:	00050493          	mv	s1,a0
    if(!flagSystemInitialize)
    800025b0:	00006797          	auipc	a5,0x6
    800025b4:	3087c783          	lbu	a5,776(a5) # 800088b8 <_ZN15MemoryAllocator20flagSystemInitializeE>
    800025b8:	02078c63          	beqz	a5,800025f0 <_ZN15MemoryAllocator14allocateMemoryEm+0x58>
    if(numOfFreeBlocks < blocksToAllocate)
    800025bc:	00006797          	auipc	a5,0x6
    800025c0:	2ec7b783          	ld	a5,748(a5) # 800088a8 <_ZN15MemoryAllocator15numOfFreeBlocksE>
    800025c4:	0297ec63          	bltu	a5,s1,800025fc <_ZN15MemoryAllocator14allocateMemoryEm+0x64>
    return findBestFit(&firstFreeBlock, blocksToAllocate);
    800025c8:	00048593          	mv	a1,s1
    800025cc:	00006517          	auipc	a0,0x6
    800025d0:	2e450513          	addi	a0,a0,740 # 800088b0 <_ZN15MemoryAllocator14firstFreeBlockE>
    800025d4:	00000097          	auipc	ra,0x0
    800025d8:	f20080e7          	jalr	-224(ra) # 800024f4 <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm>
}
    800025dc:	01813083          	ld	ra,24(sp)
    800025e0:	01013403          	ld	s0,16(sp)
    800025e4:	00813483          	ld	s1,8(sp)
    800025e8:	02010113          	addi	sp,sp,32
    800025ec:	00008067          	ret
        initializeMemory();
    800025f0:	00000097          	auipc	ra,0x0
    800025f4:	e00080e7          	jalr	-512(ra) # 800023f0 <_ZN15MemoryAllocator16initializeMemoryEv>
    800025f8:	fc5ff06f          	j	800025bc <_ZN15MemoryAllocator14allocateMemoryEm+0x24>
        return nullptr;
    800025fc:	00000513          	li	a0,0
    80002600:	fddff06f          	j	800025dc <_ZN15MemoryAllocator14allocateMemoryEm+0x44>

0000000080002604 <_ZN15MemoryAllocator17findNextFreeBlockEPNS_9FreeBlockE>:
MemoryAllocator::FreeBlock* MemoryAllocator::findNextFreeBlock(FreeBlock* memoryToFree)
{
    80002604:	ff010113          	addi	sp,sp,-16
    80002608:	00813423          	sd	s0,8(sp)
    8000260c:	01010413          	addi	s0,sp,16
    for(uint8* i = (uint8*)memoryToFree; i + MEM_BLOCK_SIZE <= (uint8*)HEAP_END_ADDR; i+= (((OccupiedBlock*)i)->numOfBlocks * MEM_BLOCK_SIZE))
    80002610:	04050793          	addi	a5,a0,64
    80002614:	00006717          	auipc	a4,0x6
    80002618:	1cc73703          	ld	a4,460(a4) # 800087e0 <_GLOBAL_OFFSET_TABLE_+0x70>
    8000261c:	00073703          	ld	a4,0(a4)
    80002620:	00f76e63          	bltu	a4,a5,8000263c <_ZN15MemoryAllocator17findNextFreeBlockEPNS_9FreeBlockE+0x38>
    {
        if(((FreeBlock*)i)->flagFree)
    80002624:	00054783          	lbu	a5,0(a0)
    80002628:	00079c63          	bnez	a5,80002640 <_ZN15MemoryAllocator17findNextFreeBlockEPNS_9FreeBlockE+0x3c>
    for(uint8* i = (uint8*)memoryToFree; i + MEM_BLOCK_SIZE <= (uint8*)HEAP_END_ADDR; i+= (((OccupiedBlock*)i)->numOfBlocks * MEM_BLOCK_SIZE))
    8000262c:	00853783          	ld	a5,8(a0)
    80002630:	00679793          	slli	a5,a5,0x6
    80002634:	00f50533          	add	a0,a0,a5
    80002638:	fd9ff06f          	j	80002610 <_ZN15MemoryAllocator17findNextFreeBlockEPNS_9FreeBlockE+0xc>
        {
            return (FreeBlock*)i;
        }
    }
    return nullptr;
    8000263c:	00000513          	li	a0,0
}
    80002640:	00813403          	ld	s0,8(sp)
    80002644:	01010113          	addi	sp,sp,16
    80002648:	00008067          	ret

000000008000264c <_ZN15MemoryAllocator21findPreviousFreeBlockEPNS_9FreeBlockES1_>:

MemoryAllocator::FreeBlock* MemoryAllocator::findPreviousFreeBlock(FreeBlock* head, FreeBlock* memoryToFree)
{
    8000264c:	ff010113          	addi	sp,sp,-16
    80002650:	00813423          	sd	s0,8(sp)
    80002654:	01010413          	addi	s0,sp,16
    FreeBlock* temp = head;
    for(; temp && temp <= memoryToFree; temp = temp->nextBlock){}
    80002658:	00050863          	beqz	a0,80002668 <_ZN15MemoryAllocator21findPreviousFreeBlockEPNS_9FreeBlockES1_+0x1c>
    8000265c:	00a5e663          	bltu	a1,a0,80002668 <_ZN15MemoryAllocator21findPreviousFreeBlockEPNS_9FreeBlockES1_+0x1c>
    80002660:	01053503          	ld	a0,16(a0)
    80002664:	ff5ff06f          	j	80002658 <_ZN15MemoryAllocator21findPreviousFreeBlockEPNS_9FreeBlockES1_+0xc>
    if(!temp)
    80002668:	00050463          	beqz	a0,80002670 <_ZN15MemoryAllocator21findPreviousFreeBlockEPNS_9FreeBlockES1_+0x24>
    {
        return nullptr;
    }
    return temp->previousBlock;
    8000266c:	01853503          	ld	a0,24(a0)
}
    80002670:	00813403          	ld	s0,8(sp)
    80002674:	01010113          	addi	sp,sp,16
    80002678:	00008067          	ret

000000008000267c <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_>:

    return 0;
}

void MemoryAllocator::connectAdjacentBlocks(FreeBlock* previousBlock, FreeBlock* adjacentBlock)
{
    8000267c:	ff010113          	addi	sp,sp,-16
    80002680:	00813423          	sd	s0,8(sp)
    80002684:	01010413          	addi	s0,sp,16


    if(adjacentBlock == (FreeBlock*)((uint8 *)previousBlock + previousBlock->numOfBlocks * MEM_BLOCK_SIZE))
    80002688:	00853703          	ld	a4,8(a0)
    8000268c:	00671793          	slli	a5,a4,0x6
    80002690:	00f507b3          	add	a5,a0,a5
    80002694:	00b78e63          	beq	a5,a1,800026b0 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_+0x34>
        adjacentBlock->previousBlock = nullptr;

    }
    else
    {
        previousBlock->nextBlock = adjacentBlock;
    80002698:	00b53823          	sd	a1,16(a0)
        if(adjacentBlock)
    8000269c:	00058463          	beqz	a1,800026a4 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_+0x28>
        {
            adjacentBlock->previousBlock = previousBlock;
    800026a0:	00a5bc23          	sd	a0,24(a1)
        }

    }
}
    800026a4:	00813403          	ld	s0,8(sp)
    800026a8:	01010113          	addi	sp,sp,16
    800026ac:	00008067          	ret
        previousBlock->numOfBlocks += adjacentBlock->numOfBlocks;
    800026b0:	0085b783          	ld	a5,8(a1)
    800026b4:	00f70733          	add	a4,a4,a5
    800026b8:	00e53423          	sd	a4,8(a0)
        previousBlock->nextBlock = adjacentBlock->nextBlock;
    800026bc:	0105b783          	ld	a5,16(a1)
    800026c0:	00f53823          	sd	a5,16(a0)
        if(adjacentBlock->nextBlock != nullptr)
    800026c4:	00078463          	beqz	a5,800026cc <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_+0x50>
            adjacentBlock->nextBlock->previousBlock = previousBlock;
    800026c8:	00a7bc23          	sd	a0,24(a5)
        if(adjacentBlock->previousBlock != previousBlock && adjacentBlock->previousBlock != nullptr)
    800026cc:	0185b783          	ld	a5,24(a1)
    800026d0:	00a78863          	beq	a5,a0,800026e0 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_+0x64>
    800026d4:	00078663          	beqz	a5,800026e0 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_+0x64>
            previousBlock->previousBlock = adjacentBlock->previousBlock;
    800026d8:	00f53c23          	sd	a5,24(a0)
            adjacentBlock->previousBlock->nextBlock = previousBlock;
    800026dc:	00a7b823          	sd	a0,16(a5)
        adjacentBlock->flagFree = false;
    800026e0:	00058023          	sb	zero,0(a1)
        adjacentBlock->numOfBlocks = 0;
    800026e4:	0005b423          	sd	zero,8(a1)
        adjacentBlock->nextBlock = nullptr;
    800026e8:	0005b823          	sd	zero,16(a1)
        adjacentBlock->previousBlock = nullptr;
    800026ec:	0005bc23          	sd	zero,24(a1)
    800026f0:	fb5ff06f          	j	800026a4 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_+0x28>

00000000800026f4 <_ZN15MemoryAllocator10freeMemoryEPv>:
    if(!addressToFree)
    800026f4:	0c050e63          	beqz	a0,800027d0 <_ZN15MemoryAllocator10freeMemoryEPv+0xdc>
{
    800026f8:	fc010113          	addi	sp,sp,-64
    800026fc:	02113c23          	sd	ra,56(sp)
    80002700:	02813823          	sd	s0,48(sp)
    80002704:	02913423          	sd	s1,40(sp)
    80002708:	03213023          	sd	s2,32(sp)
    8000270c:	01313c23          	sd	s3,24(sp)
    80002710:	01413823          	sd	s4,16(sp)
    80002714:	01513423          	sd	s5,8(sp)
    80002718:	04010413          	addi	s0,sp,64
    8000271c:	00050493          	mv	s1,a0
    tempAddress--;
    80002720:	ff050913          	addi	s2,a0,-16
    int numOfTakenBlocks = tempAddress->numOfBlocks;
    80002724:	ff852a83          	lw	s5,-8(a0)
    numOfFreeBlocks += numOfTakenBlocks;
    80002728:	00006997          	auipc	s3,0x6
    8000272c:	17898993          	addi	s3,s3,376 # 800088a0 <_ZN15MemoryAllocator13NUM_OF_BLOCKSE>
    80002730:	0089b783          	ld	a5,8(s3)
    80002734:	015787b3          	add	a5,a5,s5
    80002738:	00f9b423          	sd	a5,8(s3)
    FreeBlock* nextFreeBlock = findNextFreeBlock(newFreeBlock);
    8000273c:	00090513          	mv	a0,s2
    80002740:	00000097          	auipc	ra,0x0
    80002744:	ec4080e7          	jalr	-316(ra) # 80002604 <_ZN15MemoryAllocator17findNextFreeBlockEPNS_9FreeBlockE>
    80002748:	00050a13          	mv	s4,a0
    FreeBlock* previousFreeBlock = findPreviousFreeBlock(firstFreeBlock, newFreeBlock);
    8000274c:	00090593          	mv	a1,s2
    80002750:	0109b503          	ld	a0,16(s3)
    80002754:	00000097          	auipc	ra,0x0
    80002758:	ef8080e7          	jalr	-264(ra) # 8000264c <_ZN15MemoryAllocator21findPreviousFreeBlockEPNS_9FreeBlockES1_>
    8000275c:	00050993          	mv	s3,a0
    newFreeBlock->flagFree = true;
    80002760:	00100793          	li	a5,1
    80002764:	fef48823          	sb	a5,-16(s1)
    newFreeBlock->numOfBlocks = numOfTakenBlocks;
    80002768:	ff54bc23          	sd	s5,-8(s1)
    newFreeBlock->nextBlock = nullptr;
    8000276c:	0004b023          	sd	zero,0(s1)
    newFreeBlock->previousBlock = nullptr;
    80002770:	0004b423          	sd	zero,8(s1)
    connectAdjacentBlocks(newFreeBlock, nextFreeBlock);
    80002774:	000a0593          	mv	a1,s4
    80002778:	00090513          	mv	a0,s2
    8000277c:	00000097          	auipc	ra,0x0
    80002780:	f00080e7          	jalr	-256(ra) # 8000267c <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_>
    if(previousFreeBlock)
    80002784:	02098e63          	beqz	s3,800027c0 <_ZN15MemoryAllocator10freeMemoryEPv+0xcc>
        connectAdjacentBlocks(previousFreeBlock, newFreeBlock);
    80002788:	00090593          	mv	a1,s2
    8000278c:	00098513          	mv	a0,s3
    80002790:	00000097          	auipc	ra,0x0
    80002794:	eec080e7          	jalr	-276(ra) # 8000267c <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_>
    return 0;
    80002798:	00000513          	li	a0,0
}
    8000279c:	03813083          	ld	ra,56(sp)
    800027a0:	03013403          	ld	s0,48(sp)
    800027a4:	02813483          	ld	s1,40(sp)
    800027a8:	02013903          	ld	s2,32(sp)
    800027ac:	01813983          	ld	s3,24(sp)
    800027b0:	01013a03          	ld	s4,16(sp)
    800027b4:	00813a83          	ld	s5,8(sp)
    800027b8:	04010113          	addi	sp,sp,64
    800027bc:	00008067          	ret
        firstFreeBlock = newFreeBlock;
    800027c0:	00006797          	auipc	a5,0x6
    800027c4:	0f27b823          	sd	s2,240(a5) # 800088b0 <_ZN15MemoryAllocator14firstFreeBlockE>
    return 0;
    800027c8:	00000513          	li	a0,0
    800027cc:	fd1ff06f          	j	8000279c <_ZN15MemoryAllocator10freeMemoryEPv+0xa8>
        return -1;
    800027d0:	fff00513          	li	a0,-1
}
    800027d4:	00008067          	ret

00000000800027d8 <_ZN15MemoryAllocator19getLargestFreeBlockEv>:

size_t  MemoryAllocator::getLargestFreeBlock()
{
    800027d8:	ff010113          	addi	sp,sp,-16
    800027dc:	00813423          	sd	s0,8(sp)
    800027e0:	01010413          	addi	s0,sp,16
    size_t largestBlock = firstFreeBlock->numOfBlocks;
    800027e4:	00006797          	auipc	a5,0x6
    800027e8:	0cc7b783          	ld	a5,204(a5) # 800088b0 <_ZN15MemoryAllocator14firstFreeBlockE>
    800027ec:	0087b503          	ld	a0,8(a5)
    for(FreeBlock* curr = firstFreeBlock->nextBlock; curr; curr = curr->nextBlock)
    800027f0:	0107b783          	ld	a5,16(a5)
    800027f4:	0080006f          	j	800027fc <_ZN15MemoryAllocator19getLargestFreeBlockEv+0x24>
    800027f8:	0107b783          	ld	a5,16(a5)
    800027fc:	00078a63          	beqz	a5,80002810 <_ZN15MemoryAllocator19getLargestFreeBlockEv+0x38>
    {
        if(curr->numOfBlocks > largestBlock)
    80002800:	0087b703          	ld	a4,8(a5)
    80002804:	fee57ae3          	bgeu	a0,a4,800027f8 <_ZN15MemoryAllocator19getLargestFreeBlockEv+0x20>
        {
            largestBlock = curr->numOfBlocks;
    80002808:	00070513          	mv	a0,a4
    8000280c:	fedff06f          	j	800027f8 <_ZN15MemoryAllocator19getLargestFreeBlockEv+0x20>
        }
    }
    return largestBlock * MEM_BLOCK_SIZE;
}
    80002810:	00651513          	slli	a0,a0,0x6
    80002814:	00813403          	ld	s0,8(sp)
    80002818:	01010113          	addi	sp,sp,16
    8000281c:	00008067          	ret

0000000080002820 <_ZN15MemoryAllocator12getFreeSpaceEv>:
size_t MemoryAllocator::getFreeSpace()
{
    80002820:	ff010113          	addi	sp,sp,-16
    80002824:	00813423          	sd	s0,8(sp)
    80002828:	01010413          	addi	s0,sp,16
    return numOfFreeBlocks * MEM_BLOCK_SIZE;
}
    8000282c:	00006517          	auipc	a0,0x6
    80002830:	07c53503          	ld	a0,124(a0) # 800088a8 <_ZN15MemoryAllocator15numOfFreeBlocksE>
    80002834:	00651513          	slli	a0,a0,0x6
    80002838:	00813403          	ld	s0,8(sp)
    8000283c:	01010113          	addi	sp,sp,16
    80002840:	00008067          	ret

0000000080002844 <_ZN15MemoryAllocator17getSizeOfMetaDataEv>:

size_t MemoryAllocator::getSizeOfMetaData()
{
    80002844:	ff010113          	addi	sp,sp,-16
    80002848:	00813423          	sd	s0,8(sp)
    8000284c:	01010413          	addi	s0,sp,16
    return sizeof(OccupiedBlock);
    80002850:	01000513          	li	a0,16
    80002854:	00813403          	ld	s0,8(sp)
    80002858:	01010113          	addi	sp,sp,16
    8000285c:	00008067          	ret

0000000080002860 <_ZN10KSemaphore19initializeSemaphoreEjP10ObjectPoolIS_Lm10EE>:

extern "C" void context_switch(TCB::Context* oldContext, TCB::Context* newContext);


void KSemaphore::initializeSemaphore(unsigned value, ObjectPool<KSemaphore, KernelConfig::NUM_OF_SEMAPHORES_IN_POOL>* pool)
{
    80002860:	fe010113          	addi	sp,sp,-32
    80002864:	00113c23          	sd	ra,24(sp)
    80002868:	00813823          	sd	s0,16(sp)
    8000286c:	00913423          	sd	s1,8(sp)
    80002870:	01213023          	sd	s2,0(sp)
    80002874:	02010413          	addi	s0,sp,32
    80002878:	00050493          	mv	s1,a0
    8000287c:	00060913          	mv	s2,a2
    semaphoreVal = value;
    80002880:	02059593          	slli	a1,a1,0x20
    80002884:	0205d593          	srli	a1,a1,0x20
    80002888:	00b53023          	sd	a1,0(a0)
    //headBlockedThread = nullptr;
    //tailBlockedThread = nullptr;
    queueBlockedThreads = new Queue<TCB>();
    8000288c:	01000513          	li	a0,16
    80002890:	fffff097          	auipc	ra,0xfffff
    80002894:	430080e7          	jalr	1072(ra) # 80001cc0 <_ZN5QueueI3TCBEnwEm>
    80002898:	00053023          	sd	zero,0(a0)
    8000289c:	00053423          	sd	zero,8(a0)
    800028a0:	00a4b423          	sd	a0,8(s1)
    sourcePool = pool;
    800028a4:	0124b823          	sd	s2,16(s1)
}
    800028a8:	01813083          	ld	ra,24(sp)
    800028ac:	01013403          	ld	s0,16(sp)
    800028b0:	00813483          	ld	s1,8(sp)
    800028b4:	00013903          	ld	s2,0(sp)
    800028b8:	02010113          	addi	sp,sp,32
    800028bc:	00008067          	ret

00000000800028c0 <_ZN10KSemaphoreD1Ev>:
    thread->resetState();

}
KSemaphore::~KSemaphore()
{
    delete queueBlockedThreads;
    800028c0:	00853503          	ld	a0,8(a0)
    800028c4:	02050663          	beqz	a0,800028f0 <_ZN10KSemaphoreD1Ev+0x30>
KSemaphore::~KSemaphore()
    800028c8:	ff010113          	addi	sp,sp,-16
    800028cc:	00113423          	sd	ra,8(sp)
    800028d0:	00813023          	sd	s0,0(sp)
    800028d4:	01010413          	addi	s0,sp,16
    delete queueBlockedThreads;
    800028d8:	fffff097          	auipc	ra,0xfffff
    800028dc:	424080e7          	jalr	1060(ra) # 80001cfc <_ZN5QueueI3TCBEdlEPv>
    800028e0:	00813083          	ld	ra,8(sp)
    800028e4:	00013403          	ld	s0,0(sp)
    800028e8:	01010113          	addi	sp,sp,16
    800028ec:	00008067          	ret
    800028f0:	00008067          	ret

00000000800028f4 <_ZN10KSemaphore11blockThreadEP3TCB>:
{
    800028f4:	ff010113          	addi	sp,sp,-16
    800028f8:	00113423          	sd	ra,8(sp)
    800028fc:	00813023          	sd	s0,0(sp)
    80002900:	01010413          	addi	s0,sp,16
    void setSemaphoreOnWait (KSemaphore* semaphore) { waitOnSemaphore = semaphore; }
    80002904:	04a5b023          	sd	a0,64(a1)
    queueBlockedThreads->append(threadToBlock);
    80002908:	00853503          	ld	a0,8(a0)
    8000290c:	fffff097          	auipc	ra,0xfffff
    80002910:	418080e7          	jalr	1048(ra) # 80001d24 <_ZN5QueueI3TCBE6appendEPS0_>
}
    80002914:	00813083          	ld	ra,8(sp)
    80002918:	00013403          	ld	s0,0(sp)
    8000291c:	01010113          	addi	sp,sp,16
    80002920:	00008067          	ret

0000000080002924 <_ZN10KSemaphore4waitEv>:
    semaphoreVal--;
    80002924:	00053783          	ld	a5,0(a0)
    80002928:	fff78793          	addi	a5,a5,-1
    8000292c:	00f53023          	sd	a5,0(a0)
    if(semaphoreVal < 0)
    80002930:	0007c663          	bltz	a5,8000293c <_ZN10KSemaphore4waitEv+0x18>
    return 0;
    80002934:	00000513          	li	a0,0
}
    80002938:	00008067          	ret
{
    8000293c:	fd010113          	addi	sp,sp,-48
    80002940:	02113423          	sd	ra,40(sp)
    80002944:	02813023          	sd	s0,32(sp)
    80002948:	00913c23          	sd	s1,24(sp)
    8000294c:	01213823          	sd	s2,16(sp)
    80002950:	01313423          	sd	s3,8(sp)
    80002954:	03010413          	addi	s0,sp,48
    80002958:	00050493          	mv	s1,a0
    static TCB* getRunningThread() { return running; }
    8000295c:	00006917          	auipc	s2,0x6
    80002960:	e7493903          	ld	s2,-396(s2) # 800087d0 <_GLOBAL_OFFSET_TABLE_+0x60>
    80002964:	00093983          	ld	s3,0(s2)
        TCB::setRunningThread(Scheduler::get());
    80002968:	fffff097          	auipc	ra,0xfffff
    8000296c:	594080e7          	jalr	1428(ra) # 80001efc <_ZN9Scheduler3getEv>
    static void setRunningThread(TCB* newRunningThread) { running = newRunningThread; }
    80002970:	00a93023          	sd	a0,0(s2)
    void resetState() {state = nullptr; }
    80002974:	0409b423          	sd	zero,72(s3)
        blockThread(oldThread);
    80002978:	00098593          	mv	a1,s3
    8000297c:	00048513          	mv	a0,s1
    80002980:	00000097          	auipc	ra,0x0
    80002984:	f74080e7          	jalr	-140(ra) # 800028f4 <_ZN10KSemaphore11blockThreadEP3TCB>
    static TCB* getRunningThread() { return running; }
    80002988:	00093583          	ld	a1,0(s2)
        context_switch(oldThread->getContext(), TCB::getRunningThread()->getContext());
    8000298c:	00858593          	addi	a1,a1,8
    80002990:	00898513          	addi	a0,s3,8
    80002994:	fffff097          	auipc	ra,0xfffff
    80002998:	80c080e7          	jalr	-2036(ra) # 800011a0 <context_switch>
    8000299c:	00093783          	ld	a5,0(s2)
    KernelConfig::WakeUpReason getWakeUpReason() { return wakeUpReason; }
    800029a0:	0547a783          	lw	a5,84(a5)
        if(TCB::getRunningThread()->getWakeUpReason() == KernelConfig::WAKE_UP_SEMAPHORE_SIGNAL)
    800029a4:	02078663          	beqz	a5,800029d0 <_ZN10KSemaphore4waitEv+0xac>
        if(TCB::getRunningThread()->getWakeUpReason() == KernelConfig::WAKE_UP_SEMAPHORE_CLOSE)
    800029a8:	00100713          	li	a4,1
    800029ac:	02e78663          	beq	a5,a4,800029d8 <_ZN10KSemaphore4waitEv+0xb4>
    return 0;
    800029b0:	00000513          	li	a0,0
}
    800029b4:	02813083          	ld	ra,40(sp)
    800029b8:	02013403          	ld	s0,32(sp)
    800029bc:	01813483          	ld	s1,24(sp)
    800029c0:	01013903          	ld	s2,16(sp)
    800029c4:	00813983          	ld	s3,8(sp)
    800029c8:	03010113          	addi	sp,sp,48
    800029cc:	00008067          	ret
            return 0;
    800029d0:	00000513          	li	a0,0
    800029d4:	fe1ff06f          	j	800029b4 <_ZN10KSemaphore4waitEv+0x90>
            return -1;
    800029d8:	fff00513          	li	a0,-1
    800029dc:	fd9ff06f          	j	800029b4 <_ZN10KSemaphore4waitEv+0x90>

00000000800029e0 <_ZN10KSemaphore13unblockThreadEN12KernelConfig12WakeUpReasonE>:
{
    800029e0:	fe010113          	addi	sp,sp,-32
    800029e4:	00113c23          	sd	ra,24(sp)
    800029e8:	00813823          	sd	s0,16(sp)
    800029ec:	00913423          	sd	s1,8(sp)
    800029f0:	02010413          	addi	s0,sp,32
    800029f4:	00058493          	mv	s1,a1
   TCB* oldThread = queueBlockedThreads->take();
    800029f8:	00853503          	ld	a0,8(a0)
    800029fc:	fffff097          	auipc	ra,0xfffff
    80002a00:	35c080e7          	jalr	860(ra) # 80001d58 <_ZN5QueueI3TCBE4takeEv>
    if(oldThread)
    80002a04:	02050863          	beqz	a0,80002a34 <_ZN10KSemaphore13unblockThreadEN12KernelConfig12WakeUpReasonE+0x54>
    void setWakeUpReason(KernelConfig::WakeUpReason reason) { wakeUpReason = reason; }
    80002a08:	04952a23          	sw	s1,84(a0)
    void resetState() {state = nullptr; }
    80002a0c:	04053423          	sd	zero,72(a0)
    void resetSemaphoreOnWait() { waitOnSemaphore = nullptr; }
    80002a10:	04053023          	sd	zero,64(a0)
        Scheduler::put(oldThread);
    80002a14:	fffff097          	auipc	ra,0xfffff
    80002a18:	4b4080e7          	jalr	1204(ra) # 80001ec8 <_ZN9Scheduler3putEP3TCB>
        return 0;
    80002a1c:	00000513          	li	a0,0
}
    80002a20:	01813083          	ld	ra,24(sp)
    80002a24:	01013403          	ld	s0,16(sp)
    80002a28:	00813483          	ld	s1,8(sp)
    80002a2c:	02010113          	addi	sp,sp,32
    80002a30:	00008067          	ret
    return -1;
    80002a34:	fff00513          	li	a0,-1
    80002a38:	fe9ff06f          	j	80002a20 <_ZN10KSemaphore13unblockThreadEN12KernelConfig12WakeUpReasonE+0x40>

0000000080002a3c <_ZN10KSemaphore6signalEv>:
    semaphoreVal++;
    80002a3c:	00053783          	ld	a5,0(a0)
    80002a40:	00178793          	addi	a5,a5,1
    80002a44:	00f53023          	sd	a5,0(a0)
    if(semaphoreVal <= 0)
    80002a48:	00f05663          	blez	a5,80002a54 <_ZN10KSemaphore6signalEv+0x18>
    return 0;
    80002a4c:	00000513          	li	a0,0
}
    80002a50:	00008067          	ret
{
    80002a54:	ff010113          	addi	sp,sp,-16
    80002a58:	00113423          	sd	ra,8(sp)
    80002a5c:	00813023          	sd	s0,0(sp)
    80002a60:	01010413          	addi	s0,sp,16
        return unblockThread(KernelConfig::WAKE_UP_SEMAPHORE_SIGNAL);
    80002a64:	00000593          	li	a1,0
    80002a68:	00000097          	auipc	ra,0x0
    80002a6c:	f78080e7          	jalr	-136(ra) # 800029e0 <_ZN10KSemaphore13unblockThreadEN12KernelConfig12WakeUpReasonE>
}
    80002a70:	00813083          	ld	ra,8(sp)
    80002a74:	00013403          	ld	s0,0(sp)
    80002a78:	01010113          	addi	sp,sp,16
    80002a7c:	00008067          	ret

0000000080002a80 <_ZN10KSemaphore5closeEv>:
{
    80002a80:	fe010113          	addi	sp,sp,-32
    80002a84:	00113c23          	sd	ra,24(sp)
    80002a88:	00813823          	sd	s0,16(sp)
    80002a8c:	00913423          	sd	s1,8(sp)
    80002a90:	01213023          	sd	s2,0(sp)
    80002a94:	02010413          	addi	s0,sp,32
    80002a98:	00050913          	mv	s2,a0
    TCB* tempThread = queueBlockedThreads->top();
    80002a9c:	00853783          	ld	a5,8(a0)
    T* top() const { return head; };
    80002aa0:	0007b483          	ld	s1,0(a5)
    if(!tempThread)
    80002aa4:	02048063          	beqz	s1,80002ac4 <_ZN10KSemaphore5closeEv+0x44>
    for(;tempThread; tempThread = tempThread->getState())
    80002aa8:	02048263          	beqz	s1,80002acc <_ZN10KSemaphore5closeEv+0x4c>
        unblockThread(KernelConfig::WAKE_UP_SEMAPHORE_CLOSE);
    80002aac:	00100593          	li	a1,1
    80002ab0:	00090513          	mv	a0,s2
    80002ab4:	00000097          	auipc	ra,0x0
    80002ab8:	f2c080e7          	jalr	-212(ra) # 800029e0 <_ZN10KSemaphore13unblockThreadEN12KernelConfig12WakeUpReasonE>
    TCB* getState() const { return state; }
    80002abc:	0484b483          	ld	s1,72(s1)
    for(;tempThread; tempThread = tempThread->getState())
    80002ac0:	fe9ff06f          	j	80002aa8 <_ZN10KSemaphore5closeEv+0x28>
        return 0;
    80002ac4:	00000513          	li	a0,0
    80002ac8:	0080006f          	j	80002ad0 <_ZN10KSemaphore5closeEv+0x50>
    return -1;
    80002acc:	fff00513          	li	a0,-1
}
    80002ad0:	01813083          	ld	ra,24(sp)
    80002ad4:	01013403          	ld	s0,16(sp)
    80002ad8:	00813483          	ld	s1,8(sp)
    80002adc:	00013903          	ld	s2,0(sp)
    80002ae0:	02010113          	addi	sp,sp,32
    80002ae4:	00008067          	ret

0000000080002ae8 <_ZN10KSemaphore28removeThreadFromBlockedQueueEP3TCB>:
{
    80002ae8:	fe010113          	addi	sp,sp,-32
    80002aec:	00113c23          	sd	ra,24(sp)
    80002af0:	00813823          	sd	s0,16(sp)
    80002af4:	00913423          	sd	s1,8(sp)
    80002af8:	02010413          	addi	s0,sp,32
    80002afc:	00058493          	mv	s1,a1
    queueBlockedThreads->removeElement(thread);
    80002b00:	00853503          	ld	a0,8(a0)
    80002b04:	00000097          	auipc	ra,0x0
    80002b08:	024080e7          	jalr	36(ra) # 80002b28 <_ZN5QueueI3TCBE13removeElementEPS0_>
    void resetSemaphoreOnWait() { waitOnSemaphore = nullptr; }
    80002b0c:	0404b023          	sd	zero,64(s1)
    void resetState() {state = nullptr; }
    80002b10:	0404b423          	sd	zero,72(s1)
}
    80002b14:	01813083          	ld	ra,24(sp)
    80002b18:	01013403          	ld	s0,16(sp)
    80002b1c:	00813483          	ld	s1,8(sp)
    80002b20:	02010113          	addi	sp,sp,32
    80002b24:	00008067          	ret

0000000080002b28 <_ZN5QueueI3TCBE13removeElementEPS0_>:
void Queue<T>::removeElement(T *element)
    80002b28:	ff010113          	addi	sp,sp,-16
    80002b2c:	00813423          	sd	s0,8(sp)
    80002b30:	01010413          	addi	s0,sp,16
    T* prev = nullptr, * curr = head;
    80002b34:	00053683          	ld	a3,0(a0)
    80002b38:	00068793          	mv	a5,a3
    80002b3c:	00000713          	li	a4,0
    while(element != curr && curr)
    80002b40:	00b78a63          	beq	a5,a1,80002b54 <_ZN5QueueI3TCBE13removeElementEPS0_+0x2c>
    80002b44:	00078863          	beqz	a5,80002b54 <_ZN5QueueI3TCBE13removeElementEPS0_+0x2c>
        prev = curr;
    80002b48:	00078713          	mv	a4,a5
        curr = curr->getState();
    80002b4c:	0487b783          	ld	a5,72(a5)
    while(element != curr && curr)
    80002b50:	ff1ff06f          	j	80002b40 <_ZN5QueueI3TCBE13removeElementEPS0_+0x18>
    if(!prev)
    80002b54:	02070063          	beqz	a4,80002b74 <_ZN5QueueI3TCBE13removeElementEPS0_+0x4c>
    TCB* getState() const { return state; }
    80002b58:	0485b783          	ld	a5,72(a1)
    void addThreadToState(TCB* newThread) { state = newThread; }
    80002b5c:	04f73423          	sd	a5,72(a4)
        if(element == tail)
    80002b60:	00853783          	ld	a5,8(a0)
    80002b64:	02b78263          	beq	a5,a1,80002b88 <_ZN5QueueI3TCBE13removeElementEPS0_+0x60>
}
    80002b68:	00813403          	ld	s0,8(sp)
    80002b6c:	01010113          	addi	sp,sp,16
    80002b70:	00008067          	ret
    TCB* getState() const { return state; }
    80002b74:	0486b783          	ld	a5,72(a3)
        head = head->getState();
    80002b78:	00f53023          	sd	a5,0(a0)
        if(!head)
    80002b7c:	fe0796e3          	bnez	a5,80002b68 <_ZN5QueueI3TCBE13removeElementEPS0_+0x40>
            tail = nullptr;
    80002b80:	00053423          	sd	zero,8(a0)
    80002b84:	fe5ff06f          	j	80002b68 <_ZN5QueueI3TCBE13removeElementEPS0_+0x40>
            tail = prev;
    80002b88:	00e53423          	sd	a4,8(a0)
}
    80002b8c:	fddff06f          	j	80002b68 <_ZN5QueueI3TCBE13removeElementEPS0_+0x40>

0000000080002b90 <_ZN6Kernel12kernelWorkerEPv>:
    }

}

void Kernel::kernelWorker(void*)
{
    80002b90:	ff010113          	addi	sp,sp,-16
    80002b94:	00813423          	sd	s0,8(sp)
    80002b98:	01010413          	addi	s0,sp,16
    while(1)
    80002b9c:	0000006f          	j	80002b9c <_ZN6Kernel12kernelWorkerEPv+0xc>

0000000080002ba0 <_ZN13PriorityQueueI3TCBUlPS0_S1_E_E3topEv>:
{
    MemoryAllocator::freeMemory(obj);
}

template<typename T, typename Compare>
T* PriorityQueue<T, Compare>::top()
    80002ba0:	ff010113          	addi	sp,sp,-16
    80002ba4:	00813423          	sd	s0,8(sp)
    80002ba8:	01010413          	addi	s0,sp,16
{
    return head;
}
    80002bac:	00053503          	ld	a0,0(a0)
    80002bb0:	00813403          	ld	s0,8(sp)
    80002bb4:	01010113          	addi	sp,sp,16
    80002bb8:	00008067          	ret

0000000080002bbc <_ZN13PriorityQueueI3TCBUlPS0_S1_E_E4takeEv>:
T* PriorityQueue<T, Compare>::take()
    80002bbc:	ff010113          	addi	sp,sp,-16
    80002bc0:	00813423          	sd	s0,8(sp)
    80002bc4:	01010413          	addi	s0,sp,16
    80002bc8:	00050793          	mv	a5,a0
    T* oldElement = head;
    80002bcc:	00053503          	ld	a0,0(a0)
    80002bd0:	04853703          	ld	a4,72(a0)
    head = head->getState();
    80002bd4:	00e7b023          	sd	a4,0(a5)
    if(!head)
    80002bd8:	00070863          	beqz	a4,80002be8 <_ZN13PriorityQueueI3TCBUlPS0_S1_E_E4takeEv+0x2c>
}
    80002bdc:	00813403          	ld	s0,8(sp)
    80002be0:	01010113          	addi	sp,sp,16
    80002be4:	00008067          	ret
        tail = nullptr;
    80002be8:	0007b423          	sd	zero,8(a5)
    return oldElement;
    80002bec:	ff1ff06f          	j	80002bdc <_ZN13PriorityQueueI3TCBUlPS0_S1_E_E4takeEv+0x20>

0000000080002bf0 <_ZN13PriorityQueueI3TCBUlPS0_S1_E_E6appendES1_>:
void PriorityQueue<T, Compare>::append(T *newElement)
    80002bf0:	ff010113          	addi	sp,sp,-16
    80002bf4:	00813423          	sd	s0,8(sp)
    80002bf8:	01010413          	addi	s0,sp,16
    if(head == nullptr)
    80002bfc:	00053783          	ld	a5,0(a0)
    80002c00:	02078863          	beqz	a5,80002c30 <_ZN13PriorityQueueI3TCBUlPS0_S1_E_E6appendES1_+0x40>
    T* curr = head, *prev = nullptr;
    80002c04:	00053783          	ld	a5,0(a0)
    80002c08:	00000613          	li	a2,0
    while(curr && cmp(curr, newElement))
    80002c0c:	02078663          	beqz	a5,80002c38 <_ZN13PriorityQueueI3TCBUlPS0_S1_E_E6appendES1_+0x48>
    size_t getTimeToSleep() const { return timeToSleep; }
    80002c10:	0587b683          	ld	a3,88(a5)
    80002c14:	0585b703          	ld	a4,88(a1)
    80002c18:	02e6f063          	bgeu	a3,a4,80002c38 <_ZN13PriorityQueueI3TCBUlPS0_S1_E_E6appendES1_+0x48>
        newElement->setTimeToSleep(newElement->getTimeToSleep() - curr->getTimeToSleep());
    80002c1c:	40d70733          	sub	a4,a4,a3
    void setTimeToSleep(size_t time) { timeToSleep = time; }
    80002c20:	04e5bc23          	sd	a4,88(a1)
        prev = curr;
    80002c24:	00078613          	mv	a2,a5
        curr = curr->getState();
    80002c28:	0487b783          	ld	a5,72(a5)
    while(curr && cmp(curr, newElement))
    80002c2c:	fe1ff06f          	j	80002c0c <_ZN13PriorityQueueI3TCBUlPS0_S1_E_E6appendES1_+0x1c>
        head = newElement;
    80002c30:	00b53023          	sd	a1,0(a0)
    80002c34:	fd1ff06f          	j	80002c04 <_ZN13PriorityQueueI3TCBUlPS0_S1_E_E6appendES1_+0x14>
    if(curr == head)
    80002c38:	00053703          	ld	a4,0(a0)
    80002c3c:	02f70463          	beq	a4,a5,80002c64 <_ZN13PriorityQueueI3TCBUlPS0_S1_E_E6appendES1_+0x74>
    void addThreadToState(TCB* newThread) { state = newThread; }
    80002c40:	04f5b423          	sd	a5,72(a1)
    80002c44:	04b63423          	sd	a1,72(a2)
    size_t getTimeToSleep() const { return timeToSleep; }
    80002c48:	0587b703          	ld	a4,88(a5)
    80002c4c:	0585b683          	ld	a3,88(a1)
        curr->setTimeToSleep(curr->getTimeToSleep() - newElement->getTimeToSleep());
    80002c50:	40d70733          	sub	a4,a4,a3
    void setTimeToSleep(size_t time) { timeToSleep = time; }
    80002c54:	04e7bc23          	sd	a4,88(a5)
}
    80002c58:	00813403          	ld	s0,8(sp)
    80002c5c:	01010113          	addi	sp,sp,16
    80002c60:	00008067          	ret
    void addThreadToState(TCB* newThread) { state = newThread; }
    80002c64:	04e5b423          	sd	a4,72(a1)
    size_t getTimeToSleep() const { return timeToSleep; }
    80002c68:	05873783          	ld	a5,88(a4)
    80002c6c:	0585b683          	ld	a3,88(a1)
        head->setTimeToSleep(head->getTimeToSleep() - newElement->getTimeToSleep());
    80002c70:	40d787b3          	sub	a5,a5,a3
    void setTimeToSleep(size_t time) { timeToSleep = time; }
    80002c74:	04f73c23          	sd	a5,88(a4)
        head = newElement;
    80002c78:	00b53023          	sd	a1,0(a0)
    80002c7c:	fddff06f          	j	80002c58 <_ZN13PriorityQueueI3TCBUlPS0_S1_E_E6appendES1_+0x68>

0000000080002c80 <_ZN6Kernel9sysMallocEPNS_21ArgumentsOfSystemCallE>:

    }
}

uint64 Kernel::sysMalloc(Kernel::ArgumentsOfSystemCall *arg)
{
    80002c80:	ff010113          	addi	sp,sp,-16
    80002c84:	00113423          	sd	ra,8(sp)
    80002c88:	00813023          	sd	s0,0(sp)
    80002c8c:	01010413          	addi	s0,sp,16
//    uint64 returnValue;
//    returnValue = (uint64)MemoryAllocator::allocateMemory(arg->a0);
//    return returnValue;
    return (uint64)MemoryAllocator::allocateMemory(arg->a0);
    80002c90:	00053503          	ld	a0,0(a0)
    80002c94:	00000097          	auipc	ra,0x0
    80002c98:	904080e7          	jalr	-1788(ra) # 80002598 <_ZN15MemoryAllocator14allocateMemoryEm>
}
    80002c9c:	00813083          	ld	ra,8(sp)
    80002ca0:	00013403          	ld	s0,0(sp)
    80002ca4:	01010113          	addi	sp,sp,16
    80002ca8:	00008067          	ret

0000000080002cac <_ZN13PriorityQueueI3TCBUlPS0_S1_E_EnwEm>:
void* PriorityQueue<T, Compare>::operator new(size_t size)
    80002cac:	ff010113          	addi	sp,sp,-16
    80002cb0:	00113423          	sd	ra,8(sp)
    80002cb4:	00813023          	sd	s0,0(sp)
    80002cb8:	01010413          	addi	s0,sp,16
    size_t numOfBlocks = size / MEM_BLOCK_SIZE;
    80002cbc:	00655793          	srli	a5,a0,0x6
    numOfBlocks += size % MEM_BLOCK_SIZE ? 1 : 0;
    80002cc0:	03f57513          	andi	a0,a0,63
    80002cc4:	00050463          	beqz	a0,80002ccc <_ZN13PriorityQueueI3TCBUlPS0_S1_E_EnwEm+0x20>
    80002cc8:	00100513          	li	a0,1
    return MemoryAllocator::allocateMemory(numOfBlocks);
    80002ccc:	00f50533          	add	a0,a0,a5
    80002cd0:	00000097          	auipc	ra,0x0
    80002cd4:	8c8080e7          	jalr	-1848(ra) # 80002598 <_ZN15MemoryAllocator14allocateMemoryEm>
}
    80002cd8:	00813083          	ld	ra,8(sp)
    80002cdc:	00013403          	ld	s0,0(sp)
    80002ce0:	01010113          	addi	sp,sp,16
    80002ce4:	00008067          	ret

0000000080002ce8 <_ZN13PriorityQueueI3TCBUlPS0_S1_E_EdlEPv>:
void PriorityQueue<T, Compare>::operator delete(void *obj)
    80002ce8:	ff010113          	addi	sp,sp,-16
    80002cec:	00113423          	sd	ra,8(sp)
    80002cf0:	00813023          	sd	s0,0(sp)
    80002cf4:	01010413          	addi	s0,sp,16
    MemoryAllocator::freeMemory(obj);
    80002cf8:	00000097          	auipc	ra,0x0
    80002cfc:	9fc080e7          	jalr	-1540(ra) # 800026f4 <_ZN15MemoryAllocator10freeMemoryEPv>
}
    80002d00:	00813083          	ld	ra,8(sp)
    80002d04:	00013403          	ld	s0,0(sp)
    80002d08:	01010113          	addi	sp,sp,16
    80002d0c:	00008067          	ret

0000000080002d10 <_ZN6Kernel7sysFreeEPNS_21ArgumentsOfSystemCallE>:
uint64 Kernel::sysFree(Kernel::ArgumentsOfSystemCall *arg)
{
    80002d10:	ff010113          	addi	sp,sp,-16
    80002d14:	00113423          	sd	ra,8(sp)
    80002d18:	00813023          	sd	s0,0(sp)
    80002d1c:	01010413          	addi	s0,sp,16
//    uint64 returnValue;
//    returnValue = (uint64)MemoryAllocator::freeMemory((void*)arg->a0);
//    return returnValue;
    return (uint64)MemoryAllocator::freeMemory((void*)arg->a0);
    80002d20:	00053503          	ld	a0,0(a0)
    80002d24:	00000097          	auipc	ra,0x0
    80002d28:	9d0080e7          	jalr	-1584(ra) # 800026f4 <_ZN15MemoryAllocator10freeMemoryEPv>
}
    80002d2c:	00813083          	ld	ra,8(sp)
    80002d30:	00013403          	ld	s0,0(sp)
    80002d34:	01010113          	addi	sp,sp,16
    80002d38:	00008067          	ret

0000000080002d3c <_ZN6Kernel14sysThreadStartEPNS_21ArgumentsOfSystemCallE>:
    TCB* oldThread = TCB::getRunningThread();
    oldThread->freeWaitThreads();
    return 0;
}
uint64 Kernel::sysThreadStart(ArgumentsOfSystemCall *arg)
{
    80002d3c:	ff010113          	addi	sp,sp,-16
    80002d40:	00113423          	sd	ra,8(sp)
    80002d44:	00813023          	sd	s0,0(sp)
    80002d48:	01010413          	addi	s0,sp,16
    Scheduler::put((TCB*)arg->a0);
    80002d4c:	00053503          	ld	a0,0(a0)
    80002d50:	fffff097          	auipc	ra,0xfffff
    80002d54:	178080e7          	jalr	376(ra) # 80001ec8 <_ZN9Scheduler3putEP3TCB>
    return 0;
}
    80002d58:	00000513          	li	a0,0
    80002d5c:	00813083          	ld	ra,8(sp)
    80002d60:	00013403          	ld	s0,0(sp)
    80002d64:	01010113          	addi	sp,sp,16
    80002d68:	00008067          	ret

0000000080002d6c <_ZN6Kernel17sysThreadDispatchEPNS_21ArgumentsOfSystemCallE>:
{
    80002d6c:	ff010113          	addi	sp,sp,-16
    80002d70:	00113423          	sd	ra,8(sp)
    80002d74:	00813023          	sd	s0,0(sp)
    80002d78:	01010413          	addi	s0,sp,16
    TCB::dispatch();
    80002d7c:	fffff097          	auipc	ra,0xfffff
    80002d80:	528080e7          	jalr	1320(ra) # 800022a4 <_ZN3TCB8dispatchEv>
}
    80002d84:	00000513          	li	a0,0
    80002d88:	00813083          	ld	ra,8(sp)
    80002d8c:	00013403          	ld	s0,0(sp)
    80002d90:	01010113          	addi	sp,sp,16
    80002d94:	00008067          	ret

0000000080002d98 <_ZN6Kernel15sysGetFreeSpaceEPNS_21ArgumentsOfSystemCallE>:
{
    80002d98:	ff010113          	addi	sp,sp,-16
    80002d9c:	00113423          	sd	ra,8(sp)
    80002da0:	00813023          	sd	s0,0(sp)
    80002da4:	01010413          	addi	s0,sp,16
    return (uint64)MemoryAllocator::getFreeSpace();
    80002da8:	00000097          	auipc	ra,0x0
    80002dac:	a78080e7          	jalr	-1416(ra) # 80002820 <_ZN15MemoryAllocator12getFreeSpaceEv>
}
    80002db0:	00813083          	ld	ra,8(sp)
    80002db4:	00013403          	ld	s0,0(sp)
    80002db8:	01010113          	addi	sp,sp,16
    80002dbc:	00008067          	ret

0000000080002dc0 <_ZN6Kernel19sysLargestFreeBlockEPNS_21ArgumentsOfSystemCallE>:
{
    80002dc0:	ff010113          	addi	sp,sp,-16
    80002dc4:	00113423          	sd	ra,8(sp)
    80002dc8:	00813023          	sd	s0,0(sp)
    80002dcc:	01010413          	addi	s0,sp,16
    return (uint64)MemoryAllocator::getLargestFreeBlock();
    80002dd0:	00000097          	auipc	ra,0x0
    80002dd4:	a08080e7          	jalr	-1528(ra) # 800027d8 <_ZN15MemoryAllocator19getLargestFreeBlockEv>
}
    80002dd8:	00813083          	ld	ra,8(sp)
    80002ddc:	00013403          	ld	s0,0(sp)
    80002de0:	01010113          	addi	sp,sp,16
    80002de4:	00008067          	ret

0000000080002de8 <_ZN6Kernel13sysThreadExitEPNS_21ArgumentsOfSystemCallE>:
{
    80002de8:	ff010113          	addi	sp,sp,-16
    80002dec:	00113423          	sd	ra,8(sp)
    80002df0:	00813023          	sd	s0,0(sp)
    80002df4:	01010413          	addi	s0,sp,16
    static TCB* getRunningThread() { return running; }
    80002df8:	00006797          	auipc	a5,0x6
    80002dfc:	9d87b783          	ld	a5,-1576(a5) # 800087d0 <_GLOBAL_OFFSET_TABLE_+0x60>
    80002e00:	0007b583          	ld	a1,0(a5)
    void setIsFinished() { finished = true; }
    80002e04:	00100793          	li	a5,1
    80002e08:	04f58823          	sb	a5,80(a1)
    KSemaphore* getSemaphoreOnWait() const { return waitOnSemaphore; }
    80002e0c:	0405b503          	ld	a0,64(a1)
    if(!TCB::getRunningThread()->getSemaphoreOnWait())
    80002e10:	02050663          	beqz	a0,80002e3c <_ZN6Kernel13sysThreadExitEPNS_21ArgumentsOfSystemCallE+0x54>
    oldThread->freeWaitThreads();
    80002e14:	00006797          	auipc	a5,0x6
    80002e18:	9bc7b783          	ld	a5,-1604(a5) # 800087d0 <_GLOBAL_OFFSET_TABLE_+0x60>
    80002e1c:	0007b503          	ld	a0,0(a5)
    80002e20:	fffff097          	auipc	ra,0xfffff
    80002e24:	558080e7          	jalr	1368(ra) # 80002378 <_ZN3TCB15freeWaitThreadsEv>
}
    80002e28:	00000513          	li	a0,0
    80002e2c:	00813083          	ld	ra,8(sp)
    80002e30:	00013403          	ld	s0,0(sp)
    80002e34:	01010113          	addi	sp,sp,16
    80002e38:	00008067          	ret
        tempSemaphore->removeThreadFromBlockedQueue(TCB::getRunningThread());
    80002e3c:	00000097          	auipc	ra,0x0
    80002e40:	cac080e7          	jalr	-852(ra) # 80002ae8 <_ZN10KSemaphore28removeThreadFromBlockedQueueEP3TCB>
    80002e44:	fd1ff06f          	j	80002e14 <_ZN6Kernel13sysThreadExitEPNS_21ArgumentsOfSystemCallE+0x2c>

0000000080002e48 <_ZN6Kernel12sysTimeSleepEPNS_21ArgumentsOfSystemCallE>:
    KSemaphore* tempSemaphore = (KSemaphore*)(arg->a0);
    return (uint64)tempSemaphore->signal();
}

uint64 Kernel::sysTimeSleep(ArgumentsOfSystemCall *arg)
{
    80002e48:	fe010113          	addi	sp,sp,-32
    80002e4c:	00113c23          	sd	ra,24(sp)
    80002e50:	00813823          	sd	s0,16(sp)
    80002e54:	00913423          	sd	s1,8(sp)
    80002e58:	01213023          	sd	s2,0(sp)
    80002e5c:	02010413          	addi	s0,sp,32
    static TCB* getRunningThread() { return running; }
    80002e60:	00006917          	auipc	s2,0x6
    80002e64:	97093903          	ld	s2,-1680(s2) # 800087d0 <_GLOBAL_OFFSET_TABLE_+0x60>
    80002e68:	00093483          	ld	s1,0(s2)
    void resetState() {state = nullptr; }
    80002e6c:	0404b423          	sd	zero,72(s1)
    TCB* oldThread = TCB::getRunningThread();
    oldThread->resetState();
    oldThread->setTimeToSleep((size_t)arg->a0);
    80002e70:	00053783          	ld	a5,0(a0)
    void setTimeToSleep(size_t time) { timeToSleep = time; }
    80002e74:	04f4bc23          	sd	a5,88(s1)
    queueOfAsleepThreads->append(oldThread);
    80002e78:	00048593          	mv	a1,s1
    80002e7c:	00006517          	auipc	a0,0x6
    80002e80:	a4453503          	ld	a0,-1468(a0) # 800088c0 <_ZN6Kernel20queueOfAsleepThreadsE>
    80002e84:	00000097          	auipc	ra,0x0
    80002e88:	d6c080e7          	jalr	-660(ra) # 80002bf0 <_ZN13PriorityQueueI3TCBUlPS0_S1_E_E6appendES1_>
    TCB::setRunningThread(Scheduler::get());
    80002e8c:	fffff097          	auipc	ra,0xfffff
    80002e90:	070080e7          	jalr	112(ra) # 80001efc <_ZN9Scheduler3getEv>
    static void setRunningThread(TCB* newRunningThread) { running = newRunningThread; }
    80002e94:	00a93023          	sd	a0,0(s2)
    context_switch(oldThread->getContext(), TCB::getRunningThread()->getContext());
    80002e98:	00850593          	addi	a1,a0,8
    80002e9c:	00848513          	addi	a0,s1,8
    80002ea0:	ffffe097          	auipc	ra,0xffffe
    80002ea4:	300080e7          	jalr	768(ra) # 800011a0 <context_switch>
    return 0;
}
    80002ea8:	00000513          	li	a0,0
    80002eac:	01813083          	ld	ra,24(sp)
    80002eb0:	01013403          	ld	s0,16(sp)
    80002eb4:	00813483          	ld	s1,8(sp)
    80002eb8:	00013903          	ld	s2,0(sp)
    80002ebc:	02010113          	addi	sp,sp,32
    80002ec0:	00008067          	ret

0000000080002ec4 <_ZN6Kernel16sysSemaphoreWaitEPNS_21ArgumentsOfSystemCallE>:
{
    80002ec4:	ff010113          	addi	sp,sp,-16
    80002ec8:	00113423          	sd	ra,8(sp)
    80002ecc:	00813023          	sd	s0,0(sp)
    80002ed0:	01010413          	addi	s0,sp,16
    return (uint64)tempSemaphore->wait();
    80002ed4:	00053503          	ld	a0,0(a0)
    80002ed8:	00000097          	auipc	ra,0x0
    80002edc:	a4c080e7          	jalr	-1460(ra) # 80002924 <_ZN10KSemaphore4waitEv>
}
    80002ee0:	00813083          	ld	ra,8(sp)
    80002ee4:	00013403          	ld	s0,0(sp)
    80002ee8:	01010113          	addi	sp,sp,16
    80002eec:	00008067          	ret

0000000080002ef0 <_ZN6Kernel18sysSemaphoreSignalEPNS_21ArgumentsOfSystemCallE>:
{
    80002ef0:	ff010113          	addi	sp,sp,-16
    80002ef4:	00113423          	sd	ra,8(sp)
    80002ef8:	00813023          	sd	s0,0(sp)
    80002efc:	01010413          	addi	s0,sp,16
    return (uint64)tempSemaphore->signal();
    80002f00:	00053503          	ld	a0,0(a0)
    80002f04:	00000097          	auipc	ra,0x0
    80002f08:	b38080e7          	jalr	-1224(ra) # 80002a3c <_ZN10KSemaphore6signalEv>
}
    80002f0c:	00813083          	ld	ra,8(sp)
    80002f10:	00013403          	ld	s0,0(sp)
    80002f14:	01010113          	addi	sp,sp,16
    80002f18:	00008067          	ret

0000000080002f1c <_ZN6Kernel19initializeArgumentsEPNS_21ArgumentsOfSystemCallEm>:
{
    80002f1c:	ff010113          	addi	sp,sp,-16
    80002f20:	00813423          	sd	s0,8(sp)
    80002f24:	01010413          	addi	s0,sp,16
    __asm__ volatile("ld %[rd], 11*8(%[rs])":[rd]"=r"(arg->a0):[rs]"r"(basePointer));
    80002f28:	0585b783          	ld	a5,88(a1)
    80002f2c:	00f53023          	sd	a5,0(a0)
    __asm__ volatile("ld %[rd], 12*8(%[rs])":[rd]"=r"(arg->a1):[rs]"r"(basePointer));
    80002f30:	0605b783          	ld	a5,96(a1)
    80002f34:	00f53423          	sd	a5,8(a0)
    __asm__ volatile("ld %[rd], 13*8(%[rs])":[rd]"=r"(arg->a2):[rs]"r"(basePointer));
    80002f38:	0685b783          	ld	a5,104(a1)
    80002f3c:	00f53823          	sd	a5,16(a0)
    __asm__ volatile("ld %[rd], 14*8(%[rs])":[rd]"=r"(arg->a3):[rs]"r"(basePointer));
    80002f40:	0705b783          	ld	a5,112(a1)
    80002f44:	00f53c23          	sd	a5,24(a0)
    __asm__ volatile("ld %[rd], 15*8(%[rs])":[rd]"=r"(arg->a4):[rs]"r"(basePointer));
    80002f48:	0785b783          	ld	a5,120(a1)
    80002f4c:	02f53023          	sd	a5,32(a0)
    __asm__ volatile("ld %[rd], 16*8(%[rs])":[rd]"=r"(arg->a5):[rs]"r"(basePointer));
    80002f50:	0805b783          	ld	a5,128(a1)
    80002f54:	02f53423          	sd	a5,40(a0)
    __asm__ volatile("ld %[rd], 17*8(%[rs])":[rd]"=r"(arg->a6):[rs]"r"(basePointer));
    80002f58:	0885b583          	ld	a1,136(a1)
    80002f5c:	02b53823          	sd	a1,48(a0)
}
    80002f60:	00813403          	ld	s0,8(sp)
    80002f64:	01010113          	addi	sp,sp,16
    80002f68:	00008067          	ret

0000000080002f6c <_ZN6Kernel17mallocSystemStackEm>:
{
    80002f6c:	ff010113          	addi	sp,sp,-16
    80002f70:	00113423          	sd	ra,8(sp)
    80002f74:	00813023          	sd	s0,0(sp)
    80002f78:	01010413          	addi	s0,sp,16
    size_t numOfBlocks = numOfBytes / MEM_BLOCK_SIZE;
    80002f7c:	00655793          	srli	a5,a0,0x6
    numOfBlocks += numOfBytes % MEM_BLOCK_SIZE ? 1 : 0;
    80002f80:	03f57513          	andi	a0,a0,63
    80002f84:	00050463          	beqz	a0,80002f8c <_ZN6Kernel17mallocSystemStackEm+0x20>
    80002f88:	00100513          	li	a0,1
    uint8* systemStack = (uint8*)MemoryAllocator::allocateMemory(numOfBlocks);
    80002f8c:	00f50533          	add	a0,a0,a5
    80002f90:	fffff097          	auipc	ra,0xfffff
    80002f94:	608080e7          	jalr	1544(ra) # 80002598 <_ZN15MemoryAllocator14allocateMemoryEm>
}
    80002f98:	40050513          	addi	a0,a0,1024
    80002f9c:	00813083          	ld	ra,8(sp)
    80002fa0:	00013403          	ld	s0,0(sp)
    80002fa4:	01010113          	addi	sp,sp,16
    80002fa8:	00008067          	ret

0000000080002fac <_ZN6Kernel13wakeUpThreadsEv>:
{
    80002fac:	fe010113          	addi	sp,sp,-32
    80002fb0:	00113c23          	sd	ra,24(sp)
    80002fb4:	00813823          	sd	s0,16(sp)
    80002fb8:	00913423          	sd	s1,8(sp)
    80002fbc:	02010413          	addi	s0,sp,32
    queueOfAsleepThreads->top()->decrementTimeToSleep();
    80002fc0:	00006517          	auipc	a0,0x6
    80002fc4:	90053503          	ld	a0,-1792(a0) # 800088c0 <_ZN6Kernel20queueOfAsleepThreadsE>
    80002fc8:	00000097          	auipc	ra,0x0
    80002fcc:	bd8080e7          	jalr	-1064(ra) # 80002ba0 <_ZN13PriorityQueueI3TCBUlPS0_S1_E_E3topEv>
    void decrementTimeToSleep() { timeToSleep--; };
    80002fd0:	05853783          	ld	a5,88(a0)
    80002fd4:	fff78793          	addi	a5,a5,-1
    80002fd8:	04f53c23          	sd	a5,88(a0)
    while(!queueOfAsleepThreads->top()->getTimeToSleep())
    80002fdc:	00006497          	auipc	s1,0x6
    80002fe0:	8e44b483          	ld	s1,-1820(s1) # 800088c0 <_ZN6Kernel20queueOfAsleepThreadsE>
    80002fe4:	00048513          	mv	a0,s1
    80002fe8:	00000097          	auipc	ra,0x0
    80002fec:	bb8080e7          	jalr	-1096(ra) # 80002ba0 <_ZN13PriorityQueueI3TCBUlPS0_S1_E_E3topEv>
    size_t getTimeToSleep() const { return timeToSleep; }
    80002ff0:	05853783          	ld	a5,88(a0)
    80002ff4:	02079063          	bnez	a5,80003014 <_ZN6Kernel13wakeUpThreadsEv+0x68>
        TCB* curr = queueOfAsleepThreads->take();
    80002ff8:	00048513          	mv	a0,s1
    80002ffc:	00000097          	auipc	ra,0x0
    80003000:	bc0080e7          	jalr	-1088(ra) # 80002bbc <_ZN13PriorityQueueI3TCBUlPS0_S1_E_E4takeEv>
    void resetState() {state = nullptr; }
    80003004:	04053423          	sd	zero,72(a0)
        Scheduler::put(curr);
    80003008:	fffff097          	auipc	ra,0xfffff
    8000300c:	ec0080e7          	jalr	-320(ra) # 80001ec8 <_ZN9Scheduler3putEP3TCB>
    while(!queueOfAsleepThreads->top()->getTimeToSleep())
    80003010:	fcdff06f          	j	80002fdc <_ZN6Kernel13wakeUpThreadsEv+0x30>
}
    80003014:	01813083          	ld	ra,24(sp)
    80003018:	01013403          	ld	s0,16(sp)
    8000301c:	00813483          	ld	s1,8(sp)
    80003020:	02010113          	addi	sp,sp,32
    80003024:	00008067          	ret

0000000080003028 <_ZN6Kernel21initializeSystemCallsEv>:
    KConsole::addCharToOutputBuffer(arg->a0);
    return 0;
}

void Kernel::initializeSystemCalls(void)
{
    80003028:	ff010113          	addi	sp,sp,-16
    8000302c:	00813423          	sd	s0,8(sp)
    80003030:	01010413          	addi	s0,sp,16
    systemCallsTable[KernelConfig::MEM_ALLOC] = &sysMalloc;
    80003034:	00006797          	auipc	a5,0x6
    80003038:	88c78793          	addi	a5,a5,-1908 # 800088c0 <_ZN6Kernel20queueOfAsleepThreadsE>
    8000303c:	00000717          	auipc	a4,0x0
    80003040:	c4470713          	addi	a4,a4,-956 # 80002c80 <_ZN6Kernel9sysMallocEPNS_21ArgumentsOfSystemCallE>
    80003044:	00e7b823          	sd	a4,16(a5)
    systemCallsTable[KernelConfig::MEM_FREE] = &sysFree;
    80003048:	00000717          	auipc	a4,0x0
    8000304c:	cc870713          	addi	a4,a4,-824 # 80002d10 <_ZN6Kernel7sysFreeEPNS_21ArgumentsOfSystemCallE>
    80003050:	00e7bc23          	sd	a4,24(a5)
    systemCallsTable[KernelConfig::MEM_FREE_SPACE] = &sysGetFreeSpace;
    80003054:	00000717          	auipc	a4,0x0
    80003058:	d4470713          	addi	a4,a4,-700 # 80002d98 <_ZN6Kernel15sysGetFreeSpaceEPNS_21ArgumentsOfSystemCallE>
    8000305c:	02e7b023          	sd	a4,32(a5)
    systemCallsTable[KernelConfig::LARGEST_FREE_BLOCK] = &sysLargestFreeBlock;
    80003060:	00000717          	auipc	a4,0x0
    80003064:	d6070713          	addi	a4,a4,-672 # 80002dc0 <_ZN6Kernel19sysLargestFreeBlockEPNS_21ArgumentsOfSystemCallE>
    80003068:	02e7b423          	sd	a4,40(a5)
    systemCallsTable[KernelConfig::THREAD_CREATE] = &sysThreadCreate;
    8000306c:	00001717          	auipc	a4,0x1
    80003070:	a7c70713          	addi	a4,a4,-1412 # 80003ae8 <_ZN6Kernel15sysThreadCreateEPNS_21ArgumentsOfSystemCallE>
    80003074:	08e7b823          	sd	a4,144(a5)
    systemCallsTable[KernelConfig::THREAD_DISPATCH] = &sysThreadDispatch;
    80003078:	00000717          	auipc	a4,0x0
    8000307c:	cf470713          	addi	a4,a4,-780 # 80002d6c <_ZN6Kernel17sysThreadDispatchEPNS_21ArgumentsOfSystemCallE>
    80003080:	0ae7b023          	sd	a4,160(a5)
    systemCallsTable[KernelConfig::THREAD_EXIT] = &sysThreadExit;
    80003084:	00000717          	auipc	a4,0x0
    80003088:	d6470713          	addi	a4,a4,-668 # 80002de8 <_ZN6Kernel13sysThreadExitEPNS_21ArgumentsOfSystemCallE>
    8000308c:	08e7bc23          	sd	a4,152(a5)
    systemCallsTable[KernelConfig::THREAD_START] = &sysThreadStart;
    80003090:	00000717          	auipc	a4,0x0
    80003094:	cac70713          	addi	a4,a4,-852 # 80002d3c <_ZN6Kernel14sysThreadStartEPNS_21ArgumentsOfSystemCallE>
    80003098:	0ae7b423          	sd	a4,168(a5)
    systemCallsTable[KernelConfig::THREAD_JOIN] = &sysThreadJoin;
    8000309c:	00000717          	auipc	a4,0x0
    800030a0:	5ac70713          	addi	a4,a4,1452 # 80003648 <_ZN6Kernel13sysThreadJoinEPNS_21ArgumentsOfSystemCallE>
    800030a4:	0ae7b823          	sd	a4,176(a5)
    systemCallsTable[KernelConfig::SEMAPHORE_OPEN] = &sysSemaphoreOpen;
    800030a8:	00001717          	auipc	a4,0x1
    800030ac:	ad870713          	addi	a4,a4,-1320 # 80003b80 <_ZN6Kernel16sysSemaphoreOpenEPNS_21ArgumentsOfSystemCallE>
    800030b0:	10e7b823          	sd	a4,272(a5)
    systemCallsTable[KernelConfig::SEMAPHORE_CLOSE] = &sysSemaphoreClose;
    800030b4:	00000717          	auipc	a4,0x0
    800030b8:	65070713          	addi	a4,a4,1616 # 80003704 <_ZN6Kernel17sysSemaphoreCloseEPNS_21ArgumentsOfSystemCallE>
    800030bc:	10e7bc23          	sd	a4,280(a5)
    systemCallsTable[KernelConfig::SEMAPHORE_SIGNAL] = &sysSemaphoreSignal;
    800030c0:	00000717          	auipc	a4,0x0
    800030c4:	e3070713          	addi	a4,a4,-464 # 80002ef0 <_ZN6Kernel18sysSemaphoreSignalEPNS_21ArgumentsOfSystemCallE>
    800030c8:	12e7b423          	sd	a4,296(a5)
    systemCallsTable[KernelConfig::SEMAPHORE_WAIT] = &sysSemaphoreWait;
    800030cc:	00000717          	auipc	a4,0x0
    800030d0:	df870713          	addi	a4,a4,-520 # 80002ec4 <_ZN6Kernel16sysSemaphoreWaitEPNS_21ArgumentsOfSystemCallE>
    800030d4:	12e7b023          	sd	a4,288(a5)
    systemCallsTable[KernelConfig::TIME_SLEEP] = &sysTimeSleep;
    800030d8:	00000717          	auipc	a4,0x0
    800030dc:	d7070713          	addi	a4,a4,-656 # 80002e48 <_ZN6Kernel12sysTimeSleepEPNS_21ArgumentsOfSystemCallE>
    800030e0:	18e7b823          	sd	a4,400(a5)
    systemCallsTable[KernelConfig::GETC] = &sysGetc;
    800030e4:	00000717          	auipc	a4,0x0
    800030e8:	02470713          	addi	a4,a4,36 # 80003108 <_ZN6Kernel7sysGetcEPNS_21ArgumentsOfSystemCallE>
    800030ec:	20e7b823          	sd	a4,528(a5)
    systemCallsTable[KernelConfig::PUTC] = &sysPutc;
    800030f0:	00000717          	auipc	a4,0x0
    800030f4:	2cc70713          	addi	a4,a4,716 # 800033bc <_ZN6Kernel7sysPutcEPNS_21ArgumentsOfSystemCallE>
    800030f8:	20e7bc23          	sd	a4,536(a5)
    800030fc:	00813403          	ld	s0,8(sp)
    80003100:	01010113          	addi	sp,sp,16
    80003104:	00008067          	ret

0000000080003108 <_ZN6Kernel7sysGetcEPNS_21ArgumentsOfSystemCallE>:
{
    80003108:	fe010113          	addi	sp,sp,-32
    8000310c:	00113c23          	sd	ra,24(sp)
    80003110:	00813823          	sd	s0,16(sp)
    80003114:	00913423          	sd	s1,8(sp)
    80003118:	01213023          	sd	s2,0(sp)
    8000311c:	02010413          	addi	s0,sp,32
    static void setConsumerThread(TCB* thread) { consumerThread = thread; }

    static TCB* getProducerThread() { return producerThread; }
    static void setProducerThread(TCB* thread) { producerThread = thread; }

    static bool isInputBufferEmpty() { return inputBuffer->isBufferEmpty(); }
    80003120:	00005797          	auipc	a5,0x5
    80003124:	6b87b783          	ld	a5,1720(a5) # 800087d8 <_GLOBAL_OFFSET_TABLE_+0x68>
    80003128:	0007b503          	ld	a0,0(a5)
    8000312c:	fffff097          	auipc	ra,0xfffff
    80003130:	aa8080e7          	jalr	-1368(ra) # 80001bd4 <_ZNK6BufferIcLm100EE13isBufferEmptyEv>
    if(KConsole::isInputBufferEmpty())
    80003134:	02051263          	bnez	a0,80003158 <_ZN6Kernel7sysGetcEPNS_21ArgumentsOfSystemCallE+0x50>
    return (uint64)KConsole::getCharFromInputBuffer();
    80003138:	fffff097          	auipc	ra,0xfffff
    8000313c:	854080e7          	jalr	-1964(ra) # 8000198c <_ZN8KConsole22getCharFromInputBufferEv>
}
    80003140:	01813083          	ld	ra,24(sp)
    80003144:	01013403          	ld	s0,16(sp)
    80003148:	00813483          	ld	s1,8(sp)
    8000314c:	00013903          	ld	s2,0(sp)
    80003150:	02010113          	addi	sp,sp,32
    80003154:	00008067          	ret
    static TCB* getRunningThread() { return running; }
    80003158:	00005917          	auipc	s2,0x5
    8000315c:	67893903          	ld	s2,1656(s2) # 800087d0 <_GLOBAL_OFFSET_TABLE_+0x60>
    80003160:	00093483          	ld	s1,0(s2)
        TCB::setRunningThread(Scheduler::get());
    80003164:	fffff097          	auipc	ra,0xfffff
    80003168:	d98080e7          	jalr	-616(ra) # 80001efc <_ZN9Scheduler3getEv>
    static void setRunningThread(TCB* newRunningThread) { running = newRunningThread; }
    8000316c:	00a93023          	sd	a0,0(s2)
    void resetState() {state = nullptr; }
    80003170:	0404b423          	sd	zero,72(s1)
        KConsole::addThreadToInputWaitQueue(oldThread);
    80003174:	00048513          	mv	a0,s1
    80003178:	ffffe097          	auipc	ra,0xffffe
    8000317c:	72c080e7          	jalr	1836(ra) # 800018a4 <_ZN8KConsole25addThreadToInputWaitQueueEP3TCB>
    static TCB* getRunningThread() { return running; }
    80003180:	00093583          	ld	a1,0(s2)
        context_switch(oldThread->getContext(), TCB::getRunningThread()->getContext());
    80003184:	00858593          	addi	a1,a1,8
    80003188:	00848513          	addi	a0,s1,8
    8000318c:	ffffe097          	auipc	ra,0xffffe
    80003190:	014080e7          	jalr	20(ra) # 800011a0 <context_switch>
    80003194:	fa5ff06f          	j	80003138 <_ZN6Kernel7sysGetcEPNS_21ArgumentsOfSystemCallE+0x30>

0000000080003198 <_ZN6Kernel16interruptHandlerEv>:
{
    80003198:	f9010113          	addi	sp,sp,-112
    8000319c:	06113423          	sd	ra,104(sp)
    800031a0:	06813023          	sd	s0,96(sp)
    800031a4:	04913c23          	sd	s1,88(sp)
    800031a8:	05213823          	sd	s2,80(sp)
    800031ac:	05313423          	sd	s3,72(sp)
    800031b0:	05413023          	sd	s4,64(sp)
    800031b4:	07010413          	addi	s0,sp,112
    __asm__ volatile ("addi %[reg], s0, 0x0": [reg]"=r"(basePointer)); // Problem: da li mozemo biti 100% sigurni da ce s0 biti nepromenjen; resenje inline f-ja
    800031b8:	00040793          	mv	a5,s0
    800031bc:	fcf43423          	sd	a5,-56(s0)
    __asm__ volatile ("csrr %[cause], scause": [cause] "=r"(scause));
    800031c0:	142027f3          	csrr	a5,scause
    switch (scause)
    800031c4:	fff00713          	li	a4,-1
    800031c8:	03f71713          	slli	a4,a4,0x3f
    800031cc:	00170713          	addi	a4,a4,1
    800031d0:	12e78463          	beq	a5,a4,800032f8 <_ZN6Kernel16interruptHandlerEv+0x160>
    800031d4:	fff00713          	li	a4,-1
    800031d8:	03f71713          	slli	a4,a4,0x3f
    800031dc:	00170713          	addi	a4,a4,1
    800031e0:	08f76a63          	bltu	a4,a5,80003274 <_ZN6Kernel16interruptHandlerEv+0xdc>
    800031e4:	ff878793          	addi	a5,a5,-8
    800031e8:	00100713          	li	a4,1
    800031ec:	06f76463          	bltu	a4,a5,80003254 <_ZN6Kernel16interruptHandlerEv+0xbc>
    __asm__ volatile ("csrc sip, %[reg]":: [reg] "r"(mask));
    800031f0:	00200793          	li	a5,2
    800031f4:	1447b073          	csrc	sip,a5
}
inline uint64 Machine::readSepc()
{
    uint64 returnAddress;
    __asm__ volatile ("csrr %[reg], sepc": [reg] "=r"(returnAddress));
    800031f8:	141029f3          	csrr	s3,sepc
            uint64 sepc = Machine::readSepc() + 4;
    800031fc:	00498993          	addi	s3,s3,4
    __asm__ volatile("csrw sstatus, %[reg]":: [reg] "r"(oldStatus));
}
inline uint64 Machine::readSstatus()
{
    uint64 returnStatus;
    __asm__ volatile ("csrr %[reg], sstatus": [reg] "=r"(returnStatus));
    80003200:	10002a73          	csrr	s4,sstatus
            __asm__ volatile ("ld %[rd], -176(%[rs])": [rd]"=r"(numberOfEntry):[rs]"r"(basePointer));
    80003204:	fc843483          	ld	s1,-56(s0)
    80003208:	f504b483          	ld	s1,-176(s1)
            initializeArguments(&arg, basePointer);
    8000320c:	fc843583          	ld	a1,-56(s0)
    80003210:	f9040913          	addi	s2,s0,-112
    80003214:	00090513          	mv	a0,s2
    80003218:	00000097          	auipc	ra,0x0
    8000321c:	d04080e7          	jalr	-764(ra) # 80002f1c <_ZN6Kernel19initializeArgumentsEPNS_21ArgumentsOfSystemCallEm>
            systemCallsTable[numberOfEntry](&arg);
    80003220:	00349493          	slli	s1,s1,0x3
    80003224:	00005797          	auipc	a5,0x5
    80003228:	69c78793          	addi	a5,a5,1692 # 800088c0 <_ZN6Kernel20queueOfAsleepThreadsE>
    8000322c:	009784b3          	add	s1,a5,s1
    80003230:	0084b783          	ld	a5,8(s1)
    80003234:	00090513          	mv	a0,s2
    80003238:	000780e7          	jalr	a5
            __asm__ volatile("sd a0, -176(%[rs])"::[rs]"r"(basePointer));
    8000323c:	fc843783          	ld	a5,-56(s0)
    80003240:	f4a7b823          	sd	a0,-176(a5)
            TCB::dispatch();
    80003244:	fffff097          	auipc	ra,0xfffff
    80003248:	060080e7          	jalr	96(ra) # 800022a4 <_ZN3TCB8dispatchEv>
    __asm__ volatile("csrw sepc, %[reg]":: [reg] "r"(address));
    8000324c:	14199073          	csrw	sepc,s3
    __asm__ volatile("csrw sstatus, %[reg]":: [reg] "r"(oldStatus));
    80003250:	100a1073          	csrw	sstatus,s4
}
    80003254:	06813083          	ld	ra,104(sp)
    80003258:	06013403          	ld	s0,96(sp)
    8000325c:	05813483          	ld	s1,88(sp)
    80003260:	05013903          	ld	s2,80(sp)
    80003264:	04813983          	ld	s3,72(sp)
    80003268:	04013a03          	ld	s4,64(sp)
    8000326c:	07010113          	addi	sp,sp,112
    80003270:	00008067          	ret
    switch (scause)
    80003274:	fff00713          	li	a4,-1
    80003278:	03f71713          	slli	a4,a4,0x3f
    8000327c:	00970713          	addi	a4,a4,9
    80003280:	fce79ae3          	bne	a5,a4,80003254 <_ZN6Kernel16interruptHandlerEv+0xbc>
    __asm__ volatile ("csrc sip, %[reg]":: [reg] "r"(mask));
    80003284:	20000793          	li	a5,512
    80003288:	1447b073          	csrc	sip,a5
    __asm__ volatile ("csrr %[reg], sepc": [reg] "=r"(returnAddress));
    8000328c:	141024f3          	csrr	s1,sepc
            uint64 sepc = Machine::readSepc() + 4;
    80003290:	00448493          	addi	s1,s1,4
    __asm__ volatile ("csrr %[reg], sstatus": [reg] "=r"(returnStatus));
    80003294:	100029f3          	csrr	s3,sstatus
            int numOfDevice = plic_claim();
    80003298:	00001097          	auipc	ra,0x1
    8000329c:	52c080e7          	jalr	1324(ra) # 800047c4 <plic_claim>
    800032a0:	00050913          	mv	s2,a0
            __asm__ volatile("lb %[status], 0(%[address])": [status] "=r"(statusReg): [address] "r"(CONSOLE_STATUS));
    800032a4:	00005797          	auipc	a5,0x5
    800032a8:	4dc7b783          	ld	a5,1244(a5) # 80008780 <_GLOBAL_OFFSET_TABLE_+0x10>
    800032ac:	0007b783          	ld	a5,0(a5)
    800032b0:	00078783          	lb	a5,0(a5)
    800032b4:	0ff7f793          	andi	a5,a5,255
            if (statusReg & CONSOLE_TX_STATUS_BIT) {
    800032b8:	0207f793          	andi	a5,a5,32
    800032bc:	0c078063          	beqz	a5,8000337c <_ZN6Kernel16interruptHandlerEv+0x1e4>
    static bool isInputBufferFull() { return inputBuffer->isBufferFull(); }

    static bool isOutputBufferFull() { return outputBuffer->isBufferFull(); }
    static bool isOutputBufferEmpty() { return outputBuffer->isBufferEmpty(); }
    800032c0:	00005797          	auipc	a5,0x5
    800032c4:	4f07b783          	ld	a5,1264(a5) # 800087b0 <_GLOBAL_OFFSET_TABLE_+0x40>
    800032c8:	0007b503          	ld	a0,0(a5)
    800032cc:	fffff097          	auipc	ra,0xfffff
    800032d0:	908080e7          	jalr	-1784(ra) # 80001bd4 <_ZNK6BufferIcLm100EE13isBufferEmptyEv>
                if (KConsole::isOutputBufferEmpty()) {
    800032d4:	08050863          	beqz	a0,80003364 <_ZN6Kernel16interruptHandlerEv+0x1cc>
                    plic_complete(numOfDevice);
    800032d8:	00090513          	mv	a0,s2
    800032dc:	00001097          	auipc	ra,0x1
    800032e0:	520080e7          	jalr	1312(ra) # 800047fc <plic_complete>
            TCB::dispatch();
    800032e4:	fffff097          	auipc	ra,0xfffff
    800032e8:	fc0080e7          	jalr	-64(ra) # 800022a4 <_ZN3TCB8dispatchEv>
    __asm__ volatile("csrw sepc, %[reg]":: [reg] "r"(address));
    800032ec:	14149073          	csrw	sepc,s1
    __asm__ volatile("csrw sstatus, %[reg]":: [reg] "r"(oldStatus));
    800032f0:	10099073          	csrw	sstatus,s3
}
    800032f4:	f61ff06f          	j	80003254 <_ZN6Kernel16interruptHandlerEv+0xbc>
    __asm__ volatile ("csrc sip, %[reg]":: [reg] "r"(mask));
    800032f8:	00200793          	li	a5,2
    800032fc:	1447b073          	csrc	sip,a5

    static size_t getNumOfTicks() { return numOfTicks; }
    static void resetNumOfTicks() { numOfTicks = DEFAULT_TIME_SLICE; }
    static void incrementNumOfTicks() { numOfTicks++; }
    80003300:	00005717          	auipc	a4,0x5
    80003304:	4b873703          	ld	a4,1208(a4) # 800087b8 <_GLOBAL_OFFSET_TABLE_+0x48>
    80003308:	00073783          	ld	a5,0(a4)
    8000330c:	00178793          	addi	a5,a5,1
    80003310:	00f73023          	sd	a5,0(a4)
    static TCB* getRunningThread() { return running; }
    80003314:	00005717          	auipc	a4,0x5
    80003318:	4bc73703          	ld	a4,1212(a4) # 800087d0 <_GLOBAL_OFFSET_TABLE_+0x60>
    8000331c:	00073703          	ld	a4,0(a4)
    size_t getTimeSlice() const { return timeSlice; }
    80003320:	03073703          	ld	a4,48(a4)
            if (TCB::getNumOfTicks() >= TCB::getRunningThread()->getTimeSlice()) {
    80003324:	00e7f863          	bgeu	a5,a4,80003334 <_ZN6Kernel16interruptHandlerEv+0x19c>
            wakeUpThreads();
    80003328:	00000097          	auipc	ra,0x0
    8000332c:	c84080e7          	jalr	-892(ra) # 80002fac <_ZN6Kernel13wakeUpThreadsEv>
            break;
    80003330:	f25ff06f          	j	80003254 <_ZN6Kernel16interruptHandlerEv+0xbc>
    static void resetNumOfTicks() { numOfTicks = DEFAULT_TIME_SLICE; }
    80003334:	00005797          	auipc	a5,0x5
    80003338:	4847b783          	ld	a5,1156(a5) # 800087b8 <_GLOBAL_OFFSET_TABLE_+0x48>
    8000333c:	00200713          	li	a4,2
    80003340:	00e7b023          	sd	a4,0(a5)
    __asm__ volatile ("csrr %[reg], sepc": [reg] "=r"(returnAddress));
    80003344:	141024f3          	csrr	s1,sepc
                uint64 sepc = Machine::readSepc() + 4;
    80003348:	00448493          	addi	s1,s1,4
    __asm__ volatile ("csrr %[reg], sstatus": [reg] "=r"(returnStatus));
    8000334c:	10002973          	csrr	s2,sstatus
                TCB::dispatch();
    80003350:	fffff097          	auipc	ra,0xfffff
    80003354:	f54080e7          	jalr	-172(ra) # 800022a4 <_ZN3TCB8dispatchEv>
    __asm__ volatile("csrw sepc, %[reg]":: [reg] "r"(address));
    80003358:	14149073          	csrw	sepc,s1
    __asm__ volatile("csrw sstatus, %[reg]":: [reg] "r"(oldStatus));
    8000335c:	10091073          	csrw	sstatus,s2
}
    80003360:	fc9ff06f          	j	80003328 <_ZN6Kernel16interruptHandlerEv+0x190>
                    Scheduler::put(KConsole::getConsumerThread());
    80003364:	00005797          	auipc	a5,0x5
    80003368:	45c7b783          	ld	a5,1116(a5) # 800087c0 <_GLOBAL_OFFSET_TABLE_+0x50>
    8000336c:	0007b503          	ld	a0,0(a5)
    80003370:	fffff097          	auipc	ra,0xfffff
    80003374:	b58080e7          	jalr	-1192(ra) # 80001ec8 <_ZN9Scheduler3putEP3TCB>
    80003378:	f6dff06f          	j	800032e4 <_ZN6Kernel16interruptHandlerEv+0x14c>
    static bool isInputBufferFull() { return inputBuffer->isBufferFull(); }
    8000337c:	00005797          	auipc	a5,0x5
    80003380:	45c7b783          	ld	a5,1116(a5) # 800087d8 <_GLOBAL_OFFSET_TABLE_+0x68>
    80003384:	0007b503          	ld	a0,0(a5)
    80003388:	fffff097          	auipc	ra,0xfffff
    8000338c:	86c080e7          	jalr	-1940(ra) # 80001bf4 <_ZNK6BufferIcLm100EE12isBufferFullEv>
                if (KConsole::isInputBufferFull()) {
    80003390:	00050a63          	beqz	a0,800033a4 <_ZN6Kernel16interruptHandlerEv+0x20c>
                    plic_complete(numOfDevice);
    80003394:	00090513          	mv	a0,s2
    80003398:	00001097          	auipc	ra,0x1
    8000339c:	464080e7          	jalr	1124(ra) # 800047fc <plic_complete>
    800033a0:	f45ff06f          	j	800032e4 <_ZN6Kernel16interruptHandlerEv+0x14c>
                    Scheduler::put(KConsole::getProducerThread());
    800033a4:	00005797          	auipc	a5,0x5
    800033a8:	44c7b783          	ld	a5,1100(a5) # 800087f0 <_GLOBAL_OFFSET_TABLE_+0x80>
    800033ac:	0007b503          	ld	a0,0(a5)
    800033b0:	fffff097          	auipc	ra,0xfffff
    800033b4:	b18080e7          	jalr	-1256(ra) # 80001ec8 <_ZN9Scheduler3putEP3TCB>
    800033b8:	f2dff06f          	j	800032e4 <_ZN6Kernel16interruptHandlerEv+0x14c>

00000000800033bc <_ZN6Kernel7sysPutcEPNS_21ArgumentsOfSystemCallE>:
{
    800033bc:	fd010113          	addi	sp,sp,-48
    800033c0:	02113423          	sd	ra,40(sp)
    800033c4:	02813023          	sd	s0,32(sp)
    800033c8:	00913c23          	sd	s1,24(sp)
    800033cc:	01213823          	sd	s2,16(sp)
    800033d0:	01313423          	sd	s3,8(sp)
    800033d4:	03010413          	addi	s0,sp,48
    800033d8:	00050493          	mv	s1,a0
    static bool isOutputBufferFull() { return outputBuffer->isBufferFull(); }
    800033dc:	00005797          	auipc	a5,0x5
    800033e0:	3d47b783          	ld	a5,980(a5) # 800087b0 <_GLOBAL_OFFSET_TABLE_+0x40>
    800033e4:	0007b503          	ld	a0,0(a5)
    800033e8:	fffff097          	auipc	ra,0xfffff
    800033ec:	80c080e7          	jalr	-2036(ra) # 80001bf4 <_ZNK6BufferIcLm100EE12isBufferFullEv>
    if(KConsole::isOutputBufferFull())
    800033f0:	02051863          	bnez	a0,80003420 <_ZN6Kernel7sysPutcEPNS_21ArgumentsOfSystemCallE+0x64>
    KConsole::addCharToOutputBuffer(arg->a0);
    800033f4:	0004c503          	lbu	a0,0(s1)
    800033f8:	ffffe097          	auipc	ra,0xffffe
    800033fc:	69c080e7          	jalr	1692(ra) # 80001a94 <_ZN8KConsole21addCharToOutputBufferEc>
}
    80003400:	00000513          	li	a0,0
    80003404:	02813083          	ld	ra,40(sp)
    80003408:	02013403          	ld	s0,32(sp)
    8000340c:	01813483          	ld	s1,24(sp)
    80003410:	01013903          	ld	s2,16(sp)
    80003414:	00813983          	ld	s3,8(sp)
    80003418:	03010113          	addi	sp,sp,48
    8000341c:	00008067          	ret
    static TCB* getRunningThread() { return running; }
    80003420:	00005997          	auipc	s3,0x5
    80003424:	3b09b983          	ld	s3,944(s3) # 800087d0 <_GLOBAL_OFFSET_TABLE_+0x60>
    80003428:	0009b903          	ld	s2,0(s3)
        TCB::setRunningThread(Scheduler::get());
    8000342c:	fffff097          	auipc	ra,0xfffff
    80003430:	ad0080e7          	jalr	-1328(ra) # 80001efc <_ZN9Scheduler3getEv>
    static void setRunningThread(TCB* newRunningThread) { running = newRunningThread; }
    80003434:	00a9b023          	sd	a0,0(s3)
    void resetState() {state = nullptr; }
    80003438:	04093423          	sd	zero,72(s2)
        KConsole::addThreadToOutputWaitQueue(oldThread);
    8000343c:	00090513          	mv	a0,s2
    80003440:	ffffe097          	auipc	ra,0xffffe
    80003444:	498080e7          	jalr	1176(ra) # 800018d8 <_ZN8KConsole26addThreadToOutputWaitQueueEP3TCB>
    static TCB* getRunningThread() { return running; }
    80003448:	0009b583          	ld	a1,0(s3)
        context_switch(oldThread->getContext(), TCB::getRunningThread()->getContext());
    8000344c:	00858593          	addi	a1,a1,8
    80003450:	00890513          	addi	a0,s2,8
    80003454:	ffffe097          	auipc	ra,0xffffe
    80003458:	d4c080e7          	jalr	-692(ra) # 800011a0 <context_switch>
    8000345c:	f99ff06f          	j	800033f4 <_ZN6Kernel7sysPutcEPNS_21ArgumentsOfSystemCallE+0x38>

0000000080003460 <_Z41__static_initialization_and_destruction_0ii>:
    80003460:	00100793          	li	a5,1
    80003464:	00f50463          	beq	a0,a5,8000346c <_Z41__static_initialization_and_destruction_0ii+0xc>
    80003468:	00008067          	ret
    8000346c:	000107b7          	lui	a5,0x10
    80003470:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80003474:	fef59ae3          	bne	a1,a5,80003468 <_Z41__static_initialization_and_destruction_0ii+0x8>
    80003478:	fe010113          	addi	sp,sp,-32
    8000347c:	00113c23          	sd	ra,24(sp)
    80003480:	00813823          	sd	s0,16(sp)
    80003484:	00913423          	sd	s1,8(sp)
    80003488:	02010413          	addi	s0,sp,32
ObjectPool<TCB, KernelConfig::NUM_OF_THREADS_IN_POOL>* Kernel::poolOfThreads = new ObjectPool<TCB, KernelConfig::NUM_OF_THREADS_IN_POOL>();
    8000348c:	000014b7          	lui	s1,0x1
    80003490:	97848513          	addi	a0,s1,-1672 # 978 <_entry-0x7ffff688>
    80003494:	00000097          	auipc	ra,0x0
    80003498:	788080e7          	jalr	1928(ra) # 80003c1c <_ZN10ObjectPoolI3TCBLm20EEnwEm>

template <typename T, size_t numOfObjects>
class ObjectPool
{
public:
    ObjectPool(): headFreeObject(pool), nextObjectPool(nullptr), prevObjectPool(nullptr)
    8000349c:	009507b3          	add	a5,a0,s1
    800034a0:	96a7b023          	sd	a0,-1696(a5)
    800034a4:	9607b423          	sd	zero,-1688(a5)
    800034a8:	9607b823          	sd	zero,-1680(a5)
    {

        for(size_t i = 0; i < numOfObjects - 1; i++)
    800034ac:	00000693          	li	a3,0
    800034b0:	01200793          	li	a5,18
    800034b4:	02d7ea63          	bltu	a5,a3,800034e8 <_Z41__static_initialization_and_destruction_0ii+0x88>
        {
            pool[i].nextFree = &(pool[i+1]);
    800034b8:	00168613          	addi	a2,a3,1
    800034bc:	00461713          	slli	a4,a2,0x4
    800034c0:	40c70733          	sub	a4,a4,a2
    800034c4:	00371713          	slli	a4,a4,0x3
    800034c8:	00e50733          	add	a4,a0,a4
    800034cc:	00469793          	slli	a5,a3,0x4
    800034d0:	40d787b3          	sub	a5,a5,a3
    800034d4:	00379793          	slli	a5,a5,0x3
    800034d8:	00f507b3          	add	a5,a0,a5
    800034dc:	06e7b823          	sd	a4,112(a5)
        for(size_t i = 0; i < numOfObjects - 1; i++)
    800034e0:	00060693          	mv	a3,a2
    800034e4:	fcdff06f          	j	800034b0 <_Z41__static_initialization_and_destruction_0ii+0x50>
        }
        pool[numOfObjects - 1].nextFree = nullptr;
    800034e8:	000017b7          	lui	a5,0x1
    800034ec:	00f507b3          	add	a5,a0,a5
    800034f0:	9407bc23          	sd	zero,-1704(a5) # 958 <_entry-0x7ffff6a8>
    800034f4:	00005797          	auipc	a5,0x5
    800034f8:	5ea7b623          	sd	a0,1516(a5) # 80008ae0 <_ZN6Kernel13poolOfThreadsE>
ObjectPool<KSemaphore, KernelConfig::NUM_OF_SEMAPHORES_IN_POOL>* Kernel::poolOfSemaphores = new ObjectPool<KSemaphore, KernelConfig::NUM_OF_SEMAPHORES_IN_POOL>();
    800034fc:	15800513          	li	a0,344
    80003500:	00000097          	auipc	ra,0x0
    80003504:	780080e7          	jalr	1920(ra) # 80003c80 <_ZN10ObjectPoolI10KSemaphoreLm10EEnwEm>
    ObjectPool(): headFreeObject(pool), nextObjectPool(nullptr), prevObjectPool(nullptr)
    80003508:	14a53023          	sd	a0,320(a0)
    8000350c:	14053423          	sd	zero,328(a0)
    80003510:	14053823          	sd	zero,336(a0)
        for(size_t i = 0; i < numOfObjects - 1; i++)
    80003514:	00000793          	li	a5,0
    80003518:	00800713          	li	a4,8
    8000351c:	02f76263          	bltu	a4,a5,80003540 <_Z41__static_initialization_and_destruction_0ii+0xe0>
            pool[i].nextFree = &(pool[i+1]);
    80003520:	00178693          	addi	a3,a5,1
    80003524:	00569713          	slli	a4,a3,0x5
    80003528:	00e50733          	add	a4,a0,a4
    8000352c:	00579793          	slli	a5,a5,0x5
    80003530:	00f507b3          	add	a5,a0,a5
    80003534:	00e7bc23          	sd	a4,24(a5)
        for(size_t i = 0; i < numOfObjects - 1; i++)
    80003538:	00068793          	mv	a5,a3
    8000353c:	fddff06f          	j	80003518 <_Z41__static_initialization_and_destruction_0ii+0xb8>
        pool[numOfObjects - 1].nextFree = nullptr;
    80003540:	12053c23          	sd	zero,312(a0)
    80003544:	00005497          	auipc	s1,0x5
    80003548:	37c48493          	addi	s1,s1,892 # 800088c0 <_ZN6Kernel20queueOfAsleepThreadsE>
    8000354c:	22a4b423          	sd	a0,552(s1)
PriorityQueue<TCB, decltype(cmp)>* Kernel::queueOfAsleepThreads = new PriorityQueue<TCB, decltype(cmp)>(cmp);
    80003550:	01800513          	li	a0,24
    80003554:	fffff097          	auipc	ra,0xfffff
    80003558:	758080e7          	jalr	1880(ra) # 80002cac <_ZN13PriorityQueueI3TCBUlPS0_S1_E_EnwEm>
    explicit PriorityQueue(Compare c) : cmp(c) {}
    8000355c:	00053023          	sd	zero,0(a0)
    80003560:	00053423          	sd	zero,8(a0)
    80003564:	00a4b023          	sd	a0,0(s1)
    80003568:	01813083          	ld	ra,24(sp)
    8000356c:	01013403          	ld	s0,16(sp)
    80003570:	00813483          	ld	s1,8(sp)
    80003574:	02010113          	addi	sp,sp,32
    80003578:	00008067          	ret

000000008000357c <_ZN6Kernel7destroyEv>:
{
    8000357c:	fd010113          	addi	sp,sp,-48
    80003580:	02113423          	sd	ra,40(sp)
    80003584:	02813023          	sd	s0,32(sp)
    80003588:	00913c23          	sd	s1,24(sp)
    8000358c:	01213823          	sd	s2,16(sp)
    80003590:	01313423          	sd	s3,8(sp)
    80003594:	03010413          	addi	s0,sp,48
    delete poolOfThreads;
    80003598:	00005997          	auipc	s3,0x5
    8000359c:	5489b983          	ld	s3,1352(s3) # 80008ae0 <_ZN6Kernel13poolOfThreadsE>
    800035a0:	02098e63          	beqz	s3,800035dc <_ZN6Kernel7destroyEv+0x60>
class ObjectPool
    800035a4:	00098913          	mv	s2,s3
    800035a8:	02098463          	beqz	s3,800035d0 <_ZN6Kernel7destroyEv+0x54>
    800035ac:	000014b7          	lui	s1,0x1
    800035b0:	96048493          	addi	s1,s1,-1696 # 960 <_entry-0x7ffff6a0>
    800035b4:	009984b3          	add	s1,s3,s1
    800035b8:	0140006f          	j	800035cc <_ZN6Kernel7destroyEv+0x50>
    800035bc:	f8848493          	addi	s1,s1,-120
    int freeObject(T* obj);


private:

    typedef struct PoolObject
    800035c0:	00048513          	mv	a0,s1
    800035c4:	fffff097          	auipc	ra,0xfffff
    800035c8:	d48080e7          	jalr	-696(ra) # 8000230c <_ZN3TCBD1Ev>
class ObjectPool
    800035cc:	fe9918e3          	bne	s2,s1,800035bc <_ZN6Kernel7destroyEv+0x40>
    800035d0:	00098513          	mv	a0,s3
    800035d4:	00000097          	auipc	ra,0x0
    800035d8:	684080e7          	jalr	1668(ra) # 80003c58 <_ZN10ObjectPoolI3TCBLm20EEdlEPv>
    delete poolOfSemaphores;
    800035dc:	00005997          	auipc	s3,0x5
    800035e0:	50c9b983          	ld	s3,1292(s3) # 80008ae8 <_ZN6Kernel16poolOfSemaphoresE>
    800035e4:	02098a63          	beqz	s3,80003618 <_ZN6Kernel7destroyEv+0x9c>
    800035e8:	00098913          	mv	s2,s3
    800035ec:	02098063          	beqz	s3,8000360c <_ZN6Kernel7destroyEv+0x90>
    800035f0:	14098493          	addi	s1,s3,320
    800035f4:	00990c63          	beq	s2,s1,8000360c <_ZN6Kernel7destroyEv+0x90>
    800035f8:	fe048493          	addi	s1,s1,-32
    typedef struct PoolObject
    800035fc:	00048513          	mv	a0,s1
    80003600:	fffff097          	auipc	ra,0xfffff
    80003604:	2c0080e7          	jalr	704(ra) # 800028c0 <_ZN10KSemaphoreD1Ev>
    80003608:	fedff06f          	j	800035f4 <_ZN6Kernel7destroyEv+0x78>
    8000360c:	00098513          	mv	a0,s3
    80003610:	00000097          	auipc	ra,0x0
    80003614:	6ac080e7          	jalr	1708(ra) # 80003cbc <_ZN10ObjectPoolI10KSemaphoreLm10EEdlEPv>
    delete queueOfAsleepThreads;
    80003618:	00005517          	auipc	a0,0x5
    8000361c:	2a853503          	ld	a0,680(a0) # 800088c0 <_ZN6Kernel20queueOfAsleepThreadsE>
    80003620:	00050663          	beqz	a0,8000362c <_ZN6Kernel7destroyEv+0xb0>
    80003624:	fffff097          	auipc	ra,0xfffff
    80003628:	6c4080e7          	jalr	1732(ra) # 80002ce8 <_ZN13PriorityQueueI3TCBUlPS0_S1_E_EdlEPv>
}
    8000362c:	02813083          	ld	ra,40(sp)
    80003630:	02013403          	ld	s0,32(sp)
    80003634:	01813483          	ld	s1,24(sp)
    80003638:	01013903          	ld	s2,16(sp)
    8000363c:	00813983          	ld	s3,8(sp)
    80003640:	03010113          	addi	sp,sp,48
    80003644:	00008067          	ret

0000000080003648 <_ZN6Kernel13sysThreadJoinEPNS_21ArgumentsOfSystemCallE>:
{
    80003648:	fd010113          	addi	sp,sp,-48
    8000364c:	02113423          	sd	ra,40(sp)
    80003650:	02813023          	sd	s0,32(sp)
    80003654:	00913c23          	sd	s1,24(sp)
    80003658:	01213823          	sd	s2,16(sp)
    8000365c:	01313423          	sd	s3,8(sp)
    80003660:	03010413          	addi	s0,sp,48
    TCB* temp = (TCB*)(arg->a0);
    80003664:	00053483          	ld	s1,0(a0)
    bool isFinished() const { return finished; }
    80003668:	0504c783          	lbu	a5,80(s1)
    if(!temp->isFinished())
    8000366c:	02078e63          	beqz	a5,800036a8 <_ZN6Kernel13sysThreadJoinEPNS_21ArgumentsOfSystemCallE+0x60>
    delete temp;
    80003670:	06049c63          	bnez	s1,800036e8 <_ZN6Kernel13sysThreadJoinEPNS_21ArgumentsOfSystemCallE+0xa0>
    poolOfThreads->freeObject(temp);
    80003674:	00048593          	mv	a1,s1
    80003678:	00005517          	auipc	a0,0x5
    8000367c:	46853503          	ld	a0,1128(a0) # 80008ae0 <_ZN6Kernel13poolOfThreadsE>
    80003680:	00000097          	auipc	ra,0x0
    80003684:	664080e7          	jalr	1636(ra) # 80003ce4 <_ZN10ObjectPoolI3TCBLm20EE10freeObjectEPS0_>
}
    80003688:	00000513          	li	a0,0
    8000368c:	02813083          	ld	ra,40(sp)
    80003690:	02013403          	ld	s0,32(sp)
    80003694:	01813483          	ld	s1,24(sp)
    80003698:	01013903          	ld	s2,16(sp)
    8000369c:	00813983          	ld	s3,8(sp)
    800036a0:	03010113          	addi	sp,sp,48
    800036a4:	00008067          	ret
    static TCB* getRunningThread() { return running; }
    800036a8:	00005997          	auipc	s3,0x5
    800036ac:	1289b983          	ld	s3,296(s3) # 800087d0 <_GLOBAL_OFFSET_TABLE_+0x60>
    800036b0:	0009b903          	ld	s2,0(s3)
    void resetState() {state = nullptr; }
    800036b4:	04093423          	sd	zero,72(s2)
        temp->addThreadToWaitQueue(oldThread);
    800036b8:	00090593          	mv	a1,s2
    800036bc:	00048513          	mv	a0,s1
    800036c0:	fffff097          	auipc	ra,0xfffff
    800036c4:	d04080e7          	jalr	-764(ra) # 800023c4 <_ZN3TCB20addThreadToWaitQueueEPS_>
        TCB::TCB::setRunningThread(Scheduler::get());
    800036c8:	fffff097          	auipc	ra,0xfffff
    800036cc:	834080e7          	jalr	-1996(ra) # 80001efc <_ZN9Scheduler3getEv>
    static void setRunningThread(TCB* newRunningThread) { running = newRunningThread; }
    800036d0:	00a9b023          	sd	a0,0(s3)
        context_switch(oldThread->getContext(), TCB::getRunningThread()->getContext());
    800036d4:	00850593          	addi	a1,a0,8
    800036d8:	00890513          	addi	a0,s2,8
    800036dc:	ffffe097          	auipc	ra,0xffffe
    800036e0:	ac4080e7          	jalr	-1340(ra) # 800011a0 <context_switch>
    800036e4:	f8dff06f          	j	80003670 <_ZN6Kernel13sysThreadJoinEPNS_21ArgumentsOfSystemCallE+0x28>
    delete temp;
    800036e8:	00048513          	mv	a0,s1
    800036ec:	fffff097          	auipc	ra,0xfffff
    800036f0:	c20080e7          	jalr	-992(ra) # 8000230c <_ZN3TCBD1Ev>
    800036f4:	00048513          	mv	a0,s1
    800036f8:	fffff097          	auipc	ra,0xfffff
    800036fc:	904080e7          	jalr	-1788(ra) # 80001ffc <_ZdlPv>
    80003700:	f75ff06f          	j	80003674 <_ZN6Kernel13sysThreadJoinEPNS_21ArgumentsOfSystemCallE+0x2c>

0000000080003704 <_ZN6Kernel17sysSemaphoreCloseEPNS_21ArgumentsOfSystemCallE>:
{
    80003704:	fe010113          	addi	sp,sp,-32
    80003708:	00113c23          	sd	ra,24(sp)
    8000370c:	00813823          	sd	s0,16(sp)
    80003710:	00913423          	sd	s1,8(sp)
    80003714:	01213023          	sd	s2,0(sp)
    80003718:	02010413          	addi	s0,sp,32
    KSemaphore* tempSemaphore = (KSemaphore*)(arg->a0);
    8000371c:	00053483          	ld	s1,0(a0)
    returnValue = (uint64)tempSemaphore->close();
    80003720:	00048513          	mv	a0,s1
    80003724:	fffff097          	auipc	ra,0xfffff
    80003728:	35c080e7          	jalr	860(ra) # 80002a80 <_ZN10KSemaphore5closeEv>
    8000372c:	00050913          	mv	s2,a0
    Kernel::poolOfSemaphores->freeObject(tempSemaphore);
    80003730:	00048593          	mv	a1,s1
    80003734:	00005517          	auipc	a0,0x5
    80003738:	3b453503          	ld	a0,948(a0) # 80008ae8 <_ZN6Kernel16poolOfSemaphoresE>
    8000373c:	00000097          	auipc	ra,0x0
    80003740:	5dc080e7          	jalr	1500(ra) # 80003d18 <_ZN10ObjectPoolI10KSemaphoreLm10EE10freeObjectEPS0_>
    delete tempSemaphore;
    80003744:	02049063          	bnez	s1,80003764 <_ZN6Kernel17sysSemaphoreCloseEPNS_21ArgumentsOfSystemCallE+0x60>
}
    80003748:	00090513          	mv	a0,s2
    8000374c:	01813083          	ld	ra,24(sp)
    80003750:	01013403          	ld	s0,16(sp)
    80003754:	00813483          	ld	s1,8(sp)
    80003758:	00013903          	ld	s2,0(sp)
    8000375c:	02010113          	addi	sp,sp,32
    80003760:	00008067          	ret
    delete tempSemaphore;
    80003764:	00048513          	mv	a0,s1
    80003768:	fffff097          	auipc	ra,0xfffff
    8000376c:	158080e7          	jalr	344(ra) # 800028c0 <_ZN10KSemaphoreD1Ev>
    80003770:	00048513          	mv	a0,s1
    80003774:	fffff097          	auipc	ra,0xfffff
    80003778:	888080e7          	jalr	-1912(ra) # 80001ffc <_ZdlPv>
    return returnValue;
    8000377c:	fcdff06f          	j	80003748 <_ZN6Kernel17sysSemaphoreCloseEPNS_21ArgumentsOfSystemCallE+0x44>

0000000080003780 <_ZN6Kernel18makeConsumerThreadEv>:
{
    80003780:	fd010113          	addi	sp,sp,-48
    80003784:	02113423          	sd	ra,40(sp)
    80003788:	02813023          	sd	s0,32(sp)
    8000378c:	00913c23          	sd	s1,24(sp)
    80003790:	01213823          	sd	s2,16(sp)
    80003794:	03010413          	addi	s0,sp,48
    void* kernelSystemStack = Kernel::mallocSystemStack(KernelConfig::DEFAULT_SYSTEM_STACK_SIZE);
    80003798:	40000513          	li	a0,1024
    8000379c:	fffff097          	auipc	ra,0xfffff
    800037a0:	7d0080e7          	jalr	2000(ra) # 80002f6c <_ZN6Kernel17mallocSystemStackEm>
    800037a4:	00050913          	mv	s2,a0
    TCB* consumerThread = poolOfThreads->mallocObject(&sourcePool);
    800037a8:	fd840593          	addi	a1,s0,-40
    800037ac:	00005517          	auipc	a0,0x5
    800037b0:	33453503          	ld	a0,820(a0) # 80008ae0 <_ZN6Kernel13poolOfThreadsE>
    800037b4:	00000097          	auipc	ra,0x0
    800037b8:	5cc080e7          	jalr	1484(ra) # 80003d80 <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEPPS1_>
    800037bc:	00050493          	mv	s1,a0
    while(!consumerThread)
    800037c0:	02049063          	bnez	s1,800037e0 <_ZN6Kernel18makeConsumerThreadEv+0x60>
        consumerThread = poolOfThreads->mallocObject(&sourcePool);
    800037c4:	fd840593          	addi	a1,s0,-40
    800037c8:	00005517          	auipc	a0,0x5
    800037cc:	31853503          	ld	a0,792(a0) # 80008ae0 <_ZN6Kernel13poolOfThreadsE>
    800037d0:	00000097          	auipc	ra,0x0
    800037d4:	5b0080e7          	jalr	1456(ra) # 80003d80 <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEPPS1_>
    800037d8:	00050493          	mv	s1,a0
    800037dc:	fe5ff06f          	j	800037c0 <_ZN6Kernel18makeConsumerThreadEv+0x40>
    consumerThread->initializeThread(&KConsole::consumeOutputBuffer, nullptr, kernelSystemStack, kernelSystemStack, sourcePool, KernelConfig::BLOCKED, KernelConfig::KERNEL_MODE);
    800037e0:	00100893          	li	a7,1
    800037e4:	00100813          	li	a6,1
    800037e8:	fd843783          	ld	a5,-40(s0)
    800037ec:	00090713          	mv	a4,s2
    800037f0:	00090693          	mv	a3,s2
    800037f4:	00000613          	li	a2,0
    800037f8:	00005597          	auipc	a1,0x5
    800037fc:	f985b583          	ld	a1,-104(a1) # 80008790 <_GLOBAL_OFFSET_TABLE_+0x20>
    80003800:	00048513          	mv	a0,s1
    80003804:	fffff097          	auipc	ra,0xfffff
    80003808:	9dc080e7          	jalr	-1572(ra) # 800021e0 <_ZN3TCB16initializeThreadEPFvPvES0_S0_S0_P10ObjectPoolIS_Lm20EEN12KernelConfig11ThreadStateENS6_4ModeE>
    static void setConsumerThread(TCB* thread) { consumerThread = thread; }
    8000380c:	00005797          	auipc	a5,0x5
    80003810:	fb47b783          	ld	a5,-76(a5) # 800087c0 <_GLOBAL_OFFSET_TABLE_+0x50>
    80003814:	0097b023          	sd	s1,0(a5)
}
    80003818:	02813083          	ld	ra,40(sp)
    8000381c:	02013403          	ld	s0,32(sp)
    80003820:	01813483          	ld	s1,24(sp)
    80003824:	01013903          	ld	s2,16(sp)
    80003828:	03010113          	addi	sp,sp,48
    8000382c:	00008067          	ret

0000000080003830 <_ZN6Kernel18makeProducerThreadEv>:
{
    80003830:	fd010113          	addi	sp,sp,-48
    80003834:	02113423          	sd	ra,40(sp)
    80003838:	02813023          	sd	s0,32(sp)
    8000383c:	00913c23          	sd	s1,24(sp)
    80003840:	01213823          	sd	s2,16(sp)
    80003844:	03010413          	addi	s0,sp,48
    void* kernelSystemStack = Kernel::mallocSystemStack(KernelConfig::DEFAULT_SYSTEM_STACK_SIZE);
    80003848:	40000513          	li	a0,1024
    8000384c:	fffff097          	auipc	ra,0xfffff
    80003850:	720080e7          	jalr	1824(ra) # 80002f6c <_ZN6Kernel17mallocSystemStackEm>
    80003854:	00050913          	mv	s2,a0
    TCB* producerThread = poolOfThreads->mallocObject(&sourcePool);
    80003858:	fd840593          	addi	a1,s0,-40
    8000385c:	00005517          	auipc	a0,0x5
    80003860:	28453503          	ld	a0,644(a0) # 80008ae0 <_ZN6Kernel13poolOfThreadsE>
    80003864:	00000097          	auipc	ra,0x0
    80003868:	51c080e7          	jalr	1308(ra) # 80003d80 <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEPPS1_>
    8000386c:	00050493          	mv	s1,a0
    while(!producerThread)
    80003870:	02049063          	bnez	s1,80003890 <_ZN6Kernel18makeProducerThreadEv+0x60>
        producerThread = poolOfThreads->mallocObject(&sourcePool);
    80003874:	fd840593          	addi	a1,s0,-40
    80003878:	00005517          	auipc	a0,0x5
    8000387c:	26853503          	ld	a0,616(a0) # 80008ae0 <_ZN6Kernel13poolOfThreadsE>
    80003880:	00000097          	auipc	ra,0x0
    80003884:	500080e7          	jalr	1280(ra) # 80003d80 <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEPPS1_>
    80003888:	00050493          	mv	s1,a0
    8000388c:	fe5ff06f          	j	80003870 <_ZN6Kernel18makeProducerThreadEv+0x40>
    producerThread->initializeThread(&KConsole::produceInputBuffer, nullptr, kernelSystemStack, kernelSystemStack, sourcePool, KernelConfig::BLOCKED, KernelConfig::KERNEL_MODE);
    80003890:	00100893          	li	a7,1
    80003894:	00100813          	li	a6,1
    80003898:	fd843783          	ld	a5,-40(s0)
    8000389c:	00090713          	mv	a4,s2
    800038a0:	00090693          	mv	a3,s2
    800038a4:	00000613          	li	a2,0
    800038a8:	00005597          	auipc	a1,0x5
    800038ac:	f405b583          	ld	a1,-192(a1) # 800087e8 <_GLOBAL_OFFSET_TABLE_+0x78>
    800038b0:	00048513          	mv	a0,s1
    800038b4:	fffff097          	auipc	ra,0xfffff
    800038b8:	92c080e7          	jalr	-1748(ra) # 800021e0 <_ZN3TCB16initializeThreadEPFvPvES0_S0_S0_P10ObjectPoolIS_Lm20EEN12KernelConfig11ThreadStateENS6_4ModeE>
    static void setProducerThread(TCB* thread) { producerThread = thread; }
    800038bc:	00005797          	auipc	a5,0x5
    800038c0:	f347b783          	ld	a5,-204(a5) # 800087f0 <_GLOBAL_OFFSET_TABLE_+0x80>
    800038c4:	0097b023          	sd	s1,0(a5)
}
    800038c8:	02813083          	ld	ra,40(sp)
    800038cc:	02013403          	ld	s0,32(sp)
    800038d0:	01813483          	ld	s1,24(sp)
    800038d4:	01013903          	ld	s2,16(sp)
    800038d8:	03010113          	addi	sp,sp,48
    800038dc:	00008067          	ret

00000000800038e0 <_ZN6Kernel14makeIdleThreadEv>:
{
    800038e0:	fd010113          	addi	sp,sp,-48
    800038e4:	02113423          	sd	ra,40(sp)
    800038e8:	02813023          	sd	s0,32(sp)
    800038ec:	00913c23          	sd	s1,24(sp)
    800038f0:	01213823          	sd	s2,16(sp)
    800038f4:	03010413          	addi	s0,sp,48
    void* kernelSystemStack = Kernel::mallocSystemStack(KernelConfig::DEFAULT_SYSTEM_STACK_SIZE);
    800038f8:	40000513          	li	a0,1024
    800038fc:	fffff097          	auipc	ra,0xfffff
    80003900:	670080e7          	jalr	1648(ra) # 80002f6c <_ZN6Kernel17mallocSystemStackEm>
    80003904:	00050913          	mv	s2,a0
    TCB* idleThread = poolOfThreads->mallocObject(&sourcePool);
    80003908:	fd840593          	addi	a1,s0,-40
    8000390c:	00005517          	auipc	a0,0x5
    80003910:	1d453503          	ld	a0,468(a0) # 80008ae0 <_ZN6Kernel13poolOfThreadsE>
    80003914:	00000097          	auipc	ra,0x0
    80003918:	46c080e7          	jalr	1132(ra) # 80003d80 <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEPPS1_>
    8000391c:	00050493          	mv	s1,a0
    while(!idleThread)
    80003920:	02049063          	bnez	s1,80003940 <_ZN6Kernel14makeIdleThreadEv+0x60>
        idleThread = poolOfThreads->mallocObject(&sourcePool);
    80003924:	fd840593          	addi	a1,s0,-40
    80003928:	00005517          	auipc	a0,0x5
    8000392c:	1b853503          	ld	a0,440(a0) # 80008ae0 <_ZN6Kernel13poolOfThreadsE>
    80003930:	00000097          	auipc	ra,0x0
    80003934:	450080e7          	jalr	1104(ra) # 80003d80 <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEPPS1_>
    80003938:	00050493          	mv	s1,a0
    8000393c:	fe5ff06f          	j	80003920 <_ZN6Kernel14makeIdleThreadEv+0x40>
    idleThread->initializeThread(&kernelWorker, nullptr, kernelSystemStack, kernelSystemStack, sourcePool, KernelConfig::BLOCKED, KernelConfig::KERNEL_MODE);
    80003940:	00100893          	li	a7,1
    80003944:	00100813          	li	a6,1
    80003948:	fd843783          	ld	a5,-40(s0)
    8000394c:	00090713          	mv	a4,s2
    80003950:	00090693          	mv	a3,s2
    80003954:	00000613          	li	a2,0
    80003958:	fffff597          	auipc	a1,0xfffff
    8000395c:	23858593          	addi	a1,a1,568 # 80002b90 <_ZN6Kernel12kernelWorkerEPv>
    80003960:	00048513          	mv	a0,s1
    80003964:	fffff097          	auipc	ra,0xfffff
    80003968:	87c080e7          	jalr	-1924(ra) # 800021e0 <_ZN3TCB16initializeThreadEPFvPvES0_S0_S0_P10ObjectPoolIS_Lm20EEN12KernelConfig11ThreadStateENS6_4ModeE>
    Scheduler() = delete;
    Scheduler(const Scheduler& scheduler) = delete;
    Scheduler& operator=(const Scheduler& scheduler) = delete;
    static void put(TCB* readyThread);
    static TCB* get(void);
    static void setIdleThread(TCB* thread) { idleThread = thread; }
    8000396c:	00005797          	auipc	a5,0x5
    80003970:	e5c7b783          	ld	a5,-420(a5) # 800087c8 <_GLOBAL_OFFSET_TABLE_+0x58>
    80003974:	0097b023          	sd	s1,0(a5)
}
    80003978:	02813083          	ld	ra,40(sp)
    8000397c:	02013403          	ld	s0,32(sp)
    80003980:	01813483          	ld	s1,24(sp)
    80003984:	01013903          	ld	s2,16(sp)
    80003988:	03010113          	addi	sp,sp,48
    8000398c:	00008067          	ret

0000000080003990 <_ZN6Kernel23initializeKernelThreadsEv>:
{
    80003990:	ff010113          	addi	sp,sp,-16
    80003994:	00113423          	sd	ra,8(sp)
    80003998:	00813023          	sd	s0,0(sp)
    8000399c:	01010413          	addi	s0,sp,16
    makeConsumerThread();
    800039a0:	00000097          	auipc	ra,0x0
    800039a4:	de0080e7          	jalr	-544(ra) # 80003780 <_ZN6Kernel18makeConsumerThreadEv>
    makeProducerThread();
    800039a8:	00000097          	auipc	ra,0x0
    800039ac:	e88080e7          	jalr	-376(ra) # 80003830 <_ZN6Kernel18makeProducerThreadEv>
    makeIdleThread();
    800039b0:	00000097          	auipc	ra,0x0
    800039b4:	f30080e7          	jalr	-208(ra) # 800038e0 <_ZN6Kernel14makeIdleThreadEv>
}
    800039b8:	00813083          	ld	ra,8(sp)
    800039bc:	00013403          	ld	s0,0(sp)
    800039c0:	01010113          	addi	sp,sp,16
    800039c4:	00008067          	ret

00000000800039c8 <_ZN6Kernel16initializeKernelEv>:
{
    800039c8:	fe010113          	addi	sp,sp,-32
    800039cc:	00113c23          	sd	ra,24(sp)
    800039d0:	00813823          	sd	s0,16(sp)
    800039d4:	00913423          	sd	s1,8(sp)
    800039d8:	02010413          	addi	s0,sp,32

};

inline void Kernel::setInterruptRoutine(void (*routine)(void))
{
    Machine::writeStvec((uint64) routine);
    800039dc:	00005797          	auipc	a5,0x5
    800039e0:	dcc7b783          	ld	a5,-564(a5) # 800087a8 <_GLOBAL_OFFSET_TABLE_+0x38>
    __asm__ volatile ("csrw stvec, %[address]": : [address] "r"(interruptAddress));
    800039e4:	10579073          	csrw	stvec,a5
}
    800039e8:	0180006f          	j	80003a00 <_ZN6Kernel16initializeKernelEv+0x38>
        pool[numOfObjects - 1].nextFree = nullptr;
    800039ec:	000017b7          	lui	a5,0x1
    800039f0:	00f507b3          	add	a5,a0,a5
    800039f4:	9407bc23          	sd	zero,-1704(a5) # 958 <_entry-0x7ffff6a8>
     poolOfThreads = new ObjectPool<TCB, KernelConfig::NUM_OF_THREADS_IN_POOL>();
    800039f8:	00005797          	auipc	a5,0x5
    800039fc:	0ea7b423          	sd	a0,232(a5) # 80008ae0 <_ZN6Kernel13poolOfThreadsE>
    while(!poolOfThreads)
    80003a00:	00005797          	auipc	a5,0x5
    80003a04:	0e07b783          	ld	a5,224(a5) # 80008ae0 <_ZN6Kernel13poolOfThreadsE>
    80003a08:	06079663          	bnez	a5,80003a74 <_ZN6Kernel16initializeKernelEv+0xac>
     poolOfThreads = new ObjectPool<TCB, KernelConfig::NUM_OF_THREADS_IN_POOL>();
    80003a0c:	000014b7          	lui	s1,0x1
    80003a10:	97848513          	addi	a0,s1,-1672 # 978 <_entry-0x7ffff688>
    80003a14:	00000097          	auipc	ra,0x0
    80003a18:	208080e7          	jalr	520(ra) # 80003c1c <_ZN10ObjectPoolI3TCBLm20EEnwEm>
    ObjectPool(): headFreeObject(pool), nextObjectPool(nullptr), prevObjectPool(nullptr)
    80003a1c:	009507b3          	add	a5,a0,s1
    80003a20:	96a7b023          	sd	a0,-1696(a5)
    80003a24:	9607b423          	sd	zero,-1688(a5)
    80003a28:	9607b823          	sd	zero,-1680(a5)
        for(size_t i = 0; i < numOfObjects - 1; i++)
    80003a2c:	00000693          	li	a3,0
    80003a30:	01200793          	li	a5,18
    80003a34:	fad7ece3          	bltu	a5,a3,800039ec <_ZN6Kernel16initializeKernelEv+0x24>
            pool[i].nextFree = &(pool[i+1]);
    80003a38:	00168613          	addi	a2,a3,1
    80003a3c:	00461713          	slli	a4,a2,0x4
    80003a40:	40c70733          	sub	a4,a4,a2
    80003a44:	00371713          	slli	a4,a4,0x3
    80003a48:	00e50733          	add	a4,a0,a4
    80003a4c:	00469793          	slli	a5,a3,0x4
    80003a50:	40d787b3          	sub	a5,a5,a3
    80003a54:	00379793          	slli	a5,a5,0x3
    80003a58:	00f507b3          	add	a5,a0,a5
    80003a5c:	06e7b823          	sd	a4,112(a5)
        for(size_t i = 0; i < numOfObjects - 1; i++)
    80003a60:	00060693          	mv	a3,a2
    80003a64:	fcdff06f          	j	80003a30 <_ZN6Kernel16initializeKernelEv+0x68>
        pool[numOfObjects - 1].nextFree = nullptr;
    80003a68:	12053c23          	sd	zero,312(a0)
        poolOfSemaphores = new ObjectPool<KSemaphore, KernelConfig::NUM_OF_SEMAPHORES_IN_POOL>();
    80003a6c:	00005797          	auipc	a5,0x5
    80003a70:	06a7be23          	sd	a0,124(a5) # 80008ae8 <_ZN6Kernel16poolOfSemaphoresE>
    while(!poolOfSemaphores)
    80003a74:	00005797          	auipc	a5,0x5
    80003a78:	0747b783          	ld	a5,116(a5) # 80008ae8 <_ZN6Kernel16poolOfSemaphoresE>
    80003a7c:	04079463          	bnez	a5,80003ac4 <_ZN6Kernel16initializeKernelEv+0xfc>
        poolOfSemaphores = new ObjectPool<KSemaphore, KernelConfig::NUM_OF_SEMAPHORES_IN_POOL>();
    80003a80:	15800513          	li	a0,344
    80003a84:	00000097          	auipc	ra,0x0
    80003a88:	1fc080e7          	jalr	508(ra) # 80003c80 <_ZN10ObjectPoolI10KSemaphoreLm10EEnwEm>
    ObjectPool(): headFreeObject(pool), nextObjectPool(nullptr), prevObjectPool(nullptr)
    80003a8c:	14a53023          	sd	a0,320(a0)
    80003a90:	14053423          	sd	zero,328(a0)
    80003a94:	14053823          	sd	zero,336(a0)
        for(size_t i = 0; i < numOfObjects - 1; i++)
    80003a98:	00000793          	li	a5,0
    80003a9c:	00800713          	li	a4,8
    80003aa0:	fcf764e3          	bltu	a4,a5,80003a68 <_ZN6Kernel16initializeKernelEv+0xa0>
            pool[i].nextFree = &(pool[i+1]);
    80003aa4:	00178693          	addi	a3,a5,1
    80003aa8:	00569713          	slli	a4,a3,0x5
    80003aac:	00e50733          	add	a4,a0,a4
    80003ab0:	00579793          	slli	a5,a5,0x5
    80003ab4:	00f507b3          	add	a5,a0,a5
    80003ab8:	00e7bc23          	sd	a4,24(a5)
        for(size_t i = 0; i < numOfObjects - 1; i++)
    80003abc:	00068793          	mv	a5,a3
    80003ac0:	fddff06f          	j	80003a9c <_ZN6Kernel16initializeKernelEv+0xd4>
    initializeKernelThreads();
    80003ac4:	00000097          	auipc	ra,0x0
    80003ac8:	ecc080e7          	jalr	-308(ra) # 80003990 <_ZN6Kernel23initializeKernelThreadsEv>
    initializeSystemCalls();
    80003acc:	fffff097          	auipc	ra,0xfffff
    80003ad0:	55c080e7          	jalr	1372(ra) # 80003028 <_ZN6Kernel21initializeSystemCallsEv>
}
    80003ad4:	01813083          	ld	ra,24(sp)
    80003ad8:	01013403          	ld	s0,16(sp)
    80003adc:	00813483          	ld	s1,8(sp)
    80003ae0:	02010113          	addi	sp,sp,32
    80003ae4:	00008067          	ret

0000000080003ae8 <_ZN6Kernel15sysThreadCreateEPNS_21ArgumentsOfSystemCallE>:
{
    80003ae8:	fd010113          	addi	sp,sp,-48
    80003aec:	02113423          	sd	ra,40(sp)
    80003af0:	02813023          	sd	s0,32(sp)
    80003af4:	00913c23          	sd	s1,24(sp)
    80003af8:	01213823          	sd	s2,16(sp)
    80003afc:	03010413          	addi	s0,sp,48
    80003b00:	00050493          	mv	s1,a0
    TCB* newThread = poolOfThreads->mallocObject(&sourcePool);
    80003b04:	fd840593          	addi	a1,s0,-40
    80003b08:	00005517          	auipc	a0,0x5
    80003b0c:	fd853503          	ld	a0,-40(a0) # 80008ae0 <_ZN6Kernel13poolOfThreadsE>
    80003b10:	00000097          	auipc	ra,0x0
    80003b14:	270080e7          	jalr	624(ra) # 80003d80 <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEPPS1_>
    if(!newThread)
    80003b18:	06050063          	beqz	a0,80003b78 <_ZN6Kernel15sysThreadCreateEPNS_21ArgumentsOfSystemCallE+0x90>
    80003b1c:	00050913          	mv	s2,a0
    __asm__ volatile("sd %[ptrThread], 0(%[handle])"::[ptrThread]"r"(newThread), [handle]"r"(arg->a0));
    80003b20:	0004b783          	ld	a5,0(s1)
    80003b24:	00a7b023          	sd	a0,0(a5)
    void* kernelSystemStack = Kernel::mallocSystemStack(KernelConfig::DEFAULT_SYSTEM_STACK_SIZE);
    80003b28:	40000513          	li	a0,1024
    80003b2c:	fffff097          	auipc	ra,0xfffff
    80003b30:	440080e7          	jalr	1088(ra) # 80002f6c <_ZN6Kernel17mallocSystemStackEm>
    80003b34:	00050713          	mv	a4,a0
    newThread->initializeThread((TCB::Body) arg->a1, (void*)arg->a2, (void*)arg->a3, kernelSystemStack, sourcePool);
    80003b38:	00000893          	li	a7,0
    80003b3c:	00100813          	li	a6,1
    80003b40:	fd843783          	ld	a5,-40(s0)
    80003b44:	0184b683          	ld	a3,24(s1)
    80003b48:	0104b603          	ld	a2,16(s1)
    80003b4c:	0084b583          	ld	a1,8(s1)
    80003b50:	00090513          	mv	a0,s2
    80003b54:	ffffe097          	auipc	ra,0xffffe
    80003b58:	68c080e7          	jalr	1676(ra) # 800021e0 <_ZN3TCB16initializeThreadEPFvPvES0_S0_S0_P10ObjectPoolIS_Lm20EEN12KernelConfig11ThreadStateENS6_4ModeE>
    return 0;
    80003b5c:	00000513          	li	a0,0
}
    80003b60:	02813083          	ld	ra,40(sp)
    80003b64:	02013403          	ld	s0,32(sp)
    80003b68:	01813483          	ld	s1,24(sp)
    80003b6c:	01013903          	ld	s2,16(sp)
    80003b70:	03010113          	addi	sp,sp,48
    80003b74:	00008067          	ret
        return -1;
    80003b78:	fff00513          	li	a0,-1
    80003b7c:	fe5ff06f          	j	80003b60 <_ZN6Kernel15sysThreadCreateEPNS_21ArgumentsOfSystemCallE+0x78>

0000000080003b80 <_ZN6Kernel16sysSemaphoreOpenEPNS_21ArgumentsOfSystemCallE>:
{
    80003b80:	fd010113          	addi	sp,sp,-48
    80003b84:	02113423          	sd	ra,40(sp)
    80003b88:	02813023          	sd	s0,32(sp)
    80003b8c:	00913c23          	sd	s1,24(sp)
    80003b90:	03010413          	addi	s0,sp,48
    80003b94:	00050493          	mv	s1,a0
    KSemaphore* newSemaphore = poolOfSemaphores->mallocObject(&sourcePool);
    80003b98:	fd840593          	addi	a1,s0,-40
    80003b9c:	00005517          	auipc	a0,0x5
    80003ba0:	f4c53503          	ld	a0,-180(a0) # 80008ae8 <_ZN6Kernel16poolOfSemaphoresE>
    80003ba4:	00000097          	auipc	ra,0x0
    80003ba8:	30c080e7          	jalr	780(ra) # 80003eb0 <_ZN10ObjectPoolI10KSemaphoreLm10EE12mallocObjectEPPS1_>
    if(!newSemaphore)
    80003bac:	02050a63          	beqz	a0,80003be0 <_ZN6Kernel16sysSemaphoreOpenEPNS_21ArgumentsOfSystemCallE+0x60>
    __asm__ volatile("sd %[ptrSemaphore], 0(%[handle])"::[ptrSemaphore]"r"(newSemaphore), [handle]"r"(arg->a0));
    80003bb0:	0004b783          	ld	a5,0(s1)
    80003bb4:	00a7b023          	sd	a0,0(a5)
    newSemaphore->initializeSemaphore((unsigned)arg->a1, sourcePool);
    80003bb8:	fd843603          	ld	a2,-40(s0)
    80003bbc:	0084a583          	lw	a1,8(s1)
    80003bc0:	fffff097          	auipc	ra,0xfffff
    80003bc4:	ca0080e7          	jalr	-864(ra) # 80002860 <_ZN10KSemaphore19initializeSemaphoreEjP10ObjectPoolIS_Lm10EE>
    return 0;
    80003bc8:	00000513          	li	a0,0
}
    80003bcc:	02813083          	ld	ra,40(sp)
    80003bd0:	02013403          	ld	s0,32(sp)
    80003bd4:	01813483          	ld	s1,24(sp)
    80003bd8:	03010113          	addi	sp,sp,48
    80003bdc:	00008067          	ret
        return -1;
    80003be0:	fff00513          	li	a0,-1
    80003be4:	fe9ff06f          	j	80003bcc <_ZN6Kernel16sysSemaphoreOpenEPNS_21ArgumentsOfSystemCallE+0x4c>

0000000080003be8 <_GLOBAL__sub_I__ZN6Kernel16systemCallsTableE>:
    80003be8:	ff010113          	addi	sp,sp,-16
    80003bec:	00113423          	sd	ra,8(sp)
    80003bf0:	00813023          	sd	s0,0(sp)
    80003bf4:	01010413          	addi	s0,sp,16
    80003bf8:	000105b7          	lui	a1,0x10
    80003bfc:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    80003c00:	00100513          	li	a0,1
    80003c04:	00000097          	auipc	ra,0x0
    80003c08:	85c080e7          	jalr	-1956(ra) # 80003460 <_Z41__static_initialization_and_destruction_0ii>
    80003c0c:	00813083          	ld	ra,8(sp)
    80003c10:	00013403          	ld	s0,0(sp)
    80003c14:	01010113          	addi	sp,sp,16
    80003c18:	00008067          	ret

0000000080003c1c <_ZN10ObjectPoolI3TCBLm20EEnwEm>:

};


template<typename T, size_t numOfObjects>
void* ObjectPool<T, numOfObjects>::operator new(size_t size)
    80003c1c:	ff010113          	addi	sp,sp,-16
    80003c20:	00113423          	sd	ra,8(sp)
    80003c24:	00813023          	sd	s0,0(sp)
    80003c28:	01010413          	addi	s0,sp,16
{
    size_t numOfBlocks = size / MEM_BLOCK_SIZE;
    80003c2c:	00655793          	srli	a5,a0,0x6
    numOfBlocks += size % MEM_BLOCK_SIZE ? 1 : 0;
    80003c30:	03f57513          	andi	a0,a0,63
    80003c34:	00050463          	beqz	a0,80003c3c <_ZN10ObjectPoolI3TCBLm20EEnwEm+0x20>
    80003c38:	00100513          	li	a0,1
    return MemoryAllocator::allocateMemory(numOfBlocks);
    80003c3c:	00f50533          	add	a0,a0,a5
    80003c40:	fffff097          	auipc	ra,0xfffff
    80003c44:	958080e7          	jalr	-1704(ra) # 80002598 <_ZN15MemoryAllocator14allocateMemoryEm>
}
    80003c48:	00813083          	ld	ra,8(sp)
    80003c4c:	00013403          	ld	s0,0(sp)
    80003c50:	01010113          	addi	sp,sp,16
    80003c54:	00008067          	ret

0000000080003c58 <_ZN10ObjectPoolI3TCBLm20EEdlEPv>:
template<typename T, size_t numOfObjects>
void ObjectPool<T, numOfObjects>::operator delete(void *obj)
    80003c58:	ff010113          	addi	sp,sp,-16
    80003c5c:	00113423          	sd	ra,8(sp)
    80003c60:	00813023          	sd	s0,0(sp)
    80003c64:	01010413          	addi	s0,sp,16
{
    MemoryAllocator::freeMemory(obj);
    80003c68:	fffff097          	auipc	ra,0xfffff
    80003c6c:	a8c080e7          	jalr	-1396(ra) # 800026f4 <_ZN15MemoryAllocator10freeMemoryEPv>
}
    80003c70:	00813083          	ld	ra,8(sp)
    80003c74:	00013403          	ld	s0,0(sp)
    80003c78:	01010113          	addi	sp,sp,16
    80003c7c:	00008067          	ret

0000000080003c80 <_ZN10ObjectPoolI10KSemaphoreLm10EEnwEm>:
void* ObjectPool<T, numOfObjects>::operator new(size_t size)
    80003c80:	ff010113          	addi	sp,sp,-16
    80003c84:	00113423          	sd	ra,8(sp)
    80003c88:	00813023          	sd	s0,0(sp)
    80003c8c:	01010413          	addi	s0,sp,16
    size_t numOfBlocks = size / MEM_BLOCK_SIZE;
    80003c90:	00655793          	srli	a5,a0,0x6
    numOfBlocks += size % MEM_BLOCK_SIZE ? 1 : 0;
    80003c94:	03f57513          	andi	a0,a0,63
    80003c98:	00050463          	beqz	a0,80003ca0 <_ZN10ObjectPoolI10KSemaphoreLm10EEnwEm+0x20>
    80003c9c:	00100513          	li	a0,1
    return MemoryAllocator::allocateMemory(numOfBlocks);
    80003ca0:	00f50533          	add	a0,a0,a5
    80003ca4:	fffff097          	auipc	ra,0xfffff
    80003ca8:	8f4080e7          	jalr	-1804(ra) # 80002598 <_ZN15MemoryAllocator14allocateMemoryEm>
}
    80003cac:	00813083          	ld	ra,8(sp)
    80003cb0:	00013403          	ld	s0,0(sp)
    80003cb4:	01010113          	addi	sp,sp,16
    80003cb8:	00008067          	ret

0000000080003cbc <_ZN10ObjectPoolI10KSemaphoreLm10EEdlEPv>:
void ObjectPool<T, numOfObjects>::operator delete(void *obj)
    80003cbc:	ff010113          	addi	sp,sp,-16
    80003cc0:	00113423          	sd	ra,8(sp)
    80003cc4:	00813023          	sd	s0,0(sp)
    80003cc8:	01010413          	addi	s0,sp,16
    MemoryAllocator::freeMemory(obj);
    80003ccc:	fffff097          	auipc	ra,0xfffff
    80003cd0:	a28080e7          	jalr	-1496(ra) # 800026f4 <_ZN15MemoryAllocator10freeMemoryEPv>
}
    80003cd4:	00813083          	ld	ra,8(sp)
    80003cd8:	00013403          	ld	s0,0(sp)
    80003cdc:	01010113          	addi	sp,sp,16
    80003ce0:	00008067          	ret

0000000080003ce4 <_ZN10ObjectPoolI3TCBLm20EE10freeObjectEPS0_>:
        return &(temp->object);
    }
}

template<typename T, size_t numOfObjects>
int ObjectPool<T, numOfObjects>::freeObject(T *obj) {
    80003ce4:	ff010113          	addi	sp,sp,-16
    80003ce8:	00813423          	sd	s0,8(sp)
    80003cec:	01010413          	addi	s0,sp,16
    ObjectPool<TCB, KernelConfig::NUM_OF_THREADS_IN_POOL>* getSourcePool() { return sourcePool; }
    80003cf0:	0685b783          	ld	a5,104(a1)
////        {
////            break;
////        }
////    }
    PoolObject* tempObj = (PoolObject*)obj;
    tempObj->nextFree = curr->headFreeObject;
    80003cf4:	00001737          	lui	a4,0x1
    80003cf8:	00e787b3          	add	a5,a5,a4
    80003cfc:	9607b703          	ld	a4,-1696(a5)
    80003d00:	06e5b823          	sd	a4,112(a1)
    curr->headFreeObject = tempObj;
    80003d04:	96b7b023          	sd	a1,-1696(a5)

    return 0;
}
    80003d08:	00000513          	li	a0,0
    80003d0c:	00813403          	ld	s0,8(sp)
    80003d10:	01010113          	addi	sp,sp,16
    80003d14:	00008067          	ret

0000000080003d18 <_ZN10ObjectPoolI10KSemaphoreLm10EE10freeObjectEPS0_>:
int ObjectPool<T, numOfObjects>::freeObject(T *obj) {
    80003d18:	ff010113          	addi	sp,sp,-16
    80003d1c:	00813423          	sd	s0,8(sp)
    80003d20:	01010413          	addi	s0,sp,16
public:
    KSemaphore() = default;
    ~KSemaphore();
    void initializeSemaphore(unsigned value, ObjectPool<KSemaphore, KernelConfig::NUM_OF_SEMAPHORES_IN_POOL>* pool);
    void removeThreadFromBlockedQueue(TCB* thread);
    ObjectPool<KSemaphore, KernelConfig::NUM_OF_SEMAPHORES_IN_POOL>* getSourcePool() { return sourcePool; }
    80003d24:	0105b783          	ld	a5,16(a1)
    tempObj->nextFree = curr->headFreeObject;
    80003d28:	1407b703          	ld	a4,320(a5)
    80003d2c:	00e5bc23          	sd	a4,24(a1)
    curr->headFreeObject = tempObj;
    80003d30:	14b7b023          	sd	a1,320(a5)
}
    80003d34:	00000513          	li	a0,0
    80003d38:	00813403          	ld	s0,8(sp)
    80003d3c:	01010113          	addi	sp,sp,16
    80003d40:	00008067          	ret

0000000080003d44 <_ZN10ObjectPoolI3TCBLm20EE12findFreePoolEv>:
ObjectPool<T, numOfObjects>* ObjectPool<T, numOfObjects>::findFreePool(void)
    80003d44:	ff010113          	addi	sp,sp,-16
    80003d48:	00813423          	sd	s0,8(sp)
    80003d4c:	01010413          	addi	s0,sp,16
    80003d50:	00050793          	mv	a5,a0
    for(; !curr->nextObjectPool && !curr->headFreeObject; curr = curr->nextObjectPool);
    80003d54:	00078513          	mv	a0,a5
    80003d58:	00001737          	lui	a4,0x1
    80003d5c:	00e787b3          	add	a5,a5,a4
    80003d60:	9687b783          	ld	a5,-1688(a5)
    80003d64:	00079863          	bnez	a5,80003d74 <_ZN10ObjectPoolI3TCBLm20EE12findFreePoolEv+0x30>
    80003d68:	00e50733          	add	a4,a0,a4
    80003d6c:	96073703          	ld	a4,-1696(a4) # 960 <_entry-0x7ffff6a0>
    80003d70:	fe0702e3          	beqz	a4,80003d54 <_ZN10ObjectPoolI3TCBLm20EE12findFreePoolEv+0x10>
}
    80003d74:	00813403          	ld	s0,8(sp)
    80003d78:	01010113          	addi	sp,sp,16
    80003d7c:	00008067          	ret

0000000080003d80 <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEPPS1_>:
T* ObjectPool<T, numOfObjects>::mallocObject(ObjectPool<T, numOfObjects>** addressOfPool)
    80003d80:	fd010113          	addi	sp,sp,-48
    80003d84:	02113423          	sd	ra,40(sp)
    80003d88:	02813023          	sd	s0,32(sp)
    80003d8c:	00913c23          	sd	s1,24(sp)
    80003d90:	01213823          	sd	s2,16(sp)
    80003d94:	01313423          	sd	s3,8(sp)
    80003d98:	03010413          	addi	s0,sp,48
    80003d9c:	00058913          	mv	s2,a1
    ObjectPool<T,numOfObjects>* currentPool = findFreePool();
    80003da0:	00000097          	auipc	ra,0x0
    80003da4:	fa4080e7          	jalr	-92(ra) # 80003d44 <_ZN10ObjectPoolI3TCBLm20EE12findFreePoolEv>
    80003da8:	00050493          	mv	s1,a0
    if (currentPool->headFreeObject)
    80003dac:	000017b7          	lui	a5,0x1
    80003db0:	00f507b3          	add	a5,a0,a5
    80003db4:	9607b503          	ld	a0,-1696(a5) # 960 <_entry-0x7ffff6a0>
    80003db8:	02050a63          	beqz	a0,80003dec <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEPPS1_+0x6c>
        currentPool->headFreeObject = currentPool->headFreeObject->nextFree;
    80003dbc:	07053703          	ld	a4,112(a0)
    80003dc0:	000017b7          	lui	a5,0x1
    80003dc4:	00f487b3          	add	a5,s1,a5
    80003dc8:	96e7b023          	sd	a4,-1696(a5) # 960 <_entry-0x7ffff6a0>
        *addressOfPool = currentPool;
    80003dcc:	00993023          	sd	s1,0(s2)
}
    80003dd0:	02813083          	ld	ra,40(sp)
    80003dd4:	02013403          	ld	s0,32(sp)
    80003dd8:	01813483          	ld	s1,24(sp)
    80003ddc:	01013903          	ld	s2,16(sp)
    80003de0:	00813983          	ld	s3,8(sp)
    80003de4:	03010113          	addi	sp,sp,48
    80003de8:	00008067          	ret
        ObjectPool<T, numOfObjects>* newPool = new ObjectPool();
    80003dec:	000019b7          	lui	s3,0x1
    80003df0:	97898513          	addi	a0,s3,-1672 # 978 <_entry-0x7ffff688>
    80003df4:	00000097          	auipc	ra,0x0
    80003df8:	e28080e7          	jalr	-472(ra) # 80003c1c <_ZN10ObjectPoolI3TCBLm20EEnwEm>
    ObjectPool(): headFreeObject(pool), nextObjectPool(nullptr), prevObjectPool(nullptr)
    80003dfc:	013507b3          	add	a5,a0,s3
    80003e00:	96a7b023          	sd	a0,-1696(a5)
    80003e04:	9607b423          	sd	zero,-1688(a5)
    80003e08:	9607b823          	sd	zero,-1680(a5)
        for(size_t i = 0; i < numOfObjects - 1; i++)
    80003e0c:	00000693          	li	a3,0
    80003e10:	01200793          	li	a5,18
    80003e14:	02d7ea63          	bltu	a5,a3,80003e48 <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEPPS1_+0xc8>
            pool[i].nextFree = &(pool[i+1]);
    80003e18:	00168613          	addi	a2,a3,1
    80003e1c:	00461713          	slli	a4,a2,0x4
    80003e20:	40c70733          	sub	a4,a4,a2
    80003e24:	00371713          	slli	a4,a4,0x3
    80003e28:	00e50733          	add	a4,a0,a4
    80003e2c:	00469793          	slli	a5,a3,0x4
    80003e30:	40d787b3          	sub	a5,a5,a3
    80003e34:	00379793          	slli	a5,a5,0x3
    80003e38:	00f507b3          	add	a5,a0,a5
    80003e3c:	06e7b823          	sd	a4,112(a5)
        for(size_t i = 0; i < numOfObjects - 1; i++)
    80003e40:	00060693          	mv	a3,a2
    80003e44:	fcdff06f          	j	80003e10 <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEPPS1_+0x90>
        pool[numOfObjects - 1].nextFree = nullptr;
    80003e48:	000017b7          	lui	a5,0x1
    80003e4c:	00f507b3          	add	a5,a0,a5
    80003e50:	9407bc23          	sd	zero,-1704(a5) # 958 <_entry-0x7ffff6a8>
        if(!newPool)
    80003e54:	f6050ee3          	beqz	a0,80003dd0 <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEPPS1_+0x50>
        newPool->prevObjectPool = currentPool;
    80003e58:	00001737          	lui	a4,0x1
    80003e5c:	9697b823          	sd	s1,-1680(a5)
        currentPool->nextObjectPool = newPool;
    80003e60:	00e484b3          	add	s1,s1,a4
    80003e64:	96a4b423          	sd	a0,-1688(s1)
        PoolObject* temp = newPool->headFreeObject;
    80003e68:	9607b703          	ld	a4,-1696(a5)
        newPool->headFreeObject = newPool->headFreeObject->nextFree;
    80003e6c:	07073683          	ld	a3,112(a4) # 1070 <_entry-0x7fffef90>
    80003e70:	96d7b023          	sd	a3,-1696(a5)
        *addressOfPool = newPool;
    80003e74:	00a93023          	sd	a0,0(s2)
        return &(temp->object);
    80003e78:	00070513          	mv	a0,a4
    80003e7c:	f55ff06f          	j	80003dd0 <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEPPS1_+0x50>

0000000080003e80 <_ZN10ObjectPoolI10KSemaphoreLm10EE12findFreePoolEv>:
ObjectPool<T, numOfObjects>* ObjectPool<T, numOfObjects>::findFreePool(void)
    80003e80:	ff010113          	addi	sp,sp,-16
    80003e84:	00813423          	sd	s0,8(sp)
    80003e88:	01010413          	addi	s0,sp,16
    80003e8c:	00050793          	mv	a5,a0
    for(; !curr->nextObjectPool && !curr->headFreeObject; curr = curr->nextObjectPool);
    80003e90:	00078513          	mv	a0,a5
    80003e94:	1487b783          	ld	a5,328(a5)
    80003e98:	00079663          	bnez	a5,80003ea4 <_ZN10ObjectPoolI10KSemaphoreLm10EE12findFreePoolEv+0x24>
    80003e9c:	14053703          	ld	a4,320(a0)
    80003ea0:	fe0708e3          	beqz	a4,80003e90 <_ZN10ObjectPoolI10KSemaphoreLm10EE12findFreePoolEv+0x10>
}
    80003ea4:	00813403          	ld	s0,8(sp)
    80003ea8:	01010113          	addi	sp,sp,16
    80003eac:	00008067          	ret

0000000080003eb0 <_ZN10ObjectPoolI10KSemaphoreLm10EE12mallocObjectEPPS1_>:
T* ObjectPool<T, numOfObjects>::mallocObject(ObjectPool<T, numOfObjects>** addressOfPool)
    80003eb0:	fe010113          	addi	sp,sp,-32
    80003eb4:	00113c23          	sd	ra,24(sp)
    80003eb8:	00813823          	sd	s0,16(sp)
    80003ebc:	00913423          	sd	s1,8(sp)
    80003ec0:	01213023          	sd	s2,0(sp)
    80003ec4:	02010413          	addi	s0,sp,32
    80003ec8:	00058913          	mv	s2,a1
    ObjectPool<T,numOfObjects>* currentPool = findFreePool();
    80003ecc:	00000097          	auipc	ra,0x0
    80003ed0:	fb4080e7          	jalr	-76(ra) # 80003e80 <_ZN10ObjectPoolI10KSemaphoreLm10EE12findFreePoolEv>
    80003ed4:	00050493          	mv	s1,a0
    if (currentPool->headFreeObject)
    80003ed8:	14053503          	ld	a0,320(a0)
    80003edc:	02050463          	beqz	a0,80003f04 <_ZN10ObjectPoolI10KSemaphoreLm10EE12mallocObjectEPPS1_+0x54>
        currentPool->headFreeObject = currentPool->headFreeObject->nextFree;
    80003ee0:	01853783          	ld	a5,24(a0)
    80003ee4:	14f4b023          	sd	a5,320(s1)
        *addressOfPool = currentPool;
    80003ee8:	00993023          	sd	s1,0(s2)
}
    80003eec:	01813083          	ld	ra,24(sp)
    80003ef0:	01013403          	ld	s0,16(sp)
    80003ef4:	00813483          	ld	s1,8(sp)
    80003ef8:	00013903          	ld	s2,0(sp)
    80003efc:	02010113          	addi	sp,sp,32
    80003f00:	00008067          	ret
        ObjectPool<T, numOfObjects>* newPool = new ObjectPool();
    80003f04:	15800513          	li	a0,344
    80003f08:	00000097          	auipc	ra,0x0
    80003f0c:	d78080e7          	jalr	-648(ra) # 80003c80 <_ZN10ObjectPoolI10KSemaphoreLm10EEnwEm>
    ObjectPool(): headFreeObject(pool), nextObjectPool(nullptr), prevObjectPool(nullptr)
    80003f10:	14a53023          	sd	a0,320(a0)
    80003f14:	14053423          	sd	zero,328(a0)
    80003f18:	14053823          	sd	zero,336(a0)
        for(size_t i = 0; i < numOfObjects - 1; i++)
    80003f1c:	00000793          	li	a5,0
    80003f20:	0200006f          	j	80003f40 <_ZN10ObjectPoolI10KSemaphoreLm10EE12mallocObjectEPPS1_+0x90>
            pool[i].nextFree = &(pool[i+1]);
    80003f24:	00178693          	addi	a3,a5,1
    80003f28:	00569713          	slli	a4,a3,0x5
    80003f2c:	00e50733          	add	a4,a0,a4
    80003f30:	00579793          	slli	a5,a5,0x5
    80003f34:	00f507b3          	add	a5,a0,a5
    80003f38:	00e7bc23          	sd	a4,24(a5)
        for(size_t i = 0; i < numOfObjects - 1; i++)
    80003f3c:	00068793          	mv	a5,a3
    80003f40:	00800713          	li	a4,8
    80003f44:	fef770e3          	bgeu	a4,a5,80003f24 <_ZN10ObjectPoolI10KSemaphoreLm10EE12mallocObjectEPPS1_+0x74>
        pool[numOfObjects - 1].nextFree = nullptr;
    80003f48:	12053c23          	sd	zero,312(a0)
        if(!newPool)
    80003f4c:	fa0500e3          	beqz	a0,80003eec <_ZN10ObjectPoolI10KSemaphoreLm10EE12mallocObjectEPPS1_+0x3c>
        newPool->prevObjectPool = currentPool;
    80003f50:	14953823          	sd	s1,336(a0)
        currentPool->nextObjectPool = newPool;
    80003f54:	14a4b423          	sd	a0,328(s1)
        PoolObject* temp = newPool->headFreeObject;
    80003f58:	14053783          	ld	a5,320(a0)
        newPool->headFreeObject = newPool->headFreeObject->nextFree;
    80003f5c:	0187b703          	ld	a4,24(a5)
    80003f60:	14e53023          	sd	a4,320(a0)
        *addressOfPool = newPool;
    80003f64:	00a93023          	sd	a0,0(s2)
        return &(temp->object);
    80003f68:	00078513          	mv	a0,a5
    80003f6c:	f81ff06f          	j	80003eec <_ZN10ObjectPoolI10KSemaphoreLm10EE12mallocObjectEPPS1_+0x3c>

0000000080003f70 <start>:
    80003f70:	ff010113          	addi	sp,sp,-16
    80003f74:	00813423          	sd	s0,8(sp)
    80003f78:	01010413          	addi	s0,sp,16
    80003f7c:	300027f3          	csrr	a5,mstatus
    80003f80:	ffffe737          	lui	a4,0xffffe
    80003f84:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff4aaf>
    80003f88:	00e7f7b3          	and	a5,a5,a4
    80003f8c:	00001737          	lui	a4,0x1
    80003f90:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80003f94:	00e7e7b3          	or	a5,a5,a4
    80003f98:	30079073          	csrw	mstatus,a5
    80003f9c:	00000797          	auipc	a5,0x0
    80003fa0:	16078793          	addi	a5,a5,352 # 800040fc <system_main>
    80003fa4:	34179073          	csrw	mepc,a5
    80003fa8:	00000793          	li	a5,0
    80003fac:	18079073          	csrw	satp,a5
    80003fb0:	000107b7          	lui	a5,0x10
    80003fb4:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80003fb8:	30279073          	csrw	medeleg,a5
    80003fbc:	30379073          	csrw	mideleg,a5
    80003fc0:	104027f3          	csrr	a5,sie
    80003fc4:	2227e793          	ori	a5,a5,546
    80003fc8:	10479073          	csrw	sie,a5
    80003fcc:	fff00793          	li	a5,-1
    80003fd0:	00a7d793          	srli	a5,a5,0xa
    80003fd4:	3b079073          	csrw	pmpaddr0,a5
    80003fd8:	00f00793          	li	a5,15
    80003fdc:	3a079073          	csrw	pmpcfg0,a5
    80003fe0:	f14027f3          	csrr	a5,mhartid
    80003fe4:	0200c737          	lui	a4,0x200c
    80003fe8:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80003fec:	0007869b          	sext.w	a3,a5
    80003ff0:	00269713          	slli	a4,a3,0x2
    80003ff4:	000f4637          	lui	a2,0xf4
    80003ff8:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80003ffc:	00d70733          	add	a4,a4,a3
    80004000:	0037979b          	slliw	a5,a5,0x3
    80004004:	020046b7          	lui	a3,0x2004
    80004008:	00d787b3          	add	a5,a5,a3
    8000400c:	00c585b3          	add	a1,a1,a2
    80004010:	00371693          	slli	a3,a4,0x3
    80004014:	00005717          	auipc	a4,0x5
    80004018:	adc70713          	addi	a4,a4,-1316 # 80008af0 <timer_scratch>
    8000401c:	00b7b023          	sd	a1,0(a5)
    80004020:	00d70733          	add	a4,a4,a3
    80004024:	00f73c23          	sd	a5,24(a4)
    80004028:	02c73023          	sd	a2,32(a4)
    8000402c:	34071073          	csrw	mscratch,a4
    80004030:	00000797          	auipc	a5,0x0
    80004034:	6e078793          	addi	a5,a5,1760 # 80004710 <timervec>
    80004038:	30579073          	csrw	mtvec,a5
    8000403c:	300027f3          	csrr	a5,mstatus
    80004040:	0087e793          	ori	a5,a5,8
    80004044:	30079073          	csrw	mstatus,a5
    80004048:	304027f3          	csrr	a5,mie
    8000404c:	0807e793          	ori	a5,a5,128
    80004050:	30479073          	csrw	mie,a5
    80004054:	f14027f3          	csrr	a5,mhartid
    80004058:	0007879b          	sext.w	a5,a5
    8000405c:	00078213          	mv	tp,a5
    80004060:	30200073          	mret
    80004064:	00813403          	ld	s0,8(sp)
    80004068:	01010113          	addi	sp,sp,16
    8000406c:	00008067          	ret

0000000080004070 <timerinit>:
    80004070:	ff010113          	addi	sp,sp,-16
    80004074:	00813423          	sd	s0,8(sp)
    80004078:	01010413          	addi	s0,sp,16
    8000407c:	f14027f3          	csrr	a5,mhartid
    80004080:	0200c737          	lui	a4,0x200c
    80004084:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80004088:	0007869b          	sext.w	a3,a5
    8000408c:	00269713          	slli	a4,a3,0x2
    80004090:	000f4637          	lui	a2,0xf4
    80004094:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80004098:	00d70733          	add	a4,a4,a3
    8000409c:	0037979b          	slliw	a5,a5,0x3
    800040a0:	020046b7          	lui	a3,0x2004
    800040a4:	00d787b3          	add	a5,a5,a3
    800040a8:	00c585b3          	add	a1,a1,a2
    800040ac:	00371693          	slli	a3,a4,0x3
    800040b0:	00005717          	auipc	a4,0x5
    800040b4:	a4070713          	addi	a4,a4,-1472 # 80008af0 <timer_scratch>
    800040b8:	00b7b023          	sd	a1,0(a5)
    800040bc:	00d70733          	add	a4,a4,a3
    800040c0:	00f73c23          	sd	a5,24(a4)
    800040c4:	02c73023          	sd	a2,32(a4)
    800040c8:	34071073          	csrw	mscratch,a4
    800040cc:	00000797          	auipc	a5,0x0
    800040d0:	64478793          	addi	a5,a5,1604 # 80004710 <timervec>
    800040d4:	30579073          	csrw	mtvec,a5
    800040d8:	300027f3          	csrr	a5,mstatus
    800040dc:	0087e793          	ori	a5,a5,8
    800040e0:	30079073          	csrw	mstatus,a5
    800040e4:	304027f3          	csrr	a5,mie
    800040e8:	0807e793          	ori	a5,a5,128
    800040ec:	30479073          	csrw	mie,a5
    800040f0:	00813403          	ld	s0,8(sp)
    800040f4:	01010113          	addi	sp,sp,16
    800040f8:	00008067          	ret

00000000800040fc <system_main>:
    800040fc:	fe010113          	addi	sp,sp,-32
    80004100:	00813823          	sd	s0,16(sp)
    80004104:	00913423          	sd	s1,8(sp)
    80004108:	00113c23          	sd	ra,24(sp)
    8000410c:	02010413          	addi	s0,sp,32
    80004110:	00000097          	auipc	ra,0x0
    80004114:	0c4080e7          	jalr	196(ra) # 800041d4 <cpuid>
    80004118:	00004497          	auipc	s1,0x4
    8000411c:	70848493          	addi	s1,s1,1800 # 80008820 <started>
    80004120:	02050263          	beqz	a0,80004144 <system_main+0x48>
    80004124:	0004a783          	lw	a5,0(s1)
    80004128:	0007879b          	sext.w	a5,a5
    8000412c:	fe078ce3          	beqz	a5,80004124 <system_main+0x28>
    80004130:	0ff0000f          	fence
    80004134:	00003517          	auipc	a0,0x3
    80004138:	f1c50513          	addi	a0,a0,-228 # 80007050 <CONSOLE_STATUS+0x40>
    8000413c:	00001097          	auipc	ra,0x1
    80004140:	a70080e7          	jalr	-1424(ra) # 80004bac <panic>
    80004144:	00001097          	auipc	ra,0x1
    80004148:	9c4080e7          	jalr	-1596(ra) # 80004b08 <consoleinit>
    8000414c:	00001097          	auipc	ra,0x1
    80004150:	150080e7          	jalr	336(ra) # 8000529c <printfinit>
    80004154:	00003517          	auipc	a0,0x3
    80004158:	fdc50513          	addi	a0,a0,-36 # 80007130 <CONSOLE_STATUS+0x120>
    8000415c:	00001097          	auipc	ra,0x1
    80004160:	aac080e7          	jalr	-1364(ra) # 80004c08 <__printf>
    80004164:	00003517          	auipc	a0,0x3
    80004168:	ebc50513          	addi	a0,a0,-324 # 80007020 <CONSOLE_STATUS+0x10>
    8000416c:	00001097          	auipc	ra,0x1
    80004170:	a9c080e7          	jalr	-1380(ra) # 80004c08 <__printf>
    80004174:	00003517          	auipc	a0,0x3
    80004178:	fbc50513          	addi	a0,a0,-68 # 80007130 <CONSOLE_STATUS+0x120>
    8000417c:	00001097          	auipc	ra,0x1
    80004180:	a8c080e7          	jalr	-1396(ra) # 80004c08 <__printf>
    80004184:	00001097          	auipc	ra,0x1
    80004188:	4a4080e7          	jalr	1188(ra) # 80005628 <kinit>
    8000418c:	00000097          	auipc	ra,0x0
    80004190:	148080e7          	jalr	328(ra) # 800042d4 <trapinit>
    80004194:	00000097          	auipc	ra,0x0
    80004198:	16c080e7          	jalr	364(ra) # 80004300 <trapinithart>
    8000419c:	00000097          	auipc	ra,0x0
    800041a0:	5b4080e7          	jalr	1460(ra) # 80004750 <plicinit>
    800041a4:	00000097          	auipc	ra,0x0
    800041a8:	5d4080e7          	jalr	1492(ra) # 80004778 <plicinithart>
    800041ac:	00000097          	auipc	ra,0x0
    800041b0:	078080e7          	jalr	120(ra) # 80004224 <userinit>
    800041b4:	0ff0000f          	fence
    800041b8:	00100793          	li	a5,1
    800041bc:	00003517          	auipc	a0,0x3
    800041c0:	e7c50513          	addi	a0,a0,-388 # 80007038 <CONSOLE_STATUS+0x28>
    800041c4:	00f4a023          	sw	a5,0(s1)
    800041c8:	00001097          	auipc	ra,0x1
    800041cc:	a40080e7          	jalr	-1472(ra) # 80004c08 <__printf>
    800041d0:	0000006f          	j	800041d0 <system_main+0xd4>

00000000800041d4 <cpuid>:
    800041d4:	ff010113          	addi	sp,sp,-16
    800041d8:	00813423          	sd	s0,8(sp)
    800041dc:	01010413          	addi	s0,sp,16
    800041e0:	00020513          	mv	a0,tp
    800041e4:	00813403          	ld	s0,8(sp)
    800041e8:	0005051b          	sext.w	a0,a0
    800041ec:	01010113          	addi	sp,sp,16
    800041f0:	00008067          	ret

00000000800041f4 <mycpu>:
    800041f4:	ff010113          	addi	sp,sp,-16
    800041f8:	00813423          	sd	s0,8(sp)
    800041fc:	01010413          	addi	s0,sp,16
    80004200:	00020793          	mv	a5,tp
    80004204:	00813403          	ld	s0,8(sp)
    80004208:	0007879b          	sext.w	a5,a5
    8000420c:	00779793          	slli	a5,a5,0x7
    80004210:	00006517          	auipc	a0,0x6
    80004214:	91050513          	addi	a0,a0,-1776 # 80009b20 <cpus>
    80004218:	00f50533          	add	a0,a0,a5
    8000421c:	01010113          	addi	sp,sp,16
    80004220:	00008067          	ret

0000000080004224 <userinit>:
    80004224:	ff010113          	addi	sp,sp,-16
    80004228:	00813423          	sd	s0,8(sp)
    8000422c:	01010413          	addi	s0,sp,16
    80004230:	00813403          	ld	s0,8(sp)
    80004234:	01010113          	addi	sp,sp,16
    80004238:	ffffe317          	auipc	t1,0xffffe
    8000423c:	d4030067          	jr	-704(t1) # 80001f78 <main>

0000000080004240 <either_copyout>:
    80004240:	ff010113          	addi	sp,sp,-16
    80004244:	00813023          	sd	s0,0(sp)
    80004248:	00113423          	sd	ra,8(sp)
    8000424c:	01010413          	addi	s0,sp,16
    80004250:	02051663          	bnez	a0,8000427c <either_copyout+0x3c>
    80004254:	00058513          	mv	a0,a1
    80004258:	00060593          	mv	a1,a2
    8000425c:	0006861b          	sext.w	a2,a3
    80004260:	00002097          	auipc	ra,0x2
    80004264:	c54080e7          	jalr	-940(ra) # 80005eb4 <__memmove>
    80004268:	00813083          	ld	ra,8(sp)
    8000426c:	00013403          	ld	s0,0(sp)
    80004270:	00000513          	li	a0,0
    80004274:	01010113          	addi	sp,sp,16
    80004278:	00008067          	ret
    8000427c:	00003517          	auipc	a0,0x3
    80004280:	dfc50513          	addi	a0,a0,-516 # 80007078 <CONSOLE_STATUS+0x68>
    80004284:	00001097          	auipc	ra,0x1
    80004288:	928080e7          	jalr	-1752(ra) # 80004bac <panic>

000000008000428c <either_copyin>:
    8000428c:	ff010113          	addi	sp,sp,-16
    80004290:	00813023          	sd	s0,0(sp)
    80004294:	00113423          	sd	ra,8(sp)
    80004298:	01010413          	addi	s0,sp,16
    8000429c:	02059463          	bnez	a1,800042c4 <either_copyin+0x38>
    800042a0:	00060593          	mv	a1,a2
    800042a4:	0006861b          	sext.w	a2,a3
    800042a8:	00002097          	auipc	ra,0x2
    800042ac:	c0c080e7          	jalr	-1012(ra) # 80005eb4 <__memmove>
    800042b0:	00813083          	ld	ra,8(sp)
    800042b4:	00013403          	ld	s0,0(sp)
    800042b8:	00000513          	li	a0,0
    800042bc:	01010113          	addi	sp,sp,16
    800042c0:	00008067          	ret
    800042c4:	00003517          	auipc	a0,0x3
    800042c8:	ddc50513          	addi	a0,a0,-548 # 800070a0 <CONSOLE_STATUS+0x90>
    800042cc:	00001097          	auipc	ra,0x1
    800042d0:	8e0080e7          	jalr	-1824(ra) # 80004bac <panic>

00000000800042d4 <trapinit>:
    800042d4:	ff010113          	addi	sp,sp,-16
    800042d8:	00813423          	sd	s0,8(sp)
    800042dc:	01010413          	addi	s0,sp,16
    800042e0:	00813403          	ld	s0,8(sp)
    800042e4:	00003597          	auipc	a1,0x3
    800042e8:	de458593          	addi	a1,a1,-540 # 800070c8 <CONSOLE_STATUS+0xb8>
    800042ec:	00006517          	auipc	a0,0x6
    800042f0:	8b450513          	addi	a0,a0,-1868 # 80009ba0 <tickslock>
    800042f4:	01010113          	addi	sp,sp,16
    800042f8:	00001317          	auipc	t1,0x1
    800042fc:	5c030067          	jr	1472(t1) # 800058b8 <initlock>

0000000080004300 <trapinithart>:
    80004300:	ff010113          	addi	sp,sp,-16
    80004304:	00813423          	sd	s0,8(sp)
    80004308:	01010413          	addi	s0,sp,16
    8000430c:	00000797          	auipc	a5,0x0
    80004310:	2f478793          	addi	a5,a5,756 # 80004600 <kernelvec>
    80004314:	10579073          	csrw	stvec,a5
    80004318:	00813403          	ld	s0,8(sp)
    8000431c:	01010113          	addi	sp,sp,16
    80004320:	00008067          	ret

0000000080004324 <usertrap>:
    80004324:	ff010113          	addi	sp,sp,-16
    80004328:	00813423          	sd	s0,8(sp)
    8000432c:	01010413          	addi	s0,sp,16
    80004330:	00813403          	ld	s0,8(sp)
    80004334:	01010113          	addi	sp,sp,16
    80004338:	00008067          	ret

000000008000433c <usertrapret>:
    8000433c:	ff010113          	addi	sp,sp,-16
    80004340:	00813423          	sd	s0,8(sp)
    80004344:	01010413          	addi	s0,sp,16
    80004348:	00813403          	ld	s0,8(sp)
    8000434c:	01010113          	addi	sp,sp,16
    80004350:	00008067          	ret

0000000080004354 <kerneltrap>:
    80004354:	fe010113          	addi	sp,sp,-32
    80004358:	00813823          	sd	s0,16(sp)
    8000435c:	00113c23          	sd	ra,24(sp)
    80004360:	00913423          	sd	s1,8(sp)
    80004364:	02010413          	addi	s0,sp,32
    80004368:	142025f3          	csrr	a1,scause
    8000436c:	100027f3          	csrr	a5,sstatus
    80004370:	0027f793          	andi	a5,a5,2
    80004374:	10079c63          	bnez	a5,8000448c <kerneltrap+0x138>
    80004378:	142027f3          	csrr	a5,scause
    8000437c:	0207ce63          	bltz	a5,800043b8 <kerneltrap+0x64>
    80004380:	00003517          	auipc	a0,0x3
    80004384:	d9050513          	addi	a0,a0,-624 # 80007110 <CONSOLE_STATUS+0x100>
    80004388:	00001097          	auipc	ra,0x1
    8000438c:	880080e7          	jalr	-1920(ra) # 80004c08 <__printf>
    80004390:	141025f3          	csrr	a1,sepc
    80004394:	14302673          	csrr	a2,stval
    80004398:	00003517          	auipc	a0,0x3
    8000439c:	d8850513          	addi	a0,a0,-632 # 80007120 <CONSOLE_STATUS+0x110>
    800043a0:	00001097          	auipc	ra,0x1
    800043a4:	868080e7          	jalr	-1944(ra) # 80004c08 <__printf>
    800043a8:	00003517          	auipc	a0,0x3
    800043ac:	d9050513          	addi	a0,a0,-624 # 80007138 <CONSOLE_STATUS+0x128>
    800043b0:	00000097          	auipc	ra,0x0
    800043b4:	7fc080e7          	jalr	2044(ra) # 80004bac <panic>
    800043b8:	0ff7f713          	andi	a4,a5,255
    800043bc:	00900693          	li	a3,9
    800043c0:	04d70063          	beq	a4,a3,80004400 <kerneltrap+0xac>
    800043c4:	fff00713          	li	a4,-1
    800043c8:	03f71713          	slli	a4,a4,0x3f
    800043cc:	00170713          	addi	a4,a4,1
    800043d0:	fae798e3          	bne	a5,a4,80004380 <kerneltrap+0x2c>
    800043d4:	00000097          	auipc	ra,0x0
    800043d8:	e00080e7          	jalr	-512(ra) # 800041d4 <cpuid>
    800043dc:	06050663          	beqz	a0,80004448 <kerneltrap+0xf4>
    800043e0:	144027f3          	csrr	a5,sip
    800043e4:	ffd7f793          	andi	a5,a5,-3
    800043e8:	14479073          	csrw	sip,a5
    800043ec:	01813083          	ld	ra,24(sp)
    800043f0:	01013403          	ld	s0,16(sp)
    800043f4:	00813483          	ld	s1,8(sp)
    800043f8:	02010113          	addi	sp,sp,32
    800043fc:	00008067          	ret
    80004400:	00000097          	auipc	ra,0x0
    80004404:	3c4080e7          	jalr	964(ra) # 800047c4 <plic_claim>
    80004408:	00a00793          	li	a5,10
    8000440c:	00050493          	mv	s1,a0
    80004410:	06f50863          	beq	a0,a5,80004480 <kerneltrap+0x12c>
    80004414:	fc050ce3          	beqz	a0,800043ec <kerneltrap+0x98>
    80004418:	00050593          	mv	a1,a0
    8000441c:	00003517          	auipc	a0,0x3
    80004420:	cd450513          	addi	a0,a0,-812 # 800070f0 <CONSOLE_STATUS+0xe0>
    80004424:	00000097          	auipc	ra,0x0
    80004428:	7e4080e7          	jalr	2020(ra) # 80004c08 <__printf>
    8000442c:	01013403          	ld	s0,16(sp)
    80004430:	01813083          	ld	ra,24(sp)
    80004434:	00048513          	mv	a0,s1
    80004438:	00813483          	ld	s1,8(sp)
    8000443c:	02010113          	addi	sp,sp,32
    80004440:	00000317          	auipc	t1,0x0
    80004444:	3bc30067          	jr	956(t1) # 800047fc <plic_complete>
    80004448:	00005517          	auipc	a0,0x5
    8000444c:	75850513          	addi	a0,a0,1880 # 80009ba0 <tickslock>
    80004450:	00001097          	auipc	ra,0x1
    80004454:	48c080e7          	jalr	1164(ra) # 800058dc <acquire>
    80004458:	00004717          	auipc	a4,0x4
    8000445c:	3cc70713          	addi	a4,a4,972 # 80008824 <ticks>
    80004460:	00072783          	lw	a5,0(a4)
    80004464:	00005517          	auipc	a0,0x5
    80004468:	73c50513          	addi	a0,a0,1852 # 80009ba0 <tickslock>
    8000446c:	0017879b          	addiw	a5,a5,1
    80004470:	00f72023          	sw	a5,0(a4)
    80004474:	00001097          	auipc	ra,0x1
    80004478:	534080e7          	jalr	1332(ra) # 800059a8 <release>
    8000447c:	f65ff06f          	j	800043e0 <kerneltrap+0x8c>
    80004480:	00001097          	auipc	ra,0x1
    80004484:	090080e7          	jalr	144(ra) # 80005510 <uartintr>
    80004488:	fa5ff06f          	j	8000442c <kerneltrap+0xd8>
    8000448c:	00003517          	auipc	a0,0x3
    80004490:	c4450513          	addi	a0,a0,-956 # 800070d0 <CONSOLE_STATUS+0xc0>
    80004494:	00000097          	auipc	ra,0x0
    80004498:	718080e7          	jalr	1816(ra) # 80004bac <panic>

000000008000449c <clockintr>:
    8000449c:	fe010113          	addi	sp,sp,-32
    800044a0:	00813823          	sd	s0,16(sp)
    800044a4:	00913423          	sd	s1,8(sp)
    800044a8:	00113c23          	sd	ra,24(sp)
    800044ac:	02010413          	addi	s0,sp,32
    800044b0:	00005497          	auipc	s1,0x5
    800044b4:	6f048493          	addi	s1,s1,1776 # 80009ba0 <tickslock>
    800044b8:	00048513          	mv	a0,s1
    800044bc:	00001097          	auipc	ra,0x1
    800044c0:	420080e7          	jalr	1056(ra) # 800058dc <acquire>
    800044c4:	00004717          	auipc	a4,0x4
    800044c8:	36070713          	addi	a4,a4,864 # 80008824 <ticks>
    800044cc:	00072783          	lw	a5,0(a4)
    800044d0:	01013403          	ld	s0,16(sp)
    800044d4:	01813083          	ld	ra,24(sp)
    800044d8:	00048513          	mv	a0,s1
    800044dc:	0017879b          	addiw	a5,a5,1
    800044e0:	00813483          	ld	s1,8(sp)
    800044e4:	00f72023          	sw	a5,0(a4)
    800044e8:	02010113          	addi	sp,sp,32
    800044ec:	00001317          	auipc	t1,0x1
    800044f0:	4bc30067          	jr	1212(t1) # 800059a8 <release>

00000000800044f4 <devintr>:
    800044f4:	142027f3          	csrr	a5,scause
    800044f8:	00000513          	li	a0,0
    800044fc:	0007c463          	bltz	a5,80004504 <devintr+0x10>
    80004500:	00008067          	ret
    80004504:	fe010113          	addi	sp,sp,-32
    80004508:	00813823          	sd	s0,16(sp)
    8000450c:	00113c23          	sd	ra,24(sp)
    80004510:	00913423          	sd	s1,8(sp)
    80004514:	02010413          	addi	s0,sp,32
    80004518:	0ff7f713          	andi	a4,a5,255
    8000451c:	00900693          	li	a3,9
    80004520:	04d70c63          	beq	a4,a3,80004578 <devintr+0x84>
    80004524:	fff00713          	li	a4,-1
    80004528:	03f71713          	slli	a4,a4,0x3f
    8000452c:	00170713          	addi	a4,a4,1
    80004530:	00e78c63          	beq	a5,a4,80004548 <devintr+0x54>
    80004534:	01813083          	ld	ra,24(sp)
    80004538:	01013403          	ld	s0,16(sp)
    8000453c:	00813483          	ld	s1,8(sp)
    80004540:	02010113          	addi	sp,sp,32
    80004544:	00008067          	ret
    80004548:	00000097          	auipc	ra,0x0
    8000454c:	c8c080e7          	jalr	-884(ra) # 800041d4 <cpuid>
    80004550:	06050663          	beqz	a0,800045bc <devintr+0xc8>
    80004554:	144027f3          	csrr	a5,sip
    80004558:	ffd7f793          	andi	a5,a5,-3
    8000455c:	14479073          	csrw	sip,a5
    80004560:	01813083          	ld	ra,24(sp)
    80004564:	01013403          	ld	s0,16(sp)
    80004568:	00813483          	ld	s1,8(sp)
    8000456c:	00200513          	li	a0,2
    80004570:	02010113          	addi	sp,sp,32
    80004574:	00008067          	ret
    80004578:	00000097          	auipc	ra,0x0
    8000457c:	24c080e7          	jalr	588(ra) # 800047c4 <plic_claim>
    80004580:	00a00793          	li	a5,10
    80004584:	00050493          	mv	s1,a0
    80004588:	06f50663          	beq	a0,a5,800045f4 <devintr+0x100>
    8000458c:	00100513          	li	a0,1
    80004590:	fa0482e3          	beqz	s1,80004534 <devintr+0x40>
    80004594:	00048593          	mv	a1,s1
    80004598:	00003517          	auipc	a0,0x3
    8000459c:	b5850513          	addi	a0,a0,-1192 # 800070f0 <CONSOLE_STATUS+0xe0>
    800045a0:	00000097          	auipc	ra,0x0
    800045a4:	668080e7          	jalr	1640(ra) # 80004c08 <__printf>
    800045a8:	00048513          	mv	a0,s1
    800045ac:	00000097          	auipc	ra,0x0
    800045b0:	250080e7          	jalr	592(ra) # 800047fc <plic_complete>
    800045b4:	00100513          	li	a0,1
    800045b8:	f7dff06f          	j	80004534 <devintr+0x40>
    800045bc:	00005517          	auipc	a0,0x5
    800045c0:	5e450513          	addi	a0,a0,1508 # 80009ba0 <tickslock>
    800045c4:	00001097          	auipc	ra,0x1
    800045c8:	318080e7          	jalr	792(ra) # 800058dc <acquire>
    800045cc:	00004717          	auipc	a4,0x4
    800045d0:	25870713          	addi	a4,a4,600 # 80008824 <ticks>
    800045d4:	00072783          	lw	a5,0(a4)
    800045d8:	00005517          	auipc	a0,0x5
    800045dc:	5c850513          	addi	a0,a0,1480 # 80009ba0 <tickslock>
    800045e0:	0017879b          	addiw	a5,a5,1
    800045e4:	00f72023          	sw	a5,0(a4)
    800045e8:	00001097          	auipc	ra,0x1
    800045ec:	3c0080e7          	jalr	960(ra) # 800059a8 <release>
    800045f0:	f65ff06f          	j	80004554 <devintr+0x60>
    800045f4:	00001097          	auipc	ra,0x1
    800045f8:	f1c080e7          	jalr	-228(ra) # 80005510 <uartintr>
    800045fc:	fadff06f          	j	800045a8 <devintr+0xb4>

0000000080004600 <kernelvec>:
    80004600:	f0010113          	addi	sp,sp,-256
    80004604:	00113023          	sd	ra,0(sp)
    80004608:	00213423          	sd	sp,8(sp)
    8000460c:	00313823          	sd	gp,16(sp)
    80004610:	00413c23          	sd	tp,24(sp)
    80004614:	02513023          	sd	t0,32(sp)
    80004618:	02613423          	sd	t1,40(sp)
    8000461c:	02713823          	sd	t2,48(sp)
    80004620:	02813c23          	sd	s0,56(sp)
    80004624:	04913023          	sd	s1,64(sp)
    80004628:	04a13423          	sd	a0,72(sp)
    8000462c:	04b13823          	sd	a1,80(sp)
    80004630:	04c13c23          	sd	a2,88(sp)
    80004634:	06d13023          	sd	a3,96(sp)
    80004638:	06e13423          	sd	a4,104(sp)
    8000463c:	06f13823          	sd	a5,112(sp)
    80004640:	07013c23          	sd	a6,120(sp)
    80004644:	09113023          	sd	a7,128(sp)
    80004648:	09213423          	sd	s2,136(sp)
    8000464c:	09313823          	sd	s3,144(sp)
    80004650:	09413c23          	sd	s4,152(sp)
    80004654:	0b513023          	sd	s5,160(sp)
    80004658:	0b613423          	sd	s6,168(sp)
    8000465c:	0b713823          	sd	s7,176(sp)
    80004660:	0b813c23          	sd	s8,184(sp)
    80004664:	0d913023          	sd	s9,192(sp)
    80004668:	0da13423          	sd	s10,200(sp)
    8000466c:	0db13823          	sd	s11,208(sp)
    80004670:	0dc13c23          	sd	t3,216(sp)
    80004674:	0fd13023          	sd	t4,224(sp)
    80004678:	0fe13423          	sd	t5,232(sp)
    8000467c:	0ff13823          	sd	t6,240(sp)
    80004680:	cd5ff0ef          	jal	ra,80004354 <kerneltrap>
    80004684:	00013083          	ld	ra,0(sp)
    80004688:	00813103          	ld	sp,8(sp)
    8000468c:	01013183          	ld	gp,16(sp)
    80004690:	02013283          	ld	t0,32(sp)
    80004694:	02813303          	ld	t1,40(sp)
    80004698:	03013383          	ld	t2,48(sp)
    8000469c:	03813403          	ld	s0,56(sp)
    800046a0:	04013483          	ld	s1,64(sp)
    800046a4:	04813503          	ld	a0,72(sp)
    800046a8:	05013583          	ld	a1,80(sp)
    800046ac:	05813603          	ld	a2,88(sp)
    800046b0:	06013683          	ld	a3,96(sp)
    800046b4:	06813703          	ld	a4,104(sp)
    800046b8:	07013783          	ld	a5,112(sp)
    800046bc:	07813803          	ld	a6,120(sp)
    800046c0:	08013883          	ld	a7,128(sp)
    800046c4:	08813903          	ld	s2,136(sp)
    800046c8:	09013983          	ld	s3,144(sp)
    800046cc:	09813a03          	ld	s4,152(sp)
    800046d0:	0a013a83          	ld	s5,160(sp)
    800046d4:	0a813b03          	ld	s6,168(sp)
    800046d8:	0b013b83          	ld	s7,176(sp)
    800046dc:	0b813c03          	ld	s8,184(sp)
    800046e0:	0c013c83          	ld	s9,192(sp)
    800046e4:	0c813d03          	ld	s10,200(sp)
    800046e8:	0d013d83          	ld	s11,208(sp)
    800046ec:	0d813e03          	ld	t3,216(sp)
    800046f0:	0e013e83          	ld	t4,224(sp)
    800046f4:	0e813f03          	ld	t5,232(sp)
    800046f8:	0f013f83          	ld	t6,240(sp)
    800046fc:	10010113          	addi	sp,sp,256
    80004700:	10200073          	sret
    80004704:	00000013          	nop
    80004708:	00000013          	nop
    8000470c:	00000013          	nop

0000000080004710 <timervec>:
    80004710:	34051573          	csrrw	a0,mscratch,a0
    80004714:	00b53023          	sd	a1,0(a0)
    80004718:	00c53423          	sd	a2,8(a0)
    8000471c:	00d53823          	sd	a3,16(a0)
    80004720:	01853583          	ld	a1,24(a0)
    80004724:	02053603          	ld	a2,32(a0)
    80004728:	0005b683          	ld	a3,0(a1)
    8000472c:	00c686b3          	add	a3,a3,a2
    80004730:	00d5b023          	sd	a3,0(a1)
    80004734:	00200593          	li	a1,2
    80004738:	14459073          	csrw	sip,a1
    8000473c:	01053683          	ld	a3,16(a0)
    80004740:	00853603          	ld	a2,8(a0)
    80004744:	00053583          	ld	a1,0(a0)
    80004748:	34051573          	csrrw	a0,mscratch,a0
    8000474c:	30200073          	mret

0000000080004750 <plicinit>:
    80004750:	ff010113          	addi	sp,sp,-16
    80004754:	00813423          	sd	s0,8(sp)
    80004758:	01010413          	addi	s0,sp,16
    8000475c:	00813403          	ld	s0,8(sp)
    80004760:	0c0007b7          	lui	a5,0xc000
    80004764:	00100713          	li	a4,1
    80004768:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    8000476c:	00e7a223          	sw	a4,4(a5)
    80004770:	01010113          	addi	sp,sp,16
    80004774:	00008067          	ret

0000000080004778 <plicinithart>:
    80004778:	ff010113          	addi	sp,sp,-16
    8000477c:	00813023          	sd	s0,0(sp)
    80004780:	00113423          	sd	ra,8(sp)
    80004784:	01010413          	addi	s0,sp,16
    80004788:	00000097          	auipc	ra,0x0
    8000478c:	a4c080e7          	jalr	-1460(ra) # 800041d4 <cpuid>
    80004790:	0085171b          	slliw	a4,a0,0x8
    80004794:	0c0027b7          	lui	a5,0xc002
    80004798:	00e787b3          	add	a5,a5,a4
    8000479c:	40200713          	li	a4,1026
    800047a0:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    800047a4:	00813083          	ld	ra,8(sp)
    800047a8:	00013403          	ld	s0,0(sp)
    800047ac:	00d5151b          	slliw	a0,a0,0xd
    800047b0:	0c2017b7          	lui	a5,0xc201
    800047b4:	00a78533          	add	a0,a5,a0
    800047b8:	00052023          	sw	zero,0(a0)
    800047bc:	01010113          	addi	sp,sp,16
    800047c0:	00008067          	ret

00000000800047c4 <plic_claim>:
    800047c4:	ff010113          	addi	sp,sp,-16
    800047c8:	00813023          	sd	s0,0(sp)
    800047cc:	00113423          	sd	ra,8(sp)
    800047d0:	01010413          	addi	s0,sp,16
    800047d4:	00000097          	auipc	ra,0x0
    800047d8:	a00080e7          	jalr	-1536(ra) # 800041d4 <cpuid>
    800047dc:	00813083          	ld	ra,8(sp)
    800047e0:	00013403          	ld	s0,0(sp)
    800047e4:	00d5151b          	slliw	a0,a0,0xd
    800047e8:	0c2017b7          	lui	a5,0xc201
    800047ec:	00a78533          	add	a0,a5,a0
    800047f0:	00452503          	lw	a0,4(a0)
    800047f4:	01010113          	addi	sp,sp,16
    800047f8:	00008067          	ret

00000000800047fc <plic_complete>:
    800047fc:	fe010113          	addi	sp,sp,-32
    80004800:	00813823          	sd	s0,16(sp)
    80004804:	00913423          	sd	s1,8(sp)
    80004808:	00113c23          	sd	ra,24(sp)
    8000480c:	02010413          	addi	s0,sp,32
    80004810:	00050493          	mv	s1,a0
    80004814:	00000097          	auipc	ra,0x0
    80004818:	9c0080e7          	jalr	-1600(ra) # 800041d4 <cpuid>
    8000481c:	01813083          	ld	ra,24(sp)
    80004820:	01013403          	ld	s0,16(sp)
    80004824:	00d5179b          	slliw	a5,a0,0xd
    80004828:	0c201737          	lui	a4,0xc201
    8000482c:	00f707b3          	add	a5,a4,a5
    80004830:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80004834:	00813483          	ld	s1,8(sp)
    80004838:	02010113          	addi	sp,sp,32
    8000483c:	00008067          	ret

0000000080004840 <consolewrite>:
    80004840:	fb010113          	addi	sp,sp,-80
    80004844:	04813023          	sd	s0,64(sp)
    80004848:	04113423          	sd	ra,72(sp)
    8000484c:	02913c23          	sd	s1,56(sp)
    80004850:	03213823          	sd	s2,48(sp)
    80004854:	03313423          	sd	s3,40(sp)
    80004858:	03413023          	sd	s4,32(sp)
    8000485c:	01513c23          	sd	s5,24(sp)
    80004860:	05010413          	addi	s0,sp,80
    80004864:	06c05c63          	blez	a2,800048dc <consolewrite+0x9c>
    80004868:	00060993          	mv	s3,a2
    8000486c:	00050a13          	mv	s4,a0
    80004870:	00058493          	mv	s1,a1
    80004874:	00000913          	li	s2,0
    80004878:	fff00a93          	li	s5,-1
    8000487c:	01c0006f          	j	80004898 <consolewrite+0x58>
    80004880:	fbf44503          	lbu	a0,-65(s0)
    80004884:	0019091b          	addiw	s2,s2,1
    80004888:	00148493          	addi	s1,s1,1
    8000488c:	00001097          	auipc	ra,0x1
    80004890:	a9c080e7          	jalr	-1380(ra) # 80005328 <uartputc>
    80004894:	03298063          	beq	s3,s2,800048b4 <consolewrite+0x74>
    80004898:	00048613          	mv	a2,s1
    8000489c:	00100693          	li	a3,1
    800048a0:	000a0593          	mv	a1,s4
    800048a4:	fbf40513          	addi	a0,s0,-65
    800048a8:	00000097          	auipc	ra,0x0
    800048ac:	9e4080e7          	jalr	-1564(ra) # 8000428c <either_copyin>
    800048b0:	fd5518e3          	bne	a0,s5,80004880 <consolewrite+0x40>
    800048b4:	04813083          	ld	ra,72(sp)
    800048b8:	04013403          	ld	s0,64(sp)
    800048bc:	03813483          	ld	s1,56(sp)
    800048c0:	02813983          	ld	s3,40(sp)
    800048c4:	02013a03          	ld	s4,32(sp)
    800048c8:	01813a83          	ld	s5,24(sp)
    800048cc:	00090513          	mv	a0,s2
    800048d0:	03013903          	ld	s2,48(sp)
    800048d4:	05010113          	addi	sp,sp,80
    800048d8:	00008067          	ret
    800048dc:	00000913          	li	s2,0
    800048e0:	fd5ff06f          	j	800048b4 <consolewrite+0x74>

00000000800048e4 <consoleread>:
    800048e4:	f9010113          	addi	sp,sp,-112
    800048e8:	06813023          	sd	s0,96(sp)
    800048ec:	04913c23          	sd	s1,88(sp)
    800048f0:	05213823          	sd	s2,80(sp)
    800048f4:	05313423          	sd	s3,72(sp)
    800048f8:	05413023          	sd	s4,64(sp)
    800048fc:	03513c23          	sd	s5,56(sp)
    80004900:	03613823          	sd	s6,48(sp)
    80004904:	03713423          	sd	s7,40(sp)
    80004908:	03813023          	sd	s8,32(sp)
    8000490c:	06113423          	sd	ra,104(sp)
    80004910:	01913c23          	sd	s9,24(sp)
    80004914:	07010413          	addi	s0,sp,112
    80004918:	00060b93          	mv	s7,a2
    8000491c:	00050913          	mv	s2,a0
    80004920:	00058c13          	mv	s8,a1
    80004924:	00060b1b          	sext.w	s6,a2
    80004928:	00005497          	auipc	s1,0x5
    8000492c:	2a048493          	addi	s1,s1,672 # 80009bc8 <cons>
    80004930:	00400993          	li	s3,4
    80004934:	fff00a13          	li	s4,-1
    80004938:	00a00a93          	li	s5,10
    8000493c:	05705e63          	blez	s7,80004998 <consoleread+0xb4>
    80004940:	09c4a703          	lw	a4,156(s1)
    80004944:	0984a783          	lw	a5,152(s1)
    80004948:	0007071b          	sext.w	a4,a4
    8000494c:	08e78463          	beq	a5,a4,800049d4 <consoleread+0xf0>
    80004950:	07f7f713          	andi	a4,a5,127
    80004954:	00e48733          	add	a4,s1,a4
    80004958:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    8000495c:	0017869b          	addiw	a3,a5,1
    80004960:	08d4ac23          	sw	a3,152(s1)
    80004964:	00070c9b          	sext.w	s9,a4
    80004968:	0b370663          	beq	a4,s3,80004a14 <consoleread+0x130>
    8000496c:	00100693          	li	a3,1
    80004970:	f9f40613          	addi	a2,s0,-97
    80004974:	000c0593          	mv	a1,s8
    80004978:	00090513          	mv	a0,s2
    8000497c:	f8e40fa3          	sb	a4,-97(s0)
    80004980:	00000097          	auipc	ra,0x0
    80004984:	8c0080e7          	jalr	-1856(ra) # 80004240 <either_copyout>
    80004988:	01450863          	beq	a0,s4,80004998 <consoleread+0xb4>
    8000498c:	001c0c13          	addi	s8,s8,1
    80004990:	fffb8b9b          	addiw	s7,s7,-1
    80004994:	fb5c94e3          	bne	s9,s5,8000493c <consoleread+0x58>
    80004998:	000b851b          	sext.w	a0,s7
    8000499c:	06813083          	ld	ra,104(sp)
    800049a0:	06013403          	ld	s0,96(sp)
    800049a4:	05813483          	ld	s1,88(sp)
    800049a8:	05013903          	ld	s2,80(sp)
    800049ac:	04813983          	ld	s3,72(sp)
    800049b0:	04013a03          	ld	s4,64(sp)
    800049b4:	03813a83          	ld	s5,56(sp)
    800049b8:	02813b83          	ld	s7,40(sp)
    800049bc:	02013c03          	ld	s8,32(sp)
    800049c0:	01813c83          	ld	s9,24(sp)
    800049c4:	40ab053b          	subw	a0,s6,a0
    800049c8:	03013b03          	ld	s6,48(sp)
    800049cc:	07010113          	addi	sp,sp,112
    800049d0:	00008067          	ret
    800049d4:	00001097          	auipc	ra,0x1
    800049d8:	1d8080e7          	jalr	472(ra) # 80005bac <push_on>
    800049dc:	0984a703          	lw	a4,152(s1)
    800049e0:	09c4a783          	lw	a5,156(s1)
    800049e4:	0007879b          	sext.w	a5,a5
    800049e8:	fef70ce3          	beq	a4,a5,800049e0 <consoleread+0xfc>
    800049ec:	00001097          	auipc	ra,0x1
    800049f0:	234080e7          	jalr	564(ra) # 80005c20 <pop_on>
    800049f4:	0984a783          	lw	a5,152(s1)
    800049f8:	07f7f713          	andi	a4,a5,127
    800049fc:	00e48733          	add	a4,s1,a4
    80004a00:	01874703          	lbu	a4,24(a4)
    80004a04:	0017869b          	addiw	a3,a5,1
    80004a08:	08d4ac23          	sw	a3,152(s1)
    80004a0c:	00070c9b          	sext.w	s9,a4
    80004a10:	f5371ee3          	bne	a4,s3,8000496c <consoleread+0x88>
    80004a14:	000b851b          	sext.w	a0,s7
    80004a18:	f96bf2e3          	bgeu	s7,s6,8000499c <consoleread+0xb8>
    80004a1c:	08f4ac23          	sw	a5,152(s1)
    80004a20:	f7dff06f          	j	8000499c <consoleread+0xb8>

0000000080004a24 <consputc>:
    80004a24:	10000793          	li	a5,256
    80004a28:	00f50663          	beq	a0,a5,80004a34 <consputc+0x10>
    80004a2c:	00001317          	auipc	t1,0x1
    80004a30:	9f430067          	jr	-1548(t1) # 80005420 <uartputc_sync>
    80004a34:	ff010113          	addi	sp,sp,-16
    80004a38:	00113423          	sd	ra,8(sp)
    80004a3c:	00813023          	sd	s0,0(sp)
    80004a40:	01010413          	addi	s0,sp,16
    80004a44:	00800513          	li	a0,8
    80004a48:	00001097          	auipc	ra,0x1
    80004a4c:	9d8080e7          	jalr	-1576(ra) # 80005420 <uartputc_sync>
    80004a50:	02000513          	li	a0,32
    80004a54:	00001097          	auipc	ra,0x1
    80004a58:	9cc080e7          	jalr	-1588(ra) # 80005420 <uartputc_sync>
    80004a5c:	00013403          	ld	s0,0(sp)
    80004a60:	00813083          	ld	ra,8(sp)
    80004a64:	00800513          	li	a0,8
    80004a68:	01010113          	addi	sp,sp,16
    80004a6c:	00001317          	auipc	t1,0x1
    80004a70:	9b430067          	jr	-1612(t1) # 80005420 <uartputc_sync>

0000000080004a74 <consoleintr>:
    80004a74:	fe010113          	addi	sp,sp,-32
    80004a78:	00813823          	sd	s0,16(sp)
    80004a7c:	00913423          	sd	s1,8(sp)
    80004a80:	01213023          	sd	s2,0(sp)
    80004a84:	00113c23          	sd	ra,24(sp)
    80004a88:	02010413          	addi	s0,sp,32
    80004a8c:	00005917          	auipc	s2,0x5
    80004a90:	13c90913          	addi	s2,s2,316 # 80009bc8 <cons>
    80004a94:	00050493          	mv	s1,a0
    80004a98:	00090513          	mv	a0,s2
    80004a9c:	00001097          	auipc	ra,0x1
    80004aa0:	e40080e7          	jalr	-448(ra) # 800058dc <acquire>
    80004aa4:	02048c63          	beqz	s1,80004adc <consoleintr+0x68>
    80004aa8:	0a092783          	lw	a5,160(s2)
    80004aac:	09892703          	lw	a4,152(s2)
    80004ab0:	07f00693          	li	a3,127
    80004ab4:	40e7873b          	subw	a4,a5,a4
    80004ab8:	02e6e263          	bltu	a3,a4,80004adc <consoleintr+0x68>
    80004abc:	00d00713          	li	a4,13
    80004ac0:	04e48063          	beq	s1,a4,80004b00 <consoleintr+0x8c>
    80004ac4:	07f7f713          	andi	a4,a5,127
    80004ac8:	00e90733          	add	a4,s2,a4
    80004acc:	0017879b          	addiw	a5,a5,1
    80004ad0:	0af92023          	sw	a5,160(s2)
    80004ad4:	00970c23          	sb	s1,24(a4)
    80004ad8:	08f92e23          	sw	a5,156(s2)
    80004adc:	01013403          	ld	s0,16(sp)
    80004ae0:	01813083          	ld	ra,24(sp)
    80004ae4:	00813483          	ld	s1,8(sp)
    80004ae8:	00013903          	ld	s2,0(sp)
    80004aec:	00005517          	auipc	a0,0x5
    80004af0:	0dc50513          	addi	a0,a0,220 # 80009bc8 <cons>
    80004af4:	02010113          	addi	sp,sp,32
    80004af8:	00001317          	auipc	t1,0x1
    80004afc:	eb030067          	jr	-336(t1) # 800059a8 <release>
    80004b00:	00a00493          	li	s1,10
    80004b04:	fc1ff06f          	j	80004ac4 <consoleintr+0x50>

0000000080004b08 <consoleinit>:
    80004b08:	fe010113          	addi	sp,sp,-32
    80004b0c:	00113c23          	sd	ra,24(sp)
    80004b10:	00813823          	sd	s0,16(sp)
    80004b14:	00913423          	sd	s1,8(sp)
    80004b18:	02010413          	addi	s0,sp,32
    80004b1c:	00005497          	auipc	s1,0x5
    80004b20:	0ac48493          	addi	s1,s1,172 # 80009bc8 <cons>
    80004b24:	00048513          	mv	a0,s1
    80004b28:	00002597          	auipc	a1,0x2
    80004b2c:	62058593          	addi	a1,a1,1568 # 80007148 <CONSOLE_STATUS+0x138>
    80004b30:	00001097          	auipc	ra,0x1
    80004b34:	d88080e7          	jalr	-632(ra) # 800058b8 <initlock>
    80004b38:	00000097          	auipc	ra,0x0
    80004b3c:	7ac080e7          	jalr	1964(ra) # 800052e4 <uartinit>
    80004b40:	01813083          	ld	ra,24(sp)
    80004b44:	01013403          	ld	s0,16(sp)
    80004b48:	00000797          	auipc	a5,0x0
    80004b4c:	d9c78793          	addi	a5,a5,-612 # 800048e4 <consoleread>
    80004b50:	0af4bc23          	sd	a5,184(s1)
    80004b54:	00000797          	auipc	a5,0x0
    80004b58:	cec78793          	addi	a5,a5,-788 # 80004840 <consolewrite>
    80004b5c:	0cf4b023          	sd	a5,192(s1)
    80004b60:	00813483          	ld	s1,8(sp)
    80004b64:	02010113          	addi	sp,sp,32
    80004b68:	00008067          	ret

0000000080004b6c <console_read>:
    80004b6c:	ff010113          	addi	sp,sp,-16
    80004b70:	00813423          	sd	s0,8(sp)
    80004b74:	01010413          	addi	s0,sp,16
    80004b78:	00813403          	ld	s0,8(sp)
    80004b7c:	00005317          	auipc	t1,0x5
    80004b80:	10433303          	ld	t1,260(t1) # 80009c80 <devsw+0x10>
    80004b84:	01010113          	addi	sp,sp,16
    80004b88:	00030067          	jr	t1

0000000080004b8c <console_write>:
    80004b8c:	ff010113          	addi	sp,sp,-16
    80004b90:	00813423          	sd	s0,8(sp)
    80004b94:	01010413          	addi	s0,sp,16
    80004b98:	00813403          	ld	s0,8(sp)
    80004b9c:	00005317          	auipc	t1,0x5
    80004ba0:	0ec33303          	ld	t1,236(t1) # 80009c88 <devsw+0x18>
    80004ba4:	01010113          	addi	sp,sp,16
    80004ba8:	00030067          	jr	t1

0000000080004bac <panic>:
    80004bac:	fe010113          	addi	sp,sp,-32
    80004bb0:	00113c23          	sd	ra,24(sp)
    80004bb4:	00813823          	sd	s0,16(sp)
    80004bb8:	00913423          	sd	s1,8(sp)
    80004bbc:	02010413          	addi	s0,sp,32
    80004bc0:	00050493          	mv	s1,a0
    80004bc4:	00002517          	auipc	a0,0x2
    80004bc8:	58c50513          	addi	a0,a0,1420 # 80007150 <CONSOLE_STATUS+0x140>
    80004bcc:	00005797          	auipc	a5,0x5
    80004bd0:	1407ae23          	sw	zero,348(a5) # 80009d28 <pr+0x18>
    80004bd4:	00000097          	auipc	ra,0x0
    80004bd8:	034080e7          	jalr	52(ra) # 80004c08 <__printf>
    80004bdc:	00048513          	mv	a0,s1
    80004be0:	00000097          	auipc	ra,0x0
    80004be4:	028080e7          	jalr	40(ra) # 80004c08 <__printf>
    80004be8:	00002517          	auipc	a0,0x2
    80004bec:	54850513          	addi	a0,a0,1352 # 80007130 <CONSOLE_STATUS+0x120>
    80004bf0:	00000097          	auipc	ra,0x0
    80004bf4:	018080e7          	jalr	24(ra) # 80004c08 <__printf>
    80004bf8:	00100793          	li	a5,1
    80004bfc:	00004717          	auipc	a4,0x4
    80004c00:	c2f72623          	sw	a5,-980(a4) # 80008828 <panicked>
    80004c04:	0000006f          	j	80004c04 <panic+0x58>

0000000080004c08 <__printf>:
    80004c08:	f3010113          	addi	sp,sp,-208
    80004c0c:	08813023          	sd	s0,128(sp)
    80004c10:	07313423          	sd	s3,104(sp)
    80004c14:	09010413          	addi	s0,sp,144
    80004c18:	05813023          	sd	s8,64(sp)
    80004c1c:	08113423          	sd	ra,136(sp)
    80004c20:	06913c23          	sd	s1,120(sp)
    80004c24:	07213823          	sd	s2,112(sp)
    80004c28:	07413023          	sd	s4,96(sp)
    80004c2c:	05513c23          	sd	s5,88(sp)
    80004c30:	05613823          	sd	s6,80(sp)
    80004c34:	05713423          	sd	s7,72(sp)
    80004c38:	03913c23          	sd	s9,56(sp)
    80004c3c:	03a13823          	sd	s10,48(sp)
    80004c40:	03b13423          	sd	s11,40(sp)
    80004c44:	00005317          	auipc	t1,0x5
    80004c48:	0cc30313          	addi	t1,t1,204 # 80009d10 <pr>
    80004c4c:	01832c03          	lw	s8,24(t1)
    80004c50:	00b43423          	sd	a1,8(s0)
    80004c54:	00c43823          	sd	a2,16(s0)
    80004c58:	00d43c23          	sd	a3,24(s0)
    80004c5c:	02e43023          	sd	a4,32(s0)
    80004c60:	02f43423          	sd	a5,40(s0)
    80004c64:	03043823          	sd	a6,48(s0)
    80004c68:	03143c23          	sd	a7,56(s0)
    80004c6c:	00050993          	mv	s3,a0
    80004c70:	4a0c1663          	bnez	s8,8000511c <__printf+0x514>
    80004c74:	60098c63          	beqz	s3,8000528c <__printf+0x684>
    80004c78:	0009c503          	lbu	a0,0(s3)
    80004c7c:	00840793          	addi	a5,s0,8
    80004c80:	f6f43c23          	sd	a5,-136(s0)
    80004c84:	00000493          	li	s1,0
    80004c88:	22050063          	beqz	a0,80004ea8 <__printf+0x2a0>
    80004c8c:	00002a37          	lui	s4,0x2
    80004c90:	00018ab7          	lui	s5,0x18
    80004c94:	000f4b37          	lui	s6,0xf4
    80004c98:	00989bb7          	lui	s7,0x989
    80004c9c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80004ca0:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80004ca4:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80004ca8:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    80004cac:	00148c9b          	addiw	s9,s1,1
    80004cb0:	02500793          	li	a5,37
    80004cb4:	01998933          	add	s2,s3,s9
    80004cb8:	38f51263          	bne	a0,a5,8000503c <__printf+0x434>
    80004cbc:	00094783          	lbu	a5,0(s2)
    80004cc0:	00078c9b          	sext.w	s9,a5
    80004cc4:	1e078263          	beqz	a5,80004ea8 <__printf+0x2a0>
    80004cc8:	0024849b          	addiw	s1,s1,2
    80004ccc:	07000713          	li	a4,112
    80004cd0:	00998933          	add	s2,s3,s1
    80004cd4:	38e78a63          	beq	a5,a4,80005068 <__printf+0x460>
    80004cd8:	20f76863          	bltu	a4,a5,80004ee8 <__printf+0x2e0>
    80004cdc:	42a78863          	beq	a5,a0,8000510c <__printf+0x504>
    80004ce0:	06400713          	li	a4,100
    80004ce4:	40e79663          	bne	a5,a4,800050f0 <__printf+0x4e8>
    80004ce8:	f7843783          	ld	a5,-136(s0)
    80004cec:	0007a603          	lw	a2,0(a5)
    80004cf0:	00878793          	addi	a5,a5,8
    80004cf4:	f6f43c23          	sd	a5,-136(s0)
    80004cf8:	42064a63          	bltz	a2,8000512c <__printf+0x524>
    80004cfc:	00a00713          	li	a4,10
    80004d00:	02e677bb          	remuw	a5,a2,a4
    80004d04:	00002d97          	auipc	s11,0x2
    80004d08:	474d8d93          	addi	s11,s11,1140 # 80007178 <digits>
    80004d0c:	00900593          	li	a1,9
    80004d10:	0006051b          	sext.w	a0,a2
    80004d14:	00000c93          	li	s9,0
    80004d18:	02079793          	slli	a5,a5,0x20
    80004d1c:	0207d793          	srli	a5,a5,0x20
    80004d20:	00fd87b3          	add	a5,s11,a5
    80004d24:	0007c783          	lbu	a5,0(a5)
    80004d28:	02e656bb          	divuw	a3,a2,a4
    80004d2c:	f8f40023          	sb	a5,-128(s0)
    80004d30:	14c5d863          	bge	a1,a2,80004e80 <__printf+0x278>
    80004d34:	06300593          	li	a1,99
    80004d38:	00100c93          	li	s9,1
    80004d3c:	02e6f7bb          	remuw	a5,a3,a4
    80004d40:	02079793          	slli	a5,a5,0x20
    80004d44:	0207d793          	srli	a5,a5,0x20
    80004d48:	00fd87b3          	add	a5,s11,a5
    80004d4c:	0007c783          	lbu	a5,0(a5)
    80004d50:	02e6d73b          	divuw	a4,a3,a4
    80004d54:	f8f400a3          	sb	a5,-127(s0)
    80004d58:	12a5f463          	bgeu	a1,a0,80004e80 <__printf+0x278>
    80004d5c:	00a00693          	li	a3,10
    80004d60:	00900593          	li	a1,9
    80004d64:	02d777bb          	remuw	a5,a4,a3
    80004d68:	02079793          	slli	a5,a5,0x20
    80004d6c:	0207d793          	srli	a5,a5,0x20
    80004d70:	00fd87b3          	add	a5,s11,a5
    80004d74:	0007c503          	lbu	a0,0(a5)
    80004d78:	02d757bb          	divuw	a5,a4,a3
    80004d7c:	f8a40123          	sb	a0,-126(s0)
    80004d80:	48e5f263          	bgeu	a1,a4,80005204 <__printf+0x5fc>
    80004d84:	06300513          	li	a0,99
    80004d88:	02d7f5bb          	remuw	a1,a5,a3
    80004d8c:	02059593          	slli	a1,a1,0x20
    80004d90:	0205d593          	srli	a1,a1,0x20
    80004d94:	00bd85b3          	add	a1,s11,a1
    80004d98:	0005c583          	lbu	a1,0(a1)
    80004d9c:	02d7d7bb          	divuw	a5,a5,a3
    80004da0:	f8b401a3          	sb	a1,-125(s0)
    80004da4:	48e57263          	bgeu	a0,a4,80005228 <__printf+0x620>
    80004da8:	3e700513          	li	a0,999
    80004dac:	02d7f5bb          	remuw	a1,a5,a3
    80004db0:	02059593          	slli	a1,a1,0x20
    80004db4:	0205d593          	srli	a1,a1,0x20
    80004db8:	00bd85b3          	add	a1,s11,a1
    80004dbc:	0005c583          	lbu	a1,0(a1)
    80004dc0:	02d7d7bb          	divuw	a5,a5,a3
    80004dc4:	f8b40223          	sb	a1,-124(s0)
    80004dc8:	46e57663          	bgeu	a0,a4,80005234 <__printf+0x62c>
    80004dcc:	02d7f5bb          	remuw	a1,a5,a3
    80004dd0:	02059593          	slli	a1,a1,0x20
    80004dd4:	0205d593          	srli	a1,a1,0x20
    80004dd8:	00bd85b3          	add	a1,s11,a1
    80004ddc:	0005c583          	lbu	a1,0(a1)
    80004de0:	02d7d7bb          	divuw	a5,a5,a3
    80004de4:	f8b402a3          	sb	a1,-123(s0)
    80004de8:	46ea7863          	bgeu	s4,a4,80005258 <__printf+0x650>
    80004dec:	02d7f5bb          	remuw	a1,a5,a3
    80004df0:	02059593          	slli	a1,a1,0x20
    80004df4:	0205d593          	srli	a1,a1,0x20
    80004df8:	00bd85b3          	add	a1,s11,a1
    80004dfc:	0005c583          	lbu	a1,0(a1)
    80004e00:	02d7d7bb          	divuw	a5,a5,a3
    80004e04:	f8b40323          	sb	a1,-122(s0)
    80004e08:	3eeaf863          	bgeu	s5,a4,800051f8 <__printf+0x5f0>
    80004e0c:	02d7f5bb          	remuw	a1,a5,a3
    80004e10:	02059593          	slli	a1,a1,0x20
    80004e14:	0205d593          	srli	a1,a1,0x20
    80004e18:	00bd85b3          	add	a1,s11,a1
    80004e1c:	0005c583          	lbu	a1,0(a1)
    80004e20:	02d7d7bb          	divuw	a5,a5,a3
    80004e24:	f8b403a3          	sb	a1,-121(s0)
    80004e28:	42eb7e63          	bgeu	s6,a4,80005264 <__printf+0x65c>
    80004e2c:	02d7f5bb          	remuw	a1,a5,a3
    80004e30:	02059593          	slli	a1,a1,0x20
    80004e34:	0205d593          	srli	a1,a1,0x20
    80004e38:	00bd85b3          	add	a1,s11,a1
    80004e3c:	0005c583          	lbu	a1,0(a1)
    80004e40:	02d7d7bb          	divuw	a5,a5,a3
    80004e44:	f8b40423          	sb	a1,-120(s0)
    80004e48:	42ebfc63          	bgeu	s7,a4,80005280 <__printf+0x678>
    80004e4c:	02079793          	slli	a5,a5,0x20
    80004e50:	0207d793          	srli	a5,a5,0x20
    80004e54:	00fd8db3          	add	s11,s11,a5
    80004e58:	000dc703          	lbu	a4,0(s11)
    80004e5c:	00a00793          	li	a5,10
    80004e60:	00900c93          	li	s9,9
    80004e64:	f8e404a3          	sb	a4,-119(s0)
    80004e68:	00065c63          	bgez	a2,80004e80 <__printf+0x278>
    80004e6c:	f9040713          	addi	a4,s0,-112
    80004e70:	00f70733          	add	a4,a4,a5
    80004e74:	02d00693          	li	a3,45
    80004e78:	fed70823          	sb	a3,-16(a4)
    80004e7c:	00078c93          	mv	s9,a5
    80004e80:	f8040793          	addi	a5,s0,-128
    80004e84:	01978cb3          	add	s9,a5,s9
    80004e88:	f7f40d13          	addi	s10,s0,-129
    80004e8c:	000cc503          	lbu	a0,0(s9)
    80004e90:	fffc8c93          	addi	s9,s9,-1
    80004e94:	00000097          	auipc	ra,0x0
    80004e98:	b90080e7          	jalr	-1136(ra) # 80004a24 <consputc>
    80004e9c:	ffac98e3          	bne	s9,s10,80004e8c <__printf+0x284>
    80004ea0:	00094503          	lbu	a0,0(s2)
    80004ea4:	e00514e3          	bnez	a0,80004cac <__printf+0xa4>
    80004ea8:	1a0c1663          	bnez	s8,80005054 <__printf+0x44c>
    80004eac:	08813083          	ld	ra,136(sp)
    80004eb0:	08013403          	ld	s0,128(sp)
    80004eb4:	07813483          	ld	s1,120(sp)
    80004eb8:	07013903          	ld	s2,112(sp)
    80004ebc:	06813983          	ld	s3,104(sp)
    80004ec0:	06013a03          	ld	s4,96(sp)
    80004ec4:	05813a83          	ld	s5,88(sp)
    80004ec8:	05013b03          	ld	s6,80(sp)
    80004ecc:	04813b83          	ld	s7,72(sp)
    80004ed0:	04013c03          	ld	s8,64(sp)
    80004ed4:	03813c83          	ld	s9,56(sp)
    80004ed8:	03013d03          	ld	s10,48(sp)
    80004edc:	02813d83          	ld	s11,40(sp)
    80004ee0:	0d010113          	addi	sp,sp,208
    80004ee4:	00008067          	ret
    80004ee8:	07300713          	li	a4,115
    80004eec:	1ce78a63          	beq	a5,a4,800050c0 <__printf+0x4b8>
    80004ef0:	07800713          	li	a4,120
    80004ef4:	1ee79e63          	bne	a5,a4,800050f0 <__printf+0x4e8>
    80004ef8:	f7843783          	ld	a5,-136(s0)
    80004efc:	0007a703          	lw	a4,0(a5)
    80004f00:	00878793          	addi	a5,a5,8
    80004f04:	f6f43c23          	sd	a5,-136(s0)
    80004f08:	28074263          	bltz	a4,8000518c <__printf+0x584>
    80004f0c:	00002d97          	auipc	s11,0x2
    80004f10:	26cd8d93          	addi	s11,s11,620 # 80007178 <digits>
    80004f14:	00f77793          	andi	a5,a4,15
    80004f18:	00fd87b3          	add	a5,s11,a5
    80004f1c:	0007c683          	lbu	a3,0(a5)
    80004f20:	00f00613          	li	a2,15
    80004f24:	0007079b          	sext.w	a5,a4
    80004f28:	f8d40023          	sb	a3,-128(s0)
    80004f2c:	0047559b          	srliw	a1,a4,0x4
    80004f30:	0047569b          	srliw	a3,a4,0x4
    80004f34:	00000c93          	li	s9,0
    80004f38:	0ee65063          	bge	a2,a4,80005018 <__printf+0x410>
    80004f3c:	00f6f693          	andi	a3,a3,15
    80004f40:	00dd86b3          	add	a3,s11,a3
    80004f44:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80004f48:	0087d79b          	srliw	a5,a5,0x8
    80004f4c:	00100c93          	li	s9,1
    80004f50:	f8d400a3          	sb	a3,-127(s0)
    80004f54:	0cb67263          	bgeu	a2,a1,80005018 <__printf+0x410>
    80004f58:	00f7f693          	andi	a3,a5,15
    80004f5c:	00dd86b3          	add	a3,s11,a3
    80004f60:	0006c583          	lbu	a1,0(a3)
    80004f64:	00f00613          	li	a2,15
    80004f68:	0047d69b          	srliw	a3,a5,0x4
    80004f6c:	f8b40123          	sb	a1,-126(s0)
    80004f70:	0047d593          	srli	a1,a5,0x4
    80004f74:	28f67e63          	bgeu	a2,a5,80005210 <__printf+0x608>
    80004f78:	00f6f693          	andi	a3,a3,15
    80004f7c:	00dd86b3          	add	a3,s11,a3
    80004f80:	0006c503          	lbu	a0,0(a3)
    80004f84:	0087d813          	srli	a6,a5,0x8
    80004f88:	0087d69b          	srliw	a3,a5,0x8
    80004f8c:	f8a401a3          	sb	a0,-125(s0)
    80004f90:	28b67663          	bgeu	a2,a1,8000521c <__printf+0x614>
    80004f94:	00f6f693          	andi	a3,a3,15
    80004f98:	00dd86b3          	add	a3,s11,a3
    80004f9c:	0006c583          	lbu	a1,0(a3)
    80004fa0:	00c7d513          	srli	a0,a5,0xc
    80004fa4:	00c7d69b          	srliw	a3,a5,0xc
    80004fa8:	f8b40223          	sb	a1,-124(s0)
    80004fac:	29067a63          	bgeu	a2,a6,80005240 <__printf+0x638>
    80004fb0:	00f6f693          	andi	a3,a3,15
    80004fb4:	00dd86b3          	add	a3,s11,a3
    80004fb8:	0006c583          	lbu	a1,0(a3)
    80004fbc:	0107d813          	srli	a6,a5,0x10
    80004fc0:	0107d69b          	srliw	a3,a5,0x10
    80004fc4:	f8b402a3          	sb	a1,-123(s0)
    80004fc8:	28a67263          	bgeu	a2,a0,8000524c <__printf+0x644>
    80004fcc:	00f6f693          	andi	a3,a3,15
    80004fd0:	00dd86b3          	add	a3,s11,a3
    80004fd4:	0006c683          	lbu	a3,0(a3)
    80004fd8:	0147d79b          	srliw	a5,a5,0x14
    80004fdc:	f8d40323          	sb	a3,-122(s0)
    80004fe0:	21067663          	bgeu	a2,a6,800051ec <__printf+0x5e4>
    80004fe4:	02079793          	slli	a5,a5,0x20
    80004fe8:	0207d793          	srli	a5,a5,0x20
    80004fec:	00fd8db3          	add	s11,s11,a5
    80004ff0:	000dc683          	lbu	a3,0(s11)
    80004ff4:	00800793          	li	a5,8
    80004ff8:	00700c93          	li	s9,7
    80004ffc:	f8d403a3          	sb	a3,-121(s0)
    80005000:	00075c63          	bgez	a4,80005018 <__printf+0x410>
    80005004:	f9040713          	addi	a4,s0,-112
    80005008:	00f70733          	add	a4,a4,a5
    8000500c:	02d00693          	li	a3,45
    80005010:	fed70823          	sb	a3,-16(a4)
    80005014:	00078c93          	mv	s9,a5
    80005018:	f8040793          	addi	a5,s0,-128
    8000501c:	01978cb3          	add	s9,a5,s9
    80005020:	f7f40d13          	addi	s10,s0,-129
    80005024:	000cc503          	lbu	a0,0(s9)
    80005028:	fffc8c93          	addi	s9,s9,-1
    8000502c:	00000097          	auipc	ra,0x0
    80005030:	9f8080e7          	jalr	-1544(ra) # 80004a24 <consputc>
    80005034:	ff9d18e3          	bne	s10,s9,80005024 <__printf+0x41c>
    80005038:	0100006f          	j	80005048 <__printf+0x440>
    8000503c:	00000097          	auipc	ra,0x0
    80005040:	9e8080e7          	jalr	-1560(ra) # 80004a24 <consputc>
    80005044:	000c8493          	mv	s1,s9
    80005048:	00094503          	lbu	a0,0(s2)
    8000504c:	c60510e3          	bnez	a0,80004cac <__printf+0xa4>
    80005050:	e40c0ee3          	beqz	s8,80004eac <__printf+0x2a4>
    80005054:	00005517          	auipc	a0,0x5
    80005058:	cbc50513          	addi	a0,a0,-836 # 80009d10 <pr>
    8000505c:	00001097          	auipc	ra,0x1
    80005060:	94c080e7          	jalr	-1716(ra) # 800059a8 <release>
    80005064:	e49ff06f          	j	80004eac <__printf+0x2a4>
    80005068:	f7843783          	ld	a5,-136(s0)
    8000506c:	03000513          	li	a0,48
    80005070:	01000d13          	li	s10,16
    80005074:	00878713          	addi	a4,a5,8
    80005078:	0007bc83          	ld	s9,0(a5)
    8000507c:	f6e43c23          	sd	a4,-136(s0)
    80005080:	00000097          	auipc	ra,0x0
    80005084:	9a4080e7          	jalr	-1628(ra) # 80004a24 <consputc>
    80005088:	07800513          	li	a0,120
    8000508c:	00000097          	auipc	ra,0x0
    80005090:	998080e7          	jalr	-1640(ra) # 80004a24 <consputc>
    80005094:	00002d97          	auipc	s11,0x2
    80005098:	0e4d8d93          	addi	s11,s11,228 # 80007178 <digits>
    8000509c:	03ccd793          	srli	a5,s9,0x3c
    800050a0:	00fd87b3          	add	a5,s11,a5
    800050a4:	0007c503          	lbu	a0,0(a5)
    800050a8:	fffd0d1b          	addiw	s10,s10,-1
    800050ac:	004c9c93          	slli	s9,s9,0x4
    800050b0:	00000097          	auipc	ra,0x0
    800050b4:	974080e7          	jalr	-1676(ra) # 80004a24 <consputc>
    800050b8:	fe0d12e3          	bnez	s10,8000509c <__printf+0x494>
    800050bc:	f8dff06f          	j	80005048 <__printf+0x440>
    800050c0:	f7843783          	ld	a5,-136(s0)
    800050c4:	0007bc83          	ld	s9,0(a5)
    800050c8:	00878793          	addi	a5,a5,8
    800050cc:	f6f43c23          	sd	a5,-136(s0)
    800050d0:	000c9a63          	bnez	s9,800050e4 <__printf+0x4dc>
    800050d4:	1080006f          	j	800051dc <__printf+0x5d4>
    800050d8:	001c8c93          	addi	s9,s9,1
    800050dc:	00000097          	auipc	ra,0x0
    800050e0:	948080e7          	jalr	-1720(ra) # 80004a24 <consputc>
    800050e4:	000cc503          	lbu	a0,0(s9)
    800050e8:	fe0518e3          	bnez	a0,800050d8 <__printf+0x4d0>
    800050ec:	f5dff06f          	j	80005048 <__printf+0x440>
    800050f0:	02500513          	li	a0,37
    800050f4:	00000097          	auipc	ra,0x0
    800050f8:	930080e7          	jalr	-1744(ra) # 80004a24 <consputc>
    800050fc:	000c8513          	mv	a0,s9
    80005100:	00000097          	auipc	ra,0x0
    80005104:	924080e7          	jalr	-1756(ra) # 80004a24 <consputc>
    80005108:	f41ff06f          	j	80005048 <__printf+0x440>
    8000510c:	02500513          	li	a0,37
    80005110:	00000097          	auipc	ra,0x0
    80005114:	914080e7          	jalr	-1772(ra) # 80004a24 <consputc>
    80005118:	f31ff06f          	j	80005048 <__printf+0x440>
    8000511c:	00030513          	mv	a0,t1
    80005120:	00000097          	auipc	ra,0x0
    80005124:	7bc080e7          	jalr	1980(ra) # 800058dc <acquire>
    80005128:	b4dff06f          	j	80004c74 <__printf+0x6c>
    8000512c:	40c0053b          	negw	a0,a2
    80005130:	00a00713          	li	a4,10
    80005134:	02e576bb          	remuw	a3,a0,a4
    80005138:	00002d97          	auipc	s11,0x2
    8000513c:	040d8d93          	addi	s11,s11,64 # 80007178 <digits>
    80005140:	ff700593          	li	a1,-9
    80005144:	02069693          	slli	a3,a3,0x20
    80005148:	0206d693          	srli	a3,a3,0x20
    8000514c:	00dd86b3          	add	a3,s11,a3
    80005150:	0006c683          	lbu	a3,0(a3)
    80005154:	02e557bb          	divuw	a5,a0,a4
    80005158:	f8d40023          	sb	a3,-128(s0)
    8000515c:	10b65e63          	bge	a2,a1,80005278 <__printf+0x670>
    80005160:	06300593          	li	a1,99
    80005164:	02e7f6bb          	remuw	a3,a5,a4
    80005168:	02069693          	slli	a3,a3,0x20
    8000516c:	0206d693          	srli	a3,a3,0x20
    80005170:	00dd86b3          	add	a3,s11,a3
    80005174:	0006c683          	lbu	a3,0(a3)
    80005178:	02e7d73b          	divuw	a4,a5,a4
    8000517c:	00200793          	li	a5,2
    80005180:	f8d400a3          	sb	a3,-127(s0)
    80005184:	bca5ece3          	bltu	a1,a0,80004d5c <__printf+0x154>
    80005188:	ce5ff06f          	j	80004e6c <__printf+0x264>
    8000518c:	40e007bb          	negw	a5,a4
    80005190:	00002d97          	auipc	s11,0x2
    80005194:	fe8d8d93          	addi	s11,s11,-24 # 80007178 <digits>
    80005198:	00f7f693          	andi	a3,a5,15
    8000519c:	00dd86b3          	add	a3,s11,a3
    800051a0:	0006c583          	lbu	a1,0(a3)
    800051a4:	ff100613          	li	a2,-15
    800051a8:	0047d69b          	srliw	a3,a5,0x4
    800051ac:	f8b40023          	sb	a1,-128(s0)
    800051b0:	0047d59b          	srliw	a1,a5,0x4
    800051b4:	0ac75e63          	bge	a4,a2,80005270 <__printf+0x668>
    800051b8:	00f6f693          	andi	a3,a3,15
    800051bc:	00dd86b3          	add	a3,s11,a3
    800051c0:	0006c603          	lbu	a2,0(a3)
    800051c4:	00f00693          	li	a3,15
    800051c8:	0087d79b          	srliw	a5,a5,0x8
    800051cc:	f8c400a3          	sb	a2,-127(s0)
    800051d0:	d8b6e4e3          	bltu	a3,a1,80004f58 <__printf+0x350>
    800051d4:	00200793          	li	a5,2
    800051d8:	e2dff06f          	j	80005004 <__printf+0x3fc>
    800051dc:	00002c97          	auipc	s9,0x2
    800051e0:	f7cc8c93          	addi	s9,s9,-132 # 80007158 <CONSOLE_STATUS+0x148>
    800051e4:	02800513          	li	a0,40
    800051e8:	ef1ff06f          	j	800050d8 <__printf+0x4d0>
    800051ec:	00700793          	li	a5,7
    800051f0:	00600c93          	li	s9,6
    800051f4:	e0dff06f          	j	80005000 <__printf+0x3f8>
    800051f8:	00700793          	li	a5,7
    800051fc:	00600c93          	li	s9,6
    80005200:	c69ff06f          	j	80004e68 <__printf+0x260>
    80005204:	00300793          	li	a5,3
    80005208:	00200c93          	li	s9,2
    8000520c:	c5dff06f          	j	80004e68 <__printf+0x260>
    80005210:	00300793          	li	a5,3
    80005214:	00200c93          	li	s9,2
    80005218:	de9ff06f          	j	80005000 <__printf+0x3f8>
    8000521c:	00400793          	li	a5,4
    80005220:	00300c93          	li	s9,3
    80005224:	dddff06f          	j	80005000 <__printf+0x3f8>
    80005228:	00400793          	li	a5,4
    8000522c:	00300c93          	li	s9,3
    80005230:	c39ff06f          	j	80004e68 <__printf+0x260>
    80005234:	00500793          	li	a5,5
    80005238:	00400c93          	li	s9,4
    8000523c:	c2dff06f          	j	80004e68 <__printf+0x260>
    80005240:	00500793          	li	a5,5
    80005244:	00400c93          	li	s9,4
    80005248:	db9ff06f          	j	80005000 <__printf+0x3f8>
    8000524c:	00600793          	li	a5,6
    80005250:	00500c93          	li	s9,5
    80005254:	dadff06f          	j	80005000 <__printf+0x3f8>
    80005258:	00600793          	li	a5,6
    8000525c:	00500c93          	li	s9,5
    80005260:	c09ff06f          	j	80004e68 <__printf+0x260>
    80005264:	00800793          	li	a5,8
    80005268:	00700c93          	li	s9,7
    8000526c:	bfdff06f          	j	80004e68 <__printf+0x260>
    80005270:	00100793          	li	a5,1
    80005274:	d91ff06f          	j	80005004 <__printf+0x3fc>
    80005278:	00100793          	li	a5,1
    8000527c:	bf1ff06f          	j	80004e6c <__printf+0x264>
    80005280:	00900793          	li	a5,9
    80005284:	00800c93          	li	s9,8
    80005288:	be1ff06f          	j	80004e68 <__printf+0x260>
    8000528c:	00002517          	auipc	a0,0x2
    80005290:	ed450513          	addi	a0,a0,-300 # 80007160 <CONSOLE_STATUS+0x150>
    80005294:	00000097          	auipc	ra,0x0
    80005298:	918080e7          	jalr	-1768(ra) # 80004bac <panic>

000000008000529c <printfinit>:
    8000529c:	fe010113          	addi	sp,sp,-32
    800052a0:	00813823          	sd	s0,16(sp)
    800052a4:	00913423          	sd	s1,8(sp)
    800052a8:	00113c23          	sd	ra,24(sp)
    800052ac:	02010413          	addi	s0,sp,32
    800052b0:	00005497          	auipc	s1,0x5
    800052b4:	a6048493          	addi	s1,s1,-1440 # 80009d10 <pr>
    800052b8:	00048513          	mv	a0,s1
    800052bc:	00002597          	auipc	a1,0x2
    800052c0:	eb458593          	addi	a1,a1,-332 # 80007170 <CONSOLE_STATUS+0x160>
    800052c4:	00000097          	auipc	ra,0x0
    800052c8:	5f4080e7          	jalr	1524(ra) # 800058b8 <initlock>
    800052cc:	01813083          	ld	ra,24(sp)
    800052d0:	01013403          	ld	s0,16(sp)
    800052d4:	0004ac23          	sw	zero,24(s1)
    800052d8:	00813483          	ld	s1,8(sp)
    800052dc:	02010113          	addi	sp,sp,32
    800052e0:	00008067          	ret

00000000800052e4 <uartinit>:
    800052e4:	ff010113          	addi	sp,sp,-16
    800052e8:	00813423          	sd	s0,8(sp)
    800052ec:	01010413          	addi	s0,sp,16
    800052f0:	100007b7          	lui	a5,0x10000
    800052f4:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    800052f8:	f8000713          	li	a4,-128
    800052fc:	00e781a3          	sb	a4,3(a5)
    80005300:	00300713          	li	a4,3
    80005304:	00e78023          	sb	a4,0(a5)
    80005308:	000780a3          	sb	zero,1(a5)
    8000530c:	00e781a3          	sb	a4,3(a5)
    80005310:	00700693          	li	a3,7
    80005314:	00d78123          	sb	a3,2(a5)
    80005318:	00e780a3          	sb	a4,1(a5)
    8000531c:	00813403          	ld	s0,8(sp)
    80005320:	01010113          	addi	sp,sp,16
    80005324:	00008067          	ret

0000000080005328 <uartputc>:
    80005328:	00003797          	auipc	a5,0x3
    8000532c:	5007a783          	lw	a5,1280(a5) # 80008828 <panicked>
    80005330:	00078463          	beqz	a5,80005338 <uartputc+0x10>
    80005334:	0000006f          	j	80005334 <uartputc+0xc>
    80005338:	fd010113          	addi	sp,sp,-48
    8000533c:	02813023          	sd	s0,32(sp)
    80005340:	00913c23          	sd	s1,24(sp)
    80005344:	01213823          	sd	s2,16(sp)
    80005348:	01313423          	sd	s3,8(sp)
    8000534c:	02113423          	sd	ra,40(sp)
    80005350:	03010413          	addi	s0,sp,48
    80005354:	00003917          	auipc	s2,0x3
    80005358:	4dc90913          	addi	s2,s2,1244 # 80008830 <uart_tx_r>
    8000535c:	00093783          	ld	a5,0(s2)
    80005360:	00003497          	auipc	s1,0x3
    80005364:	4d848493          	addi	s1,s1,1240 # 80008838 <uart_tx_w>
    80005368:	0004b703          	ld	a4,0(s1)
    8000536c:	02078693          	addi	a3,a5,32
    80005370:	00050993          	mv	s3,a0
    80005374:	02e69c63          	bne	a3,a4,800053ac <uartputc+0x84>
    80005378:	00001097          	auipc	ra,0x1
    8000537c:	834080e7          	jalr	-1996(ra) # 80005bac <push_on>
    80005380:	00093783          	ld	a5,0(s2)
    80005384:	0004b703          	ld	a4,0(s1)
    80005388:	02078793          	addi	a5,a5,32
    8000538c:	00e79463          	bne	a5,a4,80005394 <uartputc+0x6c>
    80005390:	0000006f          	j	80005390 <uartputc+0x68>
    80005394:	00001097          	auipc	ra,0x1
    80005398:	88c080e7          	jalr	-1908(ra) # 80005c20 <pop_on>
    8000539c:	00093783          	ld	a5,0(s2)
    800053a0:	0004b703          	ld	a4,0(s1)
    800053a4:	02078693          	addi	a3,a5,32
    800053a8:	fce688e3          	beq	a3,a4,80005378 <uartputc+0x50>
    800053ac:	01f77693          	andi	a3,a4,31
    800053b0:	00005597          	auipc	a1,0x5
    800053b4:	98058593          	addi	a1,a1,-1664 # 80009d30 <uart_tx_buf>
    800053b8:	00d586b3          	add	a3,a1,a3
    800053bc:	00170713          	addi	a4,a4,1
    800053c0:	01368023          	sb	s3,0(a3)
    800053c4:	00e4b023          	sd	a4,0(s1)
    800053c8:	10000637          	lui	a2,0x10000
    800053cc:	02f71063          	bne	a4,a5,800053ec <uartputc+0xc4>
    800053d0:	0340006f          	j	80005404 <uartputc+0xdc>
    800053d4:	00074703          	lbu	a4,0(a4)
    800053d8:	00f93023          	sd	a5,0(s2)
    800053dc:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    800053e0:	00093783          	ld	a5,0(s2)
    800053e4:	0004b703          	ld	a4,0(s1)
    800053e8:	00f70e63          	beq	a4,a5,80005404 <uartputc+0xdc>
    800053ec:	00564683          	lbu	a3,5(a2)
    800053f0:	01f7f713          	andi	a4,a5,31
    800053f4:	00e58733          	add	a4,a1,a4
    800053f8:	0206f693          	andi	a3,a3,32
    800053fc:	00178793          	addi	a5,a5,1
    80005400:	fc069ae3          	bnez	a3,800053d4 <uartputc+0xac>
    80005404:	02813083          	ld	ra,40(sp)
    80005408:	02013403          	ld	s0,32(sp)
    8000540c:	01813483          	ld	s1,24(sp)
    80005410:	01013903          	ld	s2,16(sp)
    80005414:	00813983          	ld	s3,8(sp)
    80005418:	03010113          	addi	sp,sp,48
    8000541c:	00008067          	ret

0000000080005420 <uartputc_sync>:
    80005420:	ff010113          	addi	sp,sp,-16
    80005424:	00813423          	sd	s0,8(sp)
    80005428:	01010413          	addi	s0,sp,16
    8000542c:	00003717          	auipc	a4,0x3
    80005430:	3fc72703          	lw	a4,1020(a4) # 80008828 <panicked>
    80005434:	02071663          	bnez	a4,80005460 <uartputc_sync+0x40>
    80005438:	00050793          	mv	a5,a0
    8000543c:	100006b7          	lui	a3,0x10000
    80005440:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80005444:	02077713          	andi	a4,a4,32
    80005448:	fe070ce3          	beqz	a4,80005440 <uartputc_sync+0x20>
    8000544c:	0ff7f793          	andi	a5,a5,255
    80005450:	00f68023          	sb	a5,0(a3)
    80005454:	00813403          	ld	s0,8(sp)
    80005458:	01010113          	addi	sp,sp,16
    8000545c:	00008067          	ret
    80005460:	0000006f          	j	80005460 <uartputc_sync+0x40>

0000000080005464 <uartstart>:
    80005464:	ff010113          	addi	sp,sp,-16
    80005468:	00813423          	sd	s0,8(sp)
    8000546c:	01010413          	addi	s0,sp,16
    80005470:	00003617          	auipc	a2,0x3
    80005474:	3c060613          	addi	a2,a2,960 # 80008830 <uart_tx_r>
    80005478:	00003517          	auipc	a0,0x3
    8000547c:	3c050513          	addi	a0,a0,960 # 80008838 <uart_tx_w>
    80005480:	00063783          	ld	a5,0(a2)
    80005484:	00053703          	ld	a4,0(a0)
    80005488:	04f70263          	beq	a4,a5,800054cc <uartstart+0x68>
    8000548c:	100005b7          	lui	a1,0x10000
    80005490:	00005817          	auipc	a6,0x5
    80005494:	8a080813          	addi	a6,a6,-1888 # 80009d30 <uart_tx_buf>
    80005498:	01c0006f          	j	800054b4 <uartstart+0x50>
    8000549c:	0006c703          	lbu	a4,0(a3)
    800054a0:	00f63023          	sd	a5,0(a2)
    800054a4:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800054a8:	00063783          	ld	a5,0(a2)
    800054ac:	00053703          	ld	a4,0(a0)
    800054b0:	00f70e63          	beq	a4,a5,800054cc <uartstart+0x68>
    800054b4:	01f7f713          	andi	a4,a5,31
    800054b8:	00e806b3          	add	a3,a6,a4
    800054bc:	0055c703          	lbu	a4,5(a1)
    800054c0:	00178793          	addi	a5,a5,1
    800054c4:	02077713          	andi	a4,a4,32
    800054c8:	fc071ae3          	bnez	a4,8000549c <uartstart+0x38>
    800054cc:	00813403          	ld	s0,8(sp)
    800054d0:	01010113          	addi	sp,sp,16
    800054d4:	00008067          	ret

00000000800054d8 <uartgetc>:
    800054d8:	ff010113          	addi	sp,sp,-16
    800054dc:	00813423          	sd	s0,8(sp)
    800054e0:	01010413          	addi	s0,sp,16
    800054e4:	10000737          	lui	a4,0x10000
    800054e8:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    800054ec:	0017f793          	andi	a5,a5,1
    800054f0:	00078c63          	beqz	a5,80005508 <uartgetc+0x30>
    800054f4:	00074503          	lbu	a0,0(a4)
    800054f8:	0ff57513          	andi	a0,a0,255
    800054fc:	00813403          	ld	s0,8(sp)
    80005500:	01010113          	addi	sp,sp,16
    80005504:	00008067          	ret
    80005508:	fff00513          	li	a0,-1
    8000550c:	ff1ff06f          	j	800054fc <uartgetc+0x24>

0000000080005510 <uartintr>:
    80005510:	100007b7          	lui	a5,0x10000
    80005514:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80005518:	0017f793          	andi	a5,a5,1
    8000551c:	0a078463          	beqz	a5,800055c4 <uartintr+0xb4>
    80005520:	fe010113          	addi	sp,sp,-32
    80005524:	00813823          	sd	s0,16(sp)
    80005528:	00913423          	sd	s1,8(sp)
    8000552c:	00113c23          	sd	ra,24(sp)
    80005530:	02010413          	addi	s0,sp,32
    80005534:	100004b7          	lui	s1,0x10000
    80005538:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    8000553c:	0ff57513          	andi	a0,a0,255
    80005540:	fffff097          	auipc	ra,0xfffff
    80005544:	534080e7          	jalr	1332(ra) # 80004a74 <consoleintr>
    80005548:	0054c783          	lbu	a5,5(s1)
    8000554c:	0017f793          	andi	a5,a5,1
    80005550:	fe0794e3          	bnez	a5,80005538 <uartintr+0x28>
    80005554:	00003617          	auipc	a2,0x3
    80005558:	2dc60613          	addi	a2,a2,732 # 80008830 <uart_tx_r>
    8000555c:	00003517          	auipc	a0,0x3
    80005560:	2dc50513          	addi	a0,a0,732 # 80008838 <uart_tx_w>
    80005564:	00063783          	ld	a5,0(a2)
    80005568:	00053703          	ld	a4,0(a0)
    8000556c:	04f70263          	beq	a4,a5,800055b0 <uartintr+0xa0>
    80005570:	100005b7          	lui	a1,0x10000
    80005574:	00004817          	auipc	a6,0x4
    80005578:	7bc80813          	addi	a6,a6,1980 # 80009d30 <uart_tx_buf>
    8000557c:	01c0006f          	j	80005598 <uartintr+0x88>
    80005580:	0006c703          	lbu	a4,0(a3)
    80005584:	00f63023          	sd	a5,0(a2)
    80005588:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000558c:	00063783          	ld	a5,0(a2)
    80005590:	00053703          	ld	a4,0(a0)
    80005594:	00f70e63          	beq	a4,a5,800055b0 <uartintr+0xa0>
    80005598:	01f7f713          	andi	a4,a5,31
    8000559c:	00e806b3          	add	a3,a6,a4
    800055a0:	0055c703          	lbu	a4,5(a1)
    800055a4:	00178793          	addi	a5,a5,1
    800055a8:	02077713          	andi	a4,a4,32
    800055ac:	fc071ae3          	bnez	a4,80005580 <uartintr+0x70>
    800055b0:	01813083          	ld	ra,24(sp)
    800055b4:	01013403          	ld	s0,16(sp)
    800055b8:	00813483          	ld	s1,8(sp)
    800055bc:	02010113          	addi	sp,sp,32
    800055c0:	00008067          	ret
    800055c4:	00003617          	auipc	a2,0x3
    800055c8:	26c60613          	addi	a2,a2,620 # 80008830 <uart_tx_r>
    800055cc:	00003517          	auipc	a0,0x3
    800055d0:	26c50513          	addi	a0,a0,620 # 80008838 <uart_tx_w>
    800055d4:	00063783          	ld	a5,0(a2)
    800055d8:	00053703          	ld	a4,0(a0)
    800055dc:	04f70263          	beq	a4,a5,80005620 <uartintr+0x110>
    800055e0:	100005b7          	lui	a1,0x10000
    800055e4:	00004817          	auipc	a6,0x4
    800055e8:	74c80813          	addi	a6,a6,1868 # 80009d30 <uart_tx_buf>
    800055ec:	01c0006f          	j	80005608 <uartintr+0xf8>
    800055f0:	0006c703          	lbu	a4,0(a3)
    800055f4:	00f63023          	sd	a5,0(a2)
    800055f8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800055fc:	00063783          	ld	a5,0(a2)
    80005600:	00053703          	ld	a4,0(a0)
    80005604:	02f70063          	beq	a4,a5,80005624 <uartintr+0x114>
    80005608:	01f7f713          	andi	a4,a5,31
    8000560c:	00e806b3          	add	a3,a6,a4
    80005610:	0055c703          	lbu	a4,5(a1)
    80005614:	00178793          	addi	a5,a5,1
    80005618:	02077713          	andi	a4,a4,32
    8000561c:	fc071ae3          	bnez	a4,800055f0 <uartintr+0xe0>
    80005620:	00008067          	ret
    80005624:	00008067          	ret

0000000080005628 <kinit>:
    80005628:	fc010113          	addi	sp,sp,-64
    8000562c:	02913423          	sd	s1,40(sp)
    80005630:	fffff7b7          	lui	a5,0xfffff
    80005634:	00005497          	auipc	s1,0x5
    80005638:	71b48493          	addi	s1,s1,1819 # 8000ad4f <end+0xfff>
    8000563c:	02813823          	sd	s0,48(sp)
    80005640:	01313c23          	sd	s3,24(sp)
    80005644:	00f4f4b3          	and	s1,s1,a5
    80005648:	02113c23          	sd	ra,56(sp)
    8000564c:	03213023          	sd	s2,32(sp)
    80005650:	01413823          	sd	s4,16(sp)
    80005654:	01513423          	sd	s5,8(sp)
    80005658:	04010413          	addi	s0,sp,64
    8000565c:	000017b7          	lui	a5,0x1
    80005660:	01100993          	li	s3,17
    80005664:	00f487b3          	add	a5,s1,a5
    80005668:	01b99993          	slli	s3,s3,0x1b
    8000566c:	06f9e063          	bltu	s3,a5,800056cc <kinit+0xa4>
    80005670:	00004a97          	auipc	s5,0x4
    80005674:	6e0a8a93          	addi	s5,s5,1760 # 80009d50 <end>
    80005678:	0754ec63          	bltu	s1,s5,800056f0 <kinit+0xc8>
    8000567c:	0734fa63          	bgeu	s1,s3,800056f0 <kinit+0xc8>
    80005680:	00088a37          	lui	s4,0x88
    80005684:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80005688:	00003917          	auipc	s2,0x3
    8000568c:	1b890913          	addi	s2,s2,440 # 80008840 <kmem>
    80005690:	00ca1a13          	slli	s4,s4,0xc
    80005694:	0140006f          	j	800056a8 <kinit+0x80>
    80005698:	000017b7          	lui	a5,0x1
    8000569c:	00f484b3          	add	s1,s1,a5
    800056a0:	0554e863          	bltu	s1,s5,800056f0 <kinit+0xc8>
    800056a4:	0534f663          	bgeu	s1,s3,800056f0 <kinit+0xc8>
    800056a8:	00001637          	lui	a2,0x1
    800056ac:	00100593          	li	a1,1
    800056b0:	00048513          	mv	a0,s1
    800056b4:	00000097          	auipc	ra,0x0
    800056b8:	5e4080e7          	jalr	1508(ra) # 80005c98 <__memset>
    800056bc:	00093783          	ld	a5,0(s2)
    800056c0:	00f4b023          	sd	a5,0(s1)
    800056c4:	00993023          	sd	s1,0(s2)
    800056c8:	fd4498e3          	bne	s1,s4,80005698 <kinit+0x70>
    800056cc:	03813083          	ld	ra,56(sp)
    800056d0:	03013403          	ld	s0,48(sp)
    800056d4:	02813483          	ld	s1,40(sp)
    800056d8:	02013903          	ld	s2,32(sp)
    800056dc:	01813983          	ld	s3,24(sp)
    800056e0:	01013a03          	ld	s4,16(sp)
    800056e4:	00813a83          	ld	s5,8(sp)
    800056e8:	04010113          	addi	sp,sp,64
    800056ec:	00008067          	ret
    800056f0:	00002517          	auipc	a0,0x2
    800056f4:	aa050513          	addi	a0,a0,-1376 # 80007190 <digits+0x18>
    800056f8:	fffff097          	auipc	ra,0xfffff
    800056fc:	4b4080e7          	jalr	1204(ra) # 80004bac <panic>

0000000080005700 <freerange>:
    80005700:	fc010113          	addi	sp,sp,-64
    80005704:	000017b7          	lui	a5,0x1
    80005708:	02913423          	sd	s1,40(sp)
    8000570c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80005710:	009504b3          	add	s1,a0,s1
    80005714:	fffff537          	lui	a0,0xfffff
    80005718:	02813823          	sd	s0,48(sp)
    8000571c:	02113c23          	sd	ra,56(sp)
    80005720:	03213023          	sd	s2,32(sp)
    80005724:	01313c23          	sd	s3,24(sp)
    80005728:	01413823          	sd	s4,16(sp)
    8000572c:	01513423          	sd	s5,8(sp)
    80005730:	01613023          	sd	s6,0(sp)
    80005734:	04010413          	addi	s0,sp,64
    80005738:	00a4f4b3          	and	s1,s1,a0
    8000573c:	00f487b3          	add	a5,s1,a5
    80005740:	06f5e463          	bltu	a1,a5,800057a8 <freerange+0xa8>
    80005744:	00004a97          	auipc	s5,0x4
    80005748:	60ca8a93          	addi	s5,s5,1548 # 80009d50 <end>
    8000574c:	0954e263          	bltu	s1,s5,800057d0 <freerange+0xd0>
    80005750:	01100993          	li	s3,17
    80005754:	01b99993          	slli	s3,s3,0x1b
    80005758:	0734fc63          	bgeu	s1,s3,800057d0 <freerange+0xd0>
    8000575c:	00058a13          	mv	s4,a1
    80005760:	00003917          	auipc	s2,0x3
    80005764:	0e090913          	addi	s2,s2,224 # 80008840 <kmem>
    80005768:	00002b37          	lui	s6,0x2
    8000576c:	0140006f          	j	80005780 <freerange+0x80>
    80005770:	000017b7          	lui	a5,0x1
    80005774:	00f484b3          	add	s1,s1,a5
    80005778:	0554ec63          	bltu	s1,s5,800057d0 <freerange+0xd0>
    8000577c:	0534fa63          	bgeu	s1,s3,800057d0 <freerange+0xd0>
    80005780:	00001637          	lui	a2,0x1
    80005784:	00100593          	li	a1,1
    80005788:	00048513          	mv	a0,s1
    8000578c:	00000097          	auipc	ra,0x0
    80005790:	50c080e7          	jalr	1292(ra) # 80005c98 <__memset>
    80005794:	00093703          	ld	a4,0(s2)
    80005798:	016487b3          	add	a5,s1,s6
    8000579c:	00e4b023          	sd	a4,0(s1)
    800057a0:	00993023          	sd	s1,0(s2)
    800057a4:	fcfa76e3          	bgeu	s4,a5,80005770 <freerange+0x70>
    800057a8:	03813083          	ld	ra,56(sp)
    800057ac:	03013403          	ld	s0,48(sp)
    800057b0:	02813483          	ld	s1,40(sp)
    800057b4:	02013903          	ld	s2,32(sp)
    800057b8:	01813983          	ld	s3,24(sp)
    800057bc:	01013a03          	ld	s4,16(sp)
    800057c0:	00813a83          	ld	s5,8(sp)
    800057c4:	00013b03          	ld	s6,0(sp)
    800057c8:	04010113          	addi	sp,sp,64
    800057cc:	00008067          	ret
    800057d0:	00002517          	auipc	a0,0x2
    800057d4:	9c050513          	addi	a0,a0,-1600 # 80007190 <digits+0x18>
    800057d8:	fffff097          	auipc	ra,0xfffff
    800057dc:	3d4080e7          	jalr	980(ra) # 80004bac <panic>

00000000800057e0 <kfree>:
    800057e0:	fe010113          	addi	sp,sp,-32
    800057e4:	00813823          	sd	s0,16(sp)
    800057e8:	00113c23          	sd	ra,24(sp)
    800057ec:	00913423          	sd	s1,8(sp)
    800057f0:	02010413          	addi	s0,sp,32
    800057f4:	03451793          	slli	a5,a0,0x34
    800057f8:	04079c63          	bnez	a5,80005850 <kfree+0x70>
    800057fc:	00004797          	auipc	a5,0x4
    80005800:	55478793          	addi	a5,a5,1364 # 80009d50 <end>
    80005804:	00050493          	mv	s1,a0
    80005808:	04f56463          	bltu	a0,a5,80005850 <kfree+0x70>
    8000580c:	01100793          	li	a5,17
    80005810:	01b79793          	slli	a5,a5,0x1b
    80005814:	02f57e63          	bgeu	a0,a5,80005850 <kfree+0x70>
    80005818:	00001637          	lui	a2,0x1
    8000581c:	00100593          	li	a1,1
    80005820:	00000097          	auipc	ra,0x0
    80005824:	478080e7          	jalr	1144(ra) # 80005c98 <__memset>
    80005828:	00003797          	auipc	a5,0x3
    8000582c:	01878793          	addi	a5,a5,24 # 80008840 <kmem>
    80005830:	0007b703          	ld	a4,0(a5)
    80005834:	01813083          	ld	ra,24(sp)
    80005838:	01013403          	ld	s0,16(sp)
    8000583c:	00e4b023          	sd	a4,0(s1)
    80005840:	0097b023          	sd	s1,0(a5)
    80005844:	00813483          	ld	s1,8(sp)
    80005848:	02010113          	addi	sp,sp,32
    8000584c:	00008067          	ret
    80005850:	00002517          	auipc	a0,0x2
    80005854:	94050513          	addi	a0,a0,-1728 # 80007190 <digits+0x18>
    80005858:	fffff097          	auipc	ra,0xfffff
    8000585c:	354080e7          	jalr	852(ra) # 80004bac <panic>

0000000080005860 <kalloc>:
    80005860:	fe010113          	addi	sp,sp,-32
    80005864:	00813823          	sd	s0,16(sp)
    80005868:	00913423          	sd	s1,8(sp)
    8000586c:	00113c23          	sd	ra,24(sp)
    80005870:	02010413          	addi	s0,sp,32
    80005874:	00003797          	auipc	a5,0x3
    80005878:	fcc78793          	addi	a5,a5,-52 # 80008840 <kmem>
    8000587c:	0007b483          	ld	s1,0(a5)
    80005880:	02048063          	beqz	s1,800058a0 <kalloc+0x40>
    80005884:	0004b703          	ld	a4,0(s1)
    80005888:	00001637          	lui	a2,0x1
    8000588c:	00500593          	li	a1,5
    80005890:	00048513          	mv	a0,s1
    80005894:	00e7b023          	sd	a4,0(a5)
    80005898:	00000097          	auipc	ra,0x0
    8000589c:	400080e7          	jalr	1024(ra) # 80005c98 <__memset>
    800058a0:	01813083          	ld	ra,24(sp)
    800058a4:	01013403          	ld	s0,16(sp)
    800058a8:	00048513          	mv	a0,s1
    800058ac:	00813483          	ld	s1,8(sp)
    800058b0:	02010113          	addi	sp,sp,32
    800058b4:	00008067          	ret

00000000800058b8 <initlock>:
    800058b8:	ff010113          	addi	sp,sp,-16
    800058bc:	00813423          	sd	s0,8(sp)
    800058c0:	01010413          	addi	s0,sp,16
    800058c4:	00813403          	ld	s0,8(sp)
    800058c8:	00b53423          	sd	a1,8(a0)
    800058cc:	00052023          	sw	zero,0(a0)
    800058d0:	00053823          	sd	zero,16(a0)
    800058d4:	01010113          	addi	sp,sp,16
    800058d8:	00008067          	ret

00000000800058dc <acquire>:
    800058dc:	fe010113          	addi	sp,sp,-32
    800058e0:	00813823          	sd	s0,16(sp)
    800058e4:	00913423          	sd	s1,8(sp)
    800058e8:	00113c23          	sd	ra,24(sp)
    800058ec:	01213023          	sd	s2,0(sp)
    800058f0:	02010413          	addi	s0,sp,32
    800058f4:	00050493          	mv	s1,a0
    800058f8:	10002973          	csrr	s2,sstatus
    800058fc:	100027f3          	csrr	a5,sstatus
    80005900:	ffd7f793          	andi	a5,a5,-3
    80005904:	10079073          	csrw	sstatus,a5
    80005908:	fffff097          	auipc	ra,0xfffff
    8000590c:	8ec080e7          	jalr	-1812(ra) # 800041f4 <mycpu>
    80005910:	07852783          	lw	a5,120(a0)
    80005914:	06078e63          	beqz	a5,80005990 <acquire+0xb4>
    80005918:	fffff097          	auipc	ra,0xfffff
    8000591c:	8dc080e7          	jalr	-1828(ra) # 800041f4 <mycpu>
    80005920:	07852783          	lw	a5,120(a0)
    80005924:	0004a703          	lw	a4,0(s1)
    80005928:	0017879b          	addiw	a5,a5,1
    8000592c:	06f52c23          	sw	a5,120(a0)
    80005930:	04071063          	bnez	a4,80005970 <acquire+0x94>
    80005934:	00100713          	li	a4,1
    80005938:	00070793          	mv	a5,a4
    8000593c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80005940:	0007879b          	sext.w	a5,a5
    80005944:	fe079ae3          	bnez	a5,80005938 <acquire+0x5c>
    80005948:	0ff0000f          	fence
    8000594c:	fffff097          	auipc	ra,0xfffff
    80005950:	8a8080e7          	jalr	-1880(ra) # 800041f4 <mycpu>
    80005954:	01813083          	ld	ra,24(sp)
    80005958:	01013403          	ld	s0,16(sp)
    8000595c:	00a4b823          	sd	a0,16(s1)
    80005960:	00013903          	ld	s2,0(sp)
    80005964:	00813483          	ld	s1,8(sp)
    80005968:	02010113          	addi	sp,sp,32
    8000596c:	00008067          	ret
    80005970:	0104b903          	ld	s2,16(s1)
    80005974:	fffff097          	auipc	ra,0xfffff
    80005978:	880080e7          	jalr	-1920(ra) # 800041f4 <mycpu>
    8000597c:	faa91ce3          	bne	s2,a0,80005934 <acquire+0x58>
    80005980:	00002517          	auipc	a0,0x2
    80005984:	81850513          	addi	a0,a0,-2024 # 80007198 <digits+0x20>
    80005988:	fffff097          	auipc	ra,0xfffff
    8000598c:	224080e7          	jalr	548(ra) # 80004bac <panic>
    80005990:	00195913          	srli	s2,s2,0x1
    80005994:	fffff097          	auipc	ra,0xfffff
    80005998:	860080e7          	jalr	-1952(ra) # 800041f4 <mycpu>
    8000599c:	00197913          	andi	s2,s2,1
    800059a0:	07252e23          	sw	s2,124(a0)
    800059a4:	f75ff06f          	j	80005918 <acquire+0x3c>

00000000800059a8 <release>:
    800059a8:	fe010113          	addi	sp,sp,-32
    800059ac:	00813823          	sd	s0,16(sp)
    800059b0:	00113c23          	sd	ra,24(sp)
    800059b4:	00913423          	sd	s1,8(sp)
    800059b8:	01213023          	sd	s2,0(sp)
    800059bc:	02010413          	addi	s0,sp,32
    800059c0:	00052783          	lw	a5,0(a0)
    800059c4:	00079a63          	bnez	a5,800059d8 <release+0x30>
    800059c8:	00001517          	auipc	a0,0x1
    800059cc:	7d850513          	addi	a0,a0,2008 # 800071a0 <digits+0x28>
    800059d0:	fffff097          	auipc	ra,0xfffff
    800059d4:	1dc080e7          	jalr	476(ra) # 80004bac <panic>
    800059d8:	01053903          	ld	s2,16(a0)
    800059dc:	00050493          	mv	s1,a0
    800059e0:	fffff097          	auipc	ra,0xfffff
    800059e4:	814080e7          	jalr	-2028(ra) # 800041f4 <mycpu>
    800059e8:	fea910e3          	bne	s2,a0,800059c8 <release+0x20>
    800059ec:	0004b823          	sd	zero,16(s1)
    800059f0:	0ff0000f          	fence
    800059f4:	0f50000f          	fence	iorw,ow
    800059f8:	0804a02f          	amoswap.w	zero,zero,(s1)
    800059fc:	ffffe097          	auipc	ra,0xffffe
    80005a00:	7f8080e7          	jalr	2040(ra) # 800041f4 <mycpu>
    80005a04:	100027f3          	csrr	a5,sstatus
    80005a08:	0027f793          	andi	a5,a5,2
    80005a0c:	04079a63          	bnez	a5,80005a60 <release+0xb8>
    80005a10:	07852783          	lw	a5,120(a0)
    80005a14:	02f05e63          	blez	a5,80005a50 <release+0xa8>
    80005a18:	fff7871b          	addiw	a4,a5,-1
    80005a1c:	06e52c23          	sw	a4,120(a0)
    80005a20:	00071c63          	bnez	a4,80005a38 <release+0x90>
    80005a24:	07c52783          	lw	a5,124(a0)
    80005a28:	00078863          	beqz	a5,80005a38 <release+0x90>
    80005a2c:	100027f3          	csrr	a5,sstatus
    80005a30:	0027e793          	ori	a5,a5,2
    80005a34:	10079073          	csrw	sstatus,a5
    80005a38:	01813083          	ld	ra,24(sp)
    80005a3c:	01013403          	ld	s0,16(sp)
    80005a40:	00813483          	ld	s1,8(sp)
    80005a44:	00013903          	ld	s2,0(sp)
    80005a48:	02010113          	addi	sp,sp,32
    80005a4c:	00008067          	ret
    80005a50:	00001517          	auipc	a0,0x1
    80005a54:	77050513          	addi	a0,a0,1904 # 800071c0 <digits+0x48>
    80005a58:	fffff097          	auipc	ra,0xfffff
    80005a5c:	154080e7          	jalr	340(ra) # 80004bac <panic>
    80005a60:	00001517          	auipc	a0,0x1
    80005a64:	74850513          	addi	a0,a0,1864 # 800071a8 <digits+0x30>
    80005a68:	fffff097          	auipc	ra,0xfffff
    80005a6c:	144080e7          	jalr	324(ra) # 80004bac <panic>

0000000080005a70 <holding>:
    80005a70:	00052783          	lw	a5,0(a0)
    80005a74:	00079663          	bnez	a5,80005a80 <holding+0x10>
    80005a78:	00000513          	li	a0,0
    80005a7c:	00008067          	ret
    80005a80:	fe010113          	addi	sp,sp,-32
    80005a84:	00813823          	sd	s0,16(sp)
    80005a88:	00913423          	sd	s1,8(sp)
    80005a8c:	00113c23          	sd	ra,24(sp)
    80005a90:	02010413          	addi	s0,sp,32
    80005a94:	01053483          	ld	s1,16(a0)
    80005a98:	ffffe097          	auipc	ra,0xffffe
    80005a9c:	75c080e7          	jalr	1884(ra) # 800041f4 <mycpu>
    80005aa0:	01813083          	ld	ra,24(sp)
    80005aa4:	01013403          	ld	s0,16(sp)
    80005aa8:	40a48533          	sub	a0,s1,a0
    80005aac:	00153513          	seqz	a0,a0
    80005ab0:	00813483          	ld	s1,8(sp)
    80005ab4:	02010113          	addi	sp,sp,32
    80005ab8:	00008067          	ret

0000000080005abc <push_off>:
    80005abc:	fe010113          	addi	sp,sp,-32
    80005ac0:	00813823          	sd	s0,16(sp)
    80005ac4:	00113c23          	sd	ra,24(sp)
    80005ac8:	00913423          	sd	s1,8(sp)
    80005acc:	02010413          	addi	s0,sp,32
    80005ad0:	100024f3          	csrr	s1,sstatus
    80005ad4:	100027f3          	csrr	a5,sstatus
    80005ad8:	ffd7f793          	andi	a5,a5,-3
    80005adc:	10079073          	csrw	sstatus,a5
    80005ae0:	ffffe097          	auipc	ra,0xffffe
    80005ae4:	714080e7          	jalr	1812(ra) # 800041f4 <mycpu>
    80005ae8:	07852783          	lw	a5,120(a0)
    80005aec:	02078663          	beqz	a5,80005b18 <push_off+0x5c>
    80005af0:	ffffe097          	auipc	ra,0xffffe
    80005af4:	704080e7          	jalr	1796(ra) # 800041f4 <mycpu>
    80005af8:	07852783          	lw	a5,120(a0)
    80005afc:	01813083          	ld	ra,24(sp)
    80005b00:	01013403          	ld	s0,16(sp)
    80005b04:	0017879b          	addiw	a5,a5,1
    80005b08:	06f52c23          	sw	a5,120(a0)
    80005b0c:	00813483          	ld	s1,8(sp)
    80005b10:	02010113          	addi	sp,sp,32
    80005b14:	00008067          	ret
    80005b18:	0014d493          	srli	s1,s1,0x1
    80005b1c:	ffffe097          	auipc	ra,0xffffe
    80005b20:	6d8080e7          	jalr	1752(ra) # 800041f4 <mycpu>
    80005b24:	0014f493          	andi	s1,s1,1
    80005b28:	06952e23          	sw	s1,124(a0)
    80005b2c:	fc5ff06f          	j	80005af0 <push_off+0x34>

0000000080005b30 <pop_off>:
    80005b30:	ff010113          	addi	sp,sp,-16
    80005b34:	00813023          	sd	s0,0(sp)
    80005b38:	00113423          	sd	ra,8(sp)
    80005b3c:	01010413          	addi	s0,sp,16
    80005b40:	ffffe097          	auipc	ra,0xffffe
    80005b44:	6b4080e7          	jalr	1716(ra) # 800041f4 <mycpu>
    80005b48:	100027f3          	csrr	a5,sstatus
    80005b4c:	0027f793          	andi	a5,a5,2
    80005b50:	04079663          	bnez	a5,80005b9c <pop_off+0x6c>
    80005b54:	07852783          	lw	a5,120(a0)
    80005b58:	02f05a63          	blez	a5,80005b8c <pop_off+0x5c>
    80005b5c:	fff7871b          	addiw	a4,a5,-1
    80005b60:	06e52c23          	sw	a4,120(a0)
    80005b64:	00071c63          	bnez	a4,80005b7c <pop_off+0x4c>
    80005b68:	07c52783          	lw	a5,124(a0)
    80005b6c:	00078863          	beqz	a5,80005b7c <pop_off+0x4c>
    80005b70:	100027f3          	csrr	a5,sstatus
    80005b74:	0027e793          	ori	a5,a5,2
    80005b78:	10079073          	csrw	sstatus,a5
    80005b7c:	00813083          	ld	ra,8(sp)
    80005b80:	00013403          	ld	s0,0(sp)
    80005b84:	01010113          	addi	sp,sp,16
    80005b88:	00008067          	ret
    80005b8c:	00001517          	auipc	a0,0x1
    80005b90:	63450513          	addi	a0,a0,1588 # 800071c0 <digits+0x48>
    80005b94:	fffff097          	auipc	ra,0xfffff
    80005b98:	018080e7          	jalr	24(ra) # 80004bac <panic>
    80005b9c:	00001517          	auipc	a0,0x1
    80005ba0:	60c50513          	addi	a0,a0,1548 # 800071a8 <digits+0x30>
    80005ba4:	fffff097          	auipc	ra,0xfffff
    80005ba8:	008080e7          	jalr	8(ra) # 80004bac <panic>

0000000080005bac <push_on>:
    80005bac:	fe010113          	addi	sp,sp,-32
    80005bb0:	00813823          	sd	s0,16(sp)
    80005bb4:	00113c23          	sd	ra,24(sp)
    80005bb8:	00913423          	sd	s1,8(sp)
    80005bbc:	02010413          	addi	s0,sp,32
    80005bc0:	100024f3          	csrr	s1,sstatus
    80005bc4:	100027f3          	csrr	a5,sstatus
    80005bc8:	0027e793          	ori	a5,a5,2
    80005bcc:	10079073          	csrw	sstatus,a5
    80005bd0:	ffffe097          	auipc	ra,0xffffe
    80005bd4:	624080e7          	jalr	1572(ra) # 800041f4 <mycpu>
    80005bd8:	07852783          	lw	a5,120(a0)
    80005bdc:	02078663          	beqz	a5,80005c08 <push_on+0x5c>
    80005be0:	ffffe097          	auipc	ra,0xffffe
    80005be4:	614080e7          	jalr	1556(ra) # 800041f4 <mycpu>
    80005be8:	07852783          	lw	a5,120(a0)
    80005bec:	01813083          	ld	ra,24(sp)
    80005bf0:	01013403          	ld	s0,16(sp)
    80005bf4:	0017879b          	addiw	a5,a5,1
    80005bf8:	06f52c23          	sw	a5,120(a0)
    80005bfc:	00813483          	ld	s1,8(sp)
    80005c00:	02010113          	addi	sp,sp,32
    80005c04:	00008067          	ret
    80005c08:	0014d493          	srli	s1,s1,0x1
    80005c0c:	ffffe097          	auipc	ra,0xffffe
    80005c10:	5e8080e7          	jalr	1512(ra) # 800041f4 <mycpu>
    80005c14:	0014f493          	andi	s1,s1,1
    80005c18:	06952e23          	sw	s1,124(a0)
    80005c1c:	fc5ff06f          	j	80005be0 <push_on+0x34>

0000000080005c20 <pop_on>:
    80005c20:	ff010113          	addi	sp,sp,-16
    80005c24:	00813023          	sd	s0,0(sp)
    80005c28:	00113423          	sd	ra,8(sp)
    80005c2c:	01010413          	addi	s0,sp,16
    80005c30:	ffffe097          	auipc	ra,0xffffe
    80005c34:	5c4080e7          	jalr	1476(ra) # 800041f4 <mycpu>
    80005c38:	100027f3          	csrr	a5,sstatus
    80005c3c:	0027f793          	andi	a5,a5,2
    80005c40:	04078463          	beqz	a5,80005c88 <pop_on+0x68>
    80005c44:	07852783          	lw	a5,120(a0)
    80005c48:	02f05863          	blez	a5,80005c78 <pop_on+0x58>
    80005c4c:	fff7879b          	addiw	a5,a5,-1
    80005c50:	06f52c23          	sw	a5,120(a0)
    80005c54:	07853783          	ld	a5,120(a0)
    80005c58:	00079863          	bnez	a5,80005c68 <pop_on+0x48>
    80005c5c:	100027f3          	csrr	a5,sstatus
    80005c60:	ffd7f793          	andi	a5,a5,-3
    80005c64:	10079073          	csrw	sstatus,a5
    80005c68:	00813083          	ld	ra,8(sp)
    80005c6c:	00013403          	ld	s0,0(sp)
    80005c70:	01010113          	addi	sp,sp,16
    80005c74:	00008067          	ret
    80005c78:	00001517          	auipc	a0,0x1
    80005c7c:	57050513          	addi	a0,a0,1392 # 800071e8 <digits+0x70>
    80005c80:	fffff097          	auipc	ra,0xfffff
    80005c84:	f2c080e7          	jalr	-212(ra) # 80004bac <panic>
    80005c88:	00001517          	auipc	a0,0x1
    80005c8c:	54050513          	addi	a0,a0,1344 # 800071c8 <digits+0x50>
    80005c90:	fffff097          	auipc	ra,0xfffff
    80005c94:	f1c080e7          	jalr	-228(ra) # 80004bac <panic>

0000000080005c98 <__memset>:
    80005c98:	ff010113          	addi	sp,sp,-16
    80005c9c:	00813423          	sd	s0,8(sp)
    80005ca0:	01010413          	addi	s0,sp,16
    80005ca4:	1a060e63          	beqz	a2,80005e60 <__memset+0x1c8>
    80005ca8:	40a007b3          	neg	a5,a0
    80005cac:	0077f793          	andi	a5,a5,7
    80005cb0:	00778693          	addi	a3,a5,7
    80005cb4:	00b00813          	li	a6,11
    80005cb8:	0ff5f593          	andi	a1,a1,255
    80005cbc:	fff6071b          	addiw	a4,a2,-1
    80005cc0:	1b06e663          	bltu	a3,a6,80005e6c <__memset+0x1d4>
    80005cc4:	1cd76463          	bltu	a4,a3,80005e8c <__memset+0x1f4>
    80005cc8:	1a078e63          	beqz	a5,80005e84 <__memset+0x1ec>
    80005ccc:	00b50023          	sb	a1,0(a0)
    80005cd0:	00100713          	li	a4,1
    80005cd4:	1ae78463          	beq	a5,a4,80005e7c <__memset+0x1e4>
    80005cd8:	00b500a3          	sb	a1,1(a0)
    80005cdc:	00200713          	li	a4,2
    80005ce0:	1ae78a63          	beq	a5,a4,80005e94 <__memset+0x1fc>
    80005ce4:	00b50123          	sb	a1,2(a0)
    80005ce8:	00300713          	li	a4,3
    80005cec:	18e78463          	beq	a5,a4,80005e74 <__memset+0x1dc>
    80005cf0:	00b501a3          	sb	a1,3(a0)
    80005cf4:	00400713          	li	a4,4
    80005cf8:	1ae78263          	beq	a5,a4,80005e9c <__memset+0x204>
    80005cfc:	00b50223          	sb	a1,4(a0)
    80005d00:	00500713          	li	a4,5
    80005d04:	1ae78063          	beq	a5,a4,80005ea4 <__memset+0x20c>
    80005d08:	00b502a3          	sb	a1,5(a0)
    80005d0c:	00700713          	li	a4,7
    80005d10:	18e79e63          	bne	a5,a4,80005eac <__memset+0x214>
    80005d14:	00b50323          	sb	a1,6(a0)
    80005d18:	00700e93          	li	t4,7
    80005d1c:	00859713          	slli	a4,a1,0x8
    80005d20:	00e5e733          	or	a4,a1,a4
    80005d24:	01059e13          	slli	t3,a1,0x10
    80005d28:	01c76e33          	or	t3,a4,t3
    80005d2c:	01859313          	slli	t1,a1,0x18
    80005d30:	006e6333          	or	t1,t3,t1
    80005d34:	02059893          	slli	a7,a1,0x20
    80005d38:	40f60e3b          	subw	t3,a2,a5
    80005d3c:	011368b3          	or	a7,t1,a7
    80005d40:	02859813          	slli	a6,a1,0x28
    80005d44:	0108e833          	or	a6,a7,a6
    80005d48:	03059693          	slli	a3,a1,0x30
    80005d4c:	003e589b          	srliw	a7,t3,0x3
    80005d50:	00d866b3          	or	a3,a6,a3
    80005d54:	03859713          	slli	a4,a1,0x38
    80005d58:	00389813          	slli	a6,a7,0x3
    80005d5c:	00f507b3          	add	a5,a0,a5
    80005d60:	00e6e733          	or	a4,a3,a4
    80005d64:	000e089b          	sext.w	a7,t3
    80005d68:	00f806b3          	add	a3,a6,a5
    80005d6c:	00e7b023          	sd	a4,0(a5)
    80005d70:	00878793          	addi	a5,a5,8
    80005d74:	fed79ce3          	bne	a5,a3,80005d6c <__memset+0xd4>
    80005d78:	ff8e7793          	andi	a5,t3,-8
    80005d7c:	0007871b          	sext.w	a4,a5
    80005d80:	01d787bb          	addw	a5,a5,t4
    80005d84:	0ce88e63          	beq	a7,a4,80005e60 <__memset+0x1c8>
    80005d88:	00f50733          	add	a4,a0,a5
    80005d8c:	00b70023          	sb	a1,0(a4)
    80005d90:	0017871b          	addiw	a4,a5,1
    80005d94:	0cc77663          	bgeu	a4,a2,80005e60 <__memset+0x1c8>
    80005d98:	00e50733          	add	a4,a0,a4
    80005d9c:	00b70023          	sb	a1,0(a4)
    80005da0:	0027871b          	addiw	a4,a5,2
    80005da4:	0ac77e63          	bgeu	a4,a2,80005e60 <__memset+0x1c8>
    80005da8:	00e50733          	add	a4,a0,a4
    80005dac:	00b70023          	sb	a1,0(a4)
    80005db0:	0037871b          	addiw	a4,a5,3
    80005db4:	0ac77663          	bgeu	a4,a2,80005e60 <__memset+0x1c8>
    80005db8:	00e50733          	add	a4,a0,a4
    80005dbc:	00b70023          	sb	a1,0(a4)
    80005dc0:	0047871b          	addiw	a4,a5,4
    80005dc4:	08c77e63          	bgeu	a4,a2,80005e60 <__memset+0x1c8>
    80005dc8:	00e50733          	add	a4,a0,a4
    80005dcc:	00b70023          	sb	a1,0(a4)
    80005dd0:	0057871b          	addiw	a4,a5,5
    80005dd4:	08c77663          	bgeu	a4,a2,80005e60 <__memset+0x1c8>
    80005dd8:	00e50733          	add	a4,a0,a4
    80005ddc:	00b70023          	sb	a1,0(a4)
    80005de0:	0067871b          	addiw	a4,a5,6
    80005de4:	06c77e63          	bgeu	a4,a2,80005e60 <__memset+0x1c8>
    80005de8:	00e50733          	add	a4,a0,a4
    80005dec:	00b70023          	sb	a1,0(a4)
    80005df0:	0077871b          	addiw	a4,a5,7
    80005df4:	06c77663          	bgeu	a4,a2,80005e60 <__memset+0x1c8>
    80005df8:	00e50733          	add	a4,a0,a4
    80005dfc:	00b70023          	sb	a1,0(a4)
    80005e00:	0087871b          	addiw	a4,a5,8
    80005e04:	04c77e63          	bgeu	a4,a2,80005e60 <__memset+0x1c8>
    80005e08:	00e50733          	add	a4,a0,a4
    80005e0c:	00b70023          	sb	a1,0(a4)
    80005e10:	0097871b          	addiw	a4,a5,9
    80005e14:	04c77663          	bgeu	a4,a2,80005e60 <__memset+0x1c8>
    80005e18:	00e50733          	add	a4,a0,a4
    80005e1c:	00b70023          	sb	a1,0(a4)
    80005e20:	00a7871b          	addiw	a4,a5,10
    80005e24:	02c77e63          	bgeu	a4,a2,80005e60 <__memset+0x1c8>
    80005e28:	00e50733          	add	a4,a0,a4
    80005e2c:	00b70023          	sb	a1,0(a4)
    80005e30:	00b7871b          	addiw	a4,a5,11
    80005e34:	02c77663          	bgeu	a4,a2,80005e60 <__memset+0x1c8>
    80005e38:	00e50733          	add	a4,a0,a4
    80005e3c:	00b70023          	sb	a1,0(a4)
    80005e40:	00c7871b          	addiw	a4,a5,12
    80005e44:	00c77e63          	bgeu	a4,a2,80005e60 <__memset+0x1c8>
    80005e48:	00e50733          	add	a4,a0,a4
    80005e4c:	00b70023          	sb	a1,0(a4)
    80005e50:	00d7879b          	addiw	a5,a5,13
    80005e54:	00c7f663          	bgeu	a5,a2,80005e60 <__memset+0x1c8>
    80005e58:	00f507b3          	add	a5,a0,a5
    80005e5c:	00b78023          	sb	a1,0(a5)
    80005e60:	00813403          	ld	s0,8(sp)
    80005e64:	01010113          	addi	sp,sp,16
    80005e68:	00008067          	ret
    80005e6c:	00b00693          	li	a3,11
    80005e70:	e55ff06f          	j	80005cc4 <__memset+0x2c>
    80005e74:	00300e93          	li	t4,3
    80005e78:	ea5ff06f          	j	80005d1c <__memset+0x84>
    80005e7c:	00100e93          	li	t4,1
    80005e80:	e9dff06f          	j	80005d1c <__memset+0x84>
    80005e84:	00000e93          	li	t4,0
    80005e88:	e95ff06f          	j	80005d1c <__memset+0x84>
    80005e8c:	00000793          	li	a5,0
    80005e90:	ef9ff06f          	j	80005d88 <__memset+0xf0>
    80005e94:	00200e93          	li	t4,2
    80005e98:	e85ff06f          	j	80005d1c <__memset+0x84>
    80005e9c:	00400e93          	li	t4,4
    80005ea0:	e7dff06f          	j	80005d1c <__memset+0x84>
    80005ea4:	00500e93          	li	t4,5
    80005ea8:	e75ff06f          	j	80005d1c <__memset+0x84>
    80005eac:	00600e93          	li	t4,6
    80005eb0:	e6dff06f          	j	80005d1c <__memset+0x84>

0000000080005eb4 <__memmove>:
    80005eb4:	ff010113          	addi	sp,sp,-16
    80005eb8:	00813423          	sd	s0,8(sp)
    80005ebc:	01010413          	addi	s0,sp,16
    80005ec0:	0e060863          	beqz	a2,80005fb0 <__memmove+0xfc>
    80005ec4:	fff6069b          	addiw	a3,a2,-1
    80005ec8:	0006881b          	sext.w	a6,a3
    80005ecc:	0ea5e863          	bltu	a1,a0,80005fbc <__memmove+0x108>
    80005ed0:	00758713          	addi	a4,a1,7
    80005ed4:	00a5e7b3          	or	a5,a1,a0
    80005ed8:	40a70733          	sub	a4,a4,a0
    80005edc:	0077f793          	andi	a5,a5,7
    80005ee0:	00f73713          	sltiu	a4,a4,15
    80005ee4:	00174713          	xori	a4,a4,1
    80005ee8:	0017b793          	seqz	a5,a5
    80005eec:	00e7f7b3          	and	a5,a5,a4
    80005ef0:	10078863          	beqz	a5,80006000 <__memmove+0x14c>
    80005ef4:	00900793          	li	a5,9
    80005ef8:	1107f463          	bgeu	a5,a6,80006000 <__memmove+0x14c>
    80005efc:	0036581b          	srliw	a6,a2,0x3
    80005f00:	fff8081b          	addiw	a6,a6,-1
    80005f04:	02081813          	slli	a6,a6,0x20
    80005f08:	01d85893          	srli	a7,a6,0x1d
    80005f0c:	00858813          	addi	a6,a1,8
    80005f10:	00058793          	mv	a5,a1
    80005f14:	00050713          	mv	a4,a0
    80005f18:	01088833          	add	a6,a7,a6
    80005f1c:	0007b883          	ld	a7,0(a5)
    80005f20:	00878793          	addi	a5,a5,8
    80005f24:	00870713          	addi	a4,a4,8
    80005f28:	ff173c23          	sd	a7,-8(a4)
    80005f2c:	ff0798e3          	bne	a5,a6,80005f1c <__memmove+0x68>
    80005f30:	ff867713          	andi	a4,a2,-8
    80005f34:	02071793          	slli	a5,a4,0x20
    80005f38:	0207d793          	srli	a5,a5,0x20
    80005f3c:	00f585b3          	add	a1,a1,a5
    80005f40:	40e686bb          	subw	a3,a3,a4
    80005f44:	00f507b3          	add	a5,a0,a5
    80005f48:	06e60463          	beq	a2,a4,80005fb0 <__memmove+0xfc>
    80005f4c:	0005c703          	lbu	a4,0(a1)
    80005f50:	00e78023          	sb	a4,0(a5)
    80005f54:	04068e63          	beqz	a3,80005fb0 <__memmove+0xfc>
    80005f58:	0015c603          	lbu	a2,1(a1)
    80005f5c:	00100713          	li	a4,1
    80005f60:	00c780a3          	sb	a2,1(a5)
    80005f64:	04e68663          	beq	a3,a4,80005fb0 <__memmove+0xfc>
    80005f68:	0025c603          	lbu	a2,2(a1)
    80005f6c:	00200713          	li	a4,2
    80005f70:	00c78123          	sb	a2,2(a5)
    80005f74:	02e68e63          	beq	a3,a4,80005fb0 <__memmove+0xfc>
    80005f78:	0035c603          	lbu	a2,3(a1)
    80005f7c:	00300713          	li	a4,3
    80005f80:	00c781a3          	sb	a2,3(a5)
    80005f84:	02e68663          	beq	a3,a4,80005fb0 <__memmove+0xfc>
    80005f88:	0045c603          	lbu	a2,4(a1)
    80005f8c:	00400713          	li	a4,4
    80005f90:	00c78223          	sb	a2,4(a5)
    80005f94:	00e68e63          	beq	a3,a4,80005fb0 <__memmove+0xfc>
    80005f98:	0055c603          	lbu	a2,5(a1)
    80005f9c:	00500713          	li	a4,5
    80005fa0:	00c782a3          	sb	a2,5(a5)
    80005fa4:	00e68663          	beq	a3,a4,80005fb0 <__memmove+0xfc>
    80005fa8:	0065c703          	lbu	a4,6(a1)
    80005fac:	00e78323          	sb	a4,6(a5)
    80005fb0:	00813403          	ld	s0,8(sp)
    80005fb4:	01010113          	addi	sp,sp,16
    80005fb8:	00008067          	ret
    80005fbc:	02061713          	slli	a4,a2,0x20
    80005fc0:	02075713          	srli	a4,a4,0x20
    80005fc4:	00e587b3          	add	a5,a1,a4
    80005fc8:	f0f574e3          	bgeu	a0,a5,80005ed0 <__memmove+0x1c>
    80005fcc:	02069613          	slli	a2,a3,0x20
    80005fd0:	02065613          	srli	a2,a2,0x20
    80005fd4:	fff64613          	not	a2,a2
    80005fd8:	00e50733          	add	a4,a0,a4
    80005fdc:	00c78633          	add	a2,a5,a2
    80005fe0:	fff7c683          	lbu	a3,-1(a5)
    80005fe4:	fff78793          	addi	a5,a5,-1
    80005fe8:	fff70713          	addi	a4,a4,-1
    80005fec:	00d70023          	sb	a3,0(a4)
    80005ff0:	fec798e3          	bne	a5,a2,80005fe0 <__memmove+0x12c>
    80005ff4:	00813403          	ld	s0,8(sp)
    80005ff8:	01010113          	addi	sp,sp,16
    80005ffc:	00008067          	ret
    80006000:	02069713          	slli	a4,a3,0x20
    80006004:	02075713          	srli	a4,a4,0x20
    80006008:	00170713          	addi	a4,a4,1
    8000600c:	00e50733          	add	a4,a0,a4
    80006010:	00050793          	mv	a5,a0
    80006014:	0005c683          	lbu	a3,0(a1)
    80006018:	00178793          	addi	a5,a5,1
    8000601c:	00158593          	addi	a1,a1,1
    80006020:	fed78fa3          	sb	a3,-1(a5)
    80006024:	fee798e3          	bne	a5,a4,80006014 <__memmove+0x160>
    80006028:	f89ff06f          	j	80005fb0 <__memmove+0xfc>
	...
