	.data
x:	.word 10
y:	.word 20
str:	.string "x et y : %d %d\n"
	.text
	.global main
main:	
	// On affiche x et y avant la permutation
    ldr r0, =str  // params pour printf dans l'ordre
	ldr r3, =x
	ldr r1, [r3]  // x
	ldr r3, =y
	ldr r2, [r3]  // y 
	bl printf     

	// On appelle permut(x,y)
	ldr r3, =x
	ldr r0, [r3]  // 1er param d'appel place dans r0
	ldr r3, =y
	ldr r1, [r3]  // 2eme param d'appel place dans r1
	bl permut     

	// On affiche x et y après la permutation
	mov r1, r0
	ldr r0, =str  // params pour printf dans l'ordre
	mov r2, r1   
	bl printf     
	
	mov r0, #0
	bl exit       // On quitte proprement

/* Fonction de swap de deux valeurs */
permut:   
	sub sp, #8    // on déplace le pointeur de pile
	str lr, [sp]  // On enregistre l'adresse de retour dans la pile
	
	sub sp, #8    // On alloue de la mémoire dans la pile	
	str r0, [sp]  // On empile r0 
	mov r0, r1    // r0 <- r1
	ldr r1, [sp]  // On dépile dans r1 (la valeur de r0 donc)
	add sp, #8    // On libère la mémoire dans la pile
	
	ldr lr, [sp]  // On récupère l'adresse de retour de la pile
	add sp, #8    // on repositionne le pointeur de pile, libérant l'espace utilisé
	bx lr         // on repart vers l'appelant en ayant inversé r0 et r1
