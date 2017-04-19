//
//  GoodLookFloatView.m
//  66GoodLook
//
//  Created by Yanci on 17/4/18.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import "GoodLookFloatView.h"

@interface GoodLookFloatView()
@property (nonatomic,strong)NSArray *openPanelImageArray;
@property (nonatomic,strong)NSArray *closePanelImageArray;
@property (nonatomic,strong)UIImageView *imageView;
@end


@implementation GoodLookFloatView {
    BOOL _needsReload;
    BOOL _panelOpen;
    struct {
    }_datasourceHas;
    struct {
    }_delegateHas;
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
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
}

#pragma mark - datasource
#pragma mark - delegate
#pragma mark - user events

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

#pragma mark - functions

- (void)commonInit {
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                           action:@selector(controlPanel)];
    [self addGestureRecognizer:tapGR];
    [self addSubview:self.imageView];
    [self.imageView setImage:[UIImage imageNamed:@"ft_icon_01"]];
}

- (void)setDataSource {

}

- (void)setDelegate {

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

- (void)reloadData {
    
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
}

- (void)setImage:(UIImage *)image {
    
}

- (void)controlPanel {
    if (_panelOpen) {
        [self closeEditPanel];
    }
    else {
        [self openEditPanel];
    }
    _panelOpen = !_panelOpen;
}

/**
 打开编辑面板
 */
- (void)openEditPanel {
    [self.imageView setImage:[UIImage imageNamed:@"ft_icon_15"]];
    self.imageView.animationImages = self.openPanelImageArray;
    self.imageView.animationDuration = 1.0;
    self.imageView.animationRepeatCount = 1;
    [self.imageView startAnimating];
}

/**
 关闭编辑面板
 */
- (void)closeEditPanel {
     [self.imageView setImage:[UIImage imageNamed:@"ft_icon_01"]];
    self.imageView.animationImages = self.closePanelImageArray;
    self.imageView.animationDuration = 1.0;
    self.imageView.animationRepeatCount = 1;
    [self.imageView startAnimating];
}
#pragma mark - notification
#pragma mark - getter and setter
- (NSArray *)openPanelImageArray {
    if (!_openPanelImageArray) {
        _openPanelImageArray = @[
                                 [UIImage imageNamed:@"ft_icon_01"],
                                 [UIImage imageNamed:@"ft_icon_02"],
                                 [UIImage imageNamed:@"ft_icon_03"],
                                 [UIImage imageNamed:@"ft_icon_04"],
                                 [UIImage imageNamed:@"ft_icon_05"],
                                 [UIImage imageNamed:@"ft_icon_06"],
                                 [UIImage imageNamed:@"ft_icon_07"],
                                 [UIImage imageNamed:@"ft_icon_08"],
                                 [UIImage imageNamed:@"ft_icon_09"],
                                 [UIImage imageNamed:@"ft_icon_10"],
                                 [UIImage imageNamed:@"ft_icon_11"],
                                 [UIImage imageNamed:@"ft_icon_12"],
                                 [UIImage imageNamed:@"ft_icon_13"],
                                 [UIImage imageNamed:@"ft_icon_14"],
                                 [UIImage imageNamed:@"ft_icon_15"],
                                 ];
    }
    return _openPanelImageArray;
}

- (NSArray *)closePanelImageArray {
    if (!_closePanelImageArray) {
        _closePanelImageArray = @[
                                  [UIImage imageNamed:@"ft_icon_15"],
                                  [UIImage imageNamed:@"ft_icon_14"],
                                  [UIImage imageNamed:@"ft_icon_13"],
                                  [UIImage imageNamed:@"ft_icon_12"],
                                  [UIImage imageNamed:@"ft_icon_11"],
                                  [UIImage imageNamed:@"ft_icon_10"],
                                  [UIImage imageNamed:@"ft_icon_09"],
                                  [UIImage imageNamed:@"ft_icon_08"],
                                  [UIImage imageNamed:@"ft_icon_07"],
                                  [UIImage imageNamed:@"ft_icon_06"],
                                  [UIImage imageNamed:@"ft_icon_05"],
                                  [UIImage imageNamed:@"ft_icon_04"],
                                  [UIImage imageNamed:@"ft_icon_03"],
                                  [UIImage imageNamed:@"ft_icon_02"],
                                  [UIImage imageNamed:@"ft_icon_01"],
                                  
                                  ];
    }
    return _closePanelImageArray;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
    }
    return _imageView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
