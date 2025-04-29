//
//  longestPalindromicSubstring.swift
//  Dynamic_Examples
//
//  Created by Simon Getrik on 29.04.2025.
//

import Foundation
// Function to find the longest palindromic substring in a string
func longestPalindromicSubstring(_ s: String) -> String {
    let chars = Array(s) // Convert string to array for easier indexing
    var start = 0 // Start index of the longest palindrome
    var maxLength = 0 // Length of the longest palindrome
    
    // Helper function to expand around a center
    func expandAroundCenter(left: Int, right: Int) -> (Int, Int) {
        var l = left
        var r = right
        // Expand while within bounds and characters match
        while l >= 0 && r < chars.count && chars[l] == chars[r] {
            l -= 1
            r += 1
        }
        // Return the start index and length of the palindrome
        return (l + 1, r - l - 1)
    }
    
    // Iterate through each character as a potential center
    for i in 0..<chars.count {
        // Check for odd-length palindromes (center at i)
        let (start1, len1) = expandAroundCenter(left: i, right: i)
        // Check for even-length palindromes (center between i and i+1)
        let (start2, len2) = expandAroundCenter(left: i, right: i + 1)
        
        // Update if a longer palindrome is found
        if len1 > maxLength {
            start = start1
            maxLength = len1
        }
        if len2 > maxLength {
            start = start2
            maxLength = len2
        }
    }
    
    // Extract and return the longest palindromic substring
    let startIndex = s.index(s.startIndex, offsetBy: start)
    let endIndex = s.index(startIndex, offsetBy: maxLength)
    return String(s[startIndex..<endIndex])
}
