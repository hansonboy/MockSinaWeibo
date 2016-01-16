//
//  WMTabBarController.m
//  微博
//
//  Created by wangjianwei on 15/12/9.
//  Copyright (c) 2015年 JW. All rights reserved.
//

#import "WMTabBarController.h"
#import "WBNavigationController.h"
#import "WBDiscoverTableViewController.h"
#import "WBHomeTableViewController.h"
#import "WBMessageCenterTableViewController.h"
#import "WBMineTableViewController.h"
#import "WBTabBar.h"
#import "WBComposeViewController.h"
@interface WMTabBarController ()<WBTabBarDelegate>

@end

@implementation WMTabBarController

#pragma warning initialize 此方法只使用一次在该类或者该类的子类首次调用的时候，所以最多会调用该类及子类的个数和次
+(void)initialize{
    UITabBarItem  *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:color(255, 124, 40)} forState: UIControlStateSelected];
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    WBTabBar *tabBar = [[WBTabBar alloc]init];
    tabBar.delegate = self;
    [self setValue:tabBar forKeyPath:@"tabBar"];
    [self setupChildController];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)setupChildController{
    [self addChildViewController:[[WBHomeTableViewController alloc]init] title:@"主页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    [self addChildViewController:[[WBMessageCenterTableViewController alloc]init] title:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    [self addChildViewController:[[WBDiscoverTableViewController alloc]init] title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    [self addChildViewController:[[WBMineTableViewController alloc]init] title:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
}

-(void)addChildViewController:(UIViewController *)controller title:(NSString*)title image:(NSString*)imageName selectedImage:(NSString*)selectedImage {
    controller.title = title;
    UIImage *image = [UIImage imageNamed:imageName];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *selImage = [UIImage imageNamed:selectedImage];
    selImage = [selImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *tabBarItem = [[UITabBarItem alloc]initWithTitle:title image:image selectedImage:selImage];
    
    controller.tabBarItem = tabBarItem;
    WBNavigationController *naviController = [[WBNavigationController alloc]initWithRootViewController:controller];
    [self addChildViewController:naviController];
}
#pragma mark - WBTabBarDelegate
-(void)tabBarDidSelected:(WBTabBar *)tabBar{
    WBComposeViewController *composeVc = [[WBComposeViewController alloc]init];
    WBNavigationController *navi = [[WBNavigationController alloc]initWithRootViewController:composeVc];
    [self presentViewController:navi animated:YES completion:nil];
}

@end
