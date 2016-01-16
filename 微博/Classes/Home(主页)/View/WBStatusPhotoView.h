//
//  WBStatusPhotoView.h
//  JW微博JW
//
//  Created by wangjianwei on 15/12/25.
//  Copyright © 2015年 JW. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kStatusPhotoViewGifScale 0.6
@class WBPhoto;
@interface WBStatusPhotoView : UIImageView
@property (strong,nonatomic)WBPhoto *photo;
@end
