#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#define NB_ELEMENTS 10

void imprime_tab1(int*, int);
void imprime_tab2(char**, int);
int comp_int(int *, int *);
int comp_str(char **, char **);

void imprime_tab1(int *tab, int nb) 
{
  int   i2;
  printf("\n");
  for (i2 = 0; i2 < nb; i2++)
    printf("%d \t",tab[i2]);
  printf("\n");
  return;
}

}

void imprime_tab2(char **tab, int nb)
{
  int i ;
  printf("\n");
  for (i = 0; i < nb; i++)
    printf("%s \t",tab[i]);
  printf("\n");
  return;

int comp_int(int *a, int *b)
{
  return(*a - *b);
}
int comp_str(char **s1, char **s2)
{
  return(strcmp(*s1,*s2));
}

int main()
{
  int *tab1;
  float x;
  char *tab2[NB_ELEMENTS] = {"toto", "Auto", "auto", "titi", "a", "b",\
"z", "i , "o","d"};
  int i;
  
  tab1 = (int*)malloc(NB_ELEMENTS * sizeof(int));
  for (i = 0 ; i < NB_ELEMENTS; i++)
    tab1[i] = random() % 1000;
  imprime_tab1(tab1, NB_ELEMENTS);
  qsort(tab1, NB_ELEMENTS, sizeof(int), comp_int);
  imprime_tab1(tab1, NB_ELEMENTS);
  /************************/
  imprime_tab2(tab2, NB_ELEMENTS);
  qsort(tab2, NB_ELEMENTS, sizeof(tab2[0]), comp_str);
  imprime_tab2(tab2, NB_ELEMENTS);
  return(EXIT_SUCCESS);
}


