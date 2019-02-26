//
//  TPSimButton.h
//  Pods-TPUIKit_Example
//
//  Created by Topredator on 2019/2/21.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, TPSimButtonIconPosition) {
    TPSimButtonIconPositionDefault, // 系统默认样式
    TPSimButtonIconPositionLeft, // icon在文本左边
    TPSimButtonIconPositionRight, // icon在文本右边
    TPSimButtonIconPositionTop, // icon在文本上边
    TPSimButtonIconPositionBottom, // icon在文本下边
    TPSimButtonIconPositionCenter // // icon在文本上边, 居中对齐
};

@interface TPSimButton : UIButton
/// 图片 文本距离
@property (nonatomic, assign) CGFloat iconTextMargin;
/// 图片 文本的相对类型
@property (nonatomic, assign) TPSimButtonIconPosition iconPosition;

/// 按钮点击扩展范围，设定值为单侧的px，上下左右都会加上这个扩展值
@property (nonatomic, assign) NSInteger extInteractEdge;
/// 自定义扩展上下左右的值
@property (nonatomic, assign) UIEdgeInsets extInteractInsets;

@end

