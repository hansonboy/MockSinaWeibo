//
//  WBStatusFrame.h
//  JW微博JW
//
//  Created by wangjianwei on 15/12/22.
//  Copyright © 2015年 JW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBStatus.h"
#import "WBUser.h"
#import "WBStatusAvatarView.h"
#define kBorderW 10
#define kMaxW ((kScreenW) - 2*(kBorderW))
#define kStatusCellToolbarH 36
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kStatusCellNameFont [UIFont systemFontOfSize:15]
#define kStatusCellTimeFont [UIFont systemFontOfSize:13]
#define kStatusCellSouceFont [UIFont systemFontOfSize:14]
#define kStatusCellContentTextFont [UIFont systemFontOfSize:17]
#define kStatusCellRetweetContentTextFont [UIFont systemFontOfSize:17]
@interface WBStatusFrame : NSObject

/**微博数据模型*/
@property (strong,nonatomic)WBStatus *status;
/**cell 高度*/
@property (assign,nonatomic)CGFloat height;

/**原生微博容器frame*/
@property (assign,nonatomic)CGRect originalViewF;
/** 头像frame*/
@property (assign,nonatomic)CGRect avatarViewF;
/**vip 等级图片frame*/
@property (assign,nonatomic)CGRect vipViewF;
/**名字frame*/
@property (assign,nonatomic)CGRect nameLabelF;
/**时戳frame*/
@property (assign,nonatomic)CGRect timeLabelF;
/**来源frame*/
@property (assign,nonatomic)CGRect sourceLabelF;
/**正文frame*/
@property (assign,nonatomic)CGRect contentTextLabelF;
/**图片frame*/
@property (assign,nonatomic)CGRect contentImageViewF;

/**转发微博*/
/**转发微博整体*/
@property (assign,nonatomic)CGRect retweetViewF;
/**转发微博的内容+昵称*/
@property (assign,nonatomic)CGRect retweetContentTextLabelF;
/**转发微博的图片*/
@property (assign,nonatomic)CGRect retweetContentImageViewF;

/**评论，点赞，转发frame*/
@property (assign,nonatomic)CGRect toolbarF;

+(NSMutableArray *)arrayWithStatusArray:(NSArray*)statusArray;
@end
