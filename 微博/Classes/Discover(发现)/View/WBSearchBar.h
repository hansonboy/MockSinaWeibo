//
//  WBSearchBar.h
//  微博
//
//  Created by wangjianwei on 15/12/10.
//  Copyright © 2015年 JW. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WBSearchBar;
@protocol WBSearchBarDelegate <UITextFieldDelegate>
@optional
-(void)searchBarDidSearch:(WBSearchBar*)searchBar;
@end

@interface WBSearchBar : UIView
@property (weak,nonatomic)id<WBSearchBarDelegate> delegate;
+(instancetype)searchBar;
@end
