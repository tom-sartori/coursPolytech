import Foundation

protocol PieceProtocol : CustomStringConvertible {
    // Correspond à une enumération des couleurs que peut prendre une pièce.
    //
    // color : PieceProtocol -> EnumColor
    var color : EnumColor { get }

    // Correspond à une énumération des tailles que peut prendre une pièce.
    //
    // size : PieceProtocol -> EnumSize
    var size : EnumSize { get }

    // Correspond à une énumération indiquant si la pièce est pleine ou creuse.
    //
    // content : PieceProtocol -> EnumContent
    var content : EnumContent { get }

    // Correspond à une énumération indiquant la taille d'une pièce.
    //
    // shape : PieceProtocol -> EnumShape
    var shape: EnumShape { get }

    // Retourne vrai si la pièce est utilisée sur le plateau sinon faux.
    //
    // isUsed : PieceProtocol -> Bool
    func isUsed () -> Bool

    // Utilise la pièce.
    //
    // use : PieceProtocol
    //
    // piece.use() <=> piece.isUsed() == true
    mutating func use()

    // Dé utilise la pièce.
    //
    // unUse : PieceProtocol
    //
    // piece.unUse() <=> piece.isUsed() == false
    mutating func unUse()

    // Création d'une pièce et ses caractéristiques.
    //
    // init -> PieceProtocol
    init (color : EnumColor, size : EnumSize, content : EnumContent, shape : EnumShape)
}

// Enumération des différentes couleurs que peut prendre une pièce.
enum EnumColor : CustomStringConvertible {
    case clear
    case dark

    var description: String {
        switch self {
        case .clear : return "C"
        case .dark : return "D"
        }
    }
}

// Enumération des différentes tailles que peut prendre une pièce
enum EnumSize : CustomStringConvertible {
    case small
    case big

    var description: String {
        switch self {
        case .small : return "S"
        case .big : return "B"
        }
    }
}

// Enumération des différentes formes que peut prendre une pièce
enum EnumShape : CustomStringConvertible {
    case square
    case circle

    var description: String {
        switch self {
        case .square : return "S"
        case .circle : return "C"
        }
    }
}

// Indique si une pièce est pleine ou creuse
enum EnumContent : CustomStringConvertible {
    case full
    case empty

    var description: String {
        switch self {
        case .full : return "F"
        case .empty : return "E"
        }
    }
}
