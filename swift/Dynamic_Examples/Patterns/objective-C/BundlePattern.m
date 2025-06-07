//
//  BundlePattern.m
//  Dynamic_Examples
//
//  Created by Simon Getrik on 07.06.2025.
//

#import "BundlePattern.h"

@interface BundleGreetingProvider ()

@property (nonatomic, strong) NSBundle *bundle;

@end

@implementation BundleGreetingProvider

- (instancetype)initWithBundle:(NSBundle *)bundle {
    self = [super init];
    if (self) {
        _bundle = bundle;
    }
    return self;
}

- (NSString *)greetingForLanguage:(NSString *)language {
    // Load the localized strings file from the bundle
    NSString *stringsFilePath = [self.bundle pathForResource:@"Greetings" ofType:@"strings" inDirectory:nil forLocalization:language];
    NSDictionary *strings = [NSDictionary dictionaryWithContentsOfFile:stringsFilePath];
    
    if (strings) {
        return strings[@"welcome_message"] ?: @"No greeting found";
    }
    return @"Language not supported";
}

@end

#pragma mark - BundlePattern Demo

@implementation BundlePattern

+ (void)demoBundlePattern {
    // Assume a custom bundle named "Greetings.bundle" exists in the project
    // Bundle structure:
    // Greetings.bundle/
    //   en.lproj/Greetings.strings
    //   es.lproj/Greetings.strings
    
    // Example content of en.lproj/Greetings.strings:
    // "welcome_message" = "Hello, welcome!";
    // Example content of es.lproj/Greetings.strings:
    // "welcome_message" = "¡Hola, bienvenido!";
    
    // Load the bundle
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"Greetings" ofType:@"bundle"];
    NSBundle *greetingsBundle = [NSBundle bundleWithPath:bundlePath];
    
    if (!greetingsBundle) {
        NSLog(@"Failed to load Greetings.bundle");
        return;
    }
    
    // Create a greeting provider with the bundle
    id<GreetingProvider> provider = [[BundleGreetingProvider alloc] initWithBundle:greetingsBundle];
    
    // Demonstrate loading greetings for different languages
    NSLog(@"English greeting: %@", [provider greetingForLanguage:@"en"]);
    NSLog(@"Spanish greeting: %@", [provider greetingForLanguage:@"es"]);
    NSLog(@"French greeting: %@", [provider greetingForLanguage:@"fr"]);
    
    // Expected output (assuming bundle is set up):
    // English greeting: Hello, welcome!
    // Spanish greeting: ¡Hola, bienvenido!
    // French greeting: Language not supported
}

@end
