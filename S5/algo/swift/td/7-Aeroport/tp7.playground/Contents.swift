import Foundation
import CoreFoundation


// IndicatifAeroport est une collection de couple (indicatif, nom d'aéroport)
// Cette collection peut être parcourue par 2 itérateurs.
protocol IndicatifAeroportProtocol : Sequence{
    associatedtype ItAlphaIndic : IteratorProtocol
    associatedtype ItAlphaName : IteratorProtocol
    
    //associatedtype ItAlphaIndicProtocol: IteratorProtocol
    // init : -> IndicatifAeroport
    // création d'un IndicatifAeroport, initialisé avec différents aéroports
    init()
    
    // init : String -> (IndicatifAeroport | Vide)
    // création d'un IndicationAeroport à partir d'un fichier csv de données
    // Pre: String représente le nom d'un fichier existant
    //      sinon la création échoue
    init?(file: String)
    
    // save: IndicatifAeroport x String ->
    // sauvegarde les données de IndicatifAeroport dans un fichier au format csv
    // Pre : String représente le chemin vers un fichier
    //       sinon lève une erreur d'entrée-sortie
    func save(toFileName fileName: String) throws
    
    
    // aeroport : String -> (String | Vide)
    // retourne le nom de l'aéroport correspondant à l'indicatif passé en paramètre
    // Pre : String est un nom d'indicatif
    // Post : retour Vide si cet indicatif n'existe pas, sinon retour un String contenant le de l'aéroport
    func aeroport(indicatif: String) -> String?
    
    // changeName : IndicatifAeroport x String x String -> IndicatifAeroport
    // change le nom de l'aéroport qui a l'indicatif passé en paramètre
    // Pre : le premier paramètre est un indicatif connu
    // Pre : le second paramètre est une chaine de caractères correspondant au nouveau nom
    // Post : le nom est changé pour l'indicatif donné en paramètre ; si cet indicatif n'existe pas
    //        rien n'est fait.
    mutating func changeName(indicatif: String, name: String)
    
    // add: IndicatifAeroport x String x String -> IndicatifAeroport
    // ajoute un nouveau couple (indicatif, nom) à la collection
    // Pre : l'indicatif ne peut pas être une chaine vide ""
    // Pre : nom ne peut pas être une chaine vide ""
    // Pre : l'indicatif ne doit pas déjà exister dans la collection
    // Post : la collection avec le nouveau couple (indicatif, nom) si les preconditions ont été respectées, sinon, rien n'est changé.
    mutating func add(indicatif: String, name: String)
    
    // removeIndicatif : IndicatifAeroport x String -> IndicatifAeroport
    // Pre : indicatif est une chaîne non vide ""
    // Pre : indicatif est un indicatif existant dans la collection
    // Post : la collection de laquelle on a retiré le couple (indicatif, nom) correspondant à l'indicatif passé en paramètre si les preconditions ont été respectées, sinon rien n'est changé.
    @discardableResult
    mutating func remove(indicatif: String) -> Self
    
    // removeName : IndicatifAeroport : String -> IndicatifAeroport
    // Pre : indicatif est une chaîne non vide ""
    // Post : si la precondition est respectée et qu'un aéroport ayant ce nom existe dans la collection, le couple (indicatif, nom) correspondant est retiré de la collection, sinon rien n'est changé
    @discardableResult
    mutating func remove(name: String) -> Self
    
    // searchIndicatif : IndicatifAeroport x String -> (String | Vide)
    // cherche l'indicatif de l'aéroport qui a pour nom la chaîne passée en paramètre
    // Pre : name est une chaîne de caractère correspondant à un nom d'aéroport de la collection
    // Post : l'indicatif de l'aéroport si la precondition est respectée, sinon retourne Vide
    func searchIndicatif(name: String) -> String?
    
    // makeItAlphaIndic : IndicatifAeroport -> ItAlphaIndic
    // crée un itérateur sur la collection dans l'ordre alphabétique des indicateurs
    func makeItAlphaIndic() -> ItAlphaIndic
    
    // makeIterator : IndicatifAeroport -> ItAlphaIndic
    // crée un itérateur sur le collection pour itérer avec for in. L'itération se fait dans l'ordre alphabétique des indicateurs
    func makeIterator() -> ItAlphaIndic
    
    // makeItAlphaName : IndicatifAeroport -> ItAlphaName
    // crée un itérateur sur la collection pour la parcourir dans l'ordre alphabétique des noms d'aéroport
    func makeItAlphaName() -> ItAlphaName
    
}


