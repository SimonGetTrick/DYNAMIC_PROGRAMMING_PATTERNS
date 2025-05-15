//
//  t9Graph_aho_corasick.swift
//  Dynamic_Examples
//
//  Created by Simon Getrik on 15.05.2025.
//

import Foundation

// Node of Trie + Aho-Corasick automaton
class TrieNode {
    var children: [Int: TrieNode] = [:]      // movement throw digit (0-9)
    var failLink: TrieNode? = nil            // fail callback node
    var output: [String] = []                // words wich finished on the node
}

// Convert letter to T9digit
func charToDigit(_ ch: Character) -> Int? {
    switch ch {
        case "a","b","c": return 2
        case "d","e","f": return 3
        case "g","h","i": return 4
        case "j","k","l": return 5
        case "m","n","o": return 6
        case "p","q","r","s": return 7
        case "t","u","v": return 8
        case "w","x","y","z": return 9
        default: return nil
    }
}

// Add word in Trie (conert word to number)
func addWord(root: TrieNode, word: String) {
    var node = root
    for ch in word.lowercased() {
        guard let digit = charToDigit(ch) else { return }
        if node.children[digit] == nil {
            node.children[digit] = TrieNode()
        }
        node = node.children[digit]!
    }
    node.output.append(word)
}

func buildFailureLinks(root: TrieNode) {
    var queue = [TrieNode]()
    root.failLink = root
    for child in root.children.values {
        child.failLink = root
        queue.append(child)
    }
    
    while !queue.isEmpty {
        let current = queue.removeFirst()
        for (digit, child) in current.children {
            var fail = current.failLink
            // Traverse fail links until we find a node with a child on the digit or root
            while fail !== root && fail?.children[digit] == nil {
                fail = fail?.failLink
            }
            if let f = fail?.children[digit] {
                child.failLink = f
            } else {
                child.failLink = root
            }
            child.output += child.failLink!.output
            queue.append(child)
        }
    }
}

// Search for all words in phoneNumber by traversing Trie + failure links
func searchWords(root: TrieNode, phoneNumber: String) -> [String] {
    var node: TrieNode? = root
    var foundWords = Set<String>()
    for ch in phoneNumber {
        guard let digit = ch.wholeNumberValue else { continue }
        // Follow fail links if no edge for digit exists
        while node !== root && node?.children[digit] == nil {
            node = node?.failLink
        }
        if let nextNode = node?.children[digit] {
            node = nextNode
        }
        for word in node?.output ?? [] {
            foundWords.insert(word)
        }
    }
    return Array(foundWords).sorted()
}

// Demo
func demo_trie_aho_corasick() {
    let words = ["foo", "bar", "baz", "foobar", "emo", "cap", "car", "cat"]
    let phoneNumber = "3662277"
    
    let root = TrieNode()
    for word in words {
        addWord(root: root, word: word)
    }
    buildFailureLinks(root: root)
    
    let result = searchWords(root: root, phoneNumber: phoneNumber)
    print("Trie + Aho-Corasick result:", result)
}

