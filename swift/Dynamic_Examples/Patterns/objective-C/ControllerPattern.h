//
//  ControllerPattern.h
//  Dynamic_Examples
//
//  Created by Simon Getrik on 12.06.2025.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Note : NSObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSDate *date;

- (instancetype)initWithText:(NSString *)text;

@end

@interface NoteController : NSObject

+ (void)runDemo;

@end


NS_ASSUME_NONNULL_END
