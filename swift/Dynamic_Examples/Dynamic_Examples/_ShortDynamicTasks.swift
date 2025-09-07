//
//  ClimbingStair.swift
//  Dynamic_Examples
//
//  Created by Simon Getrik on 19.06.2025.
//

import Foundation
class Solution {
    /*
     91. Decode Ways
     Medium
     Topics
     premium lock icon
     Companies
     You have intercepted a secret message encoded as a string of numbers. The message is decoded via the following mapping:
     "1" -> 'A'
     "2" -> 'B'
     ...
     "25" -> 'Y'
     "26" -> 'Z'
     However, while decoding the message, you realize that there are many different ways you can decode the message because some codes are contained in other codes ("2" and "5" vs "25").
     For example, "11106" can be decoded into:
     "AAJF" with the grouping (1, 1, 10, 6)
     "KJF" with the grouping (11, 10, 6)
     The grouping (1, 11, 06) is invalid because "06" is not a valid code (only "6" is valid).
     Note: there may be strings that are impossible to decode.
     Given a string s containing only digits, return the number of ways to decode it. If the entire string cannot be decoded in any valid way, return 0.
     The test cases are generated so that the answer fits in a 32-bit integer.
     Example 1:
     Input: s = "12"
     Output: 2
     Explanation:
     "12" could be decoded as "AB" (1 2) or "L" (12).
     Example 2:
     Input: s = "226"
     Output: 3
     Explanation:
     "226" could be decoded as "BZ" (2 26), "VF" (22 6), or "BBF" (2 2 6).
     Example 3:
     Input: s = "06"
     Output: 0
     Explanation:
     "06" cannot be mapped to "F" because of the leading zero ("6" is different from "06"). In this case, the string is not a valid encoding, so return 0.
     Constraints:
     1 <= s.length <= 100
     s contains only digits and may contain leading zero(s).
     */
    class DecodeWays {
        /// Returns the number of ways to decode the given string using mapping 1 -> 'A' ... 26 -> 'Z'
        static func numDecodings(_ s: String) -> Int {
            let chars = Array(s)
            let n = chars.count
            
            // If the string is empty or starts with '0', it's invalid
            if n == 0 || chars[0] == "0" {
                return 0
            }
            
            // DP array to store decoding counts
            var dp = Array(repeating: 0, count: n + 1)
            
            // Base cases
            dp[0] = 1 // Empty string
            dp[1] = 1 // First character is valid since it's not zero
            
            // Fill dp table
            for i in 2...n {
                // Check single digit
                if chars[i - 1] != "0" {
                    dp[i] += dp[i - 1]
                }
                
                // Check two digits
                let twoDigit = Int(String(chars[i - 2...i - 1]))!
                if twoDigit >= 10 && twoDigit <= 26 {
                    dp[i] += dp[i - 2]
                }
            }
            
            return dp[n]
        }
    }

    /*
     90. Subsets II
     Medium
     Topics
     premium lock icon
     Companies
     Given an integer array nums that may contain duplicates, return all possible subsets (the power set).
     
     The solution set must not contain duplicate subsets. Return the solution in any order.
     
     
     
     Example 1:
     
     Input: nums = [1,2,2]
     Output: [[],[1],[1,2],[1,2,2],[2],[2,2]]
     Example 2:
     
     Input: nums = [0]
     Output: [[],[0]]
     
     
     Constraints:
     
     1 <= nums.length <= 10
     -10 <= nums[i] <= 10
     
     
     Accepted
     1,304,634/2.2M
     Acceptance Rate
     60.1%
     Topics
     icon
     Companies
     Similar Questions
     Discussion (152)
     */
    class SubsetsII {
        /// Generates all unique subsets of nums, even when duplicates exist.
        static func subsetsWithDup(_ nums: [Int]) -> [[Int]] {
            var result: [[Int]] = []
            var subset: [Int] = []
            let sortedNums = nums.sorted()
            
            func dfs(_ start: Int) {
                // Add current subset to the result
                result.append(subset)
                
                // Explore further numbers
                for i in start..<sortedNums.count {
                    // Skip duplicates: if current num equals previous AND previous was not included
                    if i > start && sortedNums[i] == sortedNums[i - 1] {
                        continue
                    }
                    
                    // Choose the current number
                    subset.append(sortedNums[i])
                    
                    // Recurse with next index
                    dfs(i + 1)
                    
                    // Backtrack: remove last added number
                    subset.removeLast()
                }
            }
            
            dfs(0)
            return result
        }
    }
    
    /*
     89. Gray Code Medium Topics premium lock icon Companies An n-bit gray code sequence is a sequence of 2n integers where: Every integer is in the inclusive range [0, 2n - 1], The first integer is 0, An integer appears no more than once in the sequence, The binary representation of every pair of adjacent integers differs by exactly one bit, and The binary representation of the first and last integers differs by exactly one bit. Given an integer n, return any valid n-bit gray code sequence. Example 1: Input: n = 2 Output: [0,1,3,2] Explanation: The binary representation of [0,1,3,2] is [00,01,11,10]. - 00 and 01 differ by one bit - 01 and 11 differ by one bit - 11 and 10 differ by one bit - 10 and 00 differ by one bit [0,2,3,1] is also a valid gray code sequence, whose binary representation is [00,10,11,01]. - 00 and 10 differ by one bit - 10 and 11 differ by one bit - 11 and 01 differ by one bit - 01 and 00 differ by one bit Example 2: Input: n = 1 Output: [0,1] Constraints: 1 <= n <= 16
     */
    class GrayCodeGenerator {
        
        /// Generates n-bit Gray code sequence
        static func grayCode(_ n: Int) -> [Int] {
            var result: [Int] = [0]
            
            // Iterate over bit positions
            for i in 0..<n {
                let addOn = 1 << i // The bit to set
                
                // Reflect current result and add new bit
                for j in stride(from: result.count - 1, through: 0, by: -1) {
                    result.append(result[j] | addOn)
                }
            }
            return result
        }
    }
    /*
     87. Scramble String
     We can scramble a string s to get a string t using the following algorithm:
     If the length of the string is 1, stop.
     If the length of the string is > 1, do the following:
     Split the string into two non-empty substrings at a random index, i.e., if the string is s, divide it to x and y where s = x + y.
     Randomly decide to swap the two substrings or to keep them in the same order. i.e., after this step, s may become s = x + y or s = y + x.
     Apply step 1 recursively on each of the two substrings x and y.
     Given two strings s1 and s2 of the same length, return true if s2 is a scrambled string of s1, otherwise, return false.
     Example 1:
     Input: s1 = "great", s2 = "rgeat"
     Output: true
     Explanation: One possible scenario applied on s1 is:
     "great" --> "gr/eat" // divide at random index.
     "gr/eat" --> "gr/eat" // random decision is not to swap the two substrings and keep them in order.
     "gr/eat" --> "g/r / e/at" // apply the same algorithm recursively on both substrings. divide at random index each of them.
     "g/r / e/at" --> "r/g / e/at" // random decision was to swap the first substring and to keep the second substring in the same order.
     "r/g / e/at" --> "r/g / e/ a/t" // again apply the algorithm recursively, divide "at" to "a/t".
     "r/g / e/ a/t" --> "r/g / e/ a/t" // random decision is to keep both substrings in the same order.
     The algorithm stops now, and the result string is "rgeat" which is s2.
     As one possible scenario led s1 to be scrambled to s2, we return true.
     Example 2:
     Input: s1 = "abcde", s2 = "caebd"
     Output: false
     Example 3:
     Input: s1 = "a", s2 = "a"
     Output: true
     */
    class ScrambleStringSolver {
        
        // Memoization cache to store computed results
        private static var memo: [String: Bool] = [:]
        
        // Public function
        static func isScramble(_ s1: String, _ s2: String) -> Bool {
            memo.removeAll()
            return helper(Array(s1), Array(s2))
        }
        
        // Recursive helper function
        private static func helper(_ s1: [Character], _ s2: [Character]) -> Bool {
            let key = String(s1) + "#" + String(s2)
            
            // If already computed, return cached result
            if let cached = memo[key] {
                return cached
            }
            
            // If strings are equal → scrambled
            if s1 == s2 {
                memo[key] = true
                return true
            }
            
            // If sorted characters are different → impossible
            if s1.sorted() != s2.sorted() {
                memo[key] = false
                return false
            }
            
            let n = s1.count
            for i in 1..<n {
                // Case 1: No swap
                let noSwap = helper(Array(s1[0..<i]), Array(s2[0..<i])) &&
                             helper(Array(s1[i..<n]), Array(s2[i..<n]))
                
                if noSwap {
                    memo[key] = true
                    return true
                }
                
                // Case 2: With swap
                let swap = helper(Array(s1[0..<i]), Array(s2[n-i..<n])) &&
                           helper(Array(s1[i..<n]), Array(s2[0..<n-i]))
                
                if swap {
                    memo[key] = true
                    return true
                }
            }
            
            memo[key] = false
            return false
        }
    }

    /*
     85. Maximal Rectangle     Hard
     Given a rows x cols binary matrix filled with 0's and 1's, find the largest rectangle containing only 1's and return its area.
     Example 1:
     Input: matrix = [["1","0","1","0","0"],["1","0","1","1","1"],["1","1","1","1","1"],["1","0","0","1","0"]]
     Output: 6
     Explanation: The maximal rectangle is shown in the above picture.
     Example 2:
     Input: matrix = [["0"]]
     Output: 0
     Example 3:
     Input: matrix = [["1"]]
     Output: 1
     Constraints:
     rows == matrix.length
     cols == matrix[i].length
     1 <= row, cols <= 200
     matrix[i][j] is '0' or '1'.
     */
    class MaximalRectangleSolver {
        
        // MARK: - Brute Force Solution
        // Time Complexity: O((m*n)^2)
        // Space Complexity: O(1)
        static func maximalRectangleBruteForce(_ matrix: [[Character]]) -> Int {
            let rows = matrix.count
            let cols = matrix[0].count
            var maxArea = 0
            
            // Iterate over all top-left corners of rectangles
            for i in 0..<rows {
                for j in 0..<cols {
                    // If we encounter '1', try to expand rectangle
                    if matrix[i][j] == "1" {
                        var minWidth = Int.max
                        for k in i..<rows {
                            if matrix[k][j] == "0" {
                                break
                            }
                            
                            // Calculate current row width of consecutive '1's
                            var width = 0
                            var col = j
                            while col < cols && matrix[k][col] == "1" {
                                width += 1
                                col += 1
                            }
                            
                            minWidth = min(minWidth, width)
                            let height = k - i + 1
                            maxArea = max(maxArea, minWidth * height)
                        }
                    }
                }
            }
            
            return maxArea
        }
        
