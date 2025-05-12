//
//  2.5.Facade.swift
//  Dynamic_Examples
//
//  Created by Simon Getrik on 12.05.2025.
//

import Foundation

// MARK: - Facade Pattern
// The Facade pattern provides a simplified interface to a complex subsystem,
// reducing coupling between the client and the subsystem.

// Subsystem: Manages the inventory of products
class InventoryManager {
    func checkStock(productId: String, quantity: Int) -> Bool {
        // Simulate checking stock availability
        print("Checking stock for product \(productId): requested \(quantity) units")
        return quantity <= 10 // Assume we have 10 units in stock
    }
    
    func reserveStock(productId: String, quantity: Int) {
        print("Reserving \(quantity) units of product \(productId)")
    }
}

// Subsystem: Handles payment processing
class PaymentProcessor {
    func processPayment(amount: Double, userId: String) -> Bool {
        // Simulate payment processing
        print("Processing payment of \(amount) for user \(userId)")
        return true // Assume payment is successful
    }
}

// Subsystem: Manages shipping logistics
class ShippingService {
    func scheduleDelivery(orderId: String, address: String) {
        // Simulate scheduling a delivery
        print("Scheduling delivery for order \(orderId) to address: \(address)")
    }
    
    func calculateShippingCost(weight: Double) -> Double {
        // Simulate calculating shipping cost based on weight
        let cost = weight * 2.5
        print("Calculated shipping cost: \(cost) for weight \(weight) kg")
        return cost
    }
}

// Facade: Simplifies interaction with the order processing subsystem
class OrderFacade {
    private let inventory: InventoryManager
    private let payment: PaymentProcessor
    private let shipping: ShippingService
    
    init() {
        self.inventory = InventoryManager()
        self.payment = PaymentProcessor()
        self.shipping = ShippingService()
    }
    
    // Simplified method to place an order
    func placeOrder(productId: String, quantity: Int, userId: String, address: String, weight: Double) -> String {
        // Step 1: Check stock availability
        guard inventory.checkStock(productId: productId, quantity: quantity) else {
            return "Order failed: Product \(productId) is out of stock."
        }
        
        // Step 2: Reserve stock
        inventory.reserveStock(productId: productId, quantity: quantity)
        
        // Step 3: Calculate total cost (product price + shipping)
        let productPrice = Double(quantity) * 50.0 // Assume $50 per unit
        let shippingCost = shipping.calculateShippingCost(weight: weight)
        let totalAmount = productPrice + shippingCost
        
        // Step 4: Process payment
        guard payment.processPayment(amount: totalAmount, userId: userId) else {
            return "Order failed: Payment processing error."
        }
        
        // Step 5: Schedule delivery
        let orderId = "ORD-\(UUID().uuidString.prefix(8))"
        shipping.scheduleDelivery(orderId: orderId, address: address)
        
        return "Order \(orderId) placed successfully! Total: \(totalAmount)"
    }
}

// Demo function to showcase the Facade pattern
func demo_FacadePattern() {
    // Create the facade
    let orderFacade = OrderFacade()
    
    // Place an order using the simplified interface
    let result1 = orderFacade.placeOrder(
        productId: "PROD123",
        quantity: 2,
        userId: "USER456",
        address: "123 Main St, City",
        weight: 3.5
    )
    print("Result 1: \(result1)")
    
    // Try placing an order with insufficient stock
    let result2 = orderFacade.placeOrder(
        productId: "PROD789",
        quantity: 15,
        userId: "USER789",
        address: "456 Oak St, Town",
        weight: 5.0
    )
    print("\nResult 2: \(result2)")
}


