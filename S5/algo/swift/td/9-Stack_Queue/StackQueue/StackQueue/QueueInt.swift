//
// Created by Tom Sartori on 11/28/21.
//

import Foundation

struct QueueInt : QueueIntProtocol {


    /**
    - Correspond to the max capacity of the queue.

    - capacity : QueueIntProtocol -> Int
     */
    var capacity : Int

    /**
     - Correspond to the current number of elements in the queue.

     - count : QueueIntProtocol -> Int

     - count(init()) == 0
     */
    var count : Int

    /**
    - Store the elements of the queue.

    - tab : QueueInt -> [Int]
     */
    private var tab : [Int]

    /**
     - Index of the first element arrived to the queue.

     - firstIndex : QueueInt -> Int
     */
    private var firstIndex : Int

    /**
    - Index of the element which will be added.

    - nextIndex : QueueInt -> Int
     */
    private var nextIndex : Int

    /**
     - Create an empty queue.

    - init : QueueIntProtocol x Int -> QueueIntProtocol

    - capacity(init(n)) == n

     - Parameter capacity: Int
     */
    init (capacity : Int) {
        self.capacity = capacity
        count = 0
        tab = [Int](repeating: 0, count: capacity)
        firstIndex = 0
        nextIndex = 0
    }

    /**
     - Retour the first element of the queue (if there is one).

     - first : QueueIntProtocol -> Int | nil

     - first(q)==Vide ⇒ isEmpty(q)

     - Returns: Int?
     */
    func first () -> Int? {
        guard !isEmpty() else { return nil }
        return tab[firstIndex]
    }

    /**
     - Delete and return the first element of the queue.

     - deQueue : QueueIntProtocol -> QueueIntProtocol x Int

     - deQueuen(deQueuen(q,tkn))==Vide
     - deQueue(q) ⇒ !isEmpty(q)
     - deQueue(enQueuen(init(),ti))==enQueuen-1(init(),ti)
     - (q2, t) = deQueue(q1) ⇒ count(q2) == count(q1) - 1

     - Returns: Int
     */
    mutating func deQueue () -> Int {
        guard !isEmpty() else { fatalError("mutating func deQueue () -> Int") }
        let value = tab[firstIndex]
        count -= 1
        firstIndex = firstIndex == capacity - 1 ? 0 : firstIndex + 1
        return value
    }

    /**
     - Add a new element to the queue.

     - enQueue : QueueIntProtocol x Int -> QueueIntProtocol

     - first(enQueue(...(enQueue(q, t0), t1), ..., tn))==t0
     - count(enQueue(q, t)) == count(q)+1
     - enQueue(q, t) ⇒ !isFull(q)

     - Parameter x: Int
     */
    mutating func enQueue (x: Int) {
        guard !isFull() else { fatalError("mutating func enQueue (x: Int)") }
        tab[nextIndex] = x
        nextIndex = nextIndex == capacity - 1 ? 0 : nextIndex + 1
        count += 1
    }

    /**
     - Return true if the queue is empty.

     - isEmpty : QueueIntProtocol -> Bool

     - isEmpty(init()) == True

     - isEmpty(q) ⟺ count(q) == 0

     - Returns: Bool
     */
    func isEmpty () -> Bool {
        return count == 0
    }

    /**
     - Return true if the queue is full.

     - isFull : QueueIntProtocol -> Bool

     - isFull(q) ⟺ count(q) == capacity(q)

     - Returns: Bool
     */
    func isFull () -> Bool {
        return count == capacity
    }
}
