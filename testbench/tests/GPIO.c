#include "gpio.h"
#include <stdbool.h>
#include <stdint.h>


void digitalWrite(int bits)
{

int *mode_reg, *dir_reg, *out_reg, *trig_type_reg, *trig_lv0_reg, *trig_lv1_reg, *irq_reg;
mode_reg = (int*)(GPIO_BASE + MODE_REG);
*mode_reg = 100;

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

irq_reg = (int*)(GPIO_BASE + IRQ_EN_REG);   
*irq_reg = 0;
}

// int main(){
//   int a=1,b=2,c=200;
//   digitalWrite(1);
//   for(int i=0; i<1000; i++){
//     c = a+b;
//     a++;
//     b++;
//   }
//   return 0;
// }
