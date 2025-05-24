//
//  AccessorsPattern.m
//  Dynamic_Examples
//
//  Created by Simon Getrik on 24.05.2025.
//

#import "AccessorsPattern.h"

@implementation Person

// Synthesize properties (implicitly handled by modern Objective-C, but shown for clarity)
@synthesize name = _name;
@synthesize age = _age;

- (instancetype)initWithName:(NSString *)name age:(NSInteger)age {
    self = [super init];
    if (self) {
        _name = name;
        _age = age;
    }
    return self;
}

// Custom getter for fullName
- (NSString *)fullName {
    // In a real scenario, 'name' might be first and last name properties.
    // For this example, we'll just return the 'name' property.
    return self.name;
}

// Custom setter example (optional, typically for additional logic)
- (void)setAge:(NSInteger)age {
    if (age < 0) {
        _age = 0; // Ensure age is not negative
    } else {
        _age = age;
    }
}

@end


@implementation AccessorsPattern

+ (void)demoAccessorsPattern {
    // Create a Person object
    Person *person = [[Person alloc] initWithName:@"Alice" age:30];

    // Using dot syntax for getters
    NSLog(@"Person's name: %@", person.name); // Accessing the 'name' property using its getter
    NSLog(@"Person's age: %ld", (long)person.age); // Accessing the 'age' property using its getter

    // Using dot syntax for setters
    person.name = @"Bob"; // Setting the 'name' property using its setter
    person.age = 25;       // Setting the 'age' property using its setter (triggers custom setter if present)

    NSLog(@"\nAfter modification:");
    NSLog(@"Person's new name: %@", person.name);
    NSLog(@"Person's new age: %ld", (long)person.age);
    NSLog(@"Person's full name (read-only property): %@", person.fullName);

    // Demonstrate custom setter logic
    person.age = -5; // This will set age to 0 due to custom setter
    NSLog(@"\nAfter setting age to -5 (custom setter effect): %ld", (long)person.age);

    // Logs:
    // Person's name: Alice
    // Person's age: 30
    //
    // After modification:
    // Person's new name: Bob
    // Person's new age: 25
    // Person's full name (read-only property): Bob
    //
    // After setting age to -5 (custom setter effect): 0
}

@end
