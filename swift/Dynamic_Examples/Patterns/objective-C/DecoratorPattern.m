//
//  DecoratorPattern.m
//  Dynamic_Examples
//
//  Created by Simon Getrik on 06.06.2025.
//

#import "DecoratorPattern.h"

#pragma mark - SimpleCoffee

@implementation SimpleCoffee

- (NSString *)getDescription {
    return @"Simple coffee";
}

- (double)getCost {
    return 2.0;
}

@end

#pragma mark - CoffeeDecorator

@interface CoffeeDecorator ()

@property (nonatomic, strong) id<Coffee> component;

@end

@implementation CoffeeDecorator

- (instancetype)initWithComponent:(id<Coffee>)component {
    self = [super init];
    if (self) {
        _component = component;
    }
    return self;
}

- (NSString *)getDescription {
    return [self.component getDescription];
}

- (double)getCost {
    return [self.component getCost];
}

@end

#pragma mark - MilkDecorator

@implementation MilkDecorator

- (NSString *)getDescription {
    return [[super getDescription] stringByAppendingString:@", milk"];
}

- (double)getCost {
    return [super getCost] + 0.5;
}

@end

#pragma mark - SugarDecorator

@implementation SugarDecorator

- (NSString *)getDescription {
    return [[super getDescription] stringByAppendingString:@", sugar"];
}

- (double)getCost {
    return [super getCost] + 0.3;
}

@end

#pragma mark - DecoratorPattern Demo

@implementation DecoratorPattern

+ (void)demoDecoratorPattern {
    id<Coffee> coffee = [[SimpleCoffee alloc] init];
    NSLog(@"%@", coffee.getDescription); // Simple coffee
    NSLog(@"Cost: %.2f", coffee.getCost); // 2.00

    coffee = [[MilkDecorator alloc] initWithComponent:coffee];
    coffee = [[SugarDecorator alloc] initWithComponent:coffee];

    NSLog(@"%@", coffee.getDescription); // Simple coffee, milk, sugar
    NSLog(@"Cost: %.2f", coffee.getCost); // 2.80
}

@end
