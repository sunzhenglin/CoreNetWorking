//
//  TXFChangePasswordModel.h
//  LoginAnimation
//
//  Created by xtz_pioneer on 2019/4/25.
//  Copyright © 2019 zhangxiong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** 修改密码模型 */
@interface TXFChangePasswordModel : NSObject
/** 账号 */
@property (nonatomic,copy)NSString *account;
/** 验证码 */
@property (nonatomic,copy)NSString *verificationCode;
/** 密码 */
@property (nonatomic,copy)NSString *password;
/** 确认密码 */
@property (nonatomic,copy)NSString *confirmPassword;
@end

NS_ASSUME_NONNULL_END
