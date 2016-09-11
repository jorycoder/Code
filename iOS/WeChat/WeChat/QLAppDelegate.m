//
//  AppDelegate.m
//  WeChat
//  Created by apple on 16/9/8.
//  Copyright (c) 2016年 qili. All rights reserved.
//

#import "QLAppDelegate.h"
#import "XMPPFramework.h"
#import "QLNavigationController.h"
#import "DDLog.h"
#import "DDTTYLogger.h"

@implementation QLAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
        // 沙盒的路径
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSLog(@"%@",path);
        
        // 打开XMPP的日志
        //[DDLog addLogger:[DDTTYLogger sharedInstance]];
        
        // 设置导航栏背景
        [QLNavigationController setupNavTheme];
        
        // 从沙里加载用户的数据到单例
        [[QLUserInfo sharedQLUserInfo] loadUserInfoFromSanbox];
        
        // 判断用户的登录状态，YES 直接来到主界面
        if([QLUserInfo sharedQLUserInfo].loginStatus){
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            self.window.rootViewController = storyboard.instantiateInitialViewController;
            
            // 自动登录
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [[QLXMPPTool sharedQLXMPPTool] xmppUserLogin:nil];
            });
            
        }
        
        //注册应用接收通知
        if ([[UIDevice currentDevice].systemVersion doubleValue] > 8.0){
            UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil];
            [application registerUserNotificationSettings:settings];
        }
        
        
        return YES;
}

@end
