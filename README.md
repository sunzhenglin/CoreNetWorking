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
* 创建模型时继承TXModel类

```objc
#import "TXModel.h"

@interface TXPeople : TXModel
@property (nonatomic,copy)NSString * name;
@property (nonatomic,copy)NSString * sex;
@property (nonatomic,strong)NSNumber * age;
@property (nonatomic,strong)NSString * occupation;
@end

```
* 使用示例:
```objc
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    NSDictionary * dict=@{@"name":@"小明",
                          @"sex":@"男",
                          @"age":@17,
                          };
    TXPeople * people1=[[TXPeople alloc]initWithDictionary:dict];
    NSLog(@"people1.name:%@",people1.name);
    NSLog(@"people1.sex:%@",people1.sex);
    NSLog(@"people1.age:%@",people1.age);
    NSLog(@"people1.occupation:%@",people1.occupation);
    NSLog(@"people1.valueForJsonString:%@",people1.valueForJsonString);
    NSLog(@"people1.valueForKey:%@",people1.valueForKey);
    NSLog(@"people1.valueForArray:%@",people1.valueForArray);
    
    
    
    NSString * str=@"{\"name\" : \"小花\",\"sex\" : \"女\",\"age\" : 16,\"occupation\" :\"学生\" }";
    TXPeople * people2=[[TXPeople alloc]initWithJsonString:str];
    NSLog(@"people2.name:%@",people2.name);
    NSLog(@"people2.sex:%@",people2.sex);
    NSLog(@"people2.age:%@",people2.age);
    NSLog(@"people2.occupation:%@",people2.occupation);
    NSLog(@"people2.valueForJsonString:%@",people2.valueForJsonString);
    NSLog(@"people2.valueForKey:%@",people2.valueForKey);
    NSLog(@"people2.valueForArray:%@",people2.valueForArray);
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}
```
* 打印示例:
```objc
2018-05-29 14:26:24.085763+0800 TXModelDemo[17840:309289] people1.name:小明
2018-05-29 14:26:24.085944+0800 TXModelDemo[17840:309289] people1.sex:男
2018-05-29 14:26:24.086073+0800 TXModelDemo[17840:309289] people1.age:17
2018-05-29 14:26:24.086186+0800 TXModelDemo[17840:309289] people1.occupation:(null)
2018-05-29 14:26:24.086522+0800 TXModelDemo[17840:309289] people1.valueForJsonString:{
  "age" : 17,
  "sex" : "男",
  "name" : "小明",
  "occupation" : null
}
2018-05-29 14:26:24.086827+0800 TXModelDemo[17840:309289] people1.valueForKey:{
    age = 17;
    name = "\U5c0f\U660e";
    occupation = "<null>";
    sex = "\U7537";
}
2018-05-29 14:26:24.087065+0800 TXModelDemo[17840:309289] people1.valueForArray:(
    17,
    "\U7537",
    "\U5c0f\U660e",
    "<null>"
)
2018-05-29 14:26:24.087350+0800 TXModelDemo[17840:309289] people2.name:小花
2018-05-29 14:26:24.087485+0800 TXModelDemo[17840:309289] people2.sex:女
2018-05-29 14:26:24.087600+0800 TXModelDemo[17840:309289] people2.age:16
2018-05-29 14:26:24.087731+0800 TXModelDemo[17840:309289] people2.occupation:学生
2018-05-29 14:26:24.087892+0800 TXModelDemo[17840:309289] people2.valueForJsonString:{
  "age" : 16,
  "sex" : "女",
  "name" : "小花",
  "occupation" : "学生"
}
2018-05-29 14:26:24.088079+0800 TXModelDemo[17840:309289] people2.valueForKey:{
    age = 16;
    name = "\U5c0f\U82b1";
    occupation = "\U5b66\U751f";
    sex = "\U5973";
}
2018-05-29 14:26:24.088262+0800 TXModelDemo[17840:309289] people2.valueForArray:(
    16,
    "\U5973",
    "\U5c0f\U82b1",
    "\U5b66\U751f"
)
```
