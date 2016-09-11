//
//  QLComposePhotosView.h
//  新浪微博
//
//  Created by QiLi on 16/7/12.
//  Copyright © 2016年 QiLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QLPostPhotosView : UIView

- (void)addPhoto:(UIImage *)photo;

@property (nonatomic, strong, readonly) NSMutableArray *photos;


@end