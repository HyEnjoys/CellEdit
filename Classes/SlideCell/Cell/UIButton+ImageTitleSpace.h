//
//  UIButton+ImageTitleSpace.h
//  HUDCooldrive
//
//  Created by YuanGu on 2017/11/14.
//  Copyright © 2017年 YuanGu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ButtonEdgeInsetsStyle) {
    ButtonEdgeInsetsStyleTop,    // image在上，label在下
    ButtonEdgeInsetsStyleLeft,   // image在左，label在右
    ButtonEdgeInsetsStyleBottom, // image在下，label在上
    ButtonEdgeInsetsStyleRight   // image在右，label在左
};

@interface UIButton (ImageTitleSpace)

/**
 *  设置button的titleLabel和imageView的布局样式，及间距
 *
 *  @param style titleLabel和imageView的布局样式
 *  @param space titleLabel和imageView的间距
 */
- (void)layoutButtonWithEdgeInsetsStyle:(ButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;


#define defaultInterval 1.0 //默认时间间隔

//用这个给重复点击加间隔
@property (nonatomic ,assign) NSTimeInterval timeInterval;
//YES不允许点击NO允许点击
@property (nonatomic ,assign) BOOL isIgnoreEvent;
@end
