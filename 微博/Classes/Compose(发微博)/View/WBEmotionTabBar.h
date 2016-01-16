//
//  WBEmotionTabBar.h
//  JW微博JW
//
//  Created by wangjianwei on 16/1/12.
//  Copyright © 2016年 JW. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    WBEmotionTabBarButtonTypeRecent = 0,
    WBEmotionTabBarButtonTypeDefault,
    WBEmotionTabBarButtonTypeEmoji,
    WBEmotionTabBarButtonTypeLxh
}WBEmotionTabBarButtonType;
@class WBEmotionTabBar;
@protocol WBEmotionTabBarDelegate<NSObject>
-(void)emotionTabbar:(WBEmotionTabBar*)tabbar didSelectButton:(WBEmotionTabBarButtonType)type;
@end
@interface WBEmotionTabBar : UIView
@property (weak,nonatomic)id<WBEmotionTabBarDelegate> delegate;
@end
