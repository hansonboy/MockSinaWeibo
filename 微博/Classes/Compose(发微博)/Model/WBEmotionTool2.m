//
//  WBEmotionTool2.m
//  JW微博JW
//
//  Created by wangjianwei on 16/1/15.
//  Copyright © 2016年 JW. All rights reserved.
//

#import "WBEmotionTool2.h"
#define kRecentEmotionsFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"recentEmotions.archiver"]
static NSMutableArray *_emotions;
@implementation WBEmotionTool2
//只有在类加载的时候调用一次
+(void)initialize{
    if (self == [WBEmotionTool2 self]){//防止在子类调用的时候也调用一次
        _emotions = [NSKeyedUnarchiver unarchiveObjectWithFile:kRecentEmotionsFile];
        if (_emotions == nil) {
            _emotions = [NSMutableArray array];
        }
    }
}
-(void)saveEmotion:(WBEmotion *)emotion{
    //先删除掉原来的，该方法会调用isEqual:方法来判断相等的是哪一个，WBEmotion的isEqual:方法已经重写，如果内容相同那么返回结果
    [_emotions removeObject:emotion];
    [_emotions insertObject:emotion atIndex:0];
}
-(NSArray*)emotions{
    return _emotions;
}
-(void)sync{
    [NSKeyedArchiver archiveRootObject:self.emotions toFile:kRecentEmotionsFile];
}
@end
