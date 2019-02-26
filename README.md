# CoreNetWorking
* 轻量级的网络请在使用GET、POST、以及图片上传时是你的操作更简单快捷、在进行网络请求时还可以智能显示加载进度HUD
### CoreNetWorking优点
* 使用以及操作简单快捷
* 内部集成HUD以及智能显示HUD
* 更加方便的网络检测功能
* 内部监听错误以更加简单的方式让你统一处理错误使你的开发更加高效

### CoreNetWorking缺点
* 逻辑复杂、多变的情况下需要开发者二次封装才能完成各项任务

### cocoapods集成
* pod 'CoreNetWorkingLib', '~> 0.2.0'
### 代码片段

```objc
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
 网络管理器
 
 主要功能:GET请求、POST请求、上传单张图片、上传多张图片、网络检测、HUD
 
 辅助功能1:“TXNetErrorCode.h”以及“TXNetErrorDelegate.h”文件主要集中处理错误代码
 
 辅助功能2:“TXNetworkStatusDelegate.”文件主要集中处理网络状态
 
 */
@interface TXNetWorking : NSObject

/** 网络状态(注意:只用在开启网络检测时可用) */
@property (nonatomic,assign,readonly)NWNetworkStatus networkStatus;

/** 网络请求识别码(注意:适用于空灵智能) */
@property (nonatomic,assign)NSInteger code;
/** 网络管理器 */
+ (TXNetWorking*)netWorkingManager;

/** AFHTTPSessionManager */
+ (AFHTTPSessionManager*)aFManager;

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
```
### 使用方法
* 例如:

```objc
/**
 * 登录
 * @param account 账户名
 * @param verificationCode 验证码
 * @param password 密码 注意:家长端密码传入“1”
 */
- (void)logInWithAccount:(NSString*)account verificationCode:(NSString*)verificationCode password:(NSString*)password{
    _operationType=LROperationTypeLogIn;
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    [parameters setValue:@"1" forKey:@"type"];//家长端
    if (!account || [account isEqualToString:@""]) {
        NSString * msg=@"账号不能为空";
        if (self.completionHandler) self.completionHandler([NSError errorWithDomain:@"KLLogInRegisterViewModelError" code:-1002 userInfo:@{@"msg":msg}],nil);
    }else if (!verificationCode || [verificationCode isEqualToString:@""]){
        NSString * msg=@"验证码不能为空";
        if (self.completionHandler) self.completionHandler([NSError errorWithDomain:@"KLLogInRegisterViewModelError" code:-1003 userInfo:@{@"msg":msg}],nil);
    }else if (!password || [password isEqualToString:@""]){
        NSString * msg=@"密码不能为空";
        if (self.completionHandler) self.completionHandler([NSError errorWithDomain:@"KLLogInRegisterViewModelError" code:-1004 userInfo:@{@"msg":msg}],nil);
    }else{
        [parameters setValue:account forKey:@"account"];
        [parameters setValue:verificationCode forKey:@"vcode"];
        [parameters setValue:password forKey:@"pwd"];
        [TXNetWorking post:HTTP_API(@"user/login.do") parameters:parameters showHUD:NO completionHandler:^(NSError *error, TXNetModel *netModel) {
            if (!error) {
                if (self.completionHandler) self.completionHandler(error,netModel);
            }else{
                NSString * msg=@"登录失败";
                if (self.completionHandler) self.completionHandler([NSError errorWithDomain:@"KLLogInRegisterViewModelError" code:-1005 userInfo:@{@"msg":msg}],netModel);
            }
        }];
    }
}
```
* 使用示例:
```objc
- (void)viewDidLoad {
    [super viewDidLoad];
    /** 登录接口演示 */
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    [parameters setValue:@"15934862072" forKey:@"account"];
    [parameters setValue:@"666666" forKey:@"vcode"];
    [parameters setValue:@"1" forKey:@"pwd"];
    // 注意:“HTTP_API(@"user/login.do")”这个是登录接口
    // 注意:“parameters”这个是请求参数 
    // 注意:“YES”这个是是否显示HUD,现在这里是显示 
    [TXNetWorking post:HTTP_API(@"user/login.do") parameters:parameters showHUD:YES completionHandler:^(NSError *error, TXNetModel *netModel) {
        if (!error) {
            //登录成功
        }else{
           //登录失败
        }
    }];
    // Do any additional setup after loading the view, typically from a nib.
}
```

