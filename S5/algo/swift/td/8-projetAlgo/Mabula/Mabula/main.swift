//
//  main.swift
//  Mabula
//
//  Created by Tom Sartori on 12/2/21.
//
//

import Foundation


func run() {
    // Début de la partie de Mabula
    print("La partie commence, le joueur 1️⃣ a les billes blanches et le joueur 2️⃣ a les billes noires")

    var jeu: Mabula = Mabula(decompteParLesLongueursMax: !askIsMultiScore())
    print(jeu)
    jeu.play(n: 23)

    while jeu.isPlayerOneCanPlay() || jeu.isPlayerTwoCanPlay() {
        print("C'est au joueur ", jeu.isPlayerOneToPlay() ? "1️⃣" : "2️⃣", " de joueur. ")
        let deplacement: (x: Int, y: Int, v: Int) = askPosition(jeu: &jeu)

        if jeu.deplacer(x : deplacement.x, y: deplacement.y, v: deplacement.v) {
            jeu.switchPlayer()

            if jeu.isPlayerOneToPlay() && !jeu.isPlayerOneCanPlay() { // Si c'est au joueur 1 de jouer
                jeu.switchPlayer()
            }
            else if !jeu.isPlayerOneToPlay() && !jeu.isPlayerTwoCanPlay() {
                jeu.switchPlayer()
            }
        }
        else {
            print("Le coup n'est pas valide, merci d'en choisir un autre")
        }
    }

    if jeu.isPlayerOneWin() == nil {
        print("La partie est finie il n'y a pas de gagnant. Egalité")
    }
    else if jeu.isPlayerOneWin() == true {
        print("La partie est finie le gagnant est le joueur : 1️⃣")
    }
    else {
        print("La partie est finie le gagnant est le joueur : 2️⃣")
    }
}

func askIsMultiScore () -> Bool {
    print("Voulez-vous compter les points en multipliant les tailles de groupe? y/n")

    if let text = readLine() {
        return text == "y"
    }
    fatalError()
}

func askPosition (jeu: inout Mabula) -> (x: Int, y: Int, v: Int) {
    print(jeu)
    while true {
        print("Entrez le numéro de la ligne de votre bille : ")
        if let text = readLine(), let x = Int(text) {
            print("Entrer le numéro de la colonne de votre bille")
            if let text = readLine(), let y = Int(text) {
                print("Entrer le nombre de combien de case vous voulez avancer la bille")
                if let text = readLine(), let v = Int(text) {
                    if jeu.isBilleCaseAppartient(x: x, y: y) {
                        /// - Todo: Check v correct.
                        return (x: x, y: y, v: v)
                    } else {
                        print("Positions invalides. ")
                    }
                }
            }
        }
    }
}


run()
