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

@interface GoodLookIndexViewController ()<GLViewPagerViewControllerDataSource,GLViewPagerViewControllerDelegate>
@property (nonatomic,strong)NSArray *viewControllers;
@property (nonatomic,strong)NSArray *tagTitles;
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
                       @"灌水区"
                       ];
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
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

- (UIViewController *)viewPager:(GLViewPagerViewController *)viewPager
contentViewControllerForTabAtIndex:(NSUInteger)index {
    return self.viewControllers[index];
}
#pragma mark - GLViewPagerViewControllerDelegate
@end
