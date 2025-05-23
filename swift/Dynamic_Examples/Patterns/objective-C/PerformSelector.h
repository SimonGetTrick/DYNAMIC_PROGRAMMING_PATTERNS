//
//  PerformSelector.h
//  Dynamic_Examples
//
//  Created by Simon Getrik on 23.05.2025.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PerformSelector : NSObject

- (void)simpleMethod;
- (void)methodWithObject:(id)object;
- (void)delayedMethod;

+ (void)demoPerformSelector;

@end

NS_ASSUME_NONNULL_END
