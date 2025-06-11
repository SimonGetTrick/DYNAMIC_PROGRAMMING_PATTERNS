//
//  ManagersPattern.h
//  Dynamic_Examples
//
//  Created by Simon Getrik on 11.06.2025.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DownloadRequest : NSObject

@property (nonatomic, strong) NSString *url;

- (instancetype)initWithURL:(NSString *)url;

@end

@interface DownloadManager : NSObject

+ (instancetype)sharedManager;
+ (void)runDemo;

- (void)startDownload:(DownloadRequest *)request;
- (NSString *)statusForURL:(NSString *)url;

@end


NS_ASSUME_NONNULL_END
