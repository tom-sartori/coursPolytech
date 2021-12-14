import Foundation

struct Quarto : QuartoProtocol {
    typealias IteratorPiece = ItPiece
    typealias IteratorTable = ItTable

    // Correspond au plateau de jeu.
    //
    // table : QuartoProtocol -> [[PieceProtocol?]]
    fileprivate var table : [[PieceProtocol?]]

    // Tableau contenant toutes les pièces.
    //
    // listPiece : QuartoProtocol -> [PieceProtocol]
    fileprivate var listPiece: [PieceProtocol]

    // Si vrai, alors le joueur actuel est le joueur 1, sinon c'est le 2.
    //
    // isPlayerOne : QuartoProtocol -> Bool
    private var playerOne: Bool

    // Correspond à la taille du jeu.
    //
    // gameSize : Quarto -> Int
    fileprivate var gameSize : Int = 4

    // Initialise un quarto avec ses 16 pièces.
    //
    // init : -> QuartoProtocol
    //
    // init => isEmpty(x: :,y: :) == true
    // init => isPlayerOne() == Bool.random()
    init () {
        listPiece = [
            Piece(color: EnumColor.clear, size: EnumSize.small, content: EnumContent.empty, shape: EnumShape.circle),
            Piece(color: EnumColor.clear, size: EnumSize.small, content: EnumContent.empty, shape: EnumShape.square),
            Piece(color: EnumColor.clear, size: EnumSize.small, content: EnumContent.full, shape: EnumShape.circle),
            Piece(color: EnumColor.clear, size: EnumSize.small, content: EnumContent.full, shape: EnumShape.square),

            Piece(color: EnumColor.clear, size: EnumSize.big, content: EnumContent.empty, shape: EnumShape.circle),
            Piece(color: EnumColor.clear, size: EnumSize.big, content: EnumContent.empty, shape: EnumShape.square),
            Piece(color: EnumColor.clear, size: EnumSize.big, content: EnumContent.full, shape: EnumShape.circle),
            Piece(color: EnumColor.clear, size: EnumSize.big, content: EnumContent.full, shape: EnumShape.square),

            Piece(color: EnumColor.dark, size: EnumSize.small, content: EnumContent.empty, shape: EnumShape.circle),
            Piece(color: EnumColor.dark, size: EnumSize.small, content: EnumContent.empty, shape: EnumShape.square),
            Piece(color: EnumColor.dark, size: EnumSize.small, content: EnumContent.full, shape: EnumShape.circle),
            Piece(color: EnumColor.dark, size: EnumSize.small, content: EnumContent.full, shape: EnumShape.square),

            Piece(color: EnumColor.dark, size: EnumSize.big, content: EnumContent.empty, shape: EnumShape.circle),
            Piece(color: EnumColor.dark, size: EnumSize.big, content: EnumContent.empty, shape: EnumShape.square),
            Piece(color: EnumColor.dark, size: EnumSize.big, content: EnumContent.full, shape: EnumShape.circle),
            Piece(color: EnumColor.dark, size: EnumSize.big, content: EnumContent.full, shape: EnumShape.square)
        ]

        table = [[PieceProtocol?]](repeating: [PieceProtocol?](repeating : nil, count : 4), count : 4)

        playerOne = Bool.random()
    }

    // Si vrai, alors le joueur actuel est le joueur 1, sinon c'est le 2.
    //
    // isPlayerOne : QuartoProtocol -> Bool
    func isPlayerOne() -> Bool {
        return playerOne
    }

