//
//  WBComposeToolbar.h
//  JW微博JW
//
//  Created by wangjianwei on 15/12/30.
//  Copyright © 2015年 JW. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger,WBComposeToolbarButtonType){
    WBComposeToolbarButtonTypePic,
    WBComposeToolbarButtonTypeCarmera,
    WBComposeToolbarButtonTypeEmotion,
    WBComposeToolbarButtonTypeTrend,
    WBComposeToolbarButtonTypeMention
};
@class WBComposeToolbar;
@protocol WBComposeToolbarDelegate<NSObject>
@optional
-(void)composeToolBar:(WBComposeToolbar*)toolbar didClickBtn:(UIButton*)btn;
@end
@interface WBComposeToolbar : UIView
@property (weak,nonatomic)id<WBComposeToolbarDelegate> delegate;
@property (nonatomic ,assign)BOOL showSystemKeyboard;
+(instancetype)toolbar;
//-(void)addBtnWithImage:(UIImage*)image highlightedImage:(UIImage*)highlightedImage tag:(NSUInteger)tag;
@end
