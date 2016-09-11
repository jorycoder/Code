//
//  QLConst.h
//  新浪微博
//
//  Created by QiLi on 16/7/11.
//  Copyright © 2016年 QiLi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QLConst : NSObject
// 账号信息
extern NSString * const QLAppKey;
extern NSString * const QLRedirectURI;
extern NSString * const QLAppSecret;

// 通知
// 表情选中的通知
extern NSString * const QLEmotionDidSelectNotification;
extern NSString * const QLSelectEmotionKey;

// 删除文字的通知
extern NSString * const QLEmotionDidDeleteNotification;
@end
