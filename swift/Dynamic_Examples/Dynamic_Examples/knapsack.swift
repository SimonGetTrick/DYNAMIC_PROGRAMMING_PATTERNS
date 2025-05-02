//
//  knapsack.swift
//  Dynamic_Examples
//
//  Created by Simon Getrik on 29.04.2025.
//

import Foundation
// duplicates are illegal
func knapsack(W: Int, weights: [Int], values: [Int], n: Int) -> Int {
    var dp = Array(repeating: Array(repeating: 0, count: W + 1), count: n + 1)

    for i in 1...n {
        for w in 1...W {
            if weights[i - 1] <= w {
                dp[i][w] = max(dp[i - 1][w], dp[i - 1][w - weights[i - 1]] + values[i - 1])
            } else {
                dp[i][w] = dp[i - 1][w]
            }
        }
    }

    return dp[n][W]
}
// duplicates are approved
func unboundedKnapsack(W: Int, weights: [Int], values: [Int], n: Int) -> Int {
    var dp = Array(repeating: 0, count: W + 1)

    for w in 1...W {
        for i in 0..<n {
            if weights[i] <= w {
                dp[w] = max(dp[w], dp[w - weights[i]] + values[i])
            }
        }
    }

    return dp[W]
}

