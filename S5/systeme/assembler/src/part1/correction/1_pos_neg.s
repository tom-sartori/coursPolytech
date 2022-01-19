/* -- pos_neg.s */
.data
menter:		.asciz 	"Entrer un nombre : "
mscan:		.asciz	"%d"
mprint:		.asciz 	"C'est un nombre %s"
msg1:		.asciz 	"positif ou nul\n"
msg2:		.asciz 	"négatif\n"
nb:		.word 10 // La variable dans laquelle le nombre saisi sera stocké
	
.text
	.global main
	
main:	
	ldr r0, =menter
	bl printf
	ldr r0, =mscan
	ldr r1, =nb
	bl scanf // Après ça, dans nb on a le nombre saisi
	ldr r0, =mprint
	ldr r1, =nb
	ldr r2, [r1]
	cmp r2, #0
	blt negatif
	ldr r1, =msg1	
	b fin
negatif:
	ldr r1, =msg2	
fin:
	bl printf	
	bl exit	
