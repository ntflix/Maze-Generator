//
//  MazeView.swift
//  MazeGenerator
//
//  Created by Felix Weber on 09/08/2020.
//  Copyright © 2020 iron59. All rights reserved.
//

import UIKit

class MazeView: UIViewController {
    // var maze = MazeGenerator(XYSize(16, 16), algorithm: RecursiveBacktracker.self).maze
    var maze: Maze? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        
//        let maze = MazeGenerator.initRecursiveBacktracker(XYSize(14, 14))
        generateMaze()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let layers = self.view.layer.sublayers {
            for layer in layers {
                layer.removeFromSuperlayer()
            }
        }
        
//        self.view.layer.removeFromSuperlayer()
        generateMaze()
    }
    
    func generateMaze() {
//        let algorithms: [(MazeGeneratorAlgorithm.Type, CGColor)] = [ (AldousBroder.self, UIColor.systemYellow.cgColor), (RecursiveBacktracker.self, UIColor.systemTeal.cgColor) ]
//        let chosenAlgorithm = algorithms.randomElement()!
        let chosenAlgorithm = (RecursiveBacktracker.self, UIColor.systemPink.cgColor)
        self.maze = MazeGenerator(XYSize(46, 32), algorithm: chosenAlgorithm.0).maze
        self.view.layer.addSublayer(drawMaze(self.maze!, color: chosenAlgorithm.1))
    }
    
    func drawMaze(_ maze: Maze, color: CGColor = UIColor.systemTeal.cgColor, lineWidth: CGFloat = 2.5, cellSize: CGFloat = 20) -> CALayer {
        let drawLayer = CALayer()
        
        let mazeLayer = CAShapeLayer()
        mazeLayer.path = mazeGrid(maze, cellSize: cellSize, lineSize: lineWidth).cgPath
        mazeLayer.strokeColor = color
        mazeLayer.lineWidth = lineWidth
        
        drawLayer.addSublayer(mazeLayer)
//        drawLayer.addSublayer(boundsLayer)

        return drawLayer
    }
    
//    private func mazeBounds(_ maze: Maze, cellSize: CGFloat, lineSize: CGFloat) -> UIBezierPath {
//        let line = UIBezierPath(rect: CGRect(x: 0, y: 0, width: CGFloat(maze.size.x) * cellSize, height: CGFloat(maze.size.y) * cellSize))
//
//        // move it all by 1/2 lineSize so it isn't clipped
//        line.apply(CGAffineTransform(translationX: lineSize / 2, y: lineSize / 2))
//
//        return line
//    }
    
    private func mazeGrid(_ maze: Maze, cellSize: CGFloat, lineSize: CGFloat) -> UIBezierPath {
        let line = UIBezierPath()
//        line.move(to: CGPoint(x: 0, y: 0))
        
        for y in 0...maze.size.y {
            let currentY = CGFloat(y) * cellSize
            
            for x in 0...maze.size.x {
                let currentX = CGFloat(x) * cellSize
//                print(currentX, currentY)
                
                let thisCell = MazeCell(x, y)
                let thisCellAdjacencyNode = AdjacencyListNode(thisCell)
                let connectedCells = maze.graph.graph[thisCellAdjacencyNode]
                var directions = [Direction]()
                
                if let connectedCells = connectedCells {
                    connectedCells.forEach { cell in
                        if let direction = thisCell.directionToCell(cell!.vertex) {
                            directions.append(direction)
                        }
                    }
                }
                
//                if let leftCell = maze.graph.graph[AdjacencyListNode(MazeCell(x - 1, y))] {
//                    if leftCell.contains(thisCellAdjacencyNode) {
//                        directions.append(.West)
//                    }
//                }
//                if let northCell = maze.graph.graph[AdjacencyListNode(MazeCell(x, y - 1))] {
//                    if northCell.contains(thisCellAdjacencyNode) {
//                        directions.append(.North)
//                    }
//                }
                
                // if relative direction between cell and connection is north, south, east, west draw the correct walls
                
                if (y != maze.size.y) {
                    if !(directions.contains(.West)) {
                        line.move(to: CGPoint(x: currentX, y: currentY))
                        line.addLine(to: CGPoint(x: currentX, y: currentY + cellSize))
                    }
                }
                
                if (x != maze.size.x) {
                    if !(directions.contains(.North)) {
                        line.move(to: CGPoint(x: currentX, y: currentY))
                        line.addLine(to: CGPoint(x: currentX + cellSize, y: currentY))
                    }
                }
            }
        }
        
        // move it all by 1/2 lineSize so it isn't clipped
        line.apply(CGAffineTransform(translationX: lineSize / 2, y: lineSize / 2))
        
        return line
    }
    
}
