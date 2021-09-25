/*/*

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
#define mdseac 0xFC0
#define BASE_SOC 0x80001000
#define LEDs_ADDR    0x80001010
#define SWs_ADDR    0x80001012

#define FIN_CSR 0x1FFFFFFF
#define mtval 0x343
#define RV_VECTOR_TABLE_BASE (0xC0000000 >> 10)
#define mdeau 0xBC0
#define RV_ICCM 0x40000
#define RV_DCCM 0x80000
//
//
#define meivt 0xBC8
#define meipt 0xBC9
#define meicpct 0xBCA
#define meicidpl 0xBCB
#define mstatus 0x300
#define meicurpl 0xBCC
#define meihap 0xFC8
#define mie 0x304
#define RV_PIC_MEIGWCTRL_OFFSET 0x4000 //0x4000 + 4*S, the product is done within the macro
#define RV_PIC_MEIGWCLR_OFFSET 0x5000 //0x5000 + 4*S, the product is done within the macro
#define RV_PIC_MEIPL_OFFSET 0x0
#define RV_PIC_MEIE_OFFSET 0x2000
#define RV_PIC_MPICCFG_OFFSET 0x3000
#define RV_PIC_MEIPT_OFFSET meipt
#define RV_PIC_MEICIDPL_OFFSET meicidpl
#define RV_PIC_MEICURPL_OFFSET meicurpl
#define RV_PIC_BASE_ADDR 0xf00c0000
#define MEIE_BASE 0x2000
#define MEIP_BASE 0x1000


.macro disable_ext_int
// Clear MIE[miep]
disable_ext_int_\@:
    li t5, 0
    csrw mie, t5
    csrw mstatus,t5
.endm
          
.macro enable_ext_int
enable_ext_int_\@:
// Set MIE[miep]
     li t5,0x800
     csrw mie,t5
 csrwi mstatus,0x8
    
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
    //li t5,0x8
   // csrw mstatus,t5
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



// Macro to set mtvec to point to Interrupt handler
.macro set_pointer_adress handler_address
set_pointer_adress\@:
csrr tp, meivt
la t0, \handler_address 
slli t0,t0,10
andi t1, tp, 0x3ff //Keep the 10 ls bits
or t0, t0, t1 //Concatenate
csrw meivt, t0
.endm


/////////////////////////////////////////////////////////////////

/*.macro disable_ext_int
// Clear MIE[miep]
disable_ext_int_\@:
li a0, (1<<11)
li t5,0xffff
csrw mstatus,t5
csrrc zero, mie, a0
.endm

//Enable external interrupt:
.macro enable_ext_int
enable_ext_int_\@:
// Set MIE[miep]
li a0, (1<<11)
csrrs zero, mie, a0
.endm

//Initialize external interrupt priority order:
.macro init_priorityorder priord
init_priorityorder_\@:
li tp, (RV_PIC_BASE_ADDR + RV_PIC_MPICCFG_OFFSET)
li t0, \priord
sw t0, 0(tp)
.endm

//Initialize external interrupt nesting priority thresholds:
.macro init_nstthresholds threshold
init_nstthresholds_\@:
li t0, \threshold
li tp, (RV_PIC_BASE_ADDR + RV_PIC_MEICIDPL_OFFSET)
sw t0, 0(tp)
li tp, (RV_PIC_BASE_ADDR + RV_PIC_MEICURPL_OFFSET)
sw t0, 0(tp)
.endm

//Set external interrupt priority threshold:
.macro set_threshold threshold
set_threshold_\@:
li tp, (RV_PIC_BASE_ADDR + RV_PIC_MEIPT_OFFSET)
li t0, \threshold
sw t0, 0(tp)
.endm

//Enable interrupt for source id:
.macro enable_interrupt id
enable_interrupt_\@:
li tp, (RV_PIC_BASE_ADDR + RV_PIC_MEIE_OFFSET + (\id <<2))
li t0, 1
sw t0, 0(tp)
.endm

//Set priority of source id:
.macro set_priority id, priority
set_priority_\@:
li tp, (RV_PIC_BASE_ADDR + RV_PIC_MEIPL_OFFSET + (\id <<2))
li t0, \priority
sw t0, 0(tp)
.endm

//Initialize gateway of source id:
.macro init_gateway id, polarity, type
init_gateway_\@:
li tp, (RV_PIC_BASE_ADDR + RV_PIC_MEIGWCTRL_OFFSET + (\id <<2))
li t0, ((\type<<1) | \polarity)
sw t0, 0(tp)
.endm

//Clear gateway of source id:
.macro clear_gateway id
clear_gateway_\@:
li tp, (RV_PIC_BASE_ADDR + RV_PIC_MEIGWCLR_OFFSET + (\id <<2))
sw zero, 0(tp)
.endm

*/
/////////////////////////////////////////////////////////////////

