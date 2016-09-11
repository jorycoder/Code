//
//  QLDropdownMenu.h
//  新浪微博
//
//  Created by QiLi on 16/7/14.
//  Copyright © 2016年 QiLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QLDropdownMenu;

@protocol QLDropdownMenuDelegate <NSObject>
@optional
- (void)dropdownMenuDidDismiss:(QLDropdownMenu *)menu;
- (void)dropdownMenuDidShow:(QLDropdownMenu *)menu;
@end

@interface QLDropdownMenu : UIView
@property (nonatomic, weak) id<QLDropdownMenuDelegate> delegate;

+ (instancetype)menu;

/**
 *  显示
 */
- (void)showFrom:(UIView *)from;
/**
 *  销毁
 */
- (void)dismiss;

/**
 *  内容
 */
@property (nonatomic, strong) UIView *content;
/**
 *  内容控制器
 */
@property (nonatomic, strong) UIViewController *contentController;
@end