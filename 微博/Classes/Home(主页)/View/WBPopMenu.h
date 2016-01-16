//
//  WBPopMenu.h
//  微博
//
//  Created by wangjianwei on 15/12/10.
//  Copyright (c) 2015年 JW. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WBPopMenu;
@protocol WBPopMenuDelegate <NSObject>
@optional
-(void)popMenuDidDismiss:(WBPopMenu*)menu;

-(void)popMenuWillShow:(WBPopMenu *)menu;

@end

@interface WBPopMenu : UIView
@property (weak,nonatomic)id<WBPopMenuDelegate>  delegate;

@property (strong,nonatomic)UIView *content;
#pragma warning 这里必须是强引用，因为可能出现传进来的时候有值，但是传完之后没有值了的尴尬情况，所以不要用weak
@property (strong,nonatomic)UIViewController *contentController;
-(void)showFrom:(UIView*)view;
-(void)dissmiss;
+(instancetype)menu;
+(instancetype)menuWithSubview:(UIView*)view;
+(instancetype)menuWithController:(UIViewController*)controller;
@end
