//
//  TXLoginViewModel.h
//  LoginAnimation
//
//  Created by xtz_pioneer on 2019/4/24.
//  Copyright © 2019 zhangxiong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** 操作类型 */
typedef NS_ENUM(NSInteger,LROperationType){
    /** 登录 */
    LROperationTypeLogIn        =0,
    /** 获取用户信息 */
    LROperationTypeGetUserInfo  =1,
    /** 获取忘记密码短信验证码 */
    LROperationTypeGetForgotPasswordVerificationCode =2,
    /** 修改密码 */
    LROperationTypeChangePassword =3,
};

/** 登录ViewModel */
@interface TXLoginViewModel : NSObject
/** 操作类型 */
@property (nonatomic,assign,readonly)LROperationType operationType;
/** 完成回调 */
@property (nonatomic,copy)NWCompletionHandler completionHandler;

/**
 *  登录
 *
 *  @param account 账号
 *  @param password 密码
 */
- (void)loginWithAccount:(NSString*)account password:(NSString*)password;

/**
 *  获取用户信息
 *
 *  @param token 令牌
 */
- (void)getUserInfoWithToken:(NSString*)token;

/**
 *  获取忘记密码短信验证码
 *
 *  @param phoneNumber 手机号
 */
- (void)getForgotPasswordVerificationCodeWithPhoneNumber:(NSString*)phoneNumber;

/**
 *  修改密码
 *
 *  @param account 账号 (必填)
 *  @param verificationCode 验证码 (必填)
 *  @param password 密码 (必填)
 *  @param confirmPassword 确认密码 (必填)
 */
- (void)changePasswordWithAccount:(NSString*)account verificationCode:(NSString*)verificationCode password:(NSString*)password confirmPassword:(NSString*)confirmPassword;

@end

NS_ASSUME_NONNULL_END
