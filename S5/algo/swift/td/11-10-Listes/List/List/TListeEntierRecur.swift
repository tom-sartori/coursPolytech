////
//// Created by Tom Sartori on 12/10/21.
////
//
//import Foundation
//
//class TListeEntierRecur : CustomStringConvertible {
//
//    public var list: TListeEntierNode?
//
//    init(list: TListeEntierNode? = nil) {
//        self.list = list
//    }
//
//
//    func insertFirst(value: Int) -> TListeEntierRecur {
////        let first: TListeEntierNode = TListeEntierNode(previous: TListeEntierRecur(list: nil), value: value, next: TListeEntierRecur(list: self))
//        let first: TListeEntierRecur = TListeEntierRecur(list: TListeEntierNode(previous: TListeEntierRecur(list: nil), value: value, next: TListeEntierRecur(list: nil)))
//
//        if self.list != nil {
//            print("self.list != nil")
//            first.list?.next = self
//            self.list?.previous = first
//        }
//        return first
//    }
//
//    var description: String {
//        return list.debugDescription
//    }
//}
