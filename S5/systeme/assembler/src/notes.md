#Assembler 

Compiler 
```bash
as -o file.o -g file.s
gcc -o exe file.o
```

Debug
```bash
gdb ./exe 
    start
    next
    info register
```

Sauter des parties de code (conditions)
```
cmp r2, #0
blt negatif
// else do this
bl end

:negatif
    // Do this if condi true
    bl end

:end
    bl exit
```

```
b suite // Ca y va et c'est tout. 
bl suite // Ca va à suite, mais ca continue en dessous apres (checkpoint)
```


If else 
```shell script
if (r1 < r2)
  r3 = r1;
else
  r3 = r2;
```

```
      cmp r1, r2
      blt then    // si r1 < r2 saut vers then
      mov r3, r2  // r3 := r2
      b done      // saut vers done
then: mov r3, r1  // saut vers done
done:             // suite du programme
```

Boucles 
```shell script
r2 = 0;
while (r1 > 0) {
    r2 = r2 + r1;
    r1 = r1 - 1; 
}
```

```
        mov r2, #0      // r2 := 0
while:  cmp r1, #0
        ble done        // si r1 <= 0 saut vers done
        add r2, r2, r1  // r2 := r2 + r1
        subr1,r1,#1     //r1:=r1-1
        b while         // retour vers while
done:                   // suite du programme
```

Tableaux 
```shell script
int a[100];

a[3]=3;
```

```
        .balign 4
a:      .skip 400

        ldr r1, =a
        mov r2, #3
        str r2, [r1, #+12]
```
