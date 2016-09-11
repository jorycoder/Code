//
//  QLEditProfileVC.h
//  WeChat
//
//  Created by apple on 16/9/9.
//  Copyright (c) 2016年 qili. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol QLEditProfileVCDelegate <NSObject>

-(void)editProfileViewControllerDidSave;


@end

@interface QLEditProfileVC : UITableViewController

@property (nonatomic, strong) UITableViewCell *cell;

@property (nonatomic, weak) id<QLEditProfileVCDelegate> delegate;

@end
