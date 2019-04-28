//
//  TXNetWorking.h
//  Furling
//
//  Created by xtz_pioneer on 2018/7/2.
//  Copyright © 2018年 zhangxiong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "TXNetModel.h"
#import "TXNWPushMessage.h"
#import "TXNWHUD.h"
#import "TXNetErrorDelegate.h"
#import "TXNetworkStatusDelegate.h"

/** 完成回调 */
typedef void (^NWCompletionHandler) (NSError *error,id obj);

/**
 *  网络管理器
 *
 *  主要功能:GET请求、POST请求、上传单张图片、上传多张图片、上传多组多图片、网络检测、HUD、上传单文件、上传多文件、上传多组多文件
 *
 *  主要设置:1.设置请求超时时间 2.设置请求头 3.设置内容类型 4.设置网络请求识别码 5.设置错误代码 6.设置错误消息名称Key
 *
 *  辅助快捷:1.HUD显示 2.获取当前时间
 *
 *  辅助功能1:“TXNetErrorDelegate.h”文件主要集中处理错误代码
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
 *  获取当前时间
 *
 *  注意:“dateFormat”参数默认格式为:yyyyMMddHHmmss
 *
 *  @param dateFormat 时间格式 如:yyyyMMddHHmmss
 *
 *  @return 当前时间
 */
+ (NSString*)currentTimeWithDateFormat:(NSString*)dateFormat;

/** 错误代码字典 */
@property (nonatomic,strong,readonly)NSDictionary *errorCodeDictionary;

/** 错误代码字典 */
+ (NSDictionary*)errorCodeDictionary;

/**
 *  是否存在错误代码的值
 *
 *  @param value 错误代码的值
 */
+ (BOOL)existErrorCodeValue:(NSString*)value;

/**
 *  是否存在错误代码的键
 *
 *  @param key 错误代码的键
 */
+ (BOOL)existErrorCodeKey:(NSInteger)key;

/**
 *  添加错误代码字典
 *
 *  @param errorCodeDictionary 错误字典
 */
+ (void)addErrorCodeDictionary:(NSDictionary*)errorCodeDictionary;

/**
 *  添加错误代码字典
 *
 *  @param value 错误值
 *  @param key   键值对
 *
 *  @return BOOL 是否添加成功
 */
+ (BOOL)addErrorCodeValue:(NSString*)value forKey:(NSInteger)key;

/** 错误消息名称Key */
@property (nonatomic,copy)NSString *errorMessageNameKey;

/**
 *  错误消息名称Key
 *
 *  @param errorMessageNameKey 错误消息Key 如:msg
 */
+ (void)setErrorMessageNameKey:(NSString*)errorMessageNameKey;

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
 *  @param fileName 给图片起一个名字，默认为当前日期时间,格式为"yyyyMMddHHmmss"，后缀为`jpg`
 *  @param name 与指定的图片相关联的名称，这是由后端写接口的人指定的，如imagefiles
 *  @param mimeType 默认为image/jpeg
 *  @param parameters 参数
 *  @param showHUD 是否显示HUD
 */
+ (void)uploadImage:(NSString *)strURL
              image:(UIImage *)image
           fileName:(NSString *)fileName
               name:(NSString *)name
           mimeType:(NSString *)mimeType
         parameters:(NSDictionary *)parameters
            showHUD:(BOOL)showHUD
  completionHandler:(NWCompletionHandler)completionHandler;

/**
 *  图片上传(多张)
 *  @param strURL 上传图片的接口路径，如/path/images/
 *  @param images 图片集合
 *  @param fileName 给图片起一个名字，默认为当前日期时间,格式为"yyyyMMddHHmmss"，后缀为`jpg`
 *  @param name 与指定的图片相关联的名称，这是由后端写接口的人指定的，如imagefiles
 *  @param mimeType 默认为image/jpeg
 *  @param parameters 参数
 *  @param showHUD 是否显示HUD
 */
