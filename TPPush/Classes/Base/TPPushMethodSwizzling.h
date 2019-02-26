//
//  TPPushMethodSwizzling.h
//  TPPush
//
//  Created by Topredator on 2019/2/26.
//

#import <Foundation/Foundation.h>


/**
 交换类的实例方法
 @param originClass 需要交换的类
 @param originSelector 交换前的实例方法
 @param swizzledSelector 交换后的实例方法
 */
void TPSwizzlingInstanceMethod(Class originClass, SEL originSelector, SEL swizzledSelector);

/**
 交换类 与 类的实例方法
*/
void TPSwizzlingClassAndInstanceMethod(Class originClass, Class swizzledClass, SEL originSelector, SEL swizzledSelector);
