//
//  ClimbingStair.swift
//  Dynamic_Examples
//
//  Created by Simon Getrik on 19.06.2025.
//

import Foundation
class Solution {
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
 task:
 Climbing Stairs
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
