//
//  WBStatusCell.m
//  JW微博JW
//
//  Created by wangjianwei on 15/12/21.
//  Copyright © 2015年 JW. All rights reserved.
//

#import "WBStatusCell.h"
#import "WBStatusFrame.h"
#import "WBUser.h"
#import "WBPhoto.h"
#import "WBToolbar.h"
#import "WBStatusPhotosView.h"
#import "WBStatusAvatarView.h"
@interface WBStatusCell()
/** 原创微博整体*/
@property (weak,nonatomic)UIView *originalView;
/** 头像*/
@property (weak,nonatomic)WBStatusAvatarView *avatarView;
/**vip 等级图片*/
@property (weak,nonatomic)UIImageView *vipView;
/**名字*/
@property (weak,nonatomic)UILabel *nameLabel;
/**时戳*/
@property (weak,nonatomic)UILabel *timeLabel;
/**来源*/
@property (weak,nonatomic)UILabel *sourceLabel;
/**正文*/
@property (weak,nonatomic)UILabel *contentTextLabel;
/**图片*/
@property (weak,nonatomic)WBStatusPhotosView *contentImageView;

/**转发微博*/
/**转发微博整体*/
@property (weak,nonatomic)UIView *retweetView;
/**转发微博的内容+昵称*/
@property (weak,nonatomic)UILabel *retweetContentTextLabel;
/**转发微博的图片*/
@property (weak,nonatomic)WBStatusPhotosView *retweetContentImageView;

/**评论，点赞，转发*/
@property (weak,nonatomic)WBToolbar *toolbar;


