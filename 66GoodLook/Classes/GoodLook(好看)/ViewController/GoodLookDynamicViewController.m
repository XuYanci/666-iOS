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
#import "GoodLookIndexViewController.h"
static NSString *const CellDynamicIdentifier = @"CellDynamicIdentifier";

@interface GoodLookDynamicViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dynamicList;       /** list data */
@property (nonatomic,strong)NSMutableArray *cacheCellRowHeights;
@end

@implementation GoodLookDynamicViewController {
    BOOL _needsReload;
    struct {
    }_datasourceHas;
    
    struct{
    }_delegateHas;
    
    NSString *_last_adSort;
    NSNumber *_last_attentionTimestamp;
    NSNumber *_last_timestamp;
    GoodLookDScrollDirection _scrollDirection;
}


#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self commonInit];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self headerRefresh];
    });
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
    return self.dynamicList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GLGetAttentionDynamicListResDynamicModel *listItemModel = [self.dynamicList objectAtIndex:indexPath.row];
    GLDynamicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellDynamicIdentifier];
    NSArray *imageRects = [cell rectsForImages:listItemModel.mediaList.count];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    NSString *avatarImageUrl = [GLQiniuImageHelper imageView2:GL_MEDIAURL_PREFIX
                                                    imagePath:listItemModel.headerUrl format:@"webp"
                                                      quality:@"60"
                                                        width:@"70"
                                                       height:@"70"];
    
    [cell.avatarImageView setImageWithURL:[NSURL URLWithString:avatarImageUrl]
                              placeholder:[UIImage imageNamed:@"gj_img_logo"]];
    cell.titleLabel.text = listItemModel.memberName;
    cell.detailTitleLabel.text = listItemModel.caption;
    
    
    NSMutableArray *imageList = [NSMutableArray array];
    
    /** Config images */
    if (listItemModel.type.intValue == 1) {
        
        
        [listItemModel.mediaList enumerateObjectsUsingBlock:^(GLGetAttentionDynamicListResMediaListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (obj.startY.intValue == 0 && obj.startX.intValue == 0) {
                if (idx < imageRects.count) {
                    NSValue *value = [imageRects objectAtIndex:idx];
                    CGRect rectForImage = value.CGRectValue;
                    
                    NSString *imageUrl = [GLQiniuImageHelper imageView2:GL_MEDIAURL_PREFIX
                                                              imagePath:obj.url
                                                                 format:@"webp"
                                                                quality:@"60"
                                                                  width:[NSString stringWithFormat:@"%.0f",(rectForImage.size.width)]                                                                 height:[NSString stringWithFormat:@"%.0f",(rectForImage.size.height)]];
                    [imageList addObject:[NSURL URLWithString:imageUrl]];

                }
            }
            else {
                if (idx < imageRects.count) {
                    
                    NSValue *value = [imageRects objectAtIndex:idx];
                    CGRect rectForImage = value.CGRectValue;
                    
                    NSString *imageUrl = [NSString stringWithFormat:@"%@/%@",GL_MEDIAURL_PREFIX,obj.url];
                         imageUrl =  [GLQiniuImageHelper imageMogr2:GL_MEDIAURL_PREFIX
                                                                   imagePath:obj.url
                                                                   cropWidth:obj.cropWidth.stringValue
                                                                  cropHeight:obj.cropHeight.stringValue
                                                                      startX:obj.startX.stringValue
                                                                      startY:obj.startY.stringValue
                                                                      format:@"webp"
                                                                     quality:@"60"
                                                              thumbnailWidth:[NSString stringWithFormat:@"%.0f",rectForImage.size.width]
                                                             thumbnailHeight:[NSString stringWithFormat:@"%.0f",rectForImage.size.height]];
                    [imageList addObject:[NSURL URLWithString:imageUrl]];
                }
            }
        }];
    }
    /* Config video */
    else if(listItemModel.type.intValue == 2) {
    }
    else {}
    
    [cell setDynamicImages:imageList];
    return cell;
}

