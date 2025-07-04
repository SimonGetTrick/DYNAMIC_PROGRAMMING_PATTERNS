//
//  ClimbingStair.swift
//  Dynamic_Examples
//
//  Created by Simon Getrik on 19.06.2025.
//

import Foundation
class Solution {
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
