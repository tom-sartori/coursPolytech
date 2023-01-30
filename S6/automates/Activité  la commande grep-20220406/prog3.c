#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <ctype.h>

#define NB_ELEMENTS 4

int comp_str_maj(char **, char **);

int comp_str_maj(char **s1, char **s2)
{
  int i; 
  char *chaine1, *chaine2;

  chaine1 = (char*)malloc(strlen(*s1) * sizeof(char));
  chaine2 = (char*)malloc(strlen(*s2) * sizeof(char));
  for (i = 0; i < strlen(*s1); i++)
    chaine1[i] = tolower((*s1)[i]);
  for (i = 0; i < strlen(*s2); i++)
    chaine2[i] = tolower((*s2)[i]);
  return(strcmp(chaine1,chaine2));
}

int main(int argc, char *argv[])
{
  char *tab[NB_ELEMENTS] = {"TOTO", "Auto", "auto", "titi"};
  char **res;

  qsort(tab, NB_ELEMENTS, sizeof(tab[0]), comp_str_maj);
  if ((res = bsearch(&argv[1],tab,NB_ELEMENTS,sizeof(tab[0]),comp_str_maj)) ==\
NULL) 
    printf("\nLe tableau ne contient pas l'element %s\n",argv[1]);
  else
    printf("\nLe tableau contient l'element %s sous la forme %s\n",argv[1], \ 
*res);
  return(EXIT_SUCCESS);
}
