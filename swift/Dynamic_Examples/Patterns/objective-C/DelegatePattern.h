//
//  DelegatePattern.h
//  Dynamic_Examples
//
//  Created by Simon Getrik on 29.05.2025.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// Forward declaration of the DataProcessor class
@class DataProcessor;

// Protocol defining the delegate methods
@protocol DataProcessorDelegate <NSObject>

// Required method for handling processed data
- (void)dataProcessor:(DataProcessor *)processor didFinishProcessingData:(NSString *)result;

// Optional method for handling errors
@optional
- (void)dataProcessor:(DataProcessor *)processor didFailWithError:(NSError *)error;

@end

// Class responsible for processing data and notifying its delegate
@interface DataProcessor : NSObject

// Delegate property (weak to avoid retain cycles)
@property (nonatomic, weak, nullable) id<DataProcessorDelegate> delegate;

// Method to process data on the main thread
- (void)processData:(NSString *)input;

// Method to process data on a background thread
- (void)processDataInBackground:(NSString *)input;

@end

// Class for demonstrating the Delegate pattern
@interface DelegatePattern : NSObject <DataProcessorDelegate>

// Method to run the demonstration
+ (void)demoDelegatePattern;

@end

NS_ASSUME_NONNULL_END
