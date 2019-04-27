//
//  TXLoginButton.h
//  LoginAnimation
//
//  Created by xtz_pioneer on 2019/4/22.
//  Copyright © 2019 zhangxiong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/** 动画完成回调 */
typedef void(^TXLOAnimationCompletion) (void);

/** 登录按钮 */
@interface TXLoginButton : UIButton

/** 登录失败回调 */
- (void)failedAnimationWithCompletion:(TXLOAnimationCompletion)completion;

/** 登录成功回调 */
- (void)succeedAnimationWithCompletion:(TXLOAnimationCompletion)completion;

@end

NS_ASSUME_NONNULL_END
