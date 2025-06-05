//
//  FlyweightPattern.h
//  Dynamic_Examples
//
//  Created by Simon Getrik on 05.06.2025.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// The Flyweight interface
@protocol TreeType <NSObject>

- (void)drawAtX:(NSInteger)x y:(NSInteger)y;

@end

// Concrete Flyweight: shared tree type
@interface ConcreteTreeType : NSObject <TreeType>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *color;
@property (nonatomic, copy) NSString *texture;

- (instancetype)initWithName:(NSString *)name
                       color:(NSString *)color
                     texture:(NSString *)texture;

@end

// Flyweight Factory: manages shared TreeTypes
@interface TreeFactory : NSObject

+ (ConcreteTreeType *)treeTypeWithName:(NSString *)name
                                 color:(NSString *)color
                               texture:(NSString *)texture;

@end

// Context object: stores extrinsic state (coordinates)
@interface Tree : NSObject

@property (nonatomic, assign) NSInteger x;
@property (nonatomic, assign) NSInteger y;
@property (nonatomic, strong) id<TreeType> type;

- (instancetype)initWithX:(NSInteger)x
                         y:(NSInteger)y
                      type:(id<TreeType>)type;

- (void)draw;

@end

// Class for demonstrating the Flyweight Pattern
@interface FlyweightPattern : NSObject

+ (void)demoFlyweightPattern;

@end

NS_ASSUME_NONNULL_END
