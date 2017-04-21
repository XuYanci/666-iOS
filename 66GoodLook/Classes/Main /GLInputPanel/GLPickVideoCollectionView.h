//
//  GLPickVideoCollectionView.h
//  66GoodLook
//
//  Created by Yanci on 17/4/20.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GLChatInputAbleView.h"
@protocol GLPickVideoCollectionViewDataSource <NSObject>
@end

@protocol GLPickVideoCollectionViewDelegate <NSObject>
@end

/*!
 @class GLPickVideoCollectionView
 
 @brief The UICollectionView class
 
 @discussion    视频选择器
 
 @superclass SuperClass: UICollectionView\n
 @classdesign    No special design is applied here.
 @coclass    None
 @helps It helps no other classes.
 @helper    No helper exists for this class.
 */
@interface GLPickVideoCollectionView : UICollectionView
@property (nonatomic, weak) id<GLChatInputAbleViewDelegate> chatDelegate;
@end
