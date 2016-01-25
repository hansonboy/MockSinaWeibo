//
//  NSString+Extension.m
//  JW微博JW
//
//  Created by wangjianwei on 15/12/22.
//  Copyright © 2015年 JW. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
/**
 *  返回目录的整体大小，单位是MB
 */
-(CGFloat)fileSize{
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    CGFloat length = 0;
    NSError *error = nil;
    if (![manager fileExistsAtPath:self isDirectory:&isDir]) {
        return 0;
    }
    if (!isDir) {
        NSDictionary *attri =[manager attributesOfItemAtPath:self error:nil];
        return [attri[NSFileSize] integerValue]/1000.0/1000.0;
    }else{
        for (NSString *subPath in [manager subpathsOfDirectoryAtPath:self error:&error]) {
            if (error) {
                NSLog(@"%@",error.localizedDescription);
                return 0;
            }
            NSString * filepath = [self stringByAppendingPathComponent:subPath];
            if ([manager fileExistsAtPath:filepath isDirectory:&isDir]) {
                if (!isDir) {
                    NSDictionary *attri =[manager attributesOfItemAtPath:filepath error:nil];
                    length += [attri[NSFileSize] integerValue]/1000.0/1000.0;
                }
            }
        }
        return length;
    }
}
@end
