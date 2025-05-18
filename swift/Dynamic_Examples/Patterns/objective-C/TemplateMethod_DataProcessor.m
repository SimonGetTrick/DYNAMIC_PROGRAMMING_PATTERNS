//
//  TemplateMethod_DataProcessor.m
//  Dynamic_Examples
//
//  Created by Simon Getrik on 18.05.2025.
//

#import "TemplateMethod_DataProcessor.h"

NS_ASSUME_NONNULL_BEGIN

@implementation TemplateMethod_DataProcessor

- (void)process {
    NSLog(@"Starting process...");
    [self loadData];
    [self transformData];
    [self saveData];
    NSLog(@"Process complete.");
}

// Default implementations (can be overridden)
- (void)loadData {
    NSLog(@"[DataProcessor] Loading data (default)");
}

- (void)transformData {
    NSLog(@"[DataProcessor] Transforming data (default)");
}

- (void)saveData {
    NSLog(@"[DataProcessor] Saving data (default)");
}

@end

@implementation CustomDataProcessor

- (void)loadData {
    NSLog(@"[CustomDataProcessor] Loading custom data...");
}

- (void)transformData {
    NSLog(@"[CustomDataProcessor] Transforming custom data...");
}

- (void)saveData {
    NSLog(@"[CustomDataProcessor] Saving custom data...");
}

@end

@implementation TemplateTestHelper

+ (void)runTemplateDemo {
    CustomDataProcessor *processor = [[CustomDataProcessor alloc] init];
    [processor process];
}

@end
NS_ASSUME_NONNULL_END
