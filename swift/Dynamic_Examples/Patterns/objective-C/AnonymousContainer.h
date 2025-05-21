//
//  AnonymousContainer.h
//  Dynamic_Examples
//
//  Created by Simon Getrik on 21.05.2025.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnonymousContainer : NSObject
@property (nonatomic, strong) NSArray *items;
- (void)storeItems:(id)item1 andItem:(id)item2;
- (void)processItems;
@end

@interface AnonymousContainerDemo : NSObject
+ (void)demoAnonymousContainer;
@end

NS_ASSUME_NONNULL_END
