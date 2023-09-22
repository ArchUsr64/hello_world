os: main.asm
	nasm main.asm -o my_os.img

clean:
	rm *.img

run: os
	qemu-system-x86_64 -nographic -enable-kvm my_os.img
	@tput smam

boot_usb: os
	sudo qemu-system-x86_64 -nographic -enable-kvm /dev/sd[a-z]
	tput smam
