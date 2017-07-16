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

/**
 计算高度
 @param detailTitle 详细标题
 @param images 图片Url集合
 @param type 类型 图片、视频等
 @return 返回列表行高度
 */
+ (CGFloat)estimateHeight:(NSString *)detailTitle images:(NSArray *)images type:(NSUInteger)type;
- (void)setDynamicImages:(NSArray *)images;
- (void)reloadData;

/**
 计算图片占用宽度

 @param imagesCount 图片个数
 @return 图片占用宽度
 */
- (NSArray*)rectsForImages:(NSUInteger)imageCount;


@end
