//
//  GLDynamicTableViewCell.h
//  666
//
//  Created by Yanci on 2017/6/17.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol GLDynamicTableViewCellDataSource <NSObject>
@end

@protocol GLDynamicTableViewCellDelegate <NSObject>
@end

@interface GLDynamicTableViewCell : UITableViewCell
@property (nonatomic,strong) UIImageView *avatarImageView; /* 头像 */
@property (nonatomic,strong) UILabel *titleLabel;          /* 标题 */
@property (nonatomic,strong) UILabel *timeLabel;           /* 发布时间 */
@property (nonatomic,strong) UILabel *detailTitleLabel;    /* 详细标题 */
@property (nonatomic,strong) UIButton *commentBtn;         /* 评论按钮 */
@property (nonatomic,strong) UIButton *likeBtn;            /* 点赞按钮 */

@property (nonatomic,weak) id<GLDynamicTableViewCellDataSource>dataSource;
@property (nonatomic,weak) id<GLDynamicTableViewCellDelegate>delegate;

- (void)reloadData;
@end
