//
//  1.5.Singleton.swift
//  Dynamic_Examples
//
//  Created by Simon Getrik on 12.05.2025.
//

import Foundation

// MARK: - Singleton Pattern
// The Singleton pattern ensures a class has only one instance and provides a global point of access to it.

// Class implementing the Singleton pattern
class ConfigurationManager {
    // Static property to hold the single instance
    static let shared = ConfigurationManager() // Thread safe burded by Swift for static
    /*
     vs 1 over complicated
     class ThreadSafeConfigurationManager {
         static private var _shared: ThreadSafeConfigurationManager?
         static private let lock = NSLock()
         
         static var shared: ThreadSafeConfigurationManager {
             lock.lock()
             defer { lock.unlock() }
             if _shared == nil {
                 _shared = ThreadSafeConfigurationManager()
             }
             return _shared!
         }
     vs 2 npt safe
     class UnsafeConfigurationManager {
         static var shared: UnsafeConfigurationManager = {
             print("Initializing...")
             return UnsafeConfigurationManager()
         }()
         private init() {}
     }
     */
    
    
    // Private initializer to prevent external instantiation
    private init() {
        // Initialize configuration settings
        print("ConfigurationManager initialized")
    }
    
    // Example property to store a configuration value
    var apiKey: String = "default-api-key"
    
    // Method to update the API key
    func setAPIKey(_ key: String) {
        apiKey = key
        /*
         for thread safe
         lock.lock()
                 defer { lock.unlock() }
                 _apiKey = key
                 DispatchQueue.main.async {
                     print("API Key updated to: \(self.apiKey)")
                 }
         */
        
    }
    
    // Method to get the current configuration
    func getConfiguration() -> String {
        return "API Key: \(apiKey)"
    }
}

// Demo function to showcase the Singleton pattern
func demo_SingletonPattern() {
    // Access the single instance
    let config1 = ConfigurationManager.shared
    print("Config 1: \(config1.getConfiguration())")
    
    // Access the same instance again
    let config2 = ConfigurationManager.shared
    config2.setAPIKey("new-api-key")
    print("Config 2 (after update): \(config2.getConfiguration())")
    
    // Verify they are the same instance
    print("Same instance: \(config1 === config2)") // Should print true
}

