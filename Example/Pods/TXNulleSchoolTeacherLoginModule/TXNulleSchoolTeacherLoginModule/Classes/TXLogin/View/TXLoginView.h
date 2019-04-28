//
//  TXLoginView.h
//  AFNetworking
//
//  Created by xtz_pioneer on 2019/4/28.
//

#import <UIKit/UIKit.h>
#import "TXLoginTextField.h"
#import "TXLoginButton.h"
#import "TXLoginViewModel.h"

NS_ASSUME_NONNULL_BEGIN

/** 完成回调 */
typedef void(^TXLIVCompletionHandler) (id obj);

/** 登录视图 */
@interface TXLoginView : UIView
/** 背景图 */
@property (nonatomic,strong)UIImageView *backgroundImageView;
/** 用户名  */
@property (nonatomic,strong)TXLoginTextField *username;
/** 登录密码  */
@property (nonatomic,strong)TXLoginTextField *password;
/** 登录按钮  */
@property (nonatomic,strong)TXLoginButton *login;
/** 忘记密码按钮  */
@property (nonatomic,strong)UIButton *forgetPassword;
/** 忘记密码回调  */
@property (nonatomic,copy)TXLIVCompletionHandler forgetPasswordCompletionHandler;
/** 登录 */
@property (nonatomic,copy)TXLIVCompletionHandler loginCompletionHandler;
@end

NS_ASSUME_NONNULL_END
