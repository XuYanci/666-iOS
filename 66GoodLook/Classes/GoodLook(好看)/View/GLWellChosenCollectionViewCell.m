//
//  GLWellChosenCollectionViewCell.m
//  666
//
//  Created by Yanci on 17/6/1.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import "GLWellChosenCollectionViewCell.h"

@interface GLWellChosenCollectionViewCell()
@property (nonatomic,strong) UIImageView *coverImageView;
@property (nonatomic,strong) UIImageView *avatarImageView;
@property (nonatomic,strong) UILabel *nicknameLabel;
@property (nonatomic,strong) UILabel *recommendDescLabel;
@end


@implementation GLWellChosenCollectionViewCell {
    BOOL _needsReload;  /*! 需要重载 */
    struct {
    }_datasourceHas;    /*! 数据源存在标识 */
    struct {
    }_delegateHas;      /*! 数据委托存在标识 */
}

#pragma mark - life cycle
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setNeedsReload];
    }
    return self;
}

- (void)layoutSubviews {
    [self _reloadDataIfNeeded];
    [super layoutSubviews];
}

#pragma mark - datasource
#pragma mark - delegate
#pragma mark - user events
#pragma mark - functions


- (void)commonInit {}

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
- (void)setFrame:(CGRect)frame { [super setFrame:frame];}
#pragma mark - notification
#pragma mark - getter and setter

@end
