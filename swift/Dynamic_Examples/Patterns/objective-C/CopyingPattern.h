//
//  CopyingPattern.h
//  Dynamic_Examples
//
//  Created by Simon Getrik on 26.05.2025.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// Our custom class that will support copying
@interface UserProfile : NSObject <NSCopying>

@property (nonatomic, strong) NSString *username;
@property (nonatomic, assign) NSInteger userID;
@property (nonatomic, strong) NSMutableArray<NSString *> *favoriteFoods; // A mutable property to demonstrate deep vs. shallow copy

- (instancetype)initWithUsername:(NSString *)username userID:(NSInteger)userID favoriteFoods:(NSArray<NSString *> *)foods;

@end

// Class for demonstrating the Copying pattern
@interface CopyingPattern : NSObject

+ (void)demoCopyingPattern;

@end

NS_ASSUME_NONNULL_END
