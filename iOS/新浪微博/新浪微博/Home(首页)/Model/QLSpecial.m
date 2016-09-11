//
//  QLSpecial.m
//  新浪微博
//
//  Created by QiLi on 16/7/14.
//  Copyright © 2016年 QiLi. All rights reserved.
//

#import "QLSpecial.h"

@implementation QLSpecial

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ - %@", self.text, NSStringFromRange(self.range)];
}
@end
