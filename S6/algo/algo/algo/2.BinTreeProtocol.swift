//
//public protocol BinTreeProtocol {
//    associatedtype T
//    // Check if tree is empty
//    /// - returns: `true` if the root references no node, `false` otherwise
//    func isEmpty() -> Bool
//    // Get the info stored at the node
//    /// - returns: the element stored in the node
//    /// - throws: `fatalerror` if the tree is empty
//    func valRoot() throws -> T
//    // Get the left subtree
//    /// - returns: a PBTree corresponding to the left subtree of the current tree
//    /// - throws: `fatalerror` if the tree is empty
//    func sag() throws -> Self
//    // Get the right subtree
//    /// - returns: a PBTree corresponding to the right subtree of the current tree
//    /// - throws: `fatalerror` if the tree is empty
//    func sad() throws -> Self
//}
//// ----------------------------------
//enum BinaryTreeError : Error {
//    case noSagInEmptyTree
//    case noSadInEmptyTree
//    case noValInEmptyTree
//}
//// ----------------------------------
//enum BinaryTree<T : Comparable> : CustomStringConvertible, BinTreeProtocol {
//    case empty
//    indirect case node(BinaryTree, T, BinaryTree)
//    func isEmpty() -> Bool {
//        if case BinaryTree.empty = self {return true} else {return false}
//    }
//    public var description: String { return descDecalRec(dec : "") }
//    // Fonction auxiliaire pour faire des décalages et montrer les niveaux de l'arbre
//    func descDecalRec(dec : String) -> String {
//        switch self {
//        case let .node(left, value, right):
//            return right.descDecalRec(dec:dec+"\t") + dec+"(\(value))\n" + left.descDecalRec(dec:dec+"\t")
//        case .empty: return ""
//        }
//    }
//    func isLeaf() -> Bool {
//        switch self {
//        case .empty: return false
//        case let .node(left, _, right):
//            if left.isEmpty() && right.isEmpty() {return true}
//        }
//        return false
//    }
//    // A traversal for counting nodes in the tree:
//    /// - returns: the number of nodes in the tree, 0 if tree is empty
//    var count: Int {
//        switch self {
//        case let .node(left, _, right):
//            return left.count + 1 + right.count
//        case .empty:
//            return 0
//        }
//    }
//    // ACCESSEURS :
//    // Return left subtree
//    /// - throws: Error in case tree is empty
//    func sag() throws -> BinaryTree<T>  {
//        switch self {
//        case .empty: throw BinaryTreeError.noSadInEmptyTree
//        case let .node(left,_,_): return left
//        }
//    }
//    // Return right subtree
//    /// - throws: Error in case tree is empty
//    func sad() throws -> BinaryTree<T>  {
//        switch self {
//        case .empty: throw BinaryTreeError.noSagInEmptyTree
//        case let .node(_,_,right): return right
//        }
//    }
//    // Return value stored at root
//    /// - throws: Error in case tree is empty
//    func valRoot() throws -> T {
//        switch self {
//        case .empty: throw BinaryTreeError.noValInEmptyTree
//        case let .node(_,val,_): return val
//        }
//    }
//}
//
//// -----------------------------------------------------
//// ---      PARTIE 2  -   modifications d'un arbre   ---
//// -----------------------------------------------------
///* Ok, faisons un récap :
// - on a défini un type qui est un mix de type valeur et de type référence (un 'enum' avec des parties 'indirect')
// - ce type vérifie les spécifications fonctionnelles demandées (dans le protocol)
//
// Maintenant on veut modifier l'arbre (la plupart des applications ont besoin d'une structure de données qui évolue dynamiquement !
// */
//
//print("\nDéfinissons un arbre sur des entiers :")
//// 1) définissons des feuilles :
//let f1 = BinaryTree.node(.empty, 4, .empty)
//let f2 = BinaryTree.node(.empty, 6, .empty)
//let f3 = BinaryTree.node(.empty, 5, .empty)
//// 2) puis des noeuds internes pour la gauche de l'arbre
//var leftSubtree = BinaryTree.node(f1, 3, f2)
//var treeTest = BinaryTree.node(leftSubtree, 10, f3)
//// 3) Essayons de changer le sous-arbre gauche :
//print("Essayons de modifier cet arbre:\n \(treeTest)")
//leftSubtree = BinaryTree.node(.empty, 1, .empty)
//print("Sous-arbre modifié : \n\(leftSubtree)")
//print("Arbre modifié ? : \n\(treeTest)")
//// -----------------------------------------------------
///*
// Mince ! L'arbre n'a pas été modifié quand on a modifié son sous-arbre...
// Question : pouvez-vous dire pourquoi ? */
//// Copie par valeur.
//// -----------------------------------------------------
//// Pour éviter ce soucis, essayons de modifier la variable contenant l'arbre elle-même :
////    var treeTest.sag() = leftSubtree
////    ... on obtient une erreur <- Cannot assign to BinaryTree<T>... Pourquoi ?
//// Réponse : sag() fonction
//// Ne fonctionne pas non plus :
////  var treeTest.sag = leftSubtree
//// Pourquoi ?
//// Réponse : sag pas défini
//// -----------------------------------------------------
//
//// Définition des setters
//// Commençons par le setter de valeur stockée dans un noeud
//extension BinaryTree {
//    // Replace value contained at root of (sub)tree:
//    mutating func setRoot(newValue: T) throws {
//        guard case .node(let left, _, let right) = self else {
//            throw BinaryTreeError.noValInEmptyTree}
//        // on remplace le noeud par le même mais avec la valeur changée
//        self = .node(left, newValue, right)
//    }
//}
//// 3) Essayons à nouveau de changer le sous-arbre gauche :
//print("\nNouvelle tentative : changement de la valeur à la racine :")
//try leftSubtree = treeTest.sag() //  on prend le sag du noeud racine de l'arbre
//try leftSubtree.setRoot(newValue: 1) // on demande à modifier l'info qu'il porte
//print("Sous-arbre modifié : \n\(leftSubtree)")
//print("Arbre modifié ? : \n\(treeTest)")
//
//
//
//
//// Quel est le probleme ?
//
//// Ca n'a pas marché, pourquoi ?
//// -----------------------------------------------------
//
//// Les types valeurs en Swift (dont Enum et Struct) empêchent d'avoir plusieurs références à une de leurs instances (livre Mastering Swift 5, p277) : quand on indique ces instances pour affectation/passage de params, se sont des COPIES qui sont générées. Donc ci-dessus quand on fait leftSubtree = treeTest.sag(), leftSubtree reçoit une copie du sag qui nous intéresse, et setRoot modifie cette copie, résultat = l'arbre initial n'est pas modifié.
//
//// Question : quelle idée simple pour surmonter cette difficulté ?
//// Réponse : ...
//
//
//// -> Appeler setRoot(...) directement sur le résultat de l'appel treeTest.sag()
//
//// -----------------------------------------------------
//// Réponse : on voudrait pouvoir écrire :
////     try treeTest.sag().setRoot(newValue: 1)
//// pour modifier dirctement un noeud présent dans l'arbre (et non une copie de ce noeud)
///* MAIS Swift nous dit : "Error: Cannot use mutating member on immutable value: function call returns immutable value..."
//
// EXPLICATION (shorturl.at/itSV6) :
// "Currently (2014) the Swift language does not allow for a mutable return value of a function on a value type. If you attempt to call a mutating func directly on the result of a function that returns a value type (exemple "something.methodReturningStruct().mutatingMethod()") you will be met with the following:
// Error: cannot use mutating member on immutable value: function call returns immutable value"
// because : when you do something like something.methodReturningStruct().mutatingMethod(), the methodReturningStruct() will actually return A COPY of the original struct (by virtue of value types). But since you didn't assign it to a var, it will implicitly be treated as a CONSTANT (i.e. LET) so you get that compiler error.
//
// You can still do the same thing, but you just have to tell swift to use the struct as a var
// var structB = something.methodReturningStruct()
// structB.mutatingMethod()
//
// Oui, merci, mais on a essayé :
// var leftSubtree = treeTest.sag()
// leftSubtree.setRoot(newValue: 1)
//
// et en toute logique ça ne modifie que la copie, pas le sous-arbre initial,
// ce qui n'est pas ce qu'on veut ici.
// */
//
//
//
//extension BinaryTree {
//    // "Remplace" les valeurs oldV par newV dans les noeuds d'un arbre binaire
//    // (notez le mot clef mutating)
//    mutating func replaceCopy(_ oldV: T, _ newV: T) {
//        self = repCopyAux(oldV, newV) // on remplace l'instance actuelle par une copie modifiée qu'on fabrique mais attention : ça peut générer des fuites mémoire, par exemple si l'arbre est doublement chainé (c-à-d parents <-> enfants, ouf ce n'est pas encore le cas ici)
//    }
//
//    // Fabrique une copie de l'instance où toute occurrence de oldVal est remplacée par newVal quand elle est rencontrée
//    private func repCopyAux(_ oldVal: T,_ newVal: T) -> BinaryTree {
//        switch self {
//        case .empty: return self
//        case .node(let left, var value, let right):
//            if (value == oldVal) {
//                value = newVal
//            }
//            return BinaryTree.node(left.repCopyAux(oldVal, newVal), value, right.repCopyAux(oldVal, newVal))
//        }
//    }
//
//// Replace left subtree of nodes indicated by their value
//    mutating func setSag(_ val: T, _ newST: BinaryTree<T>)  {
//        self = setSagAux(val,newST)
//    }
//
//    private func setSagAux(_ val: T,_ newST: BinaryTree<T>) -> BinaryTree {
//        switch self {
//        case .empty: return self
//        case let .node(left, value, right):
//            if (value == val) {
//                return BinaryTree.node(newST, value, right.setSagAux(val, newST))
//            }
//            else {
//                return BinaryTree.node(left.setSagAux(val, newST), value, right.setSagAux(val, newST))
//            }
//        }
//    }
//}
//
//
//// Alors, est-ce qu'on a réussi ?
//print("\nTentative de modif° en mode COPIE de l'arbre :")
//print("Arbre à modifier : \n\(treeTest)")
////treeTest.replaceCopy(3,1) ;
//treeTest.replaceCopy(1,4)
////treeTest.replaceCopy(4,13)
//print("Arbre actuel : \n\(treeTest)")
//let ff1 = BinaryTree.node(BinaryTree.empty,1,.empty)
//let ff2 = BinaryTree.node(.empty,5,.empty)
//let repl = BinaryTree.node(ff1,10,ff2)
//treeTest.setSag(4, repl)
//print("Arbre avec SAG MODIFIE les noeuds contenant 4: \n\(treeTest)")
//
////try treeTest = BinaryTree.node(leftSubtree, treeTest.valRoot(), treeTest.sad())
////print("Arbre encore modifié ? : \n\(treeTest)")
//
//
//
//// Mettons maintenant en place l'insertion de nouveaux noeuds.
//// Proposez une fonction qui ajoute une nouvelle feuille contenant une valeur donnée : comme en TD cette feuille sera posée au hasard dans l'arbre quand un sous-arbre vide est rencontré, donc si on est sur un ArbBin non vide on a une chance sur deux d'insérer dans son sag, respectivement dans son sad.
//extension BinaryTree {
//    // Une fonction insert qui met à gauche ou à droite au hasard
//    mutating func insert(val : T) throws {
//        self = insertAux(val: val)
//    }
//
//    func insertAux(val : T ) -> BinaryTree {
//        switch self{
//        case .empty: return BinaryTree.node(.empty, val, .empty)
//        case let .node(left, currentValue, right):
//            let random = Int.random(in: 1..<3)
//            if (random == 1){
//                if (!left.isEmpty()){
//                    return BinaryTree.node(left.insertAux(val : val), currentValue, right)
//                }
//                else {
//                    return BinaryTree.node(BinaryTree.node(.empty, val, .empty), currentValue, right)
//                }
//            }
//            else {
//                if (!right.isEmpty()){
//                    return BinaryTree.node(left, currentValue, right.insertAux(val : val))
//                }
//                else {
//                    return BinaryTree.node(left, currentValue, BinaryTree.node(.empty, val, .empty))
//                }
//            }
//        }
//    }
//}
//var treeRandom = BinaryTree<Int>.empty
//for _ in 0..<20 {
//    try treeRandom.insert(val: Int.random(in: 1..<100))
//}
//print("Un arbre rempli aléatoirement :\n \(treeRandom)")
//
//
