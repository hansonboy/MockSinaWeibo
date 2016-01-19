//
//  WBHomeTableViewController.m
//  微博
//
//  Created by wangjianwei on 15/12/9.
//  Copyright © 2015年 JW. All rights reserved.
//

#import "WBHomeTableViewController.h"
#import "WBPopMenu.h"
#import "WBTestTableViewController.h"
#import "WBAccountTool.h"
#import "HttpTool.h"
#import "WBUser.h"
#import "WBStatus.h"
#import "WBStatusFrame.h"
#import "WBStatusCell.h"
@interface WBHomeTableViewController ()<WBPopMenuDelegate>
@property (strong,nonatomic)NSMutableArray *statusFM;
/**
 *  当前用户相关信息
 */
@property (strong,nonatomic)WBUser *user;
@property (strong,nonatomic)UILabel *notifyHeader;
@property (strong,nonatomic)UIButton *footerLoadMoreBtn;
@end

@implementation WBHomeTableViewController
#pragma mark - 属性
-(UIButton *)footerLoadMoreBtn{
    if (_footerLoadMoreBtn == nil) {
        _footerLoadMoreBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 30)];
        _footerLoadMoreBtn.backgroundColor = [UIColor redColor];
        [_footerLoadMoreBtn addTarget:self action:@selector(footerClick:) forControlEvents:UIControlEventTouchUpInside];
        [_footerLoadMoreBtn setTitle:@"加载更多" forState:UIControlStateNormal];
        [_footerLoadMoreBtn setTitle:@"正在加载中" forState:UIControlStateSelected];
        [_footerLoadMoreBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _footerLoadMoreBtn;
}

-(UILabel *)notifyHeader{
    if (_notifyHeader == nil) {
        _notifyHeader = [[UILabel alloc]init];
        _notifyHeader.textAlignment = NSTextAlignmentCenter;
        _notifyHeader.textColor = [UIColor whiteColor];
        _notifyHeader.width = self.navigationController.navigationBar.width;
        _notifyHeader.height = 20;
        _notifyHeader.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
        _notifyHeader.y = self.navigationController.navigationBar.height - _notifyHeader.height;
        _notifyHeader.alpha = 0;
        [self.navigationController.navigationBar insertSubview:_notifyHeader atIndex:0];
    }
    return _notifyHeader;
}
#warning  开始没有菊花旋转 TODO
-(void)setUser:(WBUser *)user{
    _user = user;
//    JWLog(@"收到用户信息了");
    //收到用户消息后去加载用户主页的微博动态
    
    self.refreshControl.frame = CGRectMake(0, -87, 320, 60);
    self.refreshControl.backgroundColor = [UIColor yellowColor];
    self.refreshControl.hidden = NO;
    [self.refreshControl beginRefreshing];
    if (self.refreshControl.isRefreshing) {
//        JWLog(@"转起来了");
    }
    [self refreshControlValueChanged:self.refreshControl];
    
    [self setupTitleView];
}
-(NSMutableArray *)statusFM{
    if (_statusFM == nil) {
        _statusFM = [NSMutableArray array];
    }
    return _statusFM;
}
#pragma mark - 页面即将显示
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    JWLog(@"%@",self.tableView.tableFooterView);
}
#pragma mark - 初始化
- (void)viewDidLoad {
//    JWLog();
    [super viewDidLoad];
    

    [self setupNavigationItem];
    
    [self setupRefreshControl];
    
    [self setupTableView];
    
    [self getUserInfo];
    
}
/**
 *  清除未读数目
 */
-(void)clearBadgeNumber{
    self.tabBarItem.badgeValue = nil;
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}
/**
 *  设置未读数目提醒
 *
 *  @param num 新微薄未读数目
 */
-(void)setBadgeNumber:(NSNumber*)num{
    if ([num isEqualToNumber:@0]) self.tabBarItem.badgeValue = nil;
    else self.tabBarItem.badgeValue = num.description;
    [UIApplication sharedApplication].applicationIconBadgeNumber = num.integerValue;
}
/**
 *  获取用户未读微博的数目
 */
