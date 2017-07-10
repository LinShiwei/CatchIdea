//
//  ICloudManager.h
//  CatchIdea
//
//  Created by Lin,Shiwei on 2017/7/7.
//  Copyright © 2017年 Linsw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CloudKit/CloudKit.h>
#import <CoreData/CoreData.h>

@interface ICloudManager : NSObject
+ (instancetype)shared;

- (void)save;
- (void)subscriptionWithRecordType:(NSString *)type;
- (void)saveWithRecordType:(NSString *)type contentDictionary:(NSDictionary *)dic;

- (void)getIdeaItemDictionaryWithRecordID:(CKRecordID *)recordID withCompletion:(void(^)(NSDictionary *dic, BOOL success))completion;
@end
