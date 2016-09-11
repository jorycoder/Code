//
//  UIButton+QL.h
//  WeChat
//
//  Created by QiLi on 16/9/8.
//  Copyright © 2016年 qili. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (QL)
/**
 * 设置普通状态与高亮状态的背景图片
 */
-(void)setN_BG:(NSString *)nbg H_BG:(NSString *)hbg;

/**
 * 设置普通状态与高亮状态的拉伸后背景图片
 */
-(void)setResizeN_BG:(NSString *)nbg H_BG:(NSString *)hbg;
@end
