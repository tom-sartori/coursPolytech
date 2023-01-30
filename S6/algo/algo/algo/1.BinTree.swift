///*
// **Rappel** :
// Types 'valeur' et types 'références' : relisez le haut de la [doc d'apple](https://developer.apple.com/swift/blog/?id=10).
// Des exemples de types valeurs sont les types de base : String, Int mais aussi les types définis par les développeurs par struct et enum.
// Question de lecture :
// - quel est l'intérêt principal des types valeur par rapport aux types références ?
// - quel est leur inconvénient principal ? */
//
//// Réponses : ...
//
//// ------------------------------------------------------
//// Binary tree Protocol
//// ------------------------------------------------------
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
//// -------------------------
//// ^^^^ notez ci-dessus : comment on fait un commentaire de documentation,
///* Voir l'outil [Jazzy](https://github.com/realm/jazzy) pour plus d'infos et [ce tuto](https://medium.com/@virenmalhan.vm/documenting-ios-app-using-jazzy-fe588579b0ee) par exemple pour générer une doc html depuis ces "commentaires de doc°".
// *Pour les étudiants les plus avancés* : générez la doc de ce playground et montrez le résultat dans mattermost
// */
//
//// ------------------------
///* Un auteur de livre sur Swift (et blogger) propose de définir les BT en utilisant autant que possible les struct et enum plutôt que des classes (recommandé en Swift car le langage gère efficacement ces 'types valeurs') : */
//enum BinaryTree<T : Comparable> {
//    /* <T> = "générique" : pour typer les valeurs stockées dans les noeuds
//     Déclarer implémenter le protocole *Comparable* permettra de comparer des arbres (noeuds) */
//    // Un arbre est soit vide :
//    case empty    // perso, je trouve ça plus élégant que "nil" comme on utilise d'habitude
//    // soit un noeud (sag, valeur, sad) :
//    indirect case node(BinaryTree, T, BinaryTree) // (*node* est un mot qu'on définit ici).
//    /* Plus d'info donnée par [la doc swift](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html) :
//     "*It’s sometimes useful to be able to store values of other types alongside a case value. This additional information is called an *associated value*, and it varies each time you use that case as a value in your code.*" */
//}
///*  **Problème** : sans le mot clef `indirect` (ci-dessus), Swift lève un warning car il ne peut calculer la taille de l'enum à construire...
//
// "*Here’s where the 'indirect' keyword comes in. indirect applies a layer of indirection between two value types. This introduces a thin layer of REFERENCE semantics to the value type. The enum now holds **REFERENCES** to it’s associated values, rather than their value. References have a constant size,  so you no longer have the previous problem.*"
//
// Ah aahhh ! Oui mon garçon, mais bon, du coup c'est un peu comme si on avait fait une classe (!), adieu le pur type valeur :-( : on introduit des références là où on voulait des types valeurs... donc déjà on n'est pas 100% satisfait...
//
// *Note : c'est mieux de déclarer que le cas `node` comme étant `indirect` que d'ajouter ce mot clef sur l'ensemble de la struct (comme le playground nous propose de "fixer" ça), sinon autant faire une classe !*
//
// Mais bon, continuons pour l'instant, on ne sait jamais, l'enum est quand même assez élégant pour l'instant, et a l'avantage que dans cette implémentation on déclare un seul type.
// */
//print("protocole et enum définis")
//
///*
// Savoir si un arbre est vide se fait de façon très simple :
// (note : une *extension* est une façon de compléter le type,
// comme si on avait d'emblée placé ces déclarations dedans) */
//extension BinaryTree {
//    func isEmpty() -> Bool {
//        // Tester si un arbre est vide se fait naturellement:
//        if case BinaryTree.empty = self {return true} else {return false}
//        // ...qui est un raccourci pour :
//        //switch etreee {
//        //case .empty: return true
//        //default: return false
//        //}
//    }
//}
//// Construisons un arbre :
//// 1) Commençons par un arbre vide :
//let etree = BinaryTree<Int>.empty
//if etree.isEmpty() {print("eTree est un arbre vide")} else {print("eTree est un arbre non vide")}
//// Construisons un arbre avec des noeuds contenant des infos de type String:
//// 2) définissons des feuilles
////    Remarquez comme ça se définit facilement sans appel explicite à un constructeur/initialiseur :
//let node5 = BinaryTree.node(.empty, "5", .empty)
//let nodeA = BinaryTree.node(.empty, "a", .empty)
//let node10 = BinaryTree.node(.empty, "10", .empty)
//let node4 = BinaryTree.node(.empty, "4", .empty)
//let node3 = BinaryTree.node(.empty, "3", .empty)
//let nodeB = BinaryTree.node(.empty, "b", .empty)
//// 3) des noeuds internes pour la gauche de l'arbre
//let Aminus10 = BinaryTree.node(nodeA, "-", node10)
//var timesLeft = BinaryTree.node(node5, "*", Aminus10)
//// 4) noeuds internes pour le sous-arbre de droite de la racine
//let minus4 = BinaryTree.node(.empty, "-", node4)
//let divide3andB = BinaryTree.node(node3, "/", nodeB)
//let timesRight = BinaryTree.node(minus4, "*", divide3andB)
//// 5) créons un noeud racine qui relie les deux sous-arbres construits
//var tree = BinaryTree.node(timesLeft, "+", timesRight)
//// Vérifions que l'arbre créé n'est pas vide :
//if tree.isEmpty() {print("Arbre vide")} else {print("Arbre non vide")}
///*
// Questions :
// - quelle formule mathématique est encodée dans cet arbre ?
// - essayez de mettre un entier 5 à la place du String "5" pour voir si vous pouvez construire votre arbre.
// Quel soucis rencontrez-vous et pourquoi ?
// */
//
//// Vos réponses : ...
//
//
///*
// Ok, ajoutons quelques propriétés pour nous approprier le type,
// on va déjà commencé par la propriété description qui permettra d'afficher un arbre.
// Pour ça, il faut que votre type implémente le protocole CustomStringConvertible
// qui facilite les affichages de l'objet : */
//extension BinaryTree: CustomStringConvertible {
//    /// - returns: a String description of a BT
//    public var description: String { return descDecalRec(dec : "") }
//
//
//    // Fonction auxiliaire pour faire des décalages et montrer les niveaux de l'arbre
//    func descDecalRec(dec : String) -> String {
//        switch self {
//        case let .node (left, value, right):
//            return
//                    right.descDecalRec(dec: dec + "\t")
//                            + dec + "(\(value))\n"
//                            + left.descDecalRec(dec: dec + "\t")
//        case .empty: return ""
//        }
//    }
//}
//// Grâce à la propriété description et le protocol respecté par BinaryTree :
//print(tree) // renvoie l'arbre sous une forme String
//
///*
// Question de code :
// - ajoutez une fonction permettant de savoir si un noeud est une feuille ou pas
// - ajoutez une propriété calculée (nommée count) qui compte le nombre de noeuds d'un arbre
// */
//extension BinaryTree {
//    /// - returns: true if and only if the node has empty sag and sad
//    func isLeaf() -> Bool {
//        switch self {
//        case .empty: return false
//        case let .node (left, _, right):
//            return left.isEmpty() && right .isEmpty()
//        }
//    }
//    // A traversal for counting nodes in the tree:
//    /// - returns: the number of nodes in the tree, 0 if tree is empty
//    var count: Int {
//        switch self {
//        case .empty: return 0
//        case let .node(left, _, right):
//            return left.count + 1 + right.count
//        }
//    }
//}
//
//print("Number of node = \(tree.count)")
//print(tree.isLeaf())
//
//// On déclare un type pour nos erreurs liées aux BT car certaines fonctionnalités peuvent renvoyer une erreur (cf spécifications)
//enum BinaryTreeError : Error {
//    case noSagInEmptyTree
//    case noSadInEmptyTree
//    case noValInEmptyTree
//}
///*
// AJOUTONS des ACCESSEURS pour obtenir les sous-arbres et les valeurs stockées dans un BT.
// En terme d'implémentation, on en profite pour se rapprocher du cas qui nous intéresse, en demandant à ce que le type vérifie les spécifications (déclarées dans le BinTreeProtocol - voir fichier BTProtocol.swift
// */
//extension BinaryTree : BinTreeProtocol {
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
//// TO DO : modifiez le fichier BTProtocol pour que sa documentation reflète les erreurs réellement renvoyées (à la place de fatalError)
//// Utilisation de ces accesseurs :
//print("Accessing a subtree:")
//try print(tree.sag().sad())
//try print(tree.sag().sad().sad().isLeaf())
//
//// Décommentez les deux lignes ci-dessous pour voir une exception au travail :
////print("Taking more risk:")
////try print(tree.sag().sad().sag().sad().sad()) // generates an error
//