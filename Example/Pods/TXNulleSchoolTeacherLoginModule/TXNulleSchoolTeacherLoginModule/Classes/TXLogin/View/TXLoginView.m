//
//  TXLoginView.m
//  AFNetworking
//
//  Created by xtz_pioneer on 2019/4/28.
//

#import "TXLoginView.h"

@implementation TXLoginView

/** 重写initWithFrame */
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        CGFloat viewW = self.frame.size.width;
        CGFloat viewH = self.frame.size.height;
        self.userInteractionEnabled = YES;
        
        // myBundle
        NSBundle *myBundle = [TXURBundle bundleWithClass:self.class resource:TXNulleSchoolTeacherLoginModule_Bundle_Name];
        
        // 背景图
        CGFloat backgroundImageViewX = tRealLength(0);
        CGFloat backgroundImageViewY = tRealLength(0);
        CGFloat backgroundImageViewW = viewW;
        CGFloat backgroundImageViewH = viewH;
        self.backgroundImageView=[[UIImageView alloc]initWithFrame:CGRectMake(backgroundImageViewX, backgroundImageViewY, backgroundImageViewW, backgroundImageViewH)];
        NSString *backgroundImagePath = [myBundle pathForResource:@"login_view_background_image" ofType:@"png" inDirectory:nil];
        UIImage *backgroundImage = [UIImage imageWithContentsOfFile:backgroundImagePath];
        self.backgroundImageView.image = backgroundImage;
        self.backgroundImageView.userInteractionEnabled = YES;
        [self addSubview:self.backgroundImageView];
        
        // 用户名
        CGFloat usernameW = tRealLength(240);
        CGFloat usernameH = tRealLength(30);
        CGFloat usernameX = (viewW-usernameW)/2;
        CGFloat usernameY = tRealLength(80);
        self.username = [[TXLoginTextField alloc]initWithFrame:CGRectMake(usernameX, usernameY, usernameW, usernameH)];
        self.username.tx_placeholder = @"请输入账号";
        self.username.placeholderNormalStateColor = TXLFRGBA(205, 205, 205, 1);
        self.username.placeholderSelectStateColor = TXLFRGBA(66, 66, 66, 1);
        self.username.cursorColor = TXLFRGBA(205, 205, 205, 1);
        self.username.textColor = TXLFRGBA(66, 66, 66, 1);
        self.username.lineColor = TXLFRGBA(231, 231, 231, 1);
        self.username.lineLayerColor = TXLFRGBA(66, 66, 66, 0.5);
        [self.backgroundImageView addSubview:self.username];
        
        // 密码
        CGFloat passwordX = usernameX;
        CGFloat passwordY = CGRectGetMaxY(self.username.frame)+tRealLength(35);
        CGFloat passwordW = usernameW;
        CGFloat passwordH = usernameH;
        self.password = [[TXLoginTextField alloc]initWithFrame:CGRectMake(passwordX, passwordY, passwordW, passwordH)];
        self.password.tx_placeholder = @"请输入密码";
        self.password.placeholderNormalStateColor = TXLFRGBA(205, 205, 205, 1);
        self.password.placeholderSelectStateColor = TXLFRGBA(66, 66, 66, 1);
        self.password.cursorColor = TXLFRGBA(205, 205, 205, 1);
        self.password.textColor = TXLFRGBA(66, 66, 66, 1);
        self.password.lineColor = TXLFRGBA(231, 231, 231, 1);
        self.password.lineLayerColor = TXLFRGBA(66, 66, 66, 0.5);
        self.password.secureTextEntry = YES;
        [self.backgroundImageView addSubview:self.password];
        
        // 登录按钮
        CGFloat loginW = tRealLength(170);
        CGFloat loginH = tRealLength(40);
        CGFloat loginX = (viewW-loginW)/2;
        CGFloat loginY = CGRectGetMaxY(self.password.frame)+tRealLength(60);
        self.login= [[TXLoginButton alloc]initWithFrame:CGRectMake(loginX, loginY, loginW, loginH)];
        [self.login setTitle:@"登录" forState:UIControlStateNormal];
        [self.login setBackgroundColor:TXLFRGBA(46, 175, 250, 1)];
        [self.login setFailedBackgroundColor:TXLFRGBA(46, 175, 250, 1)];
        [self.login addTarget:self action:@selector(loginEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.backgroundImageView addSubview:self.login];
        
        // 忘记密码
        CGFloat forgetPasswordW = tRealLength(300);
        CGFloat forgetPasswordH = tRealLength(30);
        CGFloat forgetPasswordX = (viewW-forgetPasswordW)/2;
        CGFloat forgetPasswordY = viewH-forgetPasswordH-tRealLength(60);
        UIButton *forgetPassword = [[UIButton alloc]initWithFrame:CGRectMake(forgetPasswordX, forgetPasswordY, forgetPasswordW, forgetPasswordH)];
        [forgetPassword setTitle:@"忘记密码？请点击这里。" forState:UIControlStateNormal];
        [forgetPassword setTitleColor:TXLFRGBA(112, 112, 112, 1) forState:UIControlStateNormal];
        [forgetPassword setTitleColor:TXLFRGBA(247, 247, 247, 1) forState:UIControlStateHighlighted];
        forgetPassword.titleLabel.font=[UIFont systemFontOfSize:tRealFontSize(13.f)];
        [forgetPassword addTarget:self action:@selector(forgetPasswordEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.backgroundImageView addSubview:forgetPassword];
        
    }
    return self;
}

/** 忘记密码 */
- (void)forgetPasswordEvent:(id)sender{
    if (self.forgetPasswordCompletionHandler) self.forgetPasswordCompletionHandler(sender);
}

/** 登录事件 */
- (void)loginEvent:(id)sender{
    if (self.loginCompletionHandler) self.loginCompletionHandler(sender);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