        // MARK: - Optimal Stack Solution (Histogram Approach)
        // Time Complexity: O(m * n)
        // Space Complexity: O(n)
        static func maximalRectangle(_ matrix: [[Character]]) -> Int {
            guard !matrix.isEmpty else { return 0 }
            
            let rows = matrix.count
            let cols = matrix[0].count
            
            // Heights array for histogram per row
            var heights = Array(repeating: 0, count: cols)
            var maxArea = 0
            
            for i in 0..<rows {
                // Build histogram heights
                for j in 0..<cols {
                    heights[j] = matrix[i][j] == "1" ? heights[j] + 1 : 0
                }
                
                // Apply Largest Rectangle in Histogram algorithm
                maxArea = max(maxArea, largestRectangleInHistogram(heights))
            }
            
            return maxArea
        }
        
        // Helper function: Largest Rectangle in Histogram using stack
        private static func largestRectangleInHistogram(_ heights: [Int]) -> Int {
            var stack: [Int] = []
            var maxArea = 0
            let n = heights.count
            
            for i in 0...n {
                let currentHeight = i < n ? heights[i] : 0
                
                // Process bars while current bar is lower than the top of the stack
                while let last = stack.last, currentHeight < heights[last] {
                    let height = heights[stack.removeLast()]
                    let width = stack.isEmpty ? i : i - stack.last! - 1
                    maxArea = max(maxArea, height * width)
                }
                
                stack.append(i)
            }
            
            return maxArea
        }
    }

    func demo_MximalRectagle() {
        let matrix1: [[Character]] = [
            ["1","0","1","0","0"],
            ["1","0","1","1","1"],
            ["1","1","1","1","1"],
            ["1","0","0","1","0"]
        ]

        print(MaximalRectangleSolver.maximalRectangleBruteForce(matrix1)) // 6
        print(MaximalRectangleSolver.maximalRectangle(matrix1))          // 6

        let matrix2: [[Character]] = [["0"]]
        print(MaximalRectangleSolver.maximalRectangle(matrix2))          // 0

        let matrix3: [[Character]] = [["1"]]
        print(MaximalRectangleSolver.maximalRectangle(matrix3))          // 1
    }
    
    /*
     84. Largest Rectangle in Histogram
     Hard
     Topics
     premium lock icon
     Companies
     Given an array of integers heights representing the histogram's bar height where the width of each bar is 1, return the area of the largest rectangle in the histogram.
     Example 1:
     Input: heights = [2,1,5,6,2,3]
     Output: 10
     Explanation: The above is a histogram where width of each bar is 1.
     The largest rectangle is shown in the red area, which has an area = 10 units.
     Example 2:
     Input: heights = [2,4]
     Output: 4
     Constraints:
     1 <= heights.length <= 105
     0 <= heights[i] <= 104
     */
    class LargestRectangleHistogram {
        
        // MARK: - Brute Force Solution
        // Time Complexity: O(n^2)
        // Space Complexity: O(1)
        static func largestRectangleAreaBruteForce(_ heights: [Int]) -> Int {
            let n = heights.count
            var maxArea = 0
            
            // For each bar, expand left and right to find the largest rectangle
            for i in 0..<n {
                let height = heights[i]
                var left = i
                var right = i
                
                // Expand to the left while height is greater or equal
                while left > 0 && heights[left - 1] >= height {
                    left -= 1
                }
                
                // Expand to the right while height is greater or equal
                while right < n - 1 && heights[right + 1] >= height {
                    right += 1
                }
                
                let width = right - left + 1
                maxArea = max(maxArea, height * width)
            }
            
            return maxArea
        }
        
        // MARK: - Optimal Stack Solution
        // Time Complexity: O(n)
        // Space Complexity: O(n)
        static func largestRectangleAreaStack(_ heights: [Int]) -> Int {
            var stack: [Int] = []    // Will store indices of increasing heights
            var maxArea = 0
            let n = heights.count
            
            // Iterate through all bars + 1 extra for cleanup
            for i in 0...n {
                let currHeight = i < n ? heights[i] : 0  // Sentinel height at the end
                
                // Pop from stack while current height is smaller than top of stack
                while let last = stack.last, currHeight < heights[last] {
                    let height = heights[stack.removeLast()]
                    let width = stack.isEmpty ? i : i - stack.last! - 1
                    maxArea = max(maxArea, height * width)
                }
                
                // Push current index into stack
                stack.append(i)
            }
            
            return maxArea
        }
    }

    /*
     79. Word Search
     Given an m x n grid of characters board and a string word, return true if word exists in the grid.
     The word can be constructed from letters of sequentially adjacent cells, where adjacent cells are horizontally or vertically neighboring. The same letter cell may not be used more than once.
     Example 1:
     Input: board = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], word = "ABCCED"
     Output: true
     Example 2:
     Input: board = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], word = "SEE"
     Output: true
     Example 3:
     Input: board = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], word = "ABCB"
     Output: false
     Constraints:
     m == board.length
     n = board[i].length
     1 <= m, n <= 6
     1 <= word.length <= 15
     board and word consists of only lowercase and uppercase English letters.
     Follow up: Could you use search pruning to make your solution faster with a larger board?
     Method    Time Complexity    Space Complexity    Advantages    Disadvantages
     Recursive DFS    O(m * n * 4^L)    O(L)    Clean, easy to read    May hit recursion limit
     Iterative DFS    O(m * n * 4^L)    O(L)    No stack overflow    Code is harder
     */
    // MARK: - Recursive DFS solution (Backtracking)
    func wordSearch_recursive(_ board: [[Character]], _ word: String) -> Bool {
        var board = board
        let rows = board.count
        let cols = board[0].count
        let wordArray = Array(word)
        
        // Recursive DFS function
        func dfs(_ row: Int, _ col: Int, _ index: Int) -> Bool {
            // Base case: we found the whole word
            if index == wordArray.count {
                return true
            }
            
            // Out of bounds OR current char does not match
            if row < 0 || col < 0 || row >= rows || col >= cols || board[row][col] != wordArray[index] {
                return false
            }
            
            // Save the current character and mark the cell as visited
            let temp = board[row][col]
            board[row][col] = "#"
            
            // Explore four possible directions
            let found = dfs(row + 1, col, index + 1) ||
                        dfs(row - 1, col, index + 1) ||
                        dfs(row, col + 1, index + 1) ||
                        dfs(row, col - 1, index + 1)
            
            // Backtrack: restore the character
            board[row][col] = temp
            return found
        }
        
        // Try to start DFS from every cell
        for r in 0..<rows {
            for c in 0..<cols {
                if dfs(r, c, 0) {
                    return true
                }
            }
        }
        
        return false
    }

    // MARK: - Iterative DFS solution (Using stack)
    func wordSearch_iterative(_ board: [[Character]], _ word: String) -> Bool {
        let rows = board.count
        let cols = board[0].count
        let wordArray = Array(word)
        
        // Stack stores: (row, col, index, visitedSet)
        typealias State = (Int, Int, Int, Set<[Int]>)
        
        for r in 0..<rows {
            for c in 0..<cols {
                // Start DFS only if the first character matches
                if board[r][c] == wordArray[0] {
                    var stack: [State] = [(r, c, 0, [[r, c]])]
                    
                    while !stack.isEmpty {
                        let (row, col, index, visited) = stack.removeLast()
                        
                        // If we reached the last character, return true
                        if index == wordArray.count - 1 {
                            return true
                        }
                        
                        // Try four possible directions
                        let directions = [(1,0), (-1,0), (0,1), (0,-1)]
                        
                        for (dr, dc) in directions {
                            let nr = row + dr
                            let nc = col + dc
                            
                            // Check bounds, visited status, and next character match
                            if nr >= 0 && nr < rows &&
                               nc >= 0 && nc < cols &&
                               !visited.contains([nr, nc]) &&
                               board[nr][nc] == wordArray[index + 1] {
                                
                                var newVisited = visited
                                newVisited.insert([nr, nc])
                                stack.append((nr, nc, index + 1, newVisited))
                            }
                        }
                    }
                }
            }
        }
        
        return false
    }

