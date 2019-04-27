//
//  TXFInputPhoneNumberView.m
//  LoginAnimation
//
//  Created by xtz_pioneer on 2019/4/24.
//  Copyright © 2019 zhangxiong. All rights reserved.
//

#import "TXFInputPhoneNumberView.h"

@implementation TXFInputPhoneNumberView

/** 重写initWithFrame */
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        // 标题
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont systemFontOfSize:tRealFontSize(17)];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = @"找回密码(1/3)";
        // textField
        TXLoginTextField *textField = [[TXLoginTextField alloc]init];
        textField.tx_placeholder = @"请输入手机号码";
        textField.placeholderNormalStateColor = [UIColor whiteColor];
        textField.placeholderSelectStateColor = [UIColor whiteColor];
        textField.keyboardType = UIKeyboardTypeNumberPad;
        // 添加视图
        [self addSubview:titleLabel];
        [self addSubview:textField];
        // 赋值
        self.titleLabel=titleLabel;
        self.textField=textField;
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
    
    // textField
    CGFloat textFieldW = tRealLength(240);
    CGFloat textFieldH = tRealLength(30);
    CGFloat textFieldX = (viewW-textFieldW)/2;
    CGFloat textFieldY = tRealLength(85);
    self.textField.frame=CGRectMake(textFieldX, textFieldY, textFieldW, textFieldH);
    
    // 下一步
    if (!self.next) {
        CGFloat nextW = tRealLength(120);
        CGFloat nextH = tRealLength(30);
        CGFloat nextX = (viewW-nextW)/2;
        CGFloat nextY = CGRectGetMaxY(self.textField.frame)+tRealLength(40);
        TXLoginButton *next= [[TXLoginButton alloc]initWithFrame:CGRectMake(nextX, nextY, nextW, nextH)];
        [next setTitle:@"下一步" forState:UIControlStateNormal];
        [next setBackgroundColor:[UIColor colorWithRed:1 green:0.f/255.0f blue:128.0f/255.0f alpha:1]];
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