-(void)getUnreadCount{
//    JWLog();
    //   https://rm.api.weibo.com/2/remind/unread_count.json
 
  
    WBAccount *account = [WBAccountTool account];
    NSString *urlStr = [NSString stringWithFormat:@"https://rm.api.weibo.com/2/remind/unread_count.json?access_token=%@&uid=%@",account.access_token,account.uid];
    
    [HttpTool get:urlStr params:nil success:^(id responseObject) {
        //        JWLog(@"未读数目:%@",responseObject);
        [self setBadgeNumber:responseObject[@"status"]];
    } failure:^(NSError *error) {
         JWLog(@"%@",error);
    }];
}
-(void)setupTableView{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = color(217, 217, 217);
    self.tableView.sectionFooterHeight = 30;
    self.tableView.sectionHeaderHeight = 0;
    
}
-(void)setupRefreshControl{
    self.refreshControl = [[UIRefreshControl alloc]init];
    self.refreshControl.hidden = NO;
    [self.refreshControl addTarget:self action:@selector(refreshControlValueChanged:) forControlEvents:UIControlEventValueChanged];
}
/**
 *  获取用户的信息
 */
-(void)getUserInfo{
     /**
     *  account 信息的获取是在WBOAuthViewController的初始化中进行的
     */
    WBAccount *account = [WBAccountTool account];
    NSString *urlStr = [NSString stringWithFormat:@"https://api.weibo.com/2/users/show.json?access_token=%@&uid=%@",account.access_token,account.uid];
    [HttpTool get:urlStr params:nil
        success:^(id responseObject) {
            self.user = [WBUser mj_objectWithKeyValues:responseObject];
            account.screen_name = self.user.screen_name;
            [WBAccountTool saveAccount:account];
        } failure:^(NSError *error) {
             JWLog(@"%@",error);
        }];
    /** 获取未读更新微博数目*/
//    NSTimer *timer = [NSTimer timerWithTimeInterval:60 target:self selector:@selector(getUnreadCount) userInfo:nil repeats:YES];
//    [[NSRunLoop mainRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
    
}

-(void)setupNavigationItem{
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(frendSearch) imageName:@"navigationbar_friendsearch" selecteImageName:@"navigationbar_friendsearch_highlighted"];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) imageName:@"navigationbar_pop" selecteImageName:@"navigationbar_pop_highlighted"];
}

-(void)setupTitleView{
    LTButton *btn = [[LTButton alloc]init];
    btn.size = (CGSize){100,44};
    btn.currentFont = [UIFont boldSystemFontOfSize:18];
    //    btn.backgroundColor = [ UIColor redColor];
    //    btn.titleLabel.backgroundColor = [UIColor yellowColor];
    //    btn.imageView.backgroundColor = [UIColor blueColor];
    [btn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    NSString *title = self.user.screen_name.length>0?self.user.screen_name:@"主页";
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = btn;
}
/**
 *  显示新增加的微博数目：在navigationBar 中隐藏的
 *
 *  @param count 新增加微博数目
 */
-(void)showNewsStatusCount:(NSInteger)count{
   
    [UIView animateWithDuration:1.5 animations:^{
        NSString *message = count>0?[NSString stringWithFormat:@"新加载了%ld 条微博",count]:[NSString stringWithFormat:@"别老刷微博"];
        self.notifyHeader.text = message;
        self.notifyHeader.y = self.navigationController.navigationBar.height ;
        self.notifyHeader.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.5 animations:^{
            self.notifyHeader.alpha = 0;
            self.notifyHeader.y = self.notifyHeader.y = self.navigationController.navigationBar.height - self.notifyHeader.height;
        }];
    }];
}
#pragma mark Target-Action
/**
 *  点击加载更多请求数据
 */
