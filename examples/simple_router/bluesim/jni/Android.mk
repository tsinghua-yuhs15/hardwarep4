
include $(CLEAR_VARS)
DTOP?=/home/netarchlab/p4fpga/p4fpga/examples/simple_router/bluesim
CONNECTALDIR?=/home/netarchlab/p4fpga/connectal
LOCAL_ARM_MODE := arm
include $(CONNECTALDIR)/scripts/Makefile.connectal.application
LOCAL_SRC_FILES := /home/netarchlab/p4fpga/p4fpga/examples/simple_router/main.cpp /home/netarchlab/p4fpga/sonic-lite/sw/lpcap.c /home/netarchlab/p4fpga/p4fpga/examples/simple_router/app_init.cpp /home/netarchlab/p4fpga/connectal/cpp/dmaManager.c /home/netarchlab/p4fpga/connectal/cpp/platformMemory.cpp /home/netarchlab/p4fpga/connectal/cpp/transportXsim.c $(PORTAL_SRC_FILES)

LOCAL_PATH :=
LOCAL_MODULE := android.exe
LOCAL_MODULE_TAGS := optional
LOCAL_LDLIBS := -llog  -lpcap -lpthread 
LOCAL_CPPFLAGS := "-march=armv7-a"
LOCAL_CFLAGS := -I$(DTOP)/jni -I$(CONNECTALDIR) -I$(CONNECTALDIR)/cpp -I$(CONNECTALDIR)/lib/cpp -I/home/netarchlab/p4fpga/p4fpga/cpp  -Werror
LOCAL_CXXFLAGS := -I$(DTOP)/jni -I$(CONNECTALDIR) -I$(CONNECTALDIR)/cpp -I$(CONNECTALDIR)/lib/cpp -I/home/netarchlab/p4fpga/p4fpga/cpp -std=c++11 -L\"/home/hwang/questasim/questa_sim/gcc-4.3.3-linux_x86_64/lib64\" -Werror
LOCAL_CFLAGS2 := $(cdefines2)s

include $(BUILD_EXECUTABLE)
