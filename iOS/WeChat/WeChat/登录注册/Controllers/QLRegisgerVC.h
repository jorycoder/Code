//
//  QLRegisgerVC.h
//  WeChat
//
//  Created by apple on 16/9/8.
//  Copyright (c) 2016年 qili. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol QLRegisgerVCDelegate <NSObject>

/**
 *  完成注册
 */
-(void)regisgerViewControllerDidFinishRegister;

@end
@interface QLRegisgerVC : UIViewController

@property (nonatomic, weak) id<QLRegisgerVCDelegate> delegate;

@end
