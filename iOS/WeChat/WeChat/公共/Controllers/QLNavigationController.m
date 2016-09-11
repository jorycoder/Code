//
//  QLNavigationController.m
//  WeChat
//
//  Created by apple on 16/9/9.
//  Copyright (c) 2016年 qili. All rights reserved.
//

#import "QLNavigationController.h"

@implementation QLNavigationController

#pragma mark - Public Method
// 设置导航栏的主题
+(void)setupNavTheme{
    // 设置导航样式
    UINavigationBar *navBar = [UINavigationBar appearance
                               ];
    // 1.设置导航条的背景
    [navBar setBackgroundImage:[UIImage imageNamed:@"topbarbg_ios7"] forBarMetrics:UIBarMetricsDefault];
    
    // 2.设置栏的字体
    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    att[NSForegroundColorAttributeName] = [UIColor whiteColor];
    att[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    
    [navBar setTitleTextAttributes:att];
    
    // 设置状态栏的样式
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

@end
