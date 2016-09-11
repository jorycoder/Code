//
//  QLStatusCell.h
//  新浪微博
//
//  Created by QiLi on 16/7/14.
//  Copyright © 2016年 QiLi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QLStatusFrame;

@interface QLStatusCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) QLStatusFrame *statusFrame;

@end
