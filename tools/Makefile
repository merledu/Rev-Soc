# SPDX-License-Identifier: Apache-2.0
# Copyright 2020 Western Digital Corporation or its affiliates.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

CONF_PARAMS = -set build_axi4
GCC=$(GCC_PREFIX)-gcc
TEST_CFLAGS = -g -O3 -funroll-all-loops
ABI = -mabi=ilp32 -march=rv32imac
RV_ROOT?=

# Check for RV_ROOT
ifeq (,$(wildcard ${RV_ROOT}/configs/swerv.config))
$(error env var RV_ROOT does not point to a valid dir! Exiting!)
endif

# Allow snapshot override
target = default
snapshot = $(target)

# Allow tool override
SWERV_CONFIG = ${RV_ROOT}/configs/swerv.config
IRUN = xrun
VCS = vcs
VLOG = qverilog
VERILATOR = verilator
RIVIERA = riviera
GCC_PREFIX = riscv64-unknown-elf
BUILD_DIR = snapshots/${snapshot}
TBDIR = ${RV_ROOT}/testbench

# Define test name
TEST ?= hello_world
TEST_DIR = ${TBDIR}/asm
HEX_DIR = ${TBDIR}/hex
CTEST_DIR =${TBDIR}/tests

# Determine test directory


OFILES = $(TEST).o

ifdef debug
 DEBUG_PLUS = +dumpon
 IRUN_DEBUG = -access +rwc
 IRUN_DEBUG_RUN = -input ${RV_ROOT}/testbench/input.tcl
 VCS_DEBUG = -debug_access
 VERILATOR_DEBUG = --trace
 RIVIERA_DEBUG = +access +r
endif

ifdef gui
IRUN_DEBUG_1 = -gui 
else
IRUN_DEBUG_1 ?=
endif

ifdef Ctest
endif

# provide specific link file
ifeq (,$(wildcard $(TEST_DIR)/$(TEST).ld))
	LINK = $(BUILD_DIR)/link.ld
else
	LINK = $(TEST_DIR)/$(TEST).ld
endif

VPATH = $(TEST_DIR) $(BUILD_DIR) $(TBDIR)

-include $(TEST_DIR)/$(TEST).mki


TBFILES = $(TBDIR)/tb_top.sv $(TBDIR)/ahb_sif.sv

defines  = $(BUILD_DIR)/common_defines.vh
defines += ${RV_ROOT}/design/include/el2_def.sv
defines += $(BUILD_DIR)/el2_pdef.vh
defines += $(RV_ROOT)/design/timer/rv_timer_reg_pkg.sv
includes = -I${BUILD_DIR}
defines += ${RV_ROOT}/design/lib/common_cells/registers.svh
defines += ${RV_ROOT}/design/floating_point/fpnew_pkg.sv
defines += ${RV_ROOT}/design/floating_point/fp_pkg.sv
defines += ${RV_ROOT}/design/floating_point/common_cells/src/cf_math_pkg.sv
defines += ${RV_ROOT}/design/floating_point/fpu_div_sqrt_mvp/hdl/defs_div_sqrt_mvp.sv

# CFLAGS for verilator generated Makefiles. Without -std=c++11 it
# complains for `auto` variables
CFLAGS += "-std=c++11"

# Optimization for better performance; alternative is nothing for
# slower runtime (faster compiles) -O2 for faster runtime (slower
# compiles), or -O for balance.
VERILATOR_MAKE_FLAGS = OPT_FAST="-Os"

# Targets
all: clean verilator

