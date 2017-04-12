//
//  GLViewPagerViewController.m
//  66GoodLook
//
//  Created by Yanci on 17/4/11.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import "GLViewPagerViewController.h"



/**
 * 常量定义
 */
#define kIndicatorColor             [UIColor blueColor]
#define kTabFontDefault             [UIFont systemFontOfSize:12]
#define kTabFontSelected            [UIFont systemFontOfSize:12]
#define kTabTextColorDefault        [UIColor blueColor]
#define kTabTextColorSelected       [UIColor blueColor]
#define kBackgroundColor            [UIColor whiteColor]
#define kTabContentBackgroundColor  [UIColor redColor]

static const CGFloat kTabHeight = 44.0;
static const CGFloat kTabWidth = 128.0;
static const CGFloat kIndicatorHeight = 5.0;
static const CGFloat kIndicatorWidth = 128.0;
static const CGFloat kPadding = 0.0;
static const BOOL kFixTabWidth = YES;
static const BOOL kFixIndicatorWidth = YES;


@interface GLViewPagerViewController ()
@property (nonatomic,strong)UIPageViewController *pageViewController;
@property (nonatomic,strong)NSMutableArray <UIViewController *>*contentViewControllers;
@property (nonatomic,strong)UIScrollView *tabContentView;
@property (nonatomic,strong)NSMutableArray <UIView *>*tabViews;
@property (nonatomic,strong)UIView *indicatorView;
@end

@implementation GLViewPagerViewController {
    BOOL _needsReload;
}


#pragma mark - life cycle
- (id)init {
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (void)dealloc {
    
}

- (void)loadView  {
    self.view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tabContentView];
}

- (void)viewWillLayoutSubviews {
    if (_needsReload) {
        _needsReload = NO;
    }
    
    /** 视图布局 */
    CGFloat topLayoutGuide = self.topLayoutGuide.length;
    CGFloat bottomLayoutGuide = self.bottomLayoutGuide.length;
    
    CGRect tabContentViewFrame = self.tabContentView.frame;
    tabContentViewFrame.size.width = self.view.bounds.size.width;
    tabContentViewFrame.size.height = kTabHeight;
    tabContentViewFrame.origin.x = 0;
    tabContentViewFrame.origin.y = topLayoutGuide;
    self.tabContentView.frame = tabContentViewFrame;
    
    
    
    
}


- (void)viewDidLayoutSubviews {

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

}



#pragma mark - datasource
#pragma mark - delegate
#pragma mark - user events
#pragma mark - functions

/**
 默认初始化
 */
- (void)commonInit {
    /** 初始化默认参数 */
    self.indicatorColor = kIndicatorColor;
    self.tabFontDefault = kTabFontDefault;
    self.tabFontSelected = kTabFontSelected;
    self.tabTextColorDefault = kTabTextColorDefault;
    self.tabTextColorSelected = kTabTextColorSelected;
    self.fixTabWidth = kFixTabWidth;
    self.tabWidth = kTabWidth;
    self.tabHeight = kTabHeight;
    self.indicatorHeight = kIndicatorHeight;
    self.padding = kPadding;
    self.indicatorWidth = kIndicatorWidth;
    self.fixIndicatorWidth = kFixIndicatorWidth;
    _needsReload = YES;
}


- (void)reloadData {
    [self _setNeedsReload];
}

/**
 * 重新加载数据
 */
- (void)_setNeedsReload {
    _needsReload = YES;
    [self.view setNeedsLayout];
}


#pragma mark - notification
#pragma mark - getter and setter
- (UIScrollView *)tabContentView {
    if (!_tabContentView) {
        _tabContentView = [[UIScrollView alloc]initWithFrame:CGRectZero];
        _tabContentView.backgroundColor = kTabContentBackgroundColor;
    }
    return _tabContentView;
}

- (UIView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIView alloc]initWithFrame:CGRectZero];
    }
    return _indicatorView;
}


@end
