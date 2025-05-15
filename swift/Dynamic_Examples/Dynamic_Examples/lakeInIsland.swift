//
//  lakeInIsland.swift
//  Dynamic_Examples
//
//  Created by Simon Getrik on 15.05.2025.
//

import Foundation
/*
 A satellite image of the Pacific Ocean consists of green and blue pixels, representing land and water.
 The Pacific ocean is large, and mostly blue; but contains islands, which are green.
 Islands themselves may contain blue pixels, which are lakes.

 A frontend presents the image to a user, who can click on it.
 When the user clicks on a green pixel, a popup will appear that displays the number of lakes in that island.
 This UI code already exists: the problem of this question is to write the backend function that will
 return the value to display.

 As an example, consider an image (20 pixels wide by 8 tall) that is mostly blue;
 but contains 3 green rectangles:

 On the left of the image there is a horizontal line of three green pixels,
 from coordinates (2, 2) to (4, 2). This is an island with no lakes

 In the middle is a 3x3 square of green pixels (coordinates (5, 4) to (7, 6))
   where the center pixel (6, 5) is water. This is an island with 1 lake
   
 On the right is a green rectangle (coordinates (9, 2) to (16, 5))
   where three internal pixels are water: (12, 4), (14, 4), and (15, 4).
     This forms an island with two lakes.
   
                        1 1 1 1 1 1 1 1 1 1
    0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9
 0 |.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|
 1 |.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|
 2 |.|.|x|x|x|.|.|.|.|x|x|.|.|.|.|.|.|.|.|.|
 3 |.|.|.|.|.|.|.|.|x|.|.|x|x|x|x|x|x|.|.|.|
 4 |.|.|.|.|.|x|x|x|.|.|.|x|.|x|.|.|x|.|.|.|
 5 |.|.|.|.|.|x|.|x|.|.|.|x|x|x|x|x|x|.|.|.|
 6 |.|.|.|.|.|x|x|x|.|.|.|.|.|.|.|.|.|.|.|.|
 7 |.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|.|
 Assuming a function, count_lakes(image, coord) → integer:

 count_lakes(image, (2,2)) → 0
 count_lakes(image, (6,6)) → 1
 count_lakes(image, (12,5)) → 2

 */

typealias Grid = [[Int]]

let exampleGrid: Grid = [
    [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0], // 0
    [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0], // 1
    [0,0,1,1,1,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0], // 2
    [0,0,0,0,0,0,0,0,1,0,0,1,1,1,1,1,1,0,0,0], // 3
    [0,0,0,0,0,1,1,1,0,0,0,1,0,1,0,0,1,0,0,0], // 4
    [0,0,0,0,0,1,0,1,0,0,0,1,1,1,1,1,1,0,0,0], // 5
    [0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0], // 6
    [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]  // 7
]

func countLakes(image: Grid, coord: (Int, Int)) -> Int {
    // Check if the grid is empty
    guard !image.isEmpty, !image[0].isEmpty else { return 0 }
    let rows = image.count
    let cols = image[0].count
    
    // Set to keep track of visited pixels
    var visited = Set<Point>()
    // Set for green pixels of the island
    var islandLand = Set<Point>()
    // Set for water pixels adjacent to the island
    var adjacentWater = Set<Point>()
    
    // DFS to find the island (green pixels)
    // Time complexity: O(rows * cols) in worst case (if entire grid is land)
    func findIsland(_ x: Int, _ y: Int) {
        // Check boundaries, if pixel is land and not visited
        guard x >= 0, x < rows, y >= 0, y < cols,
              image[x][y] == 1, !visited.contains(Point(x: x, y: y)) else {
            return
        }
        
        let point = Point(x: x, y: y)
        visited.insert(point)
        islandLand.insert(point)
        
        // Check neighbors (up, down, left, right)
        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        for (dx, dy) in directions {
            let newX = x + dx
            let newY = y + dy
            if newX >= 0, newX < rows, newY >= 0, newY < cols {
                if image[newX][newY] == 0 {
                    // If neighbor is water, add to adjacentWater
                    adjacentWater.insert(Point(x: newX, y: newY))
                } else {
                    // If neighbor is land, continue search
                    findIsland(newX, newY)
                }
            }
        }
    }
    
    // DFS to mark the ocean (water connected to the border)
    // Time complexity: O(rows * cols) in worst case (if entire grid is water)
    func markOcean(_ x: Int, _ y: Int) {
        guard x >= 0, x < rows, y >= 0, y < cols,
              image[x][y] == 0, !visited.contains(Point(x: x, y: y)) else {
            return
        }
        
        visited.insert(Point(x: x, y: y))
        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        for (dx, dy) in directions {
            let newX = x + dx
            let newY = y + dy
            markOcean(newX, newY)
        }
    }
    
    // DFS to count lakes (connected components of water inside the island)
    // Time complexity: O(rows * cols) in worst case (if large connected water bodies)
    func countLake(_ x: Int, _ y: Int) {
        guard x >= 0, x < rows, y >= 0, y < cols,
              image[x][y] == 0, !visited.contains(Point(x: x, y: y)) else {
            return
        }
        
        visited.insert(Point(x: x, y: y))
        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        for (dx, dy) in directions {
            let newX = x + dx
            let newY = y + dy
            countLake(newX, newY)
        }
    }
    
    // Step 1: Mark the ocean
    for x in 0..<rows {
        for y in 0..<cols {
            // If pixel is on border and is water, start DFS
            if (x == 0 || x == rows - 1 || y == 0 || y == cols - 1) && image[x][y] == 0 {
                markOcean(x, y)
            }
        }
    }
    
    // Step 2: Find the island starting from coord
    visited.removeAll() // Reset visited for island search
    findIsland(coord.0, coord.1)
    
    // Step 3: Remove ocean from adjacentWater to get internal water (potential lakes)
    let internalWater = adjacentWater.subtracting(visited)
    
    // Step 4: Count lakes
    visited.formUnion(islandLand) // Mark land as visited
    var lakeCount = 0
    for waterPoint in internalWater {
        if !visited.contains(waterPoint) {
            countLake(waterPoint.x, waterPoint.y)
            lakeCount += 1
        }
    }
    
    return lakeCount
}
func demo_lakeCounter() {
    let lakes = countLakes(image: exampleGrid, coord: (2, 2))
    print("Number of lakes found: \(lakes)")
}
/*
 1) Find the island:

 Start from the clicked green pixel and use Depth-First Search (DFS) to find all green pixels that make up the island.

 Collect all green pixels of the island and all adjacent water pixels (potential lakes).

 2) Exclude the ocean:

 Mark all water pixels connected to the grid boundary (the ocean) using DFS.

 Remove these pixels from the list of adjacent water pixels, leaving only internal water pixels (possible lakes).

 3) Count the lakes:

 For each unmarked water pixel from the remaining set, run DFS to mark the connected region (a lake).

 Each new DFS increases the lake counter by one.

 4) Optimization:

 Use sets for fast lookup and to avoid revisiting pixels multiple times.

 Mark the ocean in advance so it is not checked during the lake counting phase.


 Cost :
 
 
 markOcean:
 Visits each water pixel connected to the border at most once → O(rows * cols) worst case.

 findIsland:
 Visits each land pixel connected to the starting coordinate at most once → O(rows * cols) worst case.

 countLake:
 Visits each water pixel in internal water components at most once → O(rows * cols) worst case.

 Overall complexity:
 Each DFS is limited to visiting each pixel once. The three main DFS passes collectively do not exceed O(rows * cols), since pixels are marked visited and not revisited unnecessarily. So the overall time complexity is O(rows * cols).
 
 
 
 
 */
