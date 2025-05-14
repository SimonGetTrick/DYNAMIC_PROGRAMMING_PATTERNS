//
//  3.10.TemplateMethod.swift
//  Dynamic_Examples
//
//  Created by Simon Getrik on 14.05.2025.
//

import Foundation

// MARK: - Template Method Pattern
// The Template Method Pattern defines the skeleton of an algorithm in a method,
// deferring some steps to subclasses.

// Abstract class defining the template method and steps
class DataProcessor {
    
    // Template method — final to prevent overriding the algorithm structure
    final func process() {
        readData()
        processData()
        saveData()
    }
    
    // Steps of the algorithm — subclasses override these
    func readData() {
        fatalError("Must override readData")
    }
    
    func processData() {
        fatalError("Must override processData")
    }
    
    func saveData() {
        fatalError("Must override saveData")
    }
}

// Concrete subclass implementing specific steps
class CSVDataProcessor: DataProcessor {
    override func readData() {
        print("Reading data from CSV file")
    }
    
    override func processData() {
        print("Processing CSV data")
    }
    
    override func saveData() {
        print("Saving processed CSV data")
    }
}

// Another concrete subclass implementing steps differently
class JSONDataProcessor: DataProcessor {
    override func readData() {
        print("Reading data from JSON file")
    }
    
    override func processData() {
        print("Processing JSON data")
    }
    
    override func saveData() {
        print("Saving processed JSON data")
    }
}

// Client code to test the Template Method pattern
func demo_TemplateMethodPattern() {
    print("\n=== Template Method Pattern ===\n")
    
    let csvProcessor = CSVDataProcessor()
    csvProcessor.process()
    
    print()
    
    let jsonProcessor = JSONDataProcessor()
    jsonProcessor.process()
}

