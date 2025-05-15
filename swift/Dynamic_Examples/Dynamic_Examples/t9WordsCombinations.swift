//
//  t9WordsCombinations.swift
//  Dynamic_Examples
//
//  Created by Simon Getrik on 15.05.2025.
//

import Foundation
import Foundation

func getValidWords(phoneNumber: String, words: [String]) -> [String] {
    // Mapping from digit to corresponding letters on a phone keypad
    let digitToLetters: [Character: Set<Character>] = [
        "2": ["a", "b", "c"],
        "3": ["d", "e", "f"],
        "4": ["g", "h", "i"],
        "5": ["j", "k", "l"],
        "6": ["m", "n", "o"],
        "7": ["p", "q", "r", "s"],
        "8": ["t", "u", "v"],
        "9": ["w", "x", "y", "z"]
    ]
    
    // Converts a word to its digit representation using the T9 mapping
    func wordToDigits(_ word: String) -> String? {
        var result = ""
        for ch in word.lowercased() {
            var matched = false
            for (digit, letters) in digitToLetters {
                if letters.contains(ch) {
                    result.append(digit)
                    matched = true
                    break
                }
            }
            if !matched { return nil } // If character can't be mapped, ignore the word
        }
        return result
    }
    
    // Filter the words that match the digit pattern in the phone number
    var matchingWords: [String] = []
    for word in words {
        if let digits = wordToDigits(word), phoneNumber.contains(digits) {
            matchingWords.append(word)
        }
    }

    return matchingWords.sorted() // Sorted for consistent output
}

// Demo function to show how the main logic works
func demo_phone_number_words() {
    let phoneNumber = "3662277"
    let words = ["foo", "bar", "baz", "foobar", "emo", "cap", "car", "cat"]
    
    let result = getValidWords(phoneNumber: phoneNumber, words: words)
    print("Matching words: \(result)")
}


