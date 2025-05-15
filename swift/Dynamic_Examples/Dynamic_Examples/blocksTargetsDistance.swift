//
//  blocksTargetsDistance.swift
//  Dynamic_Examples
//
//  Created by Simon Getrik on 15.05.2025.
//

import Foundation
// Given a list of blocks, each indicating the presence of certain facilities (e.g., gym, school, store),
// and a list of required facilities, find the block that minimizes the maximum walking distance to all required facilities,
// considering that facilities can be present in neighboring blocks as well.
typealias Block = [String: Bool]
let blocks: [Block] = [
    ["gym": false, "school": true, "store": false],
    ["gym": true, "school": false, "store": false],
    ["gym": true, "school": true, "store": false],
    ["gym": false, "school": true, "store": false],
    ["gym": false, "school": true, "store": true]
]

/*
Complexity Analysis Table:
Algorithm               | Time Complexity | Space Complexity | Explanation
------------------------|-----------------|------------------|-----------------------------------------------
Original (Naive)        | O(N² * R)       | O(N)             | For each block and each requirement, searches entire list of blocks
Optimized (Two Passes)  | O(N * R)        | O(N * R)         | Precomputes distances for each requirement in advance

Summary:
- Original algorithm is time-expensive due to nested searches for each requirement over all blocks.
- Optimized algorithm uses additional memory to store distances but is significantly faster, especially for large datasets.
*/



// Function to find the best block index given blocks and required places
func findBestBlock(blocks: [Block], reqs: [String]) -> Int? {
    // This array will store the max distance to required places for each block
    var maxDistances = [Int]()

    // Iterate over each block by index
    for i in 0..<blocks.count {
        var maxDistanceForBlock = 0
        
        // Check each required place
        for req in reqs {
            var closestDistance = Int.max
            
            // Search for the closest block that satisfies the required place
            for j in 0..<blocks.count {
                if blocks[j][req] == true {
                    // Calculate distance from current block i to j
                    let distance = abs(j - i)
                    if distance < closestDistance {
                        closestDistance = distance
                    }
                }
            }
            
            // Update max distance for this block for any requirement
            if closestDistance > maxDistanceForBlock {
                maxDistanceForBlock = closestDistance
            }
        }
        
        maxDistances.append(maxDistanceForBlock)
    }
    
    // Find the index of block with the minimum max distance
    if let minDistance = maxDistances.min() {
        return maxDistances.firstIndex(of: minDistance)
    }
    
    return nil
}

 
func findBestBlockOptimized(blocks: [Block], reqs: [String]) -> Int? {
    let n = blocks.count
    _ = reqs.count
    
    // Dictionary to hold distance arrays for each requirement
    var distances = [String: [Int]]()
    
    // For each requirement, calculate distances for all blocks
    for req in reqs {
        var dist = Array(repeating: Int.max, count: n)
        
        // Forward pass: find closest req location from the left
        var closestIndex: Int? = nil
        for i in 0..<n {
            if blocks[i][req] == true {
                closestIndex = i
                dist[i] = 0
            } else if let idx = closestIndex {
                dist[i] = i - idx
            }
        }
        
        // Backward pass: find closest req location from the right and take min
        closestIndex = nil
        for i in (0..<n).reversed() {
            if blocks[i][req] == true {
                closestIndex = i
                dist[i] = 0
            } else if let idx = closestIndex {
                dist[i] = min(dist[i], idx - i)
            }
        }
        
        distances[req] = dist
    }
    
    // For each block calculate max distance to all required places
    var maxDistances = Array(repeating: 0, count: n)
    for i in 0..<n {
        var maxDist = 0
        for req in reqs {
            if let dist = distances[req]?[i] {
                if dist > maxDist {
                    maxDist = dist
                }
            }
        }
        maxDistances[i] = maxDist
    }
    
    // Find block with minimal max distance
    if let minDistance = maxDistances.min() {
        return maxDistances.firstIndex(of: minDistance)
    }
    
    return nil
}


// third way optimisied
func findOptimalApartmentOptimized(blocks: [[String: Bool]], required: [String]) -> Int? {
    let n = blocks.count
    var buildingIndices: [String: [Int]] = [:]
    for building in required {
        buildingIndices[building] = []
    }
    
    // Collect indices
    for i in 0..<n {
        for building in required {
            if blocks[i][building] ?? false {
                buildingIndices[building]!.append(i)
            }
        }
    }
    
    // Find min and max index for each building type
    var minMaxDistance = Int.max
    var bestBlock = 0
    
    // Binary search or linear scan for optimal position
    for i in 0..<n {
        var maxDistance = 0
        for building in required {
            let indices = buildingIndices[building]!
            // Binary search for closest index
            let closest = indices.binarySearchClosest(to: i)
            maxDistance = max(maxDistance, abs(i - closest))
        }
        if maxDistance < minMaxDistance {
            minMaxDistance = maxDistance
            bestBlock = i
        }
    }
    
    return bestBlock
}

// Extension for binary search to find closest index
extension Array where Element == Int {
    func binarySearchClosest(to target: Int) -> Int {
        if isEmpty { return 0 } // Handle edge case
        var left = 0
        var right = count - 1
        while left <= right {
            let mid = (left + right) / 2
            if self[mid] == target {
                return self[mid]
            } else if self[mid] < target {
                left = mid + 1
            } else {
                right = mid - 1
            }
        }
        // Compare left and right to find closest
        let leftDist = left < count ? abs(self[left] - target) : Int.max
        let rightDist = right >= 0 ? abs(self[right] - target) : Int.max
        return leftDist <= rightDist ? self[left] : self[right]
    }
}

func demo_blockSerch() {
    // Example usage
    let blocks: [Block] = [
        ["gym": false, "school": true, "store": false],
        ["gym": true, "school": false, "store": false],
        ["gym": true, "school": true, "store": false],
        ["gym": false, "school": true, "store": false],
        ["gym": false, "school": true, "store": true]
    ]

    let reqs = ["gym", "school", "store"]

    if let bestBlock = findBestBlock(blocks: blocks, reqs: reqs) {
        print("Best block index: \(bestBlock)") // Expected output: 3 (the 4th block)
    } else {
        print("No suitable block found")
    }
    if let bestBlock = findBestBlockOptimized(blocks: blocks, reqs: reqs) {
        print("Best block index: \(bestBlock)")  // Expected output: 3
    } else {
        print("No suitable block found")
    }
    
    if let bestBlock = findOptimalApartmentOptimized(blocks: blocks, required: reqs) {
        print("Best block index: \(bestBlock)")  // Expected output: 3
    } else {
        print("No suitable block found")
    }

}
