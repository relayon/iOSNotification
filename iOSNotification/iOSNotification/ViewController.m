//
//  ViewController.m
//  iOSNotification
//
//  Created by SMC-MAC on 16/9/20.
//  Copyright © 2016年 heyou. All rights reserved.
//

#import "ViewController.h"
@import UserNotifications;

@interface ViewController ()
- (IBAction)onNotify:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onNotify:(id)sender {
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    
    UNMutableNotificationContent *content = [UNMutableNotificationContent new];
    content.title = [NSString localizedUserNotificationStringForKey:@"Here is a test noti!" arguments:nil];
    content.body = [NSString localizedUserNotificationStringForKey:@"I'am noti content body~" arguments:nil];
    content.sound = [UNNotificationSound defaultSound];
    content.categoryIdentifier = @"abcd";
    
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"requestId" content:content trigger:[UNTimeIntervalNotificationTrigger triggerWithTimeInterval:2.0 repeats:NO]];
    
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        NSLog(@"%@",error);
    }];
}
@end
