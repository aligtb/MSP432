	.text
	.thumb
	.align 2
	.global npv

npv: .asmfunc
	push {r4-r11}



	mov r5, #1				; Initialize r5 with loop counter (pow n)
	mov r4, #0
	sub r0, r4, r0 			; Initialize with negative value

loop:
	ldr r6, [r1], #4		; load the income of each year into r6
	add r5, #1 				; increment the loop
    cmp r3, r5              ; Check if t < years
    blt loop                ; If t < years, loop
end:


	pop {r4-r11}
	bx lr
	.endasmfunc

const0: .float 0.0
const1: .float 1.0
