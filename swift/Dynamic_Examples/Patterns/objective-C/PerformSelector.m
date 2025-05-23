//
//  PerformSelector.m
//  Dynamic_Examples
//
//  Created by Simon Getrik on 23.05.2025.
//

#import "PerformSelector.h"

NS_ASSUME_NONNULL_BEGIN

@implementation PerformSelector

- (void)simpleMethod {
    NSLog(@"simpleMethod was called.");
}

- (void)methodWithObject:(id)object {
    NSLog(@"methodWithObject was called with object: %@", object);
}

- (void)delayedMethod {
    NSLog(@"delayedMethod was called after a delay.");
}

+ (void)demoPerformSelector {
    PerformSelector *example = [[PerformSelector alloc] init];

    // Using performSelector:
    NSLog(@"--- Demoing performSelector: ---");
    [example performSelector:@selector(simpleMethod)];
    // Expected Log: simpleMethod was called.

    // Using performSelector:withObject:
    NSLog(@"\n--- Demoing performSelector:withObject: ---");
    [example performSelector:@selector(methodWithObject:) withObject:@"Hello from performSelector!"];
    // Expected Log: methodWithObject was called with object: Hello from performSelector!

    // Using performSelector:withObject:afterDelay:
    NSLog(@"\n--- Demoing performSelector:withObject:afterDelay: ---");
    NSLog(@"Scheduling delayedMethod to be called in 2 seconds...");
    [example performSelector:@selector(delayedMethod) withObject:nil afterDelay:2.0];
    // Expected Log (after ~2 seconds): delayedMethod was called after a delay.
    
    // To ensure the delayed method has time to execute in a non-runloop environment
    // (like a simple command-line tool, not typically needed in a GUI app with an active runloop)
    // you might need to keep the runloop alive.
    // For a typical Cocoa/Cocoa Touch application, the main runloop will handle this.
    // For this example, we assume it's part of a larger app or a test where runloop is managed.
}

@end

NS_ASSUME_NONNULL_END
