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
*time_cmp_l = a*2500;

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
      // CSR regs addresses
    __asm__(".equ mie, 0x304");
    __asm__(".equ meicpct, 0xbca");
    __asm__(".equ meicidpl, 0xbcb");
    __asm__(".equ meicurpl, 0xbcc");
    __asm__(".equ meivt, 0xbc8");
    __asm__(".equ meipt, 0xbc9");
    __asm__(".equ meihap, 0xfc8");  
    
    // Interrupt handlers
    
    __asm__("Timer_handler:");
    __asm__("ori x18, x24, 0x00000400");
    __asm__("li x21, 0x20002000");
    __asm__("li x22, 0x0");
    __asm__("sw x22, 0(x21)");
    __asm__("nop");
    __asm__("nop");
    __asm__("nop");  
    __asm__("nop");  
    __asm__("nop");  
    __asm__("nop");  
    __asm__("nop");      
    __asm__("nop");  
    __asm__("nop");  
    __asm__("nop");  
    __asm__("nop");  
    __asm__("nop");  
    __asm__("nop");  
    __asm__("nop");  
    __asm__("nop");  
    __asm__("nop");  
    __asm__("nop");  
    __asm__("nop");  
    __asm__("nop");  
    __asm__("nop");  
    __asm__("nop");  
    __asm__("nop");  
    __asm__("nop");  
    __asm__("nop");  
    __asm__("nop");  
    __asm__("nop");  
    __asm__("nop");  
    __asm__("nop");  
    __asm__("nop");  
    __asm__("nop");  
    __asm__("nop");  
    __asm__("nop");  
    __asm__("nop");          
    __asm__("mret");
    
    __asm__("intr_handler:");
    __asm__("csrwi meicpct, 1");
    __asm__("csrr x18, meihap");
    __asm__("lw x28, 0x0(x18)");
    __asm__("jalr t0,x28, 0x0");
    __asm__("mret");   

int main(){
    __asm__("la t0, intr_handler");
    __asm__("csrw mtvec, t0	");
    __asm__("lui t0, 0x200    # write RV_DCCM_OFFSET");
    __asm__("csrw meivt, t0   # base addr of vector intr");
    
    __asm__("la t1, Timer_handler");
    __asm__("sw t1, 0x8(t0)");
    
    // set priority for first irq
    __asm__("li x18, (0x300000 + 0x0000 + 4)");
    __asm__("ori x9, x0, 7");
    __asm__("sw x9, 0(x18)");    
    // set priority for second irq	
    __asm__("li x18, (0x300000 + 0x0000 + 8)");
    __asm__("ori x9, x0, 8");
    __asm__("sw x9, 0(x18)");    
     
    // priority threshold
    __asm__("ori x18, x0, 3");
    __asm__("csrw meipt, x18");
    
    // enable first irq 
    __asm__("li x18, (0x300000 + 0x2000 + 4)");
    __asm__("ori x9, x0, 1");
    __asm__("sw x9, 0(x18)");    
   // enable second irq
    __asm__("li x18, (0x300000 + 0x2000 + 8)");
    __asm__("ori x9, x0, 1");
    __asm__("sw x9, 0(x18)");    
     
    __asm__("ori x18, x0, 8");
    __asm__("csrw 0x300, x18");
    
    // enable_ext_int
    __asm__("ori x18, x0, 1");
    __asm__("slli x18, x18, 11");	
    __asm__("csrw mie, x18");
 

  
  int a=1,b=2,c=300,d=0;
  delay(1);
   while (d<1000){// for(int i=0; i<100; i++){
    c = a+b;
    a++;
    b++;
    d++;
  }
  return 0;
}
