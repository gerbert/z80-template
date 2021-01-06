TARGET = template
MCU = z80

BUILD_DIR = build
TOOLCHAIN_PATH = /usr/local/Cellar/sdcc/4.0.0
TOOLCHAIN = $(TOOLCHAIN_PATH)/bin
TOOLCHAIN_INCLUDE = $(TOOLCHAIN_PATH)/share/sdcc/include

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

OBJS = $(addprefix $(BUILD_DIR)/, $(addsuffix .rel, $(basename $(SRCS))))

.PHONY: $(BUILD_DIR)/$(TARGET).ihx

$(BUILD_DIR)/$(TARGET).ihx: $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) -o $@

clean:
	$(RM) -rf $(BUILD_DIR)

$(BUILD_DIR)/%.rel: %.c
	mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c -o $@ $<

