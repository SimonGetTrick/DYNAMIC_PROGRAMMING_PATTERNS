//
//  ArchivingPattern.m
//  Dynamic_Examples
//
//  Created by Simon Getrik on 25.05.2025.
//

#import "ArchivingPattern.h"

NS_ASSUME_NONNULL_BEGIN

// Implementation of the Book class
@implementation Book

- (instancetype)initWithTitle:(NSString *)title author:(NSString *)author year:(NSInteger)year {
    self = [super init];
    if (self) {
        _title = [title copy];
        _author = [author copy];
        _year = year;
    }
    return self;
}

#pragma mark - NSCoding Protocol

// Method for encoding (archiving) the object's properties
- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.title forKey:@"title"];
    [coder encodeObject:self.author forKey:@"author"];
    [coder encodeInteger:self.year forKey:@"year"];
    NSLog(@"Book encoded: %@", self.title);
}

// Method for decoding (unarchiving) the object's properties
- (nullable instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        _title = [coder decodeObjectForKey:@"title"];
        _author = [coder decodeObjectForKey:@"author"];
        _year = [coder decodeIntegerForKey:@"year"];
        NSLog(@"Book decoded: %@", self.title);
    }
    return self;
}

// Override description for convenient logging
- (NSString *)description {
    return [NSString stringWithFormat:@"Title: %@, Author: %@, Year: %ld", self.title, self.author, (long)self.year];
}

@end


// Implementation of the demonstration class
@implementation ArchivingPattern

+ (void)demoArchivingUnarchiving {
    // 1. Create an object to be archived
    Book *myBook = [[Book alloc] initWithTitle:@"The Hitchhiker's Guide to the Galaxy" author:@"Douglas Adams" year:1979];
    NSLog(@"Original Book: %@", myBook);

    // 2. Archive the object into NSData
    // NSKeyedArchiver creates an encoded object from the root object and all objects it refers to.
    NSError *archivingError = nil;
    NSData *bookData = [NSKeyedArchiver archivedDataWithRootObject:myBook requiringSecureCoding:NO error:&archivingError];

    if (archivingError) {
        NSLog(@"Error archiving book: %@", archivingError.localizedDescription);
        return;
    }
    NSLog(@"\nBook archived to NSData. Data size: %lu bytes", (unsigned long)bookData.length);

    // 3. Optionally, save the NSData to a file
    // In a real application, this could be saving to a file or sending over a network.
    NSString *filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"myBook.archive"];
    BOOL success = [bookData writeToFile:filePath atomically:YES];
    if (success) {
        NSLog(@"Book data successfully saved to file: %@", filePath);
    } else {
        NSLog(@"Failed to save book data to file.");
    }

    // 4. Unarchive the object from NSData
    // NSKeyedUnarchiver decodes objects from NSData.
    NSError *unarchivingError = nil;
    Book *decodedBook = [NSKeyedUnarchiver unarchivedObjectOfClass:[Book class] fromData:bookData error:&unarchivingError];

    if (unarchivingError) {
        NSLog(@"Error unarchiving book: %@", unarchivingError.localizedDescription);
        return;
    }
    
    NSLog(@"\nDecoded Book: %@", decodedBook);

    // 5. Verify that the unarchived object matches the original
    if (decodedBook && [decodedBook.title isEqualToString:myBook.title] &&
        [decodedBook.author isEqualToString:myBook.author] &&
        decodedBook.year == myBook.year) {
        NSLog(@"Archiving and unarchiving successful! Decoded book matches original.");
    } else {
        NSLog(@"Archiving and unarchiving failed: Decoded book does not match original.");
    }

    // Clean up the temporary file (optional)
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSError *removeError = nil;
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:&removeError];
        if (removeError) {
            NSLog(@"Error removing temporary file: %@", removeError.localizedDescription);
        } else {
            NSLog(@"Temporary file removed.");
        }
    }
}

@end
NS_ASSUME_NONNULL_END
