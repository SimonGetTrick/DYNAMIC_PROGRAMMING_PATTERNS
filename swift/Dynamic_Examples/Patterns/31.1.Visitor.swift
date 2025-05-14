//
//  31.1.Visitor.swift
//  Dynamic_Examples
//
//  Created by Simon Getrik on 14.05.2025.
//

import Foundation

// MARK: - Visitor Pattern
// The Visitor Pattern lets you separate algorithms from the objects on which they operate.

// Protocol for elements that can be "visited"
protocol Visitable {
    func accept(visitor: Visitor)
}

// Protocol for visitor, который выполняет операции над элементами
protocol Visitor {
    func visit(element: ConcreteElementA)
    func visit(element: ConcreteElementB)
}

// Конкретные элементы, поддерживающие Visitor
class ConcreteElementA: Visitable {
    let value = "Element A data"
    
    func accept(visitor: Visitor) {
        visitor.visit(element: self)
    }
}

class ConcreteElementB: Visitable {
    let value = "Element B data"
    
    func accept(visitor: Visitor) {
        visitor.visit(element: self)
    }
}

// Конкретный Visitor, реализующий операцию над элементами
class ConcreteVisitor: Visitor {
    func visit(element: ConcreteElementA) {
        print("Visiting ConcreteElementA: \(element.value)")
    }
    
    func visit(element: ConcreteElementB) {
        print("Visiting ConcreteElementB: \(element.value)")
    }
}

// Client code to test the Visitor pattern
func demo_VisitorPattern() {
    print("\n=== Visitor Pattern ===\n")
    
    let elements: [Visitable] = [ConcreteElementA(), ConcreteElementB()]
    let visitor = ConcreteVisitor()
    
    for element in elements {
        element.accept(visitor: visitor)  // Каждый элемент "принимает" посетителя
    }
}



