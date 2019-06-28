//
//  SideslipCell.h
//  CellEdit
//
//  Created by Enjoy on 2019/6/28.
//  Copyright © 2019 Yuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, SideslipCellActionStyle) {
    SideslipCellActionStyleDefault = 0,
    SideslipCellActionStyleDestructive = SideslipCellActionStyleDefault, // 删除 红底
    SideslipCellActionStyleNormal , // 正常 灰底
};

@interface SideslipCellAction : NSObject

+ (instancetype)rowActionWithStyle:(SideslipCellActionStyle)style
                             title:(nullable NSString *)title
                          fontSize:(CGFloat)fontSize
                        titleColor:(UIColor *)color
                             image:(UIImage *)image
                         backColor:(UIColor *)bgColor
                           handler:(void (^)(SideslipCellAction *action, NSIndexPath *indexPath))handler;

@property (nonatomic, readonly) SideslipCellActionStyle style;
@property (nonatomic, copy, nullable) NSString *title;          // 文字内容
@property (nonatomic, strong, nullable) UIImage *image;         // 按钮图片. 默认无图
@property (nonatomic, assign) CGFloat fontSize;                 // 字体大小. 默认17
@property (nonatomic, strong, nullable) UIColor *titleColor;    // 文字颜色. 默认白色
@property (nonatomic, copy, nullable) UIColor *backgroundColor; // 背景颜色. 默认透明
@property (nonatomic, assign) CGFloat margin;                   // 内容左右间距. 默认15
@end


@class SideslipCell;
@protocol SideslipCellDelegate <NSObject>
@optional;
/**
 *  选中了侧滑按钮
 *
 *  @param sideslipCell 当前响应的cell
 *  @param indexPath    cell在tableView中的位置
 *  @param index        选中的是第几个action
 */
- (void)sideslipCell:(SideslipCell *)sideslipCell rowAtIndexPath:(NSIndexPath *)indexPath didSelectedAtIndex:(NSInteger)index;

/**
 *  告知当前位置的cell是否需要侧滑按钮
 *
 *  @param sideslipCell 当前响应的cell
 *  @param indexPath    cell在tableView中的位置
 *
 *  @return YES 表示当前cell可以侧滑, NO 不可以
 */
- (BOOL)sideslipCell:(SideslipCell *)sideslipCell canSideslipRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  返回侧滑事件
 *
 *  @param sideslipCell 当前响应的cell
 *  @param indexPath    cell在tableView中的位置
 *
 *  @return 数组为空, 则没有侧滑事件
 */
- (nullable NSArray<SideslipCellAction *> *)sideslipCell:(SideslipCell *)sideslipCell
                            editActionsForRowAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface SideslipCell : UITableViewCell

@property (nonatomic, weak) id<SideslipCellDelegate> delegate;

/**
 *  按钮容器
 */
@property (nonatomic, strong) UIView *btnContainView;

/**
 *  隐藏侧滑按钮
 */
- (void)hiddenAllSideslip;
- (void)hiddenSideslip;
@end


@interface UITableView (SideslipCell)
- (void)hiddenAllSideslip;
@end

NS_ASSUME_NONNULL_END