    // Si possible, ajoute une pièce aux coordonnées (x,y). Retourne vrai si la pièce a été ajoutée.
    //
    // addPiece : QuartoProtocol x Int x Int x Int -> QuartoProtocol x Bool
    //
    // addPiece(x,y,index) => isEmpty(x: x, y: y)
    // addPiece(x,y,index) => La pièce correspondant à l'indice, ne doit pas être déjà utilisée.
    // addPiece(x,y,index) => Utilise la pièce ( piece.use() ).
    // addPiece(x,y,index) => La grille (table[x][y]), prend la pièce correspondant à l'indice.
    // paramètres:  x: numéro de ligne , y : numéro de colonne, indexPiece : L'indice de la pièce a ajouter dans listPiece.
    mutating func addPiece(x: Int, y: Int, indexPiece: Int) -> Bool {
        guard isEmpty(x: x, y: y) else { return false }
        guard 0 <= indexPiece && indexPiece < listPiece.count else { return false }
        guard !listPiece[indexPiece].isUsed() else { return false }

        listPiece[indexPiece].use()
        table[x][y] = listPiece[indexPiece]
        return true
    }

    // Retourne vrai si la case de coordonnées (x,y) est inoccupée.
    //
    // isPossible: QuartoProtocol x Int x Int -> Bool
    //
    // Paramètres: x: numéro de ligne , y : numéro de colonne
    private func isEmpty(x: Int, y: Int) -> Bool {
        guard 0 <= x && x < 4 && 0 <= y && y < 4 else { return false }
        return table[x][y] == nil
    }

    // Change la valeur du prochain joueur.
    //
    // switchPlayer: QuartoProtocol -> QuartoProtocol
    mutating func switchPlayer() {
        playerOne = !playerOne
    }

    // Retourne vrai si la pièce ajoutée en (x, y), permet la victoire.
    //
    // isWine: QuartoProtocol x Int x Int -> Bool
    //
    // Paramètres: x: numéro de ligne , y : numéro de colonne
    func isWin(x: Int, y: Int) -> Bool {
        guard 0 <= x && x < 4 && 0 <= y && y < 4 else { return false }
        return isLineWin(x: x) || isColumnWin(y: y) || isDiagonalWin(x: x, y: y)
    }

    // Retourne vrai si la ligne x respecte un des critères de victoire.
    //
    // isLineWin : QuartoProtocol x Int -> Bool
    private func isLineWin(x: Int) -> Bool {
        guard 0 <= x && x < gameSize else { return false }

        var sameColor : Bool = true
        var sameSize : Bool = true
        var sameContent : Bool = true
        var sameShape : Bool = true

        var i : Int = 1
        while i < gameSize && (sameColor || sameSize || sameContent || sameShape) {
            sameColor = sameColor && table[x][0]?.color == table[x][i]?.color
            sameSize = sameSize && table[x][0]?.size == table[x][i]?.size
            sameContent = sameContent && table[x][0]?.content == table[x][i]?.content
            sameShape = sameShape && table[x][0]?.shape == table[x][i]?.shape
            i += 1
        }
        return sameColor || sameSize || sameContent || sameShape
    }

    // Retourne vrai si la colonne y respecte un des critères de victoire.
    //
    // isColumnWin : QuartoProtocol x Int -> Bool
    private func isColumnWin(y: Int) -> Bool {
        guard 0 <= y && y < gameSize else { return false }

        var sameColor : Bool = true
        var sameSize : Bool = true
        var sameContent : Bool = true
        var sameShape : Bool = true

        var i : Int = 1
        while i < gameSize && (sameColor || sameSize || sameContent || sameShape) {
            sameColor = sameColor && table[0][y]?.color == table[i][y]?.color
            sameSize = sameSize && table[0][y]?.size == table[i][y]?.size
            sameContent = sameContent && table[0][y]?.content == table[i][y]?.content
            sameShape = sameShape && table[0][y]?.shape == table[i][y]?.shape
            i += 1
        }
        return sameColor || sameSize || sameContent || sameShape
    }

