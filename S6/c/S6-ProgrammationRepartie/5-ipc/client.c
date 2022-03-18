#include <stdlib.h>
#include <sys/types.h>
//#include <iostream>
#include <sys/ipc.h>
#include <sys/msg.h>
#include <unistd.h>
#include <stdio.h>

// ce fichier contient des bouts de codes du client pour l'exercice 1 du TP IPC.


// $1 = op1
// $2 = idpo
// $3 = op2
// $4 = filePath


int main (int argc, char * argv[]){

    if(argc != 5){
        printf("lancement : ./client operande1 operation operande2 chemin_fichier_cle\n");
        exit(1);
    }

    // récuperer l'identifiant de la file de message qu'on souhaite
    // utiliser. La clé est une paire : chemin vers un fichier existant
    // et un caractère (ou entier en fonction de l'OS). La même paire
    // permet d'identifier une seule file de message. Donc tous les
    // processus qui utiliseront la même paire, partageront la même
    // file de message (s'ils en ont les droits aussi)
    key_t cle = ftok(argv[4], 'z');
    if (cle == -1) {
        perror("erreur ftok");
        exit(1);
    }
    printf("ftok ok\n");
    // la clé numérique calculée, je réupère l'identifiant de la file (ici je suppose que la file existe).
    int msgid = msgget(cle, 0666);
    if(msgid == -1) {
        perror("erreur msgget");
        exit(1);
    }

    printf("msgget ok\n");

    // structure des requetes
    struct request1{
        long etiqReq; // 1
        struct contenu{
            int op1;
            char idop;
            int op2;
        } contenu;
    } request1;


    // initialiser un message avant de l'envoyer.
    request1.etiqReq = 1;
    request1.contenu.op1 = atoi(argv[1]);
    request1.contenu.idop = *argv[2];
    request1.contenu.op2 = atoi(argv[3]);

    // Envoi request1
    if(msgsnd(msgid, (void *)&request1, sizeof(request1.contenu), 0) == -1){
        perror("erreur send");
        exit(1);
    }




    // Récupération du résultat depuis le serveur.
    // File etiquette 2.

    // structure des requetes
    struct request2{
        long etiqReq; // 2
        struct contenu{
            int result;
        } contenu;
    } request2;

    // Récupération de la data du serveur.
    // File etiquette 2.
    ssize_t response = msgrcv (
            msgid,   // resultat de msgget()
            &request2, // pointeur tampon reception
            sizeof(request2.contenu),   // longueur max acceptee
            2,// quelle etiquette
            0   // 0 pour l’instant
    );

    printf("%d \n", request2.contenu.result);


    return 0;
}

