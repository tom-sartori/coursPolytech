/* - - programme.s */

/* - - Data section =  Section pour declarer les variables globales */
.data
enter:  .asciz "Entrez un nombre : "
scan:   .asciz "%d"
nb:     .word 0 // La variable dans laquelle le nombre saisi sera stock
msg:    .asciz "%d \n"


/* - - Instruction section */
.text

.global main
main:
    ldr r0, =enter
    bl printf

    ldr r0, =scan
    ldr r1, =nb // On range dans r1 un pointeur vers nb
    bl scanf    // Apr�s �a, dans nb on a le nombre saisi
    ldr r1, =nb // On repointe dans r1 vers nb (apr�s le scanf)
    ldr r2, [r1]    // On r�cup�re dans r2 le nombre point� par r1

    cmp r2, #0
    blt negatif

positif: // else
    ldr r0, =msg
    mov r1, r2
    bl printf
    bl end

negatif:
    ldr r0, =msg
    mov r3, #-1
    mul r1, r2, r3
    bl printf
    bl end

end:
    bl exit


