#include <stdio.h>
#include <stdlib.h>
#include <limits.h>


// 1.

//int main(int argc, char* argv[]){
//    short x = 1;
//    printf("Max : %d | Min : %d \n", SHRT_MAX, SHRT_MIN);
//
//    while (x >= 1) {
//        printf("x : %d\n", x);
//        x = x+1;
//    }
//    return 0 ;
//}



// 2.


// 2.1.

//void main ( void ) {
//    int n = 4;
//    int* p = &n;
//    printf ("%d" , *p);
//}


// 2.2.

//void f(){
//    int nchiffre [20];
//    for (int i = 0; i < 55; ++i) {
//        printf("nchiffre[%d]=%d\n", i, nchiffre[i]);
//        nchiffre[i]=0;
//    }
//}
//
//void main ( void ) {
//    f();
//    printf("␣fini\n");
//}


// 2.3.

//void f(){
//    int nchiffre[20];
////    int i = 1010;
//    printf("i=%d\n", nchiffre[-1]);
//}
//
//void fBis() {
//    int i = 1010;
//    int nchiffre [20];
//    printf("i=%d\n", nchiffre[-1]);
//}
//
//void main (void) {
//    printf("Avec f : \n");
//    f();
//
//    printf("\n");
//
//    printf("Avec fBis : \n");
//    fBis();
//
//    printf("\n");
//    printf("fini\n");
//}


// 3. Allocation de la mémoire et tableaux


// 1. Écrivez une fonction qui multiplie par 2 la valeur d’un entier. La fonction ne doit rien renvoyer.

void timesTwo (int* n) {
    *n = *n * 2;
}


// 2. Écrivez une fonction qui renvoie un pointeur vers un entier contenant la valeur 2022.

int* f2 () {
    int* n = malloc(sizeof(int));
    *n = 2022;
    return n;
}

// 3. Écrivez une fonction qui prend en entrée un nombre n et renvoie un tableau contenant les n premiers nombres de Fibonacci.

int* fibonacci (int n) {
    int* tab = malloc(sizeof(int) * n);
    tab[0] = 0;

    if (n == 1) {
        return tab;
    }

    tab[1] = 1;
    int i = 2;
    while (i < n) {
        tab[i] = tab[i - 2] + tab[i - 1];
//        printf("tab[%d] = %d \n", i, tab[i]);
        i++;
    }

    return tab;
}

int* f4 (const int* tab, int n) {
    int* tab2 = malloc(sizeof(int) * (2 * n));
    for (int i = 0; i < n; i++) {
        tab2[i] = tab[i];
    }
    for (int i = 0; i < n; i++) {
        tab2[i + n] = tab[n - i - 1];
    }
    return tab2;
}

int main (int arc, char** argv) {
    int x = 2;
    timesTwo(&x);
    printf("2x = %d \n", x);
    printf("\n");


    int n = *f2();
    printf("n = %d\n", n);
    printf("\n");


    int nbFibo = 10;
    int* fibo = fibonacci(nbFibo);
    for (int i = 0; i < nbFibo; i++) {
        printf("fibo[%d] = %d \n", i, fibo[i]);
    }
    printf("\n");


    int size = 3;
    int depart[] = {1, 2, 3};
    int* fin = f4(depart, size);
    for (int i = 0; i < size * 2; i++) {
        printf("fin[%d] = %d \n", i, *(fin + i));
    }
}






