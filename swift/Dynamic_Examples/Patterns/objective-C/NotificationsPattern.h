//
//  NotificationsPattern.h
//  Dynamic_Examples
//
//  Created by Simon Getrik on 28.05.2025.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// Class to send notifications
@interface DataManager : NSObject

- (void)sendDataUpdateNotificationWithValue:(NSString *)value;
- (void)sendThreadedDataUpdateNotificationWithValue:(NSString *)value;

@end

// Class to observe and handle notifications
@interface NotificationObserver : NSObject

- (void)startObserving;
- (void)stopObserving;

@end

// Class for demonstrating the Notifications pattern
@interface NotificationsPattern : NSObject

+ (void)demoNotificationsPattern;

@end

NS_ASSUME_NONNULL_END
