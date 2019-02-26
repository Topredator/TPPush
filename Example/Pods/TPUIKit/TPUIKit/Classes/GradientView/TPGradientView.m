//
//  TPGradientView.m
//  TPUIKit
//
//  Created by Topredator on 2019/2/21.
//

#import "TPGradientView.h"


@implementation TPGradientLayer
- (instancetype)initWithBeginColor:(UIColor *)beginColor
                          endColor:(UIColor *)endColor
                         direction:(TPGradientDirection)direction {
    self = [super init];
    if (self) {
        self.colors = @[(__bridge id)beginColor.CGColor, (__bridge id)endColor.CGColor];
        switch (direction) {
                case TPGradientDirectionTopToBottom: {
                    self.startPoint = CGPointMake(0.5, 0);
                    self.endPoint = CGPointMake(0.5, 1);
                }
                    break;
                case TPGradientDirectionBottomToTop: {
                    self.startPoint = CGPointMake(0.5, 1);
                    self.endPoint = CGPointMake(0.5, 0);
                }
                    break;
                case TPGradientDirectionLeftToRight: {
                    self.startPoint = CGPointMake(0, 0.5);
                    self.endPoint = CGPointMake(1, 0.5);
                }
                    break;
                case TPGradientDirectionRightToLeft: {
                    self.startPoint = CGPointMake(1, 0.5);
                    self.endPoint = CGPointMake(0, 0.5);
                }
                    break;
            default:
                break;
        }
    }
    return self;
}

@end

@implementation TPGradientView

- (instancetype)initWithBeginColor:(UIColor *)beginColor endColor:(UIColor *)endColor direction:(TPGradientDirection)direction {
    self = [super init];
    if (self) {
        self.gradientLayer = [[TPGradientLayer alloc] initWithBeginColor:beginColor endColor:endColor direction:direction];
        
        [self.layer insertSublayer:self.gradientLayer atIndex:0];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.gradientLayer.frame = self.bounds;
}

@end
