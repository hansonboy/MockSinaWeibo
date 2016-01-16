//
//  WBEmotionButton.m
//  JW微博JW
//
//  Created by wangjianwei on 16/1/14.
//  Copyright © 2016年 JW. All rights reserved.
//

#import "WBEmotionButton.h"
#include "WBEmotion.h"
#define kEmojiFont 32
@implementation WBEmotionButton
-(void)setEmotion:(WBEmotion *)emotion{
    _emotion = emotion;
    if (emotion.png) {
        [self setImage:[[UIImage imageNamed:emotion.png] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    }else if(emotion.code){
        [self setTitle:emotion.code.emoji forState:UIControlStateNormal];
    }
     self.titleLabel.font = [UIFont systemFontOfSize:kEmojiFont];
}
@end
