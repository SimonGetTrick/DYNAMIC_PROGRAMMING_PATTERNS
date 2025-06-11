//
//  ManagersPattern.m
//  Dynamic_Examples
//
//  Created by Simon Getrik on 11.06.2025.
//

#import "ManagersPattern.h"

NS_ASSUME_NONNULL_BEGIN

@implementation DownloadRequest

- (instancetype)initWithURL:(NSString *)url {
    self = [super init];
    if (self) {
        _url = url;
    }
    return self;
}

@end

@interface DownloadManager ()

@property (nonatomic, strong) NSMutableDictionary *activeDownloads;

@end

@implementation DownloadManager

+ (instancetype)sharedManager {
    static DownloadManager *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

+ (void)runDemo {
    DownloadRequest *r1 = [[DownloadRequest alloc] initWithURL:@"https://example.com/file1"];
    DownloadRequest *r2 = [[DownloadRequest alloc] initWithURL:@"https://example.com/file2"];
    
    DownloadManager *manager = [DownloadManager sharedManager];
    
    [manager startDownload:r1];
    [manager startDownload:r2];
    [manager startDownload:r1]; // repeat is ignored by manager
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"📊 Status: %@", [manager statusForURL:r1.url]);
    });
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _activeDownloads = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)startDownload:(DownloadRequest *)request {
    if (self.activeDownloads[request.url]) {
        NSLog(@"⏳ Already downloading: %@", request.url);
        return;
    }
    
    NSLog(@"⬇️ Starting download: %@", request.url);
    self.activeDownloads[request.url] = @"InProgress";
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.activeDownloads[request.url] = @"Completed";
        NSLog(@"✅ Download finished: %@", request.url);
    });
}

- (NSString *)statusForURL:(NSString *)url {
    return self.activeDownloads[url] ?: @"Not Started";
}

@end


NS_ASSUME_NONNULL_END
