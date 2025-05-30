//
//  HierarchiesPattern.m
//  Dynamic_Examples
//
//  Created by Simon Getrik on 30.05.2025.
//

#import "HierarchiesPattern.h"

NS_ASSUME_NONNULL_BEGIN

@implementation Task

- (instancetype)initWithTitle:(NSString *)title {
    self = [super init];
    if (self) {
        _title = [title copy];
        _isCompleted = NO;
    }
    return self;
}

// Mark the task as completed
- (void)complete {
    _isCompleted = YES;
    NSLog(@"%@ marked as completed.", self.title);
}

// Provide a description of the task
- (NSString *)taskDescription {
    return [NSString stringWithFormat:@"Task: %@, Completed: %d", self.title, self.isCompleted];
}

@end

@implementation SimpleTask

// SimpleTask uses the default implementation from Task

@end

@implementation CompositeTask

- (instancetype)initWithTitle:(NSString *)title {
    self = [super initWithTitle:title];
    if (self) {
        _subtasks = [NSMutableArray array];
    }
    return self;
}

// Add a subtask to the composite task
- (void)addSubtask:(Task *)subtask {
    // Use a lock to ensure thread safety when modifying subtasks
    @synchronized(self) {
        [self.subtasks addObject:subtask];
        NSLog(@"Added subtask %@ to composite task %@", subtask.title, self.title);
    }
}

// Remove a subtask from the composite task
- (void)removeSubtask:(Task *)subtask {
    // Use a lock to ensure thread safety when modifying subtasks
    @synchronized(self) {
        [self.subtasks removeObject:subtask];
        NSLog(@"Removed subtask %@ from composite task %@", subtask.title, self.title);
    }
}

// Override complete to mark all subtasks as completed
- (void)complete {
    // Use a lock to ensure thread safety when accessing subtasks
    @synchronized(self) {
        for (Task *subtask in self.subtasks) {
            [subtask complete];
        }
        [super complete];
    }
}

// Override taskDescription to include subtasks
- (NSString *)taskDescription {
    NSMutableString *description = [[super taskDescription] mutableCopy];
    [description appendString:@"\nSubtasks:\n"];
    
    // Use a lock to ensure thread safety when accessing subtasks
    @synchronized(self) {
        for (Task *subtask in self.subtasks) {
            [description appendFormat:@"- %@\n", [subtask taskDescription]];
        }
    }
    return description;
}

@end

@implementation HierarchiesPattern

+ (void)demoHierarchiesPattern {
    // 1. Create a hierarchy of tasks
    SimpleTask *task1 = [[SimpleTask alloc] initWithTitle:@"Write Code"];
    SimpleTask *task2 = [[SimpleTask alloc] initWithTitle:@"Test Code"];
    
    CompositeTask *projectTask = [[CompositeTask alloc] initWithTitle:@"Complete Project"];
    [projectTask addSubtask:task1];
    [projectTask addSubtask:task2];
    
    // 2. Log the initial hierarchy
    NSLog(@"Initial Task Hierarchy:\n%@", [projectTask taskDescription]);
    
    // 3. Complete a single task and log the hierarchy
    [task1 complete];
    NSLog(@"\nAfter completing 'Write Code':\n%@", [projectTask taskDescription]);
    
    // 4. Demonstrate thread safety by modifying the hierarchy from multiple threads
    NSLog(@"\n--- Demoing thread safety ---");
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.example.hierarchyQueue", DISPATCH_QUEUE_CONCURRENT);
    
    // Add a subtask from one thread
    SimpleTask *task3 = [[SimpleTask alloc] initWithTitle:@"Deploy Code"];
    dispatch_async(concurrentQueue, ^{
        [projectTask addSubtask:task3];
    });
    
    // Remove a subtask from another thread
    dispatch_async(concurrentQueue, ^{
        [projectTask removeSubtask:task2];
    });
    
    // Complete the composite task from a third thread
    dispatch_async(concurrentQueue, ^{
        [projectTask complete];
    });
    
    // 5. Simulate some delay to allow background threads to process
    [NSThread sleepForTimeInterval:1.0];
    
    // 6. Log the final hierarchy
    NSLog(@"\nFinal Task Hierarchy after concurrent modifications:\n%@", [projectTask taskDescription]);
    
    // Logs:
    // Initial Task Hierarchy:
    // Task: Complete Project, Completed: 0
    // Subtasks:
    // - Task: Write Code, Completed: 0
    // - Task: Test Code, Completed: 0
    //
    // After completing 'Write Code':
    // Write Code marked as completed.
    // Task: Complete Project, Completed: 0
    // Subtasks:
    // - Task: Write Code, Completed: 1
    // - Task: Test Code, Completed: 0
    //
    // --- Demoing thread safety ---
    // Added subtask Deploy Code to composite task Complete Project
    // Removed subtask Test Code from composite task Complete Project
    // Write Code marked as completed.
    // Deploy Code marked as completed.
    // Complete Project marked as completed.
    //
    // Final Task Hierarchy after concurrent modifications:
    // Task: Complete Project, Completed: 1
    // Subtasks:
    // - Task: Write Code, Completed: 1
    // - Task: Deploy Code, Completed: 1
}

@end

NS_ASSUME_NONNULL_END
