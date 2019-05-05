//
//  TXNetWorking.m
//  Furling
//
//  Created by xtz_pioneer on 2018/7/2.
//  Copyright © 2018年 zhangxiong. All rights reserved.
//

#import "TXNetWorking.h"

/** DEBUG 打印日志 */
#if DEBUG
#define TXNETLog(s, ... ) NSLog( @"<FileName:%@ InThe:%d Line> Log:%@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define TXNETLog(s, ... )
#endif

@interface TXNetWorking ()
/** 私有错误代码字典 */
@property (nonatomic,strong)NSMutableDictionary *privateErrorCodeDictionary;
@end

@implementation TXNetWorking

/** 网络管理器 */
+ (TXNetWorking*)netWorkingManager{
    static TXNetWorking *netWorkingManagerInstance=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        netWorkingManagerInstance=[[super allocWithZone:nil] init];
    });
    return netWorkingManagerInstance;
}

/** 重写Zone方法保证单例唯一性 */
+ (id)allocWithZone:(NSZone *)zone{
    return [TXNetWorking netWorkingManager];
}

/** 重写copy方法保证单例唯一性 */
- (id)copyWithZone:(NSZone *)zone{
    return [TXNetWorking netWorkingManager];
}

/** 重写mutableCopy方法保证单例唯一性 */
- (id)mutableCopyWithZone:(NSZone *)zone{
    return [TXNetWorking netWorkingManager];
}

/** 重写初始化方法 */
- (instancetype)init{
    if (self = [super init]) {
        /*AFHTTPSessionManager*/
        self.aFHTTPManager=[AFHTTPSessionManager manager];
        /*请求超时*/
        self.requestTimedOut=25.f;
        /*内容类型*/
        self.contentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];
        /*网络请求识别码*/
        self.code=0;
        /*私有错误代码字典*/
        self.privateErrorCodeDictionary=[NSMutableDictionary dictionary];
        /*错误消息名称Key*/
        self.errorMessageNameKey=@"errorMessage";
    }
    return self;
}

#pragma mark- 属性设置

/**
 *  设置AFHTTPSessionManager
 *
 *  注意:只有调用“netWorkingManager”方法才能使用
 *
 */
- (void)setAFHTTPManager:(AFHTTPSessionManager *)aFHTTPManager{
    _aFHTTPManager=aFHTTPManager;
}

/**
 *  设置AFNetworkReachabilityManager
 *
 *  注意:只有调用“openNetworkMonitoring”方法才能使用
 *
 */
- (void)setAFReachabilityManager:(AFNetworkReachabilityManager *)aFReachabilityManager{
    _aFReachabilityManager=aFReachabilityManager;
}

/** 设置请求超时时间 */
- (void)setRequestTimedOut:(NSTimeInterval)requestTimedOut{
    _requestTimedOut=requestTimedOut;
    [self.aFHTTPManager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    self.aFHTTPManager.requestSerializer.timeoutInterval=_requestTimedOut;
    [self.aFHTTPManager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    TXNETLog(@"设置请求超时时间==>contentTypes:%f",_requestTimedOut);
}

/**
 *  设置请求超时时间
 *  @param requestTimedOut 超时时间
 */
+ (void)setRequestTimedOut:(NSTimeInterval)requestTimedOut{
    [self netWorkingManager].requestTimedOut=requestTimedOut;
}


/** 设置内容类型 */
- (void)setContentTypes:(NSSet *)contentTypes{
    _contentTypes=contentTypes;
    self.aFHTTPManager.responseSerializer.acceptableContentTypes=_contentTypes;
    TXNETLog(@"设置内容类型==>contentTypes:%@",contentTypes);
}

/**
 *  设置内容类型
 *  @param contentTypes 内容类型
 */
+ (void)setContentTypes:(NSSet<NSString*> *)contentTypes{
    [self netWorkingManager].contentTypes=contentTypes;
}

/**
 *  设置请求头
 *  @param value 请求头的值
 *  @param key 请求头的键
 */
+ (void)setRequestHeaderWithValue:(NSString*)value forkey:(NSString*)key{
    [[self netWorkingManager].aFHTTPManager.requestSerializer setValue:value forHTTPHeaderField:key];
    TXNETLog(@"设置请求头==>value:%@ key:%@",value,key);
}

/**
 *  设置网络请求识别码
 *
 *  注意:适用于空灵智能
 *
 */
- (void)setCode:(NSInteger)code{
    _code=code;
    TXNETLog(@"设置网络请求识别码==>code:%ld",(long)_code);
}

/**
 *  获取当前时间
 *
 *  注意:“dateFormat”参数默认格式为:yyyyMMddHHmmss
 *
 *  @param dateFormat 时间格式 如:yyyyMMddHHmmss
 *
 *  @return 当前时间
 */
+ (NSString*)currentTimeWithDateFormat:(NSString*)dateFormat{
    if (!dateFormat || ![dateFormat isKindOfClass:[NSString class]] || dateFormat.length<=0) dateFormat=@"yyyyMMddHHmmss";
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    formatter.dateFormat=dateFormat;
    NSString *currentTime=[formatter stringFromDate:[NSDate date]];
    return currentTime;
}

/** 私有错误代码字典 */
- (void)setPrivateErrorCodeDictionary:(NSMutableDictionary *)privateErrorCodeDictionary{
    _privateErrorCodeDictionary=privateErrorCodeDictionary;
}

/** 错误代码字典 */
- (NSDictionary*)errorCodeDictionary{
    return self.privateErrorCodeDictionary.copy;
}

/** 错误代码字典 */
+ (NSDictionary*)errorCodeDictionary{
    return [self netWorkingManager].errorCodeDictionary;
}

/**
 *  是否存在错误代码的值
 *
 *  @param value 错误代码的值
 */
+ (BOOL)existErrorCodeValue:(NSString*)value{
    __block BOOL exist;
    [[self netWorkingManager].errorCodeDictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isEqualToString:value]) exist=YES;
    }];
    return exist;
}

