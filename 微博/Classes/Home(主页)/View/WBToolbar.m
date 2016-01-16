//
//  WBToolbar.m
//  JW微博JW
//
//  Created by wangjianwei on 15/12/23.
//  Copyright © 2015年 JW. All rights reserved.
//

#import "WBToolbar.h"
#define kToolbarFont [UIFont systemFontOfSize:13]
@interface WBToolbar()

@property (strong,nonatomic)NSMutableArray *btns;

@end

@implementation WBToolbar
-(NSMutableArray *)btns{
    if (_btns ==nil) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}
+(instancetype)toolbar{
    return [[self alloc]init];
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:[UIButton buttonWithType:UIButtonTypeCustom]];
        [self addSubview:[UIButton buttonWithType:UIButtonTypeCustom]];
        [self addSubview:[UIButton buttonWithType:UIButtonTypeCustom]];
    }
    return self;
}
-(UIButton*)setBtn:(UIButton*)button image:(UIImage*)image count:(int)count title:(NSString*)title{
    
    /**
     * 不足1万：完全显示
     * 10023：1万
     * 12300：1.2万
     */
    
    NSMutableString *titleStr =[NSMutableString stringWithString:title];
    if (count == 0) {
         titleStr =[NSMutableString stringWithString:title];
    }else{
        if (count<10000&&count>0) {
            titleStr = [NSMutableString stringWithFormat:@"%d",count];
        }else{
            CGFloat countStr = 0;
            countStr = count/10000.0;
            titleStr = [NSMutableString stringWithFormat:@"%.1f万",countStr];
            [titleStr replaceOccurrencesOfString:@".0" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, title.length)];
        }
    }
    button.titleLabel.font = kToolbarFont;
    [button setImage:image forState:UIControlStateNormal];
    [button setTitle:titleStr forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    return button;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat btnW = self.width/self.subviews.count;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnH = 0;
    for (int i = 0;i< self.btns.count;i++) {
        UIButton *btn = self.btns[i];
        btnX = i*btnW;
        btnH = self.height;
        btn.frame = CGRectMake(btnX,btnY, btnW, btnH);
    }
    
}
-(void)setStatus:(WBStatus *)status{
    _status = status;
    [self.btns removeAllObjects];
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            [self.btns addObject:view];
        }
    }
//    status.reposts_count = 10000;
//    status.comments_count =  11000;
//    status.attitudes_count = 1354;
    [self setBtn:self.btns[0] image:[UIImage imageNamed:@"timeline_icon_retweet"] count:status.reposts_count title:@"转发"];
    [self setBtn:self.btns[1] image:[UIImage imageNamed:@"timeline_icon_comment"] count:status.comments_count title:@"评论"];
    [self setBtn:self.btns[2] image:[UIImage imageNamed:@"timeline_icon_unlike"] count:status.attitudes_count title:@"赞"];
    
}
@end
