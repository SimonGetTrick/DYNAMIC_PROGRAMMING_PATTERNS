//
//  2.2.BridgeCrossPlathormExample.swift
//  Dynamic_Examples
//
//  Created by Simon Getrik on 12.05.2025.
//

import Foundation

// MARK: - Bridge Pattern
// The Bridge pattern decouples an abstraction from its implementation,
// allowing cross-platform code to work with platform-specific implementations.

// Protocol defining the platform-specific implementation for notifications
protocol NotificationService {
    func sendPushNotification(title: String, body: String, userId: String)
    func scheduleLocalNotification(title: String, body: String, delay: TimeInterval)
}

// iOS-specific implementation of the notification service
class iOSNotificationService: NotificationService {
    func sendPushNotification(title: String, body: String, userId: String) {
        // Simulate iOS push notification (e.g., using UserNotifications framework)
        print("iOS: Sending push notification to user \(userId) - Title: \(title), Body: \(body)")
    }
    
    func scheduleLocalNotification(title: String, body: String, delay: TimeInterval) {
        // Simulate scheduling a local notification on iOS
        print("iOS: Scheduling local notification after \(delay)s - Title: \(title), Body: \(body)")
    }
}

// macOS-specific implementation of the notification service
class MacOSNotificationService: NotificationService {
    func sendPushNotification(title: String, body: String, userId: String) {
        // Simulate macOS push notification (e.g., using NSUserNotification)
        print("macOS: Sending push notification to user \(userId) - Title: \(title), Body: \(body)")
    }
    
    func scheduleLocalNotification(title: String, body: String, delay: TimeInterval) {
        // Simulate scheduling a local notification on macOS
        print("macOS: Scheduling local notification after \(delay)s - Title: \(title), Body: \(body)")
    }
}

// Abstraction defining the high-level notification manager
class NotificationManager {
    private let notificationService: NotificationService
    
    init(notificationService: NotificationService) {
        self.notificationService = notificationService
    }
    
    // Send a push notification using the platform-specific service
    func sendPush(to userId: String, title: String, body: String) {
        notificationService.sendPushNotification(title: title, body: body, userId: userId)
    }
    
    // Schedule a local notification using the platform-specific service
    func scheduleReminder(title: String, body: String, delay: TimeInterval) {
        notificationService.scheduleLocalNotification(title: title, body: body, delay: delay)
    }
}

// Cross-platform app logic using the NotificationManager
class App {
    private let notificationManager: NotificationManager
    
    init(notificationService: NotificationService) {
        self.notificationManager = NotificationManager(notificationService: notificationService)
    }
    
    // Example method to notify a user
    func notifyUser(userId: String) {
        notificationManager.sendPush(to: userId, title: "New Message", body: "You have a new message!")
    }
    
    // Example method to schedule a reminder
    func setReminder() {
        notificationManager.scheduleReminder(title: "Meeting", body: "Team meeting in 10 minutes", delay: 600)
    }
}

// Demo function to showcase the Bridge pattern for cross-platform notifications
func demo_CrossPlatformBridge() {
    // Use iOS notification service
    let iOSService = iOSNotificationService()
    let iOSApp = App(notificationService: iOSService)
    print("Running on iOS:")
    iOSApp.notifyUser(userId: "user123")
    iOSApp.setReminder()
    
    // Use macOS notification service
    let macOSService = MacOSNotificationService()
    let macOSApp = App(notificationService: macOSService)
    print("\nRunning on macOS:")
    macOSApp.notifyUser(userId: "user456")
    macOSApp.setReminder()
}

// Run the demo
//demo_CrossPlatformBridge()
