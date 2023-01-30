#include <stdio.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <unistd.h>



void getStringOn (char string[10], int i) {
    string[0] = 'B';
    char buffer[10];
    sprintf(buffer, "%d", i);
    strcat(string, buffer);
    strcat(string, "on");
}

void getStringOff (char *string, int i) {
    string = "";
    string[0] = 'B';
    char buffer[10];
    sprintf(buffer, "%d", i);
    strcat(string, buffer);
    strcat(string, "off");
}


int main (int argc, char *argv[]) {

    if (argc != 3) {
        printf("Nombre d'arguments invalide. Utilisation :\n");
        printf("%s IP PORT\n", argv[0]);
        exit(0);
    }

    int dS = socket(PF_INET, SOCK_DGRAM, 0);
    if (dS == -1) {
        perror("Error socket. \n");
        exit(1);
    }

    struct sockaddr_in aD;
    aD.sin_family = AF_INET;
    inet_pton(AF_INET, argv[1], &(aD.sin_addr));
    aD.sin_port = htons(atoi(argv[2]));
    socklen_t lgA = sizeof(struct sockaddr_in);


    for (int i = 8; i >= 0; i--) {
//        char stringOn[6];
//        getStringOn(stringOn, i);


        char stringOn[10] = "B";
        char buffer[2];
        sprintf(buffer, "%d", i);
        strcat(stringOn, buffer);
        strcat(stringOn, "on");


        printf("test\n");
//        char stringOn[4];
//        stringOn[0] = 'B';
//        stringOn[1] = '4';
//        stringOn[2] = 'o';
//        stringOn[3] = 'n';

//        char stringOff[10];
//        getStringOff(stringOff, i - 2);
//
//        char string[10];
//        char buffer[10];
//        sprintf(buffer, "%d", i);
//        strcat(string, "B");
//        strcat(string, buffer);
//        strcat(string, "on");

        printf("%s\n", stringOn);

        int sendTo = sendto(dS, stringOn, strlen(stringOn), 0, (struct sockaddr *) &aD, lgA);
        if (sendTo == -1) {
            perror("Error sendTo \n");
            printf("%s", strerror(errno));
            exit(1);
        }

//        sendto(dS, stringOff, strlen(stringOff), 0, (struct sockaddr *) &aD, lgA);

        sleep(1);
    }



    int r;
    int recv = recvfrom(dS, &r, sizeof(int), 0, NULL, NULL);
    if (recv == -1) {
        perror("Error recvfrom. \n");
        exit(1);
    }

    printf("reponse : %d \n", r);
    shutdown(dS, 2);
}
