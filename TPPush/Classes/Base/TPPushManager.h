//
//  TPPushManager.h
//  TPPush
//
//  Created by Topredator on 2019/2/26.
//

#import <Foundation/Foundation.h>
#import "TPPushInterface.h"
#import "TPPushNotification.h"

@interface TPPushManager : NSObject
@property (nonatomic, weak) id <TPPushDataSource> datasource;
@property (nonatomic, strong) __kindof TPPushBaseModel *baseModel;
/// 第三方通行证
@property (nonatomic, strong) id thirdPartyPass;
/// 远程通知存储
@property (nonatomic, copy) NSDictionary *remoteNotify;
/// 本地通知存储
@property (nonatomic, copy) NSDictionary *localNotify;

+ (instancetype)shareInstance;
//  注册设备token
- (void)registerDeviceToken:(NSData *)token;
// 取消所有本地通知
- (void)cancleAllLocalNotifications;
// 设置角标
- (void)setModelBadge:(NSInteger)modelBadge;

// 处理长连接
- (void)handleConnectWithMsgString:(NSString *)msgString;
// 注册通知
- (void)registerNotification;
// 关闭推送服务
- (void)closeRemotePushService;
@end

