#include <stdio.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char *argv[]) {

    if (argc != 2) {
        printf("Nombre d'arguments invalide. Utilisation :\n");;
        printf("%s PORT\n", argv[0]);
        exit(0);
    }

    printf("Début programme\n");

    // création socket ipv4 tcp
    int dS = socket(PF_INET, SOCK_DGRAM, 0);
    printf("Socket Créé\n");

    struct sockaddr_in ad;
    ad.sin_family = AF_INET;
    ad.sin_addr.s_addr = INADDR_ANY;
    ad.sin_port = htons(atoi(argv[1]));

    // rend la socket visible et donc accessible par les clients
    if (bind(dS, (struct sockaddr *)&ad, sizeof(ad)) == -1)
    {
        printf("erreur nommage socket serveur\n");
        perror("erreur");
        exit(0);
    }
    printf("Socket Nommé\n");

    struct sockaddr_in aE;

    socklen_t lg = sizeof(struct sockaddr_in);

    char m[20];

    if (recvfrom(dS, m,20 * sizeof(char), 0, (struct sockaddr *)&aE, &lg) == -1)
    {
        printf("erreur message recu\n");
        perror("erreur message recu\n");
        exit(0);
    }

    printf("reçu %s \n", m);

    int r = 10;

    if (sendto(dS, &r, sizeof(int), 0, (struct sockaddr *)&aE, lg) == -1)
    {
        printf("erreur envoi message\n");
        perror("erreur envoi message\n");
        exit(0);
    }

    printf("message envoyé\n");

    shutdown(dS,2);
}