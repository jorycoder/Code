//
//  QLChatVC.m
//  WeChat
//
//  Created by QiLi on 16/9/9.
//  Copyright © 2016年 qili. All rights reserved.
//

#import "QLChatVC.h"
#import "QLInputView.h"
#import "QLHttpTool.h"
#import "UIImageView+WebCache.h"

@interface QLChatVC ()<UITableViewDataSource,UITableViewDelegate,NSFetchedResultsControllerDelegate,UITextViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>{
    
    NSFetchedResultsController *_resultsContr;
    
}
@property (nonatomic, strong) NSLayoutConstraint *inputViewBottomConstraint;//inputView底部约束
@property (nonatomic, strong) NSLayoutConstraint *inputViewHeightConstraint;//inputView高度约束
@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) QLHttpTool *httpTool;
@end

@implementation QLChatVC



#pragma mark - Life Cycle
-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self setupView];
    
    // 键盘监听
    // 监听键盘
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    // 加载数据
    [self loadMsgs];
    
}
#pragma mark - Touch Event
-(void)scrollToTableBottom{
    NSInteger lastRow = _resultsContr.fetchedObjects.count - 1;
    
    if (lastRow < 0) {
        //行数小于0，不能滚动
        return;
    }
    NSIndexPath *lastPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
    
    [self.tableView scrollToRowAtIndexPath:lastPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}


-(void)addBtnClick{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
    
}

#pragma mark - Private Method
-(void)keyboardWillShow:(NSNotification *)noti{
    NSLog(@"%@",noti);
    // 获取键盘的高度
    CGRect kbEndFrm = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat kbHeight =  kbEndFrm.size.height;
    
    if([[UIDevice currentDevice].systemVersion doubleValue] < 8.0
       && UIInterfaceOrientationIsLandscape(self.interfaceOrientation)){
        kbHeight = kbEndFrm.size.width;
    }
        self.inputViewBottomConstraint.constant = kbHeight;
    
    //表格滚动到底部
    [self scrollToTableBottom];
    
}



-(void)keyboardWillHide:(NSNotification *)noti{
    self.inputViewBottomConstraint.constant = 0;
}


-(void)setupView{
    // 创建Tableview;
    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    // 创建输入框View
    QLInputView *inputView = [QLInputView inputView];
    inputView.translatesAutoresizingMaskIntoConstraints = NO;
    // 设置TextView代理
    inputView.textView.delegate = self;
    
    // 添加按钮事件
    [inputView.addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:inputView];
    
    // 自动布局
    
    // 水平方向的约束
    NSDictionary *views = @{@"tableview":tableView,
                            @"inputView":inputView};
    
    // 1.tabview水平方向的约束
    NSArray *tabviewHConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[tableview]-0-|" options:0 metrics:nil views:views];
    [self.view addConstraints:tabviewHConstraints];
    
    // 2.inputView水平方向的约束
    NSArray *inputViewHConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[inputView]-0-|" options:0 metrics:nil views:views];
    [self.view addConstraints:inputViewHConstraints];
    
    // 垂直方向的约束
    NSArray *vContraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-64-[tableview]-0-[inputView(50)]-0-|" options:0 metrics:nil views:views];
    [self.view addConstraints:vContraints];
    // 添加inputView的高度约束
    self.inputViewHeightConstraint = vContraints[2];
    self.inputViewBottomConstraint = [vContraints lastObject];
    NSLog(@"%@",vContraints);
}

/**
 * 加载XMPPMessageArchiving数据库的数据显示在表格
 */
-(void)loadMsgs{
    
    // 上下文
    NSManagedObjectContext *context = [QLXMPPTool sharedQLXMPPTool].msgStorage.mainThreadManagedObjectContext;
    // 请求对象
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"XMPPMessageArchiving_Message_CoreDataObject"];
    
    // 过滤、排序
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"streamBareJidStr = %@ AND bareJidStr = %@",[QLUserInfo sharedQLUserInfo].jid,self.friendJid.bare];
    NSLog(@"%@",pre);
    request.predicate = pre;
    
    // 时间升序
    NSSortDescriptor *timeSort = [NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:YES];
    request.sortDescriptors = @[timeSort];
    
    // 查询
    _resultsContr = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    NSError *err = nil;
    // 代理
    _resultsContr.delegate = self;
    [_resultsContr performFetch:&err];
    
    if (err) {
        QLLog(@"%@",err);
    }
}

