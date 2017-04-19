//
//  GoodLookFloatView.h
//  66GoodLook
//
//  Created by Yanci on 17/4/18.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GoodLookFloatViewDataSource <NSObject>
@end

@protocol GoodLookFloatViewDelegate <NSObject>
@end

/**
 悬浮视图
 */
@interface GoodLookFloatView : UIView
@property (nonatomic,weak)id <GoodLookFloatViewDataSource>dataSource;
@property (nonatomic,weak)id <GoodLookFloatViewDelegate>delegate;

/**
 重载数据
 */
- (void)reloadData;
@end
