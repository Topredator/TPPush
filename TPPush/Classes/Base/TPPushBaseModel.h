//
//  TPPushBaseModel.h
//  TPPush
//
//  Created by Topredator on 2019/2/26.
//

#import <Foundation/Foundation.h>

@class TPPushBaseModel;

typedef TPPushBaseModel *(^TPPushBaseChain)(id);
@interface TPPushBaseModel : NSObject<NSCopying>
@property (nonatomic, copy) NSString *modelId;
@property (nonatomic, copy) NSString *modelKey;
@property (nonatomic, copy) NSString *modelSecret;
//  初始化注册
- (void)initRegister;
//  注册设备token
- (void)registerDeviceToken:(NSString *)token;
// 处理远程推送通知
- (void)handleRemoteNotification:(NSDictionary *)notify;
//  设置角标
- (void)setBadge:(NSInteger)badge;

- (TPPushBaseChain)pushId;
- (TPPushBaseChain)pushKey;
- (TPPushBaseChain)pushSecret;
+ (instancetype)modelWithId:(NSString *)modelId modelKey:(NSString *)modelKey modelSecret:(NSString *)modelSecret;
@end
