//
//  WBEmotionTabBar.m
//  JW微博JW
//
//  Created by wangjianwei on 16/1/12.
//  Copyright © 2016年 JW. All rights reserved.
//

#import "WBEmotionTabBar.h"


@implementation WBEmotionTabBar
#pragma mark - View LifeCycle
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addBtn:@"最近" withButtonType:WBEmotionTabBarButtonTypeRecent];
        [self addBtn:@"默认" withButtonType:WBEmotionTabBarButtonTypeDefault];
        [self addBtn:@"Emoji" withButtonType:WBEmotionTabBarButtonTypeEmoji];
        [self addBtn:@"浪小花" withButtonType:WBEmotionTabBarButtonTypeLxh];
        [(WBButton*)[self viewWithTag:WBEmotionTabBarButtonTypeDefault] setEnabled:NO];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    NSUInteger count = self.subviews.count;
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = self.width/count;
    CGFloat h = self.height;
    for (NSUInteger i = 0; i < count; i++) {
        UIView *view = self.subviews[i];
        x = i * w;
        view.x = x;
        view.y = y;
        view.width = w;
        view.height = h;
    }
}
#pragma mark others
-(void)addBtn:(NSString*)name withButtonType:(WBEmotionTabBarButtonType)type{
    WBButton * btn =  [[WBButton alloc]init];
    btn.tag = type;
    [btn setTitle:name forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
    
    btn.titleLabel.font = [UIFont systemFontOfSize:15];

    NSString *image = @"compose_emotion_table_mid_normal";
    NSString *disabledImage = @"compose_emotion_table_mid_selected";
    if (self.subviews.count == 0) {
       image = @"compose_emotion_table_mid_normal";
       disabledImage = @"compose_emotion_table_mid_selected";
    }else if(self.subviews.count == 3){
       image = @"compose_emotion_table_mid_normal";
       disabledImage = @"compose_emotion_table_mid_selected";
    }
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchDown];
    [btn setBackgroundImage:[[UIImage imageNamed:image]stretchableImage] forState:UIControlStateNormal];
    [btn setBackgroundImage:[[UIImage imageNamed:disabledImage]stretchableImage] forState:UIControlStateDisabled];
    
    [self addSubview:btn];
}
#pragma mark -  动作方法
-(void)click:(WBButton*)btn{
    for (WBButton*btn in self.subviews) {
        btn.enabled  = YES;
    }
    btn.enabled = NO;
    if ([self.delegate respondsToSelector:@selector(emotionTabbar:didSelectButton:)]) {
        [self.delegate emotionTabbar:self didSelectButton:btn.tag];
    }
}

@end
