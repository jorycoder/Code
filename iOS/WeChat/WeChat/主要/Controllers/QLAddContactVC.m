//
//  QLAddContactVC.m
//  WeChat
//
//  Created by apple on 16/9/9.
//  Copyright (c) 2016年 qili. All rights reserved.
//

#import "QLAddContactVC.h"

@interface QLAddContactVC()<UITextFieldDelegate>

@end

@implementation QLAddContactVC


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    // 添加好友
    
    // 1.获取好友账号
    NSString *user = textField.text;
    QLLog(@"%@",user);
    
    // 判断这个账号是否为手机号码
    if(![textField isTelphoneNum]){
        [self showAlert:@"请输入正确的手机号码"];
        return YES;
    }
    
    //判断是否添加自己
    if([user isEqualToString:[QLUserInfo sharedQLUserInfo].user]){
        
        [self showAlert:@"不能添加自己为好友"];
        return YES;
    }
    NSString *jidStr = [NSString stringWithFormat:@"%@@%@",user,domain];
    XMPPJID *friendJid = [XMPPJID jidWithString:jidStr];
    
    //判断好友是否已经存在
    if([[QLXMPPTool sharedQLXMPPTool].rosterStorage userExistsWithJID:friendJid xmppStream:[QLXMPPTool sharedQLXMPPTool].xmppStream]){
        [self showAlert:@"当前好友已经存在"];
        return YES;
    }
    
    
    // 2.发送好友添加的请求
    [[QLXMPPTool sharedQLXMPPTool].roster subscribePresenceToUser:friendJid];
    
    return YES;
}

-(void)showAlert:(NSString *)msg{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:msg delegate:nil cancelButtonTitle:@"谢谢" otherButtonTitles:nil, nil];
    [alert show];
}
@end
