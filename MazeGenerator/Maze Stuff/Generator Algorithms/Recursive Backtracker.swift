//
//  Recursive Backtracker.swift
//  MazeGenerator
//
//  Created by Felix Weber on 12/08/2020.
//  Copyright © 2020 iron59. All rights reserved.
//

class RecursiveBacktracker: MazeGeneratorAlgorithm {
    let maze: Maze
    
    required init(size: XYSize) {
        // generate a grid of cells
        self.maze = Maze(size)
        
        // pick initial cell
        var currentCell = self.maze.indices[0]!
        currentCell.visited = true
        
        let visitedStack = Stack<MazeCell>()
        visitedStack.push(currentCell)

        // while the stack is not empty
        while visitedStack.isEmpty == false {
            // pop a cell from the stack and make it the current cell
            currentCell = visitedStack.pop()!
            // select a random neighbouring cell that has not been visited yet
            if let chosenRandomNeighbour = MazeGenerator.getUnvisitedNeighboursOf(currentCell, self.maze).randomElement() {
                // push the current cell to the stack
                visitedStack.push(currentCell)
                // add link between currentCell and chosen random neighbour
                self.maze.addLink(a: currentCell, b: chosenRandomNeighbour)
                // ...and mark it as visited
                currentCell.visited = true
                // push the neighbouring cell to the stack
                visitedStack.push(chosenRandomNeighbour)
            } else {
                // there are no unvisited neighbouring cells
                do {
                    if let c = visitedStack.pop() {
                        currentCell = c
                    }
                }
            }
        }
    }
}

