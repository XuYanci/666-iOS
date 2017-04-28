//
//  GLPickPictureCollectionView.m
//  66GoodLook
//
//  Created by Yanci on 17/4/20.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import "GLPickPictureView.h"
#import "GLPickPicVidViewCollectionViewCell.h"

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
    [self addSubview:_choosePicLabel];
    
    [_choosePicLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.centerY.mas_equalTo(self.mas_centerY).offset(0);
    }];
    
    _moreBtn = [[UIButton alloc]init];
    [_moreBtn setTitle:@"更多" forState:UIControlStateNormal];
    _moreBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [_moreBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
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


@interface GLPickPictureView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)UICollectionViewLayout *collectionViewLayout;
@property (nonatomic,strong)GLPickPictureHeaderView *headerView;
@end

@implementation GLPickPictureView {
    BOOL _needsReload;  /*! 需要重载 */
    struct {
    }_datasourceHas;    /*! 数据源存在标识 */
    struct {
    }_delegateHas;      /*! 数据委托存在标识 */
}

#pragma mark - life cycle
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
        [self setNeedsReload];
    }
    return self;
}

- (void)layoutSubviews {
    [self _reloadDataIfNeeded];
    [self.collectionView sizeWith:CGSizeMake([UIScreen mainScreen].bounds.size.width,
                                             self.bounds.size.height - kPickPictureCollectionViewHeaderHeight)];
    [self.collectionView alignParentBottom];
    [self.headerView sizeWith:CGSizeMake([UIScreen mainScreen].bounds.size.width, kPickPictureCollectionViewHeaderHeight)];
    [self.headerView alignParentTop];
    [super layoutSubviews];
}

#pragma mark - datasource

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GLPickPicVidViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kPickPictureCollectionViewCellIdentifier forIndexPath:indexPath];
    [cell setPickPicVidCVType:GLPickPicVidType_Pic]; 
    return cell;
}

#pragma mark - delegate

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - user events
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
    }
}
- (void)reloadData {}
- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
}
#pragma mark - notification
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


@end
