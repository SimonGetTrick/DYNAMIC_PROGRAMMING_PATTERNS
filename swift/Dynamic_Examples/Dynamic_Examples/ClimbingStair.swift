//
//  ClimbingStair.swift
//  Dynamic_Examples
//
//  Created by Simon Getrik on 19.06.2025.
//

import Foundation
class Solution {
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
