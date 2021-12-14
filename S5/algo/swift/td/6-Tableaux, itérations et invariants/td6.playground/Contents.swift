import UIKit
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


let tab = [1, -3, 3, 7]
//print(sommeMax(tab: tab))




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

func ex3 (tab : inout [Character]) {
    // Check taille > 3

    var nextB = 0
    var nextW = 0
    var upB : Bool
    var upW : Bool

    print("Start : ", tab)
    print("")

    for i in 0..<tab.count {
        print("i : ", i , " | nextB : ", nextB, " | nextW : ", nextW)
        upB = false
        upW = false

        if tab[i] == "B" {      // On inverse les valeurs de tab[i] et tab[nextB]. Incrément nextB.
            tab[i] = tab[nextB]
            tab[nextB] = "B"
            nextB += 1
            upB = true
            print("B : ", tab)
            print("nextB : ", nextB, " | nextW : ", nextW)
        }

        if (tab[i] == "W") {    // On inverse les valeurs de tab[i] et tab[nextW]. Incrément nextW.
            tab[i] = tab[nextW]
            tab[nextW] = "W"
            nextW += 1
            upW = true
            print("")
            print("W : ", tab)
            print("nextB : ", nextB, " | nextW : ", nextW)
        }

        if (upB && !upW) {
            nextW += 1
        }


        print("")
        print("")
    }
    print("fin : ", tab)
}

var tab2 : [Character] = ["B", "W"]

//var tab2 : [Character] = ["B", "B", "W", "R", "R", "R", "W", "W", "W", "W", "B", "R", "R", "B", "B", "W", "W", "B", "R", "R", "R", "B", "B", "R", "B", "W"]
ex3(tab: &tab2)

// Check aucun R
