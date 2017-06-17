//
//  GoodLookTrendingViewController.m
//  66GoodLook
//
//  Created by Yanci on 17/4/11.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import "GoodLookDynamicViewController.h"
#import "GLRefreshHeader.h"
#import "GLRefreshFooter.h"
#import "GLDynamicTableViewCell.h"

static NSString *const CellDynamicIdentifier = @"CellDynamicIdentifier";

@interface GoodLookDynamicViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tableView;
@end

@implementation GoodLookDynamicViewController {
    BOOL _needsReload;
    struct {
    }_datasourceHas;
    
    struct{
    }_delegateHas;
}


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

- (void)viewWillLayoutSubviews {
    [self _reloadDataIfNeed];
    [self _layoutSubviews];
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GLDynamicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellDynamicIdentifier];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}

#pragma mark - delegate
#pragma mark - user events
#pragma mark - functions

- (void)commonInit {
    self.tableView.frame = self.view.bounds;
    [self.view addSubview:self.tableView];
}


- (void)headerRefresh {
    
}

- (void)footerRefresh {
    
}


- (void)reloadData {
    
}

- (void)_setNeedsReload {
    _needsReload = YES;
    [self.view setNeedsLayout];
}

- (void)_reloadDataIfNeed {
    if (_needsReload) {
        [self reloadData];
    }
}

- (void)_layoutSubviews {
    self.tableView.frame = self.view.bounds;
}

- (void)setDataSource:(id<GoodLookDynamicViewControllerDataSource>)dataSource {
    
}

- (void)setDelegate:(id<GoodLookDynamicViewControllerDelegate>)delegate {
    
}

#pragma mark - notification
#pragma mark - getter and setter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.mj_header = [GLRefreshHeader headerWithRefreshingBlock:^{
//            [self headerRefresh];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [_tableView.mj_header endRefreshing];
            });
        }];
        [_tableView registerClass:[GLDynamicTableViewCell class] forCellReuseIdentifier:CellDynamicIdentifier];
    }
    return _tableView;
}

@end
