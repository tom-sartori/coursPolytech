//
// Created by Tom Sartori on 12/2/21.
//

import Foundation

struct Mabula: CustomStringConvertible, PTMabula {
    internal typealias IteratorMabula = ItMabula


    // Correspond au plateau de jeu.
    //      true correspond aux cases blanches, du joueur 1. 
    //      false correspond aux cases noires, du joueur 2.
    //      nil aux cases vides.
    //
    // table : Mabula -> [[Bool?]]
    fileprivate var table : [[Bool?]]

    // Correspond à la taille du jeu.
    // 
    // gameSize : Mabula -> Int
    private var gameSize: Int

    // Correspond à la manière de calculer le score.
    // Si vrais alors le score sera la multiplication des groupe, sinon le plus grand groupe.
    //
    // isMultiScore : Mabula -> Bool
    private var isMultiScore: Bool

    // Si vrais, le joueur qui va joueur est le 1 (cases blanches).
    // 
    // isPlayerOne : Mabule -> Bool
    private var isPlayerOne: Bool

    // Initialisation du jeu.
    //
    // init : -> Mabula
    public init(decompteParLesLongueursMax: Bool) {
        gameSize = 8
        table = [[Bool?]](repeating: [Bool?](repeating: nil, count: gameSize), count: gameSize)
        isMultiScore = !decompteParLesLongueursMax
        isPlayerOne = true

        // TODO : Faire l'initialisation propre et pas avec quatre for.
        let listBool = randomColor()
        for i in 1 ..< 7 {  // Ligne haut
            setValue(x: 0, y: i, value: listBool[i - 1])
        }
        for i in 1 ..< 7 {  // Col droite
            setValue(x: i, y: gameSize - 1, value: listBool[5 + i])
        }
        for i in 1 ..< 7 {  // Ligne bas
            setValue(x: gameSize - 1, y: gameSize - 1 - i, value: listBool[11 + i])
        }
        for i in 1 ..< 7 {  // Col gauche
            setValue(x: gameSize - 1 - i, y: 0, value: listBool[17 + i])
        }
    }

    // Fonction qui permet de générer aléatoirement les billes de couleurs blanches ou noires. 
    //
    // randomColor : Mabula -> [Bool]
    private func randomColor() -> [Bool]{
        var tab : [Bool] = [Bool](repeating: true, count : 12)
        var tabReverse : [Bool] = [Bool](repeating: true, count : 12)
        var tabRandom : [Bool]
        var nbW : Int = 0
        var nbB : Int = 0
        var boule : Bool
        for i in 0..<tab.count{
            if nbB == 6 {
                tab[i] = true
            }
            else if nbW == 6{
                tab[i] = false
            }
            else{
                boule = Bool.random()
                if i<2{
                    tab[i] = boule
                }
                if boule == true && i>1{
                    if tab[i-2] == tab[i-1] && tab[i-1] == boule{
                        nbB += 1
                        tab[i] = !boule
                    }
                    else{
                        tab[i] = boule
                        nbW += 1
                    }
                }
                else{
                    if i>1{
                        if tab[i-2] == tab [i-1] && tab[i-1] == boule{
                            nbW += 1
                            tab[i] = !boule
                        }
                        else{
                            tab[i] = boule
                            nbB += 1
                        }
                    }
                }
            }
        }
        for i in 0..<tab.count{
            tabReverse[i] = !tab[tab.count - 1 - i]
        }
        tabRandom = tab + tabReverse
        return tabRandom
    }



/**
 - Calcul des scores et du gagnant.
 */

    // Retourne vrais si le joueur 1 a gagné, vide si nul, faux sinon.
    //
    // isPlayerOneWin : PTMabula -> PTMabula x Bool?
    public mutating func isPlayerOneWin() -> Bool? {
        let scoreWhite: Int
        let scoreBlack: Int

        if isMultiScore {   // Score calculated by multiplication of groups.
            scoreWhite = getScoreMulti(isForWhite: true)
            scoreBlack = getScoreMulti(isForWhite: false)
            // print("Multi score | White : \(scoreWhite), Black : \(scoreBlack)")
        }
        else {  // The score is the best group.
            scoreWhite = getScoreBestGroup(isForWhite: true)
            scoreBlack = getScoreBestGroup(isForWhite: false)
            // print("Group score | White : \(scoreWhite), Black : \(scoreBlack)")
        }
        return scoreWhite == scoreBlack ? nil : scoreWhite > scoreBlack
    }

