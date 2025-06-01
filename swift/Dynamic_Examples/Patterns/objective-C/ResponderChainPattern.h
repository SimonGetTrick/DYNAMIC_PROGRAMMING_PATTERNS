//
//  ResponderChainPattern.h
//  Dynamic_Examples
//
//  Created by Simon Getrik on 01.06.2025.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// Base class representing a responder in the chain
@interface Responder : NSObject

@property (nonatomic, weak, nullable) Responder *nextResponder;

// Method to handle an event
- (BOOL)handleEvent:(NSString *)event;

// Method to simulate a threaded event
- (void)handleThreadedEvent:(NSString *)event;

@end

// Subclass representing a View-like responder
@interface ViewResponder : Responder

@end

// Subclass representing a Controller-like responder
@interface ControllerResponder : Responder

@end

// Class for demonstrating the Responder Chain pattern
@interface ResponderChainPattern : NSObject

+ (void)demoResponderChainPattern;

@end

NS_ASSUME_NONNULL_END
