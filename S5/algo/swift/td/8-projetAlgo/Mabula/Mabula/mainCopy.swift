//////
//////  main.swift
//////  Mabula
//////
//////  Created by Tom Sartori on 12/2/21.
//////
//////
////
////import Foundation
////
////var mabula = Mabula(isMultiScore: true)
////print(mabula)
////mabula.move(x: 7, y: 3, v: 5)
////print(mabula)
////mabula.move(x: 0, y: 3, v: 3)
////print(mabula)
//////mabula.move(x: 1, y: 7, v: 2)
//////print(mabula)
//////print(mabula.getNumberEmptyCases(x: 1, y: 7))
////
////
//////print(mabula.isPlayerOneWin())
////
//////assert(mabula.isEmpty(x: 1, y: 1))
//////assert(mabula.getNumberEmptyCases(x: 0, y: 2) == 6) // Direction verticale basse.
//////assert(mabula.getNumberEmptyCases(x: 7, y: 5) == 6) // Direction verticale haute.
//////assert(mabula.getNumberEmptyCases(x: 1, y: 0) == 6) // Direction horizontale droite.
//////assert(mabula.getNumberEmptyCases(x: 6, y: 7) == 6) // Direction horizontale gauche
//////
//////assert(mabula.getNumberEmptyCases(x1: 1, y1: 0, x2: 1, y2: 3) == 3)
//////assert(mabula.getNumberEmptyCases(x1: 1, y1: 0, x2: 1, y2: 3) == mabula.getNumberEmptyCases(x1: 1, y1: 3, x2: 1, y2: 0))
//
//
//
//func savoirJoueur(jeu: Mabula) -> Int
//{
//    if jeu.isPlayerOneToPlay()
//    {
//        return 1
//    }
//    return 2
//}
//
///// - Todo: Fonctionne pas readline avec juste var.
////var choixCalculPoints = readLine("Voulez-vous compter les points en multipliant les tailles de groupe? y/n")
//var choixCalculPoints = "y"
//
//// Début de la partie de Mabula
//print("La partie commence, le joueur 1 a les billes blanches et le joueur 2 a les billes noires")
//
///// - Todo: Changed from PTMabula for Mabuma
//var jeu = Mabula(decompteParLesLongueursMax: choixCalculPoints == "y")
//
///// - Todo: Refactor pour isPlayerOneCanPlay()
//while jeu.isPlayerOneCanPlay() || jeu.isPlayerTwoCanPlay() {
//    var numJoueurActuel = savoirJoueur(jeu: jeu)
//    print("Au tour de joueur : ", numJoueurActuel)
//    var x = 0
//    var y = 0
//
//    for i in jeu {
//        print(i)
//    }
//
//    while !jeu.isBilleCaseAppartient(x : x, y: y) {
//        /// - Todo: ReadLnie fonctionne pas juste en var comme ca.
////        var x = Int(readLine("Entrer le numéro de la ligne de votre bille"))
////        var y = Int(readLine("Entrer le numéro de la colonne de votre bille"))
////        var v = Int(readLine("Entrer le nombre de combien de case vous voulez avancer la bille"))
//    }
//
//    /// - Todo: need v initialised
//    var v: Int = 0
//    if jeu.deplacer(x : x, y: y, v: v)
//    {
//        jeu.switchPlayer()
//        if jeu.isPlayerOneToPlay() // Si c'est au joueur 1 de jouer
//        {
//            /// - Todo: Refactor pour isPlayerOneCanPlay()
//            if !jeu.isPlayerOneCanPlay() // On vérifie s'il peut jouer, s'il ne peut pas on change de joueur
//            {
//                jeu.switchPlayer()
//            }
//        }
//        else // Si c'est pas au joueur 1 de jouer
//        {
//            if !jeu.isPlayerTwoCanPlay()  // On vérifie si le joueur 2 peut jouer, s'il ne peut pas on change de joueur
//            {
//                jeu.switchPlayer()
//            }
//        }
//    }
//    else
//    {
//        print("Le coup n'est pas valide, merci d'en choisir un autre")
//    }
//}
//
//if jeu.isPlayerOneWin() == nil
//{
//    print("La partie est finie il n'y a pas de gagnant. Egalité")
//}
///// - Todo: Fonctionne par car renvoie Bool?
//else if jeu.isPlayerOneWin() == true
//{
//    print("La partie est finie le gagnant est le joueur : 1")
//}
//else
//{
//    print("La partie est finie le gagnant est le joueur : 2")
//}
//
//
