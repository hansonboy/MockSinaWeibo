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

extern NSString * const kStatusSpecialtextRanges;
@interface WBStatusTextView()
/** 用来存放特殊字符的range*/
@property (strong,nonatomic)NSArray *specialRanges;
@end
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
-(void)setAttributedText:(NSAttributedString *)attributedText{
    [super setAttributedText:attributedText];
    //通过addAttributes: 属性传递了那些特殊字符串的ranges,ranges 是nsvalue包装的
    NSDictionary *dic = [self.attributedText attributesAtIndex:0 effectiveRange:nil];
    _specialRanges = dic[kStatusSpecialtextRanges];
}
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    BOOL __block contained = NO;
    [self.specialRanges enumerateObjectsUsingBlock:^(NSValue* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        *stop = contained = [self range:obj.rangeValue containsPoint:point];
    }];
    return contained;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    [self.specialRanges enumerateObjectsUsingBlock:^(NSValue * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([self range:obj.rangeValue containsPoint:point]) {
            NSArray *rects = [self rectsForRange:obj.rangeValue];
            [rects enumerateObjectsUsingBlock:^(UITextSelectionRect * obj, NSUInteger idx, BOOL * _Nonnull stop) {
                CGRect rect = obj.rect;
                WBStatusSelectedBackgroundView *view = [[WBStatusSelectedBackgroundView alloc]initWithFrame:rect];
                [self insertSubview:view atIndex:0];
            }];
            *stop = YES;
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
-(BOOL)range:(NSRange)range containsPoint:(CGPoint)point{
    NSArray *rects = [self rectsForRange:range];
    BOOL __block selected = NO;
    [rects enumerateObjectsUsingBlock:^(UITextSelectionRect *  obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect rect = obj.rect;
        if (rect.size.width && rect.size.height) {
            *stop = selected = CGRectContainsPoint(rect, point);
        }
    }];
    return selected;
}
-(NSArray*)rectsForRange:(NSRange)range{
    self.selectedRange = range;
    NSArray *rects = [self selectionRectsForRange:self.selectedTextRange];
    self.selectedRange = NSMakeRange(0, 0);
    return rects;
}
@end