/*
// Code to execute
.section .text
.global _start
_start:

    // Clear minstret
    //csrw minstret, zero
    //csrw minstreth, zero

    disable_ext_int   // Disabling interrupt  by Writing 0 to mie csr
  

    init_priorityorder 0x0  // Setting default priority order Zero lowest 15 highest by writing 0 to priord csr
     init_gateway 0x2,0x0, 0x0    // gateway is set through meigwclrS  S->  Id is the source number polarity == 0 is active high interrupt , Type == 0 is level trigereed interrupt
     clear_gateway 0x2
     // set_pointer_adress interrupt_handler /// Settig mtvec to point to the handler adress
   //  set_priority 0x2,0x000f  // Setting Priority  first arg is id and second is its corresponding priority
    //  set_threshold 0x1 // setting thershold to zero
   //  init_nstthresholds 0x0 // setting nest thershold to zero
    //  enable_interrupt 0x2  // id 1 is given to enable interrupt for that
   enable_ext_int
   //disable_ext_int
   //enable_ext_int





//////////////////////////////////////////////////
/*disable_ext_int     //Program global threshold to 1                 
set_threshold 1     //Configure gateway id=5 to edge-triggered/low  
init_gateway 2, 1, 1//Clear gateway id=5                             
clear_gateway 2     //Set id=5 threshold at 7                       
set_priority 2, 7   //Enable id=5                                   
enable_interrupt 2  //Enable interrupts (MIE[meip]=1)               
enable_ext_int
  */ 
////////////////////////////////////////////////////////     
      
     
      /*
         

   .rept 100
    
    addi t5,t5,1

   .endr




// Write 0xff to STDOUT for TB to termiate test.
_finish:
    li x3, STDOUT
    addi x5, x0, 0xff
    sb x5, 0(x3)
    beq x0, x0, _finish
.rept 100
    nop
.endr

/*

interrupt_handler:
li t2,1
csrw meicpct,t2
csrr t5,meihap
beq t5,t2,EXT_TIMER_ROUTINE


mret

EXT_TIMER_ROUTINE:
    
disable_ext_int               
clear_gateway 2          
mret
*/   
     

/*

.end*/

#define STDOUT 0xd0580000
#define BASE_SOC 0x80001000
#define BASE_CSR 0x10000000
#define FIN_CSR 0x1FFFFFFF

#define RV_PIC_BASE_ADDR 0xF00C0000
#define RV_PIC_OFFSET 0xC0000

/*The external interrupt vector table resides either in the DCCM, SoC memory, 
or a dedicated flop array in the core.*/
#define RV_VECTOR_TABLE_BASE 0x07000000//Stored in RAM
#define RV_VECTOR_TABLE_BASE_SHIFTED (RV_VECTOR_TABLE_BASE >> 10)//Stored in RAM

#define meivt 0xBC8
#define meipt 0xBC9
#define meicpct 0xBCA
#define meicidpl 0xBCB
#define meicurpl 0xBCC
#define meihap 0xFC8
#define mie 0x304

#define RV_PIC_MEIGWCTRL_OFFSET 0x4000 //0x4000 + 4*S, the product is done within the macro
#define RV_PIC_MEIGWCLR_OFFSET 0x5000 //0x5000 + 4*S, the product is done within the macro
#define RV_PIC_MEIPL_OFFSET 0x0//The offset is 0x0, although the first position is reserved
#define RV_PIC_MEIP_OFFSET 0x1000
#define RV_PIC_MEIE_OFFSET 0x2000
#define RV_PIC_MPICCFG_OFFSET 0x3000
#define RV_PIC_MEIPT_OFFSET 0x3004




.macro disable_ext_int
// Clear MIE[miep]
disable_ext_int_\@:
    li a0, (1<<11)
    csrrc zero, mie, a0
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
    //li tp, (RV_PIC_BASE_ADDR + RV_PIC_MEICIDPL_OFFSET)
    //sw t0, 0(tp)
    csrw meicidpl, t0
    //li tp, (RV_PIC_BASE_ADDR + RV_PIC_MEICURPL_OFFSET)
    //sw t0, 0(tp)
    csrw meicurpl, t0
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

