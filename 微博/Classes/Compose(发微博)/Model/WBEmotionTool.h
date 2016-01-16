//
//  WBEmotionTool.h
//  JW微博JW
//
//  Created by wangjianwei on 16/1/14.
//  Copyright © 2016年 JW. All rights reserved.
// 

#import <Foundation/Foundation.h>
#import "WBEmotion.h"

@interface WBEmotionTool : NSObject
@property (strong,nonatomic)NSMutableArray *emotions;
+(WBEmotionTool *)sharedEmotionTool;
-(void)saveEmotion:(WBEmotion*)emotion;
-(void)sync;
@end
