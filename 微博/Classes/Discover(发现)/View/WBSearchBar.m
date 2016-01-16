//
//  WBSearchBar.m
//  微博
//
//  Created by wangjianwei on 15/12/10.
//  Copyright © 2015年 JW. All rights reserved.
//

#import "WBSearchBar.h"

@implementation WBSearchBar
{
       UITextField *field;
}
-(void)setDelegate:(id<WBSearchBarDelegate>)delegate{
    _delegate = delegate;
    field.delegate = delegate;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame: frame]) {
        field = [[UITextField alloc]initWithFrame:self.bounds];
        field.height = field.height -4;
        UIButton *searchBtn = [[UIButton alloc]init];
        //    searchBtn.backgroundColor = [UIColor redColor];
        [searchBtn setImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"] forState:UIControlStateNormal];
        [searchBtn addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
        searchBtn.size = (CGSize){30,30};
        field.leftView = searchBtn;
        field.placeholder = @"请输入查询条件";
        field.borderStyle = UITextBorderStyleRoundedRect;
        field.leftViewMode = UITextFieldViewModeAlways;
        field.clearButtonMode = UITextFieldViewModeAlways;
        field.backgroundColor = [UIColor whiteColor];
        field.returnKeyType = UIReturnKeySearch;
        [self addSubview:field];
    }
    return self;
}
+(instancetype)searchBar{
    return [[WBSearchBar alloc]initWithFrame:CGRectMake(0, 0, 300, 44)];
    
}
-(void)search{
    if ([self.delegate respondsToSelector:@selector(searchBarDidSearch:)]) {
        [self.delegate searchBarDidSearch:self];
    }
}
@end
