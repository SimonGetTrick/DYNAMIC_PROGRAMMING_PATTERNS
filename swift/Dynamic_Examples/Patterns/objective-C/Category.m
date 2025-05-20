//
//  Category.m
//  Dynamic_Examples
//
//  Created by Simon Getrik on 20.05.2025.
//

#import "Category.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Base Class Implementation

@implementation CAnimal

- (void)move {
    NSLog(@"CAnimal moves forward");
}

@end

#pragma mark - Category Implementation

@implementation CAnimal (Speak)

- (void)speak {
    NSLog(@"CAnimal says something (category method)");
}

@end
NS_ASSUME_NONNULL_END
