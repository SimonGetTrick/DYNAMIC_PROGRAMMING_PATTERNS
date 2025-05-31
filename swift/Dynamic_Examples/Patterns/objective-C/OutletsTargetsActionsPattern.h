//
//  OutletsTargetsActionsPattern.h
//  Dynamic_Examples
//
//  Created by Simon Getrik on 31.05.2025.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// Simulated UI element (e.g., a button)
@interface SimulatedButton : NSObject

@property (nonatomic, weak, nullable) id target;
@property (nonatomic, assign) SEL action;

// Method to simulate a button click
- (void)simulateClick;

// Method to simulate a threaded button click
- (void)simulateThreadedClick;

@end

// Controller class that acts as the target for actions
@interface Controller : NSObject

@property (nonatomic, strong, readonly) NSString *status;

// Simulated outlet (in a real app, this would be a UI element)
@property (nonatomic, strong) SimulatedButton *button;

// Action method for button click
- (void)buttonClicked:(id)sender;

@end

// Class for demonstrating the Outlets, Targets, and Actions pattern
@interface OutletsTargetsActionsPattern : NSObject

+ (void)demoOutletsTargetsActionsPattern;

@end

NS_ASSUME_NONNULL_END
