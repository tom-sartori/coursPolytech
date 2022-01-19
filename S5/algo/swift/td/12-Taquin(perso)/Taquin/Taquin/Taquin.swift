//
// Created by Tom Sartori on 12/22/21.
//

import Foundation

struct Taquin : CustomStringConvertible {

    fileprivate var grid: [[Int]]
    private var gameSize: Int

    public init (gameSize: Int) {
        self.gameSize = gameSize
        grid = [[Int]](repeating: [Int](repeating: 0, count: gameSize), count: gameSize)

        for i in 0 ..< gameSize {
            for j in 0 ..< gameSize {
                setValue(x: i, y: j, value: (i * gameSize) + j + 1)
            }
        }
        setValue(x: gameSize - 1, y: gameSize - 1, value: 0)
    }

    public func isRight () -> Bool {
        var x: Int = 0
        var y: Int = 0
        var expectedValue: Int = 1

        while x < gameSize && getValue(x: x, y: y) == expectedValue {
            y = y == gameSize - 1 ? 0 : y + 1
            if y == 0 {
                x += 1
            }
            expectedValue = (x * gameSize) + y + 1
        }

        return x == gameSize - 1 && y == gameSize - 1 && getValue(x: x, y: y) == 0
    }

    private func getValue (x: Int, y: Int) -> Int {
        guard isInside(x: x, y: y) else { fatalError() }
        return grid[x][y]
    }

    private func getValue (coord: (x: Int, y: Int)) -> Int {
        getValue(x: coord.x, y: coord.y)
    }

    private mutating func setValue (x: Int, y: Int, value: Int) {
        guard isInside(x: x, y: y) else { fatalError() }

        grid[x][y] = value
    }

    private mutating func setValue (coord: (x: Int, y: Int), value: Int ) {
        setValue(x: coord.x, y: coord.y, value: value)
    }

    private func isInside (i: Int) -> Bool {
        0 <= i && i < gameSize
    }

    public func isInside (x: Int, y: Int) -> Bool {
        isInside(i: x) && isInside(i: y)
    }

    public func findEmptyCase () -> (x: Int, y: Int) {
        var x: Int = 0
        var y : Int = 0
        var it = makeIterator()

        while it.next() != 0 {
            y = y == gameSize - 1 ? 0 : y + 1
            if y == 0 {
                x += 1
            }
        }
        return (x: x, y: y)
    }

    public mutating func moveLeft() -> Bool {
        let coordEmptyCase = findEmptyCase()
        guard coordEmptyCase.y != 0 else { return false }

        let coordOtherCase = (x: coordEmptyCase.x, y: coordEmptyCase.y - 1)
        setValue(coord: coordEmptyCase, value: getValue(coord: coordOtherCase))
        setValue(coord: coordOtherCase, value: 0)
        return true
    }

    public mutating func moveRight() -> Bool {
        let coordEmptyCase = findEmptyCase()
        guard coordEmptyCase.y != gameSize - 1 else { return false }

        let coordOtherCase = (x: coordEmptyCase.x, y: coordEmptyCase.y + 1)
        setValue(coord: coordEmptyCase, value: getValue(coord: coordOtherCase))
        setValue(coord: coordOtherCase, value: 0)
        return true
    }

    public mutating func moveUp() -> Bool {
        let coordEmptyCase = findEmptyCase()
        guard coordEmptyCase.x != 0 else { return false }

        let coordOtherCase = (x: coordEmptyCase.x - 1, y: coordEmptyCase.y)
        setValue(coord: coordEmptyCase, value: getValue(coord: coordOtherCase))
        setValue(coord: coordOtherCase, value: 0)
        return true
    }

    public mutating func moveDown() -> Bool {
        let coordEmptyCase = findEmptyCase()
        guard coordEmptyCase.x != gameSize - 1 else { return false }

        let coordOtherCase = (x: coordEmptyCase.x + 1, y: coordEmptyCase.y)
        setValue(coord: coordEmptyCase, value: getValue(coord: coordOtherCase))
        setValue(coord: coordOtherCase, value: 0)
        return true
    }

    public mutating func shuffle () {
        var i: Int = 0
        let max: Int = 20
        var hasMoved: Bool = false
        var direction: Int

        while i < max {
            hasMoved = false
            direction = Int.random(in: 0 ..< 4)

            switch direction {
                case 0:
                    hasMoved = moveUp()
                case 1:
                    hasMoved = moveDown()
                case 2:
                    hasMoved = moveLeft()
                default:
                    hasMoved = moveRight()
            }

            if hasMoved {
                i += 1
            }
        }
    }

    public mutating func solve() -> Bool {
        return true
    }

    // solveAux : Taquin -> Taquin
    private mutating func solveAux() {

    }

    private func getManhattan (taquin: Taquin) -> Int {

        for i in 0 ..< gameSize {

        }
    }

    private func makeIterator () -> IteratorTaquin {
        IteratorTaquin(self)
    }

    var description: String {
        var sh: String = ""
        var i: Int = 0

        for element in makeIterator() {
            if i % gameSize == 0 {
                sh += "\n"
            }
            
            sh += " \(element.description) "
            i += 1
        }

        return sh
    }
}

struct IteratorTaquin: Sequence, IteratorProtocol {
    private var grid: [[Int]]
    private var currentX: Int
    private var currentY: Int
    private var gameSize: Int { grid.count }

    fileprivate init (_ taquin: Taquin) {
        grid = taquin.grid
        currentX = 0
        currentY = 0
    }

    fileprivate init (_ taquin: Taquin, x: Int, y: Int) {
        guard taquin.isInside(x: x, y: y) else { fatalError() }

        grid = taquin.grid
        currentX = x
        currentY = y
    }

    public mutating func next() -> Int? {
        guard currentX < grid.count else { return nil }

        let value: Int = grid[currentX][currentY]

        currentY = currentY == gameSize - 1 ? 0 : currentY + 1
        if currentY == 0 {
            currentX += 1
        }
        return value
    }
}
