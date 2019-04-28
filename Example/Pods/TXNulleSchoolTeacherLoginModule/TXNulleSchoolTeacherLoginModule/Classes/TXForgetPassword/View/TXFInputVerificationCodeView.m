//
//  TXFInputVerificationCodeView.m
//  LoginAnimation
//
//  Created by xtz_pioneer on 2019/4/24.
//  Copyright © 2019 zhangxiong. All rights reserved.
//

#import "TXFInputVerificationCodeView.h"

@implementation TXFInputVerificationCodeView

/** 重写initWithFrame */
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        // 标题
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.textColor = TXLFRGBA(66, 66, 66, 1);
        titleLabel.font = [UIFont systemFontOfSize:tRealFontSize(17)];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = @"找回密码(2/3)";
        // 向上
        UIButton *up = [UIButton buttonWithType:UIButtonTypeCustom];
        NSBundle *myBundle=[TXURBundle bundleWithClass:self.class resource:TXNulleSchoolTeacherLoginModule_Bundle_Name];
        NSString *imagePath=[myBundle pathForResource:@"forget_password_up" ofType:@"png" inDirectory:nil];
        UIImage *image=[UIImage imageWithContentsOfFile:imagePath];
        [up setImage:image forState:UIControlStateNormal];
        [up addTarget:self action:@selector(upEvent:) forControlEvents:UIControlEventTouchUpInside];
        // 验证码输入框
        TXLRPassWordView * verificationCodeView= [[TXLRPassWordView alloc]init];
        verificationCodeView.showType = TXPassShowTypeDisplayNumbersBoxesWithIntervals;
        verificationCodeView.number = 6;
        verificationCodeView.tintColor=TXLFRGBA(46, 175, 250, 1);
        verificationCodeView.textColor=TXLFRGBA(66, 66, 66, 1);
        // 添加视图
        [self addSubview:titleLabel];
        [self addSubview:up];
        [self addSubview:verificationCodeView];
        // 赋值
        self.titleLabel = titleLabel;
        self.up = up;
        self.verificationCodeView = verificationCodeView;
    }
    return self;
}

/** 重写layoutSubviews */
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat viewW = self.frame.size.width;
    CGFloat viewH = self.frame.size.height;
    
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
    
    // 验证码
    CGFloat verificationCodeViewW = tRealLength(240);
    CGFloat verificationCodeViewH = tRealLength(40);
    CGFloat verificationCodeViewX = (viewW-verificationCodeViewW)/2;
    CGFloat verificationCodeViewY = (viewH-verificationCodeViewH)/2;
    self.verificationCodeView.frame = CGRectMake(verificationCodeViewX, verificationCodeViewY, verificationCodeViewW, verificationCodeViewH);
    [self.verificationCodeView show];
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
