	.text
	.thumb
	.align 2
	.global hashop

hashop: .asmfunc
	push {r4-r11}

	; YOUR CODE HERE

    ldrb r1, [r1, r2];		Load the byte at the selected index
    mov r3, #33;			Move the current hash value to another register
    mul r0, r0, r3;			Multiply the current hash value by 33
    add r0, r0, r1;			Add the byte to the result of the multiplication

	pop {r4-r11}
	bx lr
	.endasmfunc
