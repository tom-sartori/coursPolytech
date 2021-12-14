import UIKit

var greeting = "Hello, playground"


protocol TInt {
    
    /**
     init a Int, n Int → TInt
     init(a,n) crée un tableau de n éléments initialisés avec la valeur a.
     */
    init(a : Int, n : Int)
    

    /**
     count : TInt → Int
     Donne le nombre d’éléments du tableau.
     count(init(a,n))==n
     */
    func count() -> Int
    
    
    /**
     [ ] : TInt × Int → Int
     Retourne l’élément à l ’indice donné en paramètre.
     Change la valeur de l’entier à l’indice donné par l’entier donné en paramètre.
     T=init(a,n)⇒ ∀ 0 ⩽ j < n, T[j]==a ; T[j]=k⇒T[j]==k
     */
    subscript (i : Int) -> Int { get set }


    /**
     contains : TInt × Int → bool
     True si l’entier donnée en paramètre appartient au tableau.
     contains(T,a) ⇒ ∃i, T[i]==a
     */
    func contains (a : Int) -> Bool
    
    
    /**
     firstIndex : TInt × Int → Int|Vide
     Indice de la première valeur (dans l’ordre des indices) donnée en paramètre.
     firstIndex(T,a)==i ⇒T[i]==a et ∀ 0 ⩽ j < i, T[j]̸=a
     firstIndex(T,a)==Vide ⇒ ∀ 0 ⩽ i < n, T[i]̸=a
     */
    func firstIndex (a : Int) -> Int?
    
    
    /**
     lastIndex : TInt × Int → Int|Vide
     Indice de la dernière valeur (dans l’ordre des indices) donnée en paramètre
     lastIndex(T,a)==i ⇒T[i]==a et ∀ i < j < n, T[j]̸=a
     lastIndex(T,a)==Vide ⇒ ∀ 0 ⩽ i < n, T[i]̸=a
     */
    func lastIndex(a : Int) -> Int?
    
    
    /**
     nbOccur : TInt × Int → Int
     Nombre d’occurrences de la valeur passée en paramètre.
     nbOccur(T,a)==p⇒∃i0,...,ip tel que ∀ik,O⩽k⩽p,ik ∈[0,n−1] et T[ik]==a
     */
    func nbOccur (a : Int) -> Int

    
    /**
     min:TInt→Int
     Plus petite valeur de T, min(T)==m⇒∀0⩽i<n, T[i]⩾m
     */
    func min () -> Int
    
    
    /**
     max:TInt→Int
     Plus grande valeur de T, max(T)==m⇒∀0⩽i<n, T[i]⩽m
     */
    func max () -> Int
    
    /**
     compare : TInt, t2: TInt -> Int
     retourne :
      - la valeur -1 si tous les éléments de T1 sont respectivement avant les éléments de T2 dans l’ordre lexicographique.
      - la valeur 0 si T1 et T2 sont égaux Exemple : T1=[4,2,5] et T2=[4,2,5]
      - la valeur 1 sinon.
     */
    func compare (t2 : TInt) -> Int
    
    
    /**
     isSub : TInt×TInt → bool
     isSub(T1,T2) retourne true si T1 est sous-tableau de T2, et false sinon.
     T1 est sous-tableau de T2 si :
      ∃0⩽k<count(T2), tel que ∀0⩽i<count(T1),T1[i]==T2[k+i] et tel que k+count(T1)⩽count(T2)
     */
    func isSub (t2 : TInt) -> Bool
}



struct TabInt : TInt {

    /**
     tab : TInt -> [Int]
     */
    private var tab : [Int]
    
    
    /**
     init a Int, n Int → TInt
     init(a,n) crée un tableau de n éléments initialisés avec la valeur a.
     */
    init(a: Int, n: Int) {
        assert(n > 0, "Not a good size. ")
        self.tab = [Int](repeating: a, count: n)
    }
    

