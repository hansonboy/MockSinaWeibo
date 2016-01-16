//
//  WBStatusPhotoView.m
//  JW微博JW
//
//  Created by wangjianwei on 15/12/25.
//  Copyright © 2015年 JW. All rights reserved.
//  表示具体的一个配图，当出现gif 图片时候，我们需啊在配图的右下角增加gif 标志

#import "WBStatusPhotoView.h"
#import "WBPhoto.h"
@interface WBStatusPhotoView()
@property (strong,nonatomic)UIImageView *gifView;
@end
@implementation WBStatusPhotoView
-(void)setPhoto:(WBPhoto *)photo{
    _photo = photo;
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    if ([photo.thumbnail_pic hasSuffix:@"gif"]) {
        self.gifView.hidden = NO;
    }else self.gifView.hidden = YES;
}
-(UIImageView *)gifView{
    if (_gifView == nil) {
        _gifView = [[UIImageView alloc]init];
         _gifView.size = CGSizeMake(27, 20);
        _gifView.x = self.width - _gifView.width;
        _gifView.y = self.height - _gifView.height;
        _gifView.image = [UIImage imageNamed:@"timeline_image_gif"];
        [self addSubview:_gifView];
    }
    return _gifView;
}
@end
