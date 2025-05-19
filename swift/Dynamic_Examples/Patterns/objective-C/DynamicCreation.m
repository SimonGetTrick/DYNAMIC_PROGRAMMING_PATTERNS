//
//  DynamicCreation.m
//  Dynamic_Examples
//
//  Created by Simon Getrik on 19.05.2025.
//

#import "DynamicCreation.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - DCAnimal (Base)

@implementation DCAnimal
- (void)speak {
    NSLog(@"DCAnimal makes a sound");
}
@end

#pragma mark - DCDog (Subclass)

@implementation DCDog
- (void)speak {
    NSLog(@"Woof! (DCDog)");
}
@end

#pragma mark - DCDynamicAnimalFactory

@implementation DCDynamicAnimalFactory

+ (DCAnimal *)createAnimalWithName:(NSString *)className {
    Class cls = NSClassFromString(className);
    if (cls && [cls isSubclassOfClass:[DCAnimal class]]) {
        return [[cls alloc] init];
    } else {
        NSLog(@"[DCDynamicAnimalFactory] Invalid class: %@", className);
        return nil;
    }
}

@end


NS_ASSUME_NONNULL_END
