//
//  QLAccountTool.h
//  新浪微博
//
//  Created by QiLi on 16/7/14.
//  Copyright © 2016年 QiLi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QLAccount.h"

@interface QLAccountTool : NSObject
/**
 *  存储账号信息
 *
 *  @param account 账号模型
 */
+ (void)saveAccount:(QLAccount *)account;

/**
 *  返回账号信息
 *
 *  @return 账号模型（如果账号过期，返回nil）
 */
+ (QLAccount *)account;

@end