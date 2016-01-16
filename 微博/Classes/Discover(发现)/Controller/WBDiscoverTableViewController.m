//
//  WBDiscoverTableViewController.m
//  微博
//
//  Created by wangjianwei on 15/12/9.
//  Copyright © 2015年 JW. All rights reserved.
//

#import "WBDiscoverTableViewController.h"
#import "WBSearchBar.h"
@interface WBDiscoverTableViewController ()<WBSearchBarDelegate>

@end

@implementation WBDiscoverTableViewController
{
    WBSearchBar *searchBar;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    

    searchBar = [WBSearchBar searchBar];
    searchBar.delegate = self;
    self.navigationItem.titleView = searchBar;
    
}

#pragma mark WBSearchBarDelegate 
-(void)searchBarDidSearch:(WBSearchBar *)searchBar{
  
}
#pragma mark UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
 
    [textField resignFirstResponder];
    return YES;
}

@end
