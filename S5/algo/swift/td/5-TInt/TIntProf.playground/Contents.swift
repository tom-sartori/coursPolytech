//#-hidden-code

import Foundation

extension TInt{
   var description: String {
      var ret = ""
      for i in 0..<self.count{
         if i == 0 { ret += "[" }
         ret += "\(self[i])"
         if i<self.count-1 { ret += "," }
      }
      ret += "]"
      return ret
   }
   
   
}



struct TabInt : TInt{
   
   // stockage des données du tableau
   private var tab : [Int]
   
   /// init(a,n) crée un tableau de *n* éléments initialisés avec la valeur *val*
   /// - Parameters:
   ///   - val: valeur initiale dans toutes les cases du tableau
   ///   - count: nombre de cases du tableau
   init(val: Int, count: Int) {
      assert(count > 0,"TInt must contain at least one element")
      self.count = count
      self.min   = val
      self.max   = val
      self.tab   = [Int](repeating: val, count: count)
   }
   
   /// nombre d’éléments du tableau
   private(set) var count: Int
   /// valeur maximum appartenant au tableau
   private(set) var max: Int
   /// valeur minimum appartenant au tableau
   private(set) var min : Int
   
   subscript(index: Int) -> Int {
      get {
         assert((index >= 0) && (index < self.count), "index \(index) out of range")
         return self.tab[index]
      }
      set {
         assert((index >= 0) && (index < self.count), "index \(index) out of range")
         self.tab[index] = newValue
         if newValue > self.max {
            self.max = newValue
         }
         if newValue < self.min {
            self.min = newValue
         }
         
      }
   }
   
   func firstIndex(val: Int) -> Int? {
      var i : Int = 0 // compteur de boucle
      while (i < tab.count) && (self.tab[i] != val) {
         assert(!(tab[i] == val)) // invariant jusqu'à i inclu, on n'a pas trouvé val
         i += 1
      }
      assert((i >= tab.count) || (tab[i] == val)) // condition d'arrêt
      return ((i < tab.count) ? i : nil)
   }
   
   func lastIndex(val: Int) -> Int? {
      var i : Int = self.count - 1 // compteur de boucle
      while (i >= 0) && (self.tab[i] != val) {
         assert(tab[i] != val) // invariant jusqu'à i inclu, on n'a pas trouvé val
         i -= 1
      }
      assert((i < 0) || (tab[i] == val)) // condition d'arrêt
      return ((i >= 0) ? i : nil)
   }
   
   func nbOccur(val: Int) -> Int {
      var n : Int = 0 // nombre d'occurences de val
      for v in self.tab{
         if v == val { n += 1 }
      }
      return n
   }
   
   func contains(val: Int) -> Bool {
      var i : Int = 0 // compteur de boucle
      while (i < tab.count) && (self.tab[i] != val) {
         assert(tab[i] != val) // invariant jusqu'à i inclu, on n'a pas trouvé val
         i += 1
      }
      assert((i >= tab.count) || (self.tab[i] == val)) // condition d'arrêt
      return i<tab.count
   }
   
   /// compare le tableau à un autre tableau *tab*
   /// - Parameters:
   ///   - tab: tableau auquel on se compare de taille supérieure ou égale
   /// - Returns: 0 si les valeurs des tableaux sont les mêmes et que les tableaux sont de même taille, -1 si tous les éléments du tableau sont plus petits que les éléments de *tab* à la même position, 1 sinon. Si le tableau est de taille supérieure à celle de *tab* alors `compare` retourne 1
   func compare(tab: TabInt) -> Int{
      guard self.count <= tab.count else { return 1 }
      var ret = 0 // on les suppose égaux
      var i : Int = 0 // compteur de boucle
      while (i < self.count) && (self[i] <= tab[i]){
         if self[i] < tab[i] { ret = -1 }
         // invariant : (self[i] ≤ tab[i]) &&
         //             ( ((ret==0) => ∀ 0≤j≤i, self[j]==self[j]) || (ret==-1))
         i += 1
      }
      // arrêt : (i>=self.count) || (self[i] > tab[i])
      if i < self.count { ret = 1 }
      return ret
   }
   
   /// le tableau est-il sous tableau de celui passé en paramètre ?
   /// - Parameter tab: le tableau pour lequel on doit vérifier si on est sous-tableau
   /// - Returns: true si T1 est sous-tableau de T2, et false sinon. T1 est sous-tableau de T2 si  `∃ 0⩽k<count, tel que ∀ 0⩽i<tab.count, T1[i]==T2[k+i]`
   func isSub(tab: TabInt) -> Bool{
      guard self.count <= tab.count else { return false }
      var i : Int
      var k = 0
      var foundSubTab = false
      // invariant : pas encore trouvé de sous-tableau à partir de k
      while (k <= (tab.count - self.count)) && !foundSubTab{
         i = 0
         while( (i<self.count) && (self[i]==tab[k+i]) ){
            // invariant: ∀ 0≤i<count, self[i]==tab[k+i]
            i += 1
         }
         // arret : (i≥count) || (self[i]!=tab[k+i]
         foundSubTab = i >= self.count
         k += 1
      }
      // arrêt : k > tab.count - count || foundSubTab
      return foundSubTab
   }
}

