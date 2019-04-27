//
//  TXLoginShapeLayer.h
//  LoginAnimation
//
//  Created by xtz_pioneer on 2019/4/22.
//  Copyright © 2019 zhangxiong. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

/** 登录ShapeLayer */
@interface TXLoginShapeLayer : CAShapeLayer

/**
 *  构造initWithFrame方法
 *
 *  @param frame (x,y,w.h)
 *
 *  @return TXLoginShapeLayer 类型
 *
 */
- (instancetype)initWithFrame:(CGRect)frame;

/** 开始动画 */
- (void)beginAnimation;

/** 停止动画 */
- (void)stopAnimation;

@end

NS_ASSUME_NONNULL_END
