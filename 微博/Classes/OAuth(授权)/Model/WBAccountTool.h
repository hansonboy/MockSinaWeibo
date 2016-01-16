//
//  WBAccountTool.h
//  JW微博JW
//
//  Created by wangjianwei on 15/12/17.
//  Copyright © 2015年 JW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBAccount.h"
@interface WBAccountTool : NSObject
+(BOOL)saveAccount:(WBAccount*)account;
+(WBAccount *)account;
@end
