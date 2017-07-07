//
//  CoreDataManger.h
//  CatchIdea
//
//  Created by Lin,Shiwei on 2017/7/7.
//  Copyright © 2017年 Linsw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>


@interface CoreDataManger : NSObject
+ (instancetype)shared;

- (void)reviseObjectWithUUID:(NSString *)uuidString AndKeyValue:(NSDictionary *)dic;
- (void)deleteObjectWithUUID:(NSString *)uuidString;
- (void)createNewObjectWithKeyValue:(NSDictionary *)dic;

@end
