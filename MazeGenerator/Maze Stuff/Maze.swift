//
//  AdjacencyListMaze.swift
//  MazeGenerator
//
//  Created by Felix Weber on 07/08/2020.
//  Copyright © 2020 iron59. All rights reserved.
//

struct XYSize: Hashable {
    var x: Int
    var y: Int

    static func -(lhs: XYSize, rhs: XYSize) -> XYSize {
        let x = lhs.x - rhs.x
        let y = lhs.y - rhs.y
        
        return XYSize(x, y)
    }
    
    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
    
    init?(_ size: (Int, Int)) {
        self.x = size.0
        self.y = size.1
    }
}

class Maze {
    let graph: AdjacencyList<MazeCell>
    var indices = Dictionary<Int, MazeCell>() // Keep track of cells via indices
    let size: XYSize
    
    init(_ size: XYSize) {
        self.size = size
        self.graph = AdjacencyList<MazeCell>(size.x * size.y)
        
        for y in 0...self.size.y {
            for x in 0...self.size.x {
                let currentCell = MazeCell(x, y)
                self.indices[currentCell.index(self.size)] = currentCell
                self.graph.graph[AdjacencyListNode(currentCell)] = []
            }
        }
    }
    
    func addLink(a: MazeCell, b: MazeCell) {
        let c = self.indices[a.index(self.size)]!
        let x = self.indices[b.index(self.size)]!
        
        self.graph.addEdge(from: c, to: x, directed: false)
    }
}

extension Maze: CustomDebugStringConvertible {
    public var debugDescription: String {
        return graph.debugDescription
    }
}
//
//extension Maze: CustomStringConvertible {
//    public var description: String {
//        return "\(graph)"
//    }
//}