    public mutating func getScoreMulti(isForWhite: Bool) -> Int {
        var listIndexBall = getListCoord(isForWhite: isForWhite)

        var totalScore = 1
        while !listIndexBall.isEmpty {
            let groupScore = getGroupSize(listCoord: &listIndexBall, coord: listIndexBall[0])
            totalScore *= groupScore
        }
        return totalScore
    }

    // Retourne la taille du plus grand groupe pour la couleur en param.
    // Si isForWhite == true, alors on calcule pour les blancs/le joueur 1, sinon les noirs/le joueur 2.
    //
    // getScoreBestGroup : PTMabula x Bool -> PTMabula x Int
    public mutating func getScoreBestGroup (isForWhite: Bool) -> Int {
        var listIndexBall = getListCoord(isForWhite: isForWhite)

        var bestScore: Int = 0
        while !listIndexBall.isEmpty {  // La fonction getGroupSize(...) diminue la taille de la liste. C'est donc tant qu'il n'y a plus de cases qui n'ont pas encore été comptabilisées.
            let groupScore = getGroupSize(listCoord: &listIndexBall, coord: listIndexBall[0])
            bestScore = Swift.max(bestScore, groupScore)
        }
        return bestScore
    }

    // Retourne la taille du groupe de cases, contenant la case "coord" en paramètre.
    // Les autres cases pouvant, ou non, faire partie du groupe, doivent être dans la liste en paramètres. Des éléments de cette liste pourront être supprimés.
    // Est considéré groupe, les cases côtes à côtes et pas en diagonales (voir règes mabula).
    // Cette fonction est récursive.
    // 
    // getGroupSize : Mabula x [ (Int, Int) ] x (Int x Int) -> Int
    private mutating func getGroupSize(listCoord: inout [(x: Int, y: Int)], coord: (x: Int, y: Int)) -> Int {
        /// - Invariant: Si dans la liste en param, il existe une case côte à côte de la case courante, alors on ajoute à la somme, le nombre de cases côtes à côtes de cette dernière.
        ///     Dès qu'une case est trouvée, alors on la supprime de la liste et on initialise sa somme à 1.

        var sum: Int = 1
        removeTupleInList(list: &listCoord, element: coord)

        if isTupleInList(list: listCoord, element: (coord.x, coord.y - 1)) {  // Check left side
            sum += getGroupSize(listCoord: &listCoord, coord: (coord.x, coord.y - 1))
        }
        if isTupleInList(list: listCoord, element: (coord.x, coord.y + 1)) {  // Check right side
            sum += getGroupSize(listCoord: &listCoord, coord: (coord.x, coord.y + 1))
        }
        if isTupleInList(list: listCoord, element: (coord.x - 1, coord.y)) {  // Check upper side
            sum += getGroupSize(listCoord: &listCoord, coord: (coord.x - 1, coord.y))
        }
        if isTupleInList(list: listCoord, element: (coord.x + 1, coord.y)) {  // Check bottom side
            sum += getGroupSize(listCoord: &listCoord, coord: (coord.x + 1, coord.y))
        }

        return sum
    }

    // Supprime le tuple placé en paramètre de la liste de tuples également placé en paramètre
    //
    // removeTupleInList : Mabula x [(Int,Int)] x (Int,Int) -> Bool
    //
    // Paramètres : - [(x:Int,y:Int)]: Liste de tuples, - (x: Int, y: Int) : Le tuple
    private mutating func removeTupleInList(list: inout [(x: Int, y: Int)], element: (x: Int, y: Int)) {
        list = list.filter { !($0.x == element.x && $0.y == element.y) }
    }

    // Renvoie True si le tuple en paramètre appartient à la liste de tuples également placée en paramètre, False sinon
    //
    // isTupleInList : Mabula x [(Int,Int)] x (Int,Int) -> Bool
    //
    // Paramètres : - [(x:Int,y:Int)]: Liste de tuples, - (x: Int, y: Int) : Le tuple
    private func isTupleInList(list: [(x: Int, y: Int)], element: (x: Int, y: Int)) -> Bool {
        return list.filter { $0.x == element.x && $0.y == element.y }.count >= 1
    }

