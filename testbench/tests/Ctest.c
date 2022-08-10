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
int main() {
  //  int x = 1;
  // //  float a = 4.2, b=4.3, d = 8.5;
  // //  float c;
  // //  while(x!=0){
  // //  c = a + b;
  // //  if(c == d)
  //   x = 100;
  // else 
  //   x = 0;
  //  digitalWrite(1);
  //  else
  //  digitalWrite(0);
  //  delay(1);
  //  }

  int a = 1, b=2 , c=3;
   
   a = b + c;
   if (b<c)
   b++;
   else 
   c++;
   b = b+c;
   return 0;
}
