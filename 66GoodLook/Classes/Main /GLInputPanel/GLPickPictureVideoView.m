//
//  GLPickPictureCollectionView.m
//  66GoodLook
//
//  Created by Yanci on 17/4/20.
//  Copyright © 2017年 Yanci. All rights reserved.
//
#import <Photos/Photos.h>
#import "GLPickPictureVideoView.h"
#import "GLPickPicVidViewCollectionViewCell.h"
#import "GLMediaBrowserViewController.h"

@interface GLPickPictureHeaderView : UIView
@property (nonatomic,strong)UILabel *choosePicLabel;
@property (nonatomic,strong)UIButton *moreBtn;
@end

@implementation GLPickPictureHeaderView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    _choosePicLabel = [[UILabel alloc]init];
    _choosePicLabel.font = [UIFont systemFontOfSize:12.0];
    _choosePicLabel.text = @"选择图片(0/4)";
    _choosePicLabel.textColor = [UIColor darkGrayColor];
    [self addSubview:_choosePicLabel];
    
    [_choosePicLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.centerY.mas_equalTo(self.mas_centerY).offset(0);
    }];
    
    _moreBtn = [[UIButton alloc]init];
    [_moreBtn setTitle:@"更多" forState:UIControlStateNormal];
    _moreBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [_moreBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_moreBtn addTarget:self action:@selector(clickMore:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_moreBtn];
    
    
    
    
    [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.centerY.mas_equalTo(self.mas_centerY).offset(0);
    }];
    
    self.backgroundColor = [UIColor whiteColor];
}

@end


/** 宏定义 */
static NSString *const kPickPictureCollectionViewCellIdentifier = @"pickPictureCollectioViewIdentifier";
static CGFloat const kPickPictureCollectionViewHeaderHeight = 44.0;


@interface GLPickPictureVideoView()<UICollectionViewDelegate,UICollectionViewDataSource,PHPhotoLibraryChangeObserver>
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)UICollectionViewLayout *collectionViewLayout;
@property (nonatomic,strong)GLPickPictureHeaderView *headerView;
@property (nonatomic,strong)PHFetchResult<PHAsset *> *allPhotos;
@property (nonatomic,strong)PHCachingImageManager *imageManager;
@property (nonatomic,assign)CGRect previousPreheatRect;
@property (nonatomic,assign)CGSize thumbnailSize;
@end

@implementation GLPickPictureVideoView {
    BOOL _needsReload;  /*! 需要重载 */
    struct {
    }_datasourceHas;    /*! 数据源存在标识 */
    struct {
    }_delegateHas;      /*! 数据委托存在标识 */
}

#pragma mark - life cycle

- (void)didMoveToSuperview {
  
}

- (void)didMoveToWindow {
    
}

- (void)willMoveToWindow:(UIWindow *)newWindow {
    
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
        [self setNeedsReload];
    }
    return self;
}

- (void)layoutSubviews {
    [self.collectionView sizeWith:CGSizeMake([UIScreen mainScreen].bounds.size.width,
                                             self.bounds.size.height - kPickPictureCollectionViewHeaderHeight)];
    [self.collectionView alignParentBottom];
    [self.headerView sizeWith:CGSizeMake([UIScreen mainScreen].bounds.size.width, kPickPictureCollectionViewHeaderHeight)];
    [self.headerView alignParentTop];
    
    [self _reloadDataIfNeeded];
    
    [super layoutSubviews];
}

#pragma mark - datasource

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.allPhotos.count + 1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    GLPickPicVidViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kPickPictureCollectionViewCellIdentifier forIndexPath:indexPath];
    if (self.type == GLPickPicVidType_Pic) {
        [cell setPickPicVidCVType:GLPickPicVidCVType_Pic];
        if (indexPath.row == 0) {
            [cell setPickPicVidCVType:GLPickPicVidCVType_TakePic];
            [cell setImage:[UIImage imageNamed:@"ft_pic_icon_img"]];
             return cell;
        }
       
    }
    else if(self.type == GLPickPicVidType_Vid) {
        [cell setPickPicVidCVType:GLPickPicVidCVType_Vid];
        if (indexPath.row == 0) {
            [cell setPickPicVidCVType:GLPickPicVidCVType_TakeVid];
            [cell setImage:[UIImage imageNamed:@"ft_pic_icon_camera"]];
            return cell;
        }
    }
    
    PHAsset *asset = [self.allPhotos objectAtIndex:indexPath.row - 1];
    [self.imageManager requestImageForAsset:asset
                                 targetSize:self.thumbnailSize
                                contentMode:PHImageContentModeAspectFit
                                    options:nil
                              resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        cell.image = result;
    }];
    return cell;
}

