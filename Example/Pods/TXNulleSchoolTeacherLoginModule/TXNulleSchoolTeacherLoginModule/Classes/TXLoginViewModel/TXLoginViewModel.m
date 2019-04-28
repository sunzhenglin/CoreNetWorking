//
//  TXLoginViewModel.m
//  LoginAnimation
//
//  Created by xtz_pioneer on 2019/4/24.
//  Copyright © 2019 zhangxiong. All rights reserved.
//

#import "TXLoginViewModel.h"

@implementation TXLoginViewModel

/** 重写init方法 */
- (instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}

/** 操作类型 */
- (void)setOperationType:(LROperationType)operationType{
    _operationType=operationType;
}

/**
 *  登录
 *
 *  @param account 账号
 *  @param password 密码
 */
- (void)loginWithAccount:(NSString*)account password:(NSString*)password{
    self.operationType=LROperationTypeLogIn;
    if (!account || account.length<=0) {
        NSError*error=[TXNWPushMessage pushNetWorkRequestErrorWithErrorCode:-10000 value:@"账号不能为空"];
        if (self.completionHandler) self.completionHandler(error, nil);
    }else if (!password || password.length<=0){
        NSError*error=[TXNWPushMessage pushNetWorkRequestErrorWithErrorCode:-10001 value:@"密码不能为空"];
        if (self.completionHandler) self.completionHandler(error, nil);
    }else{
        __weak typeof(self) weakSelf=self;
        NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
        [parameters setObject:account forKey:@"account"];
        [parameters setObject:password forKey:@"pwd"];
        [parameters setObject:@"000000" forKey:@"vcode"];
        [parameters setObject:@2 forKey:@"type"];
        [TXNetWorking post:HTTP_API(@"user/login.do") parameters:parameters showHUD:NO completionHandler:^(NSError *error, id obj) {
            weakSelf.operationType=LROperationTypeLogIn;
            if (weakSelf.completionHandler) weakSelf.completionHandler(error, obj);
        }];
    }
}

/**
 *  获取用户信息
 *
 *  @param token 令牌
 */
- (void)getUserInfoWithToken:(NSString*)token{
    self.operationType=LROperationTypeGetUserInfo;
    if (!token || token.length<=0) {
        NSError*error=[TXNWPushMessage pushNetWorkRequestErrorWithErrorCode:-10000 value:@"Token不能为空"];
        if (self.completionHandler) self.completionHandler(error, nil);
    }else{
        /*设置请求头*/
        [TXNetWorking setRequestHeaderWithValue:token forkey:@"Token"];
        __weak typeof(self) weakSelf=self;
        NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
        [parameters setValue:@"2" forKey:@"type"];
        [TXNetWorking get:HTTP_API(@"user/info.do") parameters:parameters showHUD:NO completionHandler:^(NSError *error, id obj) {
            weakSelf.operationType=LROperationTypeGetUserInfo;
            if (weakSelf.completionHandler) weakSelf.completionHandler(error, obj);
        }];
    }
}

/**
 *  获取忘记密码短信验证码
 *
 *  @param phoneNumber 手机号
 */
- (void)getForgotPasswordVerificationCodeWithPhoneNumber:(NSString*)phoneNumber{
    self.operationType=LROperationTypeGetForgotPasswordVerificationCode;
    if (!phoneNumber || phoneNumber.length<=0) {
        NSError*error=[TXNWPushMessage pushNetWorkRequestErrorWithErrorCode:-10000 value:@"手机号不能为空"];
        if (self.completionHandler) self.completionHandler(error, nil);
    }else{
        __weak typeof(self) weakSelf=self;
        NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
        [parameters setValue:@"4" forKey:@"type"];
        [parameters setValue:phoneNumber forKey:@"no"];
        [TXNetWorking post:HTTP_API(@"user/vcode.do") parameters:parameters showHUD:NO completionHandler:^(NSError *error, id obj) {
            weakSelf.operationType=LROperationTypeGetForgotPasswordVerificationCode;
            if (weakSelf.completionHandler) weakSelf.completionHandler(error, obj);
        }];
    }
}

/**
 *  修改密码
 *
 *  @param account 账号 (必填)
 *  @param verificationCode 验证码 (必填)
 *  @param password 密码 (必填)
 *  @param confirmPassword 确认密码 (必填)
 */
- (void)changePasswordWithAccount:(NSString*)account verificationCode:(NSString*)verificationCode password:(NSString*)password confirmPassword:(NSString*)confirmPassword{
    self.operationType=LROperationTypeChangePassword;
    if (!account || account.length<=0) {
        NSError*error=[TXNWPushMessage pushNetWorkRequestErrorWithErrorCode:-10000 value:@"账号不能为空"];
        if (self.completionHandler) self.completionHandler(error, nil);
    }else if (!verificationCode || verificationCode.length<=0) {
        NSError*error=[TXNWPushMessage pushNetWorkRequestErrorWithErrorCode:-10001 value:@"验证码不能为空"];
        if (self.completionHandler) self.completionHandler(error, nil);
    }else if (!password || password.length<=0){
        NSError*error=[TXNWPushMessage pushNetWorkRequestErrorWithErrorCode:-10002 value:@"密码不能为空"];
        if (self.completionHandler) self.completionHandler(error, nil);
    }else if (!confirmPassword || confirmPassword.length<=0){
        NSError*error=[TXNWPushMessage pushNetWorkRequestErrorWithErrorCode:-10003 value:@"确认密码不能为空"];
        if (self.completionHandler) self.completionHandler(error, nil);
    }else if (![password isEqualToString:confirmPassword]){
        NSError*error=[TXNWPushMessage pushNetWorkRequestErrorWithErrorCode:-10004 value:@"密码不一致"];
        if (self.completionHandler) self.completionHandler(error, nil);
    }else{
        __weak typeof(self) weakSelf=self;
        NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
        [parameters setValue:@"2" forKey:@"type"];
        [parameters setValue:account forKey:@"no"];
        [parameters setValue:password forKey:@"pwd"];
        [parameters setValue:verificationCode forKey:@"vcode"];
        [TXNetWorking post:HTTP_API(@"user/pwd/found.do") parameters:parameters showHUD:NO completionHandler:^(NSError *error, id obj) {
            weakSelf.operationType=LROperationTypeChangePassword;
            if (weakSelf.completionHandler) weakSelf.completionHandler(error, obj);
        }];
    }
}

@end
