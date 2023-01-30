import Foundation

public protocol BinTreeProtocol {
    associatedtype T
    // Check if tree is empty
    /// - returns: `true` if the root references no node, `false` otherwise
    func isEmpty() -> Bool
    // Get the info stored at the node
    /// - returns: the element stored in the node
    /// - throws: `fatalerror` if the tree is empty
    func valRoot() throws -> T
    // Get the left subtree
    /// - returns: a PBTree corresponding to the left subtree of the current tree
    /// - throws: `fatalerror` if the tree is empty
    func sag() throws -> Self
    // Get the right subtree
    /// - returns: a PBTree corresponding to the right subtree of the current tree
    /// - throws: `fatalerror` if the tree is empty
    func sad() throws -> Self
}
// -- --------------------------------
enum BinaryTreeError : Error {
    case noSagInEmptyTree
    case noSadInEmptyTree
    case noValInEmptyTree
}
// ----------------------------------
enum BinaryTree<T : Comparable> : CustomStringConvertible, BinTreeProtocol {
    case empty
    indirect case node(BinaryTree, T, BinaryTree)
    func isEmpty() -> Bool {
        if case BinaryTree.empty = self {return true} else {return false}
    }
    public var description: String { return descDecalRec(dec : "") }
    // Fonction auxiliaire pour faire des décalages et montrer les niveaux de l'arbre
    func descDecalRec(dec : String) -> String {
        switch self {
        case let .node(left, value, right):
            return right.descDecalRec(dec:dec+"\t") + dec+"(\(value))\n" + left.descDecalRec(dec:dec+"\t")
        case .empty: return ""
        }
    }
    func isLeaf() -> Bool {
        switch self {
        case .empty: return false
        case let .node(left, _, right):
            return left.isEmpty() && right.isEmpty()
        }
    }
    // A traversal for counting nodes in the tree:
    /// - returns: the number of nodes in the tree, 0 if tree is empty
    var count: Int {
        switch self {
        case let .node(left, _, right):
            return left.count + 1 + right.count
        case .empty:
            return 0
        }
    }
    // ACCESSEURS :
    // Return left subtree
    /// - throws: Error in case tree is empty
    func sag() throws -> BinaryTree<T>  {
        switch self {
        case .empty: throw BinaryTreeError.noSagInEmptyTree
        case let .node(left,_,_): return left
        }
    }
    // Return right subtree
    /// - throws: Error in case tree is empty
    func sad() throws -> BinaryTree<T>  {
        switch self {
        case .empty: throw BinaryTreeError.noSadInEmptyTree
        case let .node(_,_,right): return right
        }
    }
    // Return value stored at root
    /// - throws: Error in case tree is empty
    func valRoot() throws -> T {
        switch self {
        case .empty: throw BinaryTreeError.noValInEmptyTree
        case let .node(_,val,_): return val
        }
    }
}


print("\nDéfinissons un arbre sur des entiers.")
// 1) définissons des feuilles :
let f1 = BinaryTree.node(.empty, 4, .empty)
let f2 = BinaryTree.node(.empty, 6, .empty)
let f3 = BinaryTree.node(.empty, 5, .empty)
// 2) puis des noeuds internes pour la gauche de l'arbre
var leftSubtree = BinaryTree.node(f1, 3, f2)
var treeTest = BinaryTree.node(leftSubtree, 10, f3)


extension BinaryTree {
    // "Remplace" les valeurs oldV par newV dans les noeuds d'un arbre binaire (notez le mot clef mutating)
    mutating func replaceCopy(_ oldV: T, _ newV: T)  {
        self = repCopyAux(oldV,newV) // on remplace l'instance actuelle par une copie modifiée qu'on fabrique
    }
    private func repCopyAux(_ oldVal: T,_ newVal: T) -> BinaryTree {
        switch self {
        case .empty: return .empty
        case var .node(gche,val,dte):
            if val == oldVal { val = newVal }
            return .node(gche.repCopyAux(oldVal, newVal),
                    val,
                    dte.repCopyAux(oldVal, newVal))
        }
    }
}

print("\nTentative de modif° en mode COPIE de l'arbre :")
print("Arbre à modifier : \n\(treeTest)")
treeTest.replaceCopy(10,4)
treeTest.replaceCopy(4,8)
print("COPIE de l'arbre avec valeur modifiée : \n\(treeTest)")

extension BinaryTree {
    // Replace left subtree of nodes indicated by their value
    mutating func setSag(_ val: T, _ newST: BinaryTree<T>)  {
        self = setSagAux(val,newST)
    }
    private func setSagAux(_ cherchee: T,_ newST: BinaryTree<T>) -> BinaryTree {
        switch self {
        case .empty: return .empty
        case let .node(g,v,d):
            if (v == cherchee) {
                return .node(newST, v, d.setSagAux(cherchee,newST))
            }
            else { return .node(g.setSagAux(cherchee,newST),
                    v, d.setSagAux(cherchee,newST))
            }
        }
    }
    // Replace left subtree of nodes indicated by their value
    mutating func setSad(_ val: T, _ newST: BinaryTree<T>)  {
        self = setSadAux(val,newST)
    }
    private func setSadAux(_ cherchee: T,_ newST: BinaryTree<T>) -> BinaryTree {
        switch self {
        case .empty: return .empty
        case let .node(g,v,d):
            if (v == cherchee) {
                return .node(g.setSadAux(cherchee,newST),v,newST)
            }
            else { return .node(g.setSadAux(cherchee,newST),
                    v, d.setSadAux(cherchee,newST))
            }
        }
    }

}
treeTest.replaceCopy(5,8)
print("Arbre actuel : \n\(treeTest)")
let repl = BinaryTree.node(.node(.empty,10,.empty),1,.node(.empty,12,.empty))
treeTest.setSag(8, repl)
print("Arbre avec SAG MODIFIé : \n\(treeTest)")



// --------------------------------------------------------------------
// Mettons maintenant en place l'insertion de nouveaux noeuds.
// Proposez une fonction qui ajoute une nouvelle feuille contenant une valeur donnée : comme en TD cette feuille sera posée au hasard dans l'arbre quand un sous-arbre vide est rencontré, donc si on est sur un ArbBin non vide on a une chance sur deux d'insérer dans son sag, respectivement dans son sad.
extension BinaryTree {
    // Une fonction insert qui met à gauche ou à droite au hasard
    mutating func insert(val : T) throws {
        switch self {
        case .empty: self = .node(.empty,val,.empty)
        case let .node(_, current, _):
            var gauche = try self.sag()
            var droite = try self.sad()
            if Int.random(in: 1..<3) == 1 { try gauche.insert(val: val) }
            else { try droite.insert(val: val) }
            self = .node(gauche, current, droite)
        }
    }
}
var treeRandom = BinaryTree<Int>.empty
let nbInserts = 20
for _ in 0..<nbInserts {
    try treeRandom.insert(val: Int.random(in: 1..<100))
}
print("Un arbre rempli aléatoirement :\n \(treeRandom)")
let nbg = try treeRandom.sag().count
let nbd = try treeRandom.sad().count
print("Nb noeuds à gauche (\(nbg)) <-> nb noeuds à droite (\(nbd))")




