//
//  GoodLookTrendingViewController.h
//  66GoodLook
//
//  Created by Yanci on 17/4/11.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    GoodLookDScrollDirection_None,
    GoodLookDScrollDirection_Up,
    GoodLookDScrollDirection_Down,
} GoodLookDScrollDirection;


@protocol GoodLookDynamicViewControllerDataSource <NSObject>
@end

@protocol GoodLookDynamicViewControllerDelegate <NSObject>
@end


@interface GoodLookDynamicViewController : UIViewController

@property (nonatomic,weak)id <GoodLookDynamicViewControllerDataSource>dataSource;
@property (nonatomic,weak)id <GoodLookDynamicViewControllerDelegate>delegate;
/** 如果model是空的，则表示这是一个请求关注列表 */
@property (nonatomic,strong)GLGetDefaultTopicListModel *model;

- (void)resetScrollDirection:(GoodLookDScrollDirection)direction;

@end
