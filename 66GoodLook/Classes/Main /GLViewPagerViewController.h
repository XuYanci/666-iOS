//
//  GLViewPagerViewController.h
//  66GoodLook
//
//  Created by Yanci on 17/4/11.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GLViewPagerViewController;
/** ViewPager数据源 */
@protocol GLViewPagerViewControllerDataSource <NSObject>

/**
 数据源 - 返回多少个标签
 @param viewPager 分页控件
 @return 返回多少个标签
 */
- (NSUInteger)numberOfTabsForViewPager:(GLViewPagerViewController *)viewPager;

/**
 数据源 - 返回对应标签视图
 @param viewPager 分页控件
 @return 返回对应标签视图
 */
- (UIView *)viewPager:(GLViewPagerViewController *)viewPager
      viewForTabIndex:(NSUInteger)index;

@optional
- (UIViewController *)viewPager:(GLViewPagerViewController *)viewPager
contentViewControllerForTabAtIndex:(NSUInteger)index;

- (UIViewController *)viewPager:(GLViewPagerViewController *)viewPager
       contentViewForTabAtIndex:(NSUInteger)index;
@end

/** ViewPager委托*/
@protocol GLViewPagerViewControllerDelegate <NSObject>



@end

@interface GLViewPagerViewController : UIViewController

/** 数据源 */
@property (nonatomic,weak)id<GLViewPagerViewControllerDataSource> dataSource;
/** 委托 */
@property (nonatomic,weak)id<GLViewPagerViewControllerDelegate> delegate;

/** 指示器颜色 */
@property (nonatomic,strong)UIColor *indicatorColor;
/** 默认标签字体 */
@property (nonatomic,strong)UIFont *tabFontDefault;
/** 选择标签字体 */
@property (nonatomic,strong)UIFont *tabFontSelected;
/** 默认标签字体颜色 */
@property (nonatomic,strong)UIColor *tabTextColorDefault;
/** 选择标签字体颜色 */
@property (nonatomic,strong)UIColor *tabTextColorSelected;
/** 固定标签宽度 */
@property (nonatomic,assign)BOOL fixTabWidth;
/** 标签宽度 */
@property (nonatomic,assign)CGFloat tabWidth;
/** 标签高度 */
@property (nonatomic,assign)CGFloat tabHeight;
/** 指示器高度 */
@property (nonatomic,assign)CGFloat indicatorHeight;
/** 标签之间间距 */
@property (nonatomic,assign)CGFloat padding;



@end
