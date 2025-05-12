//
//  SimpleFactory.swift
//  Dynamic_Examples
//
//  Created by Simon Getrik on 10.05.2025.
//

import Foundation

enum AutomobileType {
    case big, speedy
}

// Protocol for automobile
protocol Automobile {
    func drive()
}

// Concrete product: BigAutomobile
class BigAutomobile: Automobile {
    func drive() {
        print("You drive a big automobile")
    }
}

// Concrete product: SpeedyAutomobile
class SpeedyAutomobile: Automobile {
    func drive() {
        print("You drive a speedy automobile")
    }
}

// Factory class to produce automobiles
class AutomobileFactory {
    static func produceAutomobile(type: AutomobileType) -> Automobile {
        var automobile: Automobile
        
        switch type {
        case .speedy:
            automobile = SpeedyAutomobile()
        case .big:
            automobile = BigAutomobile()
        }
        
        return automobile
    }
}

// Demo function to test the factory
func demo_SimpleFactory() {
    let bigAutomobile = BigAutomobile()
    bigAutomobile.drive()
    
    let speedyAutomobile = SpeedyAutomobile()
    speedyAutomobile.drive()
    
    let bigAutomobile1 = AutomobileFactory.produceAutomobile(type: .big)
    let speedyAutomobile1 = AutomobileFactory.produceAutomobile(type: .speedy)
    print(" \(bigAutomobile1 is BigAutomobile) \(speedyAutomobile1 is SpeedyAutomobile)")
}
