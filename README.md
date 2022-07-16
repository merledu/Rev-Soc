# ReV-SoC SweRV-EL2 RISC-V Core<sup>TM</sup> 1.0 from Micro Electronics Research Lab
This repository contains the ReV-SoC based on EL2 RISC-V SweRV Core<sup>TM</sup>  design RTL with support of F-extension.
## Directory Structure

    ├── configs                 # Configurations Dir
    │   └── snapshots           # Where generated configuration files are created
    ├── design                  # Design root dir
    │   ├── apb_interconnect    # APB interconnect
    │   ├── axi2apb_bridge      # AXI to APB bridge
    │   ├── axi_interconnect    # AXI Interconnect
    │   ├── dbg                 #   Debugger
    │   ├── dec                 #   Decode, Registers and Exceptions
    │   ├── dmi                 #   DMI block
    │   ├── exu                 #   EXU (ALU/MUL/DIV)
    │   ├── floating_point      #   Floating Point Files(wrapper, decoder, register)
    │   ├── gpio                #   GPIO PERIPHERAL
    │   ├── ifu                 #   Fetch & Branch Prediction
    │   ├── include             
    │   ├── lib
    │   └── lsu                 #   Load/Store
    │   ├── pwm                 #   PWM PERIPHERAL
    │   ├── spi                 #   SPI PERIPHERAL
    │   └── timer               #   TIMER PERIPHERAL
    ├── docs
    │   ├── gpio_docs
    │   ├── pwm_docs
    │   ├── spi_docs
    │   ├── SweRV_EL2_docs
    │   ├── timer_docs
    │   └── uart_docs
    ├── fpnew                   # Floating Point Unit
    ├── images
    ├── presentations
    ├── tools                   # Scripts/Makefiles
    └── testbench               # (Very) simple testbench
    │   ├── asm                 #   Example assembly files
    │   ├── hex                 #   Canned demo hex files
    │   └── tests               #   Example tests
    |       └── dhry
 