//
//  UIWindow+Extension.m
//  JW微博JW
//
//  Created by wangjianwei on 15/12/17.
//  Copyright © 2015年 JW. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "WMTabBarController.h"
#import "WBNewFeatureViewController.h"
@implementation UIWindow (Extension)
-(void)switchRootViewController{
    WMTabBarController *tabBarController = [[WMTabBarController alloc]init];
    WBNewFeatureViewController *newFeature = [[WBNewFeatureViewController alloc]init];
    static NSString *VersionKey = @"version";
    NSString *oldVersion = [[NSUserDefaults standardUserDefaults]objectForKey:VersionKey];
    NSString *newVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    if ([oldVersion isEqualToString:newVersion]) {
//        JWLog(@"已经是最新版本了");
        self.rootViewController = tabBarController;
    }
    else {
//        JWLog(@"欢迎来到新版本");
        self.rootViewController = newFeature;
        [[NSUserDefaults standardUserDefaults]setObject:newVersion forKey:VersionKey];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
}
@end
