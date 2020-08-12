//
//  MazeGenerator2.swift
//  GoreGraphicsStuff
//
//  Created by Felix Weber on 07/08/2020.
//  Copyright © 2020 iron59. All rights reserved.
//

struct MazeGenerator {
    let maze: Maze
    private var visitedStack = Stack<MazeCell>()
    
    init(_ size: XYSize) {
        // generate a grid of cells
        self.maze = Maze(size)
        // pick initial cell
        var currentCell = self.maze.indices[0]!
        currentCell.visited = true
        visitedStack.push(currentCell)
        
//        // while the stack is not empty, pop a cell from the stack and make it the current cell
//        if let currentCell = visitedStack.pop() {
//            // if the current cell has any neighbours which have not been visited
//            if let randomUnvisitedNeighbour = getUnvisitedNeighboursOf(currentCell).randomElement() {
//                // push the current cell to the stack
//                visitedStack.push(currentCell)
//                // add connection between current cell and the chosen random cell
//                self.maze.addLink(a: currentCell, b: randomUnvisitedNeighbour)
//                // mark the chosen cell as visited
//                randomUnvisitedNeighbour.visited = true
//                // ...and push it to the stack
//                visitedStack.push(randomUnvisitedNeighbour)
//            }
//        }

        // while the stack is not empty
        while visitedStack.isEmpty == false {
            // pop a cell from the stack and make it the current cell
            currentCell = visitedStack.pop()!
            // select a random neighbouring cell that has not been visited yet
            if let chosenRandomNeighbour = getUnvisitedNeighboursOf(currentCell).randomElement() {
                // push the current cell to the stack
                visitedStack.push(currentCell)
                // add link between currentCell and chosen random neighbour
                self.maze.addLink(a: currentCell, b: chosenRandomNeighbour)
                // ...and mark it as visited
                currentCell.visited = true
                // push the neighbouring cell to the stack
                visitedStack.push(chosenRandomNeighbour)
                // make the neighbouring cell the current cell
//                currentCell = chosenRandomNeighbour
            } else {
                // there are no unvisited neighbouring cells
                do {
                    if let c = visitedStack.pop() {
                        currentCell = c
                    }
                }
            }

        }
        
        print(self.maze)
        print(self.maze.graph.size)
        print(self.maze.graph.graph.count)
//        print()
    }
    
    init(_ maze: Maze) {
        self.maze = maze
    }
    
    static func initRecursiveBacktracker(_ size: XYSize) -> Maze {
        var maze = Maze(size)
        var visitedStack = Stack<MazeCell>()
        
        let currentCell = maze.indices[0]!
        visitedStack.push(currentCell)
                
        recursiveBacktracker(maze: &maze, currentCell: currentCell, visitedStack: &visitedStack)
        
        print(maze)
        print(maze.graph.size)
        print(maze.graph.graph.count)
        
        return maze
    }
    
    static func recursiveBacktracker(maze: inout Maze, currentCell: MazeCell, visitedStack: inout Stack<MazeCell>) {
        // mark the current cell as visited
        currentCell.visited = true
        
        visitedStack.push(currentCell)
        
        var nextCell: MazeCell? = nil
        
        // while the current cell has any unvisited neighbours, choose one of them
        if let randomChosenUnvisitedNeighbour = getUnvisitedNeighboursOf(currentCell, maze: maze).randomElement() {
            nextCell = randomChosenUnvisitedNeighbour
        } else {
            while let poppedCell = visitedStack.pop() {
                if let randomNeighbour = getUnvisitedNeighboursOf(poppedCell, maze: maze).randomElement() {
                    nextCell = randomNeighbour
                } else {
                    print()
                }
            }
            print()
        }
        
        if let nextCell = nextCell {
            // add link between currentCell and chosen cell
            maze.addLink(a: currentCell, b: nextCell)
            print("recursing")
            recursiveBacktracker(maze: &maze, currentCell: nextCell, visitedStack: &visitedStack)
        }
    }
    
    private static func getUnvisitedNeighboursOf(_ cell: MazeCell, maze: Maze) -> [MazeCell] {
        return cell.neighbours(maze.size).map { item in
            maze.indices[item]!
        }.filter { i in
            i.visited == false
        }
    }

    private func getUnvisitedNeighboursOf(_ cell: MazeCell) -> [MazeCell] {
        return cell.neighbours(self.maze.size).map { item in
            self.maze.indices[item]!
        }.filter { i in
            i.visited == false
        }
    }
}

