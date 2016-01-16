//
//  WBTabBar.h
//  微博
//
//  Created by wangjianwei on 15/12/10.
//  Copyright (c) 2015年 JW. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WBTabBar;
@protocol WBTabBarDelegate <UITabBarDelegate>

@optional
-(void)tabBarDidSelected:(WBTabBar*)tabBar;

@end
@interface WBTabBar : UITabBar
@property (weak,nonatomic)id<WBTabBarDelegate> delegate;
@end
