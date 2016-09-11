
//
//  UIImage+QL.m
//  WeChat
//
//  Created by QiLi on 16/9/8.
//  Copyright © 2016年 qili. All rights reserved.
//

#import "UIImage+QL.h"

@implementation UIImage (QL)
+(UIImage *)stretchedImageWithName:(NSString *)name{
    
    UIImage *image = [UIImage imageNamed:name];
    int leftCap = image.size.width * 0.5;
    int topCap = image.size.height * 0.5;
    return [image stretchableImageWithLeftCapWidth:leftCap topCapHeight:topCap];
}
@end
