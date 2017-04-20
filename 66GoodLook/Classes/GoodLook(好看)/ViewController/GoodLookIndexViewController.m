//
//  GoodLookIndexViewController.m
//  66GoodLook
//
//  Created by Yanci on 17/4/12.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import "GoodLookIndexViewController.h"
#import "GoodLookBaseViewController.h"
#import "GoodLookWellChosenViewController.h"
#import "GoodLookFloatView.h"

@interface GoodLookIndexViewController ()<GLViewPagerViewControllerDataSource,GLViewPagerViewControllerDelegate,GoodLookFloatViewDelegate>
@property (nonatomic,strong)NSArray *viewControllers;
@property (nonatomic,strong)NSArray *tagTitles;
@property (nonatomic,strong)GoodLookFloatView *floatView;
@end

@implementation GoodLookIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    // Do any additional setup after loading the view.
    self.dataSource = self;
    self.delegate = self;
    self.fixTabWidth = NO;
    self.padding = 10;
    self.leadingPadding = 10;
    self.trailingPadding = 10;
    self.defaultDisplayPageIndex = 0;
    self.tabAnimationType = GLTabAnimationType_whileScrolling;
    self.indicatorColor = [UIColor colorWithRed:255.0/255.0 green:205.0 / 255.0 blue:0.0 alpha:1.0];
    
    GoodLookBaseViewController *concernViewController = [[GoodLookBaseViewController alloc]init];
    concernViewController.view.backgroundColor = [UIColor redColor];
    
    GoodLookWellChosenViewController *wellChosenViewController = [[GoodLookWellChosenViewController alloc]init];
    wellChosenViewController.view.backgroundColor = [UIColor blueColor];
    
    GoodLookWellChosenViewController *SignOnViewController = [[GoodLookWellChosenViewController alloc]init];
    SignOnViewController.view.backgroundColor = [UIColor greenColor];
    
  
    GoodLookBaseViewController *girlSchoolViewController = [[GoodLookBaseViewController alloc]init];
    girlSchoolViewController.view.backgroundColor = [UIColor yellowColor];
    
    
    GoodLookBaseViewController *lolFriendDiscussViewController = [[GoodLookBaseViewController alloc]init];
    lolFriendDiscussViewController.view.backgroundColor = [UIColor purpleColor];
    
    
    GoodLookBaseViewController *lolFillWaterViewController = [[GoodLookBaseViewController alloc]init];
    lolFillWaterViewController.view.backgroundColor = [UIColor whiteColor];
    
    /** 设置内容视图 */
    self.viewControllers = @[
                              concernViewController,
                              wellChosenViewController,
                              SignOnViewController,
                              girlSchoolViewController,
                              lolFriendDiscussViewController,
                              lolFillWaterViewController,
                              ];
    /** 设置标签标题 */
    self.tagTitles = @[
                       @"关注",
                       @"精选",
                       @"签到夺金",
                       @"女子学院",
                       @"撸友讨论",
                       @"灌水区",
                       ];
    
    /** 添加悬浮视图 */
    [self.view addSubview:self.floatView];
    [self.floatView resetPosition];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - GLViewPagerViewControllerDataSource
- (NSUInteger)numberOfTabsForViewPager:(GLViewPagerViewController *)viewPager {
    return self.viewControllers.count;
}



- (UIView *)viewPager:(GLViewPagerViewController *)viewPager
      viewForTabIndex:(NSUInteger)index {
    UILabel *label = [[UILabel alloc]init];
    label.text = [self.tagTitles objectAtIndex:index];
    label.font = [UIFont systemFontOfSize:16.0];
    label.textColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = NSTextAlignmentCenter;
    label.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
    return label;
}

- (UIViewController *)viewPager:(GLViewPagerViewController *)viewPager
contentViewControllerForTabAtIndex:(NSUInteger)index {
    return self.viewControllers[index];
}
#pragma mark - GLViewPagerViewControllerDelegate
- (void)viewPager:(GLViewPagerViewController *)viewPager didChangeTabToIndex:(NSUInteger)index fromTabIndex:(NSUInteger)fromTabIndex {
    UILabel *prevLabel = (UILabel *)[viewPager tabViewAtIndex:fromTabIndex];
    UILabel *currentLabel = (UILabel *)[viewPager tabViewAtIndex:index];
    prevLabel.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
    currentLabel.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
    prevLabel.textColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    currentLabel.textColor = [UIColor colorWithWhite:0.0 alpha:1.0];
}

- (void)viewPager:(GLViewPagerViewController *)viewPager willChangeTabToIndex:(NSUInteger)index fromTabIndex:(NSUInteger)fromTabIndex withTransitionProgress:(CGFloat)progress {
    
    if (fromTabIndex == index) {
        return;
    }
    
    UILabel *prevLabel = (UILabel *)[viewPager tabViewAtIndex:fromTabIndex];
    UILabel *currentLabel = (UILabel *)[viewPager tabViewAtIndex:index];
    prevLabel.transform = CGAffineTransformScale(CGAffineTransformIdentity,
                                                 1.0 - (0.1 * progress),
                                                 1.0 - (0.1 * progress));
    currentLabel.transform = CGAffineTransformScale(CGAffineTransformIdentity,
                                                    0.9 + (0.1 * progress),
                                                    0.9 + (0.1 * progress));
    prevLabel.textColor = [UIColor colorWithWhite:0.0 alpha:1.0 - (0.5 * progress)];
    currentLabel.textColor = [UIColor colorWithWhite:0.0 alpha:0.5 + (0.5 * progress)];
}

- (CGFloat)viewPager:(GLViewPagerViewController *)viewPager widthForTabIndex:(NSUInteger)index {
    static UILabel *prototypeLabel ;
    if (!prototypeLabel) {
        prototypeLabel = [[UILabel alloc]init];
    }
    prototypeLabel.text = [self.tagTitles objectAtIndex:index];
    prototypeLabel.textAlignment = NSTextAlignmentCenter;
    prototypeLabel.font = [UIFont systemFontOfSize:16.0];
    return prototypeLabel.intrinsicContentSize.width;
}


#pragma mark - GoodLookFloatViewDelegate
- (void)floatView:(id)sender didPickEdit:(GLEditType)editType {
    
}
#pragma mark - getter and setter 
- (GoodLookFloatView *)floatView {
    if (!_floatView) {
        _floatView = [[GoodLookFloatView alloc]init];
        _floatView.frame = CGRectMake(0, 64.0 + self.tabHeight, 44, 44);
        _floatView.backgroundColor = [UIColor clearColor];
        _floatView.delegate = self;
    }
    return _floatView;
}
@end
