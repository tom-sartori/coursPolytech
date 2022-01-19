// CustomStringConvertible est présent pour l'affichage uniquement
protocol PTMabula : CustomStringConvertible, Sequence {
    associatedtype IteratorMabula : IteratorProtocol

    // Création d'un TMabula : initialise le plateau en plaçant 12 billles noires et 12 billes blanches sur les bords du plateau uniquement ; il n'y a pas plus de 2 billes de la même couleur placées à côté.
    // L'utilisateur choisi d'utiliser le décompte par les longueurs max des groupes de billes, ou bien le décopte par multiplication sinon
    init(decompteParLesLongueursMax: Bool)

    // Déplace la bille de position (x, y) de n cases vers le centre du plateau ; déplace aussi les billes sur le passage.
    // - déplacer(m, x, y, v) && bille(m, x', y') => déplacer(m, x', y', v-nombre_cases_vides_entre(m, x, y, x', y'))
    // - v <= 6 - t     où t est le nombre de billes sur le chemin de la bille en (x, y)
    mutating func deplacer(x: Int, y: Int, v: Int) -> Bool

    // Donne le nombre de cases vides entre deux cases aux coordonnées (x, y) et (x', y')
    func nombreCasesVides(x: Int, y: Int, x2: Int, y2: Int) -> Int

    // Compte la longueur maximale parmi les groupes des billes du joueur j.
    mutating func compterMax(isForWhite: Bool) -> Int

    // Compte la multiplication de la longueur de chaque groupe de bille du joueur j.
    mutating func compterMultiplication(isForWhite: Bool) -> Int

    // Retourne True si la bille sur la case en (x, y) appartient au joueur actuel
    func isBilleCaseAppartient(x: Int, y: Int) -> Bool

    // Retourne True si c'est au joueur 1 de jouer, False sinon
    func isPlayerOneToPlay() -> Bool

    // Change de joueur
    // => isPlayerOneToPlay = !isPlayerOneToPlay
    mutating func switchPlayer()

    // Le joueur 1 peut-il jouer ce tour ? Si oui, il joue ; sinon il passe son tour.
    func isPlayerOneCanPlay() -> Bool

    // Le joueur 2 peut-il jouer ce tour ? Si oui, il joue ; sinon il passe son tour.
    func isPlayerTwoCanPlay() -> Bool

    // Afin de parcourrir la collection
    func makeIterator() -> ItMabula

    // Donne le gagnant de la partie de Mabula.
    // True si c'est le joueur 1, False sinon
    // Si vide il y a égalité
    // Le gagnant est choisi en fonction du résultat de la méthode de calcul choisie
    mutating func isPlayerOneWin() -> Bool?
}
