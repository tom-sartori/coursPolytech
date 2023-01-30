#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <signal.h>


int askForInt ();
int askForContinue ();
void traitement (int n);



int main (int argc, char* argv[]) {
    pid_t pid;
    int canalInt[2];
    pipe(canalInt);

    pid = fork();

    if (pid == 0) { // Fils
        // Lire la valeur envoyee par le pere et l'afficher
            // Close pipe cote ecriture -> droit
            // read valeur dans cote gauche du pipe
            // printf

            // Check la valeur de l'entier de retour
            // Si negatif
                // envoi signal -> kill


        close(canalInt[1]);
        int canalResponse;
        while (read(canalInt[0], &canalResponse, 256)) {
//            printf("%d\n", canalResponse);
            if (canalResponse < 0) {
                kill(getppid(), SIGUSR1);
            }
//            sleep(1);
        }
    }
    else {  // Pere
        // while true
            // Demande un entier
                // askInt()
            // Envoyer au fils
                // Close pipe cote lecture (gauche)
                // write value dans pipe cote droit

            // Check que pas de message du pere (message de signal)

        signal(SIGUSR1, traitement);


        close(canalInt[0]);
        int i = 0;
        do {
            int userResponse = askForInt();
            write(canalInt[1], &userResponse, 256);
//            sleep(1);   // Si sleep, boucle infinie sur le traitement du signal.
            i++;
        }
        while (i < 10);
    }

    return EXIT_SUCCESS;
}


void traitement (int n) {
    printf("Signal : %d | Chiffre inférieur à zéro. \n", n);
    sleep(1);
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
