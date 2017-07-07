//
//  ICloudManager.h
//  CatchIdea
//
//  Created by Lin,Shiwei on 2017/7/7.
//  Copyright © 2017年 Linsw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CloudKit/CloudKit.h>

@interface ICloudManager : NSObject
+ (instancetype)shared;

- (void)save;

- (void)subscriptionWithRecordType:(NSString *)type;

- (void)saveWithRecordType:(NSString *)type contentDictionary:(NSDictionary *)dic;
@end
