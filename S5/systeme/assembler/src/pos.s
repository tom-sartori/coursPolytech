/* -- positif.s */
.data
enter:  .asciz "Entrer un nombre : "
scan:   .asciz "%d"
print:  .asciz "C'est un nombre %s"
msg1:   .asciz "positif ou nul\n"
msg2:   .asciz "négatif\n"
nb:     .word 0 // La variable dans laquelle le nombre saisi sera stock�
.text
.global main
main:
    ldr r0, =enter
    bl printf
    ldr r0, =scan
    ldr r1, =nb // On range dans r1 un pointeur vers nb
    bl scanf // Apr�s �a, dans nb on a le nombre saisi 
    ldr r1, =nb // On repointe dans r1 vers nb (apr�s le scanf)
    ldr r2, [r1] // On r�cup�re dans r2 le nombre point� par r1
    cmp r2, #0
    blt negatif
    ldr r0, =print
    ldr r1, =msg1
    bl printf
    bl fin
negatif:
    ldr r0, =print
    ldr r1, =msg2
    bl printf
    bl fin
fin:
    bl exit
