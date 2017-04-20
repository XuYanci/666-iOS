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
@property (nonatomic,strong)UIButton *penBtn;
@property (nonatomic,strong)UIButton *picBtn;
@property (nonatomic,strong)UIButton *videoBtn;
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
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.superview];

    CGRect frame =  self.frame;
    frame.origin.x = point.x - 44.0;
    frame.origin.y = point.y - 44.0;
    self.frame = frame;
    

    /** 重置控制面板*/
    if (_panelOpen == YES) {
        _panelOpen = NO;
        [self closeEditPanel];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.superview];
    

    
    [UIView animateWithDuration:0.5
                          delay:0.0
         usingSpringWithDamping:0.7
          initialSpringVelocity:15.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
            [self updatePosition:point];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.superview];
    
 

    
    [UIView animateWithDuration:0.5
                          delay:0.0
         usingSpringWithDamping:0.7
          initialSpringVelocity:15.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         [self updatePosition:point];
                     } completion:^(BOOL finished) {
                         
                     }];
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
    
   
    [self insertSubview:self.videoBtn belowSubview:self.imageView];
    [self insertSubview:self.picBtn belowSubview:self.imageView];
    [self insertSubview:self.penBtn belowSubview:self.imageView];
    
    self.videoBtn.transform = CGAffineTransformRotate(CGAffineTransformIdentity,  -M_PI);
    self.picBtn.transform = CGAffineTransformRotate(CGAffineTransformIdentity,  -M_PI);
    self.penBtn.transform = CGAffineTransformRotate(CGAffineTransformIdentity,  -M_PI);
    [UIView animateWithDuration:0.5 animations:^{
        self.videoBtn.transform = CGAffineTransformRotate(CGAffineTransformIdentity,0);
        self.picBtn.transform = CGAffineTransformRotate(CGAffineTransformIdentity,0);
        self.penBtn.transform = CGAffineTransformRotate(CGAffineTransformIdentity,0);
        [self.videoBtn layoutAbove:self.imageView margin:20.0];
        [self.picBtn layoutAbove:self.videoBtn margin:20.0];
        [self.penBtn layoutAbove:self.picBtn margin:20.0];
    }];
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
    
    
    self.videoBtn.transform = CGAffineTransformRotate(CGAffineTransformIdentity,  0);
    self.picBtn.transform = CGAffineTransformRotate(CGAffineTransformIdentity,  0);
    self.penBtn.transform = CGAffineTransformRotate(CGAffineTransformIdentity,  0);
    [UIView animateWithDuration:0.5 animations:^{
        self.videoBtn.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI);
        self.picBtn.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI);
        self.penBtn.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI);
        [self.videoBtn sameWith:self.imageView];
        [self.picBtn sameWith:self.imageView];
        [self.penBtn sameWith:self.imageView];
        
    } completion:^(BOOL finished) {
        [self.videoBtn removeFromSuperview];
        [self.picBtn removeFromSuperview];
        [self.penBtn removeFromSuperview];
    }];
    

}

- (void)resetPosition {

    [self updatePosition:CGPointMake([UIScreen mainScreen].bounds.size.width, 0)];
}

- (void)updatePosition:(CGPoint)point {
    
    /* 悬浮点在右边 */
    if (point.x > [UIScreen mainScreen].bounds.size.width / 2.0) {
        CGRect frame =  self.frame;
        frame.origin.x = [UIScreen mainScreen].bounds.size.width  - 44.0 - 20.0;
        frame.origin.y = [UIScreen mainScreen].bounds.size.height  - 64.0 - 44.0 - 10.0;
        self.frame = frame;
    }
    /* 悬浮点在左边 */
    else {
        CGRect frame =  self.frame;
        frame.origin.x =  20.0;
        frame.origin.y = [UIScreen mainScreen].bounds.size.height  - 64.0 - 44.0 - 10.0;
        self.frame = frame;
    }
    
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

- (UIButton *)penBtn {
    if (!_penBtn) {
        _penBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44.0, 44.0)];
        [_penBtn setImage:[UIImage imageNamed:@"text_icon"] forState:UIControlStateNormal];
    }
    return _penBtn;
}

- (UIButton *)picBtn {
    if (!_picBtn) {
        _picBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44.0, 44.0)];
        [_picBtn setImage:[UIImage imageNamed:@"images_icon"] forState:UIControlStateNormal];
    }
    return _picBtn;
}

- (UIButton *)videoBtn {
    if (!_videoBtn) {
        _videoBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44.0, 44.0)];
        [_videoBtn setImage:[UIImage imageNamed:@"video_icon"] forState:UIControlStateNormal];
    }
    return _videoBtn;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
