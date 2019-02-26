//
//  TPPushMethodSwizzling.m
//  TPPush
//
//  Created by Topredator on 2019/2/26.
//

#import "TPPushMethodSwizzling.h"
#import <objc/runtime.h>


void TPSwizzlingInstanceMethod(Class originClass, SEL originSelector, SEL swizzledSelector) {
    Method originMethod = class_getInstanceMethod(originClass, originSelector);
    Method swizzledMethod = class_getInstanceMethod(originClass, swizzledSelector);
    if (class_addMethod(originClass, originSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
        class_replaceMethod(originClass, swizzledSelector, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    } else {
        method_exchangeImplementations(originMethod, swizzledMethod);
    }
}

void TPSwizzlingClassAndInstanceMethod(Class originClass, Class swizzledClass, SEL originSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(originClass, originSelector);
    Method swizzlingMethod = class_getInstanceMethod(swizzledClass, swizzledSelector);
    if (class_addMethod(originClass, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))) {
        class_replaceMethod(originClass, swizzledSelector, method_getImplementation(swizzlingMethod), method_getTypeEncoding(swizzlingMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzlingMethod);
    }
}
