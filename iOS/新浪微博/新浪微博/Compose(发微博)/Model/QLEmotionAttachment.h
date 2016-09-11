//
//  QLEmotionAttachment.h
//  新浪微博
//
//  Created by QiLi on 16/7/12.
//  Copyright © 2016年 QiLi. All rights reserved.
//

#import <Foundation/Foundation.h>
@class QLEmotion;

@interface QLEmotionAttachment : NSTextAttachment
@property (nonatomic, strong) QLEmotion *emotion;
@end
