//
//  main.swift
//  tp6
//
//  Created by Tom Sartori on 11/12/21.
//
//

import Foundation

var greeting = "Hello, playground"



// Ex 1

// Soit i, j, k tq
// (tab[0 : i[ == false) && (tab [i : j[ == true) && (tab[j: k[ == false)


func estConvexe (tab : [Bool]) -> Bool {
    var i = 0, j = 0, k = 0

    while i < tab.count && i == j {
        if !tab[i] {
            i += 1
            j = i
            k = i
        }
        else {
            j += 1
            k = j
        }
    } // Arret while. Fin du tableau, ou sinon, on a trouvé un true a la fin du tableau.

    while j < tab.count && j == k {
        if tab[j] {
            j += 1
            k = j
        }
        else {
            k += 1
        }
    } // Arret while. Fin du tableau, ou sinon, on a trouvé un false a la fin du tableau.

    while k < tab.count && !tab[k - 1] {
        if !tab[k] {
            k += 1
        }
    } // Arret while : Fni du tableau ou sinon, on a trouvé un true

    return k == tab.count
}



// Ex 2

//

func sommeMax (tab : [Int]) -> Int {
    var res = tab[0]
    var somme = 0

    for i in 0 ..< tab.count {
        for j in i ..< tab.count {
            somme += tab[j]
            if res < somme {
                res = somme
            }
        }
        somme = 0
    }
    return res
}

func sommeMaxBis (tab : [Int]) -> Int {
    var resultat = tab[0]

    // Inv : resultat = max(resultat + tab[i], tab[i])
    for i in 1 ..< tab.count {
        resultat = max(resultat + tab[i], tab[i])
    }
    return resultat
}

let tab = [1, -3, 3, 7]
print(sommeMax(tab: tab))
print(sommeMaxBis(tab: tab))



// Ex 3

// {’B’,’W’,’R’}
// [W, B, R, B, B, R]   0   0   1
// [B, W, R, B, B, R]   1   1   1
// [B, B, W, B, R, R]   2   2   2
// [B, B, B, W, R, R]   3   3   2


// [W, B, R, B, B, R]   0   0
// [B, W, R, B, B, R]   1   1
// [B, W, R, B, B, R]   2   1
// [B, B, W, R, B, R]   3   2   2 act
// [B, B, B, W, R, R]   4   3   2 act


// [W, B, R, R, R, B, B, R]   0   0
// [B, W, R, R, R, B, B, R]   1   1
// [B, W, R, R, R, B, B, R]   2   1
// [B, W, R, R, R, B, B, R]   3   1
// [B, W, R, R, R, B, B, R]   4   1
// [B, B, W, R, R, R, B, R]   5   2     2 act
// [B, B, B, W, R, R, R, R]   6   3     2 act



// Partir du principe de taille 3

// Soit i, nextB, nextW tq
// (tab[0 : nextB [ == "B") && (tab[nextB : nextW [ == "W") && (tab[nextW :: [ == "R")

// (tab[0 : i [ == "B")
// ||
// (tab[0 : nextB [ == "B") && (tab[nextB : i [ == "W")
// ||
// (tab[0 : nextB [ == "B") && (tab[nextB : nextW [ == "W") && (tab[nextW : i [ == "R")


func ex3 (tab : inout [Character]) {
    var nextB = 0
    var nextW = 0
    var upB : Bool

    for i in 0..<tab.count {
        upB = false

        if tab[i] == "B" {      // On inverse les valeurs de tab[i] et tab[nextB]. Incrément nextB.
            tab[i] = tab[nextB]
            tab[nextB] = "B"
            nextB += 1
            upB = true
        }

        if (tab[i] == "W") {    // On inverse les valeurs de tab[i] et tab[nextW]. Incrément nextW.
            tab[i] = tab[nextW]
            tab[nextW] = "W"
            nextW += 1
        }
        else if upB {   // Si on avait un B et qu'on l'a échangé avec la valeur à nextB
            nextW += 1
        }
    }
//    print(tab)
}


// var tab2 : [Character] = ["B"]

//var tab2 : [Character] = ["B", "B", "W", "R", "R", "R", "W", "W", "W", "W", "B", "R", "R", "B", "B", "W", "W", "B", "R", "R", "R", "B", "B", "R", "B", "W"]
//
////var tab2 : [Character] = ["B", "B", "W", "W", "W", "W", "W", "B", "B", "B", "W", "W"]
//ex3(tab: &tab2)
//print(tab2)




func isEmpty(tab : [[Bool]], x1 : Int, y1 : Int, x2 : Int, y2 : Int) -> Bool {
    var i = x1
    var j = y1


    // Inv !tab[i][j]
    while i <= x2 {
        j = y1
        while j <= y2 {
            if (tab[i][j]) {    // Sortie : tab[i][j]
                return false
            }
            print(i, " : ", j)
            j += 1
        }
        i += 1
    }
    // Sortie : Pour tout i et j (du rectangle), !tab[i][j]
    return true
}


var mat : [[Bool]]
mat = [
    [false, false, false, false, false],
    [true,  false, false, false, true],
    [false, true,  false, false, false],
    [false, false, false, true, false],
    [true,  false, false, false, false],
    [false, false, false, false, false],
]

//print(isEmpty(tab: mat, x1: 0, y1: 2, x2: 4, y2: 3))




func ex4b (tab : [[Bool]], x1 : Int, y1 : Int) -> Int {
    guard !tab[x1][y1] else { return 0 }

    var surface : Int
    var maxSurface = 0

    for i in x1..<tab.count {
        for j in y1 ..< tab[0].count {
            print(i, " : ", j)
            if isEmpty(tab: tab, x1: x1, y1: y1, x2: i, y2: j) {
                surface = getSurface(x1: x1, y1: y1, x2: i, y2: j)
                maxSurface = maxSurface < surface ? surface : maxSurface
            }
        }
    }
    return maxSurface
}

func ex4bis (tab : [[Bool]], x1 : Int, y1 : Int) -> Int {
    guard !tab[x1][y1] else { return 0 }

    var surface : Int
    var maxSurface : Int = 0

    var iMax = tab.count
    var jMax = tab[0].count

    // Invar : tab[x1 : i[ [y1 : j[ == false
    for i in x1 ..< iMax {
        if (tab[i][y1]) {
            iMax = i
            continue
        }
        for j in y1 ..< jMax {
            if (tab[i][j]) {
                jMax = j
                continue
            }
            print(i, " : ", j)

            surface = getSurface(x1: x1, y1: y1, x2: i, y2: j)
            maxSurface = maxSurface < surface ? surface : maxSurface
        }
    }
    return maxSurface
}


// Retourne la surface du rectangle en param.
func getSurface (x1 : Int, y1 : Int, x2 : Int, y2 : Int) -> Int {
    (x2 - x1 + 1) * (y2 - y1 + 1)
}

//print(ex4bis(tab: mat, x1: 0, y1: 2))
