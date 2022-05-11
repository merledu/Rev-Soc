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

#define TIMER_BASE           0x20002000
#define GPIO_BASE            0x20004000
#define SPI_BASE             0x20006000
#define PWM_BASE             0x20008000
//#define UART_BASE            0x2000A000
//#define I2C_BASE             0x2000C000
// Register adresses
#define MODE_REG             0x0
#define DIR_REG              0x4
#define OUT_REG              0x8
#define IN_REG               0xc
#define TRIG_TYPE_REG        0x10
#define TRIG_LV0_REG         0x14
#define TRIG_LV1_REG         0x18
#define TRIG_STATUS_REG      0x1c
#define IRQ_EN_REG           0x20 

// Code to execute
.section .text
.global _start
_start:

// Setting Mode reg to Push pull by writing zero in it
li t0,GPIO_BASE
li t1,0x0
sw t1,MODE_REG(t0)

// Setting Direction 
li t1,0x1
sw t1,DIR_REG(t0)

// Setting Output
li t1,0x1
sw t1,OUT_REG(t0)
// setting trigger type
li t1,0x1
sw t1,TRIG_TYPE_REG(t0)
// setting trigger level0
li t1,0x0
sw t1,TRIG_LV0_REG(t0)
// setting trigger level1
li t1,0x0
sw t1,TRIG_LV1_REG(t0)
// setting Interrupt enable 
li t1,0x0
sw t1,IRQ_EN_REG(t0)



LOOP:
addi t0,t1,2
j LOOP



