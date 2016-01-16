//
//  WBEmotionPopView.h
//  JW微博JW
//
//  Created by wangjianwei on 16/1/14.
//  Copyright © 2016年 JW. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WBEmotion;
@class WBEmotionButton;
@interface WBEmotionPopView : UIView
@property (strong,nonatomic)WBEmotion *emotion;
+(instancetype)emotionPopView;
-(void)showFromButton:(WBEmotionButton*)button;
@end
