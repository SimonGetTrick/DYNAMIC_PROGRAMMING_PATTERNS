//
//  DelegatePattern.m
//  Dynamic_Examples
//
//  Created by Simon Getrik on 29.05.2025.
//

#import "DelegatePattern.h"

NS_ASSUME_NONNULL_BEGIN

@implementation DataProcessor

// Process data on the main thread
- (void)processData:(NSString *)input {
    // Simulate data processing
    NSString *result = [NSString stringWithFormat:@"Processed: %@", input];
    NSLog(@"Processing data on main thread: %@", result);
    
    // Notify delegate of the result (on the main thread)
    if ([self.delegate respondsToSelector:@selector(dataProcessor:didFinishProcessingData:)]) {
        [self.delegate dataProcessor:self didFinishProcessingData:result];
    }
}

// Process data on a background thread
- (void)processDataInBackground:(NSString *)input {
    // Create a background queue for processing
    dispatch_queue_t backgroundQueue = dispatch_queue_create("com.example.backgroundQueue", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(backgroundQueue, ^{
        // Simulate data processing
        NSString *result = [NSString stringWithFormat:@"Processed: %@", input];
        NSLog(@"Processing data on background thread: %@ on thread %@", result, [NSThread currentThread]);
        
        // Notify delegate on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([self.delegate respondsToSelector:@selector(dataProcessor:didFinishProcessingData:)]) {
                [self.delegate dataProcessor:self didFinishProcessingData:result];
            }
        });
        
        // Simulate an error condition for demonstration
        if ([input isEqualToString:@"ErrorCase"]) {
            NSError *error = [NSError errorWithDomain:@"DataProcessorErrorDomain"
                                                 code:1001
                                             userInfo:@{NSLocalizedDescriptionKey: @"Failed to process data"}];
            // Notify delegate of the error on the main thread
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([self.delegate respondsToSelector:@selector(dataProcessor:didFailWithError:)]) {
                    [self.delegate dataProcessor:self didFailWithError:error];
                }
            });
        }
    });
}

@end

@implementation DelegatePattern

// Implement the required delegate method
- (void)dataProcessor:(DataProcessor *)processor didFinishProcessingData:(NSString *)result {
    NSLog(@"Delegate received processed data: %@", result);
}

// Implement the optional delegate method
- (void)dataProcessor:(DataProcessor *)processor didFailWithError:(NSError *)error {
    NSLog(@"Delegate received error: %@", error.localizedDescription);
}

// Demonstration method for the Delegate pattern
+ (void)demoDelegatePattern {
    // 1. Create instances of DataProcessor and DelegatePattern
    DataProcessor *processor = [[DataProcessor alloc] init];
    DelegatePattern *delegate = [[DelegatePattern alloc] init];
    
    // 2. Set the delegate
    processor.delegate = delegate;
    
    // 3. Process data on the main thread
    NSLog(@"--- Processing data on main thread ---");
    [processor processData:@"MainThreadData"];
    
    // 4. Process data on a background thread
    NSLog(@"\n--- Processing data on background thread ---");
    [processor processDataInBackground:@"BackgroundThreadData"];
    
    // 5. Process data with an error case to trigger the optional delegate method
    NSLog(@"\n--- Processing data with error case ---");
    [processor processDataInBackground:@"ErrorCase"];
    
    // 6. Simulate some delay to allow background thread to process
    [NSThread sleepForTimeInterval:1.0];
    
    // Logs:
    // --- Processing data on main thread ---
    // Processing data on main thread: Processed: MainThreadData
    // Delegate received processed data: Processed: MainThreadData
    //
    // --- Processing data on background thread ---
    // Processing data on background thread: Processed: BackgroundThreadData on thread <NSThread: 0x...>{number = 3, name = (null)}
    // Delegate received processed data: Processed: BackgroundThreadData
    //
    // --- Processing data with error case ---
    // Processing data on background thread: Processed: ErrorCase on thread <NSThread: 0x...>{number = 4, name = (null)}
    // Delegate received processed data: Processed: ErrorCase
    // Delegate received error: Failed to process data
}

@end

NS_ASSUME_NONNULL_END
