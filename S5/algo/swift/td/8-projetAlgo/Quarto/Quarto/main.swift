import Foundation

var quarto = Quarto()
play()


// Fonction principale qui permet de jouer jusqu'à victoire ou nul.
//
// play :
//
// Fonctions appellées : iswin(...), isDraw(...), askNextIndexPiece(), switchPlayer(), askToPlay(...), askToReplay()
func play () {
    print ("Début de la partie. ")
    print(quarto)
    var x : Int = -1
    var y : Int = -1

    while !quarto.isWin(x: x, y: y) && !quarto.isDraw() {
        let nextIndexPiece = askNextIndexPiece()
        quarto.switchPlayer()
        let coords = askToPlay(indexPiece: nextIndexPiece)
        x = coords.0
        y = coords.1

        print(quarto)
    }
    print("La partie est finie. le joueur ", quarto.isPlayerOne() ? "1️⃣" : "2️⃣", " a gagné !")
    askToReplay()
}

// Demande au joueur de placer une pièce aux coordonnées (x, y). Si les coordonnées sont occupées, le joueur recommence.
// Si possible, place la pièce et retourne les cooordonnées (x, y).
//
// askToPlay : Int -> (Int, Int)
//
// askToPlay => addPiece(...)
// Paramètre : indexPiece : Indice de la pièce à poser. L'indice doit correspondre à l'indice affiché par askNextIndexPiece(...).
func askToPlay(indexPiece: Int) -> (Int, Int) {
    print("Joueur ", quarto.isPlayerOne() ? "1️⃣" : "2️⃣", ", tapez les coordonnées souhaités : ")

    while true {
        print("x : ")
        if let textX = readLine(), let x = Int(textX) {
            print("y : ")
            if let textY = readLine(), let y = Int(textY) {
                if quarto.addPiece(x: x, y: y, indexPiece: indexPiece) {
                    return (x, y)
                }
            }
        }
    }
}

// Demande à un des joueurs d'attribuer la pièce que le joueur suivant devra utiliser.
// L'entier retourné correspond à l'indice de la pièce dans la liste ou l'itérator des pièces.
//
// askNextPiece: -> Int
//
// askNextPiece -> index: Int, tq la pièce correspondant à l'indice, ne doit pas être utilisée.
func askNextIndexPiece() -> Int {
    print("Joueur ", quarto.isPlayerOne() ? "1️⃣" : "2️⃣", ", tapez le numéro de la pièce voulue : ")

    var itPiece = quarto.makeItPiece()
    while true {
        if let text = readLine(), let index = Int(text) {
            var i: Int = 0
            while let piece = itPiece.next() {
                if i == index && !piece.isUsed() {
                    return i
                }
                i += 1
            }
        }
        print("Valeur non valide. ")
    }
}

// Demande au joueur s'il souhaite rejouer. Si oui, réinitialise le jeu et le relance.
//
// askToReplay:
//
// askToReplay => restart(), play()
func askToReplay () {
    print("Pressez sur s pour stopper le jeu, sinon n'importe quelle autre touche pour recommencer : ")
    if let text = readLine() {
        if text != "s" {
            quarto.restart()
            play()
        }
    }
}