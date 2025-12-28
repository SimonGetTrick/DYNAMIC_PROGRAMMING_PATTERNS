//
//  ClimbingStair.swift
//  Dynamic_Examples
//
//  Created by Simon Getrik on 19.06.2025.
//

import Foundation

// MARK: - Helper for binary formatting
extension String {
    func leftPad(toLength: Int, withPad character: Character = "0") -> String {
        let paddingCount = max(0, toLength - self.count)
        return String(repeating: String(character), count: paddingCount) + self
    }
}
extension Array where Element == Int {
    func binarySearch(_ x: Int) -> Int {
        var l = 0, r = count
        while l < r {
            let mid = (l + r) / 2
            if self[mid] < x { l = mid + 1 } else { r = mid }
        }
        return l
    }
}

class Solution {
    /*
     275. H-Index II
     Given an array of integers citations where citations[i] is the number of citations a researcher received for their ith paper and citations is sorted in non-descending order, return the researcher's h-index.
     According to the definition of h-index on Wikipedia: The h-index is defined as the maximum value of h such that the given researcher has published at least h papers that have each been cited at least h times.
     You must write an algorithm that runs in logarithmic time.
     Example 1:
     Input: citations = [0,1,3,5,6]
     Output: 3
     Explanation: [0,1,3,5,6] means the researcher has 5 papers in total and each of them had received 0, 1, 3, 5, 6 citations respectively.
     Since the researcher has 3 papers with at least 3 citations each and the remaining two with no more than 3 citations each, their h-index is 3.
     Example 2:
     Input: citations = [1,2,100]
     Output: 2
     Constraints:
     n == citations.length
     1 <= n <= 105
     0 <= citations[i] <= 1000
     citations is sorted in ascending order.
     */
    // LeetCode 275. H-Index II
    // Binary Search solution (O(log n))

    final class Task275HIndexII {

        // Entry point for console demo
        static func demo() {

            let testCases = [
                [0, 1, 3, 5, 6],
                [1, 2, 100],
                [0, 0, 0],
                [10, 10, 10],
                [0, 1, 2, 4, 5, 6]
            ]

            for citations in testCases {
                let h = hIndex275(citations)
                print("Citations: \(citations) -> H-Index: \(h)")
            }
        }

        // Computes the H-Index using binary search
        static func hIndex275(_ citations: [Int]) -> Int {

            let n = citations.count
            var left = 0
            var right = n - 1

            while left <= right {
                let mid = left + (right - left) / 2
                let papersWithAtLeastThisManyCitations = n - mid

                if citations[mid] >= papersWithAtLeastThisManyCitations {
                    // Try to find a smaller index on the left
                    right = mid - 1
                } else {
                    // Need more citations → move right
                    left = mid + 1
                }
            }

            // left is the first index satisfying the condition
            return n - left
        }
    }

    /*
     ------------------------------------------------------------
     Explanation
     ------------------------------------------------------------

     Given sorted citations in ascending order.

     At index i:
     - Number of papers with citations >= citations[i] is (n - i)
     - H-index condition:
         citations[i] >= (n - i)

     We binary search for the first index i where the condition is true.

     Example:
     citations = [0, 1, 3, 5, 6]
     n = 5

     i = 2:
     citations[2] = 3
     n - i = 3
     3 >= 3 ✔

     First such index is i = 2
     H-index = n - i = 3

     ------------------------------------------------------------
     Time Complexity: O(log n)
     Space Complexity: O(1)
     ------------------------------------------------------------
     */
    /*
     274. H-Index
     Given an array of integers citations where citations[i] is the number of citations a researcher received for their ith paper, return the researcher's h-index.
     According to the definition of h-index on Wikipedia: The h-index is defined as the maximum value of h such that the given researcher has published at least h papers that have each been cited at least h times.
Example 1:
     Input: citations = [3,0,6,1,5]
     Output: 3
     Explanation: [3,0,6,1,5] means the researcher has 5 papers in total and each of them had received 3, 0, 6, 1, 5 citations respectively.
     Since the researcher has 3 papers with at least 3 citations each and the remaining two with no more than 3 citations each, their h-index is 3.
Example 2:
     Input: citations = [1,3,1]
     Output: 1
     Constraints:
     n == citations.length
     1 <= n <= 5000
     0 <= citations[i] <= 1000
     */
    // LeetCode 274. H-Index
    // Sorting-based solution

    final class Task274HIndex {

        // Entry point for console demo
        static func demo() {

            let testCases = [
                [3, 0, 6, 1, 5],
                [1, 3, 1],
                [0, 0, 0],
                [10, 8, 5, 4, 3],
                [25, 8, 5, 3, 3]
            ]

            for citations in testCases {
                let h = hIndex274(citations)
                print("Citations: \(citations) -> H-Index: \(h)")
            }
        }

        // Computes the H-Index using sorting
        static func hIndex274(_ citations: [Int]) -> Int {

            // Sort citations in descending order
            let sorted = citations.sorted(by: >)

            var h = 0

            // Iterate and check the H-index condition
            for i in 0..<sorted.count {
                if sorted[i] >= i + 1 {
                    h = i + 1
                } else {
                    break
                }
            }

            return h
        }
    }

    /*
     ------------------------------------------------------------
     Explanation
     ------------------------------------------------------------

     1) Sort citations in descending order
     2) For each index i:
        - Check if citations[i] >= i + 1
        - If true, we can have at least (i + 1) papers
          with at least (i + 1) citations
     3) The largest valid (i + 1) is the H-index

     Example:
     citations = [3, 0, 6, 1, 5]
     sorted    = [6, 5, 3, 1, 0]

     i = 0 → 6 >= 1 ✔
     i = 1 → 5 >= 2 ✔
     i = 2 → 3 >= 3 ✔
     i = 3 → 1 >= 4 ✘ → stop

     H-index = 3

     ------------------------------------------------------------
     Time Complexity: O(n log n)
     Space Complexity: O(n)
     ------------------------------------------------------------
     */

    /*
     273. Integer to English Words
     Convert a non-negative integer num to its English words representation.
     Example 1:
     Input: num = 123
     Output: "One Hundred Twenty Three"
     Example 2:
     Input: num = 12345
     Output: "Twelve Thousand Three Hundred Forty Five"
     Example 3:
     Input: num = 1234567
     Output: "One Million Two Hundred Thirty Four Thousand Five Hundred Sixty Seven"
     Constraints:
     0 <= num <= 231 - 1
     */
    // LeetCode 273. Integer to English & German Words
    // English and German number-to-words conversion

    final class Task273IntegerToEnglishWords {

        // Entry point for console demo
        static func demo() {

            let testCases = [
                0,
                7,
                21,
                105,
                123,
                12345,
                1_000_001
            ]

            for num in testCases {
                let en = numberToWords273(num)
                let de = numberToWords273DE(num)

                print("Number: \(num)")
                print("EN: \(en)")
                print("DE: \(de)")
                print("------------")
            }
        }

        // MARK: - English Version

        static func numberToWords273(_ num: Int) -> String {

            if num == 0 { return "Zero" }

            var num = num
            var result = ""

            if num >= 1_000_000_000 {
                result += convertBelowThousandEN(num / 1_000_000_000) + " Billion"
                num %= 1_000_000_000
            }

            if num >= 1_000_000 {
                if !result.isEmpty { result += " " }
                result += convertBelowThousandEN(num / 1_000_000) + " Million"
                num %= 1_000_000
            }

            if num >= 1_000 {
                if !result.isEmpty { result += " " }
                result += convertBelowThousandEN(num / 1_000) + " Thousand"
                num %= 1_000
            }

            if num > 0 {
                if !result.isEmpty { result += " " }
                result += convertBelowThousandEN(num)
            }

            return result
        }

        private static func convertBelowThousandEN(_ num: Int) -> String {

            let belowTwenty = [
                "", "One", "Two", "Three", "Four", "Five",
                "Six", "Seven", "Eight", "Nine", "Ten",
                "Eleven", "Twelve", "Thirteen", "Fourteen",
                "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen"
            ]

            let tens = [
                "", "", "Twenty", "Thirty", "Forty",
                "Fifty", "Sixty", "Seventy", "Eighty", "Ninety"
            ]

            var num = num
            var words = ""

            if num >= 100 {
                words += belowTwenty[num / 100] + " Hundred"
                num %= 100
            }

            if num >= 20 {
                if !words.isEmpty { words += " " }
                words += tens[num / 10]
                num %= 10
            }

            if num > 0 {
                if !words.isEmpty { words += " " }
                words += belowTwenty[num]
            }

            return words
        }

        // MARK: - German Version 🇩🇪

        static func numberToWords273DE(_ num: Int) -> String {

            if num == 0 { return "null" }

            var num = num
            var result = ""

            if num >= 1_000_000 {
                let millions = num / 1_000_000
                result += convertBelowThousandDE(millions)
                result += millions == 1 ? " Million" : " Millionen"
                num %= 1_000_000
            }

            if num >= 1_000 {
                if !result.isEmpty { result += " " }
                result += convertBelowThousandDE(num / 1_000) + "tausend"
                num %= 1_000
            }

            if num > 0 {
                if !result.isEmpty { result += " " }
                result += convertBelowThousandDE(num)
            }

            return result
        }

        // Converts numbers from 1 to 999 (German rules)
        private static func convertBelowThousandDE(_ num: Int) -> String {

            let ones = [
                "", "ein", "zwei", "drei", "vier", "fünf",
                "sechs", "sieben", "acht", "neun", "zehn",
                "elf", "zwölf", "dreizehn", "vierzehn",
                "fünfzehn", "sechzehn", "siebzehn",
                "achtzehn", "neunzehn"
            ]

            let tens = [
                "", "", "zwanzig", "dreißig", "vierzig",
                "fünfzig", "sechzig", "siebzig",
                "achtzig", "neunzig"
            ]

            var num = num
            var words = ""

            if num >= 100 {
                words += ones[num / 100] + "hundert"
                num %= 100
            }

            if num >= 20 {
                let unit = num % 10
                let ten = num / 10

                if unit > 0 {
                    words += ones[unit] + "und" + tens[ten]
                } else {
                    words += tens[ten]
                }
            } else if num > 0 {
                words += ones[num]
            }

            return words
        }
    }

    /*
     ------------------------------------------------------------
     English vs German comparison
     ------------------------------------------------------------

     English:
     - "Twenty One"
     - tens before ones
     - words separated by spaces

     German:
     - "einundzwanzig"
     - ones before tens
     - words written together

     Example:
     21
     EN -> Twenty One
     DE -> einundzwanzig

     ------------------------------------------------------------
     Time Complexity: O(1)
     Space Complexity: O(1)
     ------------------------------------------------------------
     */

    /*
     268. Missing Number
     Given an array nums containing n distinct numbers in the range [0, n], return the only number in the range that is missing from the array.
     Example 1:
     Input: nums = [3,0,1]
     Output: 2
     Explanation:
     n = 3 since there are 3 numbers, so all numbers are in the range [0,3]. 2 is the missing number in the range since it does not appear in nums.
     Example 2:
     Input: nums = [0,1]
     Output: 2
     Explanation:
     n = 2 since there are 2 numbers, so all numbers are in the range [0,2]. 2 is the missing number in the range since it does not appear in nums.
     Example 3:
     Input: nums = [9,6,4,2,3,5,7,0,1]
     Output: 8
     Explanation:
     n = 9 since there are 9 numbers, so all numbers are in the range [0,9]. 8 is the missing number in the range since it does not appear in nums.
     */
    // LeetCode 268. Missing Number
    // Finds the missing number in range [0, n] using XOR

    final class Task268MissingNumber {

        // Entry point for console demo
        static func demo() {

            let testCases = [
                [3, 0, 1],
                [0, 1],
                [9, 6, 4, 2, 3, 5, 7, 0, 1]
            ]

            for nums in testCases {
                let result = missingNumber268(nums)
                print("nums = \(nums) -> missing = \(result)")
            }
        }

        // Returns the missing number
        static func missingNumber268(_ nums: [Int]) -> Int {

            let n = nums.count

            // XOR of all indices and values
            var xorResult = 0

            // XOR all numbers from 0 to n
            for i in 0...n {
                xorResult ^= i
            }

            // XOR all elements in the array
            for num in nums {
                xorResult ^= num
            }

            // Remaining value is the missing number
            return xorResult
        }
    }

    /*
     ------------------------------------------------------------
     Explanation
     ------------------------------------------------------------

     XOR properties:
     1) a ^ a = 0
     2) a ^ 0 = a
     3) XOR is commutative and associative

     Idea:
     - XOR all numbers from 0 to n
     - XOR all numbers present in the array
     - All matching pairs cancel out
     - The remaining value is the missing number

     Example:
     nums = [3, 0, 1], n = 3

     Full range XOR:   0 ^ 1 ^ 2 ^ 3
     Array XOR:        3 ^ 0 ^ 1
     Result:           2

     ------------------------------------------------------------
     Time Complexity: O(n)
     Space Complexity: O(1)
     ------------------------------------------------------------
    */

    /*
     264. Ugly Number II
    An ugly number is a positive integer whose prime factors are limited to 2, 3, and 5.
     Given an integer n, return the nth ugly number.
     Example 1:
     Input: n = 10
     Output: 12
     Explanation: [1, 2, 3, 4, 5, 6, 8, 9, 10, 12] is the sequence of the first 10 ugly numbers.
     Example 2:
     Input: n = 1
     Output: 1
     Explanation: 1 has no prime factors, therefore all of its prime factors are limited to 2, 3, and 5.
     Constraints:
     1 <= n <= 1690
     */
    // LeetCode 264. Ugly Number II
    // Finds the n-th ugly number using dynamic programming

    final class Task264UglyNumberII {

        // Entry point for console demo
        static func demo() {

            let testValues = [1, 10, 15]

            for n in testValues {
                let result = nthUglyNumber264(n)
                print("n = \(n), nth ugly number = \(result)")
            }
        }

        // Returns the n-th ugly number
        static func nthUglyNumber264(_ n: Int) -> Int {

            // Base case
            if n == 1 {
                return 1
            }

            // DP array to store ugly numbers
            var ugly = Array(repeating: 0, count: n)
            ugly[0] = 1

            // Three pointers for multiples of 2, 3, and 5
            var i2 = 0
            var i3 = 0
            var i5 = 0

            for index in 1..<n {

                // Next possible ugly numbers
                let next2 = ugly[i2] * 2
                let next3 = ugly[i3] * 3
                let next5 = ugly[i5] * 5

                // Choose the smallest candidate
                let nextUgly = min(next2, next3, next5)
                ugly[index] = nextUgly

                // Move pointers that produced the minimum
                if nextUgly == next2 {
                    i2 += 1
                }
                if nextUgly == next3 {
                    i3 += 1
                }
                if nextUgly == next5 {
                    i5 += 1
                }
            }

            return ugly[n - 1]
        }
    }

    /*
     ------------------------------------------------------------
     Explanation
     ------------------------------------------------------------

     We generate ugly numbers in ascending order using DP.

     Key idea:
     Every ugly number is produced by multiplying a previous ugly number
     by 2, 3, or 5.

     We maintain:
     - ugly[] : list of generated ugly numbers
     - i2, i3, i5 : pointers to positions whose multiples are candidates

     At each step:
     1. Compute next candidates (ugly[i2]*2, ugly[i3]*3, ugly[i5]*5)
     2. Pick the smallest one
     3. Move all pointers that generated this value

     This avoids duplicates (e.g. 6 from 2*3 and 3*2).

     ------------------------------------------------------------
     Time Complexity: O(n)
     Space Complexity: O(n)
     ------------------------------------------------------------
    */
    /*
     263. Ugly Number
     An ugly number is a positive integer which does not have a prime factor other than 2, 3, and 5.
     Given an integer n, return true if n is an ugly number.
Example 1:
     Input: n = 6
     Output: true
     Explanation: 6 = 2 × 3
Example 2:
     Input: n = 1
     Output: true
     Explanation: 1 has no prime factors.
Example 3:
     Input: n = 14
     Output: false
     Explanation: 14 is not ugly since it includes the prime factor 7.
     */
    // LeetCode 263. Ugly Number
    // Determines whether a number has no prime factors other than 2, 3, and 5

    final class Task263UglyNumber {

        // Entry point for console demo
        static func demo() {

            let testValues = [6, 1, 14, 8, 0, -5]

            for n in testValues {
                print("n = \(n), isUgly = \(isUgly263(n))")
            }
        }

        // Checks if a number is an ugly number
        static func isUgly263(_ n: Int) -> Bool {

            // Ugly numbers must be positive
            if n <= 0 {
                return false
            }

            var value = n

            // Remove all factors of 2
            while value % 2 == 0 {
                value /= 2
            }

            // Remove all factors of 3
            while value % 3 == 0 {
                value /= 3
            }

            // Remove all factors of 5
            while value % 5 == 0 {
                value /= 5
            }

            // If only 1 remains, number is ugly
            return value == 1
        }
    }

    /*
     ------------------------------------------------------------
     Explanation
     ------------------------------------------------------------

     An ugly number is a number whose prime factors are limited to 2, 3, and 5.

     Algorithm:
     1. If n <= 0 → return false
     2. Repeatedly divide n by 2 while possible
     3. Repeatedly divide n by 3 while possible
     4. Repeatedly divide n by 5 while possible
     5. If the final result is 1 → ugly number

     ------------------------------------------------------------
     Time Complexity: O(log n)
     Space Complexity: O(1)
     ------------------------------------------------------------
    */

    /*
     262. Trips and Users
     Hard + SQL Schema
     Table: Trips

     +-------------+----------+
     | Column Name | Type     |
     +-------------+----------+
     | id          | int      |
     | client_id   | int      |
     | driver_id   | int      |
     | city_id     | int      |
     | status      | enum     |
     | request_at  | varchar  |
     +-------------+----------+
     id is the primary key (column with unique values) for this table.
     The table holds all taxi trips. Each trip has a unique id, while client_id and driver_id are foreign keys to the users_id at the Users table.
     Status is an ENUM (category) type of ('completed', 'cancelled_by_driver', 'cancelled_by_client').

     Table: Users

     +-------------+----------+
     | Column Name | Type     |
     +-------------+----------+
     | users_id    | int      |
     | banned      | enum     |
     | role        | enum     |
     +-------------+----------+
     users_id is the primary key (column with unique values) for this table.
     The table holds all users. Each user has a unique users_id, and role is an ENUM type of ('client', 'driver', 'partner').
     banned is an ENUM (category) type of ('Yes', 'No').

     The cancellation rate is computed by dividing the number of canceled (by client or driver) requests with unbanned users by the total number of requests with unbanned users on that day.

     Write a solution to find the cancellation rate of requests with unbanned users (both client and driver must not be banned) each day between "2013-10-01" and "2013-10-03" with at least one trip. Round Cancellation Rate to two decimal points.

     Return the result table in any order.

     The result format is in the following example.

      

     Example 1:

     Input:
     Trips table:
     +----+-----------+-----------+---------+---------------------+------------+
     | id | client_id | driver_id | city_id | status              | request_at |
     +----+-----------+-----------+---------+---------------------+------------+
     | 1  | 1         | 10        | 1       | completed           | 2013-10-01 |
     | 2  | 2         | 11        | 1       | cancelled_by_driver | 2013-10-01 |
     | 3  | 3         | 12        | 6       | completed           | 2013-10-01 |
     | 4  | 4         | 13        | 6       | cancelled_by_client | 2013-10-01 |
     | 5  | 1         | 10        | 1       | completed           | 2013-10-02 |
     | 6  | 2         | 11        | 6       | completed           | 2013-10-02 |
     | 7  | 3         | 12        | 6       | completed           | 2013-10-02 |
     | 8  | 2         | 12        | 12      | completed           | 2013-10-03 |
     | 9  | 3         | 10        | 12      | completed           | 2013-10-03 |
     | 10 | 4         | 13        | 12      | cancelled_by_driver | 2013-10-03 |
     +----+-----------+-----------+---------+---------------------+------------+
     Users table:
     +----------+--------+--------+
     | users_id | banned | role   |
     +----------+--------+--------+
     | 1        | No     | client |
     | 2        | Yes    | client |
     | 3        | No     | client |
     | 4        | No     | client |
     | 10       | No     | driver |
     | 11       | No     | driver |
     | 12       | No     | driver |
     | 13       | No     | driver |
     +----------+--------+--------+
     Output:
     +------------+-------------------+
     | Day        | Cancellation Rate |
     +------------+-------------------+
     | 2013-10-01 | 0.33              |
     | 2013-10-02 | 0.00              |
     | 2013-10-03 | 0.50              |
     +------------+-------------------+
     Explanation:
     On 2013-10-01:
       - There were 4 requests in total, 2 of which were canceled.
       - However, the request with Id=2 was made by a banned client (User_Id=2), so it is ignored in the calculation.
       - Hence there are 3 unbanned requests in total, 1 of which was canceled.
       - The Cancellation Rate is (1 / 3) = 0.33
     On 2013-10-02:
       - There were 3 requests in total, 0 of which were canceled.
       - The request with Id=6 was made by a banned client, so it is ignored.
       - Hence there are 2 unbanned requests in total, 0 of which were canceled.
       - The Cancellation Rate is (0 / 2) = 0.00
     On 2013-10-03:
       - There were 3 requests in total, 1 of which was canceled.
       - The request with Id=8 was made by a banned client, so it is ignored.
       - Hence there are 2 unbanned request in total, 1 of which were canceled.
       - The Cancellation Rate is (1 / 2) = 0.50
     SELECT
         t.request_at AS Day,
         ROUND(
             SUM(
                 CASE
                     WHEN t.status IN ('cancelled_by_driver', 'cancelled_by_client')
                     THEN 1 ELSE 0
                 END
             ) / COUNT(*),
             2
         ) AS "Cancellation Rate"
     FROM Trips t
     JOIN Users c
         ON t.client_id = c.users_id
         AND c.banned = 'No'
     JOIN Users d
         ON t.driver_id = d.users_id
         AND d.banned = 'No'
     WHERE t.request_at BETWEEN '2013-10-01' AND '2013-10-03'
     GROUP BY t.request_at;
     */
    // LeetCode 262. Trips and Users
    // Emulation of SQL solution using pure Swift (console project)

    final class Task262TripsAndUsers {

        // Entry point for demo execution
        static func demo() {

            // MARK: - Models (Tables)

            // Represents a row from Users table
            struct User {
                let id: Int
                let banned: Bool
            }

            // Represents a row from Trips table
            struct Trip {
                let id: Int
                let clientId: Int
                let driverId: Int
                let status: Status
                let date: String
            }

            enum Status {
                case completed
                case cancelledByClient
                case cancelledByDriver
            }

            // MARK: - Data (Same as problem example)

            let users: [Int: User] = [
                1: User(id: 1, banned: false),
                2: User(id: 2, banned: true),
                3: User(id: 3, banned: false),
                4: User(id: 4, banned: false),
                10: User(id: 10, banned: false),
                11: User(id: 11, banned: false),
                12: User(id: 12, banned: false),
                13: User(id: 13, banned: false)
            ]

            let trips: [Trip] = [
                Trip(id: 1, clientId: 1, driverId: 10, status: .completed, date: "2013-10-01"),
                Trip(id: 2, clientId: 2, driverId: 11, status: .cancelledByDriver, date: "2013-10-01"),
                Trip(id: 3, clientId: 3, driverId: 12, status: .completed, date: "2013-10-01"),
                Trip(id: 4, clientId: 4, driverId: 13, status: .cancelledByClient, date: "2013-10-01"),

                Trip(id: 5, clientId: 1, driverId: 10, status: .completed, date: "2013-10-02"),
                Trip(id: 6, clientId: 2, driverId: 11, status: .completed, date: "2013-10-02"),
                Trip(id: 7, clientId: 3, driverId: 12, status: .completed, date: "2013-10-02"),

                Trip(id: 8, clientId: 2, driverId: 12, status: .completed, date: "2013-10-03"),
                Trip(id: 9, clientId: 3, driverId: 10, status: .completed, date: "2013-10-03"),
                Trip(id: 10, clientId: 4, driverId: 13, status: .cancelledByDriver, date: "2013-10-03")
            ]

            // MARK: - Calculation Logic

            // Allowed date range
            let validDates = Set(["2013-10-01", "2013-10-02", "2013-10-03"])

            // Day -> (total trips, cancelled trips)
            var stats: [String: (total: Int, cancelled: Int)] = [:]

            for trip in trips {

                // WHERE request_at BETWEEN dates
                guard validDates.contains(trip.date) else { continue }

                // JOIN Users (client and driver)
                guard
                    let client = users[trip.clientId],
                    let driver = users[trip.driverId]
                else { continue }

                // WHERE client.banned = 'No' AND driver.banned = 'No'
                guard !client.banned && !driver.banned else { continue }

                // GROUP BY request_at (initialize if needed)
                if stats[trip.date] == nil {
                    stats[trip.date] = (0, 0)
                }

                // COUNT(*)
                stats[trip.date]!.total += 1

                // COUNT cancelled trips
                if trip.status != .completed {
                    stats[trip.date]!.cancelled += 1
                }
            }

            // MARK: - Output

            for (day, value) in stats.sorted(by: { $0.key < $1.key }) {
                let rate = Double(value.cancelled) / Double(value.total)
                let rounded = String(format: "%.2f", rate)
                print("\(day) -> Cancellation Rate: \(rounded)")
            }
        }
    }

    /*
     ------------------------------------------------------------
     SQL vs Swift (line by line comparison)
     ------------------------------------------------------------

     SQL:
     SELECT request_at AS Day,
            ROUND(
                SUM(status != 'completed') / COUNT(*), 2
            ) AS Cancellation Rate

     Swift:
     let rate = Double(cancelled) / Double(total)
     let rounded = String(format: "%.2f", rate)

     ------------------------------------------------------------

     SQL:
     FROM Trips t
     JOIN Users c ON t.client_id = c.users_id
     JOIN Users d ON t.driver_id = d.users_id

     Swift:
     let client = users[trip.clientId]
     let driver = users[trip.driverId]

     ------------------------------------------------------------

     SQL:
     WHERE c.banned = 'No'
       AND d.banned = 'No'

     Swift:
     guard !client.banned && !driver.banned else { continue }

     ------------------------------------------------------------

     SQL:
     AND request_at BETWEEN '2013-10-01' AND '2013-10-03'

     Swift:
     guard validDates.contains(trip.date) else { continue }

     ------------------------------------------------------------

     SQL:
     GROUP BY request_at

     Swift:
     stats[trip.date] = (total, cancelled)

     ------------------------------------------------------------
    */

    /*
     260. Single Number III
     Given an integer array nums, in which exactly two elements appear only once and all the other elements appear exactly twice. Find the two elements that appear only once. You can return the answer in any order.

     You must write an algorithm that runs in linear runtime complexity and uses only constant extra space.
     Example 1:
     Input: nums = [1,2,1,3,2,5]
     Output: [3,5]
     Explanation:  [5, 3] is also a valid answer.
     Example 2:
     Input: nums = [-1,0]
     Output: [-1,0]
     Example 3:
     Input: nums = [0,1]
     Output: [1,0]
      

     Constraints:

     2 <= nums.length <= 3 * 104
     -231 <= nums[i] <= 231 - 1
     Each integer in nums will appear twice, only two integers will appear once.     */
    // 260. Single Number III
    // Time Complexity: O(n)
    // Space Complexity: O(1)

    class LC260_SingleNumberIII {

        func singleNumber(_ nums: [Int]) -> [Int] {
            var xorAll = 0

            // Step 1: XOR of all numbers (result = x ^ y)
            for num in nums {
                xorAll ^= num
            }

            // Step 2: Find a distinguishing bit (rightmost set bit)
            let diffBit = xorAll & -xorAll

            var num1 = 0
            var num2 = 0

            // Step 3: Split numbers into two groups based on diffBit
            for num in nums {
                if (num & diffBit) == 0 {
                    num1 ^= num
                } else {
                    num2 ^= num
                }
            }

            return [num1, num2]
        }
    }
    /*
     242. Valid Anagram
     Given two strings s and t, return true if t is an anagram of s, and false otherwise.
     Example 1:
     Input: s = "anagram", t = "nagaram"
     Output: true
     Example 2:
     Input: s = "rat", t = "car"
     Output: false
     Constraints:
     1 <= s.length, t.length <= 5 * 104
     s and t consist of lowercase English letters.
     Follow up: What if the inputs contain Unicode characters? How would you adapt your solution to such a case?
     */
    // 242. Valid Anagram
    // Time Complexity: O(n)
    // Space Complexity: O(1)

    class LC242_ValidAnagram {

        func isAnagram(_ s: String, _ t: String) -> Bool {
            // If lengths differ, they cannot be anagrams
            if s.count != t.count {
                return false
            }

            var count = Array(repeating: 0, count: 26)
            let aAscii = Int(Character("a").asciiValue!)

            // Count characters in s
            for ch in s {
                count[Int(ch.asciiValue!) - aAscii] += 1
            }

            // Subtract characters in t
            for ch in t {
                let index = Int(ch.asciiValue!) - aAscii
                count[index] -= 1
                if count[index] < 0 {
                    return false
                }
            }

            return true
        }
    }

    /*
     241. Different Ways to Add Parentheses
     Given a string expression of numbers and operators, return all possible results from computing all the different possible ways to group numbers and operators. You may return the answer in any order.
     The test cases are generated such that the output values fit in a 32-bit integer and the number of different results does not exceed 104.
     Example 1:
     Input: expression = "2-1-1"
     Output: [0,2]
     Explanation:
     ((2-1)-1) = 0
     (2-(1-1)) = 2
     Example 2:
     Input: expression = "2*3-4*5"
     Output: [-34,-14,-10,-10,10]
     Explanation:
     (2*(3-(4*5))) = -34
     ((2*3)-(4*5)) = -14
     ((2*(3-4))*5) = -10
     (2*((3-4)*5)) = -10
     (((2*3)-4)*5) = 10
     Constraints:
     1 <= expression.length <= 20
     expression consists of digits and the operator '+', '-', and '*'.
     All the integer values in the input expression are in the range [0, 99].
     The integer values in the input expression do not have a leading '-' or '+' denoting the sign.
     */
    // 241. Different Ways to Add Parentheses
    // Divide & Conquer with recursion
    // Time Complexity: Exponential (Catalan number growth)
    // Space Complexity: Exponential (results + recursion stack)

    class LC241_DifferentWaysToAddParentheses {

        func diffWaysToCompute(_ expression: String) -> [Int] {
            return compute(expression)
        }

