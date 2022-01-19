
/* - - mon_programme.s */
/* - - Data section */
.data
.balign 4	
	i: .word 5  /* i = 5 */

/* - - Instruction section */
.text

.global main

main:
	/* i = i + 1 */
	ldr r0, =i  /* charge l'adresse de i dans r0 */
	ldr r0,[r0] /* charge la valeur de i dans r0 */

	/* Incrémenter de 1 la valeur venant de i */
	add r0, r0, #1

	/* Stocker cette valeur à nouveau dans i */
	ldr r1,=i    /* charge à nouveau l'adresse de i */
	str r0, [r1] /* stocke en mémoire à l'adresse indiquée de i, contenue dans r1) */

	/* BONUS : renvoie au shell la valeur de i */
	/* echo $? dans le shell après l'exécution du code exécutable permet de voir la valeur renvoyée */
	ldr r0, =i  /* charge l'adr mémoire de i dans r0, registre contenant la valeur de retour d'un prog */
	ldr r0,[r0] /* charge la valeur de i dans r0 */
	mov r7, #1 // <- indique qu'on veut sortir rapidement
	SWI 0 // Appel système pour dire qu'on sort du programme 
