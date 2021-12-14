//
// Created by Tom Sartori on 11/29/21.
//

import Foundation

struct Sudoku : SudokuProtocol {

    typealias IteratorLine = ItLine
    typealias IteratorColumn = ItColumn
    typealias IteratorRegion = ItRegion

    fileprivate var size: Int
    fileprivate var grille : [[Int]]

    /**
     - Create a sudoku 9x9.

     - init : SudokuProtocol -> SudokuProtocol
     */
    init() {
        size = 9
        grille = [[Int]](repeating: [Int](repeating: 0, count: size), count: size)
    }

    /**
     - Solve the sudoku

     - solve : SudokuProtocol -> SudokuProtocol x Bool

     - Returns: True if solved.
     */
    mutating func solve () -> Bool {
        return findSolution(xStart: 0, yStart: 0)
    }

    /**
     - Recursive function which solve the sudoku.

     - grilleFinie : SudokuProtocol x Int x Int -> SudokuProtocol x Bool

     - Returns: True if solved.
     */
    mutating func findSolution(xStart: Int, yStart: Int) -> Bool {
//        print(self)
        print (xStart, yStart, separator: " : ")
        guard xStart >= 0 else { return false }
        let nextCoord = getNextEmpty(x: xStart, y: yStart)

        guard nextCoord.0 < size else { return true }

        var x: Int = 1
        while x <= size {
            setValue(x: nextCoord.0, y: nextCoord.1, value: x)
            if isRight(x: nextCoord.0, y: nextCoord.1) {
                if findSolution(xStart: nextCoord.0, yStart: nextCoord.1) {
                    return true
                }
            }
            x += 1
        }
        setValue(x: nextCoord.0, y: nextCoord.1, value: 0)
        return false
    }

//    func isIteratorRight (x: Int, y: Int, iterator: IteratorProtocol) -> Bool {
//        var iteratorCopy = iterator
//        var total: Int = 0
//
//        var i : Int = 0
//        while i < size && total <= 1 {
//            if let value = iteratorCopy.next() {
//                if value == grille[x][y] {
//                    total += 1
//                }
//            }
//            i += 1
//        }
//        return total == 1
//    }

    /**
     - isRight : SudokuProtocol x Int x Int -> Bool

     - Parameters:
       - x: line index.
       - y: column index.
     - Returns: True if the value at the position in param, isn't already in his line, column and square.
     */
    func isRight(x: Int, y: Int) -> Bool {
        return isLineRight(x: x, y: y) && isColumnRight(x: x, y: y) && isRegionRight(x: x, y: y)
    }

    /**
     - isLineRight : SudokuProtocol x Int x Int -> Bool

     - Parameters:
       - x: line index.
       - y: column index.
     - Returns: True if the value at the position in param, isn't already in his line.
     */
    func isLineRight (x: Int, y: Int) -> Bool {
        var itLine = IteratorLine(self, x: x)
        var total: Int = 0

        let currentValue = getValue(x: x, y: y)
        var i : Int = 0
        while i < size && total <= 1 {
            if let isValue = itLine.next() {
                if isValue == currentValue {
                    total += 1
                }
            }
            i += 1
        }
        return total == 1
//        return isIteratorRight(x: x, y: y, iterator: makeIteratorLine(x: x))
    }

    /**
     - isColumnRight : SudokuProtocol x Int x Int -> Bool

     - Parameters:
       - x: line index.
       - y: column index.
     - Returns: True if the value at the position in param, isn't alredy in his column.
     */
    func isColumnRight (x: Int, y: Int) -> Bool {
        var itColumn = IteratorColumn(self, y: y)
        var total: Int = 0

        let currentValue = getValue(x: x, y: y)
        var i : Int = 0
        while i < size && total <= 1 {
            if let itValue = itColumn.next() {
                if itValue == currentValue {
                    total += 1
                }
            }
            i += 1
        }
        return total == 1
//        return isIteratorRight(x: x, y: y, iterator: makeIteratorColumn(y: y))
    }

    /**
     - isRegionRight : SudokuProtocol x Int x Int -> Bool

     - Parameters:
       - x: line index.
       - y: column index.
     - Returns: True if the value at the position in param, isn't alredy in his square.
     */
    func isRegionRight (x: Int, y: Int) -> Bool {
        var itRegion = IteratorRegion(self, x: x, y: y)
        var total: Int = 0

        let currentValue = getValue(x: x, y: y)
        var i : Int = 0
        while i < size {
            if let itValue = itRegion.next() {
                if itValue == currentValue {
                    total += 1
                }
            }
            i += 1
        }
        return total == 1
//        return isIteratorRight(x: x, y: y, iterator: makeIteratorRegion(x: x, y: y))
    }

    /**
     getNextEmpty : SudokuProtocol x Int x Int -> (Int, Int)

     - Parameters:
       - x: line index.
       - y: column index.
     - Returns: the coords of the next empty value (can return itself).
     */
    func getNextEmpty (x: Int, y: Int) -> (Int, Int) {
        var i: Int = x
        var j: Int = y

        while i < size  {
            while j < size {
                if isEmpty(x: i, y: j) {
                    return (i, j)
                }
                j += 1
            }
            i += 1
            j = 0
        }
        return (i, j)
    }

    /**
     - isEmpty : SudokuProtocol x Int x Int -> Bool

     - Parameters:
       - x: line index.
       - y: column index.
     - Returns: True if there isn't any value at the coords in param.
     */
    func isEmpty (x: Int, y: Int) -> Bool {
        return getValue(x: x, y: y) == 0
    }

