//
//  2.1.Adapter.swift
//  Dynamic_Examples
//
//  Created by Simon Getrik on 12.05.2025.
//

import Foundation

// MARK: - Adapter Pattern
// The Adapter pattern converts the interface of a class into another interface that a client expects,
// allowing incompatible interfaces to work together.

// Protocol defining the modern payment interface for Adapter
protocol AdapterPaymentProcessor {
    func processPayment(amount: Double) -> String
    func refundPayment(amount: Double) -> String
}

// Legacy payment system with an incompatible interface
class LegacyPaymentSystem {
    func makePayment(sum: Double) -> String {
        return "Legacy payment of \(sum) processed."
    }
    
    func cancelPayment(sum: Double) -> String {
        return "Legacy refund of \(sum) initiated."
    }
}

// Adapter class to bridge LegacyPaymentSystem with AdapterPaymentProcessor
class PaymentAdapter: AdapterPaymentProcessor {
    private let legacySystem: LegacyPaymentSystem
    
    init(legacySystem: LegacyPaymentSystem) {
        self.legacySystem = legacySystem
    }
    
    // Adapt processPayment to legacy makePayment
    func processPayment(amount: Double) -> String {
        return legacySystem.makePayment(sum: amount)
    }
    
    // Adapt refundPayment to legacy cancelPayment
    func refundPayment(amount: Double) -> String {
        return legacySystem.cancelPayment(sum: amount)
    }
}

// Demo function to showcase the Adapter pattern
func demo_AdapterPattern() {
    // Create an instance of the legacy payment system
    let legacyPayment = LegacyPaymentSystem()
    
    // Create an adapter to use the legacy system with the modern interface
    let paymentProcessor = PaymentAdapter(legacySystem: legacyPayment)
    
    // Use the modern interface to process a payment
    let paymentResult = paymentProcessor.processPayment(amount: 100.50)
    print("Payment Result: \(paymentResult)")
    
    // Use the modern interface to refund a payment
    let refundResult = paymentProcessor.refundPayment(amount: 100.50)
    print("Refund Result: \(refundResult)")
}


