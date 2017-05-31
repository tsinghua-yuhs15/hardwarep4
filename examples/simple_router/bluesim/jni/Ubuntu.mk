
CONNECTALDIR?=/home/netarchlab/p4fpga/connectal
DTOP?=/home/netarchlab/p4fpga/p4fpga/examples/simple_router/bluesim

TOOLCHAIN?=
ifneq ($(TOOLCHAIN),)
CC=$(TOOLCHAIN)gcc
CXX=$(TOOLCHAIN)g++
endif
CFLAGS_COMMON = -O -g -I$(DTOP)/jni -I$(CONNECTALDIR) -I$(CONNECTALDIR)/cpp -I$(CONNECTALDIR)/lib/cpp -I/home/netarchlab/p4fpga/p4fpga/cpp  -Wall -Werror -I$(DTOP)/jni -I$(CONNECTALDIR) -I$(CONNECTALDIR)/cpp -I$(CONNECTALDIR)/lib/cpp -I/home/netarchlab/p4fpga/p4fpga/cpp -std=c++11 -L\"/home/hwang/questasim/questa_sim/gcc-4.3.3-linux_x86_64/lib64\"
CFLAGS = $(CFLAGS_COMMON)
CFLAGS2 = 

include $(DTOP)/Makefile.autotop
include $(CONNECTALDIR)/scripts/Makefile.connectal.application
SOURCES = /home/netarchlab/p4fpga/p4fpga/examples/simple_router/main.cpp /home/netarchlab/p4fpga/sonic-lite/sw/lpcap.c /home/netarchlab/p4fpga/p4fpga/examples/simple_router/app_init.cpp /home/netarchlab/p4fpga/connectal/cpp/dmaManager.c /home/netarchlab/p4fpga/connectal/cpp/platformMemory.cpp /home/netarchlab/p4fpga/connectal/cpp/transportXsim.c $(PORTAL_SRC_FILES)
SOURCES2 =  $(PORTAL_SRC_FILES)
XSOURCES = $(CONNECTALDIR)/cpp/XsimTop.cpp $(PORTAL_SRC_FILES)
LDLIBS :=  -lpcap -lpthread  -lpthread

ubuntu.exe: $(SOURCES)
	$(Q)$(CXX) $(CFLAGS) -o ubuntu.exe $(SOURCES) $(LDLIBS)
	$(Q)[ ! -f ../bin/mkTop.bin.gz ] || $(TOOLCHAIN)objcopy --add-section fpgadata=../bin/mkTop.bin.gz ubuntu.exe

connectal.so: $(SOURCES)
	$(Q)$(CXX) -shared -fpic $(CFLAGS) -o connectal.so $(SOURCES) $(LDLIBS)

ubuntu.exe2: $(SOURCES2)
	$(Q)$(CXX) $(CFLAGS) $(CFLAGS2) -o ubuntu.exe2 $(SOURCES2) $(LDLIBS)

xsim: $(XSOURCES)
	$(CXX) $(CFLAGS) -o xsim $(XSOURCES)
