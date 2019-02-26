IDIR=ArduinoCore-raspbian/cores/arduino/
CORE_DIR=ArduinoCore-raspbian/cores/arduino
LIBS_DIR=libs
SRC_DIR=src

CC=gcc
CPPC=g++

SRC=$(wildcard $(SRC_DIR)/*.cpp) $(wildcard $(CORE_DIR)/*.cpp) $(wildcard $(CORE_DIR)/*.c) $(wildcard $(LIBS_DIR)/*/*.cpp) $(wildcard $(LIBS_DIR)/*/*.c) 
CFLAGS=-I$(SRC_DIR) -I$(CORE_DIR) -I$(wildcard $(LIBS_DIR)/*/)

ODIR=out
SRC_OBJ=$(patsubst %,$(ODIR)/%,$(SRC))
OBJ=$(SRC_OBJ:=.o)

$(ODIR)/%.cpp.o:	
	mkdir -p $(dir $@)
	g++ -c -o $@ $(patsubst out/%,%,$(basename $@)) $(CFLAGS)
$(ODIR)/%.c.o:
	mkdir -p $(dir $@)
	$(CC) -c -o $@ $(patsubst out/%,%,$(basename $@)) $(CFLAGS)
output: $(OBJ)
	@echo $(SRC)
	$(CC) -o $@ $^ $(CFLAGS) -lm

.PHONY: clean

clean:
	rm -r $(ODIR)
	rm output 
