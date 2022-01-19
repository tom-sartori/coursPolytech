	.data
str1: 	.string "Square : %d\n"
str2:	.string "Sum square : %d\n"
	.text
	.global main
main:	
	mov r0, #8
	bl sqr        // On fait sqr(8)
	
	mov r1, r0
	ldr r0, =str1
	bl printf     // On affiche le résultat

	mov r0, #8
	mov r1, #6
	bl ssqr       // On fait sum_sqr(8,6)

	mov r1, r0
	ldr r0, =str2
	bl printf     // On affiche le résultat
	
	mov r0, #0
	bl exit       // On quitte proprement

/* Calcul le carré d'un nombre, param placé dans r0 */
sqr:
	mov r1, r0
	mul r0, r1  // r0 <- r0 * r1
	bx lr

/* Sum sqr : prend deux arguments, dans r0 et r1 */
ssqr:	sub sp, #8
	str lr, [sp] // On enregistre l'adresse de retour dans la pile
	
	sub sp, #8   // sp <- sp - 8
	str r1, [sp] // On enregistre le deuxième argument (y) dans la pile
	bl sqr       // On fait sqr(x) (param x est déjà dans r0, au retour r0 contiendra rés de l'appel)

	ldr r1, [sp] // On récupère y de la pile
	str r0, [sp] // On stocke le résultat de sqr(x) dans la pile
				 // donc sp bouge pas (on stocke tjs meme quantité dans pile)

	mov r0, r1   // On prépare l'argument de sqr(y)
	bl sqr       // On fait sqr(y) -> res sera a récupérer dans r0
	
	ldr r1, [sp] // On récupère le résultat de sqr(x) de la pile
	add sp, #8   // On libere cette zone de la pile (sp <- sp + 8)
	
	add r0, r1   // r0 <-- r0 (c-a-d sqr(x)) + r1 (c-a-d sqr(y))

	ldr lr, [sp] // On récupère l'adresse de retour de la pile
	add sp, #8
	bx lr
