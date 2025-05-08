//
//  Strategy.swift
//  Dynamic_Examples
//
//  Created by Simon Getrik on 08.05.2025.
//

import Foundation
protocol SwimBehavior {
    
    func swim()
}

class ProfessionalSwimmer: SwimBehavior {
    
    func swim() {
        print("professional swimming")
    }
}

class NonSwimmer: SwimBehavior {
    
    func swim() {
        print("non-swimming")
    }
}

protocol DiveBehavior {
    
    func dive()
}


class ProfessionalDiver: DiveBehavior {
    
    func dive() {
        print("professional diving")
    }
}


class NewbieDiver: DiveBehavior {
    
    func dive() {
        print("newbie diving")
    }
}

class NonDiver: DiveBehavior {
    
    func dive() {
        print("non-diving")
    }
}


class Human {
    
    private var diveBehavior: DiveBehavior!
    private var swimBehavior: SwimBehavior!
    
    func performSwim() {
        
        swimBehavior.swim()
    }
    
    func performDive() {
        
        diveBehavior.dive()
    }
    
    func setSwimBehavior(sb: SwimBehavior) {
        
        self.swimBehavior = sb
    }
    
    func setDiveBehavior(db: DiveBehavior) {
        
        self.diveBehavior = db
    }
    
    func run() {
        
        print("running")
    }
    
    init(swimBehavior: SwimBehavior, diveBehavior: DiveBehavior) {
        self.swimBehavior = swimBehavior
        self.diveBehavior = diveBehavior
    }
}

func demo_strategy() {
    print("\n=== Strategy ===\n")
    let human = Human(swimBehavior: ProfessionalSwimmer(), diveBehavior: ProfessionalDiver())
    human.setSwimBehavior(sb: NonSwimmer())
    human.performDive()
    human.performSwim()
}

