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

#pragma mark - Speak Category Interface

@interface CAnimal (Speak)
- (void)speak;
@end

#pragma mark - Properties Category Interface

@interface CAnimal (Properties)
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, assign) NSInteger age;
@end

NS_ASSUME_NONNULL_END
