//
// Created by Tom Sartori on 11/26/21.
//

import Foundation

protocol StackIntProtocol {

    /**
     - Current number of elements in the stack.

     - count: StackT -> Int

     - count(init(n)) == 0
     - count(push(p, t)) == count(p)+1
     */
    var count : Int { get }


    /**
     - capacity: StackT -> Int

     - isFull(p) ⟺ count(p) == capacity(p)

     - capacity(init(n)) == n

     - Returns: Int -> the max number of elements that can be added to the stack.
     */
    var capacity : Int { get }


    /**
     - Create an empty stack.

     - init: Int → StackT

     - Parameter capacity: Int
     */
    init (capacity : Int)


    /**
     - top: StackT → T | Vide
     - top(push(p,t))==t
     - top(p)==Vide ⟺ isEmpty(p)

     - Returns: Int? -> The last element added to the stack.
     */
    func top () -> Int?


    /**
     - Delete and return the last element added to the stack.

     - pop: StackT -> StackT x T

     - (p2, t2)=pop(push(p1,t1)) ⟺ ( p2==p1) && (t2==t1)
     - (p2, t) = pop(t1) ⇒ count(p2) == count(p1) - 1 S9: pop(p) => !isEmpty(p)

     - Returns: Int -> the value of the last element added to the stack.
     */
    mutating func pop () -> Int


    /**
     - Add an element to the stack.

     - push: StackT x T -> StackT

     - (p2, t)=pop(p1) ⇒ push(p2, t) == p1

     - Parameter x: Int -> the value of the element to add to the stack.
     */
    mutating func push (x : Int)


    /**
     - Check if the stack is empty.

     - isEmpty: StackT -> Bool

     - isEmpty(init(n)) == true
     - isEmpty(p) ⟺ count(p) == 0

     - Returns: Bool -> true if count == 0
     */
    func isEmpty () -> Bool


    /**
     - Check if the stack is full.

     - isFull: StackT -> Bool

     - isFull(p) ⟺ count(p) == capacity(p)
     - push(p, t) ⇒ !isFull(p)

     - Returns: Bool -> true if count == capacity
     */
    func isFull () -> Bool
}
