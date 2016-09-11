//
//  QLEmotionButton.m
//  新浪微博
//
//  Created by QiLi on 16/7/12.
//  Copyright © 2016年 QiLi. All rights reserved.
//

#import "QLEmotionButton.h"
#import "QLEmotion.h"

@implementation QLEmotionButton

#pragma mark - Life Cycle
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super initWithCoder:decoder]) {
        [self setup];
    }
    return self;
}


#pragma mark - Private Method
- (void)setup
{
    self.titleLabel.font = [UIFont systemFontOfSize:32];
    // 按钮高亮的时候。不要去调整图片（不要调整图片会灰色）
    self.adjustsImageWhenHighlighted = NO;
}


- (void)setEmotion:(QLEmotion *)emotion
{
    _emotion = emotion;
    
    if (emotion.png) { // 有图片
        [self setImage:[UIImage imageNamed:emotion.png] forState:UIControlStateNormal];
    } else if (emotion.code) { // 是emoji表情
        // 设置emoji
        [self setTitle:emotion.code.emoji forState:UIControlStateNormal];
    }
}
@end
