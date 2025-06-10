//
//  ProxyPattern.h
//  Dynamic_Examples
//
//  Created by Simon Getrik on 10.06.2025.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// Protocol for image loading operations
@protocol ImageLoader <NSObject>

- (NSString *)loadImageFromPath:(NSString *)path;

@end

// Concrete class that performs actual image loading
@interface RealImageLoader : NSObject <ImageLoader>

@end

// Proxy class that controls access to RealImageLoader
@interface ImageLoaderProxy : NSObject <ImageLoader>

- (instancetype)initWithImagePath:(NSString *)path;

@end

// Demo class for the Proxy and Forwarding Pattern
@interface ProxyPattern : NSObject

+ (void)demoProxyPattern;

@end

NS_ASSUME_NONNULL_END
