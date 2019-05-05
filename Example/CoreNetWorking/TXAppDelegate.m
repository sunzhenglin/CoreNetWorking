//
//  TXAppDelegate.m
//  CoreNetWorking
//
//  Created by acct<blob>=0xE7A9BAE781B5E699BAE883BD on 02/25/2019.
//  Copyright (c) 2019 acct<blob>=0xE7A9BAE781B5E699BAE883BD. All rights reserved.
//

#import "TXAppDelegate.h"

@implementation TXAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    // 网络错误代码
    self.netErrorDelegate=[TXNetErrorDelegate new];
    // 网络错误代码代理
    self.netErrorDelegate.delegate=self;
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
    [userInfo setValue:loginCompletionHandler forKey:TXLoginCompletionHandlerKey];
    // 设置忘记密码回调
    [userInfo setValue:forgetPasswordCompletionHandler forKey:TXForgetPasswordCompletionHandlerKey];
    // 设置根视图
    self.window.rootViewController = [MGJRouter objectForURL:TXGetLoginModuleURL withUserInfo:userInfo];
    // 设置为主窗口并显示出来
    [self.window makeKeyAndVisible];
    // Override point for customization after application launch.
    return YES;
}

/** 错误类型 */
- (void)netErrorDelegate:(TXNetErrorDelegate*)netErrorDelegate errorCode:(NSInteger)errorCode errorCodeString:(NSString*)errorCodeString{
    NSLog(@"errorCode:%@  errorCodeString:%@",[NSString stringWithFormat:@"%ld",(long)errorCode],errorCodeString);
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
