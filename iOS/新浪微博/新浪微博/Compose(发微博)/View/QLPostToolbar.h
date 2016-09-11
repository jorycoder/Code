//
//  QLComposeToolbar.h
//  新浪微博
//
//  Created by QiLi on 16/7/12.
//  Copyright © 2016年 QiLi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    QLPostToolbarButtonTypeCamera, // 拍照
    QLPostToolbarButtonTypePicture, // 相册
    QLPostToolbarButtonTypeMention, // @
    QLPostToolbarButtonTypeTrend, // #
    QLPostToolbarButtonTypeEmotion // 表情
} QLPostToolbarButtonType;

@class QLPostToolbar;

@protocol QLPostToolbarDelegate <NSObject>
@optional
- (void)postToolbar:(QLPostToolbar *)toolbar didClickButton:(QLPostToolbarButtonType)buttonType;
@end

@interface QLPostToolbar : UIView

@property (nonatomic, weak) id<QLPostToolbarDelegate> delegate;
/** 是否要显示键盘按钮  */
@property (nonatomic, assign) BOOL showKeyboardButton;
@end
