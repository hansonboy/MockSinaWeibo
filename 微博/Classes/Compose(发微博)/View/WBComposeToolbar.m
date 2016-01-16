//
//  WBComposeToolbar.m
//  JW微博JW
//
//  Created by wangjianwei on 15/12/30.
//  Copyright © 2015年 JW. All rights reserved.
//

#import "WBComposeToolbar.h"
@interface WBComposeToolbar()<WBComposeToolbarDelegate>

@end
@implementation WBComposeToolbar
+(instancetype)toolbar{
    return [[self alloc]init];
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        [self addBtnWithImage:[UIImage imageNamed:@"compose_toolbar_picture"] highlightedImage:[UIImage imageNamed:@"compose_toolbar_picture_highlighted"] tag:WBComposeToolbarButtonTypePic];
        [self addBtnWithImage:[UIImage imageNamed:@"compose_mentionbutton_background"] highlightedImage:[UIImage imageNamed:@"compose_mentionbutton_background_highlighted"] tag:WBComposeToolbarButtonTypeMention];
        [self addBtnWithImage:[UIImage imageNamed:@"compose_camerabutton_background"] highlightedImage:[UIImage imageNamed:@"compose_camerabutton_background_highlighted"] tag:WBComposeToolbarButtonTypeCarmera];
        [self addBtnWithImage:[UIImage imageNamed:@"compose_emoticonbutton_background"] highlightedImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] tag:WBComposeToolbarButtonTypeEmotion];
        [self addBtnWithImage:[UIImage imageNamed:@"compose_trendbutton_background"] highlightedImage:[UIImage imageNamed:@"compose_trendbutton_background_highlighted"] tag:WBComposeToolbarButtonTypeTrend];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    NSUInteger count = self.subviews.count;
    CGFloat btnW = self.width/count;
    CGFloat btnH = self.height;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    for (NSUInteger i = 0; i < count; i ++) {
        UIButton *btn = self.subviews[i];
        btnX = i*btnW;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
}
-(void)addBtnWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage tag:(NSUInteger)tag{
    UIButton *btn  = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.backgroundColor = [UIColor redColor];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highlightedImage forState:UIControlStateHighlighted];
    btn.tag = tag;
    [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
}
-(void)clickBtn:(UIButton*)btn{
    if ([self.delegate respondsToSelector:@selector(composeToolBar:didClickBtn:)]) {
        [self.delegate composeToolBar:self didClickBtn:btn];
    }
}
-(void)setShowSystemKeyboard:(BOOL)showSystemKeyboard{
    _showSystemKeyboard  = showSystemKeyboard;
    if (showSystemKeyboard) {
        UIButton *btn = [self viewWithTag:WBComposeToolbarButtonTypeEmotion];
        [btn setImage:[UIImage imageNamed:@"compose_keyboardbutton_background"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"compose_keyboardbutton_background_highlighted"] forState:UIControlStateHighlighted];
    }else{
        UIButton *btn = [self viewWithTag:WBComposeToolbarButtonTypeEmotion];
        [btn setImage:[UIImage imageNamed:@"compose_emoticonbutton_background"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] forState:UIControlStateHighlighted];
    }
 
}
@end
