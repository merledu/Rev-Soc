#include "timer.h"
#include <stdbool.h>
#include <stdint.h>


void delay(int a)
{

int *time_cmp_l, *time_cmp_u, *ctrl, *prescale, *ie; // Pointer declaration
// Disabling timer by writing zero to the control register
ctrl = (int*)(TIMER_BASE_ADDRESS + CTRL);
*ctrl = 0;
// Setting prescale to zero and step to 1
prescale = (int*)(TIMER_BASE_ADDRESS + CFG);
*prescale = 0x20001;

// Setting timer lower reg to the given delay
time_cmp_l = (int*)(TIMER_BASE_ADDRESS + CMP_L);
*time_cmp_l = a*1000;

// Setting timer Upper reg to zero
time_cmp_u = (int*)(TIMER_BASE_ADDRESS + CMP_U);
*time_cmp_u = 0;

// Setting interrupt enable by writing 1
ie = (int*)(TIMER_BASE_ADDRESS + INTR_EN);
*ie = 1;
// Setting control enable by writing 1 to ctrl register
ctrl = (int*)(TIMER_BASE_ADDRESS + CTRL);
*ctrl = 1;

}

// int main(){
//   int a=1,b=2,c=300;
//   delay(10);
//   for(int i=0; i<1000; i++){
//     c = a+b;
//     a++;
//     b++;
//   }
//   return 0;
// }