    // Retourne la liste des coordonnées qui, dans le jeu, sont égaux au booléen an paramètre.
    // Retourne la liste des coordonnées des boules blanches du jeu, si le paramètre est true.
    //
    // getListCoord : Mabula x Bool -> [ (Int, Int) ]
    private func getListCoord (isForWhite: Bool) -> [(x: Int, y: Int)] {
        var listTupleIndex: [(x: Int, y: Int)] = [(x: Int, y: Int)]()

        for x in 0 ..< table.count {
            for y in 0 ..< table[x].count {
                if table[x][y] == isForWhite {
                    listTupleIndex.append((x: x, y: y))
                }
            }
        }
        return listTupleIndex
    }



/**
 - Déplacements.
 */

    // Déplace une bille située en (x, y), d'un nombre de cases v.
    // (x, y) doit être sur une bordure et v ne doit pas être plus grand que le nombre de cases vides devant la bille en param.
    //
    // deplacer : Mabula x Int x Int x Int -> Mabula x Bool
    mutating func deplacer(x: Int, y: Int, v: Int) -> Bool {
        guard 0 <= x && x < gameSize && 0 <= y && y < gameSize else {
            // Coordonnées non valides.
            return false
        }
        guard v > 0 else {
            // Vitesse nulle.
            return false
        }
        guard v <= getNumberEmptyCasesFromStart(x: x, y: y) else {
            // Déplacement trop grand.
            return false
        }
        // Déplacement possible.

        // Orientation du type (x: Int, y: Int), avec x et y compris entre -1 et 1.
        // Par la suite, il suffit d'augmenter x de orientation.x et y de orientation.y.
        let orientation = getOrientation(x: x, y: y)

        var tableWithoutNil: [Bool?]    // Tableau contenant les éléments ordonnés de la ligne/colonne, sans les cases vides.
        var listIndexOfNil: [Int]       // Tableau contenant les index ordonnés, des cases vides de la ligne/colonne.

        // Pour les variables suivants, on définit "premiere" et "derniere" case, en partant de gauche à droite ou de haut à bas, de la ligne/colonne à modifier.
        var indexFirstNil: Int  // Indice de la furure première case vide de la ligne/colonne à modifier.
        var indexLastNil: Int   // Indice de la furure dernière case vide de la ligne/colonne à modifier.
        var indexFirstValue: Int    // Indice de la furure première case non-vide de la ligne/colonne à modifier.
        var indexLastValue: Int     // Indice de la furure dernière case non-vide de la ligne/colonne à modifier.
        var startIndexInTableWithoutNil: Int    // Indice correspondant à l'indice, dans tableWithoutNil, qu'il faudra utiliser au départ.

        /**
         Par la suite, on initialise les variables évoquées precedement, suivant l'axe et la direction de déplacement de la première bille.
         - Invariant:
                - Si déplacement horizontal :
                    table[x][indexFirstNil : indexLastNil] == nil
                    table[x][indexFirstValue : indexLastValue] == (tableWithoutNil[startIndexInTableWithoutNil ::] || tableWithoutNil[:: startIndexInTableWithoutNil] ) suivant la direction.

                - Si déplacement vertical :
                    table[indexFirstNil : indexLastNil][y] == nil
                    table[indexFirstValue : indexLastValue][y] == (tableWithoutNil[startIndexInTableWithoutNil ::] || tableWithoutNil[:: startIndexInTableWithoutNil] ) suivant la direction.
         */

        // Initialisation des variables tableWithoutNil et listIndexOfNil.
        if orientation.0 == 0 {     // Déplacement horizontal.
            tableWithoutNil = table[x].filter{ $0 != nil }  // Liste les valeurs sur la ligne, sans les cases vides.
            listIndexOfNil = table.indices.filter( { getValue(x: x, y: $0) == nil } )  // Liste les indices des nil.
        }
        else {  // Déplacement vertical
            tableWithoutNil = [Bool?]()
            for x in 0 ..< table.count {    // Liste les valeurs sur la colonne, sans les cases vides.
                if getValue(x: x, y: y) != nil {
                    tableWithoutNil.append(getValue(x: x, y: y))
                }
            }
            listIndexOfNil = table.indices.filter({ table[$0][y] == nil })  // Liste les indices des nil.
        }


        // Initialisation des autres variables, suivant l'orientation.
        if orientation.0 == 1 || orientation.1 == 1 { // Going right or down
            indexFirstNil = 0
            indexLastNil = v - 1    // Check v > 1
            indexFirstValue = v
            indexLastValue = listIndexOfNil[v - 1]
            startIndexInTableWithoutNil = 0
        }
        else {  // Going left or up
            indexFirstNil = gameSize - v - 1
            indexLastNil = gameSize - 1
            indexFirstValue = listIndexOfNil[listIndexOfNil.count - v] /// Todo check sinon inverse et [v]
            indexLastValue = gameSize - v - 1
            startIndexInTableWithoutNil = tableWithoutNil.count - (indexLastValue - indexFirstValue) - 1
        }


        // Affectation des valeurs suivant les variables calculées précedement.
        if orientation.0 == 0 { // Déplacement horizontal.
            for i in indexFirstNil ... indexLastNil {   // Modification des cases vides.
                setValue(x: x, y: i, value: nil)
            }
            for i in indexFirstValue ... indexLastValue {   // On replace, dans l'ordre, les cases qui ont été déplacées, sans mettre les vides.
                setValue(x: x, y: i, value: tableWithoutNil[startIndexInTableWithoutNil])
                startIndexInTableWithoutNil += 1
            }
        }
        else {  // Déplacement vertical
            for i in indexFirstNil ... indexLastNil {   // Modification des cases vides.
                setValue(x: i, y: y, value: nil)
            }
            for i in indexFirstValue ... indexLastValue {   // On replace, dans l'ordre, les cases qui ont été déplacées, sans mettre les vides.
                setValue(x: i, y: y, value: tableWithoutNil[startIndexInTableWithoutNil])
                startIndexInTableWithoutNil += 1
            }
        }
        return true
    }


