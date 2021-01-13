include /home/hagai/Downloads/PcapPlusPlus-20.08/mk/platform.mk
include /home/hagai/Downloads/PcapPlusPlus-20.08/mk/PcapPlusPlus.mk


SOURCES := $(wildcard *.cpp)
#BTReceiverUDP_OBJS_FILENAMES := $(patsubst BTReceiver/BTReceiverUDP.cpp,BTReceiverUDP.o,BTReceiverUDP.cpp)
#SOURCES += $(BTReceiverUDP_OBJS_FILENAMES)
OBJS_FILENAMES := $(patsubst %.cpp,Obj/%.o,$(SOURCES))



#SOURCES += BTReceiverUDP_OBJS_FILENAMES
#OBJS_FILENAMES += BTReceiverUDP_OBJS_FILENAMES

Obj/%.o: %.cpp
	@echo 'Building file: $<'
	@$(CXX) $(PCAPPP_BUILD_FLAGS) -c $(PCAPPP_INCLUDES)  -fmessage-length=0 -MMD -MP -MF"$(@:Obj/%.o=Obj/%.d)" -MT"$(@:Obj/%.o=Obj/%.d)" -o "$@" "$<"


UNAME := $(shell uname)
CUR_TARGET := $(notdir $(shell pwd))

.SILENT:

all: dependents BenchmarkTester

start:
	@echo '==> OBJS_FILENAMES: $(OBJS_FILENAMES)'
	@echo '==> BTReceiverUDP_OBJS_FILENAMES: $(BTReceiverUDP_OBJS_FILENAMES)'
	@echo '==> SOURCES: $(SOURCES) $(BTReceiverUDP_SRC)'
	@echo '==> Building target: $(CUR_TARGET)'

create-directories:
	@$(MKDIR) -p Obj
	@$(MKDIR) -p Bin

dependents:
	@cd $(PCAPPLUSPLUS_HOME) && $(MAKE) libs


BenchmarkTester: start create-directories $(OBJS_FILENAMES)
	@$(CXX) $(PCAPPP_BUILD_FLAGS) $(PCAPPP_LIBS_DIR) -o "./Bin/BenchmarkTester$(BIN_EXT)" $(OBJS_FILENAMES) $(PCAPPP_LIBS)
	@$(PCAPPP_POST_BUILD)
	@echo 'Finished successfully building: $(CUR_TARGET)'
	@echo ' '

clean:
	@$(RM) -rf ./Obj/*
	@$(RM) -rf ./Bin/*F
	@echo 'Clean finished: $(CUR_TARGET)'