#pragma mark - delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self updateCachedAssets];
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - user events
- (void)clickMore:(id)sender {
    GLMediaBrowserViewController *browserViewController = [[GLMediaBrowserViewController alloc]init];
    if (self.type == GLPickPicVidType_Pic) {
        browserViewController.type = GLMediaBrowserType_Picture;
    }
    else if(self.type == GLPickPicVidType_Vid) {
        browserViewController.type = GLMediaBrowserType_Video;
    }
    [[AppDelegate shareInstance]pushViewController:browserViewController];
}

#pragma mark - functions


- (void)commonInit {
    [self addSubview:self.collectionView];
    [self addSubview:self.headerView];
}

- (void)setDataSource {}

- (void)setDelegate {}

- (void)setNeedsReload {
    _needsReload = YES;
    [self setNeedsLayout];
}
- (void)_reloadDataIfNeeded {
    if (_needsReload) {
        [self reloadData];
        _needsReload = NO;
    }
}
- (void)reloadData {
    PHFetchOptions *allPhotosOptions = [[PHFetchOptions alloc]init];
    
    if (self.type == GLPickPicVidType_Vid) {
        allPhotosOptions.predicate = [NSPredicate predicateWithFormat:@"mediaType = %d",PHAssetMediaTypeVideo];
        self.headerView.choosePicLabel.text = @"选择视频(0/1)";
    }
    else if(self.type == GLPickPicVidType_Pic) {
        allPhotosOptions.predicate = [NSPredicate predicateWithFormat:@"mediaType = %d",PHAssetMediaTypeImage];
        self.headerView.choosePicLabel.text = @"选择图片(0/4)";
    }
    
    allPhotosOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:false]];
    _allPhotos = [PHAsset fetchAssetsWithOptions:allPhotosOptions];
    [[PHPhotoLibrary sharedPhotoLibrary]registerChangeObserver:self];
    [self.collectionView reloadData];
    
    [self resetCachedAssets];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self updateCachedAssets];
        [self.collectionView reloadData];
    });
}
- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
}
#pragma mark - notification

#pragma mark - PHPhotoLibraryChangeObserver
- (void)photoLibraryDidChange:(PHChange *)changeInstance {
    
}


#pragma mark - Asset Caching

- (void)resetCachedAssets {
    [self.imageManager stopCachingImagesForAllAssets];
    _previousPreheatRect = CGRectZero;
    
}

