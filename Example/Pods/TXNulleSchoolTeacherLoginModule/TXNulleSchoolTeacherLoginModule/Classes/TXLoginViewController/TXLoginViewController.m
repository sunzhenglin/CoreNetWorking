//
//  TXLoginViewController.m
//  LoginAnimation
//
//  Created by xtz_pioneer on 2019/4/22.
//  Copyright © 2019 zhangxiong. All rights reserved.
//

#import "TXLoginViewController.h"
#import "TXLoginTextField.h"
#import "TXLoginButton.h"
#import "TXLoginViewModel.h"
#import "TXForgetPasswordViewController.h"

#import "UIViewController+HHTransition.h"
#import "XHLaunchAd.h"

@interface TXLoginViewController ()
/** 登录ViewModel */
@property (nonatomic,strong)TXLoginViewModel *loginViewModel;
/** 背景层  */
@property (nonatomic,strong)CAGradientLayer *backgroundLayer;
/** 用户名  */
@property (nonatomic,strong)TXLoginTextField *username;
/** 登录密码  */
@property (nonatomic,strong)TXLoginTextField *password;
/** 登录按钮  */
@property (nonatomic,strong)TXLoginButton *login;
/** 忘记密码按钮  */
@property (nonatomic,strong)UIButton *forgetPassword;
@end

@implementation TXLoginViewController

/** 背景层 */
- (CAGradientLayer *)backgroundLayer{
    if (!_backgroundLayer) {
        _backgroundLayer = [CAGradientLayer layer];
        _backgroundLayer.frame = self.view.bounds;
        _backgroundLayer.colors = @[(__bridge id)TXLFRGBA(33,148,249,1.f).CGColor,(__bridge id)[UIColor cyanColor].CGColor];
        _backgroundLayer.startPoint = CGPointMake(0.5, 0);
        _backgroundLayer.endPoint = CGPointMake(0.5, 1);
        _backgroundLayer.locations = @[@0.68,@1];
        [self.view.layer addSublayer:_backgroundLayer];
    }
    return _backgroundLayer;
}

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
    [self backgroundLayer];
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
    imageAdconfiguration.duration = 3;
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

/** 移除用户全部数据(移除登录数据/用户数据/请求头)*/
+ (void)removeUserAllData{
    [[TXUserDataManager userDataManager] removeUserData:TXRemoveUserDataTypeLogInInfo];
    [[TXUserDataManager userDataManager] removeUserData:TXRemoveUserDataTypeUserInfo];
    [TXLoginViewController removeRequestHeader];
}

/** 进入首页 */
- (void)enterHome{
    // 进入首页
    if ([TXUserDataManager userDataManager].logInInfo.logInState==TXLogInStateAlreadyLogin) {
        if (self.loginCompletionHandler) {
            // 设置请求头
            [TXLoginViewController setupRequestHeader];
            // 跳转到首页
            [self hh_presentCircleVC:self.loginCompletionHandler(nil,[TXUserDataManager userDataManager]) point:self.login.center completion:nil];
        }
    }
}

