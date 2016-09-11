//
//  QLEmotionAttachment.m
//  新浪微博
//
//  Created by QiLi on 16/7/12.
//  Copyright © 2016年 QiLi. All rights reserved.
//

#import "QLEmotionAttachment.h"
#import "QLEmotion.h"

@implementation QLEmotionAttachment

- (void)setEmotion:(QLEmotion *)emotion
{
    _emotion = emotion;
    
    self.image = [UIImage imageNamed:emotion.png];
}
@end
