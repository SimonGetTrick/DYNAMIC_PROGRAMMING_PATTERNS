//
//  EnumeratorPattern.m
//  Dynamic_Examples
//
//  Created by Simon Getrik on 22.05.2025.
//

#import "EnumeratorPattern.h"

NS_ASSUME_NONNULL_BEGIN

// Implementation of CustomCollection
@implementation CustomCollection {
    NSArray *_items;
}

- (instancetype)initWithItems:(NSArray *)items {
    self = [super init];
    if (self) {
        _items = [items copy];
    }
    return self;
}

- (NSEnumerator *)objectEnumerator {
    return [_items objectEnumerator];
}

- (NSUInteger)count {
    return _items.count;
}

@end

// Implementation of EnumeratorPattern
@implementation EnumeratorPattern

+ (void)demoEnumeratorPattern {
    // Create a custom collection with sample data
    CustomCollection *collection = [[CustomCollection alloc] initWithItems:@[@"Apple", @42, @"Banana", @7]];
    
    // Use NSEnumerator to iterate
    NSEnumerator *enumerator = [collection objectEnumerator];
    id object;
    NSLog(@"Enumerating collection (count: %lu):", (unsigned long)[collection count]);
    while ((object = [enumerator nextObject])) {
        NSLog(@"Item: %@", object);
    }
    // Logs:
    // Enumerating collection (count: 4):
    // Item: Apple
    // Item: 42
    // Item: Banana
    // Item: 7
}

@end

NS_ASSUME_NONNULL_END
