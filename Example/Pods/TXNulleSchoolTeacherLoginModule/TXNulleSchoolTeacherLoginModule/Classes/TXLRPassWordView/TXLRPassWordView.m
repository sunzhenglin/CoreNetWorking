//
//  TXLRPassWordView.m
//  SchoolWatchParent
//
//  Created by xtz_pioneer on 2018/7/10.
//  Copyright © 2018年 Komlin. All rights reserved.
//

#import "TXLRPassWordView.h"
@interface TXLRPassWordView()<UITextFieldDelegate>
@property(nonatomic,strong)NSMutableArray *dotArr;//黑点
@property(nonatomic,strong)NSMutableArray *bottomLineArr;//下划线
@property(nonatomic,strong)NSMutableArray *codeLArr;//Lable
@property(nonatomic,assign)CGSize blackSpotSize;
@end

@implementation TXLRPassWordView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder{
    if (self = [super initWithCoder:coder]) {
        
    }
    return self;
}

- (instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}


- (void)config{
    self.backgroundColor = [UIColor clearColor];
    self.bottomLineArr= @[].mutableCopy;
    self.dotArr = @[].mutableCopy;
    self.codeLArr = @[].mutableCopy;
    self.blackSpotSize=CGSizeMake(10, 10);

    [self.bottomLineArr removeAllObjects];
    [self.dotArr removeAllObjects];
    [self.codeLArr removeAllObjects];
    
    if (self.showType == TXPassShowTypeBlackDotsHaveNoGaps) {
        [self initBlackDotsHaveNoGaps];
    }else if(self.showType == TXPassShowTypeDisplayNumbersBoxesNoGaps){
        [self initDisplayNumbersBoxesNoGaps];
    }else if(self.showType == TXPassShowTypeBlackDotsBoxesWithGaps){
        [self initBlackDotsBoxesWithGaps];
    }else if(self.showType == TXPassShowTypeDisplayNumbersBoxesWithIntervals){
        [self initDisplayNumbersBoxesWithIntervals];
    }else if(self.showType == TXPassShowTypeDisplayNumberUnderline){
        [self initDisplayNumberUnderline];
    }
    
}
/*TXPassShowTypeBlackDotsHaveNoGaps 黑点,框,没间隔*/
- (void)initBlackDotsHaveNoGaps{
    CGFloat width = self.frame.size.width/self.number;
    for (int i = 0; i< self.number -1; i++) {
        UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.textField.frame)+(i+1)*width, 0, 1,self.frame.size.height)];
        lineV.backgroundColor = self.tintColor;
        [self addSubview:lineV];
    }
    self.dotArr = @[].mutableCopy;
    for (int i=0; i<self.number; i++) {
        UIView *dotView =[[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.textField.frame) + (width - self.number) / 2 + i * width, CGRectGetMinY(self.textField.frame) + (self.frame.size.height - self.blackSpotSize.height) / 2, self.blackSpotSize.width, self.blackSpotSize.height)];
        dotView.backgroundColor = [UIColor blackColor];
        dotView.layer.cornerRadius = self.blackSpotSize.width/2.0f;
        dotView.clipsToBounds = YES;
        dotView.hidden = YES;
        [self addSubview:dotView];
        [self.dotArr addObject:dotView];
    }
    _textField.layer.borderColor = self.tintColor.CGColor;
    _textField.layer.borderWidth = 1;
    _textField.layer.masksToBounds = YES;
    
}
/*TXPassShowTypeDisplayNumbersBoxesNoGaps 显示数字,框,没间隔*/
- (void)initDisplayNumbersBoxesNoGaps{
    CGFloat width = self.frame.size.width/self.number;
    for (int i = 0; i< self.number -1; i++) {
        UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.textField.frame)+(i+1)*width, 0, 1,self.frame.size.height)];
        lineV.backgroundColor = self.tintColor;
        [self addSubview:lineV];
    }
    for (int i=0; i<self.number; i++) {
        UILabel *codeL =[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.textField.frame) + (i)*width+1, 1, width-2, self.frame.size.height-2)];
        codeL.backgroundColor = [UIColor clearColor];
        codeL.layer.borderColor = [UIColor clearColor].CGColor;
        codeL.layer.borderWidth = 1.f;
        codeL.textColor = self.textColor;
        codeL.hidden = YES;
        codeL.textAlignment = NSTextAlignmentCenter;
        [self addSubview:codeL];
        [self.codeLArr addObject:codeL];
    }
    _textField.layer.borderColor = self.tintColor.CGColor;
    _textField.layer.borderWidth = 1;
    _textField.layer.masksToBounds = YES;
}
/*TXPassShowTypeBlackDotsBoxesWithGaps 黑点,框,有间隔*/
- (void)initBlackDotsBoxesWithGaps{
    CGFloat f = 10; //设置格子间隔
    CGFloat width = ((self.frame.size.width-(self.number-1)*f)/self.number);
    for (int i=0; i<self.number; i++) {
        UILabel *codeL =[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.textField.frame) + (i)*(width+f), 0, width, self.frame.size.height)];
        codeL.backgroundColor = [UIColor clearColor];
        codeL.layer.borderColor= self.tintColor.CGColor;
        codeL.textColor = self.textColor;
        codeL.layer.borderWidth = 1.;
        codeL.textAlignment = NSTextAlignmentCenter;
        [self addSubview:codeL];
        [self.codeLArr addObject:codeL];
    }
    for (int i=0; i<self.number; i++) {
        UIView *dotView =[[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.textField.frame) + i * (width+f) +(width- self.blackSpotSize.width)/2, CGRectGetMinY(self.textField.frame) + (self.frame.size.height - self.blackSpotSize.height) / 2, self.blackSpotSize.width, self.blackSpotSize.height)];
        dotView.backgroundColor = [UIColor blackColor];
        dotView.layer.cornerRadius = self.blackSpotSize.width/2.0f;
        dotView.clipsToBounds = YES;
        dotView.hidden = YES;
        [self addSubview:dotView];
        [self.dotArr addObject:dotView];
    }
}
/*TXPassShowTypeDisplayNumbersBoxesWithIntervals 显示数字,框,有间隔*/
- (void)initDisplayNumbersBoxesWithIntervals{
    CGFloat f = 10; //设置格子间隔
    CGFloat width = ((self.frame.size.width-(self.number-1)*f)/self.number);
    for (int i=0; i<self.number; i++) {
        UILabel *codeL =[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.textField.frame) + (i)*(width+f), 0, width, self.frame.size.height)];
        codeL.backgroundColor = [UIColor clearColor];
        codeL.layer.borderColor= self.tintColor.CGColor;
        codeL.textColor = self.textColor;
        codeL.layer.borderWidth = 1.;
        codeL.textAlignment = NSTextAlignmentCenter;
        [self addSubview:codeL];
        [self.codeLArr addObject:codeL];
    }
}

