//
//  3.6.Memento.swift
//  Dynamic_Examples
//
//  Created by Simon Getrik on 14.05.2025.
//

import Foundation

// MARK: - Memento Pattern
// The Memento Pattern saves and restores the internal state of an object without exposing its implementation details.

// Originator: The object whose state needs to be saved and restored
class TextEditor {
    private var text: String = ""
    
    func write(_ newText: String) {
        text += newText
    }
    
    func getText() -> String {
        return text
    }
    
    func save() -> Memento {
        return Memento(state: text)
    }
    
    func restore(memento: Memento) {
        self.text = memento.getState()
    }
}

// Memento: Stores the internal state of the Originator
class Memento {
    private let state: String
    
    init(state: String) {
        self.state = state
    }
    
    func getState() -> String {
        return state
    }
}

// Caretaker: Manages saving and restoring Memento objects
class Caretaker {
    private var mementos = [Memento]()
    
    func save(state: Memento) {
        mementos.append(state)
    }
    
    func undo() -> Memento? {
        guard !mementos.isEmpty else { return nil }
        return mementos.removeLast()
    }
}

// Client code to test the Memento pattern
func demo_MementoPattern() {
    print("\n=== Memento Pattern ===\n")
    
    let editor = TextEditor()
    let caretaker = Caretaker()
    
    editor.write("Hello, ")
    caretaker.save(state: editor.save())  // Save state
    
    editor.write("world!")
    print("Current text: \(editor.getText())")  // Output: Hello, world!
    
    if let previousState = caretaker.undo() {
        editor.restore(memento: previousState)  // Restore to previous state
    }
    
    print("After undo: \(editor.getText())")  // Output: Hello,
}