    /**
     - getValue : SudokuProtocol x Int x Int -> Int

     - Parameters:
       - x: line index.
       - y: column index.
     - Returns: the value at the coords in param.
     */
    func getValue (x: Int, y: Int) -> Int {
        guard 0 <= x && x <= size && 0 <= y && y <= size else { fatalError() }

        var it = makeIteratorLine(x: x)
        for _ in 0 ..< y {
            it.next()
        }

        if let value = it.next() {
            return value
        }
        else {
            fatalError()
        }
    }

    /**
     - Set the value in param at the position in param.

     - setValue : SudokuProtocol x Int x Int x Int -> SudokuProtocol

     - Parameters:
       - x: line index.
       - y: column index.
       - value: the value wanted.
     */
    mutating func setValue (x: Int, y: Int, value: Int) {
        guard 0 <= x && x < size && 0 <= y && y < size && 0 <= value && value <= size else { fatalError("func setValue") }
        grille[x][y] = value
    }

//    func makeIterator() -> IteratorLine {
//        fatalError("makeIterator() has not been implemented")
//    }

    /**
     - makeIteratorLine : SudokuProtocol x Int -> IteratorLine

     - Parameter x: index of the line.
     - Returns: An iterator on a line of the sudoku.
     */
    func makeIteratorLine(x : Int) -> IteratorLine {
        return ItLine(self, x: x)
    }

    /**
     - makeIteratorColumn : SudokuProtocol x Int -> IteratorColumn

     - Parameter y: index of the column.
     - Returns: An iterator on a column of the sudoku.
     */
    func makeIteratorColumn(y: Int) -> IteratorColumn {
        return ItColumn(self, y: y)
    }

    /**
     - makeIteratorRegion : SudokuProtocol x Int -> IteratorRegion

     - Parameters: coords can be anywhere in a region.
       - x: index of the line.
       - y: index of the column.
     - Returns: An iterator on a region of the sudoku.
     */
    func makeIteratorRegion(x: Int, y: Int) -> IteratorRegion {
        return ItRegion(self, x: x, y: y)
    }

    // Used for the print.
    var description: String {
        var sh: String = ""
        for i in 0 ..< size {
            if (i % 3 == 0) {
                sh += "\n"
            }
            for j in 0 ..< size {
                if (j % 3 == 0) {
                    sh += "  "
                }
                sh += String(grille[i][j]) + "  "
            }
            sh += "\n"
        }
        return sh
    }
}

public struct ItLine : IteratorProtocol {
    private var listLineValue: [Int]
    private var currentIndex: Int

    fileprivate init (_ sudoku: Sudoku, x: Int) {
        guard 0 <= x && x < sudoku.size else { fatalError() }
        listLineValue = sudoku.grille[x]
        currentIndex = 0
    }

    @discardableResult
    public mutating func next() -> Int? {
        guard currentIndex < listLineValue.count else { return nil }
        currentIndex += 1
        return listLineValue[currentIndex - 1]
    }
}

public struct ItColumn : IteratorProtocol {
    private var listColumnValue: [Int]
    private var currentIndex : Int

    fileprivate init (_ sudoku: Sudoku, y: Int) {
        guard 0 <= y && y < sudoku.size else { fatalError() }
        listColumnValue = [Int](repeating: 0, count: sudoku.size)
        for i in 0 ..< sudoku.size {
            listColumnValue[i] = sudoku.grille[i][y]
        }
        currentIndex = 0
    }

    public mutating func next() -> Int? {
        guard currentIndex < listColumnValue.count else { return nil }
        currentIndex += 1
        return listColumnValue[currentIndex - 1]
    }
}

public struct ItRegion: IteratorProtocol {
    private var listRegionValue: [Int]
    private var currentIndex: Int

    fileprivate init (_ sudoku: Sudoku, x: Int, y: Int) {
        guard 0 <= x && x < sudoku.size && 0 <= y && y < sudoku.size else { fatalError() }

        let regionSize: Int = Int(sqrt(Double(sudoku.size)))
        let startX : Int = Int(Double(x) / Double(regionSize)) * regionSize
        let startY : Int = Int(Double(y) / Double(regionSize)) * regionSize

        listRegionValue = [Int](repeating: 0, count: sudoku.size)
        var index: Int = 0
        for i in 0 ..< regionSize {
            for j in 0 ..< regionSize {
                listRegionValue[index] = sudoku.grille[startX + i % regionSize][startY + j % regionSize]
                index += 1
            }
        }
        currentIndex = 0
    }

    mutating public func next() -> Int? {
        guard currentIndex < listRegionValue.count else { return nil }
        currentIndex += 1
        return listRegionValue[currentIndex - 1]
    }
}

//public struct ItEmptyValue: IteratorProtocol {
//    private var listEmptyValue: [(Int, Int)]
//    private var currentIndex: Int
//
//    fileprivate init (_ sudoku: Sudoku) {
//
//        var listEmptyValue = [(Int, Int)](repeating: 0, count: sudoku.size * sudoku.size)
//        for i in 0 ..< sudoku.size {
//            for j in 0 ..< sudoku.size {
//                listEmptyValue[i + j] =
//            }
//        }
//        currentIndex = 0
//    }
//
//    mutating public func next() -> Int? {
//        guard currentIndex < listEmptyValue.count else { return nil }
//        currentIndex += 1
//        return listEmptyValue[currentIndex - 1]
//    }
//}
