//
//  TXLoginTextField.m
//  LoginAnimation
//
//  Created by xtz_pioneer on 2019/4/22.
//  Copyright © 2019 zhangxiong. All rights reserved.
//

#import "TXLoginTextField.h"

/** 线高 */
CGFloat const txLoginLineHeight=1.0f;
/** 填充 */
CGFloat const txLoginPadding=1.0f;
/** 间距 */
CGFloat const txLoginHeightSpaceing=8.0f;
/** 文本字体大小 */
CGFloat const txLoginTextFontSize=15.0f;
/** 选中描述字体大小 */
CGFloat const txLoginPlaceholderSelectFontSize=13.0f;
/** 正常描述字体大小 */
CGFloat const txLoginPlaceholderNormalFontSize=15.0f;

@interface TXLoginTextField()<UITextFieldDelegate>
/** 文本框 */
@property (nonatomic,strong,readonly)UITextField *textField;
/** 注释 */
@property (nonatomic,strong)UILabel *placeholderLabel;
/** 线 */
@property (nonatomic,strong)UIView *lineView;
/** 填充线 */
@property (nonatomic,strong)CALayer *lineLayer;
/** 移动一次 */
@property (nonatomic,assign)BOOL moved;
@end

@implementation TXLoginTextField

/** 重写initWithFrame方法 */
- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
        self.textField = [[UITextField alloc]initWithFrame:CGRectZero];
        self.textField.borderStyle = UITextBorderStyleNone;
        self.textField.delegate = self;
        [self addSubview:self.textField];
        
        self.placeholderLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        self.placeholderLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:self.placeholderLabel];
        
        self.lineView = [[UIView alloc]initWithFrame:CGRectZero];
        self.lineView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.lineView];
        
        self.lineLayer = [CALayer layer];
        self.lineLayer.frame = CGRectMake(0,0, 0, txLoginLineHeight);
        self.lineLayer.anchorPoint = CGPointMake(0, 0.5);
        self.lineLayer.backgroundColor = [UIColor whiteColor].CGColor;
        [self.lineView.layer addSublayer:self.lineLayer];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(obserValue:) name:UITextFieldTextDidChangeNotification object:self.textField];
        
        self.secureTextEntry = NO;
        self.placeholderNormalStateColor = [UIColor lightGrayColor];
        self.placeholderSelectStateColor = [UIColor lightGrayColor];
        self.textColor = [UIColor whiteColor];
        self.textTintColor = [UIColor whiteColor];
        self.clearButtonMode = UITextFieldViewModeNever;
        self.keyboardType = UIKeyboardTypeDefault;
        self.textFont = [UIFont systemFontOfSize:txLoginTextFontSize];
        self.placeholderNormalStateFont = [UIFont systemFontOfSize:txLoginPlaceholderNormalFontSize];
        self.placeholderSelectStateFont = [UIFont systemFontOfSize:txLoginPlaceholderSelectFontSize];
    }
    return self;
}

/** 文本框 */
- (void)setTextField:(UITextField * _Nonnull)textField{
    _textField=textField;
}

/** 重写layoutSubviews方法 */
- (void)layoutSubviews{
    [super layoutSubviews];
    self.textField.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-txLoginLineHeight);
    self.placeholderLabel.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-txLoginLineHeight);
    self.lineView.frame = CGRectMake(0, CGRectGetHeight(self.frame)-txLoginLineHeight, CGRectGetWidth(self.frame), txLoginLineHeight);
}

/** 监听 */
- (void)obserValue:(NSNotification *)obj{
    [self changeFrameOfPlaceholder];
}

/** 改变描述Frame */
- (void)changeFrameOfPlaceholder{
    
    CGFloat y = self.placeholderLabel.center.y;
    CGFloat x = self.placeholderLabel.center.x;
    
    if(self.textField.text.length != 0 && !self.moved){
        [self moveAnimation:x y:y];
    }else if(self.textField.text.length == 0 && self.moved){
        [self backAnimation:x y:y];
    }
}