    // Retourne le nombre de cases vides entre deux cases aux coordonnées (x, y) et (x2, y2).
    // Ne prend pas en compte les cases des bordures.
    //
    // nombreCasesVides : Mabula x Int x Int x Int x Int -> Int
    // Paramètres : - x: Numéro de ligne de la case de la première bille, - y: Numéro de colonne de la case de la première bille, - x2: Numéro de ligne de la case de la seconde bille, - y2: Numéro de colonne de la case de la seconde bille,
    public func nombreCasesVides(x: Int, y: Int, x2: Int, y2: Int) -> Int {
        // Vérification ques les coordonnées appartiennent au plateau.
        guard 0 <= x && x < gameSize &&
                      0 <= y && y < gameSize &&
                      0 <= x2 && x2 < gameSize &&
                      0 <= y2 && y2 < gameSize
                else { fatalError("func getNumberEmptyCases : Mauvais coordonnés. ") }

        // Vérification que les deux points en paramètres, soient bien sur une ligne ou colonne.
        guard x == x2 || y == y2 else { fatalError("func getNombeCasesVides : Les deux cases ne sont pas sur les mêmes lignes. ") }


        if x == x2 {    // On compte les cases vides sur une ligne horizontale.
            return table.indices
                    .filter( {
                        $0 != 0 && $0 != gameSize - 1 &&    // On ne prend pas les bordures.
                        Swift.min(y, y2) <= $0 && $0 <= Swift.max(y, y2) &&     // On prend que les cases qui sont sur la ligne (donc entre y et y2).
                        table[x][$0] == nil     // On prend que les cases vides.
                    } )
                    .count  // On compte le nombre de cases respectant les critères précédents, et on retourne le résultat.
        }
        else { // y1 == y2 : On compte les cases vides sur une colonne verticale.
            return table.indices
                    .filter( {
                        $0 != 0 && $0 != gameSize - 1 &&    // On ne prend pas les bordures.
                        Swift.min(x, x2) <= $0 && $0 <= Swift.max(x, x2) &&     // On prend que les cases qui sont sur la colonne (donc entre x et x2).
                        table[$0][y] == nil     // On prend que les cases vides.
                    } )
                    .count // On compte le nombre de cases respectant les critères précédents, et on retourne le résultat.
        }
    }

