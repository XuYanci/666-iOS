//
//  GoodLookWellChosenViewController.h
//  66GoodLook
//
//  Created by Yanci on 17/4/11.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    GoodLookScrollDirection_None,
    GoodLookScrollDirection_Up,
    GoodLookScrollDirection_Down,
} GoodLookScrollDirection;


@protocol GoodLookWellChosenViewControllerDataSource <NSObject>
@end

@protocol GoodLookWellChosenViewControllerDelegate <NSObject>
@end

@interface GoodLookWellChosenViewController : UIViewController
@property (nonatomic,strong)GLGetDefaultTopicListModel *model;
@property (nonatomic,weak) id<GoodLookWellChosenViewControllerDataSource>dataSource;
@property (nonatomic,weak) id<GoodLookWellChosenViewControllerDelegate>delegate;
 
- (void)reloadData;
- (void)resetScrollDirection:(GoodLookScrollDirection)direction;

@end
