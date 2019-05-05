//
//  TXForgetPasswordViewController.m
//  LoginAnimation
//
//  Created by xtz_pioneer on 2019/4/24.
//  Copyright © 2019 zhangxiong. All rights reserved.
//

#import "TXForgetPasswordViewController.h"
#import "TXFInputPhoneNumberView.h"
#import "TXLoginViewModel.h"
#import "TXFInputVerificationCodeView.h"
#import "TXFInputPasswordView.h"
#import "TXFChangePasswordModel.h"

/** 显示功能类型 */
typedef NS_ENUM(NSInteger,LRViewFunctionType){
    /** 输入手机号码 */
    LRViewFunctionTypeInputPhoneNumber =0,
    /** 视图功能输入手机号 */
    LRViewFunctionTypeInputVerificationCode =1,
    /** 视图功能输入密码 */
    LRViewFunctionTypeInputPassword =2,
};

@interface TXForgetPasswordViewController ()
/** 背景图 */
@property (nonatomic,strong)UIImageView *backgroundImageView;
/** 登录ViewModel */
@property (nonatomic,strong)TXLoginViewModel *loginViewModel;
/** 输入手机号 */
@property (nonatomic,weak)TXFInputPhoneNumberView *inputPhoneNumberView;
/** 输入验证码 */
@property (nonatomic,weak)TXFInputVerificationCodeView *inputVerificationCodeView;
/** 输入密码码 */
@property (nonatomic,weak)TXFInputPasswordView *inputPasswordView;
/** 向下按钮 */
@property (nonatomic,weak)UIButton *downButton;
/** 显示功能类型 */
@property (nonatomic,assign)LRViewFunctionType viewFunctionType;
/** 向下按钮 */
@property (nonatomic,strong)TXFChangePasswordModel *changePasswordModel;
@end

@implementation TXForgetPasswordViewController

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
    [self setupLayout];
    [self businessHandler];
    // Do any additional setup after loading the view.
}

/** 设置设置视图 */
- (void)setupLayout{
    
    CGFloat viewW = self.view.frame.size.width;
    CGFloat viewH = self.view.frame.size.height;

    // 背景图
    CGFloat backgroundImageViewX = tRealLength(0);
    CGFloat backgroundImageViewY = tRealLength(0);
    CGFloat backgroundImageViewW = viewW;
    CGFloat backgroundImageViewH = viewH;
    NSBundle *myBundle = [TXURBundle bundleWithClass:self.class resource:TXNulleSchoolTeacherLoginModule_Bundle_Name];
    self.backgroundImageView=[[UIImageView alloc]initWithFrame:CGRectMake(backgroundImageViewX, backgroundImageViewY, backgroundImageViewW, backgroundImageViewH)];
    NSString *backgroundImagePath = [myBundle pathForResource:@"forget_password_background_image" ofType:@"png" inDirectory:nil];
    UIImage *backgroundImage = [UIImage imageWithContentsOfFile:backgroundImagePath];
    self.backgroundImageView.image = backgroundImage;
    self.backgroundImageView.userInteractionEnabled = YES;
    [self.view addSubview:self.backgroundImageView];
    // 向下
    UIButton *downButton = [UIButton buttonWithType:UIButtonTypeCustom];
    NSString *imagePath=[myBundle pathForResource:@"forget_password_down" ofType:@"png" inDirectory:nil];
    UIImage *image=[UIImage imageWithContentsOfFile:imagePath];
    [downButton setImage:image forState:UIControlStateNormal];
    [downButton addTarget:self action:@selector(downEvent:) forControlEvents:UIControlEventTouchUpInside];
    // 输入手机号
    TXFInputPhoneNumberView *inputPhoneNumberView = [[TXFInputPhoneNumberView alloc]init];
    // 输入验证码
    TXFInputVerificationCodeView *inputVerificationCodeView = [[TXFInputVerificationCodeView alloc]init];
    // 输入密码
    TXFInputPasswordView *inputPasswordView = [[TXFInputPasswordView alloc]init];
    // 添加视图
    [self.backgroundImageView addSubview:downButton];
    [self.backgroundImageView addSubview:inputPhoneNumberView];
    [self.backgroundImageView addSubview:inputVerificationCodeView];
    [self.backgroundImageView addSubview:inputPasswordView];
    // 赋值
    self.downButton = downButton;
    self.inputPhoneNumberView = inputPhoneNumberView;
    self.inputVerificationCodeView = inputVerificationCodeView;
    self.inputPasswordView = inputPasswordView;
}

