//
//  ClimbingStair.swift
//  Dynamic_Examples
//
//  Created by Simon Getrik on 19.06.2025.
//

import Foundation
class Solution {
    /*
     39. Combination Sum
     Medium
     Topics
     premium lock icon
     Companies
     Given an array of distinct integers candidates and a target integer target, return a list of all unique combinations of candidates where the chosen numbers sum to target. You may return the combinations in any order.
     The same number may be chosen from candidates an unlimited number of times. Two combinations are unique if the frequency of at least one of the chosen numbers is different.
     The test cases are generated such that the number of unique combinations that sum up to target is less than 150 combinations for the given input.
     Example 1:
     Input: candidates = [2,3,6,7], target = 7
     Output: [[2,2,3],[7]]
     Explanation:
     2 and 3 are candidates, and 2 + 2 + 3 = 7. Note that 2 can be used multiple times.
     7 is a candidate, and 7 = 7.
     These are the only two combinations.
     Example 2:
     Input: candidates = [2,3,5], target = 8
     Output: [[2,2,2,2],[2,3,3],[3,5]]
     Example 3:
     Input: candidates = [2], target = 1
     Output: []
     Constraints:
     1 <= candidates.length <= 30
     2 <= candidates[i] <= 40
     All elements of candidates are distinct.
     1 <= target <= 40
     */
    func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
        var result: [[Int]] = []
        
        // Recursive backtracking function
        func backtrack(_ current: [Int], _ remaining: Int, _ start: Int) {
            if remaining == 0 {
                // Found a valid combination
                result.append(current)
                return
            }
            if remaining < 0 {
                // Exceeded the target sum
                return
            }
            for i in start..<candidates.count {
                let num = candidates[i]
                // Choose the number and continue with the same index (can reuse the number)
                backtrack(current + [num], remaining - num, i)
            }
        }
        
