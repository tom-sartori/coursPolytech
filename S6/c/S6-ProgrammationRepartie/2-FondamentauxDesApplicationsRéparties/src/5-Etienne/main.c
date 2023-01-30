#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <string.h>
#include <dirent.h>
#include <pthread.h>

#define MAX 100
pthread_mutex_t mutex;

typedef struct pathnames pathnames;

struct pathnames{
    char* entry;
    char* destination;
    char* filename;
} ;

void* copieFile(void* args){
    pathnames* paths = args;
    printf("thread lancé + namefile = %s\n" , paths->filename);
    char command[MAX];
    strcat(strcat(strcat(strcat(strcat(strcpy(command,"cp "),paths->entry),"/"),paths->filename)," "),paths->destination);
    printf("command : %s \n", command);
    if (system(command) != 0){
        pthread_mutex_lock(&mutex);
        printf("erooor copie");
        char error[MAX];
        strcat(strcat(strcat(strcat(strcat(strcpy(error,"echo "),"error "),paths->filename)," >> "),paths->destination),"/errors.log");
        system(error);
        kill(getppid(),SIGUSR1);
        pthread_mutex_unlock(&mutex);
    }
    free(paths);
}

int verifDir(char* dirname){
    DIR *d;
    struct dirent *dir;
    d = opendir(".");
    if (d)
    {
        while ((dir = readdir(d)) != NULL)
        {
            if(strcmp(dir->d_name,dirname) == NULL){
                closedir(d);
                return 1;
            }
        }
        closedir(d);
    }
    return(0);
}

int getFiles(char** tabFiles,char* nameDirectory){
    DIR *d;
    char stringPath[MAX];
    strcat(strcpy(stringPath,"./"),nameDirectory);
    int compteur = 0;
    struct dirent *dir;
    d = opendir(&stringPath);
    if (d)
    {
        while ((dir = readdir(d)) != NULL)
        {
            if (strstr(dir->d_name,".") && strcmp(dir->d_name,".") != NULL && strcmp(dir->d_name,"..") != NULL){
                tabFiles[compteur] = dir->d_name;
                compteur++;
                printf("file : %s\n", dir->d_name);
            }
        }
        closedir(d);
    }
    return compteur;
}


void afficherErreur(int id){
    printf("Erreur %d -> voir error.log", id);
}

int main(int argc, char** argv){

    if (argc - 1 != 2){
        printf("Nombre d'arguments insuffisants (%d != 2)" , argc - 1);
        exit(0);
    }
    else {
        if (verifDir(argv[1]) == 1 && verifDir(argv[2]) == 1){
            signal(SIGUSR1, afficherErreur);
            char* namesFiles[MAX];
            int nbFile = getFiles(namesFiles,argv[1]);
            pthread_t listeThread[nbFile];
            int i;
            printf("nbFile : %d \n" , nbFile);
            printf("je suis hors de la boucle %s\n",namesFiles[1]);
            for(i = 0; i < nbFile; ++i){
                pathnames* path = (pathnames*)malloc(sizeof(pathnames));
                path->entry = argv[1];
                path->destination = argv[2];
                path->filename = namesFiles[i];
                printf("entry = %s  , destination = %s , filename = %s \n", path->entry, path->destination, path->filename);
                printf("i = %d\n" , i);
                printf("je suis dans la boucle %s \n", path->filename);
                if(pthread_create(&listeThread[i],NULL,copieFile,path)){
                    free(path);
                }
            }
            for (i = 0; i < nbFile; ++i){
                pthread_join(listeThread[i],NULL);
            }
        }
        else {
            printf("Au moins un nom des dossiers est invalide\n");
            exit(0);
        }
    }
}