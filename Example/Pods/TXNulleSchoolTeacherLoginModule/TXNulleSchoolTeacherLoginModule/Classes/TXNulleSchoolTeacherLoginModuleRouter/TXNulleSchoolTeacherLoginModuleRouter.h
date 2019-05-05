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
    // 创建登录模块用户信息
    NSMutableDictionary *userInfo=[NSMutableDictionary dictionary];
    // 定义登录成功回调
    typedef UIViewController *_Nonnull(^TXLICompletionHandler) (void);
    // 登录成功回调
    TXLICompletionHandler loginCompletionHandler = ^ {
    NSLog(@"登录成功。");
    // 创建首页
    UINavigationController *navigationController=[[UINavigationController alloc]initWithRootViewController:[TXViewController new]];
    // 返回首页
    return navigationController;
    };
    // 定义修改密码成功回调
    typedef void (^TXFPCompletionHandler) (void);
    // 忘记密码回调
    TXFPCompletionHandler forgetPasswordCompletionHandler = ^ {
    NSLog(@"修改密码成功。");
    };
    // 设置登录成功回调
    [userInfo setValue:loginCompletionHandler forKey:@"loginCompletionHandler"];
    // 设置忘记密码回调
    [userInfo setValue:forgetPasswordCompletionHandler forKey:@"forgetPasswordCompletionHandler"];
    // 设置根视图
    self.window.rootViewController = [MGJRouter objectForURL:@"tx://get/nulleSchool/teacher/loginModule" withUserInfo:userInfo];
    // 设置为主窗口并显示出来
    [self.window makeKeyAndVisible];
*/

@interface TXNulleSchoolTeacherLoginModuleRouter : NSObject

@end

NS_ASSUME_NONNULL_END