    // Retourne nombre cases vides, devant une bille qui n'a pas encore été déplacée.
    //
    // getNumberEmptyCases : Mabula x Int x Int -> Int
    //
    // Paramètres : - x: Numéro de ligne de la case, - y: Numéro de colonne de la case
    //
    // Fonction appelée : getOrientation(...)
    private func getNumberEmptyCasesFromStart(x: Int, y: Int) -> Int {
        let orientation = getOrientation(x: x, y: y)

        if orientation.0 == 1 { // Direction verticale basse.
            return nombreCasesVides(x: x, y: y, x2: gameSize - 1, y2: y)
        }
        else if orientation.0 == -1 { // Direction verticale haute.
            return nombreCasesVides(x: x, y: y, x2: 0, y2: y)
        }
        else if orientation.1 == 1 {    // Direction horizontale droite.
            return nombreCasesVides(x: x, y: y, x2: x, y2: gameSize - 1)
        }
        else if orientation.1 == -1 { // Direction horizontale gauche.
            return nombreCasesVides(x: x, y: y, x2: x, y2: 0)
        }
        else {
            fatalError("func getNumberEmptyCases")
        }
    }


    // Retourne l'orientation pour une case au départ.
    // Valeurs de retour possibles :
    //      (1, 0)  pour direction verticale basse
    //      (-1, 0) pour direction verticale haute
    //      (0, 1)  pour direction horizontale droite
    //      (0, -1) pour direction horizontale gauche
    //
    // getOrientation : Mabula x Int x Int -> (Int,Int)
    //
    // Paramètres : - x: Numéro de ligne de la case, - y: Numéro de colonne de la case
    private func getOrientation (x: Int, y: Int) -> (Int, Int) {
        if x == 0 {
            return (1, 0)
        }
        else if x == gameSize - 1 {
            return (-1, 0)
        }
        else if y == 0 {
            return (0, 1)
        }
        else if y == gameSize - 1 {
            return (0, -1)
        }
        else {
            fatalError("func getOrientation")
        }
    }



/**
 - Gestion du joueur.
 */

    // Change de joueur
    // => isPlayerOneToPlay = !isPlayerOneToPlay
    //
    // switchPlayer : PTMabula -> PTMabula
    public mutating func switchPlayer() {
        isPlayerOne = !isPlayerOne
    }

    // Retourne True si la bille sur la case en (x, y) appartient au joueur actuel
    //
    // isBilleCaseAppartient : PTMabula x Int x Int -> Bool
    //
    // Paramètres : - x: Numéro de ligne de la bille, - y: Numéro de colonne de la bille
    public func isBilleCaseAppartient(x: Int, y: Int) -> Bool {
        return isPlayerOne == getValue(x: x, y: y)
    }

    // Retourne True si c'est au joueur 1 de jouer, False sinon
    //
    // isPlayerOneToPlay : PTMabula -> Bool
    public func isPlayerOneToPlay() -> Bool {
        return isPlayerOne
    }

    // Fonction qui retourne true si le joueur 1 peut jouer, false sinon
    //
    //isPlayerOneCanPlay : PTMabula -> Bool
    //
    // Fonction appelée : isPlayerCanPlay(...)
    public func isPlayerOneCanPlay() -> Bool{
        return playerCanPlay(isPlayerOne: true)
    }

    // Fonction qui retourne true si le joueur 2 peut jouer, false sinon
    //
    //isPlayerTwoCanPlay : PTMabula -> Bool
    //
    // Fonction appelée : isPlayerCanPlay(...)
    public func isPlayerTwoCanPlay() -> Bool {
        return playerCanPlay(isPlayerOne: false)
    }

    // Fonction qui retourne vrai si le joueur placé en paramètre peut jouer, false sinon
    //
    // isPlayerCanPlay : Mabula x Bool -> Bool
    //
    // Fonction appelée : getNumberEmptyCases(...)
    private func playerCanPlay (isPlayerOne : Bool) -> Bool{
        var canPlay: Bool = false
        var i: Int = 1
        // Invariant : jusqu'à un certain i, je n'ai pas trouvé un joueur pouvant jouer.
        while i < 8 && !canPlay{
            if getValue(x: 0, y: i) == isPlayerOne {
                if getNumberEmptyCasesFromStart(x: 0,y: i) > 0{
                    canPlay = true
                }
            }
            if getValue(x: i, y: gameSize - 1) == isPlayerOne {
                if getNumberEmptyCasesFromStart(x: i,y: gameSize-1) > 0{
                    canPlay = true
                }
            }
            if getValue(x: gameSize - 1, y: gameSize - 1 - i) == isPlayerOne {
                if getNumberEmptyCasesFromStart(x: gameSize - 1, y: gameSize - 1 - i) > 0{
                    canPlay = true
                }
            }
            if getValue(x: gameSize - 1 - i, y: 0) == isPlayerOne {
                if getNumberEmptyCasesFromStart(x: gameSize - 1 - i, y: 0) > 0 {
                    canPlay = true
                }
            }
            i+=1
            //Condition d'arrêt : i>8 ou on a trouvé un joueur pouvant jouer
        }
        return canPlay
    }



/**
 - Set, get et itérators.
 */

