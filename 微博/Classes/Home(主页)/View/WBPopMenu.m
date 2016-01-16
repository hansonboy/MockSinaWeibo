//
//  WBPopMenu.m
//  微博
//
//  Created by wangjianwei on 15/12/10.
//  Copyright (c) 2015年 JW. All rights reserved.
//

#import "WBPopMenu.h"
@interface WBPopMenu()<WBPopMenuDelegate>

@property (weak,nonatomic)UIWindow *foregroundWIndow;

@property (strong,nonatomic)UIImageView *contentView;

@end
@implementation WBPopMenu
-(UIWindow *)foregroundWIndow{
    if (_foregroundWIndow == nil) {
        _foregroundWIndow = [UIApplication sharedApplication].windows.lastObject;
    }
    return _foregroundWIndow;
}
-(UIImageView *)contentView{
    if (_contentView == nil) {
        _contentView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"popover_background"]];
        _contentView.userInteractionEnabled = YES;
        [self addSubview:_contentView];
    }
    return _contentView;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)showFrom:(UIView *)view{
    
    CGRect newRect = [view convertRect:view.bounds toView:self.foregroundWIndow];
    CGFloat containerViewX = CGRectGetMidX(newRect) - self.contentView.bounds.size.width * 0.5;
    CGFloat containerViewY = CGRectGetMaxY(newRect);
    self.contentView.origin = (CGPoint){containerViewX,containerViewY};
    if ([self.delegate respondsToSelector:@selector(popMenuWillShow:)]) {
        [self.delegate popMenuWillShow:self];
    }
    
    [self.foregroundWIndow addSubview:self];
}
+(instancetype)menu{
    return [[self alloc]init];
}
-(void)setContent:(UIView *)content{
    _content = content;
    self.contentView.size = (CGSize){content.width+20,content.height+30};
    content.x = 10;
    content.y = 17;
    [self.contentView addSubview:content];
}
+(instancetype)menuWithSubview:(UIView *)view{
    WBPopMenu *menu = [WBPopMenu menu];
    menu.content = view;
    return menu;
}
-(void)setContentController:(UIViewController *)contentController{
    _contentController = contentController;
    self.content = contentController.view;
}
+(instancetype)menuWithController:(UIViewController *)controller{
    WBPopMenu *menu = [WBPopMenu menu];
    menu.contentController = controller;
    return menu;
}
-(void)dissmiss{
    if ([self.delegate respondsToSelector:@selector(popMenuDidDismiss:)]) {
        [self.delegate popMenuDidDismiss:self];
    }
    [self removeFromSuperview];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self dissmiss];
}
@end
