//
//  WBStatusTextView.m
//  JW微博JW
//
//  Created by wangjianwei on 16/1/19.
//  Copyright © 2016年 JW. All rights reserved.
//

#import "WBStatusTextView.h"
#import "WBStatus.h"
#import "WBStatusSelectedBackgroundView.h"
NSUInteger const kStatusTextViewBackgroundViewTag  = 999;

extern NSString * const kStatusSpecialtextRanges;
@implementation WBStatusTextView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.editable = NO;
        //打印发现默认是{8，0，8，0},赋值为UIEdgeInsetsZero 上下正常，左右右边距，然后-3是试出来的。
        self.textContainerInset = UIEdgeInsetsMake(0, -3, 0, -3);
        self.scrollEnabled = NO;
    }
    return self;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];

    //通过addAttributes: 属性传递了那些特殊字符串的ranges,ranges 是nsvalue包装的
    NSDictionary *dic = [self.attributedText attributesAtIndex:0 effectiveRange:nil];
    NSArray *ranges = dic[kStatusSpecialtextRanges];
    
    [ranges enumerateObjectsUsingBlock:^(NSValue * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        self.selectedRange = obj.rangeValue;
        NSArray *rects = [self selectionRectsForRange:self.selectedTextRange];
        self.selectedRange = NSMakeRange(0, 0);
        BOOL __block selected = NO;
        [rects enumerateObjectsUsingBlock:^(UITextSelectionRect *  obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CGRect rect = obj.rect;
            if (rect.size.width && rect.size.height) {
                if (CGRectContainsPoint(rect, point)) {
                    selected = YES;
                }
            }
        }];
        if (selected) {
            [rects enumerateObjectsUsingBlock:^(UITextSelectionRect * obj, NSUInteger idx, BOOL * _Nonnull stop) {
                CGRect rect = obj.rect;
                WBStatusSelectedBackgroundView *view = [[WBStatusSelectedBackgroundView alloc]initWithFrame:rect];
                [self insertSubview:view atIndex:0];
            }];
        }
    }];
}
-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[WBStatusSelectedBackgroundView class]]) {
            [obj removeFromSuperview];
        }
    }];
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self touchesCancelled:touches withEvent:event];
    });
}
@end