#pragma mark - delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSNumber *cellHeight = [self.cacheCellRowHeights objectAtIndex:indexPath.row];
    return cellHeight.floatValue;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self autoHideNav:scrollView];
    [self autoRefresh:scrollView];
}


#pragma mark - user events
#pragma mark - functions

- (void)commonInit {
    self.tableView.frame = self.view.bounds;
    [self.view addSubview:self.tableView];
}


- (void)headerRefresh {
   GLGetDynamicListRequest *request = [[GLGetDynamicListRequest alloc]init];
    if (self.model) {
        request.topicId = self.model.ID.stringValue;
    }
    
    [MXNetworkConnection sendGetRequestWithMethod:self.model ? @"getDynamicList" : @"getAttentionDynamicList"
                                     requestModel:request
                                    responseClass:[GLGetDynamicListResponse class] beforeSendCallback:^{
                                        
    } SuccessCallBack:^(GLGetDynamicListResponse *result) {
        [self.dynamicList removeAllObjects];
        [self.dynamicList addObjectsFromArray:result.result.dynamic];
        
        [self.cacheCellRowHeights  removeAllObjects];
        [result.result.dynamic enumerateObjectsUsingBlock:^(GLGetAttentionDynamicListResDynamicModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.cacheCellRowHeights addObject:[NSNumber numberWithFloat:[self getCellRowHeightForModel:obj]]];
        }];
        
        self.tableView.mj_footer = [GLRefreshFooter footerWithRefreshingBlock:^{
            [self footerRefresh];
        }];
        
        GLGetAttentionDynamicListResDynamicModel *dynamic = self.dynamicList.lastObject;
        _last_adSort = result.result.adSort;
        _last_timestamp = self.model ? dynamic.updateDate :  dynamic.createDate;
        
    } ErrorCallback:^(NSError *error) {
        [self showHintHudWithMessage:error.localizedDescription];
    } CompleteCallback:^(NSError *error, id result) {
        [self.tableView.mj_header endRefreshing];
        
 
        [self.tableView reloadData];
        
    }];
}

- (void)footerRefresh {
 
    GLGetDynamicListRequest *request = [[GLGetDynamicListRequest alloc]init];
    if (!self.model) {
        request.timestamp = _last_timestamp;
    }
    else {
        request.timestamp = _last_timestamp;
        request.adSort = _last_adSort;
        request.topicId = self.model.ID.stringValue;
    }
    
    [MXNetworkConnection sendGetRequestWithMethod:self.model ? @"getDynamicList" : @"getAttentionDynamicList"
                                     requestModel:request
                                    responseClass:[GLGetDynamicListResponse class] beforeSendCallback:^{
                                        
    } SuccessCallBack:^(GLGetDynamicListResponse *result) {
        NSMutableArray *insertIndexPathes = [NSMutableArray array];
        NSUInteger beginIndexPath = self.dynamicList.count;
        NSUInteger endIndexPath = self.dynamicList.count + result.result.dynamic.count;
        
        for (NSUInteger i = beginIndexPath; i < endIndexPath; i++) {
            [insertIndexPathes addObject:[NSIndexPath indexPathForRow:i inSection:0]];
        }
        
        [self.dynamicList addObjectsFromArray:result.result.dynamic];
        [result.result.dynamic enumerateObjectsUsingBlock:^(GLGetAttentionDynamicListResDynamicModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.cacheCellRowHeights addObject:[NSNumber numberWithFloat:[self getCellRowHeightForModel:obj]]];
        }];
        
        
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:insertIndexPathes withRowAnimation:UITableViewRowAnimationNone];
        [self.tableView endUpdates];
        
        GLGetAttentionDynamicListResDynamicModel *dynamic = self.dynamicList.lastObject;
        _last_adSort = result.result.adSort;
        _last_timestamp = self.model ? dynamic.updateDate :  dynamic.createDate;
        
    } ErrorCallback:^(NSError *error) {
        [self showHintHudWithMessage:error.localizedDescription];
        
    } CompleteCallback:^(NSError *error, id result) {
        [self.tableView.mj_footer endRefreshing];
    }];
}


