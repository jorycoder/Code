//
//  WCInputView.m
//  WeChat
//
//  Created by QiLi on 16/9/9.
//  Copyright © 2016年 qili. All rights reserved.
//

#import "QLInputView.h"

@implementation QLInputView

+(instancetype)inputView{
    return [[[NSBundle mainBundle] loadNibNamed:@"QLInputView" owner:nil options:nil] lastObject];
}

@end
