//
//  Adjacency List.swift
//  MazeGenerator
//
//  Created by Felix Weber on 07/08/2020.
//  Copyright © 2020 iron59. All rights reserved.
//

struct AdjacencyListNode <T: Hashable>: Hashable {
    let vertex: T
    var next: T?
    
    init(_ value: T, next: T? = nil) {
        self.vertex = value
        self.next = next
    }
}

class AdjacencyList <T: Hashable> {
    let size: Int
    var graph: [AdjacencyListNode<T>? : [AdjacencyListNode<T>?]]
    
    init(_ size: Int) {
        self.size = size
        self.graph = [AdjacencyListNode<T>? : [AdjacencyListNode<T>?]]()
    }
    
    private func link(_ a: T, _ b: T) {
        if let _ = self.graph[AdjacencyListNode(a)] {
            var list = self.graph[AdjacencyListNode(a)]
            list?.append(AdjacencyListNode(b))
            self.graph[AdjacencyListNode(a)] = list
        } else {
            self.graph[AdjacencyListNode(a)] = [AdjacencyListNode(b)]
        }
    }
    
    func addEdge(from: T, to: T, directed: Bool = false) {
        self.link(from, to)
        
        if !directed {
            self.link(to, from)
        }
    }
}

extension AdjacencyList: CustomDebugStringConvertible {
    public var debugDescription: String {
        var lines = [String]()
        for item in graph.keys {
            let line = "\(item!.vertex)  -> \(graph[item]!.map { $0!.vertex })"
            lines.append(line)
        }
        
        var result = ""
        lines.sorted().forEach { line in
            result += line
            result += "\n"
        }
        
        return result
    }
}
//
//extension AdjacencyList: CustomStringConvertible {
//    public var description: String {
//        var result = ""
//        for item in graph.keys {
//            result += "\(item!.vertex) -> \(graph[item]!!.vertex)"
//            result += "\n"
//        }
//        return result
//    }
//}
