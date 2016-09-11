//
//  QLLoadMoreFooter.m
//  新浪微博
//
//  Created by QiLi on 16/7/14.
//  Copyright © 2016年 QiLi. All rights reserved.
//

#import "QLLoadMoreFooter.h"

@implementation QLLoadMoreFooter

+ (instancetype)footer
{
    return [[[NSBundle mainBundle] loadNibNamed:@"QLLoadMoreFooter" owner:nil options:nil] lastObject];
}

@end
