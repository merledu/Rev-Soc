// SPDX-License-Identifier: Apache-2.0
// Copyright 2019 Western Digital Corporation or its affiliates.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

// Assembly code for Hello World
// Not using only ALU ops for creating the string

#define STDOUT 0xd0580000
#define BASE_SOC 0x80001000
#define LEDs_ADDR    0x80001010
#define SWs_ADDR    0x80001012
#define BASE_CSR 0x10000000
#define FIN_CSR 0x1FFFFFFF
#define RV_PIC_BASE_ADDR BASE_CSR

/*The external interrupt vector table resides either in the DCCM, SoC memory, 
or a dedicated flop array in the core.*/
#define RV_DCCM 0x80000
#define RV_ICCM 0x40000
#define RV_VECTOR_TABLE_BASE (0xC0000000 >> 10)


#define meivt 0xBC8
#define meipt 0xBC9
#define meicpct 0xBCA
#define meicidpl 0xBCB
#define meicurpl 0xBCC
#define meihap 0xFC8
#define mie 0x304
#define ID_INT 3
#define RV_PIC_MEIGWCTRL_OFFSET 0x4000 //0x4000 + 4*S, the product is done within the macro
#define RV_PIC_MEIGWCLR_OFFSET 0x5000 //0x5000 + 4*S, the product is done within the macro
#define RV_PIC_MEIPL_OFFSET 0x0
#define RV_PIC_MEIE_OFFSET 0x2000
#define RV_PIC_MPICCFG_OFFSET 0x3000
#define RV_PIC_MEIPT_OFFSET meipt
#define RV_PIC_MEICIDPL_OFFSET meicidpl
#define RV_PIC_MEICURPL_OFFSET meicurpl


.macro disable_ext_int
// Clear MIE[miep]
disable_ext_int_\@:
    li a0, 0
    csrw mie, a0
.endm
          
.macro enable_ext_int
enable_ext_int_\@:
// Set MIE[miep]
    li a0, (1<<11)
    csrrs zero, mie, a0
.endm

.macro init_priorityorder priord
init_priorityorder_\@:
    li tp, (RV_PIC_BASE_ADDR + RV_PIC_MPICCFG_OFFSET)
    li t0, \priord
    sw t0, 0(tp)
.endm

.macro init_nstthresholds threshold
init_nstthresholds_\@:
    li t0, \threshold
    li tp, (RV_PIC_BASE_ADDR + RV_PIC_MEICIDPL_OFFSET)
    sw t0, 0(tp)
    li tp, (RV_PIC_BASE_ADDR + RV_PIC_MEICURPL_OFFSET)
    sw t0, 0(tp)
.endm

.macro set_threshold threshold
set_threshold_\@:
    li tp, (RV_PIC_BASE_ADDR + RV_PIC_MEIPT_OFFSET)
    li t0, \threshold
    sw t0, 0(tp)
.endm

.macro enable_interrupt id
enable_interrupt_\@:
    li tp, (RV_PIC_BASE_ADDR + RV_PIC_MEIE_OFFSET + (\id <<2))
    li t0, 1
    sw t0, 0(tp)
.endm

.macro set_priority id, priority
set_priority_\@:
    li tp, (RV_PIC_BASE_ADDR + RV_PIC_MEIPL_OFFSET + (\id <<2))
    li t0, \priority
    sw t0, 0(tp)
.endm

.macro init_gateway id, polarity, type
init_gateway_\@:
    li tp, (RV_PIC_BASE_ADDR + RV_PIC_MEIGWCTRL_OFFSET + (\id <<2))
    li t0, ((\type<<1) | \polarity)
    sw t0, 0(tp)
.endm

.macro clear_gateway id
clear_gateway_\@:
    li tp, (RV_PIC_BASE_ADDR + RV_PIC_MEIGWCLR_OFFSET + (\id <<2))
    sw zero, 0(tp)
.endm


.macro set_pointer_to_trapvec vector_address
set_pointer_to_trapvec_\@:
    la tp,(\vector_address<<10) 
    csrw meivt,tp
.endm








// Code to execute
.section .text
.global _start
_start:

    // Clear minstret
    csrw minstret, zero
    csrw minstreth, zero

    disable_ext_int   // Disabling interrupt  by Writing 0 to mie csr 
    init_priorityorder 0  // Setting default priority order Zero lowest 15 highest by writing 0 to priord csr
    init_gateway 1, 0, 0    // gateway is set through meigwclrS  S->  Id is the source number polarity == 0 is active high interrupt , Type == 0 is level trigereed interrupt
    set_pointer_to_trapvec Interrupt_handler /// Settig mtvec to point to the handler adress
    set_priority 1,15  // Setting Priority  first arg is id and second is its corresponding priority
    set_threshold 0 // setting thershold to zero
    init_nstthresholds 0 // setting nest thershold to zero
    




// Write 0xff to STDOUT for TB to termiate test.
_finish:
    li x3, STDOUT
    addi x5, x0, 0xff
    sb x5, 0(x3)
    beq x0, x0, _finish
.rept 100
    nop
.endr

.end



Interrupt_handler:




mret