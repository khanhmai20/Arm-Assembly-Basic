// data section 
.data
prompt: .asciz "Enter a number: "
number: .word 0 
format: .asciz "%d"
newline: .asciz "\n"
i: .word 1
j: .word 1


// code section 
.text 
main: 
	str lr, [sp, #-4]!
	ldr r0, addressofP
	bl printf //prompt the input number

	ldr r0, addressofF
	ldr r1, addressofN
	bl scanf
	
	b test_outer

inner_loop: 

	ldr r0, addressofF
	mov r1, r8
	bl printf //print the inner loop from 1 to i 

	add r8, r8, #1 // j++ 
	str r8, [r7]

outer_loop: 
	ldr r7, addressofJ
	ldr r8, [r7] //r8 = j
	
	cmp r8, r5 
	ble inner_loop // j <= i 
	
	add r5, r5, #1
	str r5, [r4] // i++ 
	
	mov r8, #1
	str r8, [r7]
	
	ldr r0, addressofNewLine
	bl printf

test_outer: 
	ldr r6, addressofN
	ldr r6, [r6] //r6 = input number

	ldr r4, addressofI
	ldr r5, [r4] //r5 = i
	cmp r5, r6
	ble outer_loop //i <= input number

end: 
	mov r0, r5
	ldr lr, [sp], #+4
	bx lr


.global main
.global printf
.global scanf

addressofP: .word prompt
addressofN: .word number
addressofF: .word format
addressofNewLine: .word newline
addressofI: .word i
addressofJ: .word j
