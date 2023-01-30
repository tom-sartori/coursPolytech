#include <sys/msg.h>
#include <stdio.h>
#include <stdlib.h>


// $1 = filePath


int calculate (int op1, char idop, int op2) {
    switch (idop) {
        case '+':
            return op1 + op2;
        case '-':
            return op1 - op2;
        case '*':
            return op1 * op2;
        case '/':
            return op1 / op2;
        default: {
            printf("Error while calculating. ");
            exit(1);
        }
    }
}

int main (int argc, char *argv[]){
    // Création de la clé. Doit etre la meme que coté client.
    key_t cle = ftok(argv[1], 'z');
    if (cle == -1) {
        perror("erreur ftok");
        exit(1);
    }

    // Création (ou pas) de la file.
    int f_id = msgget(cle, IPC_CREAT|0666);

    // structure des requetes
    struct request1{
        long etiqReq; // 1
        struct contenu{
            int op1;
            char idop;
            int op2;
        } contenu;
    } request1;

    ssize_t response;

//    while (1) {
//        response = msgrcv (
//                f_id,   // resultat de msgget()
//                &request2, // pointeur tampon reception
//                sizeof(request2.contenu),   // longueur max acceptee
//                1,// quelle etiquette
//                0   // 0 pour l’instant
//        );
//        printf("%d \n", calculate(request2.contenu.op1, request2.contenu.idop, request2.contenu.op2));
//    }



    while (1) {

        // Récupération de la data du client.
        // File etiquette 1.
        response = msgrcv(
                f_id,   // resultat de msgget()
                &request1, // pointeur tampon reception
                sizeof(request1.contenu),   // longueur max acceptee
                1,// quelle etiquette
                0   // 0 pour l’instant
        );

        // msgrcv bloquant, donc on passe a la suite quand il a recu la data du client.
        int result = calculate(request1.contenu.op1, request1.contenu.idop, request1.contenu.op2);
//    printf("%d \n", result);


        // Envoi du résultat au client.
        // Etiquette file : 2.

        // structure des requetes
        struct request2 {
            long etiqReq; // 2
            struct contenu {
                int result;
            } contenu;
        } request2;

        request2.etiqReq = 2;
        request2.contenu.result = result;

        // Envoi result => request2
        if (msgsnd(f_id, (void *) &request2, sizeof(request2.contenu), 0) == -1) {
            perror("erreur send");
            exit(1);
        }
    }
}
