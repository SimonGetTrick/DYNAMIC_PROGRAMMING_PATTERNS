//
//  FactoryMethod.swift
//  Dynamic_Examples
//
//  Created by Simon Getrik on 11.05.2025.
//

import Foundation
// Protocol for product
protocol Vehicle {
    func drive()
}

// Concrete product: Car
class Car: Vehicle {
    func drive() {
        print("Driving a car")
    }
}

// Concrete product: Bike
class Bike: Vehicle {
    func drive() {
        print("Riding a bike")
    }
}

// Creator protocol with factory method
protocol VehicleFactory {
    func createVehicle() -> Vehicle
}

// Concrete creator for Car
class CarFactory: VehicleFactory {
    // Factory method to create Car
    func createVehicle() -> Vehicle {
        return Car()
    }
}

// Concrete creator for Bike
class BikeFactory: VehicleFactory {
    // Factory method to create Bike
    func createVehicle() -> Vehicle {
        return Bike()
    }
}

// Demo function to test the factoryMethode
func demo_factoryMethode() {
    
    let carFactory: VehicleFactory = CarFactory()
    let car = carFactory.createVehicle()
    car.drive() // Output: Driving a car
    
    let bikeFactory: VehicleFactory = BikeFactory()
    let bike = bikeFactory.createVehicle()
    bike.drive() // Output: Riding a bike
}
