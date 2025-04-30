//
//  DFS.swift
//  Dynamic_Examples
//
//  Created by Simon Getrik on 30.04.2025.
//
import Foundation

// The graph is represented as a dictionary where keys are nodes, and values are arrays of neighboring nodes
var graph: [String: [String]] = [
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
    for neighbor in graph[node]! {
        dfs(node: neighbor)
    }
}

