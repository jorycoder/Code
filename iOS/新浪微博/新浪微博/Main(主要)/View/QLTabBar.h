//
//  QLTabBar.h
//  新浪微博
//
//  Created by QiLi on 16/7/14.
//  Copyright © 2016年 QiLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QLTabBar;

@protocol QLTabBarDelegate <UITabBarDelegate>
@optional
- (void)tabBarDidClickPlusButton:(QLTabBar *)tabBar;
@end

@interface QLTabBar : UITabBar

@property (nonatomic, weak) id<QLTabBarDelegate> delegate;

@end

