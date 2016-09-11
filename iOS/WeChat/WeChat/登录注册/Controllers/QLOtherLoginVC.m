//
//  QLOtherLoginVC.m
//  WeChat
//
//  Created by apple on 16/9/8.
//  Copyright (c) 2016年 qili. All rights reserved.
//

#import "QLOtherLoginVC.h"
#import "QLAppDelegate.h"

@interface QLOtherLoginVC()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightConstraint;
@property (weak, nonatomic) IBOutlet UITextField *userField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation QLOtherLoginVC

#pragma mark - Life Cycle
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"其它方式登录";
    // 判断当前设备的类型
    if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone){
        self.leftConstraint.constant = 10;
        self.rightConstraint.constant = 10;
    }
    
    // 设置TextFeild的背景
    self.userField.background = [UIImage stretchedImageWithName:@"operationbox_text"];
    self.pwdField.background = [UIImage stretchedImageWithName:@"operationbox_text"];
    
    [self.loginBtn setResizeN_BG:@"fts_green_btn" H_BG:@"fts_green_btn_HL"];
    
}

#pragma mark - Touch Event
// 登录
- (IBAction)loginBtnClick {
    // 登录
    QLUserInfo *userInfo = [QLUserInfo sharedQLUserInfo];
    userInfo.user = self.userField.text;
    userInfo.pwd = self.pwdField.text;
    
    [super login];
}
// 取消
- (IBAction)cancel:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
