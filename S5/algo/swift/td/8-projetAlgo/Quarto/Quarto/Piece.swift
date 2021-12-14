import Foundation

struct Piece: PieceProtocol {
    var color : EnumColor
    var size : EnumSize
    var content : EnumContent
    var shape: EnumShape
    var used: Bool

    init (color : EnumColor, size : EnumSize, content : EnumContent, shape : EnumShape) {
        self.color = color
        self.size = size
        self.content = content
        self.shape = shape
        used = false
    }

    func isUsed() -> Bool {
        return used
    }

     mutating func use() {
        used = true
    }

    mutating func unUse() {
        used = false
    }

    var description: String {
        var s : String
        s = "(\(self.color):\(self.size):\(self.content):\(self.shape))"

        if self.color == EnumColor.clear && self.size == EnumSize.small && self.content == EnumContent.full && self.shape == EnumShape.square { return "▫️" }
        if self.color == EnumColor.clear && self.size == EnumSize.small && self.content == EnumContent.full && self.shape == EnumShape.circle { return "●" }
        if self.color == EnumColor.clear && self.size == EnumSize.small && self.content == EnumContent.empty && self.shape == EnumShape.square { return "▫" }//□
        if self.color == EnumColor.clear && self.size == EnumSize.small && self.content == EnumContent.empty && self.shape == EnumShape.circle { return "◦" }//○

        if self.color == EnumColor.clear && self.size == EnumSize.big && self.content == EnumContent.full && self.shape == EnumShape.square { return "⬜" }
        if self.color == EnumColor.clear && self.size == EnumSize.big && self.content == EnumContent.full && self.shape == EnumShape.circle { return "⚪" }
        if self.color == EnumColor.clear && self.size == EnumSize.big && self.content == EnumContent.empty && self.shape == EnumShape.square { return "🔳" }
        if self.color == EnumColor.clear && self.size == EnumSize.big && self.content == EnumContent.empty && self.shape == EnumShape.circle { return "◯" }

        if self.color == EnumColor.dark && self.size == EnumSize.small && self.content == EnumContent.full && self.shape == EnumShape.square { return "▪️" }
        if self.color == EnumColor.dark && self.size == EnumSize.small && self.content == EnumContent.full && self.shape == EnumShape.circle { return "🌚" }
        if self.color == EnumColor.dark && self.size == EnumSize.small && self.content == EnumContent.empty && self.shape == EnumShape.square { return "➕️" }
        if self.color == EnumColor.dark && self.size == EnumSize.small && self.content == EnumContent.empty && self.shape == EnumShape.circle { return "➰" }

        if self.color == EnumColor.dark && self.size == EnumSize.big && self.content == EnumContent.full && self.shape == EnumShape.square { return "⬛" }
        if self.color == EnumColor.dark && self.size == EnumSize.big && self.content == EnumContent.full && self.shape == EnumShape.circle { return "⚫" }
        if self.color == EnumColor.dark && self.size == EnumSize.big && self.content == EnumContent.empty && self.shape == EnumShape.square { return "🔲" }
        if self.color == EnumColor.dark && self.size == EnumSize.big && self.content == EnumContent.empty && self.shape == EnumShape.circle { return "🔘" }

        return s
    }
}
