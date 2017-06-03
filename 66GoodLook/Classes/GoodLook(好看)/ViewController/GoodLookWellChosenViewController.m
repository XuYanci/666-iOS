//
//  GoodLookWellChosenViewController.m
//  66GoodLook
//
//  Created by Yanci on 17/4/11.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import "GoodLookWellChosenViewController.h"
#import "GLWellChosenCollectionViewCell.h"
#import "GLRefreshHeader.h"
#import "GLRefreshFooter.h"

#define kCollectionViewBackgroundColor  [UIColor whiteColor]
static  NSString* const glWellChosenCollectionViewCellIdentifier  = @"glWellChosenCollectionViewCellIdentifier";
//static NSUInteger const listCountPerPage = 20;

@interface GoodLookWellChosenViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)UICollectionViewLayout *collectionViewLayout;
@property (nonatomic,strong)NSMutableArray *dynamicList;       /** list data */
@property (nonatomic,assign)NSUInteger pageIndex;       /** current page index */
@property (nonatomic,assign)NSUInteger countPerPage;    /** list count per page */
@end

@implementation GoodLookWellChosenViewController {
    BOOL _needsReload;
    struct {
    }_datasourceHas;
    
    struct{
    }_delegateHas;
    
    /** Request need params */
    NSString *_last_adSort;
    NSNumber *_last_attentionTimestamp;
    NSNumber *_last_timestamp;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self commonInit];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self headerRefresh];
    });
 
}

- (void)viewWillLayoutSubviews {
    
    [self _reloadDataIfNeed];
    [self _layoutSubviews];
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
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dynamicList.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GLWellChosenCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:glWellChosenCollectionViewCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor lightGrayColor];
    return cell;
}
#pragma mark - delegate


#pragma mark - funcs
- (void)headerRefresh {
    
    [MXNetworkConnection sendGetRequestWithMethod:@"getFineSelectionList" requestModel:nil responseClass:[GLGetFineSelectionListResponse class] beforeSendCallback:^{
        
    } SuccessCallBack:^(GLGetFineSelectionListResponse *result) {
        [self.dynamicList removeAllObjects];
        [self.dynamicList addObjectsFromArray:result.result.dynamic];
    } ErrorCallback:^(NSError *error) {
        [self showHintHudWithMessage:error.localizedDescription];
    } CompleteCallback:^(NSError *error, id result) {
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView reloadData];
    }];

}

- (void)footerRefresh {
    
}

- (void)commonInit {
    self.collectionView.frame = self.view.bounds;
    [self.view addSubview:self.collectionView];
    [self _setNeedsReload];
}


- (void)reloadData {
    [self.collectionView reloadData];
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
    self.collectionView.frame = self.view.bounds;
}

#pragma mark - getter and setter
- (NSMutableArray *)dynamicList {
    if (!_dynamicList) {
        _dynamicList = [NSMutableArray array];
    }
    return _dynamicList;
}

- (UICollectionViewFlowLayout *)flowLayout:(CGFloat)left
                              paddingRight:(CGFloat)right
                                paddingTop:(CGFloat)top
                             paddingBottom:(CGFloat)bottom
                                cellHeight:(CGFloat)height
                               cellSpacing:(CGFloat)cellSpacing cellCount:(NSUInteger)cellCount{
    UICollectionViewFlowLayout *_flowLayout = nil;
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc]init];
        CGFloat itemwidth = floor((([UIScreen mainScreen].bounds.size.width - right - left - ((cellSpacing ) * (cellCount - 1) )) / cellCount)) ;
        CGFloat itemheight = height;
        _flowLayout.itemSize = CGSizeMake(itemwidth, itemheight);
        _flowLayout.sectionInset = UIEdgeInsetsMake(top,
                                                    left,
                                                    bottom,
                                                    right);
        _flowLayout.minimumLineSpacing = (cellSpacing);
        _flowLayout.minimumInteritemSpacing = (cellSpacing);
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return _flowLayout;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:
                           [self flowLayout:10
                               paddingRight:10
                                 paddingTop:10
                              paddingBottom:10
                                 cellHeight:100.0
                                cellSpacing:10.0
                                  cellCount:2]];
        [_collectionView registerClass:[GLWellChosenCollectionViewCell class] forCellWithReuseIdentifier:glWellChosenCollectionViewCellIdentifier];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = kCollectionViewBackgroundColor;
        
        _collectionView.mj_header = [GLRefreshHeader headerWithRefreshingBlock:^{
            [self headerRefresh];
        }];

//        _collectionView.mj_footer = [GLRefreshFooter footerWithRefreshingBlock:^{
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [_collectionView.mj_footer endRefreshingWithNoMoreData];
//            });
//        }];
    }
    return _collectionView;
}

@end
