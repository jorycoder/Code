

//
//  UIStoryboard+QL.m
//  WeChat
//
//  Created by QiLi on 16/9/8.
//  Copyright © 2016年 qili. All rights reserved.
//

#import "UIStoryboard+QL.h"

@implementation UIStoryboard (QL)
+(void)showInitialVCWithName:(NSString *)name{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:name bundle:nil];
    //WXLog(@"%@",[UIApplication sharedApplication].keyWindow);
    [UIApplication sharedApplication].keyWindow.rootViewController = storyboard.instantiateInitialViewController;
}

+(id)initialVCWithName:(NSString *)name{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:name bundle:nil];
    return [storyboard instantiateInitialViewController];
}
@end
