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

// Assembly code for Multithreaded Hello World
// Not using only ALU ops for creating the string


#include "defines.h"

#define STDOUT 0xd0580000



// Code to execute
.section .text
.global _start
_start:
 
  
  // li x1, 0x5f555555
 //  csrw 0x7c0, x1

     csrw minstret, zero
     csrw minstreth, zero

     li x4, 4        // Neccessary for terminating code
     csrw 0x7f9 ,x4  // Neccessary for terminating code
  
     li s0, 0xf0040000  //dccm base address
     li s5,0xf0040100 //Queue Adress  

     addi s1,x0,5 //element 1 to push  INPUT   expected output should be 5 6 7 
     addi s2,x0,6 //element 2 to push  INPUT
     addi s3,x0,7 //element 3 to push  INPUT
         
     addi s4,x0,3 //size of queue      

     addi t0,x0,0 //counter initialization
     
     addi t1,x0,1 //
     addi t2,x0,2 //
     addi t3,x0,3 //
     
     jal ra,PUSH //JUMP to push elements
     j LOAD_QUEUE       //code will load Queue Elements

     PUSH:
     addi t0,t0,1 //counter increment
     beq t0,t1,PUSH1  //if count == 1 jump to push 1
     beq t0,t2,PUSH2  //if count == 2 jump to push 2
     beq t0,t3,PUSH3  //if count == 3 jump to push 3
     ret
     
     PUSH1:
     sb s1,0(s5) // save element 1 on first location of queue
     j PUSH      // jump to push function

     PUSH2:     
     sb s2,4(s5) // save element 2 on second location of queue
     j PUSH

     PUSH3:
     sb s3,8(s5) // save element 3 on third location of queue
     j PUSH

     LOAD_QUEUE:

     lb x5,0(s5) 
     lb x6,4(s5)
     lb x7,8(s5)
     
     li s6,STDOUT

     sb x5,0(s6)  //Sending element 1 to tb 
     sb x6,4(s6)  //Sending element 2 to tb
     sb x7,8(s6)  //Sending element 3 to tb



        
   
   
// Write 0xff to STDOUT for TB to termiate test.
_finish:
    li x3, STDOUT
    addi x5, x0, 0xff
    sb x5, 0(x3)
    beq x0, x0, _finish
.rept 100
    nop
.endr
