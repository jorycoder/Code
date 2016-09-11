//
//  QLEmotion.m
//  新浪微博
//
//  Created by QiLi on 16/7/12.
//  Copyright © 2016年 QiLi. All rights reserved.
//

#import "QLEmotion.h"
#import "MJExtension.h"

@interface QLEmotion() <NSCoding>

@end

@implementation QLEmotion

MJCodingImplementation

/**
 *  常用来比较两个QLEmotion对象是否一样
 *
 *  @param other 另外一个QLEmotion对象
 *
 *  @return YES : 代表2个对象是一样的，NO: 代表2个对象是不一样
 */
- (BOOL)isEqual:(QLEmotion *)other
{
    return [self.chs isEqualToString:other.chs] || [self.code isEqualToString:other.code];
}

@end
