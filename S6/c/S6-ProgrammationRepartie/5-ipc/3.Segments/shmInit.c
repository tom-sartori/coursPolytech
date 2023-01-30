/*
  Description : 
  Le programme crée un segment de mémoire partagé dont le contenu est un tableau d'entiers et initialise ce tableau à 0. Le nombre d'élements du tableau et le fichier à prendre en clé sont passés en paramètre du programme.

*/


#include <sys/types.h>
#include <unistd.h>
#include <stdio.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <stdlib.h>
#include <sys/sem.h>


void printTab (int *tab, int size) {
    for (int i = 0; i < size; i++) {
        printf("%d, ", tab[i]);
    }
    printf("\n");
}


void operation1 (int *x) {
    *x = *x + 1;
}

void operation2 (int *x) {
    *x = *x * 5;
}



int main(int argc, char * argv[]){

    if (argc!=3) {
        printf("Nbre d'args invalide, utilisation :\n");;
        printf("%s nombre-elements fichier-pour-cle-ipc\n", argv[0]);
        exit(0);
    }

    int clemem=ftok(argv[2], 'r');

    int laMem;

    if ((laMem = shmget(clemem, atoi(argv[1]) * sizeof(int), IPC_CREAT | IPC_EXCL | 0600)) == -1){
        perror("erreur shmget : ");
        exit(-1);
    }

    printf("mem id : %d \n", laMem);


    //attachement au segment pour pouvoir y accéder
    int * tab_segment = (int *)shmat(laMem, NULL, 0);
    if (tab_segment == (int *)-1){
        perror("erreur shmat : ");
        exit(-1);
    }

    // j'ai un pointeur sur le segment, j'initialise le tableau

    int size = atoi(argv[1]);

    for(int i=0; i < size; i++){
        tab_segment[i] = 0;
    }
    printTab(tab_segment, size);


    // On veut, pour chaque élément du tableau, effectuer l'opération 1, puis l'opération 2.
    // On ne veut pas faire toutes les op1 puis toutes les op2 sur l'intégralité du tab.
    // On veut faire l'op2 sur l'importe quel element du tab, dès que l'op1 a été faite.


    // On ajoute un pour pouvoir synchroniser.
    int sizeTabSem = size + 1;

    int idSem = semget(clemem, sizeTabSem, IPC_CREAT | IPC_EXCL | 0600);
    if(idSem == -1){
        perror("erreur semget : ");
        exit(-1);
    }
    printf("sem id : %d \n", idSem);


    // initialisation des sémaphores a la valeur passée en parametre (faire autrement pour des valeurs différentes:
    ushort tabinit[sizeTabSem];
    for (int i = 0; i < sizeTabSem; i++) {
        tabinit[i] = 0;
    }


    union semun{
        int val;
        struct semid_ds * buf;
        ushort * array;
    } valinit;

    valinit.array = tabinit;

    if (semctl(idSem, sizeTabSem, SETALL, valinit) == -1){
        perror("erreur initialisation sem : ");
        exit(1);
    }

    /* test affichage valeurs des sémaphores du tableau */
    valinit.array = (ushort*)malloc(sizeTabSem * sizeof(ushort)); // pour montrer qu'on récupère bien un nouveau tableau dans la suite

    if (semctl(idSem, sizeTabSem, GETALL, valinit) == -1){
        perror("erreur initialisation sem : ");
        exit(1);
    }


    // Opération 1.
    for (int i = 0; i < size; i++) {
        operation1(&tab_segment[i]);
    }
    printTab(tab_segment, size);

    // Opération 2.
    for (int i = 0; i < size; i++) {
        operation2(&tab_segment[i]);
    }
    printTab(tab_segment, size);


    // détachement pour signaler au système la fin de l'utilisation du segment

    if (shmdt(tab_segment) == -1){
        perror("erreur shmdt : ");
        exit(-1);
    }

    return 0;
}

