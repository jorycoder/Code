//
//  QLEmotionTabBar.h
//  新浪微博
//
//  Created by QiLi on 16/7/12.
//  Copyright © 2016年 QiLi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    QLEmotionTabBarButtonTypeRecent, // 最近
    QLEmotionTabBarButtonTypeDefault, // 默认
    QLEmotionTabBarButtonTypeEmoji, // emoji
    QLEmotionTabBarButtonTypeLxh, // 浪小花
} QLEmotionTabBarButtonType;

@class QLEmotionTabBar;

@protocol QLEmotionTabBarDelegate <NSObject>

@optional
- (void)emotionTabBar:(QLEmotionTabBar *)tabBar didSelectButton:(QLEmotionTabBarButtonType)buttonType;
@end

@interface QLEmotionTabBar : UIView
@property (nonatomic, weak) id<QLEmotionTabBarDelegate> delegate;
@end

