//
//  GLWellChosenCollectionViewCell.h
//  666
//
//  Created by Yanci on 17/6/1.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GLWellChosenCollectionViewCellDataSource <NSObject>

@end

@protocol GLWellChosenCollectionViewCellDelegate <NSObject>


@end

@interface GLWellChosenCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong) UIImageView *coverImageView;
@property (nonatomic,strong) UIImageView *avatarImageView;
@property (nonatomic,strong) UILabel *nicknameLabel;
@property (nonatomic,strong) UILabel *recommendDescLabel;

@property (nonatomic,weak) id<GLWellChosenCollectionViewCellDataSource>dataSource;
@property (nonatomic,weak) id<GLWellChosenCollectionViewCellDelegate>delegate;
- (void)reloadData;
@end
