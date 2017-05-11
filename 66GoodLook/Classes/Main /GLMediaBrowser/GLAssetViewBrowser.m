//
//  GLMediaBrowserViewController.m
//  66GoodLook
//
//  Created by Yanci on 17/4/28.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import "GLAssetViewBrowser.h"

@interface GLAssetCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong)UIImageView *imageView;
@end

@implementation GLAssetCollectionViewCell

- (void)layoutSubviews {
    self.imageView.frame = self.contentView.bounds;
    [super layoutSubviews];
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_imageView];
    }
    return _imageView;
}

@end


static NSString *const kCellIdentifier = @"cellIdentifier";

@interface GLAssetViewBrowser ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) UICollectionView *collectionView;
@end

@implementation GLAssetViewBrowser {
    BOOL _needsReload;  /*! 需要重载 */
    struct {
        unsigned numberOfItems:1;
        unsigned imageForItem:1;
        unsigned asyncImageForItem:1;
    }_datasourceHas;    /*! 数据源存在标识 */
    struct {
        unsigned didClickOnItemAtIndex:1;
    }_delegateHas;      /*! 数据委托存在标识 */
    
    NSUInteger _numbersOfItems;
}


#pragma mark - life cycle



- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.frame = [UIScreen mainScreen].bounds;
        [self commonInit];
        [self setNeedsReload];
    }
    return self;
}


- (void)layoutSubviews {
    self.collectionView.frame = self.bounds;
    [self _reloadDataIfNeeded];
    [self _layoutSubviews];
}



#pragma mark - datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_datasourceHas.numberOfItems) {
        _numbersOfItems = [_dataSource numberOfItemsInGLAssetViewController:self];
        return _numbersOfItems;
    }
    return 0;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GLAssetCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    if (_datasourceHas.imageForItem) {
        cell.imageView.image = [_dataSource imageForItemInGLAssetViewControllerAtIndex:indexPath.row];
    }
    if (_datasourceHas.asyncImageForItem) {
        [_dataSource asyncImageForItemInGLAssetViewControllerAtIndex:indexPath.row imageAsyncCallback:^(UIImage *image) {
            cell.imageView.image = image;
        }];
    }
    return cell;;
}

#pragma mark - delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_delegateHas.didClickOnItemAtIndex) {
        [_delegate glAssetViewController:self didClickOnItemAtIndex:indexPath.row];
    }
}


#pragma mark - user events
#pragma mark - functions

- (void)setDataSource:(id<GLAssetViewControllerDataSource>)dataSource {
    _dataSource = dataSource;
    if ([dataSource respondsToSelector:@selector(numberOfItemsInGLAssetViewController:)]) {
        _datasourceHas.numberOfItems= 1;
    }
    if ([dataSource respondsToSelector:@selector(imageForItemInGLAssetViewControllerAtIndex:)]) {
        _datasourceHas.imageForItem = 1;
    }
    if ([dataSource respondsToSelector:@selector(asyncImageForItemInGLAssetViewControllerAtIndex:imageAsyncCallback:)]) {
        _datasourceHas.asyncImageForItem = 1;
    }
}

- (void)setDelegate:(id<GLAssetViewControllerDelegate>)delegate {
    _delegate = delegate;
    if ([_delegate respondsToSelector:@selector(glAssetViewController:didClickOnItemAtIndex:)]) {
        _delegateHas.didClickOnItemAtIndex = 1;
    }
}

- (void)commonInit {
    [self addSubview:self.collectionView];
}

- (void)setNeedsReload {
    _needsReload = YES;
    [self  setNeedsLayout];
}
- (void)_reloadDataIfNeeded {
    if (_needsReload) {
        [self reloadData];
        _needsReload = NO;
    }
}

- (void)_layoutSubviews {
    self.collectionView.frame = self.bounds;
}

- (void)reloadData {
    __weak typeof(self)weakSelf = self;
    [self.collectionView setCollectionViewLayout:  [self flowLayout:0
                                                       paddingRight:0
                                                         paddingTop:0
                                                      paddingBottom:0
                                                         cellHeight:self.bounds.size.height
                                                        cellSpacing:0
                                                          cellCount:1] animated:NO completion:^(BOOL finished) {
        
    }];
    
    
    self.collectionView.contentInset = UIEdgeInsetsZero;
    [weakSelf.collectionView reloadData];
}


#pragma mark - notification
#pragma mark - getter and setter

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
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _flowLayout;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:
                           [self flowLayout:0
                               paddingRight:0
                                 paddingTop:0
                              paddingBottom:0
                                 cellHeight:[UIScreen mainScreen].bounds.size.height
                                cellSpacing:0
                                  cellCount:1]];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[GLAssetCollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifier];
    }
    return _collectionView;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
