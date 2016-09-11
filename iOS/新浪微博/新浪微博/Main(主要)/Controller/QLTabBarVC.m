//
//  QLTabBarVC.m
//  新浪微博
//
//  Created by QiLi on 16/7/11.
//  Copyright © 2016年 QiLi. All rights reserved.
//


#import "QLTabBarVC.h"
#import "QLHomeVC.h"
#import "QLMessageCenterVC.h"
#import "QLDiscoverVC.h"
#import "QLProfileVC.h"
#import "QLNavigationVC.h"
#import "QLTabBar.h"
#import "QLPostVC.h"

@interface QLTabBarVC () <QLTabBarDelegate>

@end

@implementation QLTabBarVC

#pragma mark - Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.初始化子控制器
    QLHomeVC *home = [[QLHomeVC alloc] init];
    [self addChildVc:home title:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    
    QLMessageCenterVC *messageCenter = [[QLMessageCenterVC alloc] init];
    [self addChildVc:messageCenter title:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    
    QLDiscoverVC *discover = [[QLDiscoverVC alloc] init];
    [self addChildVc:discover title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    
    QLProfileVC *profile = [[QLProfileVC alloc] init];
    [self addChildVc:profile title:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
    
    // 2.更换系统自带的tabbar
    QLTabBar *tabBar = [[QLTabBar alloc] init];
    [self setValue:tabBar forKeyPath:@"tabBar"];

}

#pragma mark -Private Method
/**
 *  添加一个子控制器
 *
 *  @param childVc       子控制器
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中的图片
 */
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置子控制器的文字
    childVc.title = title; // 同时设置tabbar和navigationBar的文字
    
    // 设置子控制器的图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    if (iOS7) {
        childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    } else {
        childVc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    }
    
    // 设置文字的样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = QLColor(123, 123, 123);
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    // 先给外面传进来的小控制器 包装 一个导航控制器
    QLNavigationVC *nav = [[QLNavigationVC alloc] initWithRootViewController:childVc];
    // 添加为子控制器
    [self addChildViewController:nav];
}

#pragma mark - QLTabBarDelegate
- (void)tabBarDidClickPlusButton:(QLTabBar *)tabBar
{
    QLPostVC *postVC = [[QLPostVC alloc] init];
    
    QLNavigationVC *nav = [[QLNavigationVC alloc] initWithRootViewController:postVC];
    [self presentViewController:nav animated:YES completion:nil];
}


@end
