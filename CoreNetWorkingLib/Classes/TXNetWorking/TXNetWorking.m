//
//  TXNetWorking.m
//  Furling
//
//  Created by xtz_pioneer on 2018/7/2.
//  Copyright © 2018年 zhangxiong. All rights reserved.
//

#import "TXNetWorking.h"

/**
 *  DEBUG 打印日志
 */
#if DEBUG
#define TXNETLog(s, ... ) NSLog( @"<FileName:%@ InThe:%d Line> Log:%@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define TXNETLog(s, ... )
#endif

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
        self.aFHTTPManager=[AFHTTPSessionManager manager];;
        /*请求超时*/
        self.requestTimedOut=25.f;
        /*内容类型*/
        self.contentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];
        /*网络请求识别码*/
        self.code=0;
    }
    return self;
}

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

/** 开启网络检测 */
+ (void)openNetworkMonitoring{
    [self netWorkingManager].aFReachabilityManager=[AFNetworkReachabilityManager sharedManager];
    [[self netWorkingManager].aFReachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status){
        switch (status) {
                case AFNetworkReachabilityStatusUnknown:{
                    [TXNetWorking netWorkingManager].networkStatus=NWNetworkStatusUnknown;
                    [self pushNetworkStatusWithNetworkStatus:NWNetworkStatusUnknown];
                }
                break;
                case AFNetworkReachabilityStatusNotReachable:{
                    [TXNetWorking netWorkingManager].networkStatus=NWNetworkStatusReachable;
                    [self pushNetworkStatusWithNetworkStatus:NWNetworkStatusReachable];
                }
                break;
                case AFNetworkReachabilityStatusReachableViaWWAN:{
                    [TXNetWorking netWorkingManager].networkStatus=NWNetworkStatusReachableViaWWAN;
                    [self pushNetworkStatusWithNetworkStatus:NWNetworkStatusReachableViaWWAN];
                }
                break;
                case AFNetworkReachabilityStatusReachableViaWiFi:{
                    [TXNetWorking netWorkingManager].networkStatus=NWNetworkStatusReachableViaWiFi;
                    [self pushNetworkStatusWithNetworkStatus:NWNetworkStatusReachableViaWiFi];
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

/** 推送网络状态 */
+ (void)pushNetworkStatusWithNetworkStatus:(NWNetworkStatus)networkStatus{
    NSDictionary *parameters=@{networkStatusKey:[NSNumber numberWithInteger:networkStatus]};
    [[NSNotificationCenter defaultCenter] postNotificationName:TXNetworkMonitoringNotification object:nil userInfo:parameters];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:TXNetworkMonitoringNotification object:nil];
}

/**
 *  显示HUD
 *  @param showHUDType HUD显示类型
 *  @param info 信息
 */
+ (void)showHUDWithShowHUDType:(NWShowHUDType)showHUDType info:(NSString*)info{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setMinimumDismissTimeInterval:1.0];
    if (showHUDType==NWShowHUDTypeDefault) {
        [SVProgressHUD show];
    }else if (showHUDType==NWShowHUDTypeInfo){
        [SVProgressHUD showWithStatus:info];
    }else if (showHUDType==NWShowHUDTypeCaveatInfo){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.128 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD showInfoWithStatus:info];
        });
    }else if (showHUDType==NWShowHUDTypeSuccessInfo){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.128 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD showSuccessWithStatus:info];
        });
    }else if (showHUDType==NWShowHUDTypeFailureInfo){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.128 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD showErrorWithStatus:info];
        });
    }else{
        [SVProgressHUD show];
    }
}

