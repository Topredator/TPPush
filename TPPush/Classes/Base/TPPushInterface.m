//
//  TPPushInterface.m
//  TPPush
//
//  Created by Topredator on 2019/2/26.
//

#import "TPPushInterface.h"
#import "TPPushManager.h"


NSNotificationName const TPPushReceiveRemoteNotification = @"topredator.push.notification.remote";  ///    接收到远程推送通知
NSNotificationName const TPPushReceiveLocalNotification = @"topredator.push.notification.local";  /// 接收到本地通知

@implementation TPPushInterface
/// 注册通知
+ (void)registerNotificationWithModel:(TPPushBaseModel *)model {
    NSParameterAssert(model);
    [TPPushManager.shareInstance setBaseModel:model];
}
/// 设置代理
+ (void)setDatasource:(id<TPPushDataSource>)datasource {
    [TPPushManager.shareInstance setDatasource:datasource];
}
//  向服务器注册设备token
+ (void)registerDeviceToken:(NSData *)deviceToken {
    [TPPushManager.shareInstance registerDeviceToken:deviceToken];
}
/// 取消所有本地通知
+ (void)cancleAllLocalNotifications {
    [TPPushManager.shareInstance cancleAllLocalNotifications];
}
/// 获取第三方通行证  如：GTSDK的clientId
+ (id)fetchThirdPartyPass {
    return TPPushManager.shareInstance.thirdPartyPass;
}
/// 获取远程推送消息
+ (NSDictionary *)fetchRemoteNotification {
    return [TPPushManager.shareInstance remoteNotify];
}
/// 清空远程消息存储
+ (void)emptyRemote {
    TPPushManager.shareInstance.remoteNotify = nil;
}
/// 获取本地通知消息
+ (NSDictionary *)fetchLocalNotification {
    return [TPPushManager.shareInstance localNotify];
}
/// 清空本地消息存储
+ (void)emptyLocal {
    TPPushManager.shareInstance.localNotify = nil;
}
/// 设置角标
+ (void)setupBadge:(NSInteger)badge {
    [TPPushManager.shareInstance setModelBadge:badge];
}
@end
