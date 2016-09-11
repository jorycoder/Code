//
//  QLUser.h
//  新浪微博
//
//  Created by QiLi on 16/7/14.
//  Copyright © 2016年 QiLi. All rights reserved.
//

//  用户模型

#import <Foundation/Foundation.h>

typedef enum {
    QLUserVerifiedTypeNone = -1, // 没有任何认证
    
    QLUserVerifiedPersonal = 0,  // 个人认证
    
    QLUserVerifiedOrgEnterprice = 2, // 企业官方：
    QLUserVerifiedOrgMedia = 3, // 媒体官方
    QLUserVerifiedOrgWebsite = 5, // 网站官方
    
    QLUserVerifiedDaren = 220 // 微博达人
} QLUserVerifiedType;

@interface QLUser : NSObject
/**	string	字符串型的用户UID*/
@property (nonatomic, copy) NSString *idstr;

/**	string	友好显示名称*/
@property (nonatomic, copy) NSString *name;

/**	string	用户头像地址，50×50像素*/
@property (nonatomic, copy) NSString *profile_image_url;

/** 会员类型 > 2代表是会员 */
@property (nonatomic, assign) int mbtype;
/** 会员等级 */
@property (nonatomic, assign) int mbrank;
@property (nonatomic, assign, getter = isVip) BOOL vip;

/** 认证类型 */
@property (nonatomic, assign) QLUserVerifiedType verified_type;
@end

