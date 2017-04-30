//
//  GLPickPictureCollectionView.h
//  66GoodLook
//
//  Created by Yanci on 17/4/20.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GLChatInputAbleView.h"
#import "GLChatInputBaseView.h"

typedef enum : NSUInteger {
    GLPickPicVidType_Pic,
    GLPickPicVidType_Vid,
} GLPickPicVidType;

@protocol GLPickPictureCollectionViewDataSource <NSObject>
@end

@protocol GLPickPictureCollectionViewDelegate <NSObject>
@end

/*!
 @class GLPickPictureCollectionView
 
 @brief The UICollectionView class
 
 @discussion    图片选择器
 
 @superclass SuperClass: UICollectionView\n
 @classdesign    No special design is applied here.
 @coclass    None
 @helps It helps no other classes.
 @helper    No helper exists for this class.
 */
@interface GLPickPictureVideoView : UIView

@property (nonatomic,weak) id <GLPickPictureCollectionViewDelegate> delegate;
@property (nonatomic,weak) id <GLPickPictureCollectionViewDataSource> dataSource;
@property (nonatomic,assign) GLPickPicVidType type;
/**
 重载数据
 */
- (void)reloadData;
@end
