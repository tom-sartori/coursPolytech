	/* -- abs.s */
	.data
enter:	.asciz "Entrer un nombre : "
scan:	.asciz "%d"
print:	.asciz "La valeur absolue du nombre est : %d\n"
nb:	.word 0
	
	.text
	.global main
main:	
	ldr r0, =enter
	bl printf

	ldr r0, =scan
	ldr r1, =nb
	bl scanf

bp:	ldr r1, =nb
	ldr r2, [r1]

	cmp r2, #0
	bge fin
	mov r3, r2
	mov r4, #-1
	mul r2, r3, r4

fin:	ldr r0, =print
	mov r1, r2	
	bl printf
	bl exit
