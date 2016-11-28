//
//  AppDelegate+Helper.m
//  WilliamProject
//
//  Created by WilliamChen on 16/5/19.
//  Copyright © 2016年 WilliamChen. All rights reserved.
//

#import "AppDelegate+Helper.h"

@implementation AppDelegate (Helper)

+ (void)registerRemotNotification
{
    float deviceVersion = [UIDevice currentDevice].systemVersion.floatValue;
    if (deviceVersion >= 8.0) {
        UIUserNotificationType types = UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound;
        
        UIMutableUserNotificationAction *maction = [[UIMutableUserNotificationAction alloc]init];
        maction.identifier = @"Accept_Identifier";
        maction.title = @"Accept";
        maction.activationMode = UIUserNotificationActivationModeBackground;
        maction.destructive = NO;
        maction.authenticationRequired = NO;
        
        UIMutableUserNotificationCategory *category = [[UIMutableUserNotificationCategory alloc]init];
        category.identifier = @"Invite_category";
        [category setActions:@[maction] forContext:UIUserNotificationActionContextDefault];
        
        NSSet *categories = [NSSet setWithObject:category];
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:categories];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
    else{
        UIRemoteNotificationType types = UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:types];
    }
}

+ (void)handleRemoteNotification
{
    
}

@end
