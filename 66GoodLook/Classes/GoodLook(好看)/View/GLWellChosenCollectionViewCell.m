//
//  GLWellChosenCollectionViewCell.m
//  666
//
//  Created by Yanci on 17/6/1.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import "GLWellChosenCollectionViewCell.h"

static const CGFloat kConverImageViewHeight  =  170.0;

@interface GLWellChosenCollectionViewCell()

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
        [self commonInit];
    }
    return self;
}

- (void)layoutSubviews {
    [self _reloadDataIfNeeded];
    [self _layoutSubviews];
    [super layoutSubviews];
}

#pragma mark - datasource
#pragma mark - delegate
#pragma mark - user events
#pragma mark - functions


- (void)commonInit {
    [self.contentView addSubview:self.coverImageView];
    [self.contentView addSubview:self.avatarImageView];
    [self.contentView addSubview:self.nicknameLabel];
    [self.contentView addSubview:self.recommendDescLabel];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
//    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.contentView.mas_left).offset(0);
//        make.right.mas_equalTo(self.contentView.mas_right).offset(0);
//        make.top.mas_equalTo(self.contentView.mas_top).offset(0);
//        make.height.offset(kConverImageViewHeight);
//    }];
//    
//    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.coverImageView.mas_bottom).offset(-10);
//        make.height.offset(35.0);
//        make.width.offset(35.0);
//        make.left.mas_equalTo(self.contentView.mas_left).offset(10);
//    }];
    
    ///Method 1: set cornerRadius and masksToBounds will cause off-screen
//        self.avatarImageView.layer.cornerRadius = 35.0 / 2.0;
//        self.avatarImageView.layer.masksToBounds = YES;
//        self.avatarImageView.layer.borderColor = [UIColor whiteColor].CGColor;
//        self.avatarImageView.layer.borderWidth = 1.0;
    
    /// Method 2: use zy pod for adding corner , it test ok
    [self.avatarImageView zy_attachBorderWidth:1.0 color:[UIColor whiteColor]];
    [self.avatarImageView zy_cornerRadiusAdvance:35.0 / 2.0 rectCornerType:UIRectCornerAllCorners];
    
    
//    [self.nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.avatarImageView.mas_right).offset(10);
//        make.top.mas_equalTo(self.coverImageView.mas_bottom).offset(5.0);
//    }];
//    
//    [self.recommendDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.contentView.mas_left).offset(10);
//        make.top.mas_equalTo(self.avatarImageView.mas_bottom).offset(5);
//        make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
//    }];
    
    [self setNeedsReload];
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

- (void)_layoutSubviews {
    self.coverImageView.frame = CGRectMake(0,
                                           0,
                                           CGRectGetWidth(self.contentView.frame),
                                           kConverImageViewHeight);
    [self.avatarImageView sizeWith:CGSizeMake(35.0, 35.0)];
    [self.avatarImageView alignParentLeftWithMargin:10.0];
    [self.avatarImageView layoutBelow:self.coverImageView margin:-10.0];
    
    
    [self.nicknameLabel sizeToFit];
    [self.nicknameLabel layoutToRightOf:self.avatarImageView margin:10.0];
    [self.nicknameLabel layoutBelow:self.coverImageView margin:5.0];
    [self.nicknameLabel marginParentRight:10];
    
    [self.recommendDescLabel sizeWith:CGSizeMake(0, 40)];
    [self.recommendDescLabel layoutBelow:self.avatarImageView margin:3.0];
    [self.recommendDescLabel marginParentLeft:10.0];
    [self.recommendDescLabel marginParentRight:10.0];
}

- (void)reloadData {}
- (void)setFrame:(CGRect)frame { [super setFrame:frame];}
#pragma mark - notification
#pragma mark - getter and setter

- (UIImageView *)coverImageView {
    if (!_coverImageView) {
        _coverImageView = [[UIImageView alloc]init];
        _coverImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _coverImageView;
}

- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc]init];
        _avatarImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _avatarImageView;
}

- (UILabel *)nicknameLabel {
    if (!_nicknameLabel) {
        _nicknameLabel = [[UILabel alloc]init];
        _nicknameLabel.font = [UIFont systemFontOfSize:12.0];
        _nicknameLabel.textColor = [UIColor lightGrayColor];
        _nicknameLabel.backgroundColor = [UIColor whiteColor];
        _nicknameLabel.alpha = 1.0;
    }
    return _nicknameLabel;
}

- (UILabel *)recommendDescLabel {
    if (!_recommendDescLabel) {
        _recommendDescLabel = [[UILabel alloc]init];
        _recommendDescLabel.font = [UIFont systemFontOfSize:14.0];
        _recommendDescLabel.numberOfLines = 2;
        _recommendDescLabel.backgroundColor = [UIColor whiteColor];
        _recommendDescLabel.alpha = 1.0;
    }
    return _recommendDescLabel;
}

@end
