//
//  OutletsTargetsActionsPattern.m
//  Dynamic_Examples
//
//  Created by Simon Getrik on 31.05.2025.
//

#import "OutletsTargetsActionsPattern.h"

NS_ASSUME_NONNULL_BEGIN

@implementation SimulatedButton

// Simulate a button click by calling the target-action
- (void)simulateClick {
    if (self.target && self.action && [self.target respondsToSelector:self.action]) {
        // Use NSInvocation to safely invoke the action
        NSMethodSignature *signature = [self.target methodSignatureForSelector:self.action];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setSelector:self.action];
        [invocation setTarget:self.target];
        
        // Explicitly cast self to void * to avoid qualifier warnings
        void *sender = (__bridge void *)self;
        [invocation setArgument:&sender atIndex:2]; // Index 0 and 1 are reserved for target and selector
        [invocation invoke];
        
        NSLog(@"Simulated button click on thread %@", [NSThread currentThread]);
    }
}

// Simulate a button click from a background thread
- (void)simulateThreadedClick {
    dispatch_queue_t backgroundQueue = dispatch_queue_create("com.example.buttonQueue", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(backgroundQueue, ^{
        if (self.target && self.action && [self.target respondsToSelector:self.action]) {
            // Ensure the action is performed on the main thread
            dispatch_async(dispatch_get_main_queue(), ^{
                // Use NSInvocation to safely invoke the action
                NSMethodSignature *signature = [self.target methodSignatureForSelector:self.action];
                NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
                [invocation setSelector:self.action];
                [invocation setTarget:self.target];
                
                // Explicitly cast self to void * to avoid qualifier warnings
                void *sender = (__bridge void *)self;
                [invocation setArgument:&sender atIndex:2]; // Index 0 and 1 are reserved for target and selector
                [invocation invoke];
                
                NSLog(@"Simulated threaded button click on thread %@", [NSThread currentThread]);
            });
        }
    });
}

@end

@implementation Controller

- (instancetype)init {
    self = [super init];
    if (self) {
        _status = @"Idle";
        _button = [[SimulatedButton alloc] init];
        // Set the target and action (simulating Interface Builder setup)
        _button.target = self;
        _button.action = @selector(buttonClicked:);
    }
    return self;
}

// Action method for button click
- (void)buttonClicked:(id)sender {
    // Update status (thread-safe, since this is called on the main thread)
    _status = @"Button Clicked!";
    NSLog(@"Button action triggered: Status = %@", self.status);
}

@end

@implementation OutletsTargetsActionsPattern

+ (void)demoOutletsTargetsActionsPattern {
    // 1. Create a controller instance
    Controller *controller = [[Controller alloc] init];
    NSLog(@"Initial Status: %@", controller.status);
    
    // 2. Simulate a button click on the main thread
    NSLog(@"\n--- Simulating button click on main thread ---");
    [controller.button simulateClick];
    NSLog(@"Status after click: %@", controller.status);
    
    // 3. Simulate a button click from a background thread
    NSLog(@"\n--- Simulating button click from background thread ---");
    [controller.button simulateThreadedClick];
    
    // 4. Simulate some delay to allow background thread to process
    [NSThread sleepForTimeInterval:1.0];
    
    // 5. Log the final status
    NSLog(@"\nFinal Status after threaded click: %@", controller.status);
    
    // Logs:
    // Initial Status: Idle
    //
    // --- Simulating button click on main thread ---
    // Simulated button click on thread <NSThread: 0x...>{number = 1, name = (null)}
    // Button action triggered: Status = Button Clicked!
    // Status after click: Button Clicked!
    //
    // --- Simulating button click from background thread ---
    // Simulated threaded button click on thread <NSThread: 0x...>{number = 1, name = (null)}
    // Button action triggered: Status = Button Clicked!
    //
    // Final Status after threaded click: Button Clicked!
}

@end

NS_ASSUME_NONNULL_END
