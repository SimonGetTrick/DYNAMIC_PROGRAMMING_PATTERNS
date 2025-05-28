//
//  NotificationsPattern.m
//  Dynamic_Examples
//
//  Created by Simon Getrik on 28.05.2025.
//

#import "NotificationsPattern.h"

NS_ASSUME_NONNULL_BEGIN

@implementation DataManager

// Define a notification name as a constant
static NSString *const kDataUpdateNotification = @"DataUpdateNotification";

// Method to send a notification on the current thread
- (void)sendDataUpdateNotificationWithValue:(NSString *)value {
    // Create a user info dictionary to pass data with the notification
    NSDictionary *userInfo = @{@"value": value};
    
    // Post notification on the default notification center
    [[NSNotificationCenter defaultCenter] postNotificationName:kDataUpdateNotification
                                                      object:self
                                                    userInfo:userInfo];
    NSLog(@"Notification sent with value: %@", value);
}

// Method to send a notification from a background thread
- (void)sendThreadedDataUpdateNotificationWithValue:(NSString *)value {
    // Use a background queue to simulate a threaded operation
    dispatch_queue_t backgroundQueue = dispatch_queue_create("com.example.backgroundQueue", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(backgroundQueue, ^{
        // Create user info dictionary
        NSDictionary *userInfo = @{@"value": value};
        
        // Post notification from the background thread
        [[NSNotificationCenter defaultCenter] postNotificationName:kDataUpdateNotification
                                                          object:self
                                                        userInfo:userInfo];
        NSLog(@"Threaded notification sent with value: %@ on thread %@", value, [NSThread currentThread]);
    });
}

@end

@implementation NotificationObserver

// Start observing notifications
- (void)startObserving {
    // Register to receive notifications for kDataUpdateNotification
    [[NSNotificationCenter defaultCenter] addObserver:self
                                            selector:@selector(handleDataUpdate:)
                                                name:kDataUpdateNotification
                                              object:nil];
    NSLog(@"Observer registered for data updates.");
}

// Handle the notification
- (void)handleDataUpdate:(NSNotification *)notification {
    // Ensure thread safety by logging on the main thread
    dispatch_async(dispatch_get_main_queue(), ^{
        NSDictionary *userInfo = notification.userInfo;
        NSString *value = userInfo[@"value"];
        NSLog(@"Received notification with value: %@ on thread %@", value, [NSThread currentThread]);
    });
}

// Stop observing notifications
- (void)stopObserving {
    // Remove observer to prevent memory leaks
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kDataUpdateNotification
                                                  object:nil];
    NSLog(@"Observer unregistered.");
}

- (void)dealloc {
    // Clean up observer on deallocation
    [self stopObserving];
}

@end

@implementation NotificationsPattern

+ (void)demoNotificationsPattern {
    // 1. Create instances of DataManager and NotificationObserver
    DataManager *dataManager = [[DataManager alloc] init];
    NotificationObserver *observer = [[NotificationObserver alloc] init];
    
    // 2. Start observing notifications
    [observer startObserving];
    
    // 3. Send a notification from the main thread
    [dataManager sendDataUpdateNotificationWithValue:@"MainThreadUpdate"];
    
    // 4. Send a notification from a background thread
    NSLog(@"\n--- Demoing threaded notifications ---");
    [dataManager sendThreadedDataUpdateNotificationWithValue:@"BackgroundThreadUpdate"];
    
    // 5. Simulate some delay to allow background thread to process
    [NSThread sleepForTimeInterval:1.0];
    
    // 6. Stop observing notifications
    [observer stopObserving];
    
    // 7. Send one more notification to show it won't be handled
    [dataManager sendDataUpdateNotificationWithValue:@"PostUnregisterUpdate"];
    NSLog(@"Notification sent after unregistration, should not be handled.");
    
    // Logs:
    // Observer registered for data updates.
    // Notification sent with value: MainThreadUpdate
    // Received notification with value: MainThreadUpdate on thread <NSThread: 0x...>{number = 1, name = (null)}
    //
    // --- Demoing threaded notifications ---
    // Threaded notification sent with value: BackgroundThreadUpdate on thread <NSThread: 0x...>{number = 3, name = (null)}
    // Received notification with value: BackgroundThreadUpdate on thread <NSThread: 0x...>{number = 1, name = (null)}
    // Observer unregistered.
    // Notification sent with value: PostUnregisterUpdate, should not be handled.
}

@end

NS_ASSUME_NONNULL_END
