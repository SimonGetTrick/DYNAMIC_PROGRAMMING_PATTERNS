//
//  TwoStageCreation.m
//  Dynamic_Examples
//
//  Created by Simon Getrik on 17.05.2025.
//

#import "TwoStageCreation.h"

NS_ASSUME_NONNULL_BEGIN

@implementation TwoStageCreation

// Custom initializer — part of Two-Stage Creation pattern
- (instancetype)initWithFile:(NSString *)filePath {
    self = [super init]; // Stage 1: memory allocation and base init
    if (self) {
        NSLog(@"[TwoStageCreation] initWithFile: %@", filePath);

        // Stage 2: Custom initialization logic

        // Extract file name from path
        NSString *fileName = [filePath lastPathComponent];
        // Extract folder path (directory) from full path
        NSString *directory = [filePath stringByDeletingLastPathComponent];

        // Save raw path
        _filePath = filePath;
        // Store formatted information
        _contents = [NSString stringWithFormat:@"File name: %@\nFolder: %@", fileName, directory];
    }
    return self;
}

@end

NS_ASSUME_NONNULL_END
