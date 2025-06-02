//
//  AssociativeStoragePattern.m
//  Dynamic_Examples
//
//  Created by Simon Getrik on 02.06.2025.
//

#import "AssociativeStoragePattern.h"
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@implementation DataObject

// Retrieve associated metadata using the runtime
- (nullable NSString *)metadata {
    return [AssociativeStorageManager metadataForObject:self];
}

// Update metadata in a background thread
- (void)updateMetadataInBackground:(NSString *)newMetadata {
    dispatch_queue_t backgroundQueue = dispatch_queue_create("com.example.associativeQueue", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(backgroundQueue, ^{
        // Ensure update occurs on the main thread for thread safety
        dispatch_async(dispatch_get_main_queue(), ^{
            [AssociativeStorageManager associateMetadata:newMetadata withObject:self];
            NSLog(@"Updated metadata for %@ to '%@' on thread %@", self, newMetadata, [NSThread currentThread]);
        });
    });
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p>", NSStringFromClass([self class]), self];
}

@end

@implementation AssociativeStorageManager

// Define a key for associating metadata (unique for each association)
static const void *kMetadataKey = &kMetadataKey;

// Associate metadata with a DataObject
+ (void)associateMetadata:(NSString *)metadata withObject:(DataObject *)object {
    // Use a lock to ensure thread safety
    @synchronized(object) {
        objc_setAssociatedObject(object, kMetadataKey, metadata, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

// Retrieve associated metadata from a DataObject
+ (nullable NSString *)metadataForObject:(DataObject *)object {
    // Use a lock to ensure thread safety
    @synchronized(object) {
        return objc_getAssociatedObject(object, kMetadataKey);
    }
}

@end

@implementation AssociativeStoragePattern

+ (void)demoAssociativeStoragePattern {
    // 1. Create a DataObject instance
    DataObject *dataObject = [[DataObject alloc] init];
    NSLog(@"Initial object: %@, Metadata: %@", dataObject, [dataObject metadata]);
    
    // 2. Associate initial metadata on the main thread
    NSLog(@"\n--- Associating metadata on main thread ---");
    [AssociativeStorageManager associateMetadata:@"InitialData" withObject:dataObject];
    NSLog(@"After association: Metadata = %@", [dataObject metadata]);
    
    // 3. Update metadata from a background thread
    NSLog(@"\n--- Updating metadata from background thread ---");
    [dataObject updateMetadataInBackground:@"UpdatedData"];
    
    // 4. Simulate some delay to allow background thread to process
    [NSThread sleepForTimeInterval:1.0];
    
    // 5. Log the final metadata
    NSLog(@"\nFinal Metadata: %@", [dataObject metadata]);
    
    // Logs:
    // Initial object: <DataObject: 0x...>, Metadata: (null)
    //
    // --- Associating metadata on main thread ---
    // After association: Metadata = InitialData
    //
    // --- Updating metadata from background thread ---
    // Updated metadata for <DataObject: 0x...> to 'UpdatedData' on thread <NSThread: 0x...>{number = 1, name = (null)}
    //
    // Final Metadata: UpdatedData
}

@end

NS_ASSUME_NONNULL_END
