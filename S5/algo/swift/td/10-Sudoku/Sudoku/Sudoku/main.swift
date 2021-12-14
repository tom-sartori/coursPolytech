//
//  main.swift
//  Sudoku
//
//  Created by Tom Sartori on 11/29/21.
//
//

import Foundation

print("Hello, World!")


var sudoku = Sudoku()

sudoku.setValue(x: 0, y: 2, value: 1)
sudoku.setValue(x: 1, y: 5, value: 1)
sudoku.setValue(x: 2, y: 6, value: 2)
sudoku.setValue(x: 3, y: 7, value: 1)
//sudoku.setValue(x: 6, y: 8, value: 1)
print(sudoku)

let isPossible = sudoku.findSolution(xStart: 0, yStart: 0)

print(sudoku)

