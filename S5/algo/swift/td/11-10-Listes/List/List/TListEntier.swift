//
// Created by Tom Sartori on 12/12/21.
//

import Foundation

struct TListEntier {

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
}