+ (void)uploadImage:(NSString *)strURL
              images:(NSArray<UIImage*> *)images
           fileName:(NSString *)fileName
               name:(NSString *)name
           mimeType:(NSString *)mimeType
         parameters:(NSDictionary *)parameters
            showHUD:(BOOL)showHUD
  completionHandler:(NWCompletionHandler)completionHandler;

/**
 *  图片上传(多组、多张)
 *  @param strURL 上传图片的接口路径，如/path/images/
 *  @param images 多组图片集合
 *  @param fileName 给图片起一个名字，默认为当前日期时间,格式为"yyyyMMddHHmmss"，后缀为`jpg`
 *  @param names 与指定的图片相关联的名称集合，这是由后端写接口的人指定的，如imagefiles1、imagefiles2
 *  @param mimeType 默认为image/jpeg
 *  @param parameters 参数
 *  @param showHUD 是否显示HUD
 */
+ (void)uploadImage:(NSString *)strURL
             images:(NSArray<NSArray<UIImage*>*>*)images
           fileName:(NSString *)fileName
              names:(NSArray<NSString*> *)names
           mimeType:(NSString *)mimeType
         parameters:(NSDictionary *)parameters
            showHUD:(BOOL)showHUD
  completionHandler:(NWCompletionHandler)completionHandler;

/**
 *  上传文件
 *  @param strURL 上传文件的接口路径，如/path/files/
 *  @param fileURL 文件的URL
 *  @param fileName 给文件起一个名字，如:"yyyyMMddHHmmss.mp4"，
 *  @param name 与指定的文件相关联的名称，这是由后端写接口的人指定的，如audiofiles
 *  @param mimeType 上传类型:application/octet-stream
 *  @param parameters 参数
 *  @param showHUD 是否显示HUD
 */
+ (void)uploadFile:(NSString*)strURL
           fileURL:(NSURL*)fileURL
          fileName:(NSString*)fileName
              name:(NSString*)name
          mimeType:(NSString*)mimeType
        parameters:(NSDictionary*)parameters
           showHUD:(BOOL)showHUD
 completionHandler:(NWCompletionHandler)completionHandler;

/**
 *  上传文件(多文件)
 *  @param strURL 上传文件的接口路径，如/path/files/
 *  @param fileURLs 文件的URL集合
 *  @param fileName 给文件起一个名字，如:"yyyyMMddHHmmss.mp4"，
 *  @param name 与指定的文件相关联的名称，这是由后端写接口的人指定的，如audiofiles
 *  @param mimeType 上传类型:application/octet-stream
 *  @param parameters 参数
 *  @param showHUD 是否显示HUD
 */
+ (void)uploadFile:(NSString*)strURL
          fileURLs:(NSArray<NSURL*>*)fileURLs
          fileName:(NSString*)fileName
              name:(NSString*)name
          mimeType:(NSString*)mimeType
        parameters:(NSDictionary*)parameters
           showHUD:(BOOL)showHUD
 completionHandler:(NWCompletionHandler)completionHandler;

/**
 *  上传文件(多组、多文件)
 *  @param strURL 上传文件的接口路径，如/path/files/
 *  @param fileURLs 多组文件的URL集合
 *  @param fileName 给文件起一个名字，如:"yyyyMMddHHmmss.mp4"，
 *  @param names 与指定的文件相关联的名称集合，这是由后端写接口的人指定的，如audiofiles1,audiofiles2
 *  @param mimeType 上传类型:application/octet-stream
 *  @param parameters 参数
 *  @param showHUD 是否显示HUD
 */
+ (void)uploadFile:(NSString*)strURL
          fileURLs:(NSArray<NSArray<NSURL*>*>*)fileURLs
          fileName:(NSString*)fileName
             names:(NSArray<NSString*>*)names
          mimeType:(NSString*)mimeType
        parameters:(NSDictionary*)parameters
           showHUD:(BOOL)showHUD
 completionHandler:(NWCompletionHandler)completionHandler;

@end
