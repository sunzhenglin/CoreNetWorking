//
//  TXNulleSchoolTeacherLoginModuleRouter.m
//  AFNetworking
//
//  Created by xtz_pioneer on 2019/4/25.
//

#import "TXNulleSchoolTeacherLoginModuleRouter.h"
#import "TXLoginViewController.h"
#import "IQKeyboardManager.h"

/** 获取纳乐智校教师端登录模块 */
NSString *const TXGetLoginModuleURL = @"tx://get/nulleSchool/teacher/loginModule";

/** 退出登录纳乐智校教师端登录 */
NSString *const TXSignOutURL = @"tx://signOut/nulleSchool/teacher";

/** 纳乐智校教师端登录模块登录 完成处理程序Key */
NSString *const TXLoginCompletionHandlerKey=@"loginCompletionHandler";

/** 纳乐智校教师端登录模块 忘记密码完成处理程序Key */
NSString *const TXForgetPasswordCompletionHandlerKey=@"forgetPasswordCompletionHandler";

/** 登录模块 */
@implementation TXNulleSchoolTeacherLoginModuleRouter

/** 获取当前控制器 */
+ (UIViewController*)currentViewController{
    id appDelegate = [UIApplication sharedApplication].delegate;
    UIWindow *window = [appDelegate window];
    UIViewController *currentViewController = window.rootViewController;
    while (currentViewController.presentedViewController) {
        currentViewController = currentViewController.presentedViewController;
    }
    if ([currentViewController isKindOfClass:[UITabBarController class]]) {
        currentViewController = [(UITabBarController *)currentViewController selectedViewController];
    }
    if ([currentViewController isKindOfClass:[UINavigationController class]]) {
        currentViewController = [(UINavigationController *)currentViewController topViewController];
    }
    return currentViewController;
}

/** 自动注册 */
+ (void)load{
    
    // 注册 登录模块URL
    [MGJRouter registerURLPattern:TXGetLoginModuleURL toObjectHandler:^id(NSDictionary *routerParameters) {
        // 设置开发类型
        [TXUserDataManager userDataManager].logInInfo.developType = TXDevelopTypeTeacher;
        // bundle
        NSBundle *bundle = [TXURBundle bundleWithClass:self resource:TXNulleSchoolTeacherLoginModule_Bundle_Name];
        // plistPath
        NSString *plistPath = [bundle pathForResource:TXNulleSchoolTeacherLoginModule_ErrorCodePlist_Name ofType:@"plist"];
        // errorCodeDictionary
        NSDictionary *errorCodeDictionary =[NSDictionary dictionaryWithContentsOfFile:plistPath];
        // 添加错误代码
        [TXNetWorking addErrorCodeDictionary:errorCodeDictionary];
        // 错误消息名称Key
        [TXNetWorking setErrorMessageNameKey:@"msg"];
        // 安装键盘管理
        [TXNulleSchoolTeacherLoginModuleRouter installPlugin_IQKeyboardManager];
        // 创建登录模块
        TXLoginViewController *loginViewController = [[TXLoginViewController alloc]init];
        loginViewController.loginCompletionHandler = routerParameters[MGJRouterParameterUserInfo][TXLoginCompletionHandlerKey];
        loginViewController.forgetPasswordCompletionHandler = routerParameters[MGJRouterParameterUserInfo][TXForgetPasswordCompletionHandlerKey];
        // 返回登录模块
        return loginViewController;
    }];
    
    // 注册 退出登录URL
    [MGJRouter registerURLPattern:TXSignOutURL toHandler:^(NSDictionary *routerParameters) {
        // 移除用户全部数据(移除登录数据/用户数据/请求头)
        [TXLoginViewController removeUserAllData];
        // 把最前面的视图控制器dismiss掉
        UIViewController *parentViewController = [self currentViewController].presentingViewController;
        UIViewController *bottomViewController;
        while (parentViewController) {
            bottomViewController = parentViewController;
            parentViewController = parentViewController.presentingViewController;
        }
        [bottomViewController dismissViewControllerAnimated:YES completion:nil];
        TXLog(@"退出成功");
    }];
}

/** 安装键盘管理 */
+ (void)installPlugin_IQKeyboardManager{
    // 获取类库的单例变量
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager];
    // 控制整个功能是否启用
    keyboardManager.enable = YES;
    // 控制点击背景是否收起键盘
    keyboardManager.shouldResignOnTouchOutside = YES;
    // 控制键盘上的工具条文字颜色是否用户自定义
    keyboardManager.shouldToolbarUsesTextFieldTintColor = YES;
    // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews;
    // 控制是否显示键盘上的工具条
    keyboardManager.enableAutoToolbar = YES;
    // 是否显示占位文字
    keyboardManager.shouldShowToolbarPlaceholder = YES;
    // 设置占位文字的字体
    keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:tRealFontSize(15.0f)];
    // 输入框距离键盘的距离
    keyboardManager.keyboardDistanceFromTextField = tRealFontSize(10.f);
}

@end
