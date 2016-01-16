//  WBComposeTextView.m
//  JW微博JW
//
//  Created by wangjianwei on 15/12/30.
//  Copyright © 2015年 JW. All rights reserved.
//

#import "WBComposeTextView.h"
#import "WBEmotionAttachment.h"
#import "WBEmotion.h"
@interface WBComposeTextView()
@end
@implementation WBComposeTextView

-(void)drawRect:(CGRect)rect{
    JWLog();
    [super drawRect:rect];
    if (self.text.length == 0 ) {
        [self.placeholder drawInRect:CGRectMake(kWBPlaceHolderX, kWBPlaceHolderY, self.width-2*kWBPlaceHolderX, self.height - 2*kWBPlaceHolderY) withAttributes:@{NSFontAttributeName:self.font,NSForegroundColorAttributeName:[UIColor grayColor]}];
    }
}
-(void)setText:(NSString *)text{
    [super setText:text];
    [self setNeedsDisplay];
}
-(void)setFont:(UIFont *)font{
//    JWLog();
    [super setFont:font];
    [self setNeedsDisplay];
}
-(void)setAttributedText:(NSAttributedString *)attributedText{
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}
-(void)setPlaceholder:(NSString *)placeholder{
//    JWLog();
    _placeholder = placeholder;
    [self setNeedsDisplay];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    JWLog();
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [kNotificationCenter addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}
-(void)textDidChange:(NSNotification*)notification{
//    JWLog();
    [self setNeedsDisplay];
}
-(void)dealloc{
    [kNotificationCenter removeObserver:self name:UITextViewTextDidBeginEditingNotification object:self];
//    JWLog();
    
}
-(NSString*)fullText{
    NSMutableString *string = [[NSMutableString alloc]init];
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        if (attrs[@"NSAttachment"]) { //包含图片
            WBEmotionAttachment *attch = attrs[@"NSAttachment"];
            [string appendString:attch.emotion.chs];
        }else{//不包含图片
            [string appendString:[self.attributedText attributedSubstringFromRange:range].string];
        }
    }];
    return string;
}
-(void)insertEmotion:(WBEmotion*)emotion{
    //将点击过的Emotion 显示到self.textView上面
    if (emotion.png) { //有图片的要在textView中显示中文简称
        //封装了emotion,方便以后获取emotion信息，其实相当于将png 和 chs 进行了绑定，不用进行有png 查找chs 之类费事的操作。
        WBEmotionAttachment *attch = [[WBEmotionAttachment alloc]init];
        attch.emotion = emotion;
        
        //让图片的大小和文字的大小一致
        CGFloat wh = self.font.lineHeight;
        attch.bounds = CGRectMake(0, -3, wh, wh);
        NSAttributedString *attributedText = [NSMutableAttributedString attributedStringWithAttachment: attch];
        
        //这个block 是为了在插入AttributedString中间修改ArributedString的字体，如果修改完后在修改字体就会报错哦，因为self.textView.attributedText 是NSAttributedString 类型的，不是NSMutableAttributedString类型的
        [self insertAttributedText:attributedText completion:^(NSMutableAttributedString *attributedText){
            // 修改了self.textView.attributedText 会覆盖关于self.textView.text的相关字体信息，所以要重新定义
            [attributedText addAttribute:NSFontAttributeName value:self.font   range:NSMakeRange(0, attributedText.length)];
        }];
    }else if(emotion.code){
        [self insertText:emotion.code.emoji];
    }

}
@end
