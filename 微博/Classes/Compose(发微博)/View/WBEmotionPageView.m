//
//  WBEmotionPageView.m
//  JW微博JW
//
//  Created by wangjianwei on 16/1/13.
//  Copyright © 2016年 JW. All rights reserved.
//  用来表示每页pageView中包含的表情（1~20个）

#import "WBEmotionPageView.h"
#import "WBEmotion.h"
#import "WBEmotionPopView.h"
#import "WBEmotionButton.h"
#define kInsets 10
@interface WBEmotionPageView()
@property (strong,nonatomic)WBEmotionPopView *popView;
@end
@implementation WBEmotionPageView
-(WBEmotionPopView *)popView{
    if (_popView == nil) {
        _popView = [WBEmotionPopView emotionPopView];
    }
    return _popView;
}
-(void)setEmotions:(NSArray *)emotions{
    _emotions = emotions;
    for (WBEmotion *emotion in emotions) {
        WBEmotionButton *btn = [[WBEmotionButton alloc]init];
        btn.emotion = emotion;
        [btn addTarget:self action:@selector(btnTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    if (emotions) {
        UIButton *backSpaceBtn = [[UIButton alloc]init];
        [backSpaceBtn setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [backSpaceBtn setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [self addSubview:backSpaceBtn];
        [backSpaceBtn addTarget:self action:@selector(backSpaceBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)]];
    }
    
    
}

#pragma mark - view liefCycle
-(void)layoutSubviews{
    [super layoutSubviews];
//    JWLog(@"%@",NSStringFromCGRect(self.frame));
    NSUInteger count = self.subviews.count;
    CGFloat w = (self.width - 2*kInsets)/kMaxColCount;
    CGFloat h = (self.height - kInsets)/kMaxRowCount;
    for (NSUInteger i = 0; i < count; i++) {
        UIView *view = self.subviews[i];
        view.x = kInsets + (i%kMaxColCount) * w;
        view.y = kInsets + (i/kMaxColCount) * h;
        view.width = w;
        view.height = h;
    }
}
#pragma mark 监听方法
-(void)longPress:(UILongPressGestureRecognizer*)gesture{
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateChanged:
        {
            [self buttonContainTouch:gesture WithBlock:^(WBEmotionButton *button){
                [self.popView showFromButton:button];
            }];
            break;
            
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
           
            [self buttonContainTouch:gesture WithBlock:^(WBEmotionButton * button) {
                   [self btnTouchUpInside:button];
            }];
            [self.popView removeFromSuperview];
            break;
        }
        default:
            break;
    }
}
-(void)buttonContainTouch:(UILongPressGestureRecognizer*)gesture WithBlock:(void(^)(WBEmotionButton*))action{
    CGPoint location = [gesture locationInView:self];
    for (NSUInteger i= 0; i < self.subviews.count -1;i++) {
        WBEmotionButton *button = self.subviews[i];
        if(CGRectContainsPoint(button.frame, location)){
            if (action) {
                action(button);
            }
            break;
        }
    }
}
-(void)backSpaceBtnClick{
    [kNotificationCenter postNotificationName:WBEmotionBackSpaceButtonClickNotification object:nil];
}
-(void)btnTouchUpInside:(WBEmotionButton*)btn{
    [self.popView showFromButton:btn];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popView removeFromSuperview];
    });
    [kNotificationCenter postNotificationName:WBEmotionButtonDidClickNotification object:nil userInfo:@{WBEmotionButtonUserInfoKey:btn.emotion}];
    
}

@end
