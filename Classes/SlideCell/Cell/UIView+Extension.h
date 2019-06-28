//
//  UIView+Extension.h
//  HUDCooldrive
//
//  Created by YuanGu on 2017/11/14.
//  Copyright © 2017年 YuanGu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

/**
 * @brief Shortcut for frame.origin.x.
 *        Sets frame.origin.x = originX
 */
@property (nonatomic) CGFloat originX;

/**
 * @brief Shortcut for frame.origin.y
 *        Sets frame.origin.y = originY
 */
@property (nonatomic) CGFloat originY;

/**
 * @brief Shortcut for frame.origin.x + frame.size.width
 *       Sets frame.origin.x = rightX - frame.size.width
 */
@property (nonatomic) CGFloat maxX;

/**
 * @brief Shortcut for frame.origin.y + frame.size.height
 *        Sets frame.origin.y = bottomY - frame.size.height
 */
@property (nonatomic) CGFloat maxY;

/**
 * @brief Shortcut for frame.size.width
 *        Sets frame.size.width = width
 */
@property (nonatomic) CGFloat width;

/**
 * @brief Shortcut for frame.size.height
 *        Sets frame.size.height = height
 */
@property (nonatomic) CGFloat height;

/**
 * @brief Shortcut for center.x
 * Sets center.x = centerX
 */
@property (nonatomic) CGFloat centerX;

/**
 * @brief Shortcut for center.y
 *        Sets center.y = centerY
 */
@property (nonatomic) CGFloat centerY;

/**
 * @brief Shortcut for frame.origin
 */
@property (nonatomic) CGPoint origin;

/**
 * @brief Shortcut for frame.size
 */
@property (nonatomic) CGSize size;


//是否水平 添加渐变
- (void)graidentLayerIsHorizontal:(BOOL)isHorizontal;

//添加圆角
- (void)cornerLayerWithWidth:(CGFloat)corner;

//绘制边缘线条
- (void)borderLineLayerWithRect:(CGRect)rect color:(UIColor *)color;

//绘制边框 圆角
- (void)borderAllLineLayerWith:(CGFloat)radiu color:(UIColor *)color lineWidth:(CGFloat)width;

@end
