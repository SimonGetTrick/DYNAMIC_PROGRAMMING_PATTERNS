//
//  rectCounter.swift
//  Dynamic_Examples
//
//  Created by Simon Getrik on 15.05.2025.
//

import Foundation
struct Point: Hashable {
    let x: Int
    let y: Int
}

func countRectangles(_ points: [Point]) -> Int {
    guard points.count >= 4 else { return 0 }
    
    // Группируем точки по x-координате: [x: [y1, y2, ...]]
    var xToYs: [Int: Set<Int>] = [:]
    for point in points {
        if xToYs[point.x] == nil {
            xToYs[point.x] = []
        }
        xToYs[point.x]!.insert(point.y)
    }
    
    var count = 0
    let xCoords = xToYs.keys.sorted()
    
    for i in 0..<xCoords.count {
        for j in (i + 1)..<xCoords.count {
            let x1 = xCoords[i]
            let x2 = xCoords[j]
            
            // common y-coordinates for x1 и x2
            guard let yList1 = xToYs[x1], let yList2 = xToYs[x2] else { continue }
            let commonYs = yList1.intersection(yList2)
            
            // count of rect = C(k, 2), where k — count of common y
            let k = commonYs.count
            count += (k * (k - 1)) / 2
        }
    }
    
    return count
}
func demo_rectCounter() {
    let points = [
        Point(x: 0, y: 0),
        Point(x: 0, y: 1),
        Point(x: 1, y: 0),
        Point(x: 1, y: 1),
        Point(x: 2, y: 0),
        Point(x: 2, y: 1)
    ]
    
    let result = countRectangles(points)
    print("Count of rectangulars : \(result)")
}
