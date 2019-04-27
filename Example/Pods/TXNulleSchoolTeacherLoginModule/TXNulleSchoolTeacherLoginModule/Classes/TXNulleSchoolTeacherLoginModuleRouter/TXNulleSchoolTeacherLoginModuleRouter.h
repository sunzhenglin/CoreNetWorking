//
//  TXNulleSchoolTeacherLoginModuleRouter.h
//  AFNetworking
//
//  Created by xtz_pioneer on 2019/4/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** 获取纳乐智校教师端登录模块 */
FOUNDATION_EXPORT NSString *const TXGetLoginModuleURL;

/** 退出登录纳乐智校教师端登录 */
FOUNDATION_EXPORT NSString *const TXSignOutURL;

/** 纳乐智校教师端登录模块登录 完成处理程序Key */
FOUNDATION_EXPORT NSString *const TXLoginCompletionHandlerKey;

/** 纳乐智校教师端登录模块 忘记密码完成处理程序Key */
FOUNDATION_EXPORT NSString *const TXForgetPasswordCompletionHandlerKey;

/**
 *  登录模块
 *
 *  操作说明
 *
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    // 登录回调
    typedef UIViewController *_Nonnull(^TXLICompletionHandler) (NSError *_Nullable error  ,id _Nullable obj);
    TXLICompletionHandler loginCompletionHandler = ^(NSError *_Nullable error  ,id _Nullable obj){
    UINavigationController *navigationController=[[UINavigationController alloc]initWithRootViewController:[TXViewController new]];
    return navigationController;
    };
    // 忘记密码回调
    NWCompletionHandler forgetPasswordCompletionHandler = ^ (NSError *error,id obj){
    };
    [parameters setValue:loginCompletionHandler forKey:@"loginCompletionHandler"];
    [parameters setValue:forgetPasswordCompletionHandler forKey:@"forgetPasswordCompletionHandler"];
    self.window.rootViewController = [MGJRouter objectForURL:@"tx://get/nulleSchool/teacher/loginModule" withUserInfo:parameters];
    [self.window makeKeyAndVisible];
*/

@interface TXNulleSchoolTeacherLoginModuleRouter : NSObject

@end

NS_ASSUME_NONNULL_END