        backtrack([], target, 0)
        return result
    }
    /*
     The count-and-say sequence is a sequence of digit strings defined by the recursive formula:

     countAndSay(1) = "1"
     countAndSay(n) is the run-length encoding of countAndSay(n - 1).
     Run-length encoding (RLE) is a string compression method that works by replacing consecutive identical characters (repeated 2 or more times) with the concatenation of the character and the number marking the count of the characters (length of the run). For example, to compress the string "3322251" we replace "33" with "23", replace "222" with "32", replace "5" with "15" and replace "1" with "11". Thus the compressed string becomes "23321511".
     Given a positive integer n, return the nth element of the count-and-say sequence.
     Example 1:
     Input: n = 4
     Output: "1211"
     Explanation:
     countAndSay(1) = "1"
     countAndSay(2) = RLE of "1" = "11"
     countAndSay(3) = RLE of "11" = "21"
     countAndSay(4) = RLE of "21" = "1211"
     Example 2:
     Input: n = 1
     Output: "1"
     Explanation:
     This is the base case
     */
    class CountAndSay {
        // Entry point for testing
        static func runDemo() {
            let n = 4
            let result = countAndSay(n)
            print("countAndSay(\(n)) = \(result)") // Should print: 1211
        }

        // Returns the nth term of the count-and-say sequence
        static func countAndSay(_ n: Int) -> String {
            if n == 1 { return "1" }

            let prev = countAndSay(n - 1)
            return say(prev)
        }

        // Helper function to perform run-length encoding
        private static func say(_ input: String) -> String {
            var result = ""
            var count = 0
            var prevChar: Character = input.first!

            for char in input {
                if char == prevChar {
                    count += 1
                } else {
                    result += "\(count)\(prevChar)"
                    prevChar = char
                    count = 1
                }
            }

            result += "\(count)\(prevChar)" // Add the last group
            return result
        }
    }

    /*
     Write a program to solve a Sudoku puzzle by filling the empty cells.
     A sudoku solution must satisfy all of the following rules:
     Each of the digits 1-9 must occur exactly once in each row.
     Each of the digits 1-9 must occur exactly once in each column.
     Each of the digits 1-9 must occur exactly once in each of the 9 3x3 sub-boxes of the grid.
     The '.' character indicates empty cells.
     Example 1:
     Input: board = [["5","3",".",".","7",".",".",".","."],["6",".",".","1","9","5",".",".","."],[".","9","8",".",".",".",".","6","."],["8",".",".",".","6",".",".",".","3"],["4",".",".","8",".","3",".",".","1"],["7",".",".",".","2",".",".",".","6"],[".","6",".",".",".",".","2","8","."],[".",".",".","4","1","9",".",".","5"],[".",".",".",".","8",".",".","7","9"]]
     Output: [["5","3","4","6","7","8","9","1","2"],["6","7","2","1","9","5","3","4","8"],["1","9","8","3","4","2","5","6","7"],["8","5","9","7","6","1","4","2","3"],["4","2","6","8","5","3","7","9","1"],["7","1","3","9","2","4","8","5","6"],["9","6","1","5","3","7","2","8","4"],["2","8","7","4","1","9","6","3","5"],["3","4","5","2","8","6","1","7","9"]]
     Explanation: The input board is shown above and the only valid solution is shown below:
     Constraints:
     board.length == 9
     board[i].length == 9
     board[i][j] is a digit or '.'.
     It is guaranteed that the input board has only one solution.
     */
    class SudokuSolver {
        // Entry point to run the demo
        static func runDemo() {
            var board: [[Character]] = [
                ["5","3",".",".","7",".",".",".","."],
                ["6",".",".","1","9","5",".",".","."],
                [".","9","8",".",".",".",".","6","."],
                ["8",".",".",".","6",".",".",".","3"],
                ["4",".",".","8",".","3",".",".","1"],
                ["7",".",".",".","2",".",".",".","6"],
                [".","6",".",".",".",".","2","8","."],
                [".",".",".","4","1","9",".",".","5"],
                [".",".",".",".","8",".",".","7","9"]
            ]

            solveSudoku(&board)
            printBoard(board)
        }

        // Main solver function using backtracking
        static func solveSudoku(_ board: inout [[Character]]) {
            _ = solve(&board)
        }

        // Recursive function to fill the board
        private static func solve(_ board: inout [[Character]]) -> Bool {
            for row in 0..<9 {
                for col in 0..<9 {
                    if board[row][col] == "." {
                        for digit in "123456789" {
                            if isValid(board, row, col, digit) {
                                board[row][col] = digit
                                if solve(&board) {
                                    return true
                                }
                                board[row][col] = "." // backtrack
                            }
                        }
                        return false // if no valid digit found
                    }
                }
            }
            return true // fully filled
        }

        // Check if placing a digit is valid
        private static func isValid(_ board: [[Character]], _ row: Int, _ col: Int, _ char: Character) -> Bool {
            for i in 0..<9 {
                if board[row][i] == char { return false } // check row
                if board[i][col] == char { return false } // check column
                let boxRow = 3 * (row / 3) + i / 3
                let boxCol = 3 * (col / 3) + i % 3
                if board[boxRow][boxCol] == char { return false } // check box
            }
            return true
        }

        // Utility to print the board
        private static func printBoard(_ board: [[Character]]) {
            for row in board {
                print(row.map { String($0) }.joined(separator: " "))
            }
        }
    }
    /*
     Sudoku validator
     Determine if a 9 x 9 Sudoku board is valid. Only the filled cells need to be validated according to the following rules:
     
     Each row must contain the digits 1-9 without repetition.
     Each column must contain the digits 1-9 without repetition.
     Each of the nine 3 x 3 sub-boxes of the grid must contain the digits 1-9 without repetition.
     Note:
     
     A Sudoku board (partially filled) could be valid but is not necessarily solvable.
     Only the filled cells need to be validated according to the mentioned rules.
     
     
     Example 1:
     
     
     Input: board =
     [["5","3",".",".","7",".",".",".","."]
     ,["6",".",".","1","9","5",".",".","."]
     ,[".","9","8",".",".",".",".","6","."]
     ,["8",".",".",".","6",".",".",".","3"]
     ,["4",".",".","8",".","3",".",".","1"]
     ,["7",".",".",".","2",".",".",".","6"]
     ,[".","6",".",".",".",".","2","8","."]
     ,[".",".",".","4","1","9",".",".","5"]
     ,[".",".",".",".","8",".",".","7","9"]]
     Output: true
     Example 2:
     
     Input: board =
     [["8","3",".",".","7",".",".",".","."]
     ,["6",".",".","1","9","5",".",".","."]
     ,[".","9","8",".",".",".",".","6","."]
     ,["8",".",".",".","6",".",".",".","3"]
     ,["4",".",".","8",".","3",".",".","1"]
     ,["7",".",".",".","2",".",".",".","6"]
     ,[".","6",".",".",".",".","2","8","."]
     ,[".",".",".","4","1","9",".",".","5"]
     ,[".",".",".",".","8",".",".","7","9"]]
     Output: false
     Explanation: Same as Example 1, except with the 5 in the top left corner being modified to 8. Since there are two 8's in the top left 3x3 sub-box, it is invalid.
     
     */
    func isValidSudoku(_ board: [[Character]]) -> Bool {
        // Sets to keep track of seen values in rows, columns, and boxes
        var rows = Array(repeating: Set<Character>(), count: 9)
        var cols = Array(repeating: Set<Character>(), count: 9)
        var boxes = Array(repeating: Set<Character>(), count: 9)
        
        for i in 0..<9 {
            for j in 0..<9 {
                let value = board[i][j]
                if value == "." {
                    continue // Skip empty cells
                }
                
                // Calculate box index
                let boxIndex = (i / 3) * 3 + j / 3
                
                // Check for duplicates
                if rows[i].contains(value) || cols[j].contains(value) || boxes[boxIndex].contains(value) {
                    return false
                }
                
                // Add value to sets
                rows[i].insert(value)
                cols[j].insert(value)
                boxes[boxIndex].insert(value)
            }
        }
        
        return true // Valid if no duplicates found
    }
    /* Search in Rotated Sorted Array
     (O(log n)
     There is an integer array nums sorted in ascending order (with distinct values).
     Prior to being passed to your function, nums is possibly rotated at an unknown pivot index k (1 <= k < nums.length) such that the resulting array is [nums[k], nums[k+1], ..., nums[n-1], nums[0], nums[1], ..., nums[k-1]] (0-indexed). For example, [0,1,2,4,5,6,7] might be rotated at pivot index 3 and become [4,5,6,7,0,1,2].
     Given the array nums after the possible rotation and an integer target, return the index of target if it is in nums, or -1 if it is not in nums.
     You must write an algorithm with O(log n) runtime complexity.
     Example 1:
     Input: nums = [4,5,6,7,0,1,2], target = 0
     Output: 4
     Example 2:
     Input: nums = [4,5,6,7,0,1,2], target = 3
     Output: -1
     Example 3:
     
     Input: nums = [1], target = 0
     Output: -1
     
     
     Constraints:
     
     1 <= nums.length <= 5000
     -104 <= nums[i] <= 104
     All values of nums are unique.
     nums is an ascending array that is possibly rotated.
     -104 <= target <= 104
     */
    func search(_ nums: [Int], _ target: Int) -> Int {
        var left = 0
        var right = nums.count - 1
        
        while left <= right {
            let mid = (left + right) / 2
            
            // If mid is the target
            if nums[mid] == target {
                return mid
            }
            
            // Determine which half is sorted
            if nums[left] <= nums[mid] {
                // Left half is sorted
                if nums[left] <= target && target < nums[mid] {
                    right = mid - 1
                } else {
                    left = mid + 1
                }
            } else {
                // Right half is sorted
                if nums[mid] < target && target <= nums[right] {
                    left = mid + 1
                } else {
                    right = mid - 1
                }
            }
        }
        
        return -1
    }
    
    /*
     Longest Valid Parentheses
     Given a string containing just the characters '(' and ')', return the length of the longest valid (well-formed) parentheses substring.
     Example 1:
     
     Input: s = "(()"
     Output: 2
     Explanation: The longest valid parentheses substring is "()".
     Example 2:
     
     Input: s = ")()())"
     Output: 4
     Explanation: The longest valid parentheses substring is "()()".
     Example 3:
     
     Input: s = ""
     Output: 0
     
     
     Constraints:
     
     0 <= s.length <= 3 * 104
     s[i] is '(', or ')'.
     */
    func longestValidParentheses(_ s: String) -> Int {
        var maxLength = 0
        var stack: [Int] = [-1]  // Stack to store indices; start with -1 as base
        
        for (i, char) in s.enumerated() {
            if char == "(" {
                stack.append(i)  // Push index of '('
            } else {
                stack.removeLast()  // Pop the last '(' index or base
                if let last = stack.last {
                    maxLength = max(maxLength, i - last)  // Update max length
                } else {
                    stack.append(i)  // No base left, set new base
                }
            }
        }
        
        return maxLength
    }
    func longestValidParentheses_withoutStackMemory(_ s: String) -> Int {
        var left = 0, right = 0, maxLength = 0
        
        // Left to right
        for char in s {
            if char == "(" {
                left += 1
            } else {
                right += 1
            }
            
            if left == right {
                maxLength = max(maxLength, 2 * right)
            } else if right > left {
                left = 0
                right = 0
            }
        }
        
        // Right to left
        left = 0
        right = 0
        for char in s.reversed() {
            if char == ")" {
                right += 1
            } else {
                left += 1
            }
            
            if left == right {
                maxLength = max(maxLength, 2 * left)
            } else if left > right {
                left = 0
                right = 0
            }
        }
        
        return maxLength
    }
    
    
    /*
     A permutation of an array of integers is an arrangement of its members into a sequence or linear order.
     
     For example, for arr = [1,2,3], the following are all the permutations of arr: [1,2,3], [1,3,2], [2, 1, 3], [2, 3, 1], [3,1,2], [3,2,1].
     The next permutation of an array of integers is the next lexicographically greater permutation of its integer. More formally, if all the permutations of the array are sorted in one container according to their lexicographical order, then the next permutation of that array is the permutation that follows it in the sorted container. If such arrangement is not possible, the array must be rearranged as the lowest possible order (i.e., sorted in ascending order).
     For example, the next permutation of arr = [1,2,3] is [1,3,2].
     Similarly, the next permutation of arr = [2,3,1] is [3,1,2].
     While the next permutation of arr = [3,2,1] is [1,2,3] because [3,2,1] does not have a lexicographical larger rearrangement.
     Given an array of integers nums, find the next permutation of nums.
     
     The replacement must be in place and use only constant extra memory.
     
     Example 1:
     Input: nums = [1,2,3]
     Output: [1,3,2]
     Example 2:
     Input: nums = [3,2,1]
     Output: [1,2,3]
     Example 3:
     Input: nums = [1,1,5]
     Output: [1,5,1]
     Constraints:
     
     1 <= nums.length <= 100
     0 <= nums[i] <= 100
     */
    static func nextPermutation(_ nums: inout [Int]) {
        let n = nums.count
        var i = n - 2
        
        // Step 1: Find the first decreasing element from the right
        while i >= 0 && nums[i] >= nums[i + 1] {
            i -= 1
        }
        
        if i >= 0 {
            var j = n - 1
            // Step 2: Find the next larger element to swap
            while nums[j] <= nums[i] {
                j -= 1
            }
            nums.swapAt(i, j)
        }
        
        // Step 3: Reverse the suffix
        reverse(&nums, start: i + 1, end: n - 1)
    }
    
    private static func reverse(_ nums: inout [Int], start: Int, end: Int) {
        var start = start
        var end = end
        while start < end {
            nums.swapAt(start, end)
            start += 1
            end -= 1
        }
    }
    /*
     30 Substring with Concatenation of All Words
     You are given a string s and an array of strings words. All the strings of words are of the same length.
     A concatenated string is a string that exactly contains all the strings of any permutation of words concatenated.
     For example, if words = ["ab","cd","ef"], then "abcdef", "abefcd", "cdabef", "cdefab", "efabcd", and "efcdab" are all concatenated strings. "acdbef" is not a concatenated string because it is not the concatenation of any permutation of words.
     Return an array of the starting indices of all the concatenated substrings in s. You can return the answer in any order.
     Example 1:
     Input: s = "barfoothefoobarman", words = ["foo","bar"]
     Output: [0,9]
     Explanation:
     The substring starting at 0 is "barfoo". It is the concatenation of ["bar","foo"] which is a permutation of words.
     The substring starting at 9 is "foobar". It is the concatenation of ["foo","bar"] which is a permutation of words.
     Example 2:
     Input: s = "wordgoodgoodgoodbestword", words = ["word","good","best","word"]
     Output: []
     Explanation:
     There is no concatenated substring.
     Example 3:
     Input: s = "barfoofoobarthefoobarman", words = ["bar","foo","the"]
     Output: [6,9,12]
     Explanation:
     The substring starting at 6 is "foobarthe". It is the concatenation of ["foo","bar","the"].
     The substring starting at 9 is "barthefoo". It is the concatenation of ["bar","the","foo"].
     The substring starting at 12 is "thefoobar". It is the concatenation of ["the","foo","bar"].
     Constraints:
     1 <= s.length <= 104
     1 <= words.length <= 5000
     1 <= words[i].length <= 30
     s and words[i] consist of lowercase English letters.
     */
    static func findSubstring(_ s: String, _ words: [String]) -> [Int] {
        // Early return if input is invalid
        guard !s.isEmpty, !words.isEmpty else { return [] }
        
        let wordLength = words[0].count
        let wordCount = words.count
        let totalLength = wordLength * wordCount
        let sArray = Array(s)
        var result = [Int]()
        
        // Create frequency map for all words
        let wordFrequency = words.reduce(into: [String: Int]()) { dict, word in
            dict[word, default: 0] += 1
        }
        
        // We try all possible starting points within the word length offset
        for i in 0..<wordLength {
            var left = i
            var right = i
            var windowWords = [String: Int]()
            var count = 0
            
            // Slide the window by word length
            while right + wordLength <= s.count {
                let word = String(sArray[right..<right+wordLength])
                right += wordLength
                
                // If word is part of words list
                if wordFrequency[word] != nil {
                    windowWords[word, default: 0] += 1
                    count += 1
                    
                    // If word occurs more than expected, move the left side of the window
                    while windowWords[word]! > wordFrequency[word]! {
                        let leftWord = String(sArray[left..<left+wordLength])
                        windowWords[leftWord]! -= 1
                        left += wordLength
                        count -= 1
                    }
                    
                    // If the window matches all words
                    if count == wordCount {
                        result.append(left)
                    }
                } else {
                    // Reset window if word is not in the list
                    windowWords.removeAll()
                    count = 0
                    left = right
                }
            }
        }
        
        return result
    }
    /*
     Given two integers dividend and divisor, divide two integers without using multiplication, division, and mod operator.
     The integer division should truncate toward zero, which means losing its fractional part. For example, 8.345 would be truncated to 8, and -2.7335 would be truncated to -2.
     Return the quotient after dividing dividend by divisor.
     Note: Assume we are dealing with an environment that could only store integers within the 32-bit signed integer range: [−231, 231 − 1]. For this problem, if the quotient is strictly greater than 231 - 1, then return 231 - 1, and if the quotient is strictly less than -231, then return -231.
     Example 1:
     Input: dividend = 10, divisor = 3
     Output: 3
     Explanation: 10/3 = 3.33333.. which is truncated to 3.
     Example 2:
     Input: dividend = 7, divisor = -3
     Output: -2
     Explanation: 7/-3 = -2.33333.. which is truncated to -2.
     Constraints:
     -231 <= dividend, divisor <= 231 - 1
     divisor != 0
     */
    func divide(_ dividend: Int, _ divisor: Int) -> Int {
        // Constants for 32-bit integer boundaries
        let INT_MAX = Int(Int32.max)
        let INT_MIN = Int(Int32.min)
        
        // Special case: overflow
        if dividend == INT_MIN && divisor == -1 {
            return INT_MAX
        }
        
        // Determine the sign of the result
        let negative = (dividend < 0) != (divisor < 0)
        
        // Work with absolute values (use Int64 to prevent overflow)
        var a = Int64(abs(dividend))
        let b = Int64(abs(divisor))
        var result: Int64 = 0
        
        while a >= b {
            var temp = b
            var multiple: Int64 = 1
            
            // Double temp and multiple until it would exceed 'a'
            while a >= (temp << 1) {
                temp <<= 1
                multiple <<= 1
            }
            
            // Subtract and accumulate
            a -= temp
            result += multiple
        }
        
        // Apply sign
        result = negative ? -result : result
        
        // Clamp result to 32-bit signed range
        if result > Int64(INT_MAX) { return INT_MAX }
        if result < Int64(INT_MIN) { return INT_MIN }
        
        return Int(result)
    }
    /*
     Given the head of a linked list, reverse the nodes of the list k at a time, and return the modified list.
     k is a positive integer and is less than or equal to the length of the linked list. If the number of nodes is not a multiple of k then left-out nodes, in the end, should remain as it is.
     You may not alter the values in the list's nodes, only nodes themselves may be changed.
     Example 1:
     Input: head = [1,2,3,4,5], k = 2
     Output: [2,1,4,3,5]
     Example 2:
     Input: head = [1,2,3,4,5], k = 3
     Output: [3,2,1,4,5]
     Constraints:
     The number of nodes in the list is n.
     1 <= k <= n <= 5000
     0 <= Node.val <= 1000
     */
    func reverseKGroup(_ head: ListNode?, _ k: Int) -> ListNode? {
        let dummy = ListNode(0)
        dummy.next = head
        var groupPrev: ListNode? = dummy
        
        while true {
            var kth = groupPrev
            for _ in 0..<k {
                kth = kth?.next
                if kth == nil {
                    return dummy.next
                }
            }
            
            let groupNext = kth?.next
            // Reverse the group
            var prev: ListNode? = groupNext
            var curr = groupPrev?.next
            
            for _ in 0..<k {
                let tmp = curr?.next
                curr?.next = prev
                prev = curr
                curr = tmp
            }
            
            // Adjust pointers
            let tmp = groupPrev?.next
            groupPrev?.next = prev
            groupPrev = tmp
        }
    }
    
    /*
     Given a linked list, swap every two adjacent nodes and return its head. You must solve the problem without modifying the values in the list's nodes (i.e., only nodes themselves may be changed.)
     Example 1:
     Input: head = [1,2,3,4]
     Output: [2,1,4,3]
     Explanation:
     Example 2:
     Input: head = []
     Output: []
     Example 3:
     Input: head = [1]
     Output: [1]
     Example 4:
     Input: head = [1,2,3]
     Output: [2,1,3]
     Constraints:
     
     The number of nodes in the list is in the range [0, 100].
     0 <= Node.val <= 100
     */
    func swapPairs(_ head: ListNode?) -> ListNode? {
        let dummy = ListNode(0)
        dummy.next = head
        var prev = dummy
        
        while let first = prev.next, let second = first.next {
            // Nodes to swap: first and second
            let nextPair = second.next
            
            // Swap logic
            prev.next = second
            second.next = first
            first.next = nextPair
            
            // Move `prev` two nodes ahead
            prev = first
        }
        
        return dummy.next
    }
    /*
     You are given an array of k linked-lists lists, each linked-list is sorted in ascending order.
     Merge all the linked-lists into one sorted linked-list and return it.
     Example 1:
     Input: lists = [[1,4,5],[1,3,4],[2,6]]
     Output: [1,1,2,3,4,4,5,6]
     Explanation: The linked-lists are:
     [
     1->4->5,
     1->3->4,
     2->6
     ]
     merging them into one sorted linked list:
     1->1->2->3->4->4->5->6
     Example 2:
     Input: lists = []
     Output: []
     Example 3:
     Input: lists = [[]]
     Output: []     */
    // Custom comparator for the min-heap (Priority Queue)
    struct HeapNode: Comparable {
        //Comparable
        static func == (lhs: HeapNode, rhs: HeapNode) -> Bool {
            return lhs.node === rhs.node
        }
        
        let node: ListNode
        static func < (lhs: HeapNode, rhs: HeapNode) -> Bool {
            return lhs.node.val < rhs.node.val
        }
    }
    
    // MinHeap implementation using BinaryHeap
    struct MinHeap<T: Comparable> {
        private var heap: [T] = []
        
        mutating func push(_ element: T) {
            heap.append(element)
            siftUp(heap.count - 1)
        }
        
        mutating func pop() -> T? {
            guard !heap.isEmpty else { return nil }
            heap.swapAt(0, heap.count - 1)
            let popped = heap.removeLast()
            siftDown(0)
            return popped
        }
        
        func peek() -> T? {
            return heap.first
        }
        
        var isEmpty: Bool {
            return heap.isEmpty
        }
        
        private mutating func siftUp(_ index: Int) {
            var child = index
            var parent = (child - 1) / 2
            while child > 0 && heap[child] < heap[parent] {
                heap.swapAt(child, parent)
                child = parent
                parent = (child - 1) / 2
            }
        }
        
        private mutating func siftDown(_ index: Int) {
            var parent = index
            let count = heap.count
            while true {
                let left = 2 * parent + 1
                let right = 2 * parent + 2
                var candidate = parent
                
                if left < count && heap[left] < heap[candidate] {
                    candidate = left
                }
                if right < count && heap[right] < heap[candidate] {
                    candidate = right
                }
                if candidate == parent { return }
                heap.swapAt(parent, candidate)
                parent = candidate
            }
        }
    }
    func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
        var minHeap = MinHeap<HeapNode>()
        
        // Push head of each list into the heap
        for list in lists {
            if let node = list {
                minHeap.push(HeapNode(node: node))
            }
        }
        
        let dummy = ListNode(0)
        var tail = dummy
        
        while !minHeap.isEmpty {
            guard let smallest = minHeap.pop()?.node else { break }
            tail.next = smallest
            tail = tail.next!
            if let next = smallest.next {
                minHeap.push(HeapNode(node: next))
            }
        }
        
        return dummy.next
    }
    static func mergeKListsTests() {
        func createList(_ nums: [Int]) -> ListNode? {
            let dummy = ListNode(0)
            var current = dummy
            for num in nums {
                current.next = ListNode(num)
                current = current.next!
            }
            return dummy.next
        }
        
        let list1 = createList([1,4,5])
        let list2 = createList([1,3,4])
        let list3 = createList([2,6])
        
        let solution = Solution()
        if let merged = solution.mergeKLists([list1, list2, list3]) {
            var current: ListNode? = merged
            while let node = current {
                print(node.val, terminator: " -> ")
                current = node.next
            }
        } else {
            print("[]")
        }
    }
    
    /* Generate Parentsheses
     Given n pairs of parentheses, write a function to generate all combinations of well-formed parentheses.
     Example 1:
     Input: n = 3
     Output: ["((()))","(()())","(())()","()(())","()()()"]
     Example 2:
     Input: n = 1
     Output: ["()"]
     */
    func generateParenthesis(_ n: Int) -> [String] {
        var result = [String]()
        
        func backtrack(_ current: String, _ open: Int, _ close: Int) {
            // Base case: valid sequence of length 2n
            if current.count == 2 * n {
                result.append(current)
                return
            }
            
            // Add '(' if we still have opening brackets left
            if open < n {
                backtrack(current + "(", open + 1, close)
            }
            
            // Add ')' if it won't lead to invalid sequence
            if close < open {
                backtrack(current + ")", open, close + 1)
            }
        }
        
        backtrack("", 0, 0)
        return result
    }
    
    /*
     Merge Two Sorted Lists
     You are given the heads of two sorted linked lists list1 and list2.
     Merge the two lists into one sorted list. The list should be made by splicing together the nodes of the first two lists.
     Return the head of the merged linked list.
     Example 1:
     Input: list1 = [1,2,4], list2 = [1,3,4]
     Output: [1,1,2,3,4,4]
     Example 2:
     Input: list1 = [], list2 = []
     Output: []
     Example 3:
     Input: list1 = [], list2 = [0]
     Output: [0]
     Constraints:
     The number of nodes in both lists is in the range [0, 50].
     -100 <= Node.val <= 100
     Both list1 and list2 are sorted in non-decreasing order.
     */
    func mergeTwoLists(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
        // Create a dummy head to simplify edge cases
        let dummy = ListNode(0)
        var current = dummy
        var l1 = list1
        var l2 = list2
        
        // Compare and merge nodes in sorted order
        while let node1 = l1, let node2 = l2 {
            if node1.val < node2.val {
                current.next = node1
                l1 = node1.next
            } else {
                current.next = node2
                l2 = node2.next
            }
            current = current.next!
        }
        
        // Append remaining nodes
        current.next = l1 ?? l2
        
        return dummy.next
    }
    func buildList(_ values: [Int]) -> ListNode? {
        let dummy = ListNode(0)
        var current = dummy
        for val in values {
            current.next = ListNode(val)
            current = current.next!
        }
        return dummy.next
    }
    
    func printList(_ head: ListNode?) {
        var current = head
        while let node = current {
            print(node.val, terminator: node.next != nil ? " -> " : "\n")
            current = node.next
        }
    }
    /*
     Given a string s containing just the characters '(', ')', '{', '}', '[' and ']', determine if the input string is valid.
     An input string is valid if:
     Open brackets must be closed by the same type of brackets.
     Open brackets must be closed in the correct order.
     Every close bracket has a corresponding open bracket of the same type.
     Example 1:
     Input: s = "()"
     Output: true
     Example 2:
     Input: s = "()[]{}"
     Output: true
     Example 3:
     Input: s = "(]"
     Output: false
     Example 4:
     Input: s = "([])"
     Output: true
     
     */
    func isValid(_ s: String) -> Bool {
        var stack: [Character] = []
        let matching: [Character: Character] = [")": "(", "]": "[", "}": "{"]
        
        for char in s {
            if char == "(" || char == "[" || char == "{" {
                // Push opening brackets onto the stack
                stack.append(char)
            } else if let expectedOpen = matching[char] {
                // If it's a closing bracket, check for matching opening bracket
                if stack.isEmpty || stack.removeLast() != expectedOpen {
                    return false
                }
            }
        }
        
        // Stack must be empty if all brackets matched
        return stack.isEmpty
    }
    
    /*
     Given the head of a linked list, remove the nth node from the end of the list and return its head.
     Example 1:
     Input: head = [1,2,3,4,5], n = 2
     Output: [1,2,3,5]
     Example 2:
     Input: head = [1], n = 1
     Output: []
     Example 3:
     Input: head = [1,2], n = 1
     Output: [1]
     Constraints:
     The number of nodes in the list is sz.
     1 <= sz <= 30
     0 <= Node.val <= 100
     1 <= n <= sz
     */
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        // Create a dummy node that points to the head
        let dummy = ListNode(0)
        dummy.next = head
        
        var first: ListNode? = dummy
        var second: ListNode? = dummy
        
        // Move the first pointer n+1 steps ahead so the gap between first and second is n nodes
        for _ in 0...n {
            first = first?.next
        }
        
        // Move both pointers until the first reaches the end
        while first != nil {
            first = first?.next
            second = second?.next
        }
        
        // Skip the target node
        second?.next = second?.next?.next
        
        return dummy.next
    }
    
    /*
     Given an array nums of n integers, return an array of all the unique quadruplets [nums[a], nums[b], nums[c], nums[d]] such that:
     0 <= a, b, c, d < n
     a, b, c, and d are distinct.
     nums[a] + nums[b] + nums[c] + nums[d] == target
     You may return the answer in any order.
     Example 1:
     Input: nums = [1,0,-1,0,-2,2], target = 0
     Output: [[-2,-1,1,2],[-2,0,0,2],[-1,0,0,1]]
     Example 2:
     Input: nums = [2,2,2,2,2], target = 8
     Output: [[2,2,2,2]]
     Constraints:
     1 <= nums.length <= 200
     -109 <= nums[i] <= 109
     -109 <= target <= 109
     */
    func fourSum(_ nums: [Int], _ target: Int) -> [[Int]] {
        let nums = nums.sorted()
        var result = [[Int]]()
        let n = nums.count
        
        // First loop: fix the first number
        for i in 0..<n {
            if i > 0 && nums[i] == nums[i - 1] {
                continue // Skip duplicate for the first number
            }
            
            // Second loop: fix the second number
            for j in (i + 1)..<n {
                if j > i + 1 && nums[j] == nums[j - 1] {
                    continue // Skip duplicate for the second number
                }
                
                var left = j + 1
                var right = n - 1
                
                // Two-pointer approach to find the remaining two numbers
                while left < right {
                    let sum = nums[i] + nums[j] + nums[left] + nums[right]
                    
                    if sum == target {
                        // Found a valid quadruplet
                        result.append([nums[i], nums[j], nums[left], nums[right]])
                        
                        // Skip duplicates for the third number
                        while left < right && nums[left] == nums[left + 1] {
                            left += 1
                        }
                        // Skip duplicates for the fourth number
                        while left < right && nums[right] == nums[right - 1] {
                            right -= 1
                        }
                        
                        left += 1
                        right -= 1
                        
                    } else if sum < target {
                        // Move the left pointer to increase the sum
                        left += 1
                    } else {
                        // Move the right pointer to decrease the sum
                        right -= 1
                    }
                }
            }
        }
        
        return result
    }
    /*
     Given an integer array nums of length n and an integer target, find three integers in nums such that the sum is closest to target.
     
     Return the sum of the three integers.
     
     You may assume that each input would have exactly one solution.
     
     
     
     Example 1:
     
     Input: nums = [-1,2,1,-4], target = 1
     Output: 2
     Explanation: The sum that is closest to the target is 2. (-1 + 2 + 1 = 2).
     Example 2:
     
     Input: nums = [0,0,0], target = 1
     Output: 0
     Explanation: The sum that is closest to the target is 0. (0 + 0 + 0 = 0).
     
     
     Constraints:
     
     3 <= nums.length <= 500
     -1000 <= nums[i] <= 1000
     -104 <= target <= 104
     */
    static func threeSumClosest(_ nums: [Int], _ target: Int) -> Int {
        // Step 1: Sort the array to use the two-pointer technique
        let nums = nums.sorted()
        var closestSum = nums[0] + nums[1] + nums[2]
        
        // Step 2: Iterate through each element as a fixed first element
        for i in 0..<nums.count - 2 {
            var left = i + 1
            var right = nums.count - 1
            
            // Step 3: Use two pointers to find the best match
            while left < right {
                let currentSum = nums[i] + nums[left] + nums[right]
                
                // Update closest sum if the current one is closer
                if abs(currentSum - target) < abs(closestSum - target) {
                    closestSum = currentSum
                }
                
                // Move pointers based on comparison with target
                if currentSum < target {
                    left += 1
                } else if currentSum > target {
                    right -= 1
                } else {
                    // If exact match found, return it
                    return target
                }
            }
        }
        
        return closestSum
    }
    
    /*
     Given an integer array nums, return all the triplets [nums[i], nums[j], nums[k]] such that i != j, i != k, and j != k, and nums[i] + nums[j] + nums[k] == 0.
     
     Notice that the solution set must not contain duplicate triplets.
     
     
     
     Example 1:
     
     Input: nums = [-1,0,1,2,-1,-4]
     Output: [[-1,-1,2],[-1,0,1]]
     Explanation:
     nums[0] + nums[1] + nums[2] = (-1) + 0 + 1 = 0.
     nums[1] + nums[2] + nums[4] = 0 + 1 + (-1) = 0.
     nums[0] + nums[3] + nums[4] = (-1) + 2 + (-1) = 0.
     The distinct triplets are [-1,0,1] and [-1,-1,2].
     Notice that the order of the output and the order of the triplets does not matter.
     Example 2:
     
     Input: nums = [0,1,1]
     Output: []
     Explanation: The only possible triplet does not sum up to 0.
     Example 3:
     
     Input: nums = [0,0,0]
     Output: [[0,0,0]]
     Explanation: The only possible triplet sums up to 0.
     */
    func threeSum(_ nums: [Int]) -> [[Int]] {
        let nums = nums.sorted()
        var result: [[Int]] = []
        
        for i in 0..<nums.count {
            // Early termination: stop if current value > 0
            if nums[i] > 0 {
                break
            }
            
            // Skip duplicates for the first element
            if i > 0 && nums[i] == nums[i - 1] {
                continue
            }
            
            var left = i + 1
            var right = nums.count - 1
            
            while left < right {
                let sum = nums[i] + nums[left] + nums[right]
                
                if sum == 0 {
                    result.append([nums[i], nums[left], nums[right]])
                    
                    // Skip duplicates for the second element
                    while left < right && nums[left] == nums[left + 1] {
                        left += 1
                    }
                    
                    // Skip duplicates for the third element
                    while left < right && nums[right] == nums[right - 1] {
                        right -= 1
                    }
                    
                    left += 1
                    right -= 1
                } else if sum < 0 {
                    left += 1
                } else {
                    right -= 1
                }
            }
        }
        
        return result
        
    }
    
    /*
     Seven different symbols represent Roman numerals with the following values:
     
     Symbol    Value
     I    1
     V    5
     X    10
     L    50
     C    100
     D    500
     M    1000
     Roman numerals are formed by appending the conversions of decimal place values from highest to lowest. Converting a decimal place value into a Roman numeral has the following rules:
     
     If the value does not start with 4 or 9, select the symbol of the maximal value that can be subtracted from the input, append that symbol to the result, subtract its value, and convert the remainder to a Roman numeral.
     If the value starts with 4 or 9 use the subtractive form representing one symbol subtracted from the following symbol, for example, 4 is 1 (I) less than 5 (V): IV and 9 is 1 (I) less than 10 (X): IX. Only the following subtractive forms are used: 4 (IV), 9 (IX), 40 (XL), 90 (XC), 400 (CD) and 900 (CM).
     Only powers of 10 (I, X, C, M) can be appended consecutively at most 3 times to represent multiples of 10. You cannot append 5 (V), 50 (L), or 500 (D) multiple times. If you need to append a symbol 4 times use the subtractive form.
     Given an integer, convert it to a Roman numeral.
     
     
     
     Example 1:
     
     Input: num = 3749
     
     Output: "MMMDCCXLIX"
     
     Explanation:
     
     3000 = MMM as 1000 (M) + 1000 (M) + 1000 (M)
     700 = DCC as 500 (D) + 100 (C) + 100 (C)
     40 = XL as 10 (X) less of 50 (L)
     9 = IX as 1 (I) less of 10 (X)
     Note: 49 is not 1 (I) less of 50 (L) because the conversion is based on decimal places
     Example 2:
     
     Input: num = 58
     
     Output: "LVIII"
     
     Explanation:
     
     50 = L
     8 = VIII
     Example 3:
     
     Input: num = 1994
     
     Output: "MCMXCIV"
     
     Explanation:
     
     1000 = M
     900 = CM
     90 = XC
     4 = IV
     
     
     Constraints:
     
     1 <= num <= 3999
     */
    func intToRoman(_ num: Int) -> String {
        let romanMap: [(value: Int, symbol: String)] = [
            (1000, "M"),
            (900,  "CM"),
            (500,  "D"),
            (400,  "CD"),
            (100,  "C"),
            (90,   "XC"),
            (50,   "L"),
            (40,   "XL"),
            (10,   "X"),
            (9,    "IX"),
            (5,    "V"),
            (4,    "IV"),
            (1,    "I")
        ]
        
        var num = num
        var result = ""
        
        for (value, symbol) in romanMap {
            while num >= value {
                result += symbol
                num -= value
            }
        }
        
        return result
    }
    
    /*
     You are given an integer array height of length n. There are n vertical lines drawn such that the two endpoints of the ith line are (i, 0) and (i, height[i]).
     
     Find two lines that together with the x-axis form a container, such that the container contains the most water.
     
     Return the maximum amount of water a container can store.
     
     Notice that you may not slant the container.
     
     
     
     Example 1:
     barArea.png
     
     Input: height = [1,8,6,2,5,4,8,3,7]
     Output: 49
     Explanation: The above vertical lines are represented by array [1,8,6,2,5,4,8,3,7]. In this case, the max area of water (blue section) the container can contain is 49.
     Example 2:
     
     Input: height = [1,1]
     Output: 1
     
     
     Constraints:
     
     n == height.length
     2 <= n <= 105
     0 <= height[i] <= 104
     */
    func maxArea(_ height: [Int]) -> Int {
        var left = 0
        var right = height.count - 1
        var maxWater = 0
        
        while left < right {
            // Calculate width
            let width = right - left
            // Minimum of two heights defines container height
            let minHeight = min(height[left], height[right])
            // Compute current area
            let currentWater = width * minHeight
            maxWater = max(maxWater, currentWater)
            
            // Move pointer that has the smaller height
            if height[left] < height[right] {
                left += 1
            } else {
                right -= 1
            }
        }
        
        return maxWater
    }
    
    /*
     Given an input string s and a pattern p, implement regular expression matching with support for '.' and '*' where:
     
     '.' Matches any single character.
     '*' Matches zero or more of the preceding element.
     The matching should cover the entire input string (not partial).
     
     
     
     Example 1:
     
     Input: s = "aa", p = "a"
     Output: false
     Explanation: "a" does not match the entire string "aa".
     Example 2:
     
     Input: s = "aa", p = "a*"
     Output: true
     Explanation: '*' means zero or more of the preceding element, 'a'. Therefore, by repeating 'a' once, it becomes "aa".
     Example 3:
     
     Input: s = "ab", p = ".*"
     Output: true
     Explanation: ".*" means "zero or more (*) of any character (.)".
     
     
     Constraints:
     
     1 <= s.length <= 20
     1 <= p.length <= 20
     s contains only lowercase English letters.
     p contains only lowercase English letters, '.', and '*'.
     It is guaranteed for each appearance of the character '*', there will be a previous valid character to match.
     */
    func isMatch(_ s: String, _ p: String) -> Bool {
        let sChars = Array(s)
        let pChars = Array(p)
        let m = sChars.count
        let n = pChars.count
        
        // dp[i][j] = true if s[0..<i] matches p[0..<j]
        var dp = Array(
            repeating: Array(repeating: false, count: n + 1),
            count: m + 1
        )
        dp[0][0] = true
        
        // Initialize pattern for empty string s
        for j in 1...n {
            if pChars[j - 1] == "*" {
                dp[0][j] = dp[0][j - 2]
            }
        }
        
        for i in 1...m {
            for j in 1...n {
                if pChars[j - 1] == "." || pChars[j - 1] == sChars[i - 1] {
                    // Direct match or wildcard '.'
                    dp[i][j] = dp[i - 1][j - 1]
                } else if pChars[j - 1] == "*" {
                    // Star can represent 0 of the previous element
                    dp[i][j] = dp[i][j - 2]
                    // Or 1 or more if preceding matches
                    if pChars[j - 2] == "." || pChars[j - 2] == sChars[i - 1] {
                        dp[i][j] = dp[i][j] || dp[i - 1][j]
                    }
                }
            }
        }
        
        return dp[m][n]
    }
    
    /*
     Implement the myAtoi(string s) function, which converts a string to a 32-bit signed integer.
     
     The algorithm for myAtoi(string s) is as follows:
     
     Whitespace: Ignore any leading whitespace (" ").
     Signedness: Determine the sign by checking if the next character is '-' or '+', assuming positivity if neither present.
     Conversion: Read the integer by skipping leading zeros until a non-digit character is encountered or the end of the string is reached. If no digits were read, then the result is 0.
     Rounding: If the integer is out of the 32-bit signed integer range [-231, 231 - 1], then round the integer to remain in the range. Specifically, integers less than -231 should be rounded to -231, and integers greater than 231 - 1 should be rounded to 231 - 1.
     Return the integer as the final result.
     
     
     
     Example 1:
     
     Input: s = "42"
     
     Output: 42
     
     Explanation:
     
     The underlined characters are what is read in and the caret is the current reader position.
     Step 1: "42" (no characters read because there is no leading whitespace)
     ^
     Step 2: "42" (no characters read because there is neither a '-' nor '+')
     ^
     Step 3: "42" ("42" is read in)
     ^
     Example 2:
     
     Input: s = " -042"
     
     Output: -42
     
     Explanation:
     
     Step 1: "   -042" (leading whitespace is read and ignored)
     ^
     Step 2: "   -042" ('-' is read, so the result should be negative)
     ^
     Step 3: "   -042" ("042" is read in, leading zeros ignored in the result)
     ^
     Example 3:
     
     Input: s = "1337c0d3"
     
     Output: 1337
     
     Explanation:
     
     Step 1: "1337c0d3" (no characters read because there is no leading whitespace)
     ^
     Step 2: "1337c0d3" (no characters read because there is neither a '-' nor '+')
     ^
     Step 3: "1337c0d3" ("1337" is read in; reading stops because the next character is a non-digit)
     ^
     Example 4:
     
     Input: s = "0-1"
     
     Output: 0
     
     Explanation:
     
     Step 1: "0-1" (no characters read because there is no leading whitespace)
     ^
     Step 2: "0-1" (no characters read because there is neither a '-' nor '+')
     ^
     Step 3: "0-1" ("0" is read in; reading stops because the next character is a non-digit)
     ^
     Example 5:
     
     Input: s = "words and 987"
     
     Output: 0
     
     Explanation:
     
     Reading stops at the first non-digit character 'w'.
     
     
     
     Constraints:
     
     0 <= s.length <= 200
     s consists of English letters (lower-case and upper-case), digits (0-9), ' ', '+', '-', and '.'.
     */
    func myAtoi(_ s: String) -> Int {
        let chars = Array(s)
        let n = chars.count
        var i = 0
        var sign = 1
        var result = 0
        let INT_MAX = Int(Int32.max)
        let INT_MIN = Int(Int32.min)
        
        // Step 1: Skip leading whitespaces
        while i < n && chars[i] == " " {
            i += 1
        }
        
        // Step 2: Handle optional sign
        if i < n && (chars[i] == "+" || chars[i] == "-") {
            sign = chars[i] == "-" ? -1 : 1
            i += 1
        }
        
        // Step 3: Read digits
        while i < n, let digit = chars[i].wholeNumberValue {
            // Check for overflow
            if result > (INT_MAX - digit) / 10 {
                return sign == 1 ? INT_MAX : INT_MIN
            }
            result = result * 10 + digit
            i += 1
        }
        
        return result * sign
    }
    
    /*
     Given a signed 32-bit integer x, return x with its digits reversed. If reversing x causes the value to go outside the signed 32-bit integer range [-231, 231 - 1], then return 0.
     
     Assume the environment does not allow you to store 64-bit integers (signed or unsigned).
     
     
     
     Example 1:
     
     Input: x = 123
     Output: 321
     Example 2:
     
     Input: x = -123
     Output: -321
     Example 3:
     
     Input: x = 120
     Output: 21
     
     
     Constraints:
     
     -231 <= x <= 231 - 1
     */
    func reverse(_ x: Int, base: Int) -> Int {
        // Validate base (2 to 36 for standard numeral systems)
        guard base >= 2 && base <= 36 else { return 0 }
        
        // Handle the sign of the input number
        let sign = x < 0 ? -1 : 1
        // Work with absolute value to simplify digit processing
        var num = abs(x)
        var reversed = 0
        
        // Process each digit in the given base
        while num > 0 {
            // Extract the last digit in the given base
            let digit = num % base
            // Check for overflow before adding new digit
            if reversed > Int32.max / Int32(base) {
                return 0
            }
            // Build the reversed number in the given base
            reversed = reversed * base + digit
            // Remove the last digit
            num /= base
        }
        
        // Apply the original sign
        let result = sign * reversed
        
        // Check if the result is within 32-bit signed integer range
        if result < Int32.min || result > Int32.max {
            return 0
        }
        
        return result
    }
    /*
     The string "PAYPALISHIRING" is written in a zigzag pattern on a given number of rows like this: (you may want to display this pattern in a fixed font for better legibility)
     
     P   A   H   N
     A P L S I I G
     Y   I   R
     And then read line by line: "PAHNAPLSIIGYIR"
     
     Write the code that will take a string and make this conversion given a number of rows:
     
     string convert(string s, int numRows);
     
     
     Example 1:
     
     Input: s = "PAYPALISHIRING", numRows = 3
     Output: "PAHNAPLSIIGYIR"
     Example 2:
     
     Input: s = "PAYPALISHIRING", numRows = 4
     Output: "PINALSIGYAHRPI"
     Explanation:
     P     I    N
     A   L S  I G
     Y A   H R
     P     I
     Example 3:
     
     Input: s = "A", numRows = 1
     Output: "A"
     
     
     Constraints:
     
     1 <= s.length <= 1000
     s consists of English letters (lower-case and upper-case), ',' and '.'.
     1 <= numRows <= 1000
     */
    func convertZigzag(_ s: String, _ numRows: Int) -> String {
        // Handle edge cases: if numRows is 1 or greater than or equal to string length, return the string as is
        if numRows == 1 || numRows >= s.count {
            return s
        }
        
        // Initialize an array to store characters for each row
        var rows = Array(repeating: "", count: numRows)
        let chars = Array(s) // Convert string to array of characters for easier access
        var currentRow = 0   // Track the current row index
        var step = 1         // Direction of movement: 1 (down), -1 (up)
        
        // Iterate through each character in the string
        for char in chars {
            // Append the current character to the corresponding row
            rows[currentRow].append(char)
            
            // Change direction if we reach the first or last row
            if currentRow == 0 {
                step = 1 // Move down
            } else if currentRow == numRows - 1 {
                step = -1 // Move up
            }
            
            // Move to the next row based on direction
            currentRow += step
        }
        
        // Combine all rows into a single string
        return rows.joined().map { String($0) }.joined()
    }
    /*
     Given two sorted arrays nums1 and nums2 of size m and n respectively, return the median of the two sorted arrays.
     
     The overall run time complexity should be O(log (m+n)).
     
     
     
     Example 1:
     
     Input: nums1 = [1,3], nums2 = [2]
     Output: 2.00000
     Explanation: merged array = [1,2,3] and median is 2.
     Example 2:
     
     Input: nums1 = [1,2], nums2 = [3,4]
     Output: 2.50000
     Explanation: merged array = [1,2,3,4] and median is (2 + 3) / 2 = 2.5.
     
     
     Constraints:
     
     nums1.length == m
     nums2.length == n
     0 <= m <= 1000
     0 <= n <= 1000
     1 <= m + n <= 2000
     -106 <= nums1[i], nums2[i] <= 106
     */
    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        // Ensure nums1 is the shorter array to minimize binary search space
        let (A, B) = nums1.count <= nums2.count ? (nums1, nums2) : (nums2, nums1)
        let m = A.count
        let n = B.count
        let total = m + n
        let half = (total + 1) / 2 // Left partition size for odd or even total length
        
        // Binary search on the smaller array
        var left = 0
        var right = m
        
        while left <= right {
            let partitionA = (left + right) / 2 // Partition index in A
            let partitionB = half - partitionA  // Corresponding partition index in B
            
            // Get left and right elements around the partition
            let leftA = partitionA == 0 ? Int.min : A[partitionA - 1]
            let rightA = partitionA == m ? Int.max : A[partitionA]
            let leftB = partitionB == 0 ? Int.min : B[partitionB - 1]
            let rightB = partitionB == n ? Int.max : B[partitionB]
            
            // Check if we have a valid partition
            if leftA <= rightB && leftB <= rightA {
                // If total length is odd, median is the max of left elements
                if total % 2 == 1 {
                    return Double(max(leftA, leftB))
                }
                // If total length is even, median is average of max(left) and min(right)
                return Double(max(leftA, leftB) + min(rightA, rightB)) / 2.0
            } else if leftA > rightB {
                // Too many elements from A, move left
                right = partitionA - 1
            } else {
                // Too many elements from B, move right
                left = partitionA + 1
            }
        }
        
        // Should never reach here for valid inputs
        return 0.0
    }
    /*
     Given a string s, find the length of the longest substring without duplicate characters.
     
     
     
     Example 1:
     
     Input: s = "abcabcbb"
     Output: 3
     Explanation: The answer is "abc", with the length of 3.
     Example 2:
     
     Input: s = "bbbbb"
     Output: 1
     Explanation: The answer is "b", with the length of 1.
     Example 3:
     
     Input: s = "pwwkew"
     Output: 3
     Explanation: The answer is "wke", with the length of 3.
     Notice that the answer must be a substring, "pwke" is a subsequence and not a substring.
     
     
     Constraints:
     
     0 <= s.length <= 5 * 104
     s consists of English letters, digits, symbols and spaces.
     */
    func lengthOfLongestSubstring(_ s: String) -> Int {
        // Handle empty string case
        if s.isEmpty { return 0 }
        
        // Convert string to array for easier character access
        let chars = Array(s)
        // Dictionary to store the last seen position of each character
        var charIndex = [Character: Int]()
        // Start of current window
        var start = 0
        // Maximum length found so far
        var maxLength = 0
        
        // Iterate through the string
        for (end, char) in chars.enumerated() {
            // If character is seen and its last position is >= start of current window
            if let lastIndex = charIndex[char], lastIndex >= start {
                // Move window start to position after the last occurrence
                start = lastIndex + 1
            }
            // Update character's last seen position
            charIndex[char] = end
            // Update max length if current window is larger
            maxLength = max(maxLength, end - start + 1)
        }
        
        return maxLength
    }
    /*
     You are given two non-empty linked lists representing two non-negative integers. The digits are stored in reverse order, and each of their nodes contains a single digit. Add the two numbers and return the sum as a linked list.
     You may assume the two numbers do not contain any leading zero, except the number 0 itself.
     Example 1:
     Input: l1 = [2,4,3], l2 = [5,6,4]
     Output: [7,0,8]
     Explanation: 342 + 465 = 807.
     Example 2:
     Input: l1 = [0], l2 = [0]
     Output: [0]
     Example 3:
     Input: l1 = [9,9,9,9,9,9,9], l2 = [9,9,9,9]
     Output: [8,9,9,9,0,0,0,1]
     Constraints:
     The number of nodes in each linked list is in the range [1, 100].
     0 <= Node.val <= 9
     It is guaranteed that the list represents a number that does not have leading zeros.
     */
    // Definition for singly-linked list node
    public class ListNode {
        public var val: Int
        public var next: ListNode?
        public init(_ val: Int) {
            self.val = val
            self.next = nil
        }
    }
    
    // Function to add two numbers represented as linked lists
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        // Initialize a dummy node to simplify list construction
        let dummy = ListNode(0)
        var current = dummy
        var carry = 0
        
        // Pointers to traverse the input lists
        var p1 = l1
        var p2 = l2
        
        // Process both lists until all digits and carry are handled
        while p1 != nil || p2 != nil || carry != 0 {
            // Get values from lists, default to 0 if node is nil
            let x = p1?.val ?? 0
            let y = p2?.val ?? 0
            
            // Calculate sum and new carry
            let sum = x + y + carry
            carry = sum / 10
            let digit = sum % 10
            
            // Create new node with the current digit
            current.next = ListNode(digit)
            current = current.next!
            
            // Move to next nodes if available
            p1 = p1?.next
            p2 = p2?.next
        }
        
        // Return the head of the result list (skip dummy node)
        return dummy.next
    }
    /*
     Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.
     
     You may assume that each input would have exactly one solution, and you may not use the same element twice.
     
     You can return the answer in any order.
     
     
     
     Example 1:
     
     Input: nums = [2,7,11,15], target = 9
     Output: [0,1]
     Explanation: Because nums[0] + nums[1] == 9, we return [0, 1].
     Example 2:
     
     Input: nums = [3,2,4], target = 6
     Output: [1,2]
     Example 3:
     
     Input: nums = [3,3], target = 6
     Output: [0,1]
     */
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        // Create a dictionary to store number-to-index mapping
        var numToIndex: [Int: Int] = [:]
        
        // Iterate through the array with index
        for (index, num) in nums.enumerated() {
            // Calculate the complement needed to reach the target
            let complement = target - num
            
            // Check if the complement exists in the dictionary
            if let complementIndex = numToIndex[complement] {
                // If found, return the current index and the complement's index
                return [complementIndex, index]
            }
            
            // Store the current number and its index in the dictionary
            numToIndex[num] = index
        }
        
        // Return an empty array if no solution is found (though per problem constraints, this won't happen)
        return []
    }
    
    /*
     In the video game Fallout 4, the quest "Road to Freedom" requires players to reach a metal dial called the "Freedom Trail Ring" and use the dial to spell a specific keyword to open the door.
     
     Given a string ring that represents the code engraved on the outer ring and another string key that represents the keyword that needs to be spelled, return the minimum number of steps to spell all the characters in the keyword.
     
     Initially, the first character of the ring is aligned at the "12:00" direction. You should spell all the characters in key one by one by rotating ring clockwise or anticlockwise to make each character of the string key aligned at the "12:00" direction and then by pressing the center button.
     
     At the stage of rotating the ring to spell the key character key[i]:
     
     You can rotate the ring clockwise or anticlockwise by one place, which counts as one step. The final purpose of the rotation is to align one of ring's characters at the "12:00" direction, where this character must equal key[i].
     If the character key[i] has been aligned at the "12:00" direction, press the center button to spell, which also counts as one step. After the pressing, you could begin to spell the next character in the key (next stage). Otherwise, you have finished all the spelling.
     
     
     Example 1:
     
     
     Input: ring = "godding", key = "gd"
     Output: 4
     Explanation:
     For the first key character 'g', since it is already in place, we just need 1 step to spell this character.
     For the second key character 'd', we need to rotate the ring "godding" anticlockwise by two steps to make it become "ddinggo".
     Also, we need 1 more step for spelling.
     So the final output is 4.
     Example 2:
     
     Input: ring = "godding", key = "godding"
     Output: 13
     
     
     Constraints:
     
     1 <= ring.length, key.length <= 100
     ring and key consist of only lower case English letters.
     It is guaranteed that key could always be spelled by rotating ring.
     */
    // Function to find the minimum number of steps to spell the key on the Freedom Trail Ring
    func findRotateSteps(_ ring: String, _ key: String) -> Int {
        // Convert strings to character arrays for efficient access
        let ring = Array(ring)
        let key = Array(key)
        let ringLen = ring.count
        let keyLen = key.count
        
        // Memoization cache to store results of subproblems
        // dp[i][j] represents the minimum steps to spell key[i...] with ring[j] at 12:00
        var memo = [[Int]: Int]()
        
        // Helper function to compute minimum steps
        // keyIndex: current index in key
        // ringIndex: current index in ring aligned at 12:00
        func dp(_ keyIndex: Int, _ ringIndex: Int) -> Int {
            // Base case: if all key characters are spelled, no more steps needed
            if keyIndex == keyLen {
                return 0
            }
            
            // Check if result is already memoized
            let cacheKey = [keyIndex, ringIndex]
            if let cached = memo[cacheKey] {
                return cached
            }
            
            // Current character to spell
            let targetChar = key[keyIndex]
            var minSteps = Int.max
            
            // Find all occurrences of targetChar in ring
            for i in 0..<ringLen {
                if ring[i] == targetChar {
                    // Calculate clockwise and counterclockwise distances
                    let dist1 = abs(i - ringIndex)
                    let dist2 = ringLen - dist1
                    let rotations = min(dist1, dist2) // Minimum rotations needed
                    
                    // Recurse for the next character, adding rotations and 1 for button press
                    let nextSteps = dp(keyIndex + 1, i)
                    minSteps = min(minSteps, rotations + 1 + nextSteps)
                }
            }
            
            // Cache and return the result
            memo[cacheKey] = minSteps
            return minSteps
        }
        
        // Start with key index 0 and ring index 0 (initial 12:00 position)
        return dp(0, 0)
    }
    // Definition for a binary tree node
    public class TreeNode {
        public var val: Int
        public var left: TreeNode?
        public var right: TreeNode?
        public init(_ val: Int) {
            self.val = val
            self.left = nil
            self.right = nil
        }
    }
    
    // Function to find the largest value in each row of a binary tree
    func largestValues(_ root: TreeNode?) -> [Int] {
        // Handle edge case: empty tree returns empty array
        guard let root = root else { return [] }
        
        // Initialize result array to store maximum values per level
        var result: [Int] = []
        
        // Initialize queue for BFS, starting with the root node
        var queue: [TreeNode] = [root]
        
        // Process each level of the tree
        while !queue.isEmpty {
            // Get the number of nodes in the current level
            let levelSize = queue.count
            // Initialize maximum value for the current level
            var levelMax = Int.min
            
            // Process all nodes in the current level
            for _ in 0..<levelSize {
                // Dequeue the next node
                let node = queue.removeFirst()
                
                // Update maximum value for the current level
                levelMax = max(levelMax, node.val)
                
                // Add left child to queue if it exists
                if let left = node.left {
                    queue.append(left)
                }
                // Add right child to queue if it exists
                if let right = node.right {
                    queue.append(right)
                }
            }
            
            // Append the maximum value of the current level to the result
            result.append(levelMax)
        }
        
        // Return the array of maximum values
        return result
    }
    /*
     Given the root of a binary tree, return the leftmost value in the last row of the tree.
     Example 1:
     Input: root = [2,1,3]
     Output: 1
     Example 2:
     Input: root = [1,2,3,4,null,5,6,null,null,7]
     Output: 7
     Constraints:
     The number of nodes in the tree is in the range [1, 104].
     -231 <= Node.val <= 231 - 1
     */
    // Function to find the leftmost value in the last row of a binary tree
    func findBottomLeftValue(_ root: TreeNode?) -> Int {
        // Since the tree is guaranteed to have at least one node, root is non-nil
        guard let root = root else { fatalError("Tree is guaranteed to have at least one node") }
        
        // Initialize queue for BFS, starting with the root node
        var queue: [TreeNode] = [root]
        // Variable to store the leftmost value of the last level
        var leftmostValue = root.val
        
        // Process the tree level by level
        while !queue.isEmpty {
            // Get the number of nodes in the current level
            let levelSize = queue.count
            // Store the value of the first node in the current level
            leftmostValue = queue[0].val
            
            // Process all nodes in the current level
            for _ in 0..<levelSize {
                // Dequeue the next node
                let node = queue.removeFirst()
                
                // Add left child to queue if it exists (processed first for left-to-right order)
                if let left = node.left {
                    queue.append(left)
                }
                // Add right child to queue if it exists
                if let right = node.right {
                    queue.append(right)
                }
            }
        }
        
        // Return the leftmost value of the last level processed
        return leftmostValue
    }
    /*
     You have n super washing machines on a line. Initially, each washing machine has some dresses or is empty.
     
     For each move, you could choose any m (1 <= m <= n) washing machines, and pass one dress of each washing machine to one of its adjacent washing machines at the same time.
     
     Given an integer array machines representing the number of dresses in each washing machine from left to right on the line, return the minimum number of moves to make all the washing machines have the same number of dresses. If it is not possible to do it, return -1.
     
     
     
     Example 1:
     
     Input: machines = [1,0,5]
     Output: 3
     Explanation:
     1st move:    1     0 <-- 5    =>    1     1     4
     2nd move:    1 <-- 1 <-- 4    =>    2     1     3
     3rd move:    2     1 <-- 3    =>    2     2     2
     Example 2:
     
     Input: machines = [0,3,0]
     Output: 2
     Explanation:
     1st move:    0 <-- 3     0    =>    1     2     0
     2nd move:    1     2 --> 0    =>    1     1     1
     Example 3:
     
     Input: machines = [0,2,0]
     Output: -1
     Explanation:
     It's impossible to make all three washing machines have the same number of dresses.
     
     
     Constraints:
     
     n == machines.length
     1 <= n <= 104
     0 <= machines[i] <= 105
     */
    // Function to find the minimum number of moves to equalize dresses in washing machines
    func findMinMoves(_ machines: [Int]) -> Int {
        // Handle edge case: single machine requires no moves
        guard machines.count > 1 else { return 0 }
        
        // Calculate total number of dresses and number of machines
        let totalDresses = machines.reduce(0, +)
        let n = machines.count
        
        // Check if equal distribution is possible
        // Total dresses must be divisible by number of machines
        guard totalDresses % n == 0 else { return -1 }
        
        // Calculate target number of dresses per machine
        let target = totalDresses / n
        
        // Initialize variables to track moves and cumulative dress difference
        var maxMoves = 0 // Maximum moves required through any point
        var balance = 0 // Running sum of dresses relative to target
        
        // Iterate through each machine
        for dresses in machines {
            // Calculate how many dresses need to be moved to/from this machine
            let diff = dresses - target
            // Update balance: positive means excess dresses, negative means deficit
            balance += diff
            // Maximum moves is the maximum of:
            // - Absolute balance (dresses that must pass through this point)
            // - Current machine's excess dresses (if positive)
            maxMoves = max(maxMoves, max(abs(balance), diff))
        }
        
        // Return the minimum number of moves required
        return maxMoves
    }
    /*
     Given a string s, find the longest palindromic subsequence's length in s.
     
     A subsequence is a sequence that can be derived from another sequence by deleting some or no elements without changing the order of the remaining elements.
     
     
     
     Example 1:
     
     Input: s = "bbbab"
     Output: 4
     Explanation: One possible longest palindromic subsequence is "bbbb".
     Example 2:
     
     Input: s = "cbbd"
     Output: 2
     Explanation: One possible longest palindromic subsequence is "bb".
     */
    // Function to find the length of the longest palindromic subsequence in a string
    func longestPalindromeSubseq(_ s: String) -> Int {
        // Handle edge cases: empty string returns 0, single character returns 1
        guard !s.isEmpty else { return 0 }
        if s.count == 1 { return 1 }
        
        // Convert string to array for efficient character access
        let chars = Array(s)
        let n = chars.count
        
        // Initialize a 2D DP table to store lengths of palindromic subsequences
        // dp[i][j] represents the length of the longest palindromic subsequence in s[i...j]
        var dp = Array(repeating: Array(repeating: 0, count: n), count: n)
        
        // Base case: every single character is a palindrome of length 1
        for i in 0..<n {
            dp[i][i] = 1
        }
        
        // Iterate over substring lengths from 2 to n
        for length in 2...n {
            // Iterate over possible starting indices for the current length
            for start in 0...(n - length) {
                // Calculate the end index of the current substring
                let end = start + length - 1
                
                // Case 1: If characters at start and end match and length is 2, set length to 2
                if chars[start] == chars[end] && length == 2 {
                    dp[start][end] = 2
                }
                // Case 2: If characters at start and end match, include them and add inner subsequence length
                else if chars[start] == chars[end] {
                    dp[start][end] = dp[start + 1][end - 1] + 2
                }
                // Case 3: If characters don't match, take the maximum of subsequences excluding either end
                else {
                    dp[start][end] = max(dp[start + 1][end], dp[start][end - 1])
                }
            }
        }
        
        // Return the length of the longest palindromic subsequence for the entire string
        return dp[0][n - 1]
    }
    
    /*
     Palindromic Substrings
     Medium
     Topics
     premium lock icon
     Companies
     Hint
     Given a string s, return the number of palindromic substrings in it.
     
     A string is a palindrome when it reads the same backward as forward.
     
     A substring is a contiguous sequence of characters within the string.
     
     
     
     Example 1:
     
     Input: s = "abc"
     Output: 3
     Explanation: Three palindromic strings: "a", "b", "c".
     Example 2:
     
     Input: s = "aaa"
     Output: 6
     Explanation: Six palindromic strings: "a", "a", "a", "aa", "aa", "aaa".
     
     
     Constraints:
     
     1 <= s.length <= 1000
     s consists of lowercase English letters.
     */
    func countSubstrings(_ s: String) -> Int {
        // Handle edge cases
        guard !s.isEmpty else { return 0 }
        
        let chars = Array(s)
        var count = 0
        
        // Helper function to count palindromes expanding around a center
        func countPalindromes(left: Int, right: Int) {
            var left = left
            var right = right
            
            // Expand while within bounds and characters match
            while left >= 0 && right < chars.count && chars[left] == chars[right] {
                count += 1 // Increment count for each valid palindrome
                left -= 1
                right += 1
            }
        }
        
        // Iterate through each possible center
        for i in 0..<chars.count {
            // Count odd-length palindromes (single character center)
            countPalindromes(left: i, right: i)
            // Count even-length palindromes (between i and i+1)
            countPalindromes(left: i, right: i + 1)
        }
        
        return count
    }
    
    /*
     Given a string s, return the longest palindromic substring in s.
     
     
     
     Example 1:
     
     Input: s = "babad"
     Output: "bab"
     Explanation: "aba" is also a valid answer.
     Example 2:
     
     Input: s = "cbbd"
     Output: "bb"
     */
    func longestPalindrome(_ s: String) -> String {
        // Handle edge cases
        guard !s.isEmpty else { return "" }
        if s.count == 1 { return s }
        
        let chars = Array(s)
        var start = 0
        var maxLength = 1
        
        // Helper function to expand around a center
        func expandAroundCenter(left: Int, right: Int) -> (Int, Int) {
            var left = left
            var right = right
            
            // Expand while within bounds and characters match
            while left >= 0 && right < chars.count && chars[left] == chars[right] {
                left -= 1
                right += 1
            }
            
            // Return start index and length of palindrome
            return (left + 1, right - left - 1)
        }
        
        // Iterate through each possible center
        for i in 0..<chars.count {
            // Check odd-length palindromes (single character center)
            let (start1, length1) = expandAroundCenter(left: i, right: i)
            // Check even-length palindromes (between i and i+1)
            let (start2, length2) = expandAroundCenter(left: i, right: i + 1)
            
            // Update if we find a longer palindrome
            if length1 > maxLength {
                start = start1
                maxLength = length1
            }
            if length2 > maxLength {
                start = start2
                maxLength = length2
            }
        }
        // Extract the substring using the start index and length
        let startIndex = s.index(s.startIndex, offsetBy: start)
        let endIndex = s.index(startIndex, offsetBy: maxLength)
        return String(s[startIndex..<endIndex])
    }
    
    func numDistinct(_ s: String, _ t: String) -> Int {
        let sChars = Array(s)
        let tChars = Array(t)
        let sCount = sChars.count
        let tCount = tChars.count
        
        // dp[i][j] represents the number of distinct subsequences of s[0...j-1]
        // that equal t[0...i-1].
        // The array size is (tCount + 1) x (sCount + 1) to handle empty prefixes.
        var dp = Array(repeating: Array(repeating: 0, count: sCount + 1), count: tCount + 1)
        
        // Initialization:
        // dp[0][j] = 1 for all j: An empty string t can always be formed in one way
        // (by deleting all characters) from any prefix of s.
        for j in 0...sCount {
            dp[0][j] = 1
        }
        
        // dp[i][0] = 0 for all i > 0: A non-empty string t cannot be formed from an empty string s.
        // This is already handled by the default initialization of 0s.
        
        // Fill the dp table
        for i in 1...tCount {
            for j in 1...sCount {
                if sChars[j-1] == tChars[i-1] {
                    // Case 1: Characters match.
                    // We can either use sChars[j-1] to match tChars[i-1] (dp[i-1][j-1])
                    // OR we can choose not to use sChars[j-1] (dp[i][j-1]).
                    dp[i][j] = dp[i-1][j-1] + dp[i][j-1]
                } else {
                    // Case 2: Characters don't match.
                    // We cannot use sChars[j-1] to match tChars[i-1].
                    // So, the number of distinct subsequences is the same as
                    // not considering sChars[j-1].
                    dp[i][j] = dp[i][j-1]
                }
            }
        }
        
        return dp[tCount][sCount]
    }
    
    // Function to demonstrate the solution
    func demo_DistinctSubsequences() {
        /*
         Given two strings s and t, return the number of distinct subsequences of s which equals t.
         
         The test cases are generated so that the answer fits on a 32-bit signed integer.
         
          
         
         Example 1:
         
         Input: s = "rabbbit", t = "rabbit"Output: 3Explanation:
         
         As shown below, there are 3 ways you can generate "rabbit" from s.rabbbitrabbbitrabbbit
         
         Example 2:
         
         Input: s = "babgbag", t = "bag"Output: 5Explanation:
         
         As shown below, there are 5 ways you can generate "bag" from s.babgbagbabgbagbabgbagbabgbagbabgbag
         
          
         
         Constraints:
         
         1 <= s.length, t.length <= 1000
         
         s and t consist of English letters.
         */
        let solution = self//Solution()
        
        // Example 1
        let s1 = "rabbbit"
        let t1 = "rabbit"
        let result1 = solution.numDistinct(s1, t1)
        print("Input: s = \"\(s1)\", t = \"\(t1)\"")
        print("Output: \(result1)") // Expected: 3
        print("---")
        
        // Example 2
        let s2 = "babgbag"
        let t2 = "bag"
        let result2 = solution.numDistinct(s2, t2)
        print("Input: s = \"\(s2)\", t = \"\(t2)\"")
        print("Output: \(result2)") // Expected: 5
        print("---")
    }
    
    
    func minDistance(_ word1: String, _ word2: String) -> Int {
        let m = word1.count
        let n = word2.count
        
        // Convert strings to array of characters for easier access
        let chars1 = Array(word1)
        let chars2 = Array(word2)
        
        // Create DP table with dimensions (m+1) x (n+1)
        var dp = [[Int]](repeating: [Int](repeating: 0, count: n + 1), count: m + 1)
        
        // Initialize first row and column
        for i in 0...m {
            dp[i][0] = i // Cost of deleting characters from word1
        }
        for j in 0...n {
            dp[0][j] = j // Cost of inserting characters from word2
        }
        
        // Fill DP table
        for i in 1...m {
            for j in 1...n {
                if chars1[i-1] == chars2[j-1] {
                    // Characters match, no operation needed
                    dp[i][j] = dp[i-1][j-1]
                } else {
                    // Take minimum of three operations:
                    // 1. Replace: dp[i-1][j-1] + 1
                    // 2. Delete: dp[i-1][j] + 1
                    // 3. Insert: dp[i][j-1] + 1
                    dp[i][j] = min(
                        dp[i-1][j-1] + 1, // Replace
                        dp[i-1][j] + 1,   // Delete
                        dp[i][j-1] + 1    // Insert
                    )
                }
            }
        }
        
        return dp[m][n]
    }
    func minDistance_demo(){
        // Test cases
        let test1 = minDistance("horse", "ros") // Output: 3
        let test2 = minDistance("intention", "execution") // Output: 5
        print("Test 1: \(test1)")
        print("Test 2: \(test2)")
    }
    
    func mincostTickets(_ days: [Int], _ costs: [Int]) -> Int {
        let lastDay = days.last! // The last day you travel
        var dp = Array(repeating: 0, count: lastDay + 1) // dp[i] is min cost to travel up to day i
        
        // For efficient lookup of travel days
        var isTravelDay = Array(repeating: false, count: lastDay + 1)
        for day in days {
            isTravelDay[day] = true
        }
        
        // Iterate from day 1 up to the last travel day
        for i in 1...lastDay {
            // If day 'i' is not a travel day, the cost is the same as the day before
            if !isTravelDay[i] {
                dp[i] = dp[i-1]
                continue // Move to the next day
            }
            
            // If day 'i' is a travel day, we have three options:
            
            // Option 1: Buy a 1-day pass today
            let cost1Day = dp[i-1] + costs[0]
            
            // Option 2: Buy a 7-day pass today. It covers days [i-6, i].
            // The cost is dp[day before 7-day pass starts] + cost of 7-day pass.
            // max(0, i-7) ensures we don't go out of bounds for dp array.
            let cost7Day = dp[max(0, i-7)] + costs[1]
            
            // Option 3: Buy a 30-day pass today. It covers days [i-29, i].
            // Similar logic for the 30-day pass.
            let cost30Day = dp[max(0, i-30)] + costs[2]
            
            // Take the minimum of the three options
            dp[i] = min(cost1Day, cost7Day, cost30Day)
        }
        
        return dp[lastDay]
    }
    func demon_mincostTicket() {
        // Example Usage:
        let solution = self//Solution()
        
        // Example 1
        let days1 = [1,4,6,7,8,20]
        let costs1 = [2,7,15]
        print("Example 1 Output: \(solution.mincostTickets(days1, costs1))") // Expected: 11
        
        // Example 2
        let days2 = [1,2,3,4,5,6,7,8,9,10,30,31]
        let costs2 = [2,7,15]
        print("Example 2 Output: \(solution.mincostTickets(days2, costs2))") // Expected: 17
        
        // Custom Test Case
        let days3 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        let costs3 = [2, 3, 10] // 1-day: 2, 7-day: 3, 30-day: 10
        print("Custom 1 Output: \(solution.mincostTickets(days3, costs3))") // Expected: 6 (buy one 7-day pass on day 1 for 3, one 7-day pass on day 8 for 3. Total 6)
        
        // Another Custom Test Case
        let days4 = [1, 365]
        let costs4 = [10, 50, 100]
        print("Custom 2 Output: \(solution.mincostTickets(days4, costs4))") // Expected: 20 (1-day on day 1, 1-day on day 365) or 50 (7-day on day 365 if it covers day 1, but it doesn't. 100 for 30-day pass covers both. So 20 or 100. 20 is min.)
        // Explanation for Custom 2:
        // dp[1] = 10
        // dp[365]: min(dp[364]+10, dp[358]+50, dp[335]+100)
        // Since days 2-364 are not travel days, dp[364] = dp[1] = 10.
        // dp[358] = dp[1] = 10.
        // dp[335] = dp[1] = 10.
        // dp[365] = min(10+10, 10+50, 10+100) = min(20, 60, 110) = 20. Correct.
    }
    
    //coins = [1, 2, 5]
    //amount = 11
    //→ dp[11] = 3 → 5 + 5 + 1
    //    coins = [2]
    //    amount = 3
    //    → fail 3 from [2] → -1
    func coinChange(_ coins: [Int], _ amount: Int) -> Int {
        var dp = Array(repeating: Int.max, count: amount + 1)
        dp[0] = 0
        
        for x in 1...amount {
            for coin in coins {
                if x >= coin, dp[x - coin] != Int.max {
                    dp[x] = min(dp[x], dp[x - coin] + 1)
                }
            }
        }
        
        return dp[amount] == Int.max ? -1 : dp[amount]
    }
    
    func maxAlternatingSum(_ nums: [Int]) -> Int {
        var evenSum = 0 // Represents the maximum alternating sum ending with an element at an even index
        var oddSum = 0  // Represents the maximum alternating sum ending with an element at an odd index
        
        for num in nums {
            // Store the current `evenSum` before it's updated, as `oddSum`'s update depends on the old `evenSum`.
            let prevEvenSum = evenSum
            
            // Calculate the new `evenSum`:
            // Option 1: Keep the current `evenSum` (don't include `num` or `num` is part of an existing optimal evenSum subsequence).
            // Option 2: Extend an `oddSum` subsequence by adding `num`. `num` becomes an even-indexed element.
            evenSum = max(evenSum, oddSum + num)
            
            // Calculate the new `oddSum`:
            // Option 1: Keep the current `oddSum` (don't include `num` or `num` is part of an existing optimal oddSum subsequence).
            // Option 2: Extend a `prevEvenSum` subsequence by subtracting `num`. `num` becomes an odd-indexed element.
            oddSum = max(oddSum, prevEvenSum - num)
        }
        
        // The maximum alternating sum will always be found in `evenSum`.
        // This is because if the optimal sum ended with a subtracted number (an odd index),
        // you could always remove that last number and get a larger sum (or at least the same if the number was 0).
        // Therefore, the maximum sum must end with an added number (an even index).
        return evenSum
    }
    func demomaxAlternatingSum(){
        
        // Example Usage:
        let solution = Solution()
        
        // Example 1:
        let nums1 = [4, 2, 5, 3]
        print("Input: \(nums1), Output: \(solution.maxAlternatingSum(nums1))") // Expected: 7
        
        // Example 2:
        let nums2 = [5, 6, 7, 8]
        print("Input: \(nums2), Output: \(solution.maxAlternatingSum(nums2))") // Expected: 8
        
        // Example 3:
        let nums3 = [6, 2, 1, 2, 4, 5]
        print("Input: \(nums3), Output: \(solution.maxAlternatingSum(nums3))") // Expected: 10
        
        // Additional Test Cases:
        let nums4 = [1, 2, 3, 4]
        print("Input: \(nums4), Output: \(solution.maxAlternatingSum(nums4))") // Expected: 4 (subsequence [4])
        
        let nums5 = [10]
        print("Input: \(nums5), Output: \(solution.maxAlternatingSum(nums5))") // Expected: 10 (subsequence [10])
        
        let nums6 = [1, 10, 1, 10, 1]
        print("Input: \(nums6), Output: \(solution.maxAlternatingSum(nums6))") // Expected: 19 (subsequence [10, 1, 10]) or [10,10,1]
        /*
         So the optimal subsequence is:
         [1, -20, 3, -40, 5, -60, 7, -80, 9]
         
         Let's calculate its alternating sum:
         1−(−20)+3−(−40)+5−(−60)+7−(−80)+9
         =1+20+3+40+5+60+7+80+9
         =21+3+40+5+60+7+80+9
         =24+40+5+60+7+80+9
         =64+5+60+7+80+9
         =69+60+7+80+9
         =129+7+80+9
         =136+80+9
         =216+9
         =225
         */
    }
    // Maximum robber dp[i] = max(dp[i - 1], dp[i - 2] + nums[i])
    func rob(_ nums: [Int]) -> Int {
        let n = nums.count
        if n == 0 { return 0 }
        if n == 1 { return nums[0] }
        
        var dp = Array(repeating: 0, count: n)
        dp[0] = nums[0]
        dp[1] = max(nums[0], nums[1])
        
        for i in 2..<n {
            dp[i] = max(dp[i - 1], dp[i - 2] + nums[i])
        }
        
        return dp[n - 1]
    }
    // Time complexity: O(n) Space complexity: O(1)
    func robMin(_ nums: [Int]) -> Int {
        var prev1 = 0
        var prev2 = 0
        
        for num in nums {
            let temp = max(prev1, prev2 + num)
            prev2 = prev1
            prev1 = temp
        }
        
        return prev1
    }
    
    // iterative time O(n), memory — O(1).
    func climbStairs(_ n: Int) -> Int {
        if n <= 2 {
            return n
        }
        
        var first = 1  // ways(1)
        var second = 2 // ways(2)
        
        for _ in 3...n {
            let third = first + second
            first = second
            second = third
        }
        
        return second
    }
    
    // recursive with exponential time  O(2^n) !!! memory  O(n) stack for recursion
    func climbStairsUgly(_ n: Int) -> Int {
        if n <= 2 {
            return n
        }
        return climbStairsUgly(n - 1) + climbStairsUgly(n - 2)
    }
    
    // recursive with memo time O(n), memory — O(n).
    private var memo = [Int: Int]()
    
    func climbStairsR(_ n: Int) -> Int {
        if n <= 2 {
            return n
        }
        if let result = memo[n] {
            return result
        }
        let result = climbStairsR(n - 1) + climbStairsR(n - 2)
        memo[n] = result
        return result
    }
}
/*
 task: Rober
 ou are a professional robber planning to rob houses along a street. Each house has a certain amount of money stashed, the only constraint stopping you from robbing each of them is that adjacent houses have security systems connected and it will automatically contact the police if two adjacent houses were broken into on the same night.
 
 Given an integer array nums representing the amount of money of each house, return the maximum amount of money you can rob tonight without alerting the police.
 
 
 
 Example 1:
 
 Input: nums = [1,2,3,1]
 Output: 4
 Explanation: Rob house 1 (money = 1) and then rob house 3 (money = 3).
 Total amount you can rob = 1 + 3 = 4.
 Example 2:
 
 Input: nums = [2,7,9,3,1]
 Output: 12
 Explanation: Rob house 1 (money = 2), rob house 3 (money = 9) and rob house 5 (money = 1).
 Total amount you can rob = 2 + 9 + 1 = 12.
 
 task: Climbing Stairs
 Easy
 Topics
 premium lock icon
 Companies
 Hint
 You are climbing a staircase. It takes n steps to reach the top.
 
 Each time you can either climb 1 or 2 steps. In how many distinct ways can you climb to the top?
 
 
 
 Example 1:
 
 Input: n = 2
 Output: 2
 Explanation: There are two ways to climb to the top.
 1. 1 step + 1 step
 2. 2 steps
 Example 2:
 
 Input: n = 3
 Output: 3
 Explanation: There are three ways to climb to the top.
 1. 1 step + 1 step + 1 step
 2. 1 step + 2 steps
 3. 2 steps + 1 step
 
 */
