//
//  TXForgetPasswordViewController.h
//  LoginAnimation
//
//  Created by xtz_pioneer on 2019/4/24.
//  Copyright © 2019 zhangxiong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/** 忘记密码 */
@interface TXForgetPasswordViewController : UIViewController
/** 完成回调 */
@property (nonatomic,copy)NWCompletionHandler forgetPasswordCompletionHandler;
@end

NS_ASSUME_NONNULL_END
