//
//  ControllerPattern.m
//  Dynamic_Examples
//
//  Created by Simon Getrik on 12.06.2025.
//

#import "ControllerPattern.h"

NS_ASSUME_NONNULL_BEGIN


@implementation Note

- (instancetype)initWithText:(NSString *)text {
    self = [super init];
    if (self) {
        _text = text;
        _date = [NSDate date];
    }
    return self;
}

@end

@interface NoteController ()

@property (nonatomic, strong) NSMutableArray<Note *> *notes;

@end

@implementation NoteController

- (instancetype)init {
    self = [super init];
    if (self) {
        _notes = [NSMutableArray array];
    }
    return self;
}

- (void)addNoteWithText:(NSString *)text {
    Note *note = [[Note alloc] initWithText:text];
    [self.notes addObject:note];
    NSLog(@"📝 Added note: \"%@\" at %@", note.text, note.date);
}

- (void)displayAllNotes {
    NSLog(@"📒 All Notes:");
    for (Note *note in self.notes) {
        NSLog(@"• \"%@\" (%@)", note.text, note.date);
    }
}

+ (void)runDemo {
    NoteController *controller = [[NoteController alloc] init];
    
    [controller addNoteWithText:@"Buy milk"];
    [controller addNoteWithText:@"Read Cocoa book"];
    
    [controller displayAllNotes];
}

@end



NS_ASSUME_NONNULL_END
