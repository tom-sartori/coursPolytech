# TP1

1. Capacité des variables

    1. 
    
```c
int main(int argc, char argv[]){
    short x = 1;
    while (x >= 1) {
        x = x+1;
    }
    return 0 ;
}
```

    Boucle jusqu'à ce que x atteigne le max des short. 

    1. 
    `gcc -Wall -ansi -o prog prog.c`
    
    1. 
    `SHRT_MAX` et `SHRT_MIN` permettent d'indiquer la valeur max et min d'un short. 


2. Pointeurs et tableaux

```c
#include <stdio .h>
void main ( void ) { 
    int∗ p;
    printf ("%d" , ∗p);
}
```
