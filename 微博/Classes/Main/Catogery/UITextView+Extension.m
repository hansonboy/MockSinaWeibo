//
//  UITextView+Extension.m
//  JW微博JW
//
//  Created by wangjianwei on 16/1/14.
//  Copyright © 2016年 JW. All rights reserved.
//

#import "UITextView+Extension.h"

@implementation UITextView (Extension)
-(void)insertAttributedText:(NSAttributedString *)attriText completion:(void(^)(NSMutableAttributedString * attributedText))completion{
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithAttributedString:self.attributedText];
    [attri replaceCharactersInRange:self.selectedRange withAttributedString:attriText];
    if (completion) {
        completion(attri);
    }
    self.attributedText = attri;
}
@end
