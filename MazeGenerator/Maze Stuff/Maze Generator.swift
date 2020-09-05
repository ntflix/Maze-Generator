//
//  MazeGenerator2.swift
//  MazeGenerator
//
//  Created by Felix Weber on 07/08/2020.
//  Copyright © 2020 iron59. All rights reserved.
//

struct MazeGenerator {
    let maze: Maze
    
    init(_ size: XYSize, algorithm: MazeGeneratorAlgorithm.Type) {
        self.maze = algorithm.init(size: size).maze
    }
    
    static func getUnvisitedNeighboursOf(_ cell: MazeCell, _ maze: Maze) -> [MazeCell] {
        return cell.neighbours(maze.size).map { item in
            maze.indices[item]!
        }.filter { i in
            i.visited == false
        }
    }
}

protocol MazeGeneratorAlgorithm {
    init(size: XYSize)
    var maze: Maze { get }
}