/**
 *  是否存在错误代码的键
 *
 *  @param key 错误代码的键
 */
+ (BOOL)existErrorCodeKey:(NSInteger)key{
    if ([[[self netWorkingManager].errorCodeDictionary allKeys] containsObject:[NSString stringWithFormat:@"%ld",(long)key]]){
        return YES;
    }else{
        return NO;
    }
}

/**
 *  添加错误代码字典
 *
 *  @param errorCodeDictionary 错误字典
 */
+ (void)addErrorCodeDictionary:(NSDictionary*)errorCodeDictionary{
    [errorCodeDictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [self addErrorCodeValue:obj forKey:[key integerValue]];
    }];
}

/**
 *  添加错误代码字典
 *
 *  @param value 错误值
 *  @param key   键值对
 *
 *  @return BOOL 是否添加成功
 */
+ (BOOL)addErrorCodeValue:(NSString*)value forKey:(NSInteger)key{
    if ([self existErrorCodeValue:value] && [TXNetWorking existErrorCodeKey:key]) {
        TXNETLog(@"添加错误代码失败==>存在相同的Value:%ld 相同的Key:%@",(long)key,value);
        return NO;
    }else{
        [[self netWorkingManager].privateErrorCodeDictionary setValue:value forKey:[NSString stringWithFormat:@"%ld",(long)key]];
        TXNETLog(@"添加错误代码成功==>Value:%@ Key:%ld",value,(long)key);
        return YES;
    }
}

/** 错误消息名称Key */
- (void)setErrorMessageNameKey:(NSString *)errorMessageNameKey{
    _errorMessageNameKey=errorMessageNameKey;
    TXNETLog(@"错误消息名称Key==>Key:%@",_errorMessageNameKey);
}

/**
 *  错误消息名称Key
 *
 *  @param errorMessageNameKey 错误消息Key 如:msg
 */
+ (void)setErrorMessageNameKey:(NSString*)errorMessageNameKey{
    [self netWorkingManager].errorMessageNameKey=errorMessageNameKey;
}

#pragma mark- 网络状态

/** 开启网络检测 */
+ (void)openNetworkMonitoring{
    [self netWorkingManager].aFReachabilityManager=[AFNetworkReachabilityManager sharedManager];
    [[self netWorkingManager].aFReachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status){
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:{
                [TXNetWorking netWorkingManager].networkStatus=NWNetworkStatusUnknown;
                [TXNWPushMessage pushNetworkStatusWithNetworkStatus:NWNetworkStatusUnknown];
            }
                break;
            case AFNetworkReachabilityStatusNotReachable:{
                [TXNetWorking netWorkingManager].networkStatus=NWNetworkStatusReachable;
                [TXNWPushMessage pushNetworkStatusWithNetworkStatus:NWNetworkStatusReachable];
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                [TXNetWorking netWorkingManager].networkStatus=NWNetworkStatusReachableViaWWAN;
                [TXNWPushMessage pushNetworkStatusWithNetworkStatus:NWNetworkStatusReachableViaWWAN];
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                [TXNetWorking netWorkingManager].networkStatus=NWNetworkStatusReachableViaWiFi;
                [TXNWPushMessage pushNetworkStatusWithNetworkStatus:NWNetworkStatusReachableViaWiFi];
            }
                break;
            default:
                break;
        }
    }];
    [[self netWorkingManager].aFReachabilityManager startMonitoring];
}

