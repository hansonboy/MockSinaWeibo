//
//  WBStatusFrame.m
//  JW微博JW
//
//  Created by wangjianwei on 15/12/22.
//  Copyright © 2015年 JW. All rights reserved.
//

#import "WBStatusFrame.h"
#import "WBStatusPhotosView.h"
///**微博数据模型*/
//@property (strong,nonatomic)WBStatus *status;
///**cell 高度*/
//@property (assign,nonatomic)CGFloat *height;
//
///**原生微博容器frame*/
//@property (assign,nonatomic)CGRect originalViewF;
///** 头像frame*/
//@property (assign,nonatomic)CGRect avatarViewF;
///**vip 等级图片frame*/
//@property (assign,nonatomic)CGRect vipViewF;
///**名字frame*/
//@property (assign,nonatomic)CGRect nameLabelF;
///**时戳frame*/
//@property (assign,nonatomic)CGRect timeLabelF;
///**来源frame*/
//@property (assign,nonatomic)CGRect sourceLabelF;
///**正文frame*/
//@property (assign,nonatomic)CGRect contentTextLabelF;
//
///**图片frame*/
//@property (assign,nonatomic)CGRect contentImageViewF;
///**评论，点赞，转发frame*/
//@property (assign,nonatomic)CGRect comentRViewF;

@implementation WBStatusFrame
-(void)setStatus:(WBStatus *)status{

    _status = status;
    /**
     *  设置原创微博相关frame
     */
    CGFloat avatarViewX = kBorderW;
    CGFloat avatarViewY = kBorderW + kBorderW;
    CGFloat avatarViewWH = kAvatarWH;
    _avatarViewF = CGRectMake(avatarViewX, avatarViewY, avatarViewWH, avatarViewWH);
    
    CGFloat nameLabelX = CGRectGetMaxX(_avatarViewF)+kBorderW;
    CGFloat nameLabelY = avatarViewY;
    CGFloat nameLabelW = [status.user.screen_name boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kStatusCellNameFont} context:nil].size.width;
    CGFloat nameLabelH = 20;
    _nameLabelF = CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    
    if (status.user.isVip) {
        CGFloat vipViewX = CGRectGetMaxX(_nameLabelF);
        CGFloat vipViewY = nameLabelY;
        CGFloat vipViewWH = nameLabelH;
        _vipViewF = CGRectMake(vipViewX, vipViewY, vipViewWH, vipViewWH);
    }
    
    CGFloat timeLabelX = nameLabelX;
    CGFloat timeLabelY = CGRectGetMaxY(_nameLabelF)+kBorderW;
    CGFloat timeLabelW = [status.created_at boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kStatusCellTimeFont} context:nil].size.width;
    CGFloat timeLabelH = 20;
    _timeLabelF = CGRectMake(timeLabelX, timeLabelY, timeLabelW, timeLabelH);
    
    CGFloat sourceLabelX = CGRectGetMaxX(_timeLabelF)+kBorderW;
    CGFloat sourceLabelY = timeLabelY;
    CGFloat sourceLabelW = [status.source boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kStatusCellSouceFont} context:nil].size.width;
    CGFloat sourceLabelH = timeLabelH;
    _sourceLabelF = CGRectMake(sourceLabelX, sourceLabelY, sourceLabelW, sourceLabelH);
    
    CGFloat contentTextLabelX = kBorderW;
    CGFloat contentTextLabelY = CGRectGetMaxY(_avatarViewF)>CGRectGetMaxY(_timeLabelF)?(CGRectGetMaxY(_avatarViewF)+kBorderW):(CGRectGetMaxY(_timeLabelF)+kBorderW);;
    CGFloat contentTextLabelW = kScreenW - 2*contentTextLabelX;
    CGFloat contentTextLabelH = [status.attributedText boundingRectWithSize:CGSizeMake(contentTextLabelW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
    _contentTextLabelF = CGRectMake(contentTextLabelX, contentTextLabelY, contentTextLabelW, contentTextLabelH);
    
    CGFloat originalViewH = 0;
    if (status.pic_urls.count) {
        CGFloat contentImageViewX = contentTextLabelX;
        CGFloat contentImageViewY = CGRectGetMaxY(_contentTextLabelF)+kBorderW;
        CGSize size  = [WBStatusPhotosView sizeWithCount:status.pic_urls.count];
        _contentImageViewF = (CGRect){{contentImageViewX,contentImageViewY},size};
        originalViewH = CGRectGetMaxY(_contentImageViewF);
    }else{
        originalViewH = CGRectGetMaxY(_contentTextLabelF);
    }
    
    CGFloat originalViewX = 0;
    CGFloat originalViewY = 0;
    CGFloat originalViewW = kScreenW;
    _originalViewF = CGRectMake(originalViewX, originalViewY, originalViewW, originalViewH);
    
    /**
     *  设置转发微博相关frame
     */
    WBStatus *retweetStatus = status.retweeted_status;
    CGFloat toolbarY = 0;
    if (retweetStatus) {
        CGFloat retweetContentTextLabelX = kBorderW;
        CGFloat retweetContentTextLabelY = 0;
        CGFloat retweetContentTextLabelW = kMaxW;
//        NSString *retweetText = [NSString stringWithFormat:@"@%@:%@",retweetStatus.user.screen_name,retweetStatus.text];
//        CGFloat retweetContentTextLabelH = [retweetText boundingRectWithSize:CGSizeMake(retweetContentTextLabelW,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kStatusCellRetweetContentTextFont} context:nil].size.height;
        CGFloat retweetContentTextLabelH = [status.retweetedAttributedText boundingRectWithSize:CGSizeMake(retweetContentTextLabelW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
        _retweetContentTextLabelF = CGRectMake(retweetContentTextLabelX, retweetContentTextLabelY, retweetContentTextLabelW, retweetContentTextLabelH);
        
        CGFloat retweetViewH = 0;
        if (retweetStatus.pic_urls.count) {
            CGFloat retweetContentImageViewX = retweetContentTextLabelX;
            CGFloat retweetContentImageViewY = CGRectGetMaxY(_retweetContentTextLabelF)+kBorderW;
            _retweetContentImageViewF = (CGRect){{retweetContentImageViewX,retweetContentImageViewY},[WBStatusPhotosView sizeWithCount:retweetStatus.pic_urls.count]};
            retweetViewH = CGRectGetMaxY(_retweetContentImageViewF);
            
        }else{
            retweetViewH = CGRectGetMaxY(_retweetContentTextLabelF);
        }
        CGFloat retweetViewX = 0;
        CGFloat retweetViewY = CGRectGetMaxY(_originalViewF);
        CGFloat retweetViewW = kScreenW;
        _retweetViewF = CGRectMake(retweetViewX, retweetViewY, retweetViewW, retweetViewH);
        toolbarY = CGRectGetMaxY(_retweetViewF);
    }else toolbarY = CGRectGetMaxY(_originalViewF);

    /**
     *  设置toolbar
     */
    CGFloat toolbarX = 0;
    CGFloat toolbarW = kScreenW;
    CGFloat toolbarH = kStatusCellToolbarH;
    _toolbarF = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
    _height = CGRectGetMaxY(_toolbarF);
}
+(NSMutableArray *)arrayWithStatusArray:(NSArray *)statusArray{
    NSMutableArray *statusFM = [NSMutableArray array];
    for (WBStatus *status in statusArray) {
        WBStatusFrame *statusF = [[WBStatusFrame alloc]init];
        statusF.status = status;
        [statusFM addObject:statusF];
    }
    return statusFM;
}
@end
