//
//  UIView+Extension.m
//  HUDCooldrive
//
//  Created by YuanGu on 2017/11/14.
//  Copyright © 2017年 YuanGu. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (CGFloat)originX {
    return self.frame.origin.x;
}

- (void)setOriginX:(CGFloat)originX {
    CGRect frame = self.frame;
    frame.origin.x = originX;
    self.frame = frame;
}

- (CGFloat)originY {
    return self.frame.origin.y;
}

- (void)setOriginY:(CGFloat)originY {
    CGRect frame = self.frame;
    frame.origin.y = originY;
    self.frame = frame;
}

- (CGFloat)maxX {
    return [self originX] + [self width];
}

- (void)setMaxX:(CGFloat)maxX{
    CGRect frame = self.frame;
    frame.origin.x = maxX - [self width];
    self.frame = frame;
}

- (CGFloat)maxY {
    return [self originY] + [self height];
}

- (void)setMaxY:(CGFloat)maxY{
    CGRect frame = self.frame;
    frame.origin.y = maxY - [self height];
    self.frame = frame;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

//移除此view上的所有子视图
- (void)removeAllSubviews {
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
}

//是否水平 添加渐变
- (void)graidentLayerIsHorizontal:(BOOL)isHorizontal{
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:38/255.0 green:174/255.0 blue:252/255.0 alpha:1.0].CGColor,
                             (__bridge id)[UIColor colorWithRed:0/255.0 green:132/255.0 blue:255/255.0 alpha:1.0].CGColor];
    
    gradientLayer.locations = @[@0, @1.0];
    
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = isHorizontal ? CGPointMake(1, 0) : CGPointMake(0, 1);
    
    gradientLayer.frame = self.bounds;
    
    [self.layer addSublayer:gradientLayer];
}

//添加圆角
- (void)cornerLayerWithWidth:(CGFloat)corner{
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                   byRoundingCorners:UIRectCornerAllCorners
                                                         cornerRadii:CGSizeMake(corner, corner)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    //设置大小
    maskLayer.frame = self.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    
    self.layer.mask = maskLayer;
}

//绘制边缘线条
- (void)borderLineLayerWithRect:(CGRect)rect color:(UIColor *)color{
    
    CALayer *layer = [CALayer layer];
    
    [layer setFrame:rect];
    [layer setBackgroundColor:color.CGColor];
    
    [self.layer addSublayer:layer];
}

//绘制边框 加圆角
- (void)borderAllLineLayerWith:(CGFloat)radiu
                         color:(UIColor *)color
                     lineWidth:(CGFloat)width{
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.bounds;
    
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.frame = self.bounds;
    borderLayer.lineWidth = width;
    borderLayer.strokeColor = color.CGColor;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                          cornerRadius:radiu];
    maskLayer.path = bezierPath.CGPath;
    borderLayer.path = bezierPath.CGPath;
    
    [self.layer insertSublayer:borderLayer atIndex:0];
    [self.layer setMask:maskLayer];
}

@end
