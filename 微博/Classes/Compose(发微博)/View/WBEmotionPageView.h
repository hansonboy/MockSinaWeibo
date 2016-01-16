//
//  WBEmotionPageView.h
//  JW微博JW
//
//  Created by wangjianwei on 16/1/13.
//  Copyright © 2016年 JW. All rights reserved.
//  用来表示每页pageView中包含的表情（1~20个）

#import <UIKit/UIKit.h>
#define kMaxColCount 7
#define kMaxRowCount 3
#define kMaxCountPerPage (kMaxColCount * kMaxRowCount - 1)
@interface WBEmotionPageView : UIView
@property (strong,nonatomic)NSArray *emotions;
@end
