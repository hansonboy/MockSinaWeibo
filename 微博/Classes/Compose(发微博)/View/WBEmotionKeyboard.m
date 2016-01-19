//
//  WBEmotionKeyboard.m
//  JW微博JW
//
//  Created by wangjianwei on 16/1/12.
//  Copyright © 2016年 JW. All rights reserved.
//

#import "WBEmotionKeyboard.h"
#import "WBEmotionTabBar.h"
#import "WBEmotionListView.h"
//#import "WBEmotionTool.h"
#import "WBEmotionTool2.h"
#define kTabbarH 37
@interface WBEmotionKeyboard()<WBEmotionTabBarDelegate>
/** 占位视图*/
@property (weak,nonatomic)UIView *contentView;
@property (strong,nonatomic)WBEmotionListView *defaultListView;
@property (strong,nonatomic)WBEmotionListView *recentListView;
@property (strong,nonatomic)WBEmotionListView *emojiListView;
@property (strong,nonatomic)WBEmotionListView *lxhListView;
@property (weak,nonatomic)WBEmotionTabBar *tabbar;
@end
@implementation WBEmotionKeyboard
#pragma mark - lazy load
-(WBEmotionListView *)defaultListView{
    if (_defaultListView == nil) {
        //这样设置是无效的，因为很有可能self.contentView.bounds 为空
//        _defaultListView = [[WBEmotionListView alloc]initWithFrame:self.contentView.bounds];
        _defaultListView = [[WBEmotionListView alloc]init];
        _defaultListView.emotions = [kWBEmotionTool2 defaultEmotions];
    }
    return _defaultListView;
}
-(WBEmotionListView *)recentListView{
    if (_recentListView == nil) {
        _recentListView = [[WBEmotionListView alloc]init];
    }
    _recentListView.emotions = [kWBEmotionTool2 recentEmotions];
//    JWLog(@"%@",_recentListView.emotions);
    return _recentListView;
}
-(WBEmotionListView *)lxhListView{
    if (_lxhListView == nil) {
        _lxhListView = [[WBEmotionListView alloc]init];
        _lxhListView.emotions = [kWBEmotionTool2 lxhEmotions];
    }
    return _lxhListView;
}
-(WBEmotionListView *)emojiListView{
    if (_emojiListView == nil) {
        _emojiListView = [[WBEmotionListView alloc]init];
        _emojiListView.emotions = [kWBEmotionTool2 emojEmotions];
    }
    return _emojiListView;
}
#pragma mark - view LifeCycle
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        WBEmotionTabBar * tabbar = [[WBEmotionTabBar alloc]init];
        tabbar.delegate = self;
        [self addSubview:tabbar];
        self.tabbar = tabbar;
        
        UIView * contentView = [[UIView alloc]init];
        contentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:contentView];
        self.contentView = contentView;
        
        [self emotionTabbar:nil didSelectButton:WBEmotionTabBarButtonTypeDefault];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.tabbar.width = self.width;
    self.tabbar.height = kTabBarH;
    self.tabbar.x = 0;
    self.tabbar.y = self.height - self.tabbar.height;
    
    self.contentView.x = self.contentView.y = 0;
    self.contentView.width = self.width;
    self.contentView.height = self.tabbar.y;
    
    self.defaultListView.frame = self.contentView.bounds;
    self.emojiListView.frame = self.contentView.bounds;
    self.recentListView.frame = self.contentView.bounds;
    self.lxhListView.frame = self.contentView.bounds;
}
#pragma mark WBEmotionTabBarDelegate
-(void)emotionTabbar:(WBEmotionTabBar *)tabbar didSelectButton:(WBEmotionTabBarButtonType)type{
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    switch (type) {
        case WBEmotionTabBarButtonTypeDefault:
            {
                [self.contentView addSubview:self.defaultListView];
                JWLog(@"default");
                break;
            }
        case WBEmotionTabBarButtonTypeEmoji:
            {
                [self.contentView addSubview:self.emojiListView];
               
                JWLog(@"Emoji");
                break;
            }
        case WBEmotionTabBarButtonTypeLxh:
            {
             
                [self.contentView addSubview:self.lxhListView];
                JWLog(@"Lxh");
                break;
            }
        case WBEmotionTabBarButtonTypeRecent:
            {
                [self.contentView addSubview:self.recentListView];
                JWLog(@"Recent");
                break;
            }
        default:
            break;
    }
}

@end
