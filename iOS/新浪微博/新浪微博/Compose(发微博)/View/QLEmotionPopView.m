//
//  QLEmotionPopView.m
//  新浪微博
//
//  Created by QiLi on 16/7/12.
//  Copyright © 2016年 QiLi. All rights reserved.
//

#import "QLEmotionPopView.h"
#import "QLEmotion.h"
#import "QLEmotionButton.h"

@interface QLEmotionPopView()
@property (weak, nonatomic) IBOutlet QLEmotionButton *emotionButton;
@end

@implementation QLEmotionPopView

#pragma mark - Life Cycle
+ (instancetype)popView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"QLEmotionPopView" owner:nil options:nil] lastObject];
}

#pragma mark - Private Method
- (void)showFrom:(QLEmotionButton *)button
{
    if (button == nil) return;
    
    // 给popView传递数据
    self.emotionButton.emotion = button.emotion;
    
    // 取得最上面的window
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    
    // 计算出被点击的按钮在window中的frame
    CGRect btnFrame = [button convertRect:button.bounds toView:nil];
    self.y = CGRectGetMidY(btnFrame) - self.height; // 100
    self.centerX = CGRectGetMidX(btnFrame);
}
@end

