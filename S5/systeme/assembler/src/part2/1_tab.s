
.data

        .balign 4
tab:    .skip 400

i:      .word 0
max:    .word 100

msg:    .asciz "%d \n"

.text
.global main

main:

// Écrire un programme qui remplit un tableau de 100 éléments avec les 100 premiers entiers positifs (0→99) et les affiche ensuite

    // r1 tab
    // r2 index dans tab
    // r3 i
    // r4 max
    // r5 intSize
    // r6 adresse de i

    ldr r1, =tab

    ldr r3, =i
    ldr r3, [r3]

    ldr r4, =max
    ldr r4, [r4]

    mov r5, #4

condition:
    // Si i < max, continuer sinon stop
    cmp r4, r3  // Si max < i, on stop
    blt fin

loop:
    // tab[i] = i

    mul r2, r3, r5
    str r3, [r1, r2]     // A voir si juste r2 simple fonctionne.
    // str r3, [r1]     // A voir si juste r2 simple fonctionne.

increment:
    // i++
    // bl condition

    add r3, r3, #1

    ldr r6, =i
    str r3, [r6]

    bl condition

affichage:
    // set i à 0
    // tq i < max
        // afficher tab[i * size]
        // i++

    // r0 msg
    // r1 tab[i * intSize]
    // r4 tab
    // r5 i
    // r6 max

    mov r0, #0
    ldr r0, [r0]
    str r0, [r6]



condition2:
    cmp


fin:
    bl affichage
    bl exit
