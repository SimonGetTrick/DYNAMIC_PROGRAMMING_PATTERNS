//
//  EnumeratorPattern.h
//  Dynamic_Examples
//
//  Created by Simon Getrik on 22.05.2025.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// Custom collection class
@interface CustomCollection : NSObject

- (instancetype)initWithItems:(NSArray *)items;
- (NSEnumerator *)objectEnumerator; // Returns an enumerator for iteration
- (NSUInteger)count;

@end

// Enumerator pattern demonstration class
@interface EnumeratorPattern : NSObject

+ (void)demoEnumeratorPattern;

@end

NS_ASSUME_NONNULL_END
