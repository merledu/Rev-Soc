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

   loop:
    lb x5, 0(x4)
    sb x5, 0(x3)
    addi x4, x4, 1
    li x6, 0xdeadbeef
    li x7, 0xf004f000
    fmv.s.x f6,x6
    fmv.s.x f7,x7
    li x8,8
    li x9,14
    extract_data:
    addi x9,x9,-1
    fsw f6, 0(x7)
    addi x7,x7,4
    bne x8,x9, extract_data
    li x10, 0xf00400ff
    fsw f6,0(x10)
    bnez x5, loop

// Write 0xff to STDOUT for TB to termiate test.
_finish:
    li x3, STDOUT
    addi x5, x0, 0x1
    sb x5, 0(x3)
    beq x0, x0, _finish
.rept 100
    nop
.endr

//.data
//hw_data:
//.ascii "----------------------------------\n"
//.ascii "Hello World from SweRV EL2 @WDC !!\n"
//.ascii "----------------------------------\n"
//.byte 0
