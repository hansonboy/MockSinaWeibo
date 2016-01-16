//
//  WBComposeViewController.m
//  JW微博JW
//
//  Created by wangjianwei on 15/12/30.
//  Copyright © 2015年 JW. All rights reserved.
//

#import "WBComposeViewController.h"
#import "WBAccountTool.h"
//#import "WBEmotionTool.h"
#import "WBEmotionTool2.h"
#import "WBComposeTextView.h"
#import "WBComposeToolbar.h"
#import "WBEmotion.h"
#import "WBEmotionKeyboard.h"
#import "WBEmotionAttachment.h"
#define kWBComposeTitleTopFont [UIFont boldSystemFontOfSize:15]
#define kWBComposeTitleBottomFont [UIFont systemFontOfSize:13]
#define kPhotosViewMargin 40

@interface WBComposeViewController()<UITextViewDelegate,WBComposeToolbarDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (strong,nonatomic)WBEmotionKeyboard *emotionKeyboard;
@property (weak,nonatomic)WBComposeTextView *textView;
@property (weak,nonatomic)UIImageView *photosView;
@property (weak,nonatomic)WBComposeToolbar *toolbar;
@property (assign,nonatomic)BOOL switchKeyboarding;
@end
@implementation WBComposeViewController
#pragma mark - lazy load
-(WBEmotionKeyboard *)emotionKeyboard{
    if (_emotionKeyboard == nil) {
        WBEmotionKeyboard *keyboard = [[WBEmotionKeyboard alloc]init];
        keyboard.height = 216;
        keyboard.width = self.view.width;
        keyboard.x = keyboard.y = 0;
        _emotionKeyboard = keyboard;
    }
    return _emotionKeyboard;
}
#pragma mark - View Controller LifeCycle
-(instancetype)init{
    if (self = [super init]) {
       
    }
    return self;
}
-(void)viewDidLoad{
//    JWLog();
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupNavi];
    
    [self setupTextView];
    
    [self setupToolbar];
    
    [self setupPhotosView];
    
    
}

#pragma mark - 初始化
-(void)setupPhotosView{

    UIImageView *photosView = [[UIImageView alloc]initWithFrame:CGRectMake(0, kPhotosViewMargin, 100, 100)];
    [self.textView addSubview:photosView];
    photosView.contentMode = UIViewContentModeScaleAspectFit;
    photosView.clipsToBounds = YES;
    self.photosView = photosView;
    
}
-(void)setupToolbar{
    WBComposeToolbar *toolbar = [WBComposeToolbar toolbar];
    toolbar.frame = CGRectMake(0, self.view.height-kTabBarH, self.view.width, kTabBarH  );
    toolbar.delegate =self;
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
}

-(void)setupTextView{
    WBComposeTextView *textView = [[WBComposeTextView alloc]initWithFrame:self.view.bounds];
    textView.backgroundColor = [UIColor whiteColor];
    textView.height -= kTabBarH;
    textView.delegate = self;
    textView.alwaysBounceVertical = YES;
    textView.showsHorizontalScrollIndicator = NO;
    textView.showsVerticalScrollIndicator = NO;
    textView.placeholder = @"分享新鲜事...";
    textView.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:textView];
    self.textView = textView;
    
    [kNotificationCenter addObserver:self selector:@selector(KeyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [self.textView becomeFirstResponder];
    
    [kNotificationCenter addObserver:self selector:@selector(emotionButtonClick:) name:WBEmotionButtonDidClickNotification object:nil];
    [kNotificationCenter addObserver:self selector:@selector(backSpaceButtonClick:) name:WBEmotionBackSpaceButtonClickNotification object:nil];
}
-(void)setupNavi{
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
     self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(send)];
    
    WBAccount *account = [WBAccountTool account];
    JWLog(@"%@",account.screen_name);
    NSString *titlePrefix = [NSString stringWithFormat:@"发微博\n"];
    NSString *titleSuffix = account.screen_name;
    NSString *title = [NSString stringWithFormat:@"%@%@",titlePrefix,titleSuffix];
    NSMutableAttributedString *str  = [[NSMutableAttributedString alloc]initWithString:title];
    [str addAttribute:NSFontAttributeName value:kWBComposeTitleTopFont range:[title rangeOfString:titlePrefix]];
    [str addAttribute:NSFontAttributeName value:kWBComposeTitleBottomFont range:[title rangeOfString:titleSuffix]];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
    label.attributedText = str;
    label.numberOfLines = 0;
    [label setTextAlignment:NSTextAlignmentCenter];
    self.navigationItem.titleView =label;
}
#pragma mark - Action
/**
 *  发送微博
 */
