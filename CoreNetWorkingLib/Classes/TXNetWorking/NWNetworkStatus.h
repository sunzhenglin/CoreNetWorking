//
//  NWNetworkStatus.h
//  CoreNetWorking-CoreNetWorking
//
//  Created by Zlin Sun on 2019/2/25.
//

#ifndef NWNetworkStatus_h
#define NWNetworkStatus_h
/** 网络状态 */
typedef NS_ENUM(NSInteger,NWNetworkStatus){
    /** 未识别的网络*/
    NWNetworkStatusUnknown          =-1,
    /** 不可达的网络(未连接) */
    NWNetworkStatusReachable        =0,
    /** 2G,3G,4G...的网络 */
    NWNetworkStatusReachableViaWWAN =1,
    /** Wi-Fi的网络 */
    NWNetworkStatusReachableViaWiFi =2,
};

#endif /* NWNetworkStatus_h */
