//
//  TXForgetPasswordViewController.h
//  LoginAnimation
//
//  Created by xtz_pioneer on 2019/4/24.
//  Copyright © 2019 zhangxiong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/** 修改密码成功回调 */
typedef void (^TXFPCompletionHandler) (void);
/** 忘记密码 */
@interface TXForgetPasswordViewController : UIViewController
/** 修改密码成功回调*/
@property (nonatomic,copy)TXFPCompletionHandler forgetPasswordCompletionHandler;
@end

NS_ASSUME_NONNULL_END
