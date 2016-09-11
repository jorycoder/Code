//
//  QLEmotionTextView.h
//  新浪微博
//
//  Created by QiLi on 16/7/12.
//  Copyright © 2016年 QiLi. All rights reserved.
//

#import "QLTextView.h"
@class QLEmotion;

@interface QLEmotionTextView : QLTextView
- (void)insertEmotion:(QLEmotion *)emotion;

- (NSString *)fullText;
@end
