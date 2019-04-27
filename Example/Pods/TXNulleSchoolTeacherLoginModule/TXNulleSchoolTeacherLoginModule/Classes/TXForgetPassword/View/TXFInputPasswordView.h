//
//  TXFInputPasswordView.h
//  LoginAnimation
//
//  Created by xtz_pioneer on 2019/4/24.
//  Copyright © 2019 zhangxiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TXLoginTextField.h"
#import "TXLoginButton.h"

NS_ASSUME_NONNULL_BEGIN

/** 完成回调 */
typedef void(^TXFIPVCompletionHandler) (id obj);

/** 输入密码 */
@interface TXFInputPasswordView : UIView
/** 标题 */
@property (nonatomic,weak)UILabel *titleLabel;
/** 上一步 */
@property (nonatomic,weak)UIButton *up;
/** 密码 */
@property (nonatomic,weak)TXLoginTextField *password;
/** 确认密码 */
@property (nonatomic,weak)TXLoginTextField *confirmPassword;
/** 下一步 */
@property (nonatomic,weak)TXLoginButton *next;
/** 下一步回调 */
@property (nonatomic,copy)TXFIPVCompletionHandler nextCompletionHandler;
/** 上一步回调 */
@property (nonatomic,copy)TXFIPVCompletionHandler upCompletionHandler;
@end

NS_ASSUME_NONNULL_END