/** 布局视图 */
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    CGFloat viewW = self.view.frame.size.width;
    CGFloat viewH = self.view.frame.size.height;
    // 绘制圆角 要设置的圆角 使用“|”来组合
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.view.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(tRealLength(15), tRealLength(15))];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.view.bounds;
    maskLayer.path = maskPath.CGPath;
    self.view.layer.mask = maskLayer;
    // 向下按钮
    CGFloat downButtonW = tRealLength(50);
    CGFloat downButtonH = tRealLength(30);
    CGFloat an = tRealLength(24);
    CGFloat downButtonX = (viewW-downButtonW)/2;
    CGFloat downButtonY = viewH-an-downButtonH;
    self.downButton.frame=CGRectMake(downButtonX, downButtonY, downButtonW, downButtonH);
    // 视图功能输入手机号
    [self viewFunctionTypeInputPhoneNumber];
}

/** 向下事件 */
- (void)downEvent:(id)sender{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

/** 业务处理程序 */
- (void)businessHandler{
    __weak typeof(self) weakSelf=self;
    self.loginViewModel.completionHandler = ^(NSError *error, id obj) {
        if (weakSelf.loginViewModel.operationType==LROperationTypeGetForgotPasswordVerificationCode) {
            if (!error) {
                // 验证码获取成功
                [weakSelf.inputPhoneNumberView.next succeedAnimationWithCompletion:^{
                    weakSelf.viewFunctionType=LRViewFunctionTypeInputVerificationCode;
                }];
            }else{
                // 验证码获取失败
                [TXNetWorking showHUDWithShowHUDType:NWShowHUDTypeFailureInfo info:error.userInfo[@"msg"]];
                [weakSelf.inputPhoneNumberView.next failedAnimationWithCompletion:^{}];
            }
        }else if (weakSelf.loginViewModel.operationType==LROperationTypeChangePassword){
            if (!error) {
                // 修改成功
                [weakSelf.inputPasswordView.next succeedAnimationWithCompletion:^{
                    [TXNetWorking showHUDWithShowHUDType:NWShowHUDTypeSuccessInfo info:@"密码修改成功"];
                     if (weakSelf.forgetPasswordCompletionHandler) weakSelf.forgetPasswordCompletionHandler();
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.128 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [weakSelf dismissViewControllerAnimated:YES completion:nil];
                    });
                }];
            }else{
                // 修改失败
                [TXNetWorking showHUDWithShowHUDType:NWShowHUDTypeFailureInfo info:error.userInfo[@"msg"]];
                [weakSelf.inputPasswordView.next failedAnimationWithCompletion:^{}];
            }
        }
    };
    
    // 输入手机号码 下一步
    self.inputPhoneNumberView.nextCompletionHandler = ^(id  _Nonnull obj) {
        weakSelf.changePasswordModel.account=weakSelf.inputPhoneNumberView.textField.text;
        // 获取验证码
        [weakSelf.loginViewModel getForgotPasswordVerificationCodeWithPhoneNumber:weakSelf.inputPhoneNumberView.textField.text];
    };
    
    // 输入验证码 下一步
    self.inputVerificationCodeView.verificationCodeView.completionHandler = ^(NSString *str) {
        weakSelf.changePasswordModel.verificationCode=str;
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
        weakSelf.viewFunctionType=LRViewFunctionTypeInputPassword;
    };

    // 输入验证码 上一步
    self.inputVerificationCodeView.upCompletionHandler = ^(id  _Nonnull obj) {
        weakSelf.viewFunctionType=LRViewFunctionTypeInputPhoneNumber;
    };
    
    // 输入密码 下一步
    self.inputPasswordView.nextCompletionHandler = ^(id  _Nonnull obj) {
        weakSelf.changePasswordModel.password=weakSelf.inputPasswordView.password.text;
        weakSelf.changePasswordModel.confirmPassword=weakSelf.inputPasswordView.confirmPassword.text;
        // 修改密码
        [weakSelf.loginViewModel changePasswordWithAccount:weakSelf.changePasswordModel.account verificationCode:weakSelf.changePasswordModel.verificationCode password:weakSelf.changePasswordModel.password confirmPassword:weakSelf.changePasswordModel.confirmPassword];
    };
    
    // 输入密码 上一步
    self.inputPasswordView.upCompletionHandler = ^(id  _Nonnull obj) {
        weakSelf.viewFunctionType=LRViewFunctionTypeInputVerificationCode;
    };
    
    // 初始化修改密码模型
    self.changePasswordModel=[TXFChangePasswordModel new];
}

