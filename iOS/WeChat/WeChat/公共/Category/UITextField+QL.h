//
//  UITextField+QL.h
//  WeChat
//
//  Created by QiLi on 16/9/8.
//  Copyright © 2016年 qili. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (QL)

/**
 添加文件输入框左边的View,添加图片
 */
-(void)addLeftViewWithImage:(NSString *)image;

/**
 * 判断是否为手机号码
 */
-(BOOL)isTelphoneNum;
@end
