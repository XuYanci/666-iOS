//
//  GLViewPagerViewController.m
//  66GoodLook
//
//  Created by Yanci on 17/4/11.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import "GLViewPagerViewController.h"

@interface GLViewPagerViewController ()
@property (nonatomic,strong)UIPageViewController *pageViewController;
@property (nonatomic,strong)NSMutableArray <UIViewController *>*contentViewControllers;
@property (nonatomic,strong)UIView *tabContentView;
@property (nonatomic,strong)NSMutableArray <UIView *>*tabViews;
@property (nonatomic,strong)UIView *indicatorView;
@end

@implementation GLViewPagerViewController


#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
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
#pragma mark - notification
#pragma mark - getter and setter


@end
