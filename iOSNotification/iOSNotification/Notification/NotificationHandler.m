//
//  NotificationHandler.m
//  iOSNotification
//
//  Created by SMC-MAC on 16/9/20.
//  Copyright © 2016年 heyou. All rights reserved.
//

#import "NotificationHandler.h"
@import UserNotifications;

@interface NotificationHandler () <UNUserNotificationCenterDelegate> {
    UNUserNotificationCenter* _notifyCenter;
}

@end

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

// init
- (instancetype)init {
    self = [super init];
    if (self) {
        _notifyCenter = [UNUserNotificationCenter currentNotificationCenter];
        _notifyCenter.delegate = self;
    }
    return self;
}

- (void)request {
    UNAuthorizationOptions options = UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert;
    [_notifyCenter requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            NSLog(@"requestAuthorizationWithOptions OK");
            [_notifyCenter getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
                NSLog(@"%s - %@", __FUNCTION__, settings);
            }];
        } else {
            NSLog(@"%@", error);
        }
    }];
}

#pragma mark -- UNUserNotificationCenterDelegate
// The method will be called on the delegate only if the application is in the foreground. If the method is not implemented or the handler is not called in a timely manner then the notification will not be presented. The application can choose to have the notification presented as a sound, badge, alert and/or in the notification list. This decision should be based on whether the information in the notification is otherwise visible to the user.
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
    
    completionHandler(UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
}

// The method will be called on the delegate when the user responded to the notification by opening the application, dismissing the notification or choosing a UNNotificationAction. The delegate must be set before the application returns from applicationDidFinishLaunching:.
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(UNNotificationResponse *)response
         withCompletionHandler:(void(^)())completionHandler {
    NSString *actid = response.actionIdentifier;
    NSLog(@"%s - %@", __FUNCTION__, actid);
}

@end
