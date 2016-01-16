//
//  WBEmotionAttachment.m
//  JW微博JW
//
//  Created by wangjianwei on 16/1/14.
//  Copyright © 2016年 JW. All rights reserved.
//

#import "WBEmotionAttachment.h"
#import "WBEmotion.h"
@implementation WBEmotionAttachment
-(void)setEmotion:(WBEmotion *)emotion{
    _emotion = emotion;
    self.image = [UIImage imageNamed:emotion.png];
}
@end
