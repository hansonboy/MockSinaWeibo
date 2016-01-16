//
//  LTButton.m
//  彩票
//
//  Created by wangjianwei on 15/12/7.
//  Copyright (c) 2015年 JW. All rights reserved.
//

#import "LTButton.h"
#define currentTitleFont ([UIFont systemFontOfSize:30])
@implementation LTButton

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
       
        _currentFont = currentTitleFont;
        self.titleLabel.font = self.currentFont;

        self.imageView.contentMode = UIViewContentModeCenter;
    }
    return self;
}
-(void)setCurrentFont:(UIFont *)currentFont{
    _currentFont = currentFont;
    self.titleLabel.font = currentFont;
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    
    CGFloat titleX = 0;
    CGFloat titleY = 0;
    
    CGSize size = [self.currentTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_currentFont} context:nil].size;
    titleX = (contentRect.size.width - size.width - self.currentImage.size.width -1)*0.5;
    return CGRectMake(titleX, titleY, size.width, contentRect.size.height);
}
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
   
   
    CGRect titleRect = [self titleRectForContentRect:contentRect];
    CGFloat imageW = self.currentImage.size.width;
    CGFloat imageX = CGRectGetMaxX(titleRect)+1;
    CGFloat imageY = 0;
    CGFloat imageH = contentRect.size.height;
    return CGRectMake(imageX, imageY, imageW, imageH);
}
-(void)setHighlighted:(BOOL)highlighted{
    
}

@end