    /*
     78. Subsets Medium Topics premium lock icon Companies Given an integer array nums of unique elements, return all possible subsets (the power set). The solution set must not contain duplicate subsets. Return the solution in any order. Example 1: Input: nums = [1,2,3] Output: [[],[1],[2],[1,2],[3],[1,3],[2,3],[1,2,3]] Example 2: Input: nums = [0] Output: [[],[0]] Constraints: 1 <= nums.length <= 10 -10 <= nums[i] <= 10 All the numbers of nums are unique.
     */
    func subsets(_ nums: [Int]) -> [[Int]] {
        var result = [[Int]]()      // Final list of subsets
        var subset = [Int]()        // Temporary subset
        
        func backtrack(_ index: Int) {
            // Add current subset to result
            result.append(subset)
            
            // Explore further elements
            for i in index..<nums.count {
                // Include nums[i] in subset
                subset.append(nums[i])
                
                // Recurse with next index
                backtrack(i + 1)
                
                // Backtrack: remove last element
                subset.removeLast()
            }
        }
        
        backtrack(0) // Start from index 0
        return result
    }
    /*
     77. Combinations Medium Topics premium lock icon Companies Given two integers n and k, return all possible combinations of k numbers chosen from the range [1, n]. You may return the answer in any order. Example 1: Input: n = 4, k = 2 Output: [[1,2],[1,3],[1,4],[2,3],[2,4],[3,4]] Explanation: There are 4 choose 2 = 6 total combinations. Note that combinations are unordered, i.e., [1,2] and [2,1] are considered to be the same combination. Example 2: Input: n = 1, k = 1 Output: [[1]] Explanation: There is 1 choose 1 = 1 total combination.
     */
    func combine(_ n: Int, _ k: Int) -> [[Int]] {
        var result = [[Int]]()   // Final list of combinations
        var combination = [Int]() // Temporary combination
        
        func backtrack(_ start: Int) {
            // If the current combination has exactly k numbers → add it to result
            if combination.count == k {
                result.append(combination)
                return
            }
            
            // Iterate through numbers from "start" to "n"
            for i in start...n {
                // Choose number i
                combination.append(i)
                
                // Recurse with the next number
                backtrack(i + 1)
                
                // Backtrack: remove the last chosen number
                combination.removeLast()
            }
        }
        
        backtrack(1)  // Start building combinations from 1
        return result
    }
    /*
     76. Minimum Window Substring
     Given two strings s and t of lengths m and n respectively, return the minimum window substring of s such that every character in t (including duplicates) is included in the window. If there is no such substring, return the empty string "".
     The testcases will be generated such that the answer is unique.
     Example 1:
     Input: s = "ADOBECODEBANC", t = "ABC"
     Output: "BANC"
     Explanation: The minimum window substring "BANC" includes 'A', 'B', and 'C' from string t.
     Example 2:
     Input: s = "a", t = "a"
     Output: "a"
     Explanation: The entire string s is the minimum window.
     Example 3:
     Input: s = "a", t = "aa"
     Output: ""
     Explanation: Both 'a's from t must be included in the window.
     Since the largest window of s only has one 'a', return empty string.
     Constraints:
     m == s.length
     n == t.length
     1 <= m, n <= 105
     s and t consist of uppercase and lowercase English letters.
     Follow up: Could you find an algorithm that runs in O(m + n) time?
     */
    func minWindow(_ s: String, _ t: String) -> String {
        // Quick check: if either string is empty, return empty result
        if s.isEmpty || t.isEmpty { return "" }
        
        let sArr = Array(s) // Convert string to array for O(1) indexing
        var need: [Character: Int] = [:] // Dictionary to track required characters
        
        // Count how many times each character is needed from t
        for ch in t {
            need[ch, default: 0] += 1
        }
        
        var missing = t.count // Total number of characters we still need to match
        var left = 0          // Left boundary of the sliding window
        var start = 0         // Start index of the minimum window
        var end = 0           // End index (exclusive) of the minimum window
        
        // Expand the right boundary of the window
        for right in 0..<sArr.count {
            let char = sArr[right]
            
            // If this char is still needed, reduce the missing counter
            if let count = need[char], count > 0 {
                missing -= 1
            }
            // Decrease count of the current character in the need dictionary
            need[char, default: 0] -= 1
            
            // When we have matched all required characters
            while missing == 0 {
                // Update the minimum window if it's smaller than the previous one
                if end == 0 || right - left + 1 < end - start {
                    start = left
                    end = right + 1 // right is inclusive, so +1 for slicing
                }
                
                // Try to shrink the window from the left
                let leftChar = sArr[left]
                need[leftChar, default: 0] += 1
                // If this char is required and now missing again, increase missing
                if let count = need[leftChar], count > 0 {
                    missing += 1
                }
                left += 1
            }
        }
        
        // If no valid window was found, return empty string
        return end == 0 ? "" : String(sArr[start..<end])
    }
    /*
     75. Sort Colors Medium Topics premium lock icon Companies Hint Given an array nums with n objects colored red, white, or blue, sort them in-place so that objects of the same color are adjacent, with the colors in the order red, white, and blue. We will use the integers 0, 1, and 2 to represent the color red, white, and blue, respectively. You must solve this problem without using the library's sort function. Example 1: Input: nums = [2,0,2,1,1,0] Output: [0,0,1,1,2,2] Example 2: Input: nums = [2,0,1] Output: [0,1,2] Constraints: n == nums.length 1 <= n <= 300 nums[i] is either 0, 1, or 2. Follow up: Could you come up with a one-pass algorithm using only constant extra space?
     */
    func sortColors(_ nums: inout [Int]) {
        var low = 0          // Next position for 0
        var mid = 0          // Current index
        var high = nums.count - 1 // Next position for 2
        
        while mid <= high {
            if nums[mid] == 0 {
                // Swap 0 to the front
                nums.swapAt(low, mid)
                low += 1
                mid += 1
            } else if nums[mid] == 1 {
                // 1 is in the correct place
                mid += 1
            } else {
                // Swap 2 to the end
                nums.swapAt(mid, high)
                high -= 1
            }
        }
    }
    /*
     74. Search a 2D Matrix
     Companies You are given an m x n integer matrix matrix with the following two properties: Each row is sorted in non-decreasing order. The first integer of each row is greater than the last integer of the previous row. Given an integer target, return true if target is in matrix or false otherwise. You must write a solution in O(log(m * n)) time complexity. Example 1: Input: matrix = [[1,3,5,7],[10,11,16,20],[23,30,34,60]], target = 3 Output: true Example 2: Input: matrix = [[1,3,5,7],[10,11,16,20],[23,30,34,60]], target = 13 Output: false Constraints: m == matrix.length n == matrix[i].length 1 <= m, n <= 100 -104 <= matrix[i][j], target <= 104
     */
    func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
        let m = matrix.count
        let n = matrix[0].count
        
        var left = 0
        var right = m * n - 1
        
        while left <= right {
            let mid = left + (right - left) / 2
            let row = mid / n
            let col = mid % n
            
            if matrix[row][col] == target {
                return true
            } else if matrix[row][col] < target {
                left = mid + 1
            } else {
                right = mid - 1
            }
        }
        