/** 网络状态 */
- (void)setNetworkStatus:(NWNetworkStatus)networkStatus{
    _networkStatus=networkStatus;
}

#pragma mark- HUD

/**
 *  显示HUD
 *  @param showHUDType HUD显示类型
 *  @param info 信息
 */
+ (void)showHUDWithShowHUDType:(NWShowHUDType)showHUDType info:(NSString* _Nullable)info{
    [TXNWHUD showHUDWithShowHUDType:showHUDType info:info];
}

/**
 *  显示进度HUD
 *  @param progress 进度(0到1)
 *  @param info 信息
 */
+ (void)showHUDWithProgress:(CGFloat)progress info:(NSString* _Nullable)info{
    [TXNWHUD showHUDWithProgress:progress info:info];
}

/** 消除HUD */
+ (void)dismissHUD{
    [TXNWHUD dismissHUD];
}

#pragma mark- 推送

/**
 *  推送错误
 *
 *  @param code 错误代码
 *  @param completionHandler 完成处理程序
 */
+ (void)pushErrorWithCode:(NSInteger)code completionHandler:(NWCompletionHandler)completionHandler{
    NSString *errorMessage=[self netWorkingManager].errorCodeDictionary[[NSString stringWithFormat:@"%ld",code]];
    NSError*error=[TXNWPushMessage pushNetWorkRequestErrorWithErrorCode:code value:errorMessage];
    if (completionHandler) completionHandler(error,nil);
}

/**
 *  推送成功
 *
 *  @param completionHandler 完成处理程序
 */
+ (void)pushSuccessWithObj:(id)obj completionHandler:(NWCompletionHandler)completionHandler{
    if (completionHandler) completionHandler(nil,obj);
}

#pragma mark- 网络请求

/**
 *  post
 *  @param strURL 请求的URL
 *  @param parameters 请求的参数
 *  @param showHUD 是否显示HUD
 */
+ (void)post:(NSString*)strURL parameters:(NSDictionary*)parameters showHUD:(BOOL)showHUD completionHandler:(NWCompletionHandler)completionHandler{
    //是否显示HUD
    if (showHUD) [TXNetWorking showHUDWithShowHUDType:NWShowHUDTypeDefault info:nil];
    TXNETLog(@"post请求==>url:%@ parameters:%@",strURL,parameters);
    //开始请求
    [[self netWorkingManager].aFHTTPManager POST:strURL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        TXNetModel *netModel=[TXNetModel modelWithDictionary:responseObject];
        if (netModel.code==[self netWorkingManager].code) {
            [self pushSuccessWithObj:netModel completionHandler:completionHandler];
        }else{
            [self pushErrorWithCode:netModel.code completionHandler:completionHandler];
        }
        if (showHUD) [TXNetWorking dismissHUD];
        TXNETLog(@"post请求==>url:%@ responseObject:%@",strURL,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (completionHandler) completionHandler(error,nil);
        if (showHUD) [TXNetWorking dismissHUD];
        TXNETLog(@"post请求==>url:%@ error:%@",strURL,error);
    }];
}

/**
 *  get
 *  @param strURL 请求的URL
 *  @param parameters 请求的参数
 *  @param showHUD 是否显示HUD
 */
