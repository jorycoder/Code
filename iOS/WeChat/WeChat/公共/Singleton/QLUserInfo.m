//
//  QLUserInfo.m
//  WeChat
//
//  Created by apple on 16/9/8.
//  Copyright (c) 2016年 qili. All rights reserved.
//

#import "QLUserInfo.h"

#define QLUserKey @"QLUserKey"
#define QLLoginStatusKey @"QLLoginStatusKey"
#define QLPwdKey @"QLPwdKey"



@implementation QLUserInfo

singleton_implementation(QLUserInfo)

/**
 *  存储用户数据到沙盒
 */
-(void)saveUserInfoToSanbox{

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.user forKey:QLUserKey];
    [defaults setBool:self.loginStatus forKey:QLLoginStatusKey];
    [defaults setObject:self.pwd forKey:QLPwdKey];
    [defaults synchronize];
    
}

/**
 *  从沙盒读取用户数据
 */
-(void)loadUserInfoFromSanbox{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.user = [defaults objectForKey:QLUserKey];
    self.loginStatus = [defaults boolForKey:QLLoginStatusKey];
    self.pwd = [defaults objectForKey:QLPwdKey];
}


-(NSString *)jid{
    return [NSString stringWithFormat:@"%@@%@",self.user,domain];
}
@end
