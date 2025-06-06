//
//  DecoratorPattern.h
//  Dynamic_Examples
//
//  Created by Simon Getrik on 06.06.2025.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// Base component protocol
@protocol Coffee <NSObject>

- (NSString *)getDescription;
- (double)getCost;

@end

/// Concrete component
@interface SimpleCoffee : NSObject <Coffee>

@end

/// Base decorator (conforms to Coffee and wraps another Coffee)
@interface CoffeeDecorator : NSObject <Coffee>

- (instancetype)initWithComponent:(id<Coffee>)component;

@end

/// Concrete decorator: Milk
@interface MilkDecorator : CoffeeDecorator

@end

/// Concrete decorator: Sugar
@interface SugarDecorator : CoffeeDecorator

@end

/// Demo class
@interface DecoratorPattern : NSObject

+ (void)demoDecoratorPattern;

@end

NS_ASSUME_NONNULL_END

