//
//  QLOAuthVC.m
//  新浪微博
//
//  Created by QiLi on 16/7/14.
//  Copyright © 2016年 QiLi. All rights reserved.
//

#import "QLOAuthVC.h"
#import "QLAccountTool.h"
#import "MBProgressHUD+MJ.h"
#import "QLHttpTool.h"

@interface QLOAuthVC () <UIWebViewDelegate>

@end

@implementation QLOAuthVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.创建一个webView
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    [self.view addSubview:webView];

    
    // 2.用webView加载登录页面（新浪提供的）
    NSString *urlStr = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@", QLAppKey, QLRedirectURI];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
    
}

#pragma mark - webView代理方法
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
    // 3. 提示View
    UITextView *tipView = [[UITextView alloc] init];
    tipView.width = webView.width * 0.8;
    tipView.height = 90;
    tipView.centerX = webView.centerX;
    tipView.centerY = webView.centerY;
    
    tipView.text = @"用户名: 17051007232\n\n密码:qili1705100";
    tipView.font = [UIFont systemFontOfSize:17];
    tipView.textAlignment = NSTextAlignmentCenter;
    tipView.backgroundColor = [UIColor redColor];
    [webView addSubview:tipView];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在加载..."];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    // 1.获得url
    NSString *url = request.URL.absoluteString;
    
    // 2.判断是否为回调地址
    NSRange range = [url rangeOfString:@"code="];
    if (range.length != 0) { // 是回调地址
        // 截取code=后面的参数值
        NSUInteger fromIndex = range.location + range.length;
        NSString *code = [url substringFromIndex:fromIndex];
        
        // 利用code换取一个accessToken
        [self accessTokenWithCode:code];
        
        // 禁止加载回调地址
        return NO;
    }
    
    return YES;
}

/**
 *  利用code（授权成功后的request token）换取一个accessToken
 *
 *  @param code 授权成功后的request token
 */
- (void)accessTokenWithCode:(NSString *)code
{
    // 1.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = QLAppKey;
    params[@"client_secret"] = QLAppSecret;
    params[@"grant_type"] = @"authorization_code";
    params[@"redirect_uri"] = QLRedirectURI;
    params[@"code"] = code;
    
    // 2.发送请求
    [QLHttpTool post:@"https://api.weibo.com/oauth2/access_token" params:params success:^(id json) {
        [MBProgressHUD hideHUD];
        
        // 将返回的账号字典数据 --> 模型，存进沙盒
        QLAccount *account = [QLAccount accountWithDict:json];
        // 存储账号信息
        [QLAccountTool saveAccount:account];
        
        // 切换窗口的根控制器
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window switchRootViewController];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        QLLog(@"请求失败-%@", error);
    }];
}
@end

