//
// Created by Tom Sartori on 12/12/21.
//

import Foundation

struct TListEntier : CustomStringConvertible {

    private class ListNode {
        public var previous: ListNode!
        public var value: Int
        public var next: ListNode!

        public init () {
            previous = nil
            value = 0
            next = nil
        }

        public init (previous: ListNode, value: Int, next: ListNode) {
            self.previous = previous
            self.value = value
            self.next = next
        }

        public func insertFirst (value: Int) {
            let firstNode: ListNode = ListNode(previous: self, value: value, next: self.next)
            self.next.previous = firstNode
            self.next = firstNode
        }
    }

    var head: TListeEntierNode
    var count: Int { head.value }

    public init() {
        head = TListeEntierNode(previous: nil, value: 0, next: nil)
        head.previous = head
        head.next = head
    }

    public func isEmpty() -> Bool {
        return count == 0
    }

    public mutating func insertFirst (value: Int) {
        let first: TListeEntierNode = TListeEntierNode(previous: head, value: value, next: head.next)
        head.value += 1
        head.next.previous = first
        head.next = first
    }

    public mutating func insertLast (value: Int) {
        let last: TListeEntierNode = TListeEntierNode(previous: head.previous, value: value, next: head)
        head.value += 1
        head.previous.next = last
        head.previous = last
    }

    public func makeIterator () -> ItListeEntier {
        return ItListeEntier(self)
    }

    var description: String {
        var sh: String = ""

        sh += "Size : \(self.count) | "
        sh += "head : \(self.head.value) | "

        var courant = head.next
        while courant !== head {
            sh += "next : \(courant?.value) | "
            courant = courant?.next
        }

        return sh
    }
}

struct ItListeEntier: Sequence, IteratorProtocol {
    internal var list: TListEntier
    private var current: TListeEntierNode
    // fin de parcours -> Bool
    // reinit

    fileprivate init (_ list: TListEntier) {
        self.list = list
        if (self.list.head.next != nil) {
            current = self.list.head.next
        }
        current = list.head
    }

     public mutating func next () -> TListeEntierNode? {
        guard current.next !== list.head else { return nil }

        current = current.next
        return current.previous
    }

    public mutating func previous () -> TListeEntierNode? {
        guard current.previous !== list.head else { return nil }

        current = current.previous
        return current.next
    }

    public func isLast () -> Bool {
        current.next === list.head
    }

    public func isFirst () -> Bool {
        current.previous === list.head
    }

    public mutating func changeValue (value: Int) -> Int {
        let oldValue: Int = current.value
        current.value = value
        return oldValue
    }
}
