#include <stdio.h>
#include <dirent.h>
#include <string.h>
#include <pthread.h>
#include <unistd.h>
#include <signal.h>
#include <stdlib.h>

#include "main.h"


char sourceDirPath[1024];
char targetDirPath[1024];
const char *LOGS_FILE_PATH = "./logs/errors.log";

pthread_mutex_t mutex;

int main (int argc, char **argv){

    /// 1
    // Check les deux arguments en entrée
    // argv[1] = dossier départ
    // argv[2] = dossier arrivée

    if (argc != 3) {
        printf("Erreur d'arguments. ");
        exit(EXIT_FAILURE);
    }

    strcat(sourceDirPath, argv[1]);
    strcat(sourceDirPath, "/");

    strcat(targetDirPath, argv[2]);
    strcat(targetDirPath, "/");


    /// 2
    // Lire tous les fichiers du dossier de départ
    // Foreach copier le filename dans une liste et incrémenter un compteur.
    // liste = listNameFile et compteur = n.

    DIR *folder;
    struct dirent *entry;
    int files = 0;

    folder = opendir(sourceDirPath);
    if(folder == NULL) {
        perror("Unable to read directory");
        return(1);
    }

    char listNameFile[200][200];    // 200 files max dans le directory.
    int n = 0;

    while( (entry = readdir(folder)) ) {
        files++;
        printf("File %3d: %s\n", files, entry->d_name);
        if (strcmp(entry->d_name, ".") != 0 && strcmp(entry->d_name, "..") != 0) {  // On prend pas en compte les "fichiers" : "." et "..".
            strcpy(listNameFile[n], entry->d_name); // Add le filename dans la liste.
            n++;
        }
    }
    // On a listNameFile remplit des noms des fichiers. [0 : n[


    /// 3.
    // Préparation du signal.
    signal(SIGUSR1, traitement);


    /// 4.
    // Création des n threads.
    // Chaque thread va dans une fonction (threadCopyPast) avec listNameFile[i] en param.

    pthread_t pthread[n];
    int testThread;
    for (int i = 0; i < n; i++) {
        testThread = pthread_create(&pthread[i], NULL, threadCopyPast, listNameFile[i]);
        if (testThread) {
            printf("Error:unable to create thread, %d\n", testThread);
            exit(EXIT_FAILURE);
        }
    }

    closedir(folder);

    pthread_exit(NULL);
}


void *threadCopyPast (void *fileName) {
    /// 5.
    // Le thread arrive dans cette fonction.
    // On créé le source file path et le target (à partir des variables globales sourceDirPath et targetDirPath).
    // On utilise la fonction copyPast, avec les bons filepath en argument.

    char sourceFilePath[300];
    char targetFilePath[300];

    strcpy(sourceFilePath, sourceDirPath);  // sourceFilePath prend le path complet du directory.
    strcat(sourceFilePath, fileName);  // On add le file name à la suite du directory's path.

    strcpy(targetFilePath, targetDirPath);  // Same for target.
    strcat(targetFilePath, fileName);


    if (!copyPast(sourceFilePath, targetFilePath)){
        /// 7.
        // S'il y a un problème dans le copy past :
        // On log l'erreur dans le fichier errors.log.
        // On kill pour trigger le signal. (Signal préparé à l'étape 4 : ligne 71)

        logError(fileName);
        kill(getpid(), SIGUSR1);    // If copyPast didn't work, we signal the error.
        sleep(1);   // Need to sleep le temps qu'il printf le traitement.
    }

    pthread_exit(NULL);
}


// Return 0 if error.
int copyPast (char sourceFile[200], char targetFile[200]) {
    /// 6.
    // Fonction qui copie le contenu de sourceFile, dans targetFile.

    char ch;
    FILE *source, *target;

    source = fopen(sourceFile, "r");

    if( source == NULL ) {
//        printf("Error : source file. \n");
        return 0;
//        exit(EXIT_FAILURE);
    }


    target = fopen(targetFile, "w");

    if( target == NULL ) {
        fclose(source);
//        printf("Error : target file. \n");
        return 0;
//        exit(EXIT_FAILURE);
    }

    while( ( ch = fgetc(source) ) != EOF ) {
        fputc(ch, target);
    }

    printf("Source : %s | target : %s | Success. \n", sourceFile, targetFile);

    fclose(source);
    fclose(target);

    return 1;   // Everything goes well.
}


void logError (char *fileName) {
    /// 8.
    // Le path du fichier est une constante.
    // On fait un sémaphore le temps d'écrire dans le file.

    //pthread_mutex_init(&mutex, 0);    // Fonctionne si pas init. Utilité ?
    pthread_mutex_lock(&mutex); // On bloque le sémaphore le temps d'écrire dans le fichier -> évite d'avoir deux threads qui écrivent en même temps.

    FILE *errors = fopen(LOGS_FILE_PATH, "r+");

    char ch;
    while( ( ch = fgetc(errors) ) != EOF ) {    // Go to the end of the file for after that, add fileName at the end of the file.
        ch = ch;
    }

    fputs(fileName, errors);
    fputs("\n", errors);

    fclose(errors);

    pthread_mutex_unlock(&mutex);   // On débloque le sémaphore.
}


void traitement (int n) {
    printf("Signal : %d | Erreur fichier, voir errors.log\n", n);
}
