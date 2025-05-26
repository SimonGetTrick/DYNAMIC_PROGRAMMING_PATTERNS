//
//  CopyingPattern.m
//  Dynamic_Examples
//
//  Created by Simon Getrik on 26.05.2025.
//

#import "CopyingPattern.h"

NS_ASSUME_NONNULL_BEGIN

// Implementation of UserProfile class
@implementation UserProfile

- (instancetype)initWithUsername:(NSString *)username userID:(NSInteger)userID favoriteFoods:(NSArray<NSString *> *)foods {
    self = [super init];
    if (self) {
        _username = [username copy]; // Copy immutable strings
        _userID = userID;
        _favoriteFoods = [NSMutableArray arrayWithArray:foods]; // Create a mutable copy of the array for 'deep' copy behavior
    }
    return self;
}

// Override description for convenient logging
- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p> Username: %@, UserID: %ld, Favorite Foods: %@",
            NSStringFromClass([self class]), self, self.username, (long)self.userID, self.favoriteFoods];
}

#pragma mark - NSCopying Protocol

// This is the core method for the Copying pattern
- (id)copyWithZone:(nullable NSZone *)zone {
    // 1. Allocate a new instance of the class in the specified zone.
    UserProfile *copy = [[[self class] allocWithZone:zone] init];

    // 2. Copy the properties from the original to the new instance.
    //    Be mindful of "shallow" vs. "deep" copies for object properties.
    //    For immutable objects (like NSString), a "shallow" copy is usually fine as they can't be changed.
    //    For mutable objects (like NSMutableArray), you often need a "deep" copy to ensure independence.

    copy.username = [self.username copyWithZone:zone]; // Deep copy for username (though NSString is immutable)
    copy.userID = self.userID; // Primitive types are always copied by value

    // This is crucial: if you want the array in the copy to be independent
    // of the original array, you must create a *new* mutable copy of it.
    // If you just did `copy.favoriteFoods = self.favoriteFoods;`,
    // both original and copy would share the same mutable array.
    copy.favoriteFoods = [[NSMutableArray alloc] initWithArray:self.favoriteFoods copyItems:YES]; // Deep copy of the array and its contents

    return copy;
}

@end


// Implementation of the demonstration class
@implementation CopyingPattern

+ (void)demoCopyingPattern {
    // 1. Create an original UserProfile object
    UserProfile *originalUser = [[UserProfile alloc] initWithUsername:@"Alice"
                                                               userID:101
                                                        favoriteFoods:@[@"Pizza", @"Sushi"]];
    NSLog(@"Original User: %@", originalUser);
    NSLog(@"Original User (Foods Array Address): %p", originalUser.favoriteFoods);


    // 2. Create a copy using the `copy` method (which calls `copyWithZone:`)
    UserProfile *copiedUser = [originalUser copy];
    NSLog(@"\nCopied User (initial): %@", copiedUser);
    NSLog(@"Copied User (Foods Array Address): %p", copiedUser.favoriteFoods);

    // Verify that the objects themselves are different instances
    NSLog(@"Are original and copied user objects the same? %d", (originalUser == copiedUser)); // Should be NO

    // 3. Modify the copied object's mutable property
    //    If `favoriteFoods` was shallow-copied, this modification would affect originalUser too.
    //    Because we performed a deep copy of `favoriteFoods`, originalUser remains unaffected.
    [copiedUser.favoriteFoods addObject:@"Ice Cream"];
    copiedUser.userID = 202;
    copiedUser.username = @"Bob"; // Changing username on copy

    NSLog(@"\nCopied User (after modification): %@", copiedUser);
    NSLog(@"Original User (after copy modification): %@", originalUser);

    // Logs:
    // Original User: <UserProfile: 0x...> Username: Alice, UserID: 101, Favorite Foods: (
    //     Pizza,
    //     Sushi
    // )
    // Original User (Foods Array Address): 0x...
    //
    // Copied User (initial): <UserProfile: 0x...> Username: Alice, UserID: 101, Favorite Foods: (
    //     Pizza,
    //     Sushi
    // )
    // Copied User (Foods Array Address): 0x... (Different from Original User Foods Array Address)
    // Are original and copied user objects the same? 0
    //
    // Copied User (after modification): <UserProfile: 0x...> Username: Bob, UserID: 202, Favorite Foods: (
    //     Pizza,
    //     Sushi,
    //     Ice Cream
    // )
    // Original User (after copy modification): <UserProfile: 0x...> Username: Alice, UserID: 101, Favorite Foods: (
    //     Pizza,
    //     Sushi
    // )
}

@end

NS_ASSUME_NONNULL_END
