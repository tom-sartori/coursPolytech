/* - - programme.s */

/* - - Data section =  Section pour declarer les variables globales */
.data
enter:  .asciz "Entrez un max : "
scan:   .asciz "%d"
i:      .word 0
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

init:
    ldr r0, =enter
    bl printf

    ldr r0, =scan
    ldr r1, =max
    bl scanf

loop:
    ldr r3, =i
    ldr r3, [r3]
    ldr r4, =max
    ldr r4, [r4]

condition:
    cmp r4, r3
    blt end     // Si r3 < r4 -> Si i < max

print:
    ldr r0, =msg
    // r1 == i
    mov r1, r3  // r1 prend r3 avec r3 == valeur de i.
    bl printf

increment:
    ldr r3, =i
    ldr r3, [r3]
    add r3, r3, #1
    ldr r4, =i
    str r3, [r4]

    b loop

end:
    bl exit