/*TXPassShowTypeDisplayNumberUnderline 显示数字,下划线,一般用做验证码*/
- (void)initDisplayNumberUnderline{
    CGFloat f = 10; //设置间隔
    CGFloat width = ((self.frame.size.width-(self.number-1)*f)/self.number);
    for (int i =0; i<self.number; i++) {
        UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.textField.frame) + (i)*(width+f), self.frame.size.height-1,width,1)];
        lineV.backgroundColor = [UIColor grayColor];//原始线的颜色
        [self addSubview:lineV];
        [self.bottomLineArr addObject:lineV];
    }
    for (int i=0; i<self.number; i++) {
        UILabel *codeL =[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.textField.frame) + (i)*(width+f), 0, width, self.frame.size.height-1)];
        codeL.backgroundColor = [UIColor clearColor];
        codeL.textColor = self.textColor;
        codeL.hidden = YES;
        codeL.textAlignment = NSTextAlignmentCenter;
        [self addSubview:codeL];
        [self.codeLArr addObject:codeL];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    }else if(string.length == 0){
        return YES;
    }else if(textField.text.length >= self.number){
        return NO;
    }else{
        return YES;
    }
}

- (void)textFieldDidChange:(UITextField *)textField{
    switch (_showType) {
        case 0:{
            for (UIView *dotView in self.dotArr) {
                dotView.hidden = YES;
            }
            for (int i = 0; i < textField.text.length; i++) {
                ((UIView *)[self.dotArr objectAtIndex:i]).hidden = NO;
            }
        }
            break;
        case 1:{
            for (UILabel *codeL in self.codeLArr) {
                codeL.hidden = YES;
            }
            for (int i = 0; i < textField.text.length; i++) {
                ((UILabel *)[self.codeLArr objectAtIndex:i]).hidden = NO;
                ((UILabel *)[self.codeLArr objectAtIndex:i]).text =[textField.text substringWithRange:NSMakeRange(i, 1)];
            }
        }
            break;
        case 2:{
            for (UIView *dotView in self.dotArr) {
                dotView.hidden = YES;
            }
            for (int i = 0; i < textField.text.length; i++) {
                ((UIView *)[self.dotArr objectAtIndex:i]).hidden = NO;
            }
        }
            break;
        case 3:{
            for (UILabel *codeL in self.codeLArr) {
                codeL.text = @"";
                
            }
            for (int i = 0; i < textField.text.length; i++) {
                ((UILabel *)[self.codeLArr objectAtIndex:i]).hidden = NO;
                ((UILabel *)[self.codeLArr objectAtIndex:i]).text =[textField.text substringWithRange:NSMakeRange(i, 1)];
            }
        }
            break;
        case 4:{
            for (UILabel *codeL in self.codeLArr) {
                codeL.hidden = YES;
            }
            for (int i = 0; i < textField.text.length; i++) {
                ((UILabel *)[self.codeLArr objectAtIndex:i]).hidden = NO;
                ((UILabel *)[self.codeLArr objectAtIndex:i]).text =[textField.text substringWithRange:NSMakeRange(i, 1)];
            }
            for (UIView *lineV in self.bottomLineArr) {
                lineV.backgroundColor = [UIColor grayColor];
            }
            for (int i = 0; i < textField.text.length; i++) {
                ((UIView *)[self.bottomLineArr objectAtIndex:i]).backgroundColor = self.tintColor;
            }
        }
            break;
        default:
            break;
    }
    if (textField.text.length == self.number) {
        if (self.completionHandler) self.completionHandler(textField.text);
    }
}

-(UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _textField.backgroundColor = [UIColor clearColor];
        //输入的文字颜色为白色
        _textField.textColor = [UIColor clearColor];
        //输入框光标的颜色为白色
        _textField.tintColor = [UIColor clearColor];
        _textField.delegate = self;
        _textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:_textField];
    }
    return _textField;
    
}

- (void)setNumber:(NSInteger)number{
    _number=number;
}

-(void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
}

-(void)setShowType:(TXPassShowType)showType{
    _showType = showType;
}

-(void)setTintColor:(UIColor *)tintColor{
    _tintColor = tintColor;
}

-(void)show{
    if(_textColor == nil){
        _textColor = [UIColor blackColor];
    }
    if (!_showType) {
        _showType = TXPassShowTypeBlackDotsHaveNoGaps;
    }
    if(_tintColor == nil){
        _tintColor = [UIColor blackColor];
    }
    if(!_number ){
        _number =6;//默认
    }
    [self config];
}

- (void)clean{
    self.textField.text = @"";
    [self textFieldDidChange:self.textField];
}

@end
