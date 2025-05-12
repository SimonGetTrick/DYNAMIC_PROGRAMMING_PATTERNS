//
//  FactoryMethod.swift
//  Dynamic_Examples
//
//  Created by Simon Getrik on 11.05.2025.
//

import Foundation
import Foundation

// Namespace-like structure for Factory Method pattern
struct FactoryMethod {
    // Protocol for product
    protocol Transport {
        func drive()
    }
    
    // Concrete product: Truck
    class Truck: Transport {
        func drive() {
            print("Driving a truck")
        }
    }
    
    // Concrete product: Motorcycle
    class Motorcycle: Transport {
        func drive() {
            print("Riding a motorcycle")
        }
    }
    
    // Creator protocol with factory method
    protocol TransportFactory {
        func createTransport() -> Transport
    }
    
    // Concrete creator for Truck
    class TruckFactory: TransportFactory {
        // Factory method to create Truck
        func createTransport() -> Transport {
            return Truck()
        }
    }
    
    // Concrete creator for Motorcycle
    class MotorcycleFactory: TransportFactory {
        // Factory method to create Motorcycle
        func createTransport() -> Transport {
            return Motorcycle()
        }
    }
    
    // Demo function to showcase Factory Method
    static func demo_FactoryMethod() {
        let truckFactory: TransportFactory = TruckFactory()
        let truck = truckFactory.createTransport()
        truck.drive() // Output: Driving a truck
        
        let motorcycleFactory: TransportFactory = MotorcycleFactory()
        let motorcycle = motorcycleFactory.createTransport()
        motorcycle.drive() // Output: Riding a motorcycle
    }
}


