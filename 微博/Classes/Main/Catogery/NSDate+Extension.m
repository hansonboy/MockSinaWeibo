//
//  NSDate+Extension.m
//  JW微博JW
//
//  Created by wangjianwei on 15/12/24.
//  Copyright © 2015年 JW. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)
-(BOOL)isThisYear{
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy";
    NSString *dateStr  = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:now];
    if ([dateStr isEqualToString:nowStr]) {
        return YES;
    }
    return NO;
}
-(BOOL)isYestoday{
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat =@"yyyy-MM-dd";
    NSString *dateStr = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:now];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    NSDateComponents *cmpts = [calendar components:unit fromDate:[fmt dateFromString:dateStr] toDate:[fmt dateFromString:nowStr] options:NSCalendarWrapComponents];
    if (cmpts.year == 0&& cmpts.month == 0 && cmpts.day == 1) {
        return YES;
    }
    return NO;
}
-(BOOL)isToday{
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat =@"yyyy-MM-dd";
    NSString *dateStr = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:now];
    if ([dateStr isEqualToString:nowStr]) {
        return YES;
    }
    return NO;
}
@end
