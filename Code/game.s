//Data Section 
.data
promptFirst: .asciz "Guess the number: "
format: .asciz "%d"
promptHi: .asciz "Too high. Guess again. "
promptLo: .asciz "Too low. Guess again. "
promptLast: .asciz "You guessed correctly in %d tries!\n" 
trial: .word 0
target: .word 0
guess: .word 0
//Code Section 
.text 
main: 
	str lr, [sp, #-4]!
	
	//generate random number
	mov r0, #0
	bl time
	bl srand
	bl rand
	
	add r0, r0, #10 //For code quality add 10 so the random variable >= 10 initially 
	ldr r4, addressofTarget
	str r0, [r4]
	bl deflate_random
	
	ldr r0, [r4]
	add r0, r0, #1
	str r0, [r4] //now target always within [1-10] 

	ldr r0, addressofFirst
	bl printf
	ldr r0, addressofF
	ldr r1, addressofGuess
	bl scanf
	
	ldr r1, addressofGuess
	ldr r1, [r1]
	str r1, [sp, #-4]! //push the guess into the stack 

	ldr r5, addressofTri
	mov r6, #1
	str r6, [r5]

	b determination 

deflate_random: //Random number may greater than 10, deflate it within 10
	ldr r0, [r4]
	sub r0, r0, #10 //We know that the random always greater than 10 
	str r0, [r4]
	cmp r0, #10
	bge deflate_random
	bx lr

determination: //determined if the guess higher or lower 
	ldr r7, [sp], #4 //r7 = guess
	ldr r8, [r4]
	cmp r7, r8
	ble lo_eq
	b hi

lo_eq: //less than or equal 
	cmp r7,r8
	beq equal
	
	ldr r0, addressofLo
	bl printf

	ldr r0, addressofF
	ldr r1, addressofGuess
	bl scanf

	ldr r1, addressofGuess
	ldr r1, [r1]
	str r1, [sp, #-4]!

	ldr r6, [r5]
	add r6, r6, #1
	str r6, [r5] //increment trials
	
	b determination 

equal: 
	ldr r0, addressofLast
	ldr r1, [r5]
	bl printf
	b end

hi: 
	ldr r0, addressofHi
	bl printf
	
	ldr r0, addressofF
	ldr r1, addressofGuess
	bl scanf
	
	ldr r1, addressofGuess
	ldr r1, [r1]
	str r1, [sp, #-4]!

	ldr r6, [r5]
	add r6, r6, #1
	str r6, [r5] //increment trials 
	
	b determination 

end: 
	ldr r0, [r4]
	ldr lr, [sp], #4
	bx lr


.global main
.global printf
.global scanf
.global time
.global srand
.global rand

addressofFirst: .word promptFirst
addressofHi: .word promptHi
addressofLo: .word promptLo
addressofLast: .word promptLast
addressofF: .word format
addressofTri: .word trial 
addressofTarget: .word target
addressofGuess: .word guess
