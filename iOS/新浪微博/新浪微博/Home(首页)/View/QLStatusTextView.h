//
//  QLStatusTextView.h
//  新浪微博
//
//  Created by QiLi on 16/7/14.
//  Copyright © 2016年 QiLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QLStatusTextView : UITextView
/** 所有的特殊字符串(里面存放着QLSpecial) */
@property (nonatomic, strong) NSArray *specials;
@end
