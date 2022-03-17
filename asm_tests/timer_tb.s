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

// Assembly code for TIMER Testing
// Not using only ALU ops for creating the string

// Peripheral Base Adresses
#include "defines.h"
#define STDOUT     0xd0580000

#define TIMER_BASE           0x20000100
#define PWM_BASE             0x20000200
#define UART_BASE            0x20000300
#define GPIO_BASE            0x20000400
#define SPI_BASE             0x20000500
#define I2C_BASE             0x20000600
// Register adresses
#define TIMER                0x0
#define CTRL                 0x4
#define CMP                  0x8
// Configurations 
#define PRESCALER_0_DISABLED 0x0
#define PRESCALER_1_DISABLED 0x8
#define PRESCALER_2_DISABLED 0x10
#define PRESCALER_3_DISABLED 0x18
#define PRESCALER_4_DISABLED 0x20
#define PRESCALER_5_DISABLED 0x28
#define PRESCALER_6_DISABLED 0x30
#define PRESCALER_7_DISABLED 0x38
#define PRESCALER_0_ENABLED  0x1
#define PRESCALER_1_ENABLED  0x9
#define PRESCALER_2_ENABLED  0x11
#define PRESCALER_3_ENABLED  0x19
#define PRESCALER_4_ENABLED  0x21
#define PRESCALER_5_ENABLED  0x29
#define PRESCALER_6_ENABLED  0x31
#define PRESCALER_7_ENABLED  0x39
#define MAX_CMP              0xFFFF_FFFF
         

// Code to execute
.section .text
.global _start
_start:
// Setting Compare reg  to 1
li t0,TIMER_BASE
li t1,0x1
sw t1,CMP(t0)

// Setting Prescaler to zero disabled by writing control reg

li t0,TIMER_BASE
li t1,PRESCALER_0_DISABLED
sw t1,CTRL(t0)


// Setting Prescaler to zero enabled by writing control reg

li t0,TIMER_BASE
li t1,PRESCALER_0_ENABLED
sw t1,CTRL(t0)

// Delay of some nops 
.rept 200
nop
.endr
// Setting Prescaler to zero disabled by writing control reg

li t0,TIMER_BASE
li t1,PRESCALER_0_DISABLED
sw t1,CTRL(t0)

// Setting Compare reg  to 2
li t0,TIMER_BASE
li t1,0x2
sw t1,CMP(t0)

// Setting Prescaler to zero enabled by writing control reg

li t0,TIMER_BASE
li t1,PRESCALER_1_ENABLED
sw t1,CTRL(t0)


.rept 500
    nop
.endr


// Setting Prescaler to zero disabled by writing control reg

li t0,TIMER_BASE
li t1,PRESCALER_0_DISABLED
sw t1,CTRL(t0)

// Setting Compare reg  to 10
li t0,TIMER_BASE
li t1,0xA
sw t1,CMP(t0)

// Setting Prescaler to zero enabled by writing control reg

li t0,TIMER_BASE
li t1,PRESCALER_0_ENABLED
sw t1,CTRL(t0)


.rept 1000
    nop
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
