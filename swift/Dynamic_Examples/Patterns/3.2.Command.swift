//
//  3.2.Command.swift
//  Dynamic_Examples
//
//  Created by Simon Getrik on 14.05.2025.
//

import Foundation

// MARK: - Command Pattern
// The Command Pattern encapsulates a request as an object, allowing the request to be passed, executed, and undone.

protocol Command {
    func execute()  // Executes the command
    func undo()     // Undoes the command
}

// Concrete Command: A specific command that implements the Command protocol
class LightOnCommand: Command {
    private var light: Light
    
    init(light: Light) {
        self.light = light
    }
    
    func execute() {
        light.turnOn()  // Executes the action (turning on the light)
    }
    
    func undo() {
        light.turnOff()  // Undoes the action (turning off the light)
    }
}

class LightOffCommand: Command {
    private var light: Light
    
    init(light: Light) {
        self.light = light
    }
    
    func execute() {
        light.turnOff()  // Executes the action (turning off the light)
    }
    
    func undo() {
        light.turnOn()  // Undoes the action (turning on the light)
    }
}

// Receiver: The object that performs the actual action
class Light {
    func turnOn() {
        print("The light is ON.")
    }
    
    func turnOff() {
        print("The light is OFF.")
    }
}

// Invoker: The object that calls the command
class RemoteControl {
    private var command: Command?
    
    func setCommand(command: Command) {
        self.command = command
    }
    
    func pressButton() {
        command?.execute()  // Executes the command
    }
    
    func pressUndo() {
        command?.undo()     // Undoes the command
    }
}

// Client code to test the Command pattern
func demo_CommandPattern() {
    print("\n=== Command Pattern ===\n")
    
    let light = Light()  // Receiver
    let lightOn = LightOnCommand(light: light)  // Command to turn light on
    let lightOff = LightOffCommand(light: light)  // Command to turn light off
    
    let remote = RemoteControl()
    
    // Turning the light on using the remote
    remote.setCommand(command: lightOn)
    remote.pressButton()  // Output: The light is ON.
    
    // Turning the light off using the remote
    remote.setCommand(command: lightOff)
    remote.pressButton()  // Output: The light is OFF.
    
    // Undo the last action (turn the light back on)
    remote.pressUndo()  // Output: The light is ON.
}


