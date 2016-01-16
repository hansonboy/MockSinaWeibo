//
//  WBEmotionTool.m
//  JW微博JW
//
//  Created by wangjianwei on 16/1/14.
//  Copyright © 2016年 JW. All rights reserved.
// 该单例模式并不是成功的单例模式，因为还可以调用[【WBEmotionTool alloc]init]方法进行初始化

#import "WBEmotionTool.h"
#import "WBEmotion.h"

@implementation WBEmotionTool
-(NSMutableArray *)emotions{
    if (_emotions == nil) {
        _emotions = [NSKeyedUnarchiver unarchiveObjectWithFile:[self emotionsDir]];
        if (_emotions == nil) {
            _emotions = [NSMutableArray array];
        }
    }
    return _emotions;
}
+(WBEmotionTool *)sharedEmotionTool{
    static WBEmotionTool *sharedEmotionTool = nil;
    @synchronized([WBEmotionTool class]) {
        if (!sharedEmotionTool) {
            sharedEmotionTool = [[self alloc]init];
        }
    }
    return sharedEmotionTool;
}
-(id)copyWithZone:(NSZone*)zone{
      return self;
}
-(void)saveEmotion:(WBEmotion *)emotion{
    BOOL __block isContained = NO;
    //存在Emotion值相同，但是地址有可能不同
    WBEmotion __block *tmpEmotion  = nil;
    [self.emotions enumerateObjectsUsingBlock:^(WBEmotion *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj compare:emotion]) {
            isContained = YES ;
            tmpEmotion = obj;
        }
    }];
    if (isContained) {
        [self.emotions removeObject:tmpEmotion];
    }
    [self.emotions insertObject:emotion atIndex:0];
}
-(void)sync{
    [NSKeyedArchiver archiveRootObject:self.emotions toFile:[self emotionsDir]];
}
-(NSString*)emotionsDir{
    NSString *documentDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    return  [documentDir stringByAppendingPathComponent:@"recentEmotions.archiver"];
}
@end
