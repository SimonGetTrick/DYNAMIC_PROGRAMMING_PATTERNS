//
//  2.2.Bridge.swift
//  Dynamic_Examples
//
//  Created by Simon Getrik on 12.05.2025.
//

import Foundation

// MARK: - Bridge Pattern
// The Bridge pattern decouples an abstraction from its implementation,
// allowing them to vary independently.

// Protocol defining the implementation interface
protocol Renderer {
    func renderCircle(radius: Double)
    func renderSquare(side: Double)
}

// Concrete implementation for console rendering
class ConsoleRenderer: Renderer {
    func renderCircle(radius: Double) {
        print("Console: Rendering circle with radius \(radius)")
    }
    
    func renderSquare(side: Double) {
        print("Console: Rendering square with side \(side)")
    }
}

// Concrete implementation for UI rendering
class UIRenderer: Renderer {
    func renderCircle(radius: Double) {
        print("UI: Rendering circle with radius \(radius) on screen")
    }
    
    func renderSquare(side: Double) {
        print("UI: Rendering square with side \(side) on screen")
    }
}

// Abstraction defining the high-level interface
class Shape {
    internal let renderer: Renderer
    
    init(renderer: Renderer) {
        self.renderer = renderer
    }
    
    func draw() {
        // Default implementation, to be overridden by subclasses
    }
}

// Refined abstraction for a circle
class Circle: Shape {
    private let radius: Double
    
    init(radius: Double, renderer: Renderer) {
        self.radius = radius
        super.init(renderer: renderer)
    }
    
    override func draw() {
        renderer.renderCircle(radius: radius)
    }
}

// Refined abstraction for a square
class Square: Shape {
    private let side: Double
    
    init(side: Double, renderer: Renderer) {
        self.side = side
        super.init(renderer: renderer)
    }
    
    override func draw() {
        renderer.renderSquare(side: side)
    }
}

// Demo function to showcase the Bridge pattern
func demo_BridgePattern() {
    // Use ConsoleRenderer
    let consoleRenderer = ConsoleRenderer()
    let consoleCircle = Circle(radius: 5.0, renderer: consoleRenderer)
    let consoleSquare = Square(side: 4.0, renderer: consoleRenderer)
    
    print("Drawing with Console Renderer:")
    consoleCircle.draw()
    consoleSquare.draw()
    
    // Use UIRenderer
    let uiRenderer = UIRenderer()
    let uiCircle = Circle(radius: 3.0, renderer: uiRenderer)
    let uiSquare = Square(side: 6.0, renderer: uiRenderer)
    
    print("\nDrawing with UI Renderer:")
    uiCircle.draw()
    uiSquare.draw()
}

