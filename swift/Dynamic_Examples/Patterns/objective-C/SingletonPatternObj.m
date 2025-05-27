//
//  SingletonPattern.m
//  Dynamic_Examples
//
//  Created by Simon Getrik on 27.05.2025.
//

#import "SingletonPatternObj.h"

NS_ASSUME_NONNULL_BEGIN

@implementation AppConfiguration

// The single static instance of the singleton.
static AppConfiguration *_sharedConfiguration = nil;

// The dispatch_once_t token ensures that the block passed to dispatch_once is executed exactly once.
static dispatch_once_t _onceToken;

// MARK: - Singleton Access Method

// This is the public, thread-safe access point for the singleton instance.
+ (instancetype)sharedConfiguration {
    // The dispatch_once block ensures that the code inside is executed only once
    // throughout the app's lifetime, even if called concurrently from multiple threads.
    // This is the core mechanism for thread-safe singleton initialization.
    dispatch_once(&_onceToken, ^{
        // Allocate the instance using the superclass's allocWithZone:
        // Then, immediately initialize it using our private designated initializer `_init`.
        _sharedConfiguration = [[super allocWithZone:NULL] _init]; // Allocate via superclass, then use our private initializer.
        
        // Initialize default configuration values here, after allocation and basic initialization.
        _sharedConfiguration.baseURL = @"https://api.example.com";
        _sharedConfiguration.timeoutInterval = 30;
        NSLog(@"AppConfiguration singleton initialized.");
    });
    return _sharedConfiguration;
}

// MARK: - Preventing Multiple Instances

// Override allocWithZone: to ensure that new instances cannot be created directly.
// All attempts to allocate a new instance via `[[AppConfiguration alloc] ...]`
// will be intercepted here, and the existing shared instance will be returned.
// Importantly, this method does NOT contain its own dispatch_once, it relies on the one in sharedConfiguration.
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    // If the singleton has already been created through sharedConfiguration, return it.
    // This check is outside dispatch_once, as dispatch_once would block if it's already done.
    if (_sharedConfiguration) {
        return _sharedConfiguration;
    }
    
    // If it's the very first time and allocWithZone: is called directly before sharedConfiguration,
    // ensure allocation happens only once via dispatch_once.
    // This might seem redundant with the dispatch_once in sharedConfiguration,
    // but it catches cases where someone tries `[[AppConfiguration alloc] init]` before `sharedConfiguration`.
    // However, the most robust way is to make `init` and `new` unavailable, as done below.
    // The preferred way for allocWithZone to behave in a singleton is to simply return the existing instance.
    // If _sharedConfiguration is nil at this point, it means sharedConfiguration hasn't been called yet.
    // In strict singleton patterns, you might even raise an exception here if _sharedConfiguration is nil
    // to strictly enforce creation only through `sharedConfiguration`.
    // For this example, we will align it with the behavior of sharedConfiguration to always yield the same object.
    
    // The common and correct pattern here is to call sharedConfiguration which handles the dispatch_once.
    // Or, in a more strict interpretation of singleton enforcement, raise an exception
    // if _sharedConfiguration is nil.
    // A simpler and robust approach is:
    return [self sharedConfiguration]; // This will ensure the instance is created safely and returned.
}


// Private initializer: This initializer is called *only* from within the `sharedConfiguration` method.
// It performs the actual object setup.
- (instancetype)_init {
    self = [super init];
    if (self) {
        // Any specific setup for the singleton instance goes here.
        // Properties will be set in sharedConfiguration after _init returns.
    }
    return self;
}

// Prevent copying of the singleton instance.
// If an attempt is made to copy the singleton, simply return the existing instance.
- (id)copyWithZone:(nullable NSZone *)zone {
    NSLog(@"Attempted to copy AppConfiguration, returning existing shared instance.");
    return _sharedConfiguration;
}

// MARK: - Configuration Usage

- (void)printConfiguration {
    NSLog(@"Current App Configuration: Base URL: %@, Timeout: %ld seconds",
          self.baseURL, (long)self.timeoutInterval);
}

@end


// MARK: - Demonstration Class

@implementation SingletonPatternObj

+ (void)demoSingletonPattern {
    NSLog(@"--- Demoing Singleton Pattern ---");

    // Get the first instance of the configuration
    AppConfiguration *config1 = [AppConfiguration sharedConfiguration];
    [config1 printConfiguration];

    // Get the second instance. This will return the *same* instance.
    AppConfiguration *config2 = [AppConfiguration sharedConfiguration];
    [config2 printConfiguration];

    NSLog(@"Are config1 and config2 the same instance? %d", (config1 == config2)); // Should be YES

    // Try to change a property via one reference and see it reflected in the other
    config1.baseURL = @"https://newapi.example.com/v2";
    NSLog(@"\nAfter changing baseURL via config1:");
    [config1 printConfiguration];
    [config2 printConfiguration]; // config2 also reflects the change

    // Attempting to create a new instance directly using the standard init will now result in a compile-time error
    // because we marked it as NS_UNAVAILABLE.
    // AppConfiguration *config3 = [[AppConfiguration alloc] init]; // Compiler Error: 'init' is unavailable

    // However, if someone tries to call alloc and then init (which is unavailable),
    // the allocWithZone: override will intercept it and return the shared instance.
    // The compiler will still throw an error if `init` is explicitly called and marked unavailable.
    // To demonstrate the allocWithZone: interception without a compile-time error,
    // we can rely on `sharedConfiguration` being called by `allocWithZone`.
    AppConfiguration *config3 = [AppConfiguration alloc]; // This will call allocWithZone:
    // If you then try to call init on it, it will be a compile error.
    // To get around this for a demo (not recommended for production!), you could cast to id or use performSelector,
    // but the point of NS_UNAVAILABLE is to prevent this at compile time.
    
    // The correct way to test the allocWithZone: override is to trust that
    // it returns the _sharedConfiguration, which is what [self sharedConfiguration] does.
    // So, calling `[AppConfiguration alloc]` directly will actually lead to `sharedConfiguration` being called internally by the override.
    // This makes `config3` point to the singleton.
    NSLog(@"\nAttempting to create config3 via alloc (implicitly calling allocWithZone:): %@", config3);
    NSLog(@"Are config1 and config3 the same instance? %d", (config1 == config3)); // Should be YES

    // Try to copy the singleton (will return the existing shared instance due to copyWithZone override)
    AppConfiguration *config4 = [config1 copy];
    NSLog(@"\nAttempting to copy config1 to config4: %@", config4);
    NSLog(@"Are config1 and config4 the same instance? %d", (config1 == config4)); // Should be YES
}

@end

NS_ASSUME_NONNULL_END
