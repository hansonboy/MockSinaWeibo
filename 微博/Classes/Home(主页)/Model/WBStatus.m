//
//  WBStatus.m
//  JW微博JW
//
//  Created by wangjianwei on 15/12/17.
//  Copyright © 2015年 JW. All rights reserved.
//

#import "WBStatus.h"
#import "WBPhoto.h"
@implementation WBStatus

+(NSDictionary *)mj_objectClassInArray{
    return @{@"pic_urls":[WBPhoto class]};
}

+(NSArray *)mj_ignoredCodingPropertyNames{
    return @[];
}
MJCodingImplementation
-(NSString *)created_at{
//    return _created_at;
    NSString *dateStr = _created_at;
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
    formatter.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    NSDate *date = [formatter dateFromString:dateStr];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    calendar.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
    NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
    NSDate * now = [NSDate date];
    NSDateComponents *components = [calendar components:unit fromDate:date toDate:now options:NSCalendarWrapComponents];
    
    if([date isThisYear]){
        
        if ([date isYestoday]) {
            /**
             *   2> 昨天
             *  昨天 HH:mm
             */
            formatter.dateFormat = @"HH:mm";
            dateStr = [NSString stringWithFormat:@"昨天%@",[formatter stringFromDate:date]];
        }else{
            if ([date isToday]) {
                /**
                 *
                 1> 今天
                 *1分钟内 ： 刚刚
                 *1分~59分： XX分钟前
                 *大于60分： XX小时前
                 */
                if (components.hour == 0 && components.minute == 0) {
                    dateStr = [NSString stringWithFormat:@"刚刚"];
                }
                if (components.hour ==0 && components.minute != 0) {
                    dateStr = [NSString stringWithFormat:@"%ld分钟前",components.minute];
                }
                if (components.hour != 0) {
                    dateStr = [NSString stringWithFormat:@"%ld小时前",components.hour];
                }
            }else{
                /**
                 *
                 3> 其他
                 MM-dd HH:mm
                 */
                formatter.dateFormat = @"MM-dd HH:mm";
                dateStr = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
            }
            
        }
    }else{
        // 非今年
        // *yyyy-MM-dd HH:mm
        formatter.dateFormat = @"yyyy-MM-dd HH:mm";
        dateStr = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    }
    return dateStr;
}

-(void)setSource:(NSString *)source{
//    _source = source;
//    return;
    NSRange firstRange = [source rangeOfString:@"\">"];
    NSRange lastRange = [source rangeOfString:@"</"];
    if (firstRange.location != NSNotFound && lastRange.location != NSNotFound) {
        NSRange sourceRange = NSMakeRange(firstRange.length+firstRange.location, lastRange.location-firstRange.length - firstRange.location);
        _source =  [NSString stringWithFormat:@"来自%@",[source substringWithRange:sourceRange]];
    }
    else _source = nil;
}

@end
