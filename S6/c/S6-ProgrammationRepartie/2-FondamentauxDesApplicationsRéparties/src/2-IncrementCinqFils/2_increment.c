#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <signal.h>



int main (int argc, char* argv[]) {
    int canalPereToFils[2];
    pipe(canalPereToFils);

    int canalFilsToPere[2];
    pipe(canalFilsToPere);

    int tabSize = 5;
    int tab[tabSize];

    pid_t pid;
    pid = fork();

    if (pid == 0) {     // Fils
        /// 2.
            // Attendre le tab du pere
                // close canalPereToFils cote droit
                // Attendre que le pere ait ecrit
                    // read bloquant
                    // Ca ecrit les entiers du père dans un tab
            // Incrementer les valeurs du tab

        /// 3.
            // Envoyer la nouvelle data au pere
                // close canalFilsToPere cote gauche
                // write le tab dans le cote droit de canalFilsToPere

        /// Fin fils


        /// 2.
        close(canalPereToFils[1]);
        read(canalPereToFils[0], tab, 256);
        for (int i = 0; i < tabSize; i++) {
            tab[i]++;
        }


        /// 3.
        close(canalFilsToPere[0]);
        write(canalFilsToPere[1], tab, 256);
    }
    else {              // Pere
        /// 1.
            // Mettre cinq entiers dans un tableau
            // Envoyer le tab au fils
                // close canalPereToFils cote lecture
                // write le tab cote droit

        /// 4.
            // Attendre le tab du fils
                // read bloquant
                // mettre data dans un new tab
            // printf le tab

        /// Fin pere.


        /// 1.
        for (int i = 0; i < tabSize; i++) {
            tab[i] = 3 * i;
        }

        close(canalPereToFils[0]);
        write(canalPereToFils[1], tab, 256);


        /// 4.
        close(canalFilsToPere[1]);
        read(canalFilsToPere[0], tab, 256);

        for (int i = 0; i < tabSize; i++) {
            printf(" %d ", tab[i]);
        }
    }
    return EXIT_SUCCESS;
}

