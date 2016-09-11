//
//  QLHistoryVC.m
//  WeChat
//
//  Created by QiLi on 16/9/9.
//  Copyright © 2016年 qili. All rights reserved.
//

#import "QLHistoryVC.h"

@interface QLHistoryVC ()

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;

@end

@implementation QLHistoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginStatusChange:) name:QLLoginStatusChangeNotification object:nil];
}

-(void)loginStatusChange:(NSNotification *)noti{
    
    //UI在主线程刷新
    dispatch_async(dispatch_get_main_queue(), ^{
        QLLog(@"%@",noti.userInfo);
        // 获取登录状态
        int status = [noti.userInfo[@"loginStatus"] intValue];
        
        switch (status) {
            case XMPPResultTypeConnecting://正在连接
                [self.indicatorView startAnimating];
                break;
            case XMPPResultTypeNetErr://连接失败
                [self.indicatorView stopAnimating];
                break;
            case XMPPResultTypeLoginSuccess://登录成功也就是连接成功
                [self.indicatorView stopAnimating];
                break;
            case XMPPResultTypeLoginFailure://登录失败
                [self.indicatorView stopAnimating];
                break;
            default:
                break;
        }
    });
    
}



@end
