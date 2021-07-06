/*data section*/
.data 
.balign 4
f0: 
	.word 0
.balign 4
f1: 
	.word 1

/*code section*/ 
.text
.balign 4
.global main
main:
	ldr r0, addressOfF0
	ldr r0, [r0]
	ldr r1, addressOfF1
	ldr r1, [r1]
	add r0, r0, r1 /*calculate f2*/
	add r1, r1, r0 /*calculate f3*/
	add r0, r0, r1 /*calculate f4*/
	add r1, r1, r0 /*calculate f5*/
	add r0, r0, r1 /*calculate f6*/
	bx lr

addressOfF0: .word f0
addressOfF1: .word f1

