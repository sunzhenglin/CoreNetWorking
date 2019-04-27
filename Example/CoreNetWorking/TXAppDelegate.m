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
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"NulleSmartSchoolErrorCode" ofType:@"plist"];
    NSDictionary *dict =[NSDictionary dictionaryWithContentsOfFile:path];
    [TXNetWorking addErrorCodeDictionary:dict];
    [TXNetWorking setErrorMessageNameKey:@"msg"];
    
    [TXNetWorking addErrorCodeValue:@"未找到科目" forKey:4064];
    [TXNetWorking addErrorCodeValue:@"未找到科目" forKey:4064];
    [TXNetWorking addErrorCodeValue:@"未找到科目" forKey:4064];
    [TXNetWorking addErrorCodeValue:@"未找到科目" forKey:4064];
    [TXNetWorking addErrorCodeValue:@"Uface注册失败" forKey:4029];
    
    // 创建参数
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    // 定义登录回调代码块
    typedef UIViewController *_Nonnull(^TXLICompletionHandler) (NSError *_Nullable error  ,id _Nullable obj);
    // 登录回调
    TXLICompletionHandler loginCompletionHandler = ^(NSError *_Nullable error  ,id _Nullable obj){
        UINavigationController *navigationController=[[UINavigationController alloc]initWithRootViewController:[TXViewController new]];
        return navigationController;
    };
    [parameters setValue:loginCompletionHandler forKey:@"loginCompletionHandler"];
    self.window.rootViewController=[MGJRouter objectForURL:TXGetLoginModuleURL withUserInfo:parameters];
    
    // Override point for customization after application launch.
    return YES;
}

/** 错误类型 */
- (void)netErrorDelegate:(TXNetErrorDelegate*)netErrorDelegate errorCode:(NSInteger)errorCode errorCodeString:(NSString*)errorCodeString{
    NSLog(@"errorCode:%@  errorCodeString:%@",[NSString stringWithFormat:@"%ld",(long)errorCode],errorCodeString);
    NSLog(@"-------->value:%@",[TXNetErrorDelegate errorCodeKeyForValue:errorCode]);
    NSLog(@"-------->key:%ld",(long)[TXNetErrorDelegate errorCodeValueForKey:errorCodeString]);
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
