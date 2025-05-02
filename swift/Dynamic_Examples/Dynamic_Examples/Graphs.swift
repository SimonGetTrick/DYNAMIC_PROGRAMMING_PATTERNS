//
//  Graphs.swift
//  Dynamic_Examples
//
//  Created by Simon Getrik on 30.04.2025.
//
import Foundation

// The graph is represented as a dictionary where keys are nodes, and values are arrays of neighboring nodes
var graph_legacy: [String: [String]] = [
    "A": ["B", "E"],
    "B": ["A", "C", "D"],
    "C": ["B"],
    "D": ["B"],
    "E": ["A"]
]

var visited: Set<String> = []

// Recursive function for performing depth-first search
func dfs(node: String) {
    // If the node has already been visited, return from the function
    if visited.contains(node) {
        return
    }
    
    // Mark the node as visited
    visited.insert(node)
    print(node) // Output the current node
    
    // Recursively call DFS for each neighbor of the current node
    for neighbor in graph_legacy[node]! {
        dfs(node: neighbor)
    }
}

// Graph node class
class Graph {
    // Adjacency list to represent the graph
    var adjList: [String: [String]] = [:]
    
    // Method to add an edge to the graph
    func addEdge(from: String, to: String) {
        adjList[from, default: []].append(to)
    }
    
    // Breadth First Search (BFS) method
    func breadthFirstSearch(start: String) {
        var visited = Set<String>()  // Set to track visited nodes
        var queue = [start]  // Queue for BFS
        
        while !queue.isEmpty {
            let node = queue.removeFirst()  // Dequeue
            if !visited.contains(node) {
                visited.insert(node)  // Mark as visited
                print(node)  // Print the node (this represents visiting the node)
                
                // Add all unvisited neighbors to the queue
                if let neighbors = adjList[node] {
                    for neighbor in neighbors {
                        if !visited.contains(neighbor) {
                            queue.append(neighbor)
                        }
                    }
                }
            }
        }
    }
    
    // Depth First Search (DFS) method
    func depthFirstSearch(start: String) {
        var visited = Set<String>()  // Set to track visited nodes
        dfsHelper(node: start, visited: &visited)
    }
    
    // Helper method for recursive DFS
    private func dfsHelper(node: String, visited: inout Set<String>) {
        // Mark the node as visited
        visited.insert(node)
        print(node) // Print the node (this represents visiting the node)
        
        // Recursively visit all unvisited neighbors
        if let neighbors = adjList[node] {
            for neighbor in neighbors {
                if !visited.contains(neighbor) {
                    dfsHelper(node: neighbor, visited: &visited)
                }
            }
        }
    }
}

// Graph class with adjacency matrix representation
class GraphMatrix {
    var adjMatrix: [[Int]]
    var vertices: [String]

    init(vertices: [String]) {
        self.vertices = vertices
        self.adjMatrix = Array(repeating: Array(repeating: 0, count: vertices.count), count: vertices.count)
    }

    // Method to add an edge
    func addEdge(from: String, to: String) {
        let fromIndex = vertices.firstIndex(of: from)!
        let toIndex = vertices.firstIndex(of: to)!
        adjMatrix[fromIndex][toIndex] = 1
        adjMatrix[toIndex][fromIndex] = 1  // Assuming undirected graph
    }

    // Depth First Search (DFS) method
    func depthFirstSearch(start: String) {
        var visited = Set<String>()
        guard let startIndex = vertices.firstIndex(of: start) else { return }
        dfsHelper(startIndex: startIndex, visited: &visited)
    }

    // Helper method for recursive DFS
    private func dfsHelper(startIndex: Int, visited: inout Set<String>) {
        let node = vertices[startIndex]
        visited.insert(node)
        print(node)
        
        for (i, isEdge) in adjMatrix[startIndex].enumerated() {
            if isEdge == 1, !visited.contains(vertices[i]) {
                dfsHelper(startIndex: i, visited: &visited)
            }
        }
    }

    // Breadth First Search (BFS) method
    func breadthFirstSearch(start: String) {
        var visited = Set<String>()
        var queue = [start]
        guard let startIndex = vertices.firstIndex(of: start) else { return }

        visited.insert(start)
        print(start)

        while !queue.isEmpty {
            let node = queue.removeFirst()
            guard let nodeIndex = vertices.firstIndex(of: node) else { return }

            for (i, isEdge) in adjMatrix[nodeIndex].enumerated() {
                if isEdge == 1, !visited.contains(vertices[i]) {
                    visited.insert(vertices[i])
                    print(vertices[i])
                    queue.append(vertices[i])
                }
            }
        }
    }
}

