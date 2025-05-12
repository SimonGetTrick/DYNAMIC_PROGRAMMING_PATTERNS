//
//  SetDemo.swift
//  Dynamic_Examples
//
//  Created by Simon Getrik on 12.05.2025.
//

import Foundation

// Function to demonstrate Set operations
func demo_SetOperations() {
    // Initialize two sets
    var setA: Set = [1, 2, 3, 4]
    var setB: Set = [3, 4, 5, 6]
    print("Set A: \(setA)")
    print("Set B: \(setB)")
    
    // Insert a new element into Set A
    setA.insert(7)
    print("\nAfter inserting 7 into Set A: \(setA)")
    
    // Check if Set A contains an element
    let contains3 = setA.contains(3)
    print("Set A contains 3: \(contains3)")
    
    // Remove an element from Set A
    setA.remove(2)
    setA.remove(2)
    print("After removing 2 from Set A: \(setA)")
    
    // Union of Set A and Set B
    let unionSet = setA.union(setB)
    print("Union of Set A and Set B: \(unionSet)")
    
    // Intersection of Set A and Set B
    let intersectionSet = setA.intersection(setB)
    print("Intersection of Set A and Set B: \(intersectionSet)")
    
    // Difference (Set A - Set B)
    let differenceSet = setA.subtracting(setB)
    print("Set A subtracting Set B: \(differenceSet)")
    
    // Check if Set A is a subset of Union
    let isSubset = setA.isSubset(of: unionSet)
    print("Is Set A a subset of Union: \(isSubset)")
    
    // Count elements in Set A
    print("Number of elements in Set A: \(setA.count)")
    
    // Remove all elements from Set B
    setB.removeAll()
    print("Set B after removeAll: \(setB)")
}

