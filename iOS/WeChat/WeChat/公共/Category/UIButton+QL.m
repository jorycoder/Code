
//
//  UIButton+QL.m
//  WeChat
//
//  Created by QiLi on 16/9/8.
//  Copyright © 2016年 qili. All rights reserved.
//

#import "UIButton+QL.h"

@implementation UIButton (QL)
-(void)setN_BG:(NSString *)nbg H_BG:(NSString *)hbg{
    [self setBackgroundImage:[UIImage imageNamed:nbg] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:hbg] forState:UIControlStateHighlighted];
}


-(void)setResizeN_BG:(NSString *)nbg H_BG:(NSString *)hbg{
    [self setBackgroundImage:[UIImage stretchedImageWithName:nbg] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage stretchedImageWithName:hbg] forState:UIControlStateHighlighted];
}
@end
