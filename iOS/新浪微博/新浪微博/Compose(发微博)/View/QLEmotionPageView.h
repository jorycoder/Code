//
//  QLEmotionPageView.h
//  新浪微博
//
//  Created by QiLi on 16/7/12.
//  Copyright © 2016年 QiLi. All rights reserved.
//

#import <UIKit/UIKit.h>

// 一页中最多3行
#define QLEmotionMaxRows 3
// 一行中最多7列
#define QLEmotionMaxCols 7
// 每一页的表情个数
#define QLEmotionPageSize ((QLEmotionMaxRows * QLEmotionMaxCols) - 1)

@interface QLEmotionPageView : UIView
/** 这一页显示的表情（里面都是QLEmotion模型） */
@property (nonatomic, strong) NSArray *emotions;
@end