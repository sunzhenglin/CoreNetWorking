//
//  TXFInputPasswordView.m
//  LoginAnimation
//
//  Created by xtz_pioneer on 2019/4/24.
//  Copyright © 2019 zhangxiong. All rights reserved.
//

#import "TXFInputPasswordView.h"

@implementation TXFInputPasswordView

/** 重写initWithFrame */
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        // 标题
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.textColor = TXLFRGBA(66, 66, 66, 1);
        titleLabel.font = [UIFont systemFontOfSize:tRealFontSize(17)];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = @"找回密码(3/3)";
        
        // 向上
        UIButton *up = [UIButton buttonWithType:UIButtonTypeCustom];
        NSBundle *myBundle=[TXURBundle bundleWithClass:self.class resource:TXNulleSchoolTeacherLoginModule_Bundle_Name];
        NSString *imagePath=[myBundle pathForResource:@"forget_password_up" ofType:@"png" inDirectory:nil];
        UIImage *image=[UIImage imageWithContentsOfFile:imagePath];
        [up setImage:image forState:UIControlStateNormal];
        [up addTarget:self action:@selector(upEvent:) forControlEvents:UIControlEventTouchUpInside];
        
        // 密码
        TXLoginTextField *password = [[TXLoginTextField alloc]init];
        password.tx_placeholder = @"请输入密码";
        password.placeholderNormalStateColor = TXLFRGBA(205, 205, 205, 1);
        password.placeholderSelectStateColor = TXLFRGBA(66, 66, 66, 1);
        password.cursorColor = TXLFRGBA(205, 205, 205, 1);
        password.textColor = TXLFRGBA(66, 66, 66, 1);
        password.lineColor = TXLFRGBA(231, 231, 231, 1);
        password.lineLayerColor = TXLFRGBA(66, 66, 66, 0.5);
        password.secureTextEntry = YES;
        // 确认密码
        TXLoginTextField *confirmPassword = [[TXLoginTextField alloc]init];
        confirmPassword.tx_placeholder = @"请输入确认密码";
        confirmPassword.placeholderNormalStateColor = TXLFRGBA(205, 205, 205, 1);
        confirmPassword.placeholderSelectStateColor = TXLFRGBA(66, 66, 66, 1);
        confirmPassword.cursorColor = TXLFRGBA(205, 205, 205, 1);
        confirmPassword.textColor = TXLFRGBA(66, 66, 66, 1);
        confirmPassword.lineColor = TXLFRGBA(231, 231, 231, 1);
        confirmPassword.lineLayerColor = TXLFRGBA(66, 66, 66, 0.5);
        confirmPassword.secureTextEntry = YES;
        // 添加视图
        [self addSubview:titleLabel];
        [self addSubview:up];
        [self addSubview:password];
        [self addSubview:confirmPassword];
        
        // 赋值
        self.titleLabel = titleLabel;
        self.up = up;
        self.password = password;
        self.confirmPassword = confirmPassword;
    }
    return self;
}

/** 重写layoutSubviews */
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat viewW = self.frame.size.width;
    
    // 标题
    CGFloat titleLabelX = tRealLength(50);
    CGFloat titleLabelW = viewW-titleLabelX*2;
    CGFloat titleLabelH = tRealLength(25);
    CGFloat titleLabelY = tRealLength(15);
    self.titleLabel.frame=CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    
    // 向上
    CGFloat upX = tRealLength(15);
    CGFloat upY = titleLabelY;
    CGFloat upW_H = titleLabelH;
    self.up.frame = CGRectMake(upX, upY, upW_H, upW_H);
    
    // 密码
    CGFloat passwordW = tRealLength(240);
    CGFloat passwordH = tRealLength(30);
    CGFloat passwordX = (viewW-passwordW)/2;
    CGFloat passwordY = tRealLength(75);
    self.password.frame = CGRectMake(passwordX, passwordY, passwordW, passwordH);
    
    // 确认密码
    CGFloat confirmPasswordW = passwordW;
    CGFloat confirmPasswordH = passwordH;
    CGFloat confirmPasswordX = passwordX;
    CGFloat confirmPasswordY = CGRectGetMaxY(self.password.frame)+tRealLength(35);
    self.confirmPassword.frame = CGRectMake(confirmPasswordX, confirmPasswordY, confirmPasswordW, confirmPasswordH);
    
    if (!self.next) {
        // 下一步
        CGFloat nextW = tRealLength(120);
        CGFloat nextH = tRealLength(30);
        CGFloat nextX = (viewW-nextW)/2;
        CGFloat nextY = CGRectGetMaxY(self.confirmPassword.frame)+tRealLength(30);;
        TXLoginButton *next= [[TXLoginButton alloc]initWithFrame:CGRectMake(nextX, nextY, nextW, nextH)];
        [next setTitle:@"确认修改" forState:UIControlStateNormal];
        [next setBackgroundColor:TXLFRGBA(46, 175, 250, 1)];
        [next setFailedBackgroundColor:TXLFRGBA(46, 175, 250, 1)];
        [next addTarget:self action:@selector(nextEvent:) forControlEvents:UIControlEventTouchUpInside];
        next.titleLabel.font = [UIFont systemFontOfSize:tRealFontSize(13)];
        [self addSubview:next];
        self.next=next;
    }
}

/** 下一步 */
- (void)nextEvent:(id)sender{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    if (self.nextCompletionHandler) self.nextCompletionHandler(sender);
}

/** 上一步 */
- (void)upEvent:(id)sender{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    if (self.upCompletionHandler) self.upCompletionHandler(sender);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
