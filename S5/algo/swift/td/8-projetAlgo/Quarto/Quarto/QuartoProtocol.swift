import Foundation

// CustomStringConvertible est uniquement utilisé pour l'affichage.
protocol QuartoProtocol : CustomStringConvertible, Sequence {

    associatedtype IteratorPiece : IteratorProtocol
    associatedtype IteratorTable : IteratorProtocol


    // Si vrai, alors le joueur actuel est le joueur 1, sinon c'est le 2.
    //
    // isPlayerOne : QuartoProtocol -> Bool
    func isPlayerOne () -> Bool

    // Uniquement utilisé pour l'affichage.
    var description: String { get }

    // Initialise un quarto avec ses 16 pièces.
    //
    // init : -> QuartoProtocol
    //
    // init => isEmpty(x: :,y: :) == true
    // init => isPlayerOne() == Bool.random()
    init ()

    // Si possible, ajoute une pièce aux coordonnées (x,y). Retourne vrai si la pièce a été ajoutée.
    //
    // addPiece : QuartoProtocol x Int x Int x Int -> QuartoProtocol x Bool
    //
    // addPiece(x,y,index) => isEmpty(x: x, y: y)
    // addPiece(x,y,index) => La pièce correspondant à l'indice, ne doit pas être déjà utilisée.
    // addPiece(x,y,index) => Utilise la pièce ( piece.use() ).
    // addPiece(x,y,index) => La grille (table[x][y]), prend la pièce correspondant à l'indice.
    // paramètres:  x: numéro de ligne , y : numéro de colonne, indexPiece : L'indice de la pièce a ajouter dans listPiece.
    mutating func addPiece(x: Int, y: Int, indexPiece: Int) -> Bool

    // Change la valeur du prochain joueur.
    //
    // switchPlayer: QuartoProtocol -> QuartoProtocol
    mutating func switchPlayer ()

    // Retourne vrai si la pièce ajoutée en (x, y), permet la victoire.
    //
    // isWine: QuartoProtocol x Int x Int -> Bool
    //
    // Paramètres: x: numéro de ligne , y : numéro de colonne
    func isWin(x: Int, y: Int) -> Bool

    // Retour vrai si les seize pièces ont été posées et qu'il n'y a pas de gagnant.
    //
    // isDraw : QuartoProtocol -> Bool
    // isDraw() => !isEmpty(x: :, y: :) || pieces.isUsed()
    func isDraw () -> Bool

    // Réinitialise le jeu.
    //
    // restart : QuartoProtocol -> QuartoProtocol
    //
    // restart: pieces.unUse()
    // restart: isEmpty(x: :, y: :)
    // restart: isPlayerOne() -> Bool.random()
    mutating func restart ()

    // Crée un iterator sur la liste des pièces possible.
    //
    // makeItPiece : QuartoProtocol -> ItPiece
    func makeItPiece() -> ItPiece

    // Crée un iterator sur la table.
    //
    // makeItTable : QuartoProtocol -> ItTable
    func makeItTable() -> ItTable

    // Créé un iterator sur la table.
    //
    // makeIterator : QuartoProtocol -> ItTable
    func makeIterator() -> ItTable
}
