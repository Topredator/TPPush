//
//  TPToastImageView.m
//  TPUIKit
//
//  Created by Topredator on 2019/2/22.
//

#import "TPToastImageView.h"

@implementation TPToastImageView

- (CGSize)intrinsicContentSize {
    if (CGSizeEqualToSize(self.frame.size, CGSizeZero)) {
        return [super intrinsicContentSize];
    }
    return self.frame.size;
}
@end