-(void)footerClick:(UIButton*)btn{
    btn.selected = YES;
//    JWLog(@"正在加载中哦");
    WBAccount *account = [WBAccountTool account];
    WBStatusFrame *firstStatusF = self.statusFM.lastObject;
    NSString *urlStr = [NSString stringWithFormat:@"https://api.weibo.com/2/statuses/home_timeline.json?access_token=%@&max_id=%@",account.access_token,firstStatusF.status.idstr];
    
    [HttpTool get:urlStr params:nil success:^(id responseObject) {
        btn.selected = NO;
        NSMutableArray *newStatus = [WBStatus mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        //        JWLog(@"新加载了%d 条微博",newStatus.count);
        NSMutableArray *newStatusFM = [WBStatusFrame arrayWithStatusArray:newStatus];
        [self.statusFM addObjectsFromArray:newStatusFM];
        [self.tableView reloadData];
        [self showNewsStatusCount:newStatusFM.count];
    } failure:^(NSError *error) {
        btn.selected = NO;
        JWLog(@"%@",error);
    }];
}

/**
 *  加载用户的主页微博动态
 *
 *  @param refreshControl 下拉刷新获取微博
 */
-(void)refreshControlValueChanged:(UIRefreshControl*)refreshControl{
//    JWLog(@"正在加载中哦");
//     JWLog(@"%@",refreshControl);
    if (refreshControl.isRefreshing == NO) {
        [refreshControl beginRefreshing];
        
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSMutableArray *newStatus = [WBStatus mj_objectArrayWithFile:[[NSBundle mainBundle] pathForResource:@"bakStatus.plist" ofType:nil]];
//        JWLog(@"新加载了%ld 条微博",newStatus.count);
        NSMutableArray *newStatusFM = [WBStatusFrame arrayWithStatusArray:newStatus];
        [self showNewsStatusCount:newStatusFM.count];
        [self clearBadgeNumber];
        [self.statusFM insertObjects:newStatusFM atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, newStatusFM.count)]];
        [refreshControl endRefreshing];
        [self.tableView reloadData];
    });
    return;
    WBAccount *account = [WBAccountTool account];
    WBStatusFrame *lastStatusF = self.statusFM.firstObject;
    NSString *urlStr = [NSString stringWithFormat:@"https://api.weibo.com/2/statuses/home_timeline.json?access_token=%@&since_id=%@",account.access_token,lastStatusF.status.idstr];
    
    [HttpTool get:urlStr params:nil success:^(id responseObject) {
        [refreshControl endRefreshing];
        //        JWLog(@"%@",responseObject);
        NSMutableArray *newStatus = [WBStatus mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        /** 以下是进行的数组，字典，对象归档尝试，主要是加深了对与mjextesion的了解，同时归档后获取了假数据，以后没有网络，我们也可以进行测试了，而且我们的速度更快哦
         NSString *dir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
         NSString *filePath = [dir stringByAppendingPathComponent:@"bakStatus.plist"];
         if ([NSKeyedArchiver archiveRootObject:newStatus toFile:filePath]) {
         JWLog(@"归档成功");
         }else JWLog(@"归档失败");
         NSMutableArray *unarchiverObjects = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
         NSMutableArray *keyValues = [NSObject mj_keyValuesArrayWithObjectArray:newStatus];
         if ([keyValues writeToFile:filePath atomically:YES]) {
         JWLog(@"数组写入成功");
         }else JWLog(@"数组写入失败");
         
         filePath = [dir stringByAppendingPathComponent:@"bakStatus1.plist"];
         if ([responseObject writeToFile:filePath atomically:YES]) {
         JWLog(@"字典写入成功");
         }else JWLog("字典写入失败");
         */
        
        //        JWLog(@"新加载了%ld 条微博",newStatus.count);
        NSMutableArray *newStatusFM = [WBStatusFrame arrayWithStatusArray:newStatus];
        [self showNewsStatusCount:newStatusFM.count];
        [self clearBadgeNumber];
        [self.statusFM insertObjects:newStatusFM atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, newStatusFM.count)]];
        [self.tableView reloadData];

    } failure:^(NSError *error) {
        [refreshControl endRefreshing];
        JWLog(@"%@",error);
    }];
    }
-(void)clickBtn:(UIButton*)btn{
    
    WBTestTableViewController*controller = [[WBTestTableViewController alloc]init];
    controller.view.backgroundColor = [UIColor yellowColor];
    controller.view.size = (CGSize){150 ,150};
    WBPopMenu *menu = [WBPopMenu menu];
    menu.contentController = controller;
    menu.delegate = self;
    [menu showFrom:btn];
    
}

-(void)frendSearch{
    JWLog();
}
-(void)pop{
    JWLog();
}

#pragma mark - PopMenu Delegate
-(void)popMenuDidDismiss:(WBPopMenu*)menu{
    UIButton *btn = (UIButton*)self.navigationItem.titleView;
    btn.selected = NO;
}

-(void)popMenuWillShow:(WBPopMenu *)menu{
    UIButton *btn = (UIButton*)self.navigationItem.titleView;
    btn.selected = YES;
    
}
#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.statusFM.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static  NSString *identifier = @"WBTableViewCell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
//    }
//    cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:statusF.status.user.profile_image_url]]];
//    cell.detailTextLabel.text = statusF.status.text;
//    cell.textLabel.text = statusF.status.user.screen_name;
    WBStatusCell *cell = [WBStatusCell cellWithTableView:tableView style:UITableViewCellStyleSubtitle];
    WBStatusFrame *statusF = self.statusFM[indexPath.row];
    cell.statusF = statusF;
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (self.statusFM.count== 0) {
        return [[UIView alloc]initWithFrame:CGRectZero];
    }
    else return self.footerLoadMoreBtn;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.statusFM[indexPath.row] height];
}
#pragma mark - Table view Delegate
-(void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section{
    
    if (self.statusFM.count != 0 ) {
        [self footerClick:self.footerLoadMoreBtn];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    JWLog(@"selected--%d",indexPath.row);
}
@end
#warning 现在最后一条消息加载重复出现