struct IndicatifAeroport : IndicatifAeroportProtocol {
    
    // Dictionnaire de type [String : String], qui contient toutes les données tel que [indicatif : nom]
    fileprivate var dicoAeroport : [String : String]
    
    
    // init : -> IndicatifAeroport
    // création d'un IndicatifAeroport, initialisé avec différents aéroports
    init () {
        self.dicoAeroport = [
            "MPL" : "Montpellier",
            "DUB" : "Dublin",
            "CDG" : "Paris Charles-de-Gaule",
            "ORY" : "Paris Orly",
            "YYZ" : "Toronto",
            "LHR" : "London Heathrow",
            "LCY" : "London City",
            "LAX" : "Los Angeles"
        ]
    }
    
    // init : [String : String] -> IndicatifAeroport
    // création d'un IndicatifAeroport, initialisé avec le dictionnaire en paramètres.
    init (dicoAeroport : [String : String]) {
        self.dicoAeroport = dicoAeroport
    }
    
    // init : String -> (IndicatifAeroport | Vide)
    // création d'un IndicationAeroport à partir d'un fichier csv de données
    // Pre: String représente le nom d'un fichier existant
    //      sinon la création échoue
    init?(file: String){
        var fileString : String
        do{
//          Si file est le nom d'un fichier
//          let path = FileManager.default.currentDirectoryPath
//          let url = URL(fileURLWithPath: path).appendingPathComponent(file + ".csv")
            
            let url = URL(fileURLWithPath : file)   // Si file est un chemin absolu.
            
            try fileString = String(contentsOf : url, encoding : .utf8)
        }
        catch{
            fatalError("Erreur lors de la lecture du fichier. ")
        }
        
        guard (!fileString.isEmpty) else { return nil }
        
        self.dicoAeroport = [ : ]
        // Fichier du style :
            // indicatif, nom
            // indicatif2, nom2 ...
        let listLines = fileString.components(separatedBy : "\n")
        for i in listLines {
            if i.count < 0 {
                self.dicoAeroport[ i.components(separatedBy : ",")[0] ] = i.components(separatedBy : ",")[1]
            }
        }
    }
    
    // save : IndicatifAeroport x String ->
    // sauvegarde les données de IndicatifAeroport dans un fichier au format csv
    // Pre : String représente le chemin vers un fichier
    //       sinon lève une erreur d'entrée-sortie
    func save(toFileName fileName: String) throws {
//        let path = FileManager.default.currentDirectoryPath
//        let url = URL(fileURLWithPath: path).appendingPathComponent(fileName)
        
        let url = URL(fileURLWithPath: fileName)
        
        do {
            try self.dicoAeroport.description.write(to: url, atomically: false, encoding: .utf8)
        }
        catch {
            fatalError("Erreur dans le nom du fichier. ")
        }
    }
    
    // aeroport : String -> (String | Vide)
    // retourne le nom de l'aéroport correspondant à l'indicatif passé en paramètre
    // Pre : String est un nom d'indicatif
    // Post : retour Vide si cet indicatif n'existe pas, sinon retour un String contenant le de l'aéroport
    func aeroport(indicatif: String) -> String? {
        return self.dicoAeroport[indicatif]
    }
    
    // changeName : IndicatifAeroport x String x String -> IndicatifAeroport
    // change le nom de l'aéroport qui a l'indicatif passé en paramètre
    // Pre : le premier paramètre est un indicatif connu (Avec une taille de trois caractères.)
    // Pre : le second paramètre est une chaine de caractères correspondant au nouveau nom
    // Post : le nom est changé pour l'indicatif donné en paramètre ; si cet indicatif n'existe pas
    //        rien n'est fait.
    mutating func changeName(indicatif: String, name: String) {
        if (aeroport(indicatif: indicatif) != nil) {
            self.dicoAeroport[indicatif] = name
        }
    }
    