- (void)updateCachedAssets {
    
    CGRect visibleRect = CGRectMake(self.collectionView.contentOffset.x,
                                    self.collectionView.contentOffset.y,
                                    self.collectionView.bounds.size.width,
                                    self.collectionView.bounds.size.height);
    CGRect preheatRect = CGRectInset(visibleRect, -0.5 * visibleRect.size.width, 0);
    CGFloat delta = fabs(CGRectGetMidX(preheatRect) - CGRectGetMidX(_previousPreheatRect));
    if (delta <= self.bounds.size.width / 3.0) {
        return;
    }
    
    NSArray *rectsArray = [self differencesBetweenRects:_previousPreheatRect
                                                    new:preheatRect];
    NSArray *addedRects = [rectsArray objectAtIndex:0];
    NSArray *removedRects = [rectsArray objectAtIndex:1];
  
    NSMutableArray *addedAssets = [NSMutableArray array];
    NSMutableArray *removedAssets = [NSMutableArray array];
    
    [addedRects enumerateObjectsUsingBlock:^(NSValue *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect rect = [obj CGRectValue];
        NSArray <UICollectionViewLayoutAttributes*> *array = [self.collectionView.collectionViewLayout layoutAttributesForElementsInRect:rect];
        [array enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            // becaues first item is an take photo item or take video item
            if (obj.indexPath.row >= 1) {
                [addedAssets addObject:[self.allPhotos objectAtIndex:obj.indexPath.row - 1]];
            }
        }];
    }];
    
    [removedRects enumerateObjectsUsingBlock:^(NSValue *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect rect = [obj CGRectValue];
        NSArray <UICollectionViewLayoutAttributes*> *array = [self.collectionView.collectionViewLayout layoutAttributesForElementsInRect:rect];
        [array enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            // becaues first item is an take photo item or take video item
            if (obj.indexPath.row >= 1) {
               [removedAssets addObject:[self.allPhotos objectAtIndex:obj.indexPath.row - 1]];
            }
        }];
    }];
    
    [self.imageManager startCachingImagesForAssets:addedAssets targetSize:_thumbnailSize contentMode:PHImageContentModeAspectFit options:nil];
    [self.imageManager stopCachingImagesForAssets:removedAssets targetSize:_thumbnailSize contentMode:PHImageContentModeAspectFit options:nil];
    _previousPreheatRect = preheatRect;
    
}

- (NSArray *)differencesBetweenRects:(CGRect)old new:(CGRect)new {
    if (CGRectIntersectsRect(old, new)) {
        
        NSMutableArray *addedArray = [NSMutableArray array];
        if (CGRectGetMaxX(new) > CGRectGetMaxX(old)) {
            CGRect added = CGRectMake(CGRectGetMaxX(old),
                               new.origin.y,
                               CGRectGetMaxX(new) - CGRectGetMaxX(old),
                               new.size.height);
            [addedArray addObject:[NSValue valueWithCGRect:added]];
        }
        if (CGRectGetMinX(old) > CGRectGetMinX(new)) {
            CGRect added = CGRectMake(CGRectGetMinX(new),
                                      new.origin.y,
                                      CGRectGetMinX(old) - CGRectGetMinX(new),
                                      new.size.height);
            [addedArray addObject:[NSValue valueWithCGRect:added]];
        }
        
        NSMutableArray *removedArray = [NSMutableArray array];
        if (CGRectGetMaxX(new) < CGRectGetMaxX(old)) {
           CGRect removed = CGRectMake(CGRectGetMaxX(new),
                                 new.origin.y,
                                 CGRectGetMaxX(old) - CGRectGetMaxX(new),
                                 new.size.height);
           [removedArray addObject:[NSValue valueWithCGRect:removed]];
        }
        if (CGRectGetMinX(old) < CGRectGetMinX(new)) {
            CGRect removed = CGRectMake(CGRectGetMinX(old),
                                        new.origin.y,
                                        CGRectGetMinX(new) - CGRectGetMinX(old),
                                        new.size.height);
            [removedArray addObject:[NSValue valueWithCGRect:removed]];
        }
        
        return @[addedArray,removedArray];
    }
    return @[@[[NSValue valueWithCGRect:new]],@[[NSValue valueWithCGRect:old]]];
}




#pragma mark - getter and setter


- (UICollectionViewLayout *)collectionViewLayout {
    if (!_collectionViewLayout) {
        _collectionViewLayout = [[UICollectionViewLayout alloc]init];
        
    }
    return _collectionViewLayout;
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
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _flowLayout;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:[self flowLayout:10.0 paddingRight:10.0 paddingTop:0.0 paddingBottom:0.0 cellHeight:140.0 cellSpacing:10.0 cellCount:4]];
        _collectionView.showsHorizontalScrollIndicator = YES;
        _collectionView.pagingEnabled = FALSE;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[GLPickPicVidViewCollectionViewCell class]
            forCellWithReuseIdentifier:kPickPictureCollectionViewCellIdentifier];
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

- (GLPickPictureHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[GLPickPictureHeaderView alloc]init];
    }
    return _headerView;
}

- (PHCachingImageManager *)imageManager {
    if (!_imageManager) {
        _imageManager = [[PHCachingImageManager alloc]init];
    }
    return _imageManager;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


@end
