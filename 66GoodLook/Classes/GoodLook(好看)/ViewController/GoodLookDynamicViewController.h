//
//  GoodLookTrendingViewController.h
//  66GoodLook
//
//  Created by Yanci on 17/4/11.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodLookDynamicViewController : UIViewController

/** 如果model是空的，则表示这是一个请求关注列表 */
@property (nonatomic,strong)GLGetDefaultTopicListModel *model;
@end
