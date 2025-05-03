//
//  Tree.swift
//  Dynamic_Examples
//
//  Created by Simon Getrik on 03.05.2025.
//

import Foundation

// Node class to represent each element in the tree
class Node {
    var value: Int
    var left: Node?
    var right: Node?
    
    // Initializer to create a node with a value
    init(value: Int) {
        self.value = value
        self.left = nil
        self.right = nil
    }
}

// BinaryTree class to manage the tree structure
class BinaryTree {
    var root: Node?
    
    // Method to insert a new value into the tree
    func insert(value: Int) {
        let newNode = Node(value: value)
        if root == nil {
            root = newNode
        } else {
            insertHelper(node: root, value: value)
        }
    }
    
    // Recursive helper function to insert a new node in the tree
    private func insertHelper(node: Node?, value: Int) {
        guard let node = node else { return }
        
        // If value is smaller, go to the left subtree
        if value < node.value {
            if node.left == nil {
                node.left = Node(value: value)
            } else {
                insertHelper(node: node.left, value: value)
            }
        }
        // If value is larger, go to the right subtree
        else {
            if node.right == nil {
                node.right = Node(value: value)
            } else {
                insertHelper(node: node.right, value: value)
            }
        }
    }
    
    // Method to perform an in-order traversal (left, root, right)
    func inOrderTraversal() {
        inOrderHelper(node: root)
    }
    
    // Helper function for in-order traversal
    private func inOrderHelper(node: Node?) {
        guard let node = node else { return }
        
        // Traverse left subtree
        inOrderHelper(node: node.left)
        
        // Visit node
        print(node.value, terminator: " ")
        
        // Traverse right subtree
        inOrderHelper(node: node.right)
    }
    
    // Method to perform a pre-order traversal (root, left, right)
    func preOrderTraversal() {
        preOrderHelper(node: root)
    }
    
    // Helper function for pre-order traversal
    private func preOrderHelper(node: Node?) {
        guard let node = node else { return }
        
        // Visit node
        print(node.value, terminator: " ")
        
        // Traverse left subtree
        preOrderHelper(node: node.left)
        
        // Traverse right subtree
        preOrderHelper(node: node.right)
    }
    
    // Method to perform a post-order traversal (left, right, root)
    func postOrderTraversal() {
        postOrderHelper(node: root)
    }
    
    // Helper function for post-order traversal
    private func postOrderHelper(node: Node?) {
        guard let node = node else { return }
        
        // Traverse left subtree
        postOrderHelper(node: node.left)
        
        // Traverse right subtree
        postOrderHelper(node: node.right)
        
        // Visit node
        print(node.value, terminator: " ")
    }
}

