
// Retourne vrai si x est premier. 
func isPrime (x : Int) -> Bool {
    if (x <= 1) {
        return false
    }
    for i in 2..<x {
        if x % i == 0 {
            return false
        }
    }
    return true
}


// Ex2
func askIsPrime () {
    if let rep = readLine() {
        if let repInt = Int(rep) {
            print(isPrime(x: repInt))
        }
    }
}



// 3 Entrée/sortie de fichiers texte

import Foundation

func testInOut () {
    //let path = FileManager.default.currentDirectoryPath + "/test.txt"
    //let url = URL(fileURLWithPath: path)
    // ou
    let path = FileManager.default.currentDirectoryPath
    let url = URL(fileURLWithPath: path).appendingPathComponent("test.txt")


    let text = "Hello world"
    try text.write(to: url, atomically: false, encoding: .utf8)

    //try var a = String(contentsOf: url, encoding: .utf8)
}



// 4 Dictionnaires d’indicatifs d’aéroport

// Ex3

struct IndicatifAeroport {
    var dicoAeroports : [String : String]
    
    init (indicatif : String, ville : String) {
        self.dicoAeroports[indicatif] = ville
    }
}

let indicatif = IndicatifAeroport(indicatif: "MPL", ville: "Montpellier")

print(indicatif)
