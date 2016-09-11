//
//  QLLoginVC.m
//  WeChat
//
//  Created by apple on 16/9/9.
//  Copyright (c) 2016年 qili. All rights reserved.
//

#import "QLLoginVC.h"
#import "QLRegisgerVC.h"
#import "QLAppDelegate.h"
#import "QLNavigationController.h"

@interface QLLoginVC()<QLRegisgerVCDelegate>
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation QLLoginVC

#pragma mark - Life Cycle
-(void)viewDidLoad{
    [super viewDidLoad];
    
    // 设置TextField和Btn的样式
    self.pwdField.background = [UIImage stretchedImageWithName:@"operationbox_text"];
    
  
    [self.pwdField addLeftViewWithImage:@"Card_Lock"];
    
    [self.loginBtn setResizeN_BG:@"fts_green_btn" H_BG:@"fts_green_btn_HL"];
    
    
    // 设置用户名为上次登录的用户名
    
    //从沙盒获取用户名
    NSString *user = [QLUserInfo sharedQLUserInfo].user;
    self.userLabel.text = user;
}

#pragma mark - Touch Event
- (IBAction)loginBtnClick:(id)sender {
    
    // 保存数据到单例
    
    QLUserInfo *userInfo = [QLUserInfo sharedQLUserInfo];
    userInfo.user = self.userLabel.text;
    userInfo.pwd = self.pwdField.text;
    
    // 调用父类的登录
    [super login];
    
}

// 游客方式进入
- (IBAction)loginWithGuestMode:(id)sender
{
    QLAppDelegate *app = (QLAppDelegate *)[UIApplication sharedApplication].delegate;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    app.window.rootViewController = storyboard.instantiateInitialViewController;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    // 获取注册控制器
    id destVc = segue.destinationViewController;
    
    
    if ([destVc isKindOfClass:[QLNavigationController class]]) {
        QLNavigationController *nav = destVc;
        //获取根控制器
        
        if ([nav.topViewController isKindOfClass:[QLRegisgerVC class]]) {
            QLRegisgerVC *registerVc =  (QLRegisgerVC *)nav.topViewController;
            // 设置注册控制器的代理
            registerVc.delegate = self;
        }
        
    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

#pragma mark UIRegisgerViewControllerDelegete
-(void)regisgerViewControllerDidFinishRegister{
    QLLog(@"完成注册");
    self.userLabel.text = [QLUserInfo sharedQLUserInfo].registerUser;
    [MBProgressHUD showSuccess:@"请重新输入密码进行登录" toView:self.view];
    
}

@end
