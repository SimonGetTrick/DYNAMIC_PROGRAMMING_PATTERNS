//
//  ApplicationKitViewsPattern.m
//  Dynamic_Examples
//
//  Created by Simon Getrik on 14.06.2025.
//

#import "ApplicationKitViewsPattern.h"

NS_ASSUME_NONNULL_BEGIN

@implementation ApplicationKitViewsPattern

+ (void)demoApplicationKitViews {
    // Root view (like a window contentView)
    NSView *rootView = [[NSView alloc] initWithFrame:NSMakeRect(0, 0, 400, 400)];

    // Simulated subviews
    NSView *header = [[NSView alloc] initWithFrame:NSMakeRect(0, 350, 400, 50)];
    NSView *content = [[NSView alloc] initWithFrame:NSMakeRect(0, 50, 400, 300)];
    NSView *footer = [[NSView alloc] initWithFrame:NSMakeRect(0, 0, 400, 50)];

    [rootView addSubview:header];
    [rootView addSubview:content];
    [rootView addSubview:footer];

    NSLog(@"Root view has %lu subviews", (unsigned long)[rootView.subviews count]);

    for (NSView *subview in rootView.subviews) {
        NSLog(@"Subview: %@ at frame %@", subview, NSStringFromRect(subview.frame));
    }

    // Composition complete
    NSLog(@"View hierarchy simulated in console.");
}

@end

NS_ASSUME_NONNULL_END
