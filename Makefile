os: main.asm
	nasm main.asm -o my_os.img

clean:
	rm *.img

run: os
	qemu-system-x86_64 -nographic -enable-kvm my_os.img
	tput smam
