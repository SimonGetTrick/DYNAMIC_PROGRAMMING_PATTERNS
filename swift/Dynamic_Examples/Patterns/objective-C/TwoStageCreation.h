//
//  TwoStageCreation.h
//  Dynamic_Examples
//
//  Created by Simon Getrik on 17.05.2025.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TwoStageCreation : NSObject

// Custom initializer that takes a file path string
- (instancetype)initWithFile:(NSString *)filePath;

// Full input path (unchanged)
@property (nonatomic, readonly) NSString *filePath;

// Parsed description (filename and directory)
@property (nonatomic, readonly) NSString *contents;

@end

NS_ASSUME_NONNULL_END
