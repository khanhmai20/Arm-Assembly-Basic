/*data section*/
.data 
i: .word 1
j: .word 0
x: .word 0

/*code section*/
.text
.global main
main:
	/*load data into register*/
	ldr r1, addressofI
	ldr r1, [r1] //r1 = i
	ldr r2, addressofJ
	ldr r2, [r2] //r2 = j
	ldr r3, addressofX
	ldr r3, [r3] //r3 = x
	
	b test_outter

outter_loop:
	mov r2, r1 //j = i
	b test_inner

inner_loop:
	add r4, r1, r2 //i + j
	add r3, r3, r4 //x = i + j
	add r2, r2, #1

test_inner:
	cmp r2, #10
	blt inner_loop
	add r1, r1, #2

test_outter:
	cmp r1, #10
	blt outter_loop

end:
	mov r0, r3
	bx lr

addressofI: .word i
addressofJ: .word j
addressofX: .word x