- (void)reloadData {
    
}
    
- (void)resetScrollDirection:(GoodLookDScrollDirection)direction {
    _scrollDirection = direction;
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

- (void)autoHideNav:(UIScrollView *)scrollView  {
    if ([scrollView.panGestureRecognizer translationInView:scrollView].y > 0) {
        if (_scrollDirection == GoodLookDScrollDirection_Down) {
        }
        else {
            _scrollDirection = GoodLookDScrollDirection_Down;
            [[NSNotificationCenter defaultCenter]postNotificationName:kNotificationShowNaviBar object:nil];
        }
    }
    else {
        if (_scrollDirection == GoodLookDScrollDirection_Up) {
            
        }
        else {
            _scrollDirection = GoodLookDScrollDirection_Up;
            [[NSNotificationCenter defaultCenter]postNotificationName:kNotificationHideNaviBar object:nil];
        }
    }
    
}

- (void)autoRefresh:(UIScrollView *)scrollView {
    float scrollViewHeight = scrollView.frame.size.height;
    float scrollContentSizeHeight = scrollView.contentSize.height;
    float scrollOffset = scrollView.contentOffset.y;
    
    if (scrollOffset == 0)
    {
        // then we are at the top
    }
    else if (scrollOffset + scrollViewHeight > scrollContentSizeHeight / 1.5)
    {
        // then we are at the end
        [self.tableView.mj_footer beginRefreshing];
    }
}

- (CGFloat)getCellRowHeightForModel:(GLGetAttentionDynamicListResDynamicModel *)listItemModel {
    /** Config images */
    NSMutableArray *imageList = [NSMutableArray array];
    if (listItemModel.type.intValue == 1) {
        [listItemModel.mediaList enumerateObjectsUsingBlock:^(GLGetAttentionDynamicListResMediaListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (obj.startY.intValue == 0 && obj.startX.intValue == 0) {
                NSString *imageUrl = [GLQiniuImageHelper imageView2:GL_MEDIAURL_PREFIX
                                                          imagePath:obj.url
                                                             format:@"webp"
                                                            quality:@"60"
                                                              width:obj.width.stringValue
                                                             height:obj.height.stringValue];
                [imageList addObject:[NSURL URLWithString:imageUrl]];
            }
            else {
                NSString *imageUrl =  [GLQiniuImageHelper imageMogr2:GL_MEDIAURL_PREFIX
                                                           imagePath:obj.url
                                                           cropWidth:obj.cropWidth.stringValue
                                                          cropHeight:obj.cropHeight.stringValue
                                                              startX:obj.startX.stringValue
                                                              startY:obj.startY.stringValue
                                                              format:@"webp"
                                                             quality:@"60"
                                                      thumbnailWidth:obj.width.stringValue
                                                     thumbnailHeight:obj.height.stringValue];
                [imageList addObject:[NSURL URLWithString:imageUrl]];
            }
        }];
    }
    /* Config video */
    else if(listItemModel.type.intValue == 2) {}
    else {}
    return [GLDynamicTableViewCell estimateHeight:listItemModel.caption
                                           images:imageList
                                             type:listItemModel.type.intValue];
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
            [self headerRefresh];
        }];
        [_tableView registerClass:[GLDynamicTableViewCell class] forCellReuseIdentifier:CellDynamicIdentifier];
    }
    return _tableView;
}

- (NSMutableArray *)dynamicList {
    if (!_dynamicList) {
        _dynamicList = [NSMutableArray array];
    }
    return _dynamicList;
}

- (NSMutableArray *)cacheCellRowHeights {
    if (!_cacheCellRowHeights) {
        _cacheCellRowHeights = [NSMutableArray array];
    }
    return _cacheCellRowHeights;
}

@end
