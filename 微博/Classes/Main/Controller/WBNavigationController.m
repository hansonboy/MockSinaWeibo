//
//  WBNavigationController.m
//  微博
//
//  Created by wangjianwei on 15/12/9.
//  Copyright (c) 2015年 JW. All rights reserved.
//

#import "WBNavigationController.h"

@interface WBNavigationController ()

@end

@implementation WBNavigationController

+(void)initialize{
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:color(255, 130, 0),NSFontAttributeName:[UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:color(190, 184, 180)} forState:UIControlStateDisabled];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if(self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
       
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:viewController action:@selector(goBack) imageName:@"navigationbar_back" selecteImageName:@"navigationbar_back_highlighted"];
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:viewController action:@selector(more) imageName:@"navigationbar_more" selecteImageName:@"navigationbar_more_highlighted"];
    }
//    viewController.view.backgroundColor = randomColor;
#pragma warning 上面注释掉的这句话导致viewController 在被加载到TabBarController的过程中就提前创建出来了，不符合懒加载的原则
    [super pushViewController:viewController animated:animated];
}



@end
