	.data
str:	.string "Element n° %d: %d\n"
	.balign 4
a:	.skip 400 // declare tab de 100 entiers (un entier = 4 octets)
	
	.text
	.global main
main:
	ldr r1, =a // r1 est le pointeur vers le tableau
	mov r5, #0 // r5 est le i de la boucle

loop: cmp r5, #100
	beq suite
	mov r6, #4 // r6 sert pour la multiplication ci-dessous
	mul r3, r5, r6 // r3 sert pour le décalage
	str r5, [r1,+r3]
	add r5, r5, #1	// i++
	b loop

suite:	ldr r1, =a
	mov r5, #0 // r5 -> i
loop2: 	cmp r5, #100 
	beq end
	mov r6, #4
	mul r3, r5, r6
	ldr r2, [r1,+r3]
	ldr r0, =str // argument 1 de printf	
	mov r1, r5 // argument 2 de printf
	bl printf
	ldr r1, =a // Remettre dans r1 le pointeur vers le tableau
	add r5, r5, #1 // i++
	b loop2

end:	mov r0, #0
	bl exit
