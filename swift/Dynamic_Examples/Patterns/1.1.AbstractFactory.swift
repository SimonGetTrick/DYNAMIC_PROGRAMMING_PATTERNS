//
//  AbstractFactory.swift
//  Dynamic_Examples
//
//  Created by Simon Getrik on 11.05.2025.
//

import Foundation

// Namespace-like structure for Abstract Factory pattern
struct AbstractFactory {
    // Protocol for passenger vehicle product
    protocol PassengerVehicle {
        func drive()
    }
    
    // Concrete product: CompactVehicle
    class CompactVehicle: PassengerVehicle {
        func drive() {
            print("Driving a compact vehicle")
        }
    }
    
    // Concrete product: FullSizeVehicle
    class FullSizeVehicle: PassengerVehicle {
        func drive() {
            print("Driving a full-size vehicle")
        }
    }
    
    // Protocol for public transport product
    protocol PublicTransport {
        func drive()
    }
    
    // Concrete product: CompactBus
    class CompactBus: PublicTransport {
        func drive() {
            print("Driving a compact bus")
        }
    }
    
    // Concrete product: FullSizeBus
    class FullSizeBus: PublicTransport {
        func drive() {
            print("Driving a full-size bus")
        }
    }
    
    // Abstract factory protocol
    protocol TransportFactory {
        func producePassengerVehicle() -> PassengerVehicle
        func producePublicTransport() -> PublicTransport
    }
    
    // Concrete factory for compact vehicles and buses
    class CompactTransportFactory: TransportFactory {
        // Create compact vehicle
        func producePassengerVehicle() -> PassengerVehicle {
            print("Compact vehicle is created")
            return CompactVehicle()
        }
        
        // Create compact bus
        func producePublicTransport() -> PublicTransport {
            print("Compact bus is created")
            return CompactBus()
        }
    }
    
    // Concrete factory for full-size vehicles and buses
    class FullSizeTransportFactory: TransportFactory {
        // Create full-size vehicle
        func producePassengerVehicle() -> PassengerVehicle {
            print("Full-size vehicle is created")
            return FullSizeVehicle()
        }
        
        // Create full-size bus
        func producePublicTransport() -> PublicTransport {
            print("Full-size bus is created")
            return FullSizeBus()
        }
    }
    
    // Demo function to showcase Abstract Factory
    static func demo_pattert_1_1_AbstractFactory() {
        let compactFactory: TransportFactory = CompactTransportFactory()
        let compactVehicle = compactFactory.producePassengerVehicle()
        let compactBus = compactFactory.producePublicTransport()
        compactVehicle.drive() // Output: Driving a compact vehicle
        compactBus.drive() // Output: Driving a compact bus
        
        let fullSizeFactory: TransportFactory = FullSizeTransportFactory()
        let fullSizeVehicle = fullSizeFactory.producePassengerVehicle()
        let fullSizeBus = fullSizeFactory.producePublicTransport()
        fullSizeVehicle.drive() // Output: Driving a full-size vehicle
        fullSizeBus.drive() // Output: Driving a full-size bus
    }
}


