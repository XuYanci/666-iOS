//
//  GoodLookFloatView.m
//  66GoodLook
//
//  Created by Yanci on 17/4/18.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import "GoodLookFloatView.h"

@interface GoodLookFloatView()

@end


@implementation GoodLookFloatView {
    BOOL _needsReload;
    struct {
    }_datasourceHas;
    struct {
    }_delegateHas;
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

- (void)commonInit {
    
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
    
}

#pragma mark - notification
#pragma mark - getter and setter



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
