//
//  AssociativeStoragePattern.h
//  Dynamic_Examples
//
//  Created by Simon Getrik on 02.06.2025.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// Base class representing an object that can have associated data
@interface DataObject : NSObject

// Method to retrieve associated metadata
- (nullable NSString *)metadata;

// Method to simulate a threaded update of associated data
- (void)updateMetadataInBackground:(NSString *)newMetadata;

@end

// Class for managing associative storage
@interface AssociativeStorageManager : NSObject

// Associate metadata with a DataObject
+ (void)associateMetadata:(NSString *)metadata withObject:(DataObject *)object;

// Retrieve associated metadata from a DataObject
+ (nullable NSString *)metadataForObject:(DataObject *)object;

@end

// Class for demonstrating the Associative Storage pattern
@interface AssociativeStoragePattern : NSObject

+ (void)demoAssociativeStoragePattern;

@end

NS_ASSUME_NONNULL_END
