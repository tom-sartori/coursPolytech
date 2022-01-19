.data

msg:    .asciz "Entrez un nombre : "
getNb:  .asciz  "%d"
nb:     .word
x:      .word       // Possible d'initialiser a rien ?
y:      .word

showNb: .asciz  "%d \n"


.text
.global main

main:

    // Entrer un x
    // Entrer un y

    // Fonction qui met au carrée r0

    // Récupérer x^2
    // Récupérer y^2

    // Somme de carrées
    // print somme


    ldr r0, =msg
    bl printf

    ldr r0, =getNb
    ldr r1, =nb
    bl scanf

    ldr r2, =nb
    ldr r2, [r2]

    mul r1, r2, r2

    ldr r0, =showNb
    ldr r1, [r1]

    bl printf

    bl exit



square:
    mov r1, r0
    mul r0, r1, r1
    bx lr



