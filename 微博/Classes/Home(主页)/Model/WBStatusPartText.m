//
//  WBStatusSpeicalText.m
//  JW微博JW
//
//  Created by wangjianwei on 16/1/18.
//  Copyright © 2016年 JW. All rights reserved.
//

#import "WBStatusPartText.h"

@implementation WBStatusPartText
+(instancetype)partWithText:(NSString *)text range:(NSRange)range{
    WBStatusPartText *part = [[self alloc]init];
    part.text = text;
    part.range =range;
    return  part;
}
@end
