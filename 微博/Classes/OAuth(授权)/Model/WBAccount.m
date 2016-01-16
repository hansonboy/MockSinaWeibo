//
//  WBAccount.m
//  JW微博JW
//
//  Created by wangjianwei on 15/12/17.
//  Copyright © 2015年 JW. All rights reserved.
//

#import "WBAccount.h"

@implementation WBAccount

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        [self mj_decode:decoder];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    _create_date = [NSDate date];
    [self mj_encode:encoder];
}
+(NSArray *)mj_ignoredPropertyNames{
    return @[];
}
@end
