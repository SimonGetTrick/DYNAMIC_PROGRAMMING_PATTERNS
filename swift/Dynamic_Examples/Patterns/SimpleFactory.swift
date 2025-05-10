//
//  SimpleFactory.swift
//  Dynamic_Examples
//
//  Created by Simon Getrik on 10.05.2025.
//

import Foundation

enum CarType {
    case huge, fast
}

protocol Car {
    
    func drive()
}

class HugeCar: Car {
    
    func drive() {
        
        print("you drive huge car")
    }
}

class FastCar: Car {
    
    func drive() {
        
        print("you drive fast car")
    }
}


class CarFactory {
    
    static func produceCar(type: CarType) -> Car {
        var car: Car
        
        switch type {
        case .fast: car = FastCar()
        case .huge: car = HugeCar()
        }
        
        return car
    }
}

func demo_SimpleFactory() {
    let hugeCar = HugeCar()
    hugeCar.drive()
    
    let fastCar = FastCar()
    fastCar.drive()
    
    let hugeCar1 = CarFactory.produceCar(type: .huge)
    let fastCar1 = CarFactory.produceCar(type: .fast)
    print(" \(hugeCar1 is HugeCar) \(fastCar1 is FastCar)")
}


