//
// Created by Tom Sartori on 11/28/21.
//

import Foundation

protocol QueueTProtocol {

    /**
    - Correspond to the max capacity of the queue.

    - capacity : QueueIntProtocol -> Int
     */
    var capacity : Int { get }

    /**
     - Correspond to the current number of elements in the queue.

     - count : QueueIntProtocol -> Int

     - count(init()) == 0
     */
    var count : Int { get }

    /**
     - Create an empty queue.

    - init : QueueIntProtocol x Int -> QueueIntProtocol

    - capacity(init(n)) == n

     - Parameter capacity: Int
     */
    init (capacity : Int)

    /**
     - Retour the first element of the queue (if there is one).

     - first : QueueIntProtocol -> Int | nil

     - first(q)==Vide ⇒ isEmpty(q)

     - Returns: Int?
     */
    func first () -> Int?

    /**
     - Delete and return the first element of the queue.

     - deQueue : QueueIntProtocol -> QueueIntProtocol x Int

     - deQueuen(deQueuen(q,tkn))==Vide
     - deQueue(q) ⇒ !isEmpty(q)
     - deQueue(enQueuen(init(),ti))==enQueuen-1(init(),ti)
     - (q2, t) = deQueue(q1) ⇒ count(q2) == count(q1) - 1

     - Returns: Int
     */
    mutating func deQueue () -> Int

    /**
     - Add a new element to the queue.

     - enQueue : QueueIntProtocol x Int -> QueueIntProtocol

     - first(enQueue(...(enQueue(q, t0), t1), ..., tn))==t0
     - count(enQueue(q, t)) == count(q)+1
     - enQueue(q, t) ⇒ !isFull(q)

     - Parameter x: Int
     */
    mutating func enQueue (x: Int)

    /**
     - Return true if the queue is empty.

     - isEmpty : QueueIntProtocol -> Bool

     - isEmpty(init()) == True

     - isEmpty(q) ⟺ count(q) == 0

     - Returns: Bool
     */
    func isEmpty () -> Bool

    /**
     - Return true if the queue is full.

     - isFull : QueueIntProtocol -> Bool

     - isFull(q) ⟺ count(q) == capacity(q)

     - Returns: Bool
     */
    func isFull () -> Bool
}