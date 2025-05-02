//
//  priorityQueue.swift
//  Dynamic_Examples
//
//  Created by Simon Getrik on 01.05.2025.
//

import Foundation
// A generic Min-Heap based Priority Queue implementation in Swift
struct PriorityQueue<T: Comparable> {
    private var heap: [T] = []
    
    // Check if the priority queue is empty
    var isEmpty: Bool {
        return heap.isEmpty
    }
    
    // Get the number of elements in the priority queue
    var count: Int {
        return heap.count
    }
    
    // Peek at the element with the highest priority (minimum value)
    func peek() -> T? {
        return heap.first
    }
    
    // Insert a new element into the priority queue
    mutating func enqueue(_ element: T) {
        heap.append(element)
        siftUp(from: heap.count - 1)
    }
    
    // Remove and return the element with the highest priority (minimum value)
    mutating func dequeue() -> T? {
        guard !heap.isEmpty else { return nil }
        if heap.count == 1 {
            return heap.removeLast()
        }
        let result = heap[0]
        heap[0] = heap.removeLast()
        siftDown(from: 0)
        return result
    }
    
    // Helper function to maintain heap property by moving an element up
    private mutating func siftUp(from index: Int) {
        var child = index
        var parent = (child - 1) / 2
        
        while child > 0 && heap[child] < heap[parent] {
            heap.swapAt(child, parent)
            child = parent
            parent = (child - 1) / 2
        }
    }
    
    // Helper function to maintain heap property by moving an element down
    private mutating func siftDown(from index: Int) {
        var parent = index
        let count = heap.count
        
        while true {
            let leftChild = 2 * parent + 1
            let rightChild = 2 * parent + 2
            var candidate = parent
            
            if leftChild < count && heap[leftChild] < heap[candidate] {
                candidate = leftChild
            }
            if rightChild < count && heap[rightChild] < heap[candidate] {
                candidate = rightChild
            }
            if candidate == parent {
                break
            }
            heap.swapAt(parent, candidate)
            parent = candidate
        }
    }
}

