//
//  main.swift
//  List
//
//  Created by Tom Sartori on 12/10/21.
//
//

import Foundation

print("Hello, World!")


var list: TListEntier = TListEntier()
print(list)
assert(list.count == 0)
assert(list.isEmpty())

let value: Int = 4
list.insertFirst(value: value)
assert(list.count == 1)
assert(!list.isEmpty())
assert(list.head.next.value == value)
assert(list.head.next.next.value == 1)
assert(list.head.previous.value == value)
assert(list.head.previous.previous.value == 1)

print(list)


let value2: Int = 7
list.insertFirst(value: value2)
print(list)

assert(list.head.next.value == value2)
assert(list.head.next.next.value == value)
assert(list.head.previous.value == value)
assert(list.head.previous.previous.value == value2)


let value3: Int = 1
list.insertLast(value: value3)
print(list)

assert(list.head.previous.value == value3)
assert(list.head.previous.previous.value == value)


print("ITERATOR")
var it = list.makeIterator()
print(it)
print(it.next() as Any)
print(it.changeValue(value: 0))
print(list)

