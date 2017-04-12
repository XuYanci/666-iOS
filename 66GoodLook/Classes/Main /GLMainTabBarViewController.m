//
//  GLMainTabBarViewController.m
//  66GoodLook
//
//  Created by Yanci on 17/4/11.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import "GLMainTabBarViewController.h"
#import "GLViewPagerViewController.h"
#import "GLMeViewController.h"
#import "GoodPlayViewController.h"
#import "GoodLookIndexViewController.h"
#import "GLMessageViewController.h"

@interface GLMainTabBarViewController ()
@property (nonatomic,strong)GoodLookIndexViewController *viewPagerViewController;
@property (nonatomic,strong)GoodPlayViewController *goodPlayViewController;
@property (nonatomic,strong)GLMessageViewController *messageViewController;
@property (nonatomic,strong)GLMeViewController *meViewController;
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
                               [[UINavigationController alloc]initWithRootViewController:self.goodPlayViewController],
                               [[UINavigationController alloc]initWithRootViewController:self.messageViewController],
                               [[UINavigationController alloc]initWithRootViewController:self.meViewController]]];
}

#pragma mark - notification
#pragma mark - getter and setter
- (GoodLookIndexViewController *)viewPagerViewController {
    if (!_viewPagerViewController) {
        _viewPagerViewController = [[GoodLookIndexViewController alloc]init];
        _viewPagerViewController.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"好看"
                                                                          image:[[UIImage imageNamed:@"lab_home_d"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                  selectedImage:[[UIImage imageNamed:@"lab_home_s"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];

    }
    return _viewPagerViewController;
}

- (GoodPlayViewController *)goodPlayViewController {
    if (!_goodPlayViewController) {
        _goodPlayViewController = [[GoodPlayViewController alloc]init];
        _goodPlayViewController.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"好玩"
                                                                          image:[[UIImage imageNamed:@"faxian_normal_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                  selectedImage:[[UIImage imageNamed:@"faxian_press_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }
    return _goodPlayViewController;
}

- (GLMessageViewController *)messageViewController {
    if (!_messageViewController) {
         _messageViewController = [[GLMessageViewController alloc]init];
         _messageViewController.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"消息"
                                                                          image:[[UIImage imageNamed:@"lab_messege_d"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                  selectedImage:[[UIImage imageNamed:@"lab_messege_s"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
    }
    return _messageViewController;
}

- (GLMeViewController *)meViewController {
    if (!_meViewController) {
         _meViewController = [[GLMeViewController alloc]init];
        _meViewController.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我"
                                                                     image:[[UIImage imageNamed:@"lab_my_d"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                             selectedImage:[[UIImage imageNamed:@"lab_my_s"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
    }
    return _meViewController;
}

@end
