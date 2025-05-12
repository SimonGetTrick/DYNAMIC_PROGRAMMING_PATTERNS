//
//  Decorator.swift
//  Dynamic_Examples
//
//  Created by Simon Getrik on 09.05.2025.
//

import Foundation

// MARK: - Decorator Pattern
// The Decorator pattern allows behavior to be added to objects dynamically by wrapping them
// in an object of a decorator class, providing a flexible alternative to subclassing.

protocol Porsche {
    
    func getPrice() -> Double
    func getDescription() -> String
}


class Boxster: Porsche {
    
    func getPrice() -> Double {
        return 120
    }
    
    func getDescription() -> String {
        return "Porsche Boxster"
    }
}


class PorscheDecorator: Porsche {
    
    private let decoratedPorsche: Porsche
    
    required init(dp: Porsche) {
        self.decoratedPorsche = dp
    }
    
    func getPrice() -> Double {
        return decoratedPorsche.getPrice()
    }
    
    func getDescription() -> String {
        return decoratedPorsche.getDescription()
    }
}


class PremiumAudioSystem: PorscheDecorator {
    
    required init(dp: Porsche) {
        super.init(dp: dp)
    }
    
    override func getPrice() -> Double {
        return super.getPrice() + 30
    }
    
    override func getDescription() -> String {
        return super.getDescription() + " with premium audio system"
    }
}


class PanoramicSunroof: PorscheDecorator {
    
    required init(dp: Porsche) {
        super.init(dp: dp)
    }
    
    override func getPrice() -> Double {
        return super.getPrice() + 20
    }
    
    override func getDescription() -> String {
        return super.getDescription() + " with panoramic sunroof"
    }
}

func demo_Decorator() {
    print("\n=== Decorator ===\n")
    var porscheBoxster: Porsche = Boxster()
    _ = porscheBoxster.getDescription()
    _ = porscheBoxster.getPrice()
    
    _ = porscheBoxster = PremiumAudioSystem(dp: porscheBoxster)
    _ = porscheBoxster.getDescription()
    _ = porscheBoxster.getPrice()
    
    _ = porscheBoxster = PanoramicSunroof(dp: porscheBoxster)
    _ = porscheBoxster.getDescription()
    _ = porscheBoxster.getPrice()
}

// Protocol defining the interface for beverages
protocol Beverage {
    func getDescription() -> String
    func cost() -> Double
}

// Concrete component: Base beverage (Espresso)
class Espresso: Beverage {
    // Returns the description of the beverage
    func getDescription() -> String {
        return "Espresso"
    }
    
    // Returns the cost of the beverage
    func cost() -> Double {
        return 2.0
    }
    
    // Logs deallocation for ARC tracking
    deinit {
        print("Espresso deallocated")
    }
}

// Abstract decorator implementing Beverage
class BeverageDecorator: Beverage {
    // Reference to the wrapped beverage
    private let wrappedBeverage: Beverage
    
    // Initialize with a beverage to wrap
    init(beverage: Beverage) {
        self.wrappedBeverage = beverage
    }
    
    // Delegate description to wrapped beverage
    func getDescription() -> String {
        return wrappedBeverage.getDescription()
    }
    
    // Delegate cost to wrapped beverage
    func cost() -> Double {
        return wrappedBeverage.cost()
    }
    
    // Logs deallocation for ARC tracking
    deinit {
        print("BeverageDecorator deallocated")
    }
}

// Concrete decorator: Adds milk to the beverage
class Milk: BeverageDecorator {
    // Append milk to the description
    override func getDescription() -> String {
        return super.getDescription() + ", Milk"
    }
    
    // Add milk cost to the total
    override func cost() -> Double {
        return super.cost() + 0.5
    }
    
    // Logs deallocation for ARC tracking
    deinit {
        print("Milk deallocated")
    }
}

// Concrete decorator: Adds syrup to the beverage
class Syrup: BeverageDecorator {
    // Append syrup to the description
    override func getDescription() -> String {
        return super.getDescription() + ", Syrup"
    }
    
    // Add syrup cost to the total
    override func cost() -> Double {
        return super.cost() + 0.7
    }
    
    // Logs deallocation for ARC tracking
    deinit {
        print("Syrup deallocated")
    }
}

// Concrete decorator: Adds whipped cream to the beverage
class WhippedCream: BeverageDecorator {
    // Append whipped cream to the description
    override func getDescription() -> String {
        return super.getDescription() + ", Whipped Cream"
    }
    
    // Add whipped cream cost to the total
    override func cost() -> Double {
        return super.cost() + 1.0
    }
    
    // Logs deallocation for ARC tracking
    deinit {
        print("WhippedCream deallocated")
    }
}

// Demo function to showcase the Decorator pattern
func demo_decorator() {
    print("\n=== Decorator ===\n")
    
    // Create a base beverage
    var beverage: Beverage = Espresso()
    print("Order: \(beverage.getDescription()), Cost: $\(beverage.cost())")
    
    // Add milk decorator
    beverage = Milk(beverage: beverage)
    print("Order: \(beverage.getDescription()), Cost: $\(beverage.cost())")
    
    // Add syrup decorator
    beverage = Syrup(beverage: beverage)
    print("Order: \(beverage.getDescription()), Cost: $\(beverage.cost())")
    
    // Add whipped cream decorator
    beverage = WhippedCream(beverage: beverage)
    print("Order: \(beverage.getDescription()), Cost: $\(beverage.cost())")
    
    // Explicitly release to demonstrate ARC
    beverage = Espresso()
}
