//
//  ICloudManager.m
//  CatchIdea
//
//  Created by Lin,Shiwei on 2017/7/7.
//  Copyright © 2017年 Linsw. All rights reserved.
//

#import "ICloudManager.h"
//#import "CatchIdea_macOS-Swift.h"

//enum CKAlertLocationKey {
//    Create,
//    Update,
//    Delete
//};


@interface ICloudManager ()

@property CKDatabase *privateDataBase;

@end
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
        _privateDataBase = [[CKContainer defaultContainer] privateCloudDatabase];
        
        
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
    CKQuerySubscription *updateSub = [[CKQuerySubscription alloc] initWithRecordType:type predicate:precidate options:CKQuerySubscriptionOptionsFiresOnRecordUpdate];
    CKNotificationInfo *updateInfo = [CKNotificationInfo new];
    updateInfo.alertLocalizationKey = @"Update";
    updateInfo.shouldBadge = true;
    updateSub.notificationInfo = updateInfo;
    [_privateDataBase saveSubscription:updateSub completionHandler:^(CKSubscription*sub, NSError *err){
        if (err) {
            NSLog(@"%@",err);
            return;
        }
        
    }];
    
    CKQuerySubscription *createSub = [[CKQuerySubscription alloc] initWithRecordType:type predicate:precidate options:CKQuerySubscriptionOptionsFiresOnRecordCreation];
    CKNotificationInfo *createInfo = [CKNotificationInfo new];
    createInfo.alertLocalizationKey = @"Create";
    createInfo.shouldBadge = true;
    createSub.notificationInfo = createInfo;
    [_privateDataBase saveSubscription:createSub completionHandler:^(CKSubscription*sub, NSError *err){
        if (err) {
            NSLog(@"%@",err);

            return;
        }
        
    }];
    CKQuerySubscription *deleteSub = [[CKQuerySubscription alloc] initWithRecordType:type predicate:precidate options:CKQuerySubscriptionOptionsFiresOnRecordDeletion];
    CKNotificationInfo *deleteInfo = [CKNotificationInfo new];
    deleteInfo.alertLocalizationKey = @"Delete";
    deleteInfo.shouldBadge = true;
    deleteSub.notificationInfo = deleteInfo;
    [_privateDataBase saveSubscription:deleteSub completionHandler:^(CKSubscription*sub, NSError *err){
        if (err) {
            NSLog(@"%@",err);

            return;
        }
        
    }];
}

- (void)saveWithRecordType:(NSString *)type contentDictionary:(NSDictionary *)dic{
    CKRecord *record = [[CKRecord alloc] initWithRecordType:type];
    for(NSString *key in [dic allKeys]){
        record[key] = [dic objectForKey:key];
    }
    [_privateDataBase saveRecord:record completionHandler:^(CKRecord *re,NSError *err){
        if (err) {
            
            return;
        }
        
        
    }];
}

- (void)getIdeaItemDictionaryWithRecordID:(CKRecordID *)recordID withCompletion:(void (^)(NSDictionary *, BOOL))completion {
    if (!recordID) {
        completion(nil,false);
    }
    [_privateDataBase fetchRecordWithID:recordID completionHandler:^(CKRecord *record, NSError *error){
        if (error) {
            return;
        }
        NSDictionary *dic = [NSMutableDictionary dictionary];
        if (record) {
            for (NSString *key in record.allKeys) {
                [dic setValue:[record valueForKey:key] forKey:key];
            }
        }
        if ([dic count] > 0) {
            NSLog(@"Fetch item from icloud with %lu keys",(unsigned long)[dic count]);
            completion(dic,true);
        }else{
            NSLog(@"Fail to fetch item from icloud");
            completion(nil,false);
        }
    }];
    
}
@end
