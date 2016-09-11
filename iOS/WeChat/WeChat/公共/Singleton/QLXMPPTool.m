//
//  QLXMPPTool.m
//  WeChat
//
//  Created by apple on 16/9/8.
//  Copyright (c) 2016年 qili. All rights reserved.
//


#import "QLXMPPTool.h"

NSString *const QLLoginStatusChangeNotification = @"WCLoginStatusNotification";


@interface QLXMPPTool ()<XMPPStreamDelegate>{
    
    XMPPResultBlock _resultBlock;// 回调结果Block
    
    XMPPReconnect *_reconnect;// 自动连接模块
    
    XMPPvCardCoreDataStorage *_vCardStorage;//电子名片的数据存储
    
    XMPPvCardAvatarModule *_avatar;//头像模块
    
    XMPPMessageArchiving *_msgArchiving;//聊天模块
    
    
    
}

// 1. 初始化XMPPStream
-(void)setupXMPPStream;

// 2.连接到服务器
-(void)connectToHost;

// 3.连接到服务成功后，再发送密码授权
-(void)sendPwdToHost;

// 4.授权成功后，发送"在线" 消息
-(void)sendOnlineToHost;
@end


@implementation QLXMPPTool


singleton_implementation(QLXMPPTool)



#pragma mark - Private Method
/**
 *   初始化XMPPStream
 */
