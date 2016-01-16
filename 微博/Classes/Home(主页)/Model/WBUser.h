//
//  WBUser.h
//  JW微博JW
//
//  Created by wangjianwei on 15/12/17.
//  Copyright © 2015年 JW. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WBStatus;
typedef enum {
    WBUserVerifiedTypeNone = -1, // 没有任何认证
    
    WBUserVerifiedPersonal = 0,  // 个人认证
    
    WBUserVerifiedOrgEnterprice = 2, // 企业官方：CSDN、EOE、搜狐新闻客户端
    WBUserVerifiedOrgMedia = 3, // 媒体官方：程序员杂志、苹果汇
    WBUserVerifiedOrgWebsite = 5, // 网站官方：猫扑
    
    WBUserVerifiedDaren = 220 // 微博达人
}WBUserVerifiedType;
@interface WBUser : NSObject
/**	字符串型的用户UID*/
@property (nonatomic ,copy) NSString *idstr;
/** 	string	用户昵称*/
@property (nonatomic ,copy) NSString *screen_name;
/**string	用户头像地址（中图），50×50像素*/
@property (nonatomic ,copy) NSString *profile_image_url;

/**用户的最近一条微博信息字段 详细*/
@property (nonatomic ,strong) WBStatus *status;

/**会员类型  > 2 代表是会员*/
@property (nonatomic ,assign)int mbtype;
/**会员等级 */
@property (nonatomic ,assign)int mbrank;
/**是否会员*/
@property (nonatomic ,assign,getter = isVip)BOOL vip;
/**是否是微博认证用户*/
@property (nonatomic ,assign,getter = isVerified)BOOL verified;
@property (nonatomic ,assign)WBUserVerifiedType verified_type;

/** name	string	友好显示名称*/
/**province	int	用户所在省级ID*/
/**city	int	用户所在城市ID*/
/** location	string	用户所在地*/
/** description	string	用户个人描述*/
/**url	string	用户博客地址*/
/** profile_url	string	用户的微博统一URL地址*/
 /**domain	string	用户的个性化域名*/
 /**weihao	string	用户的微号*/
 /**gender	string	性别，m：男、f：女、n：未知*/
 /**followers_count	int	粉丝数*/
 /**friends_count	int	关注数
 statuses_count	int	微博数
 favourites_count	int	收藏数
 created_at	string	用户创建（注册）时间
 following	boolean	暂未支持
 allow_all_act_msg	boolean	是否允许所有人给我发私信，true：是，false：否
 geo_enabled	boolean	是否允许标识用户的地理位置，true：是，false：否
 verified	boolean	是否是微博认证用户，即加V用户，true：是，false：否
 verified_type	int	暂未支持
 remark	string	用户备注信息，只有在查询用户关系时才返回此字段*/
 /**allow_all_comment	boolean	是否允许所有人对我的微博进行评论，true：是，false：否
 avatar_large	string	用户头像地址（大图），180×180像素
 avatar_hd	string	用户头像地址（高清），高清头像原图
 verified_reason	string	认证原因
 follow_me	boolean	该用户是否关注当前登录用户，true：是，false：否
 online_status	int	用户的在线状态，0：不在线、1：在线
 bi_followers_count	int	用户的互粉数
 lang	string	用户当前的语言版本，zh-cn：简体中文，zh-tw：繁体中文，en：英语
 */
@end