/** 显示功能类型 */
- (void)setViewFunctionType:(LRViewFunctionType)viewFunctionType{
    _viewFunctionType=viewFunctionType;
    __weak typeof(self) weakSelf=self;
    switch (_viewFunctionType) {
        case LRViewFunctionTypeInputPhoneNumber:{
            [UIView animateWithDuration:0.25 animations:^{
                [weakSelf viewFunctionTypeInputPhoneNumber];
            }];
        }
            break;
        case LRViewFunctionTypeInputVerificationCode:{
            [UIView animateWithDuration:0.25 animations:^{
                [weakSelf viewFunctionTypeInputVerificationCode];
            }];
        }
            break;
        case LRViewFunctionTypeInputPassword:{
            [UIView animateWithDuration:0.25 animations:^{
                [weakSelf viewFunctionTypeInputPassword];
            }];
        }
            break;
        default:
            break;
    }
}

/** 视图功能输入手机号 */
- (void)viewFunctionTypeInputPhoneNumber{
    // 向下按钮
    CGFloat downButtonH = tRealLength(30);
    CGFloat an = tRealLength(24);
    CGFloat viewW = self.view.frame.size.width;
    CGFloat viewH = self.view.frame.size.height-downButtonH-an;
    
    // 输入手机号
    CGFloat inputPhoneNumberViewX = tRealLength(0);
    CGFloat inputPhoneNumberViewY = tRealLength(0);
    CGFloat inputPhoneNumberViewW = viewW;
    CGFloat inputPhoneNumberViewH = viewH;
    self.inputPhoneNumberView.frame = CGRectMake(inputPhoneNumberViewX, inputPhoneNumberViewY, inputPhoneNumberViewW, inputPhoneNumberViewH);
    
    // 输入验证码
    CGFloat inputVerificationCodeViewX = viewW*2;
    CGFloat inputVerificationCodeViewY = inputPhoneNumberViewY;
    CGFloat inputVerificationCodeViewW = inputPhoneNumberViewW;
    CGFloat inputVerificationCodeViewH = inputPhoneNumberViewH;
    self.inputVerificationCodeView.frame=CGRectMake(inputVerificationCodeViewX, inputVerificationCodeViewY, inputVerificationCodeViewW, inputVerificationCodeViewH);
    
    // 输入密码
    CGFloat inputPasswordViewX = viewW*3;
    CGFloat inputPasswordViewY = inputPhoneNumberViewY;
    CGFloat inputPasswordViewW = inputPhoneNumberViewW;
    CGFloat inputPasswordViewH = inputPhoneNumberViewH;
    self.inputPasswordView.frame=CGRectMake(inputPasswordViewX, inputPasswordViewY, inputPasswordViewW, inputPasswordViewH);
}