/** 消除HUD */
+ (void)dismissHUD{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.128 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

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
        TXNETLog(@"post请求==>url:%@ responseObject:%@",strURL,responseObject);
        TXNetModel * netModel=[TXNetModel modelWithDictionary:responseObject];
        if (netModel.code==[self netWorkingManager].code) {
            if (completionHandler) completionHandler(nil,netModel);
        }else{
            NSString *errorMessage=[TXNetErrorCode errorMessageWithErrorCodeType:netModel.code];
            if (completionHandler) completionHandler([NSError errorWithDomain:@"TXNetWorkingError" code:netModel.code userInfo:@{@"msg":errorMessage}],nil);
            [TXNetErrorCode pushNetWorkRequestErrorWithErrorCodeType:netModel.code];
        }
        if (showHUD) [TXNetWorking dismissHUD];
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
        TXNETLog(@"get请求==>url:%@ responseObject:%@",strURL,responseObject);
        TXNetModel * netModel=[TXNetModel modelWithDictionary:responseObject];
        if (netModel.code==[self netWorkingManager].code) {
            if (completionHandler) completionHandler(nil,netModel);
        }else{
            NSString *errorMessage=[TXNetErrorCode errorMessageWithErrorCodeType:netModel.code];
            if (completionHandler) completionHandler([NSError errorWithDomain:@"TXNetWorkingError" code:netModel.code userInfo:@{@"msg":errorMessage}],nil);
            [TXNetErrorCode pushNetWorkRequestErrorWithErrorCodeType:netModel.code];
        }
        if (showHUD) [TXNetWorking dismissHUD];
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
      completionHandler:(NWCompletionHandler)completionHandler{
    [self uploadImage:strURL images:@[image] filename:filename name:name mimeType:mimeType parameters:parameters showHUD:showHUD completionHandler:completionHandler];
}

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
  completionHandler:(NWCompletionHandler)completionHandler{
    [self uploadImage:strURL images:@[images] filename:filename names:@[name] mimeType:mimeType parameters:parameters showHUD:showHUD completionHandler:completionHandler];
}

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
  completionHandler:(NWCompletionHandler)completionHandler{
    //是否显示HUD
    if (showHUD) [TXNetWorking showHUDWithShowHUDType:NWShowHUDTypeDefault info:nil];
    TXNETLog(@"上传图片==>url: parameters:%@",strURL);
    /*图片类型*/
    if (!mimeType || mimeType.length==0) mimeType=@"image/jpeg";
    /*开始上传*/
    NSURLSessionTask *session=[[self netWorkingManager].aFHTTPManager POST:strURL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (images && names && images.count==names.count) {
            for (int index=0; index<images.count; index++) {
                NSArray *aImages=images[index];
                NSString *aName=names[index];
                for (UIImage *image in aImages) {
                    NSData *imageData = UIImageJPEGRepresentation(image, 1);
                    NSString *imageFileName = filename;
                    if (filename == nil || ![filename isKindOfClass:[NSString class]] || filename.length == 0) {
                        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                        formatter.dateFormat = @"yyyyMMddHHmmss";
                        NSString *str = [formatter stringFromDate:[NSDate date]];
                        imageFileName = [NSString stringWithFormat:@"%@.jpg", str];
                    }
                    //上传图片，以文件流的格式
                    [formData appendPartWithFileData:imageData name:aName fileName:imageFileName mimeType:mimeType];
                }
            }
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        TXNETLog(@"上传图片==>url:%@ responseObject:%@",strURL,responseObject);
        TXNetModel * netModel=[TXNetModel modelWithDictionary:responseObject];
        if (netModel.code==[self netWorkingManager].code) {
            if (completionHandler) completionHandler(nil,netModel);
        }else{
            NSString *errorMessage=[TXNetErrorCode errorMessageWithErrorCodeType:netModel.code];
            if (completionHandler) completionHandler([NSError errorWithDomain:@"TXNetWorkingError" code:netModel.code userInfo:@{@"msg":errorMessage}],nil);
            [TXNetErrorCode pushNetWorkRequestErrorWithErrorCodeType:netModel.code];
        }
        if (showHUD) [TXNetWorking dismissHUD];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (completionHandler) completionHandler(error,nil);
        if (showHUD) [TXNetWorking dismissHUD];
        TXNETLog(@"上传图片==>url:%@ error:%@",strURL,error);
    }];
    [session resume];
}

@end
