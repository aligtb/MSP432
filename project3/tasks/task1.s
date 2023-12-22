	.text
	.thumb
	.align 2
	.global delay, array_cmpn, rng

delay: .asmfunc
	; YOUR CODE HERE
	mov r1, #0				; loop counter
loop1:
	add r1, #1
	cmp r1, r0				; (for i=0; i<x; i++)
	blt loop1

	bx lr
	.endasmfunc

array_cmpn: .asmfunc
	; YOUR CODE HERE

	push {r4-r8}            ; Save registers
    mov r6, r0              ; Move array x to r6
    mov r7, r1              ; Move array y to r7
    mov r5, r2              ; Move len to r5
    mov r4, #0              ; Initialize index i to 0

loop2:
    ldrb r0, [r6, r4]       ; Load x[i] into r0
    ldrb r1, [r7, r4]       ; Load y[i] into r1
    cmp r0, r1              ; Compare x[i] and y[i]
    bne not_equal           ; If not equal, branch to not_equal
    add r4, r4, #1          ; Increment i
    cmp r4, r5              ; Compare i and len
    bne loop2                ; If not equal, branch to loop

equal:
    mov r0, #1              ; Return 1
    b end_cmp

not_equal:
    mov r0, #0              ; Return 0
    b end_cmp

end_cmp:
	pop {r4-r8}             ; Return registers old value
	bx lr
	.endasmfunc

rng: .asmfunc
	; YOUR CODE HERE
	push {r4-r7}            ; Save registers
    mov r6, r1              ; Move destination array to r6
    mov r5, r2              ; Move amount to r5
    mov r4, #0              ; Initialize index i to 0

loop3:

    lsl r1, r0, #13         ; Compute x << 13
    eor r0, r1              ; Compute x = x xor (x << 13)
    lsr r1, r0, #17         ; Compute x >> 17
    eor r0, r1              ; Compute x = x xor (x >> 17)
    lsl r1, r0, #5          ; Compute x << 5
    eor r0, r1              ; Compute x = x xor (x << 5)
    and r7, r0, #3          ; Store only the lower two bits
    strb r7, [r6, r4]       ; Store the result in the destination array
    add r4, #1        	    ; Increment i
    cmp r4, r5              ; Compare i and amount
    bne loop3               ; If not equal, branch to loop

end_rng:
	pop {r4-r7}             ; Return registers old value
	bx lr
	.endasmfunc