@end
@implementation WBStatusCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.contentView.backgroundColor = [UIColor clearColor];
        
        [self setupOriginal];
        
        [self setupRetweet];
        
        [self setupToolbar];

    }
    return self;
}
+(instancetype)cellWithTableView:(UITableView*)tableView style:(UITableViewCellStyle)style{
    static NSString *identifier = @"WBStatusCell";
    WBStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:style reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
/**
 *  设置底部工具栏
 */
-(void)setupToolbar
{
    WBToolbar * toolbar = [[WBToolbar alloc]init];
    [self.contentView addSubview:toolbar];
    _toolbar = toolbar;
}
/**
 *  设置转发微博
 */
-(void)setupRetweet{
    UIView *retweetView = [[UIView alloc]init];
    [self.contentView addSubview:retweetView];
    _retweetView = retweetView;
    _retweetView.backgroundColor = color(230, 230, 230);
    
    UILabel *retweetContentTextLabel = [[UILabel alloc]init];
    
    retweetContentTextLabel.numberOfLines = 0;
    retweetContentTextLabel.textAlignment = NSTextAlignmentLeft;
    retweetContentTextLabel.font = kStatusCellRetweetContentTextFont;
    [_retweetView addSubview:retweetContentTextLabel];
    _retweetContentTextLabel = retweetContentTextLabel;
    
    WBStatusPhotosView * retweetContentImageView= [[WBStatusPhotosView alloc]init];
    [_retweetView addSubview:retweetContentImageView];
    _retweetContentImageView = retweetContentImageView;
}
/**
 *  设置原创微博
 */
-(void)setupOriginal{
    UIView *orignalView = [[UIView alloc]init];
//    orignalView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:orignalView];
    _originalView = orignalView;
    
    WBStatusAvatarView * avatarView = [[WBStatusAvatarView alloc]init];
    [_originalView addSubview:avatarView];
    _avatarView = avatarView;
    
    UIImageView * vipView = [[UIImageView alloc]init];
    vipView.contentMode = UIViewContentModeCenter;
    [_originalView addSubview:vipView];
    _vipView = vipView;
    
    UILabel * nameLabel = [[UILabel alloc]init];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.font = kStatusCellNameFont;
    [_originalView addSubview:nameLabel];
    _nameLabel = nameLabel;
    
    UILabel * timeLabel = [[UILabel alloc]init];
    timeLabel.textAlignment = NSTextAlignmentLeft;
    timeLabel.font = kStatusCellTimeFont;
    [_originalView addSubview:timeLabel];
    _timeLabel = timeLabel;
    
    UILabel * sourceLabel = [[UILabel alloc]init];
    sourceLabel.textAlignment = NSTextAlignmentLeft;
    sourceLabel.font = kStatusCellSouceFont;
    [_originalView addSubview:sourceLabel];
    _sourceLabel = sourceLabel;
    
    UILabel * contentTextLabel = [[UILabel alloc]init];
    contentTextLabel.textAlignment = NSTextAlignmentLeft;
    contentTextLabel.numberOfLines = 0;
    contentTextLabel.font = kStatusCellContentTextFont;
    [_originalView addSubview:contentTextLabel];
    _contentTextLabel = contentTextLabel;
    
    WBStatusPhotosView * contentImageView = [[WBStatusPhotosView alloc]init];
    [_originalView addSubview:contentImageView];
    _contentImageView = contentImageView;

}
-(void)setStatusF:(WBStatusFrame *)statusF{
    _statusF = statusF;
    
    WBStatus *status = statusF.status;
    
    self.originalView.frame = statusF.originalViewF;
    
    self.avatarView.frame = statusF.avatarViewF;
    self.avatarView.user = status.user;
   
    

    self.nameLabel.frame = statusF.nameLabelF;
    self.nameLabel.text = status.user.screen_name;
    
    if(status.user.isVip) {
        self.vipView.frame = statusF.vipViewF;
        NSString *vipImg = [NSString stringWithFormat:@"common_icon_membership_level%d",status.user.mbrank];
        self.vipView.hidden = NO;
        self.vipView.image = [UIImage imageNamed:vipImg];
        self.nameLabel.textColor = color(207, 49, 17);
        self.timeLabel.textColor = color(207, 49, 17);
    }else {
        self.vipView.hidden = YES;
        self.nameLabel.textColor = [UIColor blackColor];
        self.timeLabel.textColor = [UIColor blackColor];
    }
   
    CGFloat timeLabelX = self.nameLabel.x;
    CGFloat timeLabelY = CGRectGetMaxY(statusF.nameLabelF)+kBorderW;
    CGFloat timeLabelW = [status.created_at boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kStatusCellTimeFont} context:nil].size.width;
    CGFloat timeLabelH = 20;
    self.timeLabel.frame = CGRectMake(timeLabelX, timeLabelY, timeLabelW, timeLabelH);
    self.timeLabel.text = status.created_at;
    
    CGFloat sourceLabelX = CGRectGetMaxX(self.timeLabel.frame)+kBorderW;
    CGFloat sourceLabelY = timeLabelY;
    CGFloat sourceLabelW = [status.source boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kStatusCellSouceFont} context:nil].size.width;
    CGFloat sourceLabelH = timeLabelH;
    self.sourceLabel.frame = CGRectMake(sourceLabelX, sourceLabelY, sourceLabelW, sourceLabelH);
    self.sourceLabel.text = status.source;
    
    self.contentTextLabel.frame = statusF.contentTextLabelF;
//    self.contentTextLabel.text = status.text;
    self.contentTextLabel.attributedText = status.attributedText;
    
    if (status.pic_urls.count) {
        self.contentImageView.hidden = NO;
        self.contentImageView.photoUrls = status.pic_urls;
        self.contentImageView.frame = statusF.contentImageViewF;
    }else self.contentImageView.hidden = YES;
   
    if (status.retweeted_status) {
        self.retweetView.hidden = NO;
        self.retweetView.frame = statusF.retweetViewF;
        WBStatus *retweetStatus  = status.retweeted_status;
        
        self.retweetContentTextLabel.frame = statusF.retweetContentTextLabelF;
        self.retweetContentTextLabel.attributedText = status.retweetedAttributedText;
//        self.retweetContentTextLabel.text = retweetStatus.text;
        
        if (retweetStatus.pic_urls.count) {
            self.retweetContentImageView.hidden = NO;
            self.retweetContentImageView.photoUrls = retweetStatus.pic_urls;
            self.retweetContentImageView.frame = statusF.retweetContentImageViewF;
        }else self.retweetContentImageView.hidden = YES;
    }else self.retweetView.hidden = YES;
    
    self.toolbar.frame = statusF.toolbarF;
    self.toolbar.status = status;
}

@end
#warning wangjianwei contentTextLabel 内容右侧有填充的空白