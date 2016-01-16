//
//  WBEmotion.h
//  JW微博JW
//
//  Created by wangjianwei on 16/1/12.
//  Copyright © 2016年 JW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBEmotion : NSObject
/** 表情符号的中文简写*/
@property (nonatomic ,copy)NSString* chs;
/** 表情符号的png地址*/
@property (nonatomic ,copy)NSString* png;
/** emoji 的十六进制表示*/
@property (nonatomic ,copy)NSString* code;
-(BOOL)compare:(WBEmotion *)emotion;
@end
