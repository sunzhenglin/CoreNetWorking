//
//  TXLoginButton.m
//  LoginAnimation
//
//  Created by xtz_pioneer on 2019/4/22.
//  Copyright © 2019 zhangxiong. All rights reserved.
//

#import "TXLoginButton.h"
#import "TXLoginShapeLayer.h"

@interface TXLoginButton () <CAAnimationDelegate>
@property (nonatomic,assign)CFTimeInterval shrinkDuration;
@property (nonatomic,strong)CAMediaTimingFunction *shrinkCurve;
@property (nonatomic,strong)CAMediaTimingFunction *expandCurve;
@property (nonatomic,strong)TXLOAnimationCompletion animationCompletion;
@property (nonatomic,strong)UIColor *color;
@property (nonatomic,strong)TXLoginShapeLayer *loginShapeLayer;
@end

@implementation TXLoginButton

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        // 初始化
        self.loginShapeLayer = [[TXLoginShapeLayer alloc] initWithFrame:self.frame];
        self.shrinkCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        self.expandCurve = [CAMediaTimingFunction functionWithControlPoints:0.95 :0.02 :1 :0.05];
        self.shrinkDuration = 0.1;
        [self.layer addSublayer:self.loginShapeLayer];
        // 配置
        self.layer.cornerRadius = CGRectGetHeight(self.bounds) / 2;
        self.clipsToBounds = true;
        [self addTarget:self action:@selector(scaleToSmall)
       forControlEvents:UIControlEventTouchDown | UIControlEventTouchDragEnter];
        [self addTarget:self action:@selector(scaleAnimation)
       forControlEvents:UIControlEventTouchUpInside];
        [self addTarget:self action:@selector(scaleToDefault)
       forControlEvents:UIControlEventTouchDragExit];
    }
    return self;
}

- (void)scaleToSmall {
    typeof(self) __weak weak = self;
    self.transform = CGAffineTransformMakeScale(1, 1);
    [UIView animateWithDuration:0.3
                          delay:0
         usingSpringWithDamping:0.5f
          initialSpringVelocity:0.0f
                        options:UIViewAnimationOptionLayoutSubviews
                     animations:^{
                         weak.transform = CGAffineTransformMakeScale(0.9, 0.9);
                     } completion:nil];
}

- (void)scaleAnimation {
    typeof(self) __weak weak = self;
    [UIView animateWithDuration:0.3
                          delay:0
         usingSpringWithDamping:0.5f
          initialSpringVelocity:0.0f
                        options:UIViewAnimationOptionLayoutSubviews
                     animations:^{
                         weak.transform = CGAffineTransformMakeScale(1, 1);
                     } completion:nil];
    [self beginAnimation];
}

- (void)scaleToDefault {
    typeof(self) __weak weak = self;
    [UIView animateWithDuration:0.3
                          delay:0
         usingSpringWithDamping:0.5f
          initialSpringVelocity:0.4f
                        options:UIViewAnimationOptionLayoutSubviews
                     animations:^{
                         weak.transform = CGAffineTransformMakeScale(1, 1);
                     } completion:nil];
}

- (void)beginAnimation {
    [self performSelector:@selector(revert) withObject:nil afterDelay:0.f];
    [self.layer addSublayer:self.loginShapeLayer];
    CABasicAnimation *shrinkAnim = [CABasicAnimation animationWithKeyPath:@"bounds.size.width"];
    shrinkAnim.fromValue = @(CGRectGetWidth(self.bounds));
    shrinkAnim.toValue = @(CGRectGetHeight(self.bounds));
    shrinkAnim.duration = self.shrinkDuration;
    shrinkAnim.timingFunction = self.shrinkCurve;
    shrinkAnim.fillMode = kCAFillModeForwards;
    shrinkAnim.removedOnCompletion = NO;
    [self.layer addAnimation:shrinkAnim forKey:shrinkAnim.keyPath];
    [self.loginShapeLayer beginAnimation];
    [self setUserInteractionEnabled:NO];
}

/** 登录失败回调 */
- (void)failedAnimationWithCompletion:(TXLOAnimationCompletion)completion {
    self.animationCompletion = completion;
    
    CABasicAnimation *shrinkAnim = [CABasicAnimation animationWithKeyPath:@"bounds.size.width"];
    shrinkAnim.fromValue = @(CGRectGetHeight(self.bounds));
    shrinkAnim.toValue = @(CGRectGetWidth(self.bounds));
    shrinkAnim.duration = self.shrinkDuration;
    shrinkAnim.timingFunction = self.shrinkCurve;
    shrinkAnim.fillMode = kCAFillModeForwards;
    shrinkAnim.removedOnCompletion = false;
    self.color = self.backgroundColor;
    
    CABasicAnimation *backgroundColor = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    backgroundColor.toValue  = (__bridge id)[UIColor redColor].CGColor;
    backgroundColor.duration = 0.1f;
    backgroundColor.timingFunction = self.shrinkCurve;
    backgroundColor.fillMode = kCAFillModeForwards;
    backgroundColor.removedOnCompletion = false;
    
    CAKeyframeAnimation *keyFrame = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGPoint point = self.layer.position;
    keyFrame.values = @[[NSValue valueWithCGPoint:CGPointMake(point.x, point.y)],
                        
                        [NSValue valueWithCGPoint:CGPointMake(point.x - 10, point.y)],
                        
                        [NSValue valueWithCGPoint:CGPointMake(point.x + 10, point.y)],
                        
                        [NSValue valueWithCGPoint:CGPointMake(point.x - 10, point.y)],
                        
                        [NSValue valueWithCGPoint:CGPointMake(point.x + 10, point.y)],
                        
                        [NSValue valueWithCGPoint:CGPointMake(point.x - 10, point.y)],
                        
                        [NSValue valueWithCGPoint:CGPointMake(point.x + 10, point.y)],
                        
                        [NSValue valueWithCGPoint:point]];
    keyFrame.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    keyFrame.duration = 0.5f;
    keyFrame.delegate = self;
    self.layer.position = point;
    
    [self.layer addAnimation:backgroundColor forKey:backgroundColor.keyPath];
    [self.layer addAnimation:keyFrame forKey:keyFrame.keyPath];
    [self.layer addAnimation:shrinkAnim forKey:shrinkAnim.keyPath];
    
    [self.loginShapeLayer stopAnimation];
    
    [self setUserInteractionEnabled:YES];
    
    if (self.animationCompletion) {
        self.animationCompletion();
    }
}

/** 登录成功回调 */
- (void)succeedAnimationWithCompletion:(TXLOAnimationCompletion)completion {
    self.animationCompletion=completion;
    
    [self.loginShapeLayer stopAnimation];
    
    [self setUserInteractionEnabled:YES];
    
    if (self.animationCompletion) {
        self.animationCompletion();
    }
    
    [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(didStopAnimation) userInfo:nil repeats:nil];
}

- (void)revert {
    CABasicAnimation *backgroundColor = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    backgroundColor.toValue  = (__bridge id)self.backgroundColor.CGColor;
    backgroundColor.duration = 0.1f;
    backgroundColor.timingFunction = self.shrinkCurve;
    backgroundColor.fillMode = kCAFillModeForwards;
    backgroundColor.removedOnCompletion = false;
    [self.layer addAnimation:backgroundColor forKey:@"backgroundColors"];
    
}

- (void)didStopAnimation {
    [self.layer removeAllAnimations];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
