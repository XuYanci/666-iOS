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
#define kTabContentBackgroundColor      [UIColor clearColor]
#define kPageViewCtrlBackgroundColor    [UIColor whiteColor]


static const CGFloat kTabHeight = 44.0;
static const CGFloat kTabWidth = 128.0;
static const CGFloat kIndicatorHeight = 2.0;
static const CGFloat kIndicatorWidth = 128.0;
static const CGFloat kPadding = 0.0;
static const CGFloat kLeadingPadding = 0.0;
static const CGFloat kTrailingPadding = 0.0;
static const BOOL kFixTabWidth = YES;
static const BOOL kFixIndicatorWidth = YES;
static const NSUInteger kDefaultDisplayPageIndex = 0;

@interface GLViewPagerViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource>
@property (nonatomic,strong)UIPageViewController *pageViewController;
@property (nonatomic,strong)NSMutableArray <UIViewController *>*contentViewControllers;
@property (nonatomic,strong)NSMutableArray <UIView *>*contentViews;
@property (nonatomic,strong)UIScrollView *tabContentView;
@property (nonatomic,strong)NSMutableArray <UIView *>*tabViews;
@property (nonatomic,strong)UIView *indicatorView;
@end

@implementation GLViewPagerViewController {
    BOOL _needsReload;
    struct {
        unsigned numberOfTabsForViewPager:1;
        unsigned viewForTabIndex:1;
        unsigned contentViewControllerForTabAtIndex:1;
        unsigned contentViewForTabAtIndex:1;
    }_datasourceHas;
    
    struct{
        unsigned didChangeTabToIndex;
    }_delegateHas;
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
    [self.view addSubview:[[UIView alloc]init]];
    /** @note 如果先添加tabContentView会导致contentSize设置无效、具体原因待查明 */
    [self.view addSubview:self.tabContentView];
    [self.tabContentView addSubview:self.indicatorView];
    [self.view addSubview:self.pageViewController.view];
  
}

- (void)viewWillLayoutSubviews {
    [self _reloadDataIfNeed];
    [self _layoutSubviews];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
  
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - datasource

#pragma mark - UIPageViewControllerDataSource

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = [self.contentViewControllers indexOfObject:viewController];
    if (index == 0) {
        return nil;
    }
    return [self.contentViewControllers objectAtIndex:index - 1];
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = [self.contentViewControllers indexOfObject:viewController];
    if (index == self.contentViewControllers.count - 1 ) {
        return nil;
    }
    return [self.contentViewControllers objectAtIndex:index + 1];
}


#pragma mark - UIPageViewControllerDelegate
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (completed) {
        NSUInteger currentPageIndex = [self.contentViewControllers indexOfObject:pageViewController.viewControllers[0]];
        NSLog(@"Current Page Index = %ld",currentPageIndex);
        [self setActiveTabIndex:currentPageIndex];
    }
}

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
    self.leadingPadding = kLeadingPadding;
    self.trailingPadding = kTrailingPadding;
    self.defaultDisplayPageIndex = kDefaultDisplayPageIndex;
    [self _setNeedsReload];
}

- (void)setDataSource:(id<GLViewPagerViewControllerDataSource>)newDataSource {
    _dataSource = newDataSource;
    
    _datasourceHas.numberOfTabsForViewPager = [newDataSource respondsToSelector:@selector(numberOfTabsForViewPager:)];
    _datasourceHas.contentViewForTabAtIndex = [newDataSource respondsToSelector:@selector(viewPager:contentViewForTabAtIndex:)];
    _datasourceHas.numberOfTabsForViewPager = [newDataSource respondsToSelector:@selector(numberOfTabsForViewPager:)];
    _datasourceHas.viewForTabIndex = [newDataSource respondsToSelector:@selector(viewPager:viewForTabIndex:)];
    _datasourceHas.contentViewControllerForTabAtIndex = [newDataSource respondsToSelector:@selector(viewPager:contentViewControllerForTabAtIndex:)];
    [self _setNeedsReload];
}

- (void)setDelegate:(id<GLViewPagerViewControllerDelegate>)newDelegate {
    _delegateHas.didChangeTabToIndex = [newDelegate respondsToSelector:@selector(viewPager:didChangeTabToIndex:)];
    _delegate = newDelegate;
}


/**
 重载数据
 @discussion  调用数据源填充数据以及建立视图树
 */
