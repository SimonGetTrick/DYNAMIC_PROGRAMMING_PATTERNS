//
//  BindingsAndControllersPattern.m
//  Dynamic_Examples
//
//  Created by Simon Getrik on 15.06.2025.
//

#import "BindingsAndControllersPattern.h"

#pragma mark - Model

@interface UserModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;
@end

@implementation UserModel
@end

#pragma mark - Controller (simulated)

@interface UserController : NSObject
@property (nonatomic, strong) UserModel *user;
@end

@implementation UserController

- (instancetype)initWithUser:(UserModel *)user {
    self = [super init];
    if (self) {
        _user = user;

        // Observe model using KVO
        [_user addObserver:self
                forKeyPath:@"name"
                   options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                   context:NULL];

        [_user addObserver:self
                forKeyPath:@"age"
                   options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                   context:NULL];
    }
    return self;
}

- (void)dealloc {
    [_user removeObserver:self forKeyPath:@"name"];
    [_user removeObserver:self forKeyPath:@"age"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
    NSLog(@"Observed change in %@ → %@", keyPath, change[NSKeyValueChangeOldKey]);
}

@end

#pragma mark - Demo

@implementation BindingsAndControllersPattern

+ (void)demoBindingsAndControllers {
    UserModel *u = [[UserModel alloc] init];
    u.name = @"Alice";
    u.age = 30;

    __unused UserController *controller = [[UserController alloc] initWithUser:u];

    NSLog(@"--- Changing model values ---");
    u.name = @"Bob";
    u.age = 31;
}

@end
