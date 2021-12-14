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