/** 移动动画 */
- (void)moveAnimation:(CGFloat)x y:(CGFloat)y{
    __block CGFloat moveX = x;
    __block CGFloat moveY = y;
    
    self.placeholderLabel.font = self.placeholderSelectStateFont;
    self.placeholderLabel.textColor = self.placeholderSelectStateColor;
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.15 animations:^{
        moveY -= weakSelf.placeholderLabel.frame.size.height/2 + txLoginHeightSpaceing;
        moveX -= txLoginPadding;
        weakSelf.placeholderLabel.center = CGPointMake(moveX, moveY);
        weakSelf.placeholderLabel.alpha = 1;
        weakSelf.moved = YES;
        weakSelf.lineLayer.bounds = CGRectMake(0, 0, CGRectGetWidth(self.frame), txLoginLineHeight);
    }];
}

/** 返回动画 */
- (void)backAnimation:(CGFloat)x y:(CGFloat)y{
    __block CGFloat moveX = x;
    __block CGFloat moveY = y;
    
    self.placeholderLabel.font = self.placeholderNormalStateFont;
    self.placeholderLabel.textColor = self.placeholderNormalStateColor;
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.15 animations:^{
        moveY += weakSelf.placeholderLabel.frame.size.height/2 + txLoginHeightSpaceing;
        moveX += txLoginPadding;
        weakSelf.placeholderLabel.center = CGPointMake(moveX, moveY);
        weakSelf.placeholderLabel.alpha = 1;
        weakSelf.moved = NO;
        weakSelf.lineLayer.bounds = CGRectMake(0, 0, 0, txLoginLineHeight);
    }];
}

/** 注释信息 */
- (void)setTx_placeholder:(NSString *)tx_placeholder{
    _tx_placeholder = tx_placeholder;
    self.placeholderLabel.text = _tx_placeholder;
}

/** 光标颜色 */
-(void)setCursorColor:(UIColor *)cursorColor{
    _cursorColor = cursorColor;
    self.textField.tintColor = _cursorColor;
}

/** 注释普通状态下颜色 */
-(void)setPlaceholderNormalStateColor:(UIColor *)placeholderNormalStateColor{
    _placeholderNormalStateColor = placeholderNormalStateColor;
    self.placeholderLabel.textColor = _placeholderNormalStateColor;
}

/** 注释选中状态下颜色 */
-(void)setPlaceholderSelectStateColor:(UIColor *)placeholderSelectStateColor{
    _placeholderSelectStateColor = placeholderSelectStateColor;
}

/** 文本颜色 */
- (void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    self.textField.textColor = _textColor;
}

/** 文本Tint颜色 */
- (void)setTextTintColor:(UIColor *)textTintColor{
    _textTintColor = textTintColor;
    self.textField.tintColor = _textTintColor;
}

/** 是否密文显示 */
- (void)setSecureTextEntry:(BOOL)secureTextEntry{
    _secureTextEntry = secureTextEntry;
    self.textField.secureTextEntry = _secureTextEntry;
}

/** 显示类型 */
- (void)setClearButtonMode:(UITextFieldViewMode)clearButtonMode{
    _clearButtonMode = clearButtonMode;
    self.textField.clearButtonMode = _clearButtonMode;
}

/** 键盘类型 */
- (void)setKeyboardType:(UIKeyboardType)keyboardType{
    _keyboardType = keyboardType;
    self.textField.keyboardType = _keyboardType;
}

/** 文本字体 */
- (void)setTextFont:(UIFont *)textFont{
    _textFont = textFont;
    self.textField.font = _textFont;
}

/** 注释普通状态下字体 */
- (void)setPlaceholderNormalStateFont:(UIFont *)placeholderNormalStateFont{
    _placeholderNormalStateFont = placeholderNormalStateFont;
    self.placeholderLabel.font = _placeholderNormalStateFont;
}

/** 注释选中状态下字体 */
- (void)setPlaceholderSelectStateFont:(UIFont *)placeholderSelectStateFont{
    _placeholderSelectStateFont = placeholderSelectStateFont;
}

/** 文本 */
- (void)setText:(NSString *)text{
    self.textField.text = text;
}

/** 文本 */
- (NSString*)text{
    return self.textField.text;
}

/** dealloc */
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:self.textField];
}

@end
