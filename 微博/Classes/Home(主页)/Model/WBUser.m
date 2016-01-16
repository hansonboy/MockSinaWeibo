//
//  WBUser.m
//  JW微博JW
//
//  Created by wangjianwei on 15/12/17.
//  Copyright © 2015年 JW. All rights reserved.
//

#import "WBUser.h"

@implementation WBUser

-(void)setMbtype:(int)mbtype{
    _mbtype = mbtype;
    _vip = _mbtype>2;
}
+(NSArray *)mj_ignoredCodingPropertyNames{
    return @[];
}
MJCodingImplementation
@end
