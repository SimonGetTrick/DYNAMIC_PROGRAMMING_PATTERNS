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


/*
Graph Representation Complexity:

Representation       | Memory Complexity | Neighbor Access       | Edge Addition         | Use Case
---------------------|-------------------|-----------------------|-----------------------|-------------------------------
Adjacency List       | O(V + E)          | Fast iteration         | Fast                  | Sparse graphs (Разреженные графы)
Adjacency Matrix     | O(V²)             | O(1) edge existence    | Requires vertex index | Dense graphs, fast edge lookup (Плотные графы)

Legend:
V - number of vertices (nodes)
E - number of edges
*/


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
    // Depth First Search (DFS) method for cycle detection
    func hasCycle(start: String) -> Bool {
        var visited = Set<String>()
        var recStack = Set<String>()
        
        // Start DFS from the given node
        return dfsCycleDetection(node: start, visited: &visited, recStack: &recStack)
    }

    // Helper method for DFS with cycle detection
    private func dfsCycleDetection(node: String, visited: inout Set<String>, recStack: inout Set<String>) -> Bool {
        // If the node is already in the recursion stack, a cycle is detected
        if recStack.contains(node) {
            return true
        }
        
        // If the node is already visited, no cycle is possible from here
        if visited.contains(node) {
            return false
        }
        
        // Mark the node as visited and add it to the recursion stack
        visited.insert(node)
        recStack.insert(node)
        
        // Recursively check all the neighbors of the current node
        if let neighbors = adjList[node] {
            for neighbor in neighbors {
                if dfsCycleDetection(node: neighbor, visited: &visited, recStack: &recStack) {
                    return true
                }
            }
        }
        
        // Remove the node from recursion stack as we are done with it
        recStack.remove(node)
        
        return false
    }
    // Method to remove an edge from the graph
    func removeEdge(from: String, to: String) {
        if let neighbors = adjList[from] {
            adjList[from] = neighbors.filter { $0 != to }
        }
        if let neighbors = adjList[to] {
            adjList[to] = neighbors.filter { $0 != from }
        }
    }

    // Check if the graph is fully connected using DFS
    func isConnected() -> Bool {
        guard let first = adjList.keys.first else { return true }  // Empty graph is trivially connected
        var visited = Set<String>()
        dfsHelper(node: first, visited: &visited)
        return visited.count == adjList.keys.count
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
        guard vertices.firstIndex(of: start) != nil else { return }

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

func runConnectivityDemo() {
    let g = Graph()
    g.addEdge(from: "A", to: "B")
    g.addEdge(from: "B", to: "C")
    g.addEdge(from: "C", to: "D")
    g.addEdge(from: "D", to: "E")
    g.addEdge(from: "A", to: "E")

    print("Connected initially:", g.isConnected())  // true

    g.removeEdge(from: "C", to: "D")
    print("After removing C-D:", g.isConnected())   // true

    g.removeEdge(from: "B", to: "C")
    print("After removing B-C:", g.isConnected())   // true

    g.removeEdge(from: "A", to: "B")
    print("After removing A-B:", g.isConnected())   // false
}

