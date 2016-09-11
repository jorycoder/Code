

//
//  UIScreen+QL.m
//  WeChat
//
//  Created by QiLi on 16/9/8.
//  Copyright © 2016年 qili. All rights reserved.
//

#import "UIScreen+QL.h"

@implementation UIScreen (QL)
-(CGFloat)screenH{
    return [UIScreen mainScreen].bounds.size.height;
}

-(CGFloat)screenW{
    return [UIScreen mainScreen].bounds.size.width;
}
@end
