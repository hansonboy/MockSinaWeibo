//
//  WBEmotionListView.m
//  JW微博JW
//
//  Created by wangjianwei on 16/1/12.
//  Copyright © 2016年 JW. All rights reserved.
//

#import "WBEmotionListView.h"
#import "WBEmotionPageView.h"
#define kPageControlH 37


@interface WBEmotionListView()<UIScrollViewDelegate>
@property (weak,nonatomic)UIScrollView  *scrollView;
@property (weak,nonatomic)UIPageControl *pageControl;
@end


@implementation WBEmotionListView
#pragma mark - view life Cycle
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"emoticon_keyboard_background"]];
        UIScrollView *scrollView = [[UIScrollView alloc]init];
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        scrollView.pagingEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.delegate = self;
        
        UIPageControl *pageControl = [[UIPageControl alloc]init];
        pageControl.enabled = NO;
        // 设置内部的圆点图片,其中pageImage 和 currentPageImage 是私有属性，不能通过一般的属性进行设置
        [pageControl setValue:[[UIImage imageNamed:@"compose_keyboard_dot_normal"] stretchableImage] forKeyPath:@"pageImage"];
        [pageControl setValue:[[UIImage imageNamed:@"compose_keyboard_dot_selected"] stretchableImage] forKeyPath:@"currentPageImage"];
        [self addSubview:pageControl];
        self.pageControl = pageControl;
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.pageControl.x  = 0;
    self.pageControl.width = self.width;
    self.pageControl.height = kPageControlH;
    self.pageControl.y = self.height - self.pageControl.height;
    
    self.scrollView.x = self.scrollView.y = 0;
    self.scrollView.width = self.width;
    self.scrollView.height = self.pageControl.y;
    NSUInteger pageCount = (self.emotions.count + kMaxCountPerPage - 1)/kMaxCountPerPage;
    self.scrollView.contentSize = CGSizeMake(pageCount*self.scrollView.width, self.scrollView.height);
    
    for (NSUInteger i = 0; i < self.scrollView.subviews.count; i++) {
        
        
        UIView *pageView = self.scrollView.subviews[i];
        pageView.x = i*self.scrollView.width;
        pageView.y = 0;
        pageView.width = self.scrollView.width;
        pageView.height = self.scrollView.height;
        
//        JWLog(@"%@",pageView);
    }
   
}
-(void)setEmotions:(NSArray *)emotions{
    _emotions = emotions;
    [self setNeedsLayout];
    
    NSUInteger PageCount = (emotions.count + kMaxCountPerPage - 1)/kMaxCountPerPage;
    self.pageControl.numberOfPages = PageCount > 1 ?PageCount:0;
   
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for (NSUInteger i = 0; i< PageCount; i++) {
        WBEmotionPageView *pageView = [[WBEmotionPageView alloc]init];
        [self.scrollView addSubview:pageView];
        NSUInteger loc = i*kMaxCountPerPage;
        NSUInteger leave = emotions.count - i*kMaxCountPerPage;
        NSUInteger len = leave>kMaxCountPerPage?kMaxCountPerPage:leave;
        pageView.emotions = [emotions subarrayWithRange:NSMakeRange(loc, len)];
    }
    
    
}
#pragma mark - ScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offset = scrollView.contentOffset;
    self.pageControl.currentPage = offset.x/self.scrollView.width + 0.5 ;
}// any offset changes



@end
