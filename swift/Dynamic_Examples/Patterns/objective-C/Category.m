//
//  Category.m
//  Dynamic_Examples
//
//  Created by Simon Getrik on 20.05.2025.
//

#import "Category.h"
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Base Class Implementation

@implementation CAnimal

- (void)move {
    NSLog(@"CAnimal moves forward");
}

@end

#pragma mark - Speak Category Implementation

@implementation CAnimal (Speak)

- (void)speak {
    NSLog(@"CAnimal says something (category method)");
}

@end

#pragma mark - Associated Object Keys

static const void *kNicknameKey = &kNicknameKey;
static const void *kAgeKey = &kAgeKey;

#pragma mark - Properties Category Implementation

@implementation CAnimal (Properties)

- (void)setNickname:(NSString *)nickname {
    objc_setAssociatedObject(self, kNicknameKey, nickname, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)nickname {
    return objc_getAssociatedObject(self, kNicknameKey);
}

- (void)setAge:(NSInteger)age {
    NSNumber *number = @(age);
    objc_setAssociatedObject(self, kAgeKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)age {
    NSNumber *number = objc_getAssociatedObject(self, kAgeKey);
    return number.integerValue;
}

@end

NS_ASSUME_NONNULL_END
