//
//  WBEmotionTool2.h
//  JW微博JW
//
//  Created by wangjianwei on 16/1/15.
//  Copyright © 2016年 JW. All rights reserved.
//  使用+initialize  和static 相结合的方法来代替单例模式，比较简洁

#import <Foundation/Foundation.h>
#import "WBEmotion.h"
@interface WBEmotionTool2 : NSObject
+(NSArray*)recentEmotions;
+(NSArray*)defaultEmotions;
+(NSArray*)lxhEmotions;
+(NSArray*)emojEmotions;
/**
 *  @param chs 图片简介
 *
 *  @return 图片名称
 */
+(UIImage*)pngWithChs:(NSString*)chs;
+(void)saveEmotion:(WBEmotion*)emotion;
+(void)sync;
@end
