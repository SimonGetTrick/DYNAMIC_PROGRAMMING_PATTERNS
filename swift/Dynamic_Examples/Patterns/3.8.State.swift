//
//  3.8.State.swift
//  Dynamic_Examples
//
//  Created by Simon Getrik on 14.05.2025.
//

import Foundation

// MARK: - State Pattern
// The State Pattern allows an object to alter its behavior when its internal state changes.

// Protocol defining the state interface
protocol State {
    func handle(context: Context)
}

// Concrete States implementing different behaviors
class NormalState: State {
    func handle(context: Context) {
        print("State: Normal - Button is enabled and ready.")
        context.setState(self)
    }
}

class HighlightedState: State {
    func handle(context: Context) {
        print("State: Highlighted - Button is pressed/highlighted.")
        context.setState(self)
    }
}

class DisabledState: State {
    func handle(context: Context) {
        print("State: Disabled - Button is disabled and not interactive.")
        context.setState(self)
    }
}

// Context that maintains a reference to the current state
class Context {
    private var state: State
    
    init(state: State) {
        self.state = state
    }
    
    func setState(_ state: State) {
        self.state = state
    }
    
    func request() {
        state.handle(context: self)
    }
}

// Client code to test the State pattern
func demo_StatePattern() {
    print("\n=== State Pattern ===\n")
    
    let context = Context(state: NormalState())
    context.request()  // Output: Normal state behavior
    
    context.setState(HighlightedState())
    context.request()  // Output: Highlighted state behavior
    
    context.setState(DisabledState())
    context.request()  // Output: Disabled state behavior
}
