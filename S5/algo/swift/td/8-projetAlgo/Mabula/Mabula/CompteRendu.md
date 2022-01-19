# Compte rendu 

Groupe composé de **HERMET Robin** et **SARTORI Tom**. Ce compte rendu est pour le protocol du jeu **mabula**, du groupe composé de **CLEMENT Corentin** et **FONDARD Alexis**. 


- ## PTMabule 

  - Fonction `compterMax`  
  
  <br>
  Vous aviez mis dans le protocol, le code suivant : 

  ```swift 
  // Compte la longueur maximale parmi les groupes des billes du joueur j.
  func compterMax() -> Int
  ```

  Cependant on ne peut pas savoir de quel joueur en parle. C'est sûrement juste un oubli, car au début vous aviez un type `Joueur`.  

  <br>
  Nous avons modifié la fonction de la manière suivante :  

  ```swift
  // Retourne la taille du plus grand groupe pour la couleur en param.
  // Si isForWhite == true, alors on calcule pour les blancs/le joueur 1, sinon les noirs/le joueur 2.
  //
  // compterMax : PTMabula x Bool -> PTMabula x Int
  public mutating func compterMax (isForWhite: Bool) -> Int
  ```

  - Fonction `compterMultiplication`
  <br>
  Vous aviez mis dans le protocol, le code suivant : 
  
  ```swift
  // Compte la multiplication de la longueur de chaque groupe de bille du joueur j.
  func compterMultiplication() -> Int
  ```

  Cependant on ne peut pas non plus savoir de quel joueur on parle. Ca semble être le même oubli que pour la fonction `getScoreBestGroup`. 

  <br>
  Nous avons donc modifié la signature de la fonction, de la manière suivante : 

  ```swift
  // Retourne la multiplication de tous les groupes du joueur en param.
  // Si isForWhite == true, alors on calcule pour les blancs/le joueur 1, sinon les noirs/le joueur 2.
  //
  // compterMultiplication : PTMabula x Bool -> PTMabula x Int
  public mutating func compterMultiplication(isForWhite: Bool) -> Int
  ```

  - Fonction `isPlayerOneWin`  
  Cette fonction n'était pas `mutating` dans le protocol. Cependant, nous avons du la mettre `mutating`. 


- main 
  - Impossible de le compiler. Rien ne fonctionnait. 
  - Tous les `readLine` étaient utilisés comme s'il renvoyaient des `String`, alors qu'ils renvoient des `String?`. De ce fait, pour pouvoir les utiliser, il faut les mettre dans des `if`. En plus, à cause de ça, certaines variables n'étaient pas initialisées. 
  - La partie graphique n'était pas très visuelle et fonctionnelle. 

  - Nous avons donc refait toute l'interface du main. 


- Conclusion
  - Le `PTMabula` était très bien et fonctionnel. Nons avons juste du légèrement modifier les signatures de trois fonctions. De plus, ces modifications étaient surement dues à des oublis lors des changements de dernières minutes. 
  - Le `main` n'était pas du tout fonctionnel et nous avons donc du tout refaire. 
  - Dans l'ensemble, le tout était tout de même propre et fonctionnel. Nous n'avons pas eu de mal a comprendre les spécifications et implémenter le mabula, qui est maintenant fonctionnel. 
    