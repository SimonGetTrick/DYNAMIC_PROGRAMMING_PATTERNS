//
//  2.7.Proxy.swift
//  Dynamic_Examples
//
//  Created by Simon Getrik on 12.05.2025.
//

import Foundation

// MARK: - Proxy Pattern
// The Proxy pattern provides a surrogate or placeholder for another object to control access to it,
// such as lazy loading, access control, or logging.

// Protocol defining the interface for image loading
protocol ImageLoader {
    func loadImage(url: String) -> String
}

// Real subject: Loads an image from a remote URL
class RemoteImageLoader: ImageLoader {
    func loadImage(url: String) -> String {
        // Simulate loading an image from a remote server
        print("Loading image from \(url)...")
        return "Image data from \(url)"
    }
}

// Proxy: Controls access to the RemoteImageLoader with lazy loading
class ImageLoaderProxy: ImageLoader {
    private let url: String
    private var realLoader: RemoteImageLoader?
    
    init(url: String) {
        self.url = url
        self.realLoader = nil // Lazy initialization
    }
    
    // Load the image, initializing the real loader only when needed
    func loadImage(url: String) -> String {
        guard url == self.url else {
            return "Error: URL mismatch"
        }
        
        if realLoader == nil {
            print("Proxy: Initializing real loader for \(url)")
            realLoader = RemoteImageLoader()
        }
        
        return realLoader!.loadImage(url: url)
    }
}

// Client class that uses the ImageLoader
class ImageViewer {
    private let imageLoader: ImageLoader
    
    init(imageLoader: ImageLoader) {
        self.imageLoader = imageLoader
    }
    
    // Display the image by loading it
    func displayImage(url: String) {
        let imageData = imageLoader.loadImage(url: url)
        print("Displaying: \(imageData)")
    }
}

// Demo function to showcase the Proxy pattern
func demo_ProxyPattern() {
    // Create a proxy for lazy loading an image
    let proxy = ImageLoaderProxy(url: "https://example.com/image.jpg")
    let viewer = ImageViewer(imageLoader: proxy)
    
    // First call: Proxy will initialize the real loader
    print("First attempt to display image:")
    viewer.displayImage(url: "https://example.com/image.jpg")
    
    // Second call: Proxy reuses the real loader
    print("\nSecond attempt to display image:")
    viewer.displayImage(url: "https://example.com/image.jpg")
    
    // Invalid URL: Proxy prevents access
    print("\nAttempt with incorrect URL:")
    viewer.displayImage(url: "https://wrong.com/image.jpg")
}

