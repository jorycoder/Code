//
//  QLEmotionTabBar.m
//  新浪微博
//
//  Created by QiLi on 16/7/12.
//  Copyright © 2016年 QiLi. All rights reserved.
//

#import "QLEmotionTabBar.h"
#import "QLEmotionTabBarButton.h"

@interface QLEmotionTabBar()
@property (nonatomic, weak) QLEmotionTabBarButton *selectedBtn;
@end

@implementation QLEmotionTabBar

#pragma mark - Life Cycle
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupBtn:@"最近" buttonType:QLEmotionTabBarButtonTypeRecent];
        [self setupBtn:@"默认" buttonType:QLEmotionTabBarButtonTypeDefault];
        [self setupBtn:@"Emoji" buttonType:QLEmotionTabBarButtonTypeEmoji];
        [self setupBtn:@"浪小花" buttonType:QLEmotionTabBarButtonTypeLxh];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置按钮的frame
    NSUInteger btnCount = self.subviews.count;
    CGFloat btnW = self.width / btnCount;
    CGFloat btnH = self.height;
    for (int i = 0; i<btnCount; i++) {
        QLEmotionTabBarButton *btn = self.subviews[i];
        btn.y = 0;
        btn.width = btnW;
        btn.x = i * btnW;
        btn.height = btnH;
    }
}

#pragma mark - Touch Event
/**
 *  按钮点击
 */
- (void)btnClick:(QLEmotionTabBarButton *)btn
{
    self.selectedBtn.enabled = YES;
    btn.enabled = NO;
    self.selectedBtn = btn;
    
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(emotionTabBar:didSelectButton:)]) {
        [self.delegate emotionTabBar:self didSelectButton:btn.tag];
    }
}

#pragma mark - Private Method

/**
 *  创建一个按钮
 *
 *  @param title 按钮文字
 */
- (QLEmotionTabBarButton *)setupBtn:(NSString *)title buttonType:(QLEmotionTabBarButtonType)buttonType
{
    // 创建按钮
    QLEmotionTabBarButton *btn = [[QLEmotionTabBarButton alloc] init];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    btn.tag = buttonType;
    [btn setTitle:title forState:UIControlStateNormal];
    [self addSubview:btn];
    
    // 设置背景图片
    NSString *image = @"compose_emotion_table_mid_normal";
    NSString *selectImage = @"compose_emotion_table_mid_selected";
    if (self.subviews.count == 1) {
        image = @"compose_emotion_table_left_normal";
        selectImage = @"compose_emotion_table_left_selected";
    } else if (self.subviews.count == 4) {
        image = @"compose_emotion_table_right_normal";
        selectImage = @"compose_emotion_table_right_selected";
    }
    
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:selectImage] forState:UIControlStateDisabled];
    
    return btn;
}



- (void)setDelegate:(id<QLEmotionTabBarDelegate>)delegate
{
    _delegate = delegate;
    
    // 选中“默认”按钮
    [self btnClick:(QLEmotionTabBarButton *)[self viewWithTag:QLEmotionTabBarButtonTypeDefault]];
}



@end
