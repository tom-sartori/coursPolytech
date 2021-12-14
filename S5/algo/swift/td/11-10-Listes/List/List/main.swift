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
//print(list.head.next)
//print(list.head.next.next)
//print(list.head.previous)
//print(list.head.next.previous)

let value2: Int = 7
list.insertFirst(value: value2)
print(list)
print(list.head.next)
print(list.head.next.next)

print(list.head.previous)
print(list.head.previous.previous)

assert(list.head.next.value == value2)
assert(list.head.next.next.value == value)
assert(list.head.previous.value == value)
assert(list.head.previous.previous.value == value2)
