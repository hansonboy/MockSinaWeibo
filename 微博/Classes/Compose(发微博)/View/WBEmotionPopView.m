//
//  WBEmotionPopView.m
//  JW微博JW
//
//  Created by wangjianwei on 16/1/14.
//  Copyright © 2016年 JW. All rights reserved.
//

#import "WBEmotionPopView.h"
#import "WBEmotionButton.h"

@interface WBEmotionPopView()
/** 表情按钮*/
@property (weak, nonatomic) IBOutlet WBEmotionButton *emotionBtn;
@end

@implementation WBEmotionPopView
+(instancetype)emotionPopView{
   return  [[[NSBundle mainBundle]loadNibNamed:@"WBEmotionPopView" owner:nil options:nil] lastObject];
}
-(void)setEmotion:(WBEmotion *)emotion{
    _emotion = emotion;
    self.emotionBtn.emotion = emotion;
}
-(void)showFromButton:(WBEmotionButton *)button{
    UIWindow * window = [UIApplication sharedApplication].windows.lastObject;
    CGRect rect = [button convertRect:button.bounds toView:window];
    
    self.centerX = CGRectGetMidX(rect);
    self.y = CGRectGetMidY(rect) - self.height;
    self.emotion = button.emotion;
    [window addSubview:self];
}
@end
