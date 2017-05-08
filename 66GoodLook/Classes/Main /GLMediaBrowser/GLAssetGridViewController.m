//
//  GLMediaPickerViewController.m
//  66GoodLook
//
//  Created by Yanci on 17/5/3.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import <Photos/Photos.h>
#import "GLAssetGridViewController.h"
#import "GLPickPicVidViewCollectionViewCell.h"

static NSString *const kGLPickPicVidViewCollectionViewCellIdentifier = @"kGLPickPicVidViewCollectionViewCellIdentifier";

@interface GLAssetGridViewController ()<UICollectionViewDataSource,
                                        UICollectionViewDelegate,GLPickPicVidViewCollectionViewCellDelegate,GLPickPicVidViewCollectionViewCellDataSource>
@property (nonatomic,strong) UICollectionView  *collectionView;
@property (nonatomic,strong)PHFetchResult<PHAsset *> *allPhotos;
@property (nonatomic,strong)PHCachingImageManager *imageManager;
@property (nonatomic,assign)CGRect previousPreheatRect;
@property (nonatomic,assign)CGSize thumbnailSize;
@property (nonatomic,strong)NSMutableDictionary *selectedStatusDict;
@end

@implementation GLAssetGridViewController {
    BOOL _needsReload;  /*! 需要重载 */
    struct {
    }_datasourceHas;    /*! 数据源存在标识 */
    struct {
    }_delegateHas;      /*! 数据委托存在标识 */
    NSUInteger _selectedCount;
}

#pragma mark - life cycle

- (id)init {
    if (self = [super init]) {
        [self commonInit];
        [self _setNeedsReload];
    }
    return self;
}

- (void)loadView {
    self.view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
}

- (void)viewWillLayoutSubviews {
    self.collectionView.frame = self.view.bounds;
    [self _reloadDataIfNeed];
    [self _layoutSubviews];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 

#pragma mark - datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.allPhotos.count + 1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GLPickPicVidViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kGLPickPicVidViewCollectionViewCellIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    cell.dataSource = self;
    
    NSNumber *selected =  [self.selectedStatusDict objectForKey:@(indexPath.row)];
    
    if (!selected || selected.intValue == 0) {
        [cell setTickBtnSelected:FALSE];
    }
    else if(selected && selected.intValue == 1) {
        [cell setTickBtnSelected:YES];
    }
    
    
    if (self.pickerType == GLAssetGridType_Picture) {
        [cell setPickPicVidCVType:GLPickPicVidCVType_Pic];
        if (indexPath.row == 0) {
            [cell setPickPicVidCVType:GLPickPicVidCVType_TakePic];
            [cell setImage:[UIImage imageNamed:@"ft_pic_icon_img"]];
            return cell;
        }
        
    }
    else if(self.pickerType == GLAssetGridType_Video) {
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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self updateCachedAssets];
}

#pragma mark - GLPickPicVidViewCollectionViewCellDataSource

- (NSUInteger)glPickPicVideViewCVCNumberOfSelectedItems {
    return _selectedCount;
}

#pragma mark - GLPickPicVidViewCollectionViewCellDelegate
- (void)glPickPicVidViewCVCDidSelected:(id)sender {
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
    if (indexPath.row == 0 && self.pickerType == GLAssetGridType_Picture) {
        NSLog(@"take pic");
    }
    else if(indexPath.row == 0 && self.pickerType == GLAssetGridType_Video) {
        NSLog(@"take video");
    }
    else {
        __weak typeof(self) weakSelf = self;
        PHAsset *asset = [self.allPhotos objectAtIndex:indexPath.row - 1];
        [self.imageManager requestImageForAsset:asset
                                     targetSize:self.thumbnailSize
                                    contentMode:PHImageContentModeAspectFit
                                        options:nil
                                  resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                                      __strong typeof(self)strongSelf = weakSelf;
                               
                                  }];
        
        _selectedCount += 1;
        [self.selectedStatusDict setObject:@(1) forKey:@(indexPath.row)];
    }
    
}

- (void)glPickPicVidViewCVCDidUnSelected:(id)sender {
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
    if (indexPath.row == 0 && self.pickerType == GLAssetGridType_Picture) {
        NSLog(@"take pic");
    }
    else if(indexPath.row == 0 && self.pickerType == GLAssetGridType_Video) {
        NSLog(@"take video");
    }
    else {
        __weak typeof(self) weakSelf = self;
        PHAsset *asset = [self.allPhotos objectAtIndex:indexPath.row - 1];
        [self.imageManager requestImageForAsset:asset
                                     targetSize:self.thumbnailSize
                                    contentMode:PHImageContentModeAspectFit
                                        options:nil
                                  resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                                      __strong typeof(self)strongSelf = weakSelf;
                                    
                                  }];
        
        _selectedCount -= 1;
        [self.selectedStatusDict setObject:@(0) forKey:@(indexPath.row)];
    }
    
}


#pragma mark - user events
#pragma mark - functions

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)commonInit {
    if (self.pickerType == GLAssetGridType_Picture) {
        self.title = @"全部相册";
    }
    else if(self.pickerType == GLAssetGridType_Video) {
        self.title = @"全部视频";
    }
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];

}

- (void)setDataSource:(id<GLAssetGridViewControllerDataSource>)dataSource {
    
}

- (void)setDelegate:(id<GLAssetGridViewControllerDelegate>)delegate {
    
}

/**
 * 重新加载数据
 */
- (void)_setNeedsReload {
    _needsReload = YES;
    [self.view setNeedsLayout];
}

