//
//  BundlePattern.h
//  Dynamic_Examples
//
//  Created by Simon Getrik on 07.06.2025.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// Protocol for accessing bundle resources
@protocol GreetingProvider <NSObject>

- (NSString *)greetingForLanguage:(NSString *)language;

@end

/// Concrete class to load greetings from a bundle
@interface BundleGreetingProvider : NSObject <GreetingProvider>

- (instancetype)initWithBundle:(NSBundle *)bundle;

@end

/// Demo class for the Bundle Pattern
@interface BundlePattern : NSObject

+ (void)demoBundlePattern;

@end

NS_ASSUME_NONNULL_END
