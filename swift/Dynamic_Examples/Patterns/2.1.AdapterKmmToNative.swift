//
//  2.1.AdapterKmmToNative.swift
//  Dynamic_Examples
//
//  Created by Simon Getrik on 12.05.2025.
//

import Foundation

// MARK: - Adapter Pattern
// The Adapter pattern converts the interface of a KMM-based service into a Swift-friendly interface.

// Protocol defining the modern user service interface
protocol UserServiceProtocol {
    func login(email: String, password: String) -> String
    func getUserProfile(userId: String) -> String
}

// Legacy KMM UserService (simulated as an external class for this example)
class KMMUserService {
    func login(email: String, password: String) -> String {
        return "User \(email) logged in successfully."
    }
    
    func getUserProfile(userId: String) -> String {
        return "Profile for user \(userId): [data]"
    }
}

// Native Swift implementation of the user service
class NativeUserService: UserServiceProtocol {
    func login(email: String, password: String) -> String {
        // Native Swift logic (e.g., using URLSession for network calls)
        return "Swift: User \(email) logged in successfully."
    }
    
    func getUserProfile(userId: String) -> String {
        // Native Swift logic (e.g., fetching from a local database or API)
        return "Swift: Profile for user \(userId): [updated data]"
    }
}

// Adapter to bridge KMMUserService with UserServiceProtocol
class KMMUserServiceAdapter: UserServiceProtocol {
    private let kmmService: KMMUserService?
    private let nativeService: NativeUserService?
    
    // Initialize with either KMM or native service
    init(kmmService: KMMUserService? = nil, nativeService: NativeUserService? = nil) {
        self.kmmService = kmmService
        self.nativeService = nativeService
    }
    
    func login(email: String, password: String) -> String {
        if let nativeService = nativeService {
            return nativeService.login(email: email, password: password)
        } else if let kmmService = kmmService {
            return kmmService.login(email: email, password: password)
        }
        return "Error: No service available."
    }
    
    func getUserProfile(userId: String) -> String {
        if let nativeService = nativeService {
            return nativeService.getUserProfile(userId: userId)
        } else if let kmmService = kmmService {
            return kmmService.getUserProfile(userId: userId)
        }
        return "Error: No service available."
    }
}

// Demo function to showcase the Adapter pattern with migration
func demo_KMMAdapter() {
    // Initially use the KMM service
    let kmmService = KMMUserService()
    let userServiceWithKMM = KMMUserServiceAdapter(kmmService: kmmService)
    print("Using KMM Service:")
    print(userServiceWithKMM.login(email: "user@example.com", password: "password123"))
    print(userServiceWithKMM.getUserProfile(userId: "12345"))
    
    // Transition to the native Swift service
    let nativeService = NativeUserService()
    let userServiceWithNative = KMMUserServiceAdapter(nativeService: nativeService)
    print("\nUsing Native Swift Service:")
    print(userServiceWithNative.login(email: "user@example.com", password: "password123"))
    print(userServiceWithNative.getUserProfile(userId: "12345"))
}

// Run the demo
//demo_KMMAdapter()
