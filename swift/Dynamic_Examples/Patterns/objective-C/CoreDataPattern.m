//
//  CoreDataPattern.m
//  Dynamic_Examples
//
//  Created by Simon Getrik on 13.06.2025.
//

#import "CoreDataPattern.h"

NS_ASSUME_NONNULL_BEGIN

@interface CoreDataPattern ()

@property (nonatomic, strong) NSPersistentContainer *persistentContainer;

@end

@implementation CoreDataPattern

+ (void)demoCoreDataModelPattern {
    CoreDataPattern *demo = [[CoreDataPattern alloc] init];
    [demo runDemo];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _persistentContainer = [self createInMemoryContainer];
    }
    return self;
}

- (void)runDemo {
    [self insertSampleData];
    [self fetchAndPrintPeople];
}

#pragma mark - Core Data Setup

- (NSPersistentContainer *)createInMemoryContainer {
    NSPersistentContainer *container = [[NSPersistentContainer alloc] initWithName:@"Model"];
    
    NSPersistentStoreDescription *description = [[NSPersistentStoreDescription alloc] init];
    description.type = NSInMemoryStoreType;
    container.persistentStoreDescriptions = @[description];
    
    [container loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *desc, NSError *error) {
        if (error) {
            NSLog(@"Error loading store: %@", error);
            abort();
        }
    }];
    
    return container;
}

#pragma mark - Entity Operations

- (void)insertSampleData {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;

    NSManagedObject *person = [NSEntityDescription insertNewObjectForEntityForName:@"PersonCD" inManagedObjectContext:context];
    [person setValue:@"Alice" forKey:@"name"];
    [person setValue:@30 forKey:@"age"];

    NSManagedObject *person2 = [NSEntityDescription insertNewObjectForEntityForName:@"PersonCD" inManagedObjectContext:context];
    [person2 setValue:@"Bob" forKey:@"name"];
    [person2 setValue:@42 forKey:@"age"];

    NSError *error = nil;
    [context save:&error];
    if (error) {
        NSLog(@"Failed to save context: %@", error);
    }
}

- (void)fetchAndPrintPeople {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;

    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"PersonCD"];

    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];

    if (error) {
        NSLog(@"Failed to fetch people: %@", error);
    } else {
        for (NSManagedObject *person in results) {
            NSLog(@"Person: %@ (%@)",
                  [person valueForKey:@"name"],
                  [person valueForKey:@"age"]);
        }
    }
}

@end

NS_ASSUME_NONNULL_END
