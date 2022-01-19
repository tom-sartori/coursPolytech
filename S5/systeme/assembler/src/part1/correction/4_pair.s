	/* -- pair.s */
	.data
enter:	.asciz "Entrer un nombre : "
scan:	.asciz "%d"
print:	.asciz "%d\n"
nb:	.word 0
str:	.asciz "Le nombre est %s\n"
str1:	.asciz "pair"
str2:	.asciz "impair"

	.text
	.global main
main:
	ldr r0, =enter
	bl printf

	ldr r0, =scan
	ldr r1, =nb
	bl scanf
	ldr r1, =nb
	ldr r2, [r1]
bp:	orr r3, r2, #1 // Un ou inclusif avec 1 permet de savoir si le nombre est pair ou non
	cmp r3, r2
	beq impair
	ldr r0, =str
	ldr r1, =str1
	bl printf
	b fin
impair:
	ldr r0, =str
	ldr r1, =str2		
	bl printf
fin:	
	bl exit
