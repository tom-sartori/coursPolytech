//
// Created by Tom Sartori on 12/10/21.
//

import Foundation

class TListeEntierNode : CustomStringConvertible {

    public var previous: TListeEntierNode!
    public var value: Int
    public var next: TListeEntierNode!

    init(previous: TListeEntierNode?, value: Int, next: TListeEntierNode?) {
        self.previous = previous
        self.value = value
        self.next = next
    }

    var description: String {
        var sh: String = ""
//        sh += "previous : " + previous.description
        sh += " | value : " + value.description
//        sh += " | next : " + next.description

        return sh
    }
}
