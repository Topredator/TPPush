//
//  TPGradientView.h
//  TPUIKit
//
//  Created by Topredator on 2019/2/21.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

/// 渐变色方向变化
typedef NS_ENUM(NSInteger, TPGradientDirection) {
    TPGradientDirectionTopToBottom, // 从上到下
    TPGradientDirectionBottomToTop, // 从下到上
    TPGradientDirectionLeftToRight, // 从左到右
    TPGradientDirectionRightToLeft // 从右到左
};

@interface TPGradientLayer : CAGradientLayer
- (instancetype)initWithBeginColor:(UIColor *)beginColor
                          endColor:(UIColor *)endColor
                         direction:(TPGradientDirection)direction;
@end


/**
 渐变色视图
 */
@interface TPGradientView : UIView
@property (nonatomic, strong) TPGradientLayer *gradientLayer;
- (instancetype)initWithBeginColor:(UIColor *)beginColor
                          endColor:(UIColor *)endColor
                         direction:(TPGradientDirection)direction;
@end


