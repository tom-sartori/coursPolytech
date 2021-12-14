/* - - programme.s */

/* - - Data section =  Section pour declarer les variables globales */
.data
enter:  .asciz "Entrez un max : "
scan:   .asciz "%d"
start:  .word 0
max:    .word 0
msg:    .asciz "%d \n"


/* - - Instruction section */
.text

.global main
main:
    // Affichage message enter
    // Scanner le max
    // Mettre start dans r0
    // Mettre max dans r1
    // Si r0 < r1
        // blt boucle
        // Afficher r0
        // r0++
        // bl condition

    ldr r0, =enter
    bl printf

    ldr r0, =scan
    ldr r1, =max
    bl scanf


    ldr r1, =start
    ldr r1, [r1]
    ldr r2, =max
    ldr r2, [r2]

    bl condition

condition:
    cmp r1, r2  // Si r1 < r2
    blt boucle
    bl end

boucle:
    ldr r0, =msg
    // r1 == start
    bl printf

    ldr r1, =start
    ldr r1, [r1]
    add r1, r1, #1
    str r1, [=start]


    ldr r2, =max
    ldr r2, [r2]

    bl condition

end:
    bl exit
