//
//  DecompressStringFromFormatSubstrings.swift
//  Dynamic_Examples
//
//  Created by Simon Getrik on 13.05.2025.
//

import Foundation

// MARK: - String Decompression Utility
// This utility provides two functions:
// 1. decompressSimple: Handles strings like "a3b4c2" → "aaaabbbbbccc"
// 2. decompressWithBrackets: Handles strings like "3[abc]4[ab]c" → "abcabcabcababababc"

// Function to decompress a simple string (e.g., "a3b4c2" → "aaaabbbbbccc")
func decompressSimple(_ input: String) -> String {
    var result = ""
    var currentChar: Character?
    var currentNum = 0
    
    for char in input {
        if char.isNumber {
            currentNum = currentNum * 10 + (Int(String(char)) ?? 0)
        } else {
            if let lastChar = currentChar, currentNum > 0 {
                result += String(repeating: lastChar, count: currentNum)
            } else if currentChar != nil {
                result += String(currentChar!)
            }
            currentChar = char
            currentNum = 0
        }
    }
    
    // Handle the last character and number
    if let lastChar = currentChar, currentNum > 0 {
        result += String(repeating: lastChar, count: currentNum)
    } else if currentChar != nil {
        result += String(currentChar!)
    }
    
    return result
}

// Function to decompress a string with brackets (e.g., "3[abc]4[ab]c" → "abcabcabcababababc")
func decompressWithBrackets(_ input: String) -> String {
    var stack: [(num: Int, str: String)] = [(1, "")] // Stack to track nested brackets and multipliers
    var currentNum = 0
    
    for char in input {
        if char.isNumber {
            currentNum = currentNum * 10 + (Int(String(char)) ?? 0)
        } else if char == "[" {
            // Start a new nested level with the current number
            stack.append((currentNum, ""))
            currentNum = 0
        } else if char == "]" {
            // Pop the current level, repeat its content, and append to the previous level
            let (num, str) = stack.removeLast()
            let repeatedStr = String(repeating: str, count: num)
            stack[stack.count - 1].str += repeatedStr
        } else {
            // Add the character to the current level's string
            stack[stack.count - 1].str += String(char)
        }
    }
    
    // The final result is in the root level
    return stack[0].str
}

// Demo function to showcase both decompression methods
func demo_decompressString() {
    // Test simple decompression (e.g., "a3b4c2")
    let simpleInput = "a3b4c2"
    let simpleOutput = decompressSimple(simpleInput)
    print("Simple Input: \(simpleInput)")
    print("Simple Output: \(simpleOutput)")
    
    // Test decompression with brackets (e.g., "3[abc]4[ab]c")
    let bracketInput = "3[abc]4[ab]c"
    let bracketOutput = decompressWithBrackets(bracketInput)
    print("\nBracket Input: \(bracketInput)")
    print("Bracket Output: \(bracketOutput)")
    
    // Test combined input
    let combinedInput = "a3b4c2 3[abc]4[ab]c"
    let parts = combinedInput.split(separator: " ")
    let combinedOutput = parts.map { part -> String in
        if part.contains("[") {
            return decompressWithBrackets(String(part))
        } else {
            return decompressSimple(String(part))
        }
    }.joined(separator: " ")
    print("\nCombined Input: \(combinedInput)")
    print("Combined Output: \(combinedOutput)")
}

