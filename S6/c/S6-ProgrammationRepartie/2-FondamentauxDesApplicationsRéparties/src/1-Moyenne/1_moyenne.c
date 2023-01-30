#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>


int askForInt ();
int askForContinue ();


//Exercice 1 :
//
//int main(void) {
//    pid_t pid;
//    int descr[2];
//    char buffer[256];
//    pipe(descr);
//    pid = fork();
//    if (pid != 0) { /* Processus pere */
//        close(descr[0]);
//        sprintf(buffer, "Luke, je suis ton père. La Force est avec toi jeune Skywalker. Mais tu n'es pas encore un Jedi.");
//        write(descr[1], buffer, 256);
//    }
//    else if (pid == 0) { /* Processus fils */
//        close(descr[1]);
//        read(descr[0], buffer, 256);
//        printf("Message recu du père : %s\n", buffer);
//    }
//    return EXIT_SUCCESS;
//}



// Exercice 2

int main(void) {
    pid_t pid;
    int descr[2];
    int buffer[256];
    int sum = 0;
    int n = 0;
    pipe(descr);
    pid = fork();

    if (pid != 0) { /* Processus pere */
        close(descr[1]);
        while (read(descr[0], buffer, 256)) {
            sum += *buffer;
            n++;
        }
        printf("Moyenne : %d\n", (sum/n));
    }
    else {  // (pid == 0)  /* Processus fils */
        close(descr[0]);
        do {
            int intResponse = askForInt();
            write(descr[1], &intResponse, 256);   /// TODO remove nbyte.
        }
        while (askForContinue());
    }
    return EXIT_SUCCESS;
}

int askForInt () {
    printf("Entrez un nombre : ");
    int number;
    scanf("%d", &number);
//    printf("entier : %d", number);
    printf("\n");
    return number;
}

int askForContinue () {
    printf("Entrez \"0\" pour stop, sinon un autre caractère. ");
    int number;
    scanf("%d", &number);
//    printf("entier : %d", number);
    printf("\n");
    return number != 0;
}
