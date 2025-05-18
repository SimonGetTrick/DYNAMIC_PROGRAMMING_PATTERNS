//
//  TemplateMethod_DataProcessor.h
//  Dynamic_Examples
//
//  Created by Simon Getrik on 18.05.2025.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TemplateMethod_DataProcessor : NSObject

// Template method — defines the overall process
- (void)process;

// Hook methods — meant to be overridden
- (void)loadData;
- (void)transformData;
- (void)saveData;

@end

@interface CustomDataProcessor : TemplateMethod_DataProcessor
@end

@interface TemplateTestHelper : NSObject

+ (void)runTemplateDemo;

@end
NS_ASSUME_NONNULL_END
