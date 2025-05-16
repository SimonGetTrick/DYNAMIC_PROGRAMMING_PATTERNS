//
//  4.1.ThreadPool.swift
//  Dynamic_Examples
//
//  Created by Simon Getrik on 16.05.2025.
//

import Foundation
func demo4_1_ThreadPool() {
    
    // Create an OperationQueue to manage concurrent tasks
    let operationQueue = OperationQueue()
    
    // Configure the maximum number of concurrent operations
    operationQueue.maxConcurrentOperationCount = 3
    
    // Example: Simulate downloading images concurrently
    func downloadImage(url: String, completion: @escaping (String) -> Void) {
        // Simulate a network request with a delay
        Thread.sleep(forTimeInterval: 1)
        completion("Downloaded image from \(url)")
    }
    
    // Create operations for downloading images
    let imageURLs = [
        "http://example.com/image1.jpg",
        "http://example.com/image2.jpg",
        "http://example.com/image3.jpg",
        "http://example.com/image4.jpg"
    ]
    
    // Create and add operations to the queue
    for url in imageURLs {
        // Create a BlockOperation for each download task
        let operation = BlockOperation {
            downloadImage(url: url) { result in
                // Print the result on the main thread
                DispatchQueue.main.async {
                    print(result)
                }
            }
        }
        
        // Add the operation to the queue
        operationQueue.addOperation(operation)
    }
    
    // Wait until all operations are finished (for demo purposes)
    operationQueue.waitUntilAllOperationsAreFinished()
    print("All image downloads completed!")
}
