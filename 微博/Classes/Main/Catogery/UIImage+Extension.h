//
//  UIImage+Extension.h
//  JW微博JW
//
//  Created by wangjianwei on 16/1/12.
//  Copyright © 2016年 JW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
/**用来修正方向，照相机找出的照片经过处理后会丢失方向信息的，如果传给别人，将会收到有旋转角度的照片*/
-(UIImage *)fixOrientationImage;
/** 拉伸图片来进行自适应*/
-(UIImage*)stretchableImage;
@end
