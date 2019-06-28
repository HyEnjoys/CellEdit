//
//  UIButton+ImageTitleSpace.m
//  HUDCooldrive
//
//  Created by YuanGu on 2017/11/14.
//  Copyright © 2017年 YuanGu. All rights reserved.
//

#import "UIButton+ImageTitleSpace.h"
#import <objc/runtime.h>

@implementation UIButton (ImageTitleSpace)

/**
 *  titleEdgeInsets是title相对于其上下左右的inset，跟tableView的contentInset是类似的，
 *  如果只有title，那它上下左右都是相对于button的，image也是一样；
 *  如果同时有image和label，那这时候image的上左下是相对于button，右边是相对于label的；title的上右下是相对于button，左边是相对于image的。
 */

- (void)layoutButtonWithEdgeInsetsStyle:(ButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space
{
    //get width and height with imageView and titleLabel
    CGFloat imageWith = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
    
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        
        //ios8.0，titleLabel.size = (0,0)
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
    } else {
        labelWidth = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
    }
    
    //define imageEdgeInsets、labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    //get imageEdgeInsets and labelEdgeInsets from style、space
    switch (style) {
        case ButtonEdgeInsetsStyleTop:
        {
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space/2.0, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-space/2.0, 0);
        }
            break;
        case ButtonEdgeInsetsStyleLeft:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
        }
            break;
        case ButtonEdgeInsetsStyleBottom:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space/2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-space/2.0, -imageWith, 0, 0);
        }
            break;
        case ButtonEdgeInsetsStyleRight:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space/2.0, 0, -labelWidth-space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-space/2.0, 0, imageWith+space/2.0);
        }
            break;
        default:
            break;
    }
    
    //reSet
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}



- (NSTimeInterval)timeInterval{
    return [objc_getAssociatedObject(self,_cmd) doubleValue];
}
- (void)setTimeInterval:(NSTimeInterval)timeInterval{
    objc_setAssociatedObject(self ,
                             @selector(timeInterval),
                             @(timeInterval) ,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//runtime动态绑定属性
- (void)setIsIgnoreEvent:(BOOL)isIgnoreEvent{
    objc_setAssociatedObject(self,
                             @selector(isIgnoreEvent),
                             @(isIgnoreEvent),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}
- (BOOL)isIgnoreEvent{
    return [objc_getAssociatedObject(self,_cmd) boolValue];
}

- (void)resetState{
    [self setIsIgnoreEvent:NO];
}

+ (void)load{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        SEL selA = @selector(sendAction:to:forEvent:);
        SEL selB = @selector(mySendAction:to:forEvent:);
        
        Method methodA = class_getInstanceMethod(self, selA);
        Method methodB = class_getInstanceMethod(self, selB);
        
        //将methodB的实现添加到系统方法中也就是说将methodA方法指针添加成方法methodB的返回值表示是否添加成功
        BOOL isAdd = class_addMethod(self,
                                     selA,
                                     method_getImplementation(methodB),
                                     method_getTypeEncoding(methodB));
        //添加成功了说明本类中不存在methodB所以此时必须将方法b的实现指针换成方法A的，否则b方法将没有实现。
        if(isAdd) {
            class_replaceMethod(self,
                                selB,
                                method_getImplementation(methodA),
                                method_getTypeEncoding(methodA));
        }else{
            //添加失败了说明本类中有methodB的实现，此时只需要将methodA和methodB的IMP互换一下即可。
            method_exchangeImplementations(methodA, methodB);
        }
    });
}
- (void)mySendAction:(SEL)action to:(id)target forEvent:(UIEvent*)event{
    
    if ( [NSStringFromClass(self.class) isEqualToString:@"UIButton"] ) {
        
        self.timeInterval = (self.timeInterval == 0 ? defaultInterval : self.timeInterval);
        
        if (self.isIgnoreEvent){
            return;
        }else if(self.timeInterval > 0){
            [self performSelector:@selector(resetState) withObject:nil afterDelay:self.timeInterval];
        }
    }
    //此处methodA和methodB方法IMP互换了，实际上执行sendAction；所以不会死循环
    self.isIgnoreEvent = YES;
    
    [self mySendAction:action to:target forEvent:event];
}

@end
