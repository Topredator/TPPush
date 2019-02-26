//
//  TPPushBaseModel.m
//  TPPush
//
//  Created by Topredator on 2019/2/26.
//

#import "TPPushBaseModel.h"

@implementation TPPushBaseModel
//  初始化注册
- (void)initRegister {}
//  注册设备token
- (void)registerDeviceToken:(NSString *)token {}
// 处理远程推送通知
- (void)handleRemoteNotification:(NSDictionary *)notify {}
//  设置角标
- (void)setBadge:(NSInteger)badge {}
+ (instancetype)modelWithId:(NSString *)modelId modelKey:(NSString *)modelKey modelSecret:(NSString *)modelSecret {
    TPPushBaseModel *model = [TPPushBaseModel new];
    model.modelId = modelId;
    model.modelKey = modelKey;
    model.modelSecret = modelSecret;
    return model;
}
- (TPPushBaseChain)pushId {
    return ^ (id modelId) {
        if ([modelId isKindOfClass:NSString.class]) {
            self.modelId = modelId;
        }
        return self;
    };
}
- (TPPushBaseChain)pushKey {
    return ^ (id modelKey) {
        if ([modelKey isKindOfClass:NSString.class]) {
            self.modelKey = modelKey;
        }
        return self;
    };
}
- (TPPushBaseChain)pushSecret {
    return ^ (id modelSecret) {
        if ([modelSecret isKindOfClass:NSString.class]) {
            self.modelSecret = modelSecret;
        }
        return self;
    };
}
#pragma mark ==================  NSCopying   ==================
- (id)copyWithZone:(NSZone *)zone {
    TPPushBaseModel *model = [[[self class] allocWithZone:zone] init];
    model.modelId = self.modelId;
    model.modelKey = self.modelKey;
    model.modelSecret = self.modelSecret;
    return model;
}
@end
