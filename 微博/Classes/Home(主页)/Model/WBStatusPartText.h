//
//  WBStatusPartText.h
//  JW微博JW
//
//  Created by wangjianwei on 16/1/18.
//  Copyright © 2016年 JW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBStatusPartText : NSObject
/** 特殊文本的内容*/
@property (nonatomic ,copy) NSString *text;
/** 特殊文本的范围*/
@property (nonatomic ,assign) NSRange range;
/**是否是特殊文本*/
@property (nonatomic ,assign,getter=isSpecial)BOOL special;
/**是否是特殊表情*/
@property (nonatomic ,assign,getter=isEmotion)BOOL emotion;

+(instancetype)partWithText:(NSString*)text range:(NSRange)range;
@end
