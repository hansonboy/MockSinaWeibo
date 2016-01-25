//
//  WBStatusTool.h
//  JW微博JW
//
//  Created by wangjianwei on 16/1/22.
//  Copyright © 2016年 JW. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WBStatus;
@interface WBStatusTool : NSObject
+(NSArray*)loadOldStatusesByMaxStatus:(WBStatus*)status;
+(NSArray*)loadNewStatusesByMinStatus:(WBStatus*)status;
/**
 *  保存的数组是从网络中获取到的关于status的键值对，方便后面的操作，整体要简单些。
 *  @param statuses statuses 是从网络上获取的原生键值对数组，而不是对象数组。
 */
+(void)saveStatuses:(NSArray*)statuses;
@end
