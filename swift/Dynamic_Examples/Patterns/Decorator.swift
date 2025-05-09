//
//  Decorator.swift
//  Dynamic_Examples
//
//  Created by Simon Getrik on 09.05.2025.
//

import Foundation

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