        private func compute(_ expr: String) -> [Int] {
            var results: [Int] = []

            // Try every operator as a split point
            for (i, char) in expr.enumerated() {
                if char == "+" || char == "-" || char == "*" {

                    let leftExpr = String(expr.prefix(i))
                    let rightExpr = String(expr.suffix(expr.count - i - 1))

                    let leftResults = compute(leftExpr)
                    let rightResults = compute(rightExpr)

                    // Combine results from left and right parts
                    for l in leftResults {
                        for r in rightResults {
                            switch char {
                            case "+":
                                results.append(l + r)
                            case "-":
                                results.append(l - r)
                            case "*":
                                results.append(l * r)
                            default:
                                break
                            }
                        }
                    }
                }
            }

            // Base case: the expression is a single number
            if results.isEmpty {
                results.append(Int(expr)!)
            }

            return results
        }
    }
    /*
     240. Search a 2D Matrix II
     Write an efficient algorithm that searches for a value target in an m x n integer matrix matrix. This matrix has the following properties:
     Integers in each row are sorted in ascending from left to right.
     Integers in each column are sorted in ascending from top to bottom.
     Example 1:
     Input: matrix = [[1,4,7,11,15],[2,5,8,12,19],[3,6,9,16,22],[10,13,14,17,24],[18,21,23,26,30]], target = 5
     Output: true
     Example 2:
     Input: matrix = [[1,4,7,11,15],[2,5,8,12,19],[3,6,9,16,22],[10,13,14,17,24],[18,21,23,26,30]], target = 20
     Output: false
     Constraints:
     m == matrix.length
     n == matrix[i].length
     1 <= n, m <= 300
     -109 <= matrix[i][j] <= 109
     All the integers in each row are sorted in ascending order.
     All the integers in each column are sorted in ascending order.
     -109 <= target <= 109
     */
    // 240. Search a 2D Matrix II
    // Time Complexity: O(m + n)
    // Space Complexity: O(1)

    class LC240_Search2DMatrixII {

        func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
            let rows = matrix.count
            let cols = matrix[0].count

            // Start from the top-right corner
            var row = 0
            var col = cols - 1

            while row < rows && col >= 0 {
                let value = matrix[row][col]

                if value == target {
                    return true
                } else if value > target {
                    // Move left if current value is too large
                    col -= 1
                } else {
                    // Move down if current value is too small
                    row += 1
                }
            }

