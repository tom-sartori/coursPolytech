	/* -- n_prem_ints.s */
	.data
enter:	.asciz "Entrer un nombre : "
format:	.asciz "%d"
msg:	.asciz "%d\n"
nb:	.word 0
i:	.word 1

	.text
	.global main
main:
	ldr r0, =enter
	bl printf

	ldr r0, =format
	ldr r1, =nb
	bl scanf
loop:
	ldr r1, =nb
	ldr r2, [r1]  // r2 <- val de nb
	ldr r3,=i
	ldr r3,[r3] // r3 <- val de i
	cmp r2,r3
	blt fin    // si nb < i alors fin
corpsBoucle:
	ldr r0, =msg  // r0 <- msg à afficher
	mov r1,r3 // r1 <- param du msg à afficher = r3 = i
	bl printf // appel fonction lib C
incrementei:	
	ldr r3,=i
	ldr r3,[r3]
	add r3,r3,#1
	ldr r4,=i
	str r3,[r4]
	b loop

fin:	bl exit
