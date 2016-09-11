//
//  QLMeVC.m
//  WeChat
//
//  Created by apple on 16/9/9.
//  Copyright (c) 2016年 qili. All rights reserved.
//

#import "QLMeVC.h"
#import "QLAppDelegate.h"
#import "XMPPvCardTemp.h"

@interface QLMeVC()

- (IBAction)logoutBtnClick:(id)sender;
/**
 *  头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *headerView;
/**
 *  昵称
 */
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;

/**
 *  微信号
 */
@property (weak, nonatomic) IBOutlet UILabel *weixinNumLabel;

@end

@implementation QLMeVC


-(void)viewDidLoad{
    [super viewDidLoad];
    
    // 显示当前用户个人信息
    XMPPvCardTemp *myVCard =[QLXMPPTool sharedQLXMPPTool].vCard.myvCardTemp;
    
    // 设置头像
    if(myVCard.photo){
        self.headerView.image = [UIImage imageWithData:myVCard.photo];
    }
    
    // 设置昵称
    self.nickNameLabel.text = myVCard.nickname;
    
    // 设置微信号
    
    NSString *user = [QLUserInfo sharedQLUserInfo].user;
    if (user.length) {
        self.weixinNumLabel.text = [NSString stringWithFormat:@"微信号:%@",user];
    }   
    
}

// 注销
- (IBAction)logoutBtnClick:(id)sender {

    
    [[QLXMPPTool sharedQLXMPPTool] xmppUserlogout];
}
@end