        return false
    }
    /*
     73. Set Matrix Zeroes
     Medium
     Topics
     premium lock icon
     Companies
     Hint
     Given an m x n integer matrix matrix, if an element is 0, set its entire row and column to 0's.
     You must do it in place.
     Example 1:
     Input: matrix = [  [1,1,1],
                        [1,0,1],
                        [1,1,1]]
     
     Output: [          [1,0,1],
                        [0,0,0],
                        [1,0,1]]
     Example 2:
     Input: matrix = [[0,1,2,0],[3,4,5,2],[1,3,1,5]]
     Output: [[0,0,0,0],[0,4,5,0],[0,3,1,0]]
     Constraints:
     m == matrix.length
     n == matrix[0].length
     1 <= m, n <= 200
     -231 <= matrix[i][j] <= 231 - 1
     */
    func setZeroes(_ matrix: inout [[Int]]) {
        let m = matrix.count
        let n = matrix[0].count
        
        var firstRowZero = false
        var firstColZero = false
        
        // Check if first row needs to be zeroed
        for j in 0..<n {
            if matrix[0][j] == 0 {
                firstRowZero = true
                break
            }
        }
        
        // Check if first column needs to be zeroed
        for i in 0..<m {
            if matrix[i][0] == 0 {
                firstColZero = true
                break
            }
        }
        
        // Use first row and column as markers
        for i in 1..<m {
            for j in 1..<n {
                if matrix[i][j] == 0 {
                    matrix[i][0] = 0
                    matrix[0][j] = 0
                }
            }
        }
        
        // Set zeroes based on markers
        for i in 1..<m {
            for j in 1..<n {
                if matrix[i][0] == 0 || matrix[0][j] == 0 {
                    matrix[i][j] = 0
                }
            }
        }
        
        // Zero out first row if needed
        if firstRowZero {
            for j in 0..<n {
                matrix[0][j] = 0
            }
        }
        
        // Zero out first column if needed
        if firstColZero {
            for i in 0..<m {
                matrix[i][0] = 0
            }
        }
    }
    
    /*
     71. Simplify Path
     Medium
     Topics
     premium lock icon
     Companies
     You are given an absolute path for a Unix-style file system, which always begins with a slash '/'. Your task is to transform this absolute path into its simplified canonical path.
     The rules of a Unix-style file system are as follows:
     A single period '.' represents the current directory.
     A double period '..' represents the previous/parent directory.
     Multiple consecutive slashes such as '//' and '///' are treated as a single slash '/'.
     Any sequence of periods that does not match the rules above should be treated as a valid directory or file name. For example, '...' and '....' are valid directory or file names.
     The simplified canonical path should follow these rules:
     The path must start with a single slash '/'.
     Directories within the path must be separated by exactly one slash '/'.
     The path must not end with a slash '/', unless it is the root directory.
     The path must not have any single or double periods ('.' and '..') used to denote current or parent directories.
     Return the simplified canonical path.
     Example 1:
     Input: path = "/home/"
     Output: "/home"
     Explanation:
     The trailing slash should be removed.
     Example 2:
     Input: path = "/home//foo/"
     Output: "/home/foo"
     Explanation:
     Multiple consecutive slashes are replaced by a single one.
     Example 3:
     Input: path = "/home/user/Documents/../Pictures"
     Output: "/home/user/Pictures"
     Explanation:
     A double period ".." refers to the directory up a level (the parent directory).
     Example 4:
     Input: path = "/../"
     Output: "/"
     Explanation:
     Going one level up from the root directory is not possible.
     Example 5:
     Input: path = "/.../a/../b/c/../d/./"
     Output: "/.../b/d"
     Explanation:
     "..." is a valid name for a directory in this problem.
     Constraints:
     1 <= path.length <= 3000
     path consists of English letters, digits, period '.', slash '/' or '_'.
     path is a valid absolute Unix path.
     */
    func simplifyPath(_ path: String) -> String {
        // Split the path into components separated by "/"
        let parts = path.split(separator: "/", omittingEmptySubsequences: true)
        var stack = [String]()
        
        for part in parts {
            if part == "." {
                // "." means current directory → skip
                continue
            } else if part == ".." {
                // ".." means go up one directory if possible
                if !stack.isEmpty {
                    stack.removeLast()
                }
            } else {
                // Normal directory name → push onto stack
                stack.append(String(part))
            }
        }
        
        // Join the stack to form the simplified path
        return "/" + stack.joined(separator: "/")
    }
    /* 68. Text Justification
     Given an array of strings words and a width maxWidth, format the text such that each line has exactly maxWidth characters and is fully (left and right) justified.
     You should pack your words in a greedy approach; that is, pack as many words as you can in each line. Pad extra spaces ' ' when necessary so that each line has exactly maxWidth characters.
     Extra spaces between words should be distributed as evenly as possible. If the number of spaces on a line does not divide evenly between words, the empty slots on the left will be assigned more spaces than the slots on the right.
     For the last line of text, it should be left-justified, and no extra space is inserted between words.
     Note:
     A word is defined as a character sequence consisting of non-space characters only.
     Each word's length is guaranteed to be greater than 0 and not exceed maxWidth.
     The input array words contains at least one word.
     Example 1:
     Input: words = ["This", "is", "an", "example", "of", "text", "justification."], maxWidth = 16
     Output:
     [
        "This    is    an",
        "example  of text",
        "justification.  "
     ]
     Example 2:
     Input: words = ["What","must","be","acknowledgment","shall","be"], maxWidth = 16
     Output:
     [
       "What   must   be",
       "acknowledgment  ",
       "shall be        "
     ]
     Explanation: Note that the last line is "shall be    " instead of "shall     be", because the last line must be left-justified instead of fully-justified.
     Note that the second line is also left-justified because it contains only one word.
     Example 3:
     Input: words = ["Science","is","what","we","understand","well","enough","to","explain","to","a","computer.","Art","is","everything","else","we","do"], maxWidth = 20
     Output:
     [
       "Science  is  what we",
       "understand      well",
       "enough to explain to",
       "a  computer.  Art is",
       "everything  else  we",
       "do                  "
     ]
     Constraints:
     1 <= words.length <= 300
     1 <= words[i].length <= 20
     words[i] consists of only English letters and symbols.
     1 <= maxWidth <= 100
     words[i].length <= maxWidth
     */
    func fullJustify(_ words: [String], _ maxWidth: Int) -> [String] {
        var result = [String]()
        var index = 0
        
        while index < words.count {
            var lineLen = words[index].count
            var last = index + 1
            
            // Find the last word that can fit in the current line
            while last < words.count {
                if lineLen + 1 + words[last].count > maxWidth { // +1 for a space
                    break
                }
                lineLen += 1 + words[last].count
                last += 1
            }
            
            var line = ""
            let numWords = last - index
            _ = maxWidth - lineLen + (numWords - 1) // spaces to distribute
            
            // Case 1: Last line OR single-word line → left-justified
            if last == words.count || numWords == 1 {
                line = words[index]
                for i in index + 1..<last {
                    line += " " + words[i]
                }
                // Pad remaining spaces at the end
                let remaining = maxWidth - line.count
                line += String(repeating: " ", count: remaining)
            } else {
                // Case 2: Fully justified line
                let totalSpaces = maxWidth - (lineLen - (numWords - 1)) // total spaces
                let spacesBetween = totalSpaces / (numWords - 1)
                var extraSpaces = totalSpaces % (numWords - 1)
                
                line = words[index]
                for i in index + 1..<last {
                    // Distribute extra spaces to the left slots first
                    let spaces = spacesBetween + (extraSpaces > 0 ? 1 : 0)
                    line += String(repeating: " ", count: spaces) + words[i]
                    if extraSpaces > 0 { extraSpaces -= 1 }
                }
            }
            
            result.append(line)
            index = last
        }
        
        return result
    }
    /*
     65. Valid Number
     Hard
     Topics
     premium lock icon
     Companies
     Given a string s, return whether s is a valid number.
     For example, all the following are valid numbers: "2", "0089", "-0.1", "+3.14", "4.", "-.9", "2e10", "-90E3", "3e+7", "+6e-1", "53.5e93", "-123.456e789", while the following are not valid numbers: "abc", "1a", "1e", "e3", "99e2.5", "--6", "-+3", "95a54e53".
     Formally, a valid number is defined using one of the following definitions:
     An integer number followed by an optional exponent.
     A decimal number followed by an optional exponent.
     An integer number is defined with an optional sign '-' or '+' followed by digits.
     A decimal number is defined with an optional sign '-' or '+' followed by one of the following definitions:
     Digits followed by a dot '.'.
     Digits followed by a dot '.' followed by digits.
     A dot '.' followed by digits.
     An exponent is defined with an exponent notation 'e' or 'E' followed by an integer number.
     The digits are defined as one or more digits.
     Example 1:
     Input: s = "0"
     Output: true
     Example 2:
     Input: s = "e"
     Output: false
     Example 3:
     Input: s = "."
     Output: false
     Constraints:
     1 <= s.length <= 20
     s consists of only English letters (both uppercase and lowercase), digits (0-9), plus '+', minus '-', or dot '.'.
     */
    
    func isNumberRegEx(_ s: String) -> Bool {
        let pattern = #"^[+-]?((\d+(\.\d*)?)|(\.\d+))(e[+-]?\d+)?$"#
        let regex = try! NSRegularExpression(pattern: pattern, options: [.caseInsensitive])
        let range = NSRange(location: 0, length: s.utf16.count)
        return regex.firstMatch(in: s, options: [], range: range) != nil
    }
    func isNumber(_ s: String) -> Bool {
        let s = s.trimmingCharacters(in: .whitespaces)
        var hasNum = false
        var hasDot = false
        var hasExp = false
        
        let chars = Array(s)
        
        for i in 0..<chars.count {
            let c = chars[i]
            
            if c.isNumber {
                hasNum = true
            } else if c == "." {
                // Dot is allowed only if there's no dot and no exponent yet
                if hasDot || hasExp {
                    return false
                }
                hasDot = true
            } else if c == "e" || c == "E" {
                // Exponent is allowed only if there's a number before and not seen before
                if hasExp || !hasNum {
                    return false
                }
                hasExp = true
                hasNum = false // Must have a number after exponent
            } else if c == "+" || c == "-" {
                // Sign is allowed only at the start OR right after e/E
                if i != 0 && chars[i - 1] != "e" && chars[i - 1] != "E" {
                    return false
                }
            } else {
                // Any other symbol is invalid
                return false
            }
        }
        
        return hasNum
    }
    
    /*
     64. Minimum Path Sum
     Medium
     Topics
     premium lock icon
     Companies
     Given a m x n grid filled with non-negative numbers, find a path from top left to bottom right, which minimizes the sum of all numbers along its path.
     Note: You can only move either down or right at any point in time.
     Example 1:
     Input: grid = [[1,3,1],[1,5,1],[4,2,1]]
     Output: 7
     Explanation: Because the path 1 → 3 → 1 → 1 → 1 minimizes the sum.
     Example 2:
     Input: grid = [[1,2,3],[4,5,6]]
     Output: 12
     Constraints:
     m == grid.length
     n == grid[i].length
     1 <= m, n <= 200
     0 <= grid[i][j] <= 200
     */
    func minPathSum(_ grid: [[Int]]) -> Int {
        let m = grid.count
        let n = grid[0].count
        
        // Use 1D DP array to store minimum path sums for the current row
        var dp = Array(repeating: 0, count: n)
        
        for i in 0..<m {
            for j in 0..<n {
                if i == 0 && j == 0 {
                    // Start position
                    dp[j] = grid[0][0]
                } else if i == 0 {
                    // First row → can only come from the left
                    dp[j] = dp[j - 1] + grid[i][j]
                } else if j == 0 {
                    // First column → can only come from above
                    dp[j] = dp[j] + grid[i][j]
                } else {
                    // Choose the minimum path between top and left
                    dp[j] = min(dp[j], dp[j - 1]) + grid[i][j]
                }
            }
        }
        
        return dp[n - 1]
    }
    /*
     63. Unique Paths II
     Medium
     Topics
     premium lock icon
     Companies
     Hint
     You are given an m x n integer array grid. There is a robot initially located at the top-left corner (i.e., grid[0][0]). The robot tries to move to the bottom-right corner (i.e., grid[m - 1][n - 1]). The robot can only move either down or right at any point in time.
     An obstacle and space are marked as 1 or 0 respectively in grid. A path that the robot takes cannot include any square that is an obstacle.
     Return the number of possible unique paths that the robot can take to reach the bottom-right corner.
     The testcases are generated so that the answer will be less than or equal to 2 * 109.
     Example 1:
     Input: obstacleGrid = [[0,0,0],[0,1,0],[0,0,0]]
     Output: 2
     Explanation: There is one obstacle in the middle of the 3x3 grid above.
     There are two ways to reach the bottom-right corner:
     1. Right -> Right -> Down -> Down
     2. Down -> Down -> Right -> Right
     Example 2:
     Input: obstacleGrid = [[0,1],[0,0]]
     Output: 1
     Constraints:
     m == obstacleGrid.length
     n == obstacleGrid[i].length
     1 <= m, n <= 100
     obstacleGrid[i][j] is 0 or 1.
     */
    func uniquePathsWithObstacles(_ obstacleGrid: [[Int]]) -> Int {
        let m = obstacleGrid.count
        let n = obstacleGrid[0].count
        
        // If start or finish is blocked, no paths exist
        if obstacleGrid[0][0] == 1 || obstacleGrid[m - 1][n - 1] == 1 {
            return 0
        }
        
        // Use 1D DP array for memory optimization
        var dp = Array(repeating: 0, count: n)
        dp[0] = 1
        
        for i in 0..<m {
            for j in 0..<n {
                // If current cell is an obstacle → zero paths
                if obstacleGrid[i][j] == 1 {
                    dp[j] = 0
                } else if j > 0 {
                    // Add paths from the left cell
                    dp[j] += dp[j - 1]
                }
            }
        }
        
        return dp[n - 1]
    }
    func demo_uniquePathsWithObstacles() {
        let sol = self //Solution()
        print(sol.uniquePathsWithObstacles([[0,0,0],[0,1,0],[0,0,0]])) // 2
        print(sol.uniquePathsWithObstacles([[0,1],[0,0]]))             // 1
        print(sol.uniquePathsWithObstacles([[1,0]]))                   // 0
        print(sol.uniquePathsWithObstacles([[0,0],[1,1],[0,0]]))       // 0
    }
    /*
     62. Unique Paths
     Medium
     Topics
     premium lock icon
     Companies
     There is a robot on an m x n grid. The robot is initially located at the top-left corner (i.e., grid[0][0]). The robot tries to move to the bottom-right corner (i.e., grid[m - 1][n - 1]). The robot can only move either down or right at any point in time.
     Given the two integers m and n, return the number of possible unique paths that the robot can take to reach the bottom-right corner.
     The test cases are generated so that the answer will be less than or equal to 2 * 109.
     Example 1:
     Input: m = 3, n = 7
     Output: 28
     Example 2:
     Input: m = 3, n = 2
     Output: 3
     Explanation: From the top-left corner, there are a total of 3 ways to reach the bottom-right corner:
     1. Right -> Down -> Down
     2. Down -> Down -> Right
     3. Down -> Right -> Down
     Constraints:
     1 <= m, n <= 100
     */
    func uniquePaths(_ m: Int, _ n: Int) -> Int {
        // Initialize a 2D dp array filled with 1's
        var dp = Array(repeating: Array(repeating: 1, count: n), count: m)
        
        // Fill the dp table
        for i in 1..<m {
            for j in 1..<n {
                dp[i][j] = dp[i-1][j] + dp[i][j-1]
            }
        }
        
        return dp[m-1][n-1]
    }
    /*
     61. Rotate List
     Given the head of a linked list, rotate the list to the right by k places.
     Example 1:
     Input: head = [1,2,3,4,5], k = 2
     Output: [4,5,1,2,3]
     Example 2:
     Input: head = [0,1,2], k = 4
     Output: [2,0,1]
     Constraints:
     The number of nodes in the list is in the range [0, 500].
     -100 <= Node.val <= 100
     0 <= k <= 2 * 109
     */
    // Definition for singly-linked list
    class SolutionRotaterList {
        func rotateRight(_ head: ListNode?, _ k: Int) -> ListNode? {
            // Edge cases: empty list or single node
            guard let head = head, head.next != nil else {
                return head
            }
            
            // Step 1: Find the length of the list
            var length = 1
            var tail = head
            while tail.next != nil {
                tail = tail.next!
                length += 1
            }
            
            // Step 2: Normalize k (avoid unnecessary full rotations)
            let k = k % length
            if k == 0 { return head }
            
            // Step 3: Make it a circular list
            tail.next = head
            
            // Step 4: Find the new tail (length - k - 1 steps from start)
            var newTail = head
            for _ in 0..<(length - k - 1) {
                newTail = newTail.next!
            }
            
            // Step 5: New head is next of newTail
            let newHead = newTail.next
            newTail.next = nil // break the circle
            
            return newHead
        }
        func demo_rotateList() {
            // Build input list [1,2,3,4,5]
            let head = ListNode(1)
            head.next = ListNode(2)
            head.next?.next = ListNode(3)
            head.next?.next?.next = ListNode(4)
            head.next?.next?.next?.next = ListNode(5)
            
            let rotated = rotateRight(head, 2) // expect [4,5,1,2,3]
            
            // Print result
            var node = rotated
            var result: [Int] = []
            while let n = node {
                result.append(n.val)
                node = n.next
            }
            print(result) // [4, 5, 1, 2, 3]
        }

    }

    /*
     60. Permutation Sequence
     Hard
     Topics
     premium lock icon
     Companies
     The set [1, 2, 3, ..., n] contains a total of n! unique permutations.
     By listing and labeling all of the permutations in order, we get the following sequence for n = 3:
     "123"
     "132"
     "213"
     "231"
     "312"
     "321"
     Given n and k, return the kth permutation sequence.
     Example 1:
     Input: n = 3, k = 3
     Output: "213"
     Example 2:
     Input: n = 4, k = 9
     Output: "2314"
     Example 3:
     Input: n = 3, k = 1
     Output: "123"
     Constraints:
     1 <= n <= 9
     1 <= k <= n!
     */
    class PermutationSequence {
        
        // Return the k-th permutation sequence of numbers [1..n]
        static func getPermutation(_ n: Int, _ k: Int) -> String {
            var numbers = Array(1...n)  // available digits
            var k = k - 1               // convert to 0-based index
            var result = ""
            
            // Precompute factorials
            var factorial = [1]
            for i in 1...n {
                factorial.append(factorial.last! * i)
            }
            
            // Build permutation
            for i in stride(from: n, to: 0, by: -1) {
                let groupSize = factorial[i - 1]
                let index = k / groupSize
                result += "\(numbers[index])"
                numbers.remove(at: index)
                k %= groupSize
            }
            
            return result
        }
        
        // Demo method for testing
        static func demo_getPermutation() {
            let examples = [
                (n: 3, k: 3),
                (n: 4, k: 9),
                (n: 3, k: 1),
                (n: 5, k: 42)
            ]
            
            for ex in examples {
                let result = getPermutation(ex.n, ex.k)
                print("n = \(ex.n), k = \(ex.k) → \"\(result)\"")
            }
        }
    }


    /*
     59. Spiral Matrix II
     Medium
     Topics
     premium lock icon
     Companies
     Given a positive integer n, generate an n x n matrix filled with elements from 1 to n2 in spiral order.
     Example 1:
     Input: n = 3
     Output: [[1,2,3],[8,9,4],[7,6,5]]
     Example 2:
     Input: n = 1
     Output: [[1]]
     */
    class SpiralMatrixII {
        
        // Generate an n x n spiral matrix
        static func generateMatrix(_ n: Int) -> [[Int]] {
            var matrix = Array(repeating: Array(repeating: 0, count: n), count: n)
            
            // Directions: right, down, left, up
            let directions = [(0,1),(1,0),(0,-1),(-1,0)]
            var dirIndex = 0 // start moving right
            
            var row = 0, col = 0
            for num in 1...(n*n) {
                matrix[row][col] = num
                // Calculate next cell
                let nextRow = row + directions[dirIndex].0
                let nextCol = col + directions[dirIndex].1
                
                // Check boundaries and filled cells
                if nextRow < 0 || nextRow >= n || nextCol < 0 || nextCol >= n || matrix[nextRow][nextCol] != 0 {
                    dirIndex = (dirIndex + 1) % 4 // change direction
                }
                
                row += directions[dirIndex].0
                col += directions[dirIndex].1
            }
            
            return matrix
        }
        
        // Demo method
        static func demo_generateMatrix() {
            let examples = [3, 1, 4]
            
            for n in examples {
                let result = generateMatrix(n)
                print("n = \(n)")
                for row in result {
                    print(row)
                }
                print("------")
            }
        }
    }
    /*
     58. Length of Last Word
     Given a string s consisting of words and spaces, return the length of the last word in the string.
     A word is a maximal substring consisting of non-space characters only.
     Example 1:
     Input: s = "Hello World"
     Output: 5
     Explanation: The last word is "World" with length 5.
     Example 2:
     Input: s = "   fly me   to   the moon  "
     Output: 4
     Explanation: The last word is "moon" with length 4.
     Example 3:
     Input: s = "luffy is still joyboy"
     Output: 6
     Explanation: The last word is "joyboy" with length 6.
     Constraints:
     1 <= s.length <= 104
     s consists of only English letters and spaces ' '.
     There will be at least one word in s.
     */
    class LengthOfLastWord {
        
        // Return the length of the last word in the string
        static func lengthOfLastWord(_ s: String) -> Int {
            // Trim spaces at the end, split into words
            let words = s.trimmingCharacters(in: .whitespaces).split(separator: " ")
            // Return length of the last word
            return words.last?.count ?? 0
        }
        
        // Demo method for testing
        static func demo_lengthOfLastWord() {
            let examples = [
                "Hello World",
                "   fly me   to   the moon  ",
                "luffy is still joyboy"
            ]
            
            for s in examples {
                let result = lengthOfLastWord(s)
                print("Input: \"\(s)\" → Output: \(result)")
            }
        }
    }

    /*
     57. Insert Interval
     You are given an array of non-overlapping intervals intervals where intervals[i] = [starti, endi] represent the start and the end of the ith interval and intervals is sorted in ascending order by starti. You are also given an interval newInterval = [start, end] that represents the start and end of another interval.
     Insert newInterval into intervals such that intervals is still sorted in ascending order by starti and intervals still does not have any overlapping intervals (merge overlapping intervals if necessary).
     Return intervals after the insertion.
     Note that you don't need to modify intervals in-place. You can make a new array and return it.
     Example 1:
     Input: intervals = [[1,3],[6,9]], newInterval = [2,5]
     Output: [[1,5],[6,9]]
     Example 2:
     Input: intervals = [[1,2],[3,5],[6,7],[8,10],[12,16]], newInterval = [4,8]
     Output: [[1,2],[3,10],[12,16]]
     Explanation: Because the new interval [4,8] overlaps with [3,5],[6,7],[8,10].
     Constraints:
     0 <= intervals.length <= 104
     intervals[i].length == 2
     0 <= starti <= endi <= 105
     intervals is sorted by starti in ascending order.
     newInterval.length == 2
     0 <= start <= end <= 105
     */
    class InsertIntervalDemo {
        static func insert(_ intervals: [[Int]], _ newInterval: [Int]) -> [[Int]] {
            var result: [[Int]] = []
            var newInt = newInterval
            var inserted = false
            
            for interval in intervals {
                if interval[1] < newInt[0] {
                    // Current interval ends before newInterval starts
                    result.append(interval)
                } else if interval[0] > newInt[1] {
                    // Current interval starts after newInterval ends
                    if !inserted {
                        result.append(newInt)
                        inserted = true
                    }
                    result.append(interval)
                } else {
                    // Overlap → merge intervals
                    newInt[0] = min(newInt[0], interval[0])
                    newInt[1] = max(newInt[1], interval[1])
                }
            }
            
            // If newInterval hasn't been inserted, add it at the end
            if !inserted {
                result.append(newInt)
            }
            
            return result
        }
        
        static func demo_insertInterval() {
            let tests: [([[Int]], [Int])] = [
                ([[1,3],[6,9]], [2,5]),
                ([[1,2],[3,5],[6,7],[8,10],[12,16]], [4,8]),
                ([], [5,7]),
                ([[1,5]], [2,3]),
                ([[1,5]], [2,7])
            ]
            
            for (intervals, newInt) in tests {
                print("Intervals: \(intervals), New: \(newInt)")
                print("Result: \(insert(intervals, newInt))")
                print("---")
            }
        }
    }
    //practice example for intervals
    struct Booking {
        var start: Date
        var end: Date
    }

    class TimeBookingManager {
        
        // Insert a new booking interval into the list
        static func insertBooking(existing: [Booking], newBooking: Booking) -> [Booking] {
            var result = [Booking]()
            var inserted = false
            
            for booking in existing {
                // If current booking ends before new booking starts
                if booking.end < newBooking.start {
                    result.append(booking)
                }
                // If current booking starts after new booking ends
                else if booking.start > newBooking.end {
                    if !inserted {
                        result.append(newBooking)
                        inserted = true
                    }
                    result.append(booking)
                }
                // Overlap case: merge intervals
                else {
                    let mergedStart = min(booking.start, newBooking.start)
                    let mergedEnd = max(booking.end, newBooking.end)
                    let mergedBooking = Booking(start: mergedStart, end: mergedEnd)
                    return insertBooking(existing: result + [mergedBooking] + existing.dropFirst(result.count + 1),
                                         newBooking: mergedBooking)
                }
            }
            
            if !inserted {
                result.append(newBooking)
            }
            return result
        }
        
        // Demo method
        static func runDemo() {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm"
            
            func t(_ str: String) -> Date { formatter.date(from: str)! }
            
            let existingBookings = [
                Booking(start: t("09:00"), end: t("10:00")),
                Booking(start: t("13:00"), end: t("14:00"))
            ]
            
            let newBooking = Booking(start: t("09:30"), end: t("13:30"))
            
            let updated = insertBooking(existing: existingBookings, newBooking: newBooking)
            
            print("📅 Updated bookings:")
            for b in updated {
                print("\(formatter.string(from: b.start)) - \(formatter.string(from: b.end))")
            }
        }
    }
    // Uncomment to test
    // InsertIntervalDemo.demo_insertInterval()

    /*
     56. Merge Intervals
     Medium
     Topics
     premium lock icon
     Companies
     Given an array of intervals where intervals[i] = [starti, endi], merge all overlapping intervals, and return an array of the non-overlapping intervals that cover all the intervals in the input.
     Example 1:
     Input: intervals = [[1,3],[2,6],[8,10],[15,18]]
     Output: [[1,6],[8,10],[15,18]]
     Explanation: Since intervals [1,3] and [2,6] overlap, merge them into [1,6].
     Example 2:
     Input: intervals = [[1,4],[4,5]]
     Output: [[1,5]]
     Explanation: Intervals [1,4] and [4,5] are considered overlapping.
     Constraints:
     1 <= intervals.length <= 104
     intervals[i].length == 2
     0 <= starti <= endi <= 104
     */
    class MergeIntervalsDemo {
        static func merge(_ intervals: [[Int]]) -> [[Int]] {
            guard !intervals.isEmpty else { return [] }
            
            // Step 1: Sort by start time
            let sorted = intervals.sorted { $0[0] < $1[0] }
            
            var merged: [[Int]] = []
            merged.append(sorted[0])
            
            // Step 2: Merge intervals
            for i in 1..<sorted.count {
                let last = merged[merged.count - 1]
                let current = sorted[i]
                
                if current[0] <= last[1] {
                    // Overlap → merge
                    merged[merged.count - 1][1] = max(last[1], current[1])
                } else {
                    // No overlap → add new
                    merged.append(current)
                }
            }
            
            return merged
        }
        
        static func demo_mergeIntervals() {
            let tests = [
                [[1,3],[2,6],[8,10],[15,18]],
                [[1,4],[4,5]],
                [[1,2],[3,4],[5,6]],
                [[1,10],[2,3],[4,5],[6,7],[8,9]]
            ]
            
            for intervals in tests {
                print("Input: \(intervals)")
                print("Merged: \(merge(intervals))")
                print("---")
            }
        }
    }

    // Uncomment to test
    // MergeIntervalsDemo.demo_mergeIntervals()

    /*
     55. Jump Game
     Medium
     Topics
     premium lock icon
     Companies
     You are given an integer array nums. You are initially positioned at the array's first index, and each element in the array represents your maximum jump length at that position.
     Return true if you can reach the last index, or false otherwise.
     Example 1:
     Input: nums = [2,3,1,1,4]
     Output: true
     Explanation: Jump 1 step from index 0 to 1, then 3 steps to the last index.
     Example 2:
     Input: nums = [3,2,1,0,4]
     Output: false
     Explanation: You will always arrive at index 3 no matter what. Its maximum jump length is 0, which makes it impossible to reach the last index.
     Constraints:
     1 <= nums.length <= 104
     0 <= nums[i] <= 105
     */
    class JumpGameDemo {
        // Greedy approach to check if we can reach the last index
        static func canJump(_ nums: [Int]) -> Bool {
            var maxReach = 0
            for i in 0..<nums.count {
                if i > maxReach {
                    // Current position is not reachable
                    return false
                }
                maxReach = max(maxReach, i + nums[i])
                if maxReach >= nums.count - 1 {
                    return true
                }
            }
            return true
        }
        
        // Minimum jumps to reach last index (Greedy BFS-like)
        static func minJumps(_ nums: [Int]) -> Int {
            if nums.count <= 1 { return 0 }
            
            var jumps = 0
            var currentEnd = 0
            var farthest = 0
            
            for i in 0..<nums.count - 1 {
                farthest = max(farthest, i + nums[i])
                if i == currentEnd {
                    jumps += 1
                    currentEnd = farthest
                    if currentEnd >= nums.count - 1 { break }
                }
            }
            
            return jumps
        }
        
        // Demo with visualization
        static func demo_jumpGame() {
            let testCases: [[Int]] = [
                [2, 3, 1, 1, 4],
                [3, 2, 1, 0, 4],
                [1, 0, 1, 0],
                [0]
            ]
            
            for nums in testCases {
                print("Input: \(nums)")
                let reachable = canJump(nums)
                print("Can reach last index? \(reachable)")
                if reachable {
                    let jumps = minJumps(nums)
                    print("Minimum jumps: \(jumps)")
                }
                print("---")
            }
        }
    }

    // Uncomment to run
    // JumpGameDemo.demo_jumpGame()

    /*
     54. Spiral Matrix
     Medium
     Topics
     premium lock icon
     Companies
     Hint
     Given an m x n matrix, return all elements of the matrix in spiral order.
     Example 1:
     Input: matrix = [[1,2,3],[4,5,6],[7,8,9]]
     Output: [1,2,3,6,9,8,7,4,5]
     Example 2:
     Input: matrix = [[1,2,3,4],[5,6,7,8],[9,10,11,12]]
     Output: [1,2,3,4,8,12,11,10,9,5,6,7]
     Constraints:
     m == matrix.length
     n == matrix[i].length
     1 <= m, n <= 10
     -100 <= matrix[i][j] <= 100
     */
    class SpiralMatrixDemo {
        // Return elements of the matrix in spiral order
        static func spiralOrder(_ matrix: [[Int]]) -> [Int] {
            var result = [Int]()
            guard !matrix.isEmpty else { return result }
            
            var top = 0
            var bottom = matrix.count - 1
            var left = 0
            var right = matrix[0].count - 1
            
            while top <= bottom && left <= right {
                // Traverse from left to right
                for col in left...right {
                    result.append(matrix[top][col])
                }
                top += 1
                
                // Traverse from top to bottom
                if top <= bottom {
                    for row in top...bottom {
                        result.append(matrix[row][right])
                    }
                    right -= 1
                }
                
                // Traverse from right to left
                if left <= right && top <= bottom {
                    for col in stride(from: right, through: left, by: -1) {
                        result.append(matrix[bottom][col])
                    }
                    bottom -= 1
                }
                
                // Traverse from bottom to top
                if top <= bottom && left <= right {
                    for row in stride(from: bottom, through: top, by: -1) {
                        result.append(matrix[row][left])
                    }
                    left += 1
                }
            }
            
            return result
        }
        
        // Demo runner
        static func demo_spiralMatrix() {
            let testCases = [
                [[1,2,3],[4,5,6],[7,8,9]],
                [[1,2,3,4],[5,6,7,8],[9,10,11,12]]
            ]
            
            for matrix in testCases {
                print("Input: \(matrix)")
                let output = spiralOrder(matrix)
                print("Spiral order: \(output)")
                print("---")
            }
        }
    }

    // Uncomment to run
    // SpiralMatrixDemo.demo_spiralMatrix()

    /*
     53. Maximum Subarray
     Medium
     Topics
     premium lock icon
     Companies
     Given an integer array nums, find the subarray with the largest sum, and return its sum.
     Example 1:
     Input: nums = [-2,1,-3,4,-1,2,1,-5,4]
     Output: 6
     Explanation: The subarray [4,-1,2,1] has the largest sum 6.
     Example 2:
     Input: nums = [1]
     Output: 1
     Explanation: The subarray [1] has the largest sum 1.
     Example 3:
     Input: nums = [5,4,-1,7,8]
     Output: 23
     Explanation: The subarray [5,4,-1,7,8] has the largest sum 23.
     Constraints:
     1 <= nums.length <= 105
     -104 <= nums[i] <= 104
     Follow up: If you have figured out the O(n) solution, try coding another solution using the divide and conquer approach, which is more subtle.     */
    // Kadane's Algorithm
    static func maxSubArray(_ nums: [Int]) -> Int {
        // Initialize with the first element
        var currentSum = nums[0]
        var maxSum = nums[0]
        
        // Iterate through the rest of the array
        for i in 1..<nums.count {
            // Either extend the current subarray or start new from nums[i]
            currentSum = max(nums[i], currentSum + nums[i])
            // Update maxSum if needed
            maxSum = max(maxSum, currentSum)
        }
        
        return maxSum
    }
    
    // Demo runner
    static func demo_maxSubArray() {
        let testCases = [
            [-2, 1, -3, 4, -1, 2, 1, -5, 4],
            [1],
            [5, 4, -1, 7, 8]
        ]
        
        for nums in testCases {
            let result = maxSubArray(nums)
            print("Input: \(nums)")
            print("Maximum subarray sum = \(result)")
            print("---")
        }
    }
    /*
     51. N-Queens
     Hard
     Topics
     premium lock icon
     Companies
     The n-queens puzzle is the problem of placing n queens on an n x n chessboard such that no two queens attack each other.
     Given an integer n, return all distinct solutions to the n-queens puzzle. You may return the answer in any order.
     Each solution contains a distinct board configuration of the n-queens' placement, where 'Q' and '.' both indicate a queen and an empty space, respectively.
     Example 1:
     Input: n = 4
     Output: [[".Q..","...Q","Q...","..Q."],["..Q.","Q...","...Q",".Q.."]]
     Explanation: There exist two distinct solutions to the 4-queens puzzle as shown above
     Example 2:
     Input: n = 1
     Output: [["Q"]]
     Constraints:
     1 <= n <= 9
     */
    // Solve the n-queens problem and return all distinct solutions.
    func solveNQueens(_ n: Int) -> [[String]] {
        // result container
        var results = [[String]]()
        // positions[r] = column index of queen placed in row r
        var positions = [Int](repeating: 0, count: n)
        // All bits set for n columns (1..n bits = available mask)
        let fullMask = (1 << n) - 1
        
        // Backtracking function using bitmasks:
        // cols: occupied columns mask
        // d1: occupied "main" diagonals mask (shifted left each row)
        // d2: occupied "anti" diagonals mask (shifted right each row)
        // row: current row index
        func backtrack(_ cols: Int, _ d1: Int, _ d2: Int, _ row: Int) {
            // If all rows are filled, convert positions -> board strings
            if row == n {
                var board = [String]()
                for r in 0..<n {
                    // build row string with 'Q' at positions[r]
                    var rowChars = [Character](repeating: ".", count: n)
                    rowChars[positions[r]] = "Q"
                    board.append(String(rowChars))
                }
                results.append(board)
                return
            }
            
            // available positions: bits that are 1 where we can place a queen
            var available = fullMask & ~(cols | d1 | d2)
            
            // iterate through all available positions
            while available != 0 {
                // pick lowest set bit
                let bit = available & -available
                // remove picked bit from available
                available &= (available - 1)
                
                // column index is the number of trailing zeros
                let col = bit.trailingZeroBitCount
                positions[row] = col
                
                // place queen and move to next row
                // shift d1 left (main diagonal), d2 right (anti diagonal)
                backtrack(cols | bit, (d1 | bit) << 1, (d2 | bit) >> 1, row + 1)
                
                // backtrack: positions[row] will be overwritten on next placement
            }
        }
        
        backtrack(0, 0, 0, 0)
        return results
    }
    static func demo(){
        // Example usage:
        let sol = Solution()
        let examples = sol.solveNQueens(4)
        print(examples) // prints two solutions for n = 4
    }
    /*
     50. Pow(x, n)
     Medium
     Topics
     premium lock icon
     Companies
     Implement pow(x, n), which calculates x raised to the power n (i.e., xn).
     Example 1:
     Input: x = 2.00000, n = 10
     Output: 1024.00000
     Example 2:
     Input: x = 2.10000, n = 3
     Output: 9.26100
     Example 3:
     Input: x = 2.00000, n = -2
     Output: 0.25000
     Explanation: 2-2 = 1/22 = 1/4 = 0.25
     Constraints:
     -100.0 < x < 100.0
     -231 <= n <= 231-1
     n is an integer.
     Either x is not zero or n > 0.
     -104 <= xn <= 104
     */
    class PowXN {
        static func runDemo() {
            print(myPow(2.00000, 10))   // 1024.0
            print(myPow(2.10000, 3))    // 9.261
            print(myPow(2.00000, -2))   // 0.25
        }

        static func myPow(_ x: Double, _ n: Int) -> Double {
            var base = x
            var exp = n
            if exp < 0 {
                base = 1 / base
                exp = -exp
            }
            return fastPow(base, exp)
        }

        private static func fastPow(_ x: Double, _ n: Int) -> Double {
            if n == 0 { return 1.0 }
            let half = fastPow(x, n / 2)
            if n % 2 == 0 {
                return half * half
            } else {
                return half * half * x
            }
        }
    }

    /*
    Comparison of O() metrics (time and space):

    Algorithm: Fast exponentiation (binary exponentiation)

    Time Complexity:
    - O(log n) — exponent is halved at each recursive step

    Space Complexity:
    - O(log n) due to recursion stack (can be reduced to O(1) with iterative implementation)

    n = absolute value of exponent
    */

    /*
     49. Group Anagrams
     Medium
     Topics
     premium lock icon
     Companies
     Given an array of strings strs, group the anagrams together. You can return the answer in any order.
     Example 1:
     Input: strs = ["eat","tea","tan","ate","nat","bat"]
     Output: [["bat"],["nat","tan"],["ate","eat","tea"]]
     Explanation:
     There is no string in strs that can be rearranged to form "bat".
     The strings "nat" and "tan" are anagrams as they can be rearranged to form each other.
     The strings "ate", "eat", and "tea" are anagrams as they can be rearranged to form each other.
     Example 2:
     Input: strs = [""]
     Output: [[""]]
     Example 3:
     Input: strs = ["a"]
     Output: [["a"]]
     Constraints:
     1 <= strs.length <= 104
     0 <= strs[i].length <= 100
     strs[i] consists of lowercase English letters.
 ß    Comparison of O() metrics (time and space):

     Algorithm: Sort each string and group by sorted key

     Time Complexity:
     - Sorting each word: O(k log k), where k = length of the word
     - For n words: O(n * k log k)

     Space Complexity:
     - Dictionary for grouping: O(n * k)
     - Sorting uses O(k) extra space per word (Swift’s sort is not strictly i
     */
    class GroupAnagrams {
        static func runDemo() {
            let strs1 = ["eat","tea","tan","ate","nat","bat"]
            print(groupAnagrams(strs1))
            // Possible output: [["bat"],["nat","tan"],["ate","eat","tea"]]

            let strs2 = [""]
            print(groupAnagrams(strs2)) // [[""]]

            let strs3 = ["a"]
            print(groupAnagrams(strs3)) // [["a"]]
        }

        static func groupAnagrams(_ strs: [String]) -> [[String]] {
            var dict = [String: [String]]()

            for word in strs {
                // Sort characters to form the key
                let key = String(word.sorted())
                dict[key, default: []].append(word)
            }

            return Array(dict.values)
        }
    }

    /*
     48. Rotate Image
     Medium
     Topics
     premium lock icon
     Companies
     You are given an n x n 2D matrix representing an image, rotate the image by 90 degrees (clockwise).
     You have to rotate the image in-place, which means you have to modify the input 2D matrix directly. DO NOT allocate another 2D matrix and do the rotation.
     Example 1:
     Input: matrix = [[1,2,3],[4,5,6],[7,8,9]]
     Output: [[7,4,1],[8,5,2],[9,6,3]]
     Example 2:
     Input: matrix = [[5,1,9,11],[2,4,8,10],[13,3,6,7],[15,14,12,16]]
     Output: [[15,13,2,5],[14,3,4,1],[12,6,8,9],[16,7,10,11]]
     Constraints:
     n == matrix.length == matrix[i].length
     1 <= n <= 20
     -1000 <= matrix[i][j] <= 1000
     */
    class RotateImage {
        static func runDemo() {
            var m1 = [[1,2,3],
                      [4,5,6],
                      [7,8,9]]
            rotate(&m1)
            print(m1) // [[7,4,1],[8,5,2],[9,6,3]]

            var m2 = [[5,1,9,11],
                      [2,4,8,10],
                      [13,3,6,7],
                      [15,14,12,16]]
            rotate(&m2)
            print(m2) // [[15,13,2,5],[14,3,4,1],[12,6,8,9],[16,7,10,11]]
        }

        static func rotate(_ matrix: inout [[Int]]) {
            let n = matrix.count
            
            // Step 1: Transpose (swap matrix[i][j] with matrix[j][i])
            for i in 0..<n {
                for j in i..<n {
                    let temp = matrix[i][j]
                    matrix[i][j] = matrix[j][i]
                    matrix[j][i] = temp
                }
            }

            // Step 2: Reverse each row
            for i in 0..<n {
                matrix[i].reverse()
            }
        }
    }

    /*46. Permutations
     Given an array nums of distinct integers, return all the possible permutations. You can return the answer in any order.
     Example 1:
     Input: nums = [1,2,3]
     Output: [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]
     Example 2:
     Input: nums = [0,1]
     Output: [[0,1],[1,0]]
     Example 3:
     Input: nums = [1]
     Output: [[1]]
     Constraints:
     1 <= nums.length <= 6
     -10 <= nums[i] <= 10
     All the integers of nums are unique.
     Metriks:
     Performance Comparison of Both Permutation Approaches (Time and Space)
     
     | Metric                     | Version 1: with `used[]`         | Version 2: in-place (no `used[]`) |
     |---------------------------|----------------------------------|-----------------------------------|
     | Time Complexity           | O(n * n!)                        | O(n * n!)                         |
     | Explanation (time)        | n! permutations of length n      | Same: n! permutations of length n |
     | Call Stack Depth          | O(n)                             | O(n)                              |
     | Auxiliary Space           | O(n) (used[] + current[])        | O(1) (in-place swaps only)        |
     | Total Space Complexity    | O(n)                             | O(n) (recursion only)             |
     | Modifies Input?           | No                               | Yes (but restores via backtrack)  |
     
     Summary:
     - Version 1 is easier to read and suitable for beginners.
     - Version 2 is more memory-efficient and preferred for optimal space usage.
     
     47 permurmutaion unic requered sort
     */
    
    class Permutations {
        static func runDemo() {
            print(permute([1, 2, 3]))
            print(permute([0, 1]))
            print(permute([1]))
            print(permute2([1, 2, 3]))
            print(permute2([0, 1]))
            print(permute2([1]))
            
        }
        static func permuteUnique(_ nums: [Int]) -> [[Int]] {
            let nums = nums.sorted()  // Sort to handle duplicates
            var result: [[Int]] = []
            var current: [Int] = []
            var used = Array(repeating: false, count: nums.count)
            
            func backtrack() {
                if current.count == nums.count {
                    result.append(current)
                    return
                }
                
                for i in 0..<nums.count {
                    // Skip used elements
                    if used[i] { continue }
                    
                    // Skip duplicates: if current == previous and previous hasn't been used
                    if i > 0 && nums[i] == nums[i - 1] && !used[i - 1] {
                        continue
                    }
                    
                    used[i] = true
                    current.append(nums[i])
                    backtrack()
                    current.removeLast()
                    used[i] = false
                }
            }
            
            backtrack()
            return result
        }
        static func permute(_ nums: [Int]) -> [[Int]] {
            var result: [[Int]] = []
            var current: [Int] = []
            var used = Array(repeating: false, count: nums.count)
            
            func backtrack() {
                if current.count == nums.count {
                    result.append(current)
                    return
                }
                
                for i in 0..<nums.count {
                    if used[i] { continue }
                    
                    used[i] = true
                    current.append(nums[i])
                    backtrack()
                    current.removeLast()
                    used[i] = false
                }
            }
            
            backtrack()
            return result
        }
        static func permute2(_ nums: [Int]) -> [[Int]] {
            var result: [[Int]] = []
            var nums = nums // make mutable
            
            func backtrack(_ start: Int) {
                if start == nums.count {
                    result.append(nums)
                    return
                }
                
                for i in start..<nums.count {
                    nums.swapAt(start, i)
                    backtrack(start + 1)
                    nums.swapAt(start, i) // backtrack
                }
            }
            
            backtrack(0)
            return result
        }
    }
    /*
     45. Jump Game II
     Medium
     Topics
     premium lock icon
     Companies
     You are given a 0-indexed array of integers nums of length n. You are initially positioned at nums[0].
     Each element nums[i] represents the maximum length of a forward jump from index i. In other words, if you are at nums[i], you can jump to any nums[i + j] where:
     0 <= j <= nums[i] and
     i + j < n
     Return the minimum number of jumps to reach nums[n - 1]. The test cases are generated such that you can reach nums[n - 1].
     Example 1:
     Input: nums = [2,3,1,1,4]
     Output: 2
     Explanation: The minimum number of jumps to reach the last index is 2. Jump 1 step from index 0 to 1, then 3 steps to the last index.
     Example 2:
     Input: nums = [2,3,0,1,4]
     Output: 2
     Constraints:
     1 <= nums.length <= 104
     0 <= nums[i] <= 1000
     It's guaranteed that you can reach nums[n - 1].
     */
    class JumpGameII {
        static func runDemo() {
            print(jump([2,3,1,1,4]))     // Output: 2
            print(jump([2,3,0,1,4]))     // Output: 2
            print(jump([1,2,1,1,1]))     // Output: 3
        }
        
        static func jump(_ nums: [Int]) -> Int {
            let n = nums.count
            if n <= 1 { return 0 }
            
            var jumps = 0
            var currentEnd = 0  // farthest point in current jump
            var farthest = 0    // farthest we can reach
            
            for i in 0..<n - 1 {
                farthest = max(farthest, i + nums[i])
                if i == currentEnd {
                    jumps += 1
                    currentEnd = farthest
                }
            }
            
            return jumps
        }
    }
    
    /*
     44. Wildcard Matching
     Given an input string (s) and a pattern (p), implement wildcard pattern matching with support for '?' and '*' where:
     '?' Matches any single character.
     '*' Matches any sequence of characters (including the empty sequence).
     The matching should cover the entire input string (not partial).
     Example 1:
     Input: s = "aa", p = "a"
     Output: false
     Explanation: "a" does not match the entire string "aa".
     Example 2:
     Input: s = "aa", p = "*"
     Output: true
     Explanation: '*' matches any sequence.
     Example 3:
     Input: s = "cb", p = "?a"
     Output: false
     Explanation: '?' matches 'c', but the second letter is 'a', which does not match 'b'.
     Constraints:
     0 <= s.length, p.length <= 2000
     s contains only lowercase English letters.
     p contains only lowercase English letters, '?' or '*'.
     */
    class WildcardMatching {
        static func runDemo() {
            print(isMatch("aa", "a"))     // false
            print(isMatch("aa", "*"))     // true
            print(isMatch("cb", "?a"))    // false
            print(isMatch("adceb", "*a*b")) // true
            print(isMatch("acdcb", "a*c?b")) // false
        }
        
        // Dynamic Programming solution
        static func isMatch(_ s: String, _ p: String) -> Bool {
            let sChars = Array(s)
            let pChars = Array(p)
            let m = sChars.count
            let n = pChars.count
            
            // dp[i][j] means: does s[0..<i] match p[0..<j]
            var dp = Array(repeating: Array(repeating: false, count: n + 1), count: m + 1)
            dp[0][0] = true // empty pattern matches empty string
            
            // Handle patterns like '*', '**', '***'
            for j in 1...n {
                if pChars[j - 1] == "*" {
                    dp[0][j] = dp[0][j - 1]
                }
            }
            
            for i in 1...m {
                for j in 1...n {
                    let sc = sChars[i - 1]
                    let pc = pChars[j - 1]
                    
                    if pc == "?" || pc == sc {
                        dp[i][j] = dp[i - 1][j - 1]
                    } else if pc == "*" {
                        // '*' matches 0 (dp[i][j - 1]) or more (dp[i - 1][j])
                        dp[i][j] = dp[i][j - 1] || dp[i - 1][j]
                    }
                }
            }
            
            return dp[m][n]
        }
    }
    
    /*
     Given two non-negative integers num1 and num2 represented as strings, return the product of num1 and num2, also represented as a string.
     Note: You must not use any built-in BigInteger library or convert the inputs to integer directly.
     Example 1:
     Input: num1 = "2", num2 = "3"
     Output: "6"
     Example 2:
     Input: num1 = "123", num2 = "456"
     Output: "56088"
     Constraints:
     1 <= num1.length, num2.length <= 200
     num1 and num2 consist of digits only.
     Both num1 and num2 do not contain any leading zero, except the number 0 itself.
     */
    class MultiplyStrings {
        static func runDemo() {
            print(multiply("2", "3"))       // Output: "6"
            print(multiply("123", "456"))   // Output: "56088"
            print(multiply("0", "12345"))   // Output: "0"
        }
        
        static func multiply(_ num1: String, _ num2: String) -> String {
            let len1 = num1.count
            let len2 = num2.count
            if num1 == "0" || num2 == "0" { return "0" }
            
            // Create an array to hold the result digits
            var result = Array(repeating: 0, count: len1 + len2)
            let digits1 = Array(num1)
            let digits2 = Array(num2)
            
            // Multiply each digit
            for i in (0..<len1).reversed() {
                let d1 = Int(String(digits1[i]))!
                for j in (0..<len2).reversed() {
                    let d2 = Int(String(digits2[j]))!
                    let product = d1 * d2
                    let p1 = i + j
                    let p2 = i + j + 1
                    let sum = product + result[p2]
                    
                    result[p2] = sum % 10
                    result[p1] += sum / 10
                }
            }
            
            // Convert result array to string
            var resultString = ""
            var leadingZero = true
            for digit in result {
                if digit == 0 && leadingZero {
                    continue
                }
                leadingZero = false
                resultString.append(String(digit))
            }
            
            return resultString.isEmpty ? "0" : resultString
        }
    }
    
    /*
     Given an unsorted integer array nums. Return the smallest positive integer that is not present in nums.
     You must implement an algorithm that runs in O(n) time and uses O(1) auxiliary space.
     Example 1:
     Input: nums = [1,2,0]
     Output: 3
     Explanation: The numbers in the range [1,2] are all in the array.
     Example 2:
     Input: nums = [3,4,-1,1]
     Output: 2
     Explanation: 1 is in the array but 2 is missing.
     Example 3:
     Input: nums = [7,8,9,11,12]
     Output: 1
     Explanation: The smallest positive integer 1 is missing.
     Constraints:
     1 <= nums.length <= 105
     -231 <= nums[i] <= 231 - 1
     */
    class FirstMissingPositive {
        static func runDemo() {
            let nums1 = [1, 2, 0]
            let nums2 = [3, 4, -1, 1]
            let nums3 = [7, 8, 9, 11, 12]
            
            print(firstMissingPositive(nums1)) // Output: 3
            print(firstMissingPositive(nums2)) // Output: 2
            print(firstMissingPositive(nums3)) // Output: 1
        }
        
        // Main function: O(n) time, O(1) space
        static func firstMissingPositive(_ nums: [Int]) -> Int {
            var nums = nums // make mutable copy
            let n = nums.count
            
            // Step 1: Place each number in its correct position if possible
            for i in 0..<n {
                while nums[i] > 0 && nums[i] <= n && nums[nums[i] - 1] != nums[i] {
                    nums.swapAt(i, nums[i] - 1)
                }
            }
            
            // Step 2: The first place where index != value means missing number
            for i in 0..<n {
                if nums[i] != i + 1 {
                    return i + 1
                }
            }
            
            // Step 3: All numbers are in place from 1 to n
            return n + 1
        }
    }
    
    /*
     Given a collection of candidate numbers (candidates) and a target number (target), find all unique combinations in candidates where the candidate numbers sum to target.
     Each number in candidates may only be used once in the combination.
     Note: The solution set must not contain duplicate combinations.
     Example 1:
     Input: candidates = [10,1,2,7,6,1,5], target = 8
     Output:
     [
     [1,1,6],
     [1,2,5],
     [1,7],
     [2,6]
     ]
     Example 2:
     
     Input: candidates = [2,5,2,1,2], target = 5
     Output:
     [
     [1,2,2],
     [5]
     ]
     */
    class CombinationSumII {
        // Entry point to test
        static func runDemo() {
            let candidates1 = [10,1,2,7,6,1,5]
            let target1 = 8
            let result1 = combinationSum2(candidates1, target1)
            print("Result 1:", result1)
            
            let candidates2 = [2,5,2,1,2]
            let target2 = 5
            let result2 = combinationSum2(candidates2, target2)
            print("Result 2:", result2)
        }
        
        // Main function to find unique combinations
        static func combinationSum2(_ candidates: [Int], _ target: Int) -> [[Int]] {
            var results: [[Int]] = []
            var path: [Int] = []
            let sortedCandidates = candidates.sorted() // Sort to handle duplicates easily
            backtrack(sortedCandidates, target, 0, &path, &results)
            return results
        }
        
        // Backtracking helper function
        private static func backtrack(_ candidates: [Int], _ target: Int, _ start: Int, _ path: inout [Int], _ results: inout [[Int]]) {
            if target == 0 {
                results.append(path)
                return
            }
            
            for i in start..<candidates.count {
                // Skip duplicates
                if i > start && candidates[i] == candidates[i - 1] {
                    continue
                }
                
                let current = candidates[i]
                if current > target {
                    break // No need to proceed if current is greater than remaining target
                }
                
                path.append(current)
                backtrack(candidates, target - current, i + 1, &path, &results) // i + 1: use number only once
                path.removeLast()
            }
        }
    }
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
        // let totalLength = wordLength * wordCount
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
