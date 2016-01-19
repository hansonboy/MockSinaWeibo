//
//  WBStatus.m
//  JW微博JW
//
//  Created by wangjianwei on 15/12/17.
//  Copyright © 2015年 JW. All rights reserved.
//

#import "WBStatus.h"
#import "WBPhoto.h"
#import "WBUser.h"
#import "WBStatusPartText.h"
#import "WBEmotionTool2.h"
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

-(void)setText:(NSString *)text{
    _text = text;
    _attributedText = [self attributedTextWithText:text font:kStatusCellContentTextFont];
}
/**
 *  用text 初始化attributedText
 */
-(NSAttributedString*)attributedTextWithText:(NSString*)text font:(UIFont*)font{
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]init];
    
    NSString *emotionPattern = @"\\[[\\w]*\\]";
    NSString *atPattern = @"@[\\w-]+";
    NSString *topicPattern = @"#[\\w-，,]+#";
    NSString *urlPattern = @"(http|ftp|https):\\/\\/[\\w\\-_]+(\\.[\\w\\-_]+)+([\\w\\-\\.,@?^=%&amp;:/~\\+#]*[\\w\\-\\@?^=%&amp;/~\\+#])?";
    NSString *pattern = [NSString stringWithFormat:@"%@|%@|%@|%@",topicPattern,emotionPattern,atPattern,urlPattern];
    JWLog(@"text:%@",text);
    NSMutableArray * parts  = [NSMutableArray array];
    //取出所有特殊字符串,放入到parts
    [text enumerateStringsMatchedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        JWLog(@"special:%@-%@",*capturedStrings,NSStringFromRange(*capturedRanges));
        WBStatusPartText *part = [WBStatusPartText partWithText: *capturedStrings range:*capturedRanges];
        part.special = YES;
        if ([*capturedStrings hasPrefix:@"["] && [*capturedStrings hasSuffix:@"]"]) {
            part.emotion = YES;
        }
        [parts addObject:part];
        
    }];
   //取出所有正常字符串,放入到parts
    [text enumerateStringsSeparatedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        JWLog(@"Normal:%@-%@",*capturedStrings,NSStringFromRange(*capturedRanges));
        [parts addObject:[WBStatusPartText partWithText:*capturedStrings range:*capturedRanges]];
    }];
    
    [parts sortUsingComparator:^NSComparisonResult(WBStatusPartText * part1, WBStatusPartText * part2) {
        if(part1.range.location < part2.range.location)return NSOrderedAscending;
        else return NSOrderedDescending;
    }];
    
    for (NSUInteger i  = 0; i < parts.count; i++) {
        WBStatusPartText * part  = parts[i];
        if (part.isSpecial) {
            if (part.isEmotion) {
                NSTextAttachment *attach = [[NSTextAttachment alloc]init];
                attach.image = [kWBEmotionTool2 pngWithChs:part.text];
                if (attach.image) {
                    attach.bounds = CGRectMake(-3, 0,kStatusCellContentTextFont.lineHeight , kStatusCellContentTextFont.lineHeight);
                    [attributedText appendAttributedString:[NSAttributedString attributedStringWithAttachment:attach]];
                }else{
                    NSRange range = NSMakeRange(attributedText.length, part.text.length);
                    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:part.text]];
                    [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:range];
                }
            }else{
                NSRange range = NSMakeRange(attributedText.length, part.text.length);
                [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:part.text]];
                [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:range];
            }
        }else{
            [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:part.text]];
        }
    }
    [attributedText addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, attributedText.length)];
    return attributedText;
}
-(void)setRetweeted_status:(WBStatus *)retweeted_status{
    _retweeted_status = retweeted_status;
    NSString *retweetText = [NSString stringWithFormat:@"@%@:%@",retweeted_status.user.screen_name,retweeted_status.text];
    _retweetedAttributedText = [self attributedTextWithText:retweetText font:kStatusCellRetweetContentTextFont];
}
@end