//#-end-hidden-code


//: # TD Tableaux : implémentation d'un type concret du type abstrait (`TInt`)


/*:
 
 ### Objectif : fournir une implémentation d'un type concret conforme au protocol `TInt`
 
 Un type concret `TabInt` a déjà implémenté et vous pouvez voir une série de tests avec ce type à la fin du playground.
 
 Le `protocol` décrivant le type abstrait est fourni ci-dessous.
 
 (voir les questions après avoir lu le `protocol TInt`)

 */

protocol TInt : CustomStringConvertible{
   /// init(a,n) crée un tableau de *n* éléments initialisés avec la valeur *val*
   /// - Parameters:
   ///   - val: valeur initiale dans toutes les cases du tableau
   ///   - count: nombre de cases du tableau
   init(val: Int, count: Int)
   
   /// nombre d’éléments du tableau
   var count : Int { get }
   /// valeur maximum appartenant au tableau
   var max : Int { get }
   /// valeur minimum appartenant au tableau
   var min : Int { get }

   /// permet d'accéder à l'élément d'indice *index* ou de modifier cet élément
   /// - Parameters:
   ///   - index: index de la valeur cherchée ou à modifier
   /// - Precondition:
   ///   - 0 ≤ index < count
   subscript(index: Int) -> Int { get set }
   
   /// l’entier donnée en paramètre appartient-il au tableau ?
   /// contains(T,a) ⇒ ∃i, T[i]==a
   /// - Parameter val: est-ce que *val* appartient au tableau ?
   /// - Returns: `true`  si  *val* appartient au tableau, `false`
   func contains(val: Int) -> Bool
   
   /// indice de la première valeur (dans l’ordre des indices) donnée en paramètre
   ///
   /// `firstIndex(T,a)==i ⇒ (T[i]==a` et `∀ 0⩽j<i, T[j]≠a)`
   ///
   /// `firstIndex(T,a)==nil ⇒ ∀ 0⩽i<n, T[i]≠a`
   /// - Parameter val: valeur dont ont veur l'index
   /// - Returns: le premier index de la *val* ou `nil` si *val* n'appartient pas au tableau
   func firstIndex(val: Int) -> Int?

   /// indice de la dernière valeur (dans l’ordre des indices) donnée en paramètre
   ///
   /// `lastIndex(T,a)==i ⇒ (T[i]==a` et `∀ i⩽j<count, T[j]≠a)`
   ///
   /// `firstIndex(T,a)==nil ⇒ ∀ 0⩽i<n, T[i]≠a`
   /// - Parameter val: valeur dont ont veur l'index
   /// - Returns: le dernier index de la *val* ou `nil` si *val* n'appartient pas au tableau
   func lastIndex(val: Int) -> Int?
   
   /// nombre d'occurences de *val*
   ///
   /// `nbOccur(T,a)==p⇒ ∃i 0,...,i_p` tel que `∀i k,O⩽k⩽p, i_k ∈ [0,count−1] et T[i_k]==a`
   /// - Parameter val: la valeur dont on veut connaître le nombre d'occurences dans le tableau
   /// - Returns: le nombre d'occurences de *val* dans le tableau, 0 si *val* n'appartient pas au tableau
   func nbOccur(val: Int) -> Int
   
   /// compare le tableau à un autre tableau *tab*
   /// - Parameters:
   ///   - tab: tableau auquel on se compare de taille supérieure ou égale
   /// - Returns: 0 si les valeurs des tableaux sont les mêmes et que les tableaux sont de même taille, -1 si tous les éléments du tableau sont plus petits que les éléments de *tab* à la même position, 1 sinon. Si le tableau est de taille supérieure à celle de *tab* alors `compare` retourne 1
   func compare(tab: Self) -> Int

   /// le tableau est-il sous tableau de celui passé en paramètre ?
   /// - Parameter tab: le tableau pour lequel on doit vérifier si on est sous-tableau
   /// - Returns: true si T1 est sous-tableau de T2, et false sinon. T1 est sous-tableau de T2 si  `∃ 0⩽k<count, tel que ∀ 0⩽i<tab.count, T1[i]==T2[k+i]`
   func isSub(tab: Self) -> Bool
   
