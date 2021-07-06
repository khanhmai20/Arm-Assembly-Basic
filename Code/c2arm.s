/*data section*/
.data 
.balign 4
a: 
	.word 10
b:
	.word 5
c: 
	.word 3

/*code section*/
.text
.balign 4
.global main
main:
	ldr r0, addressofA /*r0 = a*/
	ldr r1, addressofB /*r1 = b*/
	ldr r2, addressofC /*r2 = c*/
	ldr r0, [r0]
	ldr r1, [r1]
	ldr r2, [r2]
	add r0, r1, r2 /*a = b++ + c++*/
	add r1, r1, #1
	add r2, r2, #1
	sub r2, r2, #1
	add r1, r2, r0 /*b = --c + a*/
	add r3, r0, r1
	add r2, r2, r3
	add r1, r1, #1
	add r3, r1, r2
	add r0, r0, r3
	bx lr 
	

addressofA: .word a
addressofB: .word b
addressofC: .word c

