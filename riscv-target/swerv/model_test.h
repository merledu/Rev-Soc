#ifndef _COMPLIANCE_MODEL_H
#define _COMPLIANCE_MODEL_H

#define RVMODEL_HALT                                              \
		la a0, begin_signature;	 \
                la a1, end_signature; \
                li a2, 0xf004f000; \
        extract_data: \
        		lw a4, 0(a0); \
        		beq a0, a1, halt; \
        		addi a0, a0, 4; \
                        addi a2, a2, 4; \
        		sw a4, 0(a2); \
        		j extract_data; \
        halt: \
        		li a5,0xf00400ff; \
                        sw a4,0(a5);            \
                        nop;


#define RVMODEL_DATA_BEGIN                                              \
    .align 4; .global begin_signature; begin_signature: \

#define RVMODEL_DATA_END                                                      \
    .align 4; .global end_signature; end_signature:   \


#define RVMODEL_BOOT \
.section .text.init;                                            \
        .align  4;                                                      \
        .globl _start;                                                  \
_start:  


#define LOCAL_IO_WRITE_STR(_STR) RVMODEL_IO_WRITE_STR(x31, _STR)
#define RVMODEL_IO_WRITE_STR(_SP, _STR)
#define LOCAL_IO_PUSH(_SP)
#define LOCAL_IO_POP(_SP)
#define RVMODEL_IO_ASSERT_GPR_EQ(_SP, _R, _I)
#define RVMODEL_IO_ASSERT_SFPR_EQ(_F, _R, _I)
#define RVMODEL_IO_ASSERT_DFPR_EQ(_D, _R, _I)

#define RVMODEL_SET_MSW_INT
#define RVMODEL_CLEAR_MSW_INT
#define RVMODEL_CLEAR_MTIMER_INT
#define RVMODEL_CLEAR_MEXT_INT

#endif // _COMPLIANCE_MODEL_H
