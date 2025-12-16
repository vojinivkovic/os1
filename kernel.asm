
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00007117          	auipc	sp,0x7
    80000004:	0e013103          	ld	sp,224(sp) # 800070e0 <_GLOBAL_OFFSET_TABLE_+0x30>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	490030ef          	jal	ra,800034ac <start>

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

    addi s0, sp, 0
    800010f4:	00010413          	mv	s0,sp
    auipc t0, 0
    800010f8:	00000297          	auipc	t0,0x0
    addi t0, t0, 16
    800010fc:	01028293          	addi	t0,t0,16 # 80001108 <system_stack+0x9c>
    csrw sscratch, t0
    80001100:	14029073          	csrw	sscratch,t0

    call _ZN6Kernel16interruptHandlerEv
    80001104:	738010ef          	jal	ra,8000283c <_ZN6Kernel16interruptHandlerEv>

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
    800011e4:	070080e7          	jalr	112(ra) # 80002250 <_ZN15MemoryAllocator17getSizeOfMetaDataEv>
    800011e8:	00950933          	add	s2,a0,s1
    800011ec:	00695913          	srli	s2,s2,0x6
    size_of_blocks += (size + MemoryAllocator::getSizeOfMetaData()) % MEM_BLOCK_SIZE ? 1: 0;
    800011f0:	00001097          	auipc	ra,0x1
    800011f4:	060080e7          	jalr	96(ra) # 80002250 <_ZN15MemoryAllocator17getSizeOfMetaDataEv>
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

    Arguments arg = {(uint64)KernelConfig::THREAD_CREATE, (uint64)handle, (uint64)start_routine, (uint64)argOfRoutine, (uint64)(&threadStack[DEFAULT_STACK_SIZE]), 0, 0, 0};
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

000000008000148c <_Z8sem_openPP10KSemaphorej>:

int sem_open(sem_t* handle, unsigned init)
{
    8000148c:	fb010113          	addi	sp,sp,-80
    80001490:	04113423          	sd	ra,72(sp)
    80001494:	04813023          	sd	s0,64(sp)
    80001498:	05010413          	addi	s0,sp,80
    Arguments arg = {(uint64)KernelConfig::SEMAPHORE_OPEN, (uint64)handle, (uint64)init, 0, 0, 0, 0, 0};
    8000149c:	fc043423          	sd	zero,-56(s0)
    800014a0:	fc043823          	sd	zero,-48(s0)
    800014a4:	fc043c23          	sd	zero,-40(s0)
    800014a8:	fe043023          	sd	zero,-32(s0)
    800014ac:	fe043423          	sd	zero,-24(s0)
    800014b0:	02100793          	li	a5,33
    800014b4:	faf43823          	sd	a5,-80(s0)
    800014b8:	faa43c23          	sd	a0,-72(s0)
    800014bc:	02059593          	slli	a1,a1,0x20
    800014c0:	0205d593          	srli	a1,a1,0x20
    800014c4:	fcb43023          	sd	a1,-64(s0)
    return (int) system_call(&arg);
    800014c8:	fb040513          	addi	a0,s0,-80
    800014cc:	00000097          	auipc	ra,0x0
    800014d0:	b54080e7          	jalr	-1196(ra) # 80001020 <system_call>
}
    800014d4:	0005051b          	sext.w	a0,a0
    800014d8:	04813083          	ld	ra,72(sp)
    800014dc:	04013403          	ld	s0,64(sp)
    800014e0:	05010113          	addi	sp,sp,80
    800014e4:	00008067          	ret

00000000800014e8 <_Z9sem_closeP10KSemaphore>:

int sem_close(sem_t handle)
{
    800014e8:	fb010113          	addi	sp,sp,-80
    800014ec:	04113423          	sd	ra,72(sp)
    800014f0:	04813023          	sd	s0,64(sp)
    800014f4:	05010413          	addi	s0,sp,80
    Arguments arg = {(uint64)KernelConfig::SEMAPHORE_CLOSE, (uint64)handle, 0, 0, 0, 0, 0, 0};
    800014f8:	fc043023          	sd	zero,-64(s0)
    800014fc:	fc043423          	sd	zero,-56(s0)
    80001500:	fc043823          	sd	zero,-48(s0)
    80001504:	fc043c23          	sd	zero,-40(s0)
    80001508:	fe043023          	sd	zero,-32(s0)
    8000150c:	fe043423          	sd	zero,-24(s0)
    80001510:	02200793          	li	a5,34
    80001514:	faf43823          	sd	a5,-80(s0)
    80001518:	faa43c23          	sd	a0,-72(s0)
    return (int) system_call(&arg);
    8000151c:	fb040513          	addi	a0,s0,-80
    80001520:	00000097          	auipc	ra,0x0
    80001524:	b00080e7          	jalr	-1280(ra) # 80001020 <system_call>
}
    80001528:	0005051b          	sext.w	a0,a0
    8000152c:	04813083          	ld	ra,72(sp)
    80001530:	04013403          	ld	s0,64(sp)
    80001534:	05010113          	addi	sp,sp,80
    80001538:	00008067          	ret

000000008000153c <_Z8sem_waitP10KSemaphore>:

int sem_wait(sem_t handle)
{
    8000153c:	fb010113          	addi	sp,sp,-80
    80001540:	04113423          	sd	ra,72(sp)
    80001544:	04813023          	sd	s0,64(sp)
    80001548:	05010413          	addi	s0,sp,80
    Arguments arg = {(uint64)KernelConfig::SEMAPHORE_WAIT, (uint64)handle, 0, 0, 0, 0, 0, 0};
    8000154c:	fc043023          	sd	zero,-64(s0)
    80001550:	fc043423          	sd	zero,-56(s0)
    80001554:	fc043823          	sd	zero,-48(s0)
    80001558:	fc043c23          	sd	zero,-40(s0)
    8000155c:	fe043023          	sd	zero,-32(s0)
    80001560:	fe043423          	sd	zero,-24(s0)
    80001564:	02300793          	li	a5,35
    80001568:	faf43823          	sd	a5,-80(s0)
    8000156c:	faa43c23          	sd	a0,-72(s0)
    return (int) system_call(&arg);
    80001570:	fb040513          	addi	a0,s0,-80
    80001574:	00000097          	auipc	ra,0x0
    80001578:	aac080e7          	jalr	-1364(ra) # 80001020 <system_call>
}
    8000157c:	0005051b          	sext.w	a0,a0
    80001580:	04813083          	ld	ra,72(sp)
    80001584:	04013403          	ld	s0,64(sp)
    80001588:	05010113          	addi	sp,sp,80
    8000158c:	00008067          	ret

0000000080001590 <_Z10sem_signalP10KSemaphore>:

int sem_signal(sem_t handle)
{
    80001590:	fb010113          	addi	sp,sp,-80
    80001594:	04113423          	sd	ra,72(sp)
    80001598:	04813023          	sd	s0,64(sp)
    8000159c:	05010413          	addi	s0,sp,80
    Arguments arg = {(uint64)KernelConfig::SEMAPHORE_SIGNAL, (uint64)handle, 0, 0, 0, 0, 0, 0};
    800015a0:	fc043023          	sd	zero,-64(s0)
    800015a4:	fc043423          	sd	zero,-56(s0)
    800015a8:	fc043823          	sd	zero,-48(s0)
    800015ac:	fc043c23          	sd	zero,-40(s0)
    800015b0:	fe043023          	sd	zero,-32(s0)
    800015b4:	fe043423          	sd	zero,-24(s0)
    800015b8:	02400793          	li	a5,36
    800015bc:	faf43823          	sd	a5,-80(s0)
    800015c0:	faa43c23          	sd	a0,-72(s0)
    return (int) system_call(&arg);
    800015c4:	fb040513          	addi	a0,s0,-80
    800015c8:	00000097          	auipc	ra,0x0
    800015cc:	a58080e7          	jalr	-1448(ra) # 80001020 <system_call>
}
    800015d0:	0005051b          	sext.w	a0,a0
    800015d4:	04813083          	ld	ra,72(sp)
    800015d8:	04013403          	ld	s0,64(sp)
    800015dc:	05010113          	addi	sp,sp,80
    800015e0:	00008067          	ret

00000000800015e4 <_Z4getcv>:

char getc()
{
    800015e4:	fb010113          	addi	sp,sp,-80
    800015e8:	04113423          	sd	ra,72(sp)
    800015ec:	04813023          	sd	s0,64(sp)
    800015f0:	05010413          	addi	s0,sp,80
    Arguments arg = {(uint64)KernelConfig::GETC, 0, 0, 0, 0, 0, 0, 0};
    800015f4:	04100793          	li	a5,65
    800015f8:	faf43823          	sd	a5,-80(s0)
    800015fc:	fa043c23          	sd	zero,-72(s0)
    80001600:	fc043023          	sd	zero,-64(s0)
    80001604:	fc043423          	sd	zero,-56(s0)
    80001608:	fc043823          	sd	zero,-48(s0)
    8000160c:	fc043c23          	sd	zero,-40(s0)
    80001610:	fe043023          	sd	zero,-32(s0)
    80001614:	fe043423          	sd	zero,-24(s0)
    return (char) system_call(&arg);
    80001618:	fb040513          	addi	a0,s0,-80
    8000161c:	00000097          	auipc	ra,0x0
    80001620:	a04080e7          	jalr	-1532(ra) # 80001020 <system_call>
}
    80001624:	0ff57513          	andi	a0,a0,255
    80001628:	04813083          	ld	ra,72(sp)
    8000162c:	04013403          	ld	s0,64(sp)
    80001630:	05010113          	addi	sp,sp,80
    80001634:	00008067          	ret

0000000080001638 <_Z4putcc>:

void putc(char c)
{
    80001638:	fb010113          	addi	sp,sp,-80
    8000163c:	04113423          	sd	ra,72(sp)
    80001640:	04813023          	sd	s0,64(sp)
    80001644:	05010413          	addi	s0,sp,80
    Arguments arg = {(uint64)KernelConfig::PUTC, (uint64) c, 0, 0, 0, 0, 0, 0};
    80001648:	fc043023          	sd	zero,-64(s0)
    8000164c:	fc043423          	sd	zero,-56(s0)
    80001650:	fc043823          	sd	zero,-48(s0)
    80001654:	fc043c23          	sd	zero,-40(s0)
    80001658:	fe043023          	sd	zero,-32(s0)
    8000165c:	fe043423          	sd	zero,-24(s0)
    80001660:	04200793          	li	a5,66
    80001664:	faf43823          	sd	a5,-80(s0)
    80001668:	faa43c23          	sd	a0,-72(s0)
    system_call(&arg);
    8000166c:	fb040513          	addi	a0,s0,-80
    80001670:	00000097          	auipc	ra,0x0
    80001674:	9b0080e7          	jalr	-1616(ra) # 80001020 <system_call>
    80001678:	04813083          	ld	ra,72(sp)
    8000167c:	04013403          	ld	s0,64(sp)
    80001680:	05010113          	addi	sp,sp,80
    80001684:	00008067          	ret

0000000080001688 <_ZN8KConsole25addThreadToInputWaitQueueEP3TCB>:
TCB* KConsole::tailThreadInputWait = nullptr;
TCB* KConsole::headThreadOutputWait = nullptr;
TCB* KConsole::tailThreadOutputWait = nullptr;

void KConsole::addThreadToInputWaitQueue(TCB *thread)
{
    80001688:	ff010113          	addi	sp,sp,-16
    8000168c:	00813423          	sd	s0,8(sp)
    80001690:	01010413          	addi	s0,sp,16
    if(!headThreadInputWait)
    80001694:	00006797          	auipc	a5,0x6
    80001698:	afc7b783          	ld	a5,-1284(a5) # 80007190 <_ZN8KConsole19headThreadInputWaitE>
    8000169c:	02078263          	beqz	a5,800016c0 <_ZN8KConsole25addThreadToInputWaitQueueEP3TCB+0x38>
    {
        headThreadInputWait = thread;
    }
    else
    {
        tailThreadInputWait->addThreadToState(thread);
    800016a0:	00006797          	auipc	a5,0x6
    800016a4:	af87b783          	ld	a5,-1288(a5) # 80007198 <_ZN8KConsole19tailThreadInputWaitE>

    size_t getTimeSlice() const { return timeSlice; }
    bool isFinished() const { return finished; }
    void setIsFinished() { finished = true; }

    void addThreadToState(TCB* newThread) { state = newThread; }
    800016a8:	04a7b423          	sd	a0,72(a5)
    }
    tailThreadInputWait = thread;
    800016ac:	00006797          	auipc	a5,0x6
    800016b0:	aea7b623          	sd	a0,-1300(a5) # 80007198 <_ZN8KConsole19tailThreadInputWaitE>
}
    800016b4:	00813403          	ld	s0,8(sp)
    800016b8:	01010113          	addi	sp,sp,16
    800016bc:	00008067          	ret
        headThreadInputWait = thread;
    800016c0:	00006797          	auipc	a5,0x6
    800016c4:	aca7b823          	sd	a0,-1328(a5) # 80007190 <_ZN8KConsole19headThreadInputWaitE>
    800016c8:	fe5ff06f          	j	800016ac <_ZN8KConsole25addThreadToInputWaitQueueEP3TCB+0x24>

00000000800016cc <_ZN8KConsole26addThreadToOutputWaitQueueEP3TCB>:

void KConsole::addThreadToOutputWaitQueue(TCB* thread)
{
    800016cc:	ff010113          	addi	sp,sp,-16
    800016d0:	00813423          	sd	s0,8(sp)
    800016d4:	01010413          	addi	s0,sp,16
    if(!headThreadOutputWait)
    800016d8:	00006797          	auipc	a5,0x6
    800016dc:	ac87b783          	ld	a5,-1336(a5) # 800071a0 <_ZN8KConsole20headThreadOutputWaitE>
    800016e0:	02078263          	beqz	a5,80001704 <_ZN8KConsole26addThreadToOutputWaitQueueEP3TCB+0x38>
    {
        headThreadOutputWait = thread;
    }
    else
    {
        tailThreadOutputWait->addThreadToState(thread);
    800016e4:	00006797          	auipc	a5,0x6
    800016e8:	ac47b783          	ld	a5,-1340(a5) # 800071a8 <_ZN8KConsole20tailThreadOutputWaitE>
    800016ec:	04a7b423          	sd	a0,72(a5)
    }
    tailThreadOutputWait = thread;
    800016f0:	00006797          	auipc	a5,0x6
    800016f4:	aaa7bc23          	sd	a0,-1352(a5) # 800071a8 <_ZN8KConsole20tailThreadOutputWaitE>
}
    800016f8:	00813403          	ld	s0,8(sp)
    800016fc:	01010113          	addi	sp,sp,16
    80001700:	00008067          	ret
        headThreadOutputWait = thread;
    80001704:	00006797          	auipc	a5,0x6
    80001708:	a8a7be23          	sd	a0,-1380(a5) # 800071a0 <_ZN8KConsole20headThreadOutputWaitE>
    8000170c:	fe5ff06f          	j	800016f0 <_ZN8KConsole26addThreadToOutputWaitQueueEP3TCB+0x24>

0000000080001710 <_ZN8KConsole30removeThreadFromInputWaitQueueEv>:

void KConsole::removeThreadFromInputWaitQueue()
{
    if(!headThreadInputWait)
    80001710:	00006517          	auipc	a0,0x6
    80001714:	a8053503          	ld	a0,-1408(a0) # 80007190 <_ZN8KConsole19headThreadInputWaitE>
    80001718:	04050663          	beqz	a0,80001764 <_ZN8KConsole30removeThreadFromInputWaitQueueEv+0x54>
{
    8000171c:	ff010113          	addi	sp,sp,-16
    80001720:	00113423          	sd	ra,8(sp)
    80001724:	00813023          	sd	s0,0(sp)
    80001728:	01010413          	addi	s0,sp,16
    TCB* getState() const { return state; }
    8000172c:	04853783          	ld	a5,72(a0)
    {
        return;
    }
    TCB* oldThread = headThreadInputWait;
    headThreadInputWait = headThreadInputWait->getState();
    80001730:	00006717          	auipc	a4,0x6
    80001734:	a6f73023          	sd	a5,-1440(a4) # 80007190 <_ZN8KConsole19headThreadInputWaitE>
    if(!headThreadInputWait)
    80001738:	02078063          	beqz	a5,80001758 <_ZN8KConsole30removeThreadFromInputWaitQueueEv+0x48>
    void resetState() {state = nullptr; }
    8000173c:	04053423          	sd	zero,72(a0)
    {
        tailThreadInputWait = nullptr;
    }
    oldThread->resetState();
    Scheduler::put(oldThread);
    80001740:	00000097          	auipc	ra,0x0
    80001744:	4c0080e7          	jalr	1216(ra) # 80001c00 <_ZN9Scheduler3putEP3TCB>
}
    80001748:	00813083          	ld	ra,8(sp)
    8000174c:	00013403          	ld	s0,0(sp)
    80001750:	01010113          	addi	sp,sp,16
    80001754:	00008067          	ret
        tailThreadInputWait = nullptr;
    80001758:	00006797          	auipc	a5,0x6
    8000175c:	a407b023          	sd	zero,-1472(a5) # 80007198 <_ZN8KConsole19tailThreadInputWaitE>
    80001760:	fddff06f          	j	8000173c <_ZN8KConsole30removeThreadFromInputWaitQueueEv+0x2c>
    80001764:	00008067          	ret

0000000080001768 <_ZN8KConsole31removeThreadFromOutputWaitQueueEv>:
void KConsole::removeThreadFromOutputWaitQueue()
{
    if(!headThreadOutputWait)
    80001768:	00006517          	auipc	a0,0x6
    8000176c:	a3853503          	ld	a0,-1480(a0) # 800071a0 <_ZN8KConsole20headThreadOutputWaitE>
    80001770:	04050663          	beqz	a0,800017bc <_ZN8KConsole31removeThreadFromOutputWaitQueueEv+0x54>
{
    80001774:	ff010113          	addi	sp,sp,-16
    80001778:	00113423          	sd	ra,8(sp)
    8000177c:	00813023          	sd	s0,0(sp)
    80001780:	01010413          	addi	s0,sp,16
    TCB* getState() const { return state; }
    80001784:	04853783          	ld	a5,72(a0)
    {
        return;
    }
    TCB* oldThread = headThreadOutputWait;
    headThreadOutputWait = headThreadOutputWait->getState();
    80001788:	00006717          	auipc	a4,0x6
    8000178c:	a0f73c23          	sd	a5,-1512(a4) # 800071a0 <_ZN8KConsole20headThreadOutputWaitE>
    if(!headThreadOutputWait)
    80001790:	02078063          	beqz	a5,800017b0 <_ZN8KConsole31removeThreadFromOutputWaitQueueEv+0x48>
    void resetState() {state = nullptr; }
    80001794:	04053423          	sd	zero,72(a0)
    {
        tailThreadOutputWait = nullptr;
    }
    oldThread->resetState();
    Scheduler::put(oldThread);
    80001798:	00000097          	auipc	ra,0x0
    8000179c:	468080e7          	jalr	1128(ra) # 80001c00 <_ZN9Scheduler3putEP3TCB>
}
    800017a0:	00813083          	ld	ra,8(sp)
    800017a4:	00013403          	ld	s0,0(sp)
    800017a8:	01010113          	addi	sp,sp,16
    800017ac:	00008067          	ret
        tailThreadOutputWait = nullptr;
    800017b0:	00006797          	auipc	a5,0x6
    800017b4:	9e07bc23          	sd	zero,-1544(a5) # 800071a8 <_ZN8KConsole20tailThreadOutputWaitE>
    800017b8:	fddff06f          	j	80001794 <_ZN8KConsole31removeThreadFromOutputWaitQueueEv+0x2c>
    800017bc:	00008067          	ret

00000000800017c0 <_Z41__static_initialization_and_destruction_0ii>:
        TCB::setRunningThread(Scheduler::get());
        oldThread->resetState();
        context_switch(oldThread->getContext(), TCB::getRunningThread()->getContext());
    }

}
    800017c0:	00100793          	li	a5,1
    800017c4:	00f50463          	beq	a0,a5,800017cc <_Z41__static_initialization_and_destruction_0ii+0xc>
    800017c8:	00008067          	ret
    800017cc:	000107b7          	lui	a5,0x10
    800017d0:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    800017d4:	fef59ae3          	bne	a1,a5,800017c8 <_Z41__static_initialization_and_destruction_0ii+0x8>
    800017d8:	fe010113          	addi	sp,sp,-32
    800017dc:	00113c23          	sd	ra,24(sp)
    800017e0:	00813823          	sd	s0,16(sp)
    800017e4:	00913423          	sd	s1,8(sp)
    800017e8:	01213023          	sd	s2,0(sp)
    800017ec:	02010413          	addi	s0,sp,32
Buffer<char, KernelConfig::SIZE_INPUT_BUFFER>* KConsole::inputBuffer = new Buffer<char, KernelConfig::SIZE_INPUT_BUFFER>();
    800017f0:	33800513          	li	a0,824
    800017f4:	00000097          	auipc	ra,0x0
    800017f8:	2e0080e7          	jalr	736(ra) # 80001ad4 <_ZN6BufferIcLm100EEnwEm>
    800017fc:	00050493          	mv	s1,a0
    80001800:	00000097          	auipc	ra,0x0
    80001804:	310080e7          	jalr	784(ra) # 80001b10 <_ZN6BufferIcLm100EEC1Ev>
    80001808:	00006917          	auipc	s2,0x6
    8000180c:	98890913          	addi	s2,s2,-1656 # 80007190 <_ZN8KConsole19headThreadInputWaitE>
    80001810:	02993023          	sd	s1,32(s2)
Buffer<char, KernelConfig::SIZE_OUTPUT_BUFFER>* KConsole::outputBuffer = new Buffer<char, KernelConfig::SIZE_OUTPUT_BUFFER>();
    80001814:	33800513          	li	a0,824
    80001818:	00000097          	auipc	ra,0x0
    8000181c:	2bc080e7          	jalr	700(ra) # 80001ad4 <_ZN6BufferIcLm100EEnwEm>
    80001820:	00050493          	mv	s1,a0
    80001824:	00000097          	auipc	ra,0x0
    80001828:	2ec080e7          	jalr	748(ra) # 80001b10 <_ZN6BufferIcLm100EEC1Ev>
    8000182c:	02993423          	sd	s1,40(s2)
}
    80001830:	01813083          	ld	ra,24(sp)
    80001834:	01013403          	ld	s0,16(sp)
    80001838:	00813483          	ld	s1,8(sp)
    8000183c:	00013903          	ld	s2,0(sp)
    80001840:	02010113          	addi	sp,sp,32
    80001844:	00008067          	ret

0000000080001848 <_ZN8KConsole22getCharFromInputBufferEv>:
{
    80001848:	ff010113          	addi	sp,sp,-16
    8000184c:	00113423          	sd	ra,8(sp)
    80001850:	00813023          	sd	s0,0(sp)
    80001854:	01010413          	addi	s0,sp,16
    return *(inputBuffer->take());
    80001858:	00006517          	auipc	a0,0x6
    8000185c:	95853503          	ld	a0,-1704(a0) # 800071b0 <_ZN8KConsole11inputBufferE>
    80001860:	00000097          	auipc	ra,0x0
    80001864:	2f4080e7          	jalr	756(ra) # 80001b54 <_ZN6BufferIcLm100EE4takeEv>
}
    80001868:	00054503          	lbu	a0,0(a0)
    8000186c:	00813083          	ld	ra,8(sp)
    80001870:	00013403          	ld	s0,0(sp)
    80001874:	01010113          	addi	sp,sp,16
    80001878:	00008067          	ret

000000008000187c <_ZN8KConsole19consumeOutputBufferEPv>:
{
    8000187c:	fd010113          	addi	sp,sp,-48
    80001880:	02113423          	sd	ra,40(sp)
    80001884:	02813023          	sd	s0,32(sp)
    80001888:	00913c23          	sd	s1,24(sp)
    8000188c:	01213823          	sd	s2,16(sp)
    80001890:	03010413          	addi	s0,sp,48
    80001894:	0400006f          	j	800018d4 <_ZN8KConsole19consumeOutputBufferEPv+0x58>
        plic_complete(numOfDevice);
    80001898:	fd842503          	lw	a0,-40(s0)
    8000189c:	0005051b          	sext.w	a0,a0
    800018a0:	00002097          	auipc	ra,0x2
    800018a4:	49c080e7          	jalr	1180(ra) # 80003d3c <plic_complete>
    void setSemaphoreOnWait (KSemaphore* semaphore) { waitOnSemaphore = semaphore; }
    KSemaphore* getSemaphoreOnWait() const { return waitOnSemaphore; }
    void resetSemaphoreOnWait() { waitOnSemaphore = nullptr; }
    static void dispatch();

    static TCB* getRunningThread() { return running; }
    800018a8:	00006917          	auipc	s2,0x6
    800018ac:	86893903          	ld	s2,-1944(s2) # 80007110 <_GLOBAL_OFFSET_TABLE_+0x60>
    800018b0:	00093483          	ld	s1,0(s2)
        TCB::setRunningThread(Scheduler::get());
    800018b4:	00000097          	auipc	ra,0x0
    800018b8:	390080e7          	jalr	912(ra) # 80001c44 <_ZN9Scheduler3getEv>
    static void setRunningThread(TCB* newRunningThread) { running = newRunningThread; }
    800018bc:	00a93023          	sd	a0,0(s2)
    void resetState() {state = nullptr; }
    800018c0:	0404b423          	sd	zero,72(s1)
        context_switch(oldThread->getContext(), TCB::getRunningThread()->getContext());
    800018c4:	00850593          	addi	a1,a0,8
    800018c8:	00848513          	addi	a0,s1,8
    800018cc:	00000097          	auipc	ra,0x0
    800018d0:	8d4080e7          	jalr	-1836(ra) # 800011a0 <context_switch>
        volatile int numOfDevice = plic_claim();
    800018d4:	00002097          	auipc	ra,0x2
    800018d8:	430080e7          	jalr	1072(ra) # 80003d04 <plic_claim>
    800018dc:	fca42c23          	sw	a0,-40(s0)
            data = *(outputBuffer->take());
    800018e0:	00006517          	auipc	a0,0x6
    800018e4:	8d853503          	ld	a0,-1832(a0) # 800071b8 <_ZN8KConsole12outputBufferE>
    800018e8:	00000097          	auipc	ra,0x0
    800018ec:	26c080e7          	jalr	620(ra) # 80001b54 <_ZN6BufferIcLm100EE4takeEv>
    800018f0:	00054783          	lbu	a5,0(a0)
    800018f4:	fcf40fa3          	sb	a5,-33(s0)
            __asm__ volatile("sb %[regData], 0(%[address])":: [regData]"r"(data), [address]"r"(CONSOLE_TX_DATA));
    800018f8:	fdf44783          	lbu	a5,-33(s0)
    800018fc:	00005717          	auipc	a4,0x5
    80001900:	7dc73703          	ld	a4,2012(a4) # 800070d8 <_GLOBAL_OFFSET_TABLE_+0x28>
    80001904:	00073703          	ld	a4,0(a4)
    80001908:	00f70023          	sb	a5,0(a4)
            __asm__ volatile("lb %[status], 0(%[address])": [status] "=r"(statusReg): [address] "r"(CONSOLE_STATUS));
    8000190c:	00005797          	auipc	a5,0x5
    80001910:	7b47b783          	ld	a5,1972(a5) # 800070c0 <_GLOBAL_OFFSET_TABLE_+0x10>
    80001914:	0007b783          	ld	a5,0(a5)
    80001918:	00078783          	lb	a5,0(a5)
    8000191c:	fcf40f23          	sb	a5,-34(s0)
            removeThreadFromOutputWaitQueue();
    80001920:	00000097          	auipc	ra,0x0
    80001924:	e48080e7          	jalr	-440(ra) # 80001768 <_ZN8KConsole31removeThreadFromOutputWaitQueueEv>
        } while ((statusReg & CONSOLE_TX_STATUS_BIT) && !outputBuffer->isBufferEmpty());
    80001928:	fde44783          	lbu	a5,-34(s0)
    8000192c:	0ff7f793          	andi	a5,a5,255
    80001930:	0207f793          	andi	a5,a5,32
    80001934:	f60782e3          	beqz	a5,80001898 <_ZN8KConsole19consumeOutputBufferEPv+0x1c>
    80001938:	00006517          	auipc	a0,0x6
    8000193c:	88053503          	ld	a0,-1920(a0) # 800071b8 <_ZN8KConsole12outputBufferE>
    80001940:	00000097          	auipc	ra,0x0
    80001944:	150080e7          	jalr	336(ra) # 80001a90 <_ZNK6BufferIcLm100EE13isBufferEmptyEv>
    80001948:	f8050ce3          	beqz	a0,800018e0 <_ZN8KConsole19consumeOutputBufferEPv+0x64>
    8000194c:	f4dff06f          	j	80001898 <_ZN8KConsole19consumeOutputBufferEPv+0x1c>

0000000080001950 <_ZN8KConsole21addCharToOutputBufferEc>:
{
    80001950:	fe010113          	addi	sp,sp,-32
    80001954:	00113c23          	sd	ra,24(sp)
    80001958:	00813823          	sd	s0,16(sp)
    8000195c:	02010413          	addi	s0,sp,32
    80001960:	fea407a3          	sb	a0,-17(s0)
    outputBuffer->append(&c);
    80001964:	fef40593          	addi	a1,s0,-17
    80001968:	00006517          	auipc	a0,0x6
    8000196c:	85053503          	ld	a0,-1968(a0) # 800071b8 <_ZN8KConsole12outputBufferE>
    80001970:	00000097          	auipc	ra,0x0
    80001974:	238080e7          	jalr	568(ra) # 80001ba8 <_ZN6BufferIcLm100EE6appendEPc>
}
    80001978:	01813083          	ld	ra,24(sp)
    8000197c:	01013403          	ld	s0,16(sp)
    80001980:	02010113          	addi	sp,sp,32
    80001984:	00008067          	ret

0000000080001988 <_ZN8KConsole18produceInputBufferEPv>:
{
    80001988:	fd010113          	addi	sp,sp,-48
    8000198c:	02113423          	sd	ra,40(sp)
    80001990:	02813023          	sd	s0,32(sp)
    80001994:	00913c23          	sd	s1,24(sp)
    80001998:	01213823          	sd	s2,16(sp)
    8000199c:	03010413          	addi	s0,sp,48
    800019a0:	0400006f          	j	800019e0 <_ZN8KConsole18produceInputBufferEPv+0x58>
        plic_complete(numOfDevice);
    800019a4:	fd842503          	lw	a0,-40(s0)
    800019a8:	0005051b          	sext.w	a0,a0
    800019ac:	00002097          	auipc	ra,0x2
    800019b0:	390080e7          	jalr	912(ra) # 80003d3c <plic_complete>
    static TCB* getRunningThread() { return running; }
    800019b4:	00005917          	auipc	s2,0x5
    800019b8:	75c93903          	ld	s2,1884(s2) # 80007110 <_GLOBAL_OFFSET_TABLE_+0x60>
    800019bc:	00093483          	ld	s1,0(s2)
        TCB::setRunningThread(Scheduler::get());
    800019c0:	00000097          	auipc	ra,0x0
    800019c4:	284080e7          	jalr	644(ra) # 80001c44 <_ZN9Scheduler3getEv>
    static void setRunningThread(TCB* newRunningThread) { running = newRunningThread; }
    800019c8:	00a93023          	sd	a0,0(s2)
    void resetState() {state = nullptr; }
    800019cc:	0404b423          	sd	zero,72(s1)
        context_switch(oldThread->getContext(), TCB::getRunningThread()->getContext());
    800019d0:	00850593          	addi	a1,a0,8
    800019d4:	00848513          	addi	a0,s1,8
    800019d8:	fffff097          	auipc	ra,0xfffff
    800019dc:	7c8080e7          	jalr	1992(ra) # 800011a0 <context_switch>
        volatile int numOfDevice = plic_claim();
    800019e0:	00002097          	auipc	ra,0x2
    800019e4:	324080e7          	jalr	804(ra) # 80003d04 <plic_claim>
    800019e8:	fca42c23          	sw	a0,-40(s0)
            __asm__ volatile("lb %[regData], 0(%[address])" : [regData]"=r"(data): [address]"r"(CONSOLE_RX_DATA));
    800019ec:	00005797          	auipc	a5,0x5
    800019f0:	6cc7b783          	ld	a5,1740(a5) # 800070b8 <_GLOBAL_OFFSET_TABLE_+0x8>
    800019f4:	0007b783          	ld	a5,0(a5)
    800019f8:	00078783          	lb	a5,0(a5)
    800019fc:	fcf40f23          	sb	a5,-34(s0)
            char c = data;
    80001a00:	fde44783          	lbu	a5,-34(s0)
    80001a04:	fcf40ba3          	sb	a5,-41(s0)
            inputBuffer->append(&c);
    80001a08:	fd740593          	addi	a1,s0,-41
    80001a0c:	00005517          	auipc	a0,0x5
    80001a10:	7a453503          	ld	a0,1956(a0) # 800071b0 <_ZN8KConsole11inputBufferE>
    80001a14:	00000097          	auipc	ra,0x0
    80001a18:	194080e7          	jalr	404(ra) # 80001ba8 <_ZN6BufferIcLm100EE6appendEPc>
            __asm__ volatile("lb %[status], 0(%[address])": [status] "=r"(statusReg): [address] "r"(CONSOLE_STATUS));
    80001a1c:	00005797          	auipc	a5,0x5
    80001a20:	6a47b783          	ld	a5,1700(a5) # 800070c0 <_GLOBAL_OFFSET_TABLE_+0x10>
    80001a24:	0007b783          	ld	a5,0(a5)
    80001a28:	00078783          	lb	a5,0(a5)
    80001a2c:	fcf40fa3          	sb	a5,-33(s0)
            removeThreadFromInputWaitQueue();
    80001a30:	00000097          	auipc	ra,0x0
    80001a34:	ce0080e7          	jalr	-800(ra) # 80001710 <_ZN8KConsole30removeThreadFromInputWaitQueueEv>
        } while ((statusReg & CONSOLE_RX_STATUS_BIT) && !inputBuffer->isBufferFull());
    80001a38:	fdf44783          	lbu	a5,-33(s0)
    80001a3c:	0017f793          	andi	a5,a5,1
    80001a40:	f60782e3          	beqz	a5,800019a4 <_ZN8KConsole18produceInputBufferEPv+0x1c>
    80001a44:	00005517          	auipc	a0,0x5
    80001a48:	76c53503          	ld	a0,1900(a0) # 800071b0 <_ZN8KConsole11inputBufferE>
    80001a4c:	00000097          	auipc	ra,0x0
    80001a50:	064080e7          	jalr	100(ra) # 80001ab0 <_ZNK6BufferIcLm100EE12isBufferFullEv>
    80001a54:	f8050ce3          	beqz	a0,800019ec <_ZN8KConsole18produceInputBufferEPv+0x64>
    80001a58:	f4dff06f          	j	800019a4 <_ZN8KConsole18produceInputBufferEPv+0x1c>

0000000080001a5c <_GLOBAL__sub_I__ZN8KConsole11inputBufferE>:
}
    80001a5c:	ff010113          	addi	sp,sp,-16
    80001a60:	00113423          	sd	ra,8(sp)
    80001a64:	00813023          	sd	s0,0(sp)
    80001a68:	01010413          	addi	s0,sp,16
    80001a6c:	000105b7          	lui	a1,0x10
    80001a70:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    80001a74:	00100513          	li	a0,1
    80001a78:	00000097          	auipc	ra,0x0
    80001a7c:	d48080e7          	jalr	-696(ra) # 800017c0 <_Z41__static_initialization_and_destruction_0ii>
    80001a80:	00813083          	ld	ra,8(sp)
    80001a84:	00013403          	ld	s0,0(sp)
    80001a88:	01010113          	addi	sp,sp,16
    80001a8c:	00008067          	ret

0000000080001a90 <_ZNK6BufferIcLm100EE13isBufferEmptyEv>:
    return tempElem;

}

template<typename T, size_t numOfElements>
bool Buffer<T, numOfElements>::isBufferEmpty() const
    80001a90:	ff010113          	addi	sp,sp,-16
    80001a94:	00813423          	sd	s0,8(sp)
    80001a98:	01010413          	addi	s0,sp,16
{
    return count == 0;
    80001a9c:	33053503          	ld	a0,816(a0)
}
    80001aa0:	00153513          	seqz	a0,a0
    80001aa4:	00813403          	ld	s0,8(sp)
    80001aa8:	01010113          	addi	sp,sp,16
    80001aac:	00008067          	ret

0000000080001ab0 <_ZNK6BufferIcLm100EE12isBufferFullEv>:
template<typename T, size_t numOfElements>
bool Buffer<T, numOfElements>::isBufferFull() const
    80001ab0:	ff010113          	addi	sp,sp,-16
    80001ab4:	00813423          	sd	s0,8(sp)
    80001ab8:	01010413          	addi	s0,sp,16
{
    return count == numOfElements;
    80001abc:	33053503          	ld	a0,816(a0)
    80001ac0:	f9c50513          	addi	a0,a0,-100
}
    80001ac4:	00153513          	seqz	a0,a0
    80001ac8:	00813403          	ld	s0,8(sp)
    80001acc:	01010113          	addi	sp,sp,16
    80001ad0:	00008067          	ret

0000000080001ad4 <_ZN6BufferIcLm100EEnwEm>:
void* Buffer<T, numOfElements>::operator new(size_t size)
    80001ad4:	ff010113          	addi	sp,sp,-16
    80001ad8:	00113423          	sd	ra,8(sp)
    80001adc:	00813023          	sd	s0,0(sp)
    80001ae0:	01010413          	addi	s0,sp,16
    size_t numOfBlocks = size / MEM_BLOCK_SIZE;
    80001ae4:	00655793          	srli	a5,a0,0x6
    numOfBlocks += size % MEM_BLOCK_SIZE ? 1 : 0;
    80001ae8:	03f57513          	andi	a0,a0,63
    80001aec:	00050463          	beqz	a0,80001af4 <_ZN6BufferIcLm100EEnwEm+0x20>
    80001af0:	00100513          	li	a0,1
    return MemoryAllocator::allocateMemory(numOfBlocks);
    80001af4:	00f50533          	add	a0,a0,a5
    80001af8:	00000097          	auipc	ra,0x0
    80001afc:	4ac080e7          	jalr	1196(ra) # 80001fa4 <_ZN15MemoryAllocator14allocateMemoryEm>
}
    80001b00:	00813083          	ld	ra,8(sp)
    80001b04:	00013403          	ld	s0,0(sp)
    80001b08:	01010113          	addi	sp,sp,16
    80001b0c:	00008067          	ret

0000000080001b10 <_ZN6BufferIcLm100EEC1Ev>:
Buffer<T, numOfElements>::Buffer()
    80001b10:	ff010113          	addi	sp,sp,-16
    80001b14:	00813423          	sd	s0,8(sp)
    80001b18:	01010413          	addi	s0,sp,16
    80001b1c:	32053023          	sd	zero,800(a0)
    80001b20:	32053423          	sd	zero,808(a0)
    80001b24:	32053823          	sd	zero,816(a0)
    for(size_t i = 0; i < numOfElements; i++)
    80001b28:	00000793          	li	a5,0
    80001b2c:	06300713          	li	a4,99
    80001b30:	00f76c63          	bltu	a4,a5,80001b48 <_ZN6BufferIcLm100EEC1Ev+0x38>
        array[i] = nullptr;
    80001b34:	00379713          	slli	a4,a5,0x3
    80001b38:	00e50733          	add	a4,a0,a4
    80001b3c:	00073023          	sd	zero,0(a4)
    for(size_t i = 0; i < numOfElements; i++)
    80001b40:	00178793          	addi	a5,a5,1
    80001b44:	fe9ff06f          	j	80001b2c <_ZN6BufferIcLm100EEC1Ev+0x1c>
}
    80001b48:	00813403          	ld	s0,8(sp)
    80001b4c:	01010113          	addi	sp,sp,16
    80001b50:	00008067          	ret

0000000080001b54 <_ZN6BufferIcLm100EE4takeEv>:
T* Buffer<T, numOfElements>::take()
    80001b54:	ff010113          	addi	sp,sp,-16
    80001b58:	00813423          	sd	s0,8(sp)
    80001b5c:	01010413          	addi	s0,sp,16
    if(count == 0)
    80001b60:	33053703          	ld	a4,816(a0)
    80001b64:	02070e63          	beqz	a4,80001ba0 <_ZN6BufferIcLm100EE4takeEv+0x4c>
    80001b68:	00050793          	mv	a5,a0
    count--;
    80001b6c:	fff70713          	addi	a4,a4,-1
    80001b70:	32e53823          	sd	a4,816(a0)
    T* tempElem = array[head];
    80001b74:	32053703          	ld	a4,800(a0)
    80001b78:	00371693          	slli	a3,a4,0x3
    80001b7c:	00d506b3          	add	a3,a0,a3
    80001b80:	0006b503          	ld	a0,0(a3)
    head = (head + 1) % numOfElements;
    80001b84:	00170713          	addi	a4,a4,1
    80001b88:	06400693          	li	a3,100
    80001b8c:	02d77733          	remu	a4,a4,a3
    80001b90:	32e7b023          	sd	a4,800(a5)
}
    80001b94:	00813403          	ld	s0,8(sp)
    80001b98:	01010113          	addi	sp,sp,16
    80001b9c:	00008067          	ret
        return nullptr;
    80001ba0:	00000513          	li	a0,0
    80001ba4:	ff1ff06f          	j	80001b94 <_ZN6BufferIcLm100EE4takeEv+0x40>

0000000080001ba8 <_ZN6BufferIcLm100EE6appendEPc>:
int Buffer<T, numOfElements>::append(T *element)
    80001ba8:	ff010113          	addi	sp,sp,-16
    80001bac:	00813423          	sd	s0,8(sp)
    80001bb0:	01010413          	addi	s0,sp,16
    if(count == numOfElements)
    80001bb4:	33053783          	ld	a5,816(a0)
    80001bb8:	06400713          	li	a4,100
    80001bbc:	02e78e63          	beq	a5,a4,80001bf8 <_ZN6BufferIcLm100EE6appendEPc+0x50>
    count++;
    80001bc0:	00178793          	addi	a5,a5,1
    80001bc4:	32f53823          	sd	a5,816(a0)
    array[tail] = element;
    80001bc8:	32853783          	ld	a5,808(a0)
    80001bcc:	00379713          	slli	a4,a5,0x3
    80001bd0:	00e50733          	add	a4,a0,a4
    80001bd4:	00b73023          	sd	a1,0(a4)
    tail = (tail + 1) % numOfElements;
    80001bd8:	00178793          	addi	a5,a5,1
    80001bdc:	06400713          	li	a4,100
    80001be0:	02e7f7b3          	remu	a5,a5,a4
    80001be4:	32f53423          	sd	a5,808(a0)
    return 0;
    80001be8:	00000513          	li	a0,0
}
    80001bec:	00813403          	ld	s0,8(sp)
    80001bf0:	01010113          	addi	sp,sp,16
    80001bf4:	00008067          	ret
        return -1;
    80001bf8:	fff00513          	li	a0,-1
    80001bfc:	ff1ff06f          	j	80001bec <_ZN6BufferIcLm100EE6appendEPc+0x44>

0000000080001c00 <_ZN9Scheduler3putEP3TCB>:
#include "../h/TCB.hpp"
TCB* Scheduler::headReadyThread = nullptr;
TCB* Scheduler::tailReadyThread = nullptr;
TCB* Scheduler::idleThread = nullptr;
void Scheduler::put(TCB *readyThread)
{
    80001c00:	ff010113          	addi	sp,sp,-16
    80001c04:	00813423          	sd	s0,8(sp)
    80001c08:	01010413          	addi	s0,sp,16
    if(!headReadyThread)
    80001c0c:	00005797          	auipc	a5,0x5
    80001c10:	5c47b783          	ld	a5,1476(a5) # 800071d0 <_ZN9Scheduler15headReadyThreadE>
    80001c14:	02078263          	beqz	a5,80001c38 <_ZN9Scheduler3putEP3TCB+0x38>
    {
        headReadyThread = readyThread;
    }
    else
    {
        tailReadyThread->addThreadToState(readyThread);
    80001c18:	00005797          	auipc	a5,0x5
    80001c1c:	5c07b783          	ld	a5,1472(a5) # 800071d8 <_ZN9Scheduler15tailReadyThreadE>
    void addThreadToState(TCB* newThread) { state = newThread; }
    80001c20:	04a7b423          	sd	a0,72(a5)
    }
    tailReadyThread = readyThread;
    80001c24:	00005797          	auipc	a5,0x5
    80001c28:	5aa7ba23          	sd	a0,1460(a5) # 800071d8 <_ZN9Scheduler15tailReadyThreadE>
}
    80001c2c:	00813403          	ld	s0,8(sp)
    80001c30:	01010113          	addi	sp,sp,16
    80001c34:	00008067          	ret
        headReadyThread = readyThread;
    80001c38:	00005797          	auipc	a5,0x5
    80001c3c:	58a7bc23          	sd	a0,1432(a5) # 800071d0 <_ZN9Scheduler15headReadyThreadE>
    80001c40:	fe5ff06f          	j	80001c24 <_ZN9Scheduler3putEP3TCB+0x24>

0000000080001c44 <_ZN9Scheduler3getEv>:
TCB* Scheduler::get(void)
{
    80001c44:	ff010113          	addi	sp,sp,-16
    80001c48:	00813423          	sd	s0,8(sp)
    80001c4c:	01010413          	addi	s0,sp,16
    if(!headReadyThread)
    80001c50:	00005517          	auipc	a0,0x5
    80001c54:	58053503          	ld	a0,1408(a0) # 800071d0 <_ZN9Scheduler15headReadyThreadE>
    80001c58:	02050063          	beqz	a0,80001c78 <_ZN9Scheduler3getEv+0x34>
    TCB* getState() const { return state; }
    80001c5c:	04853783          	ld	a5,72(a0)
    {
        return idleThread;
    }
    TCB* newThread = headReadyThread;
    headReadyThread = headReadyThread->getState();
    80001c60:	00005717          	auipc	a4,0x5
    80001c64:	56f73823          	sd	a5,1392(a4) # 800071d0 <_ZN9Scheduler15headReadyThreadE>
    void addThreadToState(TCB* newThread) { state = newThread; }
    80001c68:	04053423          	sd	zero,72(a0)

    newThread->addThreadToState(nullptr);
    return newThread;
    80001c6c:	00813403          	ld	s0,8(sp)
    80001c70:	01010113          	addi	sp,sp,16
    80001c74:	00008067          	ret
        return idleThread;
    80001c78:	00005517          	auipc	a0,0x5
    80001c7c:	56853503          	ld	a0,1384(a0) # 800071e0 <_ZN9Scheduler10idleThreadE>
    80001c80:	fedff06f          	j	80001c6c <_ZN9Scheduler3getEv+0x28>

0000000080001c84 <main>:
// Created by os on 11/29/25.
//
#include "../h/MemoryAllocator.hpp"
#include "../h/Kernel.hpp"
#include "../h/syscall_c.hpp"
void main(){
    80001c84:	ff010113          	addi	sp,sp,-16
    80001c88:	00813423          	sd	s0,8(sp)
    80001c8c:	01010413          	addi	s0,sp,16
////    __asm__ volatile ("ecall");
//    void* allocMem1 = mem_alloc(100);
//    mem_free(allocMem1);
//    void* allocMem2 = mem_alloc(10);
//    mem_free(allocMem2);
    80001c90:	00813403          	ld	s0,8(sp)
    80001c94:	01010113          	addi	sp,sp,16
    80001c98:	00008067          	ret

0000000080001c9c <_ZN3TCB13threadWrapperEv>:
    {
        Scheduler::put(this);
    }
}
void TCB::threadWrapper()
{
    80001c9c:	ff010113          	addi	sp,sp,-16
    80001ca0:	00113423          	sd	ra,8(sp)
    80001ca4:	00813023          	sd	s0,0(sp)
    80001ca8:	01010413          	addi	s0,sp,16
    running->body(running->arguments);
    80001cac:	00005797          	auipc	a5,0x5
    80001cb0:	53c7b783          	ld	a5,1340(a5) # 800071e8 <_ZN3TCB7runningE>
    80001cb4:	0007b703          	ld	a4,0(a5)
    80001cb8:	0387b503          	ld	a0,56(a5)
    80001cbc:	000700e7          	jalr	a4
    thread_exit();
    80001cc0:	fffff097          	auipc	ra,0xfffff
    80001cc4:	778080e7          	jalr	1912(ra) # 80001438 <_Z11thread_exitv>

}
    80001cc8:	00813083          	ld	ra,8(sp)
    80001ccc:	00013403          	ld	s0,0(sp)
    80001cd0:	01010113          	addi	sp,sp,16
    80001cd4:	00008067          	ret

0000000080001cd8 <_ZN3TCB16initializeThreadEPFvPvES0_S0_S0_P10ObjectPoolIS_Lm20EEN12KernelConfig4ModeENS6_11ThreadStateE>:
    body = function;
    80001cd8:	00b53023          	sd	a1,0(a0)
    timeSlice = DEFAULT_TIME_SLICE;
    80001cdc:	00200593          	li	a1,2
    80001ce0:	02b53823          	sd	a1,48(a0)
    state = nullptr;
    80001ce4:	04053423          	sd	zero,72(a0)
    finished = false;
    80001ce8:	04050823          	sb	zero,80(a0)
    arguments = arg;
    80001cec:	02c53c23          	sd	a2,56(a0)
    waitOnSemaphore = nullptr;
    80001cf0:	04053023          	sd	zero,64(a0)
    sourcePool = pool;
    80001cf4:	04f53c23          	sd	a5,88(a0)
    userStack = (void*)((uint8*)allocatedStack - DEFAULT_STACK_SIZE);
    80001cf8:	fffff7b7          	lui	a5,0xfffff
    80001cfc:	00f687b3          	add	a5,a3,a5
    80001d00:	02f53023          	sd	a5,32(a0)
    systemStack = (void*)((uint8*)allocatedSystemStack - KernelConfig::DEFAULT_SYSTEM_STACK_SIZE);
    80001d04:	c0070793          	addi	a5,a4,-1024
    80001d08:	02f53423          	sd	a5,40(a0)
    *((uint64*)allocatedSystemStack - 30) = (uint64)((uint64*)allocatedStack - 2);
    80001d0c:	ff068693          	addi	a3,a3,-16
    80001d10:	f0d73823          	sd	a3,-240(a4)
    __asm__ volatile ("csrc sip, %[reg]":: [reg] "r"(mask));
}
inline uint64 Machine::readSscratch()
{
    uint64 returnValue;
    __asm__ volatile ("csrr %[reg], sscratch": [reg] "=r"(returnValue));
    80001d14:	140027f3          	csrr	a5,sscratch
    context = {Machine::readSscratch(), (uint64) ((uint64*)allocatedSystemStack - 32), mode};
    80001d18:	f0070713          	addi	a4,a4,-256
    80001d1c:	00f53423          	sd	a5,8(a0)
    80001d20:	00e53823          	sd	a4,16(a0)
    80001d24:	01052c23          	sw	a6,24(a0)
    Machine::writeSepc((uint64)&threadWrapper);
    80001d28:	00000797          	auipc	a5,0x0
    80001d2c:	f7478793          	addi	a5,a5,-140 # 80001c9c <_ZN3TCB13threadWrapperEv>
    return returnValue;
}
inline void Machine::writeSepc(uint64 address)
{
    __asm__ volatile("csrw sepc, %[reg]":: [reg] "r"(address));
    80001d30:	14179073          	csrw	sepc,a5
    if(stateOfThread == KernelConfig::ACTIVE)
    80001d34:	00088463          	beqz	a7,80001d3c <_ZN3TCB16initializeThreadEPFvPvES0_S0_S0_P10ObjectPoolIS_Lm20EEN12KernelConfig4ModeENS6_11ThreadStateE+0x64>
    80001d38:	00008067          	ret
{
    80001d3c:	ff010113          	addi	sp,sp,-16
    80001d40:	00113423          	sd	ra,8(sp)
    80001d44:	00813023          	sd	s0,0(sp)
    80001d48:	01010413          	addi	s0,sp,16
        Scheduler::put(this);
    80001d4c:	00000097          	auipc	ra,0x0
    80001d50:	eb4080e7          	jalr	-332(ra) # 80001c00 <_ZN9Scheduler3putEP3TCB>
}
    80001d54:	00813083          	ld	ra,8(sp)
    80001d58:	00013403          	ld	s0,0(sp)
    80001d5c:	01010113          	addi	sp,sp,16
    80001d60:	00008067          	ret

0000000080001d64 <_ZN3TCB5yieldEPS_S0_>:
void TCB::yield(TCB *oldThread, TCB *newThread)
{
    80001d64:	ff010113          	addi	sp,sp,-16
    80001d68:	00113423          	sd	ra,8(sp)
    80001d6c:	00813023          	sd	s0,0(sp)
    80001d70:	01010413          	addi	s0,sp,16
    context_switch(oldThread->getContext(), newThread->getContext());
    80001d74:	00858593          	addi	a1,a1,8
    80001d78:	00850513          	addi	a0,a0,8
    80001d7c:	fffff097          	auipc	ra,0xfffff
    80001d80:	424080e7          	jalr	1060(ra) # 800011a0 <context_switch>
}
    80001d84:	00813083          	ld	ra,8(sp)
    80001d88:	00013403          	ld	s0,0(sp)
    80001d8c:	01010113          	addi	sp,sp,16
    80001d90:	00008067          	ret

0000000080001d94 <_ZN3TCB8dispatchEv>:

void TCB::dispatch()
{
    80001d94:	fe010113          	addi	sp,sp,-32
    80001d98:	00113c23          	sd	ra,24(sp)
    80001d9c:	00813823          	sd	s0,16(sp)
    80001da0:	00913423          	sd	s1,8(sp)
    80001da4:	02010413          	addi	s0,sp,32
    TCB* oldThread = running;
    80001da8:	00005497          	auipc	s1,0x5
    80001dac:	4404b483          	ld	s1,1088(s1) # 800071e8 <_ZN3TCB7runningE>
    bool isFinished() const { return finished; }
    80001db0:	0504c783          	lbu	a5,80(s1)
    if(!oldThread->isFinished())
    80001db4:	02078c63          	beqz	a5,80001dec <_ZN3TCB8dispatchEv+0x58>
    {
        Scheduler::put(oldThread);
    }
    running = Scheduler::get();
    80001db8:	00000097          	auipc	ra,0x0
    80001dbc:	e8c080e7          	jalr	-372(ra) # 80001c44 <_ZN9Scheduler3getEv>
    80001dc0:	00050593          	mv	a1,a0
    80001dc4:	00005797          	auipc	a5,0x5
    80001dc8:	42a7b223          	sd	a0,1060(a5) # 800071e8 <_ZN3TCB7runningE>
    yield(oldThread, running);
    80001dcc:	00048513          	mv	a0,s1
    80001dd0:	00000097          	auipc	ra,0x0
    80001dd4:	f94080e7          	jalr	-108(ra) # 80001d64 <_ZN3TCB5yieldEPS_S0_>
    80001dd8:	01813083          	ld	ra,24(sp)
    80001ddc:	01013403          	ld	s0,16(sp)
    80001de0:	00813483          	ld	s1,8(sp)
    80001de4:	02010113          	addi	sp,sp,32
    80001de8:	00008067          	ret
        Scheduler::put(oldThread);
    80001dec:	00048513          	mv	a0,s1
    80001df0:	00000097          	auipc	ra,0x0
    80001df4:	e10080e7          	jalr	-496(ra) # 80001c00 <_ZN9Scheduler3putEP3TCB>
    80001df8:	fc1ff06f          	j	80001db8 <_ZN3TCB8dispatchEv+0x24>

0000000080001dfc <_ZN15MemoryAllocator16initializeMemoryEv>:
size_t MemoryAllocator::NUM_OF_BLOCKS = 0;
size_t MemoryAllocator::numOfFreeBlocks = 0;
MemoryAllocator::FreeBlock* MemoryAllocator::firstFreeBlock = nullptr;

void MemoryAllocator::initializeMemory()
{
    80001dfc:	ff010113          	addi	sp,sp,-16
    80001e00:	00813423          	sd	s0,8(sp)
    80001e04:	01010413          	addi	s0,sp,16

    NUM_OF_BLOCKS = ((uint8*)HEAP_END_ADDR - (uint8*)HEAP_START_ADDR) / MEM_BLOCK_SIZE;
    80001e08:	00005797          	auipc	a5,0x5
    80001e0c:	3187b783          	ld	a5,792(a5) # 80007120 <_GLOBAL_OFFSET_TABLE_+0x70>
    80001e10:	0007b703          	ld	a4,0(a5)
    80001e14:	00005797          	auipc	a5,0x5
    80001e18:	2b47b783          	ld	a5,692(a5) # 800070c8 <_GLOBAL_OFFSET_TABLE_+0x18>
    80001e1c:	0007b683          	ld	a3,0(a5)
    80001e20:	40d70733          	sub	a4,a4,a3
    80001e24:	00675713          	srli	a4,a4,0x6
    80001e28:	00005797          	auipc	a5,0x5
    80001e2c:	3d078793          	addi	a5,a5,976 # 800071f8 <_ZN15MemoryAllocator13NUM_OF_BLOCKSE>
    80001e30:	00e7b023          	sd	a4,0(a5)
    numOfFreeBlocks = NUM_OF_BLOCKS;
    80001e34:	00e7b423          	sd	a4,8(a5)

    firstFreeBlock = (FreeBlock*)(HEAP_START_ADDR);
    80001e38:	00d7b823          	sd	a3,16(a5)

    firstFreeBlock->flagFree = true;
    80001e3c:	00100613          	li	a2,1
    80001e40:	00c68023          	sb	a2,0(a3)
    firstFreeBlock->numOfBlocks = NUM_OF_BLOCKS;
    80001e44:	0107b703          	ld	a4,16(a5)
    80001e48:	0007b683          	ld	a3,0(a5)
    80001e4c:	00d73423          	sd	a3,8(a4)
    firstFreeBlock->nextBlock = nullptr;
    80001e50:	00073823          	sd	zero,16(a4)
    firstFreeBlock->previousBlock = nullptr;
    80001e54:	00073c23          	sd	zero,24(a4)
    flagSystemInitialize = 1;
    80001e58:	00c78c23          	sb	a2,24(a5)
}
    80001e5c:	00813403          	ld	s0,8(sp)
    80001e60:	01010113          	addi	sp,sp,16
    80001e64:	00008067          	ret

0000000080001e68 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m>:
    occupiedBlock++;
    return occupiedBlock;
}

void MemoryAllocator::remapMemory(FreeBlock **head, FreeBlock *allocatedBlocks, size_t blocksToAllocate)
{
    80001e68:	ff010113          	addi	sp,sp,-16
    80001e6c:	00813423          	sd	s0,8(sp)
    80001e70:	01010413          	addi	s0,sp,16

    if(allocatedBlocks->numOfBlocks == 0)
    80001e74:	0085b783          	ld	a5,8(a1)
    80001e78:	04079263          	bnez	a5,80001ebc <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x54>
    {

        if(allocatedBlocks->previousBlock)
    80001e7c:	0185b783          	ld	a5,24(a1)
    80001e80:	00078663          	beqz	a5,80001e8c <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x24>
        {
            allocatedBlocks->previousBlock->nextBlock = allocatedBlocks->nextBlock;
    80001e84:	0105b703          	ld	a4,16(a1)
    80001e88:	00e7b823          	sd	a4,16(a5)
        }

        if(allocatedBlocks->nextBlock)
    80001e8c:	0105b783          	ld	a5,16(a1)
    80001e90:	00078663          	beqz	a5,80001e9c <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x34>
        {
            allocatedBlocks->nextBlock->previousBlock = allocatedBlocks->previousBlock;
    80001e94:	0185b703          	ld	a4,24(a1)
    80001e98:	00e7bc23          	sd	a4,24(a5)
        }

        if(*head == allocatedBlocks)
    80001e9c:	00053783          	ld	a5,0(a0)
    80001ea0:	00b78863          	beq	a5,a1,80001eb0 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x48>
        {
            *head = newFreeBlock;
        }
    }

}
    80001ea4:	00813403          	ld	s0,8(sp)
    80001ea8:	01010113          	addi	sp,sp,16
    80001eac:	00008067          	ret
            *head = allocatedBlocks->nextBlock;
    80001eb0:	0105b783          	ld	a5,16(a1)
    80001eb4:	00f53023          	sd	a5,0(a0)
    80001eb8:	fedff06f          	j	80001ea4 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x3c>
        FreeBlock* newFreeBlock = (FreeBlock*)((uint8*)allocatedBlocks + blocksToAllocate * MEM_BLOCK_SIZE);
    80001ebc:	00661613          	slli	a2,a2,0x6
    80001ec0:	00c58633          	add	a2,a1,a2
        newFreeBlock->flagFree = true;
    80001ec4:	00100793          	li	a5,1
    80001ec8:	00f60023          	sb	a5,0(a2)
        newFreeBlock->numOfBlocks = allocatedBlocks->numOfBlocks;
    80001ecc:	0085b783          	ld	a5,8(a1)
    80001ed0:	00f63423          	sd	a5,8(a2)
        if(allocatedBlocks->previousBlock)
    80001ed4:	0185b783          	ld	a5,24(a1)
    80001ed8:	00078463          	beqz	a5,80001ee0 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x78>
            allocatedBlocks->previousBlock->nextBlock = newFreeBlock;
    80001edc:	00c7b823          	sd	a2,16(a5)
        newFreeBlock->previousBlock = allocatedBlocks->previousBlock;
    80001ee0:	0185b783          	ld	a5,24(a1)
    80001ee4:	00f63c23          	sd	a5,24(a2)
        newFreeBlock->nextBlock = allocatedBlocks->nextBlock;
    80001ee8:	0105b783          	ld	a5,16(a1)
    80001eec:	00f63823          	sd	a5,16(a2)
        if(*head == allocatedBlocks)
    80001ef0:	00053783          	ld	a5,0(a0)
    80001ef4:	fab798e3          	bne	a5,a1,80001ea4 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x3c>
            *head = newFreeBlock;
    80001ef8:	00c53023          	sd	a2,0(a0)
}
    80001efc:	fa9ff06f          	j	80001ea4 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m+0x3c>

0000000080001f00 <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm>:
{
    80001f00:	fe010113          	addi	sp,sp,-32
    80001f04:	00113c23          	sd	ra,24(sp)
    80001f08:	00813823          	sd	s0,16(sp)
    80001f0c:	00913423          	sd	s1,8(sp)
    80001f10:	01213023          	sd	s2,0(sp)
    80001f14:	02010413          	addi	s0,sp,32
    80001f18:	00058913          	mv	s2,a1
    for(FreeBlock* curr = (*head); curr; curr = curr->nextBlock)
    80001f1c:	00053783          	ld	a5,0(a0)
    FreeBlock* bestBlock = nullptr;
    80001f20:	00000493          	li	s1,0
    80001f24:	00c0006f          	j	80001f30 <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm+0x30>
                bestBlock = curr;
    80001f28:	00078493          	mv	s1,a5
    for(FreeBlock* curr = (*head); curr; curr = curr->nextBlock)
    80001f2c:	0107b783          	ld	a5,16(a5)
    80001f30:	02078063          	beqz	a5,80001f50 <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm+0x50>
        if(curr->numOfBlocks >= blocksToAllocate)
    80001f34:	0087b703          	ld	a4,8(a5)
    80001f38:	ff276ae3          	bltu	a4,s2,80001f2c <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm+0x2c>
        {   if(bestBlock == nullptr)
    80001f3c:	fe0486e3          	beqz	s1,80001f28 <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm+0x28>
            if(bestBlock->numOfBlocks > curr->numOfBlocks)
    80001f40:	0084b683          	ld	a3,8(s1)
    80001f44:	fed774e3          	bgeu	a4,a3,80001f2c <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm+0x2c>
                bestBlock = curr;
    80001f48:	00078493          	mv	s1,a5
    80001f4c:	fe1ff06f          	j	80001f2c <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm+0x2c>
    numOfFreeBlocks -= blocksToAllocate;
    80001f50:	00005717          	auipc	a4,0x5
    80001f54:	2a870713          	addi	a4,a4,680 # 800071f8 <_ZN15MemoryAllocator13NUM_OF_BLOCKSE>
    80001f58:	00873783          	ld	a5,8(a4)
    80001f5c:	412787b3          	sub	a5,a5,s2
    80001f60:	00f73423          	sd	a5,8(a4)
    bestBlock->numOfBlocks -= blocksToAllocate;
    80001f64:	0084b783          	ld	a5,8(s1)
    80001f68:	412787b3          	sub	a5,a5,s2
    80001f6c:	00f4b423          	sd	a5,8(s1)
    remapMemory(head, bestBlock, blocksToAllocate);
    80001f70:	00090613          	mv	a2,s2
    80001f74:	00048593          	mv	a1,s1
    80001f78:	00000097          	auipc	ra,0x0
    80001f7c:	ef0080e7          	jalr	-272(ra) # 80001e68 <_ZN15MemoryAllocator11remapMemoryEPPNS_9FreeBlockES1_m>
    occupiedBlock->flagFree = false;
    80001f80:	00048023          	sb	zero,0(s1)
    occupiedBlock->numOfBlocks = blocksToAllocate;
    80001f84:	0124b423          	sd	s2,8(s1)
}
    80001f88:	01048513          	addi	a0,s1,16
    80001f8c:	01813083          	ld	ra,24(sp)
    80001f90:	01013403          	ld	s0,16(sp)
    80001f94:	00813483          	ld	s1,8(sp)
    80001f98:	00013903          	ld	s2,0(sp)
    80001f9c:	02010113          	addi	sp,sp,32
    80001fa0:	00008067          	ret

0000000080001fa4 <_ZN15MemoryAllocator14allocateMemoryEm>:
{
    80001fa4:	fe010113          	addi	sp,sp,-32
    80001fa8:	00113c23          	sd	ra,24(sp)
    80001fac:	00813823          	sd	s0,16(sp)
    80001fb0:	00913423          	sd	s1,8(sp)
    80001fb4:	02010413          	addi	s0,sp,32
    80001fb8:	00050493          	mv	s1,a0
    if(!flagSystemInitialize)
    80001fbc:	00005797          	auipc	a5,0x5
    80001fc0:	2547c783          	lbu	a5,596(a5) # 80007210 <_ZN15MemoryAllocator20flagSystemInitializeE>
    80001fc4:	02078c63          	beqz	a5,80001ffc <_ZN15MemoryAllocator14allocateMemoryEm+0x58>
    if(numOfFreeBlocks < blocksToAllocate)
    80001fc8:	00005797          	auipc	a5,0x5
    80001fcc:	2387b783          	ld	a5,568(a5) # 80007200 <_ZN15MemoryAllocator15numOfFreeBlocksE>
    80001fd0:	0297ec63          	bltu	a5,s1,80002008 <_ZN15MemoryAllocator14allocateMemoryEm+0x64>
    return findBestFit(&firstFreeBlock, blocksToAllocate);
    80001fd4:	00048593          	mv	a1,s1
    80001fd8:	00005517          	auipc	a0,0x5
    80001fdc:	23050513          	addi	a0,a0,560 # 80007208 <_ZN15MemoryAllocator14firstFreeBlockE>
    80001fe0:	00000097          	auipc	ra,0x0
    80001fe4:	f20080e7          	jalr	-224(ra) # 80001f00 <_ZN15MemoryAllocator11findBestFitEPPNS_9FreeBlockEm>
}
    80001fe8:	01813083          	ld	ra,24(sp)
    80001fec:	01013403          	ld	s0,16(sp)
    80001ff0:	00813483          	ld	s1,8(sp)
    80001ff4:	02010113          	addi	sp,sp,32
    80001ff8:	00008067          	ret
        initializeMemory();
    80001ffc:	00000097          	auipc	ra,0x0
    80002000:	e00080e7          	jalr	-512(ra) # 80001dfc <_ZN15MemoryAllocator16initializeMemoryEv>
    80002004:	fc5ff06f          	j	80001fc8 <_ZN15MemoryAllocator14allocateMemoryEm+0x24>
        return nullptr;
    80002008:	00000513          	li	a0,0
    8000200c:	fddff06f          	j	80001fe8 <_ZN15MemoryAllocator14allocateMemoryEm+0x44>

0000000080002010 <_ZN15MemoryAllocator17findNextFreeBlockEPNS_9FreeBlockE>:
MemoryAllocator::FreeBlock* MemoryAllocator::findNextFreeBlock(FreeBlock* memoryToFree)
{
    80002010:	ff010113          	addi	sp,sp,-16
    80002014:	00813423          	sd	s0,8(sp)
    80002018:	01010413          	addi	s0,sp,16
    for(uint8* i = (uint8*)memoryToFree; i + MEM_BLOCK_SIZE <= (uint8*)HEAP_END_ADDR; i+= (((OccupiedBlock*)i)->numOfBlocks * MEM_BLOCK_SIZE))
    8000201c:	04050793          	addi	a5,a0,64
    80002020:	00005717          	auipc	a4,0x5
    80002024:	10073703          	ld	a4,256(a4) # 80007120 <_GLOBAL_OFFSET_TABLE_+0x70>
    80002028:	00073703          	ld	a4,0(a4)
    8000202c:	00f76e63          	bltu	a4,a5,80002048 <_ZN15MemoryAllocator17findNextFreeBlockEPNS_9FreeBlockE+0x38>
    {
        if(((FreeBlock*)i)->flagFree)
    80002030:	00054783          	lbu	a5,0(a0)
    80002034:	00079c63          	bnez	a5,8000204c <_ZN15MemoryAllocator17findNextFreeBlockEPNS_9FreeBlockE+0x3c>
    for(uint8* i = (uint8*)memoryToFree; i + MEM_BLOCK_SIZE <= (uint8*)HEAP_END_ADDR; i+= (((OccupiedBlock*)i)->numOfBlocks * MEM_BLOCK_SIZE))
    80002038:	00853783          	ld	a5,8(a0)
    8000203c:	00679793          	slli	a5,a5,0x6
    80002040:	00f50533          	add	a0,a0,a5
    80002044:	fd9ff06f          	j	8000201c <_ZN15MemoryAllocator17findNextFreeBlockEPNS_9FreeBlockE+0xc>
        {
            return (FreeBlock*)i;
        }
    }
    return nullptr;
    80002048:	00000513          	li	a0,0
}
    8000204c:	00813403          	ld	s0,8(sp)
    80002050:	01010113          	addi	sp,sp,16
    80002054:	00008067          	ret

0000000080002058 <_ZN15MemoryAllocator21findPreviousFreeBlockEPNS_9FreeBlockES1_>:

MemoryAllocator::FreeBlock* MemoryAllocator::findPreviousFreeBlock(FreeBlock* head, FreeBlock* memoryToFree)
{
    80002058:	ff010113          	addi	sp,sp,-16
    8000205c:	00813423          	sd	s0,8(sp)
    80002060:	01010413          	addi	s0,sp,16
    FreeBlock* temp = head;
    for(; temp && temp <= memoryToFree; temp = temp->nextBlock){}
    80002064:	00050863          	beqz	a0,80002074 <_ZN15MemoryAllocator21findPreviousFreeBlockEPNS_9FreeBlockES1_+0x1c>
    80002068:	00a5e663          	bltu	a1,a0,80002074 <_ZN15MemoryAllocator21findPreviousFreeBlockEPNS_9FreeBlockES1_+0x1c>
    8000206c:	01053503          	ld	a0,16(a0)
    80002070:	ff5ff06f          	j	80002064 <_ZN15MemoryAllocator21findPreviousFreeBlockEPNS_9FreeBlockES1_+0xc>
    if(!temp)
    80002074:	00050463          	beqz	a0,8000207c <_ZN15MemoryAllocator21findPreviousFreeBlockEPNS_9FreeBlockES1_+0x24>
    {
        return nullptr;
    }
    return temp->previousBlock;
    80002078:	01853503          	ld	a0,24(a0)
}
    8000207c:	00813403          	ld	s0,8(sp)
    80002080:	01010113          	addi	sp,sp,16
    80002084:	00008067          	ret

0000000080002088 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_>:

    return 0;
}

void MemoryAllocator::connectAdjacentBlocks(FreeBlock* previousBlock, FreeBlock* adjacentBlock)
{
    80002088:	ff010113          	addi	sp,sp,-16
    8000208c:	00813423          	sd	s0,8(sp)
    80002090:	01010413          	addi	s0,sp,16


    if(adjacentBlock == (FreeBlock*)((uint8 *)previousBlock + previousBlock->numOfBlocks * MEM_BLOCK_SIZE))
    80002094:	00853703          	ld	a4,8(a0)
    80002098:	00671793          	slli	a5,a4,0x6
    8000209c:	00f507b3          	add	a5,a0,a5
    800020a0:	00b78e63          	beq	a5,a1,800020bc <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_+0x34>
        adjacentBlock->previousBlock = nullptr;

    }
    else
    {
        previousBlock->nextBlock = adjacentBlock;
    800020a4:	00b53823          	sd	a1,16(a0)
        if(adjacentBlock)
    800020a8:	00058463          	beqz	a1,800020b0 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_+0x28>
        {
            adjacentBlock->previousBlock = previousBlock;
    800020ac:	00a5bc23          	sd	a0,24(a1)
        }

    }
}
    800020b0:	00813403          	ld	s0,8(sp)
    800020b4:	01010113          	addi	sp,sp,16
    800020b8:	00008067          	ret
        previousBlock->numOfBlocks += adjacentBlock->numOfBlocks;
    800020bc:	0085b783          	ld	a5,8(a1)
    800020c0:	00f70733          	add	a4,a4,a5
    800020c4:	00e53423          	sd	a4,8(a0)
        previousBlock->nextBlock = adjacentBlock->nextBlock;
    800020c8:	0105b783          	ld	a5,16(a1)
    800020cc:	00f53823          	sd	a5,16(a0)
        if(adjacentBlock->nextBlock != nullptr)
    800020d0:	00078463          	beqz	a5,800020d8 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_+0x50>
            adjacentBlock->nextBlock->previousBlock = previousBlock;
    800020d4:	00a7bc23          	sd	a0,24(a5)
        if(adjacentBlock->previousBlock != previousBlock && adjacentBlock->previousBlock != nullptr)
    800020d8:	0185b783          	ld	a5,24(a1)
    800020dc:	00a78863          	beq	a5,a0,800020ec <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_+0x64>
    800020e0:	00078663          	beqz	a5,800020ec <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_+0x64>
            previousBlock->previousBlock = adjacentBlock->previousBlock;
    800020e4:	00f53c23          	sd	a5,24(a0)
            adjacentBlock->previousBlock->nextBlock = previousBlock;
    800020e8:	00a7b823          	sd	a0,16(a5)
        adjacentBlock->flagFree = false;
    800020ec:	00058023          	sb	zero,0(a1)
        adjacentBlock->numOfBlocks = 0;
    800020f0:	0005b423          	sd	zero,8(a1)
        adjacentBlock->nextBlock = nullptr;
    800020f4:	0005b823          	sd	zero,16(a1)
        adjacentBlock->previousBlock = nullptr;
    800020f8:	0005bc23          	sd	zero,24(a1)
    800020fc:	fb5ff06f          	j	800020b0 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_+0x28>

0000000080002100 <_ZN15MemoryAllocator10freeMemoryEPv>:
    if(!addressToFree)
    80002100:	0c050e63          	beqz	a0,800021dc <_ZN15MemoryAllocator10freeMemoryEPv+0xdc>
{
    80002104:	fc010113          	addi	sp,sp,-64
    80002108:	02113c23          	sd	ra,56(sp)
    8000210c:	02813823          	sd	s0,48(sp)
    80002110:	02913423          	sd	s1,40(sp)
    80002114:	03213023          	sd	s2,32(sp)
    80002118:	01313c23          	sd	s3,24(sp)
    8000211c:	01413823          	sd	s4,16(sp)
    80002120:	01513423          	sd	s5,8(sp)
    80002124:	04010413          	addi	s0,sp,64
    80002128:	00050493          	mv	s1,a0
    tempAddress--;
    8000212c:	ff050913          	addi	s2,a0,-16
    int numOfTakenBlocks = tempAddress->numOfBlocks;
    80002130:	ff852a83          	lw	s5,-8(a0)
    numOfFreeBlocks += numOfTakenBlocks;
    80002134:	00005997          	auipc	s3,0x5
    80002138:	0c498993          	addi	s3,s3,196 # 800071f8 <_ZN15MemoryAllocator13NUM_OF_BLOCKSE>
    8000213c:	0089b783          	ld	a5,8(s3)
    80002140:	015787b3          	add	a5,a5,s5
    80002144:	00f9b423          	sd	a5,8(s3)
    FreeBlock* nextFreeBlock = findNextFreeBlock(newFreeBlock);
    80002148:	00090513          	mv	a0,s2
    8000214c:	00000097          	auipc	ra,0x0
    80002150:	ec4080e7          	jalr	-316(ra) # 80002010 <_ZN15MemoryAllocator17findNextFreeBlockEPNS_9FreeBlockE>
    80002154:	00050a13          	mv	s4,a0
    FreeBlock* previousFreeBlock = findPreviousFreeBlock(firstFreeBlock, newFreeBlock);
    80002158:	00090593          	mv	a1,s2
    8000215c:	0109b503          	ld	a0,16(s3)
    80002160:	00000097          	auipc	ra,0x0
    80002164:	ef8080e7          	jalr	-264(ra) # 80002058 <_ZN15MemoryAllocator21findPreviousFreeBlockEPNS_9FreeBlockES1_>
    80002168:	00050993          	mv	s3,a0
    newFreeBlock->flagFree = true;
    8000216c:	00100793          	li	a5,1
    80002170:	fef48823          	sb	a5,-16(s1)
    newFreeBlock->numOfBlocks = numOfTakenBlocks;
    80002174:	ff54bc23          	sd	s5,-8(s1)
    newFreeBlock->nextBlock = nullptr;
    80002178:	0004b023          	sd	zero,0(s1)
    newFreeBlock->previousBlock = nullptr;
    8000217c:	0004b423          	sd	zero,8(s1)
    connectAdjacentBlocks(newFreeBlock, nextFreeBlock);
    80002180:	000a0593          	mv	a1,s4
    80002184:	00090513          	mv	a0,s2
    80002188:	00000097          	auipc	ra,0x0
    8000218c:	f00080e7          	jalr	-256(ra) # 80002088 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_>
    if(previousFreeBlock)
    80002190:	02098e63          	beqz	s3,800021cc <_ZN15MemoryAllocator10freeMemoryEPv+0xcc>
        connectAdjacentBlocks(previousFreeBlock, newFreeBlock);
    80002194:	00090593          	mv	a1,s2
    80002198:	00098513          	mv	a0,s3
    8000219c:	00000097          	auipc	ra,0x0
    800021a0:	eec080e7          	jalr	-276(ra) # 80002088 <_ZN15MemoryAllocator21connectAdjacentBlocksEPNS_9FreeBlockES1_>
    return 0;
    800021a4:	00000513          	li	a0,0
}
    800021a8:	03813083          	ld	ra,56(sp)
    800021ac:	03013403          	ld	s0,48(sp)
    800021b0:	02813483          	ld	s1,40(sp)
    800021b4:	02013903          	ld	s2,32(sp)
    800021b8:	01813983          	ld	s3,24(sp)
    800021bc:	01013a03          	ld	s4,16(sp)
    800021c0:	00813a83          	ld	s5,8(sp)
    800021c4:	04010113          	addi	sp,sp,64
    800021c8:	00008067          	ret
        firstFreeBlock = newFreeBlock;
    800021cc:	00005797          	auipc	a5,0x5
    800021d0:	0327be23          	sd	s2,60(a5) # 80007208 <_ZN15MemoryAllocator14firstFreeBlockE>
    return 0;
    800021d4:	00000513          	li	a0,0
    800021d8:	fd1ff06f          	j	800021a8 <_ZN15MemoryAllocator10freeMemoryEPv+0xa8>
        return -1;
    800021dc:	fff00513          	li	a0,-1
}
    800021e0:	00008067          	ret

00000000800021e4 <_ZN15MemoryAllocator19getLargestFreeBlockEv>:

size_t  MemoryAllocator::getLargestFreeBlock()
{
    800021e4:	ff010113          	addi	sp,sp,-16
    800021e8:	00813423          	sd	s0,8(sp)
    800021ec:	01010413          	addi	s0,sp,16
    size_t largestBlock = firstFreeBlock->numOfBlocks;
    800021f0:	00005797          	auipc	a5,0x5
    800021f4:	0187b783          	ld	a5,24(a5) # 80007208 <_ZN15MemoryAllocator14firstFreeBlockE>
    800021f8:	0087b503          	ld	a0,8(a5)
    for(FreeBlock* curr = firstFreeBlock->nextBlock; curr; curr = curr->nextBlock)
    800021fc:	0107b783          	ld	a5,16(a5)
    80002200:	0080006f          	j	80002208 <_ZN15MemoryAllocator19getLargestFreeBlockEv+0x24>
    80002204:	0107b783          	ld	a5,16(a5)
    80002208:	00078a63          	beqz	a5,8000221c <_ZN15MemoryAllocator19getLargestFreeBlockEv+0x38>
    {
        if(curr->numOfBlocks > largestBlock)
    8000220c:	0087b703          	ld	a4,8(a5)
    80002210:	fee57ae3          	bgeu	a0,a4,80002204 <_ZN15MemoryAllocator19getLargestFreeBlockEv+0x20>
        {
            largestBlock = curr->numOfBlocks;
    80002214:	00070513          	mv	a0,a4
    80002218:	fedff06f          	j	80002204 <_ZN15MemoryAllocator19getLargestFreeBlockEv+0x20>
        }
    }
    return largestBlock * MEM_BLOCK_SIZE;
}
    8000221c:	00651513          	slli	a0,a0,0x6
    80002220:	00813403          	ld	s0,8(sp)
    80002224:	01010113          	addi	sp,sp,16
    80002228:	00008067          	ret

000000008000222c <_ZN15MemoryAllocator12getFreeSpaceEv>:
size_t MemoryAllocator::getFreeSpace()
{
    8000222c:	ff010113          	addi	sp,sp,-16
    80002230:	00813423          	sd	s0,8(sp)
    80002234:	01010413          	addi	s0,sp,16
    return numOfFreeBlocks * MEM_BLOCK_SIZE;
}
    80002238:	00005517          	auipc	a0,0x5
    8000223c:	fc853503          	ld	a0,-56(a0) # 80007200 <_ZN15MemoryAllocator15numOfFreeBlocksE>
    80002240:	00651513          	slli	a0,a0,0x6
    80002244:	00813403          	ld	s0,8(sp)
    80002248:	01010113          	addi	sp,sp,16
    8000224c:	00008067          	ret

0000000080002250 <_ZN15MemoryAllocator17getSizeOfMetaDataEv>:

size_t MemoryAllocator::getSizeOfMetaData()
{
    80002250:	ff010113          	addi	sp,sp,-16
    80002254:	00813423          	sd	s0,8(sp)
    80002258:	01010413          	addi	s0,sp,16
    return sizeof(OccupiedBlock);
    8000225c:	01000513          	li	a0,16
    80002260:	00813403          	ld	s0,8(sp)
    80002264:	01010113          	addi	sp,sp,16
    80002268:	00008067          	ret

000000008000226c <_ZN10KSemaphore19initializeSemaphoreEjP10ObjectPoolIS_Lm10EE>:


extern "C" void context_switch(TCB::Context* oldContext, TCB::Context* newContext);

void KSemaphore::initializeSemaphore(unsigned value, ObjectPool<KSemaphore, KernelConfig::NUM_OF_SEMAPHORES_IN_POOL>* pool)
{
    8000226c:	ff010113          	addi	sp,sp,-16
    80002270:	00813423          	sd	s0,8(sp)
    80002274:	01010413          	addi	s0,sp,16
    semaphoreVal = value;
    80002278:	02059593          	slli	a1,a1,0x20
    8000227c:	0205d593          	srli	a1,a1,0x20
    80002280:	00b53023          	sd	a1,0(a0)
    headBlockedThread = nullptr;
    80002284:	00053423          	sd	zero,8(a0)
    tailBlockedThread = nullptr;
    80002288:	00053823          	sd	zero,16(a0)
    sourcePool = pool;
    8000228c:	00c53c23          	sd	a2,24(a0)
}
    80002290:	00813403          	ld	s0,8(sp)
    80002294:	01010113          	addi	sp,sp,16
    80002298:	00008067          	ret

000000008000229c <_ZN10KSemaphore11blockThreadEP3TCB>:

void KSemaphore::blockThread(TCB* threadToBlock)
{
    8000229c:	ff010113          	addi	sp,sp,-16
    800022a0:	00813423          	sd	s0,8(sp)
    800022a4:	01010413          	addi	s0,sp,16
    void setSemaphoreOnWait (KSemaphore* semaphore) { waitOnSemaphore = semaphore; }
    800022a8:	04a5b023          	sd	a0,64(a1)
    threadToBlock->setSemaphoreOnWait(this);
    if(!headBlockedThread)
    800022ac:	00853783          	ld	a5,8(a0)
    800022b0:	00078e63          	beqz	a5,800022cc <_ZN10KSemaphore11blockThreadEP3TCB+0x30>
    {
        headBlockedThread = threadToBlock;
    }
    else
    {
        tailBlockedThread->addThreadToState(threadToBlock);
    800022b4:	01053783          	ld	a5,16(a0)
    void addThreadToState(TCB* newThread) { state = newThread; }
    800022b8:	04b7b423          	sd	a1,72(a5)
    }
    tailBlockedThread = threadToBlock;
    800022bc:	00b53823          	sd	a1,16(a0)
}
    800022c0:	00813403          	ld	s0,8(sp)
    800022c4:	01010113          	addi	sp,sp,16
    800022c8:	00008067          	ret
        headBlockedThread = threadToBlock;
    800022cc:	00b53423          	sd	a1,8(a0)
    800022d0:	fedff06f          	j	800022bc <_ZN10KSemaphore11blockThreadEP3TCB+0x20>

00000000800022d4 <_ZN10KSemaphore13unblockThreadEN12KernelConfig12WakeUpReasonE>:

int KSemaphore::unblockThread(KernelConfig::WakeUpReason reason)
{
    800022d4:	00050793          	mv	a5,a0
   if(!headBlockedThread)
    800022d8:	00853503          	ld	a0,8(a0)
    800022dc:	04050863          	beqz	a0,8000232c <_ZN10KSemaphore13unblockThreadEN12KernelConfig12WakeUpReasonE+0x58>
{
    800022e0:	ff010113          	addi	sp,sp,-16
    800022e4:	00113423          	sd	ra,8(sp)
    800022e8:	00813023          	sd	s0,0(sp)
    800022ec:	01010413          	addi	s0,sp,16
    TCB* getState() const { return state; }
    800022f0:	04853703          	ld	a4,72(a0)
   {
       return -1;
   }
   TCB* oldThread = headBlockedThread;
   headBlockedThread = headBlockedThread->getState();
    800022f4:	00e7b423          	sd	a4,8(a5)
   if(!headBlockedThread)
    800022f8:	02070663          	beqz	a4,80002324 <_ZN10KSemaphore13unblockThreadEN12KernelConfig12WakeUpReasonE+0x50>
    void setWakeUpReason(KernelConfig::WakeUpReason reason) { wakeUpReason = reason; }
    800022fc:	04b52a23          	sw	a1,84(a0)
    void resetState() {state = nullptr; }
    80002300:	04053423          	sd	zero,72(a0)
    void resetSemaphoreOnWait() { waitOnSemaphore = nullptr; }
    80002304:	04053023          	sd	zero,64(a0)
       tailBlockedThread = nullptr;
   }
   oldThread->setWakeUpReason(reason);
   oldThread->resetState();
   oldThread->resetSemaphoreOnWait();
   Scheduler::put(oldThread);
    80002308:	00000097          	auipc	ra,0x0
    8000230c:	8f8080e7          	jalr	-1800(ra) # 80001c00 <_ZN9Scheduler3putEP3TCB>
   return 0;
    80002310:	00000513          	li	a0,0
}
    80002314:	00813083          	ld	ra,8(sp)
    80002318:	00013403          	ld	s0,0(sp)
    8000231c:	01010113          	addi	sp,sp,16
    80002320:	00008067          	ret
       tailBlockedThread = nullptr;
    80002324:	0007b823          	sd	zero,16(a5)
    80002328:	fd5ff06f          	j	800022fc <_ZN10KSemaphore13unblockThreadEN12KernelConfig12WakeUpReasonE+0x28>
       return -1;
    8000232c:	fff00513          	li	a0,-1
}
    80002330:	00008067          	ret

0000000080002334 <_ZN10KSemaphore4waitEv>:

int KSemaphore::wait()
{
    semaphoreVal--;
    80002334:	00053783          	ld	a5,0(a0)
    80002338:	fff78793          	addi	a5,a5,-1
    8000233c:	00f53023          	sd	a5,0(a0)
    if(semaphoreVal < 0)
    80002340:	0007c663          	bltz	a5,8000234c <_ZN10KSemaphore4waitEv+0x18>
        {
            return -1;
        }

    }
    return 0;
    80002344:	00000513          	li	a0,0
}
    80002348:	00008067          	ret
{
    8000234c:	fd010113          	addi	sp,sp,-48
    80002350:	02113423          	sd	ra,40(sp)
    80002354:	02813023          	sd	s0,32(sp)
    80002358:	00913c23          	sd	s1,24(sp)
    8000235c:	01213823          	sd	s2,16(sp)
    80002360:	01313423          	sd	s3,8(sp)
    80002364:	03010413          	addi	s0,sp,48
    80002368:	00050493          	mv	s1,a0
    static TCB* getRunningThread() { return running; }
    8000236c:	00005917          	auipc	s2,0x5
    80002370:	da493903          	ld	s2,-604(s2) # 80007110 <_GLOBAL_OFFSET_TABLE_+0x60>
    80002374:	00093983          	ld	s3,0(s2)
        TCB::setRunningThread(Scheduler::get());
    80002378:	00000097          	auipc	ra,0x0
    8000237c:	8cc080e7          	jalr	-1844(ra) # 80001c44 <_ZN9Scheduler3getEv>
    static void setRunningThread(TCB* newRunningThread) { running = newRunningThread; }
    80002380:	00a93023          	sd	a0,0(s2)
    void resetState() {state = nullptr; }
    80002384:	0409b423          	sd	zero,72(s3)
        blockThread(oldThread);
    80002388:	00098593          	mv	a1,s3
    8000238c:	00048513          	mv	a0,s1
    80002390:	00000097          	auipc	ra,0x0
    80002394:	f0c080e7          	jalr	-244(ra) # 8000229c <_ZN10KSemaphore11blockThreadEP3TCB>
    static TCB* getRunningThread() { return running; }
    80002398:	00093583          	ld	a1,0(s2)
        context_switch(oldThread->getContext(), TCB::getRunningThread()->getContext());
    8000239c:	00858593          	addi	a1,a1,8
    800023a0:	00898513          	addi	a0,s3,8
    800023a4:	fffff097          	auipc	ra,0xfffff
    800023a8:	dfc080e7          	jalr	-516(ra) # 800011a0 <context_switch>
    800023ac:	00093783          	ld	a5,0(s2)
    KernelConfig::WakeUpReason getWakeUpReason() { return wakeUpReason; }
    800023b0:	0547a783          	lw	a5,84(a5)
        if(TCB::getRunningThread()->getWakeUpReason() == KernelConfig::WAKE_UP_SEMAPHORE_SIGNAL)
    800023b4:	02078663          	beqz	a5,800023e0 <_ZN10KSemaphore4waitEv+0xac>
        if(TCB::getRunningThread()->getWakeUpReason() == KernelConfig::WAKE_UP_SEMAPHORE_CLOSE)
    800023b8:	00100713          	li	a4,1
    800023bc:	02e78663          	beq	a5,a4,800023e8 <_ZN10KSemaphore4waitEv+0xb4>
    return 0;
    800023c0:	00000513          	li	a0,0
}
    800023c4:	02813083          	ld	ra,40(sp)
    800023c8:	02013403          	ld	s0,32(sp)
    800023cc:	01813483          	ld	s1,24(sp)
    800023d0:	01013903          	ld	s2,16(sp)
    800023d4:	00813983          	ld	s3,8(sp)
    800023d8:	03010113          	addi	sp,sp,48
    800023dc:	00008067          	ret
            return 0;
    800023e0:	00000513          	li	a0,0
    800023e4:	fe1ff06f          	j	800023c4 <_ZN10KSemaphore4waitEv+0x90>
            return -1;
    800023e8:	fff00513          	li	a0,-1
    800023ec:	fd9ff06f          	j	800023c4 <_ZN10KSemaphore4waitEv+0x90>

00000000800023f0 <_ZN10KSemaphore6signalEv>:

int KSemaphore::signal()
{
    semaphoreVal++;
    800023f0:	00053783          	ld	a5,0(a0)
    800023f4:	00178793          	addi	a5,a5,1
    800023f8:	00f53023          	sd	a5,0(a0)
    if(semaphoreVal <= 0)
    800023fc:	00f05663          	blez	a5,80002408 <_ZN10KSemaphore6signalEv+0x18>
    {
        return unblockThread(KernelConfig::WAKE_UP_SEMAPHORE_SIGNAL);
    }
    return 0;
    80002400:	00000513          	li	a0,0
}
    80002404:	00008067          	ret
{
    80002408:	ff010113          	addi	sp,sp,-16
    8000240c:	00113423          	sd	ra,8(sp)
    80002410:	00813023          	sd	s0,0(sp)
    80002414:	01010413          	addi	s0,sp,16
        return unblockThread(KernelConfig::WAKE_UP_SEMAPHORE_SIGNAL);
    80002418:	00000593          	li	a1,0
    8000241c:	00000097          	auipc	ra,0x0
    80002420:	eb8080e7          	jalr	-328(ra) # 800022d4 <_ZN10KSemaphore13unblockThreadEN12KernelConfig12WakeUpReasonE>
}
    80002424:	00813083          	ld	ra,8(sp)
    80002428:	00013403          	ld	s0,0(sp)
    8000242c:	01010113          	addi	sp,sp,16
    80002430:	00008067          	ret

0000000080002434 <_ZN10KSemaphore5closeEv>:

int KSemaphore::close()
{
    80002434:	fe010113          	addi	sp,sp,-32
    80002438:	00113c23          	sd	ra,24(sp)
    8000243c:	00813823          	sd	s0,16(sp)
    80002440:	00913423          	sd	s1,8(sp)
    80002444:	01213023          	sd	s2,0(sp)
    80002448:	02010413          	addi	s0,sp,32
    8000244c:	00050913          	mv	s2,a0
    TCB* tempThread = headBlockedThread;
    80002450:	00853483          	ld	s1,8(a0)
    if(!tempThread)
    80002454:	02048063          	beqz	s1,80002474 <_ZN10KSemaphore5closeEv+0x40>
    {
        return 0;
    }
    for(;tempThread; tempThread = tempThread->getState())
    80002458:	02048263          	beqz	s1,8000247c <_ZN10KSemaphore5closeEv+0x48>
    {
        unblockThread(KernelConfig::WAKE_UP_SEMAPHORE_CLOSE);
    8000245c:	00100593          	li	a1,1
    80002460:	00090513          	mv	a0,s2
    80002464:	00000097          	auipc	ra,0x0
    80002468:	e70080e7          	jalr	-400(ra) # 800022d4 <_ZN10KSemaphore13unblockThreadEN12KernelConfig12WakeUpReasonE>
    TCB* getState() const { return state; }
    8000246c:	0484b483          	ld	s1,72(s1)
    for(;tempThread; tempThread = tempThread->getState())
    80002470:	fe9ff06f          	j	80002458 <_ZN10KSemaphore5closeEv+0x24>
        return 0;
    80002474:	00000513          	li	a0,0
    80002478:	0080006f          	j	80002480 <_ZN10KSemaphore5closeEv+0x4c>
    }
    return -1;
    8000247c:	fff00513          	li	a0,-1

}
    80002480:	01813083          	ld	ra,24(sp)
    80002484:	01013403          	ld	s0,16(sp)
    80002488:	00813483          	ld	s1,8(sp)
    8000248c:	00013903          	ld	s2,0(sp)
    80002490:	02010113          	addi	sp,sp,32
    80002494:	00008067          	ret

0000000080002498 <_ZN10KSemaphore25removeThreadFromWaitQueueEP3TCB>:
void KSemaphore::removeThreadFromWaitQueue(TCB *thread)
{
    80002498:	ff010113          	addi	sp,sp,-16
    8000249c:	00813423          	sd	s0,8(sp)
    800024a0:	01010413          	addi	s0,sp,16
    TCB* currThread = headBlockedThread, *prevThread = nullptr;
    800024a4:	00853683          	ld	a3,8(a0)
    800024a8:	00068793          	mv	a5,a3
    800024ac:	00000713          	li	a4,0

    while(thread != currThread && currThread)
    800024b0:	00b78a63          	beq	a5,a1,800024c4 <_ZN10KSemaphore25removeThreadFromWaitQueueEP3TCB+0x2c>
    800024b4:	00078863          	beqz	a5,800024c4 <_ZN10KSemaphore25removeThreadFromWaitQueueEP3TCB+0x2c>
    {
        prevThread = currThread;
    800024b8:	00078713          	mv	a4,a5
        currThread = currThread->getState();
    800024bc:	0487b783          	ld	a5,72(a5)
    while(thread != currThread && currThread)
    800024c0:	ff1ff06f          	j	800024b0 <_ZN10KSemaphore25removeThreadFromWaitQueueEP3TCB+0x18>
    }

    if(!prevThread)
    800024c4:	02070463          	beqz	a4,800024ec <_ZN10KSemaphore25removeThreadFromWaitQueueEP3TCB+0x54>
    800024c8:	0485b783          	ld	a5,72(a1)
    void addThreadToState(TCB* newThread) { state = newThread; }
    800024cc:	04f73423          	sd	a5,72(a4)
    void resetSemaphoreOnWait() { waitOnSemaphore = nullptr; }
    800024d0:	0405b023          	sd	zero,64(a1)
    void resetState() {state = nullptr; }
    800024d4:	0405b423          	sd	zero,72(a1)
    else
    {
        prevThread->addThreadToState(thread->getState());
        thread->resetSemaphoreOnWait();
        thread->resetState();
        if(thread == tailBlockedThread)
    800024d8:	01053783          	ld	a5,16(a0)
    800024dc:	02b78863          	beq	a5,a1,8000250c <_ZN10KSemaphore25removeThreadFromWaitQueueEP3TCB+0x74>
        {
            tailBlockedThread = prevThread;
        }
    }
    800024e0:	00813403          	ld	s0,8(sp)
    800024e4:	01010113          	addi	sp,sp,16
    800024e8:	00008067          	ret
    TCB* getState() const { return state; }
    800024ec:	0486b783          	ld	a5,72(a3)
        headBlockedThread = headBlockedThread->getState();
    800024f0:	00f53423          	sd	a5,8(a0)
    void resetSemaphoreOnWait() { waitOnSemaphore = nullptr; }
    800024f4:	0405b023          	sd	zero,64(a1)
    void resetState() {state = nullptr; }
    800024f8:	0405b423          	sd	zero,72(a1)
        if(!headBlockedThread)
    800024fc:	00853783          	ld	a5,8(a0)
    80002500:	fe0790e3          	bnez	a5,800024e0 <_ZN10KSemaphore25removeThreadFromWaitQueueEP3TCB+0x48>
            tailBlockedThread = nullptr;
    80002504:	00053823          	sd	zero,16(a0)
    80002508:	fd9ff06f          	j	800024e0 <_ZN10KSemaphore25removeThreadFromWaitQueueEP3TCB+0x48>
            tailBlockedThread = prevThread;
    8000250c:	00e53823          	sd	a4,16(a0)
    80002510:	fd1ff06f          	j	800024e0 <_ZN10KSemaphore25removeThreadFromWaitQueueEP3TCB+0x48>

0000000080002514 <_ZN6Kernel12kernelWorkerEPv>:
    }

}

void Kernel::kernelWorker(void*)
{
    80002514:	ff010113          	addi	sp,sp,-16
    80002518:	00813423          	sd	s0,8(sp)
    8000251c:	01010413          	addi	s0,sp,16
    while(1)
    80002520:	0000006f          	j	80002520 <_ZN6Kernel12kernelWorkerEPv+0xc>

0000000080002524 <_ZN6Kernel12sysTimeSleepEPNS_21ArgumentsOfSystemCallE>:
    KSemaphore* tempSemaphore = (KSemaphore*)(arg->a0);
    return (uint64)tempSemaphore->signal();
}

uint64 Kernel::sysTimeSleep(ArgumentsOfSystemCall *arg)
{
    80002524:	ff010113          	addi	sp,sp,-16
    80002528:	00813423          	sd	s0,8(sp)
    8000252c:	01010413          	addi	s0,sp,16
    return 0;
}
    80002530:	00000513          	li	a0,0
    80002534:	00813403          	ld	s0,8(sp)
    80002538:	01010113          	addi	sp,sp,16
    8000253c:	00008067          	ret

0000000080002540 <_ZN6Kernel9sysMallocEPNS_21ArgumentsOfSystemCallE>:
{
    80002540:	ff010113          	addi	sp,sp,-16
    80002544:	00113423          	sd	ra,8(sp)
    80002548:	00813023          	sd	s0,0(sp)
    8000254c:	01010413          	addi	s0,sp,16
    return (uint64)MemoryAllocator::allocateMemory(arg->a0);
    80002550:	00053503          	ld	a0,0(a0)
    80002554:	00000097          	auipc	ra,0x0
    80002558:	a50080e7          	jalr	-1456(ra) # 80001fa4 <_ZN15MemoryAllocator14allocateMemoryEm>
}
    8000255c:	00813083          	ld	ra,8(sp)
    80002560:	00013403          	ld	s0,0(sp)
    80002564:	01010113          	addi	sp,sp,16
    80002568:	00008067          	ret

000000008000256c <_ZN6Kernel7sysFreeEPNS_21ArgumentsOfSystemCallE>:
{
    8000256c:	ff010113          	addi	sp,sp,-16
    80002570:	00113423          	sd	ra,8(sp)
    80002574:	00813023          	sd	s0,0(sp)
    80002578:	01010413          	addi	s0,sp,16
    return (uint64)MemoryAllocator::freeMemory((void*)arg->a0);
    8000257c:	00053503          	ld	a0,0(a0)
    80002580:	00000097          	auipc	ra,0x0
    80002584:	b80080e7          	jalr	-1152(ra) # 80002100 <_ZN15MemoryAllocator10freeMemoryEPv>
}
    80002588:	00813083          	ld	ra,8(sp)
    8000258c:	00013403          	ld	s0,0(sp)
    80002590:	01010113          	addi	sp,sp,16
    80002594:	00008067          	ret

0000000080002598 <_ZN6Kernel15sysGetFreeSpaceEPNS_21ArgumentsOfSystemCallE>:
{
    80002598:	ff010113          	addi	sp,sp,-16
    8000259c:	00113423          	sd	ra,8(sp)
    800025a0:	00813023          	sd	s0,0(sp)
    800025a4:	01010413          	addi	s0,sp,16
    return (uint64)MemoryAllocator::getFreeSpace();
    800025a8:	00000097          	auipc	ra,0x0
    800025ac:	c84080e7          	jalr	-892(ra) # 8000222c <_ZN15MemoryAllocator12getFreeSpaceEv>
}
    800025b0:	00813083          	ld	ra,8(sp)
    800025b4:	00013403          	ld	s0,0(sp)
    800025b8:	01010113          	addi	sp,sp,16
    800025bc:	00008067          	ret

00000000800025c0 <_ZN6Kernel19sysLargestFreeBlockEPNS_21ArgumentsOfSystemCallE>:
{
    800025c0:	ff010113          	addi	sp,sp,-16
    800025c4:	00113423          	sd	ra,8(sp)
    800025c8:	00813023          	sd	s0,0(sp)
    800025cc:	01010413          	addi	s0,sp,16
    return (uint64)MemoryAllocator::getLargestFreeBlock();
    800025d0:	00000097          	auipc	ra,0x0
    800025d4:	c14080e7          	jalr	-1004(ra) # 800021e4 <_ZN15MemoryAllocator19getLargestFreeBlockEv>
}
    800025d8:	00813083          	ld	ra,8(sp)
    800025dc:	00013403          	ld	s0,0(sp)
    800025e0:	01010113          	addi	sp,sp,16
    800025e4:	00008067          	ret

00000000800025e8 <_ZN6Kernel16sysSemaphoreWaitEPNS_21ArgumentsOfSystemCallE>:
{
    800025e8:	ff010113          	addi	sp,sp,-16
    800025ec:	00113423          	sd	ra,8(sp)
    800025f0:	00813023          	sd	s0,0(sp)
    800025f4:	01010413          	addi	s0,sp,16
    return (uint64)tempSemaphore->wait();
    800025f8:	00053503          	ld	a0,0(a0)
    800025fc:	00000097          	auipc	ra,0x0
    80002600:	d38080e7          	jalr	-712(ra) # 80002334 <_ZN10KSemaphore4waitEv>
}
    80002604:	00813083          	ld	ra,8(sp)
    80002608:	00013403          	ld	s0,0(sp)
    8000260c:	01010113          	addi	sp,sp,16
    80002610:	00008067          	ret

0000000080002614 <_ZN6Kernel18sysSemaphoreSignalEPNS_21ArgumentsOfSystemCallE>:
{
    80002614:	ff010113          	addi	sp,sp,-16
    80002618:	00113423          	sd	ra,8(sp)
    8000261c:	00813023          	sd	s0,0(sp)
    80002620:	01010413          	addi	s0,sp,16
    return (uint64)tempSemaphore->signal();
    80002624:	00053503          	ld	a0,0(a0)
    80002628:	00000097          	auipc	ra,0x0
    8000262c:	dc8080e7          	jalr	-568(ra) # 800023f0 <_ZN10KSemaphore6signalEv>
}
    80002630:	00813083          	ld	ra,8(sp)
    80002634:	00013403          	ld	s0,0(sp)
    80002638:	01010113          	addi	sp,sp,16
    8000263c:	00008067          	ret

0000000080002640 <_ZN6Kernel19initializeArgumentsEPNS_21ArgumentsOfSystemCallEm>:
{
    80002640:	ff010113          	addi	sp,sp,-16
    80002644:	00813423          	sd	s0,8(sp)
    80002648:	01010413          	addi	s0,sp,16
    __asm__ volatile("ld %[rd], 11*8(%[rs])":[rd]"=r"(arg->a0):[rs]"r"(basePointer));
    8000264c:	0585b783          	ld	a5,88(a1)
    80002650:	00f53023          	sd	a5,0(a0)
    __asm__ volatile("ld %[rd], 12*8(%[rs])":[rd]"=r"(arg->a1):[rs]"r"(basePointer));
    80002654:	0605b783          	ld	a5,96(a1)
    80002658:	00f53423          	sd	a5,8(a0)
    __asm__ volatile("ld %[rd], 13*8(%[rs])":[rd]"=r"(arg->a2):[rs]"r"(basePointer));
    8000265c:	0685b783          	ld	a5,104(a1)
    80002660:	00f53823          	sd	a5,16(a0)
    __asm__ volatile("ld %[rd], 14*8(%[rs])":[rd]"=r"(arg->a3):[rs]"r"(basePointer));
    80002664:	0705b783          	ld	a5,112(a1)
    80002668:	00f53c23          	sd	a5,24(a0)
    __asm__ volatile("ld %[rd], 15*8(%[rs])":[rd]"=r"(arg->a4):[rs]"r"(basePointer));
    8000266c:	0785b783          	ld	a5,120(a1)
    80002670:	02f53023          	sd	a5,32(a0)
    __asm__ volatile("ld %[rd], 16*8(%[rs])":[rd]"=r"(arg->a5):[rs]"r"(basePointer));
    80002674:	0805b783          	ld	a5,128(a1)
    80002678:	02f53423          	sd	a5,40(a0)
    __asm__ volatile("ld %[rd], 17*8(%[rs])":[rd]"=r"(arg->a6):[rs]"r"(basePointer));
    8000267c:	0885b583          	ld	a1,136(a1)
    80002680:	02b53823          	sd	a1,48(a0)
}
    80002684:	00813403          	ld	s0,8(sp)
    80002688:	01010113          	addi	sp,sp,16
    8000268c:	00008067          	ret

0000000080002690 <_ZN6Kernel17mallocSystemStackEm>:
{
    80002690:	ff010113          	addi	sp,sp,-16
    80002694:	00113423          	sd	ra,8(sp)
    80002698:	00813023          	sd	s0,0(sp)
    8000269c:	01010413          	addi	s0,sp,16
    size_t numOfBlocks = numOfBytes / MEM_BLOCK_SIZE;
    800026a0:	00655793          	srli	a5,a0,0x6
    numOfBlocks += numOfBytes % MEM_BLOCK_SIZE ? 1 : 0;
    800026a4:	03f57513          	andi	a0,a0,63
    800026a8:	00050463          	beqz	a0,800026b0 <_ZN6Kernel17mallocSystemStackEm+0x20>
    800026ac:	00100513          	li	a0,1
    uint8* systemStack = (uint8*)MemoryAllocator::allocateMemory(numOfBlocks);
    800026b0:	00f50533          	add	a0,a0,a5
    800026b4:	00000097          	auipc	ra,0x0
    800026b8:	8f0080e7          	jalr	-1808(ra) # 80001fa4 <_ZN15MemoryAllocator14allocateMemoryEm>
}
    800026bc:	40050513          	addi	a0,a0,1024
    800026c0:	00813083          	ld	ra,8(sp)
    800026c4:	00013403          	ld	s0,0(sp)
    800026c8:	01010113          	addi	sp,sp,16
    800026cc:	00008067          	ret

00000000800026d0 <_ZN6Kernel17sysThreadDispatchEPNS_21ArgumentsOfSystemCallE>:
{
    800026d0:	ff010113          	addi	sp,sp,-16
    800026d4:	00113423          	sd	ra,8(sp)
    800026d8:	00813023          	sd	s0,0(sp)
    800026dc:	01010413          	addi	s0,sp,16
    TCB::dispatch();
    800026e0:	fffff097          	auipc	ra,0xfffff
    800026e4:	6b4080e7          	jalr	1716(ra) # 80001d94 <_ZN3TCB8dispatchEv>
}
    800026e8:	00000513          	li	a0,0
    800026ec:	00813083          	ld	ra,8(sp)
    800026f0:	00013403          	ld	s0,0(sp)
    800026f4:	01010113          	addi	sp,sp,16
    800026f8:	00008067          	ret

00000000800026fc <_ZN6Kernel21initializeSystemCallsEv>:
    KConsole::addCharToOutputBuffer(arg->a0);
    return 0;
}

void Kernel::initializeSystemCalls(void)
{
    800026fc:	ff010113          	addi	sp,sp,-16
    80002700:	00813423          	sd	s0,8(sp)
    80002704:	01010413          	addi	s0,sp,16
    systemCallsTable[KernelConfig::MEM_ALLOC] = &sysMalloc;
    80002708:	00005797          	auipc	a5,0x5
    8000270c:	b1078793          	addi	a5,a5,-1264 # 80007218 <_ZN6Kernel16systemCallsTableE>
    80002710:	00000717          	auipc	a4,0x0
    80002714:	e3070713          	addi	a4,a4,-464 # 80002540 <_ZN6Kernel9sysMallocEPNS_21ArgumentsOfSystemCallE>
    80002718:	00e7b423          	sd	a4,8(a5)
    systemCallsTable[KernelConfig::MEM_FREE] = &sysFree;
    8000271c:	00000717          	auipc	a4,0x0
    80002720:	e5070713          	addi	a4,a4,-432 # 8000256c <_ZN6Kernel7sysFreeEPNS_21ArgumentsOfSystemCallE>
    80002724:	00e7b823          	sd	a4,16(a5)
    systemCallsTable[KernelConfig::MEM_FREE_SPACE] = &sysGetFreeSpace;
    80002728:	00000717          	auipc	a4,0x0
    8000272c:	e7070713          	addi	a4,a4,-400 # 80002598 <_ZN6Kernel15sysGetFreeSpaceEPNS_21ArgumentsOfSystemCallE>
    80002730:	00e7bc23          	sd	a4,24(a5)
    systemCallsTable[KernelConfig::LARGEST_FREE_BLOCK] = &sysLargestFreeBlock;
    80002734:	00000717          	auipc	a4,0x0
    80002738:	e8c70713          	addi	a4,a4,-372 # 800025c0 <_ZN6Kernel19sysLargestFreeBlockEPNS_21ArgumentsOfSystemCallE>
    8000273c:	02e7b023          	sd	a4,32(a5)
    systemCallsTable[KernelConfig::THREAD_CREATE] = &sysThreadCreate;
    80002740:	00001717          	auipc	a4,0x1
    80002744:	93070713          	addi	a4,a4,-1744 # 80003070 <_ZN6Kernel15sysThreadCreateEPNS_21ArgumentsOfSystemCallE>
    80002748:	08e7b423          	sd	a4,136(a5)
    systemCallsTable[KernelConfig::SEMAPHORE_OPEN] = &sysSemaphoreOpen;
    8000274c:	00001717          	auipc	a4,0x1
    80002750:	9bc70713          	addi	a4,a4,-1604 # 80003108 <_ZN6Kernel16sysSemaphoreOpenEPNS_21ArgumentsOfSystemCallE>
    80002754:	10e7b423          	sd	a4,264(a5)
    systemCallsTable[KernelConfig::SEMAPHORE_CLOSE] = &sysSemaphoreClose;
    80002758:	00000717          	auipc	a4,0x0
    8000275c:	55070713          	addi	a4,a4,1360 # 80002ca8 <_ZN6Kernel17sysSemaphoreCloseEPNS_21ArgumentsOfSystemCallE>
    80002760:	10e7b823          	sd	a4,272(a5)
    systemCallsTable[KernelConfig::SEMAPHORE_SIGNAL] = &sysSemaphoreSignal;
    80002764:	00000717          	auipc	a4,0x0
    80002768:	eb070713          	addi	a4,a4,-336 # 80002614 <_ZN6Kernel18sysSemaphoreSignalEPNS_21ArgumentsOfSystemCallE>
    8000276c:	12e7b023          	sd	a4,288(a5)
    systemCallsTable[KernelConfig::SEMAPHORE_WAIT] = &sysSemaphoreWait;
    80002770:	00000717          	auipc	a4,0x0
    80002774:	e7870713          	addi	a4,a4,-392 # 800025e8 <_ZN6Kernel16sysSemaphoreWaitEPNS_21ArgumentsOfSystemCallE>
    80002778:	10e7bc23          	sd	a4,280(a5)
    systemCallsTable[KernelConfig::TIME_SLEEP] = &sysTimeSleep;
    8000277c:	00000717          	auipc	a4,0x0
    80002780:	da870713          	addi	a4,a4,-600 # 80002524 <_ZN6Kernel12sysTimeSleepEPNS_21ArgumentsOfSystemCallE>
    80002784:	18e7b423          	sd	a4,392(a5)
    systemCallsTable[KernelConfig::GETC] = &sysGetc;
    80002788:	00000717          	auipc	a4,0x0
    8000278c:	02470713          	addi	a4,a4,36 # 800027ac <_ZN6Kernel7sysGetcEPNS_21ArgumentsOfSystemCallE>
    80002790:	20e7b423          	sd	a4,520(a5)
    systemCallsTable[KernelConfig::PUTC] = &sysPutc;
    80002794:	00000717          	auipc	a4,0x0
    80002798:	2c070713          	addi	a4,a4,704 # 80002a54 <_ZN6Kernel7sysPutcEPNS_21ArgumentsOfSystemCallE>
    8000279c:	20e7b823          	sd	a4,528(a5)
    800027a0:	00813403          	ld	s0,8(sp)
    800027a4:	01010113          	addi	sp,sp,16
    800027a8:	00008067          	ret

00000000800027ac <_ZN6Kernel7sysGetcEPNS_21ArgumentsOfSystemCallE>:
{
    800027ac:	fe010113          	addi	sp,sp,-32
    800027b0:	00113c23          	sd	ra,24(sp)
    800027b4:	00813823          	sd	s0,16(sp)
    800027b8:	00913423          	sd	s1,8(sp)
    800027bc:	01213023          	sd	s2,0(sp)
    800027c0:	02010413          	addi	s0,sp,32
    static void setConsumerThread(TCB* thread) { consumerThread = thread; }

    static TCB* getProducerThread() { return producerThread; }
    static void setProducerThread(TCB* thread) { producerThread = thread; }

    static bool isInputBufferEmpty() { return inputBuffer->isBufferEmpty(); }
    800027c4:	00005797          	auipc	a5,0x5
    800027c8:	9547b783          	ld	a5,-1708(a5) # 80007118 <_GLOBAL_OFFSET_TABLE_+0x68>
    800027cc:	0007b503          	ld	a0,0(a5)
    800027d0:	fffff097          	auipc	ra,0xfffff
    800027d4:	2c0080e7          	jalr	704(ra) # 80001a90 <_ZNK6BufferIcLm100EE13isBufferEmptyEv>
    if(KConsole::isInputBufferEmpty())
    800027d8:	02051263          	bnez	a0,800027fc <_ZN6Kernel7sysGetcEPNS_21ArgumentsOfSystemCallE+0x50>
    return (uint64)KConsole::getCharFromInputBuffer();
    800027dc:	fffff097          	auipc	ra,0xfffff
    800027e0:	06c080e7          	jalr	108(ra) # 80001848 <_ZN8KConsole22getCharFromInputBufferEv>
}
    800027e4:	01813083          	ld	ra,24(sp)
    800027e8:	01013403          	ld	s0,16(sp)
    800027ec:	00813483          	ld	s1,8(sp)
    800027f0:	00013903          	ld	s2,0(sp)
    800027f4:	02010113          	addi	sp,sp,32
    800027f8:	00008067          	ret
    static TCB* getRunningThread() { return running; }
    800027fc:	00005917          	auipc	s2,0x5
    80002800:	91493903          	ld	s2,-1772(s2) # 80007110 <_GLOBAL_OFFSET_TABLE_+0x60>
    80002804:	00093483          	ld	s1,0(s2)
        TCB::setRunningThread(Scheduler::get());
    80002808:	fffff097          	auipc	ra,0xfffff
    8000280c:	43c080e7          	jalr	1084(ra) # 80001c44 <_ZN9Scheduler3getEv>
    static void setRunningThread(TCB* newRunningThread) { running = newRunningThread; }
    80002810:	00a93023          	sd	a0,0(s2)
    void resetState() {state = nullptr; }
    80002814:	0404b423          	sd	zero,72(s1)
        KConsole::addThreadToInputWaitQueue(oldThread);
    80002818:	00048513          	mv	a0,s1
    8000281c:	fffff097          	auipc	ra,0xfffff
    80002820:	e6c080e7          	jalr	-404(ra) # 80001688 <_ZN8KConsole25addThreadToInputWaitQueueEP3TCB>
    static TCB* getRunningThread() { return running; }
    80002824:	00093583          	ld	a1,0(s2)
        context_switch(oldThread->getContext(), TCB::getRunningThread()->getContext());
    80002828:	00858593          	addi	a1,a1,8
    8000282c:	00848513          	addi	a0,s1,8
    80002830:	fffff097          	auipc	ra,0xfffff
    80002834:	970080e7          	jalr	-1680(ra) # 800011a0 <context_switch>
    80002838:	fa5ff06f          	j	800027dc <_ZN6Kernel7sysGetcEPNS_21ArgumentsOfSystemCallE+0x30>

000000008000283c <_ZN6Kernel16interruptHandlerEv>:
{
    8000283c:	f9010113          	addi	sp,sp,-112
    80002840:	06113423          	sd	ra,104(sp)
    80002844:	06813023          	sd	s0,96(sp)
    80002848:	04913c23          	sd	s1,88(sp)
    8000284c:	05213823          	sd	s2,80(sp)
    80002850:	05313423          	sd	s3,72(sp)
    80002854:	05413023          	sd	s4,64(sp)
    80002858:	07010413          	addi	s0,sp,112
    __asm__ volatile ("addi %[reg], s0, 0x0": [reg]"=r"(basePointer)); // Problem: da li mozemo biti 100% sigurni da ce s0 biti nepromenjen; resenje inline f-ja
    8000285c:	00040793          	mv	a5,s0
    80002860:	fcf43423          	sd	a5,-56(s0)
    __asm__ volatile ("csrr %[cause], scause": [cause] "=r"(scause));
    80002864:	142027f3          	csrr	a5,scause
    switch (scause)
    80002868:	fff00713          	li	a4,-1
    8000286c:	03f71713          	slli	a4,a4,0x3f
    80002870:	00170713          	addi	a4,a4,1
    80002874:	12e78463          	beq	a5,a4,8000299c <_ZN6Kernel16interruptHandlerEv+0x160>
    80002878:	fff00713          	li	a4,-1
    8000287c:	03f71713          	slli	a4,a4,0x3f
    80002880:	00170713          	addi	a4,a4,1
    80002884:	08f76a63          	bltu	a4,a5,80002918 <_ZN6Kernel16interruptHandlerEv+0xdc>
    80002888:	ff878793          	addi	a5,a5,-8
    8000288c:	00100713          	li	a4,1
    80002890:	06f76463          	bltu	a4,a5,800028f8 <_ZN6Kernel16interruptHandlerEv+0xbc>
    __asm__ volatile ("csrc sip, %[reg]":: [reg] "r"(mask));
    80002894:	00200793          	li	a5,2
    80002898:	1447b073          	csrc	sip,a5
}
inline uint64 Machine::readSepc()
{
    uint64 returnAddress;
    __asm__ volatile ("csrr %[reg], sepc": [reg] "=r"(returnAddress));
    8000289c:	141029f3          	csrr	s3,sepc
            uint64 sepc = Machine::readSepc() + 4;
    800028a0:	00498993          	addi	s3,s3,4
    __asm__ volatile("csrw sstatus, %[reg]":: [reg] "r"(oldStatus));
}
inline uint64 Machine::readSstatus()
{
    uint64 returnStatus;
    __asm__ volatile ("csrr %[reg], sstatus": [reg] "=r"(returnStatus));
    800028a4:	10002a73          	csrr	s4,sstatus
            __asm__ volatile ("ld %[rd], 80(%[rs])": [rd]"=r"(numberOfEntry):[rs]"r"(basePointer));
    800028a8:	fc843483          	ld	s1,-56(s0)
    800028ac:	0504b483          	ld	s1,80(s1)
            initializeArguments(&arg, basePointer);
    800028b0:	fc843583          	ld	a1,-56(s0)
    800028b4:	f9040913          	addi	s2,s0,-112
    800028b8:	00090513          	mv	a0,s2
    800028bc:	00000097          	auipc	ra,0x0
    800028c0:	d84080e7          	jalr	-636(ra) # 80002640 <_ZN6Kernel19initializeArgumentsEPNS_21ArgumentsOfSystemCallEm>
            systemCallsTable[numberOfEntry](&arg);
    800028c4:	00349493          	slli	s1,s1,0x3
    800028c8:	00005797          	auipc	a5,0x5
    800028cc:	95078793          	addi	a5,a5,-1712 # 80007218 <_ZN6Kernel16systemCallsTableE>
    800028d0:	009784b3          	add	s1,a5,s1
    800028d4:	0004b783          	ld	a5,0(s1)
    800028d8:	00090513          	mv	a0,s2
    800028dc:	000780e7          	jalr	a5
            __asm__ volatile("sd a0, 80(%[rs])"::[rs]"r"(basePointer));
    800028e0:	fc843783          	ld	a5,-56(s0)
    800028e4:	04a7b823          	sd	a0,80(a5)
            TCB::dispatch();
    800028e8:	fffff097          	auipc	ra,0xfffff
    800028ec:	4ac080e7          	jalr	1196(ra) # 80001d94 <_ZN3TCB8dispatchEv>
    __asm__ volatile("csrw sepc, %[reg]":: [reg] "r"(address));
    800028f0:	14199073          	csrw	sepc,s3
    __asm__ volatile("csrw sstatus, %[reg]":: [reg] "r"(oldStatus));
    800028f4:	100a1073          	csrw	sstatus,s4
}
    800028f8:	06813083          	ld	ra,104(sp)
    800028fc:	06013403          	ld	s0,96(sp)
    80002900:	05813483          	ld	s1,88(sp)
    80002904:	05013903          	ld	s2,80(sp)
    80002908:	04813983          	ld	s3,72(sp)
    8000290c:	04013a03          	ld	s4,64(sp)
    80002910:	07010113          	addi	sp,sp,112
    80002914:	00008067          	ret
    switch (scause)
    80002918:	fff00713          	li	a4,-1
    8000291c:	03f71713          	slli	a4,a4,0x3f
    80002920:	00970713          	addi	a4,a4,9
    80002924:	fce79ae3          	bne	a5,a4,800028f8 <_ZN6Kernel16interruptHandlerEv+0xbc>
    __asm__ volatile ("csrc sip, %[reg]":: [reg] "r"(mask));
    80002928:	20000793          	li	a5,512
    8000292c:	1447b073          	csrc	sip,a5
    __asm__ volatile ("csrr %[reg], sepc": [reg] "=r"(returnAddress));
    80002930:	141024f3          	csrr	s1,sepc
            uint64 sepc = Machine::readSepc() + 4;
    80002934:	00448493          	addi	s1,s1,4
    __asm__ volatile ("csrr %[reg], sstatus": [reg] "=r"(returnStatus));
    80002938:	100029f3          	csrr	s3,sstatus
            int numOfDevice = plic_claim();
    8000293c:	00001097          	auipc	ra,0x1
    80002940:	3c8080e7          	jalr	968(ra) # 80003d04 <plic_claim>
    80002944:	00050913          	mv	s2,a0
            __asm__ volatile("lb %[status], 0(%[address])": [status] "=r"(statusReg): [address] "r"(CONSOLE_STATUS));
    80002948:	00004797          	auipc	a5,0x4
    8000294c:	7787b783          	ld	a5,1912(a5) # 800070c0 <_GLOBAL_OFFSET_TABLE_+0x10>
    80002950:	0007b783          	ld	a5,0(a5)
    80002954:	00078783          	lb	a5,0(a5)
    80002958:	0ff7f793          	andi	a5,a5,255
            if (statusReg & CONSOLE_TX_STATUS_BIT) {
    8000295c:	0207f793          	andi	a5,a5,32
    80002960:	0a078a63          	beqz	a5,80002a14 <_ZN6Kernel16interruptHandlerEv+0x1d8>
    static bool isInputBufferFull() { return inputBuffer->isBufferFull(); }
    static bool isOutputBufferFull() { return outputBuffer->isBufferFull(); }
    static bool isOutputBufferEmpty() { return outputBuffer->isBufferEmpty(); }
    80002964:	00004797          	auipc	a5,0x4
    80002968:	78c7b783          	ld	a5,1932(a5) # 800070f0 <_GLOBAL_OFFSET_TABLE_+0x40>
    8000296c:	0007b503          	ld	a0,0(a5)
    80002970:	fffff097          	auipc	ra,0xfffff
    80002974:	120080e7          	jalr	288(ra) # 80001a90 <_ZNK6BufferIcLm100EE13isBufferEmptyEv>
                if (KConsole::isOutputBufferEmpty()) {
    80002978:	08050263          	beqz	a0,800029fc <_ZN6Kernel16interruptHandlerEv+0x1c0>
                    plic_complete(numOfDevice);
    8000297c:	00090513          	mv	a0,s2
    80002980:	00001097          	auipc	ra,0x1
    80002984:	3bc080e7          	jalr	956(ra) # 80003d3c <plic_complete>
            TCB::dispatch();
    80002988:	fffff097          	auipc	ra,0xfffff
    8000298c:	40c080e7          	jalr	1036(ra) # 80001d94 <_ZN3TCB8dispatchEv>
    __asm__ volatile("csrw sepc, %[reg]":: [reg] "r"(address));
    80002990:	14149073          	csrw	sepc,s1
    __asm__ volatile("csrw sstatus, %[reg]":: [reg] "r"(oldStatus));
    80002994:	10099073          	csrw	sstatus,s3
}
    80002998:	f61ff06f          	j	800028f8 <_ZN6Kernel16interruptHandlerEv+0xbc>
    __asm__ volatile ("csrc sip, %[reg]":: [reg] "r"(mask));
    8000299c:	00200793          	li	a5,2
    800029a0:	1447b073          	csrc	sip,a5

    static size_t getNumOfTicks() { return numOfTicks; }
    static void resetNumOfTicks() { numOfTicks = DEFAULT_TIME_SLICE; }
    static void incrementNumOfTicks() { numOfTicks++; }
    800029a4:	00004717          	auipc	a4,0x4
    800029a8:	75473703          	ld	a4,1876(a4) # 800070f8 <_GLOBAL_OFFSET_TABLE_+0x48>
    800029ac:	00073783          	ld	a5,0(a4)
    800029b0:	00178793          	addi	a5,a5,1
    800029b4:	00f73023          	sd	a5,0(a4)
    static TCB* getRunningThread() { return running; }
    800029b8:	00004717          	auipc	a4,0x4
    800029bc:	75873703          	ld	a4,1880(a4) # 80007110 <_GLOBAL_OFFSET_TABLE_+0x60>
    800029c0:	00073703          	ld	a4,0(a4)
    size_t getTimeSlice() const { return timeSlice; }
    800029c4:	03073703          	ld	a4,48(a4)
            if (TCB::getNumOfTicks() >= TCB::getRunningThread()->getTimeSlice()) {
    800029c8:	f2e7e8e3          	bltu	a5,a4,800028f8 <_ZN6Kernel16interruptHandlerEv+0xbc>
    static void resetNumOfTicks() { numOfTicks = DEFAULT_TIME_SLICE; }
    800029cc:	00004797          	auipc	a5,0x4
    800029d0:	72c7b783          	ld	a5,1836(a5) # 800070f8 <_GLOBAL_OFFSET_TABLE_+0x48>
    800029d4:	00200713          	li	a4,2
    800029d8:	00e7b023          	sd	a4,0(a5)
    __asm__ volatile ("csrr %[reg], sepc": [reg] "=r"(returnAddress));
    800029dc:	141024f3          	csrr	s1,sepc
                uint64 sepc = Machine::readSepc() + 4;
    800029e0:	00448493          	addi	s1,s1,4
    __asm__ volatile ("csrr %[reg], sstatus": [reg] "=r"(returnStatus));
    800029e4:	10002973          	csrr	s2,sstatus
                TCB::dispatch();
    800029e8:	fffff097          	auipc	ra,0xfffff
    800029ec:	3ac080e7          	jalr	940(ra) # 80001d94 <_ZN3TCB8dispatchEv>
    __asm__ volatile("csrw sepc, %[reg]":: [reg] "r"(address));
    800029f0:	14149073          	csrw	sepc,s1
    __asm__ volatile("csrw sstatus, %[reg]":: [reg] "r"(oldStatus));
    800029f4:	10091073          	csrw	sstatus,s2
}
    800029f8:	f01ff06f          	j	800028f8 <_ZN6Kernel16interruptHandlerEv+0xbc>
                    Scheduler::put(KConsole::getConsumerThread());
    800029fc:	00004797          	auipc	a5,0x4
    80002a00:	7047b783          	ld	a5,1796(a5) # 80007100 <_GLOBAL_OFFSET_TABLE_+0x50>
    80002a04:	0007b503          	ld	a0,0(a5)
    80002a08:	fffff097          	auipc	ra,0xfffff
    80002a0c:	1f8080e7          	jalr	504(ra) # 80001c00 <_ZN9Scheduler3putEP3TCB>
    80002a10:	f79ff06f          	j	80002988 <_ZN6Kernel16interruptHandlerEv+0x14c>
    static bool isInputBufferFull() { return inputBuffer->isBufferFull(); }
    80002a14:	00004797          	auipc	a5,0x4
    80002a18:	7047b783          	ld	a5,1796(a5) # 80007118 <_GLOBAL_OFFSET_TABLE_+0x68>
    80002a1c:	0007b503          	ld	a0,0(a5)
    80002a20:	fffff097          	auipc	ra,0xfffff
    80002a24:	090080e7          	jalr	144(ra) # 80001ab0 <_ZNK6BufferIcLm100EE12isBufferFullEv>
                if (KConsole::isInputBufferFull()) {
    80002a28:	00050a63          	beqz	a0,80002a3c <_ZN6Kernel16interruptHandlerEv+0x200>
                    plic_complete(numOfDevice);
    80002a2c:	00090513          	mv	a0,s2
    80002a30:	00001097          	auipc	ra,0x1
    80002a34:	30c080e7          	jalr	780(ra) # 80003d3c <plic_complete>
    80002a38:	f51ff06f          	j	80002988 <_ZN6Kernel16interruptHandlerEv+0x14c>
                    Scheduler::put(KConsole::getProducerThread());
    80002a3c:	00004797          	auipc	a5,0x4
    80002a40:	6f47b783          	ld	a5,1780(a5) # 80007130 <_GLOBAL_OFFSET_TABLE_+0x80>
    80002a44:	0007b503          	ld	a0,0(a5)
    80002a48:	fffff097          	auipc	ra,0xfffff
    80002a4c:	1b8080e7          	jalr	440(ra) # 80001c00 <_ZN9Scheduler3putEP3TCB>
    80002a50:	f39ff06f          	j	80002988 <_ZN6Kernel16interruptHandlerEv+0x14c>

0000000080002a54 <_ZN6Kernel7sysPutcEPNS_21ArgumentsOfSystemCallE>:
{
    80002a54:	fd010113          	addi	sp,sp,-48
    80002a58:	02113423          	sd	ra,40(sp)
    80002a5c:	02813023          	sd	s0,32(sp)
    80002a60:	00913c23          	sd	s1,24(sp)
    80002a64:	01213823          	sd	s2,16(sp)
    80002a68:	01313423          	sd	s3,8(sp)
    80002a6c:	03010413          	addi	s0,sp,48
    80002a70:	00050493          	mv	s1,a0
    static bool isOutputBufferFull() { return outputBuffer->isBufferFull(); }
    80002a74:	00004797          	auipc	a5,0x4
    80002a78:	67c7b783          	ld	a5,1660(a5) # 800070f0 <_GLOBAL_OFFSET_TABLE_+0x40>
    80002a7c:	0007b503          	ld	a0,0(a5)
    80002a80:	fffff097          	auipc	ra,0xfffff
    80002a84:	030080e7          	jalr	48(ra) # 80001ab0 <_ZNK6BufferIcLm100EE12isBufferFullEv>
    if(KConsole::isOutputBufferFull())
    80002a88:	02051863          	bnez	a0,80002ab8 <_ZN6Kernel7sysPutcEPNS_21ArgumentsOfSystemCallE+0x64>
    KConsole::addCharToOutputBuffer(arg->a0);
    80002a8c:	0004c503          	lbu	a0,0(s1)
    80002a90:	fffff097          	auipc	ra,0xfffff
    80002a94:	ec0080e7          	jalr	-320(ra) # 80001950 <_ZN8KConsole21addCharToOutputBufferEc>
}
    80002a98:	00000513          	li	a0,0
    80002a9c:	02813083          	ld	ra,40(sp)
    80002aa0:	02013403          	ld	s0,32(sp)
    80002aa4:	01813483          	ld	s1,24(sp)
    80002aa8:	01013903          	ld	s2,16(sp)
    80002aac:	00813983          	ld	s3,8(sp)
    80002ab0:	03010113          	addi	sp,sp,48
    80002ab4:	00008067          	ret
    static TCB* getRunningThread() { return running; }
    80002ab8:	00004997          	auipc	s3,0x4
    80002abc:	6589b983          	ld	s3,1624(s3) # 80007110 <_GLOBAL_OFFSET_TABLE_+0x60>
    80002ac0:	0009b903          	ld	s2,0(s3)
        TCB::setRunningThread(Scheduler::get());
    80002ac4:	fffff097          	auipc	ra,0xfffff
    80002ac8:	180080e7          	jalr	384(ra) # 80001c44 <_ZN9Scheduler3getEv>
    static void setRunningThread(TCB* newRunningThread) { running = newRunningThread; }
    80002acc:	00a9b023          	sd	a0,0(s3)
    void resetState() {state = nullptr; }
    80002ad0:	04093423          	sd	zero,72(s2)
        KConsole::addThreadToOutputWaitQueue(oldThread);
    80002ad4:	00090513          	mv	a0,s2
    80002ad8:	fffff097          	auipc	ra,0xfffff
    80002adc:	bf4080e7          	jalr	-1036(ra) # 800016cc <_ZN8KConsole26addThreadToOutputWaitQueueEP3TCB>
    static TCB* getRunningThread() { return running; }
    80002ae0:	0009b583          	ld	a1,0(s3)
        context_switch(oldThread->getContext(), TCB::getRunningThread()->getContext());
    80002ae4:	00858593          	addi	a1,a1,8
    80002ae8:	00890513          	addi	a0,s2,8
    80002aec:	ffffe097          	auipc	ra,0xffffe
    80002af0:	6b4080e7          	jalr	1716(ra) # 800011a0 <context_switch>
    80002af4:	f99ff06f          	j	80002a8c <_ZN6Kernel7sysPutcEPNS_21ArgumentsOfSystemCallE+0x38>

0000000080002af8 <_Z41__static_initialization_and_destruction_0ii>:
    80002af8:	00100793          	li	a5,1
    80002afc:	00f50463          	beq	a0,a5,80002b04 <_Z41__static_initialization_and_destruction_0ii+0xc>
    80002b00:	00008067          	ret
    80002b04:	000107b7          	lui	a5,0x10
    80002b08:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80002b0c:	fef59ae3          	bne	a1,a5,80002b00 <_Z41__static_initialization_and_destruction_0ii+0x8>
    80002b10:	fe010113          	addi	sp,sp,-32
    80002b14:	00113c23          	sd	ra,24(sp)
    80002b18:	00813823          	sd	s0,16(sp)
    80002b1c:	00913423          	sd	s1,8(sp)
    80002b20:	02010413          	addi	s0,sp,32
ObjectPool<TCB, KernelConfig::NUM_OF_THREADS_IN_POOL>* Kernel::poolOfThreads = new ObjectPool<TCB, KernelConfig::NUM_OF_THREADS_IN_POOL>();
    80002b24:	000014b7          	lui	s1,0x1
    80002b28:	83848513          	addi	a0,s1,-1992 # 838 <_entry-0x7ffff7c8>
    80002b2c:	00000097          	auipc	ra,0x0
    80002b30:	678080e7          	jalr	1656(ra) # 800031a4 <_ZN10ObjectPoolI3TCBLm20EEnwEm>


template <typename T, size_t numOfObjects>
class ObjectPool {
public:
    ObjectPool(): headFreeObject(pool), nextObjectPool(nullptr), prevObjectPool(nullptr)
    80002b34:	009507b3          	add	a5,a0,s1
    80002b38:	82a7b023          	sd	a0,-2016(a5)
    80002b3c:	8207b423          	sd	zero,-2008(a5)
    80002b40:	8207b823          	sd	zero,-2000(a5)
    {

        for(size_t i = 0; i < numOfObjects - 1; i++)
    80002b44:	00000793          	li	a5,0
    80002b48:	01200713          	li	a4,18
    80002b4c:	02f76463          	bltu	a4,a5,80002b74 <_Z41__static_initialization_and_destruction_0ii+0x7c>
        {
            pool[i].nextFree = &(pool[i+1]);
    80002b50:	00178693          	addi	a3,a5,1
    80002b54:	06800613          	li	a2,104
    80002b58:	02c68733          	mul	a4,a3,a2
    80002b5c:	00e50733          	add	a4,a0,a4
    80002b60:	02c787b3          	mul	a5,a5,a2
    80002b64:	00f507b3          	add	a5,a0,a5
    80002b68:	06e7b023          	sd	a4,96(a5)
        for(size_t i = 0; i < numOfObjects - 1; i++)
    80002b6c:	00068793          	mv	a5,a3
    80002b70:	fd9ff06f          	j	80002b48 <_Z41__static_initialization_and_destruction_0ii+0x50>
        }
        pool[numOfObjects - 1].nextFree = nullptr;
    80002b74:	000017b7          	lui	a5,0x1
    80002b78:	00f507b3          	add	a5,a0,a5
    80002b7c:	8007bc23          	sd	zero,-2024(a5) # 818 <_entry-0x7ffff7e8>
    80002b80:	00005797          	auipc	a5,0x5
    80002b84:	8aa7b823          	sd	a0,-1872(a5) # 80007430 <_ZN6Kernel13poolOfThreadsE>
ObjectPool<KSemaphore, KernelConfig::NUM_OF_SEMAPHORES_IN_POOL>* Kernel::poolOfSemaphores = new ObjectPool<KSemaphore, KernelConfig::NUM_OF_SEMAPHORES_IN_POOL>();
    80002b88:	1a800513          	li	a0,424
    80002b8c:	00000097          	auipc	ra,0x0
    80002b90:	654080e7          	jalr	1620(ra) # 800031e0 <_ZN10ObjectPoolI10KSemaphoreLm10EEnwEm>
    ObjectPool(): headFreeObject(pool), nextObjectPool(nullptr), prevObjectPool(nullptr)
    80002b94:	18a53823          	sd	a0,400(a0)
    80002b98:	18053c23          	sd	zero,408(a0)
    80002b9c:	1a053023          	sd	zero,416(a0)
        for(size_t i = 0; i < numOfObjects - 1; i++)
    80002ba0:	00000793          	li	a5,0
    80002ba4:	00800713          	li	a4,8
    80002ba8:	02f76463          	bltu	a4,a5,80002bd0 <_Z41__static_initialization_and_destruction_0ii+0xd8>
            pool[i].nextFree = &(pool[i+1]);
    80002bac:	00178693          	addi	a3,a5,1
    80002bb0:	02800613          	li	a2,40
    80002bb4:	02c68733          	mul	a4,a3,a2
    80002bb8:	00e50733          	add	a4,a0,a4
    80002bbc:	02c787b3          	mul	a5,a5,a2
    80002bc0:	00f507b3          	add	a5,a0,a5
    80002bc4:	02e7b023          	sd	a4,32(a5)
        for(size_t i = 0; i < numOfObjects - 1; i++)
    80002bc8:	00068793          	mv	a5,a3
    80002bcc:	fd9ff06f          	j	80002ba4 <_Z41__static_initialization_and_destruction_0ii+0xac>
        pool[numOfObjects - 1].nextFree = nullptr;
    80002bd0:	18053423          	sd	zero,392(a0)
    80002bd4:	00005797          	auipc	a5,0x5
    80002bd8:	86a7b223          	sd	a0,-1948(a5) # 80007438 <_ZN6Kernel16poolOfSemaphoresE>
    80002bdc:	01813083          	ld	ra,24(sp)
    80002be0:	01013403          	ld	s0,16(sp)
    80002be4:	00813483          	ld	s1,8(sp)
    80002be8:	02010113          	addi	sp,sp,32
    80002bec:	00008067          	ret

0000000080002bf0 <_ZN6Kernel13sysThreadExitEPNS_21ArgumentsOfSystemCallE>:
{
    80002bf0:	ff010113          	addi	sp,sp,-16
    80002bf4:	00113423          	sd	ra,8(sp)
    80002bf8:	00813023          	sd	s0,0(sp)
    80002bfc:	01010413          	addi	s0,sp,16
    80002c00:	00004797          	auipc	a5,0x4
    80002c04:	5107b783          	ld	a5,1296(a5) # 80007110 <_GLOBAL_OFFSET_TABLE_+0x60>
    80002c08:	0007b783          	ld	a5,0(a5)
    if(MemoryAllocator::freeMemory(TCB::getRunningThread()->getSystemStack()) == -1)
    80002c0c:	0287b503          	ld	a0,40(a5)
    80002c10:	fffff097          	auipc	ra,0xfffff
    80002c14:	4f0080e7          	jalr	1264(ra) # 80002100 <_ZN15MemoryAllocator10freeMemoryEPv>
    80002c18:	fff00793          	li	a5,-1
    80002c1c:	06f50e63          	beq	a0,a5,80002c98 <_ZN6Kernel13sysThreadExitEPNS_21ArgumentsOfSystemCallE+0xa8>
    80002c20:	00004797          	auipc	a5,0x4
    80002c24:	4f07b783          	ld	a5,1264(a5) # 80007110 <_GLOBAL_OFFSET_TABLE_+0x60>
    80002c28:	0007b783          	ld	a5,0(a5)
    void setIsFinished() { finished = true; }
    80002c2c:	00100713          	li	a4,1
    80002c30:	04e78823          	sb	a4,80(a5)
    if(MemoryAllocator::freeMemory(TCB::getRunningThread()->getUserStack()) == -1)
    80002c34:	0207b503          	ld	a0,32(a5)
    80002c38:	fffff097          	auipc	ra,0xfffff
    80002c3c:	4c8080e7          	jalr	1224(ra) # 80002100 <_ZN15MemoryAllocator10freeMemoryEPv>
    80002c40:	fff00793          	li	a5,-1
    80002c44:	04f50e63          	beq	a0,a5,80002ca0 <_ZN6Kernel13sysThreadExitEPNS_21ArgumentsOfSystemCallE+0xb0>
    static TCB* getRunningThread() { return running; }
    80002c48:	00004797          	auipc	a5,0x4
    80002c4c:	4c87b783          	ld	a5,1224(a5) # 80007110 <_GLOBAL_OFFSET_TABLE_+0x60>
    80002c50:	0007b583          	ld	a1,0(a5)
    KSemaphore* getSemaphoreOnWait() const { return waitOnSemaphore; }
    80002c54:	0405b503          	ld	a0,64(a1)
    if(!TCB::getRunningThread()->getSemaphoreOnWait())
    80002c58:	02050a63          	beqz	a0,80002c8c <_ZN6Kernel13sysThreadExitEPNS_21ArgumentsOfSystemCallE+0x9c>
    Kernel::poolOfThreads->freeObject(TCB::getRunningThread());
    80002c5c:	00004797          	auipc	a5,0x4
    80002c60:	4b47b783          	ld	a5,1204(a5) # 80007110 <_GLOBAL_OFFSET_TABLE_+0x60>
    80002c64:	0007b583          	ld	a1,0(a5)
    80002c68:	00004517          	auipc	a0,0x4
    80002c6c:	7c853503          	ld	a0,1992(a0) # 80007430 <_ZN6Kernel13poolOfThreadsE>
    80002c70:	00000097          	auipc	ra,0x0
    80002c74:	5ac080e7          	jalr	1452(ra) # 8000321c <_ZN10ObjectPoolI3TCBLm20EE10freeObjectEPS0_>
    return 0;
    80002c78:	00000513          	li	a0,0
}
    80002c7c:	00813083          	ld	ra,8(sp)
    80002c80:	00013403          	ld	s0,0(sp)
    80002c84:	01010113          	addi	sp,sp,16
    80002c88:	00008067          	ret
        tempSemaphore->removeThreadFromWaitQueue(TCB::getRunningThread());
    80002c8c:	00000097          	auipc	ra,0x0
    80002c90:	80c080e7          	jalr	-2036(ra) # 80002498 <_ZN10KSemaphore25removeThreadFromWaitQueueEP3TCB>
    80002c94:	fc9ff06f          	j	80002c5c <_ZN6Kernel13sysThreadExitEPNS_21ArgumentsOfSystemCallE+0x6c>
        return -1;
    80002c98:	fff00513          	li	a0,-1
    80002c9c:	fe1ff06f          	j	80002c7c <_ZN6Kernel13sysThreadExitEPNS_21ArgumentsOfSystemCallE+0x8c>
        return -1;
    80002ca0:	fff00513          	li	a0,-1
    80002ca4:	fd9ff06f          	j	80002c7c <_ZN6Kernel13sysThreadExitEPNS_21ArgumentsOfSystemCallE+0x8c>

0000000080002ca8 <_ZN6Kernel17sysSemaphoreCloseEPNS_21ArgumentsOfSystemCallE>:
{
    80002ca8:	fe010113          	addi	sp,sp,-32
    80002cac:	00113c23          	sd	ra,24(sp)
    80002cb0:	00813823          	sd	s0,16(sp)
    80002cb4:	00913423          	sd	s1,8(sp)
    80002cb8:	01213023          	sd	s2,0(sp)
    80002cbc:	02010413          	addi	s0,sp,32
    KSemaphore* tempSemaphore = (KSemaphore*)(arg->a0);
    80002cc0:	00053903          	ld	s2,0(a0)
    returnValue = (uint64)tempSemaphore->close();
    80002cc4:	00090513          	mv	a0,s2
    80002cc8:	fffff097          	auipc	ra,0xfffff
    80002ccc:	76c080e7          	jalr	1900(ra) # 80002434 <_ZN10KSemaphore5closeEv>
    80002cd0:	00050493          	mv	s1,a0
    Kernel::poolOfSemaphores->freeObject(tempSemaphore);
    80002cd4:	00090593          	mv	a1,s2
    80002cd8:	00004517          	auipc	a0,0x4
    80002cdc:	76053503          	ld	a0,1888(a0) # 80007438 <_ZN6Kernel16poolOfSemaphoresE>
    80002ce0:	00000097          	auipc	ra,0x0
    80002ce4:	570080e7          	jalr	1392(ra) # 80003250 <_ZN10ObjectPoolI10KSemaphoreLm10EE10freeObjectEPS0_>
}
    80002ce8:	00048513          	mv	a0,s1
    80002cec:	01813083          	ld	ra,24(sp)
    80002cf0:	01013403          	ld	s0,16(sp)
    80002cf4:	00813483          	ld	s1,8(sp)
    80002cf8:	00013903          	ld	s2,0(sp)
    80002cfc:	02010113          	addi	sp,sp,32
    80002d00:	00008067          	ret

0000000080002d04 <_ZN6Kernel18makeConsumerThreadEv>:
{
    80002d04:	fd010113          	addi	sp,sp,-48
    80002d08:	02113423          	sd	ra,40(sp)
    80002d0c:	02813023          	sd	s0,32(sp)
    80002d10:	00913c23          	sd	s1,24(sp)
    80002d14:	01213823          	sd	s2,16(sp)
    80002d18:	03010413          	addi	s0,sp,48
    void* kernelSystemStack = Kernel::mallocSystemStack(KernelConfig::DEFAULT_SYSTEM_STACK_SIZE);
    80002d1c:	40000513          	li	a0,1024
    80002d20:	00000097          	auipc	ra,0x0
    80002d24:	970080e7          	jalr	-1680(ra) # 80002690 <_ZN6Kernel17mallocSystemStackEm>
    80002d28:	00050913          	mv	s2,a0
    TCB* consumerThread = poolOfThreads->mallocObject(&sourcePool);
    80002d2c:	fd840593          	addi	a1,s0,-40
    80002d30:	00004517          	auipc	a0,0x4
    80002d34:	70053503          	ld	a0,1792(a0) # 80007430 <_ZN6Kernel13poolOfThreadsE>
    80002d38:	00000097          	auipc	ra,0x0
    80002d3c:	580080e7          	jalr	1408(ra) # 800032b8 <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEPPS1_>
    80002d40:	00050493          	mv	s1,a0
    while(!consumerThread)
    80002d44:	02049063          	bnez	s1,80002d64 <_ZN6Kernel18makeConsumerThreadEv+0x60>
        consumerThread = poolOfThreads->mallocObject(&sourcePool);
    80002d48:	fd840593          	addi	a1,s0,-40
    80002d4c:	00004517          	auipc	a0,0x4
    80002d50:	6e453503          	ld	a0,1764(a0) # 80007430 <_ZN6Kernel13poolOfThreadsE>
    80002d54:	00000097          	auipc	ra,0x0
    80002d58:	564080e7          	jalr	1380(ra) # 800032b8 <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEPPS1_>
    80002d5c:	00050493          	mv	s1,a0
    80002d60:	fe5ff06f          	j	80002d44 <_ZN6Kernel18makeConsumerThreadEv+0x40>
    consumerThread->initializeThread(&KConsole::consumeOutputBuffer, nullptr, kernelSystemStack, kernelSystemStack, sourcePool, KernelConfig::KERNEL_MODE, KernelConfig::BLOCKED);
    80002d64:	00100893          	li	a7,1
    80002d68:	00100813          	li	a6,1
    80002d6c:	fd843783          	ld	a5,-40(s0)
    80002d70:	00090713          	mv	a4,s2
    80002d74:	00090693          	mv	a3,s2
    80002d78:	00000613          	li	a2,0
    80002d7c:	00004597          	auipc	a1,0x4
    80002d80:	3545b583          	ld	a1,852(a1) # 800070d0 <_GLOBAL_OFFSET_TABLE_+0x20>
    80002d84:	00048513          	mv	a0,s1
    80002d88:	fffff097          	auipc	ra,0xfffff
    80002d8c:	f50080e7          	jalr	-176(ra) # 80001cd8 <_ZN3TCB16initializeThreadEPFvPvES0_S0_S0_P10ObjectPoolIS_Lm20EEN12KernelConfig4ModeENS6_11ThreadStateE>
    static void setConsumerThread(TCB* thread) { consumerThread = thread; }
    80002d90:	00004797          	auipc	a5,0x4
    80002d94:	3707b783          	ld	a5,880(a5) # 80007100 <_GLOBAL_OFFSET_TABLE_+0x50>
    80002d98:	0097b023          	sd	s1,0(a5)
}
    80002d9c:	02813083          	ld	ra,40(sp)
    80002da0:	02013403          	ld	s0,32(sp)
    80002da4:	01813483          	ld	s1,24(sp)
    80002da8:	01013903          	ld	s2,16(sp)
    80002dac:	03010113          	addi	sp,sp,48
    80002db0:	00008067          	ret

0000000080002db4 <_ZN6Kernel18makeProducerThreadEv>:
{
    80002db4:	fd010113          	addi	sp,sp,-48
    80002db8:	02113423          	sd	ra,40(sp)
    80002dbc:	02813023          	sd	s0,32(sp)
    80002dc0:	00913c23          	sd	s1,24(sp)
    80002dc4:	01213823          	sd	s2,16(sp)
    80002dc8:	03010413          	addi	s0,sp,48
    void* kernelSystemStack = Kernel::mallocSystemStack(KernelConfig::DEFAULT_SYSTEM_STACK_SIZE);
    80002dcc:	40000513          	li	a0,1024
    80002dd0:	00000097          	auipc	ra,0x0
    80002dd4:	8c0080e7          	jalr	-1856(ra) # 80002690 <_ZN6Kernel17mallocSystemStackEm>
    80002dd8:	00050913          	mv	s2,a0
    TCB* producerThread = poolOfThreads->mallocObject(&sourcePool);
    80002ddc:	fd840593          	addi	a1,s0,-40
    80002de0:	00004517          	auipc	a0,0x4
    80002de4:	65053503          	ld	a0,1616(a0) # 80007430 <_ZN6Kernel13poolOfThreadsE>
    80002de8:	00000097          	auipc	ra,0x0
    80002dec:	4d0080e7          	jalr	1232(ra) # 800032b8 <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEPPS1_>
    80002df0:	00050493          	mv	s1,a0
    while(!producerThread)
    80002df4:	02049063          	bnez	s1,80002e14 <_ZN6Kernel18makeProducerThreadEv+0x60>
        producerThread = poolOfThreads->mallocObject(&sourcePool);
    80002df8:	fd840593          	addi	a1,s0,-40
    80002dfc:	00004517          	auipc	a0,0x4
    80002e00:	63453503          	ld	a0,1588(a0) # 80007430 <_ZN6Kernel13poolOfThreadsE>
    80002e04:	00000097          	auipc	ra,0x0
    80002e08:	4b4080e7          	jalr	1204(ra) # 800032b8 <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEPPS1_>
    80002e0c:	00050493          	mv	s1,a0
    80002e10:	fe5ff06f          	j	80002df4 <_ZN6Kernel18makeProducerThreadEv+0x40>
    producerThread->initializeThread(&KConsole::produceInputBuffer, nullptr, kernelSystemStack, kernelSystemStack, sourcePool, KernelConfig::KERNEL_MODE, KernelConfig::BLOCKED);
    80002e14:	00100893          	li	a7,1
    80002e18:	00100813          	li	a6,1
    80002e1c:	fd843783          	ld	a5,-40(s0)
    80002e20:	00090713          	mv	a4,s2
    80002e24:	00090693          	mv	a3,s2
    80002e28:	00000613          	li	a2,0
    80002e2c:	00004597          	auipc	a1,0x4
    80002e30:	2fc5b583          	ld	a1,764(a1) # 80007128 <_GLOBAL_OFFSET_TABLE_+0x78>
    80002e34:	00048513          	mv	a0,s1
    80002e38:	fffff097          	auipc	ra,0xfffff
    80002e3c:	ea0080e7          	jalr	-352(ra) # 80001cd8 <_ZN3TCB16initializeThreadEPFvPvES0_S0_S0_P10ObjectPoolIS_Lm20EEN12KernelConfig4ModeENS6_11ThreadStateE>
    static void setProducerThread(TCB* thread) { producerThread = thread; }
    80002e40:	00004797          	auipc	a5,0x4
    80002e44:	2f07b783          	ld	a5,752(a5) # 80007130 <_GLOBAL_OFFSET_TABLE_+0x80>
    80002e48:	0097b023          	sd	s1,0(a5)
}
    80002e4c:	02813083          	ld	ra,40(sp)
    80002e50:	02013403          	ld	s0,32(sp)
    80002e54:	01813483          	ld	s1,24(sp)
    80002e58:	01013903          	ld	s2,16(sp)
    80002e5c:	03010113          	addi	sp,sp,48
    80002e60:	00008067          	ret

0000000080002e64 <_ZN6Kernel14makeIdleThreadEv>:
{
    80002e64:	fd010113          	addi	sp,sp,-48
    80002e68:	02113423          	sd	ra,40(sp)
    80002e6c:	02813023          	sd	s0,32(sp)
    80002e70:	00913c23          	sd	s1,24(sp)
    80002e74:	01213823          	sd	s2,16(sp)
    80002e78:	03010413          	addi	s0,sp,48
    void* kernelSystemStack = Kernel::mallocSystemStack(KernelConfig::DEFAULT_SYSTEM_STACK_SIZE);
    80002e7c:	40000513          	li	a0,1024
    80002e80:	00000097          	auipc	ra,0x0
    80002e84:	810080e7          	jalr	-2032(ra) # 80002690 <_ZN6Kernel17mallocSystemStackEm>
    80002e88:	00050913          	mv	s2,a0
    TCB* idleThread = poolOfThreads->mallocObject(&sourcePool);
    80002e8c:	fd840593          	addi	a1,s0,-40
    80002e90:	00004517          	auipc	a0,0x4
    80002e94:	5a053503          	ld	a0,1440(a0) # 80007430 <_ZN6Kernel13poolOfThreadsE>
    80002e98:	00000097          	auipc	ra,0x0
    80002e9c:	420080e7          	jalr	1056(ra) # 800032b8 <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEPPS1_>
    80002ea0:	00050493          	mv	s1,a0
    while(!idleThread)
    80002ea4:	02049063          	bnez	s1,80002ec4 <_ZN6Kernel14makeIdleThreadEv+0x60>
        idleThread = poolOfThreads->mallocObject(&sourcePool);
    80002ea8:	fd840593          	addi	a1,s0,-40
    80002eac:	00004517          	auipc	a0,0x4
    80002eb0:	58453503          	ld	a0,1412(a0) # 80007430 <_ZN6Kernel13poolOfThreadsE>
    80002eb4:	00000097          	auipc	ra,0x0
    80002eb8:	404080e7          	jalr	1028(ra) # 800032b8 <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEPPS1_>
    80002ebc:	00050493          	mv	s1,a0
    80002ec0:	fe5ff06f          	j	80002ea4 <_ZN6Kernel14makeIdleThreadEv+0x40>
    idleThread->initializeThread(&kernelWorker, nullptr, kernelSystemStack, kernelSystemStack, sourcePool, KernelConfig::KERNEL_MODE, KernelConfig::BLOCKED);
    80002ec4:	00100893          	li	a7,1
    80002ec8:	00100813          	li	a6,1
    80002ecc:	fd843783          	ld	a5,-40(s0)
    80002ed0:	00090713          	mv	a4,s2
    80002ed4:	00090693          	mv	a3,s2
    80002ed8:	00000613          	li	a2,0
    80002edc:	fffff597          	auipc	a1,0xfffff
    80002ee0:	63858593          	addi	a1,a1,1592 # 80002514 <_ZN6Kernel12kernelWorkerEPv>
    80002ee4:	00048513          	mv	a0,s1
    80002ee8:	fffff097          	auipc	ra,0xfffff
    80002eec:	df0080e7          	jalr	-528(ra) # 80001cd8 <_ZN3TCB16initializeThreadEPFvPvES0_S0_S0_P10ObjectPoolIS_Lm20EEN12KernelConfig4ModeENS6_11ThreadStateE>
    Scheduler() = delete;
    Scheduler(const Scheduler& scheduler) = delete;
    Scheduler& operator=(const Scheduler& scheduler) = delete;
    static void put(TCB* readyThread);
    static TCB* get(void);
    static void setIdleThread(TCB* thread) { idleThread = thread; }
    80002ef0:	00004797          	auipc	a5,0x4
    80002ef4:	2187b783          	ld	a5,536(a5) # 80007108 <_GLOBAL_OFFSET_TABLE_+0x58>
    80002ef8:	0097b023          	sd	s1,0(a5)
}
    80002efc:	02813083          	ld	ra,40(sp)
    80002f00:	02013403          	ld	s0,32(sp)
    80002f04:	01813483          	ld	s1,24(sp)
    80002f08:	01013903          	ld	s2,16(sp)
    80002f0c:	03010113          	addi	sp,sp,48
    80002f10:	00008067          	ret

0000000080002f14 <_ZN6Kernel23initializeKernelThreadsEv>:
{
    80002f14:	ff010113          	addi	sp,sp,-16
    80002f18:	00113423          	sd	ra,8(sp)
    80002f1c:	00813023          	sd	s0,0(sp)
    80002f20:	01010413          	addi	s0,sp,16
    makeConsumerThread();
    80002f24:	00000097          	auipc	ra,0x0
    80002f28:	de0080e7          	jalr	-544(ra) # 80002d04 <_ZN6Kernel18makeConsumerThreadEv>
    makeProducerThread();
    80002f2c:	00000097          	auipc	ra,0x0
    80002f30:	e88080e7          	jalr	-376(ra) # 80002db4 <_ZN6Kernel18makeProducerThreadEv>
    makeIdleThread();
    80002f34:	00000097          	auipc	ra,0x0
    80002f38:	f30080e7          	jalr	-208(ra) # 80002e64 <_ZN6Kernel14makeIdleThreadEv>
}
    80002f3c:	00813083          	ld	ra,8(sp)
    80002f40:	00013403          	ld	s0,0(sp)
    80002f44:	01010113          	addi	sp,sp,16
    80002f48:	00008067          	ret

0000000080002f4c <_ZN6Kernel16initializeKernelEv>:
{
    80002f4c:	fe010113          	addi	sp,sp,-32
    80002f50:	00113c23          	sd	ra,24(sp)
    80002f54:	00813823          	sd	s0,16(sp)
    80002f58:	00913423          	sd	s1,8(sp)
    80002f5c:	02010413          	addi	s0,sp,32

};

inline void Kernel::setInterruptRoutine(void (*routine)(void))
{
    Machine::writeStvec((uint64) routine);
    80002f60:	00004797          	auipc	a5,0x4
    80002f64:	1887b783          	ld	a5,392(a5) # 800070e8 <_GLOBAL_OFFSET_TABLE_+0x38>
    __asm__ volatile ("csrw stvec, %[address]": : [address] "r"(interruptAddress));
    80002f68:	10579073          	csrw	stvec,a5
}
    80002f6c:	0180006f          	j	80002f84 <_ZN6Kernel16initializeKernelEv+0x38>
    80002f70:	000017b7          	lui	a5,0x1
    80002f74:	00f507b3          	add	a5,a0,a5
    80002f78:	8007bc23          	sd	zero,-2024(a5) # 818 <_entry-0x7ffff7e8>
     poolOfThreads = new ObjectPool<TCB, KernelConfig::NUM_OF_THREADS_IN_POOL>();
    80002f7c:	00004797          	auipc	a5,0x4
    80002f80:	4aa7ba23          	sd	a0,1204(a5) # 80007430 <_ZN6Kernel13poolOfThreadsE>
    while(!poolOfThreads)
    80002f84:	00004797          	auipc	a5,0x4
    80002f88:	4ac7b783          	ld	a5,1196(a5) # 80007430 <_ZN6Kernel13poolOfThreadsE>
    80002f8c:	06079063          	bnez	a5,80002fec <_ZN6Kernel16initializeKernelEv+0xa0>
     poolOfThreads = new ObjectPool<TCB, KernelConfig::NUM_OF_THREADS_IN_POOL>();
    80002f90:	000014b7          	lui	s1,0x1
    80002f94:	83848513          	addi	a0,s1,-1992 # 838 <_entry-0x7ffff7c8>
    80002f98:	00000097          	auipc	ra,0x0
    80002f9c:	20c080e7          	jalr	524(ra) # 800031a4 <_ZN10ObjectPoolI3TCBLm20EEnwEm>
    ObjectPool(): headFreeObject(pool), nextObjectPool(nullptr), prevObjectPool(nullptr)
    80002fa0:	009507b3          	add	a5,a0,s1
    80002fa4:	82a7b023          	sd	a0,-2016(a5)
    80002fa8:	8207b423          	sd	zero,-2008(a5)
    80002fac:	8207b823          	sd	zero,-2000(a5)
        for(size_t i = 0; i < numOfObjects - 1; i++)
    80002fb0:	00000793          	li	a5,0
    80002fb4:	01200713          	li	a4,18
    80002fb8:	faf76ce3          	bltu	a4,a5,80002f70 <_ZN6Kernel16initializeKernelEv+0x24>
            pool[i].nextFree = &(pool[i+1]);
    80002fbc:	00178693          	addi	a3,a5,1
    80002fc0:	06800613          	li	a2,104
    80002fc4:	02c68733          	mul	a4,a3,a2
    80002fc8:	00e50733          	add	a4,a0,a4
    80002fcc:	02c787b3          	mul	a5,a5,a2
    80002fd0:	00f507b3          	add	a5,a0,a5
    80002fd4:	06e7b023          	sd	a4,96(a5)
        for(size_t i = 0; i < numOfObjects - 1; i++)
    80002fd8:	00068793          	mv	a5,a3
    80002fdc:	fd9ff06f          	j	80002fb4 <_ZN6Kernel16initializeKernelEv+0x68>
        pool[numOfObjects - 1].nextFree = nullptr;
    80002fe0:	18053423          	sd	zero,392(a0)
        poolOfSemaphores = new ObjectPool<KSemaphore, KernelConfig::NUM_OF_SEMAPHORES_IN_POOL>();
    80002fe4:	00004797          	auipc	a5,0x4
    80002fe8:	44a7ba23          	sd	a0,1108(a5) # 80007438 <_ZN6Kernel16poolOfSemaphoresE>
    while(!poolOfSemaphores)
    80002fec:	00004797          	auipc	a5,0x4
    80002ff0:	44c7b783          	ld	a5,1100(a5) # 80007438 <_ZN6Kernel16poolOfSemaphoresE>
    80002ff4:	04079c63          	bnez	a5,8000304c <_ZN6Kernel16initializeKernelEv+0x100>
        poolOfSemaphores = new ObjectPool<KSemaphore, KernelConfig::NUM_OF_SEMAPHORES_IN_POOL>();
    80002ff8:	1a800513          	li	a0,424
    80002ffc:	00000097          	auipc	ra,0x0
    80003000:	1e4080e7          	jalr	484(ra) # 800031e0 <_ZN10ObjectPoolI10KSemaphoreLm10EEnwEm>
    ObjectPool(): headFreeObject(pool), nextObjectPool(nullptr), prevObjectPool(nullptr)
    80003004:	18a53823          	sd	a0,400(a0)
    80003008:	18053c23          	sd	zero,408(a0)
    8000300c:	1a053023          	sd	zero,416(a0)
        for(size_t i = 0; i < numOfObjects - 1; i++)
    80003010:	00000693          	li	a3,0
    80003014:	00800793          	li	a5,8
    80003018:	fcd7e4e3          	bltu	a5,a3,80002fe0 <_ZN6Kernel16initializeKernelEv+0x94>
            pool[i].nextFree = &(pool[i+1]);
    8000301c:	00168613          	addi	a2,a3,1
    80003020:	00261713          	slli	a4,a2,0x2
    80003024:	00c70733          	add	a4,a4,a2
    80003028:	00371713          	slli	a4,a4,0x3
    8000302c:	00e50733          	add	a4,a0,a4
    80003030:	00269793          	slli	a5,a3,0x2
    80003034:	00d787b3          	add	a5,a5,a3
    80003038:	00379793          	slli	a5,a5,0x3
    8000303c:	00f507b3          	add	a5,a0,a5
    80003040:	02e7b023          	sd	a4,32(a5)
        for(size_t i = 0; i < numOfObjects - 1; i++)
    80003044:	00060693          	mv	a3,a2
    80003048:	fcdff06f          	j	80003014 <_ZN6Kernel16initializeKernelEv+0xc8>
    initializeKernelThreads();
    8000304c:	00000097          	auipc	ra,0x0
    80003050:	ec8080e7          	jalr	-312(ra) # 80002f14 <_ZN6Kernel23initializeKernelThreadsEv>
    initializeSystemCalls();
    80003054:	fffff097          	auipc	ra,0xfffff
    80003058:	6a8080e7          	jalr	1704(ra) # 800026fc <_ZN6Kernel21initializeSystemCallsEv>
}
    8000305c:	01813083          	ld	ra,24(sp)
    80003060:	01013403          	ld	s0,16(sp)
    80003064:	00813483          	ld	s1,8(sp)
    80003068:	02010113          	addi	sp,sp,32
    8000306c:	00008067          	ret

0000000080003070 <_ZN6Kernel15sysThreadCreateEPNS_21ArgumentsOfSystemCallE>:
{
    80003070:	fd010113          	addi	sp,sp,-48
    80003074:	02113423          	sd	ra,40(sp)
    80003078:	02813023          	sd	s0,32(sp)
    8000307c:	00913c23          	sd	s1,24(sp)
    80003080:	01213823          	sd	s2,16(sp)
    80003084:	03010413          	addi	s0,sp,48
    80003088:	00050493          	mv	s1,a0
    TCB* newThread = poolOfThreads->mallocObject(&sourcePool);
    8000308c:	fd840593          	addi	a1,s0,-40
    80003090:	00004517          	auipc	a0,0x4
    80003094:	3a053503          	ld	a0,928(a0) # 80007430 <_ZN6Kernel13poolOfThreadsE>
    80003098:	00000097          	auipc	ra,0x0
    8000309c:	220080e7          	jalr	544(ra) # 800032b8 <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEPPS1_>
    if(!newThread)
    800030a0:	06050063          	beqz	a0,80003100 <_ZN6Kernel15sysThreadCreateEPNS_21ArgumentsOfSystemCallE+0x90>
    800030a4:	00050913          	mv	s2,a0
    __asm__ volatile("sd %[ptrThread], 0(%[handle])"::[ptrThread]"r"(newThread), [handle]"r"(arg->a0));
    800030a8:	0004b783          	ld	a5,0(s1)
    800030ac:	00a7b023          	sd	a0,0(a5)
    void* kernelSystemStack = Kernel::mallocSystemStack(KernelConfig::DEFAULT_SYSTEM_STACK_SIZE);
    800030b0:	40000513          	li	a0,1024
    800030b4:	fffff097          	auipc	ra,0xfffff
    800030b8:	5dc080e7          	jalr	1500(ra) # 80002690 <_ZN6Kernel17mallocSystemStackEm>
    800030bc:	00050713          	mv	a4,a0
    newThread->initializeThread((TCB::Body) arg->a1, (void*)arg->a2, (void*)arg->a3, kernelSystemStack, sourcePool);
    800030c0:	00000893          	li	a7,0
    800030c4:	00000813          	li	a6,0
    800030c8:	fd843783          	ld	a5,-40(s0)
    800030cc:	0184b683          	ld	a3,24(s1)
    800030d0:	0104b603          	ld	a2,16(s1)
    800030d4:	0084b583          	ld	a1,8(s1)
    800030d8:	00090513          	mv	a0,s2
    800030dc:	fffff097          	auipc	ra,0xfffff
    800030e0:	bfc080e7          	jalr	-1028(ra) # 80001cd8 <_ZN3TCB16initializeThreadEPFvPvES0_S0_S0_P10ObjectPoolIS_Lm20EEN12KernelConfig4ModeENS6_11ThreadStateE>
    return 0;
    800030e4:	00000513          	li	a0,0
}
    800030e8:	02813083          	ld	ra,40(sp)
    800030ec:	02013403          	ld	s0,32(sp)
    800030f0:	01813483          	ld	s1,24(sp)
    800030f4:	01013903          	ld	s2,16(sp)
    800030f8:	03010113          	addi	sp,sp,48
    800030fc:	00008067          	ret
        return -1;
    80003100:	fff00513          	li	a0,-1
    80003104:	fe5ff06f          	j	800030e8 <_ZN6Kernel15sysThreadCreateEPNS_21ArgumentsOfSystemCallE+0x78>

0000000080003108 <_ZN6Kernel16sysSemaphoreOpenEPNS_21ArgumentsOfSystemCallE>:
{
    80003108:	fd010113          	addi	sp,sp,-48
    8000310c:	02113423          	sd	ra,40(sp)
    80003110:	02813023          	sd	s0,32(sp)
    80003114:	00913c23          	sd	s1,24(sp)
    80003118:	03010413          	addi	s0,sp,48
    8000311c:	00050493          	mv	s1,a0
    KSemaphore* newSemaphore = poolOfSemaphores->mallocObject(&sourcePool);
    80003120:	fd840593          	addi	a1,s0,-40
    80003124:	00004517          	auipc	a0,0x4
    80003128:	31453503          	ld	a0,788(a0) # 80007438 <_ZN6Kernel16poolOfSemaphoresE>
    8000312c:	00000097          	auipc	ra,0x0
    80003130:	2b0080e7          	jalr	688(ra) # 800033dc <_ZN10ObjectPoolI10KSemaphoreLm10EE12mallocObjectEPPS1_>
    if(!newSemaphore)
    80003134:	02050a63          	beqz	a0,80003168 <_ZN6Kernel16sysSemaphoreOpenEPNS_21ArgumentsOfSystemCallE+0x60>
    __asm__ volatile("sd %[ptrSemaphore], 0(%[handle])"::[ptrSemaphore]"r"(newSemaphore), [handle]"r"(arg->a0));
    80003138:	0004b783          	ld	a5,0(s1)
    8000313c:	00a7b023          	sd	a0,0(a5)
    newSemaphore->initializeSemaphore((unsigned)arg->a1, sourcePool);
    80003140:	fd843603          	ld	a2,-40(s0)
    80003144:	0084a583          	lw	a1,8(s1)
    80003148:	fffff097          	auipc	ra,0xfffff
    8000314c:	124080e7          	jalr	292(ra) # 8000226c <_ZN10KSemaphore19initializeSemaphoreEjP10ObjectPoolIS_Lm10EE>
    return 0;
    80003150:	00000513          	li	a0,0
}
    80003154:	02813083          	ld	ra,40(sp)
    80003158:	02013403          	ld	s0,32(sp)
    8000315c:	01813483          	ld	s1,24(sp)
    80003160:	03010113          	addi	sp,sp,48
    80003164:	00008067          	ret
        return -1;
    80003168:	fff00513          	li	a0,-1
    8000316c:	fe9ff06f          	j	80003154 <_ZN6Kernel16sysSemaphoreOpenEPNS_21ArgumentsOfSystemCallE+0x4c>

0000000080003170 <_GLOBAL__sub_I__ZN6Kernel16systemCallsTableE>:
    80003170:	ff010113          	addi	sp,sp,-16
    80003174:	00113423          	sd	ra,8(sp)
    80003178:	00813023          	sd	s0,0(sp)
    8000317c:	01010413          	addi	s0,sp,16
    80003180:	000105b7          	lui	a1,0x10
    80003184:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    80003188:	00100513          	li	a0,1
    8000318c:	00000097          	auipc	ra,0x0
    80003190:	96c080e7          	jalr	-1684(ra) # 80002af8 <_Z41__static_initialization_and_destruction_0ii>
    80003194:	00813083          	ld	ra,8(sp)
    80003198:	00013403          	ld	s0,0(sp)
    8000319c:	01010113          	addi	sp,sp,16
    800031a0:	00008067          	ret

00000000800031a4 <_ZN10ObjectPoolI3TCBLm20EEnwEm>:

};


template<typename T, size_t numOfObjects>
void* ObjectPool<T, numOfObjects>::operator new(size_t size)
    800031a4:	ff010113          	addi	sp,sp,-16
    800031a8:	00113423          	sd	ra,8(sp)
    800031ac:	00813023          	sd	s0,0(sp)
    800031b0:	01010413          	addi	s0,sp,16
{
    size_t numOfBlocks = size / MEM_BLOCK_SIZE;
    800031b4:	00655793          	srli	a5,a0,0x6
    numOfBlocks += size % MEM_BLOCK_SIZE ? 1 : 0;
    800031b8:	03f57513          	andi	a0,a0,63
    800031bc:	00050463          	beqz	a0,800031c4 <_ZN10ObjectPoolI3TCBLm20EEnwEm+0x20>
    800031c0:	00100513          	li	a0,1
    return MemoryAllocator::allocateMemory(numOfBlocks);
    800031c4:	00f50533          	add	a0,a0,a5
    800031c8:	fffff097          	auipc	ra,0xfffff
    800031cc:	ddc080e7          	jalr	-548(ra) # 80001fa4 <_ZN15MemoryAllocator14allocateMemoryEm>
}
    800031d0:	00813083          	ld	ra,8(sp)
    800031d4:	00013403          	ld	s0,0(sp)
    800031d8:	01010113          	addi	sp,sp,16
    800031dc:	00008067          	ret

00000000800031e0 <_ZN10ObjectPoolI10KSemaphoreLm10EEnwEm>:
void* ObjectPool<T, numOfObjects>::operator new(size_t size)
    800031e0:	ff010113          	addi	sp,sp,-16
    800031e4:	00113423          	sd	ra,8(sp)
    800031e8:	00813023          	sd	s0,0(sp)
    800031ec:	01010413          	addi	s0,sp,16
    size_t numOfBlocks = size / MEM_BLOCK_SIZE;
    800031f0:	00655793          	srli	a5,a0,0x6
    numOfBlocks += size % MEM_BLOCK_SIZE ? 1 : 0;
    800031f4:	03f57513          	andi	a0,a0,63
    800031f8:	00050463          	beqz	a0,80003200 <_ZN10ObjectPoolI10KSemaphoreLm10EEnwEm+0x20>
    800031fc:	00100513          	li	a0,1
    return MemoryAllocator::allocateMemory(numOfBlocks);
    80003200:	00f50533          	add	a0,a0,a5
    80003204:	fffff097          	auipc	ra,0xfffff
    80003208:	da0080e7          	jalr	-608(ra) # 80001fa4 <_ZN15MemoryAllocator14allocateMemoryEm>
}
    8000320c:	00813083          	ld	ra,8(sp)
    80003210:	00013403          	ld	s0,0(sp)
    80003214:	01010113          	addi	sp,sp,16
    80003218:	00008067          	ret

000000008000321c <_ZN10ObjectPoolI3TCBLm20EE10freeObjectEPS0_>:
        return &(temp->object);
    }
}

template<typename T, size_t numOfObjects>
int ObjectPool<T, numOfObjects>::freeObject(T *obj) {
    8000321c:	ff010113          	addi	sp,sp,-16
    80003220:	00813423          	sd	s0,8(sp)
    80003224:	01010413          	addi	s0,sp,16
    ObjectPool<TCB, KernelConfig::NUM_OF_THREADS_IN_POOL>* getSourcePool() { return sourcePool; }
    80003228:	0585b783          	ld	a5,88(a1)
////        {
////            break;
////        }
////    }
    PoolObject* tempObj = (PoolObject*)obj;
    tempObj->nextFree = curr->headFreeObject;
    8000322c:	00001737          	lui	a4,0x1
    80003230:	00e787b3          	add	a5,a5,a4
    80003234:	8207b703          	ld	a4,-2016(a5)
    80003238:	06e5b023          	sd	a4,96(a1)
    curr->headFreeObject = tempObj;
    8000323c:	82b7b023          	sd	a1,-2016(a5)

    return 0;
}
    80003240:	00000513          	li	a0,0
    80003244:	00813403          	ld	s0,8(sp)
    80003248:	01010113          	addi	sp,sp,16
    8000324c:	00008067          	ret

0000000080003250 <_ZN10ObjectPoolI10KSemaphoreLm10EE10freeObjectEPS0_>:
int ObjectPool<T, numOfObjects>::freeObject(T *obj) {
    80003250:	ff010113          	addi	sp,sp,-16
    80003254:	00813423          	sd	s0,8(sp)
    80003258:	01010413          	addi	s0,sp,16
class KSemaphore {
public:
    KSemaphore() = default;
    void initializeSemaphore(unsigned value, ObjectPool<KSemaphore, KernelConfig::NUM_OF_SEMAPHORES_IN_POOL>* pool);
    void removeThreadFromWaitQueue(TCB* thread);
    ObjectPool<KSemaphore, KernelConfig::NUM_OF_SEMAPHORES_IN_POOL>* getSourcePool() { return sourcePool; }
    8000325c:	0185b783          	ld	a5,24(a1)
    tempObj->nextFree = curr->headFreeObject;
    80003260:	1907b703          	ld	a4,400(a5)
    80003264:	02e5b023          	sd	a4,32(a1)
    curr->headFreeObject = tempObj;
    80003268:	18b7b823          	sd	a1,400(a5)
}
    8000326c:	00000513          	li	a0,0
    80003270:	00813403          	ld	s0,8(sp)
    80003274:	01010113          	addi	sp,sp,16
    80003278:	00008067          	ret

000000008000327c <_ZN10ObjectPoolI3TCBLm20EE12findFreePoolEv>:
ObjectPool<T, numOfObjects>* ObjectPool<T, numOfObjects>::findFreePool(void)
    8000327c:	ff010113          	addi	sp,sp,-16
    80003280:	00813423          	sd	s0,8(sp)
    80003284:	01010413          	addi	s0,sp,16
    80003288:	00050793          	mv	a5,a0
    for(; !curr->nextObjectPool && !curr->headFreeObject; curr = curr->nextObjectPool);
    8000328c:	00078513          	mv	a0,a5
    80003290:	00001737          	lui	a4,0x1
    80003294:	00e787b3          	add	a5,a5,a4
    80003298:	8287b783          	ld	a5,-2008(a5)
    8000329c:	00079863          	bnez	a5,800032ac <_ZN10ObjectPoolI3TCBLm20EE12findFreePoolEv+0x30>
    800032a0:	00e50733          	add	a4,a0,a4
    800032a4:	82073703          	ld	a4,-2016(a4) # 820 <_entry-0x7ffff7e0>
    800032a8:	fe0702e3          	beqz	a4,8000328c <_ZN10ObjectPoolI3TCBLm20EE12findFreePoolEv+0x10>
}
    800032ac:	00813403          	ld	s0,8(sp)
    800032b0:	01010113          	addi	sp,sp,16
    800032b4:	00008067          	ret

00000000800032b8 <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEPPS1_>:
T* ObjectPool<T, numOfObjects>::mallocObject(ObjectPool<T, numOfObjects>** addressOfPool)
    800032b8:	fd010113          	addi	sp,sp,-48
    800032bc:	02113423          	sd	ra,40(sp)
    800032c0:	02813023          	sd	s0,32(sp)
    800032c4:	00913c23          	sd	s1,24(sp)
    800032c8:	01213823          	sd	s2,16(sp)
    800032cc:	01313423          	sd	s3,8(sp)
    800032d0:	03010413          	addi	s0,sp,48
    800032d4:	00058913          	mv	s2,a1
    ObjectPool<T,numOfObjects>* currentPool = findFreePool();
    800032d8:	00000097          	auipc	ra,0x0
    800032dc:	fa4080e7          	jalr	-92(ra) # 8000327c <_ZN10ObjectPoolI3TCBLm20EE12findFreePoolEv>
    800032e0:	00050493          	mv	s1,a0
    if (currentPool->headFreeObject)
    800032e4:	000017b7          	lui	a5,0x1
    800032e8:	00f507b3          	add	a5,a0,a5
    800032ec:	8207b503          	ld	a0,-2016(a5) # 820 <_entry-0x7ffff7e0>
    800032f0:	02050a63          	beqz	a0,80003324 <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEPPS1_+0x6c>
        currentPool->headFreeObject = currentPool->headFreeObject->nextFree;
    800032f4:	06053703          	ld	a4,96(a0)
    800032f8:	000017b7          	lui	a5,0x1
    800032fc:	00f487b3          	add	a5,s1,a5
    80003300:	82e7b023          	sd	a4,-2016(a5) # 820 <_entry-0x7ffff7e0>
        *addressOfPool = currentPool;
    80003304:	00993023          	sd	s1,0(s2)
}
    80003308:	02813083          	ld	ra,40(sp)
    8000330c:	02013403          	ld	s0,32(sp)
    80003310:	01813483          	ld	s1,24(sp)
    80003314:	01013903          	ld	s2,16(sp)
    80003318:	00813983          	ld	s3,8(sp)
    8000331c:	03010113          	addi	sp,sp,48
    80003320:	00008067          	ret
        ObjectPool<T, numOfObjects>* newPool = new ObjectPool();
    80003324:	000019b7          	lui	s3,0x1
    80003328:	83898513          	addi	a0,s3,-1992 # 838 <_entry-0x7ffff7c8>
    8000332c:	00000097          	auipc	ra,0x0
    80003330:	e78080e7          	jalr	-392(ra) # 800031a4 <_ZN10ObjectPoolI3TCBLm20EEnwEm>
    ObjectPool(): headFreeObject(pool), nextObjectPool(nullptr), prevObjectPool(nullptr)
    80003334:	013507b3          	add	a5,a0,s3
    80003338:	82a7b023          	sd	a0,-2016(a5)
    8000333c:	8207b423          	sd	zero,-2008(a5)
    80003340:	8207b823          	sd	zero,-2000(a5)
        for(size_t i = 0; i < numOfObjects - 1; i++)
    80003344:	00000793          	li	a5,0
    80003348:	01200713          	li	a4,18
    8000334c:	02f76463          	bltu	a4,a5,80003374 <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEPPS1_+0xbc>
            pool[i].nextFree = &(pool[i+1]);
    80003350:	00178693          	addi	a3,a5,1
    80003354:	06800613          	li	a2,104
    80003358:	02c68733          	mul	a4,a3,a2
    8000335c:	00e50733          	add	a4,a0,a4
    80003360:	02c787b3          	mul	a5,a5,a2
    80003364:	00f507b3          	add	a5,a0,a5
    80003368:	06e7b023          	sd	a4,96(a5)
        for(size_t i = 0; i < numOfObjects - 1; i++)
    8000336c:	00068793          	mv	a5,a3
    80003370:	fd9ff06f          	j	80003348 <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEPPS1_+0x90>
        pool[numOfObjects - 1].nextFree = nullptr;
    80003374:	000017b7          	lui	a5,0x1
    80003378:	00f507b3          	add	a5,a0,a5
    8000337c:	8007bc23          	sd	zero,-2024(a5) # 818 <_entry-0x7ffff7e8>
        if(!newPool)
    80003380:	f80504e3          	beqz	a0,80003308 <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEPPS1_+0x50>
        newPool->prevObjectPool = currentPool;
    80003384:	00001737          	lui	a4,0x1
    80003388:	8297b823          	sd	s1,-2000(a5)
        currentPool->nextObjectPool = newPool;
    8000338c:	00e484b3          	add	s1,s1,a4
    80003390:	82a4b423          	sd	a0,-2008(s1)
        PoolObject* temp = newPool->headFreeObject;
    80003394:	8207b703          	ld	a4,-2016(a5)
        newPool->headFreeObject = newPool->headFreeObject->nextFree;
    80003398:	06073683          	ld	a3,96(a4) # 1060 <_entry-0x7fffefa0>
    8000339c:	82d7b023          	sd	a3,-2016(a5)
        *addressOfPool = newPool;
    800033a0:	00a93023          	sd	a0,0(s2)
        return &(temp->object);
    800033a4:	00070513          	mv	a0,a4
    800033a8:	f61ff06f          	j	80003308 <_ZN10ObjectPoolI3TCBLm20EE12mallocObjectEPPS1_+0x50>

00000000800033ac <_ZN10ObjectPoolI10KSemaphoreLm10EE12findFreePoolEv>:
ObjectPool<T, numOfObjects>* ObjectPool<T, numOfObjects>::findFreePool(void)
    800033ac:	ff010113          	addi	sp,sp,-16
    800033b0:	00813423          	sd	s0,8(sp)
    800033b4:	01010413          	addi	s0,sp,16
    800033b8:	00050793          	mv	a5,a0
    for(; !curr->nextObjectPool && !curr->headFreeObject; curr = curr->nextObjectPool);
    800033bc:	00078513          	mv	a0,a5
    800033c0:	1987b783          	ld	a5,408(a5)
    800033c4:	00079663          	bnez	a5,800033d0 <_ZN10ObjectPoolI10KSemaphoreLm10EE12findFreePoolEv+0x24>
    800033c8:	19053703          	ld	a4,400(a0)
    800033cc:	fe0708e3          	beqz	a4,800033bc <_ZN10ObjectPoolI10KSemaphoreLm10EE12findFreePoolEv+0x10>
}
    800033d0:	00813403          	ld	s0,8(sp)
    800033d4:	01010113          	addi	sp,sp,16
    800033d8:	00008067          	ret

00000000800033dc <_ZN10ObjectPoolI10KSemaphoreLm10EE12mallocObjectEPPS1_>:
T* ObjectPool<T, numOfObjects>::mallocObject(ObjectPool<T, numOfObjects>** addressOfPool)
    800033dc:	fe010113          	addi	sp,sp,-32
    800033e0:	00113c23          	sd	ra,24(sp)
    800033e4:	00813823          	sd	s0,16(sp)
    800033e8:	00913423          	sd	s1,8(sp)
    800033ec:	01213023          	sd	s2,0(sp)
    800033f0:	02010413          	addi	s0,sp,32
    800033f4:	00058913          	mv	s2,a1
    ObjectPool<T,numOfObjects>* currentPool = findFreePool();
    800033f8:	00000097          	auipc	ra,0x0
    800033fc:	fb4080e7          	jalr	-76(ra) # 800033ac <_ZN10ObjectPoolI10KSemaphoreLm10EE12findFreePoolEv>
    80003400:	00050493          	mv	s1,a0
    if (currentPool->headFreeObject)
    80003404:	19053503          	ld	a0,400(a0)
    80003408:	02050463          	beqz	a0,80003430 <_ZN10ObjectPoolI10KSemaphoreLm10EE12mallocObjectEPPS1_+0x54>
        currentPool->headFreeObject = currentPool->headFreeObject->nextFree;
    8000340c:	02053783          	ld	a5,32(a0)
    80003410:	18f4b823          	sd	a5,400(s1)
        *addressOfPool = currentPool;
    80003414:	00993023          	sd	s1,0(s2)
}
    80003418:	01813083          	ld	ra,24(sp)
    8000341c:	01013403          	ld	s0,16(sp)
    80003420:	00813483          	ld	s1,8(sp)
    80003424:	00013903          	ld	s2,0(sp)
    80003428:	02010113          	addi	sp,sp,32
    8000342c:	00008067          	ret
        ObjectPool<T, numOfObjects>* newPool = new ObjectPool();
    80003430:	1a800513          	li	a0,424
    80003434:	00000097          	auipc	ra,0x0
    80003438:	dac080e7          	jalr	-596(ra) # 800031e0 <_ZN10ObjectPoolI10KSemaphoreLm10EEnwEm>
    ObjectPool(): headFreeObject(pool), nextObjectPool(nullptr), prevObjectPool(nullptr)
    8000343c:	18a53823          	sd	a0,400(a0)
    80003440:	18053c23          	sd	zero,408(a0)
    80003444:	1a053023          	sd	zero,416(a0)
        for(size_t i = 0; i < numOfObjects - 1; i++)
    80003448:	00000693          	li	a3,0
    8000344c:	0300006f          	j	8000347c <_ZN10ObjectPoolI10KSemaphoreLm10EE12mallocObjectEPPS1_+0xa0>
            pool[i].nextFree = &(pool[i+1]);
    80003450:	00168613          	addi	a2,a3,1
    80003454:	00261713          	slli	a4,a2,0x2
    80003458:	00c70733          	add	a4,a4,a2
    8000345c:	00371713          	slli	a4,a4,0x3
    80003460:	00e50733          	add	a4,a0,a4
    80003464:	00269793          	slli	a5,a3,0x2
    80003468:	00d787b3          	add	a5,a5,a3
    8000346c:	00379793          	slli	a5,a5,0x3
    80003470:	00f507b3          	add	a5,a0,a5
    80003474:	02e7b023          	sd	a4,32(a5)
        for(size_t i = 0; i < numOfObjects - 1; i++)
    80003478:	00060693          	mv	a3,a2
    8000347c:	00800793          	li	a5,8
    80003480:	fcd7f8e3          	bgeu	a5,a3,80003450 <_ZN10ObjectPoolI10KSemaphoreLm10EE12mallocObjectEPPS1_+0x74>
        pool[numOfObjects - 1].nextFree = nullptr;
    80003484:	18053423          	sd	zero,392(a0)
        if(!newPool)
    80003488:	f80508e3          	beqz	a0,80003418 <_ZN10ObjectPoolI10KSemaphoreLm10EE12mallocObjectEPPS1_+0x3c>
        newPool->prevObjectPool = currentPool;
    8000348c:	1a953023          	sd	s1,416(a0)
        currentPool->nextObjectPool = newPool;
    80003490:	18a4bc23          	sd	a0,408(s1)
        PoolObject* temp = newPool->headFreeObject;
    80003494:	19053783          	ld	a5,400(a0)
        newPool->headFreeObject = newPool->headFreeObject->nextFree;
    80003498:	0207b703          	ld	a4,32(a5)
    8000349c:	18e53823          	sd	a4,400(a0)
        *addressOfPool = newPool;
    800034a0:	00a93023          	sd	a0,0(s2)
        return &(temp->object);
    800034a4:	00078513          	mv	a0,a5
    800034a8:	f71ff06f          	j	80003418 <_ZN10ObjectPoolI10KSemaphoreLm10EE12mallocObjectEPPS1_+0x3c>

00000000800034ac <start>:
    800034ac:	ff010113          	addi	sp,sp,-16
    800034b0:	00813423          	sd	s0,8(sp)
    800034b4:	01010413          	addi	s0,sp,16
    800034b8:	300027f3          	csrr	a5,mstatus
    800034bc:	ffffe737          	lui	a4,0xffffe
    800034c0:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff616f>
    800034c4:	00e7f7b3          	and	a5,a5,a4
    800034c8:	00001737          	lui	a4,0x1
    800034cc:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    800034d0:	00e7e7b3          	or	a5,a5,a4
    800034d4:	30079073          	csrw	mstatus,a5
    800034d8:	00000797          	auipc	a5,0x0
    800034dc:	16078793          	addi	a5,a5,352 # 80003638 <system_main>
    800034e0:	34179073          	csrw	mepc,a5
    800034e4:	00000793          	li	a5,0
    800034e8:	18079073          	csrw	satp,a5
    800034ec:	000107b7          	lui	a5,0x10
    800034f0:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    800034f4:	30279073          	csrw	medeleg,a5
    800034f8:	30379073          	csrw	mideleg,a5
    800034fc:	104027f3          	csrr	a5,sie
    80003500:	2227e793          	ori	a5,a5,546
    80003504:	10479073          	csrw	sie,a5
    80003508:	fff00793          	li	a5,-1
    8000350c:	00a7d793          	srli	a5,a5,0xa
    80003510:	3b079073          	csrw	pmpaddr0,a5
    80003514:	00f00793          	li	a5,15
    80003518:	3a079073          	csrw	pmpcfg0,a5
    8000351c:	f14027f3          	csrr	a5,mhartid
    80003520:	0200c737          	lui	a4,0x200c
    80003524:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80003528:	0007869b          	sext.w	a3,a5
    8000352c:	00269713          	slli	a4,a3,0x2
    80003530:	000f4637          	lui	a2,0xf4
    80003534:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80003538:	00d70733          	add	a4,a4,a3
    8000353c:	0037979b          	slliw	a5,a5,0x3
    80003540:	020046b7          	lui	a3,0x2004
    80003544:	00d787b3          	add	a5,a5,a3
    80003548:	00c585b3          	add	a1,a1,a2
    8000354c:	00371693          	slli	a3,a4,0x3
    80003550:	00004717          	auipc	a4,0x4
    80003554:	ef070713          	addi	a4,a4,-272 # 80007440 <timer_scratch>
    80003558:	00b7b023          	sd	a1,0(a5)
    8000355c:	00d70733          	add	a4,a4,a3
    80003560:	00f73c23          	sd	a5,24(a4)
    80003564:	02c73023          	sd	a2,32(a4)
    80003568:	34071073          	csrw	mscratch,a4
    8000356c:	00000797          	auipc	a5,0x0
    80003570:	6e478793          	addi	a5,a5,1764 # 80003c50 <timervec>
    80003574:	30579073          	csrw	mtvec,a5
    80003578:	300027f3          	csrr	a5,mstatus
    8000357c:	0087e793          	ori	a5,a5,8
    80003580:	30079073          	csrw	mstatus,a5
    80003584:	304027f3          	csrr	a5,mie
    80003588:	0807e793          	ori	a5,a5,128
    8000358c:	30479073          	csrw	mie,a5
    80003590:	f14027f3          	csrr	a5,mhartid
    80003594:	0007879b          	sext.w	a5,a5
    80003598:	00078213          	mv	tp,a5
    8000359c:	30200073          	mret
    800035a0:	00813403          	ld	s0,8(sp)
    800035a4:	01010113          	addi	sp,sp,16
    800035a8:	00008067          	ret

00000000800035ac <timerinit>:
    800035ac:	ff010113          	addi	sp,sp,-16
    800035b0:	00813423          	sd	s0,8(sp)
    800035b4:	01010413          	addi	s0,sp,16
    800035b8:	f14027f3          	csrr	a5,mhartid
    800035bc:	0200c737          	lui	a4,0x200c
    800035c0:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800035c4:	0007869b          	sext.w	a3,a5
    800035c8:	00269713          	slli	a4,a3,0x2
    800035cc:	000f4637          	lui	a2,0xf4
    800035d0:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800035d4:	00d70733          	add	a4,a4,a3
    800035d8:	0037979b          	slliw	a5,a5,0x3
    800035dc:	020046b7          	lui	a3,0x2004
    800035e0:	00d787b3          	add	a5,a5,a3
    800035e4:	00c585b3          	add	a1,a1,a2
    800035e8:	00371693          	slli	a3,a4,0x3
    800035ec:	00004717          	auipc	a4,0x4
    800035f0:	e5470713          	addi	a4,a4,-428 # 80007440 <timer_scratch>
    800035f4:	00b7b023          	sd	a1,0(a5)
    800035f8:	00d70733          	add	a4,a4,a3
    800035fc:	00f73c23          	sd	a5,24(a4)
    80003600:	02c73023          	sd	a2,32(a4)
    80003604:	34071073          	csrw	mscratch,a4
    80003608:	00000797          	auipc	a5,0x0
    8000360c:	64878793          	addi	a5,a5,1608 # 80003c50 <timervec>
    80003610:	30579073          	csrw	mtvec,a5
    80003614:	300027f3          	csrr	a5,mstatus
    80003618:	0087e793          	ori	a5,a5,8
    8000361c:	30079073          	csrw	mstatus,a5
    80003620:	304027f3          	csrr	a5,mie
    80003624:	0807e793          	ori	a5,a5,128
    80003628:	30479073          	csrw	mie,a5
    8000362c:	00813403          	ld	s0,8(sp)
    80003630:	01010113          	addi	sp,sp,16
    80003634:	00008067          	ret

0000000080003638 <system_main>:
    80003638:	fe010113          	addi	sp,sp,-32
    8000363c:	00813823          	sd	s0,16(sp)
    80003640:	00913423          	sd	s1,8(sp)
    80003644:	00113c23          	sd	ra,24(sp)
    80003648:	02010413          	addi	s0,sp,32
    8000364c:	00000097          	auipc	ra,0x0
    80003650:	0c4080e7          	jalr	196(ra) # 80003710 <cpuid>
    80003654:	00004497          	auipc	s1,0x4
    80003658:	b0c48493          	addi	s1,s1,-1268 # 80007160 <started>
    8000365c:	02050263          	beqz	a0,80003680 <system_main+0x48>
    80003660:	0004a783          	lw	a5,0(s1)
    80003664:	0007879b          	sext.w	a5,a5
    80003668:	fe078ce3          	beqz	a5,80003660 <system_main+0x28>
    8000366c:	0ff0000f          	fence
    80003670:	00003517          	auipc	a0,0x3
    80003674:	9e050513          	addi	a0,a0,-1568 # 80006050 <CONSOLE_STATUS+0x40>
    80003678:	00001097          	auipc	ra,0x1
    8000367c:	a74080e7          	jalr	-1420(ra) # 800040ec <panic>
    80003680:	00001097          	auipc	ra,0x1
    80003684:	9c8080e7          	jalr	-1592(ra) # 80004048 <consoleinit>
    80003688:	00001097          	auipc	ra,0x1
    8000368c:	154080e7          	jalr	340(ra) # 800047dc <printfinit>
    80003690:	00003517          	auipc	a0,0x3
    80003694:	aa050513          	addi	a0,a0,-1376 # 80006130 <CONSOLE_STATUS+0x120>
    80003698:	00001097          	auipc	ra,0x1
    8000369c:	ab0080e7          	jalr	-1360(ra) # 80004148 <__printf>
    800036a0:	00003517          	auipc	a0,0x3
    800036a4:	98050513          	addi	a0,a0,-1664 # 80006020 <CONSOLE_STATUS+0x10>
    800036a8:	00001097          	auipc	ra,0x1
    800036ac:	aa0080e7          	jalr	-1376(ra) # 80004148 <__printf>
    800036b0:	00003517          	auipc	a0,0x3
    800036b4:	a8050513          	addi	a0,a0,-1408 # 80006130 <CONSOLE_STATUS+0x120>
    800036b8:	00001097          	auipc	ra,0x1
    800036bc:	a90080e7          	jalr	-1392(ra) # 80004148 <__printf>
    800036c0:	00001097          	auipc	ra,0x1
    800036c4:	4a8080e7          	jalr	1192(ra) # 80004b68 <kinit>
    800036c8:	00000097          	auipc	ra,0x0
    800036cc:	148080e7          	jalr	328(ra) # 80003810 <trapinit>
    800036d0:	00000097          	auipc	ra,0x0
    800036d4:	16c080e7          	jalr	364(ra) # 8000383c <trapinithart>
    800036d8:	00000097          	auipc	ra,0x0
    800036dc:	5b8080e7          	jalr	1464(ra) # 80003c90 <plicinit>
    800036e0:	00000097          	auipc	ra,0x0
    800036e4:	5d8080e7          	jalr	1496(ra) # 80003cb8 <plicinithart>
    800036e8:	00000097          	auipc	ra,0x0
    800036ec:	078080e7          	jalr	120(ra) # 80003760 <userinit>
    800036f0:	0ff0000f          	fence
    800036f4:	00100793          	li	a5,1
    800036f8:	00003517          	auipc	a0,0x3
    800036fc:	94050513          	addi	a0,a0,-1728 # 80006038 <CONSOLE_STATUS+0x28>
    80003700:	00f4a023          	sw	a5,0(s1)
    80003704:	00001097          	auipc	ra,0x1
    80003708:	a44080e7          	jalr	-1468(ra) # 80004148 <__printf>
    8000370c:	0000006f          	j	8000370c <system_main+0xd4>

0000000080003710 <cpuid>:
    80003710:	ff010113          	addi	sp,sp,-16
    80003714:	00813423          	sd	s0,8(sp)
    80003718:	01010413          	addi	s0,sp,16
    8000371c:	00020513          	mv	a0,tp
    80003720:	00813403          	ld	s0,8(sp)
    80003724:	0005051b          	sext.w	a0,a0
    80003728:	01010113          	addi	sp,sp,16
    8000372c:	00008067          	ret

0000000080003730 <mycpu>:
    80003730:	ff010113          	addi	sp,sp,-16
    80003734:	00813423          	sd	s0,8(sp)
    80003738:	01010413          	addi	s0,sp,16
    8000373c:	00020793          	mv	a5,tp
    80003740:	00813403          	ld	s0,8(sp)
    80003744:	0007879b          	sext.w	a5,a5
    80003748:	00779793          	slli	a5,a5,0x7
    8000374c:	00005517          	auipc	a0,0x5
    80003750:	d2450513          	addi	a0,a0,-732 # 80008470 <cpus>
    80003754:	00f50533          	add	a0,a0,a5
    80003758:	01010113          	addi	sp,sp,16
    8000375c:	00008067          	ret

0000000080003760 <userinit>:
    80003760:	ff010113          	addi	sp,sp,-16
    80003764:	00813423          	sd	s0,8(sp)
    80003768:	01010413          	addi	s0,sp,16
    8000376c:	00813403          	ld	s0,8(sp)
    80003770:	01010113          	addi	sp,sp,16
    80003774:	ffffe317          	auipc	t1,0xffffe
    80003778:	51030067          	jr	1296(t1) # 80001c84 <main>

000000008000377c <either_copyout>:
    8000377c:	ff010113          	addi	sp,sp,-16
    80003780:	00813023          	sd	s0,0(sp)
    80003784:	00113423          	sd	ra,8(sp)
    80003788:	01010413          	addi	s0,sp,16
    8000378c:	02051663          	bnez	a0,800037b8 <either_copyout+0x3c>
    80003790:	00058513          	mv	a0,a1
    80003794:	00060593          	mv	a1,a2
    80003798:	0006861b          	sext.w	a2,a3
    8000379c:	00002097          	auipc	ra,0x2
    800037a0:	c58080e7          	jalr	-936(ra) # 800053f4 <__memmove>
    800037a4:	00813083          	ld	ra,8(sp)
    800037a8:	00013403          	ld	s0,0(sp)
    800037ac:	00000513          	li	a0,0
    800037b0:	01010113          	addi	sp,sp,16
    800037b4:	00008067          	ret
    800037b8:	00003517          	auipc	a0,0x3
    800037bc:	8c050513          	addi	a0,a0,-1856 # 80006078 <CONSOLE_STATUS+0x68>
    800037c0:	00001097          	auipc	ra,0x1
    800037c4:	92c080e7          	jalr	-1748(ra) # 800040ec <panic>

00000000800037c8 <either_copyin>:
    800037c8:	ff010113          	addi	sp,sp,-16
    800037cc:	00813023          	sd	s0,0(sp)
    800037d0:	00113423          	sd	ra,8(sp)
    800037d4:	01010413          	addi	s0,sp,16
    800037d8:	02059463          	bnez	a1,80003800 <either_copyin+0x38>
    800037dc:	00060593          	mv	a1,a2
    800037e0:	0006861b          	sext.w	a2,a3
    800037e4:	00002097          	auipc	ra,0x2
    800037e8:	c10080e7          	jalr	-1008(ra) # 800053f4 <__memmove>
    800037ec:	00813083          	ld	ra,8(sp)
    800037f0:	00013403          	ld	s0,0(sp)
    800037f4:	00000513          	li	a0,0
    800037f8:	01010113          	addi	sp,sp,16
    800037fc:	00008067          	ret
    80003800:	00003517          	auipc	a0,0x3
    80003804:	8a050513          	addi	a0,a0,-1888 # 800060a0 <CONSOLE_STATUS+0x90>
    80003808:	00001097          	auipc	ra,0x1
    8000380c:	8e4080e7          	jalr	-1820(ra) # 800040ec <panic>

0000000080003810 <trapinit>:
    80003810:	ff010113          	addi	sp,sp,-16
    80003814:	00813423          	sd	s0,8(sp)
    80003818:	01010413          	addi	s0,sp,16
    8000381c:	00813403          	ld	s0,8(sp)
    80003820:	00003597          	auipc	a1,0x3
    80003824:	8a858593          	addi	a1,a1,-1880 # 800060c8 <CONSOLE_STATUS+0xb8>
    80003828:	00005517          	auipc	a0,0x5
    8000382c:	cc850513          	addi	a0,a0,-824 # 800084f0 <tickslock>
    80003830:	01010113          	addi	sp,sp,16
    80003834:	00001317          	auipc	t1,0x1
    80003838:	5c430067          	jr	1476(t1) # 80004df8 <initlock>

000000008000383c <trapinithart>:
    8000383c:	ff010113          	addi	sp,sp,-16
    80003840:	00813423          	sd	s0,8(sp)
    80003844:	01010413          	addi	s0,sp,16
    80003848:	00000797          	auipc	a5,0x0
    8000384c:	2f878793          	addi	a5,a5,760 # 80003b40 <kernelvec>
    80003850:	10579073          	csrw	stvec,a5
    80003854:	00813403          	ld	s0,8(sp)
    80003858:	01010113          	addi	sp,sp,16
    8000385c:	00008067          	ret

0000000080003860 <usertrap>:
    80003860:	ff010113          	addi	sp,sp,-16
    80003864:	00813423          	sd	s0,8(sp)
    80003868:	01010413          	addi	s0,sp,16
    8000386c:	00813403          	ld	s0,8(sp)
    80003870:	01010113          	addi	sp,sp,16
    80003874:	00008067          	ret

0000000080003878 <usertrapret>:
    80003878:	ff010113          	addi	sp,sp,-16
    8000387c:	00813423          	sd	s0,8(sp)
    80003880:	01010413          	addi	s0,sp,16
    80003884:	00813403          	ld	s0,8(sp)
    80003888:	01010113          	addi	sp,sp,16
    8000388c:	00008067          	ret

0000000080003890 <kerneltrap>:
    80003890:	fe010113          	addi	sp,sp,-32
    80003894:	00813823          	sd	s0,16(sp)
    80003898:	00113c23          	sd	ra,24(sp)
    8000389c:	00913423          	sd	s1,8(sp)
    800038a0:	02010413          	addi	s0,sp,32
    800038a4:	142025f3          	csrr	a1,scause
    800038a8:	100027f3          	csrr	a5,sstatus
    800038ac:	0027f793          	andi	a5,a5,2
    800038b0:	10079c63          	bnez	a5,800039c8 <kerneltrap+0x138>
    800038b4:	142027f3          	csrr	a5,scause
    800038b8:	0207ce63          	bltz	a5,800038f4 <kerneltrap+0x64>
    800038bc:	00003517          	auipc	a0,0x3
    800038c0:	85450513          	addi	a0,a0,-1964 # 80006110 <CONSOLE_STATUS+0x100>
    800038c4:	00001097          	auipc	ra,0x1
    800038c8:	884080e7          	jalr	-1916(ra) # 80004148 <__printf>
    800038cc:	141025f3          	csrr	a1,sepc
    800038d0:	14302673          	csrr	a2,stval
    800038d4:	00003517          	auipc	a0,0x3
    800038d8:	84c50513          	addi	a0,a0,-1972 # 80006120 <CONSOLE_STATUS+0x110>
    800038dc:	00001097          	auipc	ra,0x1
    800038e0:	86c080e7          	jalr	-1940(ra) # 80004148 <__printf>
    800038e4:	00003517          	auipc	a0,0x3
    800038e8:	85450513          	addi	a0,a0,-1964 # 80006138 <CONSOLE_STATUS+0x128>
    800038ec:	00001097          	auipc	ra,0x1
    800038f0:	800080e7          	jalr	-2048(ra) # 800040ec <panic>
    800038f4:	0ff7f713          	andi	a4,a5,255
    800038f8:	00900693          	li	a3,9
    800038fc:	04d70063          	beq	a4,a3,8000393c <kerneltrap+0xac>
    80003900:	fff00713          	li	a4,-1
    80003904:	03f71713          	slli	a4,a4,0x3f
    80003908:	00170713          	addi	a4,a4,1
    8000390c:	fae798e3          	bne	a5,a4,800038bc <kerneltrap+0x2c>
    80003910:	00000097          	auipc	ra,0x0
    80003914:	e00080e7          	jalr	-512(ra) # 80003710 <cpuid>
    80003918:	06050663          	beqz	a0,80003984 <kerneltrap+0xf4>
    8000391c:	144027f3          	csrr	a5,sip
    80003920:	ffd7f793          	andi	a5,a5,-3
    80003924:	14479073          	csrw	sip,a5
    80003928:	01813083          	ld	ra,24(sp)
    8000392c:	01013403          	ld	s0,16(sp)
    80003930:	00813483          	ld	s1,8(sp)
    80003934:	02010113          	addi	sp,sp,32
    80003938:	00008067          	ret
    8000393c:	00000097          	auipc	ra,0x0
    80003940:	3c8080e7          	jalr	968(ra) # 80003d04 <plic_claim>
    80003944:	00a00793          	li	a5,10
    80003948:	00050493          	mv	s1,a0
    8000394c:	06f50863          	beq	a0,a5,800039bc <kerneltrap+0x12c>
    80003950:	fc050ce3          	beqz	a0,80003928 <kerneltrap+0x98>
    80003954:	00050593          	mv	a1,a0
    80003958:	00002517          	auipc	a0,0x2
    8000395c:	79850513          	addi	a0,a0,1944 # 800060f0 <CONSOLE_STATUS+0xe0>
    80003960:	00000097          	auipc	ra,0x0
    80003964:	7e8080e7          	jalr	2024(ra) # 80004148 <__printf>
    80003968:	01013403          	ld	s0,16(sp)
    8000396c:	01813083          	ld	ra,24(sp)
    80003970:	00048513          	mv	a0,s1
    80003974:	00813483          	ld	s1,8(sp)
    80003978:	02010113          	addi	sp,sp,32
    8000397c:	00000317          	auipc	t1,0x0
    80003980:	3c030067          	jr	960(t1) # 80003d3c <plic_complete>
    80003984:	00005517          	auipc	a0,0x5
    80003988:	b6c50513          	addi	a0,a0,-1172 # 800084f0 <tickslock>
    8000398c:	00001097          	auipc	ra,0x1
    80003990:	490080e7          	jalr	1168(ra) # 80004e1c <acquire>
    80003994:	00003717          	auipc	a4,0x3
    80003998:	7d070713          	addi	a4,a4,2000 # 80007164 <ticks>
    8000399c:	00072783          	lw	a5,0(a4)
    800039a0:	00005517          	auipc	a0,0x5
    800039a4:	b5050513          	addi	a0,a0,-1200 # 800084f0 <tickslock>
    800039a8:	0017879b          	addiw	a5,a5,1
    800039ac:	00f72023          	sw	a5,0(a4)
    800039b0:	00001097          	auipc	ra,0x1
    800039b4:	538080e7          	jalr	1336(ra) # 80004ee8 <release>
    800039b8:	f65ff06f          	j	8000391c <kerneltrap+0x8c>
    800039bc:	00001097          	auipc	ra,0x1
    800039c0:	094080e7          	jalr	148(ra) # 80004a50 <uartintr>
    800039c4:	fa5ff06f          	j	80003968 <kerneltrap+0xd8>
    800039c8:	00002517          	auipc	a0,0x2
    800039cc:	70850513          	addi	a0,a0,1800 # 800060d0 <CONSOLE_STATUS+0xc0>
    800039d0:	00000097          	auipc	ra,0x0
    800039d4:	71c080e7          	jalr	1820(ra) # 800040ec <panic>

00000000800039d8 <clockintr>:
    800039d8:	fe010113          	addi	sp,sp,-32
    800039dc:	00813823          	sd	s0,16(sp)
    800039e0:	00913423          	sd	s1,8(sp)
    800039e4:	00113c23          	sd	ra,24(sp)
    800039e8:	02010413          	addi	s0,sp,32
    800039ec:	00005497          	auipc	s1,0x5
    800039f0:	b0448493          	addi	s1,s1,-1276 # 800084f0 <tickslock>
    800039f4:	00048513          	mv	a0,s1
    800039f8:	00001097          	auipc	ra,0x1
    800039fc:	424080e7          	jalr	1060(ra) # 80004e1c <acquire>
    80003a00:	00003717          	auipc	a4,0x3
    80003a04:	76470713          	addi	a4,a4,1892 # 80007164 <ticks>
    80003a08:	00072783          	lw	a5,0(a4)
    80003a0c:	01013403          	ld	s0,16(sp)
    80003a10:	01813083          	ld	ra,24(sp)
    80003a14:	00048513          	mv	a0,s1
    80003a18:	0017879b          	addiw	a5,a5,1
    80003a1c:	00813483          	ld	s1,8(sp)
    80003a20:	00f72023          	sw	a5,0(a4)
    80003a24:	02010113          	addi	sp,sp,32
    80003a28:	00001317          	auipc	t1,0x1
    80003a2c:	4c030067          	jr	1216(t1) # 80004ee8 <release>

0000000080003a30 <devintr>:
    80003a30:	142027f3          	csrr	a5,scause
    80003a34:	00000513          	li	a0,0
    80003a38:	0007c463          	bltz	a5,80003a40 <devintr+0x10>
    80003a3c:	00008067          	ret
    80003a40:	fe010113          	addi	sp,sp,-32
    80003a44:	00813823          	sd	s0,16(sp)
    80003a48:	00113c23          	sd	ra,24(sp)
    80003a4c:	00913423          	sd	s1,8(sp)
    80003a50:	02010413          	addi	s0,sp,32
    80003a54:	0ff7f713          	andi	a4,a5,255
    80003a58:	00900693          	li	a3,9
    80003a5c:	04d70c63          	beq	a4,a3,80003ab4 <devintr+0x84>
    80003a60:	fff00713          	li	a4,-1
    80003a64:	03f71713          	slli	a4,a4,0x3f
    80003a68:	00170713          	addi	a4,a4,1
    80003a6c:	00e78c63          	beq	a5,a4,80003a84 <devintr+0x54>
    80003a70:	01813083          	ld	ra,24(sp)
    80003a74:	01013403          	ld	s0,16(sp)
    80003a78:	00813483          	ld	s1,8(sp)
    80003a7c:	02010113          	addi	sp,sp,32
    80003a80:	00008067          	ret
    80003a84:	00000097          	auipc	ra,0x0
    80003a88:	c8c080e7          	jalr	-884(ra) # 80003710 <cpuid>
    80003a8c:	06050663          	beqz	a0,80003af8 <devintr+0xc8>
    80003a90:	144027f3          	csrr	a5,sip
    80003a94:	ffd7f793          	andi	a5,a5,-3
    80003a98:	14479073          	csrw	sip,a5
    80003a9c:	01813083          	ld	ra,24(sp)
    80003aa0:	01013403          	ld	s0,16(sp)
    80003aa4:	00813483          	ld	s1,8(sp)
    80003aa8:	00200513          	li	a0,2
    80003aac:	02010113          	addi	sp,sp,32
    80003ab0:	00008067          	ret
    80003ab4:	00000097          	auipc	ra,0x0
    80003ab8:	250080e7          	jalr	592(ra) # 80003d04 <plic_claim>
    80003abc:	00a00793          	li	a5,10
    80003ac0:	00050493          	mv	s1,a0
    80003ac4:	06f50663          	beq	a0,a5,80003b30 <devintr+0x100>
    80003ac8:	00100513          	li	a0,1
    80003acc:	fa0482e3          	beqz	s1,80003a70 <devintr+0x40>
    80003ad0:	00048593          	mv	a1,s1
    80003ad4:	00002517          	auipc	a0,0x2
    80003ad8:	61c50513          	addi	a0,a0,1564 # 800060f0 <CONSOLE_STATUS+0xe0>
    80003adc:	00000097          	auipc	ra,0x0
    80003ae0:	66c080e7          	jalr	1644(ra) # 80004148 <__printf>
    80003ae4:	00048513          	mv	a0,s1
    80003ae8:	00000097          	auipc	ra,0x0
    80003aec:	254080e7          	jalr	596(ra) # 80003d3c <plic_complete>
    80003af0:	00100513          	li	a0,1
    80003af4:	f7dff06f          	j	80003a70 <devintr+0x40>
    80003af8:	00005517          	auipc	a0,0x5
    80003afc:	9f850513          	addi	a0,a0,-1544 # 800084f0 <tickslock>
    80003b00:	00001097          	auipc	ra,0x1
    80003b04:	31c080e7          	jalr	796(ra) # 80004e1c <acquire>
    80003b08:	00003717          	auipc	a4,0x3
    80003b0c:	65c70713          	addi	a4,a4,1628 # 80007164 <ticks>
    80003b10:	00072783          	lw	a5,0(a4)
    80003b14:	00005517          	auipc	a0,0x5
    80003b18:	9dc50513          	addi	a0,a0,-1572 # 800084f0 <tickslock>
    80003b1c:	0017879b          	addiw	a5,a5,1
    80003b20:	00f72023          	sw	a5,0(a4)
    80003b24:	00001097          	auipc	ra,0x1
    80003b28:	3c4080e7          	jalr	964(ra) # 80004ee8 <release>
    80003b2c:	f65ff06f          	j	80003a90 <devintr+0x60>
    80003b30:	00001097          	auipc	ra,0x1
    80003b34:	f20080e7          	jalr	-224(ra) # 80004a50 <uartintr>
    80003b38:	fadff06f          	j	80003ae4 <devintr+0xb4>
    80003b3c:	0000                	unimp
	...

0000000080003b40 <kernelvec>:
    80003b40:	f0010113          	addi	sp,sp,-256
    80003b44:	00113023          	sd	ra,0(sp)
    80003b48:	00213423          	sd	sp,8(sp)
    80003b4c:	00313823          	sd	gp,16(sp)
    80003b50:	00413c23          	sd	tp,24(sp)
    80003b54:	02513023          	sd	t0,32(sp)
    80003b58:	02613423          	sd	t1,40(sp)
    80003b5c:	02713823          	sd	t2,48(sp)
    80003b60:	02813c23          	sd	s0,56(sp)
    80003b64:	04913023          	sd	s1,64(sp)
    80003b68:	04a13423          	sd	a0,72(sp)
    80003b6c:	04b13823          	sd	a1,80(sp)
    80003b70:	04c13c23          	sd	a2,88(sp)
    80003b74:	06d13023          	sd	a3,96(sp)
    80003b78:	06e13423          	sd	a4,104(sp)
    80003b7c:	06f13823          	sd	a5,112(sp)
    80003b80:	07013c23          	sd	a6,120(sp)
    80003b84:	09113023          	sd	a7,128(sp)
    80003b88:	09213423          	sd	s2,136(sp)
    80003b8c:	09313823          	sd	s3,144(sp)
    80003b90:	09413c23          	sd	s4,152(sp)
    80003b94:	0b513023          	sd	s5,160(sp)
    80003b98:	0b613423          	sd	s6,168(sp)
    80003b9c:	0b713823          	sd	s7,176(sp)
    80003ba0:	0b813c23          	sd	s8,184(sp)
    80003ba4:	0d913023          	sd	s9,192(sp)
    80003ba8:	0da13423          	sd	s10,200(sp)
    80003bac:	0db13823          	sd	s11,208(sp)
    80003bb0:	0dc13c23          	sd	t3,216(sp)
    80003bb4:	0fd13023          	sd	t4,224(sp)
    80003bb8:	0fe13423          	sd	t5,232(sp)
    80003bbc:	0ff13823          	sd	t6,240(sp)
    80003bc0:	cd1ff0ef          	jal	ra,80003890 <kerneltrap>
    80003bc4:	00013083          	ld	ra,0(sp)
    80003bc8:	00813103          	ld	sp,8(sp)
    80003bcc:	01013183          	ld	gp,16(sp)
    80003bd0:	02013283          	ld	t0,32(sp)
    80003bd4:	02813303          	ld	t1,40(sp)
    80003bd8:	03013383          	ld	t2,48(sp)
    80003bdc:	03813403          	ld	s0,56(sp)
    80003be0:	04013483          	ld	s1,64(sp)
    80003be4:	04813503          	ld	a0,72(sp)
    80003be8:	05013583          	ld	a1,80(sp)
    80003bec:	05813603          	ld	a2,88(sp)
    80003bf0:	06013683          	ld	a3,96(sp)
    80003bf4:	06813703          	ld	a4,104(sp)
    80003bf8:	07013783          	ld	a5,112(sp)
    80003bfc:	07813803          	ld	a6,120(sp)
    80003c00:	08013883          	ld	a7,128(sp)
    80003c04:	08813903          	ld	s2,136(sp)
    80003c08:	09013983          	ld	s3,144(sp)
    80003c0c:	09813a03          	ld	s4,152(sp)
    80003c10:	0a013a83          	ld	s5,160(sp)
    80003c14:	0a813b03          	ld	s6,168(sp)
    80003c18:	0b013b83          	ld	s7,176(sp)
    80003c1c:	0b813c03          	ld	s8,184(sp)
    80003c20:	0c013c83          	ld	s9,192(sp)
    80003c24:	0c813d03          	ld	s10,200(sp)
    80003c28:	0d013d83          	ld	s11,208(sp)
    80003c2c:	0d813e03          	ld	t3,216(sp)
    80003c30:	0e013e83          	ld	t4,224(sp)
    80003c34:	0e813f03          	ld	t5,232(sp)
    80003c38:	0f013f83          	ld	t6,240(sp)
    80003c3c:	10010113          	addi	sp,sp,256
    80003c40:	10200073          	sret
    80003c44:	00000013          	nop
    80003c48:	00000013          	nop
    80003c4c:	00000013          	nop

0000000080003c50 <timervec>:
    80003c50:	34051573          	csrrw	a0,mscratch,a0
    80003c54:	00b53023          	sd	a1,0(a0)
    80003c58:	00c53423          	sd	a2,8(a0)
    80003c5c:	00d53823          	sd	a3,16(a0)
    80003c60:	01853583          	ld	a1,24(a0)
    80003c64:	02053603          	ld	a2,32(a0)
    80003c68:	0005b683          	ld	a3,0(a1)
    80003c6c:	00c686b3          	add	a3,a3,a2
    80003c70:	00d5b023          	sd	a3,0(a1)
    80003c74:	00200593          	li	a1,2
    80003c78:	14459073          	csrw	sip,a1
    80003c7c:	01053683          	ld	a3,16(a0)
    80003c80:	00853603          	ld	a2,8(a0)
    80003c84:	00053583          	ld	a1,0(a0)
    80003c88:	34051573          	csrrw	a0,mscratch,a0
    80003c8c:	30200073          	mret

0000000080003c90 <plicinit>:
    80003c90:	ff010113          	addi	sp,sp,-16
    80003c94:	00813423          	sd	s0,8(sp)
    80003c98:	01010413          	addi	s0,sp,16
    80003c9c:	00813403          	ld	s0,8(sp)
    80003ca0:	0c0007b7          	lui	a5,0xc000
    80003ca4:	00100713          	li	a4,1
    80003ca8:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    80003cac:	00e7a223          	sw	a4,4(a5)
    80003cb0:	01010113          	addi	sp,sp,16
    80003cb4:	00008067          	ret

0000000080003cb8 <plicinithart>:
    80003cb8:	ff010113          	addi	sp,sp,-16
    80003cbc:	00813023          	sd	s0,0(sp)
    80003cc0:	00113423          	sd	ra,8(sp)
    80003cc4:	01010413          	addi	s0,sp,16
    80003cc8:	00000097          	auipc	ra,0x0
    80003ccc:	a48080e7          	jalr	-1464(ra) # 80003710 <cpuid>
    80003cd0:	0085171b          	slliw	a4,a0,0x8
    80003cd4:	0c0027b7          	lui	a5,0xc002
    80003cd8:	00e787b3          	add	a5,a5,a4
    80003cdc:	40200713          	li	a4,1026
    80003ce0:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80003ce4:	00813083          	ld	ra,8(sp)
    80003ce8:	00013403          	ld	s0,0(sp)
    80003cec:	00d5151b          	slliw	a0,a0,0xd
    80003cf0:	0c2017b7          	lui	a5,0xc201
    80003cf4:	00a78533          	add	a0,a5,a0
    80003cf8:	00052023          	sw	zero,0(a0)
    80003cfc:	01010113          	addi	sp,sp,16
    80003d00:	00008067          	ret

0000000080003d04 <plic_claim>:
    80003d04:	ff010113          	addi	sp,sp,-16
    80003d08:	00813023          	sd	s0,0(sp)
    80003d0c:	00113423          	sd	ra,8(sp)
    80003d10:	01010413          	addi	s0,sp,16
    80003d14:	00000097          	auipc	ra,0x0
    80003d18:	9fc080e7          	jalr	-1540(ra) # 80003710 <cpuid>
    80003d1c:	00813083          	ld	ra,8(sp)
    80003d20:	00013403          	ld	s0,0(sp)
    80003d24:	00d5151b          	slliw	a0,a0,0xd
    80003d28:	0c2017b7          	lui	a5,0xc201
    80003d2c:	00a78533          	add	a0,a5,a0
    80003d30:	00452503          	lw	a0,4(a0)
    80003d34:	01010113          	addi	sp,sp,16
    80003d38:	00008067          	ret

0000000080003d3c <plic_complete>:
    80003d3c:	fe010113          	addi	sp,sp,-32
    80003d40:	00813823          	sd	s0,16(sp)
    80003d44:	00913423          	sd	s1,8(sp)
    80003d48:	00113c23          	sd	ra,24(sp)
    80003d4c:	02010413          	addi	s0,sp,32
    80003d50:	00050493          	mv	s1,a0
    80003d54:	00000097          	auipc	ra,0x0
    80003d58:	9bc080e7          	jalr	-1604(ra) # 80003710 <cpuid>
    80003d5c:	01813083          	ld	ra,24(sp)
    80003d60:	01013403          	ld	s0,16(sp)
    80003d64:	00d5179b          	slliw	a5,a0,0xd
    80003d68:	0c201737          	lui	a4,0xc201
    80003d6c:	00f707b3          	add	a5,a4,a5
    80003d70:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80003d74:	00813483          	ld	s1,8(sp)
    80003d78:	02010113          	addi	sp,sp,32
    80003d7c:	00008067          	ret

0000000080003d80 <consolewrite>:
    80003d80:	fb010113          	addi	sp,sp,-80
    80003d84:	04813023          	sd	s0,64(sp)
    80003d88:	04113423          	sd	ra,72(sp)
    80003d8c:	02913c23          	sd	s1,56(sp)
    80003d90:	03213823          	sd	s2,48(sp)
    80003d94:	03313423          	sd	s3,40(sp)
    80003d98:	03413023          	sd	s4,32(sp)
    80003d9c:	01513c23          	sd	s5,24(sp)
    80003da0:	05010413          	addi	s0,sp,80
    80003da4:	06c05c63          	blez	a2,80003e1c <consolewrite+0x9c>
    80003da8:	00060993          	mv	s3,a2
    80003dac:	00050a13          	mv	s4,a0
    80003db0:	00058493          	mv	s1,a1
    80003db4:	00000913          	li	s2,0
    80003db8:	fff00a93          	li	s5,-1
    80003dbc:	01c0006f          	j	80003dd8 <consolewrite+0x58>
    80003dc0:	fbf44503          	lbu	a0,-65(s0)
    80003dc4:	0019091b          	addiw	s2,s2,1
    80003dc8:	00148493          	addi	s1,s1,1
    80003dcc:	00001097          	auipc	ra,0x1
    80003dd0:	a9c080e7          	jalr	-1380(ra) # 80004868 <uartputc>
    80003dd4:	03298063          	beq	s3,s2,80003df4 <consolewrite+0x74>
    80003dd8:	00048613          	mv	a2,s1
    80003ddc:	00100693          	li	a3,1
    80003de0:	000a0593          	mv	a1,s4
    80003de4:	fbf40513          	addi	a0,s0,-65
    80003de8:	00000097          	auipc	ra,0x0
    80003dec:	9e0080e7          	jalr	-1568(ra) # 800037c8 <either_copyin>
    80003df0:	fd5518e3          	bne	a0,s5,80003dc0 <consolewrite+0x40>
    80003df4:	04813083          	ld	ra,72(sp)
    80003df8:	04013403          	ld	s0,64(sp)
    80003dfc:	03813483          	ld	s1,56(sp)
    80003e00:	02813983          	ld	s3,40(sp)
    80003e04:	02013a03          	ld	s4,32(sp)
    80003e08:	01813a83          	ld	s5,24(sp)
    80003e0c:	00090513          	mv	a0,s2
    80003e10:	03013903          	ld	s2,48(sp)
    80003e14:	05010113          	addi	sp,sp,80
    80003e18:	00008067          	ret
    80003e1c:	00000913          	li	s2,0
    80003e20:	fd5ff06f          	j	80003df4 <consolewrite+0x74>

0000000080003e24 <consoleread>:
    80003e24:	f9010113          	addi	sp,sp,-112
    80003e28:	06813023          	sd	s0,96(sp)
    80003e2c:	04913c23          	sd	s1,88(sp)
    80003e30:	05213823          	sd	s2,80(sp)
    80003e34:	05313423          	sd	s3,72(sp)
    80003e38:	05413023          	sd	s4,64(sp)
    80003e3c:	03513c23          	sd	s5,56(sp)
    80003e40:	03613823          	sd	s6,48(sp)
    80003e44:	03713423          	sd	s7,40(sp)
    80003e48:	03813023          	sd	s8,32(sp)
    80003e4c:	06113423          	sd	ra,104(sp)
    80003e50:	01913c23          	sd	s9,24(sp)
    80003e54:	07010413          	addi	s0,sp,112
    80003e58:	00060b93          	mv	s7,a2
    80003e5c:	00050913          	mv	s2,a0
    80003e60:	00058c13          	mv	s8,a1
    80003e64:	00060b1b          	sext.w	s6,a2
    80003e68:	00004497          	auipc	s1,0x4
    80003e6c:	6a048493          	addi	s1,s1,1696 # 80008508 <cons>
    80003e70:	00400993          	li	s3,4
    80003e74:	fff00a13          	li	s4,-1
    80003e78:	00a00a93          	li	s5,10
    80003e7c:	05705e63          	blez	s7,80003ed8 <consoleread+0xb4>
    80003e80:	09c4a703          	lw	a4,156(s1)
    80003e84:	0984a783          	lw	a5,152(s1)
    80003e88:	0007071b          	sext.w	a4,a4
    80003e8c:	08e78463          	beq	a5,a4,80003f14 <consoleread+0xf0>
    80003e90:	07f7f713          	andi	a4,a5,127
    80003e94:	00e48733          	add	a4,s1,a4
    80003e98:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    80003e9c:	0017869b          	addiw	a3,a5,1
    80003ea0:	08d4ac23          	sw	a3,152(s1)
    80003ea4:	00070c9b          	sext.w	s9,a4
    80003ea8:	0b370663          	beq	a4,s3,80003f54 <consoleread+0x130>
    80003eac:	00100693          	li	a3,1
    80003eb0:	f9f40613          	addi	a2,s0,-97
    80003eb4:	000c0593          	mv	a1,s8
    80003eb8:	00090513          	mv	a0,s2
    80003ebc:	f8e40fa3          	sb	a4,-97(s0)
    80003ec0:	00000097          	auipc	ra,0x0
    80003ec4:	8bc080e7          	jalr	-1860(ra) # 8000377c <either_copyout>
    80003ec8:	01450863          	beq	a0,s4,80003ed8 <consoleread+0xb4>
    80003ecc:	001c0c13          	addi	s8,s8,1
    80003ed0:	fffb8b9b          	addiw	s7,s7,-1
    80003ed4:	fb5c94e3          	bne	s9,s5,80003e7c <consoleread+0x58>
    80003ed8:	000b851b          	sext.w	a0,s7
    80003edc:	06813083          	ld	ra,104(sp)
    80003ee0:	06013403          	ld	s0,96(sp)
    80003ee4:	05813483          	ld	s1,88(sp)
    80003ee8:	05013903          	ld	s2,80(sp)
    80003eec:	04813983          	ld	s3,72(sp)
    80003ef0:	04013a03          	ld	s4,64(sp)
    80003ef4:	03813a83          	ld	s5,56(sp)
    80003ef8:	02813b83          	ld	s7,40(sp)
    80003efc:	02013c03          	ld	s8,32(sp)
    80003f00:	01813c83          	ld	s9,24(sp)
    80003f04:	40ab053b          	subw	a0,s6,a0
    80003f08:	03013b03          	ld	s6,48(sp)
    80003f0c:	07010113          	addi	sp,sp,112
    80003f10:	00008067          	ret
    80003f14:	00001097          	auipc	ra,0x1
    80003f18:	1d8080e7          	jalr	472(ra) # 800050ec <push_on>
    80003f1c:	0984a703          	lw	a4,152(s1)
    80003f20:	09c4a783          	lw	a5,156(s1)
    80003f24:	0007879b          	sext.w	a5,a5
    80003f28:	fef70ce3          	beq	a4,a5,80003f20 <consoleread+0xfc>
    80003f2c:	00001097          	auipc	ra,0x1
    80003f30:	234080e7          	jalr	564(ra) # 80005160 <pop_on>
    80003f34:	0984a783          	lw	a5,152(s1)
    80003f38:	07f7f713          	andi	a4,a5,127
    80003f3c:	00e48733          	add	a4,s1,a4
    80003f40:	01874703          	lbu	a4,24(a4)
    80003f44:	0017869b          	addiw	a3,a5,1
    80003f48:	08d4ac23          	sw	a3,152(s1)
    80003f4c:	00070c9b          	sext.w	s9,a4
    80003f50:	f5371ee3          	bne	a4,s3,80003eac <consoleread+0x88>
    80003f54:	000b851b          	sext.w	a0,s7
    80003f58:	f96bf2e3          	bgeu	s7,s6,80003edc <consoleread+0xb8>
    80003f5c:	08f4ac23          	sw	a5,152(s1)
    80003f60:	f7dff06f          	j	80003edc <consoleread+0xb8>

0000000080003f64 <consputc>:
    80003f64:	10000793          	li	a5,256
    80003f68:	00f50663          	beq	a0,a5,80003f74 <consputc+0x10>
    80003f6c:	00001317          	auipc	t1,0x1
    80003f70:	9f430067          	jr	-1548(t1) # 80004960 <uartputc_sync>
    80003f74:	ff010113          	addi	sp,sp,-16
    80003f78:	00113423          	sd	ra,8(sp)
    80003f7c:	00813023          	sd	s0,0(sp)
    80003f80:	01010413          	addi	s0,sp,16
    80003f84:	00800513          	li	a0,8
    80003f88:	00001097          	auipc	ra,0x1
    80003f8c:	9d8080e7          	jalr	-1576(ra) # 80004960 <uartputc_sync>
    80003f90:	02000513          	li	a0,32
    80003f94:	00001097          	auipc	ra,0x1
    80003f98:	9cc080e7          	jalr	-1588(ra) # 80004960 <uartputc_sync>
    80003f9c:	00013403          	ld	s0,0(sp)
    80003fa0:	00813083          	ld	ra,8(sp)
    80003fa4:	00800513          	li	a0,8
    80003fa8:	01010113          	addi	sp,sp,16
    80003fac:	00001317          	auipc	t1,0x1
    80003fb0:	9b430067          	jr	-1612(t1) # 80004960 <uartputc_sync>

0000000080003fb4 <consoleintr>:
    80003fb4:	fe010113          	addi	sp,sp,-32
    80003fb8:	00813823          	sd	s0,16(sp)
    80003fbc:	00913423          	sd	s1,8(sp)
    80003fc0:	01213023          	sd	s2,0(sp)
    80003fc4:	00113c23          	sd	ra,24(sp)
    80003fc8:	02010413          	addi	s0,sp,32
    80003fcc:	00004917          	auipc	s2,0x4
    80003fd0:	53c90913          	addi	s2,s2,1340 # 80008508 <cons>
    80003fd4:	00050493          	mv	s1,a0
    80003fd8:	00090513          	mv	a0,s2
    80003fdc:	00001097          	auipc	ra,0x1
    80003fe0:	e40080e7          	jalr	-448(ra) # 80004e1c <acquire>
    80003fe4:	02048c63          	beqz	s1,8000401c <consoleintr+0x68>
    80003fe8:	0a092783          	lw	a5,160(s2)
    80003fec:	09892703          	lw	a4,152(s2)
    80003ff0:	07f00693          	li	a3,127
    80003ff4:	40e7873b          	subw	a4,a5,a4
    80003ff8:	02e6e263          	bltu	a3,a4,8000401c <consoleintr+0x68>
    80003ffc:	00d00713          	li	a4,13
    80004000:	04e48063          	beq	s1,a4,80004040 <consoleintr+0x8c>
    80004004:	07f7f713          	andi	a4,a5,127
    80004008:	00e90733          	add	a4,s2,a4
    8000400c:	0017879b          	addiw	a5,a5,1
    80004010:	0af92023          	sw	a5,160(s2)
    80004014:	00970c23          	sb	s1,24(a4)
    80004018:	08f92e23          	sw	a5,156(s2)
    8000401c:	01013403          	ld	s0,16(sp)
    80004020:	01813083          	ld	ra,24(sp)
    80004024:	00813483          	ld	s1,8(sp)
    80004028:	00013903          	ld	s2,0(sp)
    8000402c:	00004517          	auipc	a0,0x4
    80004030:	4dc50513          	addi	a0,a0,1244 # 80008508 <cons>
    80004034:	02010113          	addi	sp,sp,32
    80004038:	00001317          	auipc	t1,0x1
    8000403c:	eb030067          	jr	-336(t1) # 80004ee8 <release>
    80004040:	00a00493          	li	s1,10
    80004044:	fc1ff06f          	j	80004004 <consoleintr+0x50>

0000000080004048 <consoleinit>:
    80004048:	fe010113          	addi	sp,sp,-32
    8000404c:	00113c23          	sd	ra,24(sp)
    80004050:	00813823          	sd	s0,16(sp)
    80004054:	00913423          	sd	s1,8(sp)
    80004058:	02010413          	addi	s0,sp,32
    8000405c:	00004497          	auipc	s1,0x4
    80004060:	4ac48493          	addi	s1,s1,1196 # 80008508 <cons>
    80004064:	00048513          	mv	a0,s1
    80004068:	00002597          	auipc	a1,0x2
    8000406c:	0e058593          	addi	a1,a1,224 # 80006148 <CONSOLE_STATUS+0x138>
    80004070:	00001097          	auipc	ra,0x1
    80004074:	d88080e7          	jalr	-632(ra) # 80004df8 <initlock>
    80004078:	00000097          	auipc	ra,0x0
    8000407c:	7ac080e7          	jalr	1964(ra) # 80004824 <uartinit>
    80004080:	01813083          	ld	ra,24(sp)
    80004084:	01013403          	ld	s0,16(sp)
    80004088:	00000797          	auipc	a5,0x0
    8000408c:	d9c78793          	addi	a5,a5,-612 # 80003e24 <consoleread>
    80004090:	0af4bc23          	sd	a5,184(s1)
    80004094:	00000797          	auipc	a5,0x0
    80004098:	cec78793          	addi	a5,a5,-788 # 80003d80 <consolewrite>
    8000409c:	0cf4b023          	sd	a5,192(s1)
    800040a0:	00813483          	ld	s1,8(sp)
    800040a4:	02010113          	addi	sp,sp,32
    800040a8:	00008067          	ret

00000000800040ac <console_read>:
    800040ac:	ff010113          	addi	sp,sp,-16
    800040b0:	00813423          	sd	s0,8(sp)
    800040b4:	01010413          	addi	s0,sp,16
    800040b8:	00813403          	ld	s0,8(sp)
    800040bc:	00004317          	auipc	t1,0x4
    800040c0:	50433303          	ld	t1,1284(t1) # 800085c0 <devsw+0x10>
    800040c4:	01010113          	addi	sp,sp,16
    800040c8:	00030067          	jr	t1

00000000800040cc <console_write>:
    800040cc:	ff010113          	addi	sp,sp,-16
    800040d0:	00813423          	sd	s0,8(sp)
    800040d4:	01010413          	addi	s0,sp,16
    800040d8:	00813403          	ld	s0,8(sp)
    800040dc:	00004317          	auipc	t1,0x4
    800040e0:	4ec33303          	ld	t1,1260(t1) # 800085c8 <devsw+0x18>
    800040e4:	01010113          	addi	sp,sp,16
    800040e8:	00030067          	jr	t1

00000000800040ec <panic>:
    800040ec:	fe010113          	addi	sp,sp,-32
    800040f0:	00113c23          	sd	ra,24(sp)
    800040f4:	00813823          	sd	s0,16(sp)
    800040f8:	00913423          	sd	s1,8(sp)
    800040fc:	02010413          	addi	s0,sp,32
    80004100:	00050493          	mv	s1,a0
    80004104:	00002517          	auipc	a0,0x2
    80004108:	04c50513          	addi	a0,a0,76 # 80006150 <CONSOLE_STATUS+0x140>
    8000410c:	00004797          	auipc	a5,0x4
    80004110:	5407ae23          	sw	zero,1372(a5) # 80008668 <pr+0x18>
    80004114:	00000097          	auipc	ra,0x0
    80004118:	034080e7          	jalr	52(ra) # 80004148 <__printf>
    8000411c:	00048513          	mv	a0,s1
    80004120:	00000097          	auipc	ra,0x0
    80004124:	028080e7          	jalr	40(ra) # 80004148 <__printf>
    80004128:	00002517          	auipc	a0,0x2
    8000412c:	00850513          	addi	a0,a0,8 # 80006130 <CONSOLE_STATUS+0x120>
    80004130:	00000097          	auipc	ra,0x0
    80004134:	018080e7          	jalr	24(ra) # 80004148 <__printf>
    80004138:	00100793          	li	a5,1
    8000413c:	00003717          	auipc	a4,0x3
    80004140:	02f72623          	sw	a5,44(a4) # 80007168 <panicked>
    80004144:	0000006f          	j	80004144 <panic+0x58>

0000000080004148 <__printf>:
    80004148:	f3010113          	addi	sp,sp,-208
    8000414c:	08813023          	sd	s0,128(sp)
    80004150:	07313423          	sd	s3,104(sp)
    80004154:	09010413          	addi	s0,sp,144
    80004158:	05813023          	sd	s8,64(sp)
    8000415c:	08113423          	sd	ra,136(sp)
    80004160:	06913c23          	sd	s1,120(sp)
    80004164:	07213823          	sd	s2,112(sp)
    80004168:	07413023          	sd	s4,96(sp)
    8000416c:	05513c23          	sd	s5,88(sp)
    80004170:	05613823          	sd	s6,80(sp)
    80004174:	05713423          	sd	s7,72(sp)
    80004178:	03913c23          	sd	s9,56(sp)
    8000417c:	03a13823          	sd	s10,48(sp)
    80004180:	03b13423          	sd	s11,40(sp)
    80004184:	00004317          	auipc	t1,0x4
    80004188:	4cc30313          	addi	t1,t1,1228 # 80008650 <pr>
    8000418c:	01832c03          	lw	s8,24(t1)
    80004190:	00b43423          	sd	a1,8(s0)
    80004194:	00c43823          	sd	a2,16(s0)
    80004198:	00d43c23          	sd	a3,24(s0)
    8000419c:	02e43023          	sd	a4,32(s0)
    800041a0:	02f43423          	sd	a5,40(s0)
    800041a4:	03043823          	sd	a6,48(s0)
    800041a8:	03143c23          	sd	a7,56(s0)
    800041ac:	00050993          	mv	s3,a0
    800041b0:	4a0c1663          	bnez	s8,8000465c <__printf+0x514>
    800041b4:	60098c63          	beqz	s3,800047cc <__printf+0x684>
    800041b8:	0009c503          	lbu	a0,0(s3)
    800041bc:	00840793          	addi	a5,s0,8
    800041c0:	f6f43c23          	sd	a5,-136(s0)
    800041c4:	00000493          	li	s1,0
    800041c8:	22050063          	beqz	a0,800043e8 <__printf+0x2a0>
    800041cc:	00002a37          	lui	s4,0x2
    800041d0:	00018ab7          	lui	s5,0x18
    800041d4:	000f4b37          	lui	s6,0xf4
    800041d8:	00989bb7          	lui	s7,0x989
    800041dc:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    800041e0:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    800041e4:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    800041e8:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    800041ec:	00148c9b          	addiw	s9,s1,1
    800041f0:	02500793          	li	a5,37
    800041f4:	01998933          	add	s2,s3,s9
    800041f8:	38f51263          	bne	a0,a5,8000457c <__printf+0x434>
    800041fc:	00094783          	lbu	a5,0(s2)
    80004200:	00078c9b          	sext.w	s9,a5
    80004204:	1e078263          	beqz	a5,800043e8 <__printf+0x2a0>
    80004208:	0024849b          	addiw	s1,s1,2
    8000420c:	07000713          	li	a4,112
    80004210:	00998933          	add	s2,s3,s1
    80004214:	38e78a63          	beq	a5,a4,800045a8 <__printf+0x460>
    80004218:	20f76863          	bltu	a4,a5,80004428 <__printf+0x2e0>
    8000421c:	42a78863          	beq	a5,a0,8000464c <__printf+0x504>
    80004220:	06400713          	li	a4,100
    80004224:	40e79663          	bne	a5,a4,80004630 <__printf+0x4e8>
    80004228:	f7843783          	ld	a5,-136(s0)
    8000422c:	0007a603          	lw	a2,0(a5)
    80004230:	00878793          	addi	a5,a5,8
    80004234:	f6f43c23          	sd	a5,-136(s0)
    80004238:	42064a63          	bltz	a2,8000466c <__printf+0x524>
    8000423c:	00a00713          	li	a4,10
    80004240:	02e677bb          	remuw	a5,a2,a4
    80004244:	00002d97          	auipc	s11,0x2
    80004248:	f34d8d93          	addi	s11,s11,-204 # 80006178 <digits>
    8000424c:	00900593          	li	a1,9
    80004250:	0006051b          	sext.w	a0,a2
    80004254:	00000c93          	li	s9,0
    80004258:	02079793          	slli	a5,a5,0x20
    8000425c:	0207d793          	srli	a5,a5,0x20
    80004260:	00fd87b3          	add	a5,s11,a5
    80004264:	0007c783          	lbu	a5,0(a5)
    80004268:	02e656bb          	divuw	a3,a2,a4
    8000426c:	f8f40023          	sb	a5,-128(s0)
    80004270:	14c5d863          	bge	a1,a2,800043c0 <__printf+0x278>
    80004274:	06300593          	li	a1,99
    80004278:	00100c93          	li	s9,1
    8000427c:	02e6f7bb          	remuw	a5,a3,a4
    80004280:	02079793          	slli	a5,a5,0x20
    80004284:	0207d793          	srli	a5,a5,0x20
    80004288:	00fd87b3          	add	a5,s11,a5
    8000428c:	0007c783          	lbu	a5,0(a5)
    80004290:	02e6d73b          	divuw	a4,a3,a4
    80004294:	f8f400a3          	sb	a5,-127(s0)
    80004298:	12a5f463          	bgeu	a1,a0,800043c0 <__printf+0x278>
    8000429c:	00a00693          	li	a3,10
    800042a0:	00900593          	li	a1,9
    800042a4:	02d777bb          	remuw	a5,a4,a3
    800042a8:	02079793          	slli	a5,a5,0x20
    800042ac:	0207d793          	srli	a5,a5,0x20
    800042b0:	00fd87b3          	add	a5,s11,a5
    800042b4:	0007c503          	lbu	a0,0(a5)
    800042b8:	02d757bb          	divuw	a5,a4,a3
    800042bc:	f8a40123          	sb	a0,-126(s0)
    800042c0:	48e5f263          	bgeu	a1,a4,80004744 <__printf+0x5fc>
    800042c4:	06300513          	li	a0,99
    800042c8:	02d7f5bb          	remuw	a1,a5,a3
    800042cc:	02059593          	slli	a1,a1,0x20
    800042d0:	0205d593          	srli	a1,a1,0x20
    800042d4:	00bd85b3          	add	a1,s11,a1
    800042d8:	0005c583          	lbu	a1,0(a1)
    800042dc:	02d7d7bb          	divuw	a5,a5,a3
    800042e0:	f8b401a3          	sb	a1,-125(s0)
    800042e4:	48e57263          	bgeu	a0,a4,80004768 <__printf+0x620>
    800042e8:	3e700513          	li	a0,999
    800042ec:	02d7f5bb          	remuw	a1,a5,a3
    800042f0:	02059593          	slli	a1,a1,0x20
    800042f4:	0205d593          	srli	a1,a1,0x20
    800042f8:	00bd85b3          	add	a1,s11,a1
    800042fc:	0005c583          	lbu	a1,0(a1)
    80004300:	02d7d7bb          	divuw	a5,a5,a3
    80004304:	f8b40223          	sb	a1,-124(s0)
    80004308:	46e57663          	bgeu	a0,a4,80004774 <__printf+0x62c>
    8000430c:	02d7f5bb          	remuw	a1,a5,a3
    80004310:	02059593          	slli	a1,a1,0x20
    80004314:	0205d593          	srli	a1,a1,0x20
    80004318:	00bd85b3          	add	a1,s11,a1
    8000431c:	0005c583          	lbu	a1,0(a1)
    80004320:	02d7d7bb          	divuw	a5,a5,a3
    80004324:	f8b402a3          	sb	a1,-123(s0)
    80004328:	46ea7863          	bgeu	s4,a4,80004798 <__printf+0x650>
    8000432c:	02d7f5bb          	remuw	a1,a5,a3
    80004330:	02059593          	slli	a1,a1,0x20
    80004334:	0205d593          	srli	a1,a1,0x20
    80004338:	00bd85b3          	add	a1,s11,a1
    8000433c:	0005c583          	lbu	a1,0(a1)
    80004340:	02d7d7bb          	divuw	a5,a5,a3
    80004344:	f8b40323          	sb	a1,-122(s0)
    80004348:	3eeaf863          	bgeu	s5,a4,80004738 <__printf+0x5f0>
    8000434c:	02d7f5bb          	remuw	a1,a5,a3
    80004350:	02059593          	slli	a1,a1,0x20
    80004354:	0205d593          	srli	a1,a1,0x20
    80004358:	00bd85b3          	add	a1,s11,a1
    8000435c:	0005c583          	lbu	a1,0(a1)
    80004360:	02d7d7bb          	divuw	a5,a5,a3
    80004364:	f8b403a3          	sb	a1,-121(s0)
    80004368:	42eb7e63          	bgeu	s6,a4,800047a4 <__printf+0x65c>
    8000436c:	02d7f5bb          	remuw	a1,a5,a3
    80004370:	02059593          	slli	a1,a1,0x20
    80004374:	0205d593          	srli	a1,a1,0x20
    80004378:	00bd85b3          	add	a1,s11,a1
    8000437c:	0005c583          	lbu	a1,0(a1)
    80004380:	02d7d7bb          	divuw	a5,a5,a3
    80004384:	f8b40423          	sb	a1,-120(s0)
    80004388:	42ebfc63          	bgeu	s7,a4,800047c0 <__printf+0x678>
    8000438c:	02079793          	slli	a5,a5,0x20
    80004390:	0207d793          	srli	a5,a5,0x20
    80004394:	00fd8db3          	add	s11,s11,a5
    80004398:	000dc703          	lbu	a4,0(s11)
    8000439c:	00a00793          	li	a5,10
    800043a0:	00900c93          	li	s9,9
    800043a4:	f8e404a3          	sb	a4,-119(s0)
    800043a8:	00065c63          	bgez	a2,800043c0 <__printf+0x278>
    800043ac:	f9040713          	addi	a4,s0,-112
    800043b0:	00f70733          	add	a4,a4,a5
    800043b4:	02d00693          	li	a3,45
    800043b8:	fed70823          	sb	a3,-16(a4)
    800043bc:	00078c93          	mv	s9,a5
    800043c0:	f8040793          	addi	a5,s0,-128
    800043c4:	01978cb3          	add	s9,a5,s9
    800043c8:	f7f40d13          	addi	s10,s0,-129
    800043cc:	000cc503          	lbu	a0,0(s9)
    800043d0:	fffc8c93          	addi	s9,s9,-1
    800043d4:	00000097          	auipc	ra,0x0
    800043d8:	b90080e7          	jalr	-1136(ra) # 80003f64 <consputc>
    800043dc:	ffac98e3          	bne	s9,s10,800043cc <__printf+0x284>
    800043e0:	00094503          	lbu	a0,0(s2)
    800043e4:	e00514e3          	bnez	a0,800041ec <__printf+0xa4>
    800043e8:	1a0c1663          	bnez	s8,80004594 <__printf+0x44c>
    800043ec:	08813083          	ld	ra,136(sp)
    800043f0:	08013403          	ld	s0,128(sp)
    800043f4:	07813483          	ld	s1,120(sp)
    800043f8:	07013903          	ld	s2,112(sp)
    800043fc:	06813983          	ld	s3,104(sp)
    80004400:	06013a03          	ld	s4,96(sp)
    80004404:	05813a83          	ld	s5,88(sp)
    80004408:	05013b03          	ld	s6,80(sp)
    8000440c:	04813b83          	ld	s7,72(sp)
    80004410:	04013c03          	ld	s8,64(sp)
    80004414:	03813c83          	ld	s9,56(sp)
    80004418:	03013d03          	ld	s10,48(sp)
    8000441c:	02813d83          	ld	s11,40(sp)
    80004420:	0d010113          	addi	sp,sp,208
    80004424:	00008067          	ret
    80004428:	07300713          	li	a4,115
    8000442c:	1ce78a63          	beq	a5,a4,80004600 <__printf+0x4b8>
    80004430:	07800713          	li	a4,120
    80004434:	1ee79e63          	bne	a5,a4,80004630 <__printf+0x4e8>
    80004438:	f7843783          	ld	a5,-136(s0)
    8000443c:	0007a703          	lw	a4,0(a5)
    80004440:	00878793          	addi	a5,a5,8
    80004444:	f6f43c23          	sd	a5,-136(s0)
    80004448:	28074263          	bltz	a4,800046cc <__printf+0x584>
    8000444c:	00002d97          	auipc	s11,0x2
    80004450:	d2cd8d93          	addi	s11,s11,-724 # 80006178 <digits>
    80004454:	00f77793          	andi	a5,a4,15
    80004458:	00fd87b3          	add	a5,s11,a5
    8000445c:	0007c683          	lbu	a3,0(a5)
    80004460:	00f00613          	li	a2,15
    80004464:	0007079b          	sext.w	a5,a4
    80004468:	f8d40023          	sb	a3,-128(s0)
    8000446c:	0047559b          	srliw	a1,a4,0x4
    80004470:	0047569b          	srliw	a3,a4,0x4
    80004474:	00000c93          	li	s9,0
    80004478:	0ee65063          	bge	a2,a4,80004558 <__printf+0x410>
    8000447c:	00f6f693          	andi	a3,a3,15
    80004480:	00dd86b3          	add	a3,s11,a3
    80004484:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80004488:	0087d79b          	srliw	a5,a5,0x8
    8000448c:	00100c93          	li	s9,1
    80004490:	f8d400a3          	sb	a3,-127(s0)
    80004494:	0cb67263          	bgeu	a2,a1,80004558 <__printf+0x410>
    80004498:	00f7f693          	andi	a3,a5,15
    8000449c:	00dd86b3          	add	a3,s11,a3
    800044a0:	0006c583          	lbu	a1,0(a3)
    800044a4:	00f00613          	li	a2,15
    800044a8:	0047d69b          	srliw	a3,a5,0x4
    800044ac:	f8b40123          	sb	a1,-126(s0)
    800044b0:	0047d593          	srli	a1,a5,0x4
    800044b4:	28f67e63          	bgeu	a2,a5,80004750 <__printf+0x608>
    800044b8:	00f6f693          	andi	a3,a3,15
    800044bc:	00dd86b3          	add	a3,s11,a3
    800044c0:	0006c503          	lbu	a0,0(a3)
    800044c4:	0087d813          	srli	a6,a5,0x8
    800044c8:	0087d69b          	srliw	a3,a5,0x8
    800044cc:	f8a401a3          	sb	a0,-125(s0)
    800044d0:	28b67663          	bgeu	a2,a1,8000475c <__printf+0x614>
    800044d4:	00f6f693          	andi	a3,a3,15
    800044d8:	00dd86b3          	add	a3,s11,a3
    800044dc:	0006c583          	lbu	a1,0(a3)
    800044e0:	00c7d513          	srli	a0,a5,0xc
    800044e4:	00c7d69b          	srliw	a3,a5,0xc
    800044e8:	f8b40223          	sb	a1,-124(s0)
    800044ec:	29067a63          	bgeu	a2,a6,80004780 <__printf+0x638>
    800044f0:	00f6f693          	andi	a3,a3,15
    800044f4:	00dd86b3          	add	a3,s11,a3
    800044f8:	0006c583          	lbu	a1,0(a3)
    800044fc:	0107d813          	srli	a6,a5,0x10
    80004500:	0107d69b          	srliw	a3,a5,0x10
    80004504:	f8b402a3          	sb	a1,-123(s0)
    80004508:	28a67263          	bgeu	a2,a0,8000478c <__printf+0x644>
    8000450c:	00f6f693          	andi	a3,a3,15
    80004510:	00dd86b3          	add	a3,s11,a3
    80004514:	0006c683          	lbu	a3,0(a3)
    80004518:	0147d79b          	srliw	a5,a5,0x14
    8000451c:	f8d40323          	sb	a3,-122(s0)
    80004520:	21067663          	bgeu	a2,a6,8000472c <__printf+0x5e4>
    80004524:	02079793          	slli	a5,a5,0x20
    80004528:	0207d793          	srli	a5,a5,0x20
    8000452c:	00fd8db3          	add	s11,s11,a5
    80004530:	000dc683          	lbu	a3,0(s11)
    80004534:	00800793          	li	a5,8
    80004538:	00700c93          	li	s9,7
    8000453c:	f8d403a3          	sb	a3,-121(s0)
    80004540:	00075c63          	bgez	a4,80004558 <__printf+0x410>
    80004544:	f9040713          	addi	a4,s0,-112
    80004548:	00f70733          	add	a4,a4,a5
    8000454c:	02d00693          	li	a3,45
    80004550:	fed70823          	sb	a3,-16(a4)
    80004554:	00078c93          	mv	s9,a5
    80004558:	f8040793          	addi	a5,s0,-128
    8000455c:	01978cb3          	add	s9,a5,s9
    80004560:	f7f40d13          	addi	s10,s0,-129
    80004564:	000cc503          	lbu	a0,0(s9)
    80004568:	fffc8c93          	addi	s9,s9,-1
    8000456c:	00000097          	auipc	ra,0x0
    80004570:	9f8080e7          	jalr	-1544(ra) # 80003f64 <consputc>
    80004574:	ff9d18e3          	bne	s10,s9,80004564 <__printf+0x41c>
    80004578:	0100006f          	j	80004588 <__printf+0x440>
    8000457c:	00000097          	auipc	ra,0x0
    80004580:	9e8080e7          	jalr	-1560(ra) # 80003f64 <consputc>
    80004584:	000c8493          	mv	s1,s9
    80004588:	00094503          	lbu	a0,0(s2)
    8000458c:	c60510e3          	bnez	a0,800041ec <__printf+0xa4>
    80004590:	e40c0ee3          	beqz	s8,800043ec <__printf+0x2a4>
    80004594:	00004517          	auipc	a0,0x4
    80004598:	0bc50513          	addi	a0,a0,188 # 80008650 <pr>
    8000459c:	00001097          	auipc	ra,0x1
    800045a0:	94c080e7          	jalr	-1716(ra) # 80004ee8 <release>
    800045a4:	e49ff06f          	j	800043ec <__printf+0x2a4>
    800045a8:	f7843783          	ld	a5,-136(s0)
    800045ac:	03000513          	li	a0,48
    800045b0:	01000d13          	li	s10,16
    800045b4:	00878713          	addi	a4,a5,8
    800045b8:	0007bc83          	ld	s9,0(a5)
    800045bc:	f6e43c23          	sd	a4,-136(s0)
    800045c0:	00000097          	auipc	ra,0x0
    800045c4:	9a4080e7          	jalr	-1628(ra) # 80003f64 <consputc>
    800045c8:	07800513          	li	a0,120
    800045cc:	00000097          	auipc	ra,0x0
    800045d0:	998080e7          	jalr	-1640(ra) # 80003f64 <consputc>
    800045d4:	00002d97          	auipc	s11,0x2
    800045d8:	ba4d8d93          	addi	s11,s11,-1116 # 80006178 <digits>
    800045dc:	03ccd793          	srli	a5,s9,0x3c
    800045e0:	00fd87b3          	add	a5,s11,a5
    800045e4:	0007c503          	lbu	a0,0(a5)
    800045e8:	fffd0d1b          	addiw	s10,s10,-1
    800045ec:	004c9c93          	slli	s9,s9,0x4
    800045f0:	00000097          	auipc	ra,0x0
    800045f4:	974080e7          	jalr	-1676(ra) # 80003f64 <consputc>
    800045f8:	fe0d12e3          	bnez	s10,800045dc <__printf+0x494>
    800045fc:	f8dff06f          	j	80004588 <__printf+0x440>
    80004600:	f7843783          	ld	a5,-136(s0)
    80004604:	0007bc83          	ld	s9,0(a5)
    80004608:	00878793          	addi	a5,a5,8
    8000460c:	f6f43c23          	sd	a5,-136(s0)
    80004610:	000c9a63          	bnez	s9,80004624 <__printf+0x4dc>
    80004614:	1080006f          	j	8000471c <__printf+0x5d4>
    80004618:	001c8c93          	addi	s9,s9,1
    8000461c:	00000097          	auipc	ra,0x0
    80004620:	948080e7          	jalr	-1720(ra) # 80003f64 <consputc>
    80004624:	000cc503          	lbu	a0,0(s9)
    80004628:	fe0518e3          	bnez	a0,80004618 <__printf+0x4d0>
    8000462c:	f5dff06f          	j	80004588 <__printf+0x440>
    80004630:	02500513          	li	a0,37
    80004634:	00000097          	auipc	ra,0x0
    80004638:	930080e7          	jalr	-1744(ra) # 80003f64 <consputc>
    8000463c:	000c8513          	mv	a0,s9
    80004640:	00000097          	auipc	ra,0x0
    80004644:	924080e7          	jalr	-1756(ra) # 80003f64 <consputc>
    80004648:	f41ff06f          	j	80004588 <__printf+0x440>
    8000464c:	02500513          	li	a0,37
    80004650:	00000097          	auipc	ra,0x0
    80004654:	914080e7          	jalr	-1772(ra) # 80003f64 <consputc>
    80004658:	f31ff06f          	j	80004588 <__printf+0x440>
    8000465c:	00030513          	mv	a0,t1
    80004660:	00000097          	auipc	ra,0x0
    80004664:	7bc080e7          	jalr	1980(ra) # 80004e1c <acquire>
    80004668:	b4dff06f          	j	800041b4 <__printf+0x6c>
    8000466c:	40c0053b          	negw	a0,a2
    80004670:	00a00713          	li	a4,10
    80004674:	02e576bb          	remuw	a3,a0,a4
    80004678:	00002d97          	auipc	s11,0x2
    8000467c:	b00d8d93          	addi	s11,s11,-1280 # 80006178 <digits>
    80004680:	ff700593          	li	a1,-9
    80004684:	02069693          	slli	a3,a3,0x20
    80004688:	0206d693          	srli	a3,a3,0x20
    8000468c:	00dd86b3          	add	a3,s11,a3
    80004690:	0006c683          	lbu	a3,0(a3)
    80004694:	02e557bb          	divuw	a5,a0,a4
    80004698:	f8d40023          	sb	a3,-128(s0)
    8000469c:	10b65e63          	bge	a2,a1,800047b8 <__printf+0x670>
    800046a0:	06300593          	li	a1,99
    800046a4:	02e7f6bb          	remuw	a3,a5,a4
    800046a8:	02069693          	slli	a3,a3,0x20
    800046ac:	0206d693          	srli	a3,a3,0x20
    800046b0:	00dd86b3          	add	a3,s11,a3
    800046b4:	0006c683          	lbu	a3,0(a3)
    800046b8:	02e7d73b          	divuw	a4,a5,a4
    800046bc:	00200793          	li	a5,2
    800046c0:	f8d400a3          	sb	a3,-127(s0)
    800046c4:	bca5ece3          	bltu	a1,a0,8000429c <__printf+0x154>
    800046c8:	ce5ff06f          	j	800043ac <__printf+0x264>
    800046cc:	40e007bb          	negw	a5,a4
    800046d0:	00002d97          	auipc	s11,0x2
    800046d4:	aa8d8d93          	addi	s11,s11,-1368 # 80006178 <digits>
    800046d8:	00f7f693          	andi	a3,a5,15
    800046dc:	00dd86b3          	add	a3,s11,a3
    800046e0:	0006c583          	lbu	a1,0(a3)
    800046e4:	ff100613          	li	a2,-15
    800046e8:	0047d69b          	srliw	a3,a5,0x4
    800046ec:	f8b40023          	sb	a1,-128(s0)
    800046f0:	0047d59b          	srliw	a1,a5,0x4
    800046f4:	0ac75e63          	bge	a4,a2,800047b0 <__printf+0x668>
    800046f8:	00f6f693          	andi	a3,a3,15
    800046fc:	00dd86b3          	add	a3,s11,a3
    80004700:	0006c603          	lbu	a2,0(a3)
    80004704:	00f00693          	li	a3,15
    80004708:	0087d79b          	srliw	a5,a5,0x8
    8000470c:	f8c400a3          	sb	a2,-127(s0)
    80004710:	d8b6e4e3          	bltu	a3,a1,80004498 <__printf+0x350>
    80004714:	00200793          	li	a5,2
    80004718:	e2dff06f          	j	80004544 <__printf+0x3fc>
    8000471c:	00002c97          	auipc	s9,0x2
    80004720:	a3cc8c93          	addi	s9,s9,-1476 # 80006158 <CONSOLE_STATUS+0x148>
    80004724:	02800513          	li	a0,40
    80004728:	ef1ff06f          	j	80004618 <__printf+0x4d0>
    8000472c:	00700793          	li	a5,7
    80004730:	00600c93          	li	s9,6
    80004734:	e0dff06f          	j	80004540 <__printf+0x3f8>
    80004738:	00700793          	li	a5,7
    8000473c:	00600c93          	li	s9,6
    80004740:	c69ff06f          	j	800043a8 <__printf+0x260>
    80004744:	00300793          	li	a5,3
    80004748:	00200c93          	li	s9,2
    8000474c:	c5dff06f          	j	800043a8 <__printf+0x260>
    80004750:	00300793          	li	a5,3
    80004754:	00200c93          	li	s9,2
    80004758:	de9ff06f          	j	80004540 <__printf+0x3f8>
    8000475c:	00400793          	li	a5,4
    80004760:	00300c93          	li	s9,3
    80004764:	dddff06f          	j	80004540 <__printf+0x3f8>
    80004768:	00400793          	li	a5,4
    8000476c:	00300c93          	li	s9,3
    80004770:	c39ff06f          	j	800043a8 <__printf+0x260>
    80004774:	00500793          	li	a5,5
    80004778:	00400c93          	li	s9,4
    8000477c:	c2dff06f          	j	800043a8 <__printf+0x260>
    80004780:	00500793          	li	a5,5
    80004784:	00400c93          	li	s9,4
    80004788:	db9ff06f          	j	80004540 <__printf+0x3f8>
    8000478c:	00600793          	li	a5,6
    80004790:	00500c93          	li	s9,5
    80004794:	dadff06f          	j	80004540 <__printf+0x3f8>
    80004798:	00600793          	li	a5,6
    8000479c:	00500c93          	li	s9,5
    800047a0:	c09ff06f          	j	800043a8 <__printf+0x260>
    800047a4:	00800793          	li	a5,8
    800047a8:	00700c93          	li	s9,7
    800047ac:	bfdff06f          	j	800043a8 <__printf+0x260>
    800047b0:	00100793          	li	a5,1
    800047b4:	d91ff06f          	j	80004544 <__printf+0x3fc>
    800047b8:	00100793          	li	a5,1
    800047bc:	bf1ff06f          	j	800043ac <__printf+0x264>
    800047c0:	00900793          	li	a5,9
    800047c4:	00800c93          	li	s9,8
    800047c8:	be1ff06f          	j	800043a8 <__printf+0x260>
    800047cc:	00002517          	auipc	a0,0x2
    800047d0:	99450513          	addi	a0,a0,-1644 # 80006160 <CONSOLE_STATUS+0x150>
    800047d4:	00000097          	auipc	ra,0x0
    800047d8:	918080e7          	jalr	-1768(ra) # 800040ec <panic>

00000000800047dc <printfinit>:
    800047dc:	fe010113          	addi	sp,sp,-32
    800047e0:	00813823          	sd	s0,16(sp)
    800047e4:	00913423          	sd	s1,8(sp)
    800047e8:	00113c23          	sd	ra,24(sp)
    800047ec:	02010413          	addi	s0,sp,32
    800047f0:	00004497          	auipc	s1,0x4
    800047f4:	e6048493          	addi	s1,s1,-416 # 80008650 <pr>
    800047f8:	00048513          	mv	a0,s1
    800047fc:	00002597          	auipc	a1,0x2
    80004800:	97458593          	addi	a1,a1,-1676 # 80006170 <CONSOLE_STATUS+0x160>
    80004804:	00000097          	auipc	ra,0x0
    80004808:	5f4080e7          	jalr	1524(ra) # 80004df8 <initlock>
    8000480c:	01813083          	ld	ra,24(sp)
    80004810:	01013403          	ld	s0,16(sp)
    80004814:	0004ac23          	sw	zero,24(s1)
    80004818:	00813483          	ld	s1,8(sp)
    8000481c:	02010113          	addi	sp,sp,32
    80004820:	00008067          	ret

0000000080004824 <uartinit>:
    80004824:	ff010113          	addi	sp,sp,-16
    80004828:	00813423          	sd	s0,8(sp)
    8000482c:	01010413          	addi	s0,sp,16
    80004830:	100007b7          	lui	a5,0x10000
    80004834:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80004838:	f8000713          	li	a4,-128
    8000483c:	00e781a3          	sb	a4,3(a5)
    80004840:	00300713          	li	a4,3
    80004844:	00e78023          	sb	a4,0(a5)
    80004848:	000780a3          	sb	zero,1(a5)
    8000484c:	00e781a3          	sb	a4,3(a5)
    80004850:	00700693          	li	a3,7
    80004854:	00d78123          	sb	a3,2(a5)
    80004858:	00e780a3          	sb	a4,1(a5)
    8000485c:	00813403          	ld	s0,8(sp)
    80004860:	01010113          	addi	sp,sp,16
    80004864:	00008067          	ret

0000000080004868 <uartputc>:
    80004868:	00003797          	auipc	a5,0x3
    8000486c:	9007a783          	lw	a5,-1792(a5) # 80007168 <panicked>
    80004870:	00078463          	beqz	a5,80004878 <uartputc+0x10>
    80004874:	0000006f          	j	80004874 <uartputc+0xc>
    80004878:	fd010113          	addi	sp,sp,-48
    8000487c:	02813023          	sd	s0,32(sp)
    80004880:	00913c23          	sd	s1,24(sp)
    80004884:	01213823          	sd	s2,16(sp)
    80004888:	01313423          	sd	s3,8(sp)
    8000488c:	02113423          	sd	ra,40(sp)
    80004890:	03010413          	addi	s0,sp,48
    80004894:	00003917          	auipc	s2,0x3
    80004898:	8dc90913          	addi	s2,s2,-1828 # 80007170 <uart_tx_r>
    8000489c:	00093783          	ld	a5,0(s2)
    800048a0:	00003497          	auipc	s1,0x3
    800048a4:	8d848493          	addi	s1,s1,-1832 # 80007178 <uart_tx_w>
    800048a8:	0004b703          	ld	a4,0(s1)
    800048ac:	02078693          	addi	a3,a5,32
    800048b0:	00050993          	mv	s3,a0
    800048b4:	02e69c63          	bne	a3,a4,800048ec <uartputc+0x84>
    800048b8:	00001097          	auipc	ra,0x1
    800048bc:	834080e7          	jalr	-1996(ra) # 800050ec <push_on>
    800048c0:	00093783          	ld	a5,0(s2)
    800048c4:	0004b703          	ld	a4,0(s1)
    800048c8:	02078793          	addi	a5,a5,32
    800048cc:	00e79463          	bne	a5,a4,800048d4 <uartputc+0x6c>
    800048d0:	0000006f          	j	800048d0 <uartputc+0x68>
    800048d4:	00001097          	auipc	ra,0x1
    800048d8:	88c080e7          	jalr	-1908(ra) # 80005160 <pop_on>
    800048dc:	00093783          	ld	a5,0(s2)
    800048e0:	0004b703          	ld	a4,0(s1)
    800048e4:	02078693          	addi	a3,a5,32
    800048e8:	fce688e3          	beq	a3,a4,800048b8 <uartputc+0x50>
    800048ec:	01f77693          	andi	a3,a4,31
    800048f0:	00004597          	auipc	a1,0x4
    800048f4:	d8058593          	addi	a1,a1,-640 # 80008670 <uart_tx_buf>
    800048f8:	00d586b3          	add	a3,a1,a3
    800048fc:	00170713          	addi	a4,a4,1
    80004900:	01368023          	sb	s3,0(a3)
    80004904:	00e4b023          	sd	a4,0(s1)
    80004908:	10000637          	lui	a2,0x10000
    8000490c:	02f71063          	bne	a4,a5,8000492c <uartputc+0xc4>
    80004910:	0340006f          	j	80004944 <uartputc+0xdc>
    80004914:	00074703          	lbu	a4,0(a4)
    80004918:	00f93023          	sd	a5,0(s2)
    8000491c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80004920:	00093783          	ld	a5,0(s2)
    80004924:	0004b703          	ld	a4,0(s1)
    80004928:	00f70e63          	beq	a4,a5,80004944 <uartputc+0xdc>
    8000492c:	00564683          	lbu	a3,5(a2)
    80004930:	01f7f713          	andi	a4,a5,31
    80004934:	00e58733          	add	a4,a1,a4
    80004938:	0206f693          	andi	a3,a3,32
    8000493c:	00178793          	addi	a5,a5,1
    80004940:	fc069ae3          	bnez	a3,80004914 <uartputc+0xac>
    80004944:	02813083          	ld	ra,40(sp)
    80004948:	02013403          	ld	s0,32(sp)
    8000494c:	01813483          	ld	s1,24(sp)
    80004950:	01013903          	ld	s2,16(sp)
    80004954:	00813983          	ld	s3,8(sp)
    80004958:	03010113          	addi	sp,sp,48
    8000495c:	00008067          	ret

0000000080004960 <uartputc_sync>:
    80004960:	ff010113          	addi	sp,sp,-16
    80004964:	00813423          	sd	s0,8(sp)
    80004968:	01010413          	addi	s0,sp,16
    8000496c:	00002717          	auipc	a4,0x2
    80004970:	7fc72703          	lw	a4,2044(a4) # 80007168 <panicked>
    80004974:	02071663          	bnez	a4,800049a0 <uartputc_sync+0x40>
    80004978:	00050793          	mv	a5,a0
    8000497c:	100006b7          	lui	a3,0x10000
    80004980:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80004984:	02077713          	andi	a4,a4,32
    80004988:	fe070ce3          	beqz	a4,80004980 <uartputc_sync+0x20>
    8000498c:	0ff7f793          	andi	a5,a5,255
    80004990:	00f68023          	sb	a5,0(a3)
    80004994:	00813403          	ld	s0,8(sp)
    80004998:	01010113          	addi	sp,sp,16
    8000499c:	00008067          	ret
    800049a0:	0000006f          	j	800049a0 <uartputc_sync+0x40>

00000000800049a4 <uartstart>:
    800049a4:	ff010113          	addi	sp,sp,-16
    800049a8:	00813423          	sd	s0,8(sp)
    800049ac:	01010413          	addi	s0,sp,16
    800049b0:	00002617          	auipc	a2,0x2
    800049b4:	7c060613          	addi	a2,a2,1984 # 80007170 <uart_tx_r>
    800049b8:	00002517          	auipc	a0,0x2
    800049bc:	7c050513          	addi	a0,a0,1984 # 80007178 <uart_tx_w>
    800049c0:	00063783          	ld	a5,0(a2)
    800049c4:	00053703          	ld	a4,0(a0)
    800049c8:	04f70263          	beq	a4,a5,80004a0c <uartstart+0x68>
    800049cc:	100005b7          	lui	a1,0x10000
    800049d0:	00004817          	auipc	a6,0x4
    800049d4:	ca080813          	addi	a6,a6,-864 # 80008670 <uart_tx_buf>
    800049d8:	01c0006f          	j	800049f4 <uartstart+0x50>
    800049dc:	0006c703          	lbu	a4,0(a3)
    800049e0:	00f63023          	sd	a5,0(a2)
    800049e4:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800049e8:	00063783          	ld	a5,0(a2)
    800049ec:	00053703          	ld	a4,0(a0)
    800049f0:	00f70e63          	beq	a4,a5,80004a0c <uartstart+0x68>
    800049f4:	01f7f713          	andi	a4,a5,31
    800049f8:	00e806b3          	add	a3,a6,a4
    800049fc:	0055c703          	lbu	a4,5(a1)
    80004a00:	00178793          	addi	a5,a5,1
    80004a04:	02077713          	andi	a4,a4,32
    80004a08:	fc071ae3          	bnez	a4,800049dc <uartstart+0x38>
    80004a0c:	00813403          	ld	s0,8(sp)
    80004a10:	01010113          	addi	sp,sp,16
    80004a14:	00008067          	ret

0000000080004a18 <uartgetc>:
    80004a18:	ff010113          	addi	sp,sp,-16
    80004a1c:	00813423          	sd	s0,8(sp)
    80004a20:	01010413          	addi	s0,sp,16
    80004a24:	10000737          	lui	a4,0x10000
    80004a28:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    80004a2c:	0017f793          	andi	a5,a5,1
    80004a30:	00078c63          	beqz	a5,80004a48 <uartgetc+0x30>
    80004a34:	00074503          	lbu	a0,0(a4)
    80004a38:	0ff57513          	andi	a0,a0,255
    80004a3c:	00813403          	ld	s0,8(sp)
    80004a40:	01010113          	addi	sp,sp,16
    80004a44:	00008067          	ret
    80004a48:	fff00513          	li	a0,-1
    80004a4c:	ff1ff06f          	j	80004a3c <uartgetc+0x24>

0000000080004a50 <uartintr>:
    80004a50:	100007b7          	lui	a5,0x10000
    80004a54:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80004a58:	0017f793          	andi	a5,a5,1
    80004a5c:	0a078463          	beqz	a5,80004b04 <uartintr+0xb4>
    80004a60:	fe010113          	addi	sp,sp,-32
    80004a64:	00813823          	sd	s0,16(sp)
    80004a68:	00913423          	sd	s1,8(sp)
    80004a6c:	00113c23          	sd	ra,24(sp)
    80004a70:	02010413          	addi	s0,sp,32
    80004a74:	100004b7          	lui	s1,0x10000
    80004a78:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    80004a7c:	0ff57513          	andi	a0,a0,255
    80004a80:	fffff097          	auipc	ra,0xfffff
    80004a84:	534080e7          	jalr	1332(ra) # 80003fb4 <consoleintr>
    80004a88:	0054c783          	lbu	a5,5(s1)
    80004a8c:	0017f793          	andi	a5,a5,1
    80004a90:	fe0794e3          	bnez	a5,80004a78 <uartintr+0x28>
    80004a94:	00002617          	auipc	a2,0x2
    80004a98:	6dc60613          	addi	a2,a2,1756 # 80007170 <uart_tx_r>
    80004a9c:	00002517          	auipc	a0,0x2
    80004aa0:	6dc50513          	addi	a0,a0,1756 # 80007178 <uart_tx_w>
    80004aa4:	00063783          	ld	a5,0(a2)
    80004aa8:	00053703          	ld	a4,0(a0)
    80004aac:	04f70263          	beq	a4,a5,80004af0 <uartintr+0xa0>
    80004ab0:	100005b7          	lui	a1,0x10000
    80004ab4:	00004817          	auipc	a6,0x4
    80004ab8:	bbc80813          	addi	a6,a6,-1092 # 80008670 <uart_tx_buf>
    80004abc:	01c0006f          	j	80004ad8 <uartintr+0x88>
    80004ac0:	0006c703          	lbu	a4,0(a3)
    80004ac4:	00f63023          	sd	a5,0(a2)
    80004ac8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80004acc:	00063783          	ld	a5,0(a2)
    80004ad0:	00053703          	ld	a4,0(a0)
    80004ad4:	00f70e63          	beq	a4,a5,80004af0 <uartintr+0xa0>
    80004ad8:	01f7f713          	andi	a4,a5,31
    80004adc:	00e806b3          	add	a3,a6,a4
    80004ae0:	0055c703          	lbu	a4,5(a1)
    80004ae4:	00178793          	addi	a5,a5,1
    80004ae8:	02077713          	andi	a4,a4,32
    80004aec:	fc071ae3          	bnez	a4,80004ac0 <uartintr+0x70>
    80004af0:	01813083          	ld	ra,24(sp)
    80004af4:	01013403          	ld	s0,16(sp)
    80004af8:	00813483          	ld	s1,8(sp)
    80004afc:	02010113          	addi	sp,sp,32
    80004b00:	00008067          	ret
    80004b04:	00002617          	auipc	a2,0x2
    80004b08:	66c60613          	addi	a2,a2,1644 # 80007170 <uart_tx_r>
    80004b0c:	00002517          	auipc	a0,0x2
    80004b10:	66c50513          	addi	a0,a0,1644 # 80007178 <uart_tx_w>
    80004b14:	00063783          	ld	a5,0(a2)
    80004b18:	00053703          	ld	a4,0(a0)
    80004b1c:	04f70263          	beq	a4,a5,80004b60 <uartintr+0x110>
    80004b20:	100005b7          	lui	a1,0x10000
    80004b24:	00004817          	auipc	a6,0x4
    80004b28:	b4c80813          	addi	a6,a6,-1204 # 80008670 <uart_tx_buf>
    80004b2c:	01c0006f          	j	80004b48 <uartintr+0xf8>
    80004b30:	0006c703          	lbu	a4,0(a3)
    80004b34:	00f63023          	sd	a5,0(a2)
    80004b38:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80004b3c:	00063783          	ld	a5,0(a2)
    80004b40:	00053703          	ld	a4,0(a0)
    80004b44:	02f70063          	beq	a4,a5,80004b64 <uartintr+0x114>
    80004b48:	01f7f713          	andi	a4,a5,31
    80004b4c:	00e806b3          	add	a3,a6,a4
    80004b50:	0055c703          	lbu	a4,5(a1)
    80004b54:	00178793          	addi	a5,a5,1
    80004b58:	02077713          	andi	a4,a4,32
    80004b5c:	fc071ae3          	bnez	a4,80004b30 <uartintr+0xe0>
    80004b60:	00008067          	ret
    80004b64:	00008067          	ret

0000000080004b68 <kinit>:
    80004b68:	fc010113          	addi	sp,sp,-64
    80004b6c:	02913423          	sd	s1,40(sp)
    80004b70:	fffff7b7          	lui	a5,0xfffff
    80004b74:	00005497          	auipc	s1,0x5
    80004b78:	b1b48493          	addi	s1,s1,-1253 # 8000968f <end+0xfff>
    80004b7c:	02813823          	sd	s0,48(sp)
    80004b80:	01313c23          	sd	s3,24(sp)
    80004b84:	00f4f4b3          	and	s1,s1,a5
    80004b88:	02113c23          	sd	ra,56(sp)
    80004b8c:	03213023          	sd	s2,32(sp)
    80004b90:	01413823          	sd	s4,16(sp)
    80004b94:	01513423          	sd	s5,8(sp)
    80004b98:	04010413          	addi	s0,sp,64
    80004b9c:	000017b7          	lui	a5,0x1
    80004ba0:	01100993          	li	s3,17
    80004ba4:	00f487b3          	add	a5,s1,a5
    80004ba8:	01b99993          	slli	s3,s3,0x1b
    80004bac:	06f9e063          	bltu	s3,a5,80004c0c <kinit+0xa4>
    80004bb0:	00004a97          	auipc	s5,0x4
    80004bb4:	ae0a8a93          	addi	s5,s5,-1312 # 80008690 <end>
    80004bb8:	0754ec63          	bltu	s1,s5,80004c30 <kinit+0xc8>
    80004bbc:	0734fa63          	bgeu	s1,s3,80004c30 <kinit+0xc8>
    80004bc0:	00088a37          	lui	s4,0x88
    80004bc4:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80004bc8:	00002917          	auipc	s2,0x2
    80004bcc:	5b890913          	addi	s2,s2,1464 # 80007180 <kmem>
    80004bd0:	00ca1a13          	slli	s4,s4,0xc
    80004bd4:	0140006f          	j	80004be8 <kinit+0x80>
    80004bd8:	000017b7          	lui	a5,0x1
    80004bdc:	00f484b3          	add	s1,s1,a5
    80004be0:	0554e863          	bltu	s1,s5,80004c30 <kinit+0xc8>
    80004be4:	0534f663          	bgeu	s1,s3,80004c30 <kinit+0xc8>
    80004be8:	00001637          	lui	a2,0x1
    80004bec:	00100593          	li	a1,1
    80004bf0:	00048513          	mv	a0,s1
    80004bf4:	00000097          	auipc	ra,0x0
    80004bf8:	5e4080e7          	jalr	1508(ra) # 800051d8 <__memset>
    80004bfc:	00093783          	ld	a5,0(s2)
    80004c00:	00f4b023          	sd	a5,0(s1)
    80004c04:	00993023          	sd	s1,0(s2)
    80004c08:	fd4498e3          	bne	s1,s4,80004bd8 <kinit+0x70>
    80004c0c:	03813083          	ld	ra,56(sp)
    80004c10:	03013403          	ld	s0,48(sp)
    80004c14:	02813483          	ld	s1,40(sp)
    80004c18:	02013903          	ld	s2,32(sp)
    80004c1c:	01813983          	ld	s3,24(sp)
    80004c20:	01013a03          	ld	s4,16(sp)
    80004c24:	00813a83          	ld	s5,8(sp)
    80004c28:	04010113          	addi	sp,sp,64
    80004c2c:	00008067          	ret
    80004c30:	00001517          	auipc	a0,0x1
    80004c34:	56050513          	addi	a0,a0,1376 # 80006190 <digits+0x18>
    80004c38:	fffff097          	auipc	ra,0xfffff
    80004c3c:	4b4080e7          	jalr	1204(ra) # 800040ec <panic>

0000000080004c40 <freerange>:
    80004c40:	fc010113          	addi	sp,sp,-64
    80004c44:	000017b7          	lui	a5,0x1
    80004c48:	02913423          	sd	s1,40(sp)
    80004c4c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80004c50:	009504b3          	add	s1,a0,s1
    80004c54:	fffff537          	lui	a0,0xfffff
    80004c58:	02813823          	sd	s0,48(sp)
    80004c5c:	02113c23          	sd	ra,56(sp)
    80004c60:	03213023          	sd	s2,32(sp)
    80004c64:	01313c23          	sd	s3,24(sp)
    80004c68:	01413823          	sd	s4,16(sp)
    80004c6c:	01513423          	sd	s5,8(sp)
    80004c70:	01613023          	sd	s6,0(sp)
    80004c74:	04010413          	addi	s0,sp,64
    80004c78:	00a4f4b3          	and	s1,s1,a0
    80004c7c:	00f487b3          	add	a5,s1,a5
    80004c80:	06f5e463          	bltu	a1,a5,80004ce8 <freerange+0xa8>
    80004c84:	00004a97          	auipc	s5,0x4
    80004c88:	a0ca8a93          	addi	s5,s5,-1524 # 80008690 <end>
    80004c8c:	0954e263          	bltu	s1,s5,80004d10 <freerange+0xd0>
    80004c90:	01100993          	li	s3,17
    80004c94:	01b99993          	slli	s3,s3,0x1b
    80004c98:	0734fc63          	bgeu	s1,s3,80004d10 <freerange+0xd0>
    80004c9c:	00058a13          	mv	s4,a1
    80004ca0:	00002917          	auipc	s2,0x2
    80004ca4:	4e090913          	addi	s2,s2,1248 # 80007180 <kmem>
    80004ca8:	00002b37          	lui	s6,0x2
    80004cac:	0140006f          	j	80004cc0 <freerange+0x80>
    80004cb0:	000017b7          	lui	a5,0x1
    80004cb4:	00f484b3          	add	s1,s1,a5
    80004cb8:	0554ec63          	bltu	s1,s5,80004d10 <freerange+0xd0>
    80004cbc:	0534fa63          	bgeu	s1,s3,80004d10 <freerange+0xd0>
    80004cc0:	00001637          	lui	a2,0x1
    80004cc4:	00100593          	li	a1,1
    80004cc8:	00048513          	mv	a0,s1
    80004ccc:	00000097          	auipc	ra,0x0
    80004cd0:	50c080e7          	jalr	1292(ra) # 800051d8 <__memset>
    80004cd4:	00093703          	ld	a4,0(s2)
    80004cd8:	016487b3          	add	a5,s1,s6
    80004cdc:	00e4b023          	sd	a4,0(s1)
    80004ce0:	00993023          	sd	s1,0(s2)
    80004ce4:	fcfa76e3          	bgeu	s4,a5,80004cb0 <freerange+0x70>
    80004ce8:	03813083          	ld	ra,56(sp)
    80004cec:	03013403          	ld	s0,48(sp)
    80004cf0:	02813483          	ld	s1,40(sp)
    80004cf4:	02013903          	ld	s2,32(sp)
    80004cf8:	01813983          	ld	s3,24(sp)
    80004cfc:	01013a03          	ld	s4,16(sp)
    80004d00:	00813a83          	ld	s5,8(sp)
    80004d04:	00013b03          	ld	s6,0(sp)
    80004d08:	04010113          	addi	sp,sp,64
    80004d0c:	00008067          	ret
    80004d10:	00001517          	auipc	a0,0x1
    80004d14:	48050513          	addi	a0,a0,1152 # 80006190 <digits+0x18>
    80004d18:	fffff097          	auipc	ra,0xfffff
    80004d1c:	3d4080e7          	jalr	980(ra) # 800040ec <panic>

0000000080004d20 <kfree>:
    80004d20:	fe010113          	addi	sp,sp,-32
    80004d24:	00813823          	sd	s0,16(sp)
    80004d28:	00113c23          	sd	ra,24(sp)
    80004d2c:	00913423          	sd	s1,8(sp)
    80004d30:	02010413          	addi	s0,sp,32
    80004d34:	03451793          	slli	a5,a0,0x34
    80004d38:	04079c63          	bnez	a5,80004d90 <kfree+0x70>
    80004d3c:	00004797          	auipc	a5,0x4
    80004d40:	95478793          	addi	a5,a5,-1708 # 80008690 <end>
    80004d44:	00050493          	mv	s1,a0
    80004d48:	04f56463          	bltu	a0,a5,80004d90 <kfree+0x70>
    80004d4c:	01100793          	li	a5,17
    80004d50:	01b79793          	slli	a5,a5,0x1b
    80004d54:	02f57e63          	bgeu	a0,a5,80004d90 <kfree+0x70>
    80004d58:	00001637          	lui	a2,0x1
    80004d5c:	00100593          	li	a1,1
    80004d60:	00000097          	auipc	ra,0x0
    80004d64:	478080e7          	jalr	1144(ra) # 800051d8 <__memset>
    80004d68:	00002797          	auipc	a5,0x2
    80004d6c:	41878793          	addi	a5,a5,1048 # 80007180 <kmem>
    80004d70:	0007b703          	ld	a4,0(a5)
    80004d74:	01813083          	ld	ra,24(sp)
    80004d78:	01013403          	ld	s0,16(sp)
    80004d7c:	00e4b023          	sd	a4,0(s1)
    80004d80:	0097b023          	sd	s1,0(a5)
    80004d84:	00813483          	ld	s1,8(sp)
    80004d88:	02010113          	addi	sp,sp,32
    80004d8c:	00008067          	ret
    80004d90:	00001517          	auipc	a0,0x1
    80004d94:	40050513          	addi	a0,a0,1024 # 80006190 <digits+0x18>
    80004d98:	fffff097          	auipc	ra,0xfffff
    80004d9c:	354080e7          	jalr	852(ra) # 800040ec <panic>

0000000080004da0 <kalloc>:
    80004da0:	fe010113          	addi	sp,sp,-32
    80004da4:	00813823          	sd	s0,16(sp)
    80004da8:	00913423          	sd	s1,8(sp)
    80004dac:	00113c23          	sd	ra,24(sp)
    80004db0:	02010413          	addi	s0,sp,32
    80004db4:	00002797          	auipc	a5,0x2
    80004db8:	3cc78793          	addi	a5,a5,972 # 80007180 <kmem>
    80004dbc:	0007b483          	ld	s1,0(a5)
    80004dc0:	02048063          	beqz	s1,80004de0 <kalloc+0x40>
    80004dc4:	0004b703          	ld	a4,0(s1)
    80004dc8:	00001637          	lui	a2,0x1
    80004dcc:	00500593          	li	a1,5
    80004dd0:	00048513          	mv	a0,s1
    80004dd4:	00e7b023          	sd	a4,0(a5)
    80004dd8:	00000097          	auipc	ra,0x0
    80004ddc:	400080e7          	jalr	1024(ra) # 800051d8 <__memset>
    80004de0:	01813083          	ld	ra,24(sp)
    80004de4:	01013403          	ld	s0,16(sp)
    80004de8:	00048513          	mv	a0,s1
    80004dec:	00813483          	ld	s1,8(sp)
    80004df0:	02010113          	addi	sp,sp,32
    80004df4:	00008067          	ret

0000000080004df8 <initlock>:
    80004df8:	ff010113          	addi	sp,sp,-16
    80004dfc:	00813423          	sd	s0,8(sp)
    80004e00:	01010413          	addi	s0,sp,16
    80004e04:	00813403          	ld	s0,8(sp)
    80004e08:	00b53423          	sd	a1,8(a0)
    80004e0c:	00052023          	sw	zero,0(a0)
    80004e10:	00053823          	sd	zero,16(a0)
    80004e14:	01010113          	addi	sp,sp,16
    80004e18:	00008067          	ret

0000000080004e1c <acquire>:
    80004e1c:	fe010113          	addi	sp,sp,-32
    80004e20:	00813823          	sd	s0,16(sp)
    80004e24:	00913423          	sd	s1,8(sp)
    80004e28:	00113c23          	sd	ra,24(sp)
    80004e2c:	01213023          	sd	s2,0(sp)
    80004e30:	02010413          	addi	s0,sp,32
    80004e34:	00050493          	mv	s1,a0
    80004e38:	10002973          	csrr	s2,sstatus
    80004e3c:	100027f3          	csrr	a5,sstatus
    80004e40:	ffd7f793          	andi	a5,a5,-3
    80004e44:	10079073          	csrw	sstatus,a5
    80004e48:	fffff097          	auipc	ra,0xfffff
    80004e4c:	8e8080e7          	jalr	-1816(ra) # 80003730 <mycpu>
    80004e50:	07852783          	lw	a5,120(a0)
    80004e54:	06078e63          	beqz	a5,80004ed0 <acquire+0xb4>
    80004e58:	fffff097          	auipc	ra,0xfffff
    80004e5c:	8d8080e7          	jalr	-1832(ra) # 80003730 <mycpu>
    80004e60:	07852783          	lw	a5,120(a0)
    80004e64:	0004a703          	lw	a4,0(s1)
    80004e68:	0017879b          	addiw	a5,a5,1
    80004e6c:	06f52c23          	sw	a5,120(a0)
    80004e70:	04071063          	bnez	a4,80004eb0 <acquire+0x94>
    80004e74:	00100713          	li	a4,1
    80004e78:	00070793          	mv	a5,a4
    80004e7c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80004e80:	0007879b          	sext.w	a5,a5
    80004e84:	fe079ae3          	bnez	a5,80004e78 <acquire+0x5c>
    80004e88:	0ff0000f          	fence
    80004e8c:	fffff097          	auipc	ra,0xfffff
    80004e90:	8a4080e7          	jalr	-1884(ra) # 80003730 <mycpu>
    80004e94:	01813083          	ld	ra,24(sp)
    80004e98:	01013403          	ld	s0,16(sp)
    80004e9c:	00a4b823          	sd	a0,16(s1)
    80004ea0:	00013903          	ld	s2,0(sp)
    80004ea4:	00813483          	ld	s1,8(sp)
    80004ea8:	02010113          	addi	sp,sp,32
    80004eac:	00008067          	ret
    80004eb0:	0104b903          	ld	s2,16(s1)
    80004eb4:	fffff097          	auipc	ra,0xfffff
    80004eb8:	87c080e7          	jalr	-1924(ra) # 80003730 <mycpu>
    80004ebc:	faa91ce3          	bne	s2,a0,80004e74 <acquire+0x58>
    80004ec0:	00001517          	auipc	a0,0x1
    80004ec4:	2d850513          	addi	a0,a0,728 # 80006198 <digits+0x20>
    80004ec8:	fffff097          	auipc	ra,0xfffff
    80004ecc:	224080e7          	jalr	548(ra) # 800040ec <panic>
    80004ed0:	00195913          	srli	s2,s2,0x1
    80004ed4:	fffff097          	auipc	ra,0xfffff
    80004ed8:	85c080e7          	jalr	-1956(ra) # 80003730 <mycpu>
    80004edc:	00197913          	andi	s2,s2,1
    80004ee0:	07252e23          	sw	s2,124(a0)
    80004ee4:	f75ff06f          	j	80004e58 <acquire+0x3c>

0000000080004ee8 <release>:
    80004ee8:	fe010113          	addi	sp,sp,-32
    80004eec:	00813823          	sd	s0,16(sp)
    80004ef0:	00113c23          	sd	ra,24(sp)
    80004ef4:	00913423          	sd	s1,8(sp)
    80004ef8:	01213023          	sd	s2,0(sp)
    80004efc:	02010413          	addi	s0,sp,32
    80004f00:	00052783          	lw	a5,0(a0)
    80004f04:	00079a63          	bnez	a5,80004f18 <release+0x30>
    80004f08:	00001517          	auipc	a0,0x1
    80004f0c:	29850513          	addi	a0,a0,664 # 800061a0 <digits+0x28>
    80004f10:	fffff097          	auipc	ra,0xfffff
    80004f14:	1dc080e7          	jalr	476(ra) # 800040ec <panic>
    80004f18:	01053903          	ld	s2,16(a0)
    80004f1c:	00050493          	mv	s1,a0
    80004f20:	fffff097          	auipc	ra,0xfffff
    80004f24:	810080e7          	jalr	-2032(ra) # 80003730 <mycpu>
    80004f28:	fea910e3          	bne	s2,a0,80004f08 <release+0x20>
    80004f2c:	0004b823          	sd	zero,16(s1)
    80004f30:	0ff0000f          	fence
    80004f34:	0f50000f          	fence	iorw,ow
    80004f38:	0804a02f          	amoswap.w	zero,zero,(s1)
    80004f3c:	ffffe097          	auipc	ra,0xffffe
    80004f40:	7f4080e7          	jalr	2036(ra) # 80003730 <mycpu>
    80004f44:	100027f3          	csrr	a5,sstatus
    80004f48:	0027f793          	andi	a5,a5,2
    80004f4c:	04079a63          	bnez	a5,80004fa0 <release+0xb8>
    80004f50:	07852783          	lw	a5,120(a0)
    80004f54:	02f05e63          	blez	a5,80004f90 <release+0xa8>
    80004f58:	fff7871b          	addiw	a4,a5,-1
    80004f5c:	06e52c23          	sw	a4,120(a0)
    80004f60:	00071c63          	bnez	a4,80004f78 <release+0x90>
    80004f64:	07c52783          	lw	a5,124(a0)
    80004f68:	00078863          	beqz	a5,80004f78 <release+0x90>
    80004f6c:	100027f3          	csrr	a5,sstatus
    80004f70:	0027e793          	ori	a5,a5,2
    80004f74:	10079073          	csrw	sstatus,a5
    80004f78:	01813083          	ld	ra,24(sp)
    80004f7c:	01013403          	ld	s0,16(sp)
    80004f80:	00813483          	ld	s1,8(sp)
    80004f84:	00013903          	ld	s2,0(sp)
    80004f88:	02010113          	addi	sp,sp,32
    80004f8c:	00008067          	ret
    80004f90:	00001517          	auipc	a0,0x1
    80004f94:	23050513          	addi	a0,a0,560 # 800061c0 <digits+0x48>
    80004f98:	fffff097          	auipc	ra,0xfffff
    80004f9c:	154080e7          	jalr	340(ra) # 800040ec <panic>
    80004fa0:	00001517          	auipc	a0,0x1
    80004fa4:	20850513          	addi	a0,a0,520 # 800061a8 <digits+0x30>
    80004fa8:	fffff097          	auipc	ra,0xfffff
    80004fac:	144080e7          	jalr	324(ra) # 800040ec <panic>

0000000080004fb0 <holding>:
    80004fb0:	00052783          	lw	a5,0(a0)
    80004fb4:	00079663          	bnez	a5,80004fc0 <holding+0x10>
    80004fb8:	00000513          	li	a0,0
    80004fbc:	00008067          	ret
    80004fc0:	fe010113          	addi	sp,sp,-32
    80004fc4:	00813823          	sd	s0,16(sp)
    80004fc8:	00913423          	sd	s1,8(sp)
    80004fcc:	00113c23          	sd	ra,24(sp)
    80004fd0:	02010413          	addi	s0,sp,32
    80004fd4:	01053483          	ld	s1,16(a0)
    80004fd8:	ffffe097          	auipc	ra,0xffffe
    80004fdc:	758080e7          	jalr	1880(ra) # 80003730 <mycpu>
    80004fe0:	01813083          	ld	ra,24(sp)
    80004fe4:	01013403          	ld	s0,16(sp)
    80004fe8:	40a48533          	sub	a0,s1,a0
    80004fec:	00153513          	seqz	a0,a0
    80004ff0:	00813483          	ld	s1,8(sp)
    80004ff4:	02010113          	addi	sp,sp,32
    80004ff8:	00008067          	ret

0000000080004ffc <push_off>:
    80004ffc:	fe010113          	addi	sp,sp,-32
    80005000:	00813823          	sd	s0,16(sp)
    80005004:	00113c23          	sd	ra,24(sp)
    80005008:	00913423          	sd	s1,8(sp)
    8000500c:	02010413          	addi	s0,sp,32
    80005010:	100024f3          	csrr	s1,sstatus
    80005014:	100027f3          	csrr	a5,sstatus
    80005018:	ffd7f793          	andi	a5,a5,-3
    8000501c:	10079073          	csrw	sstatus,a5
    80005020:	ffffe097          	auipc	ra,0xffffe
    80005024:	710080e7          	jalr	1808(ra) # 80003730 <mycpu>
    80005028:	07852783          	lw	a5,120(a0)
    8000502c:	02078663          	beqz	a5,80005058 <push_off+0x5c>
    80005030:	ffffe097          	auipc	ra,0xffffe
    80005034:	700080e7          	jalr	1792(ra) # 80003730 <mycpu>
    80005038:	07852783          	lw	a5,120(a0)
    8000503c:	01813083          	ld	ra,24(sp)
    80005040:	01013403          	ld	s0,16(sp)
    80005044:	0017879b          	addiw	a5,a5,1
    80005048:	06f52c23          	sw	a5,120(a0)
    8000504c:	00813483          	ld	s1,8(sp)
    80005050:	02010113          	addi	sp,sp,32
    80005054:	00008067          	ret
    80005058:	0014d493          	srli	s1,s1,0x1
    8000505c:	ffffe097          	auipc	ra,0xffffe
    80005060:	6d4080e7          	jalr	1748(ra) # 80003730 <mycpu>
    80005064:	0014f493          	andi	s1,s1,1
    80005068:	06952e23          	sw	s1,124(a0)
    8000506c:	fc5ff06f          	j	80005030 <push_off+0x34>

0000000080005070 <pop_off>:
    80005070:	ff010113          	addi	sp,sp,-16
    80005074:	00813023          	sd	s0,0(sp)
    80005078:	00113423          	sd	ra,8(sp)
    8000507c:	01010413          	addi	s0,sp,16
    80005080:	ffffe097          	auipc	ra,0xffffe
    80005084:	6b0080e7          	jalr	1712(ra) # 80003730 <mycpu>
    80005088:	100027f3          	csrr	a5,sstatus
    8000508c:	0027f793          	andi	a5,a5,2
    80005090:	04079663          	bnez	a5,800050dc <pop_off+0x6c>
    80005094:	07852783          	lw	a5,120(a0)
    80005098:	02f05a63          	blez	a5,800050cc <pop_off+0x5c>
    8000509c:	fff7871b          	addiw	a4,a5,-1
    800050a0:	06e52c23          	sw	a4,120(a0)
    800050a4:	00071c63          	bnez	a4,800050bc <pop_off+0x4c>
    800050a8:	07c52783          	lw	a5,124(a0)
    800050ac:	00078863          	beqz	a5,800050bc <pop_off+0x4c>
    800050b0:	100027f3          	csrr	a5,sstatus
    800050b4:	0027e793          	ori	a5,a5,2
    800050b8:	10079073          	csrw	sstatus,a5
    800050bc:	00813083          	ld	ra,8(sp)
    800050c0:	00013403          	ld	s0,0(sp)
    800050c4:	01010113          	addi	sp,sp,16
    800050c8:	00008067          	ret
    800050cc:	00001517          	auipc	a0,0x1
    800050d0:	0f450513          	addi	a0,a0,244 # 800061c0 <digits+0x48>
    800050d4:	fffff097          	auipc	ra,0xfffff
    800050d8:	018080e7          	jalr	24(ra) # 800040ec <panic>
    800050dc:	00001517          	auipc	a0,0x1
    800050e0:	0cc50513          	addi	a0,a0,204 # 800061a8 <digits+0x30>
    800050e4:	fffff097          	auipc	ra,0xfffff
    800050e8:	008080e7          	jalr	8(ra) # 800040ec <panic>

00000000800050ec <push_on>:
    800050ec:	fe010113          	addi	sp,sp,-32
    800050f0:	00813823          	sd	s0,16(sp)
    800050f4:	00113c23          	sd	ra,24(sp)
    800050f8:	00913423          	sd	s1,8(sp)
    800050fc:	02010413          	addi	s0,sp,32
    80005100:	100024f3          	csrr	s1,sstatus
    80005104:	100027f3          	csrr	a5,sstatus
    80005108:	0027e793          	ori	a5,a5,2
    8000510c:	10079073          	csrw	sstatus,a5
    80005110:	ffffe097          	auipc	ra,0xffffe
    80005114:	620080e7          	jalr	1568(ra) # 80003730 <mycpu>
    80005118:	07852783          	lw	a5,120(a0)
    8000511c:	02078663          	beqz	a5,80005148 <push_on+0x5c>
    80005120:	ffffe097          	auipc	ra,0xffffe
    80005124:	610080e7          	jalr	1552(ra) # 80003730 <mycpu>
    80005128:	07852783          	lw	a5,120(a0)
    8000512c:	01813083          	ld	ra,24(sp)
    80005130:	01013403          	ld	s0,16(sp)
    80005134:	0017879b          	addiw	a5,a5,1
    80005138:	06f52c23          	sw	a5,120(a0)
    8000513c:	00813483          	ld	s1,8(sp)
    80005140:	02010113          	addi	sp,sp,32
    80005144:	00008067          	ret
    80005148:	0014d493          	srli	s1,s1,0x1
    8000514c:	ffffe097          	auipc	ra,0xffffe
    80005150:	5e4080e7          	jalr	1508(ra) # 80003730 <mycpu>
    80005154:	0014f493          	andi	s1,s1,1
    80005158:	06952e23          	sw	s1,124(a0)
    8000515c:	fc5ff06f          	j	80005120 <push_on+0x34>

0000000080005160 <pop_on>:
    80005160:	ff010113          	addi	sp,sp,-16
    80005164:	00813023          	sd	s0,0(sp)
    80005168:	00113423          	sd	ra,8(sp)
    8000516c:	01010413          	addi	s0,sp,16
    80005170:	ffffe097          	auipc	ra,0xffffe
    80005174:	5c0080e7          	jalr	1472(ra) # 80003730 <mycpu>
    80005178:	100027f3          	csrr	a5,sstatus
    8000517c:	0027f793          	andi	a5,a5,2
    80005180:	04078463          	beqz	a5,800051c8 <pop_on+0x68>
    80005184:	07852783          	lw	a5,120(a0)
    80005188:	02f05863          	blez	a5,800051b8 <pop_on+0x58>
    8000518c:	fff7879b          	addiw	a5,a5,-1
    80005190:	06f52c23          	sw	a5,120(a0)
    80005194:	07853783          	ld	a5,120(a0)
    80005198:	00079863          	bnez	a5,800051a8 <pop_on+0x48>
    8000519c:	100027f3          	csrr	a5,sstatus
    800051a0:	ffd7f793          	andi	a5,a5,-3
    800051a4:	10079073          	csrw	sstatus,a5
    800051a8:	00813083          	ld	ra,8(sp)
    800051ac:	00013403          	ld	s0,0(sp)
    800051b0:	01010113          	addi	sp,sp,16
    800051b4:	00008067          	ret
    800051b8:	00001517          	auipc	a0,0x1
    800051bc:	03050513          	addi	a0,a0,48 # 800061e8 <digits+0x70>
    800051c0:	fffff097          	auipc	ra,0xfffff
    800051c4:	f2c080e7          	jalr	-212(ra) # 800040ec <panic>
    800051c8:	00001517          	auipc	a0,0x1
    800051cc:	00050513          	mv	a0,a0
    800051d0:	fffff097          	auipc	ra,0xfffff
    800051d4:	f1c080e7          	jalr	-228(ra) # 800040ec <panic>

00000000800051d8 <__memset>:
    800051d8:	ff010113          	addi	sp,sp,-16
    800051dc:	00813423          	sd	s0,8(sp)
    800051e0:	01010413          	addi	s0,sp,16
    800051e4:	1a060e63          	beqz	a2,800053a0 <__memset+0x1c8>
    800051e8:	40a007b3          	neg	a5,a0
    800051ec:	0077f793          	andi	a5,a5,7
    800051f0:	00778693          	addi	a3,a5,7
    800051f4:	00b00813          	li	a6,11
    800051f8:	0ff5f593          	andi	a1,a1,255
    800051fc:	fff6071b          	addiw	a4,a2,-1
    80005200:	1b06e663          	bltu	a3,a6,800053ac <__memset+0x1d4>
    80005204:	1cd76463          	bltu	a4,a3,800053cc <__memset+0x1f4>
    80005208:	1a078e63          	beqz	a5,800053c4 <__memset+0x1ec>
    8000520c:	00b50023          	sb	a1,0(a0) # 800061c8 <digits+0x50>
    80005210:	00100713          	li	a4,1
    80005214:	1ae78463          	beq	a5,a4,800053bc <__memset+0x1e4>
    80005218:	00b500a3          	sb	a1,1(a0)
    8000521c:	00200713          	li	a4,2
    80005220:	1ae78a63          	beq	a5,a4,800053d4 <__memset+0x1fc>
    80005224:	00b50123          	sb	a1,2(a0)
    80005228:	00300713          	li	a4,3
    8000522c:	18e78463          	beq	a5,a4,800053b4 <__memset+0x1dc>
    80005230:	00b501a3          	sb	a1,3(a0)
    80005234:	00400713          	li	a4,4
    80005238:	1ae78263          	beq	a5,a4,800053dc <__memset+0x204>
    8000523c:	00b50223          	sb	a1,4(a0)
    80005240:	00500713          	li	a4,5
    80005244:	1ae78063          	beq	a5,a4,800053e4 <__memset+0x20c>
    80005248:	00b502a3          	sb	a1,5(a0)
    8000524c:	00700713          	li	a4,7
    80005250:	18e79e63          	bne	a5,a4,800053ec <__memset+0x214>
    80005254:	00b50323          	sb	a1,6(a0)
    80005258:	00700e93          	li	t4,7
    8000525c:	00859713          	slli	a4,a1,0x8
    80005260:	00e5e733          	or	a4,a1,a4
    80005264:	01059e13          	slli	t3,a1,0x10
    80005268:	01c76e33          	or	t3,a4,t3
    8000526c:	01859313          	slli	t1,a1,0x18
    80005270:	006e6333          	or	t1,t3,t1
    80005274:	02059893          	slli	a7,a1,0x20
    80005278:	40f60e3b          	subw	t3,a2,a5
    8000527c:	011368b3          	or	a7,t1,a7
    80005280:	02859813          	slli	a6,a1,0x28
    80005284:	0108e833          	or	a6,a7,a6
    80005288:	03059693          	slli	a3,a1,0x30
    8000528c:	003e589b          	srliw	a7,t3,0x3
    80005290:	00d866b3          	or	a3,a6,a3
    80005294:	03859713          	slli	a4,a1,0x38
    80005298:	00389813          	slli	a6,a7,0x3
    8000529c:	00f507b3          	add	a5,a0,a5
    800052a0:	00e6e733          	or	a4,a3,a4
    800052a4:	000e089b          	sext.w	a7,t3
    800052a8:	00f806b3          	add	a3,a6,a5
    800052ac:	00e7b023          	sd	a4,0(a5)
    800052b0:	00878793          	addi	a5,a5,8
    800052b4:	fed79ce3          	bne	a5,a3,800052ac <__memset+0xd4>
    800052b8:	ff8e7793          	andi	a5,t3,-8
    800052bc:	0007871b          	sext.w	a4,a5
    800052c0:	01d787bb          	addw	a5,a5,t4
    800052c4:	0ce88e63          	beq	a7,a4,800053a0 <__memset+0x1c8>
    800052c8:	00f50733          	add	a4,a0,a5
    800052cc:	00b70023          	sb	a1,0(a4)
    800052d0:	0017871b          	addiw	a4,a5,1
    800052d4:	0cc77663          	bgeu	a4,a2,800053a0 <__memset+0x1c8>
    800052d8:	00e50733          	add	a4,a0,a4
    800052dc:	00b70023          	sb	a1,0(a4)
    800052e0:	0027871b          	addiw	a4,a5,2
    800052e4:	0ac77e63          	bgeu	a4,a2,800053a0 <__memset+0x1c8>
    800052e8:	00e50733          	add	a4,a0,a4
    800052ec:	00b70023          	sb	a1,0(a4)
    800052f0:	0037871b          	addiw	a4,a5,3
    800052f4:	0ac77663          	bgeu	a4,a2,800053a0 <__memset+0x1c8>
    800052f8:	00e50733          	add	a4,a0,a4
    800052fc:	00b70023          	sb	a1,0(a4)
    80005300:	0047871b          	addiw	a4,a5,4
    80005304:	08c77e63          	bgeu	a4,a2,800053a0 <__memset+0x1c8>
    80005308:	00e50733          	add	a4,a0,a4
    8000530c:	00b70023          	sb	a1,0(a4)
    80005310:	0057871b          	addiw	a4,a5,5
    80005314:	08c77663          	bgeu	a4,a2,800053a0 <__memset+0x1c8>
    80005318:	00e50733          	add	a4,a0,a4
    8000531c:	00b70023          	sb	a1,0(a4)
    80005320:	0067871b          	addiw	a4,a5,6
    80005324:	06c77e63          	bgeu	a4,a2,800053a0 <__memset+0x1c8>
    80005328:	00e50733          	add	a4,a0,a4
    8000532c:	00b70023          	sb	a1,0(a4)
    80005330:	0077871b          	addiw	a4,a5,7
    80005334:	06c77663          	bgeu	a4,a2,800053a0 <__memset+0x1c8>
    80005338:	00e50733          	add	a4,a0,a4
    8000533c:	00b70023          	sb	a1,0(a4)
    80005340:	0087871b          	addiw	a4,a5,8
    80005344:	04c77e63          	bgeu	a4,a2,800053a0 <__memset+0x1c8>
    80005348:	00e50733          	add	a4,a0,a4
    8000534c:	00b70023          	sb	a1,0(a4)
    80005350:	0097871b          	addiw	a4,a5,9
    80005354:	04c77663          	bgeu	a4,a2,800053a0 <__memset+0x1c8>
    80005358:	00e50733          	add	a4,a0,a4
    8000535c:	00b70023          	sb	a1,0(a4)
    80005360:	00a7871b          	addiw	a4,a5,10
    80005364:	02c77e63          	bgeu	a4,a2,800053a0 <__memset+0x1c8>
    80005368:	00e50733          	add	a4,a0,a4
    8000536c:	00b70023          	sb	a1,0(a4)
    80005370:	00b7871b          	addiw	a4,a5,11
    80005374:	02c77663          	bgeu	a4,a2,800053a0 <__memset+0x1c8>
    80005378:	00e50733          	add	a4,a0,a4
    8000537c:	00b70023          	sb	a1,0(a4)
    80005380:	00c7871b          	addiw	a4,a5,12
    80005384:	00c77e63          	bgeu	a4,a2,800053a0 <__memset+0x1c8>
    80005388:	00e50733          	add	a4,a0,a4
    8000538c:	00b70023          	sb	a1,0(a4)
    80005390:	00d7879b          	addiw	a5,a5,13
    80005394:	00c7f663          	bgeu	a5,a2,800053a0 <__memset+0x1c8>
    80005398:	00f507b3          	add	a5,a0,a5
    8000539c:	00b78023          	sb	a1,0(a5)
    800053a0:	00813403          	ld	s0,8(sp)
    800053a4:	01010113          	addi	sp,sp,16
    800053a8:	00008067          	ret
    800053ac:	00b00693          	li	a3,11
    800053b0:	e55ff06f          	j	80005204 <__memset+0x2c>
    800053b4:	00300e93          	li	t4,3
    800053b8:	ea5ff06f          	j	8000525c <__memset+0x84>
    800053bc:	00100e93          	li	t4,1
    800053c0:	e9dff06f          	j	8000525c <__memset+0x84>
    800053c4:	00000e93          	li	t4,0
    800053c8:	e95ff06f          	j	8000525c <__memset+0x84>
    800053cc:	00000793          	li	a5,0
    800053d0:	ef9ff06f          	j	800052c8 <__memset+0xf0>
    800053d4:	00200e93          	li	t4,2
    800053d8:	e85ff06f          	j	8000525c <__memset+0x84>
    800053dc:	00400e93          	li	t4,4
    800053e0:	e7dff06f          	j	8000525c <__memset+0x84>
    800053e4:	00500e93          	li	t4,5
    800053e8:	e75ff06f          	j	8000525c <__memset+0x84>
    800053ec:	00600e93          	li	t4,6
    800053f0:	e6dff06f          	j	8000525c <__memset+0x84>

00000000800053f4 <__memmove>:
    800053f4:	ff010113          	addi	sp,sp,-16
    800053f8:	00813423          	sd	s0,8(sp)
    800053fc:	01010413          	addi	s0,sp,16
    80005400:	0e060863          	beqz	a2,800054f0 <__memmove+0xfc>
    80005404:	fff6069b          	addiw	a3,a2,-1
    80005408:	0006881b          	sext.w	a6,a3
    8000540c:	0ea5e863          	bltu	a1,a0,800054fc <__memmove+0x108>
    80005410:	00758713          	addi	a4,a1,7
    80005414:	00a5e7b3          	or	a5,a1,a0
    80005418:	40a70733          	sub	a4,a4,a0
    8000541c:	0077f793          	andi	a5,a5,7
    80005420:	00f73713          	sltiu	a4,a4,15
    80005424:	00174713          	xori	a4,a4,1
    80005428:	0017b793          	seqz	a5,a5
    8000542c:	00e7f7b3          	and	a5,a5,a4
    80005430:	10078863          	beqz	a5,80005540 <__memmove+0x14c>
    80005434:	00900793          	li	a5,9
    80005438:	1107f463          	bgeu	a5,a6,80005540 <__memmove+0x14c>
    8000543c:	0036581b          	srliw	a6,a2,0x3
    80005440:	fff8081b          	addiw	a6,a6,-1
    80005444:	02081813          	slli	a6,a6,0x20
    80005448:	01d85893          	srli	a7,a6,0x1d
    8000544c:	00858813          	addi	a6,a1,8
    80005450:	00058793          	mv	a5,a1
    80005454:	00050713          	mv	a4,a0
    80005458:	01088833          	add	a6,a7,a6
    8000545c:	0007b883          	ld	a7,0(a5)
    80005460:	00878793          	addi	a5,a5,8
    80005464:	00870713          	addi	a4,a4,8
    80005468:	ff173c23          	sd	a7,-8(a4)
    8000546c:	ff0798e3          	bne	a5,a6,8000545c <__memmove+0x68>
    80005470:	ff867713          	andi	a4,a2,-8
    80005474:	02071793          	slli	a5,a4,0x20
    80005478:	0207d793          	srli	a5,a5,0x20
    8000547c:	00f585b3          	add	a1,a1,a5
    80005480:	40e686bb          	subw	a3,a3,a4
    80005484:	00f507b3          	add	a5,a0,a5
    80005488:	06e60463          	beq	a2,a4,800054f0 <__memmove+0xfc>
    8000548c:	0005c703          	lbu	a4,0(a1)
    80005490:	00e78023          	sb	a4,0(a5)
    80005494:	04068e63          	beqz	a3,800054f0 <__memmove+0xfc>
    80005498:	0015c603          	lbu	a2,1(a1)
    8000549c:	00100713          	li	a4,1
    800054a0:	00c780a3          	sb	a2,1(a5)
    800054a4:	04e68663          	beq	a3,a4,800054f0 <__memmove+0xfc>
    800054a8:	0025c603          	lbu	a2,2(a1)
    800054ac:	00200713          	li	a4,2
    800054b0:	00c78123          	sb	a2,2(a5)
    800054b4:	02e68e63          	beq	a3,a4,800054f0 <__memmove+0xfc>
    800054b8:	0035c603          	lbu	a2,3(a1)
    800054bc:	00300713          	li	a4,3
    800054c0:	00c781a3          	sb	a2,3(a5)
    800054c4:	02e68663          	beq	a3,a4,800054f0 <__memmove+0xfc>
    800054c8:	0045c603          	lbu	a2,4(a1)
    800054cc:	00400713          	li	a4,4
    800054d0:	00c78223          	sb	a2,4(a5)
    800054d4:	00e68e63          	beq	a3,a4,800054f0 <__memmove+0xfc>
    800054d8:	0055c603          	lbu	a2,5(a1)
    800054dc:	00500713          	li	a4,5
    800054e0:	00c782a3          	sb	a2,5(a5)
    800054e4:	00e68663          	beq	a3,a4,800054f0 <__memmove+0xfc>
    800054e8:	0065c703          	lbu	a4,6(a1)
    800054ec:	00e78323          	sb	a4,6(a5)
    800054f0:	00813403          	ld	s0,8(sp)
    800054f4:	01010113          	addi	sp,sp,16
    800054f8:	00008067          	ret
    800054fc:	02061713          	slli	a4,a2,0x20
    80005500:	02075713          	srli	a4,a4,0x20
    80005504:	00e587b3          	add	a5,a1,a4
    80005508:	f0f574e3          	bgeu	a0,a5,80005410 <__memmove+0x1c>
    8000550c:	02069613          	slli	a2,a3,0x20
    80005510:	02065613          	srli	a2,a2,0x20
    80005514:	fff64613          	not	a2,a2
    80005518:	00e50733          	add	a4,a0,a4
    8000551c:	00c78633          	add	a2,a5,a2
    80005520:	fff7c683          	lbu	a3,-1(a5)
    80005524:	fff78793          	addi	a5,a5,-1
    80005528:	fff70713          	addi	a4,a4,-1
    8000552c:	00d70023          	sb	a3,0(a4)
    80005530:	fec798e3          	bne	a5,a2,80005520 <__memmove+0x12c>
    80005534:	00813403          	ld	s0,8(sp)
    80005538:	01010113          	addi	sp,sp,16
    8000553c:	00008067          	ret
    80005540:	02069713          	slli	a4,a3,0x20
    80005544:	02075713          	srli	a4,a4,0x20
    80005548:	00170713          	addi	a4,a4,1
    8000554c:	00e50733          	add	a4,a0,a4
    80005550:	00050793          	mv	a5,a0
    80005554:	0005c683          	lbu	a3,0(a1)
    80005558:	00178793          	addi	a5,a5,1
    8000555c:	00158593          	addi	a1,a1,1
    80005560:	fed78fa3          	sb	a3,-1(a5)
    80005564:	fee798e3          	bne	a5,a4,80005554 <__memmove+0x160>
    80005568:	f89ff06f          	j	800054f0 <__memmove+0xfc>
	...