/**
 按需重新加载数据
 */
- (void)_reloadDataIfNeed {
    if (_needsReload) {
        [self reloadData];
    }
}

/** 视图布局 */
- (void)_layoutSubviews {
    self.collectionView.frame = self.view.bounds;
}


/**
 重载数据
 */
- (void)reloadData {
    PHFetchOptions *allPhotosOptions = [[PHFetchOptions alloc]init];
    
    if (self.pickerType == GLAssetGridType_Video) {
        allPhotosOptions.predicate = [NSPredicate predicateWithFormat:@"mediaType = %d",PHAssetMediaTypeVideo];
        
    }
    else if(self.pickerType == GLAssetGridType_Picture) {
        allPhotosOptions.predicate = [NSPredicate predicateWithFormat:@"mediaType = %d",PHAssetMediaTypeImage];
        
    }
    
    allPhotosOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:false]];
    _allPhotos = [PHAsset fetchAssetsWithOptions:allPhotosOptions];
    [[PHPhotoLibrary sharedPhotoLibrary]registerChangeObserver:self];
    [self resetCachedAssets];
    
    self.collectionView.userInteractionEnabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self updateCachedAssets];
        self.collectionView.userInteractionEnabled = YES;
    });
    
    if (self.pickerType == GLAssetGridType_Picture) {
        self.title = @"全部相册";
    }
    else if(self.pickerType == GLAssetGridType_Video) {
        self.title = @"全部视频";
    }
}


#pragma mark - Asset Caching

- (void)resetCachedAssets {
    [self.imageManager stopCachingImagesForAllAssets];
}

- (void)updateCachedAssets {
    
    CGRect visibleRect = CGRectMake(self.collectionView.contentOffset.x,
                                    self.collectionView.contentOffset.y,
                                    self.collectionView.bounds.size.width,
                                    self.collectionView.bounds.size.height);
    CGRect preheatRect = CGRectInset(visibleRect, 0,-0.5 * visibleRect.size.height);
    CGFloat delta = fabs(CGRectGetMidY(preheatRect) - CGRectGetMidY(_previousPreheatRect));
    if (delta <= self.view.bounds.size.height / 3.0) {
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
        if (CGRectGetMaxY(new) > CGRectGetMaxY(old)) {
            CGRect added = CGRectMake(new.origin.x,CGRectGetMaxY(old),
                                      new.size.width,
                                      CGRectGetMaxY(new) - CGRectGetMaxY(old));
            [addedArray addObject:[NSValue valueWithCGRect:added]];
        }
        if (CGRectGetMinY(old) > CGRectGetMinY(new)) {
            CGRect added = CGRectMake(new.origin.x,
                                      CGRectGetMinY(new),new.size.width,
                                      CGRectGetMinY(old) - CGRectGetMinY(new));
            [addedArray addObject:[NSValue valueWithCGRect:added]];
        }
        
        NSMutableArray *removedArray = [NSMutableArray array];
        if (CGRectGetMaxY(new) < CGRectGetMaxY(old)) {
            CGRect removed = CGRectMake(new.origin.x,CGRectGetMaxY(new),new.size.width,
                                        CGRectGetMaxY(old) - CGRectGetMaxY(new));
            [removedArray addObject:[NSValue valueWithCGRect:removed]];
        }
        if (CGRectGetMinY(old) < CGRectGetMinY(new)) {
            CGRect removed = CGRectMake(new.origin.x,CGRectGetMinY(old),new.size.width,
                                        CGRectGetMinY(new) - CGRectGetMinY(old));
            [removedArray addObject:[NSValue valueWithCGRect:removed]];
        }
        
        return @[addedArray,removedArray];
    }
    return @[@[[NSValue valueWithCGRect:new]],@[[NSValue valueWithCGRect:old]]];
}

#pragma mark - notification
#pragma mark - getter and setter
- (UICollectionViewFlowLayout *)flowLayout:(CGFloat)left
                              paddingRight:(CGFloat)right
                                paddingTop:(CGFloat)top
                             paddingBottom:(CGFloat)bottom
                                cellHeight:(CGFloat)height
                               cellSpacing:(CGFloat)cellSpacing
                                 cellCount:(NSUInteger)cellCount {
    UICollectionViewFlowLayout *_flowLayout = nil;
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc]init];
        CGFloat itemwidth = floor((([UIScreen mainScreen].bounds.size.width - right - left - ((cellSpacing ) * (cellCount - 1) )) / cellCount)) ;
        CGFloat itemheight = height;
        
        if (cellCount == 0) {
            itemwidth = itemheight;
        }
        
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
        CGFloat height = ([UIScreen mainScreen].bounds.size.width - 10.0 * 5) / 4.0;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero
                                            collectionViewLayout:[self flowLayout:10.0 paddingRight:10.0 paddingTop:10.0 paddingBottom:10.0 cellHeight:height cellSpacing:10.0 cellCount:0]];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[GLPickPicVidViewCollectionViewCell class] forCellWithReuseIdentifier:kGLPickPicVidViewCollectionViewCellIdentifier];
    }
    return _collectionView;
}

- (NSMutableDictionary *)selectedStatusDict {
    if (!_selectedStatusDict) {
        _selectedStatusDict = [NSMutableDictionary dictionary];
    }
    return _selectedStatusDict;
}

- (PHCachingImageManager *)imageManager {
    if (!_imageManager) {
        _imageManager = [[PHCachingImageManager alloc]init];
    }
    return _imageManager;
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
