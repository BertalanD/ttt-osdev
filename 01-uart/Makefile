CC = clang
LD = ld.lld
OBJCOPY = llvm-objcopy
CFLAGS = -Wall -O2 -ffreestanding -nostdlib --target=aarch64-unknown-elf -mcpu=cortex-a72+nosimd

CFILES = $(wildcard *.c)
OFILES = $(CFILES:.c=.o)

.DEFAULT_GOAL := kernel8.img

boot.o: boot.S
	$(CC) $(CFLAGS) -c boot.S -o boot.o

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

kernel8.elf: boot.o $(OFILES)
	$(LD) boot.o $(OFILES) -T link.ld -o kernel8.elf

kernel8.img: kernel8.elf
	$(OBJCOPY) -O binary kernel8.elf kernel8.img

.PHONY: run
run: kernel8.img
	qemu-system-aarch64 -machine raspi4b -cpu cortex-a72 -m 2G -kernel kernel8.img -serial stdio

.PHONY: clean
clean:
	rm -f *.elf *.o *.img