    // add: IndicatifAeroport x String x String -> IndicatifAeroport
    // ajoute un nouveau couple (indicatif, nom) à la collection
    // Pre : l'indicatif ne peut pas être une chaine vide ""
    // Pre : nom ne peut pas être une chaine vide ""
    // Pre : l'indicatif ne doit pas déjà exister dans la collection
    // Post : la collection avec le nouveau couple (indicatif, nom) si les preconditions ont été respectées, sinon, rien n'est changé.
    mutating func add(indicatif: String, name: String) {
        if (!indicatif.isEmpty && !name.isEmpty && self.aeroport(indicatif: indicatif) == nil) {
            self.dicoAeroport[indicatif] = name
        }
    }
    
    
    // removeIndicatif : IndicatifAeroport x String -> IndicatifAeroport
    // Pre : indicatif est une chaîne non vide ""
    // Pre : indicatif est un indicatif existant dans la collection
    // Post : la collection de laquelle on a retiré le couple (indicatif, nom) correspondant à l'indicatif passé en paramètre si les preconditions ont été respectées, sinon rien n'est changé.
    @discardableResult
    mutating func remove(indicatif: String) -> Self {
        self.dicoAeroport.removeValue(forKey: indicatif)
        return self
    }
    
    
    // removeName : IndicatifAeroport : String -> IndicatifAeroport
    // Pre : indicatif est une chaîne non vide ""
    // Post : si la precondition est respectée et qu'un aéroport ayant ce nom existe dans la collection, le couple (indicatif, nom) correspondant est retiré de la collection, sinon rien n'est changé
    @discardableResult
    mutating func remove(name: String) -> Self {
        if let indicatif = self.searchIndicatif(name: name) {
            self.remove(indicatif: indicatif)
        }
        return self
    }
    
    // searchIndicatif : IndicatifAeroport x String -> (String | Vide)
    // cherche l'indicatif de l'aéroport qui a pour nom la chaîne passée en paramètre
    // Pre : name est une chaîne de caractère correspondant à un nom d'aéroport de la collection
    // Post : l'indicatif de l'aéroport si la precondition est respectée, sinon retourne Vide
    func searchIndicatif(name: String) -> String? {
        guard (!name.isEmpty) else { return nil}
        
        // Faux for qui peut retourner en cours de boucle.
        for (key, value) in self.dicoAeroport {
            if name == value {
                return key
            }
        }
        // Faux for qui peut retourner en cours de boucle.
        return nil
    }
    
    // makeItAlphaIndic : IndicatifAeroport -> ItAlphaIndic
    // crée un itérateur sur la collection dans l'ordre alphabétique des indicateurs
    func makeItAlphaIndic() -> ItAlphaIndic {
        return ItAlphaIndic(indicatifAeroport: self)
    }
    
    // makeIterator : IndicatifAeroport -> ItAlphaIndic
    // crée un itérateur sur la collection pour itérer avec for in. L'itération se fait dans l'ordre alphabétique des indicateurs
    func makeIterator() -> ItAlphaIndic {
        return ItAlphaIndic(indicatifAeroport: self)
    }
    
    // makeItAlphaName : IndicatifAeroport -> ItAlphaName
    // crée un itérateur sur la collection pour la parcourir dans l'ordre alphabétique des noms d'aéroport
    func makeItAlphaName() -> ItAlphaName {
        return ItAlphaName(indicatifAeroport: self)
    }
}


struct ItAlphaIndic : IteratorProtocol {
    
    private var indicatif : [String]    // Contient tous des indicatifs ordonnés dans l'ordre alphabétique.
    private var currentIndex : Int      // Valeur de l'indice courant. Incrémenté dans next().
    
    // init : IndicatifAeroport -> ItAlphaIndic
    // crée un itérateur sur la collection en paramètre, dans l'ordre alphabétique des indicateurs.
    fileprivate init (indicatifAeroport : IndicatifAeroport) {
        self.indicatif = indicatifAeroport.dicoAeroport.keys.sorted(by: <)
        self.currentIndex = 0
    }
    
    // next -> String?
    // Retourne indicatif[currentIndex] puis incrémente currentIndex, s'il existe, sinon nil.
    mutating func next () -> String? {
        guard (self.currentIndex < self.indicatif.count) else { return nil }
        
        self.currentIndex += 1
        return self.indicatif[self.currentIndex - 1]
    }
}


struct ItAlphaName : IteratorProtocol {
    private var name : [String]
    private var currentIndex : Int
    
    // init : IndicatifAeroport -> ItAlphaIndic
    // crée un itérateur sur la collection en paramètre, dans l'ordre alphabétique des noms.
    fileprivate init (indicatifAeroport : IndicatifAeroport) {
        // Check dico pas vide
        self.name = indicatifAeroport.dicoAeroport.values.sorted(by: <)
        self.currentIndex = 0
    }
    
