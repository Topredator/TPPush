//
//  TPPushInterface.h
//  TPPush
//
//  Created by Topredator on 2019/2/26.
//

#import <Foundation/Foundation.h>
#import "TPPushBaseModel.h"
#import "TPPushNotification.h"

@protocol TPPushDataSource <NSObject>
@optional
// 处理远程推送通知
- (void)handleRemoteNotification:(NSDictionary *)notification;
// 处理本地通知
- (void)handleLocalNotification:(NSDictionary *)notification;
// 处理长连接消息
- (void)handleLongConnectionNotification:(NSString *)msgString;
@end

@interface TPPushInterface : NSObject
/// 注册通知
+ (void)registerNotificationWithModel:(__kindof TPPushBaseModel *)model;
/// 设置代理
+ (void)setDatasource:(id<TPPushDataSource>)datasource;
//  向服务器注册设备token
+ (void)registerDeviceToken:(NSData *)deviceToken;
/// 取消所有本地通知
+ (void)cancleAllLocalNotifications;
/// 获取第三方通行证  如：GTSDK的clientId
+ (id)fetchThirdPartyPass;
/// 获取远程推送消息
+ (NSDictionary *)fetchRemoteNotification;
/// 清空远程消息存储
+ (void)emptyRemote;
/// 获取本地通知消息
+ (NSDictionary *)fetchLocalNotification;
/// 清空本地消息存储
+ (void)emptyLocal;
/// 设置角标
+ (void)setupBadge:(NSInteger)badge;
@end


