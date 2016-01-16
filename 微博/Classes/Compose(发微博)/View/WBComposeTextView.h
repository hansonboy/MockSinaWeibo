//
//  WBComposeTextView.h
//  JW微博JW
//
//  Created by wangjianwei on 15/12/30.
//  Copyright © 2015年 JW. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WBEmotion;
#define kWBPlaceHolderX 5
#define kWBPlaceHolderY 8
@interface WBComposeTextView : UITextView
@property (nonatomic ,copy) NSString *placeholder;
-(NSString*)fullText;
-(void)insertEmotion:(WBEmotion*)emotion;
@end
