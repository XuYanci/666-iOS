//
//  GLMainTabBarViewController.m
//  66GoodLook
//
//  Created by Yanci on 17/4/11.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import "GLMainTabBarViewController.h"
#import "GLViewPagerViewController.h"
#import "GoodLookIndexViewController.h"

@interface GLMainTabBarViewController ()
@property (nonatomic,strong)GoodLookIndexViewController *viewPagerViewController;
@end

@implementation GLMainTabBarViewController


#pragma mark - life cycle




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self commonInit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
  
}

- (void)transferIn:(NSUInteger)a {
  
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - datasource

#pragma mark - delegate

#pragma mark - user events

#pragma mark - functions
- (void)commonInit {
    [self setViewControllers:@[[[UINavigationController alloc]initWithRootViewController:self.viewPagerViewController],
//                               [[UINavigationController alloc]initWithRootViewController:self.goodPlayViewController],
//                               [[UINavigationController alloc]initWithRootViewController:self.messageViewController],
//                               [[UINavigationController alloc]initWithRootViewController:self.meViewController]
                               ]];
}

#pragma mark - notification
#pragma mark - getter and setter
- (GoodLookIndexViewController *)viewPagerViewController {
    if (!_viewPagerViewController) {
        _viewPagerViewController = [[GoodLookIndexViewController alloc]init];
        _viewPagerViewController.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"666"
                                                                          image:[[UIImage imageNamed:@"lab_home_d"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                  selectedImage:[[UIImage imageNamed:@"lab_home_s"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [_viewPagerViewController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}
                                                           forState:UIControlStateSelected];
    }
    return _viewPagerViewController;
}

@end
