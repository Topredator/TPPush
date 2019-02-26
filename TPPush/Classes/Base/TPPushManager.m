//
//  TPPushManager.m
//  TPPush
//
//  Created by Topredator on 2019/2/26.
//

#import "TPPushManager.h"
#import "TPPushMethodSwizzling.h"
#import <objc/runtime.h>

#define kApplicationDelegate [UIApplication sharedApplication].delegate

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
#endif
@interface TPPushManager ()<UNUserNotificationCenterDelegate>
@end

static TPPushManager *pushManager = nil;
@implementation TPPushManager
+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        pushManager = [TPPushManager new];
    });
    return pushManager;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        [self registerNotification];
        [self injectionDeviceToken];
        [self injectionRemoteNotificationMethod];
        [self injectionLocalNotificationMethod];
    }
    return self;
}
// 注册通知
- (void)registerNotification {
    CGFloat systemVersion = UIDevice.currentDevice.systemVersion.floatValue;
    if (systemVersion >= 10.0) {
        if (@available(iOS 10.0, *)) {
            UNUserNotificationCenter *center = UNUserNotificationCenter.currentNotificationCenter;
            center.delegate = self;
            [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionCarPlay) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            }];
            [UIApplication.sharedApplication registerForRemoteNotifications];
        }
    } else if (systemVersion >= 8) {
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert |
                                                                       UIRemoteNotificationTypeSound |
                                                                       UIRemoteNotificationTypeBadge);
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
#pragma clang diagnostic pop
    }
}
// 注入设备Token
- (void)injectionDeviceToken {
    Class class = kApplicationDelegate.class;
    SEL localSEL = @selector(application:didRegisterForRemoteNotificationsWithDeviceToken:);
    SEL tpSEL = @selector(tpApplication:didRegisterForRemoteNotificationsWithDeviceToken:);
    Method localMethod = class_getInstanceMethod([self class], localSEL);
    // 如果appdelegate 实现了
    if ([kApplicationDelegate respondsToSelector:localSEL]) {
        TPSwizzlingClassAndInstanceMethod(class, self.class, localSEL, tpSEL);
    } else { // appdelegate 没有实现
        class_addMethod(class, localSEL, method_getImplementation(localMethod), method_getTypeEncoding(localMethod));
    }
}
// 注入远程通知方法
- (void)injectionRemoteNotificationMethod {
    Class class = kApplicationDelegate.class;
    SEL remoteSEL = @selector(application:didReceiveRemoteNotification:);
    SEL tpSEL = @selector(tpApplication:didReceiveRemoteNotification:);
    Method remoteMethod = class_getInstanceMethod([self class], remoteSEL);
    if ([kApplicationDelegate respondsToSelector:remoteSEL]) {
        TPSwizzlingClassAndInstanceMethod(class, self.class, remoteSEL, tpSEL);
    } else {
        class_addMethod(class, remoteSEL, method_getImplementation(remoteMethod), method_getTypeEncoding(remoteMethod));
    }
}
// 注入本地通知方法
- (void)injectionLocalNotificationMethod {
    Class class = kApplicationDelegate.class;
    SEL localSEL = @selector(application:didReceiveLocalNotification:);
    SEL tpSEL = @selector(tpApplication:didReceiveLocalNotification:);
    Method localMethod = class_getInstanceMethod([self class], localSEL);
    if ([kApplicationDelegate respondsToSelector:localSEL]) {
        TPSwizzlingClassAndInstanceMethod(class, self.class, localSEL, tpSEL);
    } else {
        class_addMethod(class, localSEL, method_getImplementation(localMethod), method_getTypeEncoding(localMethod));
    }
}
#pragma mark ==================  Method Swizzling   ==================
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [TPPushManager.shareInstance registerDeviceToken:deviceToken];
}
- (void)tpApplication:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [TPPushManager.shareInstance registerDeviceToken:deviceToken];
    [self tpApplication:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    [TPPushManager.shareInstance handleLocalNotification:notification.userInfo];
}
- (void)tpApplication:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    [TPPushManager.shareInstance handleLocalNotification:notification.userInfo];
    [self tpApplication:application didReceiveLocalNotification:notification];
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [TPPushManager.shareInstance handleRemoteNotification:userInfo];
}
- (void)tpApplication:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [TPPushManager.shareInstance handleRemoteNotification:userInfo];
    [self tpApplication:application didReceiveRemoteNotification:userInfo];
}
#pragma mark ==================  Public method  ==================
//  注册设备token
- (void)registerDeviceToken:(NSData *)token {
    NSString *tokenStr = [[token description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    tokenStr = [tokenStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    [self.baseModel registerDeviceToken:tokenStr];
}
// 取消所有本地通知
- (void)cancleAllLocalNotifications {
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}
// 设置角标
- (void)setModelBadge:(NSInteger)modelBadge {
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:modelBadge];
    [self.baseModel setBadge:modelBadge];
}
- (void)setBaseModel:(__kindof TPPushBaseModel *)baseModel {
    _baseModel = baseModel;
    [_baseModel initRegister];
}
#pragma mark ==================  Private method  ==================
- (void)handleRemoteNotification:(NSDictionary *)userInfo {
    if (!userInfo) return;
    self.remoteNotify = userInfo;
    // 通过代理传递
    if (self.datasource && [self.datasource respondsToSelector:@selector(handleRemoteNotification:)]) {
        [self.datasource handleRemoteNotification:userInfo];
    }
    // 通知传递
    [NSNotificationCenter.defaultCenter postNotificationName:TPPushReceiveRemoteNotification object:userInfo];
}
- (void)handleLocalNotification:(NSDictionary *)userInfo {
    if (!userInfo) return;
    self.localNotify = userInfo;
    if (self.datasource && [self.datasource respondsToSelector:@selector(handleLocalNotification:)]) {
        [self.datasource handleLocalNotification:userInfo];
    }
    [NSNotificationCenter.defaultCenter postNotificationName:TPPushReceiveLocalNotification object:userInfo];
}
#pragma mark - iOS 10中收到推送消息
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
//  iOS 10: App在前台获取到通知
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler  __IOS_AVAILABLE(10.0) __TVOS_AVAILABLE(10.0) __WATCHOS_AVAILABLE(3.0){
    
    // 根据APP需要，判断是否要提示用户Badge、Sound、Alert
    completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
}
//  iOS 10: 点击通知进入App时触发
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler __IOS_AVAILABLE(10.0) __WATCHOS_AVAILABLE(3.0) __TVOS_PROHIBITED {
    // 远程
    if ([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        NSDictionary *dic = response.notification.request.content.userInfo;
        // [ GTSdk ]：将收到的APNs信息传给个推统计
        self.remoteNotify = dic;
        [self.baseModel handleRemoteNotification:dic];
        [self handleRemoteNotification:dic];
    } else {
        NSDictionary *dic = response.notification.request.content.userInfo;
        self.localNotify = dic;
        [self handleLocalNotification:dic];
    }
    completionHandler();
}
#endif

@end
