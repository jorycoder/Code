//
//  QLHttpTool.h
//  WeChat
//
//  Created by QiLi on 16/9/9.
//  Copyright © 2016年 qili. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^HttpToolProgressBlock)(CGFloat progress);
typedef void (^HttpToolCompletionBlock)(NSError *error);



@interface QLHttpTool : NSObject

/**
 上传数据
 */
-(void)uploadData:(NSData *)data
              url:(NSURL *)url
   progressBlock : (HttpToolProgressBlock)progressBlock
       completion:(HttpToolCompletionBlock) completionBlock;

/**
 下载数据
 */
-(void)downLoadFromURL:(NSURL *)url
        progressBlock : (HttpToolProgressBlock)progressBlock
            completion:(HttpToolCompletionBlock) completionBlock;


-(NSString *)fileSavePath:(NSString *)fileName;
@end
