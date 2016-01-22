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
+(void)saveStatuses:(NSArray*)statuses;
@end
