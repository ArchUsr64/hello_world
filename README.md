# hello_world
Bare metal hello world written in machine code
## Building and Execution
1. Download the `hello_world.img` file from [releases](https://github.com/ArchUsr64/hello_world/releases)
2. On a system with [qemu](https://www.qemu.org/) installed:  
   `qemu-system-i386 hello_world.img`
3. Connect to the opened VNC port with [tigerVNC](https://tigervnc.org/):  
   `vncviewer :5900`
## Screenshot
![screenshot](https://github.com/ArchUsr64/hello_world/assets/83179501/eb00d7ec-14ae-4284-8f16-d581d06be786)

## References
- BIOS interrupt from [wikipedia](https://en.wikipedia.org/wiki/INT_10H)
- 8086 Opcode map from [mlsite](http://www.mlsite.net/8086/)
- MBR (x86) reference from [osdev wiki](https://wiki.osdev.org/MBR_(x86))