+ (void)get:(NSString*)strURL parameters:(NSDictionary*)parameters showHUD:(BOOL)showHUD completionHandler:(NWCompletionHandler)completionHandler{
    //是否显示HUD
    if (showHUD) [TXNetWorking showHUDWithShowHUDType:NWShowHUDTypeDefault info:nil];
    TXNETLog(@"get请求==>url:%@ parameters:%@",strURL,parameters);
    //开始请求
    [[self netWorkingManager].aFHTTPManager GET:strURL parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        TXNetModel *netModel=[TXNetModel modelWithDictionary:responseObject];
        if (netModel.code==[self netWorkingManager].code) {
            [self pushSuccessWithObj:netModel completionHandler:completionHandler];
        }else{
            [self pushErrorWithCode:netModel.code completionHandler:completionHandler];
        }
        if (showHUD) [TXNetWorking dismissHUD];
        TXNETLog(@"get请求==>url:%@ responseObject:%@",strURL,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (completionHandler) completionHandler(error,nil);
        if (showHUD) [TXNetWorking dismissHUD];
        TXNETLog(@"get请求==>url:%@ error:%@",strURL,error);
    }];
}

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
  completionHandler:(NWCompletionHandler)completionHandler{
    [self uploadImage:strURL images:@[image] fileName:fileName name:name mimeType:mimeType parameters:parameters showHUD:showHUD completionHandler:completionHandler];
}

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
  completionHandler:(NWCompletionHandler)completionHandler{
    [self uploadImage:strURL images:@[images] fileName:fileName names:@[name] mimeType:mimeType parameters:parameters showHUD:showHUD completionHandler:completionHandler];
}

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
  completionHandler:(NWCompletionHandler)completionHandler{
    //是否显示HUD
    if (showHUD) [TXNetWorking showHUDWithShowHUDType:NWShowHUDTypeDefault info:nil];
    /*图片类型*/
    if (!mimeType || ![mimeType isKindOfClass:[NSString class]] || mimeType.length==0) mimeType=@"image/jpeg";
    /*图片名称*/
    if (!fileName || ![fileName isKindOfClass:[NSString class]] || fileName.length<=0) fileName=[NSString stringWithFormat:@"%@.jpg", [self currentTimeWithDateFormat:nil]];
    TXNETLog(@"上传图片==>url:%@ parameters:%@ fileURLs:%@ fileName:%@  names:%@ mimeType:%@",strURL,parameters,images,fileName,names,mimeType);
    /*开始上传*/
    [[self netWorkingManager].aFHTTPManager POST:strURL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (images && [images isKindOfClass:[NSArray class]] && names && [names isKindOfClass:[NSArray class]]  && images.count==names.count) {
            for (int index=0; index<images.count; index++) {
                NSArray *aImages=images[index];
                NSString *aName=names[index];
                for (UIImage *image in aImages) {
                    NSData *imageData=UIImageJPEGRepresentation(image, 1);
                    /*上传图片，以文件流的格式*/
                    [formData appendPartWithFileData:imageData name:aName fileName:fileName mimeType:mimeType];
                }
            }
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        TXNetModel *netModel=[TXNetModel modelWithDictionary:responseObject];
        if (netModel.code==[self netWorkingManager].code) {
            [self pushSuccessWithObj:netModel completionHandler:completionHandler];
        }else{
            [self pushErrorWithCode:netModel.code completionHandler:completionHandler];
        }
        if (showHUD) [TXNetWorking dismissHUD];
        TXNETLog(@"上传图片==>url:%@ responseObject:%@",strURL,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (completionHandler) completionHandler(error,nil);
        if (showHUD) [TXNetWorking dismissHUD];
        TXNETLog(@"上传图片==>url:%@ error:%@",strURL,error);
    }];
}

/**
 *  上传文件(单文件)
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
 completionHandler:(NWCompletionHandler)completionHandler{
    [self uploadFile:strURL fileURLs:@[fileURL] fileName:fileName name:name mimeType:mimeType parameters:parameters showHUD:showHUD completionHandler:completionHandler];
}

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
 completionHandler:(NWCompletionHandler)completionHandler{
    [self uploadFile:strURL fileURLs:@[fileURLs] fileName:fileName names:@[name] mimeType:mimeType parameters:parameters showHUD:showHUD completionHandler:completionHandler];
}

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
 completionHandler:(NWCompletionHandler)completionHandler{
    //是否显示HUD
    if (showHUD) [TXNetWorking showHUDWithShowHUDType:NWShowHUDTypeDefault info:nil];
    //文件类型
    if (!mimeType || ![mimeType isKindOfClass:[NSString class]] || mimeType.length==0) mimeType=@"application/octet-stream";
    TXNETLog(@"上传文件==>url:%@ parameters:%@ fileURLs:%@ fileName:%@  names:%@ mimeType:%@",strURL,parameters,fileURLs,fileName,names,mimeType);
    [[self netWorkingManager].aFHTTPManager POST:strURL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (fileURLs && [fileURLs isKindOfClass:[NSArray class]] && names && [names isKindOfClass:[NSArray class]] &&  fileURLs.count==names.count) {
            for (int index=0; index<fileURLs.count; index++) {
                NSArray *afileURLs=fileURLs[index];
                NSString *aName=names[index];
                for (NSURL *fileURL in afileURLs) {
                    /*上传图片，以文件流的格式*/
                    [formData appendPartWithFileURL:fileURL name:aName fileName:fileName mimeType:mimeType error:nil];
                }
            }
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        TXNetModel *netModel=[TXNetModel modelWithDictionary:responseObject];
        if (netModel.code==[self netWorkingManager].code) {
            [self pushSuccessWithObj:netModel completionHandler:completionHandler];
        }else{
            [self pushErrorWithCode:netModel.code completionHandler:completionHandler];
        }
        if (showHUD) [TXNetWorking dismissHUD];
        TXNETLog(@"上传文件==>url:%@ responseObject:%@",strURL,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (completionHandler) completionHandler(error,nil);
        if (showHUD) [TXNetWorking dismissHUD];
        TXNETLog(@"上传文件==>url:%@ error:%@",strURL,error);
    }];
}

@end
