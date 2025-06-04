//
//  PrototypePattern.m
//  Dynamic_Examples
//
//  Created by Simon Getrik on 04.06.2025.
//

#import "PrototypePattern.h"

@implementation Circle

- (instancetype)initWithRadius:(CGFloat)radius {
    self = [super init];
    if (self) {
        _radius = radius;
    }
    return self;
}

- (id)clone {
    return [[Circle alloc] initWithRadius:self.radius];
}

- (void)draw {
    NSLog(@"Drawing a Circle with radius %.2f", self.radius);
}

@end

@implementation Rectangle

- (instancetype)initWithWidth:(CGFloat)width height:(CGFloat)height {
    self = [super init];
    if (self) {
        _width = width;
        _height = height;
    }
    return self;
}

- (id)clone {
    return [[Rectangle alloc] initWithWidth:self.width height:self.height];
}

- (void)draw {
    NSLog(@"Drawing a Rectangle %.2fx%.2f", self.width, self.height);
}

@end

@interface ShapePrototypeRegistry ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, id<ShapePrototype>> *prototypes;

@end

@implementation ShapePrototypeRegistry

- (instancetype)init {
    self = [super init];
    if (self) {
        _prototypes = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)registerPrototype:(id<ShapePrototype>)prototype withKey:(NSString *)key {
    self.prototypes[key] = prototype;
}

- (id<ShapePrototype>)cloneShapeWithKey:(NSString *)key {
    id<ShapePrototype> prototype = self.prototypes[key];
    return [prototype clone];
}

@end

@implementation PrototypePattern

+ (void)demoPrototypePattern {
    ShapePrototypeRegistry *registry = [[ShapePrototypeRegistry alloc] init];

    // Register initial prototypes
    [registry registerPrototype:[[Circle alloc] initWithRadius:10.0] withKey:@"circle"];
    [registry registerPrototype:[[Rectangle alloc] initWithWidth:20.0 height:30.0] withKey:@"rectangle"];

    // Clone and draw shapes
    id<ShapePrototype> shape1 = [registry cloneShapeWithKey:@"circle"];
    [shape1 draw];

    id<ShapePrototype> shape2 = [registry cloneShapeWithKey:@"rectangle"];
    [shape2 draw];
}

@end
