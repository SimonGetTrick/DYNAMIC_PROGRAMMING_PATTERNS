//
//  3.5.Mediator.swift
//  Dynamic_Examples
//
//  Created by Simon Getrik on 14.05.2025.
//

import Foundation
import Foundation

// MARK: - Mediator Pattern
// The Mediator Pattern centralizes communication between objects, reducing dependencies between them.

protocol Mediator {
    func send(message: String, from colleague: Colleague)
}

// Base class for colleagues that communicate via the Mediator
class Colleague {
    private let mediator: Mediator
    private let name: String
    
    init(name: String, mediator: Mediator) {
        self.name = name
        self.mediator = mediator
    }
    
    func send(message: String) {
        print("\(name) sends: \(message)")
        mediator.send(message: message, from: self)
    }
    
    func receive(message: String) {
        print("\(name) receives: \(message)")
    }
}

// Concrete Mediator implementation
class ChatRoom: Mediator {
    private var colleagues = [Colleague]()
    
    func addColleague(_ colleague: Colleague) {
        colleagues.append(colleague)
    }
    
    func send(message: String, from colleague: Colleague) {
        for c in colleagues {
            // Send message to all except sender
            if c !== colleague {
                c.receive(message: message)
            }
        }
    }
}

// Client code to test the Mediator pattern
func demo_MediatorPattern() {
    print("\n=== Mediator Pattern ===\n")
    
    let chatRoom = ChatRoom()
    
    let alice = Colleague(name: "Alice", mediator: chatRoom)
    let bob = Colleague(name: "Bob", mediator: chatRoom)
    let charlie = Colleague(name: "Charlie", mediator: chatRoom)
    
    chatRoom.addColleague(alice)
    chatRoom.addColleague(bob)
    chatRoom.addColleague(charlie)
    
    alice.send(message: "Hi everyone!")
    bob.send(message: "Hello Alice!")
}