/** 视图功能输入验证码 */
- (void)viewFunctionTypeInputVerificationCode{
    // 向下按钮
    CGFloat downButtonH = tRealLength(30);
    CGFloat an = tRealLength(24);
    CGFloat viewW = self.view.frame.size.width;
    CGFloat viewH = self.view.frame.size.height-downButtonH-an;
    
    // 输入手机号
    CGFloat inputPhoneNumberViewX = -viewW;
    CGFloat inputPhoneNumberViewY = tRealLength(0);
    CGFloat inputPhoneNumberViewW = viewW;
    CGFloat inputPhoneNumberViewH = viewH;
    self.inputPhoneNumberView.frame = CGRectMake(inputPhoneNumberViewX, inputPhoneNumberViewY, inputPhoneNumberViewW, inputPhoneNumberViewH);
    
    // 输入验证码
    CGFloat inputVerificationCodeViewX = tRealLength(0);
    CGFloat inputVerificationCodeViewY = inputPhoneNumberViewY;
    CGFloat inputVerificationCodeViewW = inputPhoneNumberViewW;
    CGFloat inputVerificationCodeViewH = inputPhoneNumberViewH;
    self.inputVerificationCodeView.frame=CGRectMake(inputVerificationCodeViewX, inputVerificationCodeViewY, inputVerificationCodeViewW, inputVerificationCodeViewH);
    
    // 输入密码
    CGFloat inputPasswordViewX = viewW*2;
    CGFloat inputPasswordViewY = inputPhoneNumberViewY;
    CGFloat inputPasswordViewW = inputPhoneNumberViewW;
    CGFloat inputPasswordViewH = inputPhoneNumberViewH;
    self.inputPasswordView.frame=CGRectMake(inputPasswordViewX, inputPasswordViewY, inputPasswordViewW, inputPasswordViewH);
}

/** 视图功能输入密码 */
- (void)viewFunctionTypeInputPassword{
    // 向下按钮
    CGFloat downButtonH = tRealLength(30);
    CGFloat an = tRealLength(24);
    CGFloat viewW = self.view.frame.size.width;
    CGFloat viewH = self.view.frame.size.height-downButtonH-an;
    
    // 输入手机号
    CGFloat inputPhoneNumberViewX = -viewW*3;
    CGFloat inputPhoneNumberViewY = tRealLength(0);
    CGFloat inputPhoneNumberViewW = viewW;
    CGFloat inputPhoneNumberViewH = viewH;
    self.inputPhoneNumberView.frame = CGRectMake(inputPhoneNumberViewX, inputPhoneNumberViewY, inputPhoneNumberViewW, inputPhoneNumberViewH);
    
    // 输入验证码
    CGFloat inputVerificationCodeViewX = -viewW*2;
    CGFloat inputVerificationCodeViewY = inputPhoneNumberViewY;
    CGFloat inputVerificationCodeViewW = inputPhoneNumberViewW;
    CGFloat inputVerificationCodeViewH = inputPhoneNumberViewH;
    self.inputVerificationCodeView.frame=CGRectMake(inputVerificationCodeViewX, inputVerificationCodeViewY, inputVerificationCodeViewW, inputVerificationCodeViewH);
    
    // 输入密码
    CGFloat inputPasswordViewX = tRealLength(0);
    CGFloat inputPasswordViewY = inputPhoneNumberViewY;
    CGFloat inputPasswordViewW = inputPhoneNumberViewW;
    CGFloat inputPasswordViewH = inputPhoneNumberViewH;
    self.inputPasswordView.frame=CGRectMake(inputPasswordViewX, inputPasswordViewY, inputPasswordViewW, inputPasswordViewH);
}

/** dealloc */
- (void)dealloc{
    TXLog(@"%s",__func__);
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
