//
//  TXURBundle.m
//  AFNetworking
//
//  Created by xtz_pioneer on 2019/4/25.
//

#import "TXURBundle.h"

@implementation TXURBundle

/**
 *  bundle
 *
 *  @param resource 资源名
 */
+ (NSBundle*)bundleWithClass:(Class)class resource:(NSString*)resource{
    NSBundle *mainBundle =[NSBundle bundleForClass:class];
    NSString *resourceBundlePath=[mainBundle pathForResource:resource ofType:@"bundle"];
    NSBundle *bundle=[NSBundle bundleWithPath:resourceBundlePath];
    return bundle;
}

@end