/**
 *  发送聊天消息
 */
-(void)sendMsgWithText:(NSString *)text bodyType:(NSString *)bodyType{
    
    XMPPMessage *msg = [XMPPMessage messageWithType:@"chat" to:self.friendJid];
    
    [msg addAttributeWithName:@"bodyType" stringValue:bodyType];
    // 设置内容
    [msg addBody:text];
    [[QLXMPPTool sharedQLXMPPTool].xmppStream sendElement:msg];
}

#pragma mark - UITalbeViewDataSource, UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _resultsContr.fetchedObjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"ChatCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    // 获取聊天消息对象
    XMPPMessageArchiving_Message_CoreDataObject *msg =  _resultsContr.fetchedObjects[indexPath.row];
    
    // 判断是图片还是纯文本
    NSString *chatType = [msg.message attributeStringValueForName:@"bodyType"];
    if ([chatType isEqualToString:@"image"]) {
        //下图片显示
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:msg.body] placeholderImage:[UIImage imageNamed:@"DefaultProfileHead_qq"]];
        cell.textLabel.text = nil;
    }else if([chatType isEqualToString:@"text"])
    {
        
        //显示消息
        if ([msg.outgoing boolValue]) {//自己发的
            cell.textLabel.text = msg.body;
        }else{//别人发的
            cell.textLabel.text = msg.body;
        }
        
        cell.imageView.image = nil;
    }
    
    return cell;
}


#pragma mark - NSFetchedResultsControllerDelegate
-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    // 刷新数据
    [self.tableView reloadData];
    [self scrollToTableBottom];
}

#pragma mark - UITextViewDelegate
-(void)textViewDidChange:(UITextView *)textView{
    //获取ContentSize
    CGFloat contentH = textView.contentSize.height;
    NSLog(@"textView的content的高度 %f",contentH);
    
    // 大于33，超过一行的高度/ 小于68 高度是在三行内
    if (contentH > 33 && contentH < 68 ) {
        self.inputViewHeightConstraint.constant = contentH + 18;
    }
    
    NSString *text = textView.text;
    
    // 换行就等于点击了的send
    if ([text rangeOfString:@"\n"].length != 0) {
        NSLog(@"发送数据 %@",text);
        
        // 去除换行字符
        text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        [self sendMsgWithText:text bodyType:@"text"];
        //清空数据
        textView.text = nil;
        
        // 发送完消息 inputView高度初始化
        self.inputViewHeightConstraint.constant = 50;
        
    }else{
        
    }
}




#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSLog(@"%@",info);
    // 隐藏图片选择器的窗口
    [self dismissViewControllerAnimated:YES completion:nil];
    
    // 获取图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    // 1.文件名: 用户名 + 时间(201412111537)年月日时分秒
    NSString *user = [QLUserInfo sharedQLUserInfo].user;
    
    NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
    dataFormatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *timeStr = [dataFormatter stringFromDate:[NSDate date]];
    NSString *fileName = [user stringByAppendingString:timeStr];
    
    // 2.拼接上传路径，先存到蹦迪
    NSString *uploadUrl = [@"http://localhost:8080/imfileserver/Upload/Image/" stringByAppendingString:fileName];
    
    
    // 3.使用HTTP put 上传
    [self.httpTool uploadData:UIImageJPEGRepresentation(image, 0.75) url:[NSURL URLWithString:uploadUrl] progressBlock:nil completion:^(NSError *error) {
        
        if (!error) {
            NSLog(@"上传成功");
            [self sendMsgWithText:uploadUrl bodyType:@"image"];
        }
    }];
    
}

#pragma mark - Setter / Getter
-(QLHttpTool *)httpTool{
    if (!_httpTool) {
        _httpTool = [[QLHttpTool alloc] init];
    }
    
    return _httpTool;
}

@end
