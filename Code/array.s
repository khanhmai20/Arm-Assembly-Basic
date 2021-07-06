//data section
.data 
a: .skip 40
b: .skip 40 
i: .word 0
sum: .word 0

//code section
.text
.global main
main:
	ldr r1, addressofA
	ldr r2, addressofB
	ldr r3, addressofI
	ldr r4, addressofS

	mov r5, #1
	str r5, [r3] //i (r5) = 1;
	mov r6, #0
	str r6, [r4] //sum (r6) = 0; 

	b test
loop:  
	ldr r6, [r4] //r6 = sum 
	ldr r5, [r3] // r5 = i
	add r7, r1, r5,LSL #2 //r7 = r1 + r5*4 --> a[i]
	str r5, [r7] //a[i] = i
	add r6, r6, r5

	add r7, r2, r5,LSL #2 //r7 = r1 + r5*4 --> b[i]
	mov r8, r5, LSL #2 // i<<2
//	str r8, [r7] //b[i] = i<<2
	
	and r9, r8, #7
	cmp r9, #0 
	beq case_modulo
	b rest

case_modulo:
	add r10, r1, r5, LSL #1 // r7 = r1 + r5*2 --> a[i/2]
	ldr r8, [r10] // a[i/2]
	b rest
rest:
	str r8, [r7] // b[i] = something
	add r6, r6, r8
	str r6, [r4]
	add r5, r5, #1
	str r5, [r3]
test: 
	ldr r5, [r3]
	cmp r5, #10
	blt loop
	b end

end:	
	ldr r0, [r4]
	bx lr




addressofA: .word a
addressofB: .word b
addressofI: .word i
addressofS: .word sum 
