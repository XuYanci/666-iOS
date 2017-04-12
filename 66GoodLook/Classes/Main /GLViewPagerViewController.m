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
#define kIndicatorColor                 [UIColor blueColor]
#define kTabFontDefault                 [UIFont systemFontOfSize:12]
#define kTabFontSelected                [UIFont systemFontOfSize:12]
#define kTabTextColorDefault            [UIColor blueColor]
#define kTabTextColorSelected           [UIColor blueColor]
#define kBackgroundColor                [UIColor whiteColor]
#define kTabContentBackgroundColor      [UIColor redColor]
#define kPageViewCtrlBackgroundColor    [UIColor blueColor]


static const CGFloat kTabHeight = 44.0;
static const CGFloat kTabWidth = 128.0;
static const CGFloat kIndicatorHeight = 5.0;
static const CGFloat kIndicatorWidth = 128.0;
static const CGFloat kPadding = 0.0;
static const BOOL kFixTabWidth = YES;
static const BOOL kFixIndicatorWidth = YES;


@interface GLViewPagerViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource>
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
    [self.view addSubview:self.pageViewController.view];
}

- (void)viewWillLayoutSubviews {
    [self _reloadDataIfNeed];
    [self _layoutSubviews];
}

- (void)viewDidLayoutSubviews {

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

}



#pragma mark - datasource

#pragma mark - UIPageViewControllerDataSource

#pragma mark - UIPageViewControllerDelegate


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
    [self _setNeedsReload];
}

- (void)setDataSource:(id<GLViewPagerViewControllerDataSource>)newDataSource {
    _dataSource = newDataSource;
    [self _setNeedsReload];
}

- (void)setDelegate:(id<GLViewPagerViewControllerDelegate>)newDelegate {
    _delegate = newDelegate;
}


/**
 重载数据
 @discussion  调用数据源填充数据以及建立视图树
 */
- (void)reloadData {
    // TODO: 填充Tab
    // TODO: 填充分页
    _needsReload = NO;
}

/**
 * 重新加载数据
 */
- (void)_setNeedsReload {
    _needsReload = YES;
    [self.view setNeedsLayout];
}

/**
 按需重新加载数据
 */
- (void)_reloadDataIfNeed {
    if (_needsReload) {
        [self reloadData];
    }
}

/** 视图布局 */
- (void)_layoutSubviews {
 
    CGFloat topLayoutGuide = self.topLayoutGuide.length;
    CGFloat bottomLayoutGuide = self.bottomLayoutGuide.length;
    
    /** 布局TabContentView */
    CGRect tabContentViewFrame = self.tabContentView.frame;
    tabContentViewFrame.size.width = self.view.bounds.size.width;
    tabContentViewFrame.size.height = kTabHeight;
    tabContentViewFrame.origin.x = 0;
    tabContentViewFrame.origin.y = topLayoutGuide;
    self.tabContentView.frame = tabContentViewFrame;
    
    /** 布局PageViewController */
    CGRect pageViewCtrlFrame = self.pageViewController.view.frame;
    pageViewCtrlFrame.size.width = self.view.bounds.size.width;
    pageViewCtrlFrame.size.height = self.view.bounds.size.height - topLayoutGuide - bottomLayoutGuide - CGRectGetHeight(self.tabContentView.frame);
    pageViewCtrlFrame.origin.x = 0;
    pageViewCtrlFrame.origin.y = topLayoutGuide + CGRectGetHeight(self.tabContentView.frame);
    self.pageViewController.view.frame = pageViewCtrlFrame;
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

- (UIPageViewController *)pageViewController {
    if (!_pageViewController) {
        _pageViewController = [[UIPageViewController alloc]init];
        _pageViewController.view.backgroundColor = kPageViewCtrlBackgroundColor;
        _pageViewController.dataSource = self;
        _pageViewController.delegate = self;
    }
    return _pageViewController;
}


@end