    /**
     count : TInt → Int
     Donne le nombre d’éléments du tableau.
     count(init(a,n))==n
     */
    func count() -> Int {
        return self.tab.count
    }
    
    
    /**
     [ ] : TInt × Int → Int
     Retourne l’élément à l ’indice donné en paramètre.
     Change la valeur de l’entier à l’indice donné par l’entier donné en paramètre.
     T=init(a,n)⇒ ∀ 0 ⩽ j < n, T[j]==a ; T[j]=k⇒T[j]==k
     */
    subscript(i: Int) -> Int {
        // Si i n'est pas un idex possible, alors crée une erreur "Index out of range".
        get {
            assert( (i >= 0) && (i < self.count()), "Index out of range")
            return self.tab[i]
        }
        set {
            assert( (i >= 0) && (i < self.count()), "Index out of range")
            self.tab[i] = newValue
        }
    }
    
    
    /**
     contains : TInt × Int → bool
     True si l’entier donnée en paramètre appartient au tableau.
     contains(T,a) ⇒ ∃i, T[i]==a
     
     T(n) <= n
     */
    func contains(a: Int) -> Bool {
        var i : Int = 0
        while i < self.count() && self[i] != a {
            i += 1
        }
        return i != self.count()
    }
    
    /**
     firstIndex : TInt × Int → Int|Vide
     Indice de la première valeur (dans l’ordre des indices) donnée en paramètre.
     firstIndex(T,a)==i ⇒T[i]==a et ∀ 0 ⩽ j < i, T[j]̸=a
     firstIndex(T,a)==Vide ⇒ ∀ 0 ⩽ i < n, T[i]̸=a
     
     T(n) <= 2 + 3n + 1
     */
    func firstIndex(a: Int) -> Int? {
        assert(self.count() != 0, "Empty tab")    // Si le tableau est vide, alors on crée une erreur.
        
        var i : Int = 0 // Initialisation de i au premier index du tableau.
        while i < self.count() && self[i] != a {  // Tant que i < 0 et que tab[i] n'est pas égal à a, alors on incrémente i.
            // Invariant : ∀ j ∈ [0, i], self[i] != a
            i += 1
        }
        // Arret : i >= self.count() || self[j] == a
        return i == self.count() ? nil : i   // Si i est égal à la taille de self.tab, alors on retourne nil, sinon on retourne i.
    }
    
    /**
     lastIndex : TInt × Int → Int|Vide
     Indice de la dernière valeur (dans l’ordre des indices) donnée en paramètre
     lastIndex(T,a)==i ⇒T[i]==a et ∀ i < j < n, T[j]̸=a
     lastIndex(T,a)==Vide ⇒ ∀ 0 ⩽ i < n, T[i]̸=a
     
     T(n) <= 2 + 3n + 1
     */
    func lastIndex(a: Int) -> Int? {
        assert(self.count() != 0, "Empty tab")    // Si le tableau est vide, alors on crée une erreur.
        
        var i : Int = self.count() - 1    // Initialisation de i au dernier index du tableau.
        while i >= 0 && self[i] != a {  // Tant que i >= 0 et que tab[i] n'est pas égal à a, alors on décrémente i.
            // Invariant : ∀ j ∈ [0, i], self[j] != a
            i -= 1
        }
        // Arret : i >= self.count() || self[j] == a
        return i == -1 ? nil : i   // Si i est égal à -1, alors on retourne nil, sinon on retourne i.
    }
    
    /**
     nbOccur : TInt × Int → Int
     Nombre d’occurrences de la valeur passée en paramètre.
     nbOccur(T,a)==p⇒∃i0,...,ip tel que ∀ik,O⩽k⩽p,ik ∈[0,n−1] et T[ik]==a
     
     T(n) <= 1 + 2n + 1
     */
    func nbOccur(a: Int) -> Int {
        var result : Int = 0    // Résultat initialisé à 0.
        for element in self.tab {
            if element == a {
                result += 1 // Incrémentation du récultat si un élément est égal à a.
            }
        }
        return result
    }
    
