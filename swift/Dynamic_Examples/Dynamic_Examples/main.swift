//
//  main.swift
//  Dynamic_Examples
//
//  Created by Simon Getrik on 28.04.2025.
//

import Foundation


if true { // Example usage longestPalindromicSubstring
    let input = "babad"
    let result = longestPalindromicSubstring(input)
    print("Longest palindromic substring: \(result)") // Output: "bab" or "aba"
    print("Hello, World!")
    
}
if true { // Example usage knapsack w
    let weights = [2, 3, 4]
    let values = [3, 4, 5]
    let W = 8
    let n = 3
    var result = knapsack(W: W, weights: weights, values: values, n: n)
    print("Maximum value: \(result)")
    result = unboundedKnapsack(W: W, weights: weights, values: values, n: n)
    print("Maximum value for unbounded knapsack: \(result)")
}
