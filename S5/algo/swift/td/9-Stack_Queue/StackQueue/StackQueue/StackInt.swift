//
// Created by Tom Sartori on 11/26/21.
//

import Foundation

struct StackInt : StackIntProtocol {

    /**
      - Current number of elements in the stack.

      - count: StackT -> Int

      - count(init(n)) == 0
      - count(push(p, t)) == count(p)+1
      */
    var count : Int


    /**
     - capacity: StackT -> Int

     - isFull(p) ⟺ count(p) == capacity(p)

     - capacity(init(n)) == n

     - Returns: Int -> the max number of elements that can be added to the stack.
     */
    var capacity : Int

    /**
     - Store the elements of the stack.

     - tab : StackInt -> [Int]
     */
    private var tab : [Int]

    /**
     - Create an empty stack.

     - init: Int → StackT

     - Parameter capacity: Int
     */
    init (capacity : Int) {
        self.capacity = capacity
        count = 0
        tab = [Int](repeating: 0, count: capacity)
    }


    /**
     - top: StackT → T | Vide
     - top(push(p,t))==t
     - top(p)==Vide ⟺ isEmpty(p)

     - Returns: Int? -> The last element added to the stack.
     */
    func top () -> Int? {
        return isEmpty() ? nil : tab[count - 1]
    }


    /**
     - Delete and return the last element added to the stack.

     - pop: StackT -> StackT x T

     - (p2, t2) = pop(push(p1,t1)) ⟺ ( p2==p1) && (t2==t1)
     - (p2, t) = pop(t1) ⇒ count(p2) == count(p1) - 1
      - pop(p) => !isEmpty(p)

     - Returns: Int -> the value of the last element added to the stack.
     */
    mutating func pop () -> Int {
        guard !isEmpty() else { fatalError("mutating func pop () -> Int") }
        count -= 1
        return tab[count]
    }


    /**
     - Add an element to the stack.

     - push: StackT x T -> StackT

     - (p2, t)=pop(p1) ⇒ push(p2, t) == p1

     - Parameter x: Int -> the value of the element to add to the stack.
     */
    mutating func push (x : Int) {
        guard !isFull() else { fatalError("mutating func push (x : Int)") }
        tab[count] = x
        count += 1
    }


    /**
     - Check if the stack is empty.

     - isEmpty: StackT -> Bool

     - isEmpty(init(n)) == true
     - isEmpty(p) ⟺ count(p) == 0

     - Returns: Bool -> true if count == 0
     */
    func isEmpty () -> Bool {
        return count == 0
    }


    /**
     - Check if the stack is full.

     - isFull: StackT -> Bool

     - isFull(p) ⟺ count(p) == capacity(p)
     - push(p, t) ⇒ !isFull(p)

     - Returns: Bool -> true if count == capacity
     */
    func isFull () -> Bool {
        return count == capacity
    }
}
