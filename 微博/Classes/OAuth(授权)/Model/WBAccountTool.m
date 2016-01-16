//
//  WBAccountTool.m
//  JW微博JW
//
//  Created by wangjianwei on 15/12/17.
//  Copyright © 2015年 JW. All rights reserved.
//

#import "WBAccountTool.h"

@implementation WBAccountTool
+(BOOL)saveAccount:(WBAccount *)account{

    return [NSKeyedArchiver archiveRootObject:account toFile:[self acountFilePath]];
}
+(WBAccount *)account{
    WBAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:[self acountFilePath]];
    NSDate *expireDate = [NSDate dateWithTimeInterval:account.expires_in sinceDate:account.create_date];
    NSComparisonResult result = [expireDate compare:[NSDate date]];
    if (result != NSOrderedDescending) return nil;
    else return account;
}
+(NSString*)acountFilePath{
    NSString *documentDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    return  [documentDir stringByAppendingPathComponent:@"Account.archiver"];
}
@end
