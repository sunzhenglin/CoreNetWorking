//
//  TXLoginViewController.m
//  LoginAnimation
//
//  Created by xtz_pioneer on 2019/4/22.
//  Copyright © 2019 zhangxiong. All rights reserved.
//

#import "TXLoginViewController.h"
#import "TXLoginView.h"
#import "TXForgetPasswordViewController.h"
#import "UIViewController+HHTransition.h"
#import "XHLaunchAd.h"

@interface TXLoginViewController ()
/** 登录ViewModel */
@property (nonatomic,strong)TXLoginViewModel *loginViewModel;
/** 背景图 */
@property (nonatomic,strong)UIImageView *backgroundImageView;
/** logo */
@property (nonatomic,strong)UIImageView *logoImageView;
/** 登录视图 */
@property (nonatomic,strong)TXLoginView *loginView;
@end

@implementation TXLoginViewController

/** 懒加载登录ViewModel */
- (TXLoginViewModel*)loginViewModel{
    if (!_loginViewModel) {
        _loginViewModel = [[TXLoginViewModel alloc]init];
    }
    return _loginViewModel;
};

/** viewDidLoad */
- (void)viewDidLoad {
    [super viewDidLoad];
    [self enterAD];
    [self enterLogin];
    [self businessHandler];
}

/** 进入广告 */
- (void)enterAD{
    CGFloat viewW = self.view.frame.size.width;
    CGFloat viewH = self.view.frame.size.height;
    // 设置你工程的启动页使用的是:LaunchImage 还是 LaunchScreen.storyboard(不设置默认:LaunchImage)
    [XHLaunchAd setLaunchSourceType:SourceTypeLaunchImage];
    // 配置广告数据
    XHLaunchImageAdConfiguration *imageAdconfiguration = [XHLaunchImageAdConfiguration new];
    // 广告停留时间
    imageAdconfiguration.duration = 3.0;
    // 广告frame
    imageAdconfiguration.frame = CGRectMake(0, 0, viewW, viewH);
    // 广告显示完成动画
    imageAdconfiguration.showFinishAnimate = ShowFinishAnimateFadein;
    // 广告显示完成动画时间
    imageAdconfiguration.showFinishAnimateTime = 0.8;
    // 跳过按钮类型
    imageAdconfiguration.skipButtonType = SkipTypeNone;
    // 显示图片开屏广告
    [XHLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:self];
}

/** 进入登录 */
- (void)enterLogin{
    
    CGFloat viewW = self.view.frame.size.width;
    CGFloat viewH = self.view.frame.size.height;
    
    // 背景图
    CGFloat backgroundImageViewX = tRealLength(0);
    CGFloat backgroundImageViewY = tRealLength(0);
    CGFloat backgroundImageViewW = viewW;
    CGFloat backgroundImageViewH = viewH;
    NSBundle *myBundle = [TXURBundle bundleWithClass:self.class resource:TXNulleSchoolTeacherLoginModule_Bundle_Name];
    self.backgroundImageView=[[UIImageView alloc]initWithFrame:CGRectMake(backgroundImageViewX, backgroundImageViewY, backgroundImageViewW, backgroundImageViewH)];
    NSString *backgroundImagePath = [myBundle pathForResource:@"login_background_image" ofType:@"png" inDirectory:nil];
    UIImage *backgroundImage = [UIImage imageWithContentsOfFile:backgroundImagePath];
    self.backgroundImageView.image = backgroundImage;
    self.backgroundImageView.userInteractionEnabled = YES;
    [self.view addSubview:self.backgroundImageView];
    
    // logo
    CGFloat logoImageViewX = tRealLength(25);
    CGFloat logoImageViewW = viewW-logoImageViewX*2;
    CGFloat logoImageViewH = tRealLength(35);
    CGFloat logoImageViewY = tRealLength(100);
    self.logoImageView=[[UIImageView alloc]initWithFrame:CGRectMake(logoImageViewX, logoImageViewY, logoImageViewW, logoImageViewH)];
    NSString *logoImagePath = [myBundle pathForResource:@"login_logo" ofType:@"png" inDirectory:nil];
    UIImage *logoImage = [UIImage imageWithContentsOfFile:logoImagePath];
    self.logoImageView.image = logoImage;
    [self.backgroundImageView addSubview:self.logoImageView];
    
    // 登录视图
    CGFloat loginViewX = logoImageViewX;
    CGFloat loginViewY = CGRectGetMaxY(self.logoImageView.frame)+tRealLength(30);
    CGFloat loginViewW = viewW-loginViewX*2;
    CGFloat loginViewH = viewH-loginViewY-logoImageViewY;
    self.loginView=[[TXLoginView alloc]initWithFrame:CGRectMake(loginViewX, loginViewY, loginViewW, loginViewH)];
    [self.backgroundImageView addSubview:self.loginView];
    
}

