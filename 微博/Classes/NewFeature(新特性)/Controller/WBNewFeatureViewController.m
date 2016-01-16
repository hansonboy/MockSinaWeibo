//
//  WBNewFeatureViewController.m
//  微博
//
//  Created by wangjianwei on 15/12/12.
//  Copyright © 2015年 JW. All rights reserved.
//

#import "WBNewFeatureViewController.h"
#import "WMTabBarController.h"
#define kScrollViewContentCount 4
@interface WBNewFeatureViewController ()<UIScrollViewDelegate>
@property (strong,nonatomic)UIScrollView *scrollView;
@property (strong,nonatomic)UIPageControl *pageControl;
@property (strong,nonatomic)UIButton *shareBtn;
@property (strong,nonatomic)UIButton *startBtn;
@end

@implementation WBNewFeatureViewController
-(UIPageControl *)pageControl{
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc]init];
//        _pageControl.bounds = CGRectMake(0, 0, 100, 20);
        _pageControl.backgroundColor = [UIColor redColor];
        _pageControl.enabled = NO;
        _pageControl.numberOfPages = kScrollViewContentCount;
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        _pageControl.centerX = self.view.centerX;
        _pageControl.y = self.view.height - 40;
        [self.view addSubview:_pageControl];
    }
    return _pageControl;
}
-(UIButton *)shareBtn{
    if (_shareBtn == nil) {
        _shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 150, 50)];
        [_shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
        [_shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
        [_shareBtn setTitle:@"分享到大家" forState:UIControlStateNormal];
        _shareBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _shareBtn.centerX = self.view.centerX;
        _shareBtn.y = self.view.height*0.7;
        _shareBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
        _shareBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -5);
        [_shareBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        //        _shareBtn.titleLabel.text = @"分享到大家"; 无效设置
        //        _shareBtn.titleLabel.textColor = [UIColor blackColor]; 无效设置
    }
    return _shareBtn;
}
-(void)clickBtn:(UIButton*)btn{
    btn.selected = !btn.selected;
}
-(UIButton *)startBtn{
    if (_startBtn == nil) {
        _startBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _startBtn.backgroundColor = [UIColor redColor];
        [_startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
        [_startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
        [_startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
        _startBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [_startBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _startBtn.size = _startBtn.currentBackgroundImage.size;
        _startBtn.centerX = self.view.centerX;
        _startBtn.y = self.view.height*0.7+self.shareBtn.height+5;
        [_startBtn addTarget:self action:@selector(clickStartBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startBtn;
}
-(void)clickStartBtn:(UIButton*)btn{
        [UIApplication sharedApplication].keyWindow.rootViewController = [[WMTabBarController alloc]init];
}
-(UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupScrollView];
    [self pageControl];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    JWLog(@"%@--%@",self.scrollView.subviews,self.scrollView);
}
-(void)setupScrollView{
    CGFloat imageViewW = [UIScreen mainScreen].bounds.size.width;
    for (int i = 0; i< kScrollViewContentCount; i++) {
        NSString* imgName = [NSString stringWithFormat:@"new_feature_%d",i+1];
        UIImage *image = [UIImage imageNamed:imgName];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
        imageView.userInteractionEnabled = YES;
        imageView.x = i*imageViewW;
        imageView.y = 0;
        imageView.size = self.view.size;
        [self.scrollView addSubview:imageView];
        if (i == 3) {
            [self setupLastImageView:imageView];
        }
    }
    self.scrollView.contentSize = (CGSize){kScrollViewContentCount*imageViewW,0};
}
-(void)setupLastImageView:(UIImageView*)imageView{
    [imageView addSubview:self.shareBtn];
    [imageView addSubview:self.startBtn];
}
#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    JWLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
    int currentPage = scrollView.contentOffset.x/self.view.width+0.5;
    self.pageControl.currentPage = currentPage;
}
@end
