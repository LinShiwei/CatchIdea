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

        NSAssert(_delegate != nil,@"ERROR,delegate should not be nil");
        NSAssert(_context != nil, @"ERROR,context should not be nil");
    }
    return self;
}

- (void)reviseObjectWithUUID:(NSString *)uuidString AndKeyValue:(NSDictionary *)dic {
    if (_delegate == nil || _context == nil) {
        return;
    }
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:CoreDataModelKey.entityName];
    request.predicate = [NSPredicate predicateWithFormat:@"uuidString = %@",uuidString];
    NSError *error = nil;
    NSArray *results = [_context executeFetchRequest:request error:&error];
    if (results.count == 1){
        NSManagedObject *obj = results[0];
        if (obj) {
            for (NSString *key in [dic allKeys]) {
                if ([obj valueForKey:key] != nil) {
                    [obj setValue:[dic valueForKey:key] forKey:key];
                }
            }
            [_delegate saveAction:nil];
        }else{
            
        }
    }else if (results == nil) {
        NSLog(@"ERROR,can not fetch result");

    }else{
        NSLog(@"ERROR,results.count should be 1");
    }
}

- (void)deleteObjectWithUUID:(NSString *)uuidString {
    if (_delegate == nil || _context == nil) {
        return;
    }
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:CoreDataModelKey.entityName];
    request.predicate = [NSPredicate predicateWithFormat:@"uuidString = %@",uuidString];
    NSError *error = nil;
    NSArray *results = [_context executeFetchRequest:request error:&error];
    if (results.count == 1){
        NSManagedObject *obj = results[0];
        if (obj) {
            [_context deleteObject:obj];
            [_delegate saveAction:nil];
        }else{
            
        }
    }else if (results == nil) {
        NSLog(@"ERROR,can not fetch result");
        
    }else{
        NSLog(@"ERROR,results.count should be 1");
    }
}

- (void)createNewObjectWithKeyValue:(NSDictionary * )dic {
    if (!dic || [dic count] == 0) {
        NSLog(@"ideaitem dictionary is empty");
        return;
    }
    if (_delegate == nil || _context == nil) {
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
