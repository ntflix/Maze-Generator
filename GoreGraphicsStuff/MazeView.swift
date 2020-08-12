//
//  MazeView.swift
//  GoreGraphicsStuff
//
//  Created by Felix Weber on 09/08/2020.
//  Copyright © 2020 iron59. All rights reserved.
//

import UIKit

class MazeView: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        
//        let maze = MazeGenerator(XYSize(14, 14)).maze
        let mazeRecursiveBacktracker = MazeGenerator.initRecursiveBacktracker(XYSize(14, 14))
        
        self.view.layer.addSublayer(drawMaze(mazeRecursiveBacktracker))
    }
    
    func drawMaze(_ maze: Maze, color: CGColor = UIColor.systemTeal.cgColor, lineWidth: CGFloat = 5, cellSize: CGFloat = 75) -> CALayer {
        let drawLayer = CALayer()
        
        let boundsLayer = CAShapeLayer()
        boundsLayer.path = mazeBounds(maze, cellSize: cellSize, lineSize: lineWidth).cgPath
        boundsLayer.strokeColor = color
        boundsLayer.lineWidth = lineWidth
        boundsLayer.fillColor = nil
        
        let mazeLayer = CAShapeLayer()
        mazeLayer.path = mazeGrid(maze, cellSize: cellSize, lineSize: lineWidth).cgPath
        mazeLayer.strokeColor = UIColor.yellow.cgColor
        mazeLayer.lineWidth = lineWidth
        
        drawLayer.addSublayer(mazeLayer)
//        drawLayer.addSublayer(boundsLayer)

        return drawLayer
    }
    
    private func mazeBounds(_ maze: Maze, cellSize: CGFloat, lineSize: CGFloat) -> UIBezierPath {
        let line = UIBezierPath(rect: CGRect(x: 0, y: 0, width: CGFloat(maze.size.x) * cellSize, height: CGFloat(maze.size.y) * cellSize))
        
        // move it all by 1/2 lineSize so it isn't clipped
        line.apply(CGAffineTransform(translationX: lineSize / 2, y: lineSize / 2))
        
        return line
    }
    
    private func mazeGrid(_ maze: Maze, cellSize: CGFloat, lineSize: CGFloat) -> UIBezierPath {
        let line = UIBezierPath()
//        line.move(to: CGPoint(x: 0, y: 0))
        
        for y in 0...maze.size.y {
            let currentY = CGFloat(y) * cellSize
            
            for x in 0...maze.size.x {
                let currentX = CGFloat(x) * cellSize
//                print(currentX, currentY)
                
                let thisCell = MazeCell(x, y)
                let connectedCell = maze.graph.graph[AdjacencyListNode(thisCell)]?!.vertex
                var direction: Direction? = nil
                
                if let connectedCell = connectedCell {
                    direction = thisCell.directionToCell(connectedCell)
                }
                
                let leftCellIsConnectedToThisCell = maze.graph.graph[AdjacencyListNode(MazeCell(x - 1, y))]??.vertex == thisCell
                let topCellIsConnectedToThisCell = maze.graph.graph[AdjacencyListNode(MazeCell(x, y - 1))]??.vertex == thisCell
                
                // if relative direction between cell and connection is north, south, east, west draw the correct walls
                
                if (y != maze.size.y) {
                    if (direction != .West) && !(leftCellIsConnectedToThisCell) {
                        line.move(to: CGPoint(x: currentX, y: currentY))
                        line.addLine(to: CGPoint(x: currentX, y: currentY + cellSize))
                    }
                }
                
                if (x != maze.size.x) {
                    if (direction != .South) && !(topCellIsConnectedToThisCell) {
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
