//
//  TPPushGTModel.m
//  TPPush
//
//  Created by Topredator on 2019/2/26.
//

#import "TPPushGTModel.h"
#import <GTSDK/GeTuiSdk.h>
#import "TPPushManager.h"

@interface TPPushGTModel ()<GeTuiSdkDelegate>
@end

@implementation TPPushGTModel
+ (instancetype)modelWithId:(NSString *)modelId modelKey:(NSString *)modelKey modelSecret:(NSString *)modelSecret {
    TPPushGTModel *model = [TPPushGTModel new];
    model.modelId = modelId;
    model.modelKey = modelKey;
    model.modelSecret = modelSecret;
    return model;
}
- (void)initRegister {
    NSAssert(self.modelId, @"appId不能为空");
    NSAssert(self.modelKey, @"appKey不能为空");
    NSAssert(self.modelSecret, @"appSecret不能为空");
    [GeTuiSdk startSdkWithAppId:self.modelId appKey:self.modelKey appSecret:self.modelSecret delegate:self];
}
- (void)registerDeviceToken:(NSString *)token {
    [GeTuiSdk registerDeviceToken:token];
}
- (void)handleRemoteNotification:(NSDictionary *)notify {
    [GeTuiSdk handleRemoteNotification:notify];
}
- (void)setBadge:(NSInteger)badge {
    [GeTuiSdk setBadge:badge];
}
- (void)customChannelId:(NSString *)channelId {
    [GeTuiSdk setChannelId:channelId];
}
#pragma mark ==================  GeTuiSdkDelegate   ==================
- (void)GeTuiSdkDidRegisterClient:(NSString *)clientId {
    //  记录个推的clientId 用于服务端推送
    if (clientId.length) {
        [[TPPushManager shareInstance] setThirdPartyPass:clientId];
    }
}
/** SDK收到透传消息回调 */
- (void)GeTuiSdkDidReceivePayloadData:(NSData *)payloadData andTaskId:(NSString *)taskId andMsgId:(NSString *)msgId andOffLine:(BOOL)offLine fromGtAppId:(NSString *)appId {
    // [ GTSdk ]：汇报个推自定义事件(反馈透传消息)
    [GeTuiSdk sendFeedbackMessage:90001 andTaskId:taskId andMsgId:msgId];
    
    
    // 数据转换
    NSString *payloadMsg = nil;
    if (payloadData) {
        payloadMsg = [[NSString alloc] initWithBytes:payloadData.bytes length:payloadData.length encoding:NSUTF8StringEncoding];
    }
    if (!offLine) {
        [TPPushManager.shareInstance handleConnectWithMsgString:payloadMsg];
    }
//
//    // 控制台打印日志
//    NSString *msg = [NSString stringWithFormat:@"taskId=%@,messageId:%@,payloadMsg:%@%@", taskId, msgId, payloadMsg, offLine ? @"<离线消息>" : @""];
//    NSLog(@"\n>>[GTSdk ReceivePayload]:%@\n\n", msg);
}
@end
