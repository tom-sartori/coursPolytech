```java
int [] p = { 1, 5, 8, 9 };
int n = 4;
```

| Taille d'entrée | Taille max planche |
|:---------------:|:------------------:|
|        4        |         20         |
|        0        |         4          |
|        4        |         3          |
|        1        |         3          |
|        0        |         1          |
|        4        |         2          |
|        2        |         2          |
|        0        |         2          |
|        2        |         1          |
|        1        |         1          |
|        0        |         1          |
|        4        |         1          |
|        3        |         1          |
|        2        |         1          |
|        1        |         1          |
|        0        |         1          |


Avec :
```java 
if (tailleMaxPlanche == 1) {
    return tailleRestante * p[0];
}
```

| Taille d'entrée | Taille max planche |
|:---------------:|:------------------:|
|        4        |         20         |
|        0        |         4          |
|        4        |         3          |
|        1        |         3          |
|        0        |         1          |
|        4        |         2          |
|        2        |         2          |
|        0        |         2          |
|        2        |         1          |
|        4        |         1          |


```java
int [] p = { 1, 5, 8, 9 };
int n = 6;
```

| Taille d'entrée | Taille max planche |
|:---------------:|:------------------:|
|        6        |         20         |
|        2        |         4          |
|        6        |         3          |
|        3        |         3          |
|        0        |         3          |
|        3        |         2          |
|        1        |         2          |
|        6        |         2          |
|        4        |         2          |
|        2        |         2          |