    /**
     min:TInt→Int
     Plus petite valeur de T, min(T)==m⇒∀0⩽i<n, T[i]⩾m
     
     Crée une erreur si le tableau est vide.
     
     T(n) <= 2 + 2n + 1
     */
    func min() -> Int {
        assert(self.count() != 0, "Empty tab")    // Si le tableau est vide, alors on crée une erreur.
        
        var result : Int = self[0]  // result initialisé à la première valeur du tableau.
        for element in self.tab {
            if element < result {   // Si un élément est inférieur au résultat courant, alors on modifie le résultat.
                result = element
            }
        }
        return result
    }
    
//    func minAux(i: Int, m: Int) -> Int {
//
//
//        if self[i] < m {
//            minAux(i: i + 1, m: self[i])
//        }
//    }
//
    /**
     max:TInt→Int
     Plus grande valeur de T, max(T)==m⇒∀0⩽i<n, T[i]⩽m
     
     T(n) = 2 + 2n + 1
     */
    func max() -> Int {
        assert(self.count() != 0, "Empty tab")    // Si le tableau est vide, alors on crée une erreur.
        
        var result : Int = self[0]  // result initialisé à la première valeur du tableau.
        for element in self.tab {
            if element > result {   // Si un élément est supérieur au résultat courant, alors on modifie le résultat.
                result = element
            }
        }
        return result
    }
    
    
    /**
     compare : TInt, t2: TInt -> Int
     retourne :
      - la valeur -1 si tous les éléments de T1 sont respectivement avant les éléments de T2 dans l’ordre lexicographique.
      - la valeur 0 si T1 et T2 sont égaux Exemple : T1=[4,2,5] et T2=[4,2,5]
      - la valeur 1 sinon.
     
      T(n) <= 3 + 10n + 4
     */
    func compare (t2 : TInt) -> Int {
        guard (self.count() <= t2.count()) else {return 1}
        
        var i : Int = 0
        var avant : Bool = true
        var equal : Bool = true
        
        // Tant que i < taille de tab et (equal ou avant == true)
        while i < self.count() && (avant || equal) {
            avant = avant && self[i] <= t2[i]
            equal = equal && self[i] == t2[i]
            i += 1
        }
        // Si equal == true, alors on retourne 0, sinon si avant == true, retourne -1, sinon retourne 1.
        return equal ? 0 : avant ? -1 : 1
    }
    
    
    /**
     isSub : TInt×TInt → bool
     isSub(T1,T2) retourne true si T1 est sous-tableau de T2, et false sinon.
     T1 est sous-tableau de T2 si :
      ∃0⩽k<count(T2), tel que ∀0⩽i<count(T1), T1[i]==T2[k+i] et tel que k+count(T1)⩽count(T2)
     */
    func isSub (t2 : TInt) -> Bool {
        var i : Int = 0
        var j : Int = 0
        
        while i < t2.count() && j < self.count() {
            // Invariant : ∀ a ∈ [0, i], ∀ b ∈ [0, j], ∃ k tq self[a : a+k] == t2[b : b + k]
            if t2[i] == self[j] {
                j += 1
            }
            else {
                j = 0
            }
            i += 1
            // Arret : a >= t2.count() && b >= self.count()
        }
        return j >= self.count()
    }
}



//
//var tab : TInt = TIntImplemented(a: 0, n: 10)
//tab[0] = 1
//tab[1] = 4
//tab[2] = 4
//tab[3] = 3
//tab[4] = 4
//tab[9] = 4
//
//
//var tab2 : TInt = TIntImplemented(a: 0, n: 10)
//tab2[0] = 1
//tab2[1] = 4
//tab2[2] = 4
//tab2[3] = 3
//tab2[4] = 4
//tab2[9] = 5
//
//print (tab.isSub(t2: tab2))
////print (tab2)
////print (tab.compare(t2: tab2))






//

/*:
 
 ### question 1 et 2
 
 Vous devez
 - implémentez votre propre type concret (en l'appelant différemment de `TabInt`), question 1 et 2 du TD 05 ;
  - Remplacez dans le code `TabInt` par votre propre type et testez votre solution.
 
 - Note: vérifiez que les parties de code correspondantes à la question 3 (voir plus bas) sont bien commentées.
 \
vous pouvez dans un premier temps les décommenter pour tester avec `TabInt`

 */