-(void)send{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self sendWithoutImage];
    [self sendWithImage];
}
-(void)sendWithImage{
    if(self.textView.text.length > 0 && self.photosView.image){
        /**
         *  https://upload.api.weibo.com/2/statuses/upload.json
         *  access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
         *  status	true	string	要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。
         *  pic	true	binary	要上传的图片，仅支持JPEG、GIF、PNG格式，图片大小小于5M。
         */
        AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"access_token"] = [WBAccountTool account].access_token;
        params[@"status"] = self.textView.text;
      
        [manager POST:[NSString stringWithFormat:@"https://upload.api.weibo.com/2/statuses/upload.json"] parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            [formData appendPartWithFileData:UIImagePNGRepresentation(self.photosView.image) name:@"pic" fileName:@"图片" mimeType:@"application/octet-stream"];
            
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [MBProgressHUD showSuccess:@"发布成功"];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            JWLog(@"%@",error);
            [MBProgressHUD showError:@"发送失败"];
        }];
    }
}
-(void)sendWithoutImage{
    if (self.textView.text.length > 0 && self.photosView.image == nil) {
        /**
         *  https://api.weibo.com/2/statuses/update.json
         *  access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
         *  status	true	string	要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。
         */
        AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"access_token"] = [WBAccountTool account].access_token;
        params[@"status"] = self.textView.text;
        params[@"status"] = self.textView.fullText;
        
        [manager POST:[NSString stringWithFormat:@"https://api.weibo.com/2/statuses/update.json"] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [MBProgressHUD showSuccess:@"发送成功"];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [MBProgressHUD showError:@"发送失败"];
        }];
    }
}
-(void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - Notification Method
-(void)KeyboardWillChangeFrame:(NSNotification*)notification{
    JWLog(@"%@",notification);
    if (self.switchKeyboarding) {
        self.switchKeyboarding = NO;
        return;
    }
    [UIView animateWithDuration:[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]  animations:^{
        self.toolbar.y = CGRectGetMinY([notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue]) - self.toolbar.height;
        JWLog(@"%@",NSStringFromCGRect(self.toolbar.frame));
    }];
}
-(void)emotionButtonClick:(NSNotification*)noti{
    WBEmotion *emotion = noti.userInfo[WBEmotionButtonUserInfoKey];
    //插入emotion 表情textView中
    [self.textView insertEmotion:emotion];
    //将显示过的Emotion 收藏到最近使用的表情中
    [kWBEmotionTool2 saveEmotion:emotion];
    
    [self.emotionKeyboard setNeedsLayout];
    
}
-(void)backSpaceButtonClick:(NSNotification*)noti{
    [self.textView deleteBackward];
}
#pragma mark - WBComposeToolbarDelegate
-(void)composeToolBar:(WBComposeToolbar *)toolbar didClickBtn:(UIButton *)btn{
    WBComposeToolbarButtonType type = btn.tag;
    switch (type) {
        case WBComposeToolbarButtonTypeCarmera:
            JWLog(@"WBComposeToolbarButtonTypeCarmera");
            [self pickPhotoWithSourceType:UIImagePickerControllerSourceTypeCamera];
            break;
        case WBComposeToolbarButtonTypePic:
            JWLog(@"WBComposeToolbarButtonTypePic");
            [self pickPhotoWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            break;
        case WBComposeToolbarButtonTypeEmotion:
            JWLog(@"WBComposeToolbarButtonTypeEmotion");
            [self switchEmotionKeyboard];
            break;
        case WBComposeToolbarButtonTypeTrend:
            JWLog(@"WBComposeToolbarButtonTypeTrend");
            break;
        case WBComposeToolbarButtonTypeMention:
            JWLog(@"WBComposeToolbarButtonTypeMention");
            break;
        default:
            break;
    }
}

#pragma mark click method
-(void)switchEmotionKeyboard{
    if (self.textView.inputView == nil) { //系统自带的键盘
        self.textView.inputView = self.emotionKeyboard;
        self.toolbar.showSystemKeyboard = YES;
    }else{//表情键盘
        self.textView.inputView = nil; //恢复到系统自带的键盘
        self.toolbar.showSystemKeyboard = NO;
    }
    //当我们toolbar 在底部切换键盘的时候，我们希望toolbar随着键盘动，当不在底部切换键盘的时候，我们希望当键盘下去的时候，我们的toolbar 保持不动，当键盘切换上来的时候，我们的toolbar 在随着键盘移动
    self.switchKeyboarding = (self.toolbar.y != self.view.height - self.toolbar.height);
    
    [self.textView endEditing:YES];
    [self.textView becomeFirstResponder];
}
-(void)pickPhotoWithSourceType:(UIImagePickerControllerSourceType)type{
    UIImagePickerController *ipc = [[UIImagePickerController alloc]init];
    if ([UIImagePickerController isSourceTypeAvailable:type]) {
        ipc.sourceType = type;
        ipc.delegate = self;
        [self presentViewController:ipc animated:YES completion:nil];
    }
}
#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
//    JWLog(@"%@",info);
    self.photosView.image = [info[UIImagePickerControllerOriginalImage] fixOrientationImage];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
#pragma mark - UITextViewDelegate

-(void)textViewDidChange:(UITextView *)textView{
//    JWLog();
    CGFloat textHeight = [textView.text boundingRectWithSize:CGSizeMake(textView.width, textView.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:textView.font} context:nil].size.height;
    if (textHeight + kWBPlaceHolderY > kPhotosViewMargin) {
        [UIView animateWithDuration:0.25 animations:^{
            self.photosView.y =  textHeight + kPhotosViewMargin;
//            JWLog(@"%@",NSStringFromCGRect(self.photosView.frame));
        }];
    }
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    JWLog();
    [self.view endEditing:YES];
}


-(void)dealloc{
    [kNotificationCenter removeObserver:self name:WBEmotionBackSpaceButtonClickNotification object:nil];
    [kNotificationCenter removeObserver:self name:WBEmotionButtonDidClickNotification object:nil];
    [kWBEmotionTool2 sync];
}
-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
//    JWLog();
}
@end