clean:
	rm -rf *.log *.s *.hex *.dis *.tbl irun* vcs* simv* *.map snapshots swerv* \
	verilator* *.exe obj* *.o ucli.key vc_hdrs.h csrc *.csv work\
	dataset.asdb  library.cfg vsimsa.cfg  riviera-build wave.asdb *.elf \
	*.history *.key *.shm .bpad .simvision ./build-Linux/*.log *.txt .reinvoke.sim
	clear
	echo "Cleaning"
	sleep 0.5
	clear
	



############ Model Builds ###############################

# If define files do not exist, then run swerv.config.
${BUILD_DIR}/defines.h:
	BUILD_PATH=${BUILD_DIR} ${RV_ROOT}/configs/swerv.config -target=$(target) $(CONF_PARAMS)

verilator-build: ${TBFILES} ${BUILD_DIR}/defines.h test_tb_top.cpp
	echo '`undef RV_ASSERT_ON' >> ${BUILD_DIR}/common_defines.vh
	$(VERILATOR)  --cc -CFLAGS ${CFLAGS} $(defines) \
	  $(includes) -I${RV_ROOT}/testbench -f ${RV_ROOT}/testbench/flist \
	  -Wno-WIDTH -Wno-UNOPTFLAT ${TBFILES} --top-module tb_top \
	  -exe test_tb_top.cpp --autoflush $(VERILATOR_DEBUG)
	cp ${RV_ROOT}/testbench/test_tb_top.cpp obj_dir/
	$(MAKE) -j -e -C obj_dir/ -f Vtb_top.mk $(VERILATOR_MAKE_FLAGS)
	touch verilator-build

vcs-build: ${TBFILES} ${BUILD_DIR}/defines.h
	$(VCS) -full64 -assert svaext -sverilog +define+RV_OPENSOURCE \
	  +error+500 +incdir+${RV_ROOT}/design/lib \
	  +incdir+${RV_ROOT}/design/include ${BUILD_DIR}/common_defines.vh \
	  +incdir+$(BUILD_DIR)  +libext+.v $(defines) \
	  -f ${RV_ROOT}/testbench/flist ${TBFILES} -l vcs.log
	touch vcs-build

irun-build: ${TBFILES} ${BUILD_DIR}/defines.h
	$(IRUN) -64bit -elaborate $(IRUN_DEBUG) -q -sv -sysv  -nowarn CUVIHR \
	  -xmlibdirpath . -xmlibdirname swerv.build \
	  -incdir ${RV_ROOT}/design/lib -incdir ${RV_ROOT}/design/include \
	  -vlog_ext +.vh+.h $(defines) -incdir $(BUILD_DIR) \
	  -f ${RV_ROOT}/testbench/flist -top tb_top  ${TBFILES} \
	  -I${RV_ROOT}/testbench  -snapshot ${snapshot} $(profile)
	touch irun-build

riviera-build: ${TBFILES} ${BUILD_DIR}/defines.h
	vlib work
	vlog -work work \
		+incdir+${RV_ROOT}/design/lib \
		+incdir+${RV_ROOT}/design/include \
		+incdir+${BUILD_DIR} \
		-y ${RV_ROOT}/design/lib +libext+.v+.vh \
		$(defines) \
		-f ${RV_ROOT}/testbench/flist \
		${TBFILES}
	touch riviera-build

############ TEST Simulation ###############################

verilator: program.hex verilator-build
	./obj_dir/Vtb_top

irun: program.hex irun-build
	$(IRUN)  -64bit $(IRUN_DEBUG) $(IRUN_DEBUG_1) -abvglobalfailurelimit 1 +lic_queue -licqueue \
	  -status -xmlibdirpath . -xmlibdirname swerv.build \
	  -snapshot ${snapshot} -r $(snapshot) $(IRUN_DEBUG_RUN) $(profile)
		echo "Access check "$(IRUN_DEBUG_1)

vcs: program.hex vcs-build
	./simv $(DEBUG_PLUS) +vcs+lic+wait  -l vcs.log

vlog: program.hex ${TBFILES} ${BUILD_DIR}/defines.h
	$(VLOG) -l vlog.log -sv -mfcu +incdir+${BUILD_DIR}+${RV_ROOT}/design/include+${RV_ROOT}/design/lib\
        $(defines) -f ${RV_ROOT}/testbench/flist ${TBFILES}  -R +nowarn3829 +nowarn2583 ${DEBUG_PLUS}

riviera: program.hex riviera-build
	vsim -c -lib work ${DEBUG_PLUS} ${RIVIERA_DEBUG} tb_top -do "run -all; exit" -l riviera.log



############ TEST build ###############################

ifeq ($(shell which $(GCC_PREFIX)-gcc 2> /dev/null),)
program.hex: ${BUILD_DIR}/defines.h
	@echo " !!! No $(GCC_PREFIX)-gcc in path, using canned hex files !!"
	cp ${HEX_DIR}/$(TEST).hex program.hex
else
ifneq (,$(wildcard $(TEST_DIR)/$(TEST).makefile))
program.hex:
	@echo Building $(TEST) via $(TEST_DIR)/$(TEST).makefile
	$(MAKE) -f $(TEST_DIR)/$(TEST).makefile
else

ifeq (,$(wildcard $(CTEST_DIR)/$(TEST).c))
program.hex: $(OFILES) $(LINK)
	@echo Building $(TEST)
	$(GCC_PREFIX)-gcc $(ABI) -Wl,-Map=$(TEST).map -lgcc -T$(LINK) -o $(TEST).exe $(OFILES) -nostartfiles  $(TEST_LIBS)
	$(GCC_PREFIX)-objcopy -O verilog  $(TEST).exe program.hex
	$(GCC_PREFIX)-objdump -S  $(TEST).exe > $(TEST).dis
	@echo Completed building $(TEST)

%.o : %.s ${BUILD_DIR}/defines.h
	$(GCC_PREFIX)-cpp -I${BUILD_DIR}  $<  > $*.cpp.s
	$(GCC_PREFIX)-as ${ABI} $*.cpp.s -o $@

%.o : %.c ${BUILD_DIR}/defines.h
	$(GCC_PREFIX)-gcc ${includes} ${TEST_CFLAGS} -DCOMPILER_FLAGS="\"${TEST_CFLAGS}\"" ${ABI} -nostdlib -c $< -o $@

else

ifeq (,$(wildcard $(TEST_DIR)/$(TEST).ld))
	LINK = $(BUILD_DIR)/link.ld
else
	LINK = $(TEST_DIR)/$(TEST).ld
endif

LINK_FLAGS=-march=rv32imac -mabi=ilp32 -nostartfiles -T$(LINK) 
GCCFLAGS=-mabi=ilp32 -march=rv32imac
GCC=$(GCC_PREFIX)-gcc

program.hex: irun-build build $(TEST).exe $(LINK) 
	@echo Building $(TEST)
	$(GCC_PREFIX)-gcc $(TEST_DIR)/crt0.s $(LINK_FLAGS) -Wl,-Map=$(TEST).map -lgcc -o $(TEST).exe $(TEST).o 
	$(GCC_PREFIX)-objcopy -O verilog  $(TEST).exe program.hex 
	$(GCC_PREFIX)-objdump -S  $(TEST).exe > $(TEST).dis
	@echo Completed building $(TEST)

build:
	$(GCC) $(GCCFLAGS) -c $(CTEST_DIR)/$(TEST).c -o $(TEST).o -lgcc
	$(GCC) $(TEST_DIR)/crt0.s $(LINK_FLAGS)   $(TEST).o -o $(TEST).exe  -lgcc 

whisperlog: irun
	$(RV_ROOT)/build-Linux/whisper --logfile $(RV_ROOT)/build-Linux/$(TEST)_whisper.log $(TEST).exe --configfile $(BUILD_DIR)/whisper.json


endif
cmp: whisperlog
	python3 $(RV_ROOT)/build-Linux/comparison.py ./build-Linux/$(TEST)_whisper.log exec.log

endif

endif

help:
	@echo Make sure the environment variable RV_ROOT is set.
	@echo Possible targets: verilator vcs irun vlog riviera help clean all verilator-build irun-build vcs-build riviera-build program.hex

.PHONY: help clean verilator vcs irun vlog riviera irun-build irun
