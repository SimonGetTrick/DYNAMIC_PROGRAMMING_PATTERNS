//
//  DynamicCreation.h
//  Dynamic_Examples
//
//  Created by Simon Getrik on 19.05.2025.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// Base class
@interface DCAnimal : NSObject
- (void)speak;
@end

/// Subclass: Dog
@interface DCDog : DCAnimal
@end

/// Factory for dynamic creation
@interface DCDynamicAnimalFactory : NSObject
+ (DCAnimal *)createAnimalWithName:(NSString *)className;
@end

NS_ASSUME_NONNULL_END
