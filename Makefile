# Makefile for CANopenNode with Linux socketCAN


DRV_SRC = socketCAN
CANOPEN_SRC = .
OD_SRC = example
APPL_SRC = socketCAN


LINK_TARGET = canopend


INCLUDE_DIRS = \
	-I$(DRV_SRC) \
	-I$(CANOPEN_SRC) \
	-I$(OD_SRC) \
	-I$(APPL_SRC)

#	$(DRV_SRC)/CO_OD_storage.c \

SOURCES = \
	$(DRV_SRC)/CO_driver.c \
	$(DRV_SRC)/CO_error.c \
	$(DRV_SRC)/CO_epoll_interface.c \
	$(CANOPEN_SRC)/301/CO_ODinterface.c \
	$(CANOPEN_SRC)/301/CO_NMT_Heartbeat.c \
	$(CANOPEN_SRC)/301/CO_HBconsumer.c \
	$(CANOPEN_SRC)/301/CO_Emergency.c \
	$(CANOPEN_SRC)/301/CO_SDOserver.c \
	$(CANOPEN_SRC)/301/CO_SDOclient.c \
	$(CANOPEN_SRC)/301/CO_TIME.c \
	$(CANOPEN_SRC)/301/CO_SYNC.c \
	$(CANOPEN_SRC)/301/CO_PDO.c \
	$(CANOPEN_SRC)/301/crc16-ccitt.c \
	$(CANOPEN_SRC)/301/CO_fifo.c \
	$(CANOPEN_SRC)/303/CO_LEDs.c \
	$(CANOPEN_SRC)/304/CO_GFC.c \
	$(CANOPEN_SRC)/304/CO_SRDO.c \
	$(CANOPEN_SRC)/305/CO_LSSslave.c \
	$(CANOPEN_SRC)/305/CO_LSSmaster.c \
	$(CANOPEN_SRC)/309/CO_gateway_ascii.c \
	$(CANOPEN_SRC)/extra/CO_trace.c \
	$(CANOPEN_SRC)/CANopen.c \
	$(OD_SRC)/OD.c \
	$(APPL_SRC)/CO_main_basic.c


OBJS = $(SOURCES:%.c=%.o)
CC ?= gcc
OPT = -g -pedantic
#OPT = -g -pedantic -fanalyzer
#OPT = -g -pedantic -DCO_USE_GLOBALS
#OPT = -g -pedantic -DCO_MULTIPLE_OD
#OPT = -g -pedantic -DCO_SINGLE_THREAD
CFLAGS = -Wall $(OPT) $(INCLUDE_DIRS)
LDFLAGS = -pthread
#LDFLAGS =

#Options can be passed via make: 'make OPT="-g -DCO_SINGLE_THREAD" LDFLAGS=""'


.PHONY: all clean

all: clean $(LINK_TARGET)

clean:
	rm -f $(OBJS) $(LINK_TARGET)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

$(LINK_TARGET): $(OBJS)
	$(CC) $(LDFLAGS) $^ -o $@
