//
//  WBAccount.h
//  JW微博JW
//
//  Created by wangjianwei on 15/12/17.
//  Copyright © 2015年 JW. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
"access_token" = "2.00lXI5eF0ufgaK9ca9e38205f3oxRB";
"expires_in" = 157679999;
"remind_in" = 157679999;
uid = 5177470317;
 */

@interface WBAccount : NSObject<NSCoding>
/** 访问令牌*/
@property (nonatomic ,copy)NSString* access_token;
/**
 *  令牌的有效期，单位是秒
 */
@property (nonatomic ,assign)long long  expires_in;
/**
 *  用户ID
 */
@property (nonatomic ,copy)NSString* uid;
/**
 *  account 归档的时间
 */
@property (strong,nonatomic)NSDate *create_date;
/**
 *  用户的昵称，在主页中获取用户信息的时候传入
 */
@property (nonatomic ,copy) NSString *screen_name;

@end
