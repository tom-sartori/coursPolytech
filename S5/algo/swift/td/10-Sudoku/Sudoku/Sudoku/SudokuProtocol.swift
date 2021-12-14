//
// Created by Tom Sartori on 11/29/21.
//

import Foundation

protocol SudokuProtocol : CustomStringConvertible {
    associatedtype IteratorLine : IteratorProtocol
    associatedtype IteratorColumn : IteratorProtocol
    associatedtype IteratorRegion : IteratorProtocol

    /**
     - Create a sudoku 9x9.

     - init : SudokuProtocol -> SudokuProtocol
     */
    init()

    /**
     - Solve the sudoku

     - solve : SudokuProtocol -> SudokuProtocol x Bool

     - Returns: True if solved.
     */
    mutating func solve () -> Bool

    /**
     - Recursive function which solve the sudoku.

     - grilleFinie : SudokuProtocol x Int x Int -> SudokuProtocol x Bool

     - Returns: True if solved.
     */
    mutating func findSolution(xStart: Int, yStart: Int) -> Bool

    /**
     - isRight : SudokuProtocol x Int x Int -> Bool

     - Parameters:
       - x: line index.
       - y: column index.
     - Returns: True if the value at the position in param, isn't already in his line, column and square.
     */
    func isRight(x: Int, y: Int) -> Bool

    /**
     getNextEmpty : SudokuProtocol x Int x Int -> (Int, Int)

     - Parameters:
       - x: line index.
       - y: column index.
     - Returns: the coords of the next empty value (can return itself).
     */
    func getNextEmpty (x: Int, y: Int) -> (Int, Int)

    /**
     - isEmpty : SudokuProtocol x Int x Int -> Bool

     - Parameters:
       - x: line index.
       - y: column index.
     - Returns: True if there isn't any value at the coords in param.
     */
    func isEmpty (x: Int, y: Int) -> Bool

    /**
     - getValue : SudokuProtocol x Int x Int -> Int

     - Parameters:
       - x: line index.
       - y: column index.
     - Returns: the value at the coords in param.
     */
    func getValue (x: Int, y: Int) -> Int

    /**
     - Set the value in param at the position in param.

     - setValue : SudokuProtocol x Int x Int x Int -> SudokuProtocol

     - Parameters:
       - x: line index.
       - y: column index.
       - value: the value wanted.
     */
    mutating func setValue (x: Int, y: Int, value: Int)

    /**
     - makeIteratorLine : SudokuProtocol x Int -> IteratorLine

     - Parameter x: index of the line.
     - Returns: An iterator on a line of the sudoku.
     */
    func makeIteratorLine(x : Int) -> IteratorLine

    /**
     - makeIteratorColumn : SudokuProtocol x Int -> IteratorColumn

     - Parameter y: index of the column.
     - Returns: An iterator on a column of the sudoku.
     */
    func makeIteratorColumn(y: Int) -> IteratorColumn

    /**
     - makeIteratorRegion : SudokuProtocol x Int -> IteratorRegion

     - Parameters: coords can be anywhere in a region.
       - x: index of the line.
       - y: index of the column.
     - Returns: An iterator on a region of the sudoku.
     */
    func makeIteratorRegion(x: Int, y: Int) -> IteratorRegion

    // Used for the print.
    var description: String { get }
}
