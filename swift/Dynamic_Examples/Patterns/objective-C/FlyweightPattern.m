//
//  FlyweightPattern.m
//  Dynamic_Examples
//
//  Created by Simon Getrik on 05.06.2025.
//

#import "FlyweightPattern.h"

@implementation ConcreteTreeType

- (instancetype)initWithName:(NSString *)name
                       color:(NSString *)color
                     texture:(NSString *)texture {
    self = [super init];
    if (self) {
        _name = name;
        _color = color;
        _texture = texture;
    }
    return self;
}

- (void)drawAtX:(NSInteger)x y:(NSInteger)y {
    NSLog(@"Drawing tree '%@' at (%ld, %ld) with color '%@' and texture '%@'",
          self.name, (long)x, (long)y, self.color, self.texture);
}

@end

@implementation TreeFactory

static NSMutableArray<ConcreteTreeType *> *treeTypes;

+ (void)initialize {
    if (!treeTypes) {
        treeTypes = [NSMutableArray array];
    }
}

+ (ConcreteTreeType *)treeTypeWithName:(NSString *)name
                                 color:(NSString *)color
                               texture:(NSString *)texture {
    for (ConcreteTreeType *type in treeTypes) {
        if ([type.name isEqualToString:name] &&
            [type.color isEqualToString:color] &&
            [type.texture isEqualToString:texture]) {
            return type; // Reuse existing object
        }
    }

    ConcreteTreeType *newType = [[ConcreteTreeType alloc] initWithName:name
                                                                 color:color
                                                               texture:texture];
    [treeTypes addObject:newType];
    return newType;
}

@end

@implementation Tree

- (instancetype)initWithX:(NSInteger)x
                         y:(NSInteger)y
                      type:(id<TreeType>)type {
    self = [super init];
    if (self) {
        _x = x;
        _y = y;
        _type = type;
    }
    return self;
}

- (void)draw {
    [self.type drawAtX:self.x y:self.y];
}

@end

@implementation FlyweightPattern

+ (void)demoFlyweightPattern {
    NSMutableArray<Tree *> *forest = [NSMutableArray array];

    // Create 3 trees of the same type using the Flyweight
    ConcreteTreeType *pineType = [TreeFactory treeTypeWithName:@"Pine"
                                                         color:@"Green"
                                                       texture:@"Rough"];

    [forest addObject:[[Tree alloc] initWithX:10 y:20 type:pineType]];
    [forest addObject:[[Tree alloc] initWithX:30 y:40 type:pineType]];
    [forest addObject:[[Tree alloc] initWithX:50 y:60 type:pineType]];

    // Draw all trees
    for (Tree *tree in forest) {
        [tree draw];
    }
}

@end
