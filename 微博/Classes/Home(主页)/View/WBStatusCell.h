//
//  WBStatusCell.h
//  JW微博JW
//
//  Created by wangjianwei on 15/12/21.
//  Copyright © 2015年 JW. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WBStatusFrame;
@interface WBStatusCell : UITableViewCell
/**微博控件Frame*/
@property (strong,nonatomic)WBStatusFrame *statusF;

+(instancetype)cellWithTableView:(UITableView*)tableView style:(UITableViewCellStyle)style;
@end
