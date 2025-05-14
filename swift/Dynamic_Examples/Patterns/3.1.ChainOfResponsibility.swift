//
//  ChainOfResponsibility.swift
//  Dynamic_Examples
//
//  Created by Simon Getrik on 14.05.2025.
//

import Foundation

// Protocol defining the handler interface
protocol Handler {
    func handle(request: String) -> String?
    func setNext(handler: Handler)
}

// Base handler class implementing the chain
class BaseHandler: Handler {
    private var nextHandler: Handler?
    
    func handle(request: String) -> String? {
        // Pass to the next handler if exists, otherwise return nil
        return nextHandler?.handle(request: request)
    }
    
    func setNext(handler: Handler) {
        nextHandler = handler
    }
}

// Concrete handler for specific requests
class SupportHandler: BaseHandler {
    override func handle(request: String) -> String? {
        if request == "technical" {
            return "Support: Handling technical issue."
        }
        return super.handle(request: request)
    }
}

// Concrete handler for another type of request
class BillingHandler: BaseHandler {
    override func handle(request: String) -> String? {
        if request == "billing" {
            return "Billing: Processing payment issue."
        }
        return super.handle(request: request)
    }
}

// Demo function to showcase the Chain of Responsibility pattern
func demo_ChainOfResponsibility() {
    print("\n=== Chain of Responsibility ===\n")
    
    // Create handlers
    let support = SupportHandler()
    let billing = BillingHandler()
    
    // Build the chain: support -> billing
    support.setNext(handler: billing)
    
    // Test requests
    let requests = ["technical", "billing", "general"]
    for request in requests {
        if let response = support.handle(request: request) {
            print("Request: \(request) -> \(response)")
        } else {
            print("Request: \(request) -> No handler found.")
        }
    }
}

// Run the demo

