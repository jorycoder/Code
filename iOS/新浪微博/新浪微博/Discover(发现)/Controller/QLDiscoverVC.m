//
//  QLDiscoverVC.m
//  新浪微博
//
//  Created by QiLi on 16/7/11.
//  Copyright © 2016年 QiLi. All rights reserved.
//


#import "QLDiscoverVC.h"
#import "QLSearchBar.h"


@interface QLDiscoverVC ()
@property (nonatomic, strong) QLSearchBar *searchBar;
@end

@implementation QLDiscoverVC

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
    
    // 创建搜索框对象
    QLSearchBar *searchBar = [QLSearchBar searchBar];
    searchBar.width = 300;
    searchBar.height = 30;
    self.searchBar = searchBar;
    self.navigationItem.titleView = searchBar;
}

#pragma mark - Touch Event

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.searchBar endEditing:YES];
}

#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 200;
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 {
     static NSString *ID = @"cell";
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
     if (!cell) {
         cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
     }
     cell.selectionStyle = UITableViewCellSelectionStyleNone;

     if (indexPath.row % 4 == 0) {
         cell.textLabel.text = [NSString stringWithFormat:@"主要页面:"];
         cell.detailTextLabel.text = [NSString stringWithFormat:@""];
     }else if (indexPath.row % 4 == 1)
     {
         cell.detailTextLabel.text = [NSString stringWithFormat:@"首页：可以查看、上拉加载微博、下拉刷新微博，支持链接点击事件"];
         cell.textLabel.text = [NSString stringWithFormat:@""];
         
     }else if (indexPath.row % 4 == 2)
     {
         cell.detailTextLabel.text = [NSString stringWithFormat:@"发微博页面：自定义了键盘，支持表情发送哦"];
         cell.textLabel.text = [NSString stringWithFormat:@""];
         
     }else
     {
         
         cell.detailTextLabel.text = [NSString stringWithFormat:@""];
         cell.textLabel.text = [NSString stringWithFormat:@""];
         
     }
     
     return cell;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
