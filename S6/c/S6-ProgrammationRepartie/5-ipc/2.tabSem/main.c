#include <sys/types.h>
#include <unistd.h>
#include <stdio.h>
#include <sys/ipc.h>
#include <sys/sem.h>
#include <stdlib.h>



int main(int argc, char *argv[]) {

    if (argc != 3) {
        printf("Nbre d'args invalide, utilisation :\n");
        printf("%s nombre-semaphores fichier-pour-cle-ipc\n", argv[0]);
        exit(0);
    }

    int clesem = ftok(argv[2], 'r');

    int nbSem = atoi(argv[1]);

    int idSem = semget(clesem, nbSem, 0600);

    if(idSem == -1){
        perror("erreur semget : ");
        exit(-1);
    }

    printf("sem id : %d \n", idSem);




    struct sembuf {
        unsigned short sem_num;
        short sem_op;
        short sem_flg;
    };

    struct sembuf opp;
    opp.sem_num = 0;
    opp.sem_op = -1;
    opp.sem_flg = 0;


    semop(idSem, &opp, 1);

}