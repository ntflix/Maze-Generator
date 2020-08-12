//
//  Adjacency List.swift
//  GoreGraphicsStuff
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
    var graph: [AdjacencyListNode<T>? : AdjacencyListNode<T>?]
    
    init(_ size: Int) {
        self.size = size
        self.graph = [AdjacencyListNode<T>? : AdjacencyListNode<T>?]()
    }
    
    func addEdge(from: T, to: T, directed: Bool = false) {
        self.graph[AdjacencyListNode(from)] = AdjacencyListNode(to)
        
        if !directed {
            self.graph[AdjacencyListNode(to)] = AdjacencyListNode(from)
        }
    }
}

extension AdjacencyList: CustomDebugStringConvertible {
    public var debugDescription: String {
        var result = ""
        for item in graph.keys {
            result += "\(item?.vertex) -> \(graph[item]!?.vertex)"
            result += "\n"
        }
        return result
    }
}

extension AdjacencyList: CustomStringConvertible {
    public var description: String {
        var result = ""
        for item in graph.keys {
            result += "\(item!.vertex) -> \(graph[item]!!.vertex)"
            result += "\n"
        }
        return result
    }
}
