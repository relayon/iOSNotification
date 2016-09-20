//
//  NotificationHandler.m
//  iOSNotification
//
//  Created by SMC-MAC on 16/9/20.
//  Copyright © 2016年 heyou. All rights reserved.
//

#import "NotificationHandler.h"

@implementation NotificationHandler

// 单例
+ (instancetype)sharedInstance {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}

@end