            return false
        }
    }

    /*
     239. Sliding Window Maximum     Hard
     You are given an array of integers nums, there is a sliding window of size k which is moving from the very left of the array to the very right. You can only see the k numbers in the window. Each time the sliding window moves right by one position.
     Return the max sliding window.
     Example 1:
     Input: nums = [1,3,-1,-3,5,3,6,7], k = 3
     Output: [3,3,5,5,6,7]
     Explanation:
     Window position                Max
     ---------------               -----
     [1  3  -1] -3  5  3  6  7       3
      1 [3  -1  -3] 5  3  6  7       3
      1  3 [-1  -3  5] 3  6  7       5
      1  3  -1 [-3  5  3] 6  7       5
      1  3  -1  -3 [5  3  6] 7       6
      1  3  -1  -3  5 [3  6  7]      7
     Example 2:

     Input: nums = [1], k = 1
     Output: [1]
      

     Constraints:

     1 <= nums.length <= 105
     -104 <= nums[i] <= 104
     1 <= k <= nums.length
     */
    // 239. Sliding Window Maximum
    // Time Complexity: O(n)
    // Space Complexity: O(k)

    class LC239_SlidingWindowMaximum {

        func maxSlidingWindow(_ nums: [Int], _ k: Int) -> [Int] {
            guard !nums.isEmpty, k > 0 else { return [] }

            var deque: [Int] = []   // Stores indices
            var result: [Int] = []

            for i in 0..<nums.count {

                // Remove indices that are out of the current window
                if let first = deque.first, first <= i - k {
                    deque.removeFirst()
                }

                // Remove elements smaller than current from the back
                while let last = deque.last, nums[last] < nums[i] {
                    deque.removeLast()
                }

                // Add current index
                deque.append(i)

                // The front of the deque is the maximum of the window
                if i >= k - 1 {
                    result.append(nums[deque.first!])
                }
            }

            return result
        }
    }

    /*
     238. Product of Array Except Self
     Given an integer array nums, return an array answer such that answer[i] is equal to the product of all the elements of nums except nums[i].
     The product of any prefix or suffix of nums is guaranteed to fit in a 32-bit integer.
     You must write an algorithm that runs in O(n) time and without using the division operation.
     Example 1:
     Input: nums = [1,2,3,4]
     Output: [24,12,8,6]
     Example 2:
     Input: nums = [-1,1,0,-3,3]
     Output: [0,0,9,0,0]
     Constraints:
     2 <= nums.length <= 105
     -30 <= nums[i] <= 30
     The input is generated such that answer[i] is guaranteed to fit in a 32-bit integer.
     Follow up: Can you solve the problem in O(1) extra space complexity? (The output array does not count as extra space for space complexity analysis.)
     */
    // 238. Product of Array Except Self
    // Time Complexity: O(n)
    // Space Complexity: O(1) extra space (output array does not count)

    class LC238_ProductOfArrayExceptSelf {

        func productExceptSelf(_ nums: [Int]) -> [Int] {
            let n = nums.count
            var result = Array(repeating: 1, count: n)

            // Step 1: Calculate prefix products
            // result[i] will contain the product of all elements to the left of i
            var prefix = 1
            for i in 0..<n {
                result[i] = prefix
                prefix *= nums[i]
            }

            // Step 2: Calculate suffix products and multiply with prefix products
            // suffix holds the product of all elements to the right of i
            var suffix = 1
            for i in stride(from: n - 1, through: 0, by: -1) {
                result[i] *= suffix
                suffix *= nums[i]
            }

            return result
        }
    }

    /*
     237. Delete Node in a Linked List
     There is a singly-linked list head and we want to delete a node node in it.

     You are given the node to be deleted node. You will not be given access to the first node of head.

     All the values of the linked list are unique, and it is guaranteed that the given node node is not the last node in the linked list.

     Delete the given node. Note that by deleting the node, we do not mean removing it from memory. We mean:

     The value of the given node should not exist in the linked list.
     The number of nodes in the linked list should decrease by one.
     All the values before node should be in the same order.
     All the values after node should be in the same order.
     Custom testing:
     For the input, you should provide the entire linked list head and the node to be given node. node should not be the last node of the list and should be an actual node in the list.
     We will build the linked list and pass the node to your function.
     The output will be the entire list after calling your function.
     Example 1:
     Input: head = [4,5,1,9], node = 5
     Output: [4,1,9]
     Explanation: You are given the second node with value 5, the linked list should become 4 -> 1 -> 9 after calling your function.
     Example 2:
     Input: head = [4,5,1,9], node = 1
     Output: [4,5,9]
     Explanation: You are given the third node with value 1, the linked list should become 4 -> 5 -> 9 after calling your function.
     Constraints:
     The number of the nodes in the given list is in the range [2, 1000].
     -1000 <= Node.val <= 1000
     The value of each node in the list is unique.
     The node to be deleted is in the list and is not a tail node.
     */
    // 237. Delete Node in a Linked List
    // Time Complexity: O(1)
    // Space Complexity: O(1)

    class LC237_DeleteNodeInLinkedList {

        func deleteNode(_ node: ListNode?) {
            guard let node = node, let next = node.next else {
                return
            }

            // Copy the value from the next node
            node.val = next.val

            // Skip the next node
            node.next = next.next
        }
    }

    /*
     236. Lowest Common Ancestor of a Binary Tree
     Given a binary tree, find the lowest common ancestor (LCA) of two given nodes in the tree.
     According to the definition of LCA on Wikipedia: “The lowest common ancestor is defined between two nodes p and q as the lowest node in T that has both p and q as descendants (where we allow a node to be a descendant of itself).”
     Example 1:
     Input: root = [3,5,1,6,2,0,8,null,null,7,4], p = 5, q = 1
     Output: 3
     Explanation: The LCA of nodes 5 and 1 is 3.
     Example 2:
     Input: root = [3,5,1,6,2,0,8,null,null,7,4], p = 5, q = 4
     Output: 5
     Explanation: The LCA of nodes 5 and 4 is 5, since a node can be a descendant of itself according to the LCA definition.
     Example 3:
     Input: root = [1,2], p = 1, q = 2
     Output: 1
     Constraints:
     The number of nodes in the tree is in the range [2, 105].
     -109 <= Node.val <= 109
     */
    
    /*
     235. Lowest Common Ancestor of a Binary Search Tree
     Medium
     Topics
     premium lock icon
     Companies
     Given a binary search tree (BST), find the lowest common ancestor (LCA) node of two given nodes in the BST.
     According to the definition of LCA on Wikipedia: “The lowest common ancestor is defined between two nodes p and q as the lowest node in T that has both p and q as descendants (where we allow a node to be a descendant of itself).”
     Example 1:
     Input: root = [6,2,8,0,4,7,9,null,null,3,5], p = 2, q = 8
     Output: 6
     Explanation: The LCA of nodes 2 and 8 is 6.
     Example 2:
     Input: root = [6,2,8,0,4,7,9,null,null,3,5], p = 2, q = 4
     Output: 2
     Explanation: The LCA of nodes 2 and 4 is 2, since a node can be a descendant of itself according to the LCA definition.
     Example 3:
     Input: root = [2,1], p = 2, q = 1
     Output: 2
     */
    // 235. Lowest Common Ancestor of a Binary Search Tree
    // Time Complexity: O(h), where h is the height of the tree
    // Space Complexity: O(1)
    class LC235_LowestCommonAncestorBST {
        func lowestCommonAncestor(
            _ root: TreeNode?,
            _ p: TreeNode?,
            _ q: TreeNode?
        ) -> TreeNode? {

            var current = root

            while let node = current,
                  let pVal = p?.val,
                  let qVal = q?.val {

                // Both nodes are in the left subtree
                if pVal < node.val && qVal < node.val {
                    current = node.left
                }
                // Both nodes are in the right subtree
                else if pVal > node.val && qVal > node.val {
                    current = node.right
                }
                // Split happens here, this is the LCA
                else {
                    return node
                }
            }

            return nil
        }
    }
    /*
     233. Number of Digit One
     Given an integer n, count the total number of digit 1 appearing in all non-negative integers less than or equal to n.
     Example 1:
     Input: n = 13
     Output: 6
     Example 2:
     Input: n = 0
     Output: 0
     Constraints:
     0 <= n <= 109
     */
    // 233. Number of Digit One
    // Count the total number of digit '1' appearing in all non-negative integers <= n
    // Time: O(log n), Space: O(1)
    class LC233_NumberOfDigitOne {
        func countDigitOne(_ n: Int) -> Int {
            let n = n
            var digit = 1
            var res = 0

            while n / digit > 0 {
                let high = n / (digit * 10)
                let cur  = (n / digit) % 10
                let low  = n % digit

                if cur == 0 {
                    res += high * digit
                } else if cur == 1 {
                    res += high * digit + low + 1
                } else {
                    res += (high + 1) * digit
                }

                // move to next higher digit
                digit *= 10
            }

            return res
        }
    }

    /*
     230. Kth Smallest Element in a BST
     Given the root of a binary search tree, and an integer k, return the kth smallest value (1-indexed) of all the values of the nodes in the tree.
     Example 1:
     Input: root = [3,1,4,null,2], k = 1
     Output: 1
     Example 2:
     Input: root = [5,3,6,2,4,null,null,1], k = 3
     Output: 3
     Constraints:
     The number of nodes in the tree is n.
     1 <= k <= n <= 104
     0 <= Node.val <= 104
     Follow up: If the BST is modified often (i.e., we can do insert and delete operations) and you need to find the kth smallest frequently, how would you optimize?
     */
    // MARK: - 230. Kth Smallest Element in a BST
    class LC230_KthSmallestInBST {

        // Returns the k-th smallest element (1-indexed)
        func kthSmallest(_ root: TreeNode?, _ k: Int) -> Int {
            var k = k
            var result = 0

            func inorder(_ node: TreeNode?) {
                guard let node = node, k > 0 else { return }

                inorder(node.left)

                k -= 1
                if k == 0 {
                    result = node.val
                    return
                }

                inorder(node.right)
            }

            inorder(root)
            return result
        }
    }
    /*
     229. Majority Element II
     Given an integer array of size n, find all elements that appear more than ⌊ n/3 ⌋ times.
Example 1:
     Input: nums = [3,2,3]
     Output: [3]
     Example 2:
     Input: nums = [1]
     Output: [1]
     Example 3:
     Input: nums = [1,2]
     Output: [1,2]
     Constraints:
     1 <= nums.length <= 5 * 104
     -109 <= nums[i] <= 109
     Follow up: Could you solve the problem in linear time and in O(1) space?
     */
    // 229. Majority Element II
    // This solution uses the Boyer–Moore majority vote algorithm extended to two candidates.
    // Time: O(n), Space: O(1)

    class LC229_MajorityElementII {
        func majorityElement(_ nums: [Int]) -> [Int] {
            var candidate1: Int? = nil
            var candidate2: Int? = nil
            var count1 = 0
            var count2 = 0

            // First pass: find potential candidates
            for num in nums {
                if let c1 = candidate1, c1 == num {
                    count1 += 1
                } else if let c2 = candidate2, c2 == num {
                    count2 += 1
                } else if count1 == 0 {
                    candidate1 = num
                    count1 = 1
                } else if count2 == 0 {
                    candidate2 = num
                    count2 = 1
                } else {
                    count1 -= 1
                    count2 -= 1
                }
            }

            // Second pass: verify the candidates
            count1 = 0
            count2 = 0

            for num in nums {
                if num == candidate1 { count1 += 1 }
                else if num == candidate2 { count2 += 1 }
            }

            // Check if they exceed n/3 threshold
            let threshold = nums.count / 3
            var result = [Int]()

            if let c1 = candidate1, count1 > threshold {
                result.append(c1)
            }
            if let c2 = candidate2, count2 > threshold {
                result.append(c2)
            }

            return result
        }
    }

    /*
     228. Summary Ranges
     You are given a sorted unique integer array nums.
     A range [a,b] is the set of all integers from a to b (inclusive).
     Return the smallest sorted list of ranges that cover all the numbers in the array exactly. That is, each element of nums is covered by exactly one of the ranges, and there is no integer x such that x is in one of the ranges but not in nums.
     Each range [a,b] in the list should be output as:
     "a->b" if a != b
     "a" if a == b
     Example 1:
     Input: nums = [0,1,2,4,5,7]
     Output: ["0->2","4->5","7"]
     Explanation: The ranges are:
     [0,2] --> "0->2"
     [4,5] --> "4->5"
     [7,7] --> "7"
     Example 2:
     Input: nums = [0,2,3,4,6,8,9]
     Output: ["0","2->4","6","8->9"]
     Explanation: The ranges are:
     [0,0] --> "0"
     [2,4] --> "2->4"
     [6,6] --> "6"
     [8,9] --> "8->9"
     */
    func summaryRanges228(_ nums: [Int]) -> [String] {
            guard !nums.isEmpty else { return [] }

            var res = [String]()
            var start = nums[0]

            for i in 1..<nums.count {
                // проверяем разрыв последовательности
                if nums[i] != nums[i - 1] + 1 {
                    if start == nums[i - 1] {
                        res.append("\(start)")
                    } else {
                        res.append("\(start)->\(nums[i - 1])")
                    }
                    start = nums[i]
                }
            }

            // записываем последний диапазон
            if start == nums.last! {
                res.append("\(start)")
            } else {
                res.append("\(start)->\(nums.last!)")
            }

            return res
        }
    /*
     227. Basic Calculator II
     Given a string s which represents an expression, evaluate this expression and return its value.
     The integer division should truncate toward zero.
     You may assume that the given expression is always valid. All intermediate results will be in the range of [-231, 231 - 1].
     Note: You are not allowed to use any built-in function which evaluates strings as mathematical expressions, such as eval().
     Example 1:
     Input: s = "3+2*2"
     Output: 7
     Example 2:
     Input: s = " 3/2 "
     Output: 1
     Example 3:
     Input: s = " 3+5 / 2 "
     Output: 5
     Constraints:
     1 <= s.length <= 3 * 105
     s consists of integers and operators ('+', '-', '*', '/') separated by some number of spaces.
     s represents a valid expression.
     All the integers in the expression are non-negative integers in the range [0, 231 - 1].
     The answer is guaranteed to fit in a 32-bit integer.
     */
    func calculate227(_ s: String) -> Int {
            var num = 0
            var lastOp: Character = "+"
            var stack = [Int]()
            let chars = Array(s)
            
            for i in 0..<chars.count {
                let ch = chars[i]
                
                if let d = ch.wholeNumberValue {
                    num = num * 10 + d
                }
                
                if (!ch.isNumber && ch != " ") || i == chars.count - 1 {
                    switch lastOp {
                    case "+":
                        stack.append(num)
                    case "-":
                        stack.append(-num)
                    case "*":
                        stack.append(stack.removeLast() * num)
                    case "/":
                        stack.append(stack.removeLast() / num)
                    default:
                        break
                    }
                    
                    lastOp = ch
                    num = 0
                }
            }
            
            return stack.reduce(0, +)
        }
    /*
     226. Invert Binary Tree
     Given the root of a binary tree, invert the tree, and return its root.
     Example 1:
     Input: root = [4,2,7,1,3,6,9]
     Output: [4,7,2,9,6,3,1]
     Example 2:
     Input: root = [2,1,3]
     Output: [2,3,1]
     Example 3:
     Input: root = []
     Output: []
     Constraints:
     The number of nodes in the tree is in the range [0, 100].
     -100 <= Node.val <= 100
     */
    /// LeetCode 226. Invert Binary Tree
    /// Recursively swaps left and right children for each node
    class Solution226InvertBinaryTree {

        /// Binary tree node
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

        /// Inverts the binary tree and returns the root
        func invertTree(_ root: TreeNode?) -> TreeNode? {
            guard let node = root else {
                return nil
            }

            // swap left and right children
            let temp = node.left
            node.left = node.right
            node.right = temp

            // recursively invert subtrees
            _ = invertTree(node.left)
            _ = invertTree(node.right)

            return node
        }
    }

    /*
     225. Implement Stack using Queues
     Implement a last-in-first-out (LIFO) stack using only two queues. The implemented stack should support all the functions of a normal stack (push, top, pop, and empty).
     Implement the MyStack class:
     void push(int x) Pushes element x to the top of the stack.
     int pop() Removes the element on the top of the stack and returns it.
     int top() Returns the element on the top of the stack.
     boolean empty() Returns true if the stack is empty, false otherwise.
     Notes:
     You must use only standard operations of a queue, which means that only push to back, peek/pop from front, size and is empty operations are valid.
     Depending on your language, the queue may not be supported natively. You may simulate a queue using a list or deque (double-ended queue) as long as you use only a queue's standard operations.
     Example 1:
     Input
     ["MyStack", "push", "push", "top", "pop", "empty"]
     [[], [1], [2], [], [], []]
     Output
     [null, null, null, 2, 2, false]
     Explanation
     MyStack myStack = new MyStack();
     myStack.push(1);
     myStack.push(2);
     myStack.top(); // return 2
     myStack.pop(); // return 2
     myStack.empty(); // return False
     */
    /// LeetCode 225. Implement Stack using Queues
    /// Two-queue implementation
    class Solution225MyStack {

        private var q1: [Int] = []  // main queue
        private var q2: [Int] = []  // helper queue

        /// Push element x to top of stack
        func push(_ x: Int) {
            // Step 1: enqueue new element to q2
            q2.append(x)

            // Step 2: move everything from q1 to q2
            while !q1.isEmpty {
                q2.append(q1.removeFirst())
            }

            // Step 3: swap queues
            let temp = q1
            q1 = q2
            q2 = temp
            q2.removeAll()
        }

        /// Removes top element and returns it
        func pop() -> Int {
            return q1.removeFirst()
        }

        /// Returns top element without removing it
        func top() -> Int {
            return q1.first!
        }

        /// Returns whether stack is empty
        func empty() -> Bool {
            return q1.isEmpty
        }
    }

    /*
     224. Basic Calculator
     Given a string s representing a valid expression, implement a basic calculator to evaluate it, and return the result of the evaluation.
     Note: You are not allowed to use any built-in function which evaluates strings as mathematical expressions, such as eval().
     Example 1:
     Input: s = "1 + 1"
     Output: 2
     Example 2:
     Input: s = " 2-1 + 2 "
     Output: 3
     Example 3:
     Input: s = "(1+(4+5+2)-3)+(6+8)"
     Output: 23
     Constraints:
     1 <= s.length <= 3 * 105
     s consists of digits, '+', '-', '(', ')', and ' '.
     s represents a valid expression.
     '+' is not used as a unary operation (i.e., "+1" and "+(2 + 3)" is invalid).
     '-' could be used as a unary operation (i.e., "-1" and "-(2 + 3)" is valid).
     There will be no two consecutive operators in the input.
     Every number and running calculation will fit in a signed 32-bit integer.
     */
    class Solution224BasicCalculator {
        func calculate(_ s: String) -> Int {
            var result = 0                  // global result
            var currentNumber = 0           // number being parsed
            var sign = 1                    // current sign (+1 or -1)
            var stack: [Int] = []           // stack for previous results and signs
            
            let chars = Array(s)
            var i = 0
            
            while i < chars.count {
                let c = chars[i]
                
                if let digit = c.wholeNumberValue {
                    // Build the current number
                    currentNumber = currentNumber * 10 + digit
                }
                else if c == "+" {
                    // Add previous number and reset
                    result += sign * currentNumber
                    currentNumber = 0
                    sign = 1
                }
                else if c == "-" {
                    // Add previous number and reset
                    result += sign * currentNumber
                    currentNumber = 0
                    sign = -1
                }
                else if c == "(" {
                    // Push current result and sign onto the stack
                    stack.append(result)
                    stack.append(sign)
                    
                    // Reset for inside parentheses
                    result = 0
                    sign = 1
                }
                else if c == ")" {
                    // Complete the number before ')'
                    result += sign * currentNumber
                    currentNumber = 0
                    
                    // Pop sign and previous result
                    let prevSign = stack.removeLast()
                    let prevResult = stack.removeLast()
                    
                    // Combine
                    result = prevResult + prevSign * result
                }
                
                // Ignore spaces
                i += 1
            }
            
            return result + sign * currentNumber
        }
    }

    /*
     223. Rectangle Area
     Given the coordinates of two rectilinear rectangles in a 2D plane, return the total area covered by the two rectangles.
     The first rectangle is defined by its bottom-left corner (ax1, ay1) and its top-right corner (ax2, ay2).
     The second rectangle is defined by its bottom-left corner (bx1, by1) and its top-right corner (bx2, by2).
     Example 1:
     Rectangle Area
     Input: ax1 = -3, ay1 = 0, ax2 = 3, ay2 = 4, bx1 = 0, by1 = -1, bx2 = 9, by2 = 2
     Output: 45
     Example 2:
     Input: ax1 = -2, ay1 = -2, ax2 = 2, ay2 = 2, bx1 = -2, by1 = -2, bx2 = 2, by2 = 2
     Output: 16
     Constraints:
     -104 <= ax1 <= ax2 <= 104
     -104 <= ay1 <= ay2 <= 104
     -104 <= bx1 <= bx2 <= 104
     -104 <= by1 <= by2 <= 104
     */
    class Solution223RectangleArea {
        func computeArea(
            _ ax1: Int, _ ay1: Int, _ ax2: Int, _ ay2: Int,
            _ bx1: Int, _ by1: Int, _ bx2: Int, _ by2: Int
        ) -> Int {
            
            // Area of rectangle A
            let areaA = (ax2 - ax1) * (ay2 - ay1)
            
            // Area of rectangle B
            let areaB = (bx2 - bx1) * (by2 - by1)
            
            // Compute overlap width and height
            let overlapWidth  = max(0, min(ax2, bx2) - max(ax1, bx1))
            let overlapHeight = max(0, min(ay2, by2) - max(ay1, by1))
            
            // Overlapping area (0 if rectangles don't touch)
            let overlapArea = overlapWidth * overlapHeight
            
            return areaA + areaB - overlapArea
        }
    }

    /*
     222. Count Complete Tree Nodes
     Given the root of a complete binary tree, return the number of the nodes in the tree.
     According to Wikipedia, every level, except possibly the last, is completely filled in a complete binary tree, and all nodes in the last level are as far left as possible. It can have between 1 and 2h nodes inclusive at the last level h.
     Design an algorithm that runs in less than O(n) time complexity.
     Example 1:
     Input: root = [1,2,3,4,5,6]
     Output: 6
     Example 2:
     Input: root = []
     Output: 0
     Example 3:
     Input: root = [1]
     Output: 1
     Constraints:
     The number of nodes in the tree is in the range [0, 5 * 104].
     0 <= Node.val <= 5 * 104
     The tree is guaranteed to be complete.
     */
    /**
     * Definition for a binary tree node.
     * public class TreeNode {
     *     public var val: Int
     *     public var left: TreeNode?
     *     public var right: TreeNode?
     *     public init() { self.val = 0; self.left = nil; self.right = nil; }
     *     public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
     *     public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
     *         self.val = val
     *         self.left = left
     *         self.right = right
     *     }
     * }
     */

    class Solution222 {

        // Main function
        // Counts nodes in a complete binary tree in O(log^2 n)
        func countNodes(_ root: TreeNode?) -> Int {
            guard let root = root else { return 0 }
            
            // Compute leftmost and rightmost heights
            let leftHeight = getLeftHeight(root)
            let rightHeight = getRightHeight(root)
            
            // If equal → perfect binary tree → use formula
            if leftHeight == rightHeight {
                return (1 << leftHeight) - 1
            }
            
            // Otherwise recursively count both subtrees
            return 1 + countNodes(root.left) + countNodes(root.right)
        }
        
        // Returns the height following only left children
        private func getLeftHeight(_ node: TreeNode?) -> Int {
            var height = 0
            var curr = node
            while curr != nil {
                height += 1
                curr = curr?.left
            }
            return height
        }
        
        // Returns the height following only right children
        private func getRightHeight(_ node: TreeNode?) -> Int {
            var height = 0
            var curr = node
            while curr != nil {
                height += 1
                curr = curr?.right
            }
            return height
        }
    }
    /*
     221. Maximal Square
     Given an m x n binary matrix filled with 0's and 1's, find the largest square containing only 1's and return its area.
     Example 1:
     Input: matrix = [["1","0","1","0","0"],["1","0","1","1","1"],["1","1","1","1","1"],["1","0","0","1","0"]]
     Output: 4
     Example 2:
     Input: matrix = [["0","1"],["1","0"]]
     Output: 1
     Example 3:
     Input: matrix = [["0"]]
     Output: 0
     */
    // 221. Maximal Square
    // Dynamic Programming, O(m*n) time, O(m*n) space

    class Solution221 {
        func maximalSquare(_ matrix: [[Character]]) -> Int {
            guard !matrix.isEmpty else { return 0 }
            let m = matrix.count
            let n = matrix[0].count
            var dp = Array(repeating: Array(repeating: 0, count: n), count: m)
            var maxSide = 0
            
            for i in 0..<m {
                for j in 0..<n {
                    if matrix[i][j] == "1" {
                        if i == 0 || j == 0 {
                            dp[i][j] = 1  // first row or column
                        } else {
                            // min of top, left, and top-left + 1
                            dp[i][j] = min(dp[i-1][j], dp[i][j-1], dp[i-1][j-1]) + 1
                        }
                        maxSide = max(maxSide, dp[i][j])
                    }
                }
            }
            
            return maxSide * maxSide
        }
    }

    /*
     220. Contains Duplicate III
     Hard
     You are given an integer array nums and two integers indexDiff and valueDiff.
     Find a pair of indices (i, j) such that:
     i != j,
     abs(i - j) <= indexDiff.
     abs(nums[i] - nums[j]) <= valueDiff, and
     Return true if such pair exists or false otherwise.
     Example 1:
     Input: nums = [1,2,3,1], indexDiff = 3, valueDiff = 0
     Output: true
     Explanation: We can choose (i, j) = (0, 3).
     We satisfy the three conditions:
     i != j --> 0 != 3
     abs(i - j) <= indexDiff --> abs(0 - 3) <= 3
     abs(nums[i] - nums[j]) <= valueDiff --> abs(1 - 1) <= 0
     Example 2:
     Input: nums = [1,5,9,1,5,9], indexDiff = 2, valueDiff = 3
     Output: false
     Explanation: After trying all the possible pairs (i, j), we cannot satisfy the three conditions, so we return false.
     */
    class Solution220 {

        // ============================================================
        // METHOD 1 — BUCKET HASHING  (BEST PERFORMANCE)
        // Time:   O(n)
        // Memory: O(n)
        //
        // Idea:
        // • Each number is placed into a "bucket" based on valueDiff.
        // • If two values fall into the same bucket -> difference <= valueDiff.
        // • We also check two neighbor buckets because values there may be close enough.
        // • Maintain sliding window of size indexDiff by removing old buckets.
        // ============================================================
        /* ============================================================
         COMPARISON SUMMARY

         | Method                           | Time        | Memory | Notes                             |
         |----------------------------------|-------------|--------|-----------------------------------|
         | Bucket Hashing                   | O(n)        | O(n)   | Fastest, best for large inputs    |
         | TreeSet (Sorted window + BS)     | O(n log n)  | O(n)   | Simpler logic, but slower         |

         Recommended solution → Bucket Hashing (Method 1)
         ============================================================ */


        func containsNearbyAlmostDuplicate_Bucket(_ nums: [Int], _ indexDiff: Int, _ valueDiff: Int) -> Bool {
            if valueDiff < 0 { return false } // impossible to satisfy
            
            var buckets = [Int: Int]()
            let width = valueDiff + 1 // bucket size
            
            for (i, num) in nums.enumerated() {
                let bucketID = num / width
                
                // 1) If bucket already contains a value → abs <= valueDiff → success
                if buckets[bucketID] != nil {
                    return true
                }
                
                // 2) Check left and right neighboring buckets
                if let left = buckets[bucketID - 1], abs(left - num) <= valueDiff { return true }
                if let right = buckets[bucketID + 1], abs(right - num) <= valueDiff { return true }

                // Insert into bucket
                buckets[bucketID] = num
                
                // Maintain sliding window size <= indexDiff
                if i >= indexDiff {
                    let oldBucketID = nums[i - indexDiff] / width
                    buckets.removeValue(forKey: oldBucketID)
                }
            }
            return false
        }


        // ============================================================
        // METHOD 2 — SORTED WINDOW + BINARY SEARCH (TREESET ANALOG)
        // Time:   O(n log n)
        // Memory: O(n)
        //
        // Idea:
        // • Keep an ordered window of at most indexDiff elements.
        // • For each new number, binary-search closest neighbors.
        // • If neighbor differs by <= valueDiff → true.
        // • Remove old values to keep window size valid.
        // ============================================================
        
        func containsNearbyAlmostDuplicate_TreeSet(_ nums: [Int], _ indexDiff: Int, _ valueDiff: Int) -> Bool {
            var window = [Int]() // sorted sliding window

            for i in 0..<nums.count {
                let num = nums[i]
                let pos = window.binarySearch(num) // position if inserted
                
                // Check right neighbor
                if pos < window.count && abs(window[pos] - num) <= valueDiff { return true }
                // Check left neighbor
                if pos > 0 && abs(window[pos - 1] - num) <= valueDiff { return true }

                // Insert current number into sorted array
                window.insert(num, at: pos)

                // Restrict window size to indexDiff
                if i >= indexDiff {
                    let removePos = window.binarySearch(nums[i - indexDiff])
                    window.remove(at: removePos)
                }
            }
            return false
        }
    }
    
    /*
     219. Contains Duplicate II
     Given an integer array nums and an integer k, return true if there are two distinct indices i and j in the array such that nums[i] == nums[j] and abs(i - j) <= k.
     Example 1:
     Input: nums = [1,2,3,1], k = 3
     Output: true
     Example 2:
     Input: nums = [1,0,1,1], k = 1
     Output: true
     Example 3:
     Input: nums = [1,2,3,1,2,3], k = 2
     Output: false
     Constraints:
     1 <= nums.length <= 105
     -109 <= nums[i] <= 109
     0 <= k <= 105
     */
    // 219. Contains Duplicate II
    // Sliding window + Set, O(n) time, O(k) memory

    class Solution219 {
        func containsNearbyDuplicate(_ nums: [Int], _ k: Int) -> Bool {
            var window = Set<Int>()   // stores last k numbers
            
            for i in 0..<nums.count {
                
                // If we see a number already in window -> duplicate within k distance
                if window.contains(nums[i]) {
                    return true
                }
                
                window.insert(nums[i])
                
                // Maintain window size ≤ k
                if window.count > k {
                    window.remove(nums[i - k])
                }
            }
            
            return false
        }
    }

    /*
     218. The Skyline Problem
     A city's skyline is the outer contour of the silhouette formed by all the buildings in that city when viewed from a distance. Given the locations and heights of all the buildings, return the skyline formed by these buildings collectively.

     The geometric information of each building is given in the array buildings where buildings[i] = [lefti, righti, heighti]:

     lefti is the x coordinate of the left edge of the ith building.
     righti is the x coordinate of the right edge of the ith building.
     heighti is the height of the ith building.
     You may assume all buildings are perfect rectangles grounded on an absolutely flat surface at height 0.

     The skyline should be represented as a list of "key points" sorted by their x-coordinate in the form [[x1,y1],[x2,y2],...]. Each key point is the left endpoint of some horizontal segment in the skyline except the last point in the list, which always has a y-coordinate 0 and is used to mark the skyline's termination where the rightmost building ends. Any ground between the leftmost and rightmost buildings should be part of the skyline's contour.

     Note: There must be no consecutive horizontal lines of equal height in the output skyline. For instance, [...,[2 3],[4 5],[7 5],[11 5],[12 7],...] is not acceptable; the three lines of height 5 should be merged into one in the final output as such: [...,[2 3],[4 5],[12 7],...]
     Example 1:
     Input: buildings = [[2,9,10],[3,7,15],[5,12,12],[15,20,10],[19,24,8]]
     Output: [[2,10],[3,15],[7,12],[12,0],[15,10],[20,8],[24,0]]
     Explanation:
     Figure A shows the buildings of the input.
     Figure B shows the skyline formed by those buildings. The red points in figure B represent the key points in the output list.
     Example 2:

     Input: buildings = [[0,2,3],[2,5,3]]
     Output: [[0,3],[5,0]]
      

     Constraints:

     1 <= buildings.length <= 104
     0 <= lefti < righti <= 231 - 1
     1 <= heighti <= 231 - 1
     buildings is sorted by lefti in non-decreasing order.
     */
    // 218. The Skyline Problem
    // Sweep line + max heap approach

    class Solution218 {
        func getSkyline(_ buildings: [[Int]]) -> [[Int]] {
            // List of events: (x, height), entering positive height, leaving negative
            var events = [(Int, Int)]()
            for b in buildings {
                let left = b[0], right = b[1], height = b[2]
                events.append((left, height))     // building enters
                events.append((right, -height))   // building leaves
            }
            
            // Sort events:
            // 1) by x increasing
            // 2) entering (positive) higher height first
            // 3) leaving (negative) lower height first
            events.sort {
                if $0.0 == $1.0 {
                    return $0.1 > $1.1   // higher enter first OR lower exit first
                }
                return $0.0 < $1.0
            }
            
            // Max-heap simulated by a dictionary counting heights
            var heightCount = [Int:Int]()     // height -> frequency in active set
            var maxHeight = 0
            var result = [[Int]]()
            
            func addHeight(_ h: Int) {
                heightCount[h, default: 0] += 1
            }
            
            func removeHeight(_ h: Int) {
                if let cnt = heightCount[h] {
                    if cnt == 1 { heightCount.removeValue(forKey: h) }
                    else { heightCount[h] = cnt - 1 }
                }
            }
            
            func currentMaxHeight() -> Int {
                return heightCount.keys.max() ?? 0
            }
            
            // Sweep line
            for (x, h) in events {
                if h > 0 {             // entering building
                    addHeight(h)
                } else {               // leaving building
                    removeHeight(-h)
                }
                
                let newMax = currentMaxHeight()
                
                // If skyline height changed -> record key point
                if newMax != maxHeight {
                    result.append([x, newMax])
                    maxHeight = newMax
                }
            }
            
            return result
        }
    }

    /*
     216. Combination Sum III
     Find all valid combinations of k numbers that sum up to n such that the following conditions are true:
     Only numbers 1 through 9 are used.
     Each number is used at most once.
     Return a list of all possible valid combinations. The list must not contain the same combination twice, and the combinations may be returned in any order.
     Example 1:
     Input: k = 3, n = 7
     Output: [[1,2,4]]
     Explanation:
     1 + 2 + 4 = 7
     There are no other valid combinations.
     Example 2:
     Input: k = 3, n = 9
     Output: [[1,2,6],[1,3,5],[2,3,4]]
     Explanation:
     1 + 2 + 6 = 9
     1 + 3 + 5 = 9
     2 + 3 + 4 = 9
     There are no other valid combinations.
     Example 3:
     Input: k = 4, n = 1
     Output: []
     Explanation: There are no valid combinations.
     Using 4 different numbers in the range [1,9], the smallest sum we can get is 1+2+3+4 = 10 and since 10 > 1, there are no valid combination.
     Constraints:
     2 <= k <= 9
     1 <= n <= 60
     */
    class Solution216CombinationSumIII {
        func combinationSum3(_ k: Int, _ n: Int) -> [[Int]] {
            var result: [[Int]] = []
            var current: [Int] = []

            func backtrack(_ start: Int, _ remainingK: Int, _ remainingSum: Int) {
                // If k numbers chosen & sum reached → store solution
                if remainingK == 0 && remainingSum == 0 {
                    result.append(current)
                    return
                }
                // If impossible to continue → prune early
                if remainingK < 0 || remainingSum < 0 { return }

                // Choose next candidate from 1...9 without repetition
                for num in start...9 {
                    current.append(num)
                    backtrack(num + 1, remainingK - 1, remainingSum - num)
                    current.removeLast()  // backtrack step
                }
            }

            backtrack(1, k, n)
            return result
        }
    }

    /*
     215. Kth Largest Element in an Array
     Given an integer array nums and an integer k, return the kth largest element in the array.
     Note that it is the kth largest element in the sorted order, not the kth distinct element.
     Can you solve it without sorting?
     Example 1:
     Input: nums = [3,2,1,5,6,4], k = 2
     Output: 5
     Example 2:
     Input: nums = [3,2,3,1,2,4,5,5,6], k = 4
     Output: 4
     Constraints:
     1 <= k <= nums.length <= 105
     -104 <= nums[i] <= 104
     */
    class Solution215KthLargest {
        // Returns the k-th largest element in the array
        func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
            var arr = nums                 // mutable copy
            let target = arr.count - k     // convert: kth largest → index if sorted ascending
            
            return quickSelect(&arr, 0, arr.count - 1, target)
        }
        
        // QuickSelect partition-based search
        private func quickSelect(_ arr: inout [Int], _ left: Int, _ right: Int, _ target: Int) -> Int {
            var l = left
            var r = right
            
            while l <= r {
                let pivotIndex = partition(&arr, l, r)
                
                if pivotIndex == target {       // found answer
                    return arr[pivotIndex]
                } else if pivotIndex < target { // search right side
                    l = pivotIndex + 1
                } else {                        // search left side
                    r = pivotIndex - 1
                }
            }
            return -1  // unreachable if k valid
        }
        
        // Partition: elements < pivot → left, > pivot → right
        private func partition(_ arr: inout [Int], _ left: Int, _ right: Int) -> Int {
            let pivot = arr[right]
            var i = left
            
            for j in left..<right {
                if arr[j] <= pivot {            // place <= pivot to the left part
                    arr.swapAt(i, j)
                    i += 1
                }
            }
            arr.swapAt(i, right)                // place pivot into its correct location
            return i
        }
    }

    /*
     214. Shortest Palindrome
     You are given a string s. You can convert s to a palindrome by adding characters in front of it.
     Return the shortest palindrome you can find by performing this transformation.
     Example 1:
     Input: s = "aacecaaa"
     Output: "aaacecaaa"
     Example 2:
     Input: s = "abcd"
     Output: "dcbabcd"
     Constraints:
     0 <= s.length <= 5 * 104
     s consists of lowercase English letters only.
     */
    class Solution214ShortestPalindrome {
        // Returns shortest palindrome by adding chars in front of string
        func shortestPalindrome(_ s: String) -> String {
            if s.isEmpty { return s }  // Edge-case: empty string
            
            let rev = String(s.reversed())
            // Create combined string: original + "#" + reversed
            // "#" is a separator so KMP does not connect mismatched segments
            let combined = s + "#" + rev
            
            // Build LPS (longest prefix-suffix) array for KMP pattern
            var lps = Array(repeating: 0, count: combined.count)
            let arr = Array(combined)
            
            // Classic KMP prefix-function computation
            var i = 1, length = 0
            while i < arr.count {
                if arr[i] == arr[length] {
                    length += 1
                    lps[i] = length
                    i += 1
                } else {
                    if length > 0 {
                        length = lps[length - 1]   // fallback
                    } else {
                        lps[i] = 0
                        i += 1
                    }
                }
            }

            // lps.last gives the longest palindromic prefix length in s
            // We must prepend the reverse of remaining suffix
            let prefixLength = lps.last!
            let suffix = rev.dropFirst(prefixLength)

            return String(suffix) + s
        }
    }
    /*
     213. House Robber II
     You are a professional robber planning to rob houses along a street. Each house has a certain amount of money stashed. All houses at this place are arranged in a circle. That means the first house is the neighbor of the last one. Meanwhile, adjacent houses have a security system connected, and it will automatically contact the police if two adjacent houses were broken into on the same night.

     Given an integer array nums representing the amount of money of each house, return the maximum amount of money you can rob tonight without alerting the police.

      

     Example 1:

     Input: nums = [2,3,2]
     Output: 3
     Explanation: You cannot rob house 1 (money = 2) and then rob house 3 (money = 2), because they are adjacent houses.
     Example 2:

     Input: nums = [1,2,3,1]
     Output: 4
     Explanation: Rob house 1 (money = 1) and then rob house 3 (money = 3).
     Total amount you can rob = 1 + 3 = 4.
     Example 3:

     Input: nums = [1,2,3]
     Output: 3
      

     Constraints:

     1 <= nums.length <= 100
     0 <= nums[i] <= 1000
     */
    class Solution213 {
        // Main function: rob houses arranged in a circle
        func rob(_ nums: [Int]) -> Int {
            // If there is only one house, return its value
            if nums.count == 1 {
                return nums[0]
            }
            
            // Case 1: Rob houses from index 0 to n-2
            let case1 = robLinear(Array(nums[0..<nums.count - 1]))
            // Case 2: Rob houses from index 1 to n-1
            let case2 = robLinear(Array(nums[1..<nums.count]))
            
            return max(case1, case2)
        }
        
        // Classic House Robber (linear version, LeetCode 198)
        private func robLinear(_ arr: [Int]) -> Int {
            var prev = 0   // max amount robbed up to previous house
            var curr = 0   // max amount robbed up to current house
            
            for money in arr {
                // Either skip this house or rob it
                let newCurr = max(curr, prev + money)
                prev = curr
                curr = newCurr
            }
            
            return curr
        }
    }
    /*
     212. Word Search II
     Hard

     Given an m x n board of characters and a list of strings words, return all words on the board.

     Each word must be constructed from letters of sequentially adjacent cells, where adjacent cells are horizontally or vertically neighboring. The same letter cell may not be used more than once in a word.
     Example 1:
     Input: board = [["o","a","a","n"],["e","t","a","e"],["i","h","k","r"],["i","f","l","v"]], words = ["oath","pea","eat","rain"]
     Output: ["eat","oath"]
     Example 2:
     Input: board = [["a","b"],["c","d"]], words = ["abcb"]
     Output: []
     Constraiѕnts:
     m == board.length
     n == board[i].length
     1 <= m, n <= 12
     board[i][j] is a lowercase English letter.
     1 <= words.length <= 3 * 104
     1 <= words[i].length <= 10
     words[i] consists of lowercase English letters.
     All the strings of words are unique.
     */
    // Trie node for storing children and a full word when the path forms one
    class TrieNode212 {
        // 26 lowercase English letters
        var children = Array<TrieNode212?>(repeating: nil, count: 26)
        
        // Holds the complete word when the end of a valid inserted word is reached
        var word: String? = nil
    }

    // Trie structure for fast prefix lookup
    class Trie212 {
        let root = TrieNode212()

        // Inserts a word into the Trie
        func insert(_ word: String) {
            var node = root
            for ch in word {
                let idx = Int(ch.asciiValue! - Character("a").asciiValue!)
                if node.children[idx] == nil {
                    node.children[idx] = TrieNode212()
                }
                node = node.children[idx]!
            }
            node.word = word    // Mark the end of a valid word
        }
    }

    class WordSearch212 {

        // Main function: returns all words from `words` that appear in the board
        func findWords(_ board: [[Character]], _ words: [String]) -> [String] {
            let trie = Trie212()

            // Build Trie from all words
            for w in words { trie.insert(w) }

            var result = Set<String>()
            var board = board
            let m = board.count
            let n = board[0].count

            // Start DFS from every cell
            for i in 0..<m {
                for j in 0..<n {
                    dfs(&board, i, j, trie.root, &result)
                }
            }

            return Array(result)
        }

        // DFS search that walks the board following Trie prefixes
        private func dfs(
            _ board: inout [[Character]],
            _ i: Int,
            _ j: Int,
            _ node: TrieNode212,
            _ result: inout Set<String>
        ) {
            let m = board.count
            let n = board[0].count

            // Out of bounds check
            if i < 0 || j < 0 || i >= m || j >= n { return }

            let ch = board[i][j]

            // Cell already visited (marked as '#')
            if ch == "#" { return }

            // Convert character to Trie index
            let idx = Int(ch.asciiValue! - Character("a").asciiValue!)

            // No matching prefix in Trie → stop search
            guard let next = node.children[idx] else { return }

            // If this path forms a complete word → add to result
            if let word = next.word {
                result.insert(word)
                next.word = nil   // Optimization: remove to avoid duplicates
            }

            // Mark current cell as visited
            board[i][j] = "#"

            // Explore neighbors (4-directional)
            dfs(&board, i + 1, j, next, &result)
            dfs(&board, i - 1, j, next, &result)
            dfs(&board, i, j + 1, next, &result)
            dfs(&board, i, j - 1, next, &result)

            // Restore original character after DFS
            board[i][j] = ch
        }
    }
    /*
     211. Design Add and Search Words Data Structure
     Design a data structure that supports adding new words and finding if a string matches any previously added string.
     Implement the WordDictionary class:
     WordDictionary() Initializes the object.
     void addWord(word) Adds word to the data structure, it can be matched later.
     bool search(word) Returns true if there is any string in the data structure that matches word or false otherwise. word may contain dots '.' where dots can be matched with any letter.
     Example:
     Input
     ["WordDictionary","addWord","addWord","addWord","search","search","search","search"]
     [[],["bad"],["dad"],["mad"],["pad"],["bad"],[".ad"],["b.."]]
     Output
     [null,null,null,null,false,true,true,true]
     Explanation
     WordDictionary wordDictionary = new WordDictionary();
     wordDictionary.addWord("bad");
     wordDictionary.addWord("dad");
     wordDictionary.addWord("mad");
     wordDictionary.search("pad"); // return False
     wordDictionary.search("bad"); // return True
     wordDictionary.search(".ad"); // return True
     wordDictionary.search("b.."); // return True
     Constraints:
     1 <= word.length <= 25
     word in addWord consists of lowercase English letters.
     word in search consist of '.' or lowercase English letters.
     There will be at most 2 dots in word for search queries.
     At most 104 calls will be made to addWord and search.
     */
    class WordDictionary211 {

        class TrieNode211 {
            var children = Array<TrieNode211?>(repeating: nil, count: 26)
            var isEnd = false
        }

        private let root = TrieNode211()

        init() {}

        func addWord(_ word: String) {
            var node = root
            for ch in word {
                let idx = Int(ch.asciiValue! - Character("a").asciiValue!)
                if node.children[idx] == nil {
                    node.children[idx] = TrieNode211()
                }
                node = node.children[idx]!
            }
            node.isEnd = true
        }

        func search(_ word: String) -> Bool {
            let chars = Array(word)
            return dfs(chars, 0, root)
        }

        private func dfs(_ chars: [Character], _ index: Int, _ node: TrieNode211?) -> Bool {
            guard let node = node else { return false }

            if index == chars.count {
                return node.isEnd
            }

            let ch = chars[index]

            if ch == "." {
                // try every child
                for child in node.children {
                    if dfs(chars, index + 1, child) {
                        return true
                    }
                }
                return false
            } else {
                let idx = Int(ch.asciiValue! - Character("a").asciiValue!)
                return dfs(chars, index + 1, node.children[idx])
            }
        }
    }

    /*
     210. Course Schedule II
     Medium
     Topics
     premium lock icon
     Companies
     Hint
     There are a total of numCourses courses you have to take, labeled from 0 to numCourses - 1. You are given an array prerequisites where prerequisites[i] = [ai, bi] indicates that you must take course bi first if you want to take course ai.

     For example, the pair [0, 1], indicates that to take course 0 you have to first take course 1.
     Return the ordering of courses you should take to finish all courses. If there are many valid answers, return any of them. If it is impossible to finish all courses, return an empty array.
     Example 1:
     Input: numCourses = 2, prerequisites = [[1,0]]
     Output: [0,1]
     Explanation: There are a total of 2 courses to take. To take course 1 you should have finished course 0. So the correct course order is [0,1].
     Example 2:
     Input: numCourses = 4, prerequisites = [[1,0],[2,0],[3,1],[3,2]]
     Output: [0,2,1,3]
     Explanation: There are a total of 4 courses to take. To take course 3 you should have finished both courses 1 and 2. Both courses 1 and 2 should be taken after you finished course 0.
     So one correct course order is [0,1,2,3]. Another correct ordering is [0,2,1,3].
     Example 3:
     Input: numCourses = 1, prerequisites = []
     Output: [0]
     Constraints:
     1 <= numCourses <= 2000
     0 <= prerequisites.length <= numCourses * (numCourses - 1)
     prerequisites[i].length == 2
     0 <= ai, bi < numCourses
     ai != bi
     All the pairs [ai, bi] are distinct.
     */
    class Solution210 {
        func findOrder(_ numCourses: Int, _ prerequisites: [[Int]]) -> [Int] {
            // Graph adjacency list
            var graph = Array(repeating: [Int](), count: numCourses)
            
            // indegree[i] = number of prerequisites for course i
            var indegree = Array(repeating: 0, count: numCourses)
            
            // Build graph
            for pair in prerequisites {
                let course = pair[0]
                let prereq = pair[1]
                graph[prereq].append(course)
                indegree[course] += 1
            }
            
            // Queue for BFS (all nodes with 0 indegree)
            var queue = [Int]()
            for i in 0..<numCourses {
                if indegree[i] == 0 {
                    queue.append(i)
                }
            }
            
            var order = [Int]()
            
            // BFS topological sort
            while !queue.isEmpty {
                let node = queue.removeFirst()
                order.append(node)
                
                for neighbor in graph[node] {
                    indegree[neighbor] -= 1
                    if indegree[neighbor] == 0 {
                        queue.append(neighbor)
                    }
                }
            }
            
            // If all courses processed → valid ordering
            return order.count == numCourses ? order : []
        }
    }

    /*
     209. Minimum Size Subarray Sum
     Given an array of positive integers nums and a positive integer target, return the minimal length of a subarray whose sum is greater than or equal to target. If there is no such subarray, return 0 instead.
     Example 1:
     Input: target = 7, nums = [2,3,1,2,4,3]
     Output: 2
     Explanation: The subarray [4,3] has the minimal length under the problem constraint.
     Example 2:
     Input: target = 4, nums = [1,4,4]
     Output: 1
     Example 3:
     Input: target = 11, nums = [1,1,1,1,1,1,1,1]
     Output: 0
     Constraints:
     1 <= target <= 109
     1 <= nums.length <= 105
     1 <= nums[i] <= 104
     Follow up: If you have figured out the O(n) solution, try coding another solution of which the time complexity is O(n log(n)).
     */
    class Solution209 {

        // ---------------------------------------------------------
        // Method 1: Sliding Window (O(n))
        // Time Complexity: O(n)
        // Space Complexity: O(1)
        // ---------------------------------------------------------
        static func minSubArrayLen(_ target: Int, _ nums: [Int]) -> Int {
            var left = 0
            var sum = 0
            var result = Int.max
            
            for right in 0..<nums.count {
                sum += nums[right]
                
                // Shrink window from left while sum >= target
                while sum >= target {
                    result = min(result, right - left + 1)
                    sum -= nums[left]
                    left += 1
                }
            }
            
            return result == Int.max ? 0 : result
        }
        
        // ---------------------------------------------------------
        // Method 2: Binary Search on Prefix Sum (O(n log n))
        // Time Complexity: O(n log n)
        // Space Complexity: O(n)
        // ---------------------------------------------------------
        static func minSubArrayLenBinarySearch(_ target: Int, _ nums: [Int]) -> Int {
            let n = nums.count
            if n == 0 { return 0 }
            
            // Build prefix sum array
            var prefixSum = [0]
            for num in nums {
                prefixSum.append(prefixSum.last! + num)
            }
            
            var minLen = Int.max
            
            for i in 0..<n {
                let targetSum = target + prefixSum[i]
                // Binary search for the minimal j such that prefixSum[j] >= targetSum
                var left = i + 1
                var right = n
                var pos = n + 1
                
                while left <= right {
                    let mid = (left + right) / 2
                    if prefixSum[mid] >= targetSum {
                        pos = mid
                        right = mid - 1
                    } else {
                        left = mid + 1
                    }
                }
                
                if pos <= n {
                    minLen = min(minLen, pos - i)
                }
            }
            
            return minLen == Int.max ? 0 : minLen
        }
        
        // Demo
        static func runDemo() {
            let nums1 = [2,3,1,2,4,3]
            print(minSubArrayLen(7, nums1))  // 2
            print(minSubArrayLenBinarySearch(7, nums1))  // 2
            
            let nums2 = [1,4,4]
            print(minSubArrayLen(4, nums2))  // 1
            print(minSubArrayLenBinarySearch(4, nums2))  // 1
            
            let nums3 = [1,1,1,1,1,1,1,1]
            print(minSubArrayLen(11, nums3))  // 0
            print(minSubArrayLenBinarySearch(11, nums3))  // 0
        }
    }

    /*
     208. Implement Trie (Prefix Tree)
     A trie (pronounced as "try") or prefix tree is a tree data structure used to efficiently store and retrieve keys in a dataset of strings. There are various applications of this data structure, such as autocomplete and spellchecker.
     Implement the Trie class:
     Trie() Initializes the trie object.
     void insert(String word) Inserts the string word into the trie.
     boolean search(String word) Returns true if the string word is in the trie (i.e., was inserted before), and false otherwise.
     boolean startsWith(String prefix) Returns true if there is a previously inserted string word that has the prefix prefix, and false otherwise.
     Example 1:
     Input
     ["Trie", "insert", "search", "search", "startsWith", "insert", "search"]
     [[], ["apple"], ["apple"], ["app"], ["app"], ["app"], ["app"]]
     Output
     [null, null, true, false, true, null, true]
     Explanation
     Trie trie = new Trie();
     trie.insert("apple");
     trie.search("apple");   // return True
     trie.search("app");     // return False
     trie.startsWith("app"); // return True
     trie.insert("app");
     trie.search("app");     // return True
     Constraints:
     1 <= word.length, prefix.length <= 2000
     word and prefix consist only of lowercase English letters.
     At most 3 * 104 calls in total will be made to insert, search, and startsWith.
     */
    class TrieNode {
        var children: [Character: TrieNode] = [:]
        var isWord = false
    }

    class Trie {

        private let root = TrieNode()

        init() {}

        func insert(_ word: String) {
            var node = root
            for ch in word {
                if node.children[ch] == nil {
                    node.children[ch] = TrieNode()
                }
                node = node.children[ch]!
            }
            node.isWord = true
        }

        func search(_ word: String) -> Bool {
            var node = root
            for ch in word {
                guard let next = node.children[ch] else { return false }
                node = next
            }
            return node.isWord
        }

        func startsWith(_ prefix: String) -> Bool {
            var node = root
            for ch in prefix {
                guard let next = node.children[ch] else { return false }
                node = next
            }
            return true
        }
    }
    /*
     207. Course Schedule
     There are a total of numCourses courses you have to take, labeled from 0 to numCourses - 1. You are given an array prerequisites where prerequisites[i] = [ai, bi] indicates that you must take course bi first if you want to take course ai.

     For example, the pair [0, 1], indicates that to take course 0 you have to first take course 1.
     Return true if you can finish all courses. Otherwise, return false.
     Example 1:
     Input: numCourses = 2, prerequisites = [[1,0]]
     Output: true
     Explanation: There are a total of 2 courses to take.
     To take course 1 you should have finished course 0. So it is possible.
     Example 2:

     Input: numCourses = 2, prerequisites = [[1,0],[0,1]]
     Output: false
     Explanation: There are a total of 2 courses to take.
     To take course 1 you should have finished course 0, and to take course 0 you should also have finished course 1. So it is impossible.
     */
    class Solution207 {

        // ---------------------------------------------------------
        // Method 1: DFS + Cycle Detection
        // Detects cycles using a recursion stack.
        //
        // Time Complexity:  O(V + E)
        // Space Complexity: O(V + E) for adjacency list + O(V) for recursion
        // ---------------------------------------------------------
        static func canFinishDFS(_ numCourses: Int, _ prerequisites: [[Int]]) -> Bool {
            // Build graph
            var graph = Array(repeating: [Int](), count: numCourses)
            for pair in prerequisites {
                graph[pair[1]].append(pair[0]) // bi → ai
            }

            // 0 = unvisited, 1 = visiting, 2 = visited
            var state = Array(repeating: 0, count: numCourses)

            func dfs(_ course: Int) -> Bool {
                if state[course] == 1 { return false }  // Found cycle
                if state[course] == 2 { return true }   // Already checked

                state[course] = 1 // Mark as visiting

                for next in graph[course] {
                    if !dfs(next) { return false }
                }

                state[course] = 2 // Mark as done
                return true
            }

            for c in 0..<numCourses {
                if !dfs(c) { return false }
            }
            return true
        }

        // ---------------------------------------------------------
        // Method 2: BFS (Kahn’s Algorithm)
        // Uses indegree array to detect whether a topological order exists.
        //
        // Time Complexity:  O(V + E)
        // Space Complexity: O(V + E)
        // ---------------------------------------------------------
        static func canFinishBFS(_ numCourses: Int, _ prerequisites: [[Int]]) -> Bool {
            var graph = Array(repeating: [Int](), count: numCourses)
            var indegree = Array(repeating: 0, count: numCourses)

            for pair in prerequisites {
                let course = pair[0]
                let pre = pair[1]
                graph[pre].append(course)
                indegree[course] += 1
            }

            // Queue for courses with no prerequisites
            var queue: [Int] = []
            for i in 0..<numCourses {
                if indegree[i] == 0 { queue.append(i) }
            }

            var taken = 0

            while !queue.isEmpty {
                let current = queue.removeFirst()
                taken += 1

                for next in graph[current] {
                    indegree[next] -= 1
                    if indegree[next] == 0 {
                        queue.append(next)
                    }
                }
            }

            return taken == numCourses
        }

        // ---------------------------------------------------------
        // Default method — BFS (fastest and simplest)
        // ---------------------------------------------------------
        static func canFinish(_ numCourses: Int, _ prerequisites: [[Int]]) -> Bool {
            return canFinishBFS(numCourses, prerequisites)
        }

        // For testing
        static func runDemo() {
            print(canFinish(2, [[1,0]]))          // true
            print(canFinish(2, [[1,0],[0,1]]))    // false
        }
    }

    /*
     204. Count Primes
     Given an integer n, return the number of prime numbers that are strictly less than n.
     Example 1:
     Input: n = 10
     Output: 4
     Explanation: There are 4 prime numbers less than 10, they are 2, 3, 5, 7.
     Example 2:
     Input: n = 0
     Output: 0
     Example 3:
     Input: n = 1
     Output: 0
     */
    class Solution204 {

        // ---------------------------------------------------------
        // Method 1: Basic primality test (Brute Force)
        // Time Complexity:  O(n * sqrt(n))
        // Space Complexity: O(1)
        // ---------------------------------------------------------
        static func countPrimesBruteforce(_ n: Int) -> Int {
            if n <= 2 { return 0 }
            
            func isPrime(_ x: Int) -> Bool {
                if x < 2 { return false }
                for i in 2...Int(Double(x).squareRoot()) {
                    if x % i == 0 { return false }
                }
                return true
            }
            
            var count = 0
            for i in 2..<n {
                if isPrime(i) { count += 1 }
            }
            return count
        }

        // ---------------------------------------------------------
        // Method 2: Optimized primality test using 6k ± 1
        // Time Complexity:  O(n * sqrt(n)) but faster in practice
        // Space Complexity: O(1)
        // ---------------------------------------------------------
        static func countPrimesFastCheck(_ n: Int) -> Int {
            if n <= 2 { return 0 }
            
            func isPrime(_ x: Int) -> Bool {
                if x <= 1 { return false }
                if x <= 3 { return true }
                if x % 2 == 0 || x % 3 == 0 { return false }
                
                var i = 5
                while i * i <= x {
                    if x % i == 0 || x % (i + 2) == 0 { return false }
                    i += 6   // Check only numbers of form 6k ± 1
                }
                return true
            }
            
            var count = 0
            for i in 2..<n {
                if isPrime(i) { count += 1 }
            }
            return count
        }

        // ---------------------------------------------------------
        // Method 3: Sieve of Eratosthenes (Optimal)
        // Time Complexity:  O(n log log n)
        // Space Complexity: O(n)
        // ---------------------------------------------------------
        static func countPrimes(_ n: Int) -> Int {
            if n <= 2 { return 0 }
            
            var sieve = Array(repeating: true, count: n)
            sieve[0] = false
            sieve[1] = false
            
            var i = 2
            while i * i < n {
                if sieve[i] {
                    var j = i * i
                    while j < n {
                        sieve[j] = false
                        j += i
                    }
                }
                i += 1
            }
            
            return sieve.filter { $0 }.count
        }

        // Demo
        static func runDemo() {
            print(countPrimes(10)) // 4
            print(countPrimes(0))  // 0
            print(countPrimes(1))  // 0
        }
    }

    /*
     201. Bitwise AND of Numbers Range
     Given two integers left and right that represent the range [left, right], return the bitwise AND of all numbers in this range, inclusive.
     Example 1:
     Input: left = 5, right = 7
     Output: 4
     Example 2:
     Input: left = 0, right = 0
     Output: 0
     Example 3:
     Input: left = 1, right = 2147483647
     Output: 0
     */
    class Solution201 {
        /// Computes bitwise AND in range [left, right] by finding the common bit prefix.
        ///
        /// Time Complexity:  O(1) — max 31 shifts for 32-bit integers.
        /// Space Complexity: O(1)
        static func rangeBitwiseAnd(_ left: Int, _ right: Int) -> Int {
            var l = left
            var r = right
            var shift = 0
            
            // Shift until both numbers become equal
            while l < r {
                l >>= 1
                r >>= 1
                shift += 1
            }
            
            // Shift back to restore common prefix
            return l << shift
        }
        
        /// Optional demo
        static func runDemo() {
            print(rangeBitwiseAnd(5, 7))          // 4
            print(rangeBitwiseAnd(0, 0))          // 0
            print(rangeBitwiseAnd(1, 2147483647)) // 0
        }
    }

    /*
     200. Number of Islands
     Given an m x n 2D binary grid grid which represents a map of '1's (land) and '0's (water), return the number of islands.
     An island is surrounded by water and is formed by connecting adjacent lands horizontally or vertically. You may assume all four edges of the grid are all surrounded by water.

     Example 1:
     Input: grid = [
       ["1","1","1","1","0"],
       ["1","1","0","1","0"],
       ["1","1","0","0","0"],
       ["0","0","0","0","0"]
     ]
     Output: 1
     Example 2:
     Input: grid = [
       ["1","1","0","0","0"],
       ["1","1","0","0","0"],
       ["0","0","1","0","0"],
       ["0","0","0","1","1"]
     ]
     Output: 3
     Constraints:
     m == grid.length
     n == grid[i].length
     1 <= m, n <= 300
     grid[i][j] is '0' or '1'.
     */
    class Solution200 {
        /// Counts number of islands using DFS flood fill.
        ///
        /// Time Complexity:  O(m * n) — we visit each cell at most once.
        /// Space Complexity: O(m * n) worst-case recursion stack (or O(1) if using iterative DFS).
        static func numIslands(_ grid: inout [[Character]]) -> Int {
            let rows = grid.count
            let cols = grid[0].count
            var count = 0
            
            func dfs(_ r: Int, _ c: Int) {
                // Boundary check
                if r < 0 || c < 0 || r >= rows || c >= cols { return }
                // Skip water or visited cells
                if grid[r][c] == "0" { return }
                
                // Mark as visited
                grid[r][c] = "0"
                
                // Explore neighbors (4-directional)
                dfs(r + 1, c)
                dfs(r - 1, c)
                dfs(r, c + 1)
                dfs(r, c - 1)
            }
            
            for r in 0..<rows {
                for c in 0..<cols {
                    if grid[r][c] == "1" {
                        count += 1
                        dfs(r, c) // Flood-fill this island
                    }
                }
            }
            
            return count
        }
        
        /// Optional demo
        static func runDemo() {
            var grid: [[Character]] = [
                ["1","1","0","0","0"],
                ["1","1","0","0","0"],
                ["0","0","1","0","0"],
                ["0","0","0","1","1"]
            ]
            print(numIslands(&grid)) // Expected: 3
        }
    }

    /*
     199. Binary Tree Right Side View
     Given the root of a binary tree, imagine yourself standing on the right side of it, return the values of the nodes you can see ordered from top to bottom.
     Example 1:
     Input: root = [1,2,3,null,5,null,4]
     Output: [1,3,4]
     Example 2:
     Input: root = [1,2,3,4,null,null,null,5]
     Output: [1,3,4,5]
      Example 3:
     Input: root = [1,null,3]
     Output: [1,3]
     Example 4:
     Input: root = []
     Output: []
     */
    // Definition for a binary tree node.
    public class TreeNode199 {
        public var val: Int
        public var left: TreeNode199?
        public var right: TreeNode199?
        public init() { self.val = 0; self.left = nil; self.right = nil; }
        public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
        public init(_ val: Int, _ left: TreeNode199?, _ right: TreeNode199?) {
            self.val = val
            self.left = left
            self.right = right
        }
    }

    class Solution199 {
        /// Returns the right side view of a binary tree.
        ///
        /// Approach: BFS (level order traversal) and take the last node at each level
        ///
        /// Time Complexity: O(N) — each node is visited once
        /// Space Complexity: O(N) — queue may contain up to O(N) nodes
        static func rightSideView(_ root: TreeNode199?) -> [Int] {
            guard let root = root else { return [] }
            
            var result = [Int]()
            var queue = [TreeNode199]()
            queue.append(root)
            
            while !queue.isEmpty {
                let levelSize = queue.count
                for i in 0..<levelSize {
                    let node = queue.removeFirst()
                    
                    // If this is the last node in the current level, add to result
                    if i == levelSize - 1 {
                        result.append(node.val)
                    }
                    
                    if let left = node.left {
                        queue.append(left)
                    }
                    if let right = node.right {
                        queue.append(right)
                    }
                }
            }
            
            return result
        }
        
        /// Optional demo runner
        static func runDemo() {
            let root = TreeNode199(1,
                                    TreeNode199(2, nil, TreeNode199(5)),
                                    TreeNode199(3, nil, TreeNode199(4)))
            print(rightSideView(root)) // [1, 3, 4]
        }
    }

    // Uncomment to test
    // Solution199.runDemo()
    /*
     198. House Robber
     You are a professional robber planning to rob houses along a street. Each house has a certain amount of money stashed, the only constraint stopping you from robbing each of them is that adjacent houses have security systems connected and it will automatically contact the police if two adjacent houses were broken into on the same night.
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
     Constraints:
     1 <= nums.length <= 100
     0 <= nums[i] <= 400
     Time: O(n)
     Space: O(1)
     */
    class Solution198 {
        static func rob(_ nums: [Int]) -> Int {
            var robPrev = 0        // dp[i-1]
            var robBeforePrev = 0  // dp[i-2]
            
            for money in nums {
                let current = max(robPrev, robBeforePrev + money)
                robBeforePrev = robPrev
                robPrev = current
            }
            
            return robPrev
        }
    }

    /*
     197. Rising Temperature
     Pandas Schema
     Table: Weather

     +---------------+---------+
     | Column Name   | Type    |
     +---------------+---------+
     | id            | int     |
     | recordDate    | date    |
     | temperature   | int     |
     +---------------+---------+
     id is the column with unique values for this table.
     There are no different rows with the same recordDate.
     This table contains information about the temperature on a certain day.
      

     Write a solution to find all dates' id with higher temperatures compared to its previous dates (yesterday).

     Return the result table in any order.

     The result format is in the following example.

      

     Example 1:

     Input:
     Weather table:
     +----+------------+-------------+
     | id | recordDate | temperature |
     +----+------------+-------------+
     | 1  | 2015-01-01 | 10          |
     | 2  | 2015-01-02 | 25          |
     | 3  | 2015-01-03 | 20          |
     | 4  | 2015-01-04 | 30          |
     +----+------------+-------------+
     Output:
     +----+
     | id |
     +----+
     | 2  |
     | 4  |
     +----+
     Explanation:
     In 2015-01-02, the temperature was higher than the previous day (10 -> 25).
     In 2015-01-04, the temperature was higher than the previous day (20 -> 30).
     SELECT w1.id
     FROM Weather w1
     JOIN Weather w2
     ON DATEDIFF(w1.recordDate, w2.recordDate) = 1
     WHERE w1.temperature > w2.temperature;
     */
    struct Weather197 {
        let id: Int
        let recordDate: Date
        let temperature: Int
    }

    class Solution197 {
        /// Finds all IDs where the temperature is higher than the previous day.
        ///
        /// Time Complexity: O(N log N) — due to sorting by date
        /// Space Complexity: O(1)
        static func risingTemperature(from data: [Weather197]) -> [Int] {
            // Sort by recordDate to ensure chronological order
            let sortedData = data.sorted { $0.recordDate < $1.recordDate }
            var result = [Int]()
            
            // Compare each day with the previous one
            for i in 1..<sortedData.count {
                let today = sortedData[i]
                let yesterday = sortedData[i - 1]
                
                // Check if days are consecutive and temperature rose
                let daysBetween = Calendar.current.dateComponents([.day], from: yesterday.recordDate, to: today.recordDate).day ?? 0
                if daysBetween == 1 && today.temperature > yesterday.temperature {
                    result.append(today.id)
                }
            }
            
            return result
        }
    }
    /*
     196. Delete Duplicate Emails
     SQL Schema
     Pandas Schema
     Table: Person

     +-------------+---------+
     | Column Name | Type    |
     +-------------+---------+
     | id          | int     |
     | email       | varchar |
     +-------------+---------+
     id is the primary key (column with unique values) for this table.
     Each row of this table contains an email. The emails will not contain uppercase letters.
      

     Write a solution to delete all duplicate emails, keeping only one unique email with the smallest id.

     For SQL users, please note that you are supposed to write a DELETE statement and not a SELECT one.

     For Pandas users, please note that you are supposed to modify Person in place.

     After running your script, the answer shown is the Person table. The driver will first compile and run your piece of code and then show the Person table. The final order of the Person table does not matter.

     The result format is in the following example.

      

     Example 1:

     Input:
     Person table:
     +----+------------------+
     | id | email            |
     +----+------------------+
     | 1  | john@example.com |
     | 2  | bob@example.com  |
     | 3  | john@example.com |
     +----+------------------+
     Output:
     +----+------------------+
     | id | email            |
     +----+------------------+
     | 1  | john@example.com |
     | 2  | bob@example.com  |
     +----+------------------+
     Explanation: john@example.com is repeated two times. We keep the row with the smallest Id = 1.
     DELETE p1
     FROM Person p1
     JOIN Person p2
     ON p1.email = p2.email
     WHERE p1.id > p2.id;
     */

    struct Person196 {
        let id: Int
        let email: String
    }

    class Solution196 {
        /// Removes duplicate emails, keeping only the record with the smallest ID for each email.
        ///
        /// - Parameter persons: An array of `Person196` records.
        /// - Returns: A filtered array with duplicates removed.
        ///
        /// Time Complexity: O(N)
        /// Space Complexity: O(N) — uses a dictionary to track seen emails
        static func deleteDuplicateEmails(from persons: [Person196]) -> [Person196] {
            var seenEmails = Set<String>()
            var uniquePersons = [Person196]()
            
            // Sort by ID to ensure smallest ID is processed first
            let sortedPersons = persons.sorted { $0.id < $1.id }
            
            for person in sortedPersons {
                // If email not seen before, add to result
                if !seenEmails.contains(person.email) {
                    uniquePersons.append(person)
                    seenEmails.insert(person.email)
                }
            }
            
            return uniquePersons
        }
    }

    /*
     195. Tenth Line
     Given a text file file.txt, print just the 10th line of the file.
     Example:
     Assume that file.txt has the following content:
     Line 1
....
     Line 10
     Your script should output the tenth line, which is:
     Line 10
     Note:
     1. If the file contains less than 10 lines, what should you output?
     2. There's at least three different solutions. Try to explore all possibilities.
     */
    class Solution195 {
        /// Prints the Nth line from a given text file.
        ///
        /// - Parameters:
        ///   - path: Path to the text file.
        ///   - lineNumber: The line number to print (1-based index).
        ///
        /// If the file contains fewer than N lines, prints nothing.
        ///
        /// Time Complexity: O(N) — reads up to `lineNumber` lines
        /// Space Complexity: O(1) — stores only the current line
        static func printLine(fromFile path: String, lineNumber: Int) {
            guard lineNumber > 0 else {
                print("Line number must be greater than 0.")
                return
            }
            
            do {
                // Read the entire file content
                let content = try String(contentsOfFile: path, encoding: .utf8)
                let lines = content.components(separatedBy: .newlines)
                
                // Check if the file has enough lines
                if lines.count >= lineNumber {
                    print(lines[lineNumber - 1])
                }
            } catch {
                print("Error reading file: \(error)")
            }
        }
    }

    /*
     194. Transpose File
     Given a text file file.txt, transpose its content.
     You may assume that each row has the same number of columns, and each field is separated by the ' ' character.
     Example:
     If file.txt has the following content:
     name age
     alice 21
     ryan 30
     Output the following:
     name alice ryan
     age 21 30
     */
    class Solution194 {
        /// Transposes the contents of a space-separated text file.
        ///
        /// Time Complexity: O(R * C) — where R = number of rows, C = number of columns
        /// Space Complexity: O(R * C) — to store all values before transposing
        static func transposeFile(fromFile path: String) {
            do {
                // Read the file content
                let content = try String(contentsOfFile: path, encoding: .utf8)
                
                // Split into lines, removing any empty lines
                let lines = content
                    .components(separatedBy: .newlines)
                    .filter { !$0.isEmpty }
                
                // Split each line by spaces to create a 2D matrix
                let matrix = lines.map { $0.components(separatedBy: .whitespaces).filter { !$0.isEmpty } }
                
                guard let firstRow = matrix.first else { return }
                let numCols = firstRow.count
                let numRows = matrix.count
                
                // Transpose and print
                for col in 0..<numCols {
                    var transposedRow = [String]()
                    for row in 0..<numRows {
                        transposedRow.append(matrix[row][col])
                    }
                    print(transposedRow.joined(separator: " "))
                }
            } catch {
                print("Error reading file: \(error)")
            }
        }
    }

    /*
     193. Valid Phone Numbers
     Given a text file file.txt that contains a list of phone numbers (one per line), write a one-liner bash script to print all valid phone numbers.

     You may assume that a valid phone number must appear in one of the following two formats: (xxx) xxx-xxxx or xxx-xxx-xxxx. (x means a digit)

     You may also assume each line in the text file must not contain leading or trailing white spaces.

     Example:

     Assume that file.txt has the following content:

     987-123-4567
     123 456 7890
     (123) 456-7890
     Your script should output the following valid phone numbers:

     987-123-4567
     (123) 456-7890
     */
    class Solution193 {
        /// Reads a text file line by line and prints only valid phone numbers.
        ///
        /// Valid formats:
        /// - (xxx) xxx-xxxx
        /// - xxx-xxx-xxxx
        ///
        /// Time Complexity: O(N) — where N is the number of lines
        /// Space Complexity: O(1) — no extra data structures except for regex
        static func printValidPhoneNumbers(fromFile path: String) {
            // Define the regular expression for valid phone numbers
            let pattern = #"^(\(\d{3}\)\s|\d{3}-)\d{3}-\d{4}$"#
            
            guard let regex = try? NSRegularExpression(pattern: pattern) else {
                print("Invalid regex pattern.")
                return
            }
            
            do {
                // Read the file content and split by newlines
                let content = try String(contentsOfFile: path, encoding: .utf8)
                let lines = content.components(separatedBy: .newlines)
                
                for line in lines {
                    let trimmed = line.trimmingCharacters(in: .whitespaces)
                    // Check if the line matches the regex pattern
                    let range = NSRange(location: 0, length: trimmed.utf16.count)
                    if regex.firstMatch(in: trimmed, options: [], range: range) != nil {
                        print(trimmed)
                    }
                }
            } catch {
                print("Error reading file: \(error)")
            }
        }
    }

    /*
     192. Word Frequency
     Medium
     Topics
     premium lock icon
     Companies
     Write a bash script to calculate the frequency of each word in a text file words.txt.

     For simplicity sake, you may assume:

     words.txt contains only lowercase characters and space ' ' characters.
     Each word must consist of lowercase characters only.
     Words are separated by one or more whitespace characters.
     Example:

     Assume that words.txt has the following content:

     the day is sunny the the
     the sunny is is
     Your script should output the following, sorted by descending frequency:

     the 4
     is 3
     sunny 2
     day 1
     Note:

     Don't worry about handling ties, it is guaranteed that each word's frequency count is unique.
     Could you write it in one-line using Unix pipes?
     */
    class Solution192 {
        /// Reads the content of a text file and prints the frequency of each word
        /// sorted by descending frequency.
        ///
        /// Time Complexity: O(N log N) — N = number of words (sorting step)
        /// Space Complexity: O(N) — to store frequency dictionary
        static func wordFrequency(fromFile path: String) {
            do {
                // Read the content of the file
                let content = try String(contentsOfFile: path, encoding: .utf8)
                
                // Split text into lowercase words (filter out empty substrings)
                let words = content
                    .lowercased()
                    .components(separatedBy: .whitespacesAndNewlines)
                    .filter { !$0.isEmpty }
                
                // Count occurrences using a dictionary
                var frequency: [String: Int] = [:]
                for word in words {
                    frequency[word, default: 0] += 1
                }
                
                // Sort by descending frequency
                let sorted = frequency.sorted { $0.value > $1.value }
                
                // Print each word with its frequency
                for (word, count) in sorted {
                    print("\(word) \(count)")
                }
                
            } catch {
                print("Error reading file: \(error)")
            }
        }
    }

    /*
     191. Number of 1 Bits
     Given a positive integer n, write a function that returns the number of set bits in its binary representation (also known as the Hamming weight).
     Example 1:
     Input: n = 11
     Output: 3
     Explanation:
     The input binary string 1011 has a total of three set bits.
     Example 2:
     Input: n = 128
     Output: 1
     Explanation:
     The input binary string 10000000 has a total of one set bit.
     Example 3:
     Input: n = 2147483645
     Output: 30
     Explanation:
     The input binary string 1111111111111111111111111111101 has a total of thirty set bits.
     */
    class Solution191 {
        // MARK: - Count the number of '1' bits (Hamming weight)
        //
        // Time Complexity: O(1)   → fixed 32 iterations for a 32-bit integer
        // Space Complexity: O(1)
        //
        // Approach:
        // 1. Iterate through all 32 bits of n.
        // 2. Check the least significant bit using (n & 1).
        // 3. Add it to the counter.
        // 4. Shift n right to check the next bit.
        static func hammingWeight(_ n: UInt32) -> Int {
            var num = n
            var count = 0

            for _ in 0..<32 {
                count += Int(num & 1)
                num >>= 1
            }

            return count
        }

        // MARK: - Optimized Method (Brian Kernighan’s Algorithm)
        //
        // Time Complexity: O(k), where k = number of 1 bits.
        // Space Complexity: O(1)
        //
        // Approach:
        // 1. Each iteration removes the lowest set bit using n = n & (n - 1).
        // 2. Loop runs only as many times as there are 1 bits.
        static func hammingWeightOptimized(_ n: UInt32) -> Int {
            var num = n
            var count = 0

            while num != 0 {
                num &= (num - 1)  // clear the lowest set bit
                count += 1
            }

            return count
        }

        // MARK: - Demo Runner
        static func runDemo() {
            let examples: [UInt32] = [11, 128, 2147483645]

            for n in examples {
                let simple = hammingWeight(n)
                let optimized = hammingWeightOptimized(n)

                print("Input: \(n)")
                print("→ Simple Count: \(simple)")
                print("→ Optimized (Kernighan): \(optimized)")
                print("Binary:", String(n, radix: 2))
                print("––––––––––––––––––––––––––––––––––")
            }
        }
    }

    // Uncomment to test in Playground
    // Solution191.runDemo()

    /*
     190. Reverse Bits
     Reverse bits of a given 32 bits signed integer.
     Example 1:
     Input: n = 43261596
     Output: 964176192
     Explanation:
     Integer    Binary
     43261596    00000010100101000001111010011100
     964176192    00111001011110000010100101000000
     Example 2:
     Input: n = 2147483644
     Output: 1073741822
     Explanation:
     Integer    Binary
     2147483644    01111111111111111111111111111100
     1073741822    00111111111111111111111111111110
     Constraints:
     0 <= n <= 231 - 2
     n is even.
     */
    class Solution190 {
        // MARK: - Reverse Bits of 32-bit Integer
        //
        // Time Complexity: O(1)   (always 32 iterations)
        // Space Complexity: O(1)
        //
        // Approach:
        // 1. Iterate through all 32 bits of the integer.
        // 2. Shift the result left, add the least significant bit (LSB) of n.
        // 3. Shift n right to process the next bit.
        // 4. Return the reversed 32-bit value.
        static func reverseBits(_ n: UInt32) -> UInt32 {
            var result: UInt32 = 0
            var num = n
            
            for _ in 0..<32 {
                // Shift result left to make space for next bit
                result = (result << 1) | (num & 1)
                // Move to the next bit
                num >>= 1
            }
            return result
        }

        // MARK: - Demo Runner
        static func runDemo() {
            let n1: UInt32 = 43261596
            let n2: UInt32 = 2147483644

            let reversed1 = reverseBits(n1)
            let reversed2 = reverseBits(n2)

            print("Input 1: \(n1) → Output: \(reversed1)")
            print("Input 2: \(n2) → Output: \(reversed2)")

            // For binary clarity
            print("\nBinary comparison:")
            print(String(n1, radix: 2).leftPad(toLength: 32))
            print(String(reversed1, radix: 2).leftPad(toLength: 32))
        }
    }
    // Uncomment to test in Playground
    // Solution190.runDemo()

    /*
     189. Rotate Array
     Given an integer array nums, rotate the array to the right by k steps, where k is non-negative.
     Example 1:
     Input: nums = [1,2,3,4,5,6,7], k = 3
     Output: [5,6,7,1,2,3,4]
     Explanation:
     rotate 1 steps to the right: [7,1,2,3,4,5,6]
     rotate 2 steps to the right: [6,7,1,2,3,4,5]
     rotate 3 steps to the right: [5,6,7,1,2,3,4]
     Example 2:
     Input: nums = [-1,-100,3,99], k = 2
     Output: [3,99,-1,-100]
     Explanation:
     rotate 1 steps to the right: [99,-1,-100,3]
     rotate 2 steps to the right: [3,99,-1,-100]
     Constraints:
     1 <= nums.length <= 105
     -231 <= nums[i] <= 231 - 1
     0 <= k <= 105
     Follow up:
     Try to come up with as many solutions as you can. There are at least three different ways to solve this problem.
     Could you do it in-place with O(1) extra space?
     */
    class Solution189 {
        // MARK: - Method 1: Extra Array
        // Time Complexity: O(n)
        // Space Complexity: O(n)
        // Approach: Create a new array and copy elements to rotated positions.
        static func rotateUsingExtraArray(_ nums: inout [Int], _ k: Int) {
            let n = nums.count
            guard n > 0 else { return }
            let shift = k % n
            guard shift > 0 else { return }

            // Copy last k elements + first n-k elements
            let rotated = Array(nums[n - shift..<n]) + Array(nums[0..<n - shift])

            // Copy back to original array
            for i in 0..<n {
                nums[i] = rotated[i]
            }
        }

        // MARK: - Method 2: Reverse Array In-Place
        // Time Complexity: O(n)
        // Space Complexity: O(1)
        // Approach: Reverse entire array, then reverse two segments.
        static func rotateUsingReverse(_ nums: inout [Int], _ k: Int) {
            let n = nums.count
            guard n > 0 else { return }
            let shift = k % n
            guard shift > 0 else { return }

            func reverse(_ start: Int, _ end: Int) {
                var l = start, r = end
                while l < r {
                    nums.swapAt(l, r)
                    l += 1
                    r -= 1
                }
            }

            reverse(0, n - 1)
            reverse(0, shift - 1)
            reverse(shift, n - 1)
        }

        // MARK: - Method 3: Cyclic Replacements
        // Time Complexity: O(n)
        // Space Complexity: O(1)
        // Approach: Move each element to (i + k) % n in cycles.
        static func rotateUsingCycle(_ nums: inout [Int], _ k: Int) {
            let n = nums.count
            guard n > 0 else { return }
            let shift = k % n
            guard shift > 0 else { return }

            var count = 0
            var start = 0

            // Process cycles until all elements are moved
            while count < n {
                var current = start
                var prev = nums[start]

                repeat {
                    let next = (current + shift) % n
                    let temp = nums[next]
                    nums[next] = prev
                    prev = temp
                    current = next
                    count += 1
                } while start != current

                start += 1
            }
        }

        // MARK: - Demo Runner
        static func runDemo() {
            var nums1 = [1, 2, 3, 4, 5, 6, 7]
            var nums2 = [1, 2, 3, 4, 5, 6, 7]
            var nums3 = [1, 2, 3, 4, 5, 6, 7]
            let k = 3

            rotateUsingExtraArray(&nums1, k)
            print("Method 1 (Extra Array): \(nums1)")

            rotateUsingReverse(&nums2, k)
            print("Method 2 (Reverse In-Place): \(nums2)")

            rotateUsingCycle(&nums3, k)
            print("Method 3 (Cyclic Replacement): \(nums3)")
        }
    }

    // Uncomment to test in Playground
    // Solution189.runDemo()

    /*
     188. Best Time to Buy and Sell Stock IV
     You are given an integer array prices where prices[i] is the price of a given stock on the ith day, and an integer k.

     Find the maximum profit you can achieve. You may complete at most k transactions: i.e. you may buy at most k times and sell at most k times.
     Note: You may not engage in multiple transactions simultaneously (i.e., you must sell the stock before you buy again).
     Example 1:
     Input: k = 2, prices = [2,4,1]
     Output: 2
     Explanation: Buy on day 1 (price = 2) and sell on day 2 (price = 4), profit = 4-2 = 2.
     Example 2:

     Input: k = 2, prices = [3,2,6,5,0,3]
     Output: 7
     Explanation: Buy on day 2 (price = 2) and sell on day 3 (price = 6), profit = 6-2 = 4. Then buy on day 5 (price = 0) and sell on day 6 (price = 3), profit = 3-0 = 3.
      

     Constraints:

     1 <= k <= 100
     1 <= prices.length <= 1000
     0 <= prices[i] <= 1000
     */
    class Solution188 {
        // O(n)
        static func maxProfitOpt(_ k: Int, _ prices: [Int]) -> Int {
              let n = prices.count
              if n == 0 { return 0 }
              
              // If k is large enough, treat as infinite transactions
              if k >= n / 2 {
                  var profit = 0
                  for i in 1..<n {
                      if prices[i] > prices[i - 1] {
                          profit += prices[i] - prices[i - 1]
                      }
                  }
                  return profit
              }
              
              // prev[j] = dp[i-1][j]
              // curr[j] = dp[i][j]
              var prev = Array(repeating: 0, count: n)
              var curr = Array(repeating: 0, count: n)
              
            for _ in 1...k {
                  var maxDiff = -prices[0]
                  
                  for j in 1..<n {
                      // Option 1: do nothing (carry profit)
                      // Option 2: sell today (use maxDiff)
                      curr[j] = max(curr[j - 1], prices[j] + maxDiff)
                      
                      // Update maxDiff for the next day
                      maxDiff = max(maxDiff, prev[j] - prices[j])
                  }
                  
                  // Move current row to previous for next transaction
                  prev = curr
              }
              
              return prev[n - 1]
          }
        // O(k × n)
        static func maxProfit(_ k: Int, _ prices: [Int]) -> Int {
            let n = prices.count
            if n == 0 { return 0 }
            
            // If k is large enough, it becomes equivalent to unlimited transactions
            if k >= n / 2 {
                var profit = 0
                for i in 1..<n {
                    if prices[i] > prices[i - 1] {
                        profit += prices[i] - prices[i - 1]
                    }
                }
                return profit
            }
            
            // DP approach
            // dp[i][j] = max profit on day j with at most i transactions
            var dp = Array(repeating: Array(repeating: 0, count: n), count: k + 1)
            
            for i in 1...k {
                var maxDiff = -prices[0]
                for j in 1..<n {
                    // either we don't sell today, or we sell today (using the best buy before)
                    dp[i][j] = max(dp[i][j - 1], prices[j] + maxDiff)
                    
                    // update maxDiff: best (dp[i-1][p] - price[p]) up to day j
                    maxDiff = max(maxDiff, dp[i - 1][j] - prices[j])
                }
            }
            
            return dp[k][n - 1]
        }
        
        // Demo method
        static func runDemo() {
            let k1 = 2
            let prices1 = [2, 4, 1]
            let result1 = maxProfit(k1, prices1)
            print(result1)  // 2
            
            let k2 = 2
            let prices2 = [3, 2, 6, 5, 0, 3]
            let result2 = maxProfit(k2, prices2)
            print(result2)  // 7
        }
    }

    /*
     187. Repeated DNA Sequences
     The DNA sequence is composed of a series of nucleotides abbreviated as 'A', 'C', 'G', and 'T'.
     For example, "ACGAATTCCG" is a DNA sequence.
     When studying DNA, it is useful to identify repeated sequences within the DNA.
     Given a string s that represents a DNA sequence, return all the 10-letter-long sequences (substrings) that occur more than once in a DNA molecule. You may return the answer in any order.
     Example 1:
     Input: s = "AAAAACCCCCAAAAACCCCCCAAAAAGGGTTT"
     Output: ["AAAAACCCCC","CCCCCAAAAA"]
     Example 2:
     Input: s = "AAAAAAAAAAAAA"
     Output: ["AAAAAAAAAA"]
     Constraints:
     1 <= s.length <= 105
     s[i] is either 'A', 'C', 'G', or 'T'.
     Time: O(n) — we visit each 10-letter window once.
     Space: O(n) — due to the sets storing substrings.
     */
    class Solution187 {
        static func findRepeatedDnaSequences(_ s: String) -> [String] {
            let n = s.count
            guard n > 10 else { return [] }
            
            var seen = Set<String>()        // to store all 10-letter sequences we've seen once
            var repeated = Set<String>()    // to store sequences seen more than once
            
            let chars = Array(s)
            
            // Iterate over all possible 10-letter substrings
            for i in 0...(n - 10) {
                let sub = String(chars[i..<i+10])
                if !seen.insert(sub).inserted {
                    // If insertion failed, it means we've seen it before
                    repeated.insert(sub)
                }
            }
            
            return Array(repeated)
        }
        
        // Demo method
        static func runDemo() {
            let s1 = "AAAAACCCCCAAAAACCCCCCAAAAAGGGTTT"
            let result1 = findRepeatedDnaSequences(s1)
            print(result1)  // ["AAAAACCCCC", "CCCCCAAAAA"]
            
            let s2 = "AAAAAAAAAAAAA"
            let result2 = findRepeatedDnaSequences(s2)
            print(result2)  // ["AAAAAAAAAA"]
        }
    }
    /*
     185. Department Top Three Salaries
     SQL Schema
     Pandas Schema
     Table: Employee
     
     +--------------+---------+
     | Column Name  | Type    |
     +--------------+---------+
     | id           | int     |
     | name         | varchar |
     | salary       | int     |
     | departmentId | int     |
     +--------------+---------+
     id is the primary key (column with unique values) for this table.
     departmentId is a foreign key (reference column) of the ID from the Department table.
     Each row of this table indicates the ID, name, and salary of an employee. It also contains the ID of their department.
     
     
     Table: Department
     
     +-------------+---------+
     | Column Name | Type    |
     +-------------+---------+
     | id          | int     |
     | name        | varchar |
     +-------------+---------+
     id is the primary key (column with unique values) for this table.
     Each row of this table indicates the ID of a department and its name.
     
     
     A company's executives are interested in seeing who earns the most money in each of the company's departments. A high earner in a department is an employee who has a salary in the top three unique salaries for that department.
     
     Write a solution to find the employees who are high earners in each of the departments.
     
     Return the result table in any order.
     
     The result format is in the following example.
     
     
     
     Example 1:
     
     Input:
     Employee table:
     +----+-------+--------+--------------+
     | id | name  | salary | departmentId |
     +----+-------+--------+--------------+
     | 1  | Joe   | 85000  | 1            |
     | 2  | Henry | 80000  | 2            |
     | 3  | Sam   | 60000  | 2            |
     | 4  | Max   | 90000  | 1            |
     | 5  | Janet | 69000  | 1            |
     | 6  | Randy | 85000  | 1            |
     | 7  | Will  | 70000  | 1            |
     +----+-------+--------+--------------+
     Department table:
     +----+-------+
     | id | name  |
     +----+-------+
     | 1  | IT    |
     | 2  | Sales |
     +----+-------+
     Output:
     +------------+----------+--------+
     | Department | Employee | Salary |
     +------------+----------+--------+
     | IT         | Max      | 90000  |
     | IT         | Joe      | 85000  |
     | IT         | Randy    | 85000  |
     | IT         | Will     | 70000  |
     | Sales      | Henry    | 80000  |
     | Sales      | Sam      | 60000  |
     +------------+----------+--------+
     Explanation:
     In the IT department:
     - Max earns the highest unique salary
     - Both Randy and Joe earn the second-highest unique salary
     - Will earns the third-highest unique salary
     
     In the Sales department:
     - Henry earns the highest salary
     - Sam earns the second-highest salary
     - There is no third-highest salary as there are only two employees
     
     
     Constraints:
     
     There are no employees with the exact same name, salary and department.
     */
    // Unique structs for problem 185
    struct Employee185 {
        let id: Int
        let name: String
        let salary: Int
        let departmentId: Int
    }
    
    struct Department185 {
        let id: Int
        let name: String
    }
    
    struct DepartmentTopSalary185 {
        let department: String
        let employee: String
        let salary: Int
    }
    
    class Solution185 {
        static func departmentTopThreeSalaries(
            employees: [Employee185],
            departments: [Department185]
        ) -> [DepartmentTopSalary185] {
            //            SELECT
            //                d.name AS Department,
            //                e.name AS Employee,
            //                e.salary AS Salary
            //            FROM Employee e
            //            JOIN Department d ON e.departmentId = d.id
            //            WHERE e.salary IN (
            //                SELECT DISTINCT e2.salary
            //                FROM Employee e2
            //                WHERE e2.departmentId = e.departmentId
            //                ORDER BY e2.salary DESC
            //                LIMIT 3
            //            )
            //            ORDER BY Department, Salary DESC;
            
            // Step 1: Group employees by departmentId
            var deptToEmployees = [Int: [Employee185]]()
            for e in employees {
                deptToEmployees[e.departmentId, default: []].append(e)
            }
            
            var result = [DepartmentTopSalary185]()
            
            // Step 2: For each department, find the top 3 unique salaries
            for dept in departments {
                guard let emps = deptToEmployees[dept.id], !emps.isEmpty else { continue }
                
                // Extract unique salaries in descending order
                let uniqueSalaries = Array(Set(emps.map { $0.salary })).sorted(by: >)
                
                // Take top 3 unique salaries
                let topThreeSalaries = Array(uniqueSalaries.prefix(3))
                
                // Filter employees who have one of the top three salaries
                let topEarners = emps.filter { topThreeSalaries.contains($0.salary) }
                
                // Add results
                for e in topEarners {
                    result.append(DepartmentTopSalary185(
                        department: dept.name,
                        employee: e.name,
                        salary: e.salary
                    ))
                }
            }
            
            return result
        }
        
        // Demo method
        static func runDemo() {
            let employees = [
                Employee185(id: 1, name: "Joe", salary: 85000, departmentId: 1),
                Employee185(id: 2, name: "Henry", salary: 80000, departmentId: 2),
                Employee185(id: 3, name: "Sam", salary: 60000, departmentId: 2),
                Employee185(id: 4, name: "Max", salary: 90000, departmentId: 1),
                Employee185(id: 5, name: "Janet", salary: 69000, departmentId: 1),
                Employee185(id: 6, name: "Randy", salary: 85000, departmentId: 1),
                Employee185(id: 7, name: "Will", salary: 70000, departmentId: 1)
            ]
            
            let departments = [
                Department185(id: 1, name: "IT"),
                Department185(id: 2, name: "Sales")
            ]
            
            let result = departmentTopThreeSalaries(employees: employees, departments: departments)
            
            for r in result {
                print("\(r.department) - \(r.employee) - \(r.salary)")
            }
        }
    }

    /*
     184. Department Highest Salary
     SQL Schema
     Pandas Schema
     Table: Employee

     +--------------+---------+
     | Column Name  | Type    |
     +--------------+---------+
     | id           | int     |
     | name         | varchar |
     | salary       | int     |
     | departmentId | int     |
     +--------------+---------+
     id is the primary key (column with unique values) for this table.
     departmentId is a foreign key (reference columns) of the ID from the Department table.
     Each row of this table indicates the ID, name, and salary of an employee. It also contains the ID of their department.
      

     Table: Department

     +-------------+---------+
     | Column Name | Type    |
     +-------------+---------+
     | id          | int     |
     | name        | varchar |
     +-------------+---------+
     id is the primary key (column with unique values) for this table. It is guaranteed that department name is not NULL.
     Each row of this table indicates the ID of a department and its name.
      

     Write a solution to find employees who have the highest salary in each of the departments.

     Return the result table in any order.

     The result format is in the following example.

      

     Example 1:

     Input:
     Employee table:
     +----+-------+--------+--------------+
     | id | name  | salary | departmentId |
     +----+-------+--------+--------------+
     | 1  | Joe   | 70000  | 1            |
     | 2  | Jim   | 90000  | 1            |
     | 3  | Henry | 80000  | 2            |
     | 4  | Sam   | 60000  | 2            |
     | 5  | Max   | 90000  | 1            |
     +----+-------+--------+--------------+
     Department table:
     +----+-------+
     | id | name  |
     +----+-------+
     | 1  | IT    |
     | 2  | Sales |
     +----+-------+
     Output:
     +------------+----------+--------+
     | Department | Employee | Salary |
     +------------+----------+--------+
     | IT         | Jim      | 90000  |
     | Sales      | Henry    | 80000  |
     | IT         | Max      | 90000  |
     +------------+----------+--------+
     Explanation: Max and Jim both have the highest salary in the IT department and Henry has the highest salary in the Sales department.
     */
    // Unique struct names for problem 184
    struct Employee184 {
        let id: Int
        let name: String
        let salary: Int
        let departmentId: Int
    }

    struct Department184 {
        let id: Int
        let name: String
    }

    struct DepartmentHighestSalary184 {
        let department: String
        let employee: String
        let salary: Int
    }

    class Solution184 {
        static func departmentHighestSalary(employees: [Employee184], departments: [Department184]) -> [DepartmentHighestSalary184] {
//            SELECT d.name AS Department, e.name AS Employee, e.salary AS Salary
//            FROM Employee e
//            JOIN Department d ON e.departmentId = d.id
//            WHERE e.salary = (
//                SELECT MAX(salary)
//                FROM Employee
//                WHERE departmentId = e.departmentId
//            );
            // Step 1: Group employees by departmentId
            var deptToEmployees = [Int: [Employee184]]()
            for e in employees {
                deptToEmployees[e.departmentId, default: []].append(e)
            }
            
            var result = [DepartmentHighestSalary184]()
            
            // Step 2: For each department, find the max salary and corresponding employees
            for dept in departments {
                guard let emps = deptToEmployees[dept.id], !emps.isEmpty else { continue }
                
                // Find the highest salary in this department
                let maxSalary = emps.map { $0.salary }.max()!
                
                // Get all employees who have the max salary
                let topEmployees = emps.filter { $0.salary == maxSalary }
                
                // Add to result
                for emp in topEmployees {
                    result.append(DepartmentHighestSalary184(department: dept.name, employee: emp.name, salary: emp.salary))
                }
            }
            
            return result
        }
        
        // Demo method
        static func runDemo() {
            let employees = [
                Employee184(id: 1, name: "Joe", salary: 70000, departmentId: 1),
                Employee184(id: 2, name: "Jim", salary: 90000, departmentId: 1),
                Employee184(id: 3, name: "Henry", salary: 80000, departmentId: 2),
                Employee184(id: 4, name: "Sam", salary: 60000, departmentId: 2),
                Employee184(id: 5, name: "Max", salary: 90000, departmentId: 1)
            ]
            
            let departments = [
                Department184(id: 1, name: "IT"),
                Department184(id: 2, name: "Sales")
            ]
            
            let result = departmentHighestSalary(employees: employees, departments: departments)
            for r in result {
                print("\(r.department) - \(r.employee) - \(r.salary)")
            }
        }
    }

    /*
     183. Customers Who Never Order
     Easy
     Topics
     premium lock icon
     Companies
     SQL Schema
     Pandas Schema
     Table: Customers

     +-------------+---------+
     | Column Name | Type    |
     +-------------+---------+
     | id          | int     |
     | name        | varchar |
     +-------------+---------+
     id is the primary key (column with unique values) for this table.
     Each row of this table indicates the ID and name of a customer.
      

     Table: Orders

     +-------------+------+
     | Column Name | Type |
     +-------------+------+
     | id          | int  |
     | customerId  | int  |
     +-------------+------+
     id is the primary key (column with unique values) for this table.
     customerId is a foreign key (reference columns) of the ID from the Customers table.
     Each row of this table indicates the ID of an order and the ID of the customer who ordered it.
      

     Write a solution to find all customers who never order anything.

     Return the result table in any order.

     The result format is in the following example.

      

     Example 1:

     Input:
     Customers table:
     +----+-------+
     | id | name  |
     +----+-------+
     | 1  | Joe   |
     | 2  | Henry |
     | 3  | Sam   |
     | 4  | Max   |
     +----+-------+
     Orders table:
     +----+------------+
     | id | customerId |
     +----+------------+
     | 1  | 3          |
     | 2  | 1          |
     +----+------------+
     Output:
     +-----------+
     | Customers |
     +-----------+
     | Henry     |
     | Max       |
     +-----------+
     */
    // Unique struct names for this specific problem (183)
    struct Customer183 {
        let id: Int
        let name: String
    }

    struct Order183 {
        let id: Int
        let customerId: Int
    }

    // Solution class with a unique name
    class Solution183 {
        static func customersWhoNeverOrder(customers: [Customer183], orders: [Order183]) -> [String] {
            // Collect all customer IDs that have at least one order
            let orderedCustomerIds = Set(orders.map { $0.customerId })
            
            // Filter out customers who have placed orders
            let result = customers
                .filter { !orderedCustomerIds.contains($0.id) }
                .map { $0.name }
          //SELECT name AS Customers
//            FROM Customers
//            WHERE id NOT IN (
//                SELECT customerId
//                FROM Orders
//            );
            return result
        }
        
        // Demo method to show how it works
        static func runDemo() {
            let customers = [
                Customer183(id: 1, name: "Joe"),
                Customer183(id: 2, name: "Henry"),
                Customer183(id: 3, name: "Sam"),
                Customer183(id: 4, name: "Max")
            ]
            
            let orders = [
                Order183(id: 1, customerId: 3),
                Order183(id: 2, customerId: 1)
            ]
            
            let result = customersWhoNeverOrder(customers: customers, orders: orders)
            print(result) // ["Henry", "Max"]
        }
    }

    /*
     SQL equivalent (LeetCode style):

     SELECT name AS Customers
     FROM Customers
     WHERE id NOT IN (
         SELECT customerId
         FROM Orders
     );
    */

    /*
     182. Duplicate Emails
     SQL Schema
     Pandas Schema
     Table: Person
     +-------------+---------+
     | Column Name | Type    |
     +-------------+---------+
     | id          | int     |
     | email       | varchar |
     +-------------+---------+
     id is the primary key (column with unique values) for this table.
     Each row of this table contains an email. The emails will not contain uppercase letters.
     Write a solution to report all the duplicate emails. Note that it's guaranteed that the email field is not NULL.
     Return the result table in any order.
     The result format is in the following example.
     Example 1:
     Input:
     Person table:
     +----+---------+
     | id | email   |
     +----+---------+
     | 1  | a@b.com |
     | 2  | c@d.com |
     | 3  | a@b.com |
     +----+---------+
     Output:
     +---------+
     | Email   |
     +---------+
     | a@b.com |
     +---------+
     Explanation: a@b.com is repeated two times.
     */

    struct Person182 {
        let id: Int
        let email: String
    }

    class Solution182 {
        static func duplicateEmails(_ persons: [Person182]) -> [String] {
            var emailCount = [String: Int]()
            
            // Count how many times each email appears
            for p in persons {
                emailCount[p.email, default: 0] += 1
            }
            
            // Keep only emails that appear more than once
            let duplicates = emailCount
                .filter { $0.value > 1 }
                .map { $0.key }
            
            return duplicates
        }
    }

    // Example usage
    func runDemo182() {
        let persons = [
            Person182(id: 1, email: "a@b.com"),
            Person182(id: 2, email: "c@d.com"),
            Person182(id: 3, email: "a@b.com")
        ]
        
        let result = Solution182.duplicateEmails(persons)
        print(result) // ["a@b.com"]
    }


    /*
     181. Employees Earning More Than Their Managers
     SQL Schema
     Pandas Schema
     Table: Employee

     +-------------+---------+
     | Column Name | Type    |
     +-------------+---------+
     | id          | int     |
     | name        | varchar |
     | salary      | int     |
     | managerId   | int     |
     +-------------+---------+
     id is the primary key (column with unique values) for this table.
     Each row of this table indicates the ID of an employee, their name, salary, and the ID of their manager.
     Write a solution to find the employees who earn more than their managers.
     Return the result table in any order.
     The result format is in the following example.
     Example 1:
     Input:
     Employee table:
     +----+-------+--------+-----------+
     | id | name  | salary | managerId |
     +----+-------+--------+-----------+
     | 1  | Joe   | 70000  | 3         |
     | 2  | Henry | 80000  | 4         |
     | 3  | Sam   | 60000  | Null      |
     | 4  | Max   | 90000  | Null      |
     +----+-------+--------+-----------+
     Output:
     +----------+
     | Employee |
     +----------+
     | Joe      |
     +----------+
     Explanation: Joe is the only employee who earns more than his manager.
     */

    struct Employee181 {
        let id: Int
        let name: String
        let salary: Int
        let managerId: Int?
    }

    class Solution181 {
        static func employeesEarningMoreThanManagers(_ employees: [Employee181]) -> [String] {
            var byId = [Int: Employee181]()
            for e in employees {
                byId[e.id] = e
            }
            
            var result = [String]()
            
            for e in employees {
                if let managerId = e.managerId,
                   let manager = byId[managerId],
                   e.salary > manager.salary {
                    result.append(e.name)
                }
            }
            
            return result
        }
    }

    func runDemo() {
        let employees = [
            Employee181(id: 1, name: "Joe", salary: 70000, managerId: 3),
            Employee181(id: 2, name: "Henry", salary: 80000, managerId: 4),
            Employee181(id: 3, name: "Sam", salary: 60000, managerId: nil),
            Employee181(id: 4, name: "Max", salary: 90000, managerId: nil)
        ]
        
        let result = Solution181.employeesEarningMoreThanManagers(employees)
        print(result) // ["Joe"]
    }

    /*
     180. Consecutive Numbers
     Medium
     Topics
     premium lock icon
     Companies
     SQL Schema
     Pandas Schema
     Table: Logs

     +-------------+---------+
     | Column Name | Type    |
     +-------------+---------+
     | id          | int     |
     | num         | varchar |
     +-------------+---------+
     In SQL, id is the primary key for this table.
     id is an autoincrement column starting from 1.
      

     Find all numbers that appear at least three times consecutively.

     Return the result table in any order.

     The result format is in the following example.

      

     Example 1:

     Input:
     Logs table:
     +----+-----+
     | id | num |
     +----+-----+
     | 1  | 1   |
     | 2  | 1   |
     | 3  | 1   |
     | 4  | 2   |
     | 5  | 1   |
     | 6  | 2   |
     | 7  | 2   |
     +----+-----+
     Output:
     +-----------------+
     | ConsecutiveNums |
     +-----------------+
     | 1               |
     +-----------------+
     Explanation: 1 is the only number that appears consecutively for at least three times.
     SELECT DISTINCT a.num AS ConsecutiveNums
     FROM Logs a
     JOIN Logs b ON a.id = b.id - 1
     JOIN Logs c ON b.id = c.id - 1
     WHERE a.num = b.num AND b.num = c.num;
     */
    /// Function to find all numbers that appear at least 3 times consecutively
    func findConsecutiveNumbers(_ logs: [(id: Int, num: Int)]) -> [Int] {
        // Sort by id to ensure order (just in case)
        let sortedLogs = logs.sorted { $0.id < $1.id }
        
        var result = Set<Int>()  // Use Set to avoid duplicates
        var count = 1            // Count of current consecutive sequence
        
        for i in 1..<sortedLogs.count {
            if sortedLogs[i].num == sortedLogs[i - 1].num {
                count += 1
                if count >= 3 {
                    result.insert(sortedLogs[i].num)
                }
            } else {
                count = 1  // Reset counter when number changes
            }
        }
        
        return Array(result)
    }
    func demo180() {
        /// Example usage
        let logs: [(Int, Int)] = [
            (1, 1),
            (2, 1),
            (3, 1),
            (4, 2),
            (5, 1),
            (6, 2),
            (7, 2)
        ]
        let consecutiveNums = findConsecutiveNumbers(logs)
        print("Consecutive numbers appearing 3+ times:", consecutiveNums)
    }
    /*
     179. Largest Number
     Given a list of non-negative integers nums, arrange them such that they form the largest number and return it. Since the result may be very large, so you need to return a string instead of an integer. Example 1: Input: nums = [10,2] Output: "210" Example 2: Input: nums = [3,30,34,5,9] Output: "9534330" Constraints: 1 <= nums.length <= 100 0 <= nums[i] <= 109
     */
    class LargestNumberDemo {
        
        static func largestNumber(_ nums: [Int]) -> String {
            // Convert numbers to strings
            let strs = nums.map { String($0) }
            
            // Custom sort: compare concatenations
            let sorted = strs.sorted { a, b in
                return a + b > b + a
            }
            
            // Join into a single string
            let result = sorted.joined()
            
            // Handle case when all numbers are zero (e.g. [0,0])
            if result.first == "0" {
                return "0"
            }
            
            return result
        }
        
        static func runDemo() {
            let nums1 = [10, 2]
            let nums2 = [3, 30, 34, 5, 9]
            let nums3 = [0, 0, 0]
            
            print("Input: \(nums1) → Output: \(largestNumber(nums1))")
            print("Input: \(nums2) → Output: \(largestNumber(nums2))")
            print("Input: \(nums3) → Output: \(largestNumber(nums3))")
        }
    }

    /*
     178. Rank Scores
     SQL Schema
     Pandas Schema
     Table: Scores

     +-------------+---------+
     | Column Name | Type    |
     +-------------+---------+
     | id          | int     |
     | score       | decimal |
     +-------------+---------+
     id is the primary key (column with unique values) for this table.
     Each row of this table contains the score of a game. Score is a floating point value with two decimal places.
      

     Write a solution to find the rank of the scores. The ranking should be calculated according to the following rules:

     The scores should be ranked from the highest to the lowest.
     If there is a tie between two scores, both should have the same ranking.
     After a tie, the next ranking number should be the next consecutive integer value. In other words, there should be no holes between ranks.
     Return the result table ordered by score in descending order.

     The result format is in the following example.

      

     Example 1:

     Input:
     Scores table:
     +----+-------+
     | id | score |
     +----+-------+
     | 1  | 3.50  |
     | 2  | 3.65  |
     | 3  | 4.00  |
     | 4  | 3.85  |
     | 5  | 4.00  |
     | 6  | 3.65  |
     +----+-------+
     Output:
     +-------+------+
     | score | rank |
     +-------+------+
     | 4.00  | 1    |
     | 4.00  | 1    |
     | 3.85  | 2    |
     | 3.65  | 3    |
     | 3.65  | 3    |
     | 3.50  | 4    |
     
     SELECT
         score,
         DENSE_RANK() OVER (ORDER BY score DESC) AS rank
     FROM Scores;
     */
    struct Score {
        let id: Int
        let score: Double
    }

    class RankScoresDemo {
        
        // Function to calculate ranks
        static func rankScores(_ scores: [Score]) -> [(score: Double, rank: Int)] {
            // Sort scores descending
            let sortedScores = scores.sorted { $0.score > $1.score }
            
            var results: [(Double, Int)] = []
            var rank = 1
            var prevScore: Double? = nil
            var rankOffset = 0
            
            for (_, item) in sortedScores.enumerated() {
                // If same score as previous -> same rank
                if let prev = prevScore, prev == item.score {
                    rankOffset += 1
                } else {
                    rank += rankOffset
                    rankOffset = 1
                }
                results.append((item.score, rank))
                prevScore = item.score
            }
            
            return results
        }
        
        static func runDemo() {
            // Sample data
            let scores = [
                Score(id: 1, score: 3.50),
                Score(id: 2, score: 3.65),
                Score(id: 3, score: 4.00),
                Score(id: 4, score: 3.85),
                Score(id: 5, score: 4.00),
                Score(id: 6, score: 3.65)
            ]
            
            // Get ranks
            let ranked = rankScores(scores)
            
            // Print results
            print("+-------+------+\n| score | rank |\n+-------+------+")

            for (score, rank) in ranked {
                print(String(format: "| %.2f  | %d    |", score, rank))
            }
            print("+-------+------+")
        }
    }
    
    /*
     177. Nth Highest Salary
     Medium
     Topics
     premium lock icon
     Companies
     SQL Schema
     Pandas Schema
     Table: Employee

     +-------------+------+
     | Column Name | Type |
     +-------------+------+
     | id          | int  |
     | salary      | int  |
     +-------------+------+
     id is the primary key (column with unique values) for this table.
     Each row of this table contains information about the salary of an employee.
      

     Write a solution to find the nth highest distinct salary from the Employee table. If there are less than n distinct salaries, return null.

     The result format is in the following example.

      

     Example 1:

     Input:
     Employee table:
     +----+--------+
     | id | salary |
     +----+--------+
     | 1  | 100    |
     | 2  | 200    |
     | 3  | 300    |
     +----+--------+
     n = 2
     Output:
     +------------------------+
     | getNthHighestSalary(2) |
     +------------------------+
     | 200                    |
     +------------------------+
     Example 2:

     Input:
     Employee table:
     +----+--------+
     | id | salary |
     +----+--------+
     | 1  | 100    |
     +----+--------+
     n = 2
     Output:
     +------------------------+
     | getNthHighestSalary(2) |
     +------------------------+
     | null                   |
     +------------------------+
     CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT AS
     BEGIN
       RETURN (
           SELECT DISTINCT salary
           FROM Employee
           ORDER BY salary DESC
           LIMIT 1 OFFSET N-1
       );
     END
     */
    class NthHighestSalaryDemo {
        
        // Function to get nth highest salary
        static func getNthHighestSalary(_ employees: [Employee], _ n: Int) -> Int? {
            // Extract unique salaries
            let uniqueSalaries = Array(Set(employees.map { $0.salary }))
            
            // Sort salaries descending
            let sortedSalaries = uniqueSalaries.sorted(by: >)
            
            // Return nth salary if exists, else nil
            if n <= sortedSalaries.count {
                return sortedSalaries[n - 1]
            } else {
                return nil
            }
        }
        
        static func runDemo() {
            // Sample Employee table
            let employees = [
                Employee(id: 1, salary: 100),
                Employee(id: 2, salary: 200),
                Employee(id: 3, salary: 300)
            ]
            
            // Choose n
            let n = 2
            
            // Get nth highest salary
            let result = getNthHighestSalary(employees, n)
            
            // Print result
            if let value = result {
                print("getNthHighestSalary(\(n)) | \(value)")
            } else {
                print("getNthHighestSalary(\(n)) | NULL")
            }
        }
    }
    /*
     176. Second Highest Salary
     SQL Schema
     Pandas Schema
     Table: Employee
     +-------------+------+
     | Column Name | Type |
     +-------------+------+
     | id          | int  |
     | salary      | int  |
     +-------------+------+
     id is the primary key (column with unique values) for this table.
     Each row of this table contains information about the salary of an employee.
     Write a solution to find the second highest distinct salary from the Employee table. If there is no second highest salary, return null (return None in Pandas).

     The result format is in the following example.
     Example 1:
     Input:
     Employee table:
     +----+--------+
     | id | salary |
     +----+--------+
     | 1  | 100    |
     | 2  | 200    |
     | 3  | 300    |
     +----+--------+
     Output:
     +---------------------+
     | SecondHighestSalary |
     +---------------------+
     | 200                 |
     +---------------------+
     Example 2:
     Input:
     Employee table:
     +----+--------+
     | id | salary |
     +----+--------+
     | 1  | 100    |
     +----+--------+
     Output:
     +---------------------+
     | SecondHighestSalary |
     +---------------------+
     | null                |
     +---------------------+
     */    
    struct Employee {
        let id: Int
        let salary: Int
    }

    class SecondHighestSalaryDemo {
        
        static func runDemo() {
            // Simulate Employee table
            let employees = [
                Employee(id: 1, salary: 100),
                Employee(id: 2, salary: 200),
                Employee(id: 3, salary: 300)
            ]
            
            // Extract unique salaries and sort descending
            let uniqueSalaries = Array(Set(employees.map { $0.salary })).sorted(by: >)
            
            // Get second highest if exists
            let secondHighest = uniqueSalaries.count > 1 ? uniqueSalaries[1] : nil
            
            // Print result
            if let value = secondHighest {
                print("SecondHighestSalary | \(value)")
            } else {
                print("SecondHighestSalary | NULL")
            }
        }
    }
    /*
     175. Combine Two Tables
     SQL Schema
     Pandas Schema
     Table: Person
     +-------------+---------+
     | Column Name | Type    |
     +-------------+---------+
     | personId    | int     |
     | lastName    | varchar |
     | firstName   | varchar |
     +-------------+---------+
     personId is the primary key (column with unique values) for this table.
     This table contains information about the ID of some persons and their first and last names.
     Table: Address
     +-------------+---------+
     | Column Name | Type    |
     +-------------+---------+
     | addressId   | int     |
     | personId    | int     |
     | city        | varchar |
     | state       | varchar |
     +-------------+---------+
     addressId is the primary key (column with unique values) for this table.
     Each row of this table contains information about the city and state of one person with ID = PersonId.
     Write a solution to report the first name, last name, city, and state of each person in the Person table. If the address of a personId is not present in the Address table, report null instead.
     Return the result table in any order.
     The result format is in the following example.
     Example 1:
     Input:
     Person table:
     +----------+----------+-----------+
     | personId | lastName | firstName |
     +----------+----------+-----------+
     | 1        | Wang     | Allen     |
     | 2        | Alice    | Bob       |
     +----------+----------+-----------+
     Address table:
     +-----------+----------+---------------+------------+
     | addressId | personId | city          | state      |
     +-----------+----------+---------------+------------+
     | 1         | 2        | New York City | New York   |
     | 2         | 3        | Leetcode      | California |
     +-----------+----------+---------------+------------+
     Output:
     +-----------+----------+---------------+----------+
     | firstName | lastName | city          | state    |
     +-----------+----------+---------------+----------+
     | Allen     | Wang     | Null          | Null     |
     | Bob       | Alice    | New York City | New York |
     +-----------+----------+---------------+----------+
     Explanation:
     There is no address in the address table for the personId = 1 so we return null in their city and state.
     addressId = 1 contains information about the address of personId = 2.
     */
    /*
     174. Dungeon Game
     The demons had captured the princess and imprisoned her in the bottom-right corner of a dungeon. The dungeon consists of m x n rooms laid out in a 2D grid. Our valiant knight was initially positioned in the top-left room and must fight his way through dungeon to rescue the princess.
     The knight has an initial health point represented by a positive integer. If at any point his health point drops to 0 or below, he dies immediately.
     Some of the rooms are guarded by demons (represented by negative integers), so the knight loses health upon entering these rooms; other rooms are either empty (represented as 0) or contain magic orbs that increase the knight's health (represented by positive integers).
     To reach the princess as quickly as possible, the knight decides to move only rightward or downward in each step.
     Return the knight's minimum initial health so that he can rescue the princess.
     Note that any room can contain threats or power-ups, even the first room the knight enters and the bottom-right room where the princess is imprisoned.
     Example 1:
     Input: dungeon = [[-2,-3,3],[-5,-10,1],[10,30,-5]]
     Output: 7
     Explanation: The initial health of the knight must be at least 7 if he follows the optimal path: RIGHT-> RIGHT -> DOWN -> DOWN.
     Example 2:

     Input: dungeon = [[0]]
     Output: 1
     */
    // Define Person model
    struct Person {
        let personId: Int
        let lastName: String
        let firstName: String
    }

    // Define Address model
    struct Address {
        let addressId: Int
        let personId: Int
        let city: String
        let state: String
    }

    class CombineTwoTablesDemo {
        
        static func runDemo() {
            // Simulate Person table
            let persons = [
                Person(personId: 1, lastName: "Wang", firstName: "Allen"),
                Person(personId: 2, lastName: "Alice", firstName: "Bob")
            ]
            
            // Simulate Address table
            let addresses = [
                Address(addressId: 1, personId: 2, city: "New York City", state: "New York"),
                Address(addressId: 2, personId: 3, city: "Leetcode", state: "California")
            ]
            
            // Combine using LEFT JOIN logic
            for person in persons {
                // Try to find matching address
                if let addr = addresses.first(where: { $0.personId == person.personId }) {
                    print("\(person.firstName) \(person.lastName) | \(addr.city), \(addr.state)")
                } else {
                    print("\(person.firstName) \(person.lastName) | NULL, NULL")
                }
            }
        }
    }
    
    class DungeonGame {
        static func calculateMinimumHP(_ dungeon: [[Int]]) -> Int {
            let m = dungeon.count
            let n = dungeon[0].count
            
            // DP table to store the minimum health needed at each cell
            var dp = Array(repeating: Array(repeating: Int.max, count: n + 1), count: m + 1)
            
            // Base case: health needed to reach princess (bottom-right)
            dp[m][n - 1] = 1
            dp[m - 1][n] = 1
            
            // Fill DP table from bottom-right to top-left
            for i in stride(from: m - 1, through: 0, by: -1) {
                for j in stride(from: n - 1, through: 0, by: -1) {
                    let minHealthOnExit = min(dp[i + 1][j], dp[i][j + 1])
                    dp[i][j] = max(1, minHealthOnExit - dungeon[i][j])
                }
            }
            
            return dp[0][0] // Minimum health needed to start
        }
        
        static func runDemo() {
            let dungeon1 = [[-2, -3, 3],
                            [-5, -10, 1],
                            [10, 30, -5]]
            print("Dungeon 1 minimum HP: \(calculateMinimumHP(dungeon1))") // 7
            
            let dungeon2 = [[0]]
            print("Dungeon 2 minimum HP: \(calculateMinimumHP(dungeon2))") // 1
        }
    }

    class Leetcode168_ExcelSheetColumnTitle {
        // Convert a given column number to its corresponding Excel column title.
        //
        // Example:
        // 1 -> "A"
        // 28 -> "AB"
        // 701 -> "ZY"
        //
        // Approach:
        // Excel columns are like base-26 numbers, but not exactly:
        // 'A' = 1 ... 'Z' = 26 (no zero, unlike normal base-26)
        //
        // To handle this, we repeatedly take (columnNumber - 1) % 26 to get the last character,
        // then divide columnNumber by 26 until it becomes zero.
        //
        // Time Complexity: O(log₍26₎N)
        // Space Complexity: O(1)
        
        static func convertToTitle(_ columnNumber: Int) -> String {
            var num = columnNumber
            var result = ""
            
            while num > 0 {
                // Subtract 1 because Excel column indexing starts from 1, not 0
                num -= 1
                let char = Character(UnicodeScalar(65 + (num % 26))!) // 'A' = 65 in ASCII
                result.insert(char, at: result.startIndex)
                num /= 26
            }
            
            return result
        }
        
        // Demo
        static func runDemo() {
            let tests = [1, 28, 701, 52, 2147483647]
            
            for num in tests {
                let title = convertToTitle(num)
                print("Input: \(num) -> Output: \"\(title)\"")
            }
        }
    }
    
    /*
     167. Two Sum II - Input Array Is Sorted
     Given a 1-indexed array of integers numbers that is already sorted in non-decreasing order, find two numbers such that they add up to a specific target number. Let these two numbers be numbers[index1] and numbers[index2] where 1 <= index1 < index2 <= numbers.length.
     Return the indices of the two numbers, index1 and index2, added by one as an integer array [index1, index2] of length 2.
     The tests are generated such that there is exactly one solution. You may not use the same element twice.
     Your solution must use only constant extra space.
     Example 1:
     Input: numbers = [2,7,11,15], target = 9
     Output: [1,2]
     Explanation: The sum of 2 and 7 is 9. Therefore, index1 = 1, index2 = 2. We return [1, 2].
     Example 2:
     Input: numbers = [2,3,4], target = 6
     Output: [1,3]
     Explanation: The sum of 2 and 4 is 6. Therefore index1 = 1, index2 = 3. We return [1, 3].
     Example 3:
     Input: numbers = [-1,0], target = -1
     Output: [1,2]
     Explanation: The sum of -1 and 0 is -1. Therefore index1 = 1, index2 = 2. We return [1, 2].
     */
    class Leetcode167_TwoSumII {
        // Given a sorted array, find two numbers that sum up to target.
        // Return their 1-based indices.
        //
        // Approach: Two Pointers
        // Time Complexity: O(n)
        // Space Complexity: O(1)
        
        static func twoSum(_ numbers: [Int], _ target: Int) -> [Int] {
            var left = 0
            var right = numbers.count - 1
            
            while left < right {
                let sum = numbers[left] + numbers[right]
                
                if sum == target {
                    // +1 because the problem uses 1-indexed array
                    return [left + 1, right + 1]
                } else if sum < target {
                    left += 1  // need a larger sum → move left pointer right
                } else {
                    right -= 1 // need a smaller sum → move right pointer left
                }
            }
            
            // Problem guarantees exactly one solution
            return []
        }
        
        // Demo
        static func runDemo() {
            let tests: [([Int], Int)] = [
                ([2, 7, 11, 15], 9),
                ([2, 3, 4], 6),
                ([-1, 0], -1),
                ([1, 2, 3, 4, 4, 9, 56, 90], 8)
            ]
            
            for (numbers, target) in tests {
                let result = twoSum(numbers, target)
                print("Input: numbers = \(numbers), target = \(target)")
                print("Output: \(result)\n")
            }
        }
    }
    /*
     166. Fraction to Recurring Decimal
     Given two integers representing the numerator and denominator of a fraction, return the fraction in string format.
     If the fractional part is repeating, enclose the repeating part in parentheses
     If multiple answers are possible, return any of them.
     It is guaranteed that the length of the answer string is less than 104 for all the given inputs.
     Note that if the fraction can be represented as a finite length string, you must return it.
     Example 1:
     Input: numerator = 1, denominator = 2
     Output: "0.5"
     Example 2:
     Input: numerator = 2, denominator = 1
     Output: "2"
     Example 3:
     Input: numerator = 4, denominator = 333
     Output: "0.(012)"
     */
    class Leetcode166_FractionToRecurringDecimal {
        // Convert fraction to decimal with recurring part in parentheses
        // Time Complexity: O(n), where n = length of recurring cycle (max 10^4 by problem statement)
        // Space Complexity: O(n) for hash map storing remainders
        
        static func fractionToDecimal(_ numerator: Int, _ denominator: Int) -> String {
            // Handle division by zero
            if denominator == 0 { return "NaN" }
            if numerator == 0 { return "0" }
            
            var num = numerator
            var den = denominator
            
            // Handle negative sign
            var result = ""
            if (num < 0) != (den < 0) {
                result += "-"
            }
            
            // Work with absolute values
            num = abs(num)
            den = abs(den)
            
            // Integer part
            let integerPart = num / den
            result += String(integerPart)
            
            // Remainder
            var remainder = num % den
            if remainder == 0 {
                return result  // no fractional part
            }
            
            result += "."
            
            // Dictionary to store remainder positions (for cycle detection)
            var remainderIndex: [Int: Int] = [:]
            var fractionPart = ""
            
            while remainder != 0 {
                if let index = remainderIndex[remainder] {
                    // Found a repeating remainder → insert parentheses
                    let start = fractionPart.index(fractionPart.startIndex, offsetBy: index)
                    let repeating = "(" + fractionPart[start...] + ")"
                    let nonRepeating = fractionPart[..<start]
                    result += nonRepeating + repeating
                    return result
                }
                
                // Record position of remainder
                remainderIndex[remainder] = fractionPart.count
                
                remainder *= 10
                let digit = remainder / den
                fractionPart += String(digit)
                remainder %= den
            }
            
            // No repeating part
            result += fractionPart
            return result
        }
        
        // Demo
        static func runDemo() {
            let tests = [
                (1, 2),
                (2, 1),
                (4, 333),
                (1, 6),
                (-50, 8),
                (1, 333),
                (-22, 7)
            ]
            
            for (num, den) in tests {
                let result = fractionToDecimal(num, den)
                print("\(num)/\(den) = \(result)")
            }
        }
    }
    /*
     165. Compare Version Numbers
     Given two version strings, version1 and version2, compare them. A version string consists of revisions separated by dots '.'. The value of the revision is its integer conversion ignoring leading zeros.
     To compare version strings, compare their revision values in left-to-right order. If one of the version strings has fewer revisions, treat the missing revision values as 0.
     Return the following:]
     If version1 < version2, return -1.
     If version1 > version2, return 1.
     Otherwise, return 0.
     Example 1:
     Input: version1 = "1.2", version2 = "1.10"
     Output: -1
     Explanation:
     version1's second revision is "2" and version2's second revision is "10": 2 < 10, so version1 < version2.
     Example 2:
     Input: version1 = "1.01", version2 = "1.001"
     Output: 0
     Explanation:
     Ignoring leading zeroes, both "01" and "001" represent the same integer "1".
     Example 3:
     Input: version1 = "1.0", version2 = "1.0.0.0"
     Output: 0
     Explanation:
     version1 has less revisions, which means every missing revision are treated as "0".
     */
    class Leetcode165_CompareVersionNumbers {
        // Compare two version strings
        // Time Complexity: O(n), n = total length of both version strings
        // Space Complexity: O(n) due to splitting into arrays
        static func compareVersion(_ version1: String, _ version2: String) -> Int {
            let v1 = version1.split(separator: ".").map { Int($0)! }
            let v2 = version2.split(separator: ".").map { Int($0)! }
            
            let maxLength = max(v1.count, v2.count)
            
            for i in 0..<maxLength {
                let num1 = i < v1.count ? v1[i] : 0
                let num2 = i < v2.count ? v2[i] : 0
                
                if num1 < num2 { return -1 }
                if num1 > num2 { return 1 }
            }
            
            return 0
        }
        
        // Demo method
        static func runDemo() {
            let tests = [
                ("1.2", "1.10"),
                ("1.01", "1.001"),
                ("1.0", "1.0.0.0"),
                ("1.0.33", "1.0.27")
            ]
            
            for (v1, v2) in tests {
                let result = compareVersion(v1, v2)
                print("Compare \(v1) vs \(v2) → \(result)")
            }
        }
    }
    /*
     164. Maximum Gap
     Given an integer array nums, return the maximum difference between two successive elements in its sorted form. If the array contains less than two elements, return 0.
     You must write an algorithm that runs in linear time and uses linear extra space.
     Example 1:
     Input: nums = [3,6,9,1]
     Output: 3
     Explanation: The sorted form of the array is [1,3,6,9], either (3,6) or (6,9) has the maximum difference 3.
     Example 2:
     Input: nums = [10]
     Output: 0
     Explanation: The array contains less than 2 elements, therefore return 0.
     Constraints:
     1 <= nums.length <= 105
     0 <= nums[i] <= 109
     */
    class MaximumGap {
        func maximumGap(_ nums: [Int]) -> Int {
            // If less than two numbers, no gap
            guard nums.count > 1 else { return 0 }

            // Find min and max in array
            let minVal = nums.min()!
            let maxVal = nums.max()!

            // If all numbers are the same, gap is zero
            if minVal == maxVal { return 0 }

            // Calculate bucket size and number of buckets
            let n = nums.count
            let bucketSize = max(1, (maxVal - minVal) / (n - 1))
            let bucketCount = (maxVal - minVal) / bucketSize + 1

            // Initialize buckets with nil values
            var bucketMin = Array(repeating: Int.max, count: bucketCount)
            var bucketMax = Array(repeating: Int.min, count: bucketCount)
            var bucketUsed = Array(repeating: false, count: bucketCount)

            // Distribute numbers into buckets
            for num in nums {
                let idx = (num - minVal) / bucketSize
                bucketMin[idx] = min(bucketMin[idx], num)
                bucketMax[idx] = max(bucketMax[idx], num)
                bucketUsed[idx] = true
            }

            // Find maximum gap between buckets
            var prevMax = minVal
            var maxGap = 0

            for i in 0..<bucketCount {
                if !bucketUsed[i] { continue } // skip empty bucket
                maxGap = max(maxGap, bucketMin[i] - prevMax)
                prevMax = bucketMax[i]
            }

            return maxGap
        }

        // Demo
        static func runDemo() {
            let solver = MaximumGap()
            print(solver.maximumGap([3,6,9,1]))  // 3
            print(solver.maximumGap([10]))       // 0
        }
    }
    /*
     155. Min Stack
     Design a stack that supports push, pop, top, and retrieving the minimum element in constant time.
     Implement the MinStack class:
     MinStack() initializes the stack object.
     void push(int val) pushes the element val onto the stack.
     void pop() removes the element on the top of the stack.
     int top() gets the top element of the stack.
     int getMin() retrieves the minimum element in the stack.
     You must implement a solution with O(1) time complexity for each function.
     Example 1:
     Input
     ["MinStack","push","push","push","getMin","pop","top","getMin"]
     [[],[-2],[0],[-3],[],[],[],[]]
     Output
     [null,null,null,null,-3,null,0,-2]
     Explanation
     MinStack minStack = new MinStack();
     minStack.push(-2);
     minStack.push(0);
     minStack.push(-3);
     minStack.getMin(); // return -3
     minStack.pop();
     minStack.top();    // return 0
     minStack.getMin(); // return -2
     Constraints:
     -231 <= val <= 231 - 1
     Methods pop, top and getMin operations will always be called on non-empty stacks.
     At most 3 * 104 calls will be made to push, pop, top, and getMin.
     */
    class MinStack {
        private var stack: [Int] = []
        private var minStack: [Int] = []

        init() {}

        // Push value onto the stack
        func push(_ val: Int) {
            stack.append(val)
            // Add new minimum (either val or previous min)
            if let currentMin = minStack.last {
                minStack.append(min(val, currentMin))
            } else {
                minStack.append(val)
            }
        }

        // Remove the top element
        func pop() {
            stack.removeLast()
            minStack.removeLast()
        }

        // Get the top element
        func top() -> Int {
            return stack.last!
        }

        // Retrieve the minimum element in constant time
        func getMin() -> Int {
            return minStack.last!
        }

        // Demo
        static func runDemo() {
            let minStack = MinStack()
            minStack.push(-2)
            minStack.push(0)
            minStack.push(-3)
            print(minStack.getMin()) // -3
            minStack.pop()
            print(minStack.top())    // 0
            print(minStack.getMin()) // -2
        }
    }
    /*
     154. Find Minimum in Rotated Sorted Array II
     Suppose an array of length n sorted in ascending order is rotated between 1 and n times. For example, the array nums = [0,1,4,4,5,6,7] might become:
     [4,5,6,7,0,1,4] if it was rotated 4 times.
     [0,1,4,4,5,6,7] if it was rotated 7 times.
     Notice that rotating an array [a[0], a[1], a[2], ..., a[n-1]] 1 time results in the array [a[n-1], a[0], a[1], a[2], ..., a[n-2]].
     Given the sorted rotated array nums that may contain duplicates, return the minimum element of this array.
     You must decrease the overall operation steps as much as possible.
     Example 1:
     Input: nums = [1,3,5]
     Output: 1
     Example 2:
     Input: nums = [2,2,2,0,1]
     Output: 0
     */
    class FindMinimumInRotatedSortedArrayII {
        // Find the minimum element in a rotated sorted array that may contain duplicates
        func findMin(_ nums: [Int]) -> Int {
            var left = 0
            var right = nums.count - 1

            // Modified binary search
            while left < right {
                let mid = (left + right) / 2

                if nums[mid] > nums[right] {
                    // Minimum is in the right half
                    left = mid + 1
                } else if nums[mid] < nums[right] {
                    // Minimum is in the left half including mid
                    right = mid
                } else {
                    // nums[mid] == nums[right], can't decide, reduce right
                    right -= 1
                }
            }

            // left == right -> points to the smallest element
            return nums[left]
        }

        // Demo
        static func runDemo() {
            let solver = FindMinimumInRotatedSortedArrayII()

            let nums1 = [1, 3, 5]
            let nums2 = [2, 2, 2, 0, 1]
            let nums3 = [10, 10, 10, 1, 10]
            let nums4 = [1, 1, 1, 1, 1]

            print(solver.findMin(nums1)) // Output: 1
            print(solver.findMin(nums2)) // Output: 0
            print(solver.findMin(nums3)) // Output: 1
            print(solver.findMin(nums4)) // Output: 1
        }
    }
    /*
     153. Find Minimum in Rotated Sorted Array
     Suppose an array of length n sorted in ascending order is rotated between 1 and n times. For example, the array nums = [0,1,2,4,5,6,7] might become:
     [4,5,6,7,0,1,2] if it was rotated 4 times.
     [0,1,2,4,5,6,7] if it was rotated 7 times.
     Notice that rotating an array [a[0], a[1], a[2], ..., a[n-1]] 1 time results in the array [a[n-1], a[0], a[1], a[2], ..., a[n-2]].
     Given the sorted rotated array nums of unique elements, return the minimum element of this array.
     You must write an algorithm that runs in O(log n) time.
     Example 1:
     Input: nums = [3,4,5,1,2]
     Output: 1
     Explanation: The original array was [1,2,3,4,5] rotated 3 times.
     Example 2:
     Input: nums = [4,5,6,7,0,1,2]
     Output: 0
     Explanation: The original array was [0,1,2,4,5,6,7] and it was rotated 4 times.
     Example 3:
     Input: nums = [11,13,15,17]
     Output: 11
     Explanation: The original array was [11,13,15,17] and it was rotated 4 times.
     Constraints:
     n == nums.length
     1 <= n <= 5000
     -5000 <= nums[i] <= 5000
     All the integers of nums are unique.
     */
    class FindMinimumInRotatedSortedArray {
        // Returns the minimum element in a rotated sorted array using binary search
        func findMin(_ nums: [Int]) -> Int {
            var left = 0
            var right = nums.count - 1

            // Binary search to find the point of rotation
            while left < right {
                let mid = (left + right) / 2
                
                // If middle element is greater than the rightmost,
                // then the smallest is to the right of mid
                if nums[mid] > nums[right] {
                    left = mid + 1
                } else {
                    // Otherwise, the smallest is at mid or to the left
                    right = mid
                }
            }

            // After loop, left == right, pointing to the minimum element
            return nums[left]
        }

        // Demo to test the solution
        static func runDemo() {
            let solver = FindMinimumInRotatedSortedArray()

            let nums1 = [3,4,5,1,2]
            let nums2 = [4,5,6,7,0,1,2]
            let nums3 = [11,13,15,17]

            print(solver.findMin(nums1)) // Output: 1
            print(solver.findMin(nums2)) // Output: 0
            print(solver.findMin(nums3)) // Output: 11
        }
    }

    /*
     152. Maximum Product Subarray
     Given an integer array nums, find a subarray that has the largest product, and return the product.
     The test cases are generated so that the answer will fit in a 32-bit integer.
     Example 1:
     Input: nums = [2,3,-2,4]
     Output: 6
     Explanation: [2,3] has the largest product 6.
     Example 2:
     Input: nums = [-2,0,-1]
     Output: 0
     Explanation: The result cannot be 2, because [-2,-1] is not a subarray.
     Constraints:
     1 <= nums.length <= 2 * 104
     -10 <= nums[i] <= 10
     The product of any subarray of nums is guaranteed to fit in a 32-bit integer.
     */
    class MaximumProductSubarrayDemo {
        
        // MARK: - Core solution
        func maxProduct(_ nums: [Int]) -> Int {
            // Edge case: if the array is empty
            guard !nums.isEmpty else { return 0 }
            
            // Initialize the current max, min, and global max with the first element.
            var currentMax = nums[0]
            var currentMin = nums[0]
            var result = nums[0]
            
            // Iterate through the array starting from the second element.
            for i in 1..<nums.count {
                let num = nums[i]
                
                // If the current number is negative, swap max and min
                // because multiplying by a negative flips signs.
                if num < 0 {
                    swap(&currentMax, &currentMin)
                }
                
                // Update current max and min considering the current number.
                currentMax = max(num, currentMax * num)
                currentMin = min(num, currentMin * num)
                
                // Update the global maximum product found so far.
                result = max(result, currentMax)
            }
            
            return result
        }
        
        // MARK: - Time and Space Complexity
        /*
         Time Complexity:  O(n)
           - We iterate through the array once, performing O(1) work per element.
         
         Space Complexity: O(1)
           - Only a few variables are used regardless of input size.
        */
        
        // MARK: - Demo
        static func runDemo() {
            let demo = MaximumProductSubarrayDemo()
            
            let nums1 = [2, 3, -2, 4]
            print("Input:", nums1)
            print("Output:", demo.maxProduct(nums1)) // Expected: 6
            
            let nums2 = [-2, 0, -1]
            print("\nInput:", nums2)
            print("Output:", demo.maxProduct(nums2)) // Expected: 0
            
            let nums3 = [-2, 3, -4]
            print("\nInput:", nums3)
            print("Output:", demo.maxProduct(nums3)) // Expected: 24
        }
    }
    /*
     151. Reverse Words in a String
     Given an input string s, reverse the order of the words.
     A word is defined as a sequence of non-space characters. The words in s will be separated by at least one space.
     Return a string of the words in reverse order concatenated by a single space.
     Note that s may contain leading or trailing spaces or multiple spaces between two words. The returned string should only have a single space separating the words. Do not include any extra spaces.
     Example 1:
     Input: s = "the sky is blue"
     Output: "blue is sky the"
     Example 2:
     Input: s = "  hello world  "
     Output: "world hello"
     Explanation: Your reversed string should not contain leading or trailing spaces.
     Example 3:
     Input: s = "a good   example"
     Output: "example good a"
     Explanation: You need to reduce multiple spaces between two words to a single space in the reversed string.
     Constraints:
     1 <= s.length <= 104
     s contains English letters (upper-case and lower-case), digits, and spaces ' '.
     There is at least one word in s.
     Follow-up: If the string data type is mutable in your language, can you solve it in-place with O(1) extra space?
     */
    class ReverseWordsInStringDemo {
        
        // MARK: - Core solution
        func reverseWords(_ s: String) -> String {
            // Split the input string by spaces.
            // The split() function automatically ignores extra spaces.
            let words = s.split(separator: " ")
            
            // Reverse the order of words.
            let reversed = words.reversed()
            
            // Join the reversed words using a single space as separator.
            return reversed.joined(separator: " ")
        }
        
        // MARK: - Time and Space Complexity
        /*
         Time Complexity:  O(n)
           - We scan the string once to split it into words.
           - Then we reverse the array and join it — all linear operations.
         
         Space Complexity: O(n)
           - We store an array of words and build a new output string.
        */
        
        // MARK: - Demo
        static func runDemo() {
            let demo = ReverseWordsInStringDemo()
            
            let input1 = "the sky is blue"
            print("Input: '\(input1)'")
            print("Output:", demo.reverseWords(input1)) // "blue is sky the"
            
            let input2 = "  hello world  "
            print("\nInput: '\(input2)'")
            print("Output:", demo.reverseWords(input2)) // "world hello"
            
            let input3 = "a good   example"
            print("\nInput: '\(input3)'")
            print("Output:", demo.reverseWords(input3)) // "example good a"
        }
    }
    /*
     150. Evaluate Reverse Polish Notation
     Medium
     Topics
     premium lock icon
     Companies
     You are given an array of strings tokens that represents an arithmetic expression in a Reverse Polish Notation.
     Evaluate the expression. Return an integer that represents the value of the expression.
     Note that:
     The valid operators are '+', '-', '*', and '/'.
     Each operand may be an integer or another expression.
     The division between two integers always truncates toward zero.
     There will not be any division by zero.
     The input represents a valid arithmetic expression in a reverse polish notation.
     The answer and all the intermediate calculations can be represented in a 32-bit integer.
     Example 1:
     Input: tokens = ["2","1","+","3","*"]
     Output: 9
     Explanation: ((2 + 1) * 3) = 9
     Example 2:
     Input: tokens = ["4","13","5","/","+"]
     Output: 6
     Explanation: (4 + (13 / 5)) = 6
     Example 3:
     Input: tokens = ["10","6","9","3","+","-11","*","/","*","17","+","5","+"]
     Output: 22
     Explanation: ((10 * (6 / ((9 + 3) * -11))) + 17) + 5
     = ((10 * (6 / (12 * -11))) + 17) + 5
     = ((10 * (6 / -132)) + 17) + 5
     = ((10 * 0) + 17) + 5
     = (0 + 17) + 5
     = 17 + 5
     = 22
     */
    class EvaluateReversePolishDemo {
        
        // MARK: - Core Algorithm
        func evalRPN(_ tokens: [String]) -> Int {
            var stack = [Int]()
            
            for token in tokens {
                switch token {
                case "+":
                    let b = stack.removeLast()
                    let a = stack.removeLast()
                    stack.append(a + b)
                case "-":
                    let b = stack.removeLast()
                    let a = stack.removeLast()
                    stack.append(a - b)
                case "*":
                    let b = stack.removeLast()
                    let a = stack.removeLast()
                    stack.append(a * b)
                case "/":
                    let b = stack.removeLast()
                    let a = stack.removeLast()
                    stack.append(a / b) // truncates toward zero automatically in Swift
                default:
                    stack.append(Int(token)!)
                }
            }
            return stack.last!
        }
        
        // MARK: - Demo
        static func runDemo() {
            let demo = EvaluateReversePolishDemo()
            
            let input1 = ["2","1","+","3","*"]
            print("Input:", input1)
            print("Output:", demo.evalRPN(input1)) // 9
            
            let input2 = ["4","13","5","/","+"]
            print("\nInput:", input2)
            print("Output:", demo.evalRPN(input2)) // 6
            
            let input3 = ["10","6","9","3","+","-11","*","/","*","17","+","5","+"]
            print("\nInput:", input3)
            print("Output:", demo.evalRPN(input3)) // 22
        }
    }
    /*
     149. Max Points on a Line
     Given an array of points where points[i] = [xi, yi] represents a point on the X-Y plane, return the maximum number of points that lie on the same straight line.
     Example 1:
     Input: points = [[1,1],[2,2],[3,3]]
     Output: 3
     Example 2:
     Input: points = [[1,1],[3,2],[5,3],[4,1],[2,3],[1,4]]
     Output: 4
     Constraints:
     1 <= points.length <= 300
     points[i].length == 2
     -104 <= xi, yi <= 104
     All the points are unique.
     time: O(n²) (each point is compared with each other)
     Memory: O(n) (for save slope-dicitonary)
     */
    class MaxPointsOnLineDemo {
        
        // MARK: - Core Algorithm
        func maxPoints(_ points: [[Int]]) -> Int {
            guard points.count > 2 else { return points.count }
            var result = 0
            
            for i in 0..<points.count {
                var slopes = [String: Int]() // store slope representation -> count
                var duplicates = 1            // count of identical points
                var verticals = 0             // count of vertical lines (same x)
                
                let (x1, y1) = (points[i][0], points[i][1])
                
                for j in i + 1..<points.count {
                    let (x2, y2) = (points[j][0], points[j][1])
                    
                    if x1 == x2 && y1 == y2 {
                        // identical points
                        duplicates += 1
                    } else if x1 == x2 {
                        // vertical line (infinite slope)
                        verticals += 1
                    } else {
                        // calculate slope as reduced fraction (dy/dx)
                        let dy = y2 - y1
                        let dx = x2 - x1
                        let g = gcd(dy, dx)
                        let key = "\(dy / g)/\(dx / g)"
                        slopes[key, default: 0] += 1
                    }
                }
                
                // max count among all slopes and verticals
                let localMax = max(verticals, slopes.values.max() ?? 0)
                result = max(result, localMax + duplicates)
            }
            return result
        }
        
        // Greatest Common Divisor helper
        private func gcd(_ a: Int, _ b: Int) -> Int {
            var a = abs(a), b = abs(b)
            while b != 0 {
                let temp = a % b
                a = b
                b = temp
            }
            return a
        }
        
        // MARK: - Demo
        static func runDemo() {
            let demo = MaxPointsOnLineDemo()
            
            let points1 = [[1,1],[2,2],[3,3]]
            print("Input:", points1)
            print("Output:", demo.maxPoints(points1)) // 3
            
            let points2 = [[1,1],[3,2],[5,3],[4,1],[2,3],[1,4]]
            print("\nInput:", points2)
            print("Output:", demo.maxPoints(points2)) // 4
        }
    }
    /*
     147. Insertion Sort List
     Given the head of a singly linked list, sort the list using insertion sort, and return the sorted list's head.
     The steps of the insertion sort algorithm:
     Insertion sort iterates, consuming one input element each repetition and growing a sorted output list.
     At each iteration, insertion sort removes one element from the input data, finds the location it belongs within the sorted list and inserts it there.
     It repeats until no input elements remain.
     The following is a graphical example of the insertion sort algorithm. The partially sorted list (black) initially contains only the first element in the list. One element (red) is removed from the input data and inserted in-place into the sorted list with each iteration.
     Example 1:
     Input: head = [4,2,1,3]
     Output: [1,2,3,4]
     Example 2:
     Input: head = [-1,5,3,4,0]
     Output: [-1,0,3,4,5]
     */
    /*
     146. LRU Cache
     Design a data structure that follows the constraints of a Least Recently Used (LRU) cache.
     Implement the LRUCache class:
     LRUCache(int capacity) Initialize the LRU cache with positive size capacity.
     int get(int key) Return the value of the key if the key exists, otherwise return -1.
     void put(int key, int value) Update the value of the key if the key exists. Otherwise, add the key-value pair to the cache. If the number of keys exceeds the capacity from this operation, evict the least recently used key.
     The functions get and put must each run in O(1) average time complexity.
     Example 1:
     Input
     ["LRUCache", "put", "put", "get", "put", "get", "put", "get", "get", "get"]
     [[2], [1, 1], [2, 2], [1], [3, 3], [2], [4, 4], [1], [3], [4]]
     Output
     [null, null, null, 1, null, -1, null, -1, 3, 4]
     Explanation
     LRUCache lRUCache = new LRUCache(2);
     lRUCache.put(1, 1); // cache is {1=1}
     lRUCache.put(2, 2); // cache is {1=1, 2=2}
     lRUCache.get(1);    // return 1
     lRUCache.put(3, 3); // LRU key was 2, evicts key 2, cache is {1=1, 3=3}
     lRUCache.get(2);    // returns -1 (not found)
     lRUCache.put(4, 4); // LRU key was 1, evicts key 1, cache is {4=4, 3=3}
     lRUCache.get(1);    // return -1 (not found)
     lRUCache.get(3);    // return 3
     lRUCache.get(4);    // return 4
     */
    class LRUAndInsertionSortDemo {
        
        // MARK: - 146. LRU Cache
        
        class LRUCache {
            private class Node {
                var key: Int
                var value: Int
                var prev: Node?
                var next: Node?
                init(_ key: Int, _ value: Int) {
                    self.key = key
                    self.value = value
                }
            }
            
            private var capacity: Int
            private var cache: [Int: Node] = [:]
            private var head: Node
            private var tail: Node
            
            init(_ capacity: Int) {
                self.capacity = capacity
                head = Node(0, 0)
                tail = Node(0, 0)
                head.next = tail
                tail.prev = head
            }
            
            func get(_ key: Int) -> Int {
                guard let node = cache[key] else { return -1 }
                moveToHead(node)
                return node.value
            }
            
            func put(_ key: Int, _ value: Int) {
                if let node = cache[key] {
                    node.value = value
                    moveToHead(node)
                } else {
                    let newNode = Node(key, value)
                    cache[key] = newNode
                    addToHead(newNode)
                    if cache.count > capacity {
                        if let removed = removeTail() {
                            cache.removeValue(forKey: removed.key)
                        }
                    }
                }
            }
            
            // Move an existing node to the front (most recently used)
            private func moveToHead(_ node: Node) {
                removeNode(node)
                addToHead(node)
            }
            
            // Add new node right after head
            private func addToHead(_ node: Node) {
                node.prev = head
                node.next = head.next
                head.next?.prev = node
                head.next = node
            }
            
            // Remove node from its current position
            private func removeNode(_ node: Node) {
                let prev = node.prev
                let next = node.next
                prev?.next = next
                next?.prev = prev
            }
            
            // Remove least recently used (from tail)
            private func removeTail() -> Node? {
                guard let node = tail.prev, node !== head else { return nil }
                removeNode(node)
                return node
            }
        }
        
        // MARK: - 147. Insertion Sort List
        
        class ListNode {
            var val: Int
            var next: ListNode?
            init(_ val: Int) { self.val = val }
        }
        
        func insertionSortList(_ head: ListNode?) -> ListNode? {
            let dummy = ListNode(0)
            var current = head
            
            while let node = current {
                var prev = dummy
                var next = dummy.next
                
                // Find correct place for insertion
                while let n = next, n.val < node.val {
                    prev = n
                    next = n.next
                }
                
                // Insert node between prev and next
                let nextUnsorted = node.next
                node.next = next
                prev.next = node
                current = nextUnsorted
            }
            return dummy.next
        }
        
        private func buildList(_ nums: [Int]) -> ListNode? {
            let dummy = ListNode(0)
            var current = dummy
            for num in nums {
                current.next = ListNode(num)
                current = current.next!
            }
            return dummy.next
        }
        
        private func toArray(_ head: ListNode?) -> [Int] {
            var res = [Int]()
            var curr = head
            while let node = curr {
                res.append(node.val)
                curr = node.next
            }
            return res
        }
        
        // MARK: - Demo
        
        static func runDemo() {
            print("=== 146. LRU Cache Demo ===")
            let lru = LRUCache(2)
            lru.put(1, 1)
            lru.put(2, 2)
            print(lru.get(1)) // 1
            lru.put(3, 3)     // evicts key 2
            print(lru.get(2)) // -1
            lru.put(4, 4)     // evicts key 1
            print(lru.get(1)) // -1
            print(lru.get(3)) // 3
            print(lru.get(4)) // 4
            
            print("\n=== 147. Insertion Sort List Demo ===")
            let demo = LRUAndInsertionSortDemo()
            let list1 = demo.buildList([4, 2, 1, 3])
            let sorted1 = demo.insertionSortList(list1)
            print(demo.toArray(sorted1)) // [1, 2, 3, 4]
            
            let list2 = demo.buildList([-1, 5, 3, 4, 0])
            let sorted2 = demo.insertionSortList(list2)
            print(demo.toArray(sorted2)) // [-1, 0, 3, 4, 5]
        }
    }

    /*
     140. Word Break II
     Given a string s and a dictionary of strings wordDict, add spaces in s to construct a sentence where each word is a valid dictionary word. Return all such possible sentences in any order.
     Note that the same word in the dictionary may be reused multiple times in the segmentation.
     Example 1:
     Input: s = "catsanddog", wordDict = ["cat","cats","and","sand","dog"]
     Output: ["cats and dog","cat sand dog"]
     Example 2:
     Input: s = "pineapplepenapple", wordDict = ["apple","pen","applepen","pine","pineapple"]
     Output: ["pine apple pen apple","pineapple pen apple","pine applepen apple"]
     Explanation: Note that you are allowed to reuse a dictionary word.
     Example 3:
     Input: s = "catsandog", wordDict = ["cats","dog","sand","and","cat"]
     Output: []
     Constraints:
     1 <= s.length <= 20
     1 <= wordDict.length <= 1000
     1 <= wordDict[i].length <= 10
     s and wordDict[i] consist of only lowercase English letters.
     All the strings of wordDict are unique.
     Input is generated in a way that the length of the answer doesn't exceed 105.     
     #139    Bool                               DP (array dp[i])
     #140    [String] — all possible option,    DFS +memory
     */
    class WordBreakII {
        
        func wordBreak(_ s: String, _ wordDict: [String]) -> [String] {
            let words = Set(wordDict)
            var memo = [String: [String]]()
            return dfs(s, words, &memo)
        }
        
        // DFS with memoization
        private func dfs(_ s: String, _ dict: Set<String>, _ memo: inout [String: [String]]) -> [String] {
            // If result already computed, return it
            if let cached = memo[s] {
                return cached
            }
            
            // Base case — empty string
            if s.isEmpty {
                return [""]
            }
            
            var result = [String]()
            
            // Try each word in the dictionary
            for word in dict {
                if s.hasPrefix(word) {
                    // Recurse on the remaining substring
                    let suffix = String(s.dropFirst(word.count))
                    let subSentences = dfs(suffix, dict, &memo)
                    
                    // Combine current word with recursive results
                    for sub in subSentences {
                        let space = sub.isEmpty ? "" : " "
                        result.append(word + space + sub)
                    }
                }
            }
            
            memo[s] = result
            return result
        }
        
        // Demo method
        static func runDemo() {
            let solver = WordBreakII()
            
            let s1 = "catsanddog"
            let dict1 = ["cat","cats","and","sand","dog"]
            print("Input: \(s1)")
            print("Output:", solver.wordBreak(s1, dict1)) // ["cats and dog", "cat sand dog"]
            
            let s2 = "pineapplepenapple"
            let dict2 = ["apple","pen","applepen","pine","pineapple"]
            print("Input: \(s2)")
            print("Output:", solver.wordBreak(s2, dict2))
            // ["pine apple pen apple", "pineapple pen apple", "pine applepen apple"]
            
            let s3 = "catsandog"
            let dict3 = ["cats","dog","sand","and","cat"]
            print("Input: \(s3)")
            print("Output:", solver.wordBreak(s3, dict3)) // []
        }
    }

    /*
     139. Word Break
     Given a string s and a dictionary of strings wordDict, return true if s can be segmented into a space-separated sequence of one or more dictionary words.
     Note that the same word in the dictionary may be reused multiple times in the segmentation.
     Example 1:
     Input: s = "leetcode", wordDict = ["leet","code"]
     Output: true
     Explanation: Return true because "leetcode" can be segmented as "leet code".
     Example 2:
     Input: s = "applepenapple", wordDict = ["apple","pen"]
     Output: true
     Explanation: Return true because "applepenapple" can be segmented as "apple pen apple".
     Note that you are allowed to reuse a dictionary word.
     Example 3:
     Input: s = "catsandog", wordDict = ["cats","dog","sand","and","cat"]
     Output: false
     Constraints:
     1 <= s.length <= 300
     1 <= wordDict.length <= 1000
     1 <= wordDict[i].length <= 20
     s and wordDict[i] consist of only lowercase English letters.
     All the strings of wordDict are unique.
     */
    class WordBreakSolver {
        
        // Main DP solution
        func wordBreak(_ s: String, _ wordDict: [String]) -> Bool {
            let n = s.count
            let words = Set(wordDict)   // For O(1) lookup
            let chars = Array(s)
            
            // dp[i] = true if substring s[0..<i] can be segmented
            var dp = Array(repeating: false, count: n + 1)
            dp[0] = true
            
            // Check all substrings
            for i in 1...n {
                for j in 0..<i {
                    if dp[j], words.contains(String(chars[j..<i])) {
                        dp[i] = true
                        break
                    }
                }
            }
            return dp[n]
        }
        
        // Demo method with test cases
        static func runDemo() {
            let solver = WordBreakSolver()
            
            let s1 = "leetcode"
            let dict1 = ["leet", "code"]
            print("Input: \(s1), dict: \(dict1) → \(solver.wordBreak(s1, dict1))") // true
            
            let s2 = "applepenapple"
            let dict2 = ["apple", "pen"]
            print("Input: \(s2), dict: \(dict2) → \(solver.wordBreak(s2, dict2))") // true
            
            let s3 = "catsandog"
            let dict3 = ["cats", "dog", "sand", "and", "cat"]
            print("Input: \(s3), dict: \(dict3) → \(solver.wordBreak(s3, dict3))") // false
        }
    }

    /*
     138. Copy List with Random Pointer
     A linked list of length n is given such that each node contains an additional random pointer, which could point to any node in the list, or null.
     Construct a deep copy of the list. The deep copy should consist of exactly n brand new nodes, where each new node has its value set to the value of its corresponding original node. Both the next and random pointer of the new nodes should point to new nodes in the copied list such that the pointers in the original list and copied list represent the same list state. None of the pointers in the new list should point to nodes in the original list.
     For example, if there are two nodes X and Y in the original list, where X.random --> Y, then for the corresponding two nodes x and y in the copied list, x.random --> y.
     Return the head of the copied linked list.
     The linked list is represented in the input/output as a list of n nodes. Each node is represented as a pair of [val, random_index] where:
     val: an integer representing Node.val
     random_index: the index of the node (range from 0 to n-1) that the random pointer points to, or null if it does not point to any node.
     Your code will only be given the head of the original linked list.
     Example 1:
     Input: head = [[7,null],[13,0],[11,4],[10,2],[1,0]]
     Output: [[7,null],[13,0],[11,4],[10,2],[1,0]]
     Example 2:
     Input: head = [[1,1],[2,1]]
     Output: [[1,1],[2,1]]
     Example 3:
     Input: head = [[3,null],[3,0],[3,null]]
     Output: [[3,null],[3,0],[3,null]]
     Constraints:
     0 <= n <= 1000
     -104 <= Node.val <= 104
     */
    class CopyListWithRandomPointer {
        
        class Node {
            var val: Int
            var next: Node?
            var random: Node?
            init(_ val: Int) {
                self.val = val
                self.next = nil
                self.random = nil
            }
        }
        
        // Main function: Deep copy of the list
        func copyRandomList(_ head: Node?) -> Node? {
            guard let head = head else { return nil }
            
            // Step 1: Create mapping old -> new node
            var map = [ObjectIdentifier: Node]()
            var current: Node? = head
            while let node = current {
                map[ObjectIdentifier(node)] = Node(node.val)
                current = node.next
            }
            
            // Step 2: Assign next and random pointers
            current = head
            while let node = current {
                let newNode = map[ObjectIdentifier(node)]!
                newNode.next = node.next != nil ? map[ObjectIdentifier(node.next!)] : nil
                newNode.random = node.random != nil ? map[ObjectIdentifier(node.random!)] : nil
                current = node.next
            }
            
            // Step 3: Return copied head
            return map[ObjectIdentifier(head)]
        }
        
        // Demo method with a simple test
        static func runDemo() {
            let solver = CopyListWithRandomPointer()
            
            // Create sample list: 7 -> 13 -> 11 -> 10 -> 1
            let n1 = Node(7)
            let n2 = Node(13)
            let n3 = Node(11)
            let n4 = Node(10)
            let n5 = Node(1)
            n1.next = n2
            n2.next = n3
            n3.next = n4
            n4.next = n5
            
            // Random pointers
            n2.random = n1
            n3.random = n5
            n4.random = n3
            n5.random = n1
            
            print("Original list:")
            printList(n1)
            
            if let copiedHead = solver.copyRandomList(n1) {
                print("\nCopied list:")
                printList(copiedHead)
            }
        }
        
        // Helper to print list with random pointers
        static func printList(_ head: Node?) {
            var current = head
            while let node = current {
                let randVal = node.random?.val != nil ? "\(node.random!.val)" : "nil"
                print("Node \(node.val) → random \(randVal)")
                current = node.next
            }
        }
    }

    /*
     137. Single Number II
     Given an integer array nums where every element appears three times except for one, which appears exactly once. Find the single element and return it.
     You must implement a solution with a linear runtime complexity and use only constant extra space.
     Example 1:
     Input: nums = [2,2,3,2]
     Output: 3
     Example 2:
     Input: nums = [0,1,0,1,0,1,99]
     Output: 99
     Constraints:
     1 <= nums.length <= 3 * 104
     -231 <= nums[i] <= 231 - 1
     Each element in nums appears exactly three times except for one element which appears once.
     */
    class SingleNumberII {
        // Bitwise logic: track bits that appear once and twice
        func singleNumber(_ nums: [Int]) -> Int {
            var ones = 0    // bits that appeared once
            var twos = 0    // bits that appeared twice
            
            for num in nums {
                // 'ones' keeps bits that have appeared 1st or 4th time
                ones = (ones ^ num) & ~twos
                // 'twos' keeps bits that have appeared 2nd or 5th time
                twos = (twos ^ num) & ~ones
            }
            
            return ones  // only bits that appeared once remain
        }
        
        // Demo with test examples
        static func runDemo() {
            let solver = SingleNumberII()
            
            let nums1 = [2,2,3,2]
            print("Example 1:", solver.singleNumber(nums1)) // Expected 3
            
            let nums2 = [0,1,0,1,0,1,99]
            print("Example 2:", solver.singleNumber(nums2)) // Expected 99
        }
    }
    /*
     136. Single Number
     Given a non-empty array of integers nums, every element appears twice except for one. Find that single one.
     You must implement a solution with a linear runtime complexity and use only constant extra space.
     Example 1:
     Input: nums = [2,2,1]
     Output: 1
     Example 2:
     Input: nums = [4,1,2,1,2]
     Output: 4
     Example 3:
     Input: nums = [1]
     Output: 1
     Constraints:
     1 <= nums.length <= 3 * 104
     -3 * 104 <= nums[i] <= 3 * 104
     Each element in the array appears twice except for one element which appears only once.
     */
    class SingleNumber {
        // Function to find the single number
        // Uses XOR property: a^a = 0, a^0 = a
        func singleNumber(_ nums: [Int]) -> Int {
            var result = 0
            for num in nums {
                result ^= num  // cancel out pairs, only single stays
            }
            return result
        }
        
        // Demo with examples
        static func runDemo() {
            let solver = SingleNumber()
            
            let nums1 = [2,2,1]
            print("Example 1:", solver.singleNumber(nums1)) // Expected 1
            
            let nums2 = [4,1,2,1,2]
            print("Example 2:", solver.singleNumber(nums2)) // Expected 4
            
            let nums3 = [1]
            print("Example 3:", solver.singleNumber(nums3)) // Expected 1
        }
    }

    /*
     135. Candy
     There are n children standing in a line. Each child is assigned a rating value given in the integer array ratings.
     You are giving candies to these children subjected to the following requirements:
     Each child must have at least one candy.
     Children with a higher rating get more candies than their neighbors.
     Return the minimum number of candies you need to have to distribute the candies to the children.
     Example 1:
     Input: ratings = [1,0,2]
     Output: 5
     Explanation: You can allocate to the first, second and third child with 2, 1, 2 candies respectively.
     Example 2:
     Input: ratings = [1,2,2]
     Output: 4
     Explanation: You can allocate to the first, second and third child with 1, 2, 1 candies respectively.
     The third child gets 1 candy because it satisfies the above two conditions.
     */
    class Candy {
        // Main function to calculate minimum candies
        func candy(_ ratings: [Int]) -> Int {
            let n = ratings.count
            if n == 0 { return 0 }
            
            // Each child gets at least 1 candy initially
            var candies = Array(repeating: 1, count: n)
            
            // Pass 1: left to right
            // If current rating > previous rating, give 1 more candy than previous child
            for i in 1..<n {
                if ratings[i] > ratings[i - 1] {
                    candies[i] = candies[i - 1] + 1
                }
            }
            
            // Pass 2: right to left
            // If current rating > next rating, give max of current and (next + 1)
            for i in stride(from: n - 2, through: 0, by: -1) {
                if ratings[i] > ratings[i + 1] {
                    candies[i] = max(candies[i], candies[i + 1] + 1)
                }
            }
            
            // Sum of all candies
            return candies.reduce(0, +)
        }
        
        // Demo with examples
        static func runDemo() {
            let solver = Candy()
            
            let ratings1 = [1,0,2]
            print("Example 1:", solver.candy(ratings1)) // Expected 5
            
            let ratings2 = [1,2,2]
            print("Example 2:", solver.candy(ratings2)) // Expected 4
        }
    }
    /*
     134. Gas Station O(n) time и O(1) memory.
     There are n gas stations along a circular route, where the amount of gas at the ith station is gas[i].
     You have a car with an unlimited gas tank and it costs cost[i] of gas to travel from the ith station to its next (i + 1)th station. You begin the journey with an empty tank at one of the gas stations.
     Given two integer arrays gas and cost, return the starting gas station's index if you can travel around the circuit once in the clockwise direction, otherwise return -1. If there exists a solution, it is guaranteed to be unique.
     Example 1:
     Input: gas = [1,2,3,4,5], cost = [3,4,5,1,2]
     Output: 3
     Explanation:
     Start at station 3 (index 3) and fill up with 4 unit of gas. Your tank = 0 + 4 = 4
     Travel to station 4. Your tank = 4 - 1 + 5 = 8
     Travel to station 0. Your tank = 8 - 2 + 1 = 7
     Travel to station 1. Your tank = 7 - 3 + 2 = 6
     Travel to station 2. Your tank = 6 - 4 + 3 = 5
     Travel to station 3. The cost is 5. Your gas is just enough to travel back to station 3.
     Therefore, return 3 as the starting index.
     Example 2:
     Input: gas = [2,3,4], cost = [3,4,3]
     Output: -1
     Explanation:
     You can't start at station 0 or 1, as there is not enough gas to travel to the next station.
     Let's start at station 2 and fill up with 4 unit of gas. Your tank = 0 + 4 = 4
     Travel to station 0. Your tank = 4 - 3 + 2 = 3
     Travel to station 1. Your tank = 3 - 3 + 3 = 3
     You cannot travel back to station 2, as it requires 4 unit of gas but you only have 3.
     Therefore, you can't travel around the circuit once no matter where you start.
     Constraints:
     n == gas.length == cost.length
     1 <= n <= 105
     0 <= gas[i], cost[i] <= 104
     The input is generated such that the answer is unique.
     */
    class GasStation {
        // Main algorithm: find the starting gas station index
        func canCompleteCircuit(_ gas: [Int], _ cost: [Int]) -> Int {
            let n = gas.count
            var total = 0       // total gas - cost over all stations
            var tank = 0        // current tank during traversal
            var start = 0       // candidate start index
            
            for i in 0..<n {
                let diff = gas[i] - cost[i]
                total += diff
                tank += diff
                
                // If tank < 0, reset start position and tank
                if tank < 0 {
                    start = i + 1
                    tank = 0
                }
            }
            
            return total >= 0 ? start : -1
        }
        
        // Demo method to test the solution
        static func runDemo() {
            let solver = GasStation()
            let gas1 = [1,2,3,4,5]
            let cost1 = [3,4,5,1,2]
            print("Example 1:", solver.canCompleteCircuit(gas1, cost1)) // Expected: 3
            
            let gas2 = [2,3,4]
            let cost2 = [3,4,3]
            print("Example 2:", solver.canCompleteCircuit(gas2, cost2)) // Expected: -1
        }
    }

    /*
     133. Clone Graph
     Given a reference of a node in a connected undirected graph.
     Return a deep copy (clone) of the graph.
     Each node in the graph contains a value (int) and a list (List[Node]) of its neighbors.
     class Node {
         public int val;
         public List<Node> neighbors;
     }
     Test case format:
     For simplicity, each node's value is the same as the node's index (1-indexed). For example, the first node with val == 1, the second node with val == 2, and so on. The graph is represented in the test case using an adjacency list.
     An adjacency list is a collection of unordered lists used to represent a finite graph. Each list describes the set of neighbors of a node in the graph.

     The given node will always be the first node with val = 1. You must return the copy of the given node as a reference to the cloned graph.
     Example 1:
     Input: adjList = [[2,4],[1,3],[2,4],[1,3]]
     Output: [[2,4],[1,3],[2,4],[1,3]]
     Explanation: There are 4 nodes in the graph.
     1st node (val = 1)'s neighbors are 2nd node (val = 2) and 4th node (val = 4).
     2nd node (val = 2)'s neighbors are 1st node (val = 1) and 3rd node (val = 3).
     3rd node (val = 3)'s neighbors are 2nd node (val = 2) and 4th node (val = 4).
     4th node (val = 4)'s neighbors are 1st node (val = 1) and 3rd node (val = 3).
     Example 2:
     Input: adjList = [[]]
     Output: [[]]
     Explanation: Note that the input contains one empty list. The graph consists of only one node with val = 1 and it does not have any neighbors.
     Example 3:

     Input: adjList = []
     Output: []
     Explanation: This an empty graph, it does not have any nodes.
     Constraints:
     The number of nodes in the graph is in the range [0, 100].
     1 <= Node.val <= 100
     Node.val is unique for each node.
     There are no repeated edges and no self-loops in the graph.
     The Graph is connected and all nodes can be visited starting from the given node.
     */
    public class NodeGraph {
        public var val: Int
        public var neighbors: [NodeGraph?]
        public init(_ val: Int) {
            self.val = val
            self.neighbors = []
        }
    }
    
    class CloneGraph {
        func cloneGraph(_ node: NodeGraph?) -> NodeGraph? {
            guard let node = node else { return nil }
            
            var visited = [Int: NodeGraph]()
            
            func dfs(_ current: NodeGraph) -> NodeGraph {
                if let cloned = visited[current.val] {
                    return cloned
                }
                
                let clone = NodeGraph(current.val)
                visited[current.val] = clone
                
                for neighbor in current.neighbors {
                    if let neighbor = neighbor {
                        clone.neighbors.append(dfs(neighbor))
                    }
                }
                return clone
            }
            
            return dfs(node)
        }
    }
    
    /*
     132. Palindrome Partitioning II
     Given a string s, partition s such that every substring of the partition is a palindrome.
     Return the minimum cuts needed for a palindrome partitioning of s.
     Example 1:
     Input: s = "aab"
     Output: 1
     Explanation: The palindrome partitioning ["aa","b"] could be produced using 1 cut.
     Example 2:
     Input: s = "a"
     Output: 0
     Example 3:
     Input: s = "ab"
     Output: 1
     Constraints:
     1 <= s.length <= 2000
     s consists of lowercase English letters only.
     */
    class PalindromePartitioningII {
        func minCut(_ s: String) -> Int {
            let n = s.count
            let chars = Array(s)
            
            // Precompute palindrome table
            var isPal = Array(repeating: Array(repeating: false, count: n), count: n)
            for len in 1...n {
                for i in 0...(n - len) {
                    let j = i + len - 1
                    if chars[i] == chars[j] {
                        if len <= 2 {
                            isPal[i][j] = true
                        } else {
                            isPal[i][j] = isPal[i+1][j-1]
                        }
                    }
                }
            }
            
            // dp[i] = min cuts for s[0...i]
            var dp = Array(repeating: Int.max, count: n)
            for i in 0..<n {
                if isPal[0][i] {
                    dp[i] = 0
                } else {
                    for j in 0..<i {
                        if isPal[j+1][i] {
                            dp[i] = min(dp[i], dp[j] + 1)
                        }
                    }
                }
            }
            
            return dp[n-1]
        }
        static func run() {
            let sol = Solution.PalindromePartitioningII()
            print(sol.minCut("aab"))
            print(sol.minCut("a"))
            print(sol.minCut("ab"))
        }
        //    Complexity:
        //    Time: O(n^2)
        //      calculate polindrom        O(n^2)
        //      fill dp O(n^2)
    }
    
    
    
    /*
     131. Palindrome Partitioning
     Given a string s, partition s such that every substring of the partition is a palindrome. Return all possible palindrome partitioning of s.
     Example 1:
     Input: s = "aab"
     Output: [["a","a","b"],["aa","b"]]
     Example 2:
     Input: s = "a"
     Output: [["a"]]
     Constraints:
     1 <= s.length <= 16
     s contains only lowercase English letters.
     */
    class PalindromePartitioning {
        // Main function
        func partition(_ s: String) -> [[String]] {
            var result = [[String]]()
            var path = [String]()
            let chars = Array(s)

            // Backtracking helper
            func backtrack(_ start: Int) {
                if start == chars.count {
                    result.append(path)
                    return
                }

                for end in start..<chars.count {
                    if isPalindrome(chars, start, end) {
                        let substring = String(chars[start...end])
                        path.append(substring)
                        backtrack(end + 1)
                        path.removeLast()
                    }
                }
            }

            backtrack(0)
            return result
        }

        // Check if substring s[l...r] is palindrome
        private func isPalindrome(_ chars: [Character], _ l: Int, _ r: Int) -> Bool {
            var left = l
            var right = r
            while left < right {
                if chars[left] != chars[right] {
                    return false
                }
                left += 1
                right -= 1
            }
            return true
        }
        
        static func demo() {
            let input = "aab"
            let solution = PalindromePartitioning()
            let result = solution.partition(input)
            print("Palindrome Partitioning of \(input): \(result)")
        }
    }


    /*
     130. Surrounded Regions
     You are given an m x n matrix board containing letters 'X' and 'O', capture regions that are surrounded:
    Connect: A cell is connected to adjacent cells horizontally or vertically.
     Region: To form a region connect every 'O' cell.
     Surround: The region is surrounded with 'X' cells if you can connect the region with 'X' cells and none of the region cells are on the edge of the board.
     To capture a surrounded region, replace all 'O's with 'X's in-place within the original board. You do not need to return anything.
     Example 1:
     Input: board = [
     ["X","X","X","X"],
     ["X","O","O","X"],
     ["X","X","O","X"],
     ["X","O","X","X"]]
     Output: [
     ["X","X","X","X"],
     ["X","X","X","X"],
     ["X","X","X","X"],
     ["X","O","X","X"]]
     Explanation:
     In the above diagram, the bottom region is not captured because it is on the edge of the board and cannot be surrounded.
     Example 2:
     Input: board = [["X"]]
     Output: [["X"]]
     Comparison:
     DFS
     Pros: Easy to implement, clean recursion.
     Cons: Risk of stack overflow if m × n is very large (deep recursion).
     Space: O(m × n) recursion stack in the worst case.
     BFS
     Pros: No recursion, safe from stack overflow.
     Cons: Queue might hold many nodes (but still O(m × n)).
     Space: O(m × n) for queue in the worst case.
     Time Complexity (both): O(m × n).
     */
    class SurroundedRegions {
        // MARK: - DFS Approach
        func solveDFS(_ board: inout [[Character]]) {
            guard !board.isEmpty else { return }
            let m = board.count
            let n = board[0].count
            
            // Recursive DFS helper
            func dfs(_ row: Int, _ col: Int) {
                if row < 0 || col < 0 || row >= m || col >= n || board[row][col] != "O" {
                    return
                }
                board[row][col] = "S" // mark as safe
                dfs(row + 1, col)
                dfs(row - 1, col)
                dfs(row, col + 1)
                dfs(row, col - 1)
            }
            
            // Step 1: Start DFS from border 'O's
            for i in 0..<m {
                dfs(i, 0)
                dfs(i, n - 1)
            }
            for j in 0..<n {
                dfs(0, j)
                dfs(m - 1, j)
            }
            
            // Step 2: Flip remaining 'O' → 'X', revert 'S' → 'O'
            for i in 0..<m {
                for j in 0..<n {
                    if board[i][j] == "O" {
                        board[i][j] = "X"
                    } else if board[i][j] == "S" {
                        board[i][j] = "O"
                    }
                }
            }
        }
        
        // MARK: - BFS Approach
        func solveBFS(_ board: inout [[Character]]) {
            guard !board.isEmpty else { return }
            let m = board.count
            let n = board[0].count
            
            var queue = [(Int, Int)]()
            
            // Helper to enqueue valid 'O' cells
            func enqueue(_ row: Int, _ col: Int) {
                if row >= 0 && col >= 0 && row < m && col < n && board[row][col] == "O" {
                    board[row][col] = "S" // mark as safe
                    queue.append((row, col))
                }
            }
            
            // Step 1: Add all border 'O's to the queue
            for i in 0..<m {
                enqueue(i, 0)
                enqueue(i, n - 1)
            }
            for j in 0..<n {
                enqueue(0, j)
                enqueue(m - 1, j)
            }
            
            // Step 2: BFS traversal
            let directions = [(1,0), (-1,0), (0,1), (0,-1)]
            while !queue.isEmpty {
                let (row, col) = queue.removeFirst()
                for (dr, dc) in directions {
                    enqueue(row + dr, col + dc)
                }
            }
            
            // Step 3: Flip remaining 'O' → 'X', revert 'S' → 'O'
            for i in 0..<m {
                for j in 0..<n {
                    if board[i][j] == "O" {
                        board[i][j] = "X"
                    } else if board[i][j] == "S" {
                        board[i][j] = "O"
                    }
                }
            }
        }
    }
    /*
     129. Sum Root to Leaf Numbers
     You are given the root of a binary tree containing digits from 0 to 9 only.
     Each root-to-leaf path in the tree represents a number.
     For example, the root-to-leaf path 1 -> 2 -> 3 represents the number 123.
     Return the total sum of all root-to-leaf numbers. Test cases are generated so that the answer will fit in a 32-bit integer.
     A leaf node is a node with no children.
     Example 1:
     Input: root = [1,2,3]
     Output: 25
     Explanation:
     The root-to-leaf path 1->2 represents the number 12.
     The root-to-leaf path 1->3 represents the number 13.
     Therefore, sum = 12 + 13 = 25.
     Example 2:
     Input: root = [4,9,0,5,1]
     Output: 1026
     Explanation:
     The root-to-leaf path 4->9->5 represents the number 495.
     The root-to-leaf path 4->9->1 represents the number 491.
     The root-to-leaf path 4->0 represents the number 40.
     Therefore, sum = 495 + 491 + 40 = 1026.
     Constraints:
     The number of nodes in the tree is in the range [1, 1000].
     0 <= Node.val <= 9
     The depth of the tree will not exceed 10.
     */
    class SumRootToLeafNumbers {
        func sumNumbers(_ root: TreeNode?) -> Int {
            return dfs(root, 0)
        }
        
        // DFS helper
        private func dfs(_ node: TreeNode?, _ current: Int) -> Int {
            guard let node = node else { return 0 }
            
            // Update the current number
            let newNumber = current * 10 + node.val
            
            // If it's a leaf, return the number
            if node.left == nil && node.right == nil {
                return newNumber
            }
            
            // Otherwise, continue to left and right children
            return dfs(node.left, newNumber) + dfs(node.right, newNumber)
        }
    }
    /*
     128. Longest Consecutive Sequence
     Given an unsorted array of integers nums, return the length of the longest consecutive elements sequence.
     You must write an algorithm that runs in O(n) time.
     Example 1:
     Input: nums = [100,4,200,1,3,2]
     Output: 4
     Explanation: The longest consecutive elements sequence is [1, 2, 3, 4]. Therefore its length is 4.
     Example 2:
     Input: nums = [0,3,7,2,5,8,4,6,0,1]
     Output: 9
     Example 3:
     Input: nums = [1,0,1,2]
     Output: 3
     */
    class LongestConsecutiveSequence {
        func longestConsecutive(_ nums: [Int]) -> Int {
            let numSet = Set(nums)
            var longest = 0
            
            for num in numSet {
                // Check if this number is the start of a sequence
                if !numSet.contains(num - 1) {
                    var currentNum = num
                    var currentStreak = 1
                    
                    // Expand the sequence to the right
                    while numSet.contains(currentNum + 1) {
                        currentNum += 1
                        currentStreak += 1
                    }
                    
                    longest = max(longest, currentStreak)
                }
            }
            
            return longest
        }
    }

    /*
     126. Word Ladder II
     A transformation sequence from word beginWord to word endWord using a dictionary wordList is a sequence of words beginWord -> s1 -> s2 -> ... -> sk such that:
     Every adjacent pair of words differs by a single letter.
     Every si for 1 <= i <= k is in wordList. Note that beginWord does not need to be in wordList.
     sk == endWord
     Given two words, beginWord and endWord, and a dictionary wordList, return all the shortest transformation sequences from beginWord to endWord, or an empty list if no such sequence exists. Each sequence should be returned as a list of the words [beginWord, s1, s2, ..., sk].
     Example 1:
     Input: beginWord = "hit", endWord = "cog", wordList = ["hot","dot","dog","lot","log","cog"]
     Output: [["hit","hot","dot","dog","cog"],["hit","hot","lot","log","cog"]]
     Explanation: There are 2 shortest transformation sequences:
     "hit" -> "hot" -> "dot" -> "dog" -> "cog"
     "hit" -> "hot" -> "lot" -> "log" -> "cog"
     Example 2:
     Input: beginWord = "hit", endWord = "cog", wordList = ["hot","dot","dog","lot","log"]
     Output: []
     Explanation: The endWord "cog" is not in wordList, therefore there is no valid transformation sequence.
     Constraints:
     1 <= beginWord.length <= 5
     endWord.length == beginWord.length
     1 <= wordList.length <= 500
     wordList[i].length == beginWord.length
     beginWord, endWord, and wordList[i] consist of lowercase English letters.
     beginWord != endWord
     All the words in wordList are unique.
     The sum of all shortest transformation sequences does not exceed 105.
     */
    class WordLadderII {
        func findLadders(_ beginWord: String, _ endWord: String, _ wordList: [String]) -> [[String]] {
            let wordSet = Set(wordList)
            if !wordSet.contains(endWord) { return [] }
            
            // Adjacency list for shortest paths
            var graph = [String: [String]]()
            var levels = [String: Int]()  // distance (BFS level) from beginWord
            
            // BFS queue
            var queue = [beginWord]
            levels[beginWord] = 0
            var foundEnd = false
            var step = 0
            
            while !queue.isEmpty && !foundEnd {
                step += 1
                var nextQueue = [String]()
                
                for word in queue {
                    var chars = Array(word)
                    for i in 0..<chars.count {
                        let oldChar = chars[i]
                        for c in "abcdefghijklmnopqrstuvwxyz" {
                            chars[i] = c
                            let newWord = String(chars)
                            if wordSet.contains(newWord) {
                                if levels[newWord] == nil { // first time seen
                                    levels[newWord] = step
                                    nextQueue.append(newWord)
                                }
                                if levels[newWord] == step { // only connect same level
                                    graph[word, default: []].append(newWord)
                                }
                                if newWord == endWord {
                                    foundEnd = true
                                }
                            }
                        }
                        chars[i] = oldChar
                    }
                }
                queue = nextQueue
            }
            
            var results = [[String]]()
            if foundEnd {
                var path = [beginWord]
                dfs(beginWord, endWord, &path, &results, graph)
            }
            
            return results
        }
        
        // DFS to collect all paths
        private func dfs(_ word: String, _ endWord: String,
                         _ path: inout [String],
                         _ results: inout [[String]],
                         _ graph: [String: [String]]) {
            if word == endWord {
                results.append(path)
                return
            }
            guard let neighbors = graph[word] else { return }
            
            for next in neighbors {
                path.append(next)
                dfs(next, endWord, &path, &results, graph)
                path.removeLast()
            }
        }
        static func demo() {
            let solver = WordLadderII()
            print(solver.findLadders("hit", "cog", ["hot","dot","dog","lot","log","cog"]))
            // [["hit","hot","dot","dog","cog"], ["hit","hot","lot","log","cog"]]
            print(solver.findLadders("hit", "cog", ["hot","dot","dog","lot","log"]))
            // []
        }
    }

    /*
     124. Binary Tree Maximum Path Sum
     A path in a binary tree is a sequence of nodes where each pair of adjacent nodes in the sequence has an edge connecting them. A node can only appear in the sequence at most once. Note that the path does not need to pass through the root.
     The path sum of a path is the sum of the node's values in the path.
     Given the root of a binary tree, return the maximum path sum of any non-empty path.
     Example 1:
     Input: root = [1,2,3]
     Output: 6
     Explanation: The optimal path is 2 -> 1 -> 3 with a path sum of 2 + 1 + 3 = 6.
     Example 2:
     Input: root = [-10,9,20,null,null,15,7]
     Output: 42
     Explanation: The optimal path is 15 -> 20 -> 7 with a path sum of 15 + 20 + 7 = 42.
     */
    class MaxPathSumSolver {
        private var maxSum = Int.min
        
        func maxPathSum(_ root: TreeNode?) -> Int {
            _ = dfs(root)
            return maxSum
        }
        
        private func dfs(_ node: TreeNode?) -> Int {
            guard let node = node else { return 0 }
            
            // Recursively compute left and right max path (ignore negative paths)
            let leftGain = max(dfs(node.left), 0)
            let rightGain = max(dfs(node.right), 0)
            
            // Price of the new path passing through this node
            let priceNewPath = node.val + leftGain + rightGain
            
            // Update global maximum
            maxSum = max(maxSum, priceNewPath)
            
            // Return max branch value (node + one side)
            return node.val + max(leftGain, rightGain)
        }
    }
    /*
     123. Best Time to Buy and Sell Stock III
     You are given an array prices where prices[i] is the price of a given stock on the ith day.
     Find the maximum profit you can achieve. You may complete at most two transactions.
     Note: You may not engage in multiple transactions simultaneously (i.e., you must sell the stock before you buy again).
     Example 1:
     Input: prices = [3,3,5,0,0,3,1,4]
     Output: 6
     Explanation: Buy on day 4 (price = 0) and sell on day 6 (price = 3), profit = 3-0 = 3.
     Then buy on day 7 (price = 1) and sell on day 8 (price = 4), profit = 4-1 = 3.
     Example 2:
     Input: prices = [1,2,3,4,5]
     Output: 4
     Explanation: Buy on day 1 (price = 1) and sell on day 5 (price = 5), profit = 5-1 = 4.
     Note that you cannot buy on day 1, buy on day 2 and sell them later, as you are engaging multiple transactions at the same time. You must sell before buying again.
     Example 3:
     Input: prices = [7,6,4,3,1]
     Output: 0
     Explanation: In this case, no transaction is done, i.e. max profit = 0.
     */
    class StockProfit {
        // 123. Best Time to Buy and Sell Stock III
        func maxProfit(_ prices: [Int]) -> Int {
            if prices.isEmpty { return 0 }
            
            // Initialize states
            var buy1 = Int.min
            var sell1 = 0
            var buy2 = Int.min
            var sell2 = 0
            
            for price in prices {
                // Max profit after first buy (spend money)
                buy1 = max(buy1, -price)
                
                // Max profit after first sell (gain money)
                sell1 = max(sell1, buy1 + price)
                
                // Max profit after second buy (spend money again)
                buy2 = max(buy2, sell1 - price)
                
                // Max profit after second sell (final gain)
                sell2 = max(sell2, buy2 + price)
            }
            
            return sell2
        }
    }
    
    /*
     116. Populating Next Right Pointers in Each Node Medium Topics premium lock icon Companies You are given a perfect binary tree where all leaves are on the same level, and every parent has two children. The binary tree has the following definition: struct Node { int val; Node *left; Node *right; Node *next; } Populate each next pointer to point to its next right node. If there is no next right node, the next pointer should be set to NULL. Initially, all next pointers are set to NULL. Example 1: Input: root = [1,2,3,4,5,6,7] Output: [1,#,2,3,#,4,5,6,7,#] Explanation: Given the above perfect binary tree (Figure A), your function should populate each next pointer to point to its next right node, just like in Figure B. The serialized output is in level order as connected by the next pointers, with '#' signifying the end of each level. Example 2: Input: root = [] Output: []
     */
    public class Node {
        public var val: Int
        public var left: Node?
        public var right: Node?
        public var next: Node?
        public init(_ val: Int) {
            self.val = val
            self.left = nil
            self.right = nil
            self.next = nil
        }
    }

    class NextRightConnector {
        
        // 116. Populating Next Right Pointers in Each Node
        func connect(_ root: Node?) -> Node? {
            guard let root = root else { return nil }
            
            var leftmost: Node? = root
            
            // Traverse level by level
            while let left = leftmost?.left {
                var head: Node? = leftmost
                
                // Connect nodes in the current level
                while let node = head {
                    // Connect left -> right
                    node.left?.next = node.right
                    
                    // Connect right -> next.left (cross connection)
                    if let nextNode = node.next {
                        node.right?.next = nextNode.left
                    }
                    
                    head = node.next
                }
                
                // Move to the next level
                leftmost = left
            }
            
            return root
        }
    }

    /*
     114. Flatten Binary Tree to Linked List
     Given the root of a binary tree, flatten the tree into a "linked list":
     The "linked list" should use the same TreeNode class where the right child pointer points to the next node in the list and the left child pointer is always null.
     The "linked list" should be in the same order as a pre-order traversal of the binary tree.
     Example 1:
     Input: root = [1,2,5,3,4,null,6]
     Output: [1,null,2,null,3,null,4,null,5,null,6]
     Example 2:
     Input: root = []
     Output: []
     Example 3:
     Input: root = [0]
     Output: [0]
     */
    /*
     104. Maximum Depth of Binary Tree
     108. Convert Sorted Array to Binary Search Tree
     109. Convert Sorted List to Binary Search Tree
     110. Balanced Binary Tree
     111. Minimum Depth of Binary Tree
     
     106. Construct Binary Tree from Inorder and Postorder Traversal
     Given two integer arrays inorder and postorder where inorder is the inorder traversal of a binary tree and postorder is the postorder traversal of the same tree, construct and return the binary tree.
     Example 1:
     Input: inorder = [9,3,15,20,7], postorder = [9,15,7,20,3]
     Output: [3,9,20,null,null,15,7]
     */
    /*
     105. Construct Binary Tree from Preorder and Inorder Traversal
     Given two integer arrays preorder and inorder where preorder is the preorder traversal of a binary tree and inorder is the inorder traversal of the same tree, construct and return the binary tree. Example 1: Input: preorder = [3,9,20,15,7], inorder = [9,3,15,20,7] Output: [3,9,20,null,null,15,7] Example 2: Input: preorder = [-1], inorder = [-1] Output: [-1]
     */
    class BinaryTreePreorderInorder {
        // 114. Flatten Binary Tree to Linked List
        func flatten(_ root: TreeNode?) {
            var current = root
            
            // Iterate over the tree nodes
            while let node = current {
                // If the node has a left subtree
                if let left = node.left {
                    // Find the rightmost node in the left subtree
                    var rightMost = left
                    while rightMost.right != nil {
                        rightMost = rightMost.right!
                    }
                    // Attach the original right subtree to the rightmost node
                    rightMost.right = node.right
                    // Move the left subtree to the right
                    node.right = left
                    node.left = nil
                }
                // Move to the next node in the chain
                current = node.right
            }
        }
        // 104. Maximum Depth of Binary Tree
            func maxDepth(_ root: TreeNode?) -> Int {
                guard let node = root else { return 0 }
                let leftDepth = maxDepth(node.left)
                let rightDepth = maxDepth(node.right)
                return 1 + max(leftDepth, rightDepth)
            }
            // 104
            
            // 108. Convert Sorted Array to Binary Search Tree
            func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
                func helper(_ left: Int, _ right: Int) -> TreeNode? {
                    if left > right { return nil }
                    let mid = (left + right) / 2
                    let root = TreeNode(nums[mid])
                    root.left = helper(left, mid - 1)
                    root.right = helper(mid + 1, right)
                    return root
                }
                return helper(0, nums.count - 1)
            }
            // 108
            
            // 109. Convert Sorted List to Binary Search Tree
            func sortedListToBST(_ head: ListNode?) -> TreeNode? {
                var values = [Int]()
                var current = head
                while let node = current {
                    values.append(node.val)
                    current = node.next
                }
                func helper(_ left: Int, _ right: Int) -> TreeNode? {
                    if left > right { return nil }
                    let mid = (left + right) / 2
                    let root = TreeNode(values[mid])
                    root.left = helper(left, mid - 1)
                    root.right = helper(mid + 1, right)
                    return root
                }
                return helper(0, values.count - 1)
            }
            // 109
            
            // 110. Balanced Binary Tree
            func isBalanced(_ root: TreeNode?) -> Bool {
                func checkHeight(_ node: TreeNode?) -> Int {
                    guard let n = node else { return 0 }
                    let left = checkHeight(n.left)
                    if left == -1 { return -1 }
                    let right = checkHeight(n.right)
                    if right == -1 { return -1 }
                    if abs(left - right) > 1 { return -1 }
                    return 1 + max(left, right)
                }
                return checkHeight(root) != -1
            }
            // 110
            
            // 111. Minimum Depth of Binary Tree
            func minDepth(_ root: TreeNode?) -> Int {
                guard let node = root else { return 0 }
                if node.left == nil { return 1 + minDepth(node.right) }
                if node.right == nil { return 1 + minDepth(node.left) }
                return 1 + min(minDepth(node.left), minDepth(node.right))
            }
            // 111
        func buildTree106(_ inorder: [Int], _ postorder: [Int]) -> TreeNode? {//106
             // Map for quick lookup of index in inorder array
             var inorderIndexMap = [Int: Int]()
             for (index, value) in inorder.enumerated() {
                 inorderIndexMap[value] = index
             }
             
             var postorderIndex = postorder.count - 1 // Start from the last element of postorder
             
             func arrayToTree(_ left: Int, _ right: Int) -> TreeNode? {
                 // If there are no elements to construct the subtree
                 if left > right {
                     return nil
                 }
                 
                 // Select the current element as the root and move postorder pointer
                 let rootVal = postorder[postorderIndex]
                 postorderIndex -= 1
                 
                 let root = TreeNode(rootVal)
                 
                 // Build right and left subtrees
                 // Important: build right subtree first because we are moving backwards in postorder
                 if let index = inorderIndexMap[rootVal] {
                     root.right = arrayToTree(index + 1, right)
                     root.left = arrayToTree(left, index - 1)
                 }
                 
                 return root
             }
             
             return arrayToTree(0, inorder.count - 1)
         }
        func buildTree105(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {
            // Map for quick lookup of index in inorder array
            var inorderIndexMap = [Int: Int]()
            for (index, value) in inorder.enumerated() {
                inorderIndexMap[value] = index
            }
            
            var preorderIndex = 0 // Pointer for preorder traversal
            
            func arrayToTree(_ left: Int, _ right: Int) -> TreeNode? {
                // If there are no elements to construct the subtree
                if left > right {
                    return nil
                }
                
                // Select the current element as the root and move preorder pointer
                let rootVal = preorder[preorderIndex]
                preorderIndex += 1
                
                let root = TreeNode(rootVal)
                
                // Build left and right subtrees
                // Exclude inorderIndexMap[rootVal] element because it's the root
                if let index = inorderIndexMap[rootVal] {
                    root.left = arrayToTree(left, index - 1)
                    root.right = arrayToTree(index + 1, right)
                }
                
                return root
            }
            
            return arrayToTree(0, inorder.count - 1)
        }
    }
    /*
     103. Binary Tree Zigzag Level Order Traversal Medium Topics premium lock icon Companies Given the root of a binary tree, return the zigzag level order traversal of its nodes' values. (i.e., from left to right, then right to left for the next level and alternate between). Example 1: Input: root = [3,9,20,null,null,15,7] Output: [[3],[20,9],[15,7]] Example 2: Input: root = [1] Output: [[1]] Example 3: Input: root = [] Output: []
     */
    func zigzagLevelOrder_recursion(_ root: TreeNode?) -> [[Int]] {
        var result = [[Int]]()
        dfs(root, 0, &result)
        return result
    }
    
    private func dfs(_ node: TreeNode?, _ level: Int, _ result: inout [[Int]]) {
        guard let node = node else { return }
        
        // Ensure the array for this level exists
        if result.count <= level {
            result.append([])
        }
        
        // If level is even → append normally
        // If odd → insert at the beginning
        if level % 2 == 0 {
            result[level].append(node.val)
        } else {
            result[level].insert(node.val, at: 0)
        }
        
        dfs(node.left, level + 1, &result)
        dfs(node.right, level + 1, &result)
    }
    func zigzagLevelOrder_additionalMemmory(_ root: TreeNode?) -> [[Int]] {
        var result = [[Int]]()
        guard let root = root else { return result }
        
        var queue: [TreeNode] = [root]
        var leftToRight = true
        
        while !queue.isEmpty {
            let levelSize = queue.count
            var level = [Int]()
            
            for _ in 0..<levelSize {
                let node = queue.removeFirst()
                level.append(node.val)
                
                if let left = node.left {
                    queue.append(left)
                }
                if let right = node.right {
                    queue.append(right)
                }
            }
            
            // If we need right-to-left, reverse the current level
            if !leftToRight {
                level.reverse()
            }
            
            result.append(level)
            leftToRight.toggle()
        }
        
        return result
    }
    /*
     102. Binary Tree Level Order Traversal
     Given the root of a binary tree, return the level order traversal of its nodes' values. (i.e., from left to right, level by level).
     Example 1:
     Input: root = [3,9,20,null,null,15,7]
     Output: [[3],[9,20],[15,7]]
     Example 2:
     Input: root = [1]
     Output: [[1]]
     Example 3:
     Input: root = []
     Output: []
     */
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        var result = [[Int]]()
        guard let root = root else { return result }
        
        var queue: [TreeNode] = [root]
        
        while !queue.isEmpty {
            let levelSize = queue.count
            var level = [Int]()
            
            for _ in 0..<levelSize {
                let node = queue.removeFirst()
                level.append(node.val)
                
                if let left = node.left {
                    queue.append(left)
                }
                if let right = node.right {
                    queue.append(right)
                }
            }
            
            result.append(level)
        }
        
        return result
    }
    /*
     99. Recover Binary Search Tree
     You are given the root of a binary search tree (BST), where the values of exactly two nodes of the tree were swapped by mistake. Recover the tree without changing its structure.
     Example 1:
     Input: root = [1,3,null,null,2]
     Output: [3,1,null,null,2]
     Explanation: 3 cannot be a left child of 1 because 3 > 1. Swapping 1 and 3 makes the BST valid.
     Example 2:
     Input: root = [3,1,4,null,null,2]
     Output: [2,1,4,null,null,3]
     Explanation: 2 cannot be in the right subtree of 3 because 2 < 3. Swapping 2 and 3 makes the BST valid.
     Constraints:
     The number of nodes in the tree is in the range [2, 1000].
     -231 <= Node.val <= 231 - 1
     Follow up: A solution using O(n) space is pretty straight-forward. Could you devise a constant O(1) space solution?
     */
    func recoverBinaryTree(_ root: TreeNode?) {
        var first: TreeNode? = nil
        var second: TreeNode? = nil
        var prev: TreeNode? = nil
        var current = root
        
        // Morris inorder traversal
        while current != nil {
            if current!.left == nil {
                // Process current node
                if let prev = prev, current!.val < prev.val {
                    if first == nil {
                        first = prev
                    }
                    second = current
                }
                prev = current
                current = current!.right
            } else {
                // Find predecessor
                var pre = current!.left
                while pre?.right != nil && pre?.right !== current {
                    pre = pre?.right
                }
                
                if pre?.right == nil {
                    // Create temporary thread
                    pre?.right = current
                    current = current!.left
                } else {
                    // Remove thread and process current
                    pre?.right = nil
                    if let prev = prev, current!.val < prev.val {
                        if first == nil {
                            first = prev
                        }
                        second = current
                    }
                    prev = current
                    current = current!.right
                }
            }
        }
        
        // Swap values of misplaced nodes
        if let f = first, let s = second {
            let tmp = f.val
            f.val = s.val
            s.val = tmp
        }
    }
    /*
     98. Validate Binary Search Tree
     Given the root of a binary tree, determine if it is a valid binary search tree (BST).
     A valid BST is defined as follows:
     The left subtree of a node contains only nodes with keys strictly less than the node's key.
     The right subtree of a node contains only nodes with keys strictly greater than the node's key.
     Both the left and right subtrees must also be binary search trees.
     Example 1:
     Input: root = [2,1,3]
     Output: true
     Example 2:
     Input: root = [5,1,4,null,null,3,6]
     Output: false
     Explanation: The root node's value is 5 but its right child's value is 4.
     */
    class BinarySearch {
        func isValidBST(_ root: TreeNode?) -> Bool {
            // Start recursion with no bounds
            return validate(root, min: nil, max: nil)
        }
        
        private func validate(_ node: TreeNode?, min: Int?, max: Int?) -> Bool {
            // Empty node is valid
            guard let node = node else { return true }
            
            // Check BST property with min/max constraints
            if let min = min, node.val <= min {
                return false
            }
            if let max = max, node.val >= max {
                return false
            }
            
            // Recursively check left and right subtrees
            return validate(node.left, min: min, max: node.val) &&
            validate(node.right, min: node.val, max: max)
        }
    }
    /*
     97. Interleaving String
     Given strings s1, s2, and s3, find whether s3 is formed by an interleaving of s1 and s2.
     An interleaving of two strings s and t is a configuration where s and t are divided into n and m substrings respectively, such that:
     s = s1 + s2 + ... + sn
     t = t1 + t2 + ... + tm
     |n - m| <= 1
     The interleaving is s1 + t1 + s2 + t2 + s3 + t3 + ... or t1 + s1 + t2 + s2 + t3 + s3 + ...
     Note: a + b is the concatenation of strings a and b.
     Example 1:
     Input: s1 = "aabcc", s2 = "dbbca", s3 = "aadbbcbcac"
     Output: true
     Explanation: One way to obtain s3 is:
     Split s1 into s1 = "aa" + "bc" + "c", and s2 into s2 = "dbbc" + "a".
     Interleaving the two splits, we get "aa" + "dbbc" + "bc" + "a" + "c" = "aadbbcbcac".
     Since s3 can be obtained by interleaving s1 and s2, we return true.
     Example 2:
     Input: s1 = "aabcc", s2 = "dbbca", s3 = "aadbbbaccc"
     Output: false
     Explanation: Notice how it is impossible to interleave s2 with any other string to obtain s3.
     Example 3:
     Input: s1 = "", s2 = "", s3 = ""
     Output: true
     */
    class InterleavingString {
        func isInterleave(_ s1: String, _ s2: String, _ s3: String) -> Bool {
            let n = s1.count, m = s2.count, t = s3.count
            
            // If lengths don't match, impossible
            if n + m != t { return false }
            
            // Convert strings to arrays of characters for easy indexing
            let arr1 = Array(s1)
            let arr2 = Array(s2)
            let arr3 = Array(s3)
            
            // DP table: dp[i][j] means if first i chars of s1 and first j chars of s2 form first (i+j) chars of s3
            var dp = Array(repeating: Array(repeating: false, count: m + 1), count: n + 1)
            
            // Base case: empty strings can form empty s3
            dp[0][0] = true
            
            // Fill first row (only s2 contributes)
            for j in 1...m {
                dp[0][j] = dp[0][j-1] && arr2[j-1] == arr3[j-1]
            }
            
            // Fill first column (only s1 contributes)
            for i in 1...n {
                dp[i][0] = dp[i-1][0] && arr1[i-1] == arr3[i-1]
            }
            
            // Fill the DP table
            for i in 1...n {
                for j in 1...m {
                    let fromS1 = dp[i-1][j] && arr1[i-1] == arr3[i+j-1]
                    let fromS2 = dp[i][j-1] && arr2[j-1] == arr3[i+j-1]
                    dp[i][j] = fromS1 || fromS2
                }
            }
            
            return dp[n][m]
        }
    }

    /*
     96. Unique Binary Search Trees
     Given an integer n, return the number of structurally unique BST's (binary search trees) which has exactly n nodes of unique values from 1 to n.
     Example 1:
     Input: n = 3
     Output: 5
     Example 2:
     Input: n = 1
     Output: 1
     */
    class UniqueBinarySearchTrees {
        // Dynamic Programming approach
        func numTrees(_ n: Int) -> Int {
            // DP array to store number of unique BSTs for each i
            var dp = Array(repeating: 0, count: n + 1)
            
            // Base cases: 0 nodes => 1 tree (empty), 1 node => 1 tree
            dp[0] = 1
            dp[1] = 1
            
            // Fill DP table
            if n >= 2 {
                for nodes in 2...n {
                    for root in 1...nodes {
                        dp[nodes] += dp[root - 1] * dp[nodes - root]
                    }
                }
            }
            
            return dp[n]
        }
    }
    
    /*
     95. Unique Binary Search Trees II
     Given an integer n, return all the structurally unique BST's (binary search trees), which has exactly n nodes of unique values from 1 to n. Return the answer in any order.
     Example 1:
     Input: n = 3
     Output: [[1,null,2,null,3],[1,null,3,2],[2,1,3],[3,1,null,null,2],[3,2,null,1]]
     Example 2:
     Input: n = 1
     Output: [[1]]
     */
    class UniqueBSTGenerator {
        // Public function that returns all unique BSTs for given n
        static func generateTrees(_ n: Int) -> [TreeNode?] {
            if n == 0 { return [] } // Edge case
            var memo = [String: [TreeNode?]]()  // Memoization cache
            return buildTrees(1, n, &memo)
        }

        // Recursive function to build BSTs for range [start...end]
        private static func buildTrees(_ start: Int, _ end: Int, _ memo: inout [String: [TreeNode?]]) -> [TreeNode?] {
            let key = "\(start)-\(end)"
            if let cached = memo[key] { return cached }  // Use cached result if exists

            var result = [TreeNode?]()

            // Base case: empty subtree
            if start > end {
                result.append(nil)
                memo[key] = result
                return result
            }

            // Choose root for each number in range
            for rootVal in start...end {
                // Recursively build all possible left and right subtrees
                let leftTrees = buildTrees(start, rootVal - 1, &memo)
                let rightTrees = buildTrees(rootVal + 1, end, &memo)

                // Combine left and right subtrees with current root
                for left in leftTrees {
                    for right in rightTrees {
                        let root = TreeNode(rootVal)
                        root.left = left
                        root.right = right
                        result.append(root)
                    }
                }
            }

            // Save computed result to cache
            memo[key] = result
            return result
        }
    }

    /*
     93. Restore IP Addresses
     A valid IP address consists of exactly four integers separated by single dots. Each integer is between 0 and 255 (inclusive) and cannot have leading zeros.

     For example, "0.1.2.201" and "192.168.1.1" are valid IP addresses, but "0.011.255.245", "192.168.1.312" and "192.168@1.1" are invalid IP addresses.
     Given a string s containing only digits, return all possible valid IP addresses that can be formed by inserting dots into s. You are not allowed to reorder or remove any digits in s. You may return the valid IP addresses in any order.
     Example 1:
     Input: s = "25525511135"
     Output: ["255.255.11.135","255.255.111.35"]
     Example 2:
     Input: s = "0000"
     Output: ["0.0.0.0"]
     Example 3:
     Input: s = "101023"
     Output: ["1.0.10.23","1.0.102.3","10.1.0.23","10.10.2.3","101.0.2.3"]
     Constraints:
     1 <= s.length <= 20
     s consists of digits only.
     */
    class RestoreIPAddresses {
        /// Restores all possible valid IP addresses from the given string
        static func restoreIpAddresses(_ s: String) -> [String] {
            var result = [String]()
            let chars = Array(s)
            let n = chars.count
            
            func backtrack(_ start: Int, _ path: [String]) {
                // If we already have 4 parts and reached the end -> valid IP
                if path.count == 4 {
                    if start == n {
                        result.append(path.joined(separator: "."))
                    }
                    return
                }
                
                // If there are not enough or too many chars left, prune search
                let remaining = n - start
                let minNeeded = 4 - path.count
                if remaining < minNeeded || remaining > minNeeded * 3 {
                    return
                }
                
                // Try segments of length 1 to 3
                for len in 1...3 {
                    if start + len > n { break }
                    let substring = String(chars[start..<start + len])
                    
                    // Skip segments with leading zero unless it's "0"
                    if substring.hasPrefix("0") && substring.count > 1 {
                        continue
                    }
                    
                    // Skip segments greater than 255
                    if let value = Int(substring), value <= 255 {
                        backtrack(start + len, path + [substring])
                    }
                }
            }
            
            backtrack(0, [])
            return result
        }
    }

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
        public init() { self.val = 0; self.left = nil; self.right = nil }
        public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
            self.val = val
            self.left = left
            self.right = right
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
        /*115. Distinct Subsequences
         Given two strings s and t, return the number of distinct subsequences of s which equals t.
         The test cases are generated so that the answer fits on a 32-bit signed integer.
         Example 1:
         Input: s = "rabbbit", t = "rabbit"Output: 3Explanation:
         As shown below, there are 3 ways you can generate "rabbit" from s.rabbbitrabbbitrabbbit
         Example 2:
         Input: s = "babgbag", t = "bag"Output: 5Explanation:
         As shown below, there are 5 ways you can generate "bag" from s.babgbagbabgbagbabgbagbabgbagbabgbag
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
