//
//  TPPushGTModel.h
//  TPPush
//
//  Created by Topredator on 2019/2/26.
//

#import "TPPushBaseModel.h"

@interface TPPushGTModel : TPPushBaseModel
/// 自定义渠道
- (void)customChannelId:(NSString *)channelId;
@end
NS_INLINE TPPushGTModel *TPGTPushModel(NSString *modelId, NSString *modelKey, NSString *modelSecret) {
    return [TPPushGTModel modelWithId:modelId modelKey:modelKey modelSecret:modelSecret];
};
