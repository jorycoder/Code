//
//  QLMessageCenterVC.m
//  新浪微博
//
//  Created by QiLi on 16/7/11.
//  Copyright © 2016年 QiLi. All rights reserved.
//

#import "QLMessageCenterVC.h"

@interface QLMessageCenterVC ()

@end

@implementation QLMessageCenterVC

#pragma mark - Life Cycle
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"写私信" style:UIBarButtonItemStylePlain target:self action:@selector(postMsg)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark - Touch Event
- (void)postMsg
{
    NSLog(@"post");
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    if (indexPath.row % 4 == 0) {
        cell.textLabel.text = [NSString stringWithFormat:@"主要功能:"];
        cell.detailTextLabel.text = [NSString stringWithFormat:@""];
    }else if (indexPath.row % 4 == 1)
    {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"首页：可以查看、上拉加载微博、下拉刷新微博，支持链接点击事件"];
        cell.textLabel.text = [NSString stringWithFormat:@""];

    }else if (indexPath.row % 4 == 2)
    {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"发微博页面：自定义键盘，支持表情发送"];
        cell.textLabel.text = [NSString stringWithFormat:@""];

    }else
    {
        
        cell.detailTextLabel.text = [NSString stringWithFormat:@""];
        cell.textLabel.text = [NSString stringWithFormat:@""];
        
    }
    
    
    return cell;
}

@end

