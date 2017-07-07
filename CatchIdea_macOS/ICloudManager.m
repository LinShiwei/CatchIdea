//
//  ICloudManager.m
//  CatchIdea
//
//  Created by Lin,Shiwei on 2017/7/7.
//  Copyright © 2017年 Linsw. All rights reserved.
//

#import "ICloudManager.h"

@implementation ICloudManager

+ (instancetype)shared{
    static ICloudManager *shared = nil;
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
//        CKRecordID *newID = [[CKRecordID alloc] initWithRecordName:@"115"];
        
        
        
    }
    return self;
}

- (void)save{
    CKRecord *ideaItemRecord = [[CKRecord alloc] initWithRecordType:@"IdeaItem"];
    ideaItemRecord[@"addingDate"] = [NSDate date];
    ideaItemRecord[@"markColorIndex"] = [NSNumber numberWithInteger:0];
    ideaItemRecord[@"content"] = @"";
    ideaItemRecord[@"isDelete"] = false;
    ideaItemRecord[@"isFinish"] = false;
    ideaItemRecord[@"notificationDate"] = nil;
    ideaItemRecord[@"header"] = @"newnew";
    ideaItemRecord[@"uuidString"] = [[NSUUID UUID] UUIDString];
    
    CKContainer *myContainer = [CKContainer defaultContainer];
    CKDatabase *privateDataBase = [myContainer privateCloudDatabase];
    
    [privateDataBase saveRecord:ideaItemRecord completionHandler:^(CKRecord *re,NSError *err){
        if (err) {
            
            return;
        }
        
        
    }];
}

- (void)subscriptionWithRecordType:(NSString *)type {
    NSPredicate *precidate = [NSPredicate predicateWithFormat:@"TRUEPREDICATE"];
    CKQuerySubscription *subscription = [[CKQuerySubscription alloc] initWithRecordType:type predicate:precidate options:CKQuerySubscriptionOptionsFiresOnRecordUpdate | CKQuerySubscriptionOptionsFiresOnRecordCreation | CKQuerySubscriptionOptionsFiresOnRecordDeletion];
    CKNotificationInfo *notificationInfo = [CKNotificationInfo new];
    notificationInfo.alertLocalizationKey = @"New item update";
    notificationInfo.shouldBadge = true;
    subscription.notificationInfo = notificationInfo;
    CKDatabase *privateDataBase = [[CKContainer defaultContainer] privateCloudDatabase];
    [privateDataBase saveSubscription:subscription completionHandler:^(CKSubscription*sub, NSError *err){
        if (err) {
            
            return;
        }
        
    }];
}

- (void)saveWithRecordType:(NSString *)type contentDictionary:(NSDictionary *)dic{
    CKRecord *record = [[CKRecord alloc] initWithRecordType:type];
    for(NSString *key in [dic allKeys]){
        record[key] = [dic objectForKey:key];
    }
    
    CKContainer *myContainer = [CKContainer defaultContainer];
    CKDatabase *privateDataBase = [myContainer privateCloudDatabase];
    
    [privateDataBase saveRecord:record completionHandler:^(CKRecord *re,NSError *err){
        if (err) {
            
            return;
        }
        
        
    }];
}
@end
