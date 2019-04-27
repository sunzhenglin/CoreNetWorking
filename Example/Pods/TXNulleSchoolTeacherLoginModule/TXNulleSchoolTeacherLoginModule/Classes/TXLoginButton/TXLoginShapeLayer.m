//
//  TXLoginShapeLayer.m
//  LoginAnimation
//
//  Created by xtz_pioneer on 2019/4/22.
//  Copyright © 2019 zhangxiong. All rights reserved.
//

#import "TXLoginShapeLayer.h"
#import <UIKit/UIKit.h>

@implementation TXLoginShapeLayer

/** 构造initWithFrame方法 */
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super init]) {
        CGFloat radius = CGRectGetHeight(frame) / 4;
        self.frame = CGRectMake(0, 0, CGRectGetHeight(frame), CGRectGetHeight(frame));
        CGPoint center = CGPointMake(CGRectGetHeight(frame) / 2, CGRectGetMidY(self.bounds));
        CGFloat startAngle = 0 - M_PI_2;
        CGFloat endAngle = M_PI * 2 - M_PI_2;
        BOOL clockwise = YES;
        self.path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:clockwise].CGPath;
        self.fillColor = nil;
        self.strokeColor = [UIColor whiteColor].CGColor;
        self.lineWidth = 1;
        self.strokeEnd = 0.4;
        self.hidden = YES;
    }
    return self;
}

/** 开始动画 */
- (void)beginAnimation{
    self.hidden = NO;
    CABasicAnimation *rotate = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotate.fromValue = 0;
    rotate.toValue = @(M_PI * 2);
    rotate.duration = 0.4;
    rotate.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    rotate.repeatCount = HUGE;
    rotate.fillMode = kCAFillModeForwards;
    rotate.removedOnCompletion = NO;
    [self addAnimation:rotate forKey:rotate.keyPath];
}

/** 停止动画 */
- (void)stopAnimation{
    self.hidden = YES;
}

@end
