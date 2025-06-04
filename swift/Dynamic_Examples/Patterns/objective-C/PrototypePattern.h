//
//  PrototypePattern.h
//  Dynamic_Examples
//
//  Created by Simon Getrik on 04.06.2025.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// Protocol for all shape prototypes
@protocol ShapePrototype <NSObject>

- (id)clone;
- (void)draw;

@end

// Concrete prototype: Circle
@interface Circle : NSObject <ShapePrototype>

@property (nonatomic, assign) CGFloat radius;

- (instancetype)initWithRadius:(CGFloat)radius;

@end

// Concrete prototype: Rectangle
@interface Rectangle : NSObject <ShapePrototype>

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

- (instancetype)initWithWidth:(CGFloat)width height:(CGFloat)height;

@end

// Prototype registry for cloning shapes by key
@interface ShapePrototypeRegistry : NSObject

- (void)registerPrototype:(id<ShapePrototype>)prototype withKey:(NSString *)key;
- (id<ShapePrototype>)cloneShapeWithKey:(NSString *)key;

@end

// Class for demonstrating the Prototype Pattern
@interface PrototypePattern : NSObject

+ (void)demoPrototypePattern;

@end

NS_ASSUME_NONNULL_END
