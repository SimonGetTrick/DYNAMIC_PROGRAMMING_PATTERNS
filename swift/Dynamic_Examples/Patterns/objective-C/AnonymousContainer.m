//
//  AnonymousContainer.m
//  Dynamic_Examples
//
//  Created by Simon Getrik on 21.05.2025.
//

#import "AnonymousContainer.h"

NS_ASSUME_NONNULL_BEGIN

@implementation AnonymousContainer

- (void)storeItems:(id)item1 andItem:(id)item2 {
    self.items = @[item1, item2];
}

- (void)processItems {
    for (id item in self.items) {
        if ([item isKindOfClass:[NSString class]]) {
            NSLog(@"String: %@", item);
        } else if ([item isKindOfClass:[NSNumber class]]) {
            NSLog(@"Number: %ld", [item integerValue]);
        } else {
            NSLog(@"Unknown item: %@", item);
        }
    }
}

@end


@implementation AnonymousContainerDemo

+ (void)demoAnonymousContainer {
    AnonymousContainer *container = [[AnonymousContainer alloc] init];
    [container storeItems:@"Hello" andItem:@42];
    [container processItems];
    // Logs:
    // String: Hello
    // Number: 42
}

@end

NS_ASSUME_NONNULL_END

//// Usage Example
//int main() {
//    @autoreleasepool {
//        AnonymousContainer *container = [[AnonymousContainer alloc] init];
//        [container storeItems:@"Hello" andItem:@42];
//        [container processItems];
//        // Logs:
//        // String: Hello
//        // Number: 42
//    }
//    return 0;
//}
