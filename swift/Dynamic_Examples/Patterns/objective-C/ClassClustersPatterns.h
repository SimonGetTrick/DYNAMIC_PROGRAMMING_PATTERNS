//
//  ClassClustersPatterns.h
//  Dynamic_Examples
//
//  Created by Simon Getrik on 08.06.2025.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// Public abstract interface
@interface MyNumber : NSObject

+ (instancetype)numberWithInt:(int)value;
+ (instancetype)numberWithFloat:(float)value;

- (NSString *)stringValue;

@end

/// Demo class for Class Cluster pattern
@interface ClassClusterPattern : NSObject

+ (void)demoClassClusterPattern;

@end
NS_ASSUME_NONNULL_END
