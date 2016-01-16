//
//  WBTabBar.m
//  微博
//
//  Created by wangjianwei on 15/12/10.
//  Copyright (c) 2015年 JW. All rights reserved.
//

#import "WBTabBar.h"
@interface WBTabBar()
@property (strong,nonatomic)UIButton *plusBtn;

@end
@implementation WBTabBar

-(UIButton *)plusBtn{
    if (_plusBtn == nil) {
        _plusBtn = [[UIButton alloc]init];
        
        [_plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button" ]forState:UIControlStateNormal];
        [_plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [_plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [_plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        [_plusBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_plusBtn];
    }
    return _plusBtn;
}
-(void)layoutSubviews{
    [super layoutSubviews];
//    JWLog(@"%d--%@",self.subviews.count,self.subviews);
    Class class = NSClassFromString(@"UITabBarButton");
    int index = 0;
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:class]) {
//            JWLog(@"%@",view);
            view.width = self.width/5;
            view.x = view.width * index;
            index++;
            if (index == 2) {
                self.plusBtn.width = view.width;
                self.plusBtn.height = view.height;
                self.plusBtn.x = view.width*2;
                self.plusBtn.y = 1;
                index++;
            }
        }
    }
}
-(void)clickBtn:(UIButton*)btn{
    if ([self.delegate respondsToSelector:@selector(tabBarDidSelected:)]) {
        [self.delegate tabBarDidSelected:self];
    }
}
@end
