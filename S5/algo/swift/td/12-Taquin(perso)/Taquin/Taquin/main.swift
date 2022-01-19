//
//  main.swift
//  Taquin
//
//  Created by Tom Sartori on 12/22/21.
//
//

import Foundation

print("Hello, World!")

var taquin: Taquin = Taquin(gameSize: 4)
print(taquin)
assert(taquin.isRight())
assert(taquin.findEmptyCase() == (x: 3, y: 3))

taquin.shuffle()
print(taquin)
assert(!taquin.isRight())

taquin = Taquin(gameSize: 3)
print(taquin)
taquin.shuffle()
print(taquin)
