//
//  WBStatusAvatarView.m
//  JW微博JW
//
//  Created by wangjianwei on 15/12/25.
//  Copyright © 2015年 JW. All rights reserved.
// 表示微博头像以及加V 标志

#import "WBStatusAvatarView.h"
#import "WBUser.h"
@interface WBStatusAvatarView()
@property (strong,nonatomic)UIImageView *avatarView;
@property (strong,nonatomic)UIImageView *verifyView;
@end
@implementation WBStatusAvatarView
-(void)setUser:(WBUser *)user{
    _user = user;
     [self.avatarView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    WBUserVerifiedType type = user.verified_type;
//    WBUserVerifiedTypeNone = -1, // 没有任何认证
//    
//    WBUserVerifiedPersonal = 0,  // 个人认证
//    
//    WBUserVerifiedOrgEnterprice = 2, // 企业官方：CSDN、EOE、搜狐新闻客户端
//    WBUserVerifiedOrgMedia = 3, // 媒体官方：程序员杂志、苹果汇
//    WBUserVerifiedOrgWebsite = 5, // 网站官方：猫扑
//    
//    WBUserVerifiedDaren = 220 // 微博达人
    switch (type) {
        case WBUserVerifiedTypeNone:
            self.verifyView.hidden = YES;
            break;
        case WBUserVerifiedPersonal:
            self.verifyView.hidden = NO;
            self.verifyView.image = [UIImage imageNamed:@"avatar_vip"];
            break;
        case WBUserVerifiedOrgEnterprice:
            self.verifyView.hidden = NO;
            self.verifyView.image = [UIImage imageNamed:@"avatar_enterprise_vip"];
            break;
        case WBUserVerifiedOrgMedia:
            self.verifyView.hidden = YES;
            break;
        case WBUserVerifiedOrgWebsite:
            self.verifyView.hidden = YES;
            break;
        case WBUserVerifiedDaren:
            self.verifyView.hidden = NO;
            self.verifyView.image = [UIImage imageNamed:@"avatar_grassroot"];
            break;
        default:
            break;
    }
    
}
-(UIImageView *)avatarView{
    if (_avatarView == nil) {
        _avatarView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kAvatarWH, kAvatarWH)];
        _avatarView.clipsToBounds = YES;
        _avatarView.layer.cornerRadius = self.avatarView.width*0.5;
        [self addSubview:_avatarView];
    }
    return _avatarView;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor yellowColor];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.verifyView.x = self.width - _verifyView.width*kStatusAvaraPositionScale;
    self.verifyView.y = self.height - _verifyView.height*kStatusAvaraPositionScale;
}
-(UIImageView *)verifyView{
    if (_verifyView == nil) {
        _verifyView = [[UIImageView alloc]init];
        _verifyView.size = CGSizeMake(kStatusAvatarBadgeWH,kStatusAvatarBadgeWH);
        [self addSubview:_verifyView];
    }
    return _verifyView;
}
@end
