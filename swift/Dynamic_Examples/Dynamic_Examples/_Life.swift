
//
//  Life.swift
//  Dynamic_Examples
//
//  Created by Simon Getrik on 04.01.2026.
//

/*
 289. Game of Life
 According to Wikipedia's article: "The Game of Life, also known simply as Life, is a cellular automaton devised by the British mathematician John Horton Conway in 1970."
 The board is made up of an m x n grid of cells, where each cell has an initial state: live (represented by a 1) or dead (represented by a 0). Each cell interacts with its eight neighbors (horizontal, vertical, diagonal) using the following four rules (taken from the above Wikipedia article):
 Any live cell with fewer than two live neighbors dies as if caused by under-population.
 Any live cell with two or three live neighbors lives on to the next generation.
 Any live cell with more than three live neighbors dies, as if by over-population.
 Any dead cell with exactly three live neighbors becomes a live cell, as if by reproduction.
 The next state of the board is determined by applying the above rules simultaneously to every cell in the current state of the m x n grid board. In this process, births and deaths occur simultaneously.
 Given the current state of the board, update the board to reflect its next state.
 Note that you do not need to return anything.
 Example 1:
 Input: board = [[0,1,0],[0,0,1],[1,1,1],[0,0,0]]
 Output: [[0,0,0],[1,0,1],[0,1,1],[0,1,0]]
 Example 2:
 Input: board = [[1,1],[1,0]]
 Output: [[1,1],[1,1]]
 Constraints:
 m == board.length
 n == board[i].length
 1 <= m, n <= 25
 board[i][j] is 0 or 1.
 */
// LeetCode 289. Game of Life
// Toroidal world with pattern generator and random seeding

final class Task289GameOfLife {

    // MARK: - Cell states (in-place encoding)

    //  1  -> live
    //  0  -> dead
    // -1  -> live -> dead
    //  2  -> dead -> live

    // MARK: - Patterns

    enum Pattern {
        case block
        case blinker
        case glider
        case toad
        case beacon

        var cells: [(Int, Int)] {
            switch self {
            case .block:
                return [(0,0), (0,1), (1,0), (1,1)]

            case .blinker:
                return [(0,0), (0,1), (0,2)]

            case .glider:
                return [(0,1), (1,2), (2,0), (2,1), (2,2)]

            case .toad:
                return [(0,1), (0,2), (0,3),
                        (1,0), (1,1), (1,2)]

            case .beacon:
                return [(0,0), (0,1), (1,0), (1,1),
                        (2,2), (2,3), (3,2), (3,3)]
            }
        }
    }

    // MARK: - Board generation

    /// Generates an empty board (all cells dead)
    static func generateBoard(rows: Int, cols: Int) -> [[Int]] {
        Array(repeating: Array(repeating: 0, count: cols), count: rows)
    }

    /// Places a pattern on the board using toroidal wrapping
    static func placePattern(
        board: inout [[Int]],
        pattern: Pattern,
        atRow row: Int,
        col: Int
    ) {
        let rows = board.count
        let cols = board[0].count

        for (dr, dc) in pattern.cells {
            let r = (row + dr + rows) % rows
            let c = (col + dc + cols) % cols
            board[r][c] = 1
        }
    }

    /// Randomly seeds the board with patterns
    static func seedRandomPatterns(
        board: inout [[Int]],
        patterns: [Pattern],
        count: Int
    ) {
        let rows = board.count
        let cols = board[0].count

        for _ in 0..<count {
            let pattern = patterns.randomElement()!
            let r = Int.random(in: 0..<rows)
            let c = Int.random(in: 0..<cols)
            placePattern(board: &board, pattern: pattern, atRow: r, col: c)
        }
    }

    // MARK: - Game logic (toroidal)

    static func step(board: inout [[Int]]) {

        let rows = board.count
        let cols = board[0].count

        let directions = [
            (-1,-1), (-1,0), (-1,1),
            ( 0,-1),         ( 0,1),
            ( 1,-1), ( 1,0), ( 1,1)
        ]

        // First pass: mark transitions
        for r in 0..<rows {
            for c in 0..<cols {

                var liveNeighbors = 0

                for (dr, dc) in directions {
                    let nr = (r + dr + rows) % rows
                    let nc = (c + dc + cols) % cols

                    if abs(board[nr][nc]) == 1 {
                        liveNeighbors += 1
                    }
                }

                if board[r][c] == 1 && (liveNeighbors < 2 || liveNeighbors > 3) {
                    board[r][c] = -1
                }

                if board[r][c] == 0 && liveNeighbors == 3 {
                    board[r][c] = 2
                }
            }
        }

        // Second pass: normalize states
        for r in 0..<rows {
            for c in 0..<cols {
                board[r][c] = board[r][c] > 0 ? 1 : 0
            }
        }
    }

    // MARK: - Debug / Visualization

    static func printBoard(_ board: [[Int]]) {
        for row in board {
            print(row.map { $0 == 1 ? "⬛️" : "⬜️" }.joined())
        }
        print()
    }

    // MARK: - Demo

    static func demo() {

        // Create large toroidal world
        let rows = 20
        let cols = 40

        var board = generateBoard(rows: rows, cols: cols)

        // Seed known patterns
        placePattern(board: &board, pattern: .glider, atRow: 1, col: 1)
        placePattern(board: &board, pattern: .blinker, atRow: 10, col: 10)
        placePattern(board: &board, pattern: .block, atRow: 15, col: 30)

        // Seed random patterns
        seedRandomPatterns(
            board: &board,
            patterns: [.glider, .toad, .beacon],
            count: 10
        )

        // Run simulation
        for generation in 1...5 {
            print("Generation \(generation)")
            printBoard(board)
            step(board: &board)
        }
    }
}
