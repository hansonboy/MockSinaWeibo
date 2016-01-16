//
//  WBStatusPhotosView.m
//  JW微博JW
//
//  Created by wangjianwei on 15/12/25.
//  Copyright © 2015年 JW. All rights reserved.
//

#import "WBStatusPhotosView.h"
#import "WBPhoto.h"
#import "WBStatusPhotoView.h"
@implementation WBStatusPhotosView
-(void)setPhotoUrls:(NSArray *)photoUrls{
//    return;
    _photoUrls = photoUrls;
    NSInteger photosCount = _photoUrls.count;
    while (self.subviews.count < photosCount) {
        WBStatusPhotoView *imgView = [[WBStatusPhotoView alloc]init];
        imgView.size = (CGSize){kStatusCellPhotosWH,kStatusCellPhotosWH};
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.clipsToBounds = YES;
        [self addSubview:imgView];
    }
    NSInteger subviewCount = self.subviews.count;
    for (int i = 0; i < subviewCount; i++) {
        WBStatusPhotoView *imgView = self.subviews[i];
        if (i < photosCount) {
            imgView.hidden = NO;
            imgView.photo = _photoUrls[i];
        }else{
            imgView.hidden = YES;
        }
    }
    
}
+(CGSize)sizeWithCount:(NSInteger)count{

    NSInteger row = (count + kStatusCellPhotoMaxCol(count) - 1)/kStatusCellPhotoMaxCol(count);
    CGFloat height = row *kStatusCellPhotosWH + (row -1)*kStatusCellPhotoMagin;
    NSInteger col = count > kStatusCellPhotoMaxCol(count) ? kStatusCellPhotoMaxCol(count):count;
    CGFloat width = col *kStatusCellPhotosWH + (col -1)*kStatusCellPhotoMagin;
    return (CGSize){width,height};
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        // 子控件的数目如果是固定的，我们可以选择在这里一次全部创建加载。
        //此处，我们本着懒加载原则，放在了setPhotoUrls: 方法中进行
//        self.backgroundColor = [UIColor yellowColor];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    NSInteger photoCount =self.photoUrls.count;
    for (int i = 0; i < photoCount; i++) {
        UIImageView *imageView = self.subviews[i];
        NSInteger col = i%kStatusCellPhotoMaxCol(photoCount);
        NSInteger row = i/kStatusCellPhotoMaxCol(photoCount);
        imageView.x = col *(kStatusCellPhotosWH + kStatusCellPhotoMagin);
        imageView.y = row*(kStatusCellPhotosWH + kStatusCellPhotoMagin);
    }
}
@end
