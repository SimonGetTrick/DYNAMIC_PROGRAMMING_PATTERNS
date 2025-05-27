//
//  SingletonPattern.h
//  Dynamic_Examples
//
//  Created by Simon Getrik on 27.05.2025.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppConfiguration : NSObject <NSCopying> // Conform to NSCopying to prevent copying

@property (nonatomic, strong) NSString *baseURL;
@property (nonatomic, assign) NSInteger timeoutInterval;

// Public class method to get the shared instance of the singleton.
// This is the ONLY intended way to get an instance of AppConfiguration.
+ (instancetype)sharedConfiguration;

// Private initializer - intended strictly for internal use by the singleton's sharedConfiguration method.
// It is NOT marked as NS_DESIGNATED_INITIALIZER as the external `init` is unavailable.
// Clients should NEVER call this directly.
- (instancetype)_init;

// Prevent direct calls to the standard init method.
// This enforces that sharedConfiguration is the sole entry point for instance creation.
- (instancetype)init NS_UNAVAILABLE;

// Method to demonstrate configuration usage
- (void)printConfiguration;

@end

@interface SingletonPatternObj : NSObject

+ (void)demoSingletonPattern;

@end

NS_ASSUME_NONNULL_END
