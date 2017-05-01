//
//  GLPickPictureViewCollectionView.m
//  66GoodLook
//
//  Created by Yanci on 17/4/28.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import "GLPickPicVidViewCollectionViewCell.h"

@interface GLPickPicVidViewCollectionViewCell()
@property (nonatomic,strong) UIImageView *pictureImageView;
@property (nonatomic,strong) UIButton *tickBtn;
@end

@implementation GLPickPicVidViewCollectionViewCell {
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
    
    if (self.pickPicVidCVType == GLPickPicVidCVType_TakePic) {
        self.tickBtn.hidden = YES;
        [self.pictureImageView sizeWith:CGSizeMake(30, 30)];
        [self.pictureImageView alignParentCenter];
        self.contentView.backgroundColor = [UIColor yellowColor];
    }
    else if(self.pickPicVidCVType == GLPickPicVidCVType_TakeVid) {
        self.tickBtn.hidden = YES;
        [self.pictureImageView sizeWith:CGSizeMake(30, 30)];
        [self.pictureImageView alignParentCenter];
        self.contentView.backgroundColor = [UIColor yellowColor];
    }
    else {
        self.tickBtn.hidden = NO;
        self.pictureImageView.frame = self.contentView.bounds;
        [self.tickBtn sizeWith:CGSizeMake(30, 30)];
        [self.tickBtn alignParentRightWithMargin:10.0];
        [self.tickBtn alignParentTopWithMargin:10.0];
        self.contentView.backgroundColor = [UIColor clearColor];
    }
}

#pragma mark - datasource
#pragma mark - delegate
#pragma mark - user events
- (void)tick:(id)sender {
    self.tickBtn.selected = !self.tickBtn.selected;
}

#pragma mark - functions
- (void)commonInit {
    [self.contentView addSubview:self.pictureImageView];
    [self.contentView addSubview:self.tickBtn];
  
    [self.tickBtn setImage:[UIImage imageNamed:@"ft_pic_icon_wrong"] forState:UIControlStateNormal];
    [self.tickBtn setImage:[UIImage imageNamed:@"ft_pic_icon_dui"] forState:UIControlStateSelected];
//    [self.tickBtn addTarget:self action:@selector(tick:) forControlEvents:UIControlEventTouchUpInside];
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
- (void)reloadData {}
- (void)setFrame:(CGRect)frame { [super setFrame:frame];}

- (void)setImage:(UIImage *)image {
    _image = image;
    [self.pictureImageView setImage:_image];
}

- (void)setPickPicVidCVType:(GLPickPicVidCVType)pickPicVidCVType {
    _pickPicVidCVType = pickPicVidCVType;
    [self setNeedsReload];
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    self.tickBtn.selected = selected;
}

#pragma mark - notification
#pragma mark - getter and setter

- (UIImageView *)pictureImageView {
    if (!_pictureImageView) {
        _pictureImageView = [[UIImageView alloc]init];
        _pictureImageView.backgroundColor = [UIColor whiteColor];
    }
    return _pictureImageView;
}

- (UIButton *)tickBtn {
    if (!_tickBtn) {
        _tickBtn = [[UIButton alloc]init];
        _tickBtn.userInteractionEnabled = NO;
    }
    return _tickBtn;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
