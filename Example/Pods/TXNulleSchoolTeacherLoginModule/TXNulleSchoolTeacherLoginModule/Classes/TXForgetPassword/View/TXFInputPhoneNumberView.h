//
//  TXFInputPhoneNumberView.h
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
typedef void(^TXFIPNCompletionHandler) (id obj);

/** 输入手机号 */
@interface TXFInputPhoneNumberView : UIView
/** 标题 */
@property (nonatomic,weak)UILabel *titleLabel;
/** textField */
@property (nonatomic,weak)TXLoginTextField *textField;
/** 下一步 */
@property (nonatomic,weak)TXLoginButton *next;
/** 完成回调 */
@property (nonatomic,copy)TXFIPNCompletionHandler nextCompletionHandler;

@end

NS_ASSUME_NONNULL_END
