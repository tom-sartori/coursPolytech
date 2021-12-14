/* - - programme.s */
/* - - Data section =  Section pour declarer les variables globales */
.data
/* S’assure que la prochaine variable declaree sera placee a une adresse multiple de 4. C’est important car ARM ne peut utiliser que des données commencant a de tels emplacements  */
.balign 4
    i: .word 5  /* i = 5 */

/* - - Instruction section */
.text

.global main

main:
    /* i = i + 1 */
    ldr r0, =i  /* Charge l'adresse de i dans r0 */
    ldr r0,[r0] /* Charge la valeur de i dans r0 */

    /* Incrémente de 1 la valeur venant de i */
    add r0, r0, #1

    /* Stocker cette valeur à nouveau dans i */
    ldr r1,=i   /* Charge à nouveau l'adresse de i */
    str r0, [r1]    /* Stocke en mémoire à l'adresse indiquée de i, contenue dans r1 */

    bl exit
