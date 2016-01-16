//
//  WBToolbar.h
//  JW微博JW
//
//  Created by wangjianwei on 15/12/23.
//  Copyright © 2015年 JW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBStatus.h"
@interface WBToolbar : UIView

@property (strong,nonatomic)WBStatus *status;

+(instancetype)toolbar;

@end
