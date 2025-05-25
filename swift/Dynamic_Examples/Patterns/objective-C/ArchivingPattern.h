//
//  ArchivingPattern.h
//  Dynamic_Examples
//
//  Created by Simon Getrik on 25.05.2025.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// Data model that we will archive and unarchive
@interface Book : NSObject <NSCoding>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, assign) NSInteger year;

- (instancetype)initWithTitle:(NSString *)title author:(NSString *)author year:(NSInteger)year;

@end

// Class for demonstrating the archiving/unarchiving pattern
@interface ArchivingPattern : NSObject

+ (void)demoArchivingUnarchiving;

@end

NS_ASSUME_NONNULL_END
