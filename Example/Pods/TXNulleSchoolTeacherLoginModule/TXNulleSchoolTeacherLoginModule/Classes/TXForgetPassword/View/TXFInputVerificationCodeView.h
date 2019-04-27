//
//  TXFInputVerificationCodeView.h
//  LoginAnimation
//
//  Created by xtz_pioneer on 2019/4/24.
//  Copyright © 2019 zhangxiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TXLRPassWordView.h"

NS_ASSUME_NONNULL_BEGIN

/** 完成回调 */
typedef void(^TXFIVCCompletionHandler) (id obj);

/** 输入验证码 */
@interface TXFInputVerificationCodeView : UIView
/** 标题 */
@property (nonatomic,weak)UILabel *titleLabel;
/** 上一步 */
@property (nonatomic,weak)UIButton *up;
/** 验证码 */
@property (nonatomic,weak)TXLRPassWordView *verificationCodeView;
/** 上一步回调 */
@property (nonatomic,copy)TXFIVCCompletionHandler upCompletionHandler;
@end

NS_ASSUME_NONNULL_END
