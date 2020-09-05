//
//  Aldous-Broder.swift
//  MazeGenerator
//
//  Created by Felix Weber on 12/08/2020.
//  Copyright © 2020 iron59. All rights reserved.
//

class AldousBroder: MazeGeneratorAlgorithm {
    let maze: Maze
    
    required init(size: XYSize) {
        /*
         Pick a random cell as the current cell and mark it as visited.
         While there are unvisited cells:
            Pick a random neigbour.
            If the chosen neighbour has not been visited:
                Remove tutehe wall between the current cell and the chosen neighbour.
                Mark the chosen neighbour as visited.
            Make the chosen neighbour the current cell.
         */
        
        // generate a grid of cells
        self.maze = Maze(size)
        
        // pick a random cell as the current cell
        var currentCell = self.maze.graph.graph.keys.randomElement()!!.vertex
        
        // find the number of cells
        var remaining = self.maze.size.x * self.maze.size.y - 1
        
        while remaining > 0 {
            print(remaining)
            currentCell.calculateNeigbours(self.maze.size)
            if let randomNeighbour = currentCell.neighbours.randomElement() {
                if self.maze.indices[randomNeighbour]!.visited == false {
                    self.maze.indices[randomNeighbour]!.visited = true
                    self.maze.addLink(a: currentCell, b: self.maze.indices[randomNeighbour]!)
                    remaining -= 1
                }
                currentCell = self.maze.indices[randomNeighbour]!
            }
        }
    }
}
