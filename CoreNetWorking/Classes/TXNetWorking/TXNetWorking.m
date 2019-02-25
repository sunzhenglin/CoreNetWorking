//
//  TXNetWorking.m
//  Furling
//
//  Created by xtz_pioneer on 2018/7/2.
//  Copyright © 2018年 zhangxiong. All rights reserved.
//

#import "TXNetWorking.h"
/*DEBUG打印日志*/

#if DEBUG
#define TXLog(s, ... ) NSLog( @"<FileName:%@ InThe:%dRow> Log:%@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define TXLog(s, ... )
#endif
@implementation TXNetWorking

/** 网络管理器 */
+ (TXNetWorking*)netWorkingManager{
    static TXNetWorking * netWorkingManagerInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        netWorkingManagerInstance = [[super allocWithZone:nil] init];
    });
    return netWorkingManagerInstance;
}

+ (id)allocWithZone:(NSZone *)zone{
    return [TXNetWorking netWorkingManager];
}

- (id)copyWithZone:(NSZone *)zone{
    return [TXNetWorking netWorkingManager];
}

- (id)mutableCopyWithZone:(NSZone *)zone{
    return [TXNetWorking netWorkingManager];
}

- (instancetype)init{
    if (self = [super init]) {
        /*网络请求识别码*/
        self.code=0;
    }
    return self;
}

/** AFHTTPSessionManager */
+ (AFHTTPSessionManager*)aFManager{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];
    /** 设置超时时间 */
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval=25.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    return manager;
}

/** 开启网络检测 */
+ (void)openNetworkMonitoring{
    AFNetworkReachabilityManager *manager=[AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                [TXNetWorking netWorkingManager].networkStatus=NWNetworkStatusUnknown;
                [self pushNetworkStatusWithNetworkStatus:NWNetworkStatusUnknown];
                break;
            case AFNetworkReachabilityStatusNotReachable:
                [TXNetWorking netWorkingManager].networkStatus=NWNetworkStatusReachable;
                [self pushNetworkStatusWithNetworkStatus:NWNetworkStatusReachable];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                [TXNetWorking netWorkingManager].networkStatus=NWNetworkStatusReachableViaWWAN;
                [self pushNetworkStatusWithNetworkStatus:NWNetworkStatusReachableViaWWAN];
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [TXNetWorking netWorkingManager].networkStatus=NWNetworkStatusReachableViaWiFi;
                [self pushNetworkStatusWithNetworkStatus:NWNetworkStatusReachableViaWiFi];
                break;
            default:
                break;
        }
    }];
    [manager startMonitoring];
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
 *  设置token
 *  @param token token
 *  return AFHTTPSessionManager
 */
+ (AFHTTPSessionManager*)setToken:(NSString*)token{
    AFHTTPSessionManager *manager=[self aFManager];
    if (!token || [token isEqualToString:@""]) {
        return manager;
    }else{
        NSString *remotelyKey=@"Token";//服务器定义的字段名
        [manager.requestSerializer setValue:token forHTTPHeaderField:remotelyKey];
        TXLog(@"setToken->token:%@",token);
        return manager;
    }
}

/**
 *  过滤Token
 *  @param parameters 参数
 *  return 请求参数
 */
+ (NSDictionary*)filterWithParameters:(NSDictionary*)parameters{
    NSMutableDictionary  *dict=[[NSMutableDictionary alloc]initWithDictionary:parameters];
    NSString *localKey=@"token";//本地定义的字段名
    if ([dict.allKeys containsObject:localKey]) {
        [dict removeObjectForKey:localKey];
        return dict;
    }else{
        return parameters;
    }
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
    //设置Token
    AFHTTPSessionManager * manager=[self setToken:parameters[@"token"]];
    /*过滤Token*/
    parameters=[self filterWithParameters:parameters];
    TXLog(@"post->url:%@",strURL);
    TXLog(@"post->parameters:%@",parameters);
    //开始请求
    [manager POST:strURL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        TXLog(@"post->responseObject:%@",responseObject);
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
        TXLog(@"post->error:%@",error);
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
    //设置Token
    AFHTTPSessionManager * manager=[self setToken:parameters[@"token"]];
    /*过滤Token*/
    parameters=[self filterWithParameters:parameters];
    TXLog(@"get->url:%@",strURL);
    TXLog(@"get->parameters:%@",parameters);
    //开始请求
    [manager GET:strURL parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        TXLog(@"get->responseObject:%@",responseObject);
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
        TXLog(@"get->error:%@",error);
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
    [self uploadImage:strURL images:@[image] filename:filename name:name mimeType:mimeType parameters:parameters showHUD:showHUD completionHandler:^(NSError *error, id obj) {
        if (completionHandler) completionHandler(error,obj);
    }];
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
    //是否显示HUD
    if (showHUD) [TXNetWorking showHUDWithShowHUDType:NWShowHUDTypeDefault info:nil];
    //设置Token
    AFHTTPSessionManager * manager=[self setToken:parameters[@"token"]];
    /*过滤Token*/
    parameters=[self filterWithParameters:parameters];
    TXLog(@"upload->url:%@",strURL);
    TXLog(@"upload->parameters:%@",parameters);
    /*图片类型*/
    if (!mimeType || mimeType.length==0) mimeType=@"image/jpeg";
    /*开始上传*/
    NSURLSessionTask *session=[manager POST:strURL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (UIImage *image in images) {
            NSData *imageData = UIImageJPEGRepresentation(image, 1);
            NSString *imageFileName = filename;
            if (filename == nil || ![filename isKindOfClass:[NSString class]] || filename.length == 0) {
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.dateFormat = @"yyyyMMddHHmmss";
                NSString *str = [formatter stringFromDate:[NSDate date]];
                imageFileName = [NSString stringWithFormat:@"%@.jpg", str];
            }
            //上传图片，以文件流的格式
            [formData appendPartWithFileData:imageData name:name fileName:imageFileName mimeType:mimeType];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        TXLog(@"upload->responseObject:%@",responseObject);
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
        TXLog(@"upload->error:%@",error);
    }];
    [session resume];
}

@end