    // Retourne vrai si (x, y) est sur une diagonale, et que cette dernière respecte un des critères de victoire.
    //
    // isDiagonalWin : QuartoProtocol x Int -> Bool
    private func isDiagonalWin (x: Int, y: Int) -> Bool {
        guard 0 <= x && x < gameSize && 0 <= y && y < gameSize else { return false }

        var sameColor : Bool = true
        var sameSize : Bool = true
        var sameContent : Bool = true
        var sameShape : Bool = true

        var i : Int = 1
        if x == y {
            while i < gameSize && (sameColor || sameSize || sameContent || sameShape) {
                sameColor = sameColor && table[0][0]?.color == table[i][i]?.color
                sameSize = sameSize && table[0][0]?.size == table[i][i]?.size
                sameContent = sameContent && table[0][0]?.content == table[i][i]?.content
                sameShape = sameShape && table[0][0]?.shape == table[i][i]?.shape
                i += 1
            }
        }
        else { // if on the oder diag.
            while i < gameSize && (sameColor || sameSize || sameContent || sameShape) {
                sameColor = sameColor && table[0][0]?.color == table[i][gameSize - i - 1]?.color
                sameSize = sameSize && table[0][0]?.size == table[i][gameSize - i - 1]?.size
                sameContent = sameContent && table[0][0]?.content == table[i][gameSize - i - 1]?.content
                sameShape = sameShape && table[0][0]?.shape == table[i][gameSize - i - 1]?.shape
                i += 1
            }
        }
        return sameColor || sameSize || sameContent || sameShape
    }

    // Retour vrai si les seize pièces ont été posées et qu'il n'y a pas de gagnant.
    //
    // isDraw : QuartoProtocol -> Bool
    // isDraw() => !isEmpty(x: :, y: :) || pieces.isUsed()
    func isDraw() -> Bool {
        return listPiece.count == listPiece.filter({ $0.isUsed() }).count
    }

    // Réinitialise le jeu.
    //
    // restart : QuartoProtocol -> QuartoProtocol
    //
    // restart: pieces.unUse()
    // restart: isEmpty(x: :, y: :)
    // restart: isPlayerOne() -> Bool.random()
    mutating func restart () {
        for i in 0 ..< listPiece.count {
            listPiece[i].unUse()
        }
        playerOne = Bool.random()
        table = [[PieceProtocol?]](repeating: [PieceProtocol?](repeating : nil, count : 4), count : 4)
    }

    var description: String {
        var s = "Liste des pièces : \n"
        var itPiece = makeItPiece()
        var i : Int = 0
        while let piece = itPiece.next() {  // Affichage des pièces.
            if !piece.isUsed() {
                s += "\(i) : \(piece) \n"
            }
            i += 1
        }

        i = 0
        let itTable = makeIterator()
        for elt in itTable {    // Affichage de la grille
            s += " \(elt?.description ?? "x") "
            i += 1
            if i % 4 == 0 {
                s += "\n"
            }
        }
        return s
    }

    public func makeItPiece() -> ItPiece {
        return ItPiece(self)
    }

    public func makeItTable() -> ItTable {
        return ItTable(self)
    }

    func makeIterator() -> ItTable {
        return ItTable(self)
    }
}

struct ItPiece : IteratorProtocol {
    private var listPiece: [PieceProtocol]
    private var currentIndex: Int

    fileprivate init (_ quarto: Quarto) {
        listPiece = quarto.listPiece
        currentIndex = 0
    }

    public mutating func next() -> PieceProtocol? {
        guard currentIndex < listPiece.count else { return nil }
        currentIndex += 1
        return listPiece[currentIndex - 1]
    }
}

struct ItTable : Sequence, IteratorProtocol {
    private var table: [[PieceProtocol?]]
    private var currentX: Int
    private var currentY: Int

    fileprivate init (_ quarto: Quarto) {
        table = quarto.table
        currentX = 0
        currentY = 0
    }

    public mutating func next() -> PieceProtocol?? {
        guard currentX < quarto.gameSize else { return nil }
        let value = table[currentX][currentY]

        if (currentY == quarto.gameSize - 1) {
            currentX += 1
            currentY = 0
        }
        else {
            currentY += 1
        }

        return value
    }
}
