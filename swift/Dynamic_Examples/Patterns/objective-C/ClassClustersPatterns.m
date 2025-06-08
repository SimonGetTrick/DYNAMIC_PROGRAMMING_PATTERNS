//
//  ClassClustersPatterns.m
//  Dynamic_Examples
//
//  Created by Simon Getrik on 08.06.2025.
//

#import "ClassClustersPatterns.h"

/// Concrete subclass for integer
@interface MyIntNumber : MyNumber
@property (nonatomic, assign) int value;
- (instancetype)initWithInt:(int)value;
@end

/// Concrete subclass for float
@interface MyFloatNumber : MyNumber
@property (nonatomic, assign) float value;
- (instancetype)initWithFloat:(float)value;
@end

@implementation MyNumber

+ (instancetype)numberWithInt:(int)value {
    return [[MyIntNumber alloc] initWithInt:value];
}

+ (instancetype)numberWithFloat:(float)value {
    return [[MyFloatNumber alloc] initWithFloat:value];
}

- (NSString *)stringValue {
    [NSException raise:@"AbstractMethod" format:@"Call to abstract method"];
    return @"";
}

@end

@implementation MyIntNumber

- (instancetype)initWithInt:(int)value {
    self = [super init];
    if (self) {
        _value = value;
    }
    return self;
}

- (NSString *)stringValue {
    return [NSString stringWithFormat:@"%d", self.value];
}

@end

@implementation MyFloatNumber

- (instancetype)initWithFloat:(float)value {
    self = [super init];
    if (self) {
        _value = value;
    }
    return self;
}

- (NSString *)stringValue {
    return [NSString stringWithFormat:@"%.2f", self.value];
}
@end

@implementation ClassClusterPattern

+ (void)demoClassClusterPattern {
    MyNumber *intNumber = [MyNumber numberWithInt:42];
    MyNumber *floatNumber = [MyNumber numberWithFloat:3.14];

    NSLog(@"Integer Number: %@", [intNumber stringValue]); // "42"
    NSLog(@"Float Number: %@", [floatNumber stringValue]); // "3.14"
}


@end
