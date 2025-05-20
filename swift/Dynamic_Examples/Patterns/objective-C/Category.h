//
//  Category.h
//  Dynamic_Examples
//
//  Created by Simon Getrik on 20.05.2025.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Base Class Interface

@interface CAnimal : NSObject
- (void)move;
@end

#pragma mark - Category Interface

@interface CAnimal (Speak)
- (void)speak;
@end

NS_ASSUME_NONNULL_END
