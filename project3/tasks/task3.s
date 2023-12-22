	.text
	.thumb
	.align 2
	.global gameloop
	.ref bumperReadSequence, array_cmpn, blinkSequence

gameloop: .asmfunc
	; YOUR CODE HERE
	push {r4-r8, lr}

	; Blinks out the sequence arr in r0
	push {r0-r3}		   ; Save parameters
    bl blinkSequence       ; blinks out the sequence
	pop {r0-r3}		       ; Load parameters




	; Wait for and store amount button presses
	push {r0-r3}		   	; Save parameters
	mov r6, r0				; Save the pointer to seq array

	lsl r4, r1, #2 			; r4 = len of array * 4 (an integer is 4 bytes)
	sub sp, r4			  	; Reserve space on stack (sp - len*4) (temp array)
	mov r7,sp 				; Save stack position (convention)
	mov r0, r7		 		; Load pointer to r0 (first parameter)
							; r1 is len
    bl bumperReadSequence  	; Read the pressed buttons

    mov r0, r6				; Restore pointer to seq array
    mov r2, r1				; Move len to the right position
    mov r1, r7				; Restore pointer to BMP array
    bl array_cmpn			; Compare blink output and BMP input
    mov r5, r0				; Save the result
    mov sp, r7				; Restore stack position (convention)
	add sp, r4 				; Remove temp array

	pop {r0-r3}	       		; Load parameters
	mov r0, r5				; Write the result of cmpn as return value

	pop {r4-r8, lr}
	bx lr
	.endasmfunc
