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


#include "defines.h"

#define STDOUT 0xd0580000


// Code to execute
.section .text
.global _start
_start:

    // Clear minstret
    csrw minstret, zero
    csrw minstreth, zero
    li x1, 0x5f555555
    csrw 0x7c0, x1
    li x1, 4
    csrw 0x7f9, x1

    li x8, 0xf0040000 // dccm address
    li x3, STDOUT	
    li x13, 0x1      // the number whose factorial needs to be calculated  1 till 10
    addi x9, x0, 0xA
    addi x6, x0, 0
    addi x11, x0, 1 // initial value
    addi x12, x0, 1 
    nop
    
store:    
    add x5, x0, x6 
    sw x5, 0(x8)
    addi x6, x6, 1
    addi x8, x8, 4
    bne x9, x6, store
    li x8, 0xf0040000
    j factorial_loop
    
next:
    sw x11, 0(x8) 
    addi x8, x8, 4
    sw x11, 0(x3)
    addi x3, x3, 4
    beq x13, x9,  _finish
    addi x13, x13, 1 
    addi x11, x0, 1  
    addi x12, x0, 1 
    
    
factorial_loop:
	mul x11, x11, x12
	beq x12, x13, next
	addi x12,x12,1
	j factorial_loop
	


   

// Write 0xff to STDOUT for TB to termiate test.
_finish:
    li x3, STDOUT
    addi x5, x0, 0xff
    sb x5, 0(x3)
    beq x0, x0, _finish
.rept 100
    nop
.endr


