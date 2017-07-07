//
//  CoreDataManger.m
//  CatchIdea
//
//  Created by Lin,Shiwei on 2017/7/7.
//  Copyright © 2017年 Linsw. All rights reserved.
//

#import "CoreDataManger.h"
#import "CatchIdea_macOS-Swift.h"

@interface CoreDataManger ()

@property (weak) NSManagedObjectContext *context;
@property (weak) AppDelegate *delegate;
@end

@implementation CoreDataManger

+ (instancetype)shared{
    static CoreDataManger *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        shared = [[self alloc] init];
    });
    return shared;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _delegate = [[NSApplication sharedApplication] delegate];
        _context = _delegate.persistentContainer.viewContext;
        NSAssert(_delegate != nil, @"delegate should not be nil");
        NSAssert(_context != nil, @"context should not be nil");
    }
    return self;
}

- (void)reviseObjectWithUUID:(NSString *)uuidString AndKeyValue:(NSDictionary *)dic {
    
}

- (void)deleteObjectWithUUID:(NSString *)uuidString {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:CoreDataModelKey.entityName];
//    fetchRequest.predicate =
    NSError *error = nil;
    NSArray *results = [_context executeFetchRequest:fetchRequest error:&error];
    if (!results || results.count == 0) {
        NSLog(@"Error fetching Employee objects: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }else{
        if (results.count == 1) {
            [_context deleteObject:[results objectAtIndex:0]];
            [_delegate saveAction:nil];
        }else{
            NSLog(@"Error: Fetch more than one object with one uuidString.");
        }
    }
}

- (void)createNewObjectWithKeyValue:(NSDictionary * )dic {
    if (!dic || [dic count] == 0) {
        NSLog(@"ideaitem dictionary is empty");
        return;
    }
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:CoreDataModelKey.entityName inManagedObjectContext:_context];
    NSManagedObject *object = [[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:_context];
//    for (NSString *key in dic.allKeys) {
//        [object setValue:[dic valueForKey:key] forKey:key];
//    }
    [object setValue:[dic valueForKey:CoreDataModelKey.header] forKey:CoreDataModelKey.header];
    [object setValue:[dic valueForKey:CoreDataModelKey.content] forKey:CoreDataModelKey.content];
    [object setValue:[dic valueForKey:CoreDataModelKey.isFinish] forKey:CoreDataModelKey.isFinish];
    [object setValue:[dic valueForKey:CoreDataModelKey.isDelete] forKey:CoreDataModelKey.isDelete];
    [object setValue:[dic valueForKey:CoreDataModelKey.addingDate] forKey:CoreDataModelKey.addingDate];
    [object setValue:[dic valueForKey:CoreDataModelKey.notificationDate] forKey:CoreDataModelKey.notificationDate];
    [object setValue:[dic valueForKey:CoreDataModelKey.uuidString] forKey:CoreDataModelKey.uuidString];
    [object setValue:[dic valueForKey:CoreDataModelKey.markColorIndex] forKey:CoreDataModelKey.markColorIndex];

    
    [_delegate saveAction:nil];
    
}



@end
