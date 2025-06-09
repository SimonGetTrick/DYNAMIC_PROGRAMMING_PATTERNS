//
//  FacadePattern.h
//  Dynamic_Examples
//
//  Created by Simon Getrik on 09.06.2025.
//

#import <Foundation/Foundation.h>
/*
 📘 Facade Patterns in UIKit and SwiftUI
 Facade is a structural design pattern that provides a simplified interface to a complex system. In Apple's frameworks like UIKit and SwiftUI, many types act as facades — they expose easy-to-use APIs while hiding intricate subsystems, internal logic, and performance optimizations.

 🧩 UIKit Examples:
 UIViewController
 → Manages the view hierarchy, view lifecycle, memory handling, and user interactions.

 UIImageView
 → Abstracts away image decoding, caching, and rendering via Core Animation layers.

 UINavigationController
 → Wraps a stack-based navigation system, transitions, gesture handling, and bar updates.

 UITableView / UICollectionView
 → Manage cell reuse, scrolling performance, layout, and data-driven UI updates behind simple data source and delegate methods.

 UIApplication
 → Orchestrates the app's lifecycle, event loop, system notifications, and background modes.

 🌱 SwiftUI Examples:
 @State, @Binding, @ObservedObject
 → Facade for reactive state management, view updates, and data propagation.

 Form, NavigationStack, List
 → Compose dynamic UI with minimal code, while internally managing layout, hierarchy, accessibility, and transitions.

 Image("name")
 → Handles asset loading, resolution scaling, rendering, and fallback logic automatically.

 💡 Key Idea:
 With facades, Apple frameworks let developers focus on what they want to do, not how the system works under the hood. These types encapsulate complexity and expose minimal, expressive APIs.
 */
NS_ASSUME_NONNULL_BEGIN

/// Subsystems
@interface Projector : NSObject
- (void)turnOn;
- (void)turnOff;
@end

@interface Amplifier : NSObject
- (void)turnOn;
- (void)setVolume:(int)level;
@end

@interface Screen : NSObject
- (void)lower;
- (void)raise;
@end

@interface MoviePlayer : NSObject
- (void)playMovie:(NSString *)name;
- (void)stopMovie;
@end

/// Facade
@interface HomeTheaterFacade : NSObject

- (void)startMovieNightWithTitle:(NSString *)title;
- (void)endMovieNight;

@end

/// Demo class
@interface FacadePattern : NSObject

+ (void)demoFacadePattern;

@end

NS_ASSUME_NONNULL_END
