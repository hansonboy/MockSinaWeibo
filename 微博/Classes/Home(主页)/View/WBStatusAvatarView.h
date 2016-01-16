//
//  WBStatusAvatarView.h
//  JW微博JW
//
//  Created by wangjianwei on 15/12/25.
//  Copyright © 2015年 JW. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kStatusAvaraPositionScale 0.8
#define kAvatarWH 50
#define kStatusAvatarBadgeWH 17
@class WBUser;
@interface WBStatusAvatarView : UIView
@property (strong,nonatomic)WBUser *user;
@end
