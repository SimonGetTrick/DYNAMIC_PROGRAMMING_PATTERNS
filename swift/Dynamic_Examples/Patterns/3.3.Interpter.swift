//
//  3.3.Interpter.swift
//  Dynamic_Examples
//
//  Created by Simon Getrik on 14.05.2025.
//

import Foundation

// MARK: - Interpreter Pattern
// The Interpreter Pattern defines a grammar for interpreting expressions and provides an interpreter for evaluating them.

protocol Expression {
    func interpret() -> Int
}

// Concrete expression: Represents a number in the grammar
class NumberExpression: Expression {
    private var number: Int
    
    init(number: Int) {
        self.number = number
    }
    
    func interpret() -> Int {
        return number  // Simply returns the number itself
    }
}

// Concrete expression: Represents addition in the grammar
class AdditionExpression: Expression {
    private var left: Expression
    private var right: Expression
    
    init(left: Expression, right: Expression) {
        self.left = left
        self.right = right
    }
    
    func interpret() -> Int {
        return left.interpret() + right.interpret()  // Adds the results of left and right expressions
    }
}

// Concrete expression: Represents subtraction in the grammar
class SubtractionExpression: Expression {
    private var left: Expression
    private var right: Expression
    
    init(left: Expression, right: Expression) {
        self.left = left
        self.right = right
    }
    
    func interpret() -> Int {
        return left.interpret() - right.interpret()  // Subtracts the right expression from the left
    }
}

// Client code to test the Interpreter pattern
func demo_InterpreterPattern() {
    print("\n=== Interpreter Pattern ===\n")
    
    // Expression: (5 + 10) - 3
    let five = NumberExpression(number: 5)
    let ten = NumberExpression(number: 10)
    let three = NumberExpression(number: 3)
    
    let addition = AdditionExpression(left: five, right: ten)
    let subtraction = SubtractionExpression(left: addition, right: three)
    
    // Evaluating the expression
    let result = subtraction.interpret()
    print("Result of (5 + 10) - 3 = \(result)")  // Output: 12
}


