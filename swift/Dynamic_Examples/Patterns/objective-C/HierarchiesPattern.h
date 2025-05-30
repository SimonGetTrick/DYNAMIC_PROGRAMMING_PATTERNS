//
//  HierarchiesPattern.h
//  Dynamic_Examples
//
//  Created by Simon Getrik on 30.05.2025.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// Base class representing a generic Task
@interface Task : NSObject

@property (nonatomic, strong, readonly) NSString *title;
@property (nonatomic, assign, readonly) BOOL isCompleted;

// Designated initializer
- (instancetype)initWithTitle:(NSString *)title;

// Method to mark the task as completed
- (void)complete;

// Method to get a description of the task
- (NSString *)taskDescription;

@end

// Subclass representing a Simple Task
@interface SimpleTask : Task

@end

// Subclass representing a Composite Task (contains subtasks)
@interface CompositeTask : Task

@property (nonatomic, strong, readonly) NSMutableArray<Task *> *subtasks;

// Method to add a subtask
- (void)addSubtask:(Task *)subtask;

// Method to remove a subtask
- (void)removeSubtask:(Task *)subtask;

@end

// Class for demonstrating the Hierarchies pattern
@interface HierarchiesPattern : NSObject

+ (void)demoHierarchiesPattern;

@end

NS_ASSUME_NONNULL_END
