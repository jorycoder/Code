//
//  WCInputView.h
//  WeChat
//
//  Created by QiLi on 16/9/9.
//  Copyright © 2016年 qili. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QLInputView : UIView
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

+(instancetype)inputView;
@end