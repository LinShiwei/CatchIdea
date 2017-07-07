//
//  CoreDataManger.m
//  CatchIdea
//
//  Created by Lin,Shiwei on 2017/7/7.
//  Copyright © 2017年 Linsw. All rights reserved.
//

#import "CoreDataManger.h"
#import "CatchIdea_macOS-Swift.h"

@implementation CoreDataManger

NSString *entityName = @"IdeaItemObject";

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
    
    }
    return self;
}

- (void)reviseObjectWithUUID:(NSString *)uuidString AndKeyValue:(NSDictionary *)dic {
    
}

- (void)deleteObjectWithUUID:(NSString *)uuidString {
    
}

- (void)createNewObjectWithKeyValue:(NSDictionary * )dic {
    if (!dic || [dic count] == 0) {
        NSLog(@"ideaitem dictionary is empty");
        return;
    }
    AppDelegate *delegate = [[NSApplication sharedApplication] delegate];
    if (delegate == nil) {
        return;
    }
    NSManagedObjectContext *context = delegate.persistentContainer.viewContext;
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
    NSManagedObject *object = [[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
//    for (NSString *key in dic.allKeys) {
//        [object setValue:[dic valueForKey:key] forKey:key];
//    }
    [object setValue:[dic valueForKey:@"header"] forKey:@"header"];
    [object setValue:[dic valueForKey:@"content"] forKey:@"content"];
    [object setValue:[dic valueForKey:@"isFinish"] forKey:@"isFinish"];
    [object setValue:[dic valueForKey:@"isDelete"] forKey:@"isDelete"];
    [object setValue:[dic valueForKey:@"addingDate"] forKey:@"addingDate"];
    [object setValue:[dic valueForKey:@"notificationDate"] forKey:@"notificationDate"];
    [object setValue:[dic valueForKey:@"uuidString"] forKey:@"uuidString"];
    [object setValue:[dic valueForKey:@"markColorIndex"] forKey:@"markColorIndex"];

    
    [delegate saveAction:nil];
    
}



@end
