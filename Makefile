TARGET = template
MCU = z80

BUILD_DIR = build
STM_TOOLS_PATH = /usr/local/Cellar/sdcc/4.0.0
TOOLCHAIN = $(STM_TOOLS_PATH)/bin
TOOLCHAIN_INCLUDE = $(TOOLCHAIN)/share/sdcc/include

CC = $(TOOLCHAIN)/sdcc
LD = $(TOOLCHAIN)/sdld
AR = $(TOOLCHAIN)/sdar
OBJCPY = $(TOOLCHAIN)/sdobjcopy
CP = /bin/cp
RM = /bin/rm

# Includes
CFLAGS = -I$(TOOLCHAIN_INCLUDE)
CFLAGS += -I./include

# Compile flags
CFLAGS += -m$(MCU) -p$(MCU)
CFLAGS += --Werror --std-sdcc99
CFLAGS += --vc --code-loc 16384 --opt-code-size 
ARFLAGS = -a
ASFLAGS = -plosgff

SRCS += src/main.c
SRCS += src/vt.c

OBJS += src/main.rel src/vt.rel

.PHONY: $(TARGET).ihx

$(TARGET).ihx: $(TARGET).rel

$(TARGET).rel: $(OBJS)
	$(CC) $(CFLAGS) main.rel vt.rel

clean:
	$(RM) -f *.noi *.lk *.mem *.sym *.rst *.lst *.ihx *.asm *.rel *.map

%.rel: %.c
	$(CC) $(CFLAGS) -c $<