    // next -> String?
    // Retourne indicatif[currentIndex] puis incrémente currentIndex, s'il existe, sinon nil.
    mutating func next () -> String? {
        guard (self.currentIndex < self.name.count) else { return nil }
        
        self.currentIndex += 1
        return self.name[self.currentIndex - 1]
    }
}




// Fonction qui test les foncitons de IndicatifAeroport.
func test () {
    let dico = [
        "MPL" : "Montpellier",
        "LDN" : "London"
    ]
    
    var indicatifAeroport = IndicatifAeroport(dicoAeroport: dico)
    print (dico)
    
    do {
        let filePath = "/Users/tom/Documents/partageGit/coursPolytech/S5/algo/swift/td/7-Aeroport/test.csv"
        try indicatifAeroport.save(toFileName: filePath)
    }
    catch {
        fatalError()
    }

    
    assert(indicatifAeroport.aeroport(indicatif : "MPL") != nil)
    assert(indicatifAeroport.aeroport(indicatif : "MPL") == "Montpellier")
    assert(indicatifAeroport.aeroport(indicatif: "AAA") == nil)
    print("test aeroport passed. ")
    
    indicatifAeroport.changeName(indicatif: "AAA", name: "Aaaaaaaa")
    assert(indicatifAeroport.aeroport(indicatif: "AAA") == nil)
    indicatifAeroport.changeName(indicatif: "MPL", name: "Mulhouse")
    assert(indicatifAeroport.aeroport(indicatif: "MPL") == "Mulhouse")
    indicatifAeroport.changeName(indicatif: "MPL", name: "Montpellier")
    assert(indicatifAeroport.aeroport(indicatif: "MPL") == "Montpellier")
    print("test changeName passed. ")
    
    indicatifAeroport.add(indicatif: "NEW", name: "New Airport")
    assert(indicatifAeroport.aeroport(indicatif: "NEW") != nil)
    assert(indicatifAeroport.aeroport(indicatif: "NEW") == "New Airport")
    indicatifAeroport.add(indicatif: "MPL", name: "Mulhouse")
    assert(indicatifAeroport.aeroport(indicatif: "MPL") == "Montpellier")
    indicatifAeroport.add(indicatif: "", name: "Mulhouse")
    assert(indicatifAeroport.aeroport(indicatif: "") == nil)
    indicatifAeroport.add(indicatif: "AAA", name: "")
    assert(indicatifAeroport.aeroport(indicatif: "AAA") == nil)
    print("test add passed. ")
    
    indicatifAeroport.remove(indicatif: "NEW")
    assert(indicatifAeroport.aeroport(indicatif: "NEW") == nil)
    indicatifAeroport.remove(indicatif: "NEW")
    assert(indicatifAeroport.aeroport(indicatif: "NEW") == nil)
    indicatifAeroport.remove(indicatif: "")
    assert(indicatifAeroport.aeroport(indicatif: "") == nil)
    print("test remove by indicatif passed. ")
    
    indicatifAeroport.add(indicatif: "ABC", name: "Abc City")
    assert(indicatifAeroport.aeroport(indicatif: "ABC") != nil)
    indicatifAeroport.remove(name: "Abc City")
    assert(indicatifAeroport.aeroport(indicatif: "ABC") == nil)
    indicatifAeroport.remove(name: "Abc City")
    assert(indicatifAeroport.aeroport(indicatif: "ABC") == nil)
    print("test remove by name passed. ")
    
    assert(indicatifAeroport.searchIndicatif(name: "Montpellier") == "MPL")
    assert(indicatifAeroport.searchIndicatif(name: "Aaaaaaa") == nil)
    assert(indicatifAeroport.searchIndicatif(name: "") == nil)
    print("test searchIndicatif passed. ")
    
    var iteratorIndic = indicatifAeroport.makeItAlphaIndic()
    assert(iteratorIndic.next() == "LDN")
    assert(iteratorIndic.next() == "MPL")
    assert(iteratorIndic.next() == nil)
    print("test makeItAlphaIndic passed. ")
    
    var iteratorName = indicatifAeroport.makeItAlphaName()
    assert(iteratorName.next() == "London")
    assert(iteratorName.next() == "Montpellier")
    assert(iteratorName.next() == nil)
    print("test makeItAlphaName passed. ")
    
    indicatifAeroport.remove(indicatif: "MPL")
    indicatifAeroport.remove(indicatif: "LDN")
    var emptyIteratorIndic = indicatifAeroport.makeItAlphaIndic()
    assert(emptyIteratorIndic.next() == nil)
    print("test makeItAlphaIndic empty values passed. ")
}

test()