/** 进入首页 */
- (void)enterHome{
    // 进入首页
    if ([TXUserDataManager userDataManager].logInInfo.logInState==TXLogInStateAlreadyLogin) {
        if (self.loginCompletionHandler) {
            // 设置请求头
            [TXLoginViewController setupRequestHeader];
            // 跳转到首页
            CGPoint point = [self.loginView convertPoint:self.loginView.login.center toView:self.backgroundImageView];
            [self hh_presentCircleVC:self.loginCompletionHandler(nil,[TXUserDataManager userDataManager]) point:point completion:nil];
        }
    }
}

/** 设置请求头 */
+ (void)setupRequestHeader{
    [TXNetWorking setRequestHeaderWithValue:[TXUserDataManager userDataManager].logInInfo.token forkey:@"Token"];
    [TXNetWorking setRequestHeaderWithValue:[NSString stringWithFormat:@"%ld",(long)[TXUserDataManager userDataManager].logInInfo.schoolId] forkey:@"schoolId"];
}

/** 移除请求头 */
+ (void)removeRequestHeader{
    [TXNetWorking setRequestHeaderWithValue:@"" forkey:@"Token"];
    [TXNetWorking setRequestHeaderWithValue:@"" forkey:@"schoolId"];
}

/** 移除用户全部数据(移除登录数据/用户数据/请求头) */
+ (void)removeUserAllData{
    [[TXUserDataManager userDataManager] removeUserData:TXRemoveUserDataTypeLogInInfo];
    [[TXUserDataManager userDataManager] removeUserData:TXRemoveUserDataTypeUserInfo];
    [TXLoginViewController removeRequestHeader];
}

/** 业务处理程序 */
- (void)businessHandler{
    __weak typeof(self) weakSelf=self;
    self.loginViewModel.completionHandler = ^(NSError *error, id obj) {
        if (weakSelf.loginViewModel.operationType==LROperationTypeLogIn) {
            if (!error) {
                TXNetModel * netModel = obj;
                // 设置登录数据
                [[TXUserDataManager userDataManager] setUserDataWithSetUserDataType:TXSetUserDataTypeLogInInfo parameters:netModel.data];
                // 设置请求头
                [TXLoginViewController setupRequestHeader];
                // 获取用户信息
                [weakSelf.loginViewModel getUserInfoWithToken:[TXUserDataManager userDataManager].logInInfo.token];
            }else{
                // 移除登录信息
                [[TXUserDataManager userDataManager] removeUserData:TXRemoveUserDataTypeLogInInfo];
                // 移除请求头
                [TXLoginViewController removeRequestHeader];
                // 错误提示
                [TXNetWorking showHUDWithShowHUDType:NWShowHUDTypeFailureInfo info:error.userInfo[@"msg"]];
                [weakSelf.loginView.login failedAnimationWithCompletion:^{}];
                if (weakSelf.loginCompletionHandler) weakSelf.loginCompletionHandler(error,obj);
            }
        }else if (weakSelf.loginViewModel.operationType==LROperationTypeGetUserInfo){
            if (!error) {
                TXNetModel * netModel = obj;
                // 设置用户数据
                [[TXUserDataManager userDataManager] setUserDataWithSetUserDataType:TXSetUserDataTypeUserInfo parameters:netModel.data];
                // 登录成功
                [weakSelf.loginView.login succeedAnimationWithCompletion:^{
                    if (weakSelf.loginCompletionHandler) {
                        // 技术点1 (将像素point由point所在视图转换到目标视图view中，返回在目标视图view中的像素值)
                        CGPoint point = [weakSelf.loginView convertPoint:weakSelf.loginView.login.center toView:weakSelf.backgroundImageView];
                        [weakSelf hh_presentCircleVC:weakSelf.loginCompletionHandler(error,[TXUserDataManager userDataManager]) point:point completion:nil];
                    }
                }];
            }else{
                // 移除用户全部数据(移除登录数据/用户数据/请求头)
                [TXLoginViewController removeUserAllData];
                // 错误提示
                [TXNetWorking showHUDWithShowHUDType:NWShowHUDTypeFailureInfo info:error.userInfo[@"msg"]];
                [weakSelf.loginView.login failedAnimationWithCompletion:^{}];
                if (weakSelf.loginCompletionHandler) weakSelf.loginCompletionHandler(error,obj);
            }
        }
    };
    
    // 登录
    self.loginView.loginCompletionHandler = ^(id  _Nonnull obj) {
        [weakSelf.loginViewModel loginWithAccount:weakSelf.loginView.username.text password:weakSelf.loginView.password.text];
    };
    
    // 忘记密码
    self.loginView.forgetPasswordCompletionHandler = ^(id  _Nonnull obj) {
        TXForgetPasswordViewController *forgetPasswordViewController = [TXForgetPasswordViewController new];
        forgetPasswordViewController.forgetPasswordCompletionHandler = weakSelf.forgetPasswordCompletionHandler;
        [weakSelf hh_presentBackScaleVC:forgetPasswordViewController height:tRealLength(300) completion:nil];
    };
    
}

/** 将要进入 */
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

/** 已经进入 */
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self enterHome];
}

/** 将要离开 */
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

/** 已经离开*/
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