.macro disable_interrupt id
disable_interrupt_\@:
    li tp, (RV_PIC_BASE_ADDR + RV_PIC_MEIE_OFFSET + (\id <<2))
    li t0, 0
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
    li t0, ((\polarity<<1) | \type)
    sw t0, 0(tp)
.endm

.macro clear_gateway id
clear_gateway_\@:
    li tp, (RV_PIC_BASE_ADDR + RV_PIC_MEIGWCLR_OFFSET + (\id <<2))
    sw zero, 0(tp)
.endm

.globl _start
_start:



/*INIT CONFIG FOR INTERRUPTS*/
//SEE SECTION 5.5.1
disable_ext_int // Disable interrupts (MIE[meip]=0)

//1
init_priorityorder 0  // Set priority to standard RISC-V order

//2
init_gateway 2, 0, 0 // Configure gateway id=5 (first param) to edge-triggered/low
clear_gateway 2 // Clear gateway id=5

//3
//init_vector_table //Init the vector table
jal init_vector_table_rt //Init the vector table


li a0, 0x2 // id=5
la a1, eint_handler
jal ra, init_handler_rt //Call init_handler_rt

//Load the trap_vector into mtvec
la a0, trap_vector 
jal ra, init_trap_vector_rt


//4
set_priority 2, 15 // Set id=5 threshold at 15

//5
set_threshold 1 // Program global threshold to 1

//6
init_nstthresholds 0  // Initialize nesting thresholds to 0

//7
enable_interrupt 2 // Enable id=1

enable_ext_int // Enable interrupts (MIE[meip]=1)

//Others
//Set mstatus[mei]=1
csrr tp, mstatus 
ori tp, tp, 0x8// (1 << 3)
csrw mstatus, tp

.rept 100 
    nop
.endr
//if (clk_cnt < 1000)
 // interrupt <= 1'b0;
  //else if (clk_cnt >= 1000 && clk_cnt < 2000  ) 
  //interrupt <= 1'b1;
 // else if(clk_cnt >= 2000 && clk_cnt < 3000 )
 // interrupt <= 1'b0;
  //else if(clk_cnt >= 3000 && clk_cnt < 4000 )
 //
 _finish:
    li x3, STDOUT
    addi t6, x0, 0xff
    sb t6, 0(x3)
    beq x0, x0, _finish
.rept 100 
    nop
.endr

init_vector_table_rt:
csrr tp, meivt
li t0, (RV_VECTOR_TABLE_BASE_SHIFTED<<10) 
andi t1, tp, 0x3ff //Keep the 10 ls bits
or t0, t0, t1 //Concatenate
csrw meivt, t0
ret

init_handler_rt:
//a0=source
//a1=handler_address
slli tp, a0, 2
li t0, RV_VECTOR_TABLE_BASE
add tp, tp, t0
sw a1, 0(tp)
ret

init_trap_vector_rt:
//a0=trap_address
//slli t0, a0, 2 //Shift the address [31..2]
andi t0, a0, 0xFFFFFFFC //Base[31..2] maps with mtvec[31..2]
//addi t0, t0, 1 //+1 for the vectored mode
csrw mtvec, t0 //move
ret


trap_vector: // Interrupt trap starts here when MTVEC[mode]=1

csrwi meicpct, 1 // Capture winning claim id and priority
csrr t0, meihap // Load pointer index
lw t1, 0(t0) // Load vector address
jr t1 // Go there


eint_handler:
/*
// Do some useful interrupt handling
li  a1, SWs_ADDR         # Read the Switches
lw  t0, 0(a1)
 
li  a0, LEDs_ADDR        # Write the LEDs
srl t0, t0, 16
sw  t0, 0(a0)

*/


//Clear interrupt pending register
mv x1, x0
li t0, (RV_PIC_BASE_ADDR + RV_PIC_MEIGWCLR_OFFSET + 0x8)
sw x1, 0(t0)
lw t1, 0(t0)
//Disable ext int
csrr tp, mstatus 
ori tp, tp, 0x0// (1 << 3)
csrw mstatus, tp

disable_ext_int
disable_interrupt 2 // Disable id
// Mask all
set_priority 2 , 0
csrr tp, mip
andi t0, tp, 0x7FF // I do not know why I cannot use more bits
csrw mip, t0

mret

.end


mret // Return from ISR

.end
