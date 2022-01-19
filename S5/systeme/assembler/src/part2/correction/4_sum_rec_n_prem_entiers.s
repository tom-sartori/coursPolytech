.data
str:	.string "La somme des %d premiers entiers positifs est : %d\n"
n:	.word 20

.text
.global main

main:	
    ldr r1, =n
	ldr r0, [r1]
	bl somme
	b end

/* fonction récursive */
somme:	
    // on sauvegarde dans la pile l'adresse de retour
	sub sp, sp, #8
	str lr, [sp]

	// est-ce qu'on est arrivé à 0 ?
	cmp r0, #0
	ble somme0

    // sinon on svg r0 notre param dans la pile
	sub sp, sp, #8
	str r0, [sp]

    // on appelle récursivement avec r0 - 1
	sub r0, #1
	bl somme

// après l'appel récursif
endf
    // qd on arrive ici r0 contient le res des appels réc qu'on a déclenchés
    // r1 <- de la pile notre param de départ 
	ldr r1, [sp]
	add sp, sp, #8 // on libere cet emplacement de la pile

    // !? pbm : il faut ici récupérer notre r0 qu'on avait svg dans pile !?

    // ensuite on fait l'addition a renvoyer : faite dans r0
	add r0, r1 // on l'ajoute à notre param de départ

    // on ressort de l'appel (return)
	ldr lr, [sp]
	add sp, sp, #8
	bx lr

/* cas d'arrêt de la récursivité */
somme0:	
	mov r0, #0. // on place 0 dans r0 
	sub sp, sp, #8 // on réserve une place dans la pile
	str r0, [sp] // on place la valeur à renvoyer dans la pile
	b endf

end:	mov r2, r0
	ldr r0, =str
	ldr r3, =n
	ldr r1, [r3]		
	bl printf

	mov r0, #0
	bl exit