/** 设置布局 */
- (void)setupLayout{
    CGFloat viewW = self.view.frame.size.width;
    CGFloat viewH = self.view.frame.size.height;
    // 标题
    CGFloat titleLabelW = tRealLength(300);
    CGFloat titleLabelH = tRealLength(50);
    CGFloat titleLabelX = (viewW-titleLabelW)/2;
    CGFloat titleLabelY = tRealLength(100);
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"纳乐智校教师端";
    titleLabel.font = [UIFont systemFontOfSize:tRealFontSize(35.f)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    // 用户名
    CGFloat usernameW = tRealLength(270);
    CGFloat usernameH = tRealLength(30);
    CGFloat usernameX = (viewW-usernameW)/2;
    CGFloat usernameY = CGRectGetMaxY(titleLabel.frame)+tRealLength(100);
    self.username = [[TXLoginTextField alloc]initWithFrame:CGRectMake(usernameX, usernameY, usernameW, usernameH)];
    self.username.tx_placeholder = @"请输入账号";
    self.username.placeholderNormalStateColor = [UIColor whiteColor];
    self.username.placeholderSelectStateColor = [UIColor whiteColor];
    [self.view addSubview:self.username];
    // 密码
    CGFloat passwordX = usernameX;
    CGFloat passwordY = CGRectGetMaxY(self.username.frame)+tRealLength(35);
    CGFloat passwordW = usernameW;
    CGFloat passwordH = usernameH;
    self.password = [[TXLoginTextField alloc]initWithFrame:CGRectMake(passwordX, passwordY, passwordW, passwordH)];
    self.password.tx_placeholder = @"请输入密码";
    self.password.placeholderNormalStateColor = [UIColor whiteColor];
    self.password.placeholderSelectStateColor = [UIColor whiteColor];
    self.password.textColor = [UIColor whiteColor];
    self.password.secureTextEntry = YES;
    [self.view addSubview:self.password];
    // 登录按钮
    CGFloat loginW = tRealLength(200);
    CGFloat loginH = tRealLength(40);
    CGFloat loginX = (viewW-loginW)/2;
    CGFloat loginY = CGRectGetMaxY(self.password.frame)+tRealLength(80);
    self.login= [[TXLoginButton alloc]initWithFrame:CGRectMake(loginX, loginY, loginW, loginH)];
    [self.login setTitle:@"登录" forState:UIControlStateNormal];
    [self.login setBackgroundColor:[UIColor colorWithRed:1 green:0.f/255.0f blue:128.0f/255.0f alpha:1]];
    [self.login addTarget:self action:@selector(loginEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.login];
    // 忘记密码
    CGFloat forgetPasswordW = tRealLength(300);
    CGFloat forgetPasswordH = tRealLength(30);
    CGFloat forgetPasswordX = (viewW-forgetPasswordW)/2;
    CGFloat forgetPasswordY = CGRectGetMaxY(self.login.frame)+tRealLength(80);
    UIButton *forgetPassword = [[UIButton alloc]initWithFrame:CGRectMake(forgetPasswordX, forgetPasswordY, forgetPasswordW, forgetPasswordH)];
    [forgetPassword setTitle:@"忘记密码？请点击这里。" forState:UIControlStateNormal];
    [forgetPassword setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [forgetPassword setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    forgetPassword.titleLabel.font=[UIFont systemFontOfSize:tRealFontSize(13.f)];
    [forgetPassword addTarget:self action:@selector(forgetPasswordEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetPassword];
}

/** 移除布局 */
- (void)removeLayout{
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
}

/** 忘记密码 */
- (void)forgetPasswordEvent:(id)sender{
    TXForgetPasswordViewController *forgetPasswordViewController = [TXForgetPasswordViewController new];
    forgetPasswordViewController.forgetPasswordCompletionHandler = self.forgetPasswordCompletionHandler;
    [self hh_presentBackScaleVC:forgetPasswordViewController height:tRealLength(300) completion:nil];
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
                [weakSelf.login failedAnimationWithCompletion:^{
                    [TXNetWorking showHUDWithShowHUDType:NWShowHUDTypeFailureInfo info:error.userInfo[@"msg"]];
                    if (weakSelf.loginCompletionHandler) weakSelf.loginCompletionHandler(error,obj);
                }];
            }
        }else if (weakSelf.loginViewModel.operationType==LROperationTypeGetUserInfo){
            if (!error) {
                TXNetModel * netModel = obj;
                // 设置用户数据
                [[TXUserDataManager userDataManager] setUserDataWithSetUserDataType:TXSetUserDataTypeUserInfo parameters:netModel.data];
                // 登录成功
                [weakSelf.login succeedAnimationWithCompletion:^{
                    if (weakSelf.loginCompletionHandler) {
                        [weakSelf hh_presentCircleVC:weakSelf.loginCompletionHandler(error,[TXUserDataManager userDataManager]) point:weakSelf.login.center completion:nil];
                    }
                }];
            }else{
                // 移除用户全部数据(移除登录数据/用户数据/请求头)
                [TXLoginViewController removeUserAllData];
                // 错误提示
                [weakSelf.login failedAnimationWithCompletion:^{
                    [TXNetWorking showHUDWithShowHUDType:NWShowHUDTypeFailureInfo info:error.userInfo[@"msg"]];
                    if (weakSelf.loginCompletionHandler) weakSelf.loginCompletionHandler(error,obj);
                }];
            }
        }
    };
}

/** 登录事件 */
- (void)loginEvent:(TXLoginButton *)button{
    [self.loginViewModel loginWithAccount:self.username.text password:self.password.text];
}

/** 将要进入 */
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self enterAD];
    [self setupLayout];
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
    [self removeLayout];
    [XHLaunchAd removeAndAnimated:YES];
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
