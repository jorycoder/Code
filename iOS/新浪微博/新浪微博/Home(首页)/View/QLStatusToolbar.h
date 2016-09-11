//
//  QLStatusToolbar.h
//  新浪微博
//
//  Created by QiLi on 16/7/14.
//  Copyright © 2016年 QiLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QLStatus;
@interface QLStatusToolbar : UIView

+ (instancetype)toolbar;
@property (nonatomic, strong) QLStatus *status;

@end