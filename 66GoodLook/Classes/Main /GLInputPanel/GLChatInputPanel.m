//
//  GLChatInputPanel.m
//  66GoodLook
//
//  Created by Yanci on 17/4/20.
//  Copyright © 2017年 Yanci. All rights reserved.
//

#import "GLChatInputPanel.h"
#import "GLChatInputToolBar.h"
#import "GLPickVideoCollectionView.h"
#import "GLPickPictureCollectionView.h"
#import "GLPickEmojView.h"

@interface GLChatInputPanel()
/** 工具栏 */
@property (nonatomic,strong) GLChatInputToolBar *toolbar;
/** 视频选择器,作为Pannel */
@property (nonatomic,strong) GLPickVideoCollectionView *pickVideoCollectionView;
/** 图片选择器,作为Pannel */
@property (nonatomic,strong) GLPickPictureCollectionView *pickPictureCollectionView;
/** 表情选择器,作为Pannel */
@property (nonatomic,strong) GLPickEmojView *pickEmojView;
@end

@implementation GLChatInputPanel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
