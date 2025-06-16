import Foundation
//digital keyboard:
//  1 2 3
//  4 5 6
//  7 8 9
//    0


struct KnightDialer {
    static let moves: [Int: [Int]] = [
        0: [4, 6],
        1: [6, 8],
        2: [7, 9],
        3: [4, 8],
        4: [3, 9, 0],
        5: [],
        6: [1, 7, 0],
        7: [2, 6],
        8: [1, 3],
        9: [2, 4]
    ]
    
    // Generates all valid knight sequences starting from `start` and making `steps` moves
    static func generateSequences(start: Int, steps: Int) -> [[Int]] {
        guard steps >= 0 else { return [] }
        var results: [[Int]] = []
        
        func dfs(current: Int, path: [Int], remainingSteps: Int) {
            if remainingSteps == 0 {
                results.append(path)
                return
            }
            for next in moves[current, default: []] {
                dfs(current: next, path: path + [next], remainingSteps: remainingSteps - 1)
            }
        }
        
        dfs(current: start, path: [start], remainingSteps: steps)
        return results
    }

    static func runDemo() {
        let steps = 4 // Number of knight moves
        for start in 0...9 {
            let sequences = generateSequences(start: start, steps: steps)
            print("(\(start), \(steps)): [")
            for seq in sequences {
                print("  \(seq),")
            }
            print("]")
            print("Total sequences: \(sequences.count)\n")
        }
    }
}
