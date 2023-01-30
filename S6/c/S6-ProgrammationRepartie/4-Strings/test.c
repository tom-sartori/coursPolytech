#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define TAILLE 100


int compterCaractere(char* chaine){
    int compteur = 0;
    while(chaine[compteur] != NULL){
        compteur += 1;
    }
    return compteur;
}


void afficherEnDecimal(char* chaine){
    for (int i = 0; i < compterCaractere(chaine); ++i){
        printf("%d ", chaine[i]);
    }
    printf("\n");
}


void mettreEnMajuscule(char* chaine){
    for (int i = 0; i < compterCaractere(chaine); ++i){
        if (chaine[i] >= 97 && chaine[i] <= 122){
            chaine[i] -= 32;
        }
    }
}

void mettreEnMinuscule(char* chaine){
    for (int i = 0; i < compterCaractere(chaine); ++i){
        if (chaine[i] >= 65 && chaine[i] <= 90){
            chaine[i] += 32;
        }
    }
}

void transformerMinMaj(char* chaine){
    for (int i = 0; i < compterCaractere(chaine); ++i){
        if (chaine[i] >= 65 && chaine[i] <= 90){
            chaine[i] += 32;
        }
        else if (chaine[i] >= 97 && chaine[i] <= 122){
            chaine[i] -= 32;
        }
    }
}

void retournerMot(char* chaine){
    char* copie = (char*)malloc(compterCaractere(chaine));
    strcpy(copie,chaine);
    int index = 0;
    for(int i = compterCaractere(chaine) - 1; i >= 0; --i){
        chaine[index] = copie[i];
        ++index;
    }
    free(copie);
}

char* reverseWordFgets(){
    char* userChaine = (char*)malloc(TAILLE);
    fgets(userChaine,TAILLE,stdin);
    retournerMot(userChaine);
    return userChaine;
}

void removeChar(char* chaine, char carac){
    char* copie = (char*)malloc(compterCaractere(chaine));
    int index = 0;
    strcpy(copie,chaine);
    for (int i = 0; i < compterCaractere(chaine); ++i){
        if (copie[i] != carac){
            chaine[index] = copie[i];
            ++index;
        }
    }
    chaine[index] = '\0';
    free(copie);
}


int estPalindrome(char* chaine){
    char* moitie = (char*)malloc(compterCaractere(chaine)/2);
    for (int i = 0; i < compterCaractere(chaine) / 2; ++i){
        moitie[i] = chaine[i];
    }
    char* autreMotie = (char*)malloc(compterCaractere(chaine)/2);
    int compteur;
    if ((compterCaractere(chaine) %2) != 0){
        compteur = (compterCaractere(chaine) / 2) + 1;
    }
    else {
        compteur = (compterCaractere(chaine) / 2);
    }
    int index = 0;
    for (int i = compterCaractere(chaine) - 1; i >= compteur; --i){
        autreMotie[index] = chaine[i];
        index += 1;
    }
    if(strcmp(autreMotie,moitie) == 0){
        free(autreMotie);
        free(moitie);
        return 0;
    }
    else {
        free(autreMotie);
        free(moitie);
        return -1;
    }
}


int compare(char* chaine1, char* chaine2){
    if (compterCaractere(chaine1) != compterCaractere(chaine2)){
        if (compterCaractere(chaine1) < compterCaractere(chaine2)){
            return -1;
        }
        else {
            return 1;
        }
    }
    else {
        int i = 0;
        while (i < compterCaractere(chaine1) && chaine1[i] == chaine2[i]){
            i += 1;
        }

        if (i == compterCaractere(chaine1)){
            return 0;
        }
        else {
            if (chaine1[i] < chaine2[i]){
                return - 1;
            }
            else {
                return 1;
            }
        }
    }
}


void premierGroupe(char* verbe){
    //verif du verbe premier groupe 'er'
    int tailleVerbe = compterCaractere(verbe);
    if (verbe[tailleVerbe - 2] == 'e' && verbe[tailleVerbe - 1] == 'r'){
        char infinif[tailleVerbe -2];
        for (int i = 0; i < tailleVerbe -2; ++i){
            infinif[i] = verbe[i];
        }
        printf("Je %se\n", infinif);
        printf("Tu %ses\n", infinif);
        printf("Il %se\n", infinif);
        printf("Nous %sons\n", infinif);
        printf("Vous %sez\n", infinif);
        printf("Ils %sent\n", infinif);
    }
    else {
        printf("Le verbe n'est pas du premier groupe (ne termine par par -er)\n");
    }
}



int main(int argc, char const *argv[])
{
    /* code */
    char* chaineTest = (char*)malloc(TAILLE);
    strcpy(chaineTest,"SaLuTt");
    printf("la chaine contient %d caractères \n", compterCaractere(chaineTest));
    afficherEnDecimal(chaineTest);
    transformerMinMaj(chaineTest);
    printf("%s \n" , chaineTest);
    retournerMot(chaineTest);
    printf("%s \n", chaineTest);
    supprimerCaractere(chaineTest,'U');
    printf("%s \n", chaineTest);
    char* chainepal = (char*)malloc(TAILLE);
    char* chainecmp = (char*)malloc(TAILLE);
    strcpy(chainepal,"coco");
    strcpy(chainecmp,"cwco");
    printf("%s est palindrome ? : %d \n", chainepal,estPalindrome(chainepal));
    printf("%s = %s ? %d\n", chainepal, chainecmp, comparerChaine(chainepal,chainecmp));
    char* verbeTest = (char*)malloc(TAILLE);
    strcpy(verbeTest,"chanter");
    premierGroupe(verbeTest);
    return 0;
}
