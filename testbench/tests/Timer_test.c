/////////////////////////////////////////////////////////////////////////////////////////////////////////
// Company:       MICRO-ELECTRONICS RESEARCH LABORATORY                                                //
//                                                                                                     //
// Engineers:     Rehan Ejaz - Design Engineer                                                         //
//                                                                                                     //
// Additional contributions by:                                                                        //
//                                                                                                     //
// Create Date:   18.04.2022                                                                           //
// Design Name:   Timer test                                                                           //
// Project Name:  ReV-SoC                                                                              //
// Language:      SystemVerilog -                                                                      //
//                                                                                                     //
// Description:                                                                                        //
//  This is a simple C language testbench to configure timer by using the assmebler function           //
//                                                                                                     //
//                                                                                                     //
// Revision Date:                                                                                      //
//                                                                                                     //
/////////////////////////////////////////////////////////////////////////////////////////////////////////
#include <stdbool.h>
#include <stdint.h>
__asm__(                         // Declaration of DEFINES FOR ASSEMBLER
  ".equ TIMER_BASE, 0x20002000;"
  ".equ PWM_BASE  , 0x20004000;"
  ".equ UART_BASE , 0x20006000;"
  ".equ GPIO_BASE , 0x20008000;"
  ".equ SPI_BASE  , 0x2000A000;"
  ".equ I2C_BASE  , 0x2000E000;"
  ".equ CTRL      , 0x0;       "
  ".equ CFG       , 0x100;     "
  ".equ TIMER_L   , 0x104;     "
  ".equ TIMER_U   , 0x108;     "
  ".equ CMP_L     , 0x10c;     "
  ".equ CMP_U     , 0x110;     "
  ".equ INTR_EN   , 0x114;     ");

int main(){
  __asm__ __volatile__(
    // Setting CTRL disable  by writing 0
    "li t0,TIMER_BASE;"
    "li t1,0x0;"
    "sw t1,CTRL(t0);"
    // Setting prescaler to zero step to 1
    "li t0,TIMER_BASE;"
    "li t1,0x20001;"
    "sw t1,CFG(t0);"
    // Setting timer lower reg  to 0x0
    "li t1,0;"
    "sw t1,TIMER_L(t0);"
    // Setting timer upper reg  to 0x0
    "li t1,0;"
    "sw t1,TIMER_U(t0);"
    // Setting Compare lower reg  to 10
    "li t1,10;"
    "sw t1,CMP_L(t0);"
    // Setting Compare UPPER reg  to 0
    "li t1,0x0;"
    "sw t1,CMP_U(t0);"
    // Setting interrupt enable  by writing INTR_EN
    "li t0,TIMER_BASE;"
    "li t1,0x1;"
    "sw t1,INTR_EN(t0);"
    // Setting CTRL enable  by writing 1
    "li t0,TIMER_BASE;"
    "li t1,0x1;"
    "sw t1,CTRL(t0);"
    // LOOP
    "LOOP:;"
    "addi t5,t5,1;"
    "j LOOP;"
  );
  
  return 0;
}
