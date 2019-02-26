//
//  TPPushGTModel.h
//  TPPush
//
//  Created by Topredator on 2019/2/26.
//

#import "TPPushBaseModel.h"

@interface TPPushGTModel : TPPushBaseModel
@end
NS_INLINE TPPushGTModel *TPGTPushModel(NSString *modelId, NSString *modelKey, NSString *modelSecret) {
    return [TPPushGTModel modelWithId:modelId modelKey:modelKey modelSecret:modelSecret];
};
