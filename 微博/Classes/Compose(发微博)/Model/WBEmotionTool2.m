//
//  WBEmotionTool2.m
//  JW微博JW
//
//  Created by wangjianwei on 16/1/15.
//  Copyright © 2016年 JW. All rights reserved.
//

#import "WBEmotionTool2.h"
#define kRecentEmotionsFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"recentEmotions.archiver"]
static NSMutableArray *_recentEmotions;
static NSArray *_defaultEmotions;
static NSArray *_lxhEmotions;
static NSArray *_emojiEmotions;
@implementation WBEmotionTool2
//只有在类加载的时候调用一次
+(void)initialize{
    if (self == [WBEmotionTool2 self]){//防止在子类调用的时候也调用一次
        _recentEmotions = [NSKeyedUnarchiver unarchiveObjectWithFile:kRecentEmotionsFile];
        if (_recentEmotions == nil) {
            _recentEmotions = [NSMutableArray array];
        }
    }
}
+(void)saveEmotion:(WBEmotion *)emotion{
    //先删除掉原来的，该方法会调用isEqual:方法来判断相等的是哪一个，WBEmotion的isEqual:方法已经重写，如果内容相同那么返回结果
    [_recentEmotions removeObject:emotion];
    [_recentEmotions insertObject:emotion atIndex:0];
}
+(NSArray*)recentEmotions{
    return _recentEmotions;
}
+(void)sync{
    [NSKeyedArchiver archiveRootObject:self.recentEmotions toFile:kRecentEmotionsFile];
}
+(NSArray *)defaultEmotions{
    if (_defaultEmotions == nil) {
        _defaultEmotions = [WBEmotion mj_objectArrayWithFilename:@"EmotionIcons/default/info.plist"];
    }
    return _defaultEmotions;
}
+(NSArray *)lxhEmotions{
    if (_lxhEmotions == nil) {
        _lxhEmotions = [WBEmotion mj_objectArrayWithFilename:@"EmotionIcons/lxh/info.plist"];
    }
    return _lxhEmotions;
}
+(NSArray *)emojEmotions{
    if (_emojiEmotions == nil) {
        _emojiEmotions = [WBEmotion mj_objectArrayWithFilename:@"EmotionIcons/emoji/info.plist"];
        
    }
    return _emojiEmotions;
}
+(UIImage *)pngWithChs:(NSString *)chs{
    NSString * __block png;
    [[self defaultEmotions] enumerateObjectsUsingBlock:^(WBEmotion* emotion, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([emotion.chs isEqualToString:chs]) {
            png = emotion.png;
            *stop = YES;
        }
    }];
    [[self lxhEmotions] enumerateObjectsUsingBlock:^(WBEmotion* emotion, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([emotion.chs isEqualToString:chs]) {
            png = emotion.png;
            *stop = YES;
        }
    }];
    return [UIImage imageNamed:png];
}
@end
