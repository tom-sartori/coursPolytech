#include <printf.h>
#include <string.h>
#include <stdlib.h>


int sizeOf (const char *word) {
    int i = 0;
    while (word [i] != '\0') {
        i++;
    }
    return i;
}

void printAscii (char *word) {
    int size = sizeOf(word);
    for (int i = 0; i < size; i++) {
        printf("%d ", word[i]);
    }
    printf("\n");
}

void maj (char *word) {
    int size = sizeOf(word);
    for (int i = 0; i < size; i++) {
        if (97 <= (int)word[i] && (int)word[i] <= 122) {
            word[i] = (char)(word[i] - 32);
        }
    }
}

void min (char *word) {
    int size = sizeOf(word);
    for (int i = 0; i < size; i++) {
        if (65 <= (int)word[i] && (int)word[i] <= 90) {
            word[i] = (char)(word[i] + 32);
        }
    }
}

void reverseMinMaj (char * word) {
    int size = sizeOf(word);
    for (int i = 0; i < size; i++) {
        if (65 <= (int)word[i] && (int)word[i] <= 90) {
            word[i] = (char)(word[i] + 32);
        }
        else if (97 <= (int)word[i] && (int)word[i] <= 122) {
            word[i] = (char)(word[i] - 32);
        }
    }
}

void reverseWord(char *word){
    char *copy = (char*)malloc(sizeOf(word));
    strcpy(copy, word);
    int index = 0;
    for(int i = sizeOf(word) - 1; i >= 0; --i){
        word[index] = copy[i];
        ++index;
    }
    free(copy);
}

char* reverseWordFgets (){
    char* word = (char*)malloc(50);
    fgets(word, 50, stdin);
    reverseWord(word);

    return word;
}

void removeChar(char *word, char c){
    char *copy = (char*)malloc(sizeOf(word));
    strcpy(copy, word);
    int index = 0;

    for (int i = 0; i < sizeOf(word); ++i){
        if (copy[i] != c){
            word[index] = copy[i];
            ++index;
        }
    }

    word[index] = '\0';
    free(copy);
}

int isPalindrom(char *word) {
    char *copy = (char*)malloc(sizeOf(word));
    strcpy(copy, word);
    reverseWord(copy);

    return strcmp(word, copy) ? -1 : 0;
}

int compare(char* word1, char* word2){
    int size1 = sizeOf(word1);
    int size2 = sizeOf(word2);

    if (size1 != size2){
        return (size1 < size2) ? -1 : 1;
    }
    int i = 0;
    while (i < size1 && word1[i] == word2[i]){
        i += 1;
    }

    return (i == size1) ? 0 : (word1[i] < word2[i]) ? -1: 1;
}

void firstGroup(char *word){
    int size = sizeOf(word);

    if (word[size - 2] == 'e' && word[size - 1] == 'r'){
        char infinitive[size - 2];

        for (int i = 0; i < size - 2; ++i){
            infinitive[i] = word[i];
        }

        printf("Je %se\n", infinitive);
        printf("Tu %ses\n", infinitive);
        printf("Il %se\n", infinitive);
        printf("Nous %sons\n", infinitive);
        printf("Vous %sez\n", infinitive);
        printf("Ils %sent\n", infinitive);
    }
    else {
        printf("Le mot n'est pas du premier groupe. \n");
    }
}


int main (int argc, char *argv[]) {
    printf("sizeOf : %d\n", sizeOf("abc") == 3);
    printAscii("aA");

    char *wordMaj = malloc(sizeof(char) * 100);
    strcpy(wordMaj, "bonSoir");
    maj(wordMaj);
    printf("%s\n", wordMaj);

    min(wordMaj);
    printf("%s\n", wordMaj);

    strcpy(wordMaj, "BoNsOiR");
    reverseMinMaj(wordMaj);
    printf("%s\n", wordMaj);

    reverseWord(wordMaj);
    printf("%s\n", wordMaj);

    removeChar(wordMaj, 'b');
    printf("%s\n", wordMaj);

    printf("Palindrome : %d\n", isPalindrom("radar"));
    printf("Palindrome : %d\n", isPalindrom("mur"));

    firstGroup("Chanter");
}

