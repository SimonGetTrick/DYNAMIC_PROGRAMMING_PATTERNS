//
//  InvocationPattern.m
//  Dynamic_Examples
//
//  Created by Simon Getrik on 03.06.2025.
//

#import "InvocationPattern.h"

@implementation InvocationCommand {
    __weak id _target;
    SEL _selector;
}

- (instancetype)initWithTarget:(id)target selector:(SEL)selector {
    self = [super init];
    if (self) {
        _target = target;
        _selector = selector;
    }
    return self;
}

- (void)execute {
    if ([_target respondsToSelector:_selector]) {
        // Obtain the method signature for the target and selector.
        // This is crucial for NSInvocation to correctly pack arguments and return values.
        NSMethodSignature *methodSignature = [_target methodSignatureForSelector:_selector];
        
        if (!methodSignature) {
            NSLog(@"Error: Method signature not found for selector '%@' on target '%@'.", NSStringFromSelector(_selector), _target);
            return;
        }
        
        // Create an NSInvocation instance with the obtained signature.
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
        
        // Set the target object that will receive the message.
        [invocation setTarget:_target];
        // Set the selector (the method name) to be invoked.
        [invocation setSelector:_selector];
        
        // If your command needed arguments, you would set them here.
        // For example:
        // id anArgument = @"Some Value";
        // [invocation setArgument:&anArgument atIndex:2]; // Index 0 is target, 1 is selector, actual arguments start from 2.
        
        // Invoke the method.
        [invocation invoke];
    } else {
        NSLog(@"Error: Target '%@' does not respond to selector '%@'.", _target, NSStringFromSelector(_selector));
    }
}

@end

@implementation Light

- (void)turnOn {
    NSLog(@"The light is ON");
}

- (void)turnOff {
    NSLog(@"The light is OFF");
}

@end

@implementation RemoteControl {
    id<Command> _command;
}

- (void)setCommand:(id<Command>)command {
    _command = command;
}

- (void)pressButton {
    [_command execute];
}

@end

@implementation InvocationPattern

+ (void)demoInvocationPattern {
    Light *lamp = [[Light alloc] init];

    InvocationCommand *onCommand = [[InvocationCommand alloc] initWithTarget:lamp selector:@selector(turnOn)];
    InvocationCommand *offCommand = [[InvocationCommand alloc] initWithTarget:lamp selector:@selector(turnOff)];

    RemoteControl *remote = [[RemoteControl alloc] init];

    [remote setCommand:onCommand];
    [remote pressButton]; // Output: The light is ON

    [remote setCommand:offCommand];
    [remote pressButton]; // Output: The light is OFF
}

@end
