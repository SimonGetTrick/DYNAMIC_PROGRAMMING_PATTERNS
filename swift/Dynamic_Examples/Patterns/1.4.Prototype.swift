//
//  1.4.Prototype.swift
//  Dynamic_Examples
//
//  Created by Simon Getrik on 12.05.2025.
//

import Foundation

// MARK: - Prototype Pattern
// The Prototype pattern creates new objects by copying an existing prototype, minimizing the cost of creation.

// Protocol defining the cloning capability for the prototype
protocol Cloneable {
    func clone() -> Self
}

// Class representing a game character with settings that can be cloned
final class GameCharacter: Cloneable {
    var name: String
    var health: Int
    var level: Int
    var abilities: [String]
    
    init(name: String, health: Int, level: Int, abilities: [String]) {
        self.name = name
        self.health = health
        self.level = level
        self.abilities = abilities
    }
    
    private init(character: GameCharacter) {
        self.name = character.name
        self.health = character.health
        self.level = character.level
        self.abilities = character.abilities
    }
    
    // Implement the clone method to create a copy of the character
    func clone() -> GameCharacter {
        return GameCharacter(character: self)
    }
    
    // Method to update the character's name
    @discardableResult
    func setName(_ name: String) -> Self {
        self.name = name
        return self
    }
    
    // Method to describe the character's details
    func describe() -> String {
        return """
        Character:
        - Name: \(name)
        - Health: \(health)
        - Level: \(level)
        - Abilities: \(abilities.joined(separator: ", "))
        """
    }
}

// Demo function to showcase the Prototype pattern
func demo_PrototypePattern() {
    // Create a base character as the prototype
    let baseCharacter = GameCharacter(
        name: "Warrior",
        health: 100,
        level: 1,
        abilities: ["Slash"]
    )
    print("Base Character:")
    print(baseCharacter.describe())
    
    // Clone and modify for Player 1
    let player1Character = baseCharacter.clone()
        .setName("Player 1")
    print("\nPlayer 1 Character (cloned and modified):")
    print(player1Character.describe())
}

