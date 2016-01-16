//
//  UITextView+Extension.h
//  JW微博JW
//
//  Created by wangjianwei on 16/1/14.
//  Copyright © 2016年 JW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Extension)
-(void)insertAttributedText:(NSAttributedString *)attriText completion:(void(^)(NSMutableAttributedString * attributedText))completion;
@end
