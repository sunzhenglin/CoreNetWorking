//
//  TXNetWorking.h
//  Furling
//
//  Created by xtz_pioneer on 2018/7/2.
//  Copyright © 2018年 zhangxiong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "TXNetModel.h"
#import "TXNetErrorCode.h"
#import "TXNetErrorDelegate.h"
#import "TXNetworkStatusDelegate.h"
#import "NWNetworkStatus.h"
/** 完成回调 */
typedef void (^NWCompletionHandler) (NSError *error,id obj);

/** HUD显示类型 */
typedef NS_ENUM(NSInteger,NWShowHUDType){
    NWShowHUDTypeDefault     =0,//默认
    NWShowHUDTypeInfo        =1,//信息
    NWShowHUDTypeCaveatInfo  =2,//警告
    NWShowHUDTypeSuccessInfo =3,//成功
    NWShowHUDTypeFailureInfo =4,//失败
};

/**
 *  网络管理器
 *
 *  主要功能:GET请求、POST请求、上传单张图片、上传多张图片、网络检测、HUD
 *
 *  辅助功能1:“TXNetErrorCode.h”以及“TXNetErrorDelegate.h”文件主要集中处理错误代码
 *
 *  辅助功能2:“TXNetworkStatusDelegate.”文件主要集中处理网络状态
 *
 */
@interface TXNetWorking : NSObject

/** 网络管理器 */
+ (TXNetWorking*)netWorkingManager;

/**
 *  AFHTTPSessionManager
 *
 *  注意:只有调用“netWorkingManager”方法才能使用
 *
 */
@property (nonatomic,strong,readonly)AFHTTPSessionManager *aFHTTPManager;

/**
 *  AFNetworkReachabilityManager
 *
 *  注意:只有调用“openNetworkMonitoring”方法才能使用
 *
 */
@property (nonatomic,strong,readonly)AFNetworkReachabilityManager *aFReachabilityManager;

/**
 *  网络状态
 *
 *  注意:只用在开启网络检测时可用
 *
 */
@property (nonatomic,assign,readonly)NWNetworkStatus networkStatus;

/**
 *  网络请求识别码
 *
 *  注意:适用于空灵智能
 *
 */
@property (nonatomic,assign)NSInteger code;

/** 请求超时时间 */
@property (nonatomic,assign)NSTimeInterval requestTimedOut;

/**
 *  设置请求超时时间
 *  @param requestTimedOut 超时时间
 */
+ (void)setRequestTimedOut:(NSTimeInterval)requestTimedOut;

/**
 *  设置请求头
 *  @param value 请求头的值
 *  @param key 请求头的键
 */
+ (void)setRequestHeaderWithValue:(NSString*)value forkey:(NSString*)key;

/** 内容类型*/
@property (nonatomic,copy)NSSet<NSString*> *contentTypes;

/**
 *  设置内容类型
 *  @param contentTypes 内容类型
 */
+ (void)setContentTypes:(NSSet<NSString*> *)contentTypes;

/** 开启网络检测 */
+ (void)openNetworkMonitoring;

/**
 *  显示HUD
 *  @param showHUDType HUD显示类型
 *  @param info 信息
 */
+ (void)showHUDWithShowHUDType:(NWShowHUDType)showHUDType info:(NSString*)info;

/** 消除HUD */
+ (void)dismissHUD;

/**
 *  post
 *  @param strURL 请求的URL
 *  @param parameters 请求的参数
 *  @param showHUD 是否显示HUD
 */
+ (void)post:(NSString*)strURL parameters:(NSDictionary*)parameters showHUD:(BOOL)showHUD completionHandler:(NWCompletionHandler)completionHandler;

/**
 *  get
 *  @param strURL 请求的URL
 *  @param parameters 请求的参数
 *  @param showHUD 是否显示HUD
 */
+ (void)get:(NSString*)strURL parameters:(NSDictionary*)parameters showHUD:(BOOL)showHUD completionHandler:(NWCompletionHandler)completionHandler;

/**
 *  图片上传(单张)
 *  @param strURL 上传图片的接口路径，如/path/images/
 *  @param image 图片对象
 *  @param filename 给图片起一个名字，默认为当前日期时间,格式为"yyyyMMddHHmmss"，后缀为`jpg`
 *  @param name 与指定的图片相关联的名称，这是由后端写接口的人指定的，如imagefiles
 *  @param mimeType 默认为image/jpeg
 *  @param parameters 参数
 *  @param showHUD 是否显示HUD
 */
+ (void)uploadImage:(NSString *)strURL
              image:(UIImage *)image
           filename:(NSString *)filename
               name:(NSString *)name
           mimeType:(NSString *)mimeType
         parameters:(NSDictionary *)parameters
            showHUD:(BOOL)showHUD
  completionHandler:(NWCompletionHandler)completionHandler;

/**
 *  图片上传(多张)
 *  @param strURL 上传图片的接口路径，如/path/images/
 *  @param images 图片集合
 *  @param filename 给图片起一个名字，默认为当前日期时间,格式为"yyyyMMddHHmmss"，后缀为`jpg`
 *  @param name 与指定的图片相关联的名称，这是由后端写接口的人指定的，如imagefiles
 *  @param mimeType 默认为image/jpeg
 *  @param parameters 参数
 *  @param showHUD 是否显示HUD
 */
+ (void)uploadImage:(NSString *)strURL
              images:(NSArray<UIImage*> *)images
           filename:(NSString *)filename
               name:(NSString *)name
           mimeType:(NSString *)mimeType
         parameters:(NSDictionary *)parameters
            showHUD:(BOOL)showHUD
  completionHandler:(NWCompletionHandler)completionHandler;

/**
 *  图片上传(多组、多张)
 *  @param strURL 上传图片的接口路径，如/path/images/
 *  @param images 多组图片集合
 *  @param filename 给图片起一个名字，默认为当前日期时间,格式为"yyyyMMddHHmmss"，后缀为`jpg`
 *  @param names 与指定的图片相关联的名称集合，这是由后端写接口的人指定的，如imagefiles1、imagefiles2
 *  @param mimeType 默认为image/jpeg
 *  @param parameters 参数
 *  @param showHUD 是否显示HUD
 */
+ (void)uploadImage:(NSString *)strURL
             images:(NSArray<NSArray<UIImage*>*> *)images
           filename:(NSString *)filename
              names:(NSArray<NSString*> *)names
           mimeType:(NSString *)mimeType
         parameters:(NSDictionary *)parameters
            showHUD:(BOOL)showHUD
  completionHandler:(NWCompletionHandler)completionHandler;

@end
