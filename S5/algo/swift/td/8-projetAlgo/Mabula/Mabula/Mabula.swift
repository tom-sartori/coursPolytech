//
// Created by Tom Sartori on 12/2/21.
//

import Foundation

struct Mabula: CustomStringConvertible, PTMabula {
    typealias IteratorMabula = ItMabula

    // White == true && Black == false
    fileprivate var table : [[Bool?]]
    private var gameSize: Int
    private var isMultiScore: Bool  // True if score calculated by multi else, score calculated by max group.
    private var isPlayerOne: Bool

    init(decompteParLesLongueursMax: Bool) {
        gameSize = 8
        table = [[Bool?]](repeating: [Bool?](repeating: nil, count: gameSize), count: gameSize)
        self.isMultiScore = decompteParLesLongueursMax
        isPlayerOne = true

        // TODO : Faire l'initialisation propre et pas avec quatre for.
        var listBool = randomColor()
        for i in 1 ..< 7 {  // Ligne haut
            table[0][i] = listBool[i - 1]
        }
        for i in 1 ..< 7 {  // Col droite
            table[i][gameSize - 1] = listBool[5 + i]
        }
        for i in 1 ..< 7 {  // Ligne bas
            table[gameSize - 1][gameSize - 1 - i] = listBool[11 + i]
        }
        for i in 1 ..< 7 {  // Col gauche
            table[gameSize - 1 - i][0] = listBool[17 + i]
        }
    }

// Fonction qui permet de générer aléatoirement les billes de couleurs blanches ou noires
//
// randomColor : MabulaProtocol -> [Bool]
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
        print (tabRandom)
        return tabRandom
    }

    /// - Todo: Refactor
    mutating func getListIndex (value: Bool) -> [(x: Int, y: Int)] {
        let element = (x: -1, y: -1)
        var listTupleIndex: [(x: Int, y: Int)] = [(x: Int, y: Int)](repeating: element, count: 1)
        removeTupleInList(list: &listTupleIndex, element: element)
        assert(listTupleIndex.isEmpty)

        for x in 0 ..< table.count {
            let listYIndex = table.indices.filter{ table[x][$0] == value }
            for i in 0 ..< listYIndex.count {
                listTupleIndex.append((x: x, y: listYIndex[i]))
            }
        }
        return listTupleIndex
    }

    mutating func isPlayerOneWin() -> Bool? {
        let scoreWhite: Int
        let scoreBlack: Int

        if isMultiScore {   // Score calculated by multiplication of groups.
            scoreWhite = getScoreMulti(isForWhite: true)
            scoreBlack = getScoreMulti(isForWhite: false)
            /// - Todo: remove print
            print("Multi score | White : \(scoreWhite), Black : \(scoreBlack)")
        }
        else {  // The score is the best group.
            scoreWhite = getScoreBestGroup(isFromWhite: true)
            scoreBlack = getScoreBestGroup(isFromWhite: false)
            /// - Todo: remove print
            print("Group score | White : \(scoreWhite), Black : \(scoreBlack)")
        }
        /// - Todo: print ?
        /// - Todo: isDraw ?
        return scoreWhite == scoreBlack ? nil : scoreWhite > scoreBlack
    }

    // TODO Refactor coord
    mutating func getScoreMulti(isForWhite: Bool) -> Int {
        var listIndexBall = getListIndex(value: isForWhite)

        var totalScore = 1
        while !listIndexBall.isEmpty {
            let groupScore = getScoreAux(list: &listIndexBall, coord: listIndexBall[0])
            totalScore *= groupScore
        }
        return totalScore
    }

    mutating func getScoreBestGroup (isFromWhite: Bool) -> Int {
        var listIndexBall = getListIndex(value: isFromWhite)

        var bestScore: Int = 0
        while !listIndexBall.isEmpty {
            let groupScore = getScoreAux(list: &listIndexBall, coord: listIndexBall[0])
            bestScore = Swift.max(bestScore, groupScore)
        }
        return bestScore
    }

    // TODO Faireavec un idex ?
    private mutating func getScoreAux (list: inout [(x: Int, y: Int)], coord: (x: Int, y: Int)) -> Int {
        var sum: Int = 1
        removeTupleInList(list: &list, element: coord)

        if isTupleInList(list: list, element: (coord.x, coord.y - 1)) {  // Check left side
            sum += getScoreAux(list: &list, coord: (coord.x, coord.y - 1))
        }
        if isTupleInList(list: list, element: (coord.x, coord.y + 1)) {  // Check right side
            sum += getScoreAux(list: &list, coord: (coord.x, coord.y + 1))
        }
        if isTupleInList(list: list, element: (coord.x - 1, coord.y)) {  // Check upper side
            sum += getScoreAux(list: &list, coord: (coord.x - 1, coord.y))
        }
        if isTupleInList(list: list, element: (coord.x + 1, coord.y)) {  // Check bottom side
            sum += getScoreAux(list: &list, coord: (coord.x + 1, coord.y))
        }

        return sum
    }

    private mutating func removeTupleInList(list: inout [(x: Int, y: Int)], element: (x: Int, y: Int)) {
        list = list.filter { !($0.x == element.x && $0.y == element.y) }
    }

    private func isTupleInList(list: [(x: Int, y: Int)], element: (x: Int, y: Int)) -> Bool {
        return list.filter { $0.x == element.x && $0.y == element.y }.count >= 1
    }

    func nombreCasesVides(x: Int, y: Int, x2: Int, y2: Int) -> Int {
        guard 0 <= x && x < gameSize && 0 <= y && y < gameSize && 0 <= x2 && x2 < gameSize && 0 <= y2 && y2 < gameSize else { fatalError("func getNumberEmptyCases : Mauvais coordonnés. ") }
        guard x == x2 || y == y2 else { fatalError("func getNombeCasesVides : Les deux cases ne sont pas sur les mêmes lignes. ") }

        if x == x2 {
            // TODO : filter between y1 et y2
            // Crée une liste contenant les indices des nil dans la ligne, sans prendre en compte les extrémités. Retourne le nombre d'éléments de cette liste.
            return table.indices.filter({ $0 != 0 && $0 != gameSize - 1 && table[x][$0] == nil }).count
        }
        else { // y1 == y2
            // Crée une liste contenant les indices des nil dans la colonne, sans prendre en compte les extrémités. Retourne le nombre d'éléments de cette liste.
            return table.indices.filter({ $0 != 0 && $0 != gameSize - 1 && table[$0][y] == nil }).count // retourne les indices des nil
        }
    }

    // Retourne nombre cases vides pour bille au start.
    func getNumberEmptyCases(x: Int, y: Int) -> Int {
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


    // TODO : Refactor.
    /// - Todo: return false
    mutating func deplacer(x: Int, y: Int, v: Int) -> Bool {
        guard 0 <= x && x < gameSize && 0 <= y && y < gameSize else {
            return false
        }
        guard v > 0 else { fatalError("func move : Vitesse nulle. ") }
        // TODO Erreur de déplacement trop grand quand a la limite.
        guard v <= getNumberEmptyCases(x: x, y: y) else { fatalError("func move : Déplacement trop grand. ") }

        // Déplacement possible.
        let orientation = getOrientation(x: x, y: y)
        print("Orientation : \(orientation)")


        var tableWithoutNil: [Bool?]
        var listIndexOfNil: [Int]

        var indexFirstNil: Int
        var indexLastNil: Int
        var indexFirstValue: Int
        var indexLastValue: Int
        var startIndexInTableWithoutNil: Int

        if orientation.0 == 0 { // Déplacement horizontal.
            tableWithoutNil = table[x].filter{ $0 != nil }
            listIndexOfNil = table.indices.filter({ table[x][$0] == nil }) // retourne les indices des nil
        }
        else {  // Déplacement vertical
            print("test : ", table.indices.filter{ table[$0][y] != nil } )

            tableWithoutNil = [Bool?](repeating: true, count: 1)
            tableWithoutNil.remove(at: 0)
            assert(tableWithoutNil.isEmpty)
            for i in 0 ..< table.count {
                if table[i][y] != nil {
                    tableWithoutNil.append(table[i][y])
                }
            }
            listIndexOfNil = table.indices.filter({ table[$0][y] == nil }) // retourne les indices des nil
        }

        print("tableWithoutNil : \(tableWithoutNil)")
        print("listIndexOfNil : \(listIndexOfNil)")



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


        if orientation.0 == 0 { // Déplacement horizontal.
            for i in indexFirstNil...indexLastNil {
                table[x][i] = nil  // TODO Fonction setValue
            }
            for i in indexFirstValue...indexLastValue {
                table[x][i] = tableWithoutNil[startIndexInTableWithoutNil]
                startIndexInTableWithoutNil += 1
            }
        }
        else {  // Déplacement vertical
            for i in indexFirstNil ... indexLastNil {
                table[i][y] = nil  // TODO Fonction setValue
            }
            for i in indexFirstValue ... indexLastValue {
                table[i][y] = tableWithoutNil[startIndexInTableWithoutNil]
                startIndexInTableWithoutNil += 1
            }
        }
        return true
    }


    // Retourne orientation pour case au start
    func getOrientation (x: Int, y: Int) -> (Int, Int) {
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

    func isEmpty(x: Int, y: Int) -> Bool {
        return table[x][y] == nil
    }

    mutating func switchPlayer() {
        isPlayerOne = !isPlayerOne
    }

    func isBilleCaseAppartient(x: Int, y: Int) -> Bool {
        return isPlayerOne == table[x][y]
    }

    // Fonctio
    func isPlayerOneToPlay() -> Bool {
        return isPlayerOne
    }

    // Fonction qui retourne true si le joueur 1 peut jouer, false sinon
    //
    //isPlayerOneCanPlay : MabulaProtocol -> Bool
    //
    // Fonction appelée : isPlayerCanPlay(...)
    func isPlayerOneCanPlay() -> Bool{
        return isPlayerCanPlay(isPlayerOne: true)
    }

    // Fonction qui retourne true si le joueur 2 peut jouer, false sinon
    //
    //isPlayerTwoCanPlay : MabulaProtocol -> Bool
    //
    // Fonction appelée : isPlayerCanPlay(...)
    func isPlayerTwoCanPlay() -> Bool {
        return isPlayerCanPlay(isPlayerOne: false)
    }

    // Fonction qui retourne vrai si le joueur placé en paramètre peut jouer, false sinon
    //
    //isPlayerCanPlay : MabulaProtocol x Bool -> Bool
    //
    // Fonction appelée : getNumberEmptyCases(...)
    private func isPlayerCanPlay(isPlayerOne : Bool) -> Bool{
        var canPlay : Bool = false
        var i : Int = 1
        // Invariant : jusqu'à un certain i, je n'ai pas trouvé un joueur pouvant jouer
        while i<8 && !canPlay{
            if table[0][i] == isPlayerOne{
                if getNumberEmptyCases(x: 0,y: i) > 0{
                    canPlay = true
                }
            }
            if table[i][gameSize - 1] == isPlayerOne {
                if getNumberEmptyCases(x: i,y: gameSize-1) > 0{
                    canPlay = true
                }
            }
            if table[gameSize - 1][gameSize - 1 - i] == isPlayerOne {
                if getNumberEmptyCases(x: gameSize - 1, y: gameSize - 1 - i) > 0{
                    canPlay = true
                }
            }
            if table[gameSize - 1 - i][0] == isPlayerOne {
                if getNumberEmptyCases(x: gameSize - 1 - i, y: 0) > 0{
                    canPlay = true
                }
            }
            i+=1
            //Condition d'arrêt : i>8 ou on a trouvé un joueur pouvant jouer
        }
        return canPlay
    }

    func makeIterator() -> ItMabula {
        return ItMabula(self)
    }

    //Uniquement utilisé pour l'affichage
    var description: String {
        var str : String = "   0   1   2  3   4   5   6  7 \n"
        for i in 0 ..< gameSize {
            str += "\(i.description)  "
            for j in 0 ..< gameSize {
                if let value = table[i][j] {
                    str += value ? "⚪" : "⚫"
                }
                else {
                    str += "⭕"
                }
                str += "  "
            }
            str += "\n"
        }
        return str
    }
}
struct ItMabula: IteratorProtocol {
    private var table: [[Bool?]]
    private var currentX: Int
    private var currentY: Int

    init (_ mabula: Mabula) {
        table = mabula.table
        currentX = 0
        currentY = 0
    }

    mutating func next() -> Bool?? {
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
