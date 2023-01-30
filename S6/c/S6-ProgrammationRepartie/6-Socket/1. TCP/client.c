#include <stdio.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>

int MESSAGE_SIZE_MAX = 10;

int main(int argc, char *argv[]) {

    printf("Début programme\n");

    if (argc != 3) {
        printf("Nombre d'arguments invalide. Utilisation :\n");;
        printf("%s IP PORT\n", argv[0]);
        exit(0);
    }

    int dS = socket(PF_INET, SOCK_STREAM, 0);
    if (dS == -1) {
        printf("Erreur lors de la création du socket. \n");
        exit(0);
    }
    else { printf("Socket Créé\n"); }

    struct sockaddr_in aS;
    aS.sin_family = AF_INET;
    inet_pton(AF_INET,argv[1],&(aS.sin_addr));
    aS.sin_port = htons(atoi(argv[2]));
    socklen_t lgA = sizeof(struct sockaddr_in);
    if (connect(dS, (struct sockaddr *) &aS, lgA) == -1) {
        printf("Erreur lors de la connection au socket. \n");
        printf("%s", strerror(errno));
        exit(0);
    }
    else {
        printf("Socket Connecté\n");
    }

    // Demande une chaine de caractères à l'utilisateur.
    char * m = (char *)malloc(sizeof (char) * MESSAGE_SIZE_MAX);
    fgets(m, MESSAGE_SIZE_MAX, stdin);
//    printf("%s", m);

    ssize_t nb = strlen(m);
    do {
        nb = send(dS, m, nb, 0);
    }
    while (nb);

//    if (send(dS, m, strlen(m) + 1, 0) == -1) {
//        printf("Erreur lors de l'envoi du message. \n");
//        printf("%s", strerror(errno));
//        exit(0);
//    }
//    else { printf("Message Envoyé \n"); }

    int r;
    if (recv(dS, &r, sizeof(int), 0) == -1) {
        printf("Erreur lors de la réception du message. \n");
        exit(0);
    }
    else { printf("Réponse reçue : %d\n", r) ; }

    shutdown(dS,2) ;
    printf("Fin du programme. \n");
}