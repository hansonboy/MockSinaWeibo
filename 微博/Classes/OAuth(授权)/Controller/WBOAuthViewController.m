//
//  WBOAuthViewController.m
//  JW微博JW
//
//  Created by wangjianwei on 15/12/14.
//  Copyright © 2015年 JW. All rights reserved.
//

#import "WBOAuthViewController.h"
#import "HttpTool.h"
#import "WMTabBarController.h"
#import "WBAccountTool.h"
#import "MBProgressHUD+MJ.h"
@interface WBOAuthViewController ()<UIWebViewDelegate>
@property (strong,nonatomic)UIWebView *webView;

@end

@implementation WBOAuthViewController


-(UIWebView *)webView{
    if (_webView == nil) {
        _webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:_webView];
        _webView.delegate = self;
    }
    return _webView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupWebView];
    
    [MBProgressHUD showMessage:@"正在加载数据..."];
}
-(void)setupWebView{
    NSString *urlStr = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",appKey,redirect_uri];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:5];
    [self.webView loadRequest:request];
}
#pragma  mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
//    JWLog();
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
//    JWLog();
    [MBProgressHUD hideHUD];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error{
    JWLog(@"%@",error);
    [MBProgressHUD hideHUD];
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
     NSString *code = [self getCode:request];
    if (code.length != 0) {
        JWLog(@"code----%@",code);
        [self getAccess_token:code];
        return NO;
    }
    return YES;
}
-(NSString*)getCode:(NSURLRequest*)request{
    NSString *urlStr = request.URL.absoluteString;
    NSRange indexRange = [urlStr  rangeOfString:@"code="];
    NSString *code;
    if (indexRange.location != NSNotFound) {
        code = [urlStr substringFromIndex:indexRange.location+indexRange.length];
    }
    return code;
}
-(void)getAccess_token:(NSString*)code
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = appKey;
    params[@"client_secret"] = appSecret;
    params[@"grant_type"] = @"authorization_code";
    params[@"redirect_uri"] = redirect_uri;
    params[@"code"] = code;
    
    [HttpTool post:@"https://api.weibo.com/oauth2/access_token" params:params
           success:^(id responseObject) {
               WBAccount *account = [WBAccount mj_objectWithKeyValues:responseObject];
               JWLog(@"%@",account);
               [WBAccountTool saveAccount:account];
               
               UIWindow *window = [UIApplication sharedApplication].keyWindow;
               [window switchRootViewController];
               
           } failure:^(NSError *error) {
                JWLog(@"error-----%@",error);
           }];

}



@end
