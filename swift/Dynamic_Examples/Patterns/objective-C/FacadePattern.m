//
//  FacadePattern.m
//  Dynamic_Examples
//
//  Created by Simon Getrik on 09.06.2025.
//

#import "FacadePattern.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Subsystems

@implementation Projector
- (void)turnOn { NSLog(@"Projector: ON"); }
- (void)turnOff { NSLog(@"Projector: OFF"); }
@end

@implementation Amplifier
- (void)turnOn { NSLog(@"Amplifier: ON"); }
- (void)setVolume:(int)level { NSLog(@"Amplifier: volume set to %d", level); }
@end

@implementation Screen
- (void)lower { NSLog(@"Screen: lowering..."); }
- (void)raise { NSLog(@"Screen: raising..."); }
@end

@implementation MoviePlayer
- (void)playMovie:(NSString *)name { NSLog(@"MoviePlayer: playing %@", name); }
- (void)stopMovie { NSLog(@"MoviePlayer: stopping"); }
@end

#pragma mark - Facade

@interface HomeTheaterFacade ()
@property (nonatomic, strong) Projector *projector;
@property (nonatomic, strong) Amplifier *amplifier;
@property (nonatomic, strong) Screen *screen;
@property (nonatomic, strong) MoviePlayer *player;
@end

@implementation HomeTheaterFacade

- (instancetype)init {
    self = [super init];
    if (self) {
        _projector = [Projector new];
        _amplifier = [Amplifier new];
        _screen = [Screen new];
        _player = [MoviePlayer new];
    }
    return self;
}

- (void)startMovieNightWithTitle:(NSString *)title {
    NSLog(@"--- Starting Movie Night ---");
    [self.screen lower];
    [self.projector turnOn];
    [self.amplifier turnOn];
    [self.amplifier setVolume:7];
    [self.player playMovie:title];
}

- (void)endMovieNight {
    NSLog(@"--- Ending Movie Night ---");
    [self.player stopMovie];
    [self.projector turnOff];
    [self.screen raise];
}

@end

#pragma mark - Demo

@implementation FacadePattern

+ (void)demoFacadePattern {
    HomeTheaterFacade *theater = [HomeTheaterFacade new];
    [theater startMovieNightWithTitle:@"Inception"];
    [theater endMovieNight];
}

@end


NS_ASSUME_NONNULL_END