var t = TabInt(a: 0, n: 10)
for i in 0..<t.count(){
   t[i] = i
}
print("t=\(t)")
print("t.count = \(t.count())")
print("t.min = \(t.min())")
print("t.max = \(t.max())")
print("t.contains(val: 10)=\(t.contains(a: 10))")
print("t.contains(val: 8)=\(t.contains(a: 8))")
t[2] = 10 ; t[5] = 10 ; t[8] = 10
print("t.firstIndex(val: 10)=\(String(describing: t.firstIndex(a: 10)))")
print("t.lastIndex(val: 10)=\(String(describing: t.lastIndex(a: 10)))")
print("t.firstIndex(val: 11)=\(String(describing: t.firstIndex(a: 11)))")
print("t.lastIndex(val: 11)=\(String(describing: t.lastIndex(a: 11)))")
print("t.nbOccur(val: 2)=\(t.nbOccur(a: 2))")
print("t.nbOccur(val: 10)=\(t.nbOccur(a: 10))")
print("t.nbOccur(val: 1)=\(t.nbOccur(a: 1))")
/*:

 ### Test de compare (question 3)

 Vous devez
 - implémentez la fonction `compare` ;
 - décommentez les lignes de code correspondantes dans le playground que vous avez du commenter à la question précédente ;
 - remplacez `TabInt` par votre propre type (attention plusieurs lignes sont concernées) ;
 - testez votre solution.

 - Note:  partie de code à commenter ou décommenter selon les besoins
*/

var t1 = TabInt(a: 1, n: 3)
var t2 = TabInt(a: 1, n: 4)
t1[0] = 4 ; t1[1] = 2 ; t1[2] = 5
t2[0] = 4 ; t2[1] = 2 ; t2[2] = 5
print("t1.compare(tab: t2)=\(t1.compare(t2: t2))")
t1[0] = 1 ; t1[1] = 2 ; t1[2] = 1
t2[0] = 1 ; t2[1] = 2 ; t2[2] = 3
print("t1.compare(tab: t2)=\(t1.compare(t2: t2))")
t2[0] = 1 ; t2[1] = 2 ; t2[2] = 3 ; t2[3] = 0
print("t1.compare(tab: t2)=\(t1.compare(t2: t2))")
t1[0] = 1 ; t1[1] = 1 ; t1[2] = 1
t2[0] = 1 ; t2[1] = 2 ; t2[2] = 1 ; t2[3] = 0
print("t1.compare(tab: t2)=\(t1.compare(t2: t2))")
t1[0] = 1 ; t1[1] = 4 ; t1[2] = 1
t2[0] = 1 ; t2[1] = 2 ; t2[2] = 3 ; t2[3] = 0
print("t1.compare(tab: t2)=\(t1.compare(t2: t2))")



/*:
 
 ### Test de `isSub` (question 3)
 
 Vous devez
 - implémentez la fonction `isSub` ;
 - décommentez les lignes de code correspondantes ci-dessous ;
 - remplacez `TabInt` par votre propre type (attention plusieurs lignes sont concernées) ;
 - testez votre solution.
 
 - Note:  partie de code à commenter ou décommenter selon les besoins

 */


var t3 = TabInt(a: 1, n: 6)
t3[1] = 2 ; t3[2] = 3 ; t3[3] = 4 ; t3[4] = 5 ; t3[5] = 6
t1[0] = 3 ; t1[1] = 4 ; t1[2] = 5

print ("t1 : ", t1)
print ("t3 : ", t3)
print("t1.isSub(tab: t3)=\(t1.isSub(t2: t3))")
print ("\n")

t3[2] = 2
print ("t1 : ", t1)
print ("t3 : ", t3)
print("t1.isSub(tab: t3)=\(t1.isSub(t2: t3))")
print ("\n")

var t4 = TabInt(a: 1, n: 3)
t4[1] = 3 ; t4[2] = 4
print ("t1 : ", t1)
print ("t4 : ", t4)
print("t1.isSub(tab: t4)=\(t1.isSub(t2: t4))")



var t5 = TabInt(a: 0, n: 3)
t5[0] = 3
t5[1] = 4
t5[2] = 5


var t6 = TabInt(a: 0, n: 2)
t6[0] = 3
t6[1] = 4
t6[2] = 5
t6[3] = 4

print ("t5 : ", t5)
print ("t6 : ", t6)
print("t5.isSub(tab: t6)=\(t5.isSub(t2: t6))")