   /// voulu par le protocole CustomStringConvertible -> valeur de l'instance sous forme de chaine de caractères
   /// note : il n'est pas nécessaire de mettre ceci ici car CustomStringConvertible le réclame
   ///      je l'ai mis pour que vous voyez bien qu'il faut rajouter cette propriété car vous ne connaissez pas CustomStringConvertible
   var description : String { get }
}

/*:
 
 ### question 1 et 2
 
 Vous devez
 - implémentez votre propre type concret (en l'appelant différemment de `TabInt`), question 1 et 2 du TD 05 ;
  - Remplacez dans le code `TabInt` par votre propre type et testez votre solution.
 
 - Note: vérifiez que les parties de code correspondantes à la question 3 (voir plus bas) sont bien commentées.
 \
vous pouvez dans un premier temps les décommenter pour tester avec `TabInt`

 */

var t = TabInt(val: 0, count: 10)
for i in 0..<t.count{
   t[i] = i
}
print("t=\(t)")
print("t.count = \(t.count)")
print("t.min = \(t.min)")
print("t.max = \(t.max)")
print("t.contains(val: 10)=\(t.contains(val: 10))")
print("t.contains(val: 8)=\(t.contains(val: 8))")
t[2] = 10 ; t[5] = 10 ; t[8] = 10
print("t.firstIndex(val: 10)=\(String(describing: t.firstIndex(val: 10)))")
print("t.lastIndex(val: 10)=\(String(describing: t.lastIndex(val: 10)))")
print("t.firstIndex(val: 11)=\(String(describing: t.firstIndex(val: 11)))")
print("t.lastIndex(val: 11)=\(String(describing: t.lastIndex(val: 11)))")
print("t.nbOccur(val: 2)=\(t.nbOccur(val: 2))")
print("t.nbOccur(val: 10)=\(t.nbOccur(val: 10))")
print("t.nbOccur(val: 1)=\(t.nbOccur(val: 1))")
/*:

 ### Test de compare (question 3)

 Vous devez
 - implémentez la fonction `compare` ;
 - décommentez les lignes de code correspondantes dans le playground que vous avez du commenter à la question précédente ;
 - remplacez `TabInt` par votre propre type (attention plusieurs lignes sont concernées) ;
 - testez votre solution.

 - Note:  partie de code à commenter ou décommenter selon les besoins
*/

/*
var t1 = TabInt(val: 1, count: 3)
var t2 = TabInt(val: 1, count: 4)
t1[0] = 4 ; t1[1] = 2 ; t1[2] = 5
t2[0] = 4 ; t2[1] = 2 ; t2[2] = 5
print("t1.compare(tab: t2)=\(t1.compare(tab: t2))")
t1[0] = 1 ; t1[1] = 2 ; t1[2] = 1
t2[0] = 1 ; t2[1] = 2 ; t2[2] = 3
print("t1.compare(tab: t2)=\(t1.compare(tab: t2))")
t2[0] = 1 ; t2[1] = 2 ; t2[2] = 3 ; t2[3] = 0
print("t1.compare(tab: t2)=\(t1.compare(tab: t2))")
t1[0] = 1 ; t1[1] = 1 ; t1[2] = 1
t2[0] = 1 ; t2[1] = 2 ; t2[2] = 1 ; t2[3] = 0
print("t1.compare(tab: t2)=\(t1.compare(tab: t2))")
t1[0] = 1 ; t1[1] = 4 ; t1[2] = 1
t2[0] = 1 ; t2[1] = 2 ; t2[2] = 3 ; t2[3] = 0
print("t1.compare(tab: t2)=\(t1.compare(tab: t2))")
*/


/*:
 
 ### Test de `isSub` (question 3)
 
 Vous devez
 - implémentez la fonction `isSub` ;
 - décommentez les lignes de code correspondantes ci-dessous ;
 - remplacez `TabInt` par votre propre type (attention plusieurs lignes sont concernées) ;
 - testez votre solution.
 
 - Note:  partie de code à commenter ou décommenter selon les besoins

 */

/*
var t3 = TabInt(val: 1, count: 6)
t3[1] = 2 ; t3[2] = 3 ; t3[3] = 4 ; t3[4] = 5 ; t3[5] = 6
t1[0] = 3 ; t1[1] = 4 ; t1[2] = 5
print("t1.isSub(tab: t3)=\(t1.isSub(tab: t3))")
t3[2] = 2
print("t1.isSub(tab: t3)=\(t1.isSub(tab: t3))")
var t4 = TabInt(val: 1, count: 3)
t4[1] = 3 ; t4[2] = 4
print("t1.isSub(tab: t4)=\(t1.isSub(tab: t4))")

*/
