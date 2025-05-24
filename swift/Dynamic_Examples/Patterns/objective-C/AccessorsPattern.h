//
//  AccessorsPattern.h
//  Dynamic_Examples
//
//  Created by Simon Getrik on 24.05.2025.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, strong, readonly) NSString *fullName; // Read-only property

- (instancetype)initWithName:(NSString *)name age:(NSInteger)age;

@end

@interface AccessorsPattern : NSObject

+ (void)demoAccessorsPattern;

@end

NS_ASSUME_NONNULL_END
