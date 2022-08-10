#include "gpio.h"
#include <stdbool.h>
#include <stdint.h>


void digitalWrite(int bits)
{

int *mode_reg, *dir_reg, *out_reg, *trig_type_reg, *trig_lv0_reg, *trig_lv1_reg, *irq_reg, *trig_stat; 
mode_reg = (int*)(GPIO_BASE + MODE_REG);
*mode_reg = 0;

dir_reg = (int*)(GPIO_BASE + DIR_REG);
*dir_reg = bits;

out_reg = (int*)(GPIO_BASE + OUT_REG);   
*out_reg = bits;

trig_type_reg = (int*)(GPIO_BASE + TRIG_TYPE_REG);   
*trig_type_reg = 0;

trig_lv0_reg = (int*)(GPIO_BASE + TRIG_LV0_REG);   
*trig_lv0_reg = 0;

trig_lv1_reg = (int*)(GPIO_BASE + TRIG_LV1_REG);   
*trig_lv1_reg = 0;

// trig_stat = (int*)(GPIO_BASE + TRIG_STATUS_REG);   
// *trig_stat = 1;

irq_reg = (int*)(GPIO_BASE + IRQ_EN_REG);   
*irq_reg = 0;
}


void digitalWriteI(int bits,int direction)
{

int *mode_reg, *dir_reg, *out_reg, *trig_type_reg, *trig_lv0_reg, *trig_lv1_reg, *irq_reg, *trig_stat; 
mode_reg = (int*)(GPIO_BASE + MODE_REG);
*mode_reg = 0;

dir_reg = (int*)(GPIO_BASE + DIR_REG);
*dir_reg = direction;

out_reg = (int*)(GPIO_BASE + OUT_REG);   
*out_reg = bits;

trig_type_reg = (int*)(GPIO_BASE + TRIG_TYPE_REG);   
*trig_type_reg = 0;

trig_lv0_reg = (int*)(GPIO_BASE + TRIG_LV0_REG);   
*trig_lv0_reg = 0;

trig_lv1_reg = (int*)(GPIO_BASE + TRIG_LV1_REG);   
*trig_lv1_reg = 1;

}

int Gpiointerrupt(){
  int *reg;
  int *mode;
  int d=0,e;
  while(d==0){
  mode = (int*)(GPIO_BASE + MODE_REG);
  e = *mode;
    reg = (int*)(GPIO_BASE + INTR);
  d = *reg;
  }
  return d;
  }
// int main(){
//   int a=1,b=2,c=200,d=2,e=1;

//   while(e!=0){
//   d = 2;
//   digitalWrite(1);
//   while(d<200){
//     a = b+c;
//     b++;
//     c++;
//     d++;
//   }
//   // d = 2;
//   // digitalWrite(0);
  
//   // while(d<200000){
//   //   a = b+c;
//   //   b++;
//   //   c++;
//   //   d++;
//   // }
//   }


//   return 0;
// }