- (void)reloadData {
    
    // 清理Tab子控件
    [self.tabViews removeAllObjects];
    [self.tabContentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    // 填充Tab
    NSUInteger numberOfTabs = 0;
    if (_datasourceHas.numberOfTabsForViewPager) {
        numberOfTabs = [_dataSource numberOfTabsForViewPager:self];
    }
    
    if (_datasourceHas.viewForTabIndex) {
        /** 添加标签指示视图 */
        if (![self.tabContentView.subviews containsObject:self.indicatorView]
            && numberOfTabs > 0) {
            [self.tabContentView addSubview:self.indicatorView];
        }
        
        UIView *preTabView = nil;
        CGFloat tabContentWidth = 0;
        for (NSUInteger i = 0; i < numberOfTabs; i++) {
            UIView *tabView = [_dataSource viewPager:self viewForTabIndex:i];
            NSAssert([tabView isKindOfClass:[UIView class]], @"This is not an UIView subclass");
            [self.tabContentView addSubview:tabView];
            [self.tabViews addObject:tabView];
            
            if (!preTabView) {
                CGRect rect = tabView.frame;
                rect.size.width = self.fixTabWidth ? self.tabWidth : [tabView intrinsicContentSize].width;
                rect.size.height = self.tabHeight;
                rect.origin.x = self.leadingPadding;
                rect.origin.y = 0;
                tabView.frame = rect;
                preTabView = tabView;
                tabContentWidth += self.fixTabWidth ? self.tabWidth : [tabView intrinsicContentSize].width + self.leadingPadding;
            }
            else {
                CGRect rect = tabView.frame;
                rect.size.width = self.fixTabWidth ? self.tabWidth : [tabView intrinsicContentSize].width;
                rect.size.height = self.tabHeight;
                rect.origin.x = CGRectGetMaxX(preTabView.frame) + self.padding;
                rect.origin.y = 0;
                tabView.frame =rect;
                preTabView = tabView;
                tabContentWidth += ((self.fixTabWidth ? self.tabWidth : [tabView intrinsicContentSize].width) + self.padding);
                
                if (i == numberOfTabs - 1) {
                    tabContentWidth += self.trailingPadding;
                }
            }
        }
        self.tabContentView.contentSize = CGSizeMake(tabContentWidth, kTabHeight);
    }
    
    [self.contentViews removeAllObjects];
    [self.contentViewControllers removeAllObjects];
    
    /**填充分页方式一
     */
    if (_datasourceHas.contentViewControllerForTabAtIndex) {
        for (NSUInteger i = 0; i < numberOfTabs; i++) {
            UIViewController *viewController = [_dataSource viewPager:self contentViewControllerForTabAtIndex:i];
            NSAssert([viewController isKindOfClass:[UIViewController class]], @"This is not an UIViewController subclass");
            [self.contentViewControllers addObject:viewController];
        }
        
        NSAssert(self.defaultDisplayPageIndex <= self.contentViewControllers.count - 1, @"Default display page index is bigger than amount of  view controller");
        
        [self setActivePageIndex:self.defaultDisplayPageIndex];
        [self setActiveTabIndex:self.defaultDisplayPageIndex];
    }
    /**填充分页方式二
     */
    else if(_datasourceHas.contentViewForTabAtIndex) {
        for (NSUInteger i = 0; i < numberOfTabs; i++) {
            
        }
    }
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

- (void)setActiveTabIndex:(NSUInteger)tabIndex {
    
    NSAssert(tabIndex <= self.tabViews.count - 1, @"Default display page index is bigger than amount of  view controller");
    if (self.fixTabWidth) {
        CGRect frameOfTabView = CGRectZero;
        frameOfTabView.origin.x = tabIndex * self.fixTabWidth + (tabIndex * self.padding) + self.leadingPadding;
        frameOfTabView.origin.y = self.tabContentView.frame.size.height - self.indicatorHeight;
        frameOfTabView.size.height = self.indicatorHeight;
        frameOfTabView.size.width = self.tabWidth;
        self.indicatorView.frame = frameOfTabView;
    }
    else {
        UIView *currentTabView = self.tabViews[tabIndex];
        UIView *previousTabView = (tabIndex  > 0) ? self.tabViews[tabIndex - 1]:nil;
        CGFloat x = 0;
        if (tabIndex == 0) {
            x += self.leadingPadding;
        }
        else {
            x += self.padding;
        }
        x += CGRectGetMaxX(previousTabView.frame);
        CGRect frameOfTabView = CGRectZero;
        frameOfTabView.origin.x = x;
        frameOfTabView.origin.y = self.tabHeight - self.indicatorHeight;
        frameOfTabView.size.height = self.indicatorHeight;
        frameOfTabView.size.width = currentTabView.intrinsicContentSize.width;
        self.indicatorView.frame = frameOfTabView;
    }
}

- (void)setActivePageIndex:(NSUInteger)pageIndex {
    NSAssert(pageIndex <= self.contentViewControllers.count - 1, @"Default display page index is bigger than amount of  view controller");
    
    [self.pageViewController setViewControllers:@[self.contentViewControllers[pageIndex]]
                                      direction:UIPageViewControllerNavigationDirectionForward | UIPageViewControllerNavigationDirectionReverse
                                       animated:YES
                                     completion:^(BOOL finished) {
                                         
                                     }];
}


#pragma mark - notification
#pragma mark - getter and setter
- (UIScrollView *)tabContentView {
    if (!_tabContentView) {
        _tabContentView = [[UIScrollView alloc]initWithFrame:CGRectZero];
        _tabContentView.backgroundColor = kTabContentBackgroundColor;
        _tabContentView.showsVerticalScrollIndicator = YES;
        _tabContentView.showsHorizontalScrollIndicator = YES;
        _tabContentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _tabContentView.scrollsToTop = NO;
        _tabContentView.showsHorizontalScrollIndicator = NO;
        _tabContentView.showsVerticalScrollIndicator = NO;
        _tabContentView.bounces = NO;
        _tabContentView.contentSize = CGSizeZero;
    }
    return _tabContentView;
}

- (UIView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIView alloc]initWithFrame:CGRectZero];
        _indicatorView.backgroundColor = kIndicatorColor;
//        _indicatorView.layer.zPosition = 1.0;
    }
    return _indicatorView;
}

- (UIPageViewController *)pageViewController {
    if (!_pageViewController) {
        _pageViewController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _pageViewController.view.backgroundColor = kPageViewCtrlBackgroundColor;
        _pageViewController.dataSource = self;
        _pageViewController.delegate = self;
    }
    return _pageViewController;
}

- (NSMutableArray *)contentViewControllers {
    if (!_contentViewControllers) {
        _contentViewControllers = [NSMutableArray array];
    }
    return _contentViewControllers;
}

- (NSMutableArray *)contentViews {
    if (!_contentViews) {
        _contentViews = [NSMutableArray array];

    }
    return _contentViews;
}

- (NSMutableArray *)tabViews {
    if (!_tabViews) {
        _tabViews = [NSMutableArray array];
    }
    return _tabViews;
}

@end
