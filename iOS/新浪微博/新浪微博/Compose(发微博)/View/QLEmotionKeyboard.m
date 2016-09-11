//
//  QLEmotionKeyboard.m
//  新浪微博
//
//  Created by QiLi on 16/7/12.
//  Copyright © 2016年 QiLi. All rights reserved.
//


#import "QLEmotionKeyboard.h"
#import "QLEmotionListView.h"
#import "QLEmotionTabBar.h"
#import "QLEmotion.h"
#import "QLEmotionTool.h"

@interface QLEmotionKeyboard() <QLEmotionTabBarDelegate>
/** 保存正在显示listView */
@property (nonatomic, weak) QLEmotionListView *showingListView;
/** 表情内容 */
@property (nonatomic, strong) QLEmotionListView *recentListView;
@property (nonatomic, strong) QLEmotionListView *defaultListView;
@property (nonatomic, strong) QLEmotionListView *emojiListView;
@property (nonatomic, strong) QLEmotionListView *lxhListView;
/** tabbar */
@property (nonatomic, weak) QLEmotionTabBar *tabBar;
@end

@implementation QLEmotionKeyboard


#pragma mark - Life Cycle
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // tabbar
        QLEmotionTabBar *tabBar = [[QLEmotionTabBar alloc] init];
        tabBar.delegate = self;
        [self addSubview:tabBar];
        self.tabBar = tabBar;
        
        // 表情选中的通知
        [QLNotificationCenter addObserver:self selector:@selector(emotionDidSelect) name:QLEmotionDidSelectNotification object:nil];
    }
    return self;
}



- (void)dealloc
{
    [QLNotificationCenter removeObserver:self];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1.tabbar
    self.tabBar.width = self.width;
    self.tabBar.height = 37;
    self.tabBar.x = 0;
    self.tabBar.y = self.height - self.tabBar.height;
    
    // 2.表情内容
    self.showingListView.x = self.showingListView.y = 0;
    self.showingListView.width = self.width;
    self.showingListView.height = self.tabBar.y;
}

#pragma mark - touch event

- (void)emotionDidSelect
{
    self.recentListView.emotions = [QLEmotionTool recentEmotions];
}

#pragma mark - QLEmotionTabBarDelegate
- (void)emotionTabBar:(QLEmotionTabBar *)tabBar didSelectButton:(QLEmotionTabBarButtonType)buttonType
{
    // 移除正在显示的listView控件
    [self.showingListView removeFromSuperview];
    
    // 根据按钮类型，切换键盘上面的listview
    switch (buttonType) {
        case QLEmotionTabBarButtonTypeRecent: { // 最近
            // 加载沙盒中的数据
            [self addSubview:self.recentListView];
            break;
        }
            
        case QLEmotionTabBarButtonTypeDefault: { // 默认
            [self addSubview:self.defaultListView];
            break;
        }
            
        case QLEmotionTabBarButtonTypeEmoji: { // Emoji
            [self addSubview:self.emojiListView];
            break;
        }
            
        case QLEmotionTabBarButtonTypeLxh: { // Lxh
            [self addSubview:self.lxhListView];
            break;
        }
    }
    
    // 设置正在显示的listView
    self.showingListView = [self.subviews lastObject];
    
    // 设置frame
    [self setNeedsLayout];
}

#pragma mark - Setter / Getter
- (QLEmotionListView *)recentListView
{
    if (!_recentListView) {
        self.recentListView = [[QLEmotionListView alloc] init];
        // 加载沙盒中的数据
        self.recentListView.emotions = [QLEmotionTool recentEmotions];
    }
    return _recentListView;
}

- (QLEmotionListView *)defaultListView
{
    if (!_defaultListView) {
        self.defaultListView = [[QLEmotionListView alloc] init];
        self.defaultListView.emotions = [QLEmotionTool defaultEmotions];
    }
    return _defaultListView;
}

- (QLEmotionListView *)emojiListView
{
    if (!_emojiListView) {
        self.emojiListView = [[QLEmotionListView alloc] init];
        self.emojiListView.emotions = [QLEmotionTool emojiEmotions];
    }
    return _emojiListView;
}

- (QLEmotionListView *)lxhListView
{
    if (!_lxhListView) {
        self.lxhListView = [[QLEmotionListView alloc] init];
        self.lxhListView.emotions = [QLEmotionTool lxhEmotions];
    }
    return _lxhListView;
}


@end

