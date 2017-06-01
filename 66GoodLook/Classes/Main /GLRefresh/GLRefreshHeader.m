//
//  GLRefreshHeader.m
//  666
//
//  Created by Yanci on 17/6/1.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import "GLRefreshHeader.h"

static NSString * kStringImagePath1 = @"xialashuaxin-icon-2";
static NSString * kStringImagePath2 = @"xialashuaxin-icon-3";
static NSString * kStringImagePath3 = @"xialashuaxin-icon-4";
static NSString * kStringImagePath4 = @"xialashuaxin-icon-5";
static NSString * kStringImagePath5 = @"xialashuaxin-icon-6";

@interface GLRefreshHeader()
@property (nonatomic,strong) UIView *contentView;                 /** 容器视图 */
@property (nonatomic,strong) UIImageView *backgroundView;         /** 背景视图 */
@property (nonatomic,strong) UIImageView *stringView;             /** 绳子视图 */
@end

@implementation GLRefreshHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)prepare
{
    [super prepare];
    
    [self beginRefreshingWithCompletionBlock:^{
        NSLog(@"animation begin");
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        animation.repeatCount = HUGE_VALF;
        animation.duration = 0.5;
        animation.autoreverses = YES;
        animation.fromValue = @(-M_PI_2 * 0.5);
        animation.toValue = @(M_PI_2 * 0.5);
        [self.stringView.layer addAnimation:animation forKey:@"justrotate"];
    }];
    
    [self endRefreshingWithCompletionBlock:^{
        NSLog(@"animation end");
        [self.stringView.layer removeAnimationForKey:@"justrotate"];
    }];
    
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.backgroundView];
    [self.contentView addSubview:self.stringView];
    
    [self.backgroundView setImage:[UIImage imageNamed:@"xialashuaxin-icon-1"]];
    [self.stringView setImage:[UIImage imageNamed:kStringImagePath1]];
    self.stringView.layer.anchorPoint = CGPointMake(0.5, 0.0);

    [self.backgroundView sizeToFit];
    self.mj_h = CGRectGetHeight(self.backgroundView.bounds) + 10.0;
}

- (void)placeSubviews
{
    [super placeSubviews];
    self.contentView.frame = self.bounds;
    self.backgroundView.frame = self.contentView.bounds;
    [self.stringView sizeToFit];
    [self.stringView setCenter:CGPointMake(60.0, CGRectGetHeight(self.stringView.bounds) / 2.0 - 20.0)];
}


#pragma mark - getter and setter
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
    }
    return _contentView;
}

- (UIImageView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIImageView alloc]init];
        _backgroundView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _backgroundView;
}

- (UIImageView *)stringView {
    if (!_stringView) {
        _stringView = [[UIImageView alloc]init];
        _stringView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _stringView;
}


@end
