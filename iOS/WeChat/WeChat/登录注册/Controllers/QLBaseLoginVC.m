//
//  QLBaseLoginVC.m
//  WeChat
//
//  Created by apple on 16/9/9.
//  Copyright (c) 2016年 qili. All rights reserved.
//

#import "QLBaseLoginVC.h"
#import "QLAppDelegate.h"

@implementation QLBaseLoginVC

/**
 *  登录操作
 */
- (void)login{
    
    //隐藏键盘
    [self.view endEditing:YES];
    [MBProgressHUD showMessage:@"正在登录中..." toView:self.view];
    
    [QLXMPPTool sharedQLXMPPTool].registerOperation = NO;
    __weak typeof(self) selfVc = self;
    
    [[QLXMPPTool sharedQLXMPPTool] xmppUserLogin:^(XMPPResultType type) {
        [selfVc handleResultType:type];
    }];
}

/**
 *  登录结果回调
 *
 *  @param type 返回登录结果类型
 */
-(void)handleResultType:(XMPPResultType)type{
    // 主线程刷新UI
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view
         ];
        switch (type) {
            case XMPPResultTypeLoginSuccess:
                NSLog(@"登录成功");
                [self enterMainPage];
                break;
            case XMPPResultTypeLoginFailure:
                NSLog(@"登录失败");
                [MBProgressHUD showError:@"用户名或者密码不正确" toView:self.view];
                break;
            case XMPPResultTypeNetErr:
                [MBProgressHUD showError:@"网络不给力" toView:self.view];
            default:
                break;
        }
    });
    
}

/**
 *  登录成功后进入主页
 */
-(void)enterMainPage{
    
    // 更改用户的登录状态为YES
    [QLUserInfo sharedQLUserInfo].loginStatus = YES;
    
    // 把用户登录成功的数据，保存到沙盒
    [[QLUserInfo sharedQLUserInfo] saveUserInfoToSanbox];
    
    // 隐藏模态窗口
    [self dismissViewControllerAnimated:NO completion:nil];
    
    // 此方法是在子线程补调用，所以在主线程刷新UI
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.view.window.rootViewController = storyboard.instantiateInitialViewController;
}

@end
