all:
	nasm -f bin -o fire.com fire.asm

clean:
	unlink fire.com