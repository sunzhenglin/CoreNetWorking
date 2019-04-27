//
//  TXURBundle.h
//  AFNetworking
//
//  Created by xtz_pioneer on 2019/4/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** 获取自身所在Bundle */
@interface TXURBundle : NSObject

/**
 *  bundle
 *
 *  @param resource 资源名
 */
+ (NSBundle*)bundleWithClass:(Class)class resource:(NSString*)resource;
@end

NS_ASSUME_NONNULL_END
