//
//  GoodLookIndexViewController.m
//  66GoodLook
//
//  Created by Yanci on 17/4/12.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import "GoodLookIndexViewController.h"
 
@interface GoodLookIndexViewController ()<GLViewPagerViewControllerDataSource,GLViewPagerViewControllerDelegate>

@end

@implementation GoodLookIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
    self.dataSource = self;
    self.delegate = self;
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
    return 10;
}

- (UIView *)viewPager:(GLViewPagerViewController *)viewPager
      viewForTabIndex:(NSUInteger)index {
    UILabel *label = [[UILabel alloc]init];
    label.text = [NSString stringWithFormat:@"%@%ld",@"标签",index];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

#pragma mark - GLViewPagerViewControllerDelegate
@end
