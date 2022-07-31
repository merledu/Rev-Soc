# SPDX-License-Identifier: Apache-2.0
# Copyright 2020 Western Digital Corporation or its affiliates.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http:#www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# startup code to support HLL programs

#define STDOUT 0xd0580000
#define BASE_SOC 0x80000000
#define BASE_CSR 0x10000000
#define FIN_CSR 0x1FFFFFFF

#define 0xF00C0000 0xF00C0000
#define RV_PIC_OFFSET 0xC0000

/*The external interrupt vector table resides either in the DCCM, SoC memory, 
or a dedicated flop array in the core.*/
#define RV_VECTOR_TABLE_BASE 0x70000000#Stored in RAM
#define RV_VECTOR_TABLE_BASE_SHIFTED #(RV_VECTOR_TABLE_BASE >> 10)#Stored in RAM

#define meivt 0xBC8
#define meipt 0xBC9
#define meicpct 0xBCA
#define meicidpl 0xBCB
#define meicurpl 0xBCC
#define meihap 0xFC8
#define mie 0x304

#define RV_PIC_MEIGWCTRL_OFFSET 0x4000 #0x4000 + 4*S, the product is done within the macro
#define RV_PIC_MEIGWCLR_OFFSET 0x5000 #0x5000 + 4*S, the product is done within the macro
#define RV_PIC_MEIPL_OFFSET 0x0#The offset is 0x0, although the first position is reserved
#define RV_PIC_MEIP_OFFSET 0x1000
#define RV_PIC_MEIE_OFFSET 0x2000
#define RV_PIC_MPICCFG_OFFSET 0x3000
#define RV_PIC_MEIPT_OFFSET 0x3004


# # Disable external interrupt:
# .macro disable_ext_int
# # # Clear MIE[miep]
# disable_ext_int_\@:
# li a0, (1<<11)
# csrrc zero, mie, a0
# .endm

# # Enable external interrupt:
# .macro enable_ext_int
# enable_ext_int_\@:
# # # Set MIE[miep]
# li a0, (1<<11)
# csrrs zero, mie, a0
# .endm

# # Initialize external interrupt priority order:
# .macro init_priorityorder priord
# init_priorityorder_\@:
# li tp, (0xF00C0000+ 0x3000)
# li t0, \priord
# sw t0, 0(tp)
# .endm

# # Initialize external interrupt nesting priority thresholds:
# .macro init_nstthresholds threshold
# init_nstthresholds_\@:
# li t0, \threshold
# li tp, (0xF00C0000 + 0xBCB)
# sw t0, 0(tp)
# li tp, (0xF00C0000 + 0xBCC)
# sw t0, 0(tp)
# .endm

# # Set external interrupt priority threshold:
# .macro set_threshold threshold
# set_threshold_\@:
# li tp, (0xF00C0000 + 0x3004)
# li t0, \threshold
# sw t0, 0(tp)
# .endm

# # Enable interrupt for source id:
# .macro enable_interrupt id
# enable_interrupt_\@:
# li tp, (0xF00C0000 + 0x2000 + (\id <<2))
# li t0, 1
# sw t0, 0(tp)
# .endm
# # Set priority of source id:
# .macro set_priority id, priority
# set_priority_\@:
# li tp, (0xF00C0000 + 0x0 + (\id <<2))
# li t0, \priority
# sw t0, 0(tp)
# .endm

# # Initialize gateway of source id:
# .macro init_gateway id, polarity, type
# init_gateway_\@:
# li tp, (0xF00C0000 + 0x4000 + (\id <<2))
# li t0, ((\type<<1) | \polarity)
# sw t0, 0(tp)
# .endm

# # Clear gateway of source id:
# .macro clear_gateway id
# clear_gateway_\@:
# li tp, (0xF00C0000 + 0x5000 + (\id <<2))
# sw zero, 0(tp)
# .endm

# .macro init_vector_table_rt
# init_vector_table_rt_\@:
# csrr tp, 0xBC8
# la t0, eint_handler
# slli t0,t0,0xA
# # li t0, (0x70000000<<10) 
# andi t1, tp, 0x3ff # #Keep the 10 ls bits
# or t0, t0, t1 # #Concatenate
# csrw 0xBC8, t0
# .endm

# # .macro init_handler_rt
# # init_handler_rt_\@:
# # li a0, 0x2 # id=2
# # la a1, eint_handler
# # #a0=source
# # #a1=handler_address
# # slli tp, a0, 2
# # li t0, 0x70000000
# # add tp, tp, t0
# # sw a1, 0(tp)
# # .endm

# .macro init_trap_vector_rt
# init_trap_vector_rt_\@:
# la a0, trap_vector 
# #a0=trap_address

# slli t0, a0, 2 #Shift the address [31..2]
# andi t0, a0, 0xFFFFFFFC #Base[31..2] maps with mtvec[31..2]
# addi t0, t0, 1 #+1 for the vectored mode
# csrw mtvec, t0 #move
# .endm

# # Code to jump to the interrupt handler from the RISC-V trap vector:
# trap_vector:
# # Interrupt trap starts here when MTVEC[mode]=1
# csrwi 0xBCA, 1 # Capture winning claim id and priority
# csrr t0, 0xFC8 # Load pointer index
# lw t1, 0(t0)
# # # Load vector address
# jr t1
# # # Go there

# # Code to handle the interrupt:
# eint_handler:
# disable_ext_int
# mret

.section .text.init
.global _start
_start:
# enable caching, except region 0xd
        li t0, 0x59555555
        csrw 0x7c0, t0
        li t1,0xd0580000
        la sp, STACK
# zero step
# disable_ext_int
# init_trap_vector_rt
# init_vector_table
# init_handler_rt
# # Step 1 configure priority order
# # Macro flow to initialize priority order:
# # To RISC-V standard order:
# init_priorityorder 0

# # step 2 set the polarity id and type of interrupt and clear the ip bit of gateway

# init_gateway 2, 1, 0
# clear_gateway 2

# # step 3 set base address of vector table
# init_vector_table_rt
# # step 4 set priority level
# set_priority 2, 7
# # step 5 set priority thershold
# set_threshold 1
# # step 6 set nesting priority thershold
# init_nstthresholds 0
# # step 7 enable interrupt for particula interrupt source
# enable_interrupt 2
# # last step
# enable_ext_int 

# # Set priority to standard RISC-V order
# # Initialize nesting thresholds to 0



        call main




.global _finish
_finish:
        la t0, tohost
        li t1, 0x1
        sb t1, 0(t0) # DemoTB test termination
        # li t1, 1
        # sw t1, 0(t0) # Whisper test termination
        beq x0, x0, _finish
        .rept 10
        nop
        .endr
.section .data.io
.global tohost
tohost: .word 0