-(void)setupXMPPStream{
    
    _xmppStream = [[XMPPStream alloc] init];
    //添加自动连接模块
    _reconnect = [[XMPPReconnect alloc] init];
    [_reconnect activate:_xmppStream];
    
    //添加电子名片模块
    _vCardStorage = [XMPPvCardCoreDataStorage sharedInstance];
    _vCard = [[XMPPvCardTempModule alloc] initWithvCardStorage:_vCardStorage];
    
    //激活
    [_vCard activate:_xmppStream];
    
    //添加头像模块
    _avatar = [[XMPPvCardAvatarModule alloc] initWithvCardTempModule:_vCard];
    [_avatar activate:_xmppStream];
    
    
    // 添加花名册模块【获取好友列表】
    _rosterStorage = [[XMPPRosterCoreDataStorage alloc] init];
    _roster = [[XMPPRoster alloc] initWithRosterStorage:_rosterStorage];
    [_roster activate:_xmppStream];
    
    // 添加聊天模块
    _msgStorage = [[XMPPMessageArchivingCoreDataStorage alloc] init];
    _msgArchiving = [[XMPPMessageArchiving alloc] initWithMessageArchivingStorage:_msgStorage];
    [_msgArchiving activate:_xmppStream];
    
    _xmppStream.enableBackgroundingOnSocket = YES;
    
    // 设置代理
    [_xmppStream addDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
}

/**
 *  释放xmppStream相关的资源
 */
-(void)teardownXmpp{
    
    // 移除代理
    [_xmppStream removeDelegate:self];
    
    // 停止模块
    [_reconnect deactivate];
    [_vCard deactivate];
    [_avatar deactivate];
    [_roster deactivate];
    [_msgArchiving deactivate];
    
    // 断开连接
    [_xmppStream disconnect];
    
    // 清空资源
    _reconnect = nil;
    _vCard = nil;
    _vCardStorage = nil;
    _avatar = nil;
    _roster = nil;
    _rosterStorage = nil;
    _msgArchiving = nil;
    _msgStorage = nil;
    _xmppStream = nil;
    
}

/**
 *  连接到服务器
 */
-(void)connectToHost{
    QLLog(@"开始连接到服务器");
    if (!_xmppStream) {
        [self setupXMPPStream];
    }
    
    // 发送通知【正在连接】
    [self postNotification:XMPPResultTypeConnecting];
    
    // 从单例获取用户名
    NSString *user = nil;
    if (self.isRegisterOperation) {
        user = [QLUserInfo sharedQLUserInfo].registerUser;
    }else{
        user = [QLUserInfo sharedQLUserInfo].user;
    }
    
    XMPPJID *myJID = [XMPPJID jidWithUser:user domain:@"teacher.local" resource:@"iphone" ];
    _xmppStream.myJID = myJID;
    
    // 设置服务器域名
    _xmppStream.hostName = @"qili.local";
    
    // 设置端口 如果服务器端口是5222，可以省略
    _xmppStream.hostPort = 5222;
    
    // 连接
    NSError *err = nil;
    if(![_xmppStream connectWithTimeout:XMPPStreamTimeoutNone error:&err]){
        QLLog(@"%@",err);
    }
    
}

/**
 *  连接到服务成功后，再发送密码授权
 */
-(void)sendPwdToHost{
    NSError *err = nil;
    
    // 从单例里获取密码
    NSString *pwd = [QLUserInfo sharedQLUserInfo].pwd;
    
    [_xmppStream authenticateWithPassword:pwd error:&err];
    
    if (err) {
        QLLog(@"%@",err);
    }
}

/**
 *  授权成功后，发送"在线" 消息
 */
-(void)sendOnlineToHost{
    
    XMPPPresence *presence = [XMPPPresence presence];
    QLLog(@"%@",presence);
    
    [_xmppStream sendElement:presence];
    
    
}


/**
 * 通知 QLHistoryViewControllers 登录状态
 */
-(void)postNotification:(XMPPResultType)resultType{
    
    // 将登录状态放入字典，然后通过通知传递
    NSDictionary *userInfo = @{@"loginStatus":@(resultType)};
    
    [[NSNotificationCenter defaultCenter] postNotificationName:QLLoginStatusChangeNotification object:nil userInfo:userInfo];
}

#pragma mark -XMPPStreamDelegate
-(void)xmppStreamDidConnect:(XMPPStream *)sender{
    QLLog(@"与主机连接成功");
    
    if (self.isRegisterOperation) {
        //注册操作，发送注册的密码
        NSString *pwd = [QLUserInfo sharedQLUserInfo].registerPwd;
        [_xmppStream registerWithPassword:pwd error:nil];
    }else{//登录操作
        // 主机连接成功后，发送密码进行授权
        [self sendPwdToHost];
    }
    
}
-(void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error{
    
    if(error && _resultBlock){
        _resultBlock(XMPPResultTypeNetErr);
    }
    
    if (error) {
        [self postNotification:XMPPResultTypeNetErr];
    }
    QLLog(@"与主机断开连接 %@",error);
    
}

-(void)xmppStreamDidAuthenticate:(XMPPStream *)sender{
    QLLog(@"授权成功");
    
    [self sendOnlineToHost];
    
    // 回调控制器登录成功
    if(_resultBlock){
        _resultBlock(XMPPResultTypeLoginSuccess);
    }
    
    [self postNotification:XMPPResultTypeLoginSuccess];
    
}

-(void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error{
    QLLog(@"授权失败 %@",error);
    if (_resultBlock) {
        _resultBlock(XMPPResultTypeLoginFailure);
    }
    
    [self postNotification:XMPPResultTypeLoginFailure];
}

-(void)xmppStreamDidRegister:(XMPPStream *)sender{
    QLLog(@"注册成功");
    if(_resultBlock){
        _resultBlock(XMPPResultTypeRegisterSuccess);
    }
    
}

-(void)xmppStream:(XMPPStream *)sender didNotRegister:(DDXMLElement *)error{
    
    if(_resultBlock){
        _resultBlock(XMPPResultTypeRegisterFailure);
    }
    
}

-(void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message{
    QLLog(@"%@",message);
    
    //如果当前程序不在前台，发出一个本地通知
    if([UIApplication sharedApplication].applicationState != UIApplicationStateActive){
        QLLog(@"在后台");
        
        //本地通知
        UILocalNotification *localNoti = [[UILocalNotification alloc] init];
        
        // 设置内容
        localNoti.alertBody = [NSString stringWithFormat:@"%@\n%@",message.fromStr,message.body];
        
        // 设置通知执行时间
        localNoti.fireDate = [NSDate date];
        
        //声音
        localNoti.soundName = @"default";
        
        //执行
        [[UIApplication sharedApplication] scheduleLocalNotification:localNoti];
        
    }
}


#pragma mark - Public Method
-(void)xmppUserlogout{
    // 1." 发送 "离线" 消息"
    XMPPPresence *offline = [XMPPPresence presenceWithType:@"unavailable"];
    [_xmppStream sendElement:offline];
    
    // 2. 与服务器断开连接
    [_xmppStream disconnect];
    
    [UIStoryboard showInitialVCWithName:@"Login"];
    
    
    //4.更新用户的登录状态
    [QLUserInfo sharedQLUserInfo].loginStatus = NO;
    [[QLUserInfo sharedQLUserInfo] saveUserInfoToSanbox];
    
}

-(void)xmppUserLogin:(XMPPResultBlock)resultBlock{
    
    // 先把block存起来
    _resultBlock = resultBlock;
    
    //    Domain=XMPPStreamErrorDomain Code=1 "Attempting to connect while already connected or connecting." UserInfo=0x7fd86bf06700 {NSLocalizedDescription=Attempting to connect while already connected or connecting.}
    // 如果以前连接过服务，要断开
    [_xmppStream disconnect];
    
    // 连接主机 成功后发送登录密码
    [self connectToHost];
}


-(void)xmppUserRegister:(XMPPResultBlock)resultBlock{
    // 先把block存起来
    _resultBlock = resultBlock;
    
    // 如果以前连接过服务，要断开
    [_xmppStream disconnect];
    
    // 连接主机 成功后发送注册密码
    [self connectToHost];
}


-(void)dealloc{
    [self teardownXmpp];
}
@end
