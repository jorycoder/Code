//
//  UIStoryboard+QL.h
//  WeChat
//
//  Created by QiLi on 16/9/8.
//  Copyright © 2016年 qili. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIStoryboard (QL)
/**
 * 1.显示Storybaord的第一个控制器到窗口
 */
+(void)showInitialVCWithName:(NSString *)name;
+(id)initialVCWithName:(NSString *)name;
@end
