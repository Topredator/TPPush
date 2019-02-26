//
//  TPUIKitDefine.m
//  TPUIKit
//
//  Created by Topredator on 2019/2/22.
//

#import "TPGradientView.h"

UIImage *TPModuleImage(NSString *name) {
    NSBundle *bundle = [NSBundle bundleForClass:[TPGradientView class]];
    return [UIImage imageNamed:name inBundle:bundle compatibleWithTraitCollection:nil];
}
