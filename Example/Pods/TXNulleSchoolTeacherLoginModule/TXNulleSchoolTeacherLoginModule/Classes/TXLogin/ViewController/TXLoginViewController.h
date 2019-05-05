//
//  TXLoginViewController.h
//  LoginAnimation
//
//  Created by xtz_pioneer on 2019/4/22.
//  Copyright © 2019 zhangxiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TXForgetPasswordViewController.h"

NS_ASSUME_NONNULL_BEGIN
/** 登录成功回调 */
typedef UIViewController *_Nonnull(^TXLICompletionHandler) (void);
/** 登录控制视图 */
@interface TXLoginViewController : UIViewController
/** 登录完成回调 */
@property (nonatomic,copy)TXLICompletionHandler loginCompletionHandler;
/** 修改密码成功回调*/
@property (nonatomic,copy)TXFPCompletionHandler forgetPasswordCompletionHandler;
/** 设置请求头 */
+ (void)setupRequestHeader;
/** 移除请求头 */
+ (void)removeRequestHeader;
/** 移除用户全部数据(移除登录数据/用户数据/请求头) */
+ (void)removeUserAllData;
@end

NS_ASSUME_NONNULL_END
