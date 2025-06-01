//
//  ResponderChainPattern.m
//  Dynamic_Examples
//
//  Created by Simon Getrik on 01.06.2025.
//

#import "ResponderChainPattern.h"

NS_ASSUME_NONNULL_BEGIN

@implementation Responder

- (BOOL)handleEvent:(NSString *)event {
    // Default implementation: pass to next responder if present
    if (self.nextResponder) {
        NSLog(@"Responder %@ passing event '%@' to next responder", self, event);
        return [self.nextResponder handleEvent:event];
    } else {
        NSLog(@"Responder %@ reached end of chain, event '%@' not handled", self, event);
        return NO;
    }
}

- (void)handleThreadedEvent:(NSString *)event {
    dispatch_queue_t backgroundQueue = dispatch_queue_create("com.example.responderQueue", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(backgroundQueue, ^{
        // Ensure event handling occurs on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.nextResponder) {
                NSLog(@"Responder %@ passing threaded event '%@' to next responder on thread %@", self, event, [NSThread currentThread]);
                [self.nextResponder handleThreadedEvent:event];
            } else {
                NSLog(@"Responder %@ reached end of chain, threaded event '%@' not handled on thread %@", self, event, [NSThread currentThread]);
            }
        });
    });
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p>", NSStringFromClass([self class]), self];
}

@end

@implementation ViewResponder

- (BOOL)handleEvent:(NSString *)event {
    // Simulate a view handling a specific event
    if ([event isEqualToString:@"Tap"]) {
        NSLog(@"ViewResponder %@ handled event '%@'", self, event);
        return YES;
    } else {
        NSLog(@"ViewResponder %@ cannot handle event '%@', passing to next responder", self, event);
        return [super handleEvent:event];
    }
}

- (void)handleThreadedEvent:(NSString *)event {
    // Simulate threaded event handling
    if ([event isEqualToString:@"Tap"]) {
        NSLog(@"ViewResponder %@ handled threaded event '%@' on thread %@", self, event, [NSThread currentThread]);
    } else {
        NSLog(@"ViewResponder %@ cannot handle threaded event '%@', passing to next responder", self, event);
        [super handleThreadedEvent:event];
    }
}

@end

@implementation ControllerResponder

- (BOOL)handleEvent:(NSString *)event {
    // Simulate a controller handling a specific event
    if ([event isEqualToString:@"LongPress"]) {
        NSLog(@"ControllerResponder %@ handled event '%@'", self, event);
        return YES;
    } else {
        NSLog(@"ControllerResponder %@ cannot handle event '%@', passing to next responder", self, event);
        return [super handleEvent:event];
    }
}

- (void)handleThreadedEvent:(NSString *)event {
    // Simulate threaded event handling
    if ([event isEqualToString:@"LongPress"]) {
        NSLog(@"ControllerResponder %@ handled threaded event '%@' on thread %@", self, event, [NSThread currentThread]);
    } else {
        NSLog(@"ControllerResponder %@ cannot handle threaded event '%@', passing to next responder", self, event);
        [super handleThreadedEvent:event];
    }
}

@end

@implementation ResponderChainPattern

+ (void)demoResponderChainPattern {
    // 1. Create a responder chain
    ViewResponder *view = [[ViewResponder alloc] init];
    ControllerResponder *controller = [[ControllerResponder alloc] init];
    view.nextResponder = controller; // Chain: View -> Controller
    
    // 2. Test event handling on the main thread
    NSLog(@"--- Testing main thread event handling ---");
    [view handleEvent:@"Tap"];        // Should be handled by ViewResponder
    [view handleEvent:@"LongPress"];  // Should be handled by ControllerResponder
    [view handleEvent:@"Swipe"];      // Should reach end of chain
    
    // 3. Test threaded event handling
    NSLog(@"\n--- Testing threaded event handling ---");
    [view handleThreadedEvent:@"Tap"];        // Should be handled by ViewResponder
    [view handleThreadedEvent:@"LongPress"];  // Should be handled by ControllerResponder
    [view handleThreadedEvent:@"Swipe"];      // Should reach end of chain
    
    // 4. Simulate some delay to allow background threads to process
    [NSThread sleepForTimeInterval:1.0];
    
    // Logs:
    // --- Testing main thread event handling ---
    // ViewResponder <ViewResponder: 0x...> handled event 'Tap'
    // ViewResponder <ViewResponder: 0x...> cannot handle event 'LongPress', passing to next responder
    // ControllerResponder <ControllerResponder: 0x...> handled event 'LongPress'
    // ViewResponder <ViewResponder: 0x...> cannot handle event 'Swipe', passing to next responder
    // ControllerResponder <ControllerResponder: 0x...> cannot handle event 'Swipe', passing to next responder
    // Responder <ControllerResponder: 0x...> reached end of chain, event 'Swipe' not handled
    //
    // --- Testing threaded event handling ---
    // ViewResponder <ViewResponder: 0x...> handled threaded event 'Tap' on thread <NSThread: 0x...>{number = 1, name = (null)}
    // ViewResponder <ViewResponder: 0x...> cannot handle threaded event 'LongPress', passing to next responder
    // ControllerResponder <ControllerResponder: 0x...> handled threaded event 'LongPress' on thread <NSThread: 0x...>{number = 1, name = (null)}
    // ViewResponder <ViewResponder: 0x...> cannot handle threaded event 'Swipe', passing to next responder
    // ControllerResponder <ControllerResponder: 0x...> cannot handle threaded event 'Swipe', passing to next responder
    // Responder <ControllerResponder: 0x...> reached end of chain, threaded event 'Swipe' not handled on thread <NSThread: 0x...>{number = 1, name = (null)}
}

@end

NS_ASSUME_NONNULL_END
