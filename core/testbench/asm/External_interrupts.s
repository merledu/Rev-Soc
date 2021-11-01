#define STDOUT 0xd0580000
#define BASE_SOC 0x80000000
#define BASE_CSR 0x10000000
#define FIN_CSR 0x1FFFFFFF

#define RV_PIC_BASE_ADDR 0xF00C0000
#define RV_PIC_OFFSET 0xC0000

/*The external interrupt vector table resides either in the DCCM, SoC memory, 
or a dedicated flop array in the core.*/
#define RV_VECTOR_TABLE_BASE 0x70000000//Stored in RAM
#define RV_VECTOR_TABLE_BASE_SHIFTED //(RV_VECTOR_TABLE_BASE >> 10)//Stored in RAM

#define meivt 0xBC8
#define meipt 0xBC9
#define meicpct 0xBCA
#define meicidpl 0xBCB
#define meicurpl 0xBCC
#define meihap 0xFC8
#define mie 0x304

#define RV_PIC_MEIGWCTRL_OFFSET 0x4000 //0x4000 + 4*S, the product is done within the macro
#define RV_PIC_MEIGWCLR_OFFSET 0x5000 //0x5000 + 4*S, the product is done within the macro
#define RV_PIC_MEIPL_OFFSET 0x0//The offset is 0x0, although the first position is reserved
#define RV_PIC_MEIP_OFFSET 0x1000
#define RV_PIC_MEIE_OFFSET 0x2000
#define RV_PIC_MPICCFG_OFFSET 0x3000
#define RV_PIC_MEIPT_OFFSET 0x3004




.macro disable_ext_int
// Clear MIE[miep]
disable_ext_int_\@:
    li a0, (1<<11)
    csrrc zero, mie, a0
.endm
          
.macro init_vector_table_rt
init_vector_table_rt_\@:
csrr tp, meivt
li t0, (RV_VECTOR_TABLE_BASE<<10) 
andi t1, tp, 0x3ff //Keep the 10 ls bits
or t0, t0, t1 //Concatenate
csrw meivt, t0
.endm

.macro init_handler_rt
init_handler_rt_\@:
li a0, 0x2 // id=2
la a1, eint_handler
//a0=source
//a1=handler_address
slli tp, a0, 2
li t0, RV_VECTOR_TABLE_BASE
add tp, tp, t0
sw a1, 0(tp)
.endm


.macro enable_ext_int
enable_ext_int_\@:
// Set MIE[miep]
    li a0, (1<<11)
    csrrs zero, mie, a0
.endm

.macro init_priorityorder priord
init_priorityorder_\@:
    li tp, (RV_PIC_BASE_ADDR + RV_PIC_MPICCFG_OFFSET)
    li t0, \priord
    sw t0, 0(tp)
.endm

.macro init_nstthresholds threshold
init_nstthresholds_\@:
    li t0, \threshold
    //li tp, (RV_PIC_BASE_ADDR + RV_PIC_MEICIDPL_OFFSET)
    //sw t0, 0(tp)
    csrw meicidpl, t0
    //li tp, (RV_PIC_BASE_ADDR + RV_PIC_MEICURPL_OFFSET)
    //sw t0, 0(tp)
    csrw meicurpl, t0
.endm

.macro set_threshold threshold
set_threshold_\@:
    li tp, (RV_PIC_BASE_ADDR + RV_PIC_MEIPT_OFFSET)
    li t0, \threshold
    sw t0, 0(tp)
.endm

.macro enable_interrupt id
enable_interrupt_\@:
    li tp, (RV_PIC_BASE_ADDR + RV_PIC_MEIE_OFFSET + (\id <<2))
    li t0, 1
    sw t0, 0(tp)
.endm

.macro disable_interrupt id
disable_interrupt_\@:
    li tp, (RV_PIC_BASE_ADDR + RV_PIC_MEIE_OFFSET + (\id <<2))
    li t0, 0
    sw t0, 0(tp)
.endm


.macro set_priority id, priority
set_priority_\@:
    li tp, (RV_PIC_BASE_ADDR + RV_PIC_MEIPL_OFFSET + (\id <<2))
    li t0, \priority
    sw t0, 0(tp)
.endm

.macro init_gateway id, polarity, type
init_gateway_\@:
    li tp, (RV_PIC_BASE_ADDR + RV_PIC_MEIGWCTRL_OFFSET + (\id <<2))
    li t0, ((\polarity<<1) | \type)
    sw t0, 0(tp)
.endm

.macro clear_gateway id
clear_gateway_\@:
    li tp, (RV_PIC_BASE_ADDR + RV_PIC_MEIGWCLR_OFFSET + (\id <<2))
    sw zero, 0(tp)
.endm

.macro init_trap_vector_rt
init_trap_vector_rt_\@:
la a0, trap_vector 
//a0=trap_address

slli t0, a0, 2 //Shift the address [31..2]
andi t0, a0, 0xFFFFFFFC //Base[31..2] maps with mtvec[31..2]
addi t0, t0, 1 //+1 for the vectored mode
csrw mtvec, t0 //move
.endm


.globl _start
_start:



/*INIT CONFIG FOR INTERRUPTS*/
//SEE SECTION 5.5.1
disable_ext_int // Disable interrupts (MIE[meip]=0)

//1
init_priorityorder 0  // Set priority to standard RISC-V order

//2
init_gateway 2, 0, 0 // Configure gateway id=5 (first param) to edge-triggered/low
clear_gateway 2 // Clear gateway id=5

//3
//init_vector_table //Init the vector table
init_vector_table_rt //Init the vector table



init_handler_rt //Call init_handler_rt

//Load the trap_vector into mtvec

init_trap_vector_rt


//4
set_priority 2, 15 // Set id=5 threshold at 15

//5
set_threshold 1 // Program global threshold to 1

//6
init_nstthresholds 0  // Initialize nesting thresholds to 0

//7
enable_interrupt 2 // Enable id=1

enable_ext_int // Enable interrupts (MIE[meip]=1)

//Others
//Set mstatus[mei]=1
csrr tp, mstatus 
ori tp, tp, 0x8// (1 << 3)
csrw mstatus, tp

.rept 100 
    nop
.endr


 _finish:
    li x3, STDOUT
    addi t6, x0, 0xff
    sb t6, 0(x3)
    beq x0, x0, _finish
.rept 100 
    nop
.endr


trap_vector: // Interrupt trap starts here when MTVEC[mode]=1

csrwi meicpct, 1 // Capture winning claim id and priority
csrr t0, meihap // Load pointer index
srli t0,t0,0x2
andi t5,t0,0xFF // geting last 8 bits that is claim id
srli t0,t0,0x8  // shrinking to base adress
add t0,t0,t5    // adding base and claim id
lw t1, 0(t0) // Load vector address
jr t1 // Go there


eint_handler:
//Clear interrupt pending register
nop
nop
nop
nop
nop
nop
/// ANY OPERATION TO EXECUTE IN THAT PARTICULAR INTERRUPT WILL BE WRITTEN THERE
disable_ext_int
disable_interrupt 2 // Disable id
// Mask all
set_priority 2 , 0
csrr tp, mip
andi t0, tp, 0x7FF // I do not know why I cannot use more bits
csrw mip, t0

mret // Return from ISR

.end
