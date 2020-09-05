//
//  MazeCell.swift
//  MazeGenerator
//
//  Created by Felix Weber on 07/08/2020.
//  Copyright © 2020 iron59. All rights reserved.
//

enum Direction {
    case North
    case East
    case South
    case West
    
    static func fromXYSize(_ xysize: XYSize) -> Direction? {
        if xysize.x == 0 {
            if xysize.y == -1 {
                return .South
            } else if xysize.y == 1 {
                return .North
            }
        }
        if xysize.x == -1 {
            return .East
        } else if xysize.x == 1 {
            return .West
        }
        
        return nil
    }
}

class MazeCell: Hashable {
    static func == (lhs: MazeCell, rhs: MazeCell) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
    
    static func calculateIndexOf(x: Int, y: Int, mazeSize: XYSize) -> Int {
        return x + (mazeSize.x * y) + y
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine((y + 1) * -1)
    }
    
    func directionToCell(_ cell: MazeCell) -> Direction? {
        return Direction.fromXYSize(XYSize(self.x, self.y) - XYSize(cell.x, cell.y)) ?? nil
    }
    
    let x: Int
    let y: Int
    var visited: Bool = false
    var neighbours = [Int]()
    
    func index(_ mazeSize: XYSize) -> Int {
        return MazeCell.calculateIndexOf(x: self.x, y: self.y, mazeSize: mazeSize)
    }
    
    init(_ x: Int, _ y: Int, _ visited: Bool = false) {
        self.x = x
        self.y = y
        self.visited = visited
    }
    
    func neighbours(_ size: XYSize) -> [Int] {
        self.calculateNeigbours(size)
        return self.neighbours
    }
    
    func calculateNeigbours(_ size: XYSize) {
        // lmaooooo this function
        
        var neighbours = [Int]()
        
        if !(self.x >= size.x - 1) {
            // current cell is not in the last column
            neighbours.append(MazeCell(self.x + 1, self.y).index(size))
        }
        if !(self.x == 0) {
            // current cell is not in the first column
            neighbours.append(MazeCell(self.x - 1, self.y).index(size))
        }
        if !(self.y >= size.y - 1) {
            // current cell is not in the last row
            neighbours.append(MazeCell(self.x, self.y + 1).index(size))
        }
        if !(self.y == 0) {
            // current cell is not in the first row
            neighbours.append(MazeCell(self.x, self.y - 1).index(size))
        }
        
        self.neighbours = neighbours
    }
    
//    func invertConnections(_ connections: [Int]) -> [Int] {
//        var inverted = [Int]()
//        
//        if !(self.x >= size.x - 1) {
//            // current cell is not in the last column
//            neighbours.append(MazeCell(self.x + 1, self.y).index(size))
//        }
//        if !(self.x == 0) {
//            // current cell is not in the first column
//            neighbours.append(MazeCell(self.x - 1, self.y).index(size))
//        }
//        if !(self.y >= size.y - 1) {
//            // current cell is not in the last row
//            neighbours.append(MazeCell(self.x, self.y + 1).index(size))
//        }
//        if !(self.y == 0) {
//            // current cell is not in the first row
//            neighbours.append(MazeCell(self.x, self.y - 1).index(size))
//        }
//    }
}

extension MazeCell: CustomDebugStringConvertible {
    var debugDescription: String {
        return "(\(x), \(y))"
    }
}

extension MazeCell: CustomStringConvertible {
    var description: String {
        return "(\(x), \(y))"
    }
}
