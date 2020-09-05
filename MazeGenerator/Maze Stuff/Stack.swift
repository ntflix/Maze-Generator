//
//  Stack.swift
//  MazeGenerator
//
//  Created by Felix Weber on 07/08/2020.
//  Copyright © 2020 iron59. All rights reserved.
//

class Stack<T> {
    var stack = [T?]()
    var top = -1
    
    var isEmpty: Bool { return top == -1 }
    
    func pop() -> T? {
        if !self.isEmpty {
            let item = self.stack[self.top]
            self.stack[self.top] = nil
            self.top -= 1
            return item
        }
        return nil
    }
    
    func peek() -> T? {
        if !self.isEmpty {
            return self.stack[self.top]
        }
        return nil
    }
    
    func push(_ item: T) {
        self.top += 1
        if self.stack.count <= self.top {
            self.stack.append(item)
        } else {
            self.stack[self.top] = item
        }
    }
}
