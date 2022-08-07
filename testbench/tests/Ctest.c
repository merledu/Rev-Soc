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
#include "timer.h"
#include "Timer.c"
#include "gpio.h"
#include "GPIO.c"

#define STACK 0x70041
<<<<<<< HEAD
int main() {
   float a = 4.2,b=4.3, d = 8.5;
   float c;
   c = a + b;
   if(c == d)
   digitalWrite(1);
   else
   digitalWrite(0);
   // delay(200);
   return 0;
}
=======

int main(){
  __asm__ __volatile__(
  "srai x11, x26, 27;"
  );
//   int a=3,b=6,c=10,d=0;
//   int *test_finish;                     // declaratin of test termination pointer
//  // int *stack;                         // declaration of stack initialize pointer
//  // stack = (int *)(0xD0580000);        // setting address of mailbox to finish test
//  // *test_finish = 0xFF;                // writing data 0xFF
//   d = a+b+c;
//   // test_finish = (int *)(0xD0580000); // setting address of mailbox to finish test
  // *test_finish = 0xFF;               //writing data 0xFF
  return 0;
}
>>>>>>> 658614d02da91c617f1ed2010adbcd782505d021
