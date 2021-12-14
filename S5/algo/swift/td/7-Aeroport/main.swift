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
