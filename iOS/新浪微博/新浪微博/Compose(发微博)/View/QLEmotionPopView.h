//
//  QLEmotionPopView.h
//  新浪微博
//
//  Created by QiLi on 16/7/12.
//  Copyright © 2016年 QiLi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QLEmotion, QLEmotionButton;

@interface QLEmotionPopView : UIView

+ (instancetype)popView;

- (void)showFrom:(QLEmotionButton *)button;
@end

