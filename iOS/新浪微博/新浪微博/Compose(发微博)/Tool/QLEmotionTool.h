//
//  QLEmotionTool.h
//  新浪微博
//
//  Created by QiLi on 16/7/12.
//  Copyright © 2016年 QiLi. All rights reserved.
//

#import <Foundation/Foundation.h>
@class QLEmotion;

@interface QLEmotionTool : NSObject
+ (void)addRecentEmotion:(QLEmotion *)emotion;
+ (NSArray *)recentEmotions;
+ (NSArray *)defaultEmotions;
+ (NSArray *)lxhEmotions;
+ (NSArray *)emojiEmotions;

/**
 *  通过表情描述找到对应的表情
 *
 *  @param chs 表情描述
 */
+ (QLEmotion *)emotionWithChs:(NSString *)chs;

@end