    // Retourne True si la case (x,y) est vide, False sinon
    //
    // isEmpty : Mabula x Int x Int -> Bool
    //
    // Paramètres : - x: Numéro de ligne de la case, - y: Numéro de colonne de la case
    private func isEmpty(x: Int, y: Int) -> Bool {
        return getValue(x: x, y: y) == nil
    }

    // Renvoi la valeur aux coordonnées en paramètre.
    //
    // getValue : Mabula x Int x Int -> Bool?
    private func getValue (x: Int, y: Int) -> Bool? {
        var itMabula: ItMabula = makeIterator(startX: x, startY: y)
        if let value = itMabula.next() {
            return value
        }
        else {
            fatalError("func getValue")
        }
    }

    // Met la valeur en paramètre aux coordonnées en paramètre.
    //
    // setValue : Mabula x Int x Int x Bool? -> Mabula
    private mutating func setValue (x: Int, y: Int, value: Bool?) {
        table[x][y] = value
    }


    // Crée un itérateur sur le mabula permettant de la parcourir.
    //
    // makeIterator : PTMabula -> ItMabula
    public func makeIterator() -> ItMabula {
        return ItMabula(self)
    }

    // Créé un itérateur sur le mabula permettant de le parcourir.
    // Commence le parcour a certains coordonnées en paramètres.
    //
    // makeIterator : Mabula x Int x Int -> ItMabula
    private func makeIterator(startX: Int, startY: Int) -> ItMabula {
        return ItMabula(self, startX: startX, startY: startY)
    }

    // Uniquement utilisé pour l'affichage
    //
    // description: PTMabule -> String
    public var description: String {
        var itMabula = makeIterator()
        var str : String = "   0   1   2  3   4   5   6  7 \n"

        var i: Int = 0
        while let elt = itMabula.next() {
            if i % 8 == 0 { str += (i / 8).description + "  " }   // Affichage chiffre à gauche.
            str += elt == nil ? "⭕" : elt == true ? "⚪" : "⚫"   // Affichage valeur case.
            str += "  "
            i += 1
            if i % 8 == 0 { str += "\n" }   // Retour à la ligne.
        }

        return str
    }
}

// Itérateur sur le mabula permettant de le parcourir.
// Le parcour est fait de la gauche à la droite et de haut en bas.
public struct ItMabula: IteratorProtocol {
    private var table: [[Bool?]]
    private var currentX: Int
    private var currentY: Int

    // Initialisation d'un itérateur sur la table du mabula. La premiere case est la case supérieure gauche (0; 0).
    //
    // init: Mabula -> ItMabula
    init (_ mabula: Mabula) {
        table = mabula.table
        currentX = 0
        currentY = 0
    }

    // Initialisation de l'itérator à partir d'une valeur spécifique.
    //
    // init: Mabula x Int x Int -> ItMabula
    init(_ mabula: Mabula, startX: Int, startY: Int) {
        guard 0 <= startX && startX < mabula.table.count && 0 <= startY && startY < mabula.table.count else { fatalError("ItMabula : init") }
        table = mabula.table
        currentX = startX
        currentY = startY
    }

    // Renvoi la valeur aux coordonnées courants.
    // Passe à la case suivante (direction : gaucha à droite et haut à bas).
    // S'il n'y a plus de cases, retourne vide.
    //
    // next: ItMabula -> (Bool | vide) | vide
    public mutating func next() -> Bool?? {
        guard currentX < table.count else { return nil }
        let value = table[currentX][currentY]

        if (currentY == table.count - 1) {
            currentX += 1
            currentY = 0
        }
        else {
            currentY += 1
        }

        return value
    }
}
