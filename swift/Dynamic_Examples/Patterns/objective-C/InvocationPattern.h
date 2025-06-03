//
//  InvocationPattern.h
//  Dynamic_Examples
//
//  Created by Simon Getrik on 03.06.2025.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// A command-like protocol that encapsulates an action
@protocol Command <NSObject>

- (void)execute;

@end

/// A concrete command that wraps a target and selector
@interface InvocationCommand : NSObject <Command>

- (instancetype)initWithTarget:(id)target selector:(SEL)selector;

@end

/// Receiver class with business logic
@interface Light : NSObject

- (void)turnOn;
- (void)turnOff;

@end

/// Invoker class that holds and executes commands
@interface RemoteControl : NSObject

- (void)setCommand:(id<Command>)command;
- (void)pressButton;

@end

/// Demo class
@interface InvocationPattern : NSObject

+ (void)demoInvocationPattern;

@end

NS_ASSUME_NONNULL_END
