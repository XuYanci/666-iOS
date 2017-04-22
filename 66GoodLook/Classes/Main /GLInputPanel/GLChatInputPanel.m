//
//  GLChatInputPanel.m
//  66GoodLook
//
//  Created by Yanci on 17/4/20.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import "GLChatInputPanel.h"
#import "GLChatInputAbleView.h"
#import "GLChatInputToolBar.h"
#import "GLPickVideoCollectionView.h"
#import "GLPickPictureCollectionView.h"
#import "GLPickEmojView.h"
#import <Masonry/Masonry.h>

@interface GLChatInputPanel()<GLChatInputToolBarDelegate>
/** 工具栏 */
@property (nonatomic,strong) GLChatInputToolBar *toolbar;
/** 当前面板 */
@property (nonatomic,weak)  UIView<GLChatInputAbleView> *panel;
/** 视频选择器,作为Pannel */
@property (nonatomic,strong) UIView<GLChatInputAbleView> *pickVideoCollectionView;
/** 图片选择器,作为Pannel */
@property (nonatomic,strong) UIView<GLChatInputAbleView> *pickPictureCollectionView;
/** 表情选择器,作为Pannel */
@property (nonatomic,strong) UIView<GLChatInputAbleView> *pickEmojView;
/** **/
@property (nonatomic,strong) UIView *maskView;
/** 面板类型 */
@property (nonatomic,assign) GLChatInputPanelType panelType;
@end

@implementation GLChatInputPanel {
    BOOL _needsReload;  /*! 需要重载 */
    struct {
    }_datasourceHas;    /*! 数据源存在标识 */
    struct {
    }_delegateHas;      /*! 数据委托存在标识 */
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - life cycle


- (id)initWithPanelType:(GLChatInputPanelType)panelType {
    if (self = [super init]) {
        _panelType = panelType;
        self.frame = [UIScreen mainScreen].bounds;
        [self commonInit];
        [self setNeedsReload];
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _panelType = GLChatInputPanelType_Text;
        self.frame = [UIScreen mainScreen].bounds;
        [self commonInit];
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

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.maskView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
    [UIView animateWithDuration:0.5 animations:^{
        self.maskView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
    }];
}

- (void)dismiss {
    [self.toolbar endEditing:YES];
    self.maskView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
    [UIView animateWithDuration:0.5 animations:^{
        self.maskView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)commonInit {
    [self addSubview:self.maskView];
    [self addSubview:self.toolbar];
    
    if (self.panelType == GLChatInputPanelType_Text) {
        [self.toolbar setBarType:GLChatInputToolBarType_Default];
    }
    else if(self.panelType == GLChatInputPanelType_Image) {
        [self.toolbar setBarType:GLChatInputToolBarType_Pic];
    }
    else if(self.panelType == GLChatInputPanelType_Video) {
        [self.toolbar setBarType:GLChatInputToolBarType_Video];
    }
    
    [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(0);
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.top.mas_equalTo(self.mas_top).offset(0);
        make.bottom.mas_equalTo(self.mas_bottom).offset(0);
    }];
    
    
    [self.toolbar sizeWith:CGSizeMake([UIScreen mainScreen].bounds.size.width, 44.0)];
    [self.toolbar alignParentBottom];
    [self.toolbar alignParentRight];
    [self.toolbar alignParentLeft];
}

- (void)setDataSource:(id<GLChatInputPanelDataSource>)dataSource {}

- (void)setDelegate:(id<GLChatInputPanelDelegate>)delegate {}

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
- (GLChatInputToolBar *)toolbar {
    if (!_toolbar) {
        _toolbar = [[GLChatInputToolBar alloc]initWithBarType:GLChatInputToolBarType_Default];
        _toolbar.backgroundColor = [UIColor whiteColor];
    }
    return _toolbar;
}

- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc]init];
        _maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
        [_maskView addGestureRecognizer:tapGR];
    }
    return _maskView;
}

@end
