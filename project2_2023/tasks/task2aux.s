	.text
	.thumb
	.align 2
	.global encryptop

encryptop: .asmfunc
	push {r4-r11}

	; YOUR CODE HERE

    ldrb r1, [r0]       ; Load the character to be encrypted
    cmp r1, #'a'        ; Check if the character is a lowercase letter
    blt end             ; If it is not, return
    cmp r1, #'z'        ; Check if the character is greater than 'z'
    bgt loop            ; If it is, loop back to the beginning of the alphabet
    add r1, r1, r2      ; Add the key to the character
    cmp r1, #'z'        ; Check if the result is greater than 'z'
    ble store           ; If it is not, store the result
loop:
    sub r1, r1, #'z'-'a'+1  ; Subtract the length of the alphabet
store:
    strb r1, [r0]       ; Store the encrypted character
end:

	pop {r4-r11}
	bx lr
	.endasmfunc
