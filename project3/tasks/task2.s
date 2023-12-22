	.text
	.thumb
	.align 2
	.global ledInit, ledOut, bumperInit, blinkSequence, bumperAwait, bumperReadSequence
	.ref delay

ledInit: .asmfunc
	; YOUR CODE HERE
    ldr r0, p2Base		    ; Load the address of P2Base into r0
    mvn r2, #0x7

    ldr r1, [r0, #0xb]      ; Load the value of P2SEL0 into r1
    and r1, r2              ; Set the bits to 0 corresponding to the LEDs (b0111)
    str r1, [r0, #0xb]      ; Store the new value of P2SEL0

    ldr r1, [r0, #0xd]      ; Load the value of P2SEL1 into r1
    and r1, r2              ; Set the bits to 0 corresponding to the LEDs (b0111)
    str r1, [r0, #0xd]      ; Store the new value of P2SEL1


	mvn r2, r2				; Inverting the bits

    ldr r1, [r0, #0x5]      ; Load the value of P2DIR into r1
    orr r1, #0x7            ; Set the bits corresponding to the LEDs (b0111) to 1
    str r1, [r0, #0x5]      ; Store the new value of P2DIR

    ldr r1, [r0, #0x3]      ; Load the value of P2OUT into r1
    orr r1, #0x7            ; Set the bits corresponding to the LEDs (b0111) to 1
    str r1, [r0, #0x3]      ; Store the new value of P2OUT

    ldr r1, [r0, #0x9]      ; Load the value of P2DS into r1
    orr r1, #0x7            ; Set the bits corresponding to the LEDs to 1
    str r1, [r0, #0x9]      ; Store the new value of P2DS

	bx lr
	.endasmfunc

p2Base: .int 0x40004C00

ledOut: .asmfunc
	; YOUR CODE HERE
    and r0, #0x7            ; Mask the color parameter to keep only the lower three bits

    ldr r2, p2Base    		; Load the address of p2Base into r2

    mvn r3, #0x7

    ldr r1, [r2, #0x3]      ; Load the value of P2OUT into r1
    and r1, r3              ; Clear the bits corresponding to the LEDs
    orr r1, r0              ; Set the bits corresponding to the color parameter
    str r1, [r2, #0x3]      ; Store the new value of P2OUT

	bx lr
	.endasmfunc

blinkSequence: .asmfunc
	; YOUR CODE HERE
    push {r4-r5, lr}       ; Save registers
    mov r4, #0             ; Initialize index to 0

blinkLoop:
    cmp r4, r1             ; Compare index with length
    bge endBlink           ; If index >= length, end blink sequence

	; choose color and Turn LED on
	push {r0-r3}    	   ; Save parameters
    ldrb r0, [r0, r4]      ; Load color from array
    cmp r0, #0			   ; Check if the value of sqeuence is 0, then map it to white color
    it eq
    moveq r0, #0x5		   ; set gb colors to on
    bl ledOut              ; Output color to LED
	pop {r0-r3} 		   ; Load parameters

	push {r0-r3} 		   ; Save parameters
    ldr r0, leddelay       ; Load delay value
    bl delay               ; Wait for delay
	pop {r0-r3}  		   ; Load parameters

	; Turn LED off
	push {r0-r3}    	   ; Save parameters
    mov r0, #0             ; Load 0 (LED off state)
    bl ledOut              ; Turn off LED
    pop {r0-r3}  		   ; Load parameters

    push {r0-r3}    	   ; Save parameters
    ldr r0, leddelay       ; Load delay value
    bl delay               ; Wait for delay
	pop {r0-r3}	     	   ; Load parameters


    add r4, #1	           ; Increment index
    b blinkLoop            ; Repeat blink sequence

endBlink:
    pop {r4-r5, lr}        ; Restore registers and return

	bx lr
	.endasmfunc

leddelay: .int 0x1FFFFF

bumperInit: .asmfunc
	; YOUR CODE HERE

	ldr r0, p2Base		    ; Load the address of P2Base into r0
    mvn r2, #0xA9			; set corresponding values to 0

	; Set P4.0, P4.3, P4.5, P4.7 as GPIO Inputs
    ldr r1, [r0, #0x2b]     ; Load the value of P4SEL0 into r1
    and r1, r2              ; Set the bits to 0
    str r1, [r0, #0x2b]     ; Store the new value of P4SEL0

    ldr r1, [r0, #0x2d]     ; Load the value of P4SEL1 into r1
    and r1, r2              ; Set the bits to 0
    str r1, [r0, #0x2d]     ; Store the new value of P4SEL1

	; Set the directions to input
    ldr r1, [r0, #0x27]     ; Load the value of P4DIR into r1
    and r1, r2              ; Set the bits to 0
    str r1, [r0, #0x27]     ; Store the new value of P4DIR


    ; Enable pull-up resistors (negative logic)
    mvn r2, r2				; Flip the bits

    ldr r1, [r0, #0x27]     ; Load the value of P4REN into r1
    orr r1, r2              ; Set the bits to 1
    str r1, [r0, #0x27]     ; Store the new value of P4REN

    ldr r1, [r0, #0x27]     ; Load the value of P4REN into r1
    orr r1, r2              ; Set the bits to 1
    str r1, [r0, #0x27]     ; Store the new value of P4REN

	bx lr
	.endasmfunc

bumperAwait: .asmfunc
	; YOUR CODE HERE

    push {lr}       	   ; Save registers
	ldr r0, p2Base		   ; Load the address of P2Base into r0

wait_for_press:
    ; Read the button state
    ldrh r1, [r0, #0x21]

    ; Mask the required bits
    mvn r1, r1			   ; Flip the bits
    and r1, #0xA9

    ; Check if any button is pressed
    cmp r1, #0
    beq wait_for_press

get_result:
    ; Check which button is pressed and return the corresponding number
    cmp r1, #0x01
    beq return_BMP0

    cmp r1, #0x08
    beq return_BMP2

    cmp r1, #0x20
    beq return_BMP3

    cmp r1, #0x80
    beq return_BMP5


	; return the right vaule,  (BMP0 = 0, BMP2 = 1, BMP3 = 2, BMP5 = 3)
return_BMP0:
    mov r0, #0
    b wait_for_release

return_BMP2:
    mov r0, #1
    b wait_for_release

return_BMP3:
    mov r0, #2
    b wait_for_release

return_BMP5:
    mov r0, #3
    b wait_for_release


wait_for_release:

    push {r0-r3}    	   ; Save parameters
    ldr r0, releasedelay   ; Load delay value
    bl delay               ; Wait for delay
	pop {r0-r3}		       ; Load parameters

	pop {lr}		       ; Restore registers and return
	bx lr
	.endasmfunc

releasedelay: .int 0xFFFFF

bumperReadSequence: .asmfunc
	; YOUR CODE HERE

	push {r4-r5, lr}        ; Save Registers
	mov r4, #0				; for ( i = 0; i =< amount ; i++)

save_loop:
	cmp r4, r1
	bge save_end			; Done with the number of required items

	push {r0-r3}	   		; Save parameters
    bl bumperAwait          ; Wait for result
    mov r5, r0				; Save the BMP number temporry
	pop {r0-r3}		   		; Load parameter

	strb r5, [r0], #1
	add r4, r4, #1 				; i++
	b save_loop


save_end:
	pop {r4-r5, lr}        ; Restore registers and return
	bx lr
	.endasmfunc


