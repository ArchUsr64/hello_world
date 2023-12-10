QEMUFLAGS=-nographic -enable-kvm

os: main.asm
	nasm main.asm -o my_os.img

clean:
	rm *.img

run: os
	qemu-system-i386 $(QEMUFLAGS) my_os.img
	@tput smam

debug: os
	bochs -f bochsrc.txt -q

boot_usb: os
	sudo qemu-system-x86_64 -nographic -enable-kvm /dev/sd[a-z]
	tput smam
