//
//  UIViewController+Extension.m
//  微博
//
//  Created by wangjianwei on 15/12/9.
//  Copyright © 2015年 JW. All rights reserved.
//

#import "UIViewController+Extension.h"

@implementation UIViewController (Extension)
-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)more{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
