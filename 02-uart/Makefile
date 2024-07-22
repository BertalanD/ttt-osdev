CC = clang
LD = ld.lld
OBJCOPY = llvm-objcopy
CFLAGS = -std=c23 -Wall -O2 -ffreestanding -nostdlib --target=aarch64-unknown-elf -mcpu=cortex-a72+nosimd

.DEFAULT_GOAL := kernel8.img

boot.o: boot.S
	$(CC) $(CFLAGS) -c boot.S -o boot.o

main.o: main.c
	$(CC) $(CFLAGS) -c main.c -o main.o

kernel8.elf: boot.o main.o
	$(LD) boot.o main.o -T link.ld -o kernel8.elf

kernel8.img: kernel8.elf
	$(OBJCOPY) -O binary kernel8.elf kernel8.img

.PHONY: run
run: kernel8.img
	qemu-system-aarch64 -machine raspi3b -cpu cortex-a53 -m 1G -kernel kernel8.img -serial stdio

.PHONY: clean
clean:
	rm -f *.elf *.o *.img
