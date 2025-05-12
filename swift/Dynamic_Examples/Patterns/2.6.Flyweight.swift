//
//  2.6.Flyweight.swift
//  Dynamic_Examples
//
//  Created by Simon Getrik on 12.05.2025.
//

import Foundation

// MARK: - Flyweight Pattern
// The Flyweight pattern saves memory by sharing the intrinsic state of small objects,
// allowing multiple objects to reuse the same shared data.

// Struct to represent the intrinsic (shared) state of an icon
struct IconData {
    let type: String
    let color: String
}

// Flyweight class that holds the shared intrinsic state
class IconFlyweight {
    private let data: IconData
    
    init(type: String, color: String) {
        self.data = IconData(type: type, color: color)
    }
    
    // Method to render the icon with extrinsic (context-specific) state
    func render(at position: (x: Int, y: Int)) {
        print("Rendering \(data.type) icon with color \(data.color) at position (\(position.x), \(position.y))")
    }
}

// Factory to manage and share flyweight objects
class IconFlyweightFactory {
    private var flyweights: [String: IconFlyweight] = [:]
    
    // Get or create a flyweight for the given intrinsic state
    func getIcon(type: String, color: String) -> IconFlyweight {
        let key = "\(type)_\(color)"
        if let existingFlyweight = flyweights[key] {
            return existingFlyweight
        } else {
            let newFlyweight = IconFlyweight(type: type, color: color)
            flyweights[key] = newFlyweight
            return newFlyweight
        }
    }
    
    // Get the number of unique flyweights created
    var flyweightCount: Int {
        return flyweights.count
    }
}

// Client class that uses flyweights to render icons
class IconRenderer {
    private let factory: IconFlyweightFactory
    
    init(factory: IconFlyweightFactory) {
        self.factory = factory
    }
    
    // Render an icon at a specific position
    func renderIcon(type: String, color: String, position: (x: Int, y: Int)) {
        let icon = factory.getIcon(type: type, color: color)
        icon.render(at: position)
    }
}

// Demo function to showcase the Flyweight pattern
func demo_FlyweightPattern() {
    let factory = IconFlyweightFactory()
    let renderer = IconRenderer(factory: factory)
    
    // Render multiple icons with shared intrinsic state
    renderer.renderIcon(type: "star", color: "red", position: (x: 10, y: 20))
    renderer.renderIcon(type: "star", color: "red", position: (x: 15, y: 25))
    renderer.renderIcon(type: "circle", color: "blue", position: (x: 30, y: 40))
    renderer.renderIcon(type: "star", color: "red", position: (x: 50, y: 60))
    
    // Show the number of unique flyweights created
    print("\nTotal unique flyweights created: \(factory.flyweightCount)")
}

