//
//  WBEmotion.m
//  JW微博JW
//
//  Created by wangjianwei on 16/1/12.
//  Copyright © 2016年 JW. All rights reserved.
//

#import "WBEmotion.h"

@implementation WBEmotion
MJCodingImplementation
+(NSArray *)mj_ignoredCodingPropertyNames{
    return @[];
}
-(BOOL)compare:(WBEmotion *)object{
    return [self.chs isEqualToString:object.chs] || [self.code isEqualToString:object.code];
}

/**
 *  默认情况下： isEqual：方法内部的实现是比较内存地址，我们也可以修改让他们比较内部的内容是否相同
 *  isEqual： 方法 重写，将会影响nasarray -removeObject:方法的结果
 */
-(BOOL)isEqual:(WBEmotion*)object{
    return [self.chs isEqualToString:object.chs] || [self.code isEqualToString:object.code];
}
@end
