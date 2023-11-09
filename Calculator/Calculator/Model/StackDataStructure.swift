//
//  StackDataStructure.swift
//  Calculator
//
//  Created by Ashot Hovhannisyan on 13.09.23.
//

import Foundation

struct Stack<T> {
    
    private var stackArray:[T] = [T]()
    
    mutating func push(_ item:T) {
        stackArray.append(item)
    }
    
    @discardableResult mutating func pop() -> T? {
        if stackArray.count != 0 {
            let last = stackArray[stackArray.count - 1]
            stackArray.removeLast()
            return last
        } else {
            return nil
        }
    }
    
    func top() -> T? {
        if stackArray.count != 0 {
            let last = stackArray[stackArray.count - 1]
            return last
        } else {
            return nil
        }
    }
   
    func isEmpty() -> Bool {
        return self.stackArray.isEmpty
    }
    
}
