//
//  GLDynamicTableViewCell.m
//  666
//
//  Created by Yanci on 2017/6/17.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import "GLDynamicTableViewCell.h"

@interface GLDynamicTableViewCell()
@property (nonatomic,strong) UIView *imageContainer;       /* 图片容器 */
@end


@implementation GLDynamicTableViewCell {
    BOOL _needsReload;  /*! 需要重载 */
    struct {
    }_datasourceHas;    /*! 数据源存在标识 */
    struct {
    }_delegateHas;      /*! 数据委托存在标识 */
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - life cycle

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
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
    [self.contentView addSubview:self.avatarImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.detailTitleLabel];
    [self.contentView addSubview:self.imageContainer];
    [self.contentView addSubview:self.likeBtn];
    [self.contentView addSubview:self.commentBtn];
    
    [self setNeedsReload];
}

- (void)setDataSource:(id<GLDynamicTableViewCellDataSource>)dataSource {
    
}

- (void)setDelegate:(id<GLDynamicTableViewCellDelegate>)delegate {
    
}

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
    [self.avatarImageView sizeWith:CGSizeMake(35, 35)];
    [self.avatarImageView alignParentLeftWithMargin:10.0];
    [self.avatarImageView alignParentTopWithMargin:5.0];
    
    [self.timeLabel sizeToFit];
    [self.timeLabel alignParentRightWithMargin:10.0];
    [self.timeLabel alignParentTopWithMargin:5.0];
    
    [self.titleLabel sizeToFit];
    [self.titleLabel layoutToRightOf:self.avatarImageView margin:10.0];
    [self.titleLabel alignParentTopWithMargin:5.0];
    [self.titleLabel scaleToLeftOf:self.timeLabel margin:10.0];
    
    [self.detailTitleLabel sizeToFit];
    [self.detailTitleLabel layoutBelow:self.titleLabel margin:10.0];
    [self.detailTitleLabel alignLeft:self.titleLabel margin:0];
    [self.detailTitleLabel scaleToParentRightWithMargin:10.0];
}

- (void)reloadData {}
- (void)setFrame:(CGRect)frame { [super setFrame:frame];}
#pragma mark - notification
#pragma mark - getter and setter
- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc]init];
        [_avatarImageView setImage:[UIImage imageNamed:@"gj_img_logo"]];
    }
    return _avatarImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"微博热点";
    }
    return _titleLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.text = @"06-16";
    }
    return _timeLabel;
}

- (UILabel *)detailTitleLabel {
    if (!_detailTitleLabel) {
        _detailTitleLabel = [[UILabel alloc]init];
        _detailTitleLabel.text = @"GLViewPagerViewController is an common public control, it is usally used in news, here use UIPageViewController and UIScrollView as tab container to build it.";
        _detailTitleLabel.numberOfLines = 3;
    }
    return _detailTitleLabel;
}

- (UIButton *)commentBtn {
    if (!_commentBtn) {
        _commentBtn = [[UIButton alloc]init];
    }
    return _commentBtn;
}

- (UIButton *)likeBtn {
    if (!_likeBtn) {
        _likeBtn = [[UIButton alloc]init];
    }
    return _likeBtn;
}

- (UIView *)imageContainer {
    if (!_imageContainer) {
        _imageContainer = [[UIView alloc]init];
    }
    return _imageContainer;
}
@end
