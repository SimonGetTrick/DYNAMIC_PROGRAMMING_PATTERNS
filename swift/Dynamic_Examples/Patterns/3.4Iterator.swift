//
//  3.4Iterator.swift
//  Dynamic_Examples
//
//  Created by Simon Getrik on 14.05.2025.
//

import Foundation
import Foundation

// MARK: - Iterator Pattern
// The Iterator Pattern provides sequential access to elements of a collection without exposing its underlying structure.

protocol Iterator {
    associatedtype Element
    func hasNext() -> Bool  // Checks if there are more elements
    func next() -> Element? // Returns the next element
}

// Concrete Iterator: Iterates over an array of elements
class ArrayIterator<Element>: Iterator {
    private var collection: [Element]
    private var currentIndex = 0
    
    init(collection: [Element]) {
        self.collection = collection
    }
    
    func hasNext() -> Bool {
        return currentIndex < collection.count  // Checks if there are more elements to iterate
    }
    
    func next() -> Element? {
        if hasNext() {
            let element = collection[currentIndex]
            currentIndex += 1
            return element
        }
        return nil  // Return nil when no more elements
    }
}

// Collection that uses the Iterator
class Collection<Element> {
    private var items: [Element]
    
    init(items: [Element]) {
        self.items = items
    }
    
    func iterator() -> ArrayIterator<Element> {
        return ArrayIterator(collection: items)
    }
}

// Client code to test the Iterator pattern
func demo_IteratorPattern() {
    print("\n=== Iterator Pattern ===\n")
    
    let numbers = Collection(items: [1, 2, 3, 4, 5])  // Collection of numbers
    let iterator = numbers.iterator()
    
    // Using the iterator to access elements one by one
    while iterator.hasNext() {
        if let number = iterator.next() {
            print("Current number: \(number)")
        }
    }
}


