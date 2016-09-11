//
//  QLStatusPhotosView.m
//  新浪微博
//
//  Created by QiLi on 16/7/14.
//  Copyright © 2016年 QiLi. All rights reserved.
//

#import "QLStatusPhotosView.h"
#import "QLPhoto.h"
#import "QLStatusPhotoView.h"

#define QLStatusPhotoWH 70
#define QLStatusPhotoMargin 10
#define QLStatusPhotoMaxCol(count) ((count==4)?2:3)

@implementation QLStatusPhotosView // 9

#pragma mark - Life Cycle
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置图片的尺寸和位置
    NSUInteger photosCount = self.photos.count;
    int maxCol = QLStatusPhotoMaxCol(photosCount);
    for (int i = 0; i<photosCount; i++) {
        QLStatusPhotoView *photoView = self.subviews[i];
        
        int col = i % maxCol;
        photoView.x = col * (QLStatusPhotoWH + QLStatusPhotoMargin);
        
        int row = i / maxCol;
        photoView.y = row * (QLStatusPhotoWH + QLStatusPhotoMargin);
        photoView.width = QLStatusPhotoWH;
        photoView.height = QLStatusPhotoWH;
    }
}



#pragma mark - Private Method
- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    
    NSUInteger photosCount = photos.count;
    
    // 创建足够数量的图片控件
    while (self.subviews.count < photosCount) {
        QLStatusPhotoView *photoView = [[QLStatusPhotoView alloc] init];
        [self addSubview:photoView];
    }
    
    // 遍历所有的图片控件，设置图片
    for (int i = 0; i<self.subviews.count; i++) {
        QLStatusPhotoView *photoView = self.subviews[i];
        
        if (i < photosCount) { // 显示
            photoView.photo = photos[i];
            photoView.hidden = NO;
        } else { // 隐藏
            photoView.hidden = YES;
        }
    }
}


+ (CGSize)sizeWithCount:(NSUInteger)count
{
    // 最大列数（一行最多有多少列）
    int maxCols = QLStatusPhotoMaxCol(count);
    
    NSUInteger cols = (count >= maxCols)? maxCols : count;
    CGFloat photosW = cols * QLStatusPhotoWH + (cols - 1) * QLStatusPhotoMargin;
    
    // 行数
    NSUInteger rows = (count + maxCols - 1) / maxCols;
    CGFloat photosH = rows * QLStatusPhotoWH + (rows - 1) * QLStatusPhotoMargin;
    
    return CGSizeMake(photosW, photosH);
}
@end
