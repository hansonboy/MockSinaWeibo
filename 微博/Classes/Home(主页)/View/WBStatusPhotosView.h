//
//  WBStatusPhotosView.h
//  JW微博JW
//
//  Created by wangjianwei on 15/12/25.
//  Copyright © 2015年 JW. All rights reserved.
//用来表示配图整体

#import <UIKit/UIKit.h>
#define kStatusCellPhotosWH 76
#define kStatusCellPhotoMagin 5
#define kStatusCellPhotoMaxCol(count) ((count)==4?2:3)
@class WBStatus;
@interface WBStatusPhotosView : UIView
@property (strong,nonatomic)NSArray *photoUrls;
+(CGSize)sizeWithCount:(NSInteger)count;
@end
