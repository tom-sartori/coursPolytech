//
//  main.swift
//  StackQueue
//
//  Created by Tom Sartori on 11/26/21.
//
//

import Foundation

print("Hello, World!")

let capacity = 30
var stack : StackIntProtocol = StackInt(capacity: capacity)
assert(stack.isEmpty())
assert(!stack.isFull())
assert(stack.capacity == capacity)
assert(stack.count == 0)
assert(stack.top() == nil)
stack.push(x: 4)
stack.push(x: 5)
assert(!stack.isEmpty())
assert(!stack.isFull())
assert(stack.capacity == capacity)
assert(stack.count == 2)
assert(stack.top() == 5)
assert(stack.pop() == 5)
assert(stack.top() == 4)
assert(stack.pop() == 4)

var queue : QueueIntProtocol = QueueInt(capacity: capacity)
assert(queue.isEmpty())
assert(!queue.isFull())
assert(queue.capacity == capacity)
assert(queue.count == 0)
assert(queue.first() == nil)
queue.enQueue(x: 4)
queue.enQueue(x: 5)
assert(!queue.isEmpty())
assert(!queue.isFull())
assert(queue.capacity == capacity)
assert(queue.count == 2)
assert(queue.first() == 4)
assert(queue.deQueue() == 4)
assert(queue.first() == 5)
assert(queue.deQueue() == 5)
assert(queue.isEmpty())
assert(queue.first() == nil)
assert(queue.count == 0)
