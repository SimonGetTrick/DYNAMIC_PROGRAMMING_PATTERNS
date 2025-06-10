//
//  ProxyPattern.m
//  Dynamic_Examples
//
//  Created by Simon Getrik on 10.06.2025.
//

#import "ProxyPattern.h"

#pragma mark - RealImageLoader

@implementation RealImageLoader

// Simulates loading an image from a file path
- (NSString *)loadImageFromPath:(NSString *)path {
    // In a real app, this would load an image file
    NSLog(@"RealImageLoader: Loading image from %@", path);
    return [NSString stringWithFormat:@"Image loaded from %@", path];
}

@end

#pragma mark - ImageLoaderProxy

@interface ImageLoaderProxy ()

// Path to the image
@property (nonatomic, copy) NSString *imagePath;
// Reference to the real image loader
@property (nonatomic, strong, nullable) RealImageLoader *realLoader;

@end

@implementation ImageLoaderProxy

- (instancetype)initWithImagePath:(NSString *)path {
    self = [super init];
    if (self) {
        _imagePath = [path copy];
        _realLoader = nil; // Lazy initialization
    }
    return self;
}

// Implements the ImageLoader protocol, forwards to realLoader
- (NSString *)loadImageFromPath:(NSString *)path {
    if (!self.realLoader) {
        // Lazy initialization of the real loader
        NSLog(@"ImageLoaderProxy: Initializing RealImageLoader for path %@", self.imagePath);
        self.realLoader = [[RealImageLoader alloc] init];
    }
    // Forward the message to the real loader
    return [self.realLoader loadImageFromPath:path];
}

@end

#pragma mark - ProxyPattern Demo

@implementation ProxyPattern

+ (void)demoProxyPattern {
    // Create a proxy for an image loader
    id<ImageLoader> proxy = [[ImageLoaderProxy alloc] initWithImagePath:@"/path/to/image.jpg"];
    
    // First call: Proxy creates RealImageLoader and forwards the message
    NSLog(@"%@", [proxy loadImageFromPath:@"/path/to/image.jpg"]);
    
    // Second call: Proxy reuses the existing RealImageLoader
    NSLog(@"%@", [proxy loadImageFromPath:@"/path/to/image.jpg"]);
    
    // Expected output:
    // ImageLoaderProxy: Initializing RealImageLoader for path /path/to/image.jpg
    // RealImageLoader: Loading image from /path/to/image.jpg
    // Image loaded from /path/to/image.jpg
    // RealImageLoader: Loading image from /path/to/image.jpg
    // Image loaded from /path/to/image.jpg
}

@end